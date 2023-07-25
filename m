Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D7DC762402
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 22:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231341AbjGYU53 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 16:57:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231262AbjGYU5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 16:57:24 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC4841988
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 13:57:22 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-99364ae9596so1011903166b.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 13:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1690318641; x=1690923441;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SZaam7kr0RM2wvFpQkpovBqoJNVqtgLNS4lSsOVsnM0=;
        b=lPILFNe6iyP6sPc9zZXqtkD+ivwxJMiLysrJkPdoYQMn9aUoUR2L+BdedOAO6wrWeb
         nJgu5Pj2uLdy0yE7AfOGoETN3LnBIfii7oJ812PRc6szN23P9cM0ECvKbe5nSu3cK6/E
         kv47ZNe0QTxjWrdDBUb824me6CcO++gY7Rh9Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690318641; x=1690923441;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SZaam7kr0RM2wvFpQkpovBqoJNVqtgLNS4lSsOVsnM0=;
        b=lRNmLwpudSoJEt22PmBAS0iguEAQ+GHNIYgm+9KfS0Nse6qJr/WnpBQvXUqmIkouG5
         G8JdHy2IH/+20bvpPIhGYnYqztR+cKAnf2cgxMdQYa9AuJIyy/MLKLY5hXYIZDbiGuy+
         ekWSf3OtYnPAyCzeOSwELBdkqUHiENFGI1TL9mHAwbYXAOx2Is+p8Ms6WvCCAZokTPjv
         6YnyrlkZ15GQ09LUBw+YcSJ7UyFsospLTezDZgw9MBBIgMIislnXVdZJtmXB9gjbn5dn
         get5MwxpEIn+l5B77SkQFm7cMhKEJTxYYPpcD/Tu0MIE5MuEUNET2V3DXigWeCzZ6UKd
         BExg==
X-Gm-Message-State: ABy/qLZmictdewNqUL/AcCFpZSC0V7qJ8b0I/kHHnFog5l3cAEmouyXw
        D41jlKgMDy5UCzvNeSal6r9Clg==
X-Google-Smtp-Source: APBJJlGX7BZVD6CMaWSxooDiqPHBfJnW1g6PQRdV1WoMXcFPycQZ2h1NdKwXfYvEFDAjGCB44Qe4og==
X-Received: by 2002:a17:907:2c4f:b0:982:870f:9e8f with SMTP id hf15-20020a1709072c4f00b00982870f9e8fmr225ejc.62.1690318641418;
        Tue, 25 Jul 2023 13:57:21 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id h19-20020a1709062dd300b0097073f1ed84sm8704186eji.4.2023.07.25.13.57.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 13:57:21 -0700 (PDT)
From:   Joe Damato <jdamato@fastly.com>
To:     netdev@vger.kernel.org, saeedm@nvidia.com, tariqt@nvidia.com,
        ecree@solarflare.com, andrew@lunn.ch, kuba@kernel.org,
        davem@davemloft.net, leon@kernel.org, pabeni@redhat.com,
        arnd@arndb.de
