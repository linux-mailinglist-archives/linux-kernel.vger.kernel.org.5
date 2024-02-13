Return-Path: <linux-kernel+bounces-63307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDDB1852D7A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 11:08:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BA2F28513B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 10:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02524225AF;
	Tue, 13 Feb 2024 10:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hHLxAmSG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4091A22606;
	Tue, 13 Feb 2024 10:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707818896; cv=none; b=krHvL0oYJPmBm6TakV6dDFQBii3CrMqWzfG+C/v8eyzNbWsV+l1gOS04Uw15NczBX7kqzj3RZ289uTBw9HaxGlFhD6Oqtq6O9b6DuxnTnDXqhUMxDiY9tC92CtF/tD0rk678JCWrgb80QfVwv2wzaJpxC3cOt7+dApQoxkCqaHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707818896; c=relaxed/simple;
	bh=3kTC3hEoJgDbJR86DA/K8LcbeDgwurEbXjVDgtNlqcI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lmNLhJ0xoB0j04qYztWQlyuPuk5ttHx49aVmFBu0wTNiX3qFwfPdNLwToAuGAoQ/z+HjFmcCKRHeNluRyaJf5bJDvGl2UejC4CRCxNOGqXUmZo/YoBmQyY5ReYVL7yrhRghSHUodGDRZLBlL1lZPVZOBmjo/LRfs1pQZziuTZEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hHLxAmSG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 347DFC433F1;
	Tue, 13 Feb 2024 10:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707818895;
	bh=3kTC3hEoJgDbJR86DA/K8LcbeDgwurEbXjVDgtNlqcI=;
	h=From:To:Cc:Subject:Date:From;
	b=hHLxAmSG6+Ig+3zRzlwxnnSRf5/OmGhS+v5Cu1oNTfInj+Tv3kRHk+5dLiIQDtyYg
	 h2eDGMXs6JlNfomulCJfjy33NXXDZwyphjcz0mCEnPxTYFT3N+Ua3Gjs03z1FAHjgM
	 rumiwlWK6MH2EvnyHIZyMd68QSK/w1ycpKDz/ylEjNZU51tcAtrFceOkT/0ZaZeT2L
	 1TEJhnTk900XsbMiZQwzw+JNNgXZZi8DzAzXAMYZGsNORHYj49BYelNbB2beUbQTKi
	 62he7VrSjL8fyxHIeqkcEW8k4lbTnHtZPtzUfgOAyRYiS1eM633WK+QYXmf9AXi7Oc
	 ND/OgfokMMZIw==
From: Arnd Bergmann <arnd@kernel.org>
To: Rasesh Mody <rmody@marvell.com>,
	Sudarsana Kalluru <skalluru@marvell.com>,
	GR-Linux-NIC-Dev@marvell.com,
	Jakub Kicinski <kuba@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Wu Yunchuan <yunchuan@nfschina.com>,
	Jing Huang <huangj@Brocade.COM>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH] bnad: fix work_queue type mismatch
Date: Tue, 13 Feb 2024 11:07:50 +0100
Message-Id: <20240213100809.458571-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

clang-16 warns about a function pointer cast:

drivers/net/ethernet/brocade/bna/bnad.c:1995:4: error: cast from 'void (*)(struct delayed_work *)' to 'work_func_t' (aka 'void (*)(struct work_struct *)') converts to incompatible function type [-Werror,-Wcast-function-type-strict]
 1995 |                         (work_func_t)bnad_tx_cleanup);
drivers/net/ethernet/brocade/bna/bnad.c:2252:4: error: cast from 'void (*)(void *)' to 'work_func_t' (aka 'void (*)(struct work_struct *)') converts to incompatible function type [-Werror,-Wcast-function-type-strict]
 2252 |                         (work_func_t)(bnad_rx_cleanup));

The problem here is mixing up work_struct and delayed_work, which relies
the former being the first member of the latter.

Change the code to use consistent types here to address the warning and
make it more robust against workqueue interface changes.

Side note: the use of a delayed workqueue for cleaning up TX descriptors
is probably a bad idea since this introduces a noticeable delay. The
driver currently does not appear to use BQL, but if one wanted to add
that, this would have to be changed as well.

Fixes: 01b54b145185 ("bna: tx rx cleanup fix")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/ethernet/brocade/bna/bnad.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/brocade/bna/bnad.c b/drivers/net/ethernet/brocade/bna/bnad.c
index 31191b520b58..c32174484a96 100644
--- a/drivers/net/ethernet/brocade/bna/bnad.c
+++ b/drivers/net/ethernet/brocade/bna/bnad.c
@@ -1091,10 +1091,10 @@ bnad_cb_tx_resume(struct bnad *bnad, struct bna_tx *tx)
  * Free all TxQs buffers and then notify TX_E_CLEANUP_DONE to Tx fsm.
  */
 static void
-bnad_tx_cleanup(struct delayed_work *work)
+bnad_tx_cleanup(struct work_struct *work)
 {
 	struct bnad_tx_info *tx_info =
-		container_of(work, struct bnad_tx_info, tx_cleanup_work);
+		container_of(work, struct bnad_tx_info, tx_cleanup_work.work);
 	struct bnad *bnad = NULL;
 	struct bna_tcb *tcb;
 	unsigned long flags;
@@ -1170,7 +1170,7 @@ bnad_cb_rx_stall(struct bnad *bnad, struct bna_rx *rx)
  * Free all RxQs buffers and then notify RX_E_CLEANUP_DONE to Rx fsm.
  */
 static void
-bnad_rx_cleanup(void *work)
+bnad_rx_cleanup(struct work_struct *work)
 {
 	struct bnad_rx_info *rx_info =
 		container_of(work, struct bnad_rx_info, rx_cleanup_work);
@@ -1991,8 +1991,7 @@ bnad_setup_tx(struct bnad *bnad, u32 tx_id)
 	}
 	tx_info->tx = tx;
 
-	INIT_DELAYED_WORK(&tx_info->tx_cleanup_work,
-			(work_func_t)bnad_tx_cleanup);
+	INIT_DELAYED_WORK(&tx_info->tx_cleanup_work, bnad_tx_cleanup);
 
 	/* Register ISR for the Tx object */
 	if (intr_info->intr_type == BNA_INTR_T_MSIX) {
@@ -2248,8 +2247,7 @@ bnad_setup_rx(struct bnad *bnad, u32 rx_id)
 	rx_info->rx = rx;
 	spin_unlock_irqrestore(&bnad->bna_lock, flags);
 
-	INIT_WORK(&rx_info->rx_cleanup_work,
-			(work_func_t)(bnad_rx_cleanup));
+	INIT_WORK(&rx_info->rx_cleanup_work, bnad_rx_cleanup);
 
 	/*
 	 * Init NAPI, so that state is set to NAPI_STATE_SCHED,
-- 
2.39.2


