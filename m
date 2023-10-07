Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 636277BC80E
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 15:50:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343892AbjJGNuT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 09:50:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343893AbjJGNuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 09:50:17 -0400
Received: from smtp.smtpout.orange.fr (smtp-24.smtpout.orange.fr [80.12.242.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D34D9CA
        for <linux-kernel@vger.kernel.org>; Sat,  7 Oct 2023 06:50:14 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id p7h0qpPqZqToTp7h0qy9q1; Sat, 07 Oct 2023 15:50:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1696686612;
        bh=+NsrC/kMBjP5jYS5nCk9DfFO8Yn5kcVnJ7NUbypxWEE=;
        h=From:To:Cc:Subject:Date;
        b=S/BuIu22dvKaQZVcytkPFaooazzGdz6iVKPujBs6N8X9Uu+z4UbmAnryyDm8S4qTi
         /tslWKj4umgblAYL000xKgNdUbZF3ReR7cg8t1LtjGq7K9C8rHLXiSBaIqr0tX4ajY
         1IZdGZSeVlT5bDdZET+U0jRVhDD8YXIkg+PoPd+IxRBpE4WXztn4p88MCqBEZUxagO
         O3Z4llfIe3LOG/3i+k/j9RSOS4IfazIdbV3srp82iDeUHRZHw9REoeuJsSZ1Cp/Tc8
         w4islVbqKYeLJfgGsoAdVKT5VctLwFS42DqXs9YLwUkMpc6p6zPwlqH/iN/JxHyZ+9
         krAqU6VFsdHEA==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 07 Oct 2023 15:50:12 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Dmitry Osipenko <digetx@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-media@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH] media: vde: Use struct_size()
Date:   Sat,  7 Oct 2023 15:50:02 +0200
Message-Id: <bb201c3f0e7d2ca5cd222d9bb4c78ded8fded54e.1696686558.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use struct_size() which is much more common than this offsetof().

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/media/platform/nvidia/tegra-vde/v4l2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/nvidia/tegra-vde/v4l2.c b/drivers/media/platform/nvidia/tegra-vde/v4l2.c
index bd8c207d5b54..0f48ce6f243e 100644
--- a/drivers/media/platform/nvidia/tegra-vde/v4l2.c
+++ b/drivers/media/platform/nvidia/tegra-vde/v4l2.c
@@ -813,7 +813,7 @@ static int tegra_open(struct file *file)
 	struct tegra_ctx *ctx;
 	int err;
 
-	ctx = kzalloc(offsetof(struct tegra_ctx, ctrls[ARRAY_SIZE(ctrl_cfgs)]),
+	ctx = kzalloc(struct_size(ctx, ctrls, ARRAY_SIZE(ctrl_cfgs)),
 		      GFP_KERNEL);
 	if (!ctx)
 		return -ENOMEM;
-- 
2.34.1

