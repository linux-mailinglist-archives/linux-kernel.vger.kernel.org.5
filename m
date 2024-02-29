Return-Path: <linux-kernel+bounces-87577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A1486D61B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 22:24:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4510DB218F0
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 21:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E65E574C0A;
	Thu, 29 Feb 2024 21:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H78YpcgH"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4694074BF2
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 21:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709241836; cv=none; b=uqqdBNicEzLkr5zs/Gu1m1+xgRjC7ulFMawL4Xz+1ulL7JXCsky5MJqGgEAD+6XndoH3b/p9+6TUQ8uACq7q9CJWJlbRxXevM+WHQIiH0pfeMeMa8xae8j0ByQl3MJatKNovB7+58g2fCW7uBxd0OOklfnoiu88El3/W31q14ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709241836; c=relaxed/simple;
	bh=nNRYs43CNcjZoviggESxp1eEDgYULA6gB+/AuIQtI1c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uCZKVQlrknQ2XgHVtNsxgfg82/3YJ2yxNwFEdxf5xuGcDX6Fv9odsLTrIbPfgQcTfy/TjlWW/N5HYobn/6k4/AeMBysaMKR6KpKrKB/2hWv7akv++iC4jr+4KQOqX2oM+Sb1akzKMYALqrcl7IX5QT80pkuvsWyJB4o+jvogSeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ziweixiao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H78YpcgH; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ziweixiao.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-1dcabec8fddso14927875ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 13:23:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709241835; x=1709846635; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Xurr9IMa0IOArYf8o+P8T4vB1IGhQ03rSgtQlkyp0BA=;
        b=H78YpcgHFoH4ndfLUAoWlauvyQHEotP4s7YBjdwDu16F5npy+5GwSQsR4sYhH+L9jb
         849Bk7YgevtElm+2fhInoHzLI+2MwgbxD9F0X3eODveO/iowNjBpck90C+6z3sXuX3Wv
         5jz/kn6OE80FMzjQys7icSC+oYCQ+qVd8fCN3z4CBGWvdn8ymES3NPoRVTosu2RuSDGP
         eSRFhJKA6jsUitOKA7A1pZpPeow6m7rNC+fkxlmJQqTp/flUwkFmUvnRtsji3ibExLvS
         IwqSSmq7N197x1Fo957JQVaLepuYizNpPJWfAywaosqXTLzHWgpOpH4HeWYDhwtsGQ/7
         x2Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709241835; x=1709846635;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xurr9IMa0IOArYf8o+P8T4vB1IGhQ03rSgtQlkyp0BA=;
        b=ex//xDPlqThCS6/qMxYP1oaQWcSocYGAcrQn5bIUtDuzy1degUlw6ndniLjPb3iSEL
         IfgjUJ7EDES9v7yGtaz6GB4YQiE4QsxAoi1jYdRgIHIAhjKbGcvQFwWfgU5AEE0J6Dx4
         bGqVqZ0EjfOCOuTrXklOTGmENyua8jfurpAbqv0rDuJ4FgYWbk5JpicP/MB1yxgcmq3M
         +5u94IYKRdnewIIQcsu2BCK1zLioO+hH4csJd08LJi5EAJzIlnisf/y9mCkSHu5K86xI
         A9amUJs8P98fhmge5k2WnmxsOe/bIA1H3gETb6l9h6SdFjhJVUEKHumuGAS074naF5D9
         oQ0Q==
X-Forwarded-Encrypted: i=1; AJvYcCWR+OrtDpfLxpH4sBmrHHQNxidO7UMxi55P+kpbfOa4TuxQ/1L9HnCTlRKxP6IV6qzpmK3QwHpplwPn9cFgRY3UDVvML+3BcYOdE9oz
X-Gm-Message-State: AOJu0Yxpq0n6RH6Z139OxMJsgtrUto/avP2ZbOvoQ/+yVIYKF15q62TS
	aR++dBPsatE2nXuAq/bZ8zcPj8JFlR3mWNsu1ZkHJRqOcUKeF3bxK52a1zMJz2T+/OMRKEjlrVD
	QP0OTnr6nnUZT4A==
X-Google-Smtp-Source: AGHT+IFqt3ldMw/BECjjDJSaPfiP+LaU5TVxhqmyrd602FhAkoxoBUMbcgz9vHF9/uD0bShCkGFAHIbt2S4AW+U=
X-Received: from ziweixiao.sea.corp.google.com ([2620:15c:11c:202:43b5:fdf3:8395:a655])
 (user=ziweixiao job=sendgmr) by 2002:a17:902:da8c:b0:1db:b8a6:dbb2 with SMTP
 id j12-20020a170902da8c00b001dbb8a6dbb2mr61212plx.13.1709241834615; Thu, 29
 Feb 2024 13:23:54 -0800 (PST)
