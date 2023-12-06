Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5021C807C3A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 00:18:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379675AbjLFXRj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 18:17:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379617AbjLFXRa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 18:17:30 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D218BD69
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 15:17:36 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3424CC433CB;
        Wed,  6 Dec 2023 23:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701904656;
        bh=8uz7AK/6yHawqaJPcw4bg1vliKDTq/KL8xQPTh+RBhQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ldO8y0aaCAI30pGHZ+jGi3ri+gv6J7mHp87soVwGOCnw7hGcQgtXzAK6BzELZoYXT
         EkEFX2BuYSZfAhST/kM4KnpgfrUHGV4vAsB7+Ouh4jfVeliyoFM5Qhy/H7rOju9C5n
         fW2tyyccaFPGkmXsN/rlupyXFxMt0EKFplWPVCQy/CmqxlalQSkr7GtccdcDSbvVNR
         3wy2y6YX/LW2rtq8M5iliwsM/Fx8Pg4+Ge8xxfSFebR//VvU94kwwBFAKUZaoVgj79
         MUX+xlMD1xRnCl2NeZL2/zAlrXEnZasnuLWe3loDsHzSUMGaKwJFLs9qgItr2iDKaP
         ESqXecPm63nDg==
From:   Stephen Boyd <sboyd@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Fei Shao <fshao@chromium.org>, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH 5/8] spmi: mtk-pmif: Reorder driver remove sequence
Date:   Wed,  6 Dec 2023 15:17:28 -0800
Message-ID: <20231206231733.4031901-6-sboyd@kernel.org>
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

From: Fei Shao <fshao@chromium.org>

This driver enables clocks and then adds SPMI controller in probing, so
we expect the reversed sequence in removal.
Fix the order in the remove callback.

Signed-off-by: Fei Shao <fshao@chromium.org>
Link: https://lore.kernel.org/r/20230824104101.4083400-4-fshao@chromium.org
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/spmi/spmi-mtk-pmif.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spmi/spmi-mtk-pmif.c b/drivers/spmi/spmi-mtk-pmif.c
index 6ebc6901490a..cc660da6a037 100644
--- a/drivers/spmi/spmi-mtk-pmif.c
+++ b/drivers/spmi/spmi-mtk-pmif.c
@@ -515,9 +515,9 @@ static void mtk_spmi_remove(struct platform_device *pdev)
 	struct spmi_controller *ctrl = platform_get_drvdata(pdev);
 	struct pmif *arb = spmi_controller_get_drvdata(ctrl);
 
+	spmi_controller_remove(ctrl);
 	clk_bulk_disable_unprepare(arb->nclks, arb->clks);
 	clk_bulk_put(arb->nclks, arb->clks);
-	spmi_controller_remove(ctrl);
 }
 
 static const struct of_device_id mtk_spmi_match_table[] = {
-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git

