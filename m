Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D68337BC24D
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 00:44:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233780AbjJFWop (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 18:44:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233802AbjJFWon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 18:44:43 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54B2F93;
        Fri,  6 Oct 2023 15:44:40 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90726C433C7;
        Fri,  6 Oct 2023 22:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696632279;
        bh=YoE+IETji8jPLWdxvOTSBPuvIy3CWy3/W00cFbvaZVA=;
        h=From:To:Cc:Subject:Date:From;
        b=sfdwVhXLnB5x0G2GMOhFQwyi7aN8LrsurzCp6eDI5oRAo6KLVOBCnf0ffzW8ch4s7
         bT6XjnaWuoUAMtF57vrHlOOlnAYKSj49vR79/mRVfVLTNBg25KIRdFZhQNX2UTGJ+l
         YUI45j/EvJbJ3R6bxXYg4oKVS3e7I2W+nLgoswk8ovhmY4eFtqKU/4khwbdS96LsZN
         CaeH3D0FrfS9hqb4lg0jBwdUsir6f6SMDeJevG2TH8JrxndS0JTQ8h06Eoe4zefKSK
         4X3XyaF4XMeyV4/9s9f7lfYYHWuVGEzqPxSK3z0oxLtzwLKJILE65qKnsMg4LYFyFP
         vAoRGjMAneU6g==
Received: (nullmailer pid 442832 invoked by uid 1000);
        Fri, 06 Oct 2023 22:44:37 -0000
From:   Rob Herring <robh@kernel.org>
To:     Laxman Dewangan <ldewangan@nvidia.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     linux-input@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Input: tegra: Use device_get_match_data()
Date:   Fri,  6 Oct 2023 17:44:32 -0500
Message-Id: <20231006224432.442709-1-robh@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use preferred device_get_match_data() instead of of_match_device() to
get the driver match data. With this, adjust the includes to explicitly
include the correct headers.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/input/keyboard/tegra-kbc.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/input/keyboard/tegra-kbc.c b/drivers/input/keyboard/tegra-kbc.c
index c9a823ea45d0..a1765ed8c825 100644
--- a/drivers/input/keyboard/tegra-kbc.c
+++ b/drivers/input/keyboard/tegra-kbc.c
@@ -14,7 +14,7 @@
 #include <linux/io.h>
 #include <linux/interrupt.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
+#include <linux/property.h>
 #include <linux/clk.h>
 #include <linux/slab.h>
 #include <linux/input/matrix_keypad.h>
@@ -602,9 +602,6 @@ static int tegra_kbc_probe(struct platform_device *pdev)
 	unsigned int debounce_cnt;
 	unsigned int scan_time_rows;
 	unsigned int keymap_rows;
-	const struct of_device_id *match;
-
-	match = of_match_device(tegra_kbc_of_match, &pdev->dev);
 
 	kbc = devm_kzalloc(&pdev->dev, sizeof(*kbc), GFP_KERNEL);
 	if (!kbc) {
@@ -613,7 +610,7 @@ static int tegra_kbc_probe(struct platform_device *pdev)
 	}
 
 	kbc->dev = &pdev->dev;
-	kbc->hw_support = match->data;
+	kbc->hw_support = device_get_match_data(&pdev->dev);
 	kbc->max_keys = kbc->hw_support->max_rows *
 				kbc->hw_support->max_columns;
 	kbc->num_rows_and_columns = kbc->hw_support->max_rows +
-- 
2.40.1