Date: Thu, 29 Feb 2024 13:22:36 -0800
In-Reply-To: <20240229212236.3152897-1-ziweixiao@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240229212236.3152897-1-ziweixiao@google.com>
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
Message-ID: <20240229212236.3152897-4-ziweixiao@google.com>
Subject: [PATCH net-next 3/3] gve: Add header split ethtool stats
From: Ziwei Xiao <ziweixiao@google.com>
To: netdev@vger.kernel.org
Cc: jeroendb@google.com, pkaligineedi@google.com, shailend@google.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	willemb@google.com, rushilg@google.com, jfraker@google.com, jrkim@google.com, 
	hramamurthy@google.com, ziweixiao@google.com, horms@kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Jeroen de Borst <jeroendb@google.com>

To record the stats of header split packets, three stats are added in
the driver's ethtool stats.

- rx_hsplit_pkt is the split packets count with header split
- rx_hsplit_bytes is the received header bytes count with header split
- rx_hsplit_unsplit_pkt is the unsplit packet count due to header buffer
  overflow or zero header length when header split is enabled

Currently, it's entering the stats_update critical section more than
once per packet. We have plans to avoid that in the future change to let
all the stats_update happen in one place at the end of
`gve_rx_poll_dqo`.

Co-developed-by: Ziwei Xiao <ziweixiao@google.com>
Signed-off-by: Ziwei Xiao <ziweixiao@google.com>
Signed-off-by: Jeroen de Borst <jeroendb@google.com>
Reviewed-by: Praveen Kaligineedi <pkaligineedi@google.com>
Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
---
 drivers/net/ethernet/google/gve/gve.h         |  4 +++
 drivers/net/ethernet/google/gve/gve_ethtool.c | 36 +++++++++++++------
 drivers/net/ethernet/google/gve/gve_rx_dqo.c  |  9 +++++
 3 files changed, 38 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
index 5f02b87d7fea..4814c96d5fe7 100644
--- a/drivers/net/ethernet/google/gve/gve.h
+++ b/drivers/net/ethernet/google/gve/gve.h
@@ -269,15 +269,19 @@ struct gve_rx_ring {
 	};
 
 	u64 rbytes; /* free-running bytes received */
+	u64 rx_hsplit_bytes; /* free-running header bytes received */
 	u64 rpackets; /* free-running packets received */
 	u32 cnt; /* free-running total number of completed packets */
 	u32 fill_cnt; /* free-running total number of descs and buffs posted */
 	u32 mask; /* masks the cnt and fill_cnt to the size of the ring */
+	u64 rx_hsplit_pkt; /* free-running packets with headers split */
 	u64 rx_copybreak_pkt; /* free-running count of copybreak packets */
 	u64 rx_copied_pkt; /* free-running total number of copied packets */
 	u64 rx_skb_alloc_fail; /* free-running count of skb alloc fails */
 	u64 rx_buf_alloc_fail; /* free-running count of buffer alloc fails */
 	u64 rx_desc_err_dropped_pkt; /* free-running count of packets dropped by descriptor error */
+	/* free-running count of unsplit packets due to header buffer overflow or hdr_len is 0 */
+	u64 rx_hsplit_unsplit_pkt;
 	u64 rx_cont_packet_cnt; /* free-running multi-fragment packets received */
 	u64 rx_frag_flip_cnt; /* free-running count of rx segments where page_flip was used */
 	u64 rx_frag_copy_cnt; /* free-running count of rx segments copied */
