Return-Path: <linux-kernel+bounces-87576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71CDA86D617
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 22:24:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 545791C24235
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 21:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28F826D51B;
	Thu, 29 Feb 2024 21:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RfgaMYNw"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01376D50E
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 21:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709241832; cv=none; b=Kjsrb+h7d+I8QndbfyOW13DI6sP3BtDufy6OqTGDhFlrAYpBP+/EMvzw1g22tHTjhm7KbJGwNRUi3c7sPw49ggKu+5i5gr29VBzEF5JPrIwAb0OnPa0r1ulHyXNkjKhXNMLG6R6g4BP6B9YACz6Ajw66eg65ulNaHo1FfgcTLUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709241832; c=relaxed/simple;
	bh=rvYJHjF3TJa8UGPtWynrnvN5ETRyBHi+0lL/4xDeqKQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WhwlCTPZCaZlStzFnkwmmyv3RK8ID9mumh+K4eRfIGQU7689fGTpxl/p6opKUBB2dZMBAdKxTACzspIszaiReOwcH5gZlMJ0iAxNCHA8gU4fjqnu1axf5UqbagUTMjnZV8yE7pXxgvdc+zD1VLWhCYlY4sAAmek2Q5hMtAwQGdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ziweixiao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RfgaMYNw; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ziweixiao.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-299cae4f36bso1140245a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 13:23:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709241830; x=1709846630; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=f9FlKgN0QCZV27xvHjQB5sdwQFtHd/7HtCh3o9a31n0=;
        b=RfgaMYNwHx8myVSYWR8oZD/owVXz4iw8k9yGvIl5bL3Kadt2Q36HnbEYgWQr0Vlj6N
         4+jNdvaly+T/mel2bwB8lhl8qPhzZtjg7JQnh39k7qsozMJtaO+wzOVCHuuTQzske4lT
         HlTKsEBf+IuwnTalzKGVwAH6bnq44mYh2DZwc5oI/P6Z482oD2mVCmsOuWpRIyza65dn
         FjEI3JGxA8mQ6+fcWqwmzvkDGNxLGursT+PiDG+iYIcJYB6GHjWsFDSFghdf6AKhCoHM
         36v6EqKq3lwqmdwIvoqpzEN8VLD8ApgSczwK8MOYt0hqLioEzXOTpJwwUb4sRPjCba+p
         PKiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709241830; x=1709846630;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f9FlKgN0QCZV27xvHjQB5sdwQFtHd/7HtCh3o9a31n0=;
        b=gicbsK7ZNPu0+avlCQ2IXsNY/WcKaomkqt/xc1QOUPjrwmNQfIlRCmtMCOTrxTB35P
         H53hQhitGPcTQm6WU/cIhHLT7ajHHvZN3e5Oz+bqJe9PCZqeNF9MMUfgjOqpIX0/CYg8
         dRnHb2mmu032UBb6SDSmBbvDvkDfwxUfY7RTcMXElBh1PhFCTdp8JreO3ziaWPQbtO0B
         2IXP5btn2ChAbcUp4Essq5IlN6Bu2O8BKSbzCeS1pjnhFk5FKAzCwxTglQw8PMjMrAKD
         nytdWZGMjmK0R3rCqSv+DRYn50k+ueuJd4fwxpu+skVgAY8bLvAo1pATUEYBuAk00Jxq
         vovQ==
X-Forwarded-Encrypted: i=1; AJvYcCWifgg8ZJVY8OH8NFHVkH8KKxqvW5WpeeDxQ2N404Ega7vj4yNLywlCg3jWIoISU6Cg3gblB91+7RLc+fbpm+sneJjbtD+kMzQ9lte0
X-Gm-Message-State: AOJu0Yyx/dam3NpR/6LiVAQ9gtn+Vnnqrf+RoWkdWnNKMAEqWT3XQm+o
	RNR7cCFb5nl1vqpVpBtPJHc6MAOC7kvvS7wbLfHhFvwPFLrW1eRArNcILfjkYcFquekxudBkUmH
	Gxn5RjhMzv0S9Dw==
X-Google-Smtp-Source: AGHT+IGptRBwRyeFAFBA2+g0P1j7z86UzOVILpGLTrooIezds8rCIUFaoqb12UTIFb0yzA1gPOfOgfv+XEDtAOg=
X-Received: from ziweixiao.sea.corp.google.com ([2620:15c:11c:202:43b5:fdf3:8395:a655])
 (user=ziweixiao job=sendgmr) by 2002:a17:90a:b008:b0:299:dbe9:353b with SMTP
 id x8-20020a17090ab00800b00299dbe9353bmr800pjq.9.1709241829335; Thu, 29 Feb
 2024 13:23:49 -0800 (PST)
