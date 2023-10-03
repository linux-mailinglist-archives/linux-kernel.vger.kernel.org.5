Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59FC07B6DA3
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 17:58:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240202AbjJCP6o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 11:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239326AbjJCP6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 11:58:36 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6F76A7;
        Tue,  3 Oct 2023 08:58:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8803C433CD;
        Tue,  3 Oct 2023 15:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696348711;
        bh=arWViVOFJ+xLCsEMqdnO3mqzkm5NiZn0WEmyp7nWPzo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fdZAqcOy0KP/1cr8Dv8F6l+6h8ksFQsBPP12k3onVO1ieCNudGaxOedU6ik3VEBBx
         4Ckn4Wbd2Wdeq5/W9/Xp9Tmqaoqa5VJWlE4w8wWGO6fyvAuVl2u+xJsfIqT12CEILu
         Ps94+ShHf2JoB1r3E5EiHJ2sOWZjLYt3VuWg1YX59PWJUnB7P1binntFq+AAyd49Fb
         kXaqj2NFC1a+2/vrKRuJYYrn0cNz1OONGr8WiPnm8SXn5VtBg7WjlpAKUoPl3pfXSS
         PUkFepwIa/Mtv9jdJql495Fp6Geab+hH4YkrxCSg4htN5oxw7wesRjeuOgoBfryR/s
         wuewWIIxkdDGg==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan+linaro@kernel.org>)
        id 1qnhnG-00074t-0c;
        Tue, 03 Oct 2023 17:58:42 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>, stable@vger.kernel.org
Subject: [PATCH 4/7] ASoC: codecs: wcd938x: fix regulator leaks on probe errors
Date:   Tue,  3 Oct 2023 17:55:55 +0200
Message-ID: <20231003155558.27079-5-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231003155558.27079-1-johan+linaro@kernel.org>
References: <20231003155558.27079-1-johan+linaro@kernel.org>
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

Make sure to disable and free the regulators on probe errors and on
driver unbind.

Fixes: 16572522aece ("ASoC: codecs: wcd938x-sdw: add SoundWire driver")
Cc: stable@vger.kernel.org      # 5.14
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 sound/soc/codecs/wcd938x.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/wcd938x.c b/sound/soc/codecs/wcd938x.c
index 7e0b07eeed77..679c627f7eaa 100644
--- a/sound/soc/codecs/wcd938x.c
+++ b/sound/soc/codecs/wcd938x.c
@@ -3325,8 +3325,10 @@ static int wcd938x_populate_dt_data(struct wcd938x_priv *wcd938x, struct device
 		return dev_err_probe(dev, ret, "Failed to get supplies\n");
 
 	ret = regulator_bulk_enable(WCD938X_MAX_SUPPLY, wcd938x->supplies);
-	if (ret)
+	if (ret) {
+		regulator_bulk_free(WCD938X_MAX_SUPPLY, wcd938x->supplies);
 		return dev_err_probe(dev, ret, "Failed to enable supplies\n");
+	}
 
 	wcd938x_dt_parse_micbias_info(dev, wcd938x);
 
@@ -3592,13 +3594,13 @@ static int wcd938x_probe(struct platform_device *pdev)
 
 	ret = wcd938x_add_slave_components(wcd938x, dev, &match);
 	if (ret)
-		return ret;
+		goto err_disable_regulators;
 
 	wcd938x_reset(wcd938x);
 
 	ret = component_master_add_with_match(dev, &wcd938x_comp_ops, match);
 	if (ret)
-		return ret;
+		goto err_disable_regulators;
 
 	pm_runtime_set_autosuspend_delay(dev, 1000);
 	pm_runtime_use_autosuspend(dev);
@@ -3608,11 +3610,21 @@ static int wcd938x_probe(struct platform_device *pdev)
 	pm_runtime_idle(dev);
 
 	return 0;
+
+err_disable_regulators:
+	regulator_bulk_disable(WCD938X_MAX_SUPPLY, wcd938x->supplies);
+	regulator_bulk_free(WCD938X_MAX_SUPPLY, wcd938x->supplies);
+
+	return ret;
 }
 
 static void wcd938x_remove(struct platform_device *pdev)
 {
+	struct wcd938x_priv *wcd938x = dev_get_drvdata(&pdev->dev);
+
 	component_master_del(&pdev->dev, &wcd938x_comp_ops);
+	regulator_bulk_disable(WCD938X_MAX_SUPPLY, wcd938x->supplies);
+	regulator_bulk_free(WCD938X_MAX_SUPPLY, wcd938x->supplies);
 }
 
 #if defined(CONFIG_OF)
-- 
2.41.0

