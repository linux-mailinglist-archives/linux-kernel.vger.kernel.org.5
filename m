Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B16F37AFA3D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 07:45:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbjI0Fp0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 01:45:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbjI0Foy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 01:44:54 -0400
Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CE99A5FD7
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 19:07:00 -0700 (PDT)
X-MailGates: (SIP:2,PASS,NONE)(compute_score:DELIVER,40,3)
Received: from 192.168.10.46
        by mg.richtek.com with MailGates ESMTPS Server V6.0(1978105:0:AUTH_RELAY)
        (envelope-from <cy_huang@richtek.com>)
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256/256); Wed, 27 Sep 2023 10:06:17 +0800 (CST)
Received: from ex4.rt.l (192.168.10.47) by ex3.rt.l (192.168.10.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.25; Wed, 27 Sep
 2023 10:06:17 +0800
Received: from linuxcarl2.richtek.com (192.168.10.154) by ex4.rt.l
 (192.168.10.45) with Microsoft SMTP Server id 15.2.1118.25 via Frontend
 Transport; Wed, 27 Sep 2023 10:06:17 +0800
From:   <cy_huang@richtek.com>
To:     Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>
CC:     ChiYuan Huang <cy_huang@richtek.com>,
        Allen Lin <allen_lin@richtek.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] ASoC: codecs: rtq9128: Add TDM data source selection
Date:   Wed, 27 Sep 2023 10:06:16 +0800
Message-ID: <1695780376-32301-1-git-send-email-cy_huang@richtek.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChiYuan Huang <cy_huang@richtek.com>

Since rtq9128 can support 4 channel I2S mode audio data, there are two
dedicated data input pins for CH12 and CH34.  But in TDM mode, input
source was already drived on one data pin for multiple data slots. In
this case, only one input source is needed for TDM mode.

This patch is to add the data source pin selection for CH12 and CH34.

Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
---
 sound/soc/codecs/rtq9128.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/sound/soc/codecs/rtq9128.c b/sound/soc/codecs/rtq9128.c
index 926b79ed8078..3cf613c6900e 100644
--- a/sound/soc/codecs/rtq9128.c
+++ b/sound/soc/codecs/rtq9128.c
@@ -225,6 +225,7 @@ static const char * const phase_select_text[] = {
 	"180 degree",	"225 degree",	"270 degree",	"315 degree",
 };
 static const char * const dvdduv_select_text[] = { "1P4V", "1P5V", "2P1V", "2P3V" };
+static const char * const tdm_data_select_text[] = { "DATA1", "DATA2" };
 
 static const struct soc_enum rtq9128_ch1_si_enum =
 	SOC_ENUM_SINGLE(RTQ9128_REG_SDI_SEL, 6, ARRAY_SIZE(source_select_text), source_select_text);
@@ -246,6 +247,12 @@ static const struct soc_enum rtq9128_out3_phase_enum =
 static const struct soc_enum rtq9128_out4_phase_enum =
 	SOC_ENUM_SINGLE(RTQ9128_REG_PLLTRI_GEN2, 0, ARRAY_SIZE(phase_select_text),
 			phase_select_text);
+static const struct soc_enum rtq9128_ch12_tdm_data_select_enum =
+	SOC_ENUM_SINGLE(RTQ9128_REG_SDO_SEL, 5, ARRAY_SIZE(tdm_data_select_text),
+			tdm_data_select_text);
+static const struct soc_enum rtq9128_ch34_tdm_data_select_enum =
+	SOC_ENUM_SINGLE(RTQ9128_REG_SDO_SEL, 4, ARRAY_SIZE(tdm_data_select_text),
+			tdm_data_select_text);
 
 /*
  * In general usage, DVDD could be 1P8V, 3P0V or 3P3V.
@@ -277,6 +284,8 @@ static const struct snd_kcontrol_new rtq9128_snd_ctrls[] = {
 	SOC_ENUM("OUT3 Phase Select", rtq9128_out3_phase_enum),
 	SOC_ENUM("OUT4 Phase Select", rtq9128_out4_phase_enum),
 	SOC_ENUM("DVDD UV Threshold Select", rtq9128_dvdduv_select_enum),
+	SOC_ENUM("CH12 TDM Data Select", rtq9128_ch12_tdm_data_select_enum),
+	SOC_ENUM("CH34 TDM Data Select", rtq9128_ch34_tdm_data_select_enum),
 };
 
 static int rtq9128_dac_power_event(struct snd_soc_dapm_widget *w, struct snd_kcontrol *kcontrol,

base-commit: c351835058419c1eb8791941a057c3f3e6068cb6
-- 
2.34.1

