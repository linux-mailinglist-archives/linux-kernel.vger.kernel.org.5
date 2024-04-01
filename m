Return-Path: <linux-kernel+bounces-127201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 858318947EE
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 01:48:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8AA91C21CBE
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 23:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26DFC5FDB5;
	Mon,  1 Apr 2024 23:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IW+B6EP/"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AFC95F874
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 23:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712015146; cv=none; b=avoR2brDg6T3maR5QxcVdmRJTqikn8jzx9BP5bVNE59aZ5ZuCSWmp+Gluv0kRWP/xQTxPf0Lcu3m5JbdUKbS/oC5Q7iyG7QC19kBEPhhKD4wClF+Z2Z3QuoHjc6hy6yvVqJRQ254tmEKS9aCTMx9pQyEGH33KTGmNwiW4rbGWic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712015146; c=relaxed/simple;
	bh=T+r5MN0wKWkjv/eITFuRd7ZDeIMaevp8ktEOAZXCBSo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MS9mp6otDU0/prHQmo5A5tDx0LWZFvSgwjVHmiPo1B0Wup4UUV7UTQRL9lFlWZsime3v5GUTqr1Zo+NbvOfcofhRJp7FfOr8GqSVecLgaHiwixGakUaPuRuCW5+RHssqEH1das5cwsQLx8QfWiTX6XAHv9tHKw5CyWwX0VRV438=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IW+B6EP/; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-6ea81b74262so3945481b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2024 16:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712015143; x=1712619943; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7x9CpIazFdTR4Zq3OOfIkhN9CyfFJTEzyO4IvebVf/Y=;
        b=IW+B6EP/KzkT/1xOdGTZWGpsj48V86ugK8ezpTTkNghksVQfX00BrG8uUb7mGUGN9X
         8KymasS3cnoqtWUjHOtiHtXaXPISV2e81fpow4/9EbRS5DETdfYSUSlb8VluUuNcjopR
         Fc2OHX3zuc+kuNwpRd4aNvM7IEg5QkHH4o8G/eA+Tv5bp/+xO1Skdc5w9/py6jhOZQfh
         RK54qVIbShzhnMlCRidKcr3+RygcSIuUfyCKJv3ddMnOUJTuMR4C4SS+TwdssTgNdZXj
         z/Zte+VkNye7x8rdnTjzyP1v83/0svRlMxIn6gDPJcqZ55YGIQXtLGxRr1p594LodUVq
         qEjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712015143; x=1712619943;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7x9CpIazFdTR4Zq3OOfIkhN9CyfFJTEzyO4IvebVf/Y=;
        b=k87y7hEdjBN6CM6VDDyoqUR/hpp4PyETg6JmwgGAzib8jTrmHwpZL3YLMrv5YxceHE
         C6B/lMHoxcUmJGGRUHCtoCpNqcHfgiGkLifbzXFdrEnLL1x8/cEHQWpbz7/V8EhjHzWj
         g1OqvN/n9YV5Yig56G74v3pXWuDA29jIH++jt/PGprNM8fEjklSVbv4qWX1s1iSFIPVc
         WxoU6UtTjw49Gsf5fBSDl+q3Pam2Rsaiio6NwPM46I0T2vMCX7XMK+bJdSAU/lQ5gNUG
         +SbumZZ+vVwB09WCAB7JhPOSbYJ2igZa8bGLql7XMrJWMYRKNfhnQAwSVy0emP27Tg1p
         /bkQ==
X-Forwarded-Encrypted: i=1; AJvYcCWYP4fIFATwt2+F+TdpYPAMz6lUvp8uqUMcronJ/s5riJXfEBlt1/UBnqvz4bww4ihEHmWrGl2uxgME25DQMyUizrPlLUph/zSXfiRf
X-Gm-Message-State: AOJu0YwHvYzU7eVW4JiD3unvRCcaqJS4n3gtoAdtGo59MxwZl6MAyNTX
	gfrIMyDSF60k0BdSYDp0a2yLiovO2Joo5vaXGohjsH9S1+0igpm7mqHZ4pReKXfezQVVwiapIRh
	cGgdD8vflFu7MEXjjftthOg==
X-Google-Smtp-Source: AGHT+IHxXT/yLL2cd2rNrldpnEy/7nGDMyQzRcgHUJLn8ajOjZ2fO60/quZkbOYxInCtgd4AjE3Y9oES7raKn1ME0A==
X-Received: from hramamurthy-gve.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:141e])
 (user=hramamurthy job=sendgmr) by 2002:a05:6a00:a1c:b0:6e6:b9a8:5ce8 with
 SMTP id p28-20020a056a000a1c00b006e6b9a85ce8mr252030pfh.6.1712015143610; Mon,
 01 Apr 2024 16:45:43 -0700 (PDT)
