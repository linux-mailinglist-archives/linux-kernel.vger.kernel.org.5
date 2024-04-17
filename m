Return-Path: <linux-kernel+bounces-149231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AFDF8A8D66
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 22:58:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C74071F2162F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 20:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D469F48CCD;
	Wed, 17 Apr 2024 20:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oPv/QCAt"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC72481A6
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 20:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713387490; cv=none; b=suCZAyXadkanIuyw4hKkkuVXJ9/VM9wl2uq/EDjCvVAYKSCFnFoMa4PPurqteHde5g7eHCJTf5UBcibQ1Y26ahAVytNQHLqVeBMZc7BxQM/lTUQ5w9Y1lKnx5GgtYaj0JZeoruftMsQ4e7NiswTOB9AVSJfXw4F+zIEvYb9GtSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713387490; c=relaxed/simple;
	bh=xIgWSxLBbguyRcb0zKhiKbT1dbRUzTnSdHRJoAVzhVs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=JZ4N9kBva1ejDTKqp8PYpP/g3xp6RVD1lWRduK2B+YqgffeCrNgKzEVjwou4mv5hRK/6D4KJSQsncedY1l1n2x56USHObD5g53boR26OigYAtKSNtXcTxGJDyjOxssPDVntboNdeHshVqDQAYaRkIs7qtvTDXiF1y09NvF03nx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ziweixiao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oPv/QCAt; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ziweixiao.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-5dcab65d604so84244a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 13:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713387488; x=1713992288; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gEAhZlLshKO/PptO5/jBMX3CmASJWwGmWZLqDVkQJdg=;
        b=oPv/QCAt7jeDx1/ioFRHHO54nDTGyof164WTemqVO0gCBwxFgr1Erv13IS2kyO1WpH
         bcHWfG+lZoxeKSdcA123EizSHzyZMqe6DxsbLn5IqQgB3PEFRBYKfVFtO7YUYUmhrSa2
         0UEi8mN26QMwNbZxQAo161C2nrUpAid2NOrQ7XuemDae+ul87ML9XVYHAT6TtnFk04nx
         OfxneeT7mGistIyJEB4hYivgRp6v5UL3WdSi1jGDZGg0K6jcScJbs3I29oSpJFxWtyT8
         dwrIzf1Z/hD/F1mCy00BOLsk37MaC/6wVfm9AjXxaO4fwJc5HsCgs1lnz3tEVR0KuAYN
         VA9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713387488; x=1713992288;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gEAhZlLshKO/PptO5/jBMX3CmASJWwGmWZLqDVkQJdg=;
        b=TL6C3z4ocSv3d5nwzXQo7lki0IHuopWKQ3F/A/mmxsGnqVAx8U+o5IbSvMB4zU8RkQ
         R78GvN6xoziwQWWsatpEW/FPU7m7DCMQqwPkFRkFd00yOTj1vtiWKxs9+1gyxcKZNRZk
         Cs6p1eZUel6Fkf4XjPwLh9DRD4lLdrPVh1R4RReTpAoOzaJSzo+lnqE0qQfL+mH/ReRm
         9Npo3/X4yEvnz+CeTnm3C6nxWq6UL/JZLNthZJtYrzaN75ljf2t6VAzdkvLZZ/RVvSVF
         iEWVZ22tGb2MBTzsA+rSd79Ik83UaODSkT+yttJmIeQ33rXUJ93vIDt+m6XnJ+RCWZRK
         H6sw==
X-Forwarded-Encrypted: i=1; AJvYcCXixLqAQQNGHDTAn/ttmZ4u82SOn8fb6h+5q3Z7F+XG75bRI2CKyZrJJvsr+DJCjLydtQeYveaW5StitUApwJEPd3uMd+VCn9KXD+6p
X-Gm-Message-State: AOJu0YzEsM0S+I1VVA8rfKiLoJtFlEXFKGAFo1gmtLo8pc/aEuS6/iiP
	Pae4AWf/tTbv1xZxkaSkaQgkMhTkwtOx/4BGC6y8yH9u8cgnm9bCWDgyVnyBnvqRTan/E+dlLne
	CGE7UVeuGdV3qWg==
X-Google-Smtp-Source: AGHT+IEgXH3RvQT2/Y9Asb+xVSS6BM3mP3BTVVzG4B+WcQtNy06SR1k9LfX02V/9rhbYZjdmkEXlX+wNmitsBw8=
X-Received: from ziwei-gti.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:9b0])
 (user=ziweixiao job=sendgmr) by 2002:a63:2d7:0:b0:5f0:6959:8a46 with SMTP id
 206-20020a6302d7000000b005f069598a46mr1723pgc.9.1713387487983; Wed, 17 Apr
 2024 13:58:07 -0700 (PDT)
