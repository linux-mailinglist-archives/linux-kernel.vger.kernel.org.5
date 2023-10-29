Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1C8D7DB075
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 00:06:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231756AbjJ2XG4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 19:06:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232147AbjJ2XGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 19:06:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 921915FDC;
        Sun, 29 Oct 2023 16:00:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C03E8C4163C;
        Sun, 29 Oct 2023 22:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698620374;
        bh=Xk3/KL1/p/7aPW6+tG0rfglenLkveedb3INbBGFMFs4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SIQDVKCAUsmWG7V4E7dhkZ8TQaTcNSFKLD/BtBgfSK6lMk82IdyQy7quAP6KjyCXa
         y6O9P+wfTo236GiJ3RsLinuEXbED0ZqBz3aI5M0Evsw3nrH0qn7+sIVHlq5ZJXmJcQ
         raqGguXiEPxeZH6++v+AKRckAOWNPwW3TrE8yRiEBhfKwJaWrx3EgDrek4xBlGnchp
         RMzuw60voiDkGmm50pxZtFEaefg8jXacphSub6xrJmAH6Csfur4vuLXSxUH+tZswla
         /9izNVJNViie9YaDYBA9eDXpCOrmYARU7nigGPpfljNKXbkPOIbmkz1PPLLtnSc+Nw
         gX17ipzr8+Uyg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        srinivas.kandagatla@linaro.org, bgoswami@quicinc.com,
        lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 5.15 13/28] ASoC: codecs: wsa-macro: handle component name prefix
Date:   Sun, 29 Oct 2023 18:58:48 -0400
Message-ID: <20231029225916.791798-13-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231029225916.791798-1-sashal@kernel.org>
References: <20231029225916.791798-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.137
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

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

[ Upstream commit c29e5263d32a6d0ec094d425ae7fef3fa8d4da1c ]

When comparing widget names in wsa_macro_spk_boost_event(), consider
also the component's name prefix.  Otherwise the WSA codec won't have
proper mixer setup resulting in no sound playback through speakers.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://lore.kernel.org/r/20231003155710.821315-3-krzysztof.kozlowski@linaro.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/lpass-wsa-macro.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/lpass-wsa-macro.c b/sound/soc/codecs/lpass-wsa-macro.c
index dd1a8b7bc794c..643ddf7dd6c5d 100644
--- a/sound/soc/codecs/lpass-wsa-macro.c
+++ b/sound/soc/codecs/lpass-wsa-macro.c
@@ -1668,12 +1668,12 @@ static int wsa_macro_spk_boost_event(struct snd_soc_dapm_widget *w,
 	u16 boost_path_ctl, boost_path_cfg1;
 	u16 reg, reg_mix;
 
-	if (!strcmp(w->name, "WSA_RX INT0 CHAIN")) {
+	if (!snd_soc_dapm_widget_name_cmp(w, "WSA_RX INT0 CHAIN")) {
 		boost_path_ctl = CDC_WSA_BOOST0_BOOST_PATH_CTL;
 		boost_path_cfg1 = CDC_WSA_RX0_RX_PATH_CFG1;
 		reg = CDC_WSA_RX0_RX_PATH_CTL;
 		reg_mix = CDC_WSA_RX0_RX_PATH_MIX_CTL;
-	} else if (!strcmp(w->name, "WSA_RX INT1 CHAIN")) {
+	} else if (!snd_soc_dapm_widget_name_cmp(w, "WSA_RX INT1 CHAIN")) {
 		boost_path_ctl = CDC_WSA_BOOST1_BOOST_PATH_CTL;
 		boost_path_cfg1 = CDC_WSA_RX1_RX_PATH_CFG1;
 		reg = CDC_WSA_RX1_RX_PATH_CTL;
-- 
2.42.0