Date: Mon,  1 Apr 2024 23:45:30 +0000
In-Reply-To: <20240401234530.3101900-1-hramamurthy@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240401234530.3101900-1-hramamurthy@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240401234530.3101900-6-hramamurthy@google.com>
Subject: [PATCH net-next 5/5] gve: add support to change ring size via ethtool
From: Harshitha Ramamurthy <hramamurthy@google.com>
To: netdev@vger.kernel.org
Cc: jeroendb@google.com, pkaligineedi@google.com, shailend@google.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	willemb@google.com, rushilg@google.com, jfraker@google.com, 
	linux-kernel@vger.kernel.org, Harshitha Ramamurthy <hramamurthy@google.com>
Content-Type: text/plain; charset="UTF-8"

Allow the user to change ring size via ethtool if
supported by the device. The driver relies on the
ring size ranges queried from device to validate
ring sizes requested by the user.

Reviewed-by: Praveen Kaligineedi <pkaligineedi@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
---
 drivers/net/ethernet/google/gve/gve.h         |  8 ++
 drivers/net/ethernet/google/gve/gve_ethtool.c | 85 +++++++++++++++++--
 drivers/net/ethernet/google/gve/gve_main.c    | 16 ++--
 3 files changed, 95 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
index 669cacdae4f4..e97633b68e25 100644
--- a/drivers/net/ethernet/google/gve/gve.h
+++ b/drivers/net/ethernet/google/gve/gve.h
@@ -1159,6 +1159,14 @@ int gve_set_hsplit_config(struct gve_priv *priv, u8 tcp_data_split);
 /* Reset */
 void gve_schedule_reset(struct gve_priv *priv);
 int gve_reset(struct gve_priv *priv, bool attempt_teardown);
+void gve_get_curr_alloc_cfgs(struct gve_priv *priv,
+			     struct gve_qpls_alloc_cfg *qpls_alloc_cfg,
+			     struct gve_tx_alloc_rings_cfg *tx_alloc_cfg,
+			     struct gve_rx_alloc_rings_cfg *rx_alloc_cfg);
+int gve_adjust_config(struct gve_priv *priv,
+		      struct gve_qpls_alloc_cfg *qpls_alloc_cfg,
+		      struct gve_tx_alloc_rings_cfg *tx_alloc_cfg,
+		      struct gve_rx_alloc_rings_cfg *rx_alloc_cfg);
 int gve_adjust_queues(struct gve_priv *priv,
 		      struct gve_queue_config new_rx_config,
 		      struct gve_queue_config new_tx_config);
