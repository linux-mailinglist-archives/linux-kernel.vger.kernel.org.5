Return-Path: <linux-kernel+bounces-17760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF7D5825225
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 11:36:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76FA2B22BD1
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 10:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 881042C865;
	Fri,  5 Jan 2024 10:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b="vsp/ed+p"
X-Original-To: linux-kernel@vger.kernel.org
Received: from bee.tesarici.cz (bee.tesarici.cz [77.93.223.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1F32E405;
	Fri,  5 Jan 2024 10:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tesarici.cz
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id E3E231A6FC6;
	Fri,  5 Jan 2024 11:34:03 +0100 (CET)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=none dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tesarici.cz; s=mail;
	t=1704450844; bh=W5kCnIB42LtsWaPmFAcROMCgMQPTBbi21yBS1qwCu3o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=vsp/ed+p/jez3C+wSexJ/WxUleoMdIAYBCau4oba3WHeINZOmT49XmZg71MHuOnXC
	 /96L+GGHlVPtqeNDBNq11AiSrJXnMGlMOwIHre2Cs9YIOtPxWB0oTn5c3n26wDWLAh
	 XTmGFjkHId1xkRB0mQUS0CFAAvu4i9/ysdrjmKlKx8d2sAbf0Z5mFL53xoDLcGxtmF
	 7kd+II8C/wcovQkpRn9TiYf8wAFcOYR9CKESmQQIY46X1ZIQvMiR++rvuoDxXft82j
	 KWS9v1/4/r+1FbDm0JxeCpDjxpLYMCfCnwZ81Xrq3rPEGV/IhKULwMtAJxA5p3yfvy
	 fRD1Jv9G8xgsA==
Date: Fri, 5 Jan 2024 11:34:02 +0100
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: Eric Dumazet <edumazet@google.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu
 <joabreu@synopsys.com>, "David S. Miller" <davem@davemloft.net>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Maxime
 Coquelin <mcoquelin.stm32@gmail.com>, Chen-Yu Tsai <wens@csie.org>, Jernej
 Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>,
 "open list:STMMAC ETHERNET DRIVER" <netdev@vger.kernel.org>, "moderated
 list:ARM/STM32 ARCHITECTURE" <linux-stm32@st-md-mailman.stormreply.com>,
 "moderated list:ARM/STM32 ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>, open list
 <linux-kernel@vger.kernel.org>, "open list:ARM/Allwinner sunXi SoC support"
 <linux-sunxi@lists.linux.dev>
Subject: Re: [PATCH] net: stmmac: protect statistics updates with a spinlock
Message-ID: <20240105113402.0f5f1232@meshulam.tesarici.cz>
In-Reply-To: <CANn89iLuYZBersxq4aH-9Fg_ojD0fh=0xtdLbRdbMrup=nvrkA@mail.gmail.com>
References: <20240105091556.15516-1-petr@tesarici.cz>
	<CANn89iLuYZBersxq4aH-9Fg_ojD0fh=0xtdLbRdbMrup=nvrkA@mail.gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.39; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 5 Jan 2024 10:58:42 +0100
Eric Dumazet <edumazet@google.com> wrote:

> On Fri, Jan 5, 2024 at 10:16=E2=80=AFAM Petr Tesarik <petr@tesarici.cz> w=
rote:
> >
> > Add a spinlock to fix race conditions while updating Tx/Rx statistics.
> >
> > As explained by a comment in <linux/u64_stats_sync.h>, write side of st=
ruct
> > u64_stats_sync must ensure mutual exclusion, or one seqcount update cou=
ld
> > be lost on 32-bit platforms, thus blocking readers forever.
> >
> > Such lockups have been actually observed on 32-bit Arm after stmmac_xmi=
t()
> > on one core raced with stmmac_napi_poll_tx() on another core.
> >
> > Signed-off-by: Petr Tesarik <petr@tesarici.cz> =20
>=20
> This is going to add more costs to 64bit platforms ?

Yes, it adds a (hopefully not too contended) spinlock and in most
places an interrupt disable/enable pair.

FWIW the race condition is also present on 64-bit platforms, resulting
in inaccurate statistic counters. I can understand if you consider it a
mild annoyance, not worth fixing.

> It seems to me that the same syncp can be used from two different
> threads : hard irq and napi poller...

Yes, that's exactly the scenario that locks up my system.

> At this point, I do not see why you keep linux/u64_stats_sync.h if you
> decide to go for a spinlock...

The spinlock does not havce to be taken on the reader side, so the
seqcounter still adds some value.

> Alternative would use atomic64_t fields for the ones where there is no
> mutual exclusion.
>=20
> RX : napi poll is definitely safe (protected by an atomic bit)
> TX : each TX queue is also safe (protected by an atomic exclusion for
> non LLTX drivers)
>=20
> This leaves the fields updated from hardware interrupt context ?

I'm afraid I don't have enough network-stack-foo to follow here.

My issue on 32 bit is that stmmac_xmit() may be called directly from
process context while another core runs the TX napi on the same channel
(in interrupt context). I didn't observe any race on the RX path, but I
believe it's possible with NAPI busy polling.

In any case, I don't see the connection with LLTX. Maybe you want to
say that the TX queue is safe for stmmac (because it is a non-LLTX
driver), but might not be safe for LLTX drivers?

Petr T