Date: Wed, 17 Apr 2024 20:57:57 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240417205757.778551-1-ziweixiao@google.com>
Subject: [PATCH net-next] gve: Remove qpl_cfg struct since qpl_ids map with
 queues respectively
From: Ziwei Xiao <ziweixiao@google.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, jeroendb@google.com, pkaligineedi@google.com, 
	shailend@google.com, willemb@google.com, hramamurthy@google.com, 
	rushilg@google.com, jfraker@google.com, junfeng.guo@intel.com, 
	Julia.Lawall@inria.fr, horms@kernel.org, linux-kernel@vger.kernel.org, 
	Ziwei Xiao <ziweixiao@google.com>
Content-Type: text/plain; charset="UTF-8"

The qpl_cfg struct was used to make sure that no two different queues
are using QPL with the same qpl_id. We can remove that qpl_cfg struct
since now the qpl_ids map with the queues respectively as follows:
For tx queues: qpl_id = tx_qid
For rx queues: qpl_id = max_tx_queues + rx_qid

And when XDP is used, it will need the user to reduce the tx queues to
be at most half of the max_tx_queues. Then it will use the same number
of tx queues starting from the end of existing tx queues for XDP. So the
XDP queues will not exceed the max_tx_queues range and will not overlap
with the rx queues, where the qpl_ids will not have overlapping too.

Considering of that, we remove the qpl_cfg struct to get the qpl_id
directly based on the queue id. Unless we are erroneously allocating a
rx/tx queue that has already been allocated, we would never allocate
the qpl with the same qpl_id twice. In that case, it should fail much
earlier than the QPL assignment.

Suggested-by: Praveen Kaligineedi <pkaligineedi@google.com>
Signed-off-by: Ziwei Xiao <ziweixiao@google.com>
Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
Reviewed-by: Shailend Chand <shailend@google.com>
---
 drivers/net/ethernet/google/gve/gve.h         | 39 +------------------
 drivers/net/ethernet/google/gve/gve_ethtool.c |  9 -----
 drivers/net/ethernet/google/gve/gve_main.c    | 38 +-----------------
 drivers/net/ethernet/google/gve/gve_rx.c      | 12 ++----
 drivers/net/ethernet/google/gve/gve_rx_dqo.c  | 12 +++---
 drivers/net/ethernet/google/gve/gve_tx.c      | 12 ++----
 drivers/net/ethernet/google/gve/gve_tx_dqo.c  | 11 ++----
 7 files changed, 20 insertions(+), 113 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
