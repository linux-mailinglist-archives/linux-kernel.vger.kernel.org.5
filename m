Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CFE775E2CD
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 17:07:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbjGWPHh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 11:07:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjGWPHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 11:07:34 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 058DDFB
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 08:07:33 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-52229f084beso612847a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 08:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1690124851; x=1690729651;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GEc9euFEeaN2LOx71f0ruznOJAiMTwjsoaciaFbgqt0=;
        b=cj3NZzAiM9ofKEZ0Mvd0r8MPdICmm1gpUfdlfHdiGZzsP5ZWhqtWLG6xjIFUtyvZU2
         FvXax1CjYYcRYhXXhqkcyw4Pht0DLLlfRcRAfFKGBrTdNGtH1bRIoW8emVafpD17JgYR
         acikaMwq3ztfl7CSVb63XCkw1Ow/zbUkre8ao=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690124851; x=1690729651;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GEc9euFEeaN2LOx71f0ruznOJAiMTwjsoaciaFbgqt0=;
        b=hppkVYrPjBbIeLFpPz/RRVx06AIzIZbCip88wngEtNdvdH3ugh7ASLM6A8Xv1zEa/L
         klRhIpi4CoYEaG4Du1UwRxTn+6tT4BUWUJ47TZjm+6EdOf3NuIpbwA5e4lN6NeT5wD2n
         RXMztTpt4wvE8cCwxcgRtkpQLdBASkBTe+613tdT1RK21hmrjMVuTmyExg+MKDOh+y3Z
         Bg7muHM/rqz7DBkGnY6lcMq4aT9+muHpiV90/ugluU79rK3pm0gcfKI+XLJvdmB2v0nW
         CVcz5VnSxx9mgg1JPXiHHXLY+dcSFSY3B+JrW5kHuD1hA3H+G2p9SJFxTWZUfyVtXMJr
         Jl8A==
X-Gm-Message-State: ABy/qLZAmFQc6OGttwcNbcevvPPXY0E8U+0nXPCH2g/qdZdHSHfFQiTh
        6mYlLEL+RfYuWFAPzbijXj3Ckg==
X-Google-Smtp-Source: APBJJlGzbZcbLgL11cNMQhdBE0LOVo6Nzm3pFcfi0GArBOrvnGw4LOVoD0Sy4HUnyFvcRjyhsHvcSA==
X-Received: by 2002:a17:906:1098:b0:982:a454:6d20 with SMTP id u24-20020a170906109800b00982a4546d20mr7326815eju.54.1690124851416;
        Sun, 23 Jul 2023 08:07:31 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id t10-20020a1709064f0a00b009929d998abcsm5227691eju.209.2023.07.23.08.07.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jul 2023 08:07:31 -0700 (PDT)
From:   Joe Damato <jdamato@fastly.com>
To:     netdev@vger.kernel.org, saeedm@nvidia.com, tariqt@nvidia.com,
        ecree@solarflare.com, andrew@lunn.ch, kuba@kernel.org,
        davem@davemloft.net, leon@kernel.org, pabeni@redhat.com,
        bhutchings@solarflare.com, arnd@arndb.de
Cc:     linux-kernel@vger.kernel.org, Joe Damato <jdamato@fastly.com>
Subject: [net 2/2] net/mlx5: Fix flowhash key set/get for custom RSS
Date:   Sun, 23 Jul 2023 15:06:58 +0000
Message-Id: <20230723150658.241597-3-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230723150658.241597-1-jdamato@fastly.com>
References: <20230723150658.241597-1-jdamato@fastly.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mlx5 flow hash field retrieval and set only worked on the default
RSS context, not custom RSS contexts.

For example, before this patch attempting to retrieve the flow hash fields
for RSS context 1 fails:

$ sudo ethtool -u eth1 rx-flow-hash tcp4 context 1
Cannot get RX network flow hashing options: Invalid argument

This patch fixes getting and setting the flow hash fields for contexts
other than the default context.

Getting the flow hash fields for RSS context 1:

sudo ethtool -u eth1 rx-flow-hash tcp4 context 1
For RSS context 1:
TCP over IPV4 flows use these fields for computing Hash flow key:
IP DA

Now, setting the flash hash fields to a custom value:

sudo ethtool -U eth1 rx-flow-hash tcp4 sdfn context 1

And retrieving them again:

sudo ethtool -u eth1 rx-flow-hash tcp4 context 1
For RSS context 1:
TCP over IPV4 flows use these fields for computing Hash flow key:
IP SA
IP DA
L4 bytes 0 & 1 [TCP/UDP src port]
L4 bytes 2 & 3 [TCP/UDP dst port]

Fixes: f01cc58c18d6 ("net/mlx5e: Support multiple RSS contexts")
Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 .../ethernet/mellanox/mlx5/core/en/rx_res.c   | 23 ++++++++++---
 .../ethernet/mellanox/mlx5/core/en/rx_res.h   |  5 +--
 .../mellanox/mlx5/core/en_fs_ethtool.c        | 33 ++++++++++++++-----
 3 files changed, 46 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.c b/drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.c