diff --git a/drivers/net/ethernet/google/gve/gve_ethtool.c b/drivers/net/ethernet/google/gve/gve_ethtool.c
index dbe05402d40b..815dead31673 100644
--- a/drivers/net/ethernet/google/gve/gve_ethtool.c
+++ b/drivers/net/ethernet/google/gve/gve_ethtool.c
@@ -490,8 +490,8 @@ static void gve_get_ringparam(struct net_device *netdev,
 {
 	struct gve_priv *priv = netdev_priv(netdev);
 
-	cmd->rx_max_pending = priv->rx_desc_cnt;
-	cmd->tx_max_pending = priv->tx_desc_cnt;
+	cmd->rx_max_pending = priv->max_rx_desc_cnt;
+	cmd->tx_max_pending = priv->max_tx_desc_cnt;
 	cmd->rx_pending = priv->rx_desc_cnt;
 	cmd->tx_pending = priv->tx_desc_cnt;
 
@@ -503,20 +503,93 @@ static void gve_get_ringparam(struct net_device *netdev,
 		kernel_cmd->tcp_data_split = ETHTOOL_TCP_DATA_SPLIT_DISABLED;
 }
 
+static int gve_adjust_ring_sizes(struct gve_priv *priv,
+				 u16 new_tx_desc_cnt,
+				 u16 new_rx_desc_cnt)
+{
+	struct gve_tx_alloc_rings_cfg tx_alloc_cfg = {0};
+	struct gve_rx_alloc_rings_cfg rx_alloc_cfg = {0};
+	struct gve_qpls_alloc_cfg qpls_alloc_cfg = {0};
+	struct gve_qpl_config new_qpl_cfg;
+	int err;
+
+	/* get current queue configuration */
+	gve_get_curr_alloc_cfgs(priv, &qpls_alloc_cfg,
+				&tx_alloc_cfg, &rx_alloc_cfg);
+
+	/* copy over the new ring_size from ethtool */
+	tx_alloc_cfg.ring_size = new_tx_desc_cnt;
+	rx_alloc_cfg.ring_size = new_rx_desc_cnt;
+
+	/* qpl_cfg is not read-only, it contains a map that gets updated as
+	 * rings are allocated, which is why we cannot use the yet unreleased
+	 * one in priv.
+	 */
+	qpls_alloc_cfg.qpl_cfg = &new_qpl_cfg;
+	tx_alloc_cfg.qpl_cfg = &new_qpl_cfg;
+	rx_alloc_cfg.qpl_cfg = &new_qpl_cfg;
+
+	if (netif_running(priv->dev)) {
+		err = gve_adjust_config(priv, &qpls_alloc_cfg,
+					&tx_alloc_cfg, &rx_alloc_cfg);
+		if (err)
+			return err;
+	}
+
+	/* Set new ring_size for the next up */
+	priv->tx_desc_cnt = new_tx_desc_cnt;
+	priv->rx_desc_cnt = new_rx_desc_cnt;
+
+	return 0;
+}
+
+static int gve_validate_req_ring_size(struct gve_priv *priv, u16 new_tx_desc_cnt,
+				      u16 new_rx_desc_cnt)
+{
+	/* check for valid range */
+	if (new_tx_desc_cnt < priv->min_tx_desc_cnt ||
+	    new_tx_desc_cnt > priv->max_tx_desc_cnt ||
+	    new_rx_desc_cnt < priv->min_rx_desc_cnt ||
+	    new_rx_desc_cnt > priv->max_rx_desc_cnt) {
+		dev_err(&priv->pdev->dev, "Requested descriptor count out of range\n");
+		return -EINVAL;
+	}
+
+	if (!is_power_of_2(new_tx_desc_cnt) || !is_power_of_2(new_rx_desc_cnt)) {
+		dev_err(&priv->pdev->dev, "Requested descriptor count has to be a power of 2\n");
+		return -EINVAL;
+	}
+	return 0;
+}
+
 static int gve_set_ringparam(struct net_device *netdev,
 			     struct ethtool_ringparam *cmd,
 			     struct kernel_ethtool_ringparam *kernel_cmd,
 			     struct netlink_ext_ack *extack)
 {
 	struct gve_priv *priv = netdev_priv(netdev);
+	u16 new_tx_cnt, new_rx_cnt;
+	int err;
+
+	err = gve_set_hsplit_config(priv, kernel_cmd->tcp_data_split);
+	if (err)
+		return err;
 
-	if (priv->tx_desc_cnt != cmd->tx_pending ||
-	    priv->rx_desc_cnt != cmd->rx_pending) {
-		dev_info(&priv->pdev->dev, "Modify ring size is not supported.\n");
+	if (cmd->tx_pending == priv->tx_desc_cnt && cmd->rx_pending == priv->rx_desc_cnt)
+		return 0;
+
+	if (!priv->modify_ring_size_enabled) {
+		dev_err(&priv->pdev->dev, "Modify ring size is not supported.\n");
 		return -EOPNOTSUPP;
 	}
 
-	return gve_set_hsplit_config(priv, kernel_cmd->tcp_data_split);
+	new_tx_cnt = cmd->tx_pending;
+	new_rx_cnt = cmd->rx_pending;
+
+	if (gve_validate_req_ring_size(priv, new_tx_cnt, new_rx_cnt))
+		return -EINVAL;
+
+	return gve_adjust_ring_sizes(priv, new_tx_cnt, new_rx_cnt);
 }
 
 static int gve_user_reset(struct net_device *netdev, u32 *flags)
diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index 470447c0490f..a515e5af843c 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -1314,10 +1314,10 @@ static void gve_rx_get_curr_alloc_cfg(struct gve_priv *priv,
 	cfg->rx = priv->rx;
 }
 
-static void gve_get_curr_alloc_cfgs(struct gve_priv *priv,
-				    struct gve_qpls_alloc_cfg *qpls_alloc_cfg,
-				    struct gve_tx_alloc_rings_cfg *tx_alloc_cfg,
-				    struct gve_rx_alloc_rings_cfg *rx_alloc_cfg)
+void gve_get_curr_alloc_cfgs(struct gve_priv *priv,
+			     struct gve_qpls_alloc_cfg *qpls_alloc_cfg,
+			     struct gve_tx_alloc_rings_cfg *tx_alloc_cfg,
+			     struct gve_rx_alloc_rings_cfg *rx_alloc_cfg)
 {
 	gve_qpls_get_curr_alloc_cfg(priv, qpls_alloc_cfg);
 	gve_tx_get_curr_alloc_cfg(priv, tx_alloc_cfg);
@@ -1867,10 +1867,10 @@ static int gve_xdp(struct net_device *dev, struct netdev_bpf *xdp)
 	}
 }
 
-static int gve_adjust_config(struct gve_priv *priv,
-			     struct gve_qpls_alloc_cfg *qpls_alloc_cfg,
-			     struct gve_tx_alloc_rings_cfg *tx_alloc_cfg,
-			     struct gve_rx_alloc_rings_cfg *rx_alloc_cfg)
+int gve_adjust_config(struct gve_priv *priv,
+		      struct gve_qpls_alloc_cfg *qpls_alloc_cfg,
+		      struct gve_tx_alloc_rings_cfg *tx_alloc_cfg,
+		      struct gve_rx_alloc_rings_cfg *rx_alloc_cfg)
 {
 	int err;
 
-- 
2.44.0.478.gd926399ef9-goog


