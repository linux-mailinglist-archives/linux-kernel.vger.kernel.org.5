Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB7CE7D7002
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 16:54:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344318AbjJYOvQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 10:51:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344176AbjJYOvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 10:51:13 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C920136;
        Wed, 25 Oct 2023 07:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698245471; x=1729781471;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=l/NJMRjSMo3od/OVoprgvRt/zRss9xwyAblrboJ/CAc=;
  b=Ma6rDtha9Tp0RxAmrqD+n+Vp3tkBTBl2VSoLKahHS2cv7aegIPc6uQuG
   QbNkcwndjOHWK/atibXlW/Kx5XoQUnZz1cHLFd1nwFpVmhlAFCiQwSpWw
   K8JejvOCdkNtaHeGWxdl81/blVZqL4nZ/dfWUauTVgcDrpqNVQesD+c5r
   B+KqSXEp8gQbc/uHTzMefFbPbJnkrWvbuRJ9bz2gc6dIltRU0xm8wPdvT
   aDlUyws6KZhn2IwXeH29n15E8RrxxdY53OlshVocTN1lb6w9t8cIQwn9D
   VhEuL2gr4Daqn8kNg4uMbdbcp21WTJC03jPim1OkxUyz4kmx2MI/Z3dt6
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="453789860"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="453789860"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 07:51:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="1090250352"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="1090250352"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmsmga005.fm.intel.com with ESMTP; 25 Oct 2023 07:51:06 -0700
Received: from pkitszel-desk.intel.com (unknown [10.255.194.221])
        by irvmail002.ir.intel.com (Postfix) with ESMTP id EF9CD381BD;
        Wed, 25 Oct 2023 15:51:01 +0100 (IST)
From:   Przemek Kitszel <przemyslaw.kitszel@intel.com>
To:     netdev@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Jiri Pirko <jiri@resnulli.us>
Cc:     linux-kernel@vger.kernel.org, Leon Romanovsky <leon@kernel.org>,
        Tariq Toukan <tariqt@nvidia.com>,
        Danielle Ratson <danieller@nvidia.com>,
        Ido Schimmel <idosch@nvidia.com>,
        Petr Machata <petrm@nvidia.com>,
        Moshe Shemesh <moshe@nvidia.com>,
        Eran Ben Elisha <eranbe@nvidia.com>,
        Aya Levin <ayal@mellanox.com>, Simon Horman <horms@kernel.org>,
        Przemek Kitszel <przemyslaw.kitszel@intel.com>,
        Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH net-next] net/mlx5: fix uninit value use
Date:   Wed, 25 Oct 2023 16:50:50 +0200
Message-Id: <20231025145050.36114-1-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid use of uninitialized state variable.

In case of mlx5e_tx_reporter_build_diagnose_output_sq_common() it's better
to still collect other data than bail out entirely.

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Link: https://lore.kernel.org/netdev/8bd30131-c9f2-4075-a575-7fa2793a1760@moroto.mountain
Fixes: d17f98bf7cc9 ("net/mlx5: devlink health: use retained error fmsg API")
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en/reporter_rx.c | 6 +++++-
 drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c | 8 ++++++--
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_rx.c
index fc5a9fdd06db..fea8c0a5fe89 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_rx.c
@@ -263,8 +263,12 @@ mlx5e_rx_reporter_build_diagnose_output_rq_common(struct mlx5e_rq *rq,
 	if (rq->icosq) {
 		struct mlx5e_icosq *icosq = rq->icosq;
 		u8 icosq_hw_state;
+		int err;
+
+		err = mlx5_core_query_sq_state(rq->mdev, icosq->sqn, &icosq_hw_state);
+		if (err)
+			return err;
 
-		mlx5_core_query_sq_state(rq->mdev, icosq->sqn, &icosq_hw_state);
 		mlx5e_reporter_icosq_diagnose(icosq, icosq_hw_state, fmsg);
 	}
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c b/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c
index ccff7c26d6ac..6b44ddce14e9 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c
@@ -221,12 +221,16 @@ mlx5e_tx_reporter_build_diagnose_output_sq_common(struct devlink_fmsg *fmsg,
 	bool stopped = netif_xmit_stopped(sq->txq);
 	struct mlx5e_priv *priv = sq->priv;
 	u8 state;
+	int err;
 
-	mlx5_core_query_sq_state(priv->mdev, sq->sqn, &state);
 	devlink_fmsg_u32_pair_put(fmsg, "tc", tc);
 	devlink_fmsg_u32_pair_put(fmsg, "txq ix", sq->txq_ix);
 	devlink_fmsg_u32_pair_put(fmsg, "sqn", sq->sqn);
-	devlink_fmsg_u8_pair_put(fmsg, "HW state", state);
+
+	err = mlx5_core_query_sq_state(priv->mdev, sq->sqn, &state);
+	if (!err)
+		devlink_fmsg_u8_pair_put(fmsg, "HW state", state);
+
 	devlink_fmsg_bool_pair_put(fmsg, "stopped", stopped);
 	devlink_fmsg_u32_pair_put(fmsg, "cc", sq->cc);
 	devlink_fmsg_u32_pair_put(fmsg, "pc", sq->pc);
-- 
2.38.1

