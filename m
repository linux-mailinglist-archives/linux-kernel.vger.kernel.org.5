Return-Path: <linux-kernel+bounces-1378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BE50814E36
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 18:16:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69EA71C23EA9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 17:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4E83697B1;
	Fri, 15 Dec 2023 17:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="U2uSkbD+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xR47XjeC"
X-Original-To: linux-kernel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A155049F7D;
	Fri, 15 Dec 2023 17:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1702660239;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rzieE1bdCDU7ZEE1pZ3W32UoA/gXNQn5x2kQlc+EJVs=;
	b=U2uSkbD+NpMBTLSNNot26VG9U32jW+WuGSigX1H2dsAJHh0RiWL9bkRUxHu+zMwWE96uXB
	GXxqnmpJAn7ZSm6y2Wo8M8d3ookGUh+NWnNtG7PhLOUrF1qovGkgZyFJxniTa08ldaWDT+
	KK7rLMb/yr4rw4uYPRonA6KAlxr3S94Rh67FP+QnqeMZknVqukBtyqDpcKymKTh9tDHmTZ
	02mF3VFOoBiCHEkVULLrMoST1FTPmR4FhSehWPFG1I1TVQHeLMgNGZw7WDi5G+NqKHsv4H
	F2PE22hMCiJo3cRTeBfGjqj0ahQcOyrbdJ8qLvv+VjMNgIjN/48OfF3CDSUm5w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1702660239;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rzieE1bdCDU7ZEE1pZ3W32UoA/gXNQn5x2kQlc+EJVs=;
	b=xR47XjeCsKRff47ftRL3dngUnv52a3CC+b6k684V9u9q0dYWYnMFrl9eQzdyykaw/kwJZc
	Ot6Y1WRGJvAg6pCA==
To: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Boqun Feng <boqun.feng@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eric Dumazet <edumazet@google.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Waiman Long <longman@redhat.com>,
	Will Deacon <will@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Alexei Starovoitov <ast@kernel.org>,
	Arthur Kiyanovski <akiyano@amazon.com>,
	David Arinzon <darinzon@amazon.com>,
	Igor Russkikh <irusskikh@marvell.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Michael Chan <michael.chan@broadcom.com>,
	Noam Dagan <ndagan@amazon.com>,
	Saeed Bishara <saeedb@amazon.com>,
	Shay Agroskin <shayagr@amazon.com>,
	Sunil Goutham <sgoutham@marvell.com>
Subject: [PATCH net-next 17/24] net: amazon, aquanti, broadcom, cavium, engleder: Use nested-BH locking for XDP redirect.
Date: Fri, 15 Dec 2023 18:07:36 +0100
Message-ID: <20231215171020.687342-18-bigeasy@linutronix.de>
In-Reply-To: <20231215171020.687342-1-bigeasy@linutronix.de>
References: <20231215171020.687342-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

The per-CPU variables used during bpf_prog_run_xdp() invocation and
later during xdp_do_redirect() rely on disabled BH for their protection.
Without locking in local_bh_disable() on PREEMPT_RT these data structure
require explicit locking.

This is a follow-up on the previous change which introduced
bpf_run_lock.redirect_lock and uses it now within drivers.

The simple way is to acquire the lock before bpf_prog_run_xdp() is
invoked and hold it until the end of function.
This does not always work because some drivers (cpsw, atlantic) invoke
xdp_do_flush() in the same context.
Acquiring the lock in bpf_prog_run_xdp() and dropping in
xdp_do_redirect() (without touching drivers) does not work because not
all driver, which use bpf_prog_run_xdp(), do support XDP_REDIRECT (and
invoke xdp_do_redirect()).

Ideally the minimal locking scope would be bpf_prog_run_xdp() +
xdp_do_redirect() and everything else (error recovery, DMA unmapping,
free/ alloc of memory, =E2=80=A6) would happen outside of the locked sectio=
n.

Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Arthur Kiyanovski <akiyano@amazon.com>
Cc: David Arinzon <darinzon@amazon.com>
Cc: Igor Russkikh <irusskikh@marvell.com>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: John Fastabend <john.fastabend@gmail.com>
Cc: Michael Chan <michael.chan@broadcom.com>
Cc: Noam Dagan <ndagan@amazon.com>
Cc: Saeed Bishara <saeedb@amazon.com>
Cc: Shay Agroskin <shayagr@amazon.com>
Cc: Sunil Goutham <sgoutham@marvell.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/net/ethernet/amazon/ena/ena_netdev.c  |  1 +
 .../net/ethernet/aquantia/atlantic/aq_ring.c  | 26 ++++++++++++-------
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c |  1 +
 .../net/ethernet/cavium/thunder/nicvf_main.c  |  3 ++-
 drivers/net/ethernet/engleder/tsnep_main.c    | 17 +++++++-----
 5 files changed, 31 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c b/drivers/net/eth=
ernet/amazon/ena/ena_netdev.c
index b5bca48148309..cf075bc5e2b13 100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
@@ -385,6 +385,7 @@ static int ena_xdp_execute(struct ena_ring *rx_ring, st=
ruct xdp_buff *xdp)
 	if (!xdp_prog)
 		goto out;
=20
+	guard(local_lock_nested_bh)(&bpf_run_lock.redirect_lock);
 	verdict =3D bpf_prog_run_xdp(xdp_prog, xdp);
