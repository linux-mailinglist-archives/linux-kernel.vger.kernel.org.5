Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8D7975C7A6
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 15:22:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231357AbjGUNW3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 09:22:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230421AbjGUNWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 09:22:16 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5747C35BD
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 06:21:42 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 36L7lwWp024208;
        Fri, 21 Jul 2023 08:21:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        PODMain02222019; bh=c6QsHYmtyBqfdIoU+pRVAEHn06ODVZeQEQGmwea9Ug4=; b=
        k36hvTENNX5X2cZOZYaSVwF4Rxe1qM0ABqL/JgrELp4fyccCITLF2+gYhtKpXDYt
        qEGTMyelHHfnPg8v60dq6ppp+O35M7RUnz+Xe2pohIvz7DO+uAFHQg20c2rMH31M
        S4tEbsH+XXKWaQhNzTUUqtAl6MAgyEqrKuZ//Xcp0Tzf13kX2wT9xVymXrTFDuxR
        7inBTqZcf9cRIJixhYH1FA/wkVzSG3eS3J9hB6qSolMV9ryJIztxZPACnjakhIP6
        7MstNL+3eXM+7s0BGovQuaWsKXPIOyVZJvO/8la2L3yE1cbuUNP8ooSzylMep+2f
        k0Jktsv3RclT7MGqL24Dew==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3rus6gyj2u-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Jul 2023 08:21:29 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Fri, 21 Jul
 2023 14:21:26 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.30 via Frontend
 Transport; Fri, 21 Jul 2023 14:21:26 +0100
Received: from work-debian.ad.cirrus.com (unknown [198.61.64.172])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id E253215B6;
        Fri, 21 Jul 2023 13:21:25 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>, <tiwai@suse.com>
CC:     <perex@perex.cz>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH v5 06/11] ASoC: cs35l56: Move cs_dsp init into shared library
Date:   Fri, 21 Jul 2023 14:21:15 +0100
Message-ID: <20230721132120.5523-7-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230721132120.5523-1-rf@opensource.cirrus.com>
References: <20230721132120.5523-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 5SU-H0dEhfF74G_vqaIMFcaTV035bMPQ
X-Proofpoint-GUID: 5SU-H0dEhfF74G_vqaIMFcaTV035bMPQ
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the code that initialized the struct cs_dsp members
into the shared library so that the HDA driver can use it.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Acked-by: Mark Brown <broonie@kernel.org>
---
 include/sound/cs35l56.h           |  2 +-
 sound/soc/codecs/cs35l56-shared.c | 18 ++++++++++++++++--
 sound/soc/codecs/cs35l56.c        | 11 +----------
 3 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/include/sound/cs35l56.h b/include/sound/cs35l56.h
index e48f662dcbce..6ab12e2035cd 100644
--- a/include/sound/cs35l56.h
+++ b/include/sound/cs35l56.h
@@ -269,7 +269,6 @@ extern struct regmap_config cs35l56_regmap_i2c;
 extern struct regmap_config cs35l56_regmap_spi;
 extern struct regmap_config cs35l56_regmap_sdw;
 
-extern const struct cs_dsp_region cs35l56_dsp1_regions[CS35L56_NUM_DSP_REGIONS];
 extern const char * const cs35l56_tx_input_texts[CS35L56_NUM_INPUT_SRC];
 extern const unsigned int cs35l56_tx_input_values[CS35L56_NUM_INPUT_SRC];
 
@@ -283,6 +282,7 @@ irqreturn_t cs35l56_irq(int irq, void *data);
 int cs35l56_is_fw_reload_needed(struct cs35l56_base *cs35l56_base);
 int cs35l56_runtime_suspend_common(struct cs35l56_base *cs35l56_base);
 int cs35l56_runtime_resume_common(struct cs35l56_base *cs35l56_base, bool is_soundwire);
+void cs35l56_init_cs_dsp(struct cs35l56_base *cs35l56_base, struct cs_dsp *cs_dsp);
 int cs35l56_get_bclk_freq_id(unsigned int freq);
 void cs35l56_fill_supply_names(struct regulator_bulk_data *data);
 
