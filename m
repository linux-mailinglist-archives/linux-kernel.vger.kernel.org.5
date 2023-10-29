Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 793177DAFFE
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 00:01:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231453AbjJ2XBo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 19:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230449AbjJ2XB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 19:01:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0F7B1FC2;
        Sun, 29 Oct 2023 15:58:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0F1AC4167E;
        Sun, 29 Oct 2023 22:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698620291;
        bh=I75dT+BpB934kNxmKXsCPFa+j1/Qlrodb8hUDyZG7FY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=io5y1OIFonc7nUKhBg1jItAJVZbZxKdmegf7jb5Hm8bfM8qjk0gI9wP4w2WyJvftt
         73HiRGbVan5xfv2mvLib0xxnoFfSC5sCdwq11F0IduxRh2QdI64lXj8OF4mJLi3hN7
         UjVZnfKZ/qVhQw+IG8s4y5civ3XNMZviQ23rFA1tNIJ5WYChj2RzpDRXi+RNh0LUK9
         WpTb5ootMnnflKvakQw1Fc12wdlP4v1tQFIZEqKtGn3e7A4puZI0rCdfaAnnCBTakT
         tDx7NqGrxcmMUi36IPzZ1Ul0pGpNcjVg9N9qwsaXlA+Lib2bLkZ0pTIciSPzdmqDLA
         aFpXtg/hfn+RA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Roy Chateau <roy.chateau@mep-info.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, shenghao-ding@ti.com,
        kevin-lu@ti.com, baojun.xu@ti.com, lgirdwood@gmail.com,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 6.1 21/39] ASoC: codecs: tas2780: Fix log of failed reset via I2C.
Date:   Sun, 29 Oct 2023 18:56:53 -0400
Message-ID: <20231029225740.790936-21-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231029225740.790936-1-sashal@kernel.org>
References: <20231029225740.790936-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.60
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roy Chateau <roy.chateau@mep-info.com>

[ Upstream commit 4e9a429ae80657bdc502d3f5078e2073656ec5fd ]

Correctly log failures of reset via I2C.

Signed-off-by: Roy Chateau <roy.chateau@mep-info.com>
Link: https://lore.kernel.org/r/20231013110239.473123-1-roy.chateau@mep-info.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/tas2780.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/tas2780.c b/sound/soc/codecs/tas2780.c
index afdf0c863aa10..a2d27410bbefa 100644
--- a/sound/soc/codecs/tas2780.c
+++ b/sound/soc/codecs/tas2780.c
@@ -39,7 +39,7 @@ static void tas2780_reset(struct tas2780_priv *tas2780)
 		usleep_range(2000, 2050);
 	}
 
-	snd_soc_component_write(tas2780->component, TAS2780_SW_RST,
+	ret = snd_soc_component_write(tas2780->component, TAS2780_SW_RST,
 				TAS2780_RST);
 	if (ret)
 		dev_err(tas2780->dev, "%s:errCode:0x%x Reset error!\n",
-- 
2.42.0