Date: Thu, 29 Feb 2024 13:22:35 -0800
In-Reply-To: <20240229212236.3152897-1-ziweixiao@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240229212236.3152897-1-ziweixiao@google.com>
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
Message-ID: <20240229212236.3152897-3-ziweixiao@google.com>
Subject: [PATCH net-next 2/3] gve: Add header split data path
From: Ziwei Xiao <ziweixiao@google.com>
To: netdev@vger.kernel.org
Cc: jeroendb@google.com, pkaligineedi@google.com, shailend@google.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	willemb@google.com, rushilg@google.com, jfraker@google.com, jrkim@google.com, 
	hramamurthy@google.com, ziweixiao@google.com, horms@kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Jeroen de Borst <jeroendb@google.com>

Add header buffers and ethtool support to enable header split via the
tcp-data-split flag in ethtool's ringparam config. A coherent dma memory
is allocated for the header buffers. There is one header buffer per ring
entry by calculating the offset to the header-buffers starting address.
The header buffer is always copied directly into the skb and payload is
always added as frags. When there is a header buffer overflow or the
header length is 0, the driver places the whole unsplit packet in frags.

When toggling header split, the driver will call gve_adjust_config to
set its queues appropriately. If header split is enabled by the user and
the max packet buffer size is no less than 4KB, driver will set the
packet buffer size as 4KB to support TCP_ZEROCOPY_RECEIVE. Otherwise the
driver will use the default 2KB as the packet buffer size.

`ethtool -G <dev> tcp-data-split on/off` is the command to toggle header
split.
`ethtool -g <dev>` will show the status of header split with the field
of `tcp-data-split`.

Co-developed-by: Ziwei Xiao <ziweixiao@google.com>
Signed-off-by: Ziwei Xiao <ziweixiao@google.com>
Signed-off-by: Jeroen de Borst <jeroendb@google.com>
Reviewed-by: Praveen Kaligineedi <pkaligineedi@google.com>
Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
---
 drivers/net/ethernet/google/gve/gve.h         | 14 +++++
 drivers/net/ethernet/google/gve/gve_adminq.c  |  3 +
 drivers/net/ethernet/google/gve/gve_ethtool.c | 26 ++++++++-
 drivers/net/ethernet/google/gve/gve_main.c    | 57 +++++++++++++++++++
 drivers/net/ethernet/google/gve/gve_rx_dqo.c  | 57 ++++++++++++++++++-
 drivers/net/ethernet/google/gve/gve_utils.c   | 17 ++++--
 drivers/net/ethernet/google/gve/gve_utils.h   |  3 +
 7 files changed, 169 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
index 5305404516fc..5f02b87d7fea 100644
--- a/drivers/net/ethernet/google/gve/gve.h
+++ b/drivers/net/ethernet/google/gve/gve.h
@@ -9,6 +9,7 @@
 
 #include <linux/dma-mapping.h>
 #include <linux/dmapool.h>
+#include <linux/ethtool_netlink.h>
 #include <linux/netdevice.h>
 #include <linux/pci.h>
 #include <linux/u64_stats_sync.h>
@@ -154,6 +155,11 @@ struct gve_rx_compl_queue_dqo {
 	u32 mask; /* Mask for indices to the size of the ring */
 };
 
+struct gve_header_buf {
+	u8 *data;
+	dma_addr_t addr;
+};
+
 /* Stores state for tracking buffers posted to HW */
 struct gve_rx_buf_state_dqo {
 	/* The page posted to HW. */
@@ -256,6 +262,9 @@ struct gve_rx_ring {
 
 			/* track number of used buffers */
 			u16 used_buf_states_cnt;
+
+			/* Address info of the buffers for header-split */
+			struct gve_header_buf hdr_bufs;
 		} dqo;
 	};
 
