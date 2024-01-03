Return-Path: <linux-kernel+bounces-15085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 622B3822718
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 03:39:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED22CB21771
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 02:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9F524A27;
	Wed,  3 Jan 2024 02:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="ExTsSpJk"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-4325.protonmail.ch (mail-4325.protonmail.ch [185.70.43.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E497A4A13
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 02:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=rpwcewjj7zfibednh5axf65hs4.protonmail; t=1704249544; x=1704508744;
	bh=coq+E/koRQ1nyDj6Btxcud2fUdhToaVns+u6j7xhYDo=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=ExTsSpJkVG/FfAqr+JfR7Aea8K6RrhNmZ/g2kFoQcYuBoUap5M8BeiKM20bCJVdxl
	 5+5T8tc9wNuMheekpSVToJvcsizmqPcOVYNXZUjqYSeSr2COuARD9z/3trnEvPUTH+
	 7uOYdd17CnBiS5xRj8wzRD6v45AmVdlX2Da6G2nR37buheIBVIpIw+TUhDHKt8BjT0
	 tvwLDAGIAoQ4+a4zXIz2DpVDEx/rQp4U/DGDmidBgEaRi38sHQiSY4u6mQIQQtO3KX
	 asiLmWM2vD0Ry9x2b8n/QuwcNZwUidY6ATm8xzzMgabizOhPT6BCP2m6oDTNmueYIs
	 rdDrRzp8WIElQ==
Date: Wed, 03 Jan 2024 02:38:50 +0000
To: "peterz@infradead.org" <peterz@infradead.org>
From: rohan470 <rohan470@proton.me>
Cc: "mingo@kernel.org" <mingo@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: EEVDF virtual time calculation rationale
Message-ID: <ZkUEh0F9jAcEI7v9ufD9OqnxsuVxvOca7fX8R9jJlre5kFXoynNMANNbZFPZs02-jb2MdiCQAGk_l2Xdl4cmnxekDyRG45rcJ1-yU0Kz9oo=@proton.me>
Feedback-ID: 96939901:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hello,

I have a question regarding the calculation of virtual time in the new EEVD=
F system.=20
I'm quite new to Linux kernel development, so forgive me if my question sou=
nds naive or if my assumptions regarding the kernel's scheduling mechanisms=
 are incorrect.

I read Stoica et al's EEVDF papers (both the 37 page technical report [1], =
and the 1996 RTSS conference edition [2]). I then spent the past few weeks =
studying the new EEVDF code.
I noticed a difference in how virtual time is calculated in the paper versu=
s how the kernel does it.

The paper defines virtual time as:
V(t)=3D\int_{0}^{t}\frac{1}{\sum_{j\in A(\tau)}w_j}d\tau

However, if I understand correctly, the kernel does not calculate virtual t=
ime with this formula.=20
Instead, it takes the \Sum lag_i =3D 0 invariant of EEVDF and the definitio=
n of lag (lag_i =3D S - s_i =3D w_i * (V - v_i)), and rearranges the formul=
a to solve for virtual time, V.=20
This means virtual time is effectively calculated as a weighted average of =
the tasks' virtual runtimes.

Why does the kernel calculate virtual time this way? Does it produce the ex=
act same value as the integral solution?
Was this inherited from the CFS system?

One issue I thought of with the integral solution is that the definition of=
 time 0 is somewhat ambiguous. Is it when the system boots, or when the run=
queue is initialized, or something else?
Could it be set to any arbitrary time constant, as long as it's before the =
first time we try to calculate virtual time?=20
Unfortunately, the paper doesn't answer these questions, since it omits the=
 implementation of the get_current_vt function.

Could an integral version be implemented like this?: we store the virtual t=
ime in a variable, virtual_time. When the scheduler runs periodically from =
an interrupt, we update virtual time with: virtual_time +=3D (1/sum_of_weig=
hts)*(t-t'), where t is the current time and t' is the last time we updated=
 the virtual_time variable. When a task leaves/joins the system, we update =
virtual time with: virtual_time =3D virtual_time +/- (lag_i(t)/(sum_of_weig=
hts)), where sum_of_weights is the new sum after the leave/join.

For the periodic update (not the leave/join) of virtual_time, we effectivel=
y break the integral into two parts: one for the 0 to t' interval, and anot=
her for the t' to t interval. Since the integral for 0 to t' is already cal=
culated, we don't have to worry about the variations in sum_of_weights duri=
ng that interval. Since we update virtual_time and sum_of_weights whenever =
a task leaves/joins the system, then t' is the last time the weights could =
have changed before t. Therefore, we know sum_of_weights stays constant bet=
ween t' and t.

I'm curious to learn more about why the weighted average method is used, an=
d whether or not the integral solution is possible to use in the kernel.

Thanks,
-Rohan

[1] https://citeseerx.ist.psu.edu/document?repid=3Drep1&type=3Dpdf&doi=3D80=
5acf7726282721504c8f00575d91ebfd750564
[2] https://ieeexplore.ieee.org/abstract/document/563725?casa_token=3DeZ1XT=
M6ux9QAAAAA:10ncyLGX4mjYATqMTdwBRgQTkIjE4MHtYvYKLXVuaubP_cdWr8YeX-TALqd-94O=
xhDp248wAWFqe

