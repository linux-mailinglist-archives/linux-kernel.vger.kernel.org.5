Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B5E675C7A4
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 15:22:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230503AbjGUNWW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 09:22:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231315AbjGUNWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 09:22:14 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9744135AC
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 06:21:41 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 36L7lwWm024208;
        Fri, 21 Jul 2023 08:21:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        PODMain02222019; bh=72jaUi8LQGupqb0rDYD3gpQ7cU92GTLGM5/DEejZRHs=; b=
        NPgaERWHxJgo65xs+vpCWC45ykbGBwhYuWix2A1caSC2JMMYSLZbKFmLaoD9rQcA
        7bDpdYBCqd3RY3s54UIqgpqqHLWSmo7Njtf2OUxz2q0qSRoYJOzuTUfD9PoZTflT
        H1bhptr+qtiP0Rk7PP+vK+rXF4AGMZS/jFji2o6a9R3uN0sVGVgFi/sMjjIHtg7S
        7VbC2toKJdjXQYBzABCDxAM0McjCE1C1qFaL50/0RbD77cNoNXM5HXOPAALH0yhH
        ASTtaL2dcEg8uzuFd1XZ3U96LZAMeCpfBcz4t2kyzCZcYsusbJTG61iP/YMeZgRM
        Qa4MDPV10g9aYbXSzxFzYQ==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3rus6gyj2u-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Jul 2023 08:21:26 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Fri, 21 Jul
 2023 14:21:24 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.30 via Frontend Transport; Fri, 21 Jul 2023 14:21:24 +0100
Received: from work-debian.ad.cirrus.com (unknown [198.61.64.172])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 79EB515B6;
        Fri, 21 Jul 2023 13:21:24 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>, <tiwai@suse.com>
CC:     <perex@perex.cz>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        Simon Trimmer <simont@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH v5 03/11] ASoC: cs35l56: Convert utility functions to use common data structure
Date:   Fri, 21 Jul 2023 14:21:12 +0100
Message-ID: <20230721132120.5523-4-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230721132120.5523-1-rf@opensource.cirrus.com>
References: <20230721132120.5523-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: jxbwaBapaFciCsqhqApgJW-vJr5Z41Ry
X-Proofpoint-GUID: jxbwaBapaFciCsqhqApgJW-vJr5Z41Ry
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

From: Simon Trimmer <simont@opensource.cirrus.com>

Use the new cs35l56_base struct for utility functions.

Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>
Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Acked-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/cs35l56.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/sound/soc/codecs/cs35l56.c b/sound/soc/codecs/cs35l56.c
index 7a83e388e869..87e2f618850b 100644
--- a/sound/soc/codecs/cs35l56.c
+++ b/sound/soc/codecs/cs35l56.c
@@ -802,14 +802,14 @@ static const struct reg_sequence cs35l56_system_reset_seq[] = {
 	REG_SEQ0(CS35L56_DSP_VIRTUAL1_MBOX_1, CS35L56_MBOX_CMD_SYSTEM_RESET),
 };
 
