Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1D127CD63D
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 10:20:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235119AbjJRIU2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 04:20:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbjJRIUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 04:20:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69315C6
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 01:20:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02897C433C7;
        Wed, 18 Oct 2023 08:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697617222;
        bh=+iJNkAX3uTlU6h3PwOl18AULdHhbN3mhV+q+jP2nzPQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p88ZKR/AY6Q5a3gOGqVHXP/+gK4sH6u8N3vAbDm25eZ6glgD143jXNWYMvUDsoZRu
         CmSME1X7TtU4b/mfsuardPV3NpW2cJLUfhrxhEYxw/HsrUxUqLP6Lp/i26E7H1+JN0
         Ba0XdwePcPUHIP1FPEZBondihXSGd/yGG1IfgMRdEAU5wlLC5sYkjSEM2+T4h2d+Fh
         bhV8T51ycU7hGCk2Sc4yA/+5+ayDxwZn8lQOQU6nf/UDadZfKvGhWjcd+uOXhlT0yY
         B+muRkOTP5ADsI23nK2OULKYl56YGPoy5m3Zs3DAQzJSDSXIo8YRiIavdHtz4vJ5H2
         HlHNmVBhnAiHg==
From:   Saeed Mahameed <saeed@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Leon Romanovsky <leonro@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
        Saeed Mahameed <saeedm@nvidia.com>
Subject: [PATCH 1/5] mlx5: Add aux dev for ctl interface
Date:   Wed, 18 Oct 2023 01:19:37 -0700
Message-ID: <20231018081941.475277-2-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231018081941.475277-1-saeed@kernel.org>
References: <20231018081941.475277-1-saeed@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Saeed Mahameed <saeedm@nvidia.com>

Allow ctl protocol interface auxiliary driver in mlx5.

Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/dev.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/dev.c b/drivers/net/ethernet/mellanox/mlx5/core/dev.c
index 7909f378dc93..f0e91793f4ad 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/dev.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/dev.c
@@ -215,8 +215,14 @@ enum {
 	MLX5_INTERFACE_PROTOCOL_MPIB,
 
 	MLX5_INTERFACE_PROTOCOL_VNET,
+	MLX5_INTERFACE_PROTOCOL_CTL,
 };
 
+static bool is_ctl_supported(struct mlx5_core_dev *dev)
+{
+	return MLX5_CAP_GEN(dev, uctx_cap);
+}
+
 static const struct mlx5_adev_device {
 	const char *suffix;
 	bool (*is_supported)(struct mlx5_core_dev *dev);
@@ -237,6 +243,8 @@ static const struct mlx5_adev_device {
 					   .is_supported = &is_ib_rep_supported },
 	[MLX5_INTERFACE_PROTOCOL_MPIB] = { .suffix = "multiport",
 					   .is_supported = &is_mp_supported },
+	[MLX5_INTERFACE_PROTOCOL_CTL] = { .suffix = "ctl",
+					  .is_supported = &is_ctl_supported },
 };
 
 int mlx5_adev_idx_alloc(void)
-- 
2.41.0

