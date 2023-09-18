Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 383797A55DE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 00:45:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbjIRWp3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 18:45:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbjIRWpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 18:45:25 -0400
X-Greylist: delayed 916 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 18 Sep 2023 15:45:18 PDT
Received: from s1-ba86.socketlabs.email-od.com (s1-ba86.socketlabs.email-od.com [142.0.186.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2C98FF
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 15:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; d=email-od.com;i=@email-od.com;s=dkim;
        c=relaxed/relaxed; q=dns/txt; t=1695077119; x=1697669119;
        h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:subject:cc:to:from:x-thread-info:subject:to:from:cc:reply-to;
        bh=civKVjUZdeRQiNd2Nurlx+U4cUAHpte7hLrL1+ny2CY=;
        b=ESM+AJzUjX3KV6WcNtaMHDRQJrl0e15n6DJ3Ti5ecyxNt2Kv6sxfYBBVSBDc/SMPuUFyssdKsTvpWjrapNLVCQQjoGFFKPC+595OZAF6W5RMnlGeLKlsUFA7/3NYaRAec/VaqDn9A7gePOD0OsUq9YMvkIOQLeUkzp2wt8Q/+H8=
X-Thread-Info: NDUwNC4xMi4xNWZkOTAwMDc1Y2E1NjQubGludXgta2VybmVsPXZnZXIua2VybmVsLm9yZw==
Received: from r3.h.in.socketlabs.com (r3.h.in.socketlabs.com [142.0.180.13]) by mxrs4.email-od.com
        with ESMTP(version=Tls12 cipher=Aes256 bits=256); Mon, 18 Sep 2023 18:30:00 -0400
Received: from nalramli.com (d14-69-55-117.try.wideopenwest.com [69.14.117.55]) by r3.h.in.socketlabs.com
        with ESMTP; Mon, 18 Sep 2023 18:29:59 -0400
Received: from localhost.localdomain (d14-69-55-117.try.wideopenwest.com [69.14.117.55])
        by nalramli.com (Postfix) with ESMTPS id D2D4E2CE016D;
        Mon, 18 Sep 2023 18:29:58 -0400 (EDT)
From:   "Nabil S. Alramli" <dev@nalramli.com>
To:     netdev@vger.kernel.org, saeedm@nvidia.com, saeed@kernel.org,
        kuba@kernel.org, davem@davemloft.net, tariqt@nvidia.com,
        linux-kernel@vger.kernel.org, leon@kernel.org
Cc:     jdamato@fastly.com, sbhogavilli@fastly.com, nalramli@fastly.com,
        "Nabil S. Alramli" <dev@nalramli.com>
Subject: [net-next RFC v2 4/4] mlx5: Add {get,set}_per_queue_coalesce()
Date:   Mon, 18 Sep 2023 18:29:55 -0400
Message-Id: <20230918222955.2066-5-dev@nalramli.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230918222955.2066-1-dev@nalramli.com>
References: <ZOemz1HLp95aGXXQ@x130>
 <20230918222955.2066-1-dev@nalramli.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-13.3 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_IADB_DK,RCVD_IN_IADB_LISTED,
        RCVD_IN_IADB_OPTIN,RCVD_IN_IADB_RDNS,RCVD_IN_IADB_SENDERID,
        RCVD_IN_IADB_SPF,RCVD_IN_IADB_VOUCHED,SPF_HELO_PASS,SPF_PASS,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mlx-5 driver currently only implements querying or modifying coalesce
configurations globally. It does not allow per-queue operations. This
change is to implement per-queue coalesce operations in the driver.

Signed-off-by: Nabil S. Alramli <dev@nalramli.com>
---
 .../ethernet/mellanox/mlx5/core/en_ethtool.c  | 46 +++++++++++++++++--
 1 file changed, 41 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c b/drive=
rs/net/ethernet/mellanox/mlx5/core/en_ethtool.c
index daa0aa833a42..492c03c3d5f4 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
@@ -515,8 +515,8 @@ static int mlx5e_set_channels(struct net_device *dev,
=20
 static int mlx5e_ethtool_get_per_queue_coalesce(struct mlx5e_priv *priv,
 						int queue,
-			       struct ethtool_coalesce *coal,
-			       struct kernel_ethtool_coalesce *kernel_coal)
+						struct ethtool_coalesce *coal,
+						struct kernel_ethtool_coalesce *kernel_coal)
 {
 	struct dim_cq_moder *rx_moder, *tx_moder;
 	struct mlx5e_params *params;
@@ -572,6 +572,23 @@ static int mlx5e_get_coalesce(struct net_device *net=
dev,
 	return mlx5e_ethtool_get_coalesce(priv, coal, kernel_coal);
 }
=20
+/**
+ * mlx5e_get_per_queue_coalesce - gets coalesce settings for particular =
queue
+ * @netdev: netdev structure
+ * @coal: ethtool's coalesce settings
+ * @queue: the particular queue to read
+ *
+ * Reads a specific queue's coalesce settings
+ **/
+static int mlx5e_get_per_queue_coalesce(struct net_device *netdev,
+					u32 queue,
+					struct ethtool_coalesce *coal)
+{
+	struct mlx5e_priv *priv =3D netdev_priv(netdev);
+
+	return mlx5e_ethtool_get_per_queue_coalesce(priv, queue, coal, NULL);
+}
+
 #define MLX5E_MAX_COAL_TIME		MLX5_MAX_CQ_PERIOD
 #define MLX5E_MAX_COAL_FRAMES		MLX5_MAX_CQ_COUNT
=20
@@ -643,9 +660,9 @@ static int cqe_mode_to_period_mode(bool val)
=20
 static int mlx5e_ethtool_set_per_queue_coalesce(struct mlx5e_priv *priv,
 						int queue,
-			       struct ethtool_coalesce *coal,
-			       struct kernel_ethtool_coalesce *kernel_coal,
-			       struct netlink_ext_ack *extack)
+						struct ethtool_coalesce *coal,
+						struct kernel_ethtool_coalesce *kernel_coal,
+						struct netlink_ext_ack *extack)
 {
 	struct dim_cq_moder *rx_moder, *tx_moder;
 	struct mlx5_core_dev *mdev =3D priv->mdev;
@@ -772,6 +789,23 @@ static int mlx5e_set_coalesce(struct net_device *net=
dev,
 	return mlx5e_ethtool_set_coalesce(priv, coal, kernel_coal, extack);
 }
=20
+/**
+ * mlx5e_set_per_queue_coalesce - set specific queue's coalesce settings
+ * @netdev: the netdev to change
+ * @coal: ethtool's coalesce settings
+ * @queue: the queue to change
+ *
+ * Sets the specified queue's coalesce settings.
+ **/
+static int mlx5e_set_per_queue_coalesce(struct net_device *netdev,
+					u32 queue,
+					struct ethtool_coalesce *coal)
+{
+	struct mlx5e_priv *priv =3D netdev_priv(netdev);
+
+	return mlx5e_ethtool_set_per_queue_coalesce(priv, queue, coal, NULL, NU=
LL);
+}
+
 static void ptys2ethtool_supported_link(struct mlx5_core_dev *mdev,
 					unsigned long *supported_modes,
 					u32 eth_proto_cap)
@@ -2506,6 +2540,8 @@ const struct ethtool_ops mlx5e_ethtool_ops =3D {
 	.flash_device      =3D mlx5e_flash_device,
 	.get_priv_flags    =3D mlx5e_get_priv_flags,
 	.set_priv_flags    =3D mlx5e_set_priv_flags,
+	.get_per_queue_coalesce	=3D mlx5e_get_per_queue_coalesce,
+	.set_per_queue_coalesce	=3D mlx5e_set_per_queue_coalesce,
 	.self_test         =3D mlx5e_self_test,
 	.get_fec_stats     =3D mlx5e_get_fec_stats,
 	.get_fecparam      =3D mlx5e_get_fecparam,
--=20
2.35.1