-static void cs35l56_system_reset(struct cs35l56_private *cs35l56, bool is_soundwire)
+static void cs35l56_system_reset(struct cs35l56_base *cs35l56_base, bool is_soundwire)
 {
 	/*
 	 * Must enter cache-only first so there can't be any more register
 	 * accesses other than the controlled system reset sequence below.
 	 */
-	regcache_cache_only(cs35l56->base.regmap, true);
-	regmap_multi_reg_write_bypassed(cs35l56->base.regmap,
+	regcache_cache_only(cs35l56_base->regmap, true);
+	regmap_multi_reg_write_bypassed(cs35l56_base->regmap,
 					cs35l56_system_reset_seq,
 					ARRAY_SIZE(cs35l56_system_reset_seq));
 
@@ -818,7 +818,7 @@ static void cs35l56_system_reset(struct cs35l56_private *cs35l56, bool is_soundw
 		return;
 
 	usleep_range(CS35L56_CONTROL_PORT_READY_US, CS35L56_CONTROL_PORT_READY_US + 400);
-	regcache_cache_only(cs35l56->base.regmap, false);
+	regcache_cache_only(cs35l56_base->regmap, false);
 }
 
 static void cs35l56_secure_patch(struct cs35l56_private *cs35l56)
@@ -882,7 +882,7 @@ static void cs35l56_patch(struct cs35l56_private *cs35l56)
 	init_completion(&cs35l56->init_completion);
 
 	cs35l56->soft_resetting = true;
-	cs35l56_system_reset(cs35l56, !!cs35l56->sdw_peripheral);
+	cs35l56_system_reset(&cs35l56->base, !!cs35l56->sdw_peripheral);
 
 	if (cs35l56->sdw_peripheral) {
 		/*
@@ -1137,20 +1137,20 @@ int cs35l56_runtime_resume_common(struct cs35l56_private *cs35l56)
 }
 EXPORT_SYMBOL_NS_GPL(cs35l56_runtime_resume_common, SND_SOC_CS35L56_CORE);
 
-static int cs35l56_is_fw_reload_needed(struct cs35l56_private *cs35l56)
+static int cs35l56_is_fw_reload_needed(struct cs35l56_base *cs35l56_base)
 {
 	unsigned int val;
 	int ret;
 
 	/* Nothing to re-patch if we haven't done any patching yet. */
-	if (!cs35l56->base.fw_patched)
+	if (!cs35l56_base->fw_patched)
 		return false;
 
 	/*
 	 * If we have control of RESET we will have asserted it so the firmware
 	 * will need re-patching.
 	 */
-	if (cs35l56->base.reset_gpio)
+	if (cs35l56_base->reset_gpio)
 		return true;
 
 	/*
@@ -1158,22 +1158,22 @@ static int cs35l56_is_fw_reload_needed(struct cs35l56_private *cs35l56)
 	 * can't be used here to test for memory retention.
 	 * Assume that tuning must be re-loaded.
 	 */
-	if (cs35l56->base.secured)
+	if (cs35l56_base->secured)
 		return true;
 
-	ret = pm_runtime_resume_and_get(cs35l56->base.dev);
+	ret = pm_runtime_resume_and_get(cs35l56_base->dev);
 	if (ret) {
-		dev_err(cs35l56->base.dev, "Failed to runtime_get: %d\n", ret);
+		dev_err(cs35l56_base->dev, "Failed to runtime_get: %d\n", ret);
 		return ret;
 	}
 
-	ret = regmap_read(cs35l56->base.regmap, CS35L56_PROTECTION_STATUS, &val);
+	ret = regmap_read(cs35l56_base->regmap, CS35L56_PROTECTION_STATUS, &val);
 	if (ret)
-		dev_err(cs35l56->base.dev, "Failed to read PROTECTION_STATUS: %d\n", ret);
+		dev_err(cs35l56_base->dev, "Failed to read PROTECTION_STATUS: %d\n", ret);
 	else
 		ret = !!(val & CS35L56_FIRMWARE_MISSING);
 
-	pm_runtime_put_autosuspend(cs35l56->base.dev);
+	pm_runtime_put_autosuspend(cs35l56_base->dev);
 
 	return ret;
 }
@@ -1302,7 +1302,7 @@ int cs35l56_system_resume(struct device *dev)
 	if (!cs35l56->component)
 		return 0;
 
-	ret = cs35l56_is_fw_reload_needed(cs35l56);
+	ret = cs35l56_is_fw_reload_needed(&cs35l56->base);
 	dev_dbg(cs35l56->base.dev, "fw_reload_needed: %d\n", ret);
 	if (ret < 1)
 		return ret;
@@ -1547,7 +1547,7 @@ int cs35l56_init(struct cs35l56_private *cs35l56)
 	if (!cs35l56->base.reset_gpio) {
 		dev_dbg(cs35l56->base.dev, "No reset gpio: using soft reset\n");
 		cs35l56->soft_resetting = true;
-		cs35l56_system_reset(cs35l56, !!cs35l56->sdw_peripheral);
+		cs35l56_system_reset(&cs35l56->base, !!cs35l56->sdw_peripheral);
 		if (cs35l56->sdw_peripheral) {
 			/* Keep alive while we wait for re-enumeration */
 			pm_runtime_get_noresume(cs35l56->base.dev);
-- 
2.30.2

