Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE3097748EE
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 21:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235458AbjHHTpI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 15:45:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235315AbjHHToq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 15:44:46 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65A8F117A02
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 09:48:07 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 378GfYwE012826;
        Tue, 8 Aug 2023 11:47:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        PODMain02222019; bh=Mt28dTgZ7PN6kO/FpAGHcn+lAjxM4yoMpXnoYmoEICM=; b=
        oPIzpcGViEhf22/FDG+vD+CfVPnzGYPiXgctTKouarGtNDf6G2s3sLxE5s72H2Ef
        bpm1w1jZOwk5mLqZgXOePSh/DcFG4n+TsefJhSugbBEuvVsX7ZaFlmV4Vk7jCWT7
        4bI+6Ki1oGnbl7ZPY5sK2DwgFJvnviWgJMB4x2cyxBdtmhZ/q7CyPSYW87ZA5XoA
        f92toe1BTCFqlixXNH8M9SIDZou9IOMteAIk4SPW9Nc6a4j0DPHS/e1oliqS0gwE
        drYNJZdfgTEsYT7FbFhyqoxp5vCOiyxbK6PPTW3CPd1mVD1+iacz1HAbh6Q09T/k
        CB/WncpoeOiz/AgOz9LiOQ==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3s9juhtucr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Aug 2023 11:47:06 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Tue, 8 Aug
 2023 17:47:04 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.30 via Frontend Transport; Tue, 8 Aug 2023 17:47:04 +0100
Received: from EDIN4L06LR3.ad.cirrus.com (EDIN4L06LR3.ad.cirrus.com [198.61.64.220])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id A41F515B7;
        Tue,  8 Aug 2023 16:47:04 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH 1/5] ASoC: cs35l56: Avoid uninitialized variable in cs35l56_set_asp_slot_positions()
Date:   Tue, 8 Aug 2023 17:46:58 +0100
Message-ID: <20230808164702.21272-2-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230808164702.21272-1-rf@opensource.cirrus.com>
References: <20230808164702.21272-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 5TEVI71sAI4bd-azc_I1dsY-qWuAlvMR
X-Proofpoint-ORIG-GUID: 5TEVI71sAI4bd-azc_I1dsY-qWuAlvMR
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Re-implement setting of ASP TDM slots so that only the common loop to
build the register word is factored out.

The original cs35l56_set_asp_slot_positions() had an apparent
uninitialized variable if the passed register address was neither of the
ASP slot registers. In fact this would never happen because the calling
code passed valid registers.

While it's trivial to initialize the variable or add a default case,
actually the only common code was the loop at the end of the function,
which simply manipulates some mask values and is identical for either
register. Factoring out the regmap_write() didn't really gain anything.

So instead re-implement the code to replace the original function with
cs35l56_make_tdm_config_word() that only does the loop, and change the
calling code to call regmap_write() directly.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 sound/soc/codecs/cs35l56.c | 24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/sound/soc/codecs/cs35l56.c b/sound/soc/codecs/cs35l56.c
index 19b6b4fbe5de..be400208205a 100644
--- a/sound/soc/codecs/cs35l56.c
+++ b/sound/soc/codecs/cs35l56.c
@@ -358,22 +358,11 @@ static int cs35l56_asp_dai_set_fmt(struct snd_soc_dai *codec_dai, unsigned int f
 	return 0;
 }
 
-static void cs35l56_set_asp_slot_positions(struct cs35l56_private *cs35l56,
-					   unsigned int reg, unsigned long mask)
+static unsigned int cs35l56_make_tdm_config_word(unsigned int reg_val, unsigned long mask)
 {
-	unsigned int reg_val, channel_shift;
+	unsigned int channel_shift;
 	int bit_num;
 
-	/* Init all slots to 63 */
-	switch (reg) {
-	case CS35L56_ASP1_FRAME_CONTROL1:
-		reg_val = 0x3f3f3f3f;
-		break;
-	case CS35L56_ASP1_FRAME_CONTROL5:
-		reg_val = 0x3f3f3f;
-		break;
-	}
-
 	/* Enable consecutive TX1..TXn for each of the slots set in mask */
 	channel_shift = 0;
 	for_each_set_bit(bit_num, &mask, 32) {
@@ -382,7 +371,7 @@ static void cs35l56_set_asp_slot_positions(struct cs35l56_private *cs35l56,
 		channel_shift += 8;
 	}
 
-	regmap_write(cs35l56->base.regmap, reg, reg_val);
+	return reg_val;
 }
 
 static int cs35l56_asp_dai_set_tdm_slot(struct snd_soc_dai *dai, unsigned int tx_mask,
@@ -418,8 +407,11 @@ static int cs35l56_asp_dai_set_tdm_slot(struct snd_soc_dai *dai, unsigned int tx
 	if (rx_mask == 0)
 		rx_mask = 0xf;	// ASPTX1..TX4 in slots 0..3
 
-	cs35l56_set_asp_slot_positions(cs35l56, CS35L56_ASP1_FRAME_CONTROL1, rx_mask);
-	cs35l56_set_asp_slot_positions(cs35l56, CS35L56_ASP1_FRAME_CONTROL5, tx_mask);
+	/* Default unused slots to 63 */
+	regmap_write(cs35l56->base.regmap, CS35L56_ASP1_FRAME_CONTROL1,
+		     cs35l56_make_tdm_config_word(0x3f3f3f3f, rx_mask));
+	regmap_write(cs35l56->base.regmap, CS35L56_ASP1_FRAME_CONTROL5,
+		     cs35l56_make_tdm_config_word(0x3f3f3f, tx_mask));
 
 	dev_dbg(cs35l56->base.dev, "tdm slot width: %u count: %u tx_mask: %#x rx_mask: %#x\n",
 		cs35l56->asp_slot_width, cs35l56->asp_slot_count, tx_mask, rx_mask);
-- 
2.30.2

