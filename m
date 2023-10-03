Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D2B07B6DA2
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 17:58:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240192AbjJCP6x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 11:58:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239352AbjJCP6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 11:58:36 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49176AD;
        Tue,  3 Oct 2023 08:58:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E279DC433CC;
        Tue,  3 Oct 2023 15:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696348710;
        bh=0qc7/9y/unJJylgNAX3JbS8b4NM02Ln9LHqplyR4wyU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I/uNHvQsrULhHsQWc04qSOzIBUXExGDZ4pciHPiv2KV5h6AgsAi2a8IfizwFLrUaj
         WAv+yqUyQj0XpaLVX96MhM4imcZ0susNTT7GGTogrCIio/+MhDU2KUaLpejxWpBRCD
         OxDCnn6A3KQjuAfUAYUu2S2yG5A78yy8MvUvLXxTwNLk+fAjoIwD1sDcXs6+vES5U/
         ADFo/sjBsipBAjVUPMYWdbBGKiJG2NxoSzgW8vDilA52fmH2+ujNbwdzwqpOfRbEIx
         C5xFZe8Jst6b0gXhmJOT7e/abhVkk4FZ2xpXgupMtHxSY/AtpU6nbC8PnQg3Jet29H
         wb1OP+QBLe+qQ==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan+linaro@kernel.org>)
        id 1qnhnG-00074w-0q;
        Tue, 03 Oct 2023 17:58:42 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>, stable@vger.kernel.org
Subject: [PATCH 5/7] ASoC: codecs: wcd938x: fix runtime PM imbalance on remove
Date:   Tue,  3 Oct 2023 17:55:56 +0200
Message-ID: <20231003155558.27079-6-johan+linaro@kernel.org>
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

Make sure to balance the runtime PM operations, including the disable
count, on driver unbind.

Fixes: 16572522aece ("ASoC: codecs: wcd938x-sdw: add SoundWire driver")
Cc: stable@vger.kernel.org      # 5.14
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 sound/soc/codecs/wcd938x.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wcd938x.c b/sound/soc/codecs/wcd938x.c
index 679c627f7eaa..d27b919c63b4 100644
--- a/sound/soc/codecs/wcd938x.c
+++ b/sound/soc/codecs/wcd938x.c
@@ -3620,9 +3620,15 @@ static int wcd938x_probe(struct platform_device *pdev)
 
 static void wcd938x_remove(struct platform_device *pdev)
 {
-	struct wcd938x_priv *wcd938x = dev_get_drvdata(&pdev->dev);
+	struct device *dev = &pdev->dev;
+	struct wcd938x_priv *wcd938x = dev_get_drvdata(dev);
+
+	component_master_del(dev, &wcd938x_comp_ops);
+
+	pm_runtime_disable(dev);
+	pm_runtime_set_suspended(dev);
+	pm_runtime_dont_use_autosuspend(dev);
 
-	component_master_del(&pdev->dev, &wcd938x_comp_ops);
 	regulator_bulk_disable(WCD938X_MAX_SUPPLY, wcd938x->supplies);
 	regulator_bulk_free(WCD938X_MAX_SUPPLY, wcd938x->supplies);
 }
-- 
2.41.0

