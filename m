Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 555017B6D9A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 17:58:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240211AbjJCP6q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 11:58:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239313AbjJCP6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 11:58:36 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4864CA9;
        Tue,  3 Oct 2023 08:58:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCFF8C433CA;
        Tue,  3 Oct 2023 15:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696348710;
        bh=4jGYbmV8EJoY522y4EajfuW6yY4prtu1gNkYioxbOz0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r4GvB9l3roUiywzVyJxzJ5uLnUEzfKgtkuDutPXFUICPpDB3Bcb3b2M2TYdlDNyTD
         oyc+gtSFiZmv17z9VQh44DCXS3aQf3wEL0VsCUylPSOgOF+nWv3GVgJojBAkBs21ud
         dULh4ILK5n4I4vWafbd6Hv73EQwYO18K+BO0AN6ckk4CN630pEtvrSzsq+VUrUwJYj
         8cPX913lhzpZRKndwQDwguaOWxSV6RVwnp7onLz/S8Ljw297slyioRz2wTYN+Q3nuZ
         BHRTxf2yBmKVXzTJifJVupbnZpQtC0feBGC8dMHM50StfFWsDNCRbp/YAYSHLKtM7q
         NfmNE3J/0LKKg==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan+linaro@kernel.org>)
        id 1qnhnG-00074r-0P;
        Tue, 03 Oct 2023 17:58:42 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>, stable@vger.kernel.org
Subject: [PATCH 3/7] ASoC: codecs: wcd938x: fix resource leaks on bind errors
Date:   Tue,  3 Oct 2023 17:55:54 +0200
Message-ID: <20231003155558.27079-4-johan+linaro@kernel.org>
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

Add the missing code to release resources on bind errors, including the
references taken by wcd938x_sdw_device_get() which also need to be
dropped on unbind().

Fixes: 16572522aece ("ASoC: codecs: wcd938x-sdw: add SoundWire driver")
Cc: stable@vger.kernel.org      # 5.14
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 sound/soc/codecs/wcd938x.c | 44 +++++++++++++++++++++++++++++---------
 1 file changed, 34 insertions(+), 10 deletions(-)

diff --git a/sound/soc/codecs/wcd938x.c b/sound/soc/codecs/wcd938x.c
index c617fc3ce489..7e0b07eeed77 100644
--- a/sound/soc/codecs/wcd938x.c
+++ b/sound/soc/codecs/wcd938x.c
@@ -3435,7 +3435,8 @@ static int wcd938x_bind(struct device *dev)
 	wcd938x->rxdev = wcd938x_sdw_device_get(wcd938x->rxnode);
 	if (!wcd938x->rxdev) {
 		dev_err(dev, "could not find slave with matching of node\n");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto err_unbind;
 	}
 	wcd938x->sdw_priv[AIF1_PB] = dev_get_drvdata(wcd938x->rxdev);
 	wcd938x->sdw_priv[AIF1_PB]->wcd938x = wcd938x;
@@ -3443,7 +3444,8 @@ static int wcd938x_bind(struct device *dev)
 	wcd938x->txdev = wcd938x_sdw_device_get(wcd938x->txnode);
 	if (!wcd938x->txdev) {
 		dev_err(dev, "could not find txslave with matching of node\n");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto err_put_rxdev;
 	}
 	wcd938x->sdw_priv[AIF1_CAP] = dev_get_drvdata(wcd938x->txdev);
 	wcd938x->sdw_priv[AIF1_CAP]->wcd938x = wcd938x;
@@ -3454,31 +3456,35 @@ static int wcd938x_bind(struct device *dev)
 	if (!device_link_add(wcd938x->rxdev, wcd938x->txdev, DL_FLAG_STATELESS |
 			    DL_FLAG_PM_RUNTIME)) {
 		dev_err(dev, "could not devlink tx and rx\n");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto err_put_txdev;
 	}
 
 	if (!device_link_add(dev, wcd938x->txdev, DL_FLAG_STATELESS |
 					DL_FLAG_PM_RUNTIME)) {
 		dev_err(dev, "could not devlink wcd and tx\n");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto err_remove_rxtx_link;
 	}
 
 	if (!device_link_add(dev, wcd938x->rxdev, DL_FLAG_STATELESS |
 					DL_FLAG_PM_RUNTIME)) {
 		dev_err(dev, "could not devlink wcd and rx\n");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto err_remove_tx_link;
 	}
 
 	wcd938x->regmap = dev_get_regmap(&wcd938x->tx_sdw_dev->dev, NULL);
 	if (!wcd938x->regmap) {
 		dev_err(dev, "could not get TX device regmap\n");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto err_remove_rx_link;
 	}
 
 	ret = wcd938x_irq_init(wcd938x, dev);
 	if (ret) {
 		dev_err(dev, "%s: IRQ init failed: %d\n", __func__, ret);
-		return ret;
+		goto err_remove_rx_link;
 	}
 
 	wcd938x->sdw_priv[AIF1_PB]->slave_irq = wcd938x->virq;
@@ -3487,17 +3493,33 @@ static int wcd938x_bind(struct device *dev)
 	ret = wcd938x_set_micbias_data(wcd938x);
 	if (ret < 0) {
 		dev_err(dev, "%s: bad micbias pdata\n", __func__);
-		return ret;
+		goto err_remove_rx_link;
 	}
 
 	ret = snd_soc_register_component(dev, &soc_codec_dev_wcd938x,
 					 wcd938x_dais, ARRAY_SIZE(wcd938x_dais));
-	if (ret)
+	if (ret) {
 		dev_err(dev, "%s: Codec registration failed\n",
 				__func__);
+		goto err_remove_rx_link;
+	}
 
-	return ret;
+	return 0;
 
+err_remove_rx_link:
+	device_link_remove(dev, wcd938x->rxdev);
+err_remove_tx_link:
+	device_link_remove(dev, wcd938x->txdev);
+err_remove_rxtx_link:
+	device_link_remove(wcd938x->rxdev, wcd938x->txdev);
+err_put_txdev:
+	put_device(wcd938x->txdev);
+err_put_rxdev:
+	put_device(wcd938x->rxdev);
+err_unbind:
+	component_unbind_all(dev, wcd938x);
+
+	return ret;
 }
 
 static void wcd938x_unbind(struct device *dev)
@@ -3508,6 +3530,8 @@ static void wcd938x_unbind(struct device *dev)
 	device_link_remove(dev, wcd938x->txdev);
 	device_link_remove(dev, wcd938x->rxdev);
 	device_link_remove(wcd938x->rxdev, wcd938x->txdev);
+	put_device(wcd938x->txdev);
+	put_device(wcd938x->rxdev);
 	component_unbind_all(dev, wcd938x);
 }
 
-- 
2.41.0

