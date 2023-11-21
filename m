Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18F277F261B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 08:06:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbjKUHGf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 02:06:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjKUHGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 02:06:31 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE203F5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 23:06:27 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F2DFC433C8;
        Tue, 21 Nov 2023 07:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700550387;
        bh=fRBJjZFPTR6OGb7k2gGjja7sHzz884j46t7cYBYv3r8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DoxnnLt2h5sAHOExSrhg3cR5/5BXtrkiCv0ZiwrqokF+RY1/ZVSCXFSXEipTWeVDU
         CAReITvBovf9yexbC2/k6T/KVelOR2M4ZBunk3OWncJsqOUYMbHJSM1mUS17xGBsVC
         XzsUsT7eqkbSj935jcVGBo5T4i4r9r5tTqtxaVsQRCwZi1GvD+ZuEaqqLgx6vnyaO1
         dGcdw8jho1cA589iON0MXnXHMVP6hn3nLFn//ASvI7T3w7KToSi3AbT6a8XSR2qFFE
         HucyxZECGiG1SI2F97NjolLsj192AOtolxBv3kB4hQJhZ0iHLoaArh7R5aDVEmqIz/
         AyOP/+R8a1Ngw==
From:   Saeed Mahameed <saeed@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Jiri Pirko <jiri@nvidia.com>, Leonid Bloch <lbloch@nvidia.com>,
        Itay Avraham <itayavr@nvidia.com>,
        Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org,
        Saeed Mahameed <saeedm@nvidia.com>
Subject: [PATCH V3 1/5] mlx5: Add aux dev for ctl interface
Date:   Mon, 20 Nov 2023 23:06:15 -0800
Message-ID: <20231121070619.9836-2-saeed@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231121070619.9836-1-saeed@kernel.org>
References: <20231121070619.9836-1-saeed@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
2.42.0

