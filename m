Return-Path: <linux-kernel+bounces-127199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29AEB8947E9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 01:47:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D4BD1C216CB
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 23:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B09105F466;
	Mon,  1 Apr 2024 23:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3W3lMt6E"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E43058AAD
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 23:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712015142; cv=none; b=OCYnZVQQrj75kHBuYxXWQ9HGr7H6AdkbQdFE9mSy7tVK2Acf43JN8hJwPETDstmycoD7Etm5Ynn9Njj/I2XWOQu3DUJoff/Q1+H4/R6tGpxtVnyx1JMRJCAGuVCGAZLxN9/w7b3RoFmxO42vhQ+g+2ae2FJAOxQcBbgP3kL3kwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712015142; c=relaxed/simple;
	bh=zmdb2RykTKxgOnYxe1piDwaiGtsm1mvy4+l4CT85SUA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NB6jcLqjHyLL1kd75wAPWY4aEcXQCvgKE8PhN7nxFUbH1klKZIS4IWMCtyixdsPWQZcEXDXcgAcW6ggibzHXbytuvLbAzegSFVL+cXXgaxbpzFXRyK8uOVe8KwTcerf+6vxRmmWBHDiKAKemsNH8rhGXStz9pfHm0h2d6+DF5mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3W3lMt6E; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-29c7932c5f5so3523053a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2024 16:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712015140; x=1712619940; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SL4gSpw35iFPDr0r8I57ZBW33p2oC8+GNJ3croWhHJo=;
        b=3W3lMt6Ey94I3YguA0w6fLvbZRcdtBgRkW2vFGGABFIW118jghP/vGxl9jesIq8lr3
         gpPpsQg0qecsx7lwvZeT9jS36J4NW2OXGzYcKZllYFBUPf5uahswbqz4jh8q6SJ5IIm6
         3y8qwDNC90MUZ9ZKNw6rv9F96sbq9FtEQZKfabbmruPxjfekMm/T79UGxZL95tWDey5J
         pEAvC2hmDph55rcIp5bIaootJ/5RKH7yWYlV/j6Gw6N1KTy7gPGFAhXerpfqbJeZ6+03
         rIW0q8j6NvgfjtZBsBslx0U+Rc1FarG+ysku3CN2eMoBLys0JxlSMg8VjIMFgRcnJaTi
         cgHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712015140; x=1712619940;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SL4gSpw35iFPDr0r8I57ZBW33p2oC8+GNJ3croWhHJo=;
        b=ZsZ9qtoCPBJQuMO/aPZq17tvTgEKvnCY6tkKqAjIYtgnuqk02qmiHR7fSJbs3Cc5nl
         4oG08N8PciRHbo5SZrwHJ0gqH4sKPZ1UYp9AQLcJleg07NUzNC246BA2Rl9KminhWyc9
         HT7MMaQFbE04hvowvV3KNIPlTLqmyB5XmchBodSG4pJOXb4O0kkQQzJP2USzzYcCLfyR
         lbk0h7bq7BO1uRwOHRS2SomGs4pK1LMxIppRnKb6guHXW/wOcbnGH+tgQWptEddotU2Z
         UWP2WURocikxMGux4EMCPx+Dx6I0Nu6IRcisbO5hiqDl96eXDbuvQkclvqmpJztk12ia
         KotA==
X-Forwarded-Encrypted: i=1; AJvYcCWp7dHIWedACpLdEMmlN8B8CeTl7zD7uDFUlxQjuGtVkU/hINHhLQf5IGjcC/fBpTfh7YVEujXJUT6n+9IXNaP6hd6SYquwjkYuAHzr
X-Gm-Message-State: AOJu0YyRx7GU3v+3wPdZcnGGCgTdto+LtO+WgW5F38bVAL7Nuz9+4rS1
	wqBFtO9bBpRfKtmR06/Q7BFCguIZg8aAxlF5vHhADO1aUbQ9hsg2Q0JaUiHI7DIS+OI9sAUQlj1
	JgvsRLIzcXGxSBpLJ17sO/Q==
X-Google-Smtp-Source: AGHT+IEVImByN++D88oacBX+RxQuh83VMx/H5Xh8Wa6G1kf6Ysz7vUklVGBi0ciEnIoEuO4k9iWTvBB2xKDji1NemA==
X-Received: from hramamurthy-gve.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:141e])
 (user=hramamurthy job=sendgmr) by 2002:a17:903:2305:b0:1e2:57b:9d8c with SMTP
 id d5-20020a170903230500b001e2057b9d8cmr649790plh.4.1712015140212; Mon, 01
 Apr 2024 16:45:40 -0700 (PDT)
Date: Mon,  1 Apr 2024 23:45:28 +0000
In-Reply-To: <20240401234530.3101900-1-hramamurthy@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240401234530.3101900-1-hramamurthy@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240401234530.3101900-4-hramamurthy@google.com>
Subject: [PATCH net-next 3/5] gve: set page count for RX QPL for GQI and DQO
 queue formats