index e97633b68e25..53b5244dc7bc 100644
--- a/drivers/net/ethernet/google/gve/gve.h
+++ b/drivers/net/ethernet/google/gve/gve.h
@@ -639,7 +639,6 @@ struct gve_ptype_lut {
 
 /* Parameters for allocating queue page lists */
 struct gve_qpls_alloc_cfg {
-	struct gve_qpl_config *qpl_cfg;
 	struct gve_queue_config *tx_cfg;
 	struct gve_queue_config *rx_cfg;
 
@@ -655,9 +654,8 @@ struct gve_qpls_alloc_cfg {
 struct gve_tx_alloc_rings_cfg {
 	struct gve_queue_config *qcfg;
 
-	/* qpls and qpl_cfg must already be allocated */
+	/* qpls must already be allocated */
 	struct gve_queue_page_list *qpls;
-	struct gve_qpl_config *qpl_cfg;
 
 	u16 ring_size;
 	u16 start_idx;
@@ -674,9 +672,8 @@ struct gve_rx_alloc_rings_cfg {
 	struct gve_queue_config *qcfg;
 	struct gve_queue_config *qcfg_tx;
 
-	/* qpls and qpl_cfg must already be allocated */
+	/* qpls must already be allocated */
 	struct gve_queue_page_list *qpls;
-	struct gve_qpl_config *qpl_cfg;
 
 	u16 ring_size;
 	u16 packet_buffer_size;
@@ -732,7 +729,6 @@ struct gve_priv {
 	u16 num_xdp_queues;
 	struct gve_queue_config tx_cfg;
 	struct gve_queue_config rx_cfg;
-	struct gve_qpl_config qpl_cfg; /* map used QPL ids */
 	u32 num_ntfy_blks; /* spilt between TX and RX so must be even */
 
 	struct gve_registers __iomem *reg_bar0; /* see gve_register.h */
@@ -1053,37 +1049,6 @@ static inline u32 gve_get_rx_pages_per_qpl_dqo(u32 rx_desc_cnt)
 	return 2 * rx_desc_cnt;
 }
 
-/* Returns a pointer to the next available tx qpl in the list of qpls */
-static inline
-struct gve_queue_page_list *gve_assign_tx_qpl(struct gve_tx_alloc_rings_cfg *cfg,
-					      int tx_qid)
-{
-	/* QPL already in use */
-	if (test_bit(tx_qid, cfg->qpl_cfg->qpl_id_map))
-		return NULL;
-	set_bit(tx_qid, cfg->qpl_cfg->qpl_id_map);
-	return &cfg->qpls[tx_qid];
-}
-
-/* Returns a pointer to the next available rx qpl in the list of qpls */
-static inline
-struct gve_queue_page_list *gve_assign_rx_qpl(struct gve_rx_alloc_rings_cfg *cfg,
-					      int rx_qid)
-{
-	int id = gve_get_rx_qpl_id(cfg->qcfg_tx, rx_qid);
-	/* QPL already in use */
-	if (test_bit(id, cfg->qpl_cfg->qpl_id_map))
-		return NULL;
-	set_bit(id, cfg->qpl_cfg->qpl_id_map);
-	return &cfg->qpls[id];
-}
-
-/* Unassigns the qpl with the given id */
-static inline void gve_unassign_qpl(struct gve_qpl_config *qpl_cfg, int id)
-{
-	clear_bit(id, qpl_cfg->qpl_id_map);
-}
-
 /* Returns the correct dma direction for tx and rx qpls */
 static inline enum dma_data_direction gve_qpl_dma_dir(struct gve_priv *priv,
 						      int id)
diff --git a/drivers/net/ethernet/google/gve/gve_ethtool.c b/drivers/net/ethernet/google/gve/gve_ethtool.c
index 299206d15c73..bd7632eed776 100644
--- a/drivers/net/ethernet/google/gve/gve_ethtool.c
+++ b/drivers/net/ethernet/google/gve/gve_ethtool.c
@@ -510,7 +510,6 @@ static int gve_adjust_ring_sizes(struct gve_priv *priv,
 	struct gve_tx_alloc_rings_cfg tx_alloc_cfg = {0};
 	struct gve_rx_alloc_rings_cfg rx_alloc_cfg = {0};
 	struct gve_qpls_alloc_cfg qpls_alloc_cfg = {0};
-	struct gve_qpl_config new_qpl_cfg;
 	int err;
 
 	/* get current queue configuration */
@@ -521,14 +520,6 @@ static int gve_adjust_ring_sizes(struct gve_priv *priv,
 	tx_alloc_cfg.ring_size = new_tx_desc_cnt;
 	rx_alloc_cfg.ring_size = new_rx_desc_cnt;
 
-	/* qpl_cfg is not read-only, it contains a map that gets updated as
-	 * rings are allocated, which is why we cannot use the yet unreleased
-	 * one in priv.
-	 */
-	qpls_alloc_cfg.qpl_cfg = &new_qpl_cfg;
-	tx_alloc_cfg.qpl_cfg = &new_qpl_cfg;
-	rx_alloc_cfg.qpl_cfg = &new_qpl_cfg;
-
 	if (netif_running(priv->dev)) {
 		err = gve_adjust_config(priv, &qpls_alloc_cfg,
 					&tx_alloc_cfg, &rx_alloc_cfg);
diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index a515e5af843c..61039e3dd2bb 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -829,7 +829,6 @@ static void gve_tx_get_curr_alloc_cfg(struct gve_priv *priv,
 	cfg->qcfg = &priv->tx_cfg;
 	cfg->raw_addressing = !gve_is_qpl(priv);
 	cfg->qpls = priv->qpls;
-	cfg->qpl_cfg = &priv->qpl_cfg;
 	cfg->ring_size = priv->tx_desc_cnt;
 	cfg->start_idx = 0;
 	cfg->num_rings = gve_num_tx_queues(priv);
@@ -1119,22 +1118,13 @@ static int gve_alloc_qpls(struct gve_priv *priv, struct gve_qpls_alloc_cfg *cfg,
 	if (!qpls)
 		return -ENOMEM;
 
-	cfg->qpl_cfg->qpl_map_size = BITS_TO_LONGS(max_queues) *
-		sizeof(unsigned long) * BITS_PER_BYTE;
-	cfg->qpl_cfg->qpl_id_map = kvcalloc(BITS_TO_LONGS(max_queues),
-					    sizeof(unsigned long), GFP_KERNEL);
-	if (!cfg->qpl_cfg->qpl_id_map) {
-		err = -ENOMEM;
-		goto free_qpl_array;
-	}
-
 	/* Allocate TX QPLs */
 	page_count = priv->tx_pages_per_qpl;
 	tx_num_qpls = gve_num_tx_qpls(cfg->tx_cfg, cfg->num_xdp_queues,
 				      gve_is_qpl(priv));
 	err = gve_alloc_n_qpls(priv, qpls, page_count, 0, tx_num_qpls);
 	if (err)
-		goto free_qpl_map;
+		goto free_qpl_array;
 
 	/* Allocate RX QPLs */
 	rx_start_id = gve_rx_start_qpl_id(cfg->tx_cfg);
@@ -1157,9 +1147,6 @@ static int gve_alloc_qpls(struct gve_priv *priv, struct gve_qpls_alloc_cfg *cfg,
 
 free_tx_qpls:
 	gve_free_n_qpls(priv, qpls, 0, tx_num_qpls);
-free_qpl_map:
-	kvfree(cfg->qpl_cfg->qpl_id_map);
-	cfg->qpl_cfg->qpl_id_map = NULL;
 free_qpl_array:
 	kvfree(qpls);
 	return err;
@@ -1175,9 +1162,6 @@ static void gve_free_qpls(struct gve_priv *priv,
 	if (!qpls)
 		return;
 
-	kvfree(cfg->qpl_cfg->qpl_id_map);
-	cfg->qpl_cfg->qpl_id_map = NULL;
-
 	for (i = 0; i < max_queues; i++)
 		gve_free_queue_page_list(priv, &qpls[i], i);
 
@@ -1292,7 +1276,6 @@ static void gve_qpls_get_curr_alloc_cfg(struct gve_priv *priv,
 	  cfg->raw_addressing = !gve_is_qpl(priv);
 	  cfg->is_gqi = gve_is_gqi(priv);
 	  cfg->num_xdp_queues = priv->num_xdp_queues;
-	  cfg->qpl_cfg = &priv->qpl_cfg;
 	  cfg->tx_cfg = &priv->tx_cfg;
 	  cfg->rx_cfg = &priv->rx_cfg;
 	  cfg->qpls = priv->qpls;
@@ -1306,7 +1289,6 @@ static void gve_rx_get_curr_alloc_cfg(struct gve_priv *priv,
 	cfg->raw_addressing = !gve_is_qpl(priv);
 	cfg->enable_header_split = priv->header_split_enabled;
 	cfg->qpls = priv->qpls;
-	cfg->qpl_cfg = &priv->qpl_cfg;
 	cfg->ring_size = priv->rx_desc_cnt;
 	cfg->packet_buffer_size = gve_is_gqi(priv) ?
 				  GVE_DEFAULT_RX_BUFFER_SIZE :
@@ -1419,7 +1401,6 @@ static int gve_queues_start(struct gve_priv *priv,
 	priv->rx = rx_alloc_cfg->rx;
 
 	/* Record new configs into priv */
-	priv->qpl_cfg = *qpls_alloc_cfg->qpl_cfg;
 	priv->tx_cfg = *tx_alloc_cfg->qcfg;
 	priv->rx_cfg = *rx_alloc_cfg->qcfg;
 	priv->tx_desc_cnt = tx_alloc_cfg->ring_size;
@@ -1916,20 +1897,11 @@ int gve_adjust_queues(struct gve_priv *priv,
 	struct gve_tx_alloc_rings_cfg tx_alloc_cfg = {0};
 	struct gve_rx_alloc_rings_cfg rx_alloc_cfg = {0};
 	struct gve_qpls_alloc_cfg qpls_alloc_cfg = {0};
-	struct gve_qpl_config new_qpl_cfg;
 	int err;
 
 	gve_get_curr_alloc_cfgs(priv, &qpls_alloc_cfg,
 				&tx_alloc_cfg, &rx_alloc_cfg);
 
-	/* qpl_cfg is not read-only, it contains a map that gets updated as
-	 * rings are allocated, which is why we cannot use the yet unreleased
-	 * one in priv.
-	 */
-	qpls_alloc_cfg.qpl_cfg = &new_qpl_cfg;
-	tx_alloc_cfg.qpl_cfg = &new_qpl_cfg;
-	rx_alloc_cfg.qpl_cfg = &new_qpl_cfg;
-
 	/* Relay the new config from ethtool */
 	qpls_alloc_cfg.tx_cfg = &new_tx_config;
 	tx_alloc_cfg.qcfg = &new_tx_config;
@@ -2121,18 +2093,10 @@ static int gve_set_features(struct net_device *netdev,
 	struct gve_rx_alloc_rings_cfg rx_alloc_cfg = {0};
 	struct gve_qpls_alloc_cfg qpls_alloc_cfg = {0};
 	struct gve_priv *priv = netdev_priv(netdev);
-	struct gve_qpl_config new_qpl_cfg;
 	int err;
 
 	gve_get_curr_alloc_cfgs(priv, &qpls_alloc_cfg,
 				&tx_alloc_cfg, &rx_alloc_cfg);
-	/* qpl_cfg is not read-only, it contains a map that gets updated as
-	 * rings are allocated, which is why we cannot use the yet unreleased
-	 * one in priv.
-	 */
-	qpls_alloc_cfg.qpl_cfg = &new_qpl_cfg;
-	tx_alloc_cfg.qpl_cfg = &new_qpl_cfg;
-	rx_alloc_cfg.qpl_cfg = &new_qpl_cfg;
 
 	if ((netdev->features & NETIF_F_LRO) != (features & NETIF_F_LRO)) {
 		netdev->features ^= NETIF_F_LRO;
diff --git a/drivers/net/ethernet/google/gve/gve_rx.c b/drivers/net/ethernet/google/gve/gve_rx.c
index cd727e55ae0f..9b56e89c4f43 100644
--- a/drivers/net/ethernet/google/gve/gve_rx.c
+++ b/drivers/net/ethernet/google/gve/gve_rx.c
@@ -38,7 +38,6 @@ static void gve_rx_unfill_pages(struct gve_priv *priv,
 		for (i = 0; i < slots; i++)
 			page_ref_sub(rx->data.page_info[i].page,
 				     rx->data.page_info[i].pagecnt_bias - 1);
-		gve_unassign_qpl(cfg->qpl_cfg, rx->data.qpl->id);
 		rx->data.qpl = NULL;
 
 		for (i = 0; i < rx->qpl_copy_pool_mask + 1; i++) {
@@ -145,13 +144,11 @@ static int gve_rx_prefill_pages(struct gve_rx_ring *rx,
 		return -ENOMEM;
 
 	if (!rx->data.raw_addressing) {
-		rx->data.qpl = gve_assign_rx_qpl(cfg, rx->q_num);
-		if (!rx->data.qpl) {
-			kvfree(rx->data.page_info);
-			rx->data.page_info = NULL;
-			return -ENOMEM;
-		}
+		u32 qpl_id = gve_get_rx_qpl_id(cfg->qcfg_tx, rx->q_num);
+
+		rx->data.qpl = &cfg->qpls[qpl_id];
 	}
+
 	for (i = 0; i < slots; i++) {
 		if (!rx->data.raw_addressing) {
 			struct page *page = rx->data.qpl->pages[i];
@@ -204,7 +201,6 @@ static int gve_rx_prefill_pages(struct gve_rx_ring *rx,
 		page_ref_sub(rx->data.page_info[i].page,
 			     rx->data.page_info[i].pagecnt_bias - 1);
 
-	gve_unassign_qpl(cfg->qpl_cfg, rx->data.qpl->id);
 	rx->data.qpl = NULL;
 
 	return err;
diff --git a/drivers/net/ethernet/google/gve/gve_rx_dqo.c b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
index 15108407b54f..53fd2d87233f 100644
--- a/drivers/net/ethernet/google/gve/gve_rx_dqo.c
+++ b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
@@ -247,10 +247,8 @@ static void gve_rx_free_ring_dqo(struct gve_priv *priv, struct gve_rx_ring *rx,
 		if (bs->page_info.page)
 			gve_free_page_dqo(priv, bs, !rx->dqo.qpl);
 	}
-	if (rx->dqo.qpl) {
-		gve_unassign_qpl(cfg->qpl_cfg, rx->dqo.qpl->id);
-		rx->dqo.qpl = NULL;
-	}
+
+	rx->dqo.qpl = NULL;
 
 	if (rx->dqo.bufq.desc_ring) {
 		size = sizeof(rx->dqo.bufq.desc_ring[0]) * buffer_queue_slots;
@@ -359,9 +357,9 @@ static int gve_rx_alloc_ring_dqo(struct gve_priv *priv,
 		goto err;
 
 	if (!cfg->raw_addressing) {
-		rx->dqo.qpl = gve_assign_rx_qpl(cfg, rx->q_num);
-		if (!rx->dqo.qpl)
-			goto err;
+		u32 qpl_id = gve_get_rx_qpl_id(cfg->qcfg_tx, rx->q_num);
+
+		rx->dqo.qpl = &cfg->qpls[qpl_id];
 		rx->dqo.next_qpl_page_idx = 0;
 	}
 
diff --git a/drivers/net/ethernet/google/gve/gve_tx.c b/drivers/net/ethernet/google/gve/gve_tx.c
index 4b9853adc113..f805700d67e7 100644
--- a/drivers/net/ethernet/google/gve/gve_tx.c
+++ b/drivers/net/ethernet/google/gve/gve_tx.c
@@ -225,7 +225,6 @@ static void gve_tx_free_ring_gqi(struct gve_priv *priv, struct gve_tx_ring *tx,
 
 	if (!tx->raw_addressing) {
 		gve_tx_fifo_release(priv, &tx->tx_fifo);
-		gve_unassign_qpl(cfg->qpl_cfg, tx->tx_fifo.qpl->id);
 		tx->tx_fifo.qpl = NULL;
 	}
 
@@ -280,12 +279,12 @@ static int gve_tx_alloc_ring_gqi(struct gve_priv *priv,
 	tx->raw_addressing = cfg->raw_addressing;
 	tx->dev = hdev;
 	if (!tx->raw_addressing) {
-		tx->tx_fifo.qpl = gve_assign_tx_qpl(cfg, idx);
-		if (!tx->tx_fifo.qpl)
-			goto abort_with_desc;
+		u32 qpl_id = gve_tx_qpl_id(priv, tx->q_num);
+
+		tx->tx_fifo.qpl = &cfg->qpls[qpl_id];
 		/* map Tx FIFO */
 		if (gve_tx_fifo_init(priv, &tx->tx_fifo))
-			goto abort_with_qpl;
+			goto abort_with_desc;
 	}
 
 	tx->q_resources =
@@ -301,9 +300,6 @@ static int gve_tx_alloc_ring_gqi(struct gve_priv *priv,
 abort_with_fifo:
 	if (!tx->raw_addressing)
 		gve_tx_fifo_release(priv, &tx->tx_fifo);
-abort_with_qpl:
-	if (!tx->raw_addressing)
-		gve_unassign_qpl(cfg->qpl_cfg, tx->tx_fifo.qpl->id);
 abort_with_desc:
 	dma_free_coherent(hdev, bytes, tx->desc, tx->bus);
 	tx->desc = NULL;
diff --git a/drivers/net/ethernet/google/gve/gve_tx_dqo.c b/drivers/net/ethernet/google/gve/gve_tx_dqo.c
index 70f29b90a982..3d825e406c4b 100644
--- a/drivers/net/ethernet/google/gve/gve_tx_dqo.c
+++ b/drivers/net/ethernet/google/gve/gve_tx_dqo.c
@@ -236,10 +236,7 @@ static void gve_tx_free_ring_dqo(struct gve_priv *priv, struct gve_tx_ring *tx,
 	kvfree(tx->dqo.tx_qpl_buf_next);
 	tx->dqo.tx_qpl_buf_next = NULL;
 
-	if (tx->dqo.qpl) {
-		gve_unassign_qpl(cfg->qpl_cfg, tx->dqo.qpl->id);
-		tx->dqo.qpl = NULL;
-	}
+	tx->dqo.qpl = NULL;
 
 	netif_dbg(priv, drv, priv->dev, "freed tx queue %d\n", idx);
 }
@@ -352,9 +349,9 @@ static int gve_tx_alloc_ring_dqo(struct gve_priv *priv,
 		goto err;
 
 	if (!cfg->raw_addressing) {
-		tx->dqo.qpl = gve_assign_tx_qpl(cfg, idx);
-		if (!tx->dqo.qpl)
-			goto err;
+		u32 qpl_id = gve_tx_qpl_id(priv, tx->q_num);
+
+		tx->dqo.qpl = &cfg->qpls[qpl_id];
 
 		if (gve_tx_qpl_buf_init(tx))
 			goto err;
-- 
2.44.0.769.g3c40516874-goog


