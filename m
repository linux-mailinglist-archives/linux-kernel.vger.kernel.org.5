Return-Path: <linux-kernel+bounces-17783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1288282529C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 12:15:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7721AB234DF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 11:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78E832C1AE;
	Fri,  5 Jan 2024 11:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b="1VfFDQEa"
X-Original-To: linux-kernel@vger.kernel.org
Received: from bee.tesarici.cz (bee.tesarici.cz [77.93.223.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5210828DDD;
	Fri,  5 Jan 2024 11:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tesarici.cz
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id 2FCD31A832B;
	Fri,  5 Jan 2024 12:14:48 +0100 (CET)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=none dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tesarici.cz; s=mail;
	t=1704453288; bh=VYNlhjSgg7jLCMMITrN8jeGgl0bBjNZ/pe4B+q8QKeE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=1VfFDQEadUP+XmGIWATJBwq5CBSGsDI0Qs175mZmz6QFcSuNnGXs/ezrOjxbV5tFL
	 gVkmv6JF4QNR1xX84ydALHJ8rGjBjKZh+Mhj8KOHkH/dAeEMCD0O8Mzfyu82Z0CDvE
	 y/OOHbSbr7MzKGdjZNe8/7dMrzcA1sPqey7H1LH9MD4LeWlvuk93Fw3VgQu7m07/9d
	 O+y1vjz3dvc98K0GPU7o9Pvv6LUMdAaWZ+ayb5JvScSowrOASEKArfwMBXRLdm9Ynm
	 UVC1SPCpcnWN/hUPQI5PbZdJiegK7gkv+/38qwPiqPxSwG6vqgUSdUsIl7WbqMdbED
	 8S9ghcZ1KmqSg==
Date: Fri, 5 Jan 2024 12:14:47 +0100
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
Message-ID: <20240105121447.11ae80d1@meshulam.tesarici.cz>
In-Reply-To: <CANn89iLEvW9ZS=+WPETPC=mKRyu9AKmueGCWZZOrz9oX3Xef=g@mail.gmail.com>
References: <20240105091556.15516-1-petr@tesarici.cz>
	<CANn89iLuYZBersxq4aH-9Fg_ojD0fh=0xtdLbRdbMrup=nvrkA@mail.gmail.com>
	<20240105113402.0f5f1232@meshulam.tesarici.cz>
	<CANn89iLEvW9ZS=+WPETPC=mKRyu9AKmueGCWZZOrz9oX3Xef=g@mail.gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.39; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 5 Jan 2024 11:48:19 +0100
Eric Dumazet <edumazet@google.com> wrote:

> On Fri, Jan 5, 2024 at 11:34=E2=80=AFAM Petr Tesa=C5=99=C3=ADk <petr@tesa=
rici.cz> wrote:
> >
> > On Fri, 5 Jan 2024 10:58:42 +0100
> > Eric Dumazet <edumazet@google.com> wrote:
> > =20
> > > On Fri, Jan 5, 2024 at 10:16=E2=80=AFAM Petr Tesarik <petr@tesarici.c=
z> wrote: =20
> > > >
> > > > Add a spinlock to fix race conditions while updating Tx/Rx statisti=
cs.
> > > >
> > > > As explained by a comment in <linux/u64_stats_sync.h>, write side o=
f struct
> > > > u64_stats_sync must ensure mutual exclusion, or one seqcount update=
 could
> > > > be lost on 32-bit platforms, thus blocking readers forever.
> > > >
> > > > Such lockups have been actually observed on 32-bit Arm after stmmac=
_xmit()
> > > > on one core raced with stmmac_napi_poll_tx() on another core.
> > > >
> > > > Signed-off-by: Petr Tesarik <petr@tesarici.cz> =20
> > >
> > > This is going to add more costs to 64bit platforms ? =20
> >
> > Yes, it adds a (hopefully not too contended) spinlock and in most
> > places an interrupt disable/enable pair.
> >
> > FWIW the race condition is also present on 64-bit platforms, resulting
> > in inaccurate statistic counters. I can understand if you consider it a
> > mild annoyance, not worth fixing.
> > =20
> > > It seems to me that the same syncp can be used from two different
> > > threads : hard irq and napi poller... =20
> >
> > Yes, that's exactly the scenario that locks up my system.
> > =20
> > > At this point, I do not see why you keep linux/u64_stats_sync.h if you
> > > decide to go for a spinlock... =20
> >
> > The spinlock does not havce to be taken on the reader side, so the
> > seqcounter still adds some value.
> > =20
> > > Alternative would use atomic64_t fields for the ones where there is no
> > > mutual exclusion.
> > >
> > > RX : napi poll is definitely safe (protected by an atomic bit)
> > > TX : each TX queue is also safe (protected by an atomic exclusion for
> > > non LLTX drivers)
> > >
> > > This leaves the fields updated from hardware interrupt context ? =20
> >
> > I'm afraid I don't have enough network-stack-foo to follow here.
> >
> > My issue on 32 bit is that stmmac_xmit() may be called directly from
> > process context while another core runs the TX napi on the same channel
> > (in interrupt context). I didn't observe any race on the RX path, but I
> > believe it's possible with NAPI busy polling.
> >
> > In any case, I don't see the connection with LLTX. Maybe you want to
> > say that the TX queue is safe for stmmac (because it is a non-LLTX
> > driver), but might not be safe for LLTX drivers? =20
>=20
> LLTX drivers (mostly virtual drivers like tunnels...) can have multiple c=
pus
> running ndo_start_xmit() concurrently. So any use of a 'shared syncp'
> would be a bug.
> These drivers usually use per-cpu stats, to avoid races and false
> sharing anyway.
>=20
> I think you should split the structures into two separate groups, each
> guarded with its own syncp.
>=20
> No extra spinlocks, no extra costs on 64bit arches...
>=20
> If TX completion can run in parallel with ndo_start_xmit(), then
> clearly we have to split stmmac_txq_stats in two halves:

Oh, now I get it. Yes, that's much better, indeed.

I mean, the counters have never been consistent (due to the race on the
writer side), and nobody is concerned. So, there is no value in taking
a consistent snapshot in stmmac_get_ethtool_stats().

I'm going to rework and retest my patch. Thank you for pointing me in
the right direction!

Petr T

> Also please note the conversion from u64 to u64_stats_t

Noted. IIUC this will in turn close the update race on 64-bit by using
an atomic type and on 32-bit by using a seqlock. Clever.

Petr T

> Very partial patch, only to show the split and new structure :
>=20
> diff --git a/drivers/net/ethernet/stmicro/stmmac/common.h
> b/drivers/net/ethernet/stmicro/stmmac/common.h
> index e3f650e88f82f927f0dcf95748fbd10c14c30cbe..702bceea5dc8c875a80f5e3a9=
2b7bb058f373eda
> 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/common.h
> +++ b/drivers/net/ethernet/stmicro/stmmac/common.h
> @@ -60,16 +60,22 @@
>  /* #define FRAME_FILTER_DEBUG */
>=20
>  struct stmmac_txq_stats {
> -       u64 tx_bytes;
> -       u64 tx_packets;
> -       u64 tx_pkt_n;
> -       u64 tx_normal_irq_n;
> -       u64 napi_poll;
> -       u64 tx_clean;
> -       u64 tx_set_ic_bit;
> -       u64 tx_tso_frames;
> -       u64 tx_tso_nfrags;
> -       struct u64_stats_sync syncp;
> +/* First part, updated from ndo_start_xmit(), protected by tx queue lock=
 */
> +       struct u64_stats_sync syncp_tx;
> +       u64_stats_t tx_bytes;
> +       u64_stats_t tx_packets;
> +       u64_stats_t tx_pkt_n;
> +       u64_stats_t tx_tso_frames;
> +       u64_stats_t tx_tso_nfrags;
> +
> +/* Second part, updated from TX completion (protected by NAPI poll logic=
) */
> +       struct u64_stats_sync syncp_tx_completion;
> +       u64_stats_t napi_poll;
> +       u64_stats_t tx_clean;
> +       u64_stats_t tx_set_ic_bit;
> +
> +/* Following feld is updated from hard irq context... */
> +       atomic64_t tx_normal_irq_n;
>  } ____cacheline_aligned_in_smp;
>=20
>  struct stmmac_rxq_stats {


