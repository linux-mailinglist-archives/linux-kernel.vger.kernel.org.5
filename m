Return-Path: <linux-kernel+bounces-4528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 41F04817EE2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 01:41:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CAC29B23C5E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 00:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B48815AC;
	Tue, 19 Dec 2023 00:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H56w/d+p"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D3FD15A0;
	Tue, 19 Dec 2023 00:41:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED812C433C7;
	Tue, 19 Dec 2023 00:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702946504;
	bh=8eMEq2EQPcJdSoDYjoL4uYUzfmA7mbwgk3VmCG7O0T0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=H56w/d+pl+NtQL688KYylFmPYQByNU/Yx9h+6GeWG8o4+3YEtr2/tOqE/K058P3rn
	 I+wk1r6Jg8JKiS5qaBYjYDZCvpY7qhYvRU1sB73fc2d5pAxoLUBlIlhf//Z5kY54P1
	 9TYvT7B1LuFVlfOrbZlsE2mBzukF3AuTMZQEhSFSwIl9kS1VZJ81BPj/263DFl/Rh/
	 gUK4lIWHvM290Uvf5gKedYDZHwzmS9OmHV2c4/jMQP5sybpxaorucJKrvghHCCgCvt
	 OwZS5Jxeg9DNclquCgTnn8FYp4a20boJn2yVGRgoALRMXFa6SdsIzEtLXiN79tduGX
	 F5/7l546/H+Qg==
Date: Mon, 18 Dec 2023 16:41:42 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Michael Chan
 <michael.chan@broadcom.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, "David S. Miller"
 <davem@davemloft.net>, Boqun Feng <boqun.feng@gmail.com>, Daniel Borkmann
 <daniel@iogearbox.net>, Eric Dumazet <edumazet@google.com>, Frederic
 Weisbecker <frederic@kernel.org>, Ingo Molnar <mingo@redhat.com>, Paolo
 Abeni <pabeni@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Thomas
 Gleixner <tglx@linutronix.de>, Waiman Long <longman@redhat.com>, Will
 Deacon <will@kernel.org>
Subject: Re: [PATCH net-next 00/24] locking: Introduce nested-BH locking.
Message-ID: <20231218164142.0b10e29d@kernel.org>
In-Reply-To: <20231218172331.fp-nC_Nr@linutronix.de>
References: <20231215171020.687342-1-bigeasy@linutronix.de>
	<20231215145059.3b42ee35@kernel.org>
	<20231218172331.fp-nC_Nr@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 18 Dec 2023 18:23:31 +0100 Sebastian Andrzej Siewior wrote:
> On 2023-12-15 14:50:59 [-0800], Jakub Kicinski wrote:
> > On Fri, 15 Dec 2023 18:07:19 +0100 Sebastian Andrzej Siewior wrote: =20
> > > The proposed way out is to introduce explicit per-CPU locks for
> > > resources which are protected by local_bh_disable() and use those only
> > > on PREEMPT_RT so there is no additional overhead for !PREEMPT_RT buil=
ds. =20
> >=20
> > As I said at LPC, complicating drivers with odd locking constructs
> > is a no go for me. =20
>=20
> I misunderstood it then as I assumed you wanted to ease the work while I
> was done which every driver after (hopefully) understanding what is
> possible/ needed and what not. We do speak here about 15++?

My main concern is that it takes the complexity of writing network
device drivers to a next level. It's already hard enough to implement
XDP correctly. "local lock" and "guard"? Too complicated :(
Or "unmaintainable" as in "too much maintainer's time will be spent
reviewing code that gets this wrong".

> Now. The pattern is usually
> |	act =3D bpf_prog_run_xdp(xdp_prog, &xdp);
> |	switch (act) {
> |	case XDP_REDIRECT:
> |		ret =3D xdp_do_redirect(netdev, &xdp, xdp_prog)))
> |		if (ret)
> |			goto XDP_ABORTED;
> |		xdp_redir++ or so;
>=20
> so we might be able to turn this into something that covers both and
> returns either XDP_REDIRECT or XDP_ABORTED. So this could be merged
> into
>=20
> | u32 bpf_prog_run_xdp_and_redirect(struct net_device *dev, const struct
> | 				  bpf_prog *prog, struct xdp_buff *xdp)
> | {
> | 	u32 act;
> | 	int ret;
> |=20
> | 	act =3D bpf_prog_run_xdp(prog, xdp);
> | 	if (act =3D=3D XDP_REDIRECT) {
> | 		ret =3D xdp_do_redirect(netdev, xdp, prog);
> | 		if (ret < 0)
> | 			act =3D XDP_ABORTED;
> | 	}
> | 	return act;
> | }

If we could fold the DROP case into this -- even better!

> so the lock can be put inside the function and all drivers use this
> function.
>=20
> From looking through drivers/net/ethernet/, this should work for most
> drivers:
> - amazon/ena
> - aquantia/atlantic
> - engleder/tsnep
> - freescale/enetc
> - freescale/fec
> - intel/igb
> - intel/igc
> - marvell/mvneta
> - marvell/mvpp2
> - marvell/octeontx2
> - mediatek/mtk
> - mellanox/mlx5
> - microchip/lan966x
> - microsoft/mana
> - netronome/nfp (two call paths with no support XDP_REDIRECT)
> - sfc/rx
> - sfc/siena (that offset pointer can be moved)
> - socionext/netsec
> - stmicro/stmmac
>=20
> A few do something custom/ additionally between bpf_prog_run_xdp() and
>   xdp_do_redirect():
>=20
> - broadcom/bnxt
>   calculates length, offset, data pointer. DMA unmaps + memory
>   allocations before redirect.

Just looked at this one. The recalculation is probably for the PASS /
TX cases, REDIRECT / DROP shouldn't care. The DMA unmap looks like=20
a bug (hi, Michael!)

> - freescale/dpaa2
> - freescale/dpaa
>   sets xdp.data_hard_start + frame_sz, unmaps DMA.
>=20
> - fungible/funeth
>   conditional redirect.
>=20
> - google/gve
>   Allocates a new packet for redirect.
>=20
> - intel/ixgbe
> - intel/i40e
> - intel/ice
>   Failure in the ZC case is different from XDP_ABORTED, depends on the
>   error from xdp_do_redirect())
>=20
> - mellanox/mlx4/
>   calculates page_offset.
>=20
> - qlogic/qede
>   DMA unmap and buffer alloc.
>=20
> - ti/cpsw_priv
>   recalculates length (pointer).
>=20
> and a few more don't support XDP_REDIRECT:
>=20
> - cavium/thunder
>   does not support XDP_REDIRECT, calculates length, offset.
>=20
> - intel/ixgbevf
>   does not support XDP_REDIRECT
>=20
> I don't understand why some driver need to recalculate data_hard_start,
> length and so on and others don't. This might be only needed for the
> XDP_TX case or not needed=E2=80=A6
> Also I'm not sure about the dma unmaps and skb allocations. The new skb
> allocation can be probably handled before running the bpf prog but then
> in the XDP_PASS case it is a waste=E2=80=A6
> And the DMA unmaps. Only a few seem to need it. Maybe it can be done
> before running the BPF program. After all the bpf may look into the skb.
>=20
>=20
> If that is no go, then the only thing that comes to mind is (as you
> mentioned on LPC) to acquire the lock in bpf_prog_run_xdp() and drop it
> in xdp_do_redirect(). This would require that every driver invokes
> xdp_do_redirect() even not if it is not supporting it (by setting netdev
> to NULL or so).

To make progress on other parts of the stack we could also take=20
the local lock around all of napi->poll() for now..

