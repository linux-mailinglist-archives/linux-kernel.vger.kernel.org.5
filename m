Return-Path: <linux-kernel+bounces-127198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4DAC8947E8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 01:47:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F1231F236D9
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 23:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D394A5D479;
	Mon,  1 Apr 2024 23:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YDhZya3c"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1324858200
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 23:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712015140; cv=none; b=m1UJv6/atuyN3fKEB1Tc1SO5UMx+hKYxN19+d25Hd3JeX8wkWahSP8pmjeb21f+zItgds27tiwRuHv6tNTXs4L9wazEavsvi3RKqQISPcXTkejoRtFYJmod5sACSvxSMBLXPJq2+GMizw6bJMExTVvzyEW9Uw9dgjjQMZmiGZ+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712015140; c=relaxed/simple;
	bh=4Al7cogJgwG71T9PF36FmiCOCANhmjGddBvyH81kElo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ehbqMEHKJb8N6GR8xYdtn1WlD0UMwffr6AXlnsE5tIF5LaFJMIQO0R7eJAJAXrcQbESJevkSuN3M7RvMRb0dlWzdsTNMEwm/agHXNmBpm8ToRIFEp2ysk3PNSKi1jRQiLS2YJ+q3Fm7SwnmjBlNXtz3KcQZ4YKXzv5zHw0j40WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YDhZya3c; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-1e0b29c2ef9so39042805ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2024 16:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712015138; x=1712619938; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TD84AfiiAPduKfquC9ZyoiPEtdYCEB6tU+3PiFa9oWU=;
        b=YDhZya3chzxAteE1FMP5l49U3pkC/aAgONylHAS3ayzWwMh7eX6sQBpcg6ZJnRTJsc
         dFyR8sbPYYOaYxFGTW3MTcWENcRq9IP0FPhmL8GDiaSLb2DoKOIHT0bHXWdh6B5BqfnY
         oPAQ1XYrR8CQqhldG48IO0f47plaUFUsn/IyqSgfSl63dfyMfsKrM6H8bcZlWNxnRIZT
         Gol5ljKBuN8P0MTjsElR3ulWkgcWOq4ETpRmQ1H4QFtx6snna/r32tsTLQ8qlc6THSdI
         UR0L3N6Fo4ItToETANDj9aGytnNAH5tgFAW6Cl1/vyoCaR/G82+lwAbK1vugOjTBN2kc
         ZI7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712015138; x=1712619938;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TD84AfiiAPduKfquC9ZyoiPEtdYCEB6tU+3PiFa9oWU=;
        b=QcMPgfUzbvkJ5yEXw+rfxaUGXN3r3ejy048pr7hVH9F8Fhxlhoq34Q+RH/9DzaidJk
         RLccNs1X+cyM7nznxDx1RlbcLpfevwGS5FRR6E+Wg6v4GugD2QJrq6Gi2S24pO5sjbFO
         EeGR5pugNGpmHqxRCoPNszy5NrECC8CCDM91bkaGy89dDZ/DC6Xqwq3YfYh0RlZFkEP6
         2Vv0RXw4VrVLUeUr9zm5mUBs/l6qf+u5YgTSzRLhec7opwJuVHFZLuZ5CCHYDoB3Gtg0
         WypQqeQbK2SVCn+OUf90cdXwbp5QopXZqqSE0EMliTC/lAQS/DG8aJjcTpv/dT8ufUGU
         C80g==
X-Forwarded-Encrypted: i=1; AJvYcCVZL/VMHPJa7kDPhdl2MY8gLbMdvT2l4S6glFWxjmNYmVxUEJcX1WbjlGv65Dn6503JRGdLYC53K6+zOvUaYp0N8vxEwbz2Yx/uae+t
X-Gm-Message-State: AOJu0YxCV3BEnPIsJMDkO7tPLl8y2o6r+hDQatYdhDq60WG7zUXliw0h
	bQM+HHjNqUoP/wo4SBqWR+xDJ+RaB1YQ49CjWhzGbcCEx2tJgI5d01UvdmZZtpiuLRZOx9u/Jnv
	oJT08zkfa3rH6GQKU7SPZLQ==
