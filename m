Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D277175C243
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 10:58:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbjGUI6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 04:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbjGUI5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 04:57:50 -0400
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA1CC30C0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 01:57:48 -0700 (PDT)
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 53C102004DB;
        Fri, 21 Jul 2023 10:57:47 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 1AFC02004B5;
        Fri, 21 Jul 2023 10:57:47 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id B7DF21820F57;
        Fri, 21 Jul 2023 16:57:45 +0800 (+08)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, ckeepax@opensource.cirrus.com,
        kuninori.morimoto.gx@renesas.com, patches@opensource.cirrus.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] ASoC: wm8960: Add DAC filter characteristics selection
Date:   Fri, 21 Jul 2023 16:24:02 +0800
Message-Id: <1689927842-21165-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support DAC filter characteristics selection: Normal mode
and Sloping stopband. Sloping stopband may have
better frequency response.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
changes in v2:
- modify capitalise

 sound/soc/codecs/wm8960.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/codecs/wm8960.c b/sound/soc/codecs/wm8960.c
index 366f5d769d6d..5db9b0338396 100644
--- a/sound/soc/codecs/wm8960.c
+++ b/sound/soc/codecs/wm8960.c
@@ -155,6 +155,7 @@ static const char *wm8960_adc_data_output_sel[] = {
 	"Left Data = Right ADC; Right Data = Left ADC",
 };
 static const char *wm8960_dmonomix[] = {"Stereo", "Mono"};
+static const char *wm8960_dacslope[] = {"Normal", "Sloping"};
 
 static const struct soc_enum wm8960_enum[] = {
 	SOC_ENUM_SINGLE(WM8960_DACCTL1, 5, 4, wm8960_polarity),
@@ -165,6 +166,7 @@ static const struct soc_enum wm8960_enum[] = {
 	SOC_ENUM_SINGLE(WM8960_ALC3, 8, 2, wm8960_alcmode),
 	SOC_ENUM_SINGLE(WM8960_ADDCTL1, 2, 4, wm8960_adc_data_output_sel),
 	SOC_ENUM_SINGLE(WM8960_ADDCTL1, 4, 2, wm8960_dmonomix),
+	SOC_ENUM_SINGLE(WM8960_DACCTL2, 1, 2, wm8960_dacslope),
 };
 
 static const int deemph_settings[] = { 0, 32000, 44100, 48000 };
@@ -307,6 +309,7 @@ SOC_SINGLE_TLV("Right Output Mixer RINPUT3 Volume",
 
 SOC_ENUM("ADC Data Output Select", wm8960_enum[6]),
 SOC_ENUM("DAC Mono Mix", wm8960_enum[7]),
+SOC_ENUM("DAC Filter Characteristics", wm8960_enum[8]),
 };
 
 static const struct snd_kcontrol_new wm8960_lin_boost[] = {
-- 
2.34.1

