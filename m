Return-Path: <linux-kernel+bounces-127200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D36E8947EC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 01:47:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E01B128394C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 23:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72DE75FDDC;
	Mon,  1 Apr 2024 23:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Df6Zv/SK"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697AE5D8EB
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 23:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712015144; cv=none; b=Y4t9lbcN85RZ89nrGfRg3lRRt/m2eAJad/jHM5QMpVuJca8jO1RMRtqouPJz88a2wQzuMQw5JzGXpvm2ysGPTmuioaZmnmeQXYCboN3QWAZCQQqaczX8eWSHJO2sgnVqmdnLn4zT40GXsN18be6yiQiiurq8us99FV9IC7sqbio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712015144; c=relaxed/simple;
	bh=wpaOzUKZe6m41VJhMrZmFbZtbx1NJZMDb9aKqCk1HAc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QyZwQMWYZ8VxVpEE1JLEEorLzIpnka3ZghZoLzbxheQ8z7H7BGeOrMsTAeISRi/M0zTx3PCZGcLONMZtFTuMgHeC17pVMQuJ1erJK4SUYpew12zbl4zxZbcRd6VLpDe5nNEE5lism27rugu+Iwk/W0bxgRSNtusmIGgcLY8Eof4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Df6Zv/SK; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-1deffb08ac1so33431345ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2024 16:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712015142; x=1712619942; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DEKaQ6KAeMPWO9dtuQ6KA+UswlqpBXRhAE4EEfNny0E=;
        b=Df6Zv/SKtWu+T9fwjBMY2viIe2nmpbrNhDxJybsuROI919TgWhoCmbazid38TzPx8P
         TtDQXJL4rKumCL8MJybDtvy73slGcRs5xpvaHEBWLyOJN5QzDsqAq2bv4maNq0xEKCwL
         bJFrlFr4MtnQ/OQRsP5SxKgq0IKM7VkAMNbi4grP/wHFbIantsteCFOvJVotjjzcr5iY
         CDilthfuosgVoqmk3a0gLyBnsZ5HBNX8vXH3TwaOq204jlYznuJB3/yYZQShqjBRODKc
         d7Yu6MM8K2zeoNrNCPAOHHStg22UAtPkgowDuZVvxifEujLfC6pZ6ZMiYA1CIj5ixPW8
         kidg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712015142; x=1712619942;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DEKaQ6KAeMPWO9dtuQ6KA+UswlqpBXRhAE4EEfNny0E=;
        b=C7N+XlIeJHBzLdh9X2b1JipQ6yBz4ResNrgBAn2p3w5TOG/XKIIq6p6RGXrZ1E/YJV
         MFJxHzghHlvLYYMkZlDyJNYhNTQtVeW2HBTbGA7XVUFgOt6Ijyx5IfMUDtEo1OVx+MwM
         wIcX+LG2RH7YoYT6CgLzY/hS+UXqGIjVT75w2rSVzjdk6QDWMH5gnXu0IKx5IuPiSYIj
         Up2iClLKu0bsjmh/26VtZ1KRenIsFwq2PsrvB1pSbHetrUXy7QaTppmbeuQdd899nrnV
         vPMWB6zMfc39qFu/JuShdV6gOZUnFdo5X55DnDFJRm8/Le+lpQiz9s7q7vfJ2lw4bJ5q
         bgmg==
X-Forwarded-Encrypted: i=1; AJvYcCV8HAXSYvNpc9fDB0k4qWK2o+pXjhIjM1Nartdw4395gj0s7dprG5kpGc1y8MnognJj8Be7Zbb8nOQOKiyFlXvLlttQkzZqURpSSRun
X-Gm-Message-State: AOJu0YyE5lr9XLMR3mtjNTqy4Ai5yF6G9AN4ccuQKCOfWqFx8uR5IVtw
	5/RVRTL4ZsjHZWONqArcl2UNI/WKdUUT/W8Nylqc1uRn9aVaiCbZZ8ZsdVZ2F5bK+o+rImVTD2z
	0dCVxUIBu8cC7aUwWtlcfcw==
