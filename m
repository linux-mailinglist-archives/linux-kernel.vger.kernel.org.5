Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE2077B44B0
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 01:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234096AbjI3Xoi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 19:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234101AbjI3Xoh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 19:44:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF816FD
        for <linux-kernel@vger.kernel.org>; Sat, 30 Sep 2023 16:44:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABB7EC433C8;
        Sat, 30 Sep 2023 23:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696117469;
        bh=WdTnvHIfE9Z+Cf7GFtMdGxS7MP/BA2t1PAoWsH1zAYg=;
        h=From:Date:Subject:To:Cc:From;
        b=MlCxd+y7kh2Bn2VFvMQ1aF/BrB3BLwISITRpYnAZpOiEbJh/1zU0EP+cnlbMbpP/o
         t2cmyDOT/90RWBBTNOl6AbwhiZWUztf5Llj/B63X/SKU6abyssNr5nWzyLrIavmZSi
         0QU2f25FgzM+GeFVQhZjbv3vEzjZF81WsYdkR5wY8iypZ+HqT7O44A3fof05tjW4BN
         zlIDp9oyI8yWgiRVgkkmdtBdFOBgThGFfu5U+WE4jgxvVCWITKx5FQsy4v55tWy2Rp
         Xw7FOa3KNPYOlIp1PN0cIdhTk8DUCfziOPh49PzfBzWEJQwk8YXG8jTYVbHJYo5kxC
         jEpLgt9uZSIAg==
From:   Mark Brown <broonie@kernel.org>
Date:   Sun, 01 Oct 2023 00:44:22 +0100
Subject: [PATCH] mfd: rk8xx: Convert to use maple tree register cache
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231001-mfd-rk88x-maple-v1-1-90434cfb2f90@kernel.org>
X-B4-Tracking: v=1; b=H4sIANWyGGUC/x3MSwqAMAwA0auUrA1oitp4FXEhGjX4Ky2IIN7d4
 vItZh6IElQiNOaBIJdGPY+EIjMwLP0xC+qYDJSTzZkY92nEsDp34977TbCyNHDJtZBjSJUPMun
 9H9vufT8qJRtmYQAAAA==
To:     Lee Jones <lee@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=1509; i=broonie@kernel.org;
 h=from:subject:message-id; bh=WdTnvHIfE9Z+Cf7GFtMdGxS7MP/BA2t1PAoWsH1zAYg=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlGLLbvWdqGA3ROxRyd6mIFL3vECSnHvoc9rU+2
 VqKsXi7j3yJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZRiy2wAKCRAk1otyXVSH
 0BZRB/0Z3ddSRqV2F72nIRJwA+HAce3Ol1fpb2ryVwo+fYoVKaq8e9GqrhZy0rllcU71dKwRXvA
 NcDIIRsW5dgRBAzkFt9GV1U0PMHZq7ql1bBPC33BCVgysnM91rK8e37TOJywfQUt9KMnF5fU+Q6
 RFlIR4yc3jZY/IJy+GY5dondBS61Uq97LxBDnNvCN4GYdXiCENgDjh8Z991iZEMef2gXlIOVP5n
 pYxGw6w+wg2eBW61x5v8Wi/UbArt8V2kJiw+xFtNqIWlg8iEzcUMNMxWFX/dsSxIEbQg91SwWWu
 j4oH4o9XgC+NuKVxdVQMdljHqW/YqaBsymNiArxQMMyFI2p9
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The maple tree register cache is based on a much more modern data structure
than the rbtree cache and makes optimisation choices which are probably
more appropriate for modern systems than those made by the rbtree cache.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/mfd/rk8xx-i2c.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mfd/rk8xx-i2c.c b/drivers/mfd/rk8xx-i2c.c
index 1a98feea97e2..75b5cf09d5a0 100644
--- a/drivers/mfd/rk8xx-i2c.c
+++ b/drivers/mfd/rk8xx-i2c.c
@@ -80,7 +80,7 @@ static const struct regmap_config rk818_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 8,
 	.max_register = RK818_USB_CTRL_REG,
-	.cache_type = REGCACHE_RBTREE,
+	.cache_type = REGCACHE_MAPLE,
 	.volatile_reg = rk808_is_volatile_reg,
 };
 
@@ -88,7 +88,7 @@ static const struct regmap_config rk805_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 8,
 	.max_register = RK805_OFF_SOURCE_REG,
-	.cache_type = REGCACHE_RBTREE,
+	.cache_type = REGCACHE_MAPLE,
 	.volatile_reg = rk808_is_volatile_reg,
 };
 
@@ -96,7 +96,7 @@ static const struct regmap_config rk808_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 8,
 	.max_register = RK808_IO_POL_REG,
-	.cache_type = REGCACHE_RBTREE,
+	.cache_type = REGCACHE_MAPLE,
 	.volatile_reg = rk808_is_volatile_reg,
 };
 

---
base-commit: 6465e260f48790807eef06b583b38ca9789b6072
change-id: 20230929-mfd-rk88x-maple-632c9597e289

Best regards,
-- 
Mark Brown <broonie@kernel.org>