=20
 	switch (verdict) {
diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_ring.c b/drivers/net=
/ethernet/aquantia/atlantic/aq_ring.c
index 694daeaf3e615..5d33d478d5109 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
@@ -458,7 +458,24 @@ static struct sk_buff *aq_xdp_run_prog(struct aq_nic_s=
 *aq_nic,
 	if (xdp_buff_has_frags(xdp) && !prog->aux->xdp_has_frags)
 		goto out_aborted;
=20
+	local_lock_nested_bh(&bpf_run_lock.redirect_lock);
 	act =3D bpf_prog_run_xdp(prog, xdp);
+	if (act =3D=3D XDP_REDIRECT) {
+		if (xdp_do_redirect(aq_nic->ndev, xdp, prog) < 0) {
+			local_unlock_nested_bh(&bpf_run_lock.redirect_lock);
+			goto out_aborted;
+		}
+		local_unlock_nested_bh(&bpf_run_lock.redirect_lock);
+
+		xdp_do_flush();
+		u64_stats_update_begin(&rx_ring->stats.rx.syncp);
+		++rx_ring->stats.rx.xdp_redirect;
+		u64_stats_update_end(&rx_ring->stats.rx.syncp);
+		aq_get_rxpages_xdp(buff, xdp);
+	} else {
+		local_unlock_nested_bh(&bpf_run_lock.redirect_lock);
+	}
+
 	switch (act) {
 	case XDP_PASS:
 		skb =3D aq_xdp_build_skb(xdp, aq_nic->ndev, buff);
@@ -481,15 +498,6 @@ static struct sk_buff *aq_xdp_run_prog(struct aq_nic_s=
 *aq_nic,
 		u64_stats_update_end(&rx_ring->stats.rx.syncp);
 		aq_get_rxpages_xdp(buff, xdp);
 		break;
-	case XDP_REDIRECT:
-		if (xdp_do_redirect(aq_nic->ndev, xdp, prog) < 0)
-			goto out_aborted;
-		xdp_do_flush();
-		u64_stats_update_begin(&rx_ring->stats.rx.syncp);
-		++rx_ring->stats.rx.xdp_redirect;
-		u64_stats_update_end(&rx_ring->stats.rx.syncp);
-		aq_get_rxpages_xdp(buff, xdp);
-		break;
 	default:
 		fallthrough;
 	case XDP_ABORTED:
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c b/drivers/net/et=
hernet/broadcom/bnxt/bnxt_xdp.c
index 96f5ca778c67d..c4d989da7fade 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
@@ -253,6 +253,7 @@ bool bnxt_rx_xdp(struct bnxt *bp, struct bnxt_rx_ring_i=
nfo *rxr, u16 cons,
 	/* BNXT_RX_PAGE_MODE(bp) when XDP enabled */
 	orig_data =3D xdp.data;
=20
+	guard(local_lock_nested_bh)(&bpf_run_lock.redirect_lock);
 	act =3D bpf_prog_run_xdp(xdp_prog, &xdp);
=20
 	tx_avail =3D bnxt_tx_avail(bp, txr);
diff --git a/drivers/net/ethernet/cavium/thunder/nicvf_main.c b/drivers/net=
/ethernet/cavium/thunder/nicvf_main.c
index eff350e0bc2a8..8e1406101f71b 100644
--- a/drivers/net/ethernet/cavium/thunder/nicvf_main.c
+++ b/drivers/net/ethernet/cavium/thunder/nicvf_main.c
@@ -554,7 +554,8 @@ static inline bool nicvf_xdp_rx(struct nicvf *nic, stru=
ct bpf_prog *prog,
 	xdp_prepare_buff(&xdp, hard_start, data - hard_start, len, false);
 	orig_data =3D xdp.data;
=20
-	action =3D bpf_prog_run_xdp(prog, &xdp);
+	scoped_guard(local_lock_nested_bh, &bpf_run_lock.redirect_lock)
+		action =3D bpf_prog_run_xdp(prog, &xdp);
=20
 	len =3D xdp.data_end - xdp.data;
 	/* Check if XDP program has changed headers */
diff --git a/drivers/net/ethernet/engleder/tsnep_main.c b/drivers/net/ether=
net/engleder/tsnep_main.c
index df40c720e7b23..acda3502d274f 100644
--- a/drivers/net/ethernet/engleder/tsnep_main.c
+++ b/drivers/net/ethernet/engleder/tsnep_main.c
@@ -1268,6 +1268,7 @@ static bool tsnep_xdp_run_prog(struct tsnep_rx *rx, s=
truct bpf_prog *prog,
=20
 	length =3D xdp->data_end - xdp->data_hard_start - XDP_PACKET_HEADROOM;
=20
+	guard(local_lock_nested_bh)(&bpf_run_lock.redirect_lock);
 	act =3D bpf_prog_run_xdp(prog, xdp);
 	switch (act) {
 	case XDP_PASS:
@@ -1309,14 +1310,16 @@ static bool tsnep_xdp_run_prog_zc(struct tsnep_rx *=
rx, struct bpf_prog *prog,
 {
 	u32 act;
=20
-	act =3D bpf_prog_run_xdp(prog, xdp);
+	scoped_guard(local_lock_nested_bh, &bpf_run_lock.redirect_lock) {
+		act =3D bpf_prog_run_xdp(prog, xdp);
=20
-	/* XDP_REDIRECT is the main action for zero-copy */
-	if (likely(act =3D=3D XDP_REDIRECT)) {
-		if (xdp_do_redirect(rx->adapter->netdev, xdp, prog) < 0)
-			goto out_failure;
-		*status |=3D TSNEP_XDP_REDIRECT;
-		return true;
+		/* XDP_REDIRECT is the main action for zero-copy */
+		if (likely(act =3D=3D XDP_REDIRECT)) {
+			if (xdp_do_redirect(rx->adapter->netdev, xdp, prog) < 0)
+				goto out_failure;
+			*status |=3D TSNEP_XDP_REDIRECT;
+			return true;
+		}
 	}
=20
 	switch (act) {
--=20
2.43.0


