Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39C1A807C36
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 00:17:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379654AbjLFXRe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 18:17:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377556AbjLFXR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 18:17:29 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90CE2181
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 15:17:35 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC886C433CA;
        Wed,  6 Dec 2023 23:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701904655;
        bh=DE6LOODg8opqMxDQr9pajmg5bZcQ8RbpkX6Gz17Xsa4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o+I5/P8jMIg5fG9kLI7hWzQVkunc0BfPRII4N7CB72iq2sxL9q5BicDtkfVtb/T4U
         xEJ+g32CtkG1tRpnPX9W0eIh8I4RVFdtunftSv5dVygMuF3J2RsuM1Js99lnLQ9fIg
         d2tbrlGCduycPKs3smcm4etVDMtkATGm/dKfU5foU5UrpdxkkH+Tryud70/JhboP1l
         n3whXkHfCiCrw47Np+hHmLfnM3puM3HQShycc6ZBvZ3wdS7dX6aJURO+rCvj2XeeSd
         iQ56ZWE+SukHSBhgWnbjrFU85zUpvwa4YC569ArB4bA52iiwBooT3sLkFA4j1KSIR4
         mxbPFVUHPtbXw==
From:   Stephen Boyd <sboyd@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Yu-Che Cheng <giver@chromium.org>, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Fei Shao <fshao@chromium.org>,
        Chen-Yu Tsai <wenst@chromium.org>
Subject: [PATCH 2/8] spmi: mediatek: Fix UAF on device remove
Date:   Wed,  6 Dec 2023 15:17:25 -0800
Message-ID: <20231206231733.4031901-3-sboyd@kernel.org>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
In-Reply-To: <20231206231733.4031901-1-sboyd@kernel.org>
References: <20231206231733.4031901-1-sboyd@kernel.org>
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

From: Yu-Che Cheng <giver@chromium.org>

The pmif driver data that contains the clocks is allocated along with
spmi_controller.
On device remove, spmi_controller will be freed first, and then devres
, including the clocks, will be cleanup.
This leads to UAF because putting the clocks will access the clocks in
the pmif driver data, which is already freed along with spmi_controller.

This can be reproduced by enabling DEBUG_TEST_DRIVER_REMOVE and
building the kernel with KASAN.

Fix the UAF issue by using unmanaged clk_bulk_get() and putting the
clocks before freeing spmi_controller.

Reported-by: Fei Shao <fshao@chromium.org>
Signed-off-by: Yu-Che Cheng <giver@chromium.org>
Link: https://lore.kernel.org/r/20230717173934.1.If004a6e055a189c7f2d0724fa814422c26789839@changeid
Tested-by: Fei Shao <fshao@chromium.org>
Reviewed-by: Fei Shao <fshao@chromium.org>
Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/spmi/spmi-mtk-pmif.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/spmi/spmi-mtk-pmif.c b/drivers/spmi/spmi-mtk-pmif.c
index 54c35f5535cb..1261f381cae6 100644
--- a/drivers/spmi/spmi-mtk-pmif.c
+++ b/drivers/spmi/spmi-mtk-pmif.c
@@ -475,7 +475,7 @@ static int mtk_spmi_probe(struct platform_device *pdev)
 	for (i = 0; i < arb->nclks; i++)
 		arb->clks[i].id = pmif_clock_names[i];
 
-	err = devm_clk_bulk_get(&pdev->dev, arb->nclks, arb->clks);
+	err = clk_bulk_get(&pdev->dev, arb->nclks, arb->clks);
 	if (err) {
 		dev_err(&pdev->dev, "Failed to get clocks: %d\n", err);
 		goto err_put_ctrl;
@@ -484,7 +484,7 @@ static int mtk_spmi_probe(struct platform_device *pdev)
 	err = clk_bulk_prepare_enable(arb->nclks, arb->clks);
 	if (err) {
 		dev_err(&pdev->dev, "Failed to enable clocks: %d\n", err);
-		goto err_put_ctrl;
+		goto err_put_clks;
 	}
 
 	ctrl->cmd = pmif_arb_cmd;
@@ -510,6 +510,8 @@ static int mtk_spmi_probe(struct platform_device *pdev)
 
 err_domain_remove:
 	clk_bulk_disable_unprepare(arb->nclks, arb->clks);
+err_put_clks:
+	clk_bulk_put(arb->nclks, arb->clks);
 err_put_ctrl:
 	spmi_controller_put(ctrl);
 	return err;
@@ -521,6 +523,7 @@ static void mtk_spmi_remove(struct platform_device *pdev)
 	struct pmif *arb = spmi_controller_get_drvdata(ctrl);
 
 	clk_bulk_disable_unprepare(arb->nclks, arb->clks);
+	clk_bulk_put(arb->nclks, arb->clks);
 	spmi_controller_remove(ctrl);
 	spmi_controller_put(ctrl);
 }
-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git