diff --git a/sound/soc/codecs/cs35l56-shared.c b/sound/soc/codecs/cs35l56-shared.c
index 737a9ea27495..fe8df04951f3 100644
--- a/sound/soc/codecs/cs35l56-shared.c
+++ b/sound/soc/codecs/cs35l56-shared.c
@@ -521,14 +521,28 @@ int cs35l56_runtime_resume_common(struct cs35l56_base *cs35l56_base, bool is_sou
 }
 EXPORT_SYMBOL_NS_GPL(cs35l56_runtime_resume_common, SND_SOC_CS35L56_SHARED);
 
-const struct cs_dsp_region cs35l56_dsp1_regions[] = {
+static const struct cs_dsp_region cs35l56_dsp1_regions[] = {
 	{ .type = WMFW_HALO_PM_PACKED,	.base = CS35L56_DSP1_PMEM_0 },
 	{ .type = WMFW_HALO_XM_PACKED,	.base = CS35L56_DSP1_XMEM_PACKED_0 },
 	{ .type = WMFW_HALO_YM_PACKED,	.base = CS35L56_DSP1_YMEM_PACKED_0 },
 	{ .type = WMFW_ADSP2_XM,	.base = CS35L56_DSP1_XMEM_UNPACKED24_0 },
 	{ .type = WMFW_ADSP2_YM,	.base = CS35L56_DSP1_YMEM_UNPACKED24_0 },
 };
-EXPORT_SYMBOL_NS_GPL(cs35l56_dsp1_regions, SND_SOC_CS35L56_SHARED);
+
+void cs35l56_init_cs_dsp(struct cs35l56_base *cs35l56_base, struct cs_dsp *cs_dsp)
+{
+	cs_dsp->num = 1;
+	cs_dsp->type = WMFW_HALO;
+	cs_dsp->rev = 0;
+	cs_dsp->dev = cs35l56_base->dev;
+	cs_dsp->regmap = cs35l56_base->regmap;
+	cs_dsp->base = CS35L56_DSP1_CORE_BASE;
+	cs_dsp->base_sysinfo = CS35L56_DSP1_SYS_INFO_ID;
+	cs_dsp->mem = cs35l56_dsp1_regions;
+	cs_dsp->num_mems = ARRAY_SIZE(cs35l56_dsp1_regions);
+	cs_dsp->no_core_startstop = true;
+}
+EXPORT_SYMBOL_NS_GPL(cs35l56_init_cs_dsp, SND_SOC_CS35L56_SHARED);
 
 static const u32 cs35l56_bclk_valid_for_pll_freq_table[] = {
 	[0x0C] = 128000,
diff --git a/sound/soc/codecs/cs35l56.c b/sound/soc/codecs/cs35l56.c
index 701f1072a609..430829f8a320 100644
--- a/sound/soc/codecs/cs35l56.c
+++ b/sound/soc/codecs/cs35l56.c
@@ -1016,18 +1016,9 @@ static int cs35l56_dsp_init(struct cs35l56_private *cs35l56)
 	INIT_WORK(&cs35l56->dsp_work, cs35l56_dsp_work);
 
 	dsp = &cs35l56->dsp;
+	cs35l56_init_cs_dsp(&cs35l56->base, &dsp->cs_dsp);
 	dsp->part = "cs35l56";
-	dsp->cs_dsp.num = 1;
-	dsp->cs_dsp.type = WMFW_HALO;
-	dsp->cs_dsp.rev = 0;
 	dsp->fw = 12;
-	dsp->cs_dsp.dev = cs35l56->base.dev;
-	dsp->cs_dsp.regmap = cs35l56->base.regmap;
-	dsp->cs_dsp.base = CS35L56_DSP1_CORE_BASE;
-	dsp->cs_dsp.base_sysinfo = CS35L56_DSP1_SYS_INFO_ID;
-	dsp->cs_dsp.mem = cs35l56_dsp1_regions;
-	dsp->cs_dsp.num_mems = ARRAY_SIZE(cs35l56_dsp1_regions);
-	dsp->cs_dsp.no_core_startstop = true;
 	dsp->wmfw_optional = true;
 
 	dev_dbg(cs35l56->base.dev, "DSP system name: '%s'\n", dsp->system_name);
-- 
2.30.2