X-Google-Smtp-Source: AGHT+IEFwS5Z6zr+ZYfTQEzPuI+9uZ0WffSIQt9jTChPWGH4dIrQ5vd1dTDCGXzmtoo03Z8BVdd8AkExGL442jOsWw==
X-Received: from hramamurthy-gve.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:141e])
 (user=hramamurthy job=sendgmr) by 2002:a17:903:41d1:b0:1e0:c580:4960 with
 SMTP id u17-20020a17090341d100b001e0c5804960mr1068554ple.8.1712015141826;
 Mon, 01 Apr 2024 16:45:41 -0700 (PDT)
Date: Mon,  1 Apr 2024 23:45:29 +0000
In-Reply-To: <20240401234530.3101900-1-hramamurthy@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240401234530.3101900-1-hramamurthy@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240401234530.3101900-5-hramamurthy@google.com>
Subject: [PATCH net-next 4/5] gve: add support to read ring size ranges from
 the device
From: Harshitha Ramamurthy <hramamurthy@google.com>
To: netdev@vger.kernel.org
Cc: jeroendb@google.com, pkaligineedi@google.com, shailend@google.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	willemb@google.com, rushilg@google.com, jfraker@google.com, 
	linux-kernel@vger.kernel.org, Harshitha Ramamurthy <hramamurthy@google.com>
Content-Type: text/plain; charset="UTF-8"

Add support to read ring size change capability and the
min and max descriptor counts from the device and store it
in the driver. Also accommodate a special case where the
device does not provide minimum ring size depending on the
version of the device. In that case, rely on default values
for the minimums.

Reviewed-by: Praveen Kaligineedi <pkaligineedi@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
---
 drivers/net/ethernet/google/gve/gve.h        | 10 +++
 drivers/net/ethernet/google/gve/gve_adminq.c | 71 +++++++++++++++++---
 drivers/net/ethernet/google/gve/gve_adminq.h | 45 ++++++++-----
 3 files changed, 102 insertions(+), 24 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
index 693d4b7d818b..669cacdae4f4 100644
--- a/drivers/net/ethernet/google/gve/gve.h
+++ b/drivers/net/ethernet/google/gve/gve.h
@@ -50,6 +50,10 @@
 /* PTYPEs are always 10 bits. */
 #define GVE_NUM_PTYPES	1024
 
+/* Default minimum ring size */
+#define GVE_DEFAULT_MIN_TX_RING_SIZE 256
+#define GVE_DEFAULT_MIN_RX_RING_SIZE 512
+
 #define GVE_DEFAULT_RX_BUFFER_SIZE 2048
 
 #define GVE_MAX_RX_BUFFER_SIZE 4096
