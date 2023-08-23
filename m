Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E8EA78638C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 00:47:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238755AbjHWWqw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 18:46:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238753AbjHWWqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 18:46:43 -0400
X-Greylist: delayed 902 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 23 Aug 2023 15:46:41 PDT
Received: from s1-ba86.socketlabs.email-od.com (s1-ba86.socketlabs.email-od.com [142.0.186.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5189ECF1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 15:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; d=email-od.com;i=@email-od.com;s=dkim;
        c=relaxed/relaxed; q=dns/txt; t=1692830801; x=1695422801;
        h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:subject:cc:to:from:x-thread-info:subject:to:from:cc:reply-to;
        bh=3g2JrsnOZXgLW4qZJY2N1Md1glpQ8oXzTDMqeHFzXQg=;
        b=wmXo9ScZY3Y/2CTlUjQFaj45UvX8+uMgcMKg28nHiJD+rvhxZPUduVvFzcYMV1uNcuHwb2yKjcvHNWHu3vUGo4bS0HnYPbLgTkEdEY7HKW+dwOP16p7tgqucOD/9V7XImppNjVn9U9na0m+3Yg0IX2FZg+ZAyllqoKwuVEpJ/Fo=
X-Thread-Info: NDUwNC4xMi4xNWZkOTAwMDE4MTM2NGUubGludXgta2VybmVsPXZnZXIua2VybmVsLm9yZw==
Received: from r3.us-east-1.aws.in.socketlabs.com (r3.us-east-1.aws.in.socketlabs.com [142.0.191.3]) by mxrs4.email-od.com
        with ESMTP(version=Tls12 cipher=Aes256 bits=256); Wed, 23 Aug 2023 18:31:35 -0400
Received: from nalramli.com (d14-69-55-117.try.wideopenwest.com [69.14.117.55]) by r3.us-east-1.aws.in.socketlabs.com
        with ESMTP; Wed, 23 Aug 2023 18:31:25 -0400
Received: from localhost.localdomain (d14-69-55-117.try.wideopenwest.com [69.14.117.55])
        by nalramli.com (Postfix) with ESMTPS id CD5D92CE0018;
        Wed, 23 Aug 2023 18:31:24 -0400 (EDT)
From:   "Nabil S. Alramli" <dev@nalramli.com>
To:     netdev@vger.kernel.org, kuba@kernel.org, davem@davemloft.net,
        saeedm@nvidia.com, tariqt@nvidia.com, linux-kernel@vger.kernel.org,
        leon@kernel.org
Cc:     jdamato@fastly.com, nalramli@fastly.com,
        "Nabil S. Alramli" <dev@nalramli.com>
Subject: [net-next RFC 1/1] mlx5: Add {get,set}_per_queue_coalesce()
Date:   Wed, 23 Aug 2023 18:31:21 -0400
Message-Id: <20230823223121.58676-2-dev@nalramli.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230823223121.58676-1-dev@nalramli.com>
References: <20230823223121.58676-1-dev@nalramli.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-13.3 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_IADB_DK,RCVD_IN_IADB_LISTED,
        RCVD_IN_IADB_OPTIN,RCVD_IN_IADB_RDNS,RCVD_IN_IADB_SENDERID,
        RCVD_IN_IADB_SPF,RCVD_IN_IADB_VOUCHED,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mlx-5 driver currently only implements querying or modifying coalesce
configurations globally. It does not allow per-queue operations. This
patch is to implement per-queue coalesce operations in the driver.

Signed-off-by: Nabil S. Alramli <dev@nalramli.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en.h  |   3 +-
 .../ethernet/mellanox/mlx5/core/en_ethtool.c  | 212 ++++++++++++++----
 .../net/ethernet/mellanox/mlx5/core/en_main.c |   4 +
 3 files changed, 173 insertions(+), 46 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/e=
thernet/mellanox/mlx5/core/en.h
index c1deb04ba7e8..e61c2fb9bc55 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -783,6 +783,7 @@ struct mlx5e_channel {
 	DECLARE_BITMAP(state, MLX5E_CHANNEL_NUM_STATES);
 	int                        ix;
 	int                        cpu;
+	struct mlx5e_params        params; /* channel specific params */
 	/* Sync between icosq recovery and XSK enable/disable. */
 	struct mutex               icosq_recovery_lock;
 };
@@ -793,7 +794,7 @@ struct mlx5e_channels {
 	struct mlx5e_channel **c;
 	struct mlx5e_ptp      *ptp;
 	unsigned int           num;
-	struct mlx5e_params    params;
+	struct mlx5e_params    params; /* global params */
 };
=20
 struct mlx5e_channel_stats {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c b/drive=
rs/net/ethernet/mellanox/mlx5/core/en_ethtool.c
index dff02434ff45..7296ccfc0825 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
@@ -513,33 +513,55 @@ static int mlx5e_set_channels(struct net_device *de=
v,
 	return mlx5e_ethtool_set_channels(priv, ch);
 }
=20
-int mlx5e_ethtool_get_coalesce(struct mlx5e_priv *priv,
-			       struct ethtool_coalesce *coal,
-			       struct kernel_ethtool_coalesce *kernel_coal)
+static int mlx5e_ethtool_get_per_queue_coalesce(struct mlx5e_priv *priv,
+						int queue,
+						struct ethtool_coalesce *coal,
+						struct kernel_ethtool_coalesce *kernel_coal)
 {
 	struct dim_cq_moder *rx_moder, *tx_moder;
+	struct mlx5e_params *params;
=20
 	if (!MLX5_CAP_GEN(priv->mdev, cq_moderation))
 		return -EOPNOTSUPP;
=20
-	rx_moder =3D &priv->channels.params.rx_cq_moderation;
+	if (queue !=3D -1 && queue >=3D priv->channels.num) {
+		netdev_err(priv->netdev, "%s: Invalid queue ID [%d]",
+			   __func__, queue);
+		return -EINVAL;
+	}
+
+	if (queue =3D=3D -1)
+		params =3D &priv->channels.params;
+	else
+		params =3D &priv->channels.c[queue]->params;
+
+	rx_moder =3D &params->rx_cq_moderation;
 	coal->rx_coalesce_usecs		=3D rx_moder->usec;
 	coal->rx_max_coalesced_frames	=3D rx_moder->pkts;
-	coal->use_adaptive_rx_coalesce	=3D priv->channels.params.rx_dim_enabled=
;
+	coal->use_adaptive_rx_coalesce	=3D params->rx_dim_enabled;
=20
-	tx_moder =3D &priv->channels.params.tx_cq_moderation;
+	tx_moder =3D &params->tx_cq_moderation;
 	coal->tx_coalesce_usecs		=3D tx_moder->usec;
 	coal->tx_max_coalesced_frames	=3D tx_moder->pkts;
-	coal->use_adaptive_tx_coalesce	=3D priv->channels.params.tx_dim_enabled=
;
+	coal->use_adaptive_tx_coalesce	=3D params->tx_dim_enabled;
=20
-	kernel_coal->use_cqe_mode_rx =3D
-		MLX5E_GET_PFLAG(&priv->channels.params, MLX5E_PFLAG_RX_CQE_BASED_MODER=
);
-	kernel_coal->use_cqe_mode_tx =3D
-		MLX5E_GET_PFLAG(&priv->channels.params, MLX5E_PFLAG_TX_CQE_BASED_MODER=
);
+	if (kernel_coal) {
+		kernel_coal->use_cqe_mode_rx =3D
+			MLX5E_GET_PFLAG(&priv->channels.params, MLX5E_PFLAG_RX_CQE_BASED_MODE=
R);
+		kernel_coal->use_cqe_mode_tx =3D
+			MLX5E_GET_PFLAG(&priv->channels.params, MLX5E_PFLAG_TX_CQE_BASED_MODE=
R);
+	}
=20
 	return 0;
 }
=20
+int mlx5e_ethtool_get_coalesce(struct mlx5e_priv *priv,
+			       struct ethtool_coalesce *coal,
+			       struct kernel_ethtool_coalesce *kernel_coal)
+{
+	return mlx5e_ethtool_get_per_queue_coalesce(priv, -1, coal, kernel_coal=
);
+}
+
 static int mlx5e_get_coalesce(struct net_device *netdev,
 			      struct ethtool_coalesce *coal,
 			      struct kernel_ethtool_coalesce *kernel_coal,
@@ -550,36 +572,76 @@ static int mlx5e_get_coalesce(struct net_device *ne=
tdev,
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
 static void
-mlx5e_set_priv_channels_tx_coalesce(struct mlx5e_priv *priv, struct etht=
ool_coalesce *coal)
+mlx5e_set_priv_channels_tx_coalesce(struct mlx5e_priv *priv,
+				    int queue,
+				    struct ethtool_coalesce *coal)
 {
 	struct mlx5_core_dev *mdev =3D priv->mdev;
 	int tc;
 	int i;
=20
-	for (i =3D 0; i < priv->channels.num; ++i) {
-		struct mlx5e_channel *c =3D priv->channels.c[i];
+	if (queue =3D=3D -1) {
+		for (i =3D 0; i < priv->channels.num; ++i) {
+			struct mlx5e_channel *c =3D priv->channels.c[i];
+
+			for (tc =3D 0; tc < c->num_tc; tc++) {
+				mlx5_core_modify_cq_moderation(mdev,
+							       &c->sq[tc].cq.mcq,
+							       coal->tx_coalesce_usecs,
+							       coal->tx_max_coalesced_frames);
+			}
+		}
+	} else {
+		struct mlx5e_channel *c =3D priv->channels.c[queue];
=20
 		for (tc =3D 0; tc < c->num_tc; tc++) {
 			mlx5_core_modify_cq_moderation(mdev,
-						&c->sq[tc].cq.mcq,
-						coal->tx_coalesce_usecs,
-						coal->tx_max_coalesced_frames);
+						       &c->sq[tc].cq.mcq,
+						       coal->tx_coalesce_usecs,
+						       coal->tx_max_coalesced_frames);
 		}
 	}
 }
=20
 static void
-mlx5e_set_priv_channels_rx_coalesce(struct mlx5e_priv *priv, struct etht=
ool_coalesce *coal)
+mlx5e_set_priv_channels_rx_coalesce(struct mlx5e_priv *priv,
+				    int queue,
+				    struct ethtool_coalesce *coal)
 {
 	struct mlx5_core_dev *mdev =3D priv->mdev;
 	int i;
=20
-	for (i =3D 0; i < priv->channels.num; ++i) {
-		struct mlx5e_channel *c =3D priv->channels.c[i];
+	if (queue =3D=3D -1) {
+		for (i =3D 0; i < priv->channels.num; ++i) {
+			struct mlx5e_channel *c =3D priv->channels.c[i];
+
+			mlx5_core_modify_cq_moderation(mdev, &c->rq.cq.mcq,
+						       coal->rx_coalesce_usecs,
+						       coal->rx_max_coalesced_frames);
+		}
+	} else {
+		struct mlx5e_channel *c =3D priv->channels.c[queue];
=20
 		mlx5_core_modify_cq_moderation(mdev, &c->rq.cq.mcq,
 					       coal->rx_coalesce_usecs,
@@ -596,15 +658,17 @@ static int cqe_mode_to_period_mode(bool val)
 	return val ? MLX5_CQ_PERIOD_MODE_START_FROM_CQE : MLX5_CQ_PERIOD_MODE_S=
TART_FROM_EQE;
 }
=20
-int mlx5e_ethtool_set_coalesce(struct mlx5e_priv *priv,
-			       struct ethtool_coalesce *coal,
-			       struct kernel_ethtool_coalesce *kernel_coal,
-			       struct netlink_ext_ack *extack)
+static int mlx5e_ethtool_set_per_queue_coalesce(struct mlx5e_priv *priv,
+						int queue,
+						struct ethtool_coalesce *coal,
+						struct kernel_ethtool_coalesce *kernel_coal,
+						struct netlink_ext_ack *extack)
 {
 	struct dim_cq_moder *rx_moder, *tx_moder;
 	struct mlx5_core_dev *mdev =3D priv->mdev;
-	struct mlx5e_params new_params;
-	bool reset_rx, reset_tx;
+	bool reset_rx =3D false, reset_tx =3D false;
+	struct mlx5e_params new_params =3D {0};
+	struct mlx5e_params *old_params;
 	bool reset =3D true;
 	u8 cq_period_mode;
 	int err =3D 0;
@@ -626,14 +690,29 @@ int mlx5e_ethtool_set_coalesce(struct mlx5e_priv *p=
riv,
 		return -ERANGE;
 	}
=20
-	if ((kernel_coal->use_cqe_mode_rx || kernel_coal->use_cqe_mode_tx) &&
-	    !MLX5_CAP_GEN(priv->mdev, cq_period_start_from_cqe)) {
-		NL_SET_ERR_MSG_MOD(extack, "cqe_mode_rx/tx is not supported on this de=
vice");
-		return -EOPNOTSUPP;
+	if (kernel_coal) {
+		if ((kernel_coal->use_cqe_mode_rx || kernel_coal->use_cqe_mode_tx) &&
+		    !MLX5_CAP_GEN(priv->mdev, cq_period_start_from_cqe)) {
+			NL_SET_ERR_MSG_MOD(extack,
+					   "cqe_mode_rx/tx is not supported on this device");
+			return -EOPNOTSUPP;
+		}
+	}
+
+	if (queue !=3D -1 && queue >=3D priv->channels.num) {
+		netdev_err(priv->netdev, "%s: Invalid queue ID [%d]",
+			   __func__, queue);
+		return -EINVAL;
 	}
=20
 	mutex_lock(&priv->state_lock);
-	new_params =3D priv->channels.params;
+
+	if (queue =3D=3D -1)
+		old_params =3D &priv->channels.params;
+	else
+		old_params =3D &priv->channels.c[queue]->params;
+
+	new_params =3D *old_params;
=20
 	rx_moder          =3D &new_params.rx_cq_moderation;
 	rx_moder->usec    =3D coal->rx_coalesce_usecs;
@@ -645,19 +724,21 @@ int mlx5e_ethtool_set_coalesce(struct mlx5e_priv *p=
riv,
 	tx_moder->pkts    =3D coal->tx_max_coalesced_frames;
 	new_params.tx_dim_enabled =3D !!coal->use_adaptive_tx_coalesce;
=20
-	reset_rx =3D !!coal->use_adaptive_rx_coalesce !=3D priv->channels.param=
s.rx_dim_enabled;
-	reset_tx =3D !!coal->use_adaptive_tx_coalesce !=3D priv->channels.param=
s.tx_dim_enabled;
+	reset_rx =3D !!coal->use_adaptive_rx_coalesce !=3D old_params->rx_dim_e=
nabled;
+	reset_tx =3D !!coal->use_adaptive_tx_coalesce !=3D old_params->tx_dim_e=
nabled;
=20
-	cq_period_mode =3D cqe_mode_to_period_mode(kernel_coal->use_cqe_mode_rx=
);
-	if (cq_period_mode !=3D rx_moder->cq_period_mode) {
-		mlx5e_set_rx_cq_mode_params(&new_params, cq_period_mode);
-		reset_rx =3D true;
-	}
+	if (kernel_coal) {
+		cq_period_mode =3D cqe_mode_to_period_mode(kernel_coal->use_cqe_mode_r=
x);
+		if (cq_period_mode !=3D rx_moder->cq_period_mode) {
+			mlx5e_set_rx_cq_mode_params(&new_params, cq_period_mode);
+			reset_rx =3D true;
+		}
=20
-	cq_period_mode =3D cqe_mode_to_period_mode(kernel_coal->use_cqe_mode_tx=
);
-	if (cq_period_mode !=3D tx_moder->cq_period_mode) {
-		mlx5e_set_tx_cq_mode_params(&new_params, cq_period_mode);
-		reset_tx =3D true;
+		cq_period_mode =3D cqe_mode_to_period_mode(kernel_coal->use_cqe_mode_t=
x);
+		if (cq_period_mode !=3D tx_moder->cq_period_mode) {
+			mlx5e_set_tx_cq_mode_params(&new_params, cq_period_mode);
+			reset_tx =3D true;
+		}
 	}
=20
 	if (reset_rx) {
@@ -678,18 +759,40 @@ int mlx5e_ethtool_set_coalesce(struct mlx5e_priv *p=
riv,
 	 */
 	if (!reset_rx && !reset_tx && test_bit(MLX5E_STATE_OPENED, &priv->state=
)) {
 		if (!coal->use_adaptive_rx_coalesce)
-			mlx5e_set_priv_channels_rx_coalesce(priv, coal);
+			mlx5e_set_priv_channels_rx_coalesce(priv, queue, coal);
 		if (!coal->use_adaptive_tx_coalesce)
-			mlx5e_set_priv_channels_tx_coalesce(priv, coal);
+			mlx5e_set_priv_channels_tx_coalesce(priv, queue, coal);
 		reset =3D false;
 	}
=20
-	err =3D mlx5e_safe_switch_params(priv, &new_params, NULL, NULL, reset);
+	if (queue =3D=3D -1) {
+		err =3D mlx5e_safe_switch_params(priv, &new_params, NULL, NULL, reset)=
;
+	} else {
+		if (reset) {
+			netdev_err(priv->netdev, "%s: Per-queue adaptive-rx / adaptive-tx ope=
rations are not supported",
+				   __func__);
+			err =3D -EOPNOTSUPP;
+		} else {
+			/* Since preactivate is NULL and we are not doing reset we just copy =
the
+			 * params here instead of calling mlx5e_safe_switch_params() to avoid
+			 * having to pass the queue to it.
+			 */
+			priv->channels.c[queue]->params =3D new_params;
+		}
+	}
=20
 	mutex_unlock(&priv->state_lock);
 	return err;
 }
=20
+int mlx5e_ethtool_set_coalesce(struct mlx5e_priv *priv,
+			       struct ethtool_coalesce *coal,
+			       struct kernel_ethtool_coalesce *kernel_coal,
+			       struct netlink_ext_ack *extack)
+{
+	return mlx5e_ethtool_set_per_queue_coalesce(priv, -1, coal, kernel_coal=
, extack);
+}
+
 static int mlx5e_set_coalesce(struct net_device *netdev,
 			      struct ethtool_coalesce *coal,
 			      struct kernel_ethtool_coalesce *kernel_coal,
@@ -700,6 +803,23 @@ static int mlx5e_set_coalesce(struct net_device *net=
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
@@ -2434,6 +2554,8 @@ const struct ethtool_ops mlx5e_ethtool_ops =3D {
 	.flash_device      =3D mlx5e_flash_device,
 	.get_priv_flags    =3D mlx5e_get_priv_flags,
 	.set_priv_flags    =3D mlx5e_set_priv_flags,
+	.get_per_queue_coalesce	=3D mlx5e_get_per_queue_coalesce,
+	.set_per_queue_coalesce	=3D mlx5e_set_per_queue_coalesce,
 	.self_test         =3D mlx5e_self_test,
 	.get_fec_stats     =3D mlx5e_get_fec_stats,
 	.get_fecparam      =3D mlx5e_get_fecparam,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/=
net/ethernet/mellanox/mlx5/core/en_main.c
index a2ae791538ed..4fce06ca57bc 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -3043,6 +3043,7 @@ int mlx5e_safe_switch_params(struct mlx5e_priv *pri=
v,
 {
 	struct mlx5e_channels *new_chs;
 	int err;
+	int i;
=20
 	reset &=3D test_bit(MLX5E_STATE_OPENED, &priv->state);
 	if (!reset)
@@ -3059,6 +3060,9 @@ int mlx5e_safe_switch_params(struct mlx5e_priv *pri=
v,
 	if (err)
 		goto err_cancel_selq;
=20
+	for (i =3D 0; i < new_chs->num; ++i)
+		new_chs->c[i]->params =3D *params;
+
 	err =3D mlx5e_switch_priv_channels(priv, new_chs, preactivate, context)=
;
 	if (err)
 		goto err_close;
--=20
2.35.1