Cc:     linux-kernel@vger.kernel.org, Joe Damato <jdamato@fastly.com>
Subject: [net-next v2 2/2] net/mlx5: Fix flowhash key set/get for custom RSS
Date:   Tue, 25 Jul 2023 20:56:55 +0000
Message-Id: <20230725205655.310165-3-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230725205655.310165-1-jdamato@fastly.com>
References: <20230725205655.310165-1-jdamato@fastly.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mlx5 flow hash field retrieval and set only worked on the default
RSS context as of commit f01cc58c18d6 ("net/mlx5e: Support multiple RSS
contexts"), not custom RSS contexts.

For example, before this patch attempting to retrieve the flow hash fields
for RSS context 1 fails:

$ sudo ethtool -u eth1 rx-flow-hash tcp4 context 1
Cannot get RX network flow hashing options: Invalid argument

This patch fixes getting and setting the flow hash fields for contexts
other than the default context.

Getting the flow hash fields for RSS context 1:

$ sudo ethtool -u eth1 rx-flow-hash tcp4 context 1
For RSS context 1:
TCP over IPV4 flows use these fields for computing Hash flow key:
IP DA

Now, setting the flash hash fields to a custom value:

$ sudo ethtool -U eth1 rx-flow-hash tcp4 sdfn context 1

And retrieving them again:

$ sudo ethtool -u eth1 rx-flow-hash tcp4 context 1
For RSS context 1:
TCP over IPV4 flows use these fields for computing Hash flow key:
IP SA
IP DA
L4 bytes 0 & 1 [TCP/UDP src port]
L4 bytes 2 & 3 [TCP/UDP dst port]

Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 .../ethernet/mellanox/mlx5/core/en/rx_res.c   | 25 +++++++++++---
 .../ethernet/mellanox/mlx5/core/en/rx_res.h   |  7 ++--
 .../mellanox/mlx5/core/en_fs_ethtool.c        | 33 ++++++++++++++-----
 3 files changed, 48 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.c b/drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.c
index e1095bc36543..56e6b8c7501f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.c
@@ -218,17 +218,32 @@ int mlx5e_rx_res_rss_set_rxfh(struct mlx5e_rx_res *res, u32 rss_idx,
 	return mlx5e_rss_set_rxfh(rss, indir, key, hfunc, res->rss_rqns, res->rss_nch);
 }
 
-u8 mlx5e_rx_res_rss_get_hash_fields(struct mlx5e_rx_res *res, enum mlx5_traffic_types tt)
+int mlx5e_rx_res_rss_get_hash_fields(struct mlx5e_rx_res *res, u32 rss_idx,
+				     enum mlx5_traffic_types tt)
 {
-	struct mlx5e_rss *rss = res->rss[0];
+	struct mlx5e_rss *rss;
+
+	if (rss_idx >= MLX5E_MAX_NUM_RSS)
+		return -EINVAL;
+
+	rss = res->rss[rss_idx];
+	if (!rss)
+		return -ENOENT;
 
 	return mlx5e_rss_get_hash_fields(rss, tt);
 }
 
-int mlx5e_rx_res_rss_set_hash_fields(struct mlx5e_rx_res *res, enum mlx5_traffic_types tt,
-				     u8 rx_hash_fields)
+int mlx5e_rx_res_rss_set_hash_fields(struct mlx5e_rx_res *res, u32 rss_idx,
+				     enum mlx5_traffic_types tt, u8 rx_hash_fields)
 {
-	struct mlx5e_rss *rss = res->rss[0];
+	struct mlx5e_rss *rss;
+
+	if (rss_idx >= MLX5E_MAX_NUM_RSS)
+		return -EINVAL;
+
+	rss = res->rss[rss_idx];
+	if (!rss)
+		return -ENOENT;
 
 	return mlx5e_rss_set_hash_fields(rss, tt, rx_hash_fields);
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.h b/drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.h
index 5d5f64fab60f..580fe8bc3cd2 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.h
@@ -48,9 +48,10 @@ int mlx5e_rx_res_rss_get_rxfh(struct mlx5e_rx_res *res, u32 rss_idx,
 int mlx5e_rx_res_rss_set_rxfh(struct mlx5e_rx_res *res, u32 rss_idx,
 			      const u32 *indir, const u8 *key, const u8 *hfunc);
 
-u8 mlx5e_rx_res_rss_get_hash_fields(struct mlx5e_rx_res *res, enum mlx5_traffic_types tt);
-int mlx5e_rx_res_rss_set_hash_fields(struct mlx5e_rx_res *res, enum mlx5_traffic_types tt,
-				     u8 rx_hash_fields);
+int mlx5e_rx_res_rss_get_hash_fields(struct mlx5e_rx_res *res, u32 rss_idx,
+				     enum mlx5_traffic_types tt);
+int mlx5e_rx_res_rss_set_hash_fields(struct mlx5e_rx_res *res, u32 rss_idx,
+				     enum mlx5_traffic_types tt, u8 rx_hash_fields);
 int mlx5e_rx_res_packet_merge_set_param(struct mlx5e_rx_res *res,
 					struct mlx5e_packet_merge_param *pkt_merge_param);
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_fs_ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/en_fs_ethtool.c
index aac32e505c14..aed599db9d84 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_fs_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_fs_ethtool.c
@@ -900,10 +900,16 @@ static int mlx5e_set_rss_hash_opt(struct mlx5e_priv *priv,
 				  struct ethtool_rxnfc *nfc)
 {
 	u8 rx_hash_field = 0;
+	u32 flow_type = 0;
+	u32 rss_idx = 0;
 	int err;
 	int tt;
 
-	tt = flow_type_to_traffic_type(nfc->flow_type);
+	if (nfc->flow_type & FLOW_RSS)
+		rss_idx = nfc->rss_context;
+
+	flow_type = flow_type_mask(nfc->flow_type);
+	tt = flow_type_to_traffic_type(flow_type);
 	if (tt < 0)
 		return tt;
 
@@ -911,10 +917,10 @@ static int mlx5e_set_rss_hash_opt(struct mlx5e_priv *priv,
 	 *  on src IP, dest IP, TCP/UDP src port and TCP/UDP dest
 	 *  port.
 	 */
-	if (nfc->flow_type != TCP_V4_FLOW &&
-	    nfc->flow_type != TCP_V6_FLOW &&
-	    nfc->flow_type != UDP_V4_FLOW &&
-	    nfc->flow_type != UDP_V6_FLOW)
+	if (flow_type != TCP_V4_FLOW &&
+	    flow_type != TCP_V6_FLOW &&
+	    flow_type != UDP_V4_FLOW &&
+	    flow_type != UDP_V6_FLOW)
 		return -EOPNOTSUPP;
 
 	if (nfc->data & ~(RXH_IP_SRC | RXH_IP_DST |
@@ -931,7 +937,7 @@ static int mlx5e_set_rss_hash_opt(struct mlx5e_priv *priv,
 		rx_hash_field |= MLX5_HASH_FIELD_SEL_L4_DPORT;
 
 	mutex_lock(&priv->state_lock);
-	err = mlx5e_rx_res_rss_set_hash_fields(priv->rx_res, tt, rx_hash_field);
+	err = mlx5e_rx_res_rss_set_hash_fields(priv->rx_res, rss_idx, tt, rx_hash_field);
 	mutex_unlock(&priv->state_lock);
 
 	return err;
@@ -940,14 +946,23 @@ static int mlx5e_set_rss_hash_opt(struct mlx5e_priv *priv,
 static int mlx5e_get_rss_hash_opt(struct mlx5e_priv *priv,
 				  struct ethtool_rxnfc *nfc)
 {
-	u32 hash_field = 0;
+	int hash_field = 0;
+	u32 flow_type = 0;
+	u32 rss_idx = 0;
 	int tt;
 
-	tt = flow_type_to_traffic_type(nfc->flow_type);
+	if (nfc->flow_type & FLOW_RSS)
+		rss_idx = nfc->rss_context;
+
+	flow_type = flow_type_mask(nfc->flow_type);
+	tt = flow_type_to_traffic_type(flow_type);
 	if (tt < 0)
 		return tt;
 
-	hash_field = mlx5e_rx_res_rss_get_hash_fields(priv->rx_res, tt);
+	hash_field = mlx5e_rx_res_rss_get_hash_fields(priv->rx_res, rss_idx, tt);
+	if (hash_field < 0)
+		return hash_field;
+
 	nfc->data = 0;
 
 	if (hash_field & MLX5_HASH_FIELD_SEL_SRC_IP)
-- 
2.25.1