@@ -668,6 +677,7 @@ struct gve_rx_alloc_rings_cfg {
 	struct gve_qpl_config *qpl_cfg;
 
 	u16 ring_size;
+	u16 packet_buffer_size;
 	bool raw_addressing;
 	bool enable_header_split;
 
@@ -792,6 +802,7 @@ struct gve_priv {
 	u32 rx_coalesce_usecs;
 
 	u16 header_buf_size; /* device configured, header-split supported if non-zero */
+	bool header_split_enabled; /* True if the header split is enabled by the user */
 };
 
 enum gve_service_task_flags_bit {
@@ -1129,6 +1140,9 @@ void gve_rx_free_rings_gqi(struct gve_priv *priv,
 			   struct gve_rx_alloc_rings_cfg *cfg);
 void gve_rx_start_ring_gqi(struct gve_priv *priv, int idx);
 void gve_rx_stop_ring_gqi(struct gve_priv *priv, int idx);
+u16 gve_get_pkt_buf_size(const struct gve_priv *priv, bool enable_hplit);
+bool gve_header_split_supported(const struct gve_priv *priv);
+int gve_set_hsplit_config(struct gve_priv *priv, u8 tcp_data_split);
 /* Reset */
 void gve_schedule_reset(struct gve_priv *priv);
 int gve_reset(struct gve_priv *priv, bool attempt_teardown);
diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/ethernet/google/gve/gve_adminq.c
index e2c27bbb56e6..ae12ac38e18b 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.c
+++ b/drivers/net/ethernet/google/gve/gve_adminq.c
@@ -659,6 +659,9 @@ static int gve_adminq_create_rx_queue(struct gve_priv *priv, u32 queue_index)
 			cpu_to_be16(rx_buff_ring_entries);
 		cmd.create_rx_queue.enable_rsc =
 			!!(priv->dev->features & NETIF_F_LRO);
+		if (priv->header_split_enabled)
+			cmd.create_rx_queue.header_buffer_size =
+				cpu_to_be16(priv->header_buf_size);
 	}
 
 	return gve_adminq_issue_cmd(priv, &cmd);
diff --git a/drivers/net/ethernet/google/gve/gve_ethtool.c b/drivers/net/ethernet/google/gve/gve_ethtool.c
index e5397aa1e48f..13c2901968e0 100644
--- a/drivers/net/ethernet/google/gve/gve_ethtool.c
+++ b/drivers/net/ethernet/google/gve/gve_ethtool.c
@@ -4,7 +4,6 @@
  * Copyright (C) 2015-2021 Google, Inc.
  */
 
-#include <linux/ethtool.h>
 #include <linux/rtnetlink.h>
 #include "gve.h"
 #include "gve_adminq.h"
@@ -480,6 +479,29 @@ static void gve_get_ringparam(struct net_device *netdev,
 	cmd->tx_max_pending = priv->tx_desc_cnt;
 	cmd->rx_pending = priv->rx_desc_cnt;
 	cmd->tx_pending = priv->tx_desc_cnt;
+
+	if (!gve_header_split_supported(priv))
+		kernel_cmd->tcp_data_split = ETHTOOL_TCP_DATA_SPLIT_UNKNOWN;
+	else if (priv->header_split_enabled)
+		kernel_cmd->tcp_data_split = ETHTOOL_TCP_DATA_SPLIT_ENABLED;
+	else
+		kernel_cmd->tcp_data_split = ETHTOOL_TCP_DATA_SPLIT_DISABLED;
+}
+
+static int gve_set_ringparam(struct net_device *netdev,
+			     struct ethtool_ringparam *cmd,
+			     struct kernel_ethtool_ringparam *kernel_cmd,
+			     struct netlink_ext_ack *extack)
+{
+	struct gve_priv *priv = netdev_priv(netdev);
+
+	if (priv->tx_desc_cnt != cmd->tx_pending ||
+	    priv->rx_desc_cnt != cmd->rx_pending) {
+		dev_info(&priv->pdev->dev, "Modify ring size is not supported.\n");
+		return -EOPNOTSUPP;
+	}
+
+	return gve_set_hsplit_config(priv, kernel_cmd->tcp_data_split);
 }
 
 static int gve_user_reset(struct net_device *netdev, u32 *flags)
@@ -655,6 +677,7 @@ static int gve_set_coalesce(struct net_device *netdev,
 
 const struct ethtool_ops gve_ethtool_ops = {
 	.supported_coalesce_params = ETHTOOL_COALESCE_USECS,
+	.supported_ring_params = ETHTOOL_RING_USE_TCP_DATA_SPLIT,
 	.get_drvinfo = gve_get_drvinfo,
 	.get_strings = gve_get_strings,
 	.get_sset_count = gve_get_sset_count,
@@ -667,6 +690,7 @@ const struct ethtool_ops gve_ethtool_ops = {
 	.get_coalesce = gve_get_coalesce,
 	.set_coalesce = gve_set_coalesce,
 	.get_ringparam = gve_get_ringparam,
+	.set_ringparam = gve_set_ringparam,
 	.reset = gve_user_reset,
 	.get_tunable = gve_get_tunable,
 	.set_tunable = gve_set_tunable,
diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index 02d12aa50885..7b89b66adb53 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -1307,9 +1307,13 @@ static void gve_rx_get_curr_alloc_cfg(struct gve_priv *priv,
 	cfg->qcfg = &priv->rx_cfg;
 	cfg->qcfg_tx = &priv->tx_cfg;
 	cfg->raw_addressing = !gve_is_qpl(priv);
+	cfg->enable_header_split = priv->header_split_enabled;
 	cfg->qpls = priv->qpls;
 	cfg->qpl_cfg = &priv->qpl_cfg;
 	cfg->ring_size = priv->rx_desc_cnt;
+	cfg->packet_buffer_size = gve_is_gqi(priv) ?
+				  GVE_DEFAULT_RX_BUFFER_SIZE :
+				  priv->data_buffer_size_dqo;
 	cfg->rx = priv->rx;
 }
 
@@ -1448,6 +1452,9 @@ static int gve_queues_start(struct gve_priv *priv,
 	if (err)
 		goto reset;
 
+	priv->header_split_enabled = rx_alloc_cfg->enable_header_split;
+	priv->data_buffer_size_dqo = rx_alloc_cfg->packet_buffer_size;
+
 	err = gve_create_rings(priv);
 	if (err)
 		goto reset;
@@ -2059,6 +2066,56 @@ static void gve_tx_timeout(struct net_device *dev, unsigned int txqueue)
 	priv->tx_timeo_cnt++;
 }
 
+u16 gve_get_pkt_buf_size(const struct gve_priv *priv, bool enable_hsplit)
+{
+	if (enable_hsplit && priv->max_rx_buffer_size >= GVE_MAX_RX_BUFFER_SIZE)
+		return GVE_MAX_RX_BUFFER_SIZE;
+	else
+		return GVE_DEFAULT_RX_BUFFER_SIZE;
+}
+
+/* header-split is not supported on non-DQO_RDA yet even if device advertises it */
+bool gve_header_split_supported(const struct gve_priv *priv)
+{
+	return priv->header_buf_size && priv->queue_format == GVE_DQO_RDA_FORMAT;
+}
+
+int gve_set_hsplit_config(struct gve_priv *priv, u8 tcp_data_split)
+{
+	struct gve_tx_alloc_rings_cfg tx_alloc_cfg = {0};
+	struct gve_rx_alloc_rings_cfg rx_alloc_cfg = {0};
+	struct gve_qpls_alloc_cfg qpls_alloc_cfg = {0};
+	bool enable_hdr_split;
+	int err = 0;
+
+	if (tcp_data_split == ETHTOOL_TCP_DATA_SPLIT_UNKNOWN)
+		return 0;
+
+	if (!gve_header_split_supported(priv)) {
+		dev_err(&priv->pdev->dev, "Header-split not supported\n");
+		return -EOPNOTSUPP;
+	}
+
+	if (tcp_data_split == ETHTOOL_TCP_DATA_SPLIT_ENABLED)
+		enable_hdr_split = true;
+	else
+		enable_hdr_split = false;
+
+	if (enable_hdr_split == priv->header_split_enabled)
+		return 0;
+
+	gve_get_curr_alloc_cfgs(priv, &qpls_alloc_cfg,
+				&tx_alloc_cfg, &rx_alloc_cfg);
+
+	rx_alloc_cfg.enable_header_split = enable_hdr_split;
+	rx_alloc_cfg.packet_buffer_size = gve_get_pkt_buf_size(priv, enable_hdr_split);
+
+	if (netif_running(priv->dev))
+		err = gve_adjust_config(priv, &qpls_alloc_cfg,
+					&tx_alloc_cfg, &rx_alloc_cfg);
+	return err;
+}
+
 static int gve_set_features(struct net_device *netdev,
 			    netdev_features_t features)
 {
diff --git a/drivers/net/ethernet/google/gve/gve_rx_dqo.c b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
index c3ce819ee5ab..a12d776d4385 100644
--- a/drivers/net/ethernet/google/gve/gve_rx_dqo.c
+++ b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
@@ -199,6 +199,18 @@ static int gve_alloc_page_dqo(struct gve_rx_ring *rx,
 	return 0;
 }
 
+static void gve_rx_free_hdr_bufs(struct gve_priv *priv, struct gve_rx_ring *rx)
+{
+	struct device *hdev = &priv->pdev->dev;
+	int buf_count = rx->dqo.bufq.mask + 1;
+
+	if (rx->dqo.hdr_bufs.data) {
+		dma_free_coherent(hdev, priv->header_buf_size * buf_count,
+				  rx->dqo.hdr_bufs.data, rx->dqo.hdr_bufs.addr);
+		rx->dqo.hdr_bufs.data = NULL;
+	}
+}
+
 void gve_rx_stop_ring_dqo(struct gve_priv *priv, int idx)
 {
 	int ntfy_idx = gve_rx_idx_to_ntfy(priv, idx);
@@ -258,9 +270,24 @@ static void gve_rx_free_ring_dqo(struct gve_priv *priv, struct gve_rx_ring *rx,
 	kvfree(rx->dqo.buf_states);
 	rx->dqo.buf_states = NULL;
 
+	gve_rx_free_hdr_bufs(priv, rx);
+
 	netif_dbg(priv, drv, priv->dev, "freed rx ring %d\n", idx);
 }
 
+static int gve_rx_alloc_hdr_bufs(struct gve_priv *priv, struct gve_rx_ring *rx)
+{
+	struct device *hdev = &priv->pdev->dev;
+	int buf_count = rx->dqo.bufq.mask + 1;
+
+	rx->dqo.hdr_bufs.data = dma_alloc_coherent(hdev, priv->header_buf_size * buf_count,
+						   &rx->dqo.hdr_bufs.addr, GFP_KERNEL);
+	if (!rx->dqo.hdr_bufs.data)
+		return -ENOMEM;
+
+	return 0;
+}
+
 void gve_rx_start_ring_dqo(struct gve_priv *priv, int idx)
 {
 	int ntfy_idx = gve_rx_idx_to_ntfy(priv, idx);
@@ -302,6 +329,11 @@ static int gve_rx_alloc_ring_dqo(struct gve_priv *priv,
 	if (!rx->dqo.buf_states)
 		return -ENOMEM;
 
+	/* Allocate header buffers for header-split */
+	if (cfg->enable_header_split)
+		if (gve_rx_alloc_hdr_bufs(priv, rx))
+			goto err;
+
 	/* Set up linked list of buffer IDs */
 	for (i = 0; i < rx->dqo.num_buf_states - 1; i++)
 		rx->dqo.buf_states[i].next = i + 1;
@@ -443,6 +475,10 @@ void gve_rx_post_buffers_dqo(struct gve_rx_ring *rx)
 		desc->buf_id = cpu_to_le16(buf_state - rx->dqo.buf_states);
 		desc->buf_addr = cpu_to_le64(buf_state->addr +
 					     buf_state->page_info.page_offset);
+		if (rx->dqo.hdr_bufs.data)
+			desc->header_buf_addr =
+				cpu_to_le64(rx->dqo.hdr_bufs.addr +
+					    priv->header_buf_size * bufq->tail);
 
 		bufq->tail = (bufq->tail + 1) & bufq->mask;
 		complq->num_free_slots--;
@@ -645,13 +681,16 @@ static int gve_rx_append_frags(struct napi_struct *napi,
  */
 static int gve_rx_dqo(struct napi_struct *napi, struct gve_rx_ring *rx,
 		      const struct gve_rx_compl_desc_dqo *compl_desc,
-		      int queue_idx)
+		      u32 desc_idx, int queue_idx)
 {
 	const u16 buffer_id = le16_to_cpu(compl_desc->buf_id);
+	const bool hbo = compl_desc->header_buffer_overflow;
 	const bool eop = compl_desc->end_of_packet != 0;
+	const bool hsplit = compl_desc->split_header;
 	struct gve_rx_buf_state_dqo *buf_state;
 	struct gve_priv *priv = rx->gve;
 	u16 buf_len;
+	u16 hdr_len;
 
 	if (unlikely(buffer_id >= rx->dqo.num_buf_states)) {
 		net_err_ratelimited("%s: Invalid RX buffer_id=%u\n",
@@ -672,12 +711,26 @@ static int gve_rx_dqo(struct napi_struct *napi, struct gve_rx_ring *rx,
 	}
 
 	buf_len = compl_desc->packet_len;
+	hdr_len = compl_desc->header_len;
 
 	/* Page might have not been used for awhile and was likely last written
 	 * by a different thread.
 	 */
 	prefetch(buf_state->page_info.page);
 
+	/* Copy the header into the skb in the case of header split */
+	if (hsplit) {
+		if (hdr_len && !hbo) {
+			rx->ctx.skb_head = gve_rx_copy_data(priv->dev, napi,
+							    rx->dqo.hdr_bufs.data +
+							    desc_idx * priv->header_buf_size,
+							    hdr_len);
+			if (unlikely(!rx->ctx.skb_head))
+				goto error;
+			rx->ctx.skb_tail = rx->ctx.skb_head;
+		}
+	}
+
 	/* Sync the portion of dma buffer for CPU to read. */
 	dma_sync_single_range_for_cpu(&priv->pdev->dev, buf_state->addr,
 				      buf_state->page_info.page_offset,
@@ -820,7 +873,7 @@ int gve_rx_poll_dqo(struct gve_notify_block *block, int budget)
 		/* Do not read data until we own the descriptor */
 		dma_rmb();
 
-		err = gve_rx_dqo(napi, rx, compl_desc, rx->q_num);
+		err = gve_rx_dqo(napi, rx, compl_desc, complq->head, rx->q_num);
 		if (err < 0) {
 			gve_rx_free_skb(rx);
 			u64_stats_update_begin(&rx->statss);
diff --git a/drivers/net/ethernet/google/gve/gve_utils.c b/drivers/net/ethernet/google/gve/gve_utils.c
index 535b1796b91d..2349750075a5 100644
--- a/drivers/net/ethernet/google/gve/gve_utils.c
+++ b/drivers/net/ethernet/google/gve/gve_utils.c
@@ -64,11 +64,9 @@ void gve_rx_add_to_block(struct gve_priv *priv, int queue_idx)
 	rx->ntfy_id = ntfy_idx;
 }
 
-struct sk_buff *gve_rx_copy(struct net_device *dev, struct napi_struct *napi,
-			    struct gve_rx_slot_page_info *page_info, u16 len)
+struct sk_buff *gve_rx_copy_data(struct net_device *dev, struct napi_struct *napi,
+				 u8 *data, u16 len)
 {
-	void *va = page_info->page_address + page_info->page_offset +
-		page_info->pad;
 	struct sk_buff *skb;
 
 	skb = napi_alloc_skb(napi, len);
@@ -76,12 +74,21 @@ struct sk_buff *gve_rx_copy(struct net_device *dev, struct napi_struct *napi,
 		return NULL;
 
 	__skb_put(skb, len);
-	skb_copy_to_linear_data_offset(skb, 0, va, len);
+	skb_copy_to_linear_data_offset(skb, 0, data, len);
 	skb->protocol = eth_type_trans(skb, dev);
 
 	return skb;
 }
 
+struct sk_buff *gve_rx_copy(struct net_device *dev, struct napi_struct *napi,
+			    struct gve_rx_slot_page_info *page_info, u16 len)
+{
+	void *va = page_info->page_address + page_info->page_offset +
+		page_info->pad;
+
+	return gve_rx_copy_data(dev, napi, va, len);
+}
+
 void gve_dec_pagecnt_bias(struct gve_rx_slot_page_info *page_info)
 {
 	page_info->pagecnt_bias--;
diff --git a/drivers/net/ethernet/google/gve/gve_utils.h b/drivers/net/ethernet/google/gve/gve_utils.h
index 277921a629f7..bf2e9a0adb36 100644
--- a/drivers/net/ethernet/google/gve/gve_utils.h
+++ b/drivers/net/ethernet/google/gve/gve_utils.h
@@ -19,6 +19,9 @@ bool gve_rx_was_added_to_block(struct gve_priv *priv, int queue_idx);
 void gve_rx_remove_from_block(struct gve_priv *priv, int queue_idx);
 void gve_rx_add_to_block(struct gve_priv *priv, int queue_idx);
 
+struct sk_buff *gve_rx_copy_data(struct net_device *dev, struct napi_struct *napi,
+				 u8 *data, u16 len);
+
 struct sk_buff *gve_rx_copy(struct net_device *dev, struct napi_struct *napi,
 			    struct gve_rx_slot_page_info *page_info, u16 len);
 
-- 
2.44.0.rc1.240.g4c46232300-goog


