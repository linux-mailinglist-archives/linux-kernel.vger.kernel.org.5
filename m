Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 423BC78C581
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 15:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236134AbjH2NdP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 09:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236143AbjH2NdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 09:33:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1277ACC9;
        Tue, 29 Aug 2023 06:32:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 761F862DB2;
        Tue, 29 Aug 2023 13:32:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C00EDC433C8;
        Tue, 29 Aug 2023 13:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693315943;
        bh=8V1JkwAzu5VZdGESa+X98BKD0oGzH8Czi5Y7HrS2MII=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H27OUgf17NJiTTpfEV7/ZUkTNcsWTDQBxVrkqhdi6o8bdHaTJoOFshzVM1/HsttUC
         C5qdy5r4h7DxdjIa6Dp16RqFLb9WBOlhVsXd45OVfHWBUJWTGmPEegPsUfxMV68X+x
         ooLaC5EQtZRANl+BhJYD98F9OQLlDL+URAr/aw2p05GMbHLID2lSnjDZMxMzdhGO/I
         100e/HSiNYBF4Kh7gzsj/4r/NKgfySpZz4XoF65wB3eFw/8i6rlC8IG+VJCJxb7oeS
         Ydm4NQoybQa7vEbJa+ocewKo3NESnajQcsiMxaeqMwbHHPOkS/JHh41quM/P4cKddF
         5y472jtW0n5XQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dragos Tatulea <dtatulea@nvidia.com>,
        =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Lei Yang <leiyang@redhat.com>, Sasha Levin <sashal@kernel.org>,
        elic@nvidia.com, si-wei.liu@oracle.com,
        virtualization@lists.linux-foundation.org
Subject: [PATCH AUTOSEL 6.4 05/17] vdpa/mlx5: Correct default number of queues when MQ is on
Date:   Tue, 29 Aug 2023 09:31:52 -0400
Message-Id: <20230829133211.519957-5-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230829133211.519957-1-sashal@kernel.org>
References: <20230829133211.519957-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.4.12
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dragos Tatulea <dtatulea@nvidia.com>

[ Upstream commit 3fe024193340b225d1fd410d78c495434a9d68e0 ]

The standard specifies that the initial number of queues is the
default, which is 1 (1 tx, 1 rx).

Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Eugenio Pérez <eperezma@redhat.com>
Message-Id: <20230727172354.68243-2-dtatulea@nvidia.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Tested-by: Lei Yang <leiyang@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index 279ac6a558d29..93a2520223b66 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -2447,7 +2447,15 @@ static int mlx5_vdpa_set_driver_features(struct vdpa_device *vdev, u64 features)
 	else
 		ndev->rqt_size = 1;
 
-	ndev->cur_num_vqs = 2 * ndev->rqt_size;
+	/* Device must start with 1 queue pair, as per VIRTIO v1.2 spec, section
+	 * 5.1.6.5.5 "Device operation in multiqueue mode":
+	 *
+	 * Multiqueue is disabled by default.
+	 * The driver enables multiqueue by sending a command using class
+	 * VIRTIO_NET_CTRL_MQ. The command selects the mode of multiqueue
+	 * operation, as follows: ...
+	 */
+	ndev->cur_num_vqs = 2;
 
 	update_cvq_info(mvdev);
 	return err;
-- 
2.40.1