X-Google-Smtp-Source: AGHT+IEpZZdbMF8QXndZ12sIWCPLHdc5DHSePA9XGiZF2UTbpSSDR6xCYwihyqIUpslkzVLV0Ia4HHkiL33e5dL/UA==
X-Received: from hramamurthy-gve.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:141e])
 (user=hramamurthy job=sendgmr) by 2002:a17:902:d505:b0:1e1:a509:5681 with
 SMTP id b5-20020a170902d50500b001e1a5095681mr819299plg.2.1712015138316; Mon,
 01 Apr 2024 16:45:38 -0700 (PDT)
Date: Mon,  1 Apr 2024 23:45:27 +0000
In-Reply-To: <20240401234530.3101900-1-hramamurthy@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240401234530.3101900-1-hramamurthy@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240401234530.3101900-3-hramamurthy@google.com>
Subject: [PATCH net-next 2/5] gve: make the completion and buffer ring size
 equal for DQO
From: Harshitha Ramamurthy <hramamurthy@google.com>
To: netdev@vger.kernel.org
Cc: jeroendb@google.com, pkaligineedi@google.com, shailend@google.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	willemb@google.com, rushilg@google.com, jfraker@google.com, 
	linux-kernel@vger.kernel.org, Harshitha Ramamurthy <hramamurthy@google.com>
Content-Type: text/plain; charset="UTF-8"

For the DQO queue format, the gve driver stores two ring sizes
for both TX and RX - one for completion queue ring and one for
data buffer ring. This is supposed to enable asymmetric sizes
for these two rings but that is not supported. Make both fields
reference the same single variable.

This change renders reading supported TX completion ring size
and RX buffer ring size for DQO from the device useless, so change
those fields to reserved and remove related code.

Reviewed-by: Praveen Kaligineedi <pkaligineedi@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
---
 drivers/net/ethernet/google/gve/gve.h        |  6 ---
 drivers/net/ethernet/google/gve/gve_adminq.c | 40 +++++---------------
 drivers/net/ethernet/google/gve/gve_adminq.h |  3 +-
 drivers/net/ethernet/google/gve/gve_rx_dqo.c |  3 +-
 drivers/net/ethernet/google/gve/gve_tx_dqo.c |  4 +-
 5 files changed, 13 insertions(+), 43 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
index 4814c96d5fe7..f009f7b3e68b 100644
--- a/drivers/net/ethernet/google/gve/gve.h
+++ b/drivers/net/ethernet/google/gve/gve.h
@@ -621,11 +621,6 @@ struct gve_qpl_config {
 	unsigned long *qpl_id_map; /* bitmap of used qpl ids */
 };
 
-struct gve_options_dqo_rda {
-	u16 tx_comp_ring_entries; /* number of tx_comp descriptors */
-	u16 rx_buff_ring_entries; /* number of rx_buff descriptors */
-};
-
 struct gve_irq_db {
 	__be32 index;
 } ____cacheline_aligned;
