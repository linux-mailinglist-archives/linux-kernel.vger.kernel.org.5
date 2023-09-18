Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D47827A55DA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 00:45:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbjIRWpO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 18:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjIRWpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 18:45:13 -0400
X-Greylist: delayed 906 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 18 Sep 2023 15:45:06 PDT
Received: from s1-ba86.socketlabs.email-od.com (s1-ba86.socketlabs.email-od.com [142.0.186.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF7AC91
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 15:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; d=email-od.com;i=@email-od.com;s=dkim;
        c=relaxed/relaxed; q=dns/txt; t=1695077107; x=1697669107;
        h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:subject:cc:to:from:x-thread-info:subject:to:from:cc:reply-to;
        bh=3ZMrNeKN62FSveMjc7T4KvcZT7aU10NEVwhrwfIClwc=;
        b=SOJ21ln7J3AF6p35MI1B8mGA1OqV76FCS6m3brSYZ3qkfik91+rXoa+K3yQ28l3diGLUqi+oON1dOCThGFREXToKIIPV/5Dc8v3HBuucBbFahZ9mJcrH0wolEHT6HqIUTFQ/fauYGGGK6qwbcqpCAPhB8Er/d51fAxdoLCUDNaY=
X-Thread-Info: NDUwNC4xMi4xNWZkOTAwMDc1Y2E1MzQubGludXgta2VybmVsPXZnZXIua2VybmVsLm9yZw==
Received: from r2.h.in.socketlabs.com (r2.h.in.socketlabs.com [142.0.180.12]) by mxrs4.email-od.com
        with ESMTP(version=Tls12 cipher=Aes256 bits=256); Mon, 18 Sep 2023 18:29:59 -0400
Received: from nalramli.com (d14-69-55-117.try.wideopenwest.com [69.14.117.55]) by r2.h.in.socketlabs.com
        with ESMTP; Mon, 18 Sep 2023 18:29:59 -0400
Received: from localhost.localdomain (d14-69-55-117.try.wideopenwest.com [69.14.117.55])
        by nalramli.com (Postfix) with ESMTPS id 9248C2CE016A;
        Mon, 18 Sep 2023 18:29:58 -0400 (EDT)
From:   "Nabil S. Alramli" <dev@nalramli.com>
To:     netdev@vger.kernel.org, saeedm@nvidia.com, saeed@kernel.org,
        kuba@kernel.org, davem@davemloft.net, tariqt@nvidia.com,
        linux-kernel@vger.kernel.org, leon@kernel.org
Cc:     jdamato@fastly.com, sbhogavilli@fastly.com, nalramli@fastly.com,
        "Nabil S. Alramli" <dev@nalramli.com>
Subject: [net-next RFC v2 1/4] mlx5: Add mlx5e_param to individual mlx5e_channel and preserve them through mlx5e_open_channels()
Date:   Mon, 18 Sep 2023 18:29:52 -0400
Message-Id: <20230918222955.2066-2-dev@nalramli.com>
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
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mlx-5 driver currently has one global `struct mlx5e_param` for storin=
g
settings including coalescing ones which means that individual channels
cannot have their own independent settings. This patch adds a
`struct mlx5e_param` to each `struct mlx5e_channel`. The global settings
have been preserved as well to continue to support global commands.

Signed-off-by: Nabil S. Alramli <dev@nalramli.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en.h  |  3 +-
 .../net/ethernet/mellanox/mlx5/core/en_main.c | 34 ++++++++++++++-----
 2 files changed, 28 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/e=
thernet/mellanox/mlx5/core/en.h
index 86f2690c5e01..3657839b88f8 100644
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
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/=
net/ethernet/mellanox/mlx5/core/en_main.c
index a2ae791538ed..a1578219187b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -2471,6 +2471,7 @@ static int mlx5e_open_channel(struct mlx5e_priv *pr=
iv, int ix,
 	c->tstamp   =3D &priv->tstamp;
 	c->ix       =3D ix;
 	c->cpu      =3D cpu;
+	c->params   =3D *params;
 	c->pdev     =3D mlx5_core_dma_dev(priv->mdev);
 	c->netdev   =3D priv->netdev;
 	c->mkey_be  =3D cpu_to_be32(priv->mdev->mlx5e_res.hw_objs.mkey);
@@ -2558,27 +2559,42 @@ int mlx5e_open_channels(struct mlx5e_priv *priv,
 			struct mlx5e_channels *chs)
 {
 	struct mlx5e_channel_param *cparam;
+	bool use_global_params =3D true;
 	int err =3D -ENOMEM;
 	int i;
=20
 	chs->num =3D chs->params.num_channels;
=20
+	/* This check is necessary here in case chs =3D=3D priv->channels becau=
se the allocation of
+	 * chs->c will invalidate it
+	 */
+	if (priv->channels.c)
+		use_global_params =3D false;
+
 	chs->c =3D kcalloc(chs->num, sizeof(struct mlx5e_channel *), GFP_KERNEL=
);
-	cparam =3D kvzalloc(sizeof(struct mlx5e_channel_param), GFP_KERNEL);
+	cparam =3D kvmalloc(sizeof(*cparam), GFP_KERNEL);
 	if (!chs->c || !cparam)
 		goto err_free;
=20
-	err =3D mlx5e_build_channel_param(priv->mdev, &chs->params, priv->q_cou=
nter, cparam);
-	if (err)
-		goto err_free;
-
 	for (i =3D 0; i < chs->num; i++) {
 		struct xsk_buff_pool *xsk_pool =3D NULL;
+		struct mlx5e_params *params =3D NULL;
+
+		/* If priv->channels.c is not NULL, then retain the original params */
+		if (use_global_params)
+			params =3D &chs->params;
+		else
+			params =3D &priv->channels.c[i]->params;
+
+		memset(cparam, 0, sizeof(*cparam));
+		err =3D mlx5e_build_channel_param(priv->mdev, params, priv->q_counter,=
 cparam);
+		if (err)
+			goto err_free;
=20
-		if (chs->params.xdp_prog)
-			xsk_pool =3D mlx5e_xsk_get_pool(&chs->params, chs->params.xsk, i);
+		if (params->xdp_prog)
+			xsk_pool =3D mlx5e_xsk_get_pool(params, params->xsk, i);
=20
-		err =3D mlx5e_open_channel(priv, i, &chs->params, cparam, xsk_pool, &c=
hs->c[i]);
+		err =3D mlx5e_open_channel(priv, i, params, cparam, xsk_pool, &chs->c[=
i]);
 		if (err)
 			goto err_close_channels;
 	}
@@ -3115,6 +3131,7 @@ int mlx5e_open_locked(struct net_device *netdev)
=20
 	set_bit(MLX5E_STATE_OPENED, &priv->state);
=20
+	priv->channels.c  =3D NULL;
 	err =3D mlx5e_open_channels(priv, &priv->channels);
 	if (err)
 		goto err_clear_state_opened_flag;
@@ -5611,6 +5628,7 @@ int mlx5e_priv_init(struct mlx5e_priv *priv,
 	priv->netdev      =3D netdev;
 	priv->max_nch     =3D nch;
 	priv->max_opened_tc =3D 1;
+	priv->channels.c  =3D NULL;
=20
 	if (!alloc_cpumask_var(&priv->scratchpad.cpumask, GFP_KERNEL))
 		return -ENOMEM;
--=20
2.35.1

