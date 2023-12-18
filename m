Return-Path: <linux-kernel+bounces-4159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B294581789D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 18:24:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDFC2B23BA1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 17:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDDCA5D730;
	Mon, 18 Dec 2023 17:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="E8Zr2gQH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fcFiiycG"
X-Original-To: linux-kernel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33CC75A860;
	Mon, 18 Dec 2023 17:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 18 Dec 2023 18:23:31 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1702920214;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P1XgGZYPjy8h7WYBBhi2vRaDTtl2GOwX8g4rRNZ63x8=;
	b=E8Zr2gQHS1RTIapRpz9bYE2YgbOVxJsDMiTk+cC8+ZD8ze7eBR7efXe6vNMqWB6LZr2QjR
	eNWaKXEt+h+o/u48gjxbMCLoZPFF+ZcU8dgh4lek+ljyY/tZnGKfZPBoXYdJCBZaCEiISI
	XIR3q1eJFpAdi0EHGkFXs9ZnSunMxNF5m4KPotSLxsbwhyXRrMePD5UyxUxhloy6cToCjv
	24rJkXVwYfybx+WTsstsA/j9x42Y94EOxAcnDVoFcceNQVR1fLK0NkK3oT2tJQ1pfxfym9
	LM4LjwaKaMMrnbN0K7uuUC23xL7yOgYPEKQseoFspzQTCnTdjhRoHMFduzv0iw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1702920214;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P1XgGZYPjy8h7WYBBhi2vRaDTtl2GOwX8g4rRNZ63x8=;
	b=fcFiiycGeLxLFabKrK2qZ5LMXyUpYcjlq8IuIdoaeVfiBxDpG08imbK97Iw0WNey9/NMnb
	9OfewZGtfacEQMDg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Boqun Feng <boqun.feng@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eric Dumazet <edumazet@google.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Paolo Abeni <pabeni@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH net-next 00/24] locking: Introduce nested-BH locking.
Message-ID: <20231218172331.fp-nC_Nr@linutronix.de>
References: <20231215171020.687342-1-bigeasy@linutronix.de>
 <20231215145059.3b42ee35@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20231215145059.3b42ee35@kernel.org>

On 2023-12-15 14:50:59 [-0800], Jakub Kicinski wrote:
> On Fri, 15 Dec 2023 18:07:19 +0100 Sebastian Andrzej Siewior wrote:
> > The proposed way out is to introduce explicit per-CPU locks for
> > resources which are protected by local_bh_disable() and use those only
> > on PREEMPT_RT so there is no additional overhead for !PREEMPT_RT builds.
>=20
> As I said at LPC, complicating drivers with odd locking constructs
> is a no go for me.

I misunderstood it then as I assumed you wanted to ease the work while I
was done which every driver after (hopefully) understanding what is
possible/ needed and what not. We do speak here about 15++?

Now. The pattern is usually
|	act =3D bpf_prog_run_xdp(xdp_prog, &xdp);
|	switch (act) {
|	case XDP_REDIRECT:
|		ret =3D xdp_do_redirect(netdev, &xdp, xdp_prog)))
|		if (ret)
|			goto XDP_ABORTED;
|		xdp_redir++ or so;

so we might be able to turn this into something that covers both and
returns either XDP_REDIRECT or XDP_ABORTED. So this could be merged
into

| u32 bpf_prog_run_xdp_and_redirect(struct net_device *dev, const struct
| 				  bpf_prog *prog, struct xdp_buff *xdp)
| {
| 	u32 act;
| 	int ret;
|=20
| 	act =3D bpf_prog_run_xdp(prog, xdp);
| 	if (act =3D=3D XDP_REDIRECT) {
| 		ret =3D xdp_do_redirect(netdev, xdp, prog);
| 		if (ret < 0)
| 			act =3D XDP_ABORTED;
| 	}
| 	return act;
| }

so the lock can be put inside the function and all drivers use this
function.

=46rom looking through drivers/net/ethernet/, this should work for most
drivers:
- amazon/ena
- aquantia/atlantic
- engleder/tsnep
- freescale/enetc
- freescale/fec
- intel/igb
- intel/igc
- marvell/mvneta
- marvell/mvpp2
- marvell/octeontx2
- mediatek/mtk
- mellanox/mlx5
- microchip/lan966x
- microsoft/mana
- netronome/nfp (two call paths with no support XDP_REDIRECT)
- sfc/rx
- sfc/siena (that offset pointer can be moved)
- socionext/netsec
- stmicro/stmmac

A few do something custom/ additionally between bpf_prog_run_xdp() and
  xdp_do_redirect():

- broadcom/bnxt
  calculates length, offset, data pointer. DMA unmaps + memory
  allocations before redirect.

- freescale/dpaa2
- freescale/dpaa
  sets xdp.data_hard_start + frame_sz, unmaps DMA.

- fungible/funeth
  conditional redirect.

- google/gve
  Allocates a new packet for redirect.

- intel/ixgbe
- intel/i40e
- intel/ice
  Failure in the ZC case is different from XDP_ABORTED, depends on the
  error from xdp_do_redirect())

- mellanox/mlx4/
  calculates page_offset.

- qlogic/qede
  DMA unmap and buffer alloc.

- ti/cpsw_priv
  recalculates length (pointer).

and a few more don't support XDP_REDIRECT:

- cavium/thunder
  does not support XDP_REDIRECT, calculates length, offset.

- intel/ixgbevf
  does not support XDP_REDIRECT

I don't understand why some driver need to recalculate data_hard_start,
length and so on and others don't. This might be only needed for the
XDP_TX case or not needed=E2=80=A6
Also I'm not sure about the dma unmaps and skb allocations. The new skb
allocation can be probably handled before running the bpf prog but then
in the XDP_PASS case it is a waste=E2=80=A6
And the DMA unmaps. Only a few seem to need it. Maybe it can be done
before running the BPF program. After all the bpf may look into the skb.


If that is no go, then the only thing that comes to mind is (as you
mentioned on LPC) to acquire the lock in bpf_prog_run_xdp() and drop it
in xdp_do_redirect(). This would require that every driver invokes
xdp_do_redirect() even not if it is not supporting it (by setting netdev
to NULL or so).

Sebastian