index e1095bc36543..bb189c92e4c0 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.c
@@ -218,17 +218,32 @@ int mlx5e_rx_res_rss_set_rxfh(struct mlx5e_rx_res *res, u32 rss_idx,
 	return mlx5e_rss_set_rxfh(rss, indir, key, hfunc, res->rss_rqns, res->rss_nch);
 }
 
-u8 mlx5e_rx_res_rss_get_hash_fields(struct mlx5e_rx_res *res, enum mlx5_traffic_types tt)
+int mlx5e_rx_res_rss_get_hash_fields(struct mlx5e_rx_res *res, enum mlx5_traffic_types tt,
+				     u32 rss_idx)
 {
-	struct mlx5e_rss *rss = res->rss[0];
+	struct mlx5e_rss *rss;
+
+	if (rss_idx >= MLX5E_MAX_NUM_RSS)
+		return -EINVAL;
+
+	rss = res->rss[rss_idx];
+	if (!rss)
+		return -EINVAL;
 
 	return mlx5e_rss_get_hash_fields(rss, tt);
 }
 
 int mlx5e_rx_res_rss_set_hash_fields(struct mlx5e_rx_res *res, enum mlx5_traffic_types tt,
-				     u8 rx_hash_fields)
+				     u8 rx_hash_fields, u32 rss_idx)
 {
-	struct mlx5e_rss *rss = res->rss[0];
+	struct mlx5e_rss *rss;
+
+	if (rss_idx >= MLX5E_MAX_NUM_RSS)
+		return -EINVAL;
+
+	rss = res->rss[rss_idx];
+	if (!rss)
+		return -EINVAL;
 
 	return mlx5e_rss_set_hash_fields(rss, tt, rx_hash_fields);
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.h b/drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.h
index 5d5f64fab60f..8ac9d67a9603 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.h
@@ -48,9 +48,10 @@ int mlx5e_rx_res_rss_get_rxfh(struct mlx5e_rx_res *res, u32 rss_idx,
 int mlx5e_rx_res_rss_set_rxfh(struct mlx5e_rx_res *res, u32 rss_idx,
 			      const u32 *indir, const u8 *key, const u8 *hfunc);
 
-u8 mlx5e_rx_res_rss_get_hash_fields(struct mlx5e_rx_res *res, enum mlx5_traffic_types tt);
+int mlx5e_rx_res_rss_get_hash_fields(struct mlx5e_rx_res *res, enum mlx5_traffic_types tt,
+				     u32 rss_idx);
 int mlx5e_rx_res_rss_set_hash_fields(struct mlx5e_rx_res *res, enum mlx5_traffic_types tt,
-				     u8 rx_hash_fields);
+				     u8 rx_hash_fields, u32 rss_idx);
 int mlx5e_rx_res_packet_merge_set_param(struct mlx5e_rx_res *res,
 					struct mlx5e_packet_merge_param *pkt_merge_param);
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_fs_ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/en_fs_ethtool.c
index aac32e505c14..50b8f3da4db1 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_fs_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_fs_ethtool.c
@@ -902,8 +902,14 @@ static int mlx5e_set_rss_hash_opt(struct mlx5e_priv *priv,
 	u8 rx_hash_field = 0;
 	int err;
 	int tt;
+	u32 flow_type = 0;
+	u32 rss_idx = 0;
 
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
+	err = mlx5e_rx_res_rss_set_hash_fields(priv->rx_res, tt, rx_hash_field, rss_idx);
 	mutex_unlock(&priv->state_lock);
 
 	return err;
@@ -940,14 +946,23 @@ static int mlx5e_set_rss_hash_opt(struct mlx5e_priv *priv,
 static int mlx5e_get_rss_hash_opt(struct mlx5e_priv *priv,
 				  struct ethtool_rxnfc *nfc)
 {
-	u32 hash_field = 0;
+	int hash_field = 0;
 	int tt;
+	u32 flow_type = 0;
+	u32 rss_idx = 0;
+
+	if (nfc->flow_type & FLOW_RSS)
+		rss_idx = nfc->rss_context;
 
-	tt = flow_type_to_traffic_type(nfc->flow_type);
+	flow_type = flow_type_mask(nfc->flow_type);
+	tt = flow_type_to_traffic_type(flow_type);
 	if (tt < 0)
 		return tt;
 
-	hash_field = mlx5e_rx_res_rss_get_hash_fields(priv->rx_res, tt);
+	hash_field = mlx5e_rx_res_rss_get_hash_fields(priv->rx_res, tt, rss_idx);
+	if (hash_field < 0)
+		return hash_field;
+
 	nfc->data = 0;
 
 	if (hash_field & MLX5_HASH_FIELD_SEL_SRC_IP)
-- 
2.25.1

