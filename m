Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A694D790875
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 17:22:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233446AbjIBPWk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 11:22:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233364AbjIBPWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 11:22:38 -0400
Received: from smtp.smtpout.orange.fr (smtp-19.smtpout.orange.fr [80.12.242.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EA1C10D2
        for <linux-kernel@vger.kernel.org>; Sat,  2 Sep 2023 08:22:35 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id cSRzqoXOCUaEwcSSHqaS1Y; Sat, 02 Sep 2023 17:22:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1693668154;
        bh=sMto5kVoJFQpIRLL7skhyJFDCC1Jq17K2/NpJOjmAnE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=M4pyTcXr3lY9YINresby63k6i5hIp4AOrgx+uoHldLZYPi6gjmDXKxTICmgPU8nRs
         LGeUg6fUbkc6NPqGZgNRrZjBCEBZRkwTfKu18YULt5TmOy010dnB8vLOzWyNut1+tu
         JSSkqyvYpik9Z3h2D8LCAFJ8uygpgsD0yzLVgWw0etDdYSuoVnIeoTmiTGyxi1HhrA
         oeitcqzsq3uFWAajVfgzWj76XG8Tay/IofNtmdMsLdEMEVxtC/SRhZbyXcmhvXRbqY
         2AT3h2BARp4TCMUflM5GADuXLEKu+V3YBnYJcc3POzgFn/FJXYDool+43phuHdSqjZ
         lb9i7m6PPs2Ew==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 02 Sep 2023 17:22:34 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     thierry.reding@gmail.com, mperttunen@nvidia.com, airlied@gmail.com,
        daniel@ffwll.ch, jonathanh@nvidia.com, digetx@gmail.com
Cc:     dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 4/6] drm/tegra: rgb: Fix some error handling paths in tegra_dc_rgb_probe()
Date:   Sat,  2 Sep 2023 17:22:11 +0200
Message-Id: <0001f61eb89048bc36241629b564195689cf54b6.1693667005.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1693667005.git.christophe.jaillet@wanadoo.fr>
References: <cover.1693667005.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If an error occurs after calling tegra_output_probe(),
tegra_output_remove() should be called as already done in the remove
function.

Fixes: 59d29c0ec93f ("drm/tegra: Allocate resources at probe time")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/gpu/drm/tegra/rgb.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/tegra/rgb.c b/drivers/gpu/drm/tegra/rgb.c
index 79566c9ea8ff..26d4d87b83de 100644
--- a/drivers/gpu/drm/tegra/rgb.c
+++ b/drivers/gpu/drm/tegra/rgb.c
@@ -215,26 +215,28 @@ int tegra_dc_rgb_probe(struct tegra_dc *dc)
 	rgb->clk = devm_clk_get(dc->dev, NULL);
 	if (IS_ERR(rgb->clk)) {
 		dev_err(dc->dev, "failed to get clock\n");
-		return PTR_ERR(rgb->clk);
+		err = PTR_ERR(rgb->clk);
+		goto tegra_remove;
 	}
 
 	rgb->clk_parent = devm_clk_get(dc->dev, "parent");
 	if (IS_ERR(rgb->clk_parent)) {
 		dev_err(dc->dev, "failed to get parent clock\n");
-		return PTR_ERR(rgb->clk_parent);
+		err = PTR_ERR(rgb->clk_parent);
+		goto tegra_remove;
 	}
 
 	err = clk_set_parent(rgb->clk, rgb->clk_parent);
 	if (err < 0) {
 		dev_err(dc->dev, "failed to set parent clock: %d\n", err);
-		return err;
+		goto tegra_remove;
 	}
 
 	rgb->pll_d_out0 = clk_get_sys(NULL, "pll_d_out0");
 	if (IS_ERR(rgb->pll_d_out0)) {
 		err = PTR_ERR(rgb->pll_d_out0);
 		dev_err(dc->dev, "failed to get pll_d_out0: %d\n", err);
-		return err;
+		goto tegra_remove;
 	}
 
 	if (dc->soc->has_pll_d2_out0) {
@@ -242,13 +244,17 @@ int tegra_dc_rgb_probe(struct tegra_dc *dc)
 		if (IS_ERR(rgb->pll_d2_out0)) {
 			err = PTR_ERR(rgb->pll_d2_out0);
 			dev_err(dc->dev, "failed to get pll_d2_out0: %d\n", err);
-			return err;
+			goto tegra_remove;
 		}
 	}
 
 	dc->rgb = &rgb->output;
 
 	return 0;
+
+tegra_remove:
+	tegra_output_remove(&rgb->output);
+	return err;
 }
 
 void tegra_dc_rgb_remove(struct tegra_dc *dc)
-- 
2.34.1