From: Harshitha Ramamurthy <hramamurthy@google.com>
To: netdev@vger.kernel.org
Cc: jeroendb@google.com, pkaligineedi@google.com, shailend@google.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	willemb@google.com, rushilg@google.com, jfraker@google.com, 
	linux-kernel@vger.kernel.org, Harshitha Ramamurthy <hramamurthy@google.com>
Content-Type: text/plain; charset="UTF-8"

Fulfill the requirement that for GQI, the number of pages per
RX QPL is equal to the ring size. Set this value to be equal to
ring size. Because of this change, the rx_data_slot_cnt and
rx_pages_per_qpl fields stored in the priv structure are not
needed, so remove their usage. And for DQO, the number of pages
per RX QPL is more than ring size to account for out-of-order
completions. So set it to two times of rx ring size.

Reviewed-by: Praveen Kaligineedi <pkaligineedi@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
---
 drivers/net/ethernet/google/gve/gve.h        | 11 ++++++++---
 drivers/net/ethernet/google/gve/gve_adminq.c | 11 -----------
 drivers/net/ethernet/google/gve/gve_main.c   | 14 +++++++++-----
 drivers/net/ethernet/google/gve/gve_rx.c     |  2 +-
 drivers/net/ethernet/google/gve/gve_rx_dqo.c |  4 ++--
 5 files changed, 20 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
index f009f7b3e68b..693d4b7d818b 100644
--- a/drivers/net/ethernet/google/gve/gve.h
+++ b/drivers/net/ethernet/google/gve/gve.h
@@ -63,7 +63,6 @@
 #define GVE_DEFAULT_HEADER_BUFFER_SIZE 128
 
 #define DQO_QPL_DEFAULT_TX_PAGES 512
-#define DQO_QPL_DEFAULT_RX_PAGES 2048
 
 /* Maximum TSO size supported on DQO */
 #define GVE_DQO_TX_MAX	0x3FFFF
@@ -714,8 +713,6 @@ struct gve_priv {
 	u16 tx_desc_cnt; /* num desc per ring */
 	u16 rx_desc_cnt; /* num desc per ring */
 	u16 tx_pages_per_qpl; /* Suggested number of pages per qpl for TX queues by NIC */
-	u16 rx_pages_per_qpl; /* Suggested number of pages per qpl for RX queues by NIC */
-	u16 rx_data_slot_cnt; /* rx buffer length */
 	u64 max_registered_pages;
 	u64 num_registered_pages; /* num pages registered with NIC */
 	struct bpf_prog *xdp_prog; /* XDP BPF program */
@@ -1038,6 +1035,14 @@ static inline u32 gve_rx_start_qpl_id(const struct gve_queue_config *tx_cfg)
 	return gve_get_rx_qpl_id(tx_cfg, 0);
 }
 