@@ -712,6 +716,12 @@ struct gve_priv {
 	u16 num_event_counters;
 	u16 tx_desc_cnt; /* num desc per ring */
 	u16 rx_desc_cnt; /* num desc per ring */
+	u16 max_tx_desc_cnt;
+	u16 max_rx_desc_cnt;
+	u16 min_tx_desc_cnt;
+	u16 min_rx_desc_cnt;
+	bool modify_ring_size_enabled;
+	bool default_min_ring_size;
 	u16 tx_pages_per_qpl; /* Suggested number of pages per qpl for TX queues by NIC */
 	u64 max_registered_pages;
 	u64 num_registered_pages; /* num pages registered with NIC */
diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/ethernet/google/gve/gve_adminq.c
index faeff20cd370..b2b619aa2310 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.c
+++ b/drivers/net/ethernet/google/gve/gve_adminq.c
@@ -32,6 +32,8 @@ struct gve_device_option *gve_get_next_option(struct gve_device_descriptor *desc
 	return option_end > descriptor_end ? NULL : (struct gve_device_option *)option_end;
 }
 
+#define GVE_DEVICE_OPTION_NO_MIN_RING_SIZE	8
+
 static
 void gve_parse_device_option(struct gve_priv *priv,
 			     struct gve_device_descriptor *device_descriptor,
@@ -41,7 +43,8 @@ void gve_parse_device_option(struct gve_priv *priv,
 			     struct gve_device_option_dqo_rda **dev_op_dqo_rda,
 			     struct gve_device_option_jumbo_frames **dev_op_jumbo_frames,
 			     struct gve_device_option_dqo_qpl **dev_op_dqo_qpl,
-			     struct gve_device_option_buffer_sizes **dev_op_buffer_sizes)
+			     struct gve_device_option_buffer_sizes **dev_op_buffer_sizes,
+			     struct gve_device_option_modify_ring **dev_op_modify_ring)
 {
 	u32 req_feat_mask = be32_to_cpu(option->required_features_mask);
 	u16 option_length = be16_to_cpu(option->option_length);
@@ -165,6 +168,27 @@ void gve_parse_device_option(struct gve_priv *priv,
 				 "Buffer Sizes");
 		*dev_op_buffer_sizes = (void *)(option + 1);
 		break;
+	case GVE_DEV_OPT_ID_MODIFY_RING:
+		if (option_length < GVE_DEVICE_OPTION_NO_MIN_RING_SIZE ||
+		    req_feat_mask != GVE_DEV_OPT_REQ_FEAT_MASK_MODIFY_RING) {
+			dev_warn(&priv->pdev->dev, GVE_DEVICE_OPTION_ERROR_FMT,
+				 "Modify Ring", (int)sizeof(**dev_op_modify_ring),
+				 GVE_DEV_OPT_REQ_FEAT_MASK_MODIFY_RING,
+				 option_length, req_feat_mask);
+			break;
+		}
+
+		if (option_length > sizeof(**dev_op_modify_ring)) {
+			dev_warn(&priv->pdev->dev,
+				 GVE_DEVICE_OPTION_TOO_BIG_FMT, "Modify Ring");
+		}
+
+		*dev_op_modify_ring = (void *)(option + 1);
+
+		/* device has not provided min ring size */
+		if (option_length == GVE_DEVICE_OPTION_NO_MIN_RING_SIZE)
+			priv->default_min_ring_size = true;
+		break;
 	default:
 		/* If we don't recognize the option just continue
 		 * without doing anything.
@@ -183,7 +207,8 @@ gve_process_device_options(struct gve_priv *priv,
 			   struct gve_device_option_dqo_rda **dev_op_dqo_rda,
 			   struct gve_device_option_jumbo_frames **dev_op_jumbo_frames,
 			   struct gve_device_option_dqo_qpl **dev_op_dqo_qpl,
-			   struct gve_device_option_buffer_sizes **dev_op_buffer_sizes)
+			   struct gve_device_option_buffer_sizes **dev_op_buffer_sizes,
+			   struct gve_device_option_modify_ring **dev_op_modify_ring)
 {
 	const int num_options = be16_to_cpu(descriptor->num_device_options);
 	struct gve_device_option *dev_opt;
@@ -204,7 +229,8 @@ gve_process_device_options(struct gve_priv *priv,
 		gve_parse_device_option(priv, descriptor, dev_opt,
 					dev_op_gqi_rda, dev_op_gqi_qpl,
 					dev_op_dqo_rda, dev_op_jumbo_frames,
-					dev_op_dqo_qpl, dev_op_buffer_sizes);
+					dev_op_dqo_qpl, dev_op_buffer_sizes,
+					dev_op_modify_ring);
 		dev_opt = next_opt;
 	}
 
@@ -738,6 +764,12 @@ static void gve_set_default_desc_cnt(struct gve_priv *priv,
 {
 	priv->tx_desc_cnt = be16_to_cpu(descriptor->tx_queue_entries);
 	priv->rx_desc_cnt = be16_to_cpu(descriptor->rx_queue_entries);
+
+	/* set default ranges */
+	priv->max_tx_desc_cnt = priv->tx_desc_cnt;
+	priv->max_rx_desc_cnt = priv->rx_desc_cnt;
+	priv->min_tx_desc_cnt = priv->tx_desc_cnt;
+	priv->min_rx_desc_cnt = priv->rx_desc_cnt;
 }
 
 static void gve_enable_supported_features(struct gve_priv *priv,
@@ -747,7 +779,9 @@ static void gve_enable_supported_features(struct gve_priv *priv,
 					  const struct gve_device_option_dqo_qpl
 					  *dev_op_dqo_qpl,
 					  const struct gve_device_option_buffer_sizes
-					  *dev_op_buffer_sizes)
+					  *dev_op_buffer_sizes,
+					  const struct gve_device_option_modify_ring
+					  *dev_op_modify_ring)
 {
 	/* Before control reaches this point, the page-size-capped max MTU from
 	 * the gve_device_descriptor field has already been stored in
@@ -778,12 +812,33 @@ static void gve_enable_supported_features(struct gve_priv *priv,
 			 "BUFFER SIZES device option enabled with max_rx_buffer_size of %u, header_buf_size of %u.\n",
 			 priv->max_rx_buffer_size, priv->header_buf_size);
 	}
+
+	/* Read and store ring size ranges given by device */
+	if (dev_op_modify_ring &&
+	    (supported_features_mask & GVE_SUP_MODIFY_RING_MASK)) {
+		priv->modify_ring_size_enabled = true;
+
+		/* max ring size for DQO QPL should not be overwritten because of device limit */
+		if (priv->queue_format != GVE_DQO_QPL_FORMAT) {
+			priv->max_rx_desc_cnt = be16_to_cpu(dev_op_modify_ring->max_rx_ring_size);
+			priv->max_tx_desc_cnt = be16_to_cpu(dev_op_modify_ring->max_tx_ring_size);
+		}
+		if (priv->default_min_ring_size) {
+			/* If device hasn't provided minimums, use default minimums */
+			priv->min_tx_desc_cnt = GVE_DEFAULT_MIN_TX_RING_SIZE;
+			priv->min_rx_desc_cnt = GVE_DEFAULT_MIN_RX_RING_SIZE;
+		} else {
+			priv->min_rx_desc_cnt = be16_to_cpu(dev_op_modify_ring->min_rx_ring_size);
+			priv->min_tx_desc_cnt = be16_to_cpu(dev_op_modify_ring->min_tx_ring_size);
+		}
+	}
 }
 
 int gve_adminq_describe_device(struct gve_priv *priv)
 {
 	struct gve_device_option_buffer_sizes *dev_op_buffer_sizes = NULL;
 	struct gve_device_option_jumbo_frames *dev_op_jumbo_frames = NULL;
+	struct gve_device_option_modify_ring *dev_op_modify_ring = NULL;
 	struct gve_device_option_gqi_rda *dev_op_gqi_rda = NULL;
 	struct gve_device_option_gqi_qpl *dev_op_gqi_qpl = NULL;
 	struct gve_device_option_dqo_rda *dev_op_dqo_rda = NULL;
@@ -815,9 +870,9 @@ int gve_adminq_describe_device(struct gve_priv *priv)
 
 	err = gve_process_device_options(priv, descriptor, &dev_op_gqi_rda,
 					 &dev_op_gqi_qpl, &dev_op_dqo_rda,
-					 &dev_op_jumbo_frames,
-					 &dev_op_dqo_qpl,
-					 &dev_op_buffer_sizes);
+					 &dev_op_jumbo_frames, &dev_op_dqo_qpl,
+					 &dev_op_buffer_sizes,
+					 &dev_op_modify_ring);
 	if (err)
 		goto free_device_descriptor;
 
@@ -878,7 +933,7 @@ int gve_adminq_describe_device(struct gve_priv *priv)
 
 	gve_enable_supported_features(priv, supported_features_mask,
 				      dev_op_jumbo_frames, dev_op_dqo_qpl,
-				      dev_op_buffer_sizes);
+				      dev_op_buffer_sizes, dev_op_modify_ring);
 
 free_device_descriptor:
 	dma_pool_free(priv->adminq_pool, descriptor, descriptor_bus);
