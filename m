Return-Path: <linux-kernel+bounces-13579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5361582084E
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 20:44:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7ED5E1C21E9B
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 19:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22D2FBE76;
	Sat, 30 Dec 2023 19:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="UpIzOKKa"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B6BBE4E
	for <linux-kernel@vger.kernel.org>; Sat, 30 Dec 2023 19:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1703965448; x=1704224648;
	bh=OxoL4VxT9E+VrhbDUVt3Q/iTv0P+LTHXnaE7vR1Zcp8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=UpIzOKKa3eUpZlB7iWpRGGRr8FX5M1RYLpR/IErm8OvBcDO6sXQ3qsS3ULqE2fpVm
	 CH15YZKyfHTWm4/NwimAJs/H+w3FouEzn6SZt8h3ND5xk/8V7ihzYplEm1XACZtLzR
	 b1DXEz3rqBkrzohFLAK+5LPu/478KtSat8Gmk++JL57xNr77Sjglwkmtw5458LJr48
	 rJRJQVfgvkeaMJ5sfgDwka7V69wm6WXuOaiazXdCiDj17KL1rtipJY9DXOSk/VJjsS
	 cx39UIlPrgq2NQYBqm/C2hKzOp5W3/K8bJjL99Rah45OpBDvM2Nsu+LMEvY0WbRrpi
	 ozzMhgb9IbLVA==
Date: Sat, 30 Dec 2023 19:43:45 +0000
To: Larry Finger <Larry.Finger@lwfinger.net>
From: Rahul Rameshbabu <sergeantsagara@protonmail.com>
Cc: Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org, b43-dev@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH wireless 3/5] wifi: b43: Stop/wake correct queue in PIO Tx path when QoS is disabled
Message-ID: <877ckvwk5v.fsf@protonmail.com>
In-Reply-To: <cb9dcb49-ad94-40df-9f01-a28df3daf6c3@lwfinger.net>
References: <20231230045105.91351-1-sergeantsagara@protonmail.com> <20231230045105.91351-4-sergeantsagara@protonmail.com> <cb9dcb49-ad94-40df-9f01-a28df3daf6c3@lwfinger.net>
Feedback-ID: 26003777:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sat, 30 Dec, 2023 12:04:02 -0600 "Larry Finger" <Larry.Finger@lwfinger.n=
et> wrote:
> On 12/29/23 22:51, Rahul Rameshbabu wrote:
>> +=09=09if (dev->qos_enabled)
>> +=09=09=09ieee80211_stop_queue(dev->wl->hw,
>> +=09=09=09=09=09     skb_get_queue_mapping(skb));
>> +=09=09else
>> +=09=09=09ieee80211_stop_queue(dev->wl->hw, 0);
>
> This code sequence occurs in several places. Would it be better to put th=
is in a
> routine specific to b43, thus it would only be used once?

Right, I am waiting to converge on the discussion in the second patch in
this series before making this refactor, but I agree that this pattern
is prevelant and should be refactored if this is the approach taken.

>
> We certainly could try extracting firmware from a newer binary. Any sugge=
stions?

Unfortunately, new firmware would not prevent the need to fix up the
code with regards to QoS being disabled via the kernel parameter or
using OpenFW. That said, new firmware could help us drop the fifth patch
in this series. I am thinking about using b43-fwcutter to extract
proprietary fw from a newer release of broadcom-wl to see if that makes
a difference. That said, I am a bit puzzled since the device I am
testing on released in early 2011, and I used firmware released in late
2012.

--
Thanks,

Rahul Rameshbabu