@@ -792,7 +787,6 @@ struct gve_priv {
 	u64 link_speed;
 	bool up_before_suspend; /* True if dev was up before suspend */
 
-	struct gve_options_dqo_rda options_dqo_rda;
 	struct gve_ptype_lut *ptype_lut_dqo;
 
 	/* Must be a power of two. */
diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/ethernet/google/gve/gve_adminq.c
index 50affa11a59c..2ff9327ec056 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.c
+++ b/drivers/net/ethernet/google/gve/gve_adminq.c
@@ -565,6 +565,7 @@ static int gve_adminq_create_tx_queue(struct gve_priv *priv, u32 queue_index)
 			cpu_to_be64(tx->q_resources_bus),
 		.tx_ring_addr = cpu_to_be64(tx->bus),
 		.ntfy_id = cpu_to_be32(tx->ntfy_id),
+		.tx_ring_size = cpu_to_be16(priv->tx_desc_cnt),
 	};
 
 	if (gve_is_gqi(priv)) {
@@ -573,24 +574,17 @@ static int gve_adminq_create_tx_queue(struct gve_priv *priv, u32 queue_index)
 
 		cmd.create_tx_queue.queue_page_list_id = cpu_to_be32(qpl_id);
 	} else {
-		u16 comp_ring_size;
 		u32 qpl_id = 0;
 
-		if (priv->queue_format == GVE_DQO_RDA_FORMAT) {
+		if (priv->queue_format == GVE_DQO_RDA_FORMAT)
 			qpl_id = GVE_RAW_ADDRESSING_QPL_ID;
-			comp_ring_size =
-				priv->options_dqo_rda.tx_comp_ring_entries;
-		} else {
+		else
 			qpl_id = tx->dqo.qpl->id;
-			comp_ring_size = priv->tx_desc_cnt;
-		}
 		cmd.create_tx_queue.queue_page_list_id = cpu_to_be32(qpl_id);
-		cmd.create_tx_queue.tx_ring_size =
-			cpu_to_be16(priv->tx_desc_cnt);
 		cmd.create_tx_queue.tx_comp_ring_addr =
 			cpu_to_be64(tx->complq_bus_dqo);
 		cmd.create_tx_queue.tx_comp_ring_size =
-			cpu_to_be16(comp_ring_size);
+			cpu_to_be16(priv->tx_desc_cnt);
 	}
 
 	return gve_adminq_issue_cmd(priv, &cmd);
@@ -621,6 +615,7 @@ static int gve_adminq_create_rx_queue(struct gve_priv *priv, u32 queue_index)
 		.queue_id = cpu_to_be32(queue_index),
 		.ntfy_id = cpu_to_be32(rx->ntfy_id),
 		.queue_resources_addr = cpu_to_be64(rx->q_resources_bus),
+		.rx_ring_size = cpu_to_be16(priv->rx_desc_cnt),
 	};
 
 	if (gve_is_gqi(priv)) {
@@ -635,20 +630,13 @@ static int gve_adminq_create_rx_queue(struct gve_priv *priv, u32 queue_index)
 		cmd.create_rx_queue.queue_page_list_id = cpu_to_be32(qpl_id);
 		cmd.create_rx_queue.packet_buffer_size = cpu_to_be16(rx->packet_buffer_size);
 	} else {
-		u16 rx_buff_ring_entries;
 		u32 qpl_id = 0;
 
-		if (priv->queue_format == GVE_DQO_RDA_FORMAT) {
+		if (priv->queue_format == GVE_DQO_RDA_FORMAT)
 			qpl_id = GVE_RAW_ADDRESSING_QPL_ID;
-			rx_buff_ring_entries =
-				priv->options_dqo_rda.rx_buff_ring_entries;
-		} else {
+		else
 			qpl_id = rx->dqo.qpl->id;
-			rx_buff_ring_entries = priv->rx_desc_cnt;
-		}
 		cmd.create_rx_queue.queue_page_list_id = cpu_to_be32(qpl_id);
-		cmd.create_rx_queue.rx_ring_size =
-			cpu_to_be16(priv->rx_desc_cnt);
 		cmd.create_rx_queue.rx_desc_ring_addr =
 			cpu_to_be64(rx->dqo.complq.bus);
 		cmd.create_rx_queue.rx_data_ring_addr =
@@ -656,7 +644,7 @@ static int gve_adminq_create_rx_queue(struct gve_priv *priv, u32 queue_index)
 		cmd.create_rx_queue.packet_buffer_size =
 			cpu_to_be16(priv->data_buffer_size_dqo);
 		cmd.create_rx_queue.rx_buff_ring_size =
-			cpu_to_be16(rx_buff_ring_entries);
+			cpu_to_be16(priv->rx_desc_cnt);
 		cmd.create_rx_queue.enable_rsc =
 			!!(priv->dev->features & NETIF_F_LRO);
 		if (priv->header_split_enabled)
@@ -746,18 +734,10 @@ int gve_adminq_destroy_rx_queues(struct gve_priv *priv, u32 num_queues)
 }
 
 static void gve_set_default_desc_cnt(struct gve_priv *priv,
-			const struct gve_device_descriptor *descriptor,
-			const struct gve_device_option_dqo_rda *dev_op_dqo_rda)
+			const struct gve_device_descriptor *descriptor)
 {
 	priv->tx_desc_cnt = be16_to_cpu(descriptor->tx_queue_entries);
 	priv->rx_desc_cnt = be16_to_cpu(descriptor->rx_queue_entries);
-
-	if (priv->queue_format == GVE_DQO_RDA_FORMAT) {
-		priv->options_dqo_rda.tx_comp_ring_entries =
-			be16_to_cpu(dev_op_dqo_rda->tx_comp_ring_entries);
-		priv->options_dqo_rda.rx_buff_ring_entries =
-			be16_to_cpu(dev_op_dqo_rda->rx_buff_ring_entries);
-	}
 }
 
 static void gve_enable_supported_features(struct gve_priv *priv,
@@ -878,7 +858,7 @@ int gve_adminq_describe_device(struct gve_priv *priv)
 	}
 
 	/* set default descriptor counts */
