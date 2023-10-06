Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D948E7BB601
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 13:11:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231997AbjJFLLH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 07:11:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231942AbjJFLK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 07:10:56 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2633EC5
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 04:10:51 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 396An4mD006823;
        Fri, 6 Oct 2023 06:10:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        PODMain02222019; bh=0zBqGPEQTQ7H/6c/RrnU9opyRaEYN9jVzR4spOSXdYI=; b=
        DpTv58/rHiV2u/LVDUIFqqlkCsb/+hcY0tyZznH4kN3eEALncTzco2Tg8GHr4WKL
        RXDycWbUaNA4d35Mz8xofJ4CZDVOMEO1eRRfCgENbBASFK8zgU9LgeQaYaZV2lXj
        aTKKhxkPgjB5GU3EnvXIlOFa3/FneiD8IKOBKy20fGDHjFDLSGG6kg3/Kb4kraV5
        ryMk381rqeipdr6DUMhfe/eXG7EtrFBfVQDSvmw0sa1sS/lMqLfM/Ic4iZn1XmtP
        EIVl5LoA0Hj0l1h4BG7H4jLnj9BHdXKuvBWjL3K9MxcE5OniFHFTtzOy5MbLf1iE
        +fUVEWrkW/WqM0gA8Cve2g==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3teg3k812p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 Oct 2023 06:10:44 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.37; Fri, 6 Oct
 2023 12:10:42 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.37 via Frontend Transport; Fri, 6 Oct 2023 12:10:42 +0100
Received: from work-debian.ad.cirrus.com (unknown [198.61.64.45])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 4B69A15B9;
        Fri,  6 Oct 2023 11:10:42 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Simon Trimmer <simont@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH 1/4] ASoC: cs35l56: Change hibernate sequence to use allow auto hibernate
Date:   Fri, 6 Oct 2023 12:10:36 +0100
Message-ID: <20231006111039.101914-2-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231006111039.101914-1-rf@opensource.cirrus.com>
References: <20231006111039.101914-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: vuHgu9vlpzucuUgr3uO0ndyVgfLXYYqA
X-Proofpoint-ORIG-GUID: vuHgu9vlpzucuUgr3uO0ndyVgfLXYYqA
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Simon Trimmer <simont@opensource.cirrus.com>

If the hardware uses SPI_MOSI, I2C_SCL or I2C_SDA as the wake source
the bus activity of sending HIBERNATE_NOW will wake up the amps that
were already put into hibernate.

ALLOW_AUTO_HIBERNATE tells the firmware to hibernate itself after a
timeout of a few seconds, giving the driver instances time to send this
before any amps have gone into hibernate.

Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>
Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 sound/soc/codecs/cs35l56-shared.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/sound/soc/codecs/cs35l56-shared.c b/sound/soc/codecs/cs35l56-shared.c
index 01b6fa97b36b..68dc93b82789 100644
--- a/sound/soc/codecs/cs35l56-shared.c
+++ b/sound/soc/codecs/cs35l56-shared.c
@@ -439,7 +439,7 @@ EXPORT_SYMBOL_NS_GPL(cs35l56_is_fw_reload_needed, SND_SOC_CS35L56_SHARED);
 
 static const struct reg_sequence cs35l56_hibernate_seq[] = {
 	/* This must be the last register access */
-	REG_SEQ0(CS35L56_DSP_VIRTUAL1_MBOX_1, CS35L56_MBOX_CMD_HIBERNATE_NOW),
+	REG_SEQ0(CS35L56_DSP_VIRTUAL1_MBOX_1, CS35L56_MBOX_CMD_ALLOW_AUTO_HIBERNATE),
 };
 
 static const struct reg_sequence cs35l56_hibernate_wake_seq[] = {
@@ -473,12 +473,6 @@ int cs35l56_runtime_suspend_common(struct cs35l56_base *cs35l56_base)
 		return 0;
 	}
 
-	/*
-	 * Enable auto-hibernate. If it is woken by some other wake source
-	 * it will automatically return to hibernate.
-	 */
-	cs35l56_mbox_send(cs35l56_base, CS35L56_MBOX_CMD_ALLOW_AUTO_HIBERNATE);
-
 	/*
 	 * Must enter cache-only first so there can't be any more register
 	 * accesses other than the controlled hibernate sequence below.
@@ -545,11 +539,12 @@ int cs35l56_runtime_resume_common(struct cs35l56_base *cs35l56_base, bool is_sou
 	return 0;
 
 err:
-	regmap_write(cs35l56_base->regmap, CS35L56_DSP_VIRTUAL1_MBOX_1,
-		     CS35L56_MBOX_CMD_HIBERNATE_NOW);
-
 	regcache_cache_only(cs35l56_base->regmap, true);
 
+	regmap_multi_reg_write_bypassed(cs35l56_base->regmap,
+					cs35l56_hibernate_seq,
+					ARRAY_SIZE(cs35l56_hibernate_seq));
+
 	return ret;
 }
 EXPORT_SYMBOL_NS_GPL(cs35l56_runtime_resume_common, SND_SOC_CS35L56_SHARED);
-- 
2.30.2

