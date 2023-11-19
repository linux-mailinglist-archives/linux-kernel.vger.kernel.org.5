Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6273B7F0505
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 10:44:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230407AbjKSJn5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 04:43:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbjKSJn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 04:43:56 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3804212D
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 01:43:53 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7024C433CA;
        Sun, 19 Nov 2023 09:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700387032;
        bh=LtPGF9rLnrTjx4KOW6bP4tyG32DyV0XUPY4ZXkV6sgY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RYgG9auU9nH9bapRq3jPlMdmo7jFriHnk68LO8cUREdpCe9j6eRd2N6BSWPdmxp92
         EBOk4Cp+/8lxRp/Jsncw+pG5vLOSuNT556lG4sCsak7vVKPhMqvXIDWs1FtgFBExlv
         rBmuZU84BI7RZbZ/zDUQ/xWUqe1rbQoF9wDfA7rOSorGR6vt0430MMVcgMGVWMzdKT
         MV9nkN9jkHpHr5HNSWso15n3+Mlw9khyr4cV6CF+3xL0YGQHNpG+e6MwWPGiQaq/Z3
         hw1On4U7cI3zIrBxfvmPY9sAttp+T5oR72z6En/jQadU6KGElS+7krW11bew749kC5
         2f/46HGBBIVmw==
From:   Saeed Mahameed <saeed@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Jiri Pirko <jiri@nvidia.com>, Leonid Bloch <lbloch@nvidia.com>,
        Itay Avraham <itayavr@nvidia.com>,
        Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org,
        Saeed Mahameed <saeedm@nvidia.com>
Subject: [PATCH V2 1/5] mlx5: Add aux dev for ctl interface
Date:   Sun, 19 Nov 2023 01:24:46 -0800
Message-ID: <20231119092450.164996-2-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231119092450.164996-1-saeed@kernel.org>
References: <20231119092450.164996-1-saeed@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Saeed Mahameed <saeedm@nvidia.com>

Allow ctl protocol interface auxiliary driver in mlx5.

Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/dev.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/dev.c b/drivers/net/ethernet/mellanox/mlx5/core/dev.c
index cf0477f53dc4..753c11f7050d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/dev.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/dev.c
@@ -228,8 +228,14 @@ enum {
 	MLX5_INTERFACE_PROTOCOL_VNET,
 
 	MLX5_INTERFACE_PROTOCOL_DPLL,
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
@@ -252,6 +258,8 @@ static const struct mlx5_adev_device {
 					   .is_supported = &is_mp_supported },
 	[MLX5_INTERFACE_PROTOCOL_DPLL] = { .suffix = "dpll",
 					   .is_supported = &is_dpll_supported },
+	[MLX5_INTERFACE_PROTOCOL_CTL] = { .suffix = "ctl",
+					  .is_supported = &is_ctl_supported },
 };
 
 int mlx5_adev_idx_alloc(void)
-- 
2.41.0

