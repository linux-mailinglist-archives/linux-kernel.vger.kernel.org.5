Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 314BE75C7A3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 15:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbjGUNWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 09:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231228AbjGUNWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 09:22:11 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA0A5358E
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 06:21:40 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 36L7lwWl024208;
        Fri, 21 Jul 2023 08:21:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        PODMain02222019; bh=29De29CfgxtaslEDXEZsN6HJ5nTQb8h4NcfQQ6+My7w=; b=
        hLTsQSaHDqEoLwbNFZD23xejc04aA/0kflqR1pV0+Zv/ON8o+7h0OmGJw+yVWwzP
        SaDF7k3TWC7AYyoOFQQy/0jLj13c7Ka7UvzaLSLC060E7LAK504OjAwld6tKCVtw
        nag9Bu7IwyREnu6RmP8pX8tv9pAlt3fXku60oBcf8o3X04DHy+dDff8U9ZKLeZtb
        EZq6AD9ypvxqM9qdE3wjPsAoCARSVh2oDhUbu03bVMssLqgVcTEge2uE27dF/5HA
        grPMOJaGQbJbBjc5OO+lKtLfxduayrELlderNDqlQfjQTjRw58X2PnpJtGvCdkE1
        R0lrz9rdkG2OQ9khKTiacQ==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3rus6gyj2u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Jul 2023 08:21:25 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Fri, 21 Jul
 2023 14:21:24 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.30 via Frontend Transport; Fri, 21 Jul 2023 14:21:24 +0100
Received: from work-debian.ad.cirrus.com (unknown [198.61.64.172])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id F176346B;
        Fri, 21 Jul 2023 13:21:23 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>, <tiwai@suse.com>
CC:     <perex@perex.cz>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        Simon Trimmer <simont@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH v5 02/11] ASoC: cs35l56: Make cs35l56_system_reset() code more generic
Date:   Fri, 21 Jul 2023 14:21:11 +0100
Message-ID: <20230721132120.5523-3-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230721132120.5523-1-rf@opensource.cirrus.com>
References: <20230721132120.5523-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: abVUIvMO1chmM1eHGKjqZGXK-Y_dSGZL
X-Proofpoint-GUID: abVUIvMO1chmM1eHGKjqZGXK-Y_dSGZL
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

The function can be more easily reused in HDA if the tracking of whether
a soft reset is being performed and whether the device is connected to a
SoundWire bus is moved out of the function.

Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>
Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Acked-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/cs35l56.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/cs35l56.c b/sound/soc/codecs/cs35l56.c
index 4eb8e5b09bfd..7a83e388e869 100644
--- a/sound/soc/codecs/cs35l56.c
+++ b/sound/soc/codecs/cs35l56.c
@@ -802,10 +802,8 @@ static const struct reg_sequence cs35l56_system_reset_seq[] = {
 	REG_SEQ0(CS35L56_DSP_VIRTUAL1_MBOX_1, CS35L56_MBOX_CMD_SYSTEM_RESET),
 };
 
-static void cs35l56_system_reset(struct cs35l56_private *cs35l56)
+static void cs35l56_system_reset(struct cs35l56_private *cs35l56, bool is_soundwire)
 {
-	cs35l56->soft_resetting = true;
-
 	/*
 	 * Must enter cache-only first so there can't be any more register
 	 * accesses other than the controlled system reset sequence below.
@@ -816,7 +814,7 @@ static void cs35l56_system_reset(struct cs35l56_private *cs35l56)
 					ARRAY_SIZE(cs35l56_system_reset_seq));
 
 	/* On SoundWire the registers won't be accessible until it re-enumerates. */
-	if (cs35l56->sdw_peripheral)
+	if (is_soundwire)
 		return;
 
 	usleep_range(CS35L56_CONTROL_PORT_READY_US, CS35L56_CONTROL_PORT_READY_US + 400);
@@ -883,7 +881,8 @@ static void cs35l56_patch(struct cs35l56_private *cs35l56)
 
 	init_completion(&cs35l56->init_completion);
 
-	cs35l56_system_reset(cs35l56);
+	cs35l56->soft_resetting = true;
+	cs35l56_system_reset(cs35l56, !!cs35l56->sdw_peripheral);
 
 	if (cs35l56->sdw_peripheral) {
 		/*
@@ -1547,7 +1546,8 @@ int cs35l56_init(struct cs35l56_private *cs35l56)
 
 	if (!cs35l56->base.reset_gpio) {
 		dev_dbg(cs35l56->base.dev, "No reset gpio: using soft reset\n");
-		cs35l56_system_reset(cs35l56);
+		cs35l56->soft_resetting = true;
+		cs35l56_system_reset(cs35l56, !!cs35l56->sdw_peripheral);
 		if (cs35l56->sdw_peripheral) {
 			/* Keep alive while we wait for re-enumeration */
 			pm_runtime_get_noresume(cs35l56->base.dev);
-- 
2.30.2

