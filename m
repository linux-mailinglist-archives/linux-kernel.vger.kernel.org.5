Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 398497C8C5F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 19:37:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbjJMRhl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 13:37:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjJMRhk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 13:37:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A74BFBF
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 10:37:38 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA7FEC433C8;
        Fri, 13 Oct 2023 17:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697218658;
        bh=HJT283gufmNTKZ1HBQ/5iGWVvMQLBiV0kx1VBpmJJ2o=;
        h=From:Date:Subject:To:Cc:From;
        b=Hh2dLgaVMsg08SS9GArO1W/6DeLTcXQhQ5sUQbYuB26xBHcm48kAyKz28jwDPPkF/
         OEwu1nH+YpE9d0Yfvm1bVR5exlTowmYY4KjepN07FD7NZ2hfCwsOwguvuorkH24hX5
         eUJHm+cwxKiyRstBVYfj9pRBNSgjBpMi0qKCrl4tVn2pSDZNC8jsSo5mOu8BvC0PpQ
         ZuQqpA5O0P6YoyrLVCGjf84zgEcr2I0umirU/hT78DLnpURA0H+wpdxb9EOJ2cwuwY
         +wh+eF9L406GFV2sw0AKgytpy/UuHo23vISKpMj2+/3eod5vizMR6n1Vt7lLWyD/U3
         tP0BRGaxgw0YA==
From:   Mark Brown <broonie@kernel.org>
Date:   Fri, 13 Oct 2023 18:37:33 +0100
Subject: [PATCH] ASoC: dwc: Fix non-DT instantiation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231013-asoc-fix-dwc-v1-1-63211bb746b9@kernel.org>
X-B4-Tracking: v=1; b=H4sIAFyAKWUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2NDA0Nj3cTi/GTdtMwK3ZTyZF0DMyNLk0TjFGMzc1MloJaColSgFNi46Nj
 aWgBOVaAjXgAAAA==
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Xingyu Wu <xingyu.wu@starfivetech.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=1128; i=broonie@kernel.org;
 h=from:subject:message-id; bh=HJT283gufmNTKZ1HBQ/5iGWVvMQLBiV0kx1VBpmJJ2o=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlKYBgq42EeqOZ620pMX7z5W9hELZSAYwy4YNTO
 S+uXAn88ZiJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZSmAYAAKCRAk1otyXVSH
 0NgfB/4xxyVdMMJQWFk24fk2jmqzHiHSBcyUZxRVj8niv5wH4r3RjJx6aZToR776cRsXQfCR228
 ZD4MHe/kyNV4aIpS7dpt3vU9eDVaugyovL1FJMPbrgXKokQNlqAQevLZgmzDCl2aknq2dgNxhjA
 h/j1ZAWqFFXrpd62ntGfmMaXX2SyGTpneB9rJ47egALZo2lXuqY+bHnxNUKajLHJoV9SfVYgxux
 myxewmqBUBmJA8FXtTjguqwdGxtF5iFbWtW6+HNEwCcY109lNthgo8omZbfDC4QOv9jc2+eUAGT
 pS6eOJ6X0ehJAUa0f9Fz2PjQeZkZBnG/MAP5pW+JQOpEB4UL
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit d6d6c513f5d2 ("ASoC: dwc: Use ops to get platform data")
converted the DesignWare I2S driver to use a DT specific function to
obtain platform data but this breaks at least non-DT systems such as
AMD.  Revert it.

Fixes: d6d6c513f5d2 ("ASoC: dwc: Use ops to get platform data")
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/dwc/dwc-i2s.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/dwc/dwc-i2s.c b/sound/soc/dwc/dwc-i2s.c
index 2ff619a29655..c04466f5492e 100644
--- a/sound/soc/dwc/dwc-i2s.c
+++ b/sound/soc/dwc/dwc-i2s.c
@@ -917,7 +917,7 @@ static int jh7110_i2stx0_clk_cfg(struct i2s_clk_config_data *config)
 
 static int dw_i2s_probe(struct platform_device *pdev)
 {
-	const struct i2s_platform_data *pdata = of_device_get_match_data(&pdev->dev);
+	const struct i2s_platform_data *pdata = pdev->dev.platform_data;
 	struct dw_i2s_dev *dev;
 	struct resource *res;
 	int ret, irq;

---
base-commit: fbfe616ad40c06d68b83b657a94cd2e709dda37b
change-id: 20231013-asoc-fix-dwc-06294a3d3675

Best regards,
-- 
Mark Brown <broonie@kernel.org>

