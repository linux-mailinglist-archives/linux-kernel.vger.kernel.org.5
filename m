Return-Path: <linux-kernel+bounces-13577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 231FD820848
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 20:38:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D954C283898
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 19:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62AFAC143;
	Sat, 30 Dec 2023 19:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="Aahj92t5"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9B0C139
	for <linux-kernel@vger.kernel.org>; Sat, 30 Dec 2023 19:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1703965094; x=1704224294;
	bh=hzDnlR2JtaWtfwJIyhGyRAK5TYxs41N11mbfkjjCeuA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Aahj92t5uGFWTqmOxjniE5OZ3TRJguziyPxCCgQ29EPrxtCqZ3kR9LtjXcV1/LdZq
	 9j8dwpnozl5p+zuocdqzsViooERopNkJy5IEHRpUXIvGkV2uQVFYVoULoJOGoGBpI2
	 BXLOQmcihq1llvS/oZJ07g9Qq5mE/P040mT9XhiI8iJbUc2iexcxjxzySToYm/rW3W
	 fL6kBJIZQfAeTMxTNqYQZ9rXklN8a7aY0bWDyf5VeNpbDqr7VRo0BGRJpdbvKJ5ds5
	 Z+bSqsWNDnAaMOSv7vKYvXRbEPX5NW21pIht+Qe0yue4PeDz9t3NRaVhZwl/GroKXy
	 WHdWzXYC5iuag==
Date: Sat, 30 Dec 2023 19:37:56 +0000
To: =?utf-8?Q?Michael_B=C3=BCsch?= <m@bues.ch>
From: Rahul Rameshbabu <sergeantsagara@protonmail.com>
Cc: Julian Calaby <julian.calaby@gmail.com>, Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org, b43-dev@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH wireless 2/5] wifi: b43: Stop/wake correct queue in DMA Tx path when QoS is disabled
Message-ID: <87bka7wkfm.fsf@protonmail.com>
In-Reply-To: <20231230184113.3ecfed4f@barney>
References: <20231230045105.91351-1-sergeantsagara@protonmail.com> <20231230045105.91351-3-sergeantsagara@protonmail.com> <CAGRGNgWYLTmRfvw94Ok_FfcEVGPa0tRg-ELxkD8K6nxTTNZ9jg@mail.gmail.com> <20231230144036.7f48b739@barney> <878r5bk3x9.fsf@protonmail.com> <20231230184113.3ecfed4f@barney>
Feedback-ID: 26003777:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sat, 30 Dec, 2023 18:41:13 +0100 Michael B=C3=BCsch <m@bues.ch> wrote:
> [[PGP Signed Part:Undecided]]
> On Sat, 30 Dec 2023 17:15:18 +0000
> Rahul Rameshbabu <sergeantsagara@protonmail.com> wrote:
>
>> On Sat, 30 Dec, 2023 14:40:36 +0100 Michael B=C3=BCsch <m@bues.ch> wrote=
:
>> > [[PGP Signed Part:Undecided]]
>> > On Sat, 30 Dec 2023 18:48:45 +1100
>> > Julian Calaby <julian.calaby@gmail.com> wrote: =20
>> >> > --- a/drivers/net/wireless/broadcom/b43/dma.c
>> >> > +++ b/drivers/net/wireless/broadcom/b43/dma.c
>> >> > @@ -1399,7 +1399,10 @@ int b43_dma_tx(struct b43_wldev *dev, struct=
 sk_buff *skb)
>> >> >             should_inject_overflow(ring)) {
>> >> >                 /* This TX ring is full. */
>> >> >                 unsigned int skb_mapping =3D skb_get_queue_mapping(=
skb);
>> >> > -               ieee80211_stop_queue(dev->wl->hw, skb_mapping);
>> >> > +               if (dev->qos_enabled)
>> >> > +                       ieee80211_stop_queue(dev->wl->hw, skb_mappi=
ng);
>> >> > +               else
>> >> > +                       ieee80211_stop_queue(dev->wl->hw, 0);   =20
>> >>=20
>> >> Would this be a little cleaner if we only look up the queue mapping i=
f
>> >> QOS is enabled? I.e. =20
>> >
>> > No. It would break the other uses of skb_mapping.
>> >
>> > But I am wondering why skb_mapping is non-zero in the first place.
>> > I think the actual bug might be somewhere else. =20
>>=20
>> Right, skb_mapping is used to map to the correct software structures DMA
>> mapped to the device. The reason the mapping for the best effort queue
>> (the default/defacto when QoS is disabled) is not zero is due to the way
>> initialization of the queues/rings occurs in the driver. The best effort
>> queue is mapped as the third queue, which leads to this issue when QoS
>> is disabled. Would it make more sense to change the mappings in
>> initialization such that the best effort queue is by default mapped to
>> zero, so we would not need such conditionals?
>
> Maybe it is a good idea to find the patch that broke non-QoS.
> That possibly helps to understand the situation.
>
> Non-QoS used to work just fine.

I did some git analysis, and I actually believe that this issue has been
present since the commit e6f5b934fba8 ("b43: Add QOS support"). Before
then, non-QOS would not trigger this issue. There is a cosmetic change
after this commit, b27faf8ebf25 ("b43: Rename the DMA ring pointers"),
but this change does not introduce the issue (but makes it more
obvious). I think the reason nobody has ever reported this is that even
when the warnings are triggered, everything appears to work fine. I
think therefore the two options are the following.

1. Remap the BE queue to 0 instead of the BK queue.
2. Use this kind of conditional to handle the mapping when QoS is
   disabled.

--
Thanks,

Rahul Rameshbabu