diff --git a/drivers/net/ethernet/google/gve/gve_ethtool.c b/drivers/net/ethernet/google/gve/gve_ethtool.c
index 13c2901968e0..9aebfb843d9d 100644
--- a/drivers/net/ethernet/google/gve/gve_ethtool.c
+++ b/drivers/net/ethernet/google/gve/gve_ethtool.c
@@ -39,17 +39,18 @@ static u32 gve_get_msglevel(struct net_device *netdev)
  * as declared in enum xdp_action inside file uapi/linux/bpf.h .
  */
 static const char gve_gstrings_main_stats[][ETH_GSTRING_LEN] = {
-	"rx_packets", "tx_packets", "rx_bytes", "tx_bytes",
-	"rx_dropped", "tx_dropped", "tx_timeouts",
+	"rx_packets", "rx_hsplit_pkt", "tx_packets", "rx_bytes",
+	"tx_bytes", "rx_dropped", "tx_dropped", "tx_timeouts",
 	"rx_skb_alloc_fail", "rx_buf_alloc_fail", "rx_desc_err_dropped_pkt",
+	"rx_hsplit_unsplit_pkt",
 	"interface_up_cnt", "interface_down_cnt", "reset_cnt",
 	"page_alloc_fail", "dma_mapping_error", "stats_report_trigger_cnt",
 };
 
 static const char gve_gstrings_rx_stats[][ETH_GSTRING_LEN] = {
-	"rx_posted_desc[%u]", "rx_completed_desc[%u]", "rx_consumed_desc[%u]", "rx_bytes[%u]",
-	"rx_cont_packet_cnt[%u]", "rx_frag_flip_cnt[%u]", "rx_frag_copy_cnt[%u]",
-	"rx_frag_alloc_cnt[%u]",
+	"rx_posted_desc[%u]", "rx_completed_desc[%u]", "rx_consumed_desc[%u]",
+	"rx_bytes[%u]", "rx_hsplit_bytes[%u]", "rx_cont_packet_cnt[%u]",
+	"rx_frag_flip_cnt[%u]", "rx_frag_copy_cnt[%u]", "rx_frag_alloc_cnt[%u]",
 	"rx_dropped_pkt[%u]", "rx_copybreak_pkt[%u]", "rx_copied_pkt[%u]",
 	"rx_queue_drop_cnt[%u]", "rx_no_buffers_posted[%u]",
 	"rx_drops_packet_over_mru[%u]", "rx_drops_invalid_checksum[%u]",
@@ -153,11 +154,13 @@ static void
 gve_get_ethtool_stats(struct net_device *netdev,
 		      struct ethtool_stats *stats, u64 *data)
 {
-	u64 tmp_rx_pkts, tmp_rx_bytes, tmp_rx_skb_alloc_fail,
-		tmp_rx_buf_alloc_fail, tmp_rx_desc_err_dropped_pkt,
+	u64 tmp_rx_pkts, tmp_rx_hsplit_pkt, tmp_rx_bytes, tmp_rx_hsplit_bytes,
+		tmp_rx_skb_alloc_fail, tmp_rx_buf_alloc_fail,
+		tmp_rx_desc_err_dropped_pkt, tmp_rx_hsplit_unsplit_pkt,
 		tmp_tx_pkts, tmp_tx_bytes;
-	u64 rx_buf_alloc_fail, rx_desc_err_dropped_pkt, rx_pkts,
-		rx_skb_alloc_fail, rx_bytes, tx_pkts, tx_bytes, tx_dropped;
+	u64 rx_buf_alloc_fail, rx_desc_err_dropped_pkt, rx_hsplit_unsplit_pkt,
+		rx_pkts, rx_hsplit_pkt, rx_skb_alloc_fail, rx_bytes, tx_pkts, tx_bytes,
+		tx_dropped;
 	int stats_idx, base_stats_idx, max_stats_idx;
 	struct stats *report_stats;
 	int *rx_qid_to_stats_idx;
@@ -184,8 +187,10 @@ gve_get_ethtool_stats(struct net_device *netdev,
 		kfree(rx_qid_to_stats_idx);
 		return;
 	}
-	for (rx_pkts = 0, rx_bytes = 0, rx_skb_alloc_fail = 0,
-	     rx_buf_alloc_fail = 0, rx_desc_err_dropped_pkt = 0, ring = 0;
+	for (rx_pkts = 0, rx_bytes = 0, rx_hsplit_pkt = 0,
+	     rx_skb_alloc_fail = 0, rx_buf_alloc_fail = 0,
+	     rx_desc_err_dropped_pkt = 0, rx_hsplit_unsplit_pkt = 0,
+	     ring = 0;
 	     ring < priv->rx_cfg.num_queues; ring++) {
 		if (priv->rx) {
 			do {
@@ -194,18 +199,23 @@ gve_get_ethtool_stats(struct net_device *netdev,
 				start =
 				  u64_stats_fetch_begin(&priv->rx[ring].statss);
 				tmp_rx_pkts = rx->rpackets;
+				tmp_rx_hsplit_pkt = rx->rx_hsplit_pkt;
 				tmp_rx_bytes = rx->rbytes;
 				tmp_rx_skb_alloc_fail = rx->rx_skb_alloc_fail;
 				tmp_rx_buf_alloc_fail = rx->rx_buf_alloc_fail;
 				tmp_rx_desc_err_dropped_pkt =
 					rx->rx_desc_err_dropped_pkt;
+				tmp_rx_hsplit_unsplit_pkt =
+					rx->rx_hsplit_unsplit_pkt;
 			} while (u64_stats_fetch_retry(&priv->rx[ring].statss,
 						       start));
 			rx_pkts += tmp_rx_pkts;
+			rx_hsplit_pkt += tmp_rx_hsplit_pkt;
 			rx_bytes += tmp_rx_bytes;
 			rx_skb_alloc_fail += tmp_rx_skb_alloc_fail;
 			rx_buf_alloc_fail += tmp_rx_buf_alloc_fail;
 			rx_desc_err_dropped_pkt += tmp_rx_desc_err_dropped_pkt;
+			rx_hsplit_unsplit_pkt += tmp_rx_hsplit_unsplit_pkt;
 		}
 	}
 	for (tx_pkts = 0, tx_bytes = 0, tx_dropped = 0, ring = 0;
@@ -226,6 +236,7 @@ gve_get_ethtool_stats(struct net_device *netdev,
 
 	i = 0;
 	data[i++] = rx_pkts;
+	data[i++] = rx_hsplit_pkt;
 	data[i++] = tx_pkts;
 	data[i++] = rx_bytes;
 	data[i++] = tx_bytes;
@@ -237,6 +248,7 @@ gve_get_ethtool_stats(struct net_device *netdev,
 	data[i++] = rx_skb_alloc_fail;
 	data[i++] = rx_buf_alloc_fail;
 	data[i++] = rx_desc_err_dropped_pkt;
+	data[i++] = rx_hsplit_unsplit_pkt;
 	data[i++] = priv->interface_up_cnt;
 	data[i++] = priv->interface_down_cnt;
 	data[i++] = priv->reset_cnt;
@@ -276,6 +288,7 @@ gve_get_ethtool_stats(struct net_device *netdev,
 				start =
 				  u64_stats_fetch_begin(&priv->rx[ring].statss);
 				tmp_rx_bytes = rx->rbytes;
+				tmp_rx_hsplit_bytes = rx->rx_hsplit_bytes;
 				tmp_rx_skb_alloc_fail = rx->rx_skb_alloc_fail;
 				tmp_rx_buf_alloc_fail = rx->rx_buf_alloc_fail;
 				tmp_rx_desc_err_dropped_pkt =
@@ -283,6 +296,7 @@ gve_get_ethtool_stats(struct net_device *netdev,
 			} while (u64_stats_fetch_retry(&priv->rx[ring].statss,
 						       start));
 			data[i++] = tmp_rx_bytes;
+			data[i++] = tmp_rx_hsplit_bytes;
 			data[i++] = rx->rx_cont_packet_cnt;
 			data[i++] = rx->rx_frag_flip_cnt;
 			data[i++] = rx->rx_frag_copy_cnt;
diff --git a/drivers/net/ethernet/google/gve/gve_rx_dqo.c b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
index a12d776d4385..8e8071308aeb 100644
--- a/drivers/net/ethernet/google/gve/gve_rx_dqo.c
+++ b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
@@ -720,6 +720,8 @@ static int gve_rx_dqo(struct napi_struct *napi, struct gve_rx_ring *rx,
 
 	/* Copy the header into the skb in the case of header split */
 	if (hsplit) {
+		int unsplit = 0;
+
 		if (hdr_len && !hbo) {
 			rx->ctx.skb_head = gve_rx_copy_data(priv->dev, napi,
 							    rx->dqo.hdr_bufs.data +
@@ -728,7 +730,14 @@ static int gve_rx_dqo(struct napi_struct *napi, struct gve_rx_ring *rx,
 			if (unlikely(!rx->ctx.skb_head))
 				goto error;
 			rx->ctx.skb_tail = rx->ctx.skb_head;
+		} else {
+			unsplit = 1;
 		}
+		u64_stats_update_begin(&rx->statss);
+		rx->rx_hsplit_pkt++;
+		rx->rx_hsplit_unsplit_pkt += unsplit;
+		rx->rx_hsplit_bytes += hdr_len;
+		u64_stats_update_end(&rx->statss);
 	}
 
 	/* Sync the portion of dma buffer for CPU to read. */
-- 
2.44.0.rc1.240.g4c46232300-goog