-	gve_set_default_desc_cnt(priv, descriptor, dev_op_dqo_rda);
+	gve_set_default_desc_cnt(priv, descriptor);
 
 	/* DQO supports LRO. */
 	if (!gve_is_gqi(priv))
diff --git a/drivers/net/ethernet/google/gve/gve_adminq.h b/drivers/net/ethernet/google/gve/gve_adminq.h
index 5ac972e45ff8..3ff2028a7472 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.h
+++ b/drivers/net/ethernet/google/gve/gve_adminq.h
@@ -103,8 +103,7 @@ static_assert(sizeof(struct gve_device_option_gqi_qpl) == 4);
 
 struct gve_device_option_dqo_rda {
 	__be32 supported_features_mask;
-	__be16 tx_comp_ring_entries;
-	__be16 rx_buff_ring_entries;
+	__be32 reserved;
 };
 
 static_assert(sizeof(struct gve_device_option_dqo_rda) == 8);
diff --git a/drivers/net/ethernet/google/gve/gve_rx_dqo.c b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
index 8e8071308aeb..7c2ab1edfcb2 100644
--- a/drivers/net/ethernet/google/gve/gve_rx_dqo.c
+++ b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
@@ -305,8 +305,7 @@ static int gve_rx_alloc_ring_dqo(struct gve_priv *priv,
 	size_t size;
 	int i;
 
-	const u32 buffer_queue_slots = cfg->raw_addressing ?
-		priv->options_dqo_rda.rx_buff_ring_entries : cfg->ring_size;
+	const u32 buffer_queue_slots = cfg->ring_size;
 	const u32 completion_queue_slots = cfg->ring_size;
 
 	netif_dbg(priv, drv, priv->dev, "allocating rx ring DQO\n");
diff --git a/drivers/net/ethernet/google/gve/gve_tx_dqo.c b/drivers/net/ethernet/google/gve/gve_tx_dqo.c
index bc34b6cd3a3e..70f29b90a982 100644
--- a/drivers/net/ethernet/google/gve/gve_tx_dqo.c
+++ b/drivers/net/ethernet/google/gve/gve_tx_dqo.c
@@ -295,9 +295,7 @@ static int gve_tx_alloc_ring_dqo(struct gve_priv *priv,
 
 	/* Queue sizes must be a power of 2 */
 	tx->mask = cfg->ring_size - 1;
-	tx->dqo.complq_mask = priv->queue_format == GVE_DQO_RDA_FORMAT ?
-		priv->options_dqo_rda.tx_comp_ring_entries - 1 :
-		tx->mask;
+	tx->dqo.complq_mask = tx->mask;
 
 	/* The max number of pending packets determines the maximum number of
 	 * descriptors which maybe written to the completion queue.
-- 
2.44.0.478.gd926399ef9-goog