diff --git a/drivers/net/ethernet/google/gve/gve_adminq.h b/drivers/net/ethernet/google/gve/gve_adminq.h
index 3ff2028a7472..beedf2353847 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.h
+++ b/drivers/net/ethernet/google/gve/gve_adminq.h
@@ -133,6 +133,16 @@ struct gve_device_option_buffer_sizes {
 
 static_assert(sizeof(struct gve_device_option_buffer_sizes) == 8);
 
+struct gve_device_option_modify_ring {
+	__be32 supported_featured_mask;
+	__be16 max_rx_ring_size;
+	__be16 max_tx_ring_size;
+	__be16 min_rx_ring_size;
+	__be16 min_tx_ring_size;
+};
+
+static_assert(sizeof(struct gve_device_option_modify_ring) == 12);
+
 /* Terminology:
  *
  * RDA - Raw DMA Addressing - Buffers associated with SKBs are directly DMA
@@ -142,28 +152,31 @@ static_assert(sizeof(struct gve_device_option_buffer_sizes) == 8);
  *       the device for read/write and data is copied from/to SKBs.
  */
 enum gve_dev_opt_id {
-	GVE_DEV_OPT_ID_GQI_RAW_ADDRESSING = 0x1,
-	GVE_DEV_OPT_ID_GQI_RDA = 0x2,
-	GVE_DEV_OPT_ID_GQI_QPL = 0x3,
-	GVE_DEV_OPT_ID_DQO_RDA = 0x4,
-	GVE_DEV_OPT_ID_DQO_QPL = 0x7,
-	GVE_DEV_OPT_ID_JUMBO_FRAMES = 0x8,
-	GVE_DEV_OPT_ID_BUFFER_SIZES = 0xa,
+	GVE_DEV_OPT_ID_GQI_RAW_ADDRESSING	= 0x1,
+	GVE_DEV_OPT_ID_GQI_RDA			= 0x2,
+	GVE_DEV_OPT_ID_GQI_QPL			= 0x3,
+	GVE_DEV_OPT_ID_DQO_RDA			= 0x4,
+	GVE_DEV_OPT_ID_MODIFY_RING		= 0x6,
+	GVE_DEV_OPT_ID_DQO_QPL			= 0x7,
+	GVE_DEV_OPT_ID_JUMBO_FRAMES		= 0x8,
+	GVE_DEV_OPT_ID_BUFFER_SIZES		= 0xa,
 };
 
 enum gve_dev_opt_req_feat_mask {
-	GVE_DEV_OPT_REQ_FEAT_MASK_GQI_RAW_ADDRESSING = 0x0,
-	GVE_DEV_OPT_REQ_FEAT_MASK_GQI_RDA = 0x0,
-	GVE_DEV_OPT_REQ_FEAT_MASK_GQI_QPL = 0x0,
-	GVE_DEV_OPT_REQ_FEAT_MASK_DQO_RDA = 0x0,
-	GVE_DEV_OPT_REQ_FEAT_MASK_JUMBO_FRAMES = 0x0,
-	GVE_DEV_OPT_REQ_FEAT_MASK_DQO_QPL = 0x0,
-	GVE_DEV_OPT_REQ_FEAT_MASK_BUFFER_SIZES = 0x0,
+	GVE_DEV_OPT_REQ_FEAT_MASK_GQI_RAW_ADDRESSING	= 0x0,
+	GVE_DEV_OPT_REQ_FEAT_MASK_GQI_RDA		= 0x0,
+	GVE_DEV_OPT_REQ_FEAT_MASK_GQI_QPL		= 0x0,
+	GVE_DEV_OPT_REQ_FEAT_MASK_DQO_RDA		= 0x0,
+	GVE_DEV_OPT_REQ_FEAT_MASK_JUMBO_FRAMES		= 0x0,
+	GVE_DEV_OPT_REQ_FEAT_MASK_DQO_QPL		= 0x0,
+	GVE_DEV_OPT_REQ_FEAT_MASK_BUFFER_SIZES		= 0x0,
+	GVE_DEV_OPT_REQ_FEAT_MASK_MODIFY_RING		= 0x0,
 };
 
 enum gve_sup_feature_mask {
-	GVE_SUP_JUMBO_FRAMES_MASK = 1 << 2,
-	GVE_SUP_BUFFER_SIZES_MASK = 1 << 4,
+	GVE_SUP_MODIFY_RING_MASK	= 1 << 0,
+	GVE_SUP_JUMBO_FRAMES_MASK	= 1 << 2,
+	GVE_SUP_BUFFER_SIZES_MASK	= 1 << 4,
 };
 
 #define GVE_DEV_OPT_LEN_GQI_RAW_ADDRESSING 0x0
-- 
2.44.0.478.gd926399ef9-goog


