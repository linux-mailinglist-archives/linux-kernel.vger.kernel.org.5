Return-Path: <linux-kernel+bounces-13612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08227820930
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 01:03:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A68EB21A84
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 00:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D77DAE57E;
	Sun, 31 Dec 2023 00:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="PIa1/Fwt"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4AEE546;
	Sun, 31 Dec 2023 00:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1703980964; x=1704240164;
	bh=NzTBAR3J7TqlmV8UyI1UxV71fO1hFB/qVw412kUFJcE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=PIa1/FwtZTQ2ITyhtpzTfs/gpygu8d9/KHHnrAJtDv1Xd5EDlYHD6Y2lK2fBQ9hJ5
	 bYvAyydeznYtidorMjMsDKqDvUJLEsQG7YU3mpBKcgZ856InCtlZbQ46szMFVXkqZ+
	 YkPVnwZuRTRWAWiqUFJIUPbCza8ekXKxENakMYQvAhFXrywiO0+CAOiXYp86Z9pH/t
	 GcDY0PgdweMxYRN8J6TTRSBj9QtmAKvtlSs/0lGoZmawwaLBcA+65b652hn5S/TqeI
	 TH24Ow2ChDV66qWMggBShd0qnJR7A7cUas/eb3bRRWZH433l+cabad9veH4cu75skM
	 DvIjG2PA9s4/Q==
Date: Sun, 31 Dec 2023 00:02:32 +0000
To: Larry Finger <Larry.Finger@lwfinger.net>
From: Rahul Rameshbabu <sergeantsagara@protonmail.com>
Cc: Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org, b43-dev@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH wireless 3/5] wifi: b43: Stop/wake correct queue in PIO Tx path when QoS is disabled
Message-ID: <874jfzutm5.fsf@protonmail.com>
In-Reply-To: <ca357d13-7da9-490f-9e69-4674c6ede057@lwfinger.net>
References: <20231230045105.91351-1-sergeantsagara@protonmail.com> <20231230045105.91351-4-sergeantsagara@protonmail.com> <cb9dcb49-ad94-40df-9f01-a28df3daf6c3@lwfinger.net> <877ckvwk5v.fsf@protonmail.com> <ca357d13-7da9-490f-9e69-4674c6ede057@lwfinger.net>
Feedback-ID: 26003777:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sat, 30 Dec, 2023 16:23:58 -0600 "Larry Finger" <Larry.Finger@lwfinger.n=
et> wrote:
> On 12/30/23 13:43, Rahul Rameshbabu wrote:
>> Unfortunately, new firmware would not prevent the need to fix up the
>> code with regards to QoS being disabled via the kernel parameter or
>> using OpenFW. That said, new firmware could help us drop the fifth patch
>> in this series. I am thinking about using b43-fwcutter to extract
>> proprietary fw from a newer release of broadcom-wl to see if that makes
>> a difference. That said, I am a bit puzzled since the device I am
>> testing on released in early 2011, and I used firmware released in late
>> 2012.
>
> Unfortunately, it is very difficult to get the parameters for fwcutter fr=
om an
> x86 binary. Some of the other architectures are easier.

Just tried this with the x86 binary just because and ran into extraction
issues as expected. I could not find other architecture options from
Broadcom's download page, but I may not have been looking well enough...

  =E2=9D=AF b43-fwcutter ./wlc_hybrid.o_shipped
  Sorry, the input file is either wrong or not supported by b43-fwcutter.
  This file has an unknown MD5sum 6889dbd24abf8006de5cc6eddd138518.

  https://www.broadcom.com/support/download-search?pg=3DWireless+Embedded+S=
olutions+and+RF+Components&pf=3DLegacy+Wireless&pn=3D&pa=3DDriver&po=3D&dk=
=3DBCM4331&pl=3D&l=3Dtrue

I guess, for now, we can keep the exception for bcm4331 and see if
future firmware extractions help.

--
Thanks,

Rahul Rameshbabu