+static inline u32 gve_get_rx_pages_per_qpl_dqo(u32 rx_desc_cnt)
+{
+	/* For DQO, page count should be more than ring size for
+	 * out-of-order completions. Set it to two times of ring size.
+	 */
+	return 2 * rx_desc_cnt;
+}
+
 /* Returns a pointer to the next available tx qpl in the list of qpls */
 static inline
 struct gve_queue_page_list *gve_assign_tx_qpl(struct gve_tx_alloc_rings_cfg *cfg,
diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/ethernet/google/gve/gve_adminq.c
index 2ff9327ec056..faeff20cd370 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.c
+++ b/drivers/net/ethernet/google/gve/gve_adminq.c
@@ -764,12 +764,8 @@ static void gve_enable_supported_features(struct gve_priv *priv,
 	if (dev_op_dqo_qpl) {
 		priv->tx_pages_per_qpl =
 			be16_to_cpu(dev_op_dqo_qpl->tx_pages_per_qpl);
-		priv->rx_pages_per_qpl =
-			be16_to_cpu(dev_op_dqo_qpl->rx_pages_per_qpl);
 		if (priv->tx_pages_per_qpl == 0)
 			priv->tx_pages_per_qpl = DQO_QPL_DEFAULT_TX_PAGES;
-		if (priv->rx_pages_per_qpl == 0)
-			priv->rx_pages_per_qpl = DQO_QPL_DEFAULT_RX_PAGES;
 	}
 
 	if (dev_op_buffer_sizes &&
@@ -878,13 +874,6 @@ int gve_adminq_describe_device(struct gve_priv *priv)
 	mac = descriptor->mac;
 	dev_info(&priv->pdev->dev, "MAC addr: %pM\n", mac);
 	priv->tx_pages_per_qpl = be16_to_cpu(descriptor->tx_pages_per_qpl);
-	priv->rx_data_slot_cnt = be16_to_cpu(descriptor->rx_pages_per_qpl);
-
-	if (gve_is_gqi(priv) && priv->rx_data_slot_cnt < priv->rx_desc_cnt) {
-		dev_err(&priv->pdev->dev, "rx_data_slot_cnt cannot be smaller than rx_desc_cnt, setting rx_desc_cnt down to %d.\n",
-			priv->rx_data_slot_cnt);
-		priv->rx_desc_cnt = priv->rx_data_slot_cnt;
-	}
 	priv->default_num_queues = be16_to_cpu(descriptor->default_num_queues);
 
 	gve_enable_supported_features(priv, supported_features_mask,
diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index 166bd827a6d7..470447c0490f 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -1103,13 +1103,13 @@ static int gve_alloc_n_qpls(struct gve_priv *priv,
 	return err;
 }
 
-static int gve_alloc_qpls(struct gve_priv *priv,
-			  struct gve_qpls_alloc_cfg *cfg)
+static int gve_alloc_qpls(struct gve_priv *priv, struct gve_qpls_alloc_cfg *cfg,
+			  struct gve_rx_alloc_rings_cfg *rx_alloc_cfg)
 {
 	int max_queues = cfg->tx_cfg->max_queues + cfg->rx_cfg->max_queues;
 	int rx_start_id, tx_num_qpls, rx_num_qpls;
 	struct gve_queue_page_list *qpls;
-	int page_count;
+	u32 page_count;
 	int err;
 
 	if (cfg->raw_addressing)
@@ -1141,8 +1141,12 @@ static int gve_alloc_qpls(struct gve_priv *priv,
 	/* For GQI_QPL number of pages allocated have 1:1 relationship with
 	 * number of descriptors. For DQO, number of pages required are
 	 * more than descriptors (because of out of order completions).
+	 * Set it to twice the number of descriptors.
 	 */
-	page_count = cfg->is_gqi ? priv->rx_data_slot_cnt : priv->rx_pages_per_qpl;
+	if (cfg->is_gqi)
+		page_count = rx_alloc_cfg->ring_size;
+	else
+		page_count = gve_get_rx_pages_per_qpl_dqo(rx_alloc_cfg->ring_size);
 	rx_num_qpls = gve_num_rx_qpls(cfg->rx_cfg, gve_is_qpl(priv));
 	err = gve_alloc_n_qpls(priv, qpls, page_count, rx_start_id, rx_num_qpls);
 	if (err)
@@ -1363,7 +1367,7 @@ static int gve_queues_mem_alloc(struct gve_priv *priv,
 {
 	int err;
 
-	err = gve_alloc_qpls(priv, qpls_alloc_cfg);
+	err = gve_alloc_qpls(priv, qpls_alloc_cfg, rx_alloc_cfg);
 	if (err) {
 		netif_err(priv, drv, priv->dev, "Failed to alloc QPLs\n");
 		return err;
diff --git a/drivers/net/ethernet/google/gve/gve_rx.c b/drivers/net/ethernet/google/gve/gve_rx.c
index 20f5a9e7fae9..cd727e55ae0f 100644
--- a/drivers/net/ethernet/google/gve/gve_rx.c
+++ b/drivers/net/ethernet/google/gve/gve_rx.c
@@ -240,7 +240,7 @@ static int gve_rx_alloc_ring_gqi(struct gve_priv *priv,
 				 int idx)
 {
 	struct device *hdev = &priv->pdev->dev;
-	u32 slots = priv->rx_data_slot_cnt;
+	u32 slots = cfg->ring_size;
 	int filled_pages;
 	size_t bytes;
 	int err;
diff --git a/drivers/net/ethernet/google/gve/gve_rx_dqo.c b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
index 7c2ab1edfcb2..15108407b54f 100644
--- a/drivers/net/ethernet/google/gve/gve_rx_dqo.c
+++ b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
@@ -178,7 +178,7 @@ static int gve_alloc_page_dqo(struct gve_rx_ring *rx,
 			return err;
 	} else {
 		idx = rx->dqo.next_qpl_page_idx;
-		if (idx >= priv->rx_pages_per_qpl) {
+		if (idx >= gve_get_rx_pages_per_qpl_dqo(priv->rx_desc_cnt)) {
 			net_err_ratelimited("%s: Out of QPL pages\n",
 					    priv->dev->name);
 			return -ENOMEM;
@@ -321,7 +321,7 @@ static int gve_rx_alloc_ring_dqo(struct gve_priv *priv,
 
 	rx->dqo.num_buf_states = cfg->raw_addressing ?
 		min_t(s16, S16_MAX, buffer_queue_slots * 4) :
-		priv->rx_pages_per_qpl;
+		gve_get_rx_pages_per_qpl_dqo(cfg->ring_size);
 	rx->dqo.buf_states = kvcalloc(rx->dqo.num_buf_states,
 				      sizeof(rx->dqo.buf_states[0]),
 				      GFP_KERNEL);
-- 
2.44.0.478.gd926399ef9-goog


