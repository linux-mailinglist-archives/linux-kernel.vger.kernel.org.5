Return-Path: <linux-kernel+bounces-13518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A177F820793
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 18:15:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E449281D1F
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 17:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53EF3B672;
	Sat, 30 Dec 2023 17:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="MLN/rQ0/"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D988F44;
	Sat, 30 Dec 2023 17:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1703956524; x=1704215724;
	bh=09Hmr6FulL4GOGnkm6RTp3Uh3iuibt0XtEnBi3NKpx0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=MLN/rQ0//gvkGbqBg5K0NlNmP/OmjnP8M0ydYz3Vfm5Q9VhHo65tFsttgxjI373kY
	 DLsdsatl10g40/HIWtIbK949a2mjL+/3aqGkGVSFRTUqq0UNziRjpysRTVwUKopUU8
	 kpi/7S9Ec2n1btgdDV9oJdv6WtP++98Nd4131EuT9x7b7WAInfo+yrBE8gIFI2+hPT
	 S9AY37xg0JgEnPP1B8/a0N77HgXBbKXuRlvmNjlqENoWpUjtuc6XureBi9VcYunmXX
	 mhj+Rjexpufc8LfWWgH2/zUw7dhjOO37XDDmcaCihEddzsXHPcezCrCY1bBJ/z4oii
	 vgaH11JAEEyKw==
Date: Sat, 30 Dec 2023 17:15:18 +0000
To: =?utf-8?Q?Michael_B=C3=BCsch?= <m@bues.ch>
From: Rahul Rameshbabu <sergeantsagara@protonmail.com>
Cc: Julian Calaby <julian.calaby@gmail.com>, Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org, b43-dev@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH wireless 2/5] wifi: b43: Stop/wake correct queue in DMA Tx path when QoS is disabled
Message-ID: <878r5bk3x9.fsf@protonmail.com>
In-Reply-To: <20231230144036.7f48b739@barney>
References: <20231230045105.91351-1-sergeantsagara@protonmail.com> <20231230045105.91351-3-sergeantsagara@protonmail.com> <CAGRGNgWYLTmRfvw94Ok_FfcEVGPa0tRg-ELxkD8K6nxTTNZ9jg@mail.gmail.com> <20231230144036.7f48b739@barney>
Feedback-ID: 26003777:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sat, 30 Dec, 2023 14:40:36 +0100 Michael B=C3=BCsch <m@bues.ch> wrote:
> [[PGP Signed Part:Undecided]]
> On Sat, 30 Dec 2023 18:48:45 +1100
> Julian Calaby <julian.calaby@gmail.com> wrote:
>> > --- a/drivers/net/wireless/broadcom/b43/dma.c
>> > +++ b/drivers/net/wireless/broadcom/b43/dma.c
>> > @@ -1399,7 +1399,10 @@ int b43_dma_tx(struct b43_wldev *dev, struct sk=
_buff *skb)
>> >             should_inject_overflow(ring)) {
>> >                 /* This TX ring is full. */
>> >                 unsigned int skb_mapping =3D skb_get_queue_mapping(skb=
);
>> > -               ieee80211_stop_queue(dev->wl->hw, skb_mapping);
>> > +               if (dev->qos_enabled)
>> > +                       ieee80211_stop_queue(dev->wl->hw, skb_mapping)=
;
>> > +               else
>> > +                       ieee80211_stop_queue(dev->wl->hw, 0); =20
>>=20
>> Would this be a little cleaner if we only look up the queue mapping if
>> QOS is enabled? I.e.
>
> No. It would break the other uses of skb_mapping.
>
> But I am wondering why skb_mapping is non-zero in the first place.
> I think the actual bug might be somewhere else.

Right, skb_mapping is used to map to the correct software structures DMA
mapped to the device. The reason the mapping for the best effort queue
(the default/defacto when QoS is disabled) is not zero is due to the way
initialization of the queues/rings occurs in the driver. The best effort
queue is mapped as the third queue, which leads to this issue when QoS
is disabled. Would it make more sense to change the mappings in
initialization such that the best effort queue is by default mapped to
zero, so we would not need such conditionals?

--
Thanks,

Rahul Rameshbabu


