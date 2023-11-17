Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D78627EF438
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 15:14:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346094AbjKQOOY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 09:14:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345808AbjKQOOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 09:14:09 -0500
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF84E11F;
        Fri, 17 Nov 2023 06:14:05 -0800 (PST)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3AH8IefM017599;
        Fri, 17 Nov 2023 08:13:52 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        PODMain02222019; bh=W64wMY4JDd5Fw2BbTWagHGzZxuKk6vjKkgnSKun7nH8=; b=
        HooMQkxfqgBGH/i9+TKH2FbeitgRg1YOnFm2Ju12aFDvrqSQMjdVptuQ6BOVDUU0
        k9w60rLoUvKQ4rDuauyF+TjCwYdQK75ivBxu3OnCQEH1bAhgRg1NLBCfWqyXGwIw
        haWSLryR02/VVx7sJ9F4iYDXPnX5sBFT5eGSTZ8ngZeSTyfzeY213HKD6qQ9SVx2
        66oS9bh0FGE4Ly83XYiq1Ao1YEoALLAPD70K6FtxGvzzocUYhL5aLTtF06hVrPtF
        NIDu1NazV+cPTqScAfT9HoV+puncLt9EPaE352cfH7NFKK3GIIfxxWugJhwKni5h
        QLW20BSCBJLXsqz9/hSyJA==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3ua7w2qj86-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Nov 2023 08:13:52 -0600 (CST)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Fri, 17 Nov
 2023 14:13:47 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.39 via Frontend
 Transport; Fri, 17 Nov 2023 14:13:47 +0000
Received: from upx-tgl-008-ubuntu.ad.cirrus.com (upx-tgl-008-ubuntu.ad.cirrus.com [198.90.251.167])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 12ED83581;
        Fri, 17 Nov 2023 14:13:47 +0000 (UTC)
From:   Maciej Strozek <mstrozek@opensource.cirrus.com>
To:     Mark Brown <broonie@kernel.org>
CC:     James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Maciej Strozek <mstrozek@opensource.cirrus.com>
Subject: [PATCH 6/7] ASoC: cs43130: Allow driver to work without IRQ thread
Date:   Fri, 17 Nov 2023 14:13:43 +0000
Message-ID: <20231117141344.64320-7-mstrozek@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231117141344.64320-1-mstrozek@opensource.cirrus.com>
References: <20231117141344.64320-1-mstrozek@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: g8xh5h9rQ8qavCW3ClbUb019i61gWdLC
X-Proofpoint-GUID: g8xh5h9rQ8qavCW3ClbUb019i61gWdLC
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

Signed-off-by: Maciej Strozek <mstrozek@opensource.cirrus.com>
---
 sound/soc/codecs/cs43130.c | 56 +++++++++++++++++++++++++++++++-------
 sound/soc/codecs/cs43130.h |  1 +
 2 files changed, 47 insertions(+), 10 deletions(-)

diff --git a/sound/soc/codecs/cs43130.c b/sound/soc/codecs/cs43130.c
index fd39328579fb..1e7c32eedc7b 100644
--- a/sound/soc/codecs/cs43130.c
+++ b/sound/soc/codecs/cs43130.c
@@ -326,6 +326,43 @@ static int cs43130_set_pll(struct snd_soc_component *component, int pll_id, int
 	return ret;
 }
 
+static int cs43130_wait_for_completion(struct cs43130_private *cs43130, struct completion *to_poll,
+					int time)
+{
+	int stickies, offset, flag;
+	int ret = 0;
+
+	if (cs43130->has_irq_line) {
+		ret = wait_for_completion_timeout(to_poll, msecs_to_jiffies(time));
+	} else {
+		if (to_poll == &cs43130->xtal_rdy) {
+			offset = 0;
+			flag = CS43130_XTAL_RDY_INT;
+		} else if (to_poll == &cs43130->pll_rdy) {
+			offset = 0;
+			flag = CS43130_PLL_RDY_INT;
+		} else if (to_poll == &cs43130->hpload_evt) {
+			offset = 3;
+			flag = CS43130_HPLOAD_NO_DC_INT | CS43130_HPLOAD_UNPLUG_INT |
+				CS43130_HPLOAD_OOR_INT | CS43130_HPLOAD_AC_INT |
+				CS43130_HPLOAD_DC_INT | CS43130_HPLOAD_ON_INT |
+				CS43130_HPLOAD_OFF_INT;
+		} else {
+			return 0;
+		}
+
+		ret = regmap_read_poll_timeout(cs43130->regmap, CS43130_INT_STATUS_1 + offset,
+					       stickies, (stickies & flag),
+					       1000, time * 1000);
+
+		/*
+		 * Return 0 for an timeout/error to be consistent with wait_for_completion_timeout
+		 */
+		ret = !ret;
+	}
+	return ret;
+}
+
 static int cs43130_change_clksrc(struct snd_soc_component *component,
 				 enum cs43130_mclk_src_sel src)
 {
@@ -364,8 +401,7 @@ static int cs43130_change_clksrc(struct snd_soc_component *component,
 					   CS43130_XTAL_RDY_INT_MASK, 0);
 			regmap_update_bits(cs43130->regmap, CS43130_PWDN_CTL,
 					   CS43130_PDN_XTAL_MASK, 0);
-			ret = wait_for_completion_timeout(&cs43130->xtal_rdy,
-							  msecs_to_jiffies(100));
+			ret = cs43130_wait_for_completion(cs43130, &cs43130->xtal_rdy, 100);
 			regmap_update_bits(cs43130->regmap, CS43130_INT_MASK_1,
 					   CS43130_XTAL_RDY_INT_MASK,
 					   1 << CS43130_XTAL_RDY_INT_SHIFT);
@@ -400,8 +436,7 @@ static int cs43130_change_clksrc(struct snd_soc_component *component,
 					   CS43130_XTAL_RDY_INT_MASK, 0);
 			regmap_update_bits(cs43130->regmap, CS43130_PWDN_CTL,
 					   CS43130_PDN_XTAL_MASK, 0);
-			ret = wait_for_completion_timeout(&cs43130->xtal_rdy,
-							  msecs_to_jiffies(100));
+			ret = cs43130_wait_for_completion(cs43130, &cs43130->xtal_rdy, 100);
 			regmap_update_bits(cs43130->regmap, CS43130_INT_MASK_1,
 					   CS43130_XTAL_RDY_INT_MASK,
 					   1 << CS43130_XTAL_RDY_INT_SHIFT);
@@ -416,8 +451,7 @@ static int cs43130_change_clksrc(struct snd_soc_component *component,
 				   CS43130_PLL_RDY_INT_MASK, 0);
 		regmap_update_bits(cs43130->regmap, CS43130_PWDN_CTL,
 				   CS43130_PDN_PLL_MASK, 0);
-		ret = wait_for_completion_timeout(&cs43130->pll_rdy,
-						  msecs_to_jiffies(100));
+		ret = cs43130_wait_for_completion(cs43130, &cs43130->pll_rdy, 100);
 		regmap_update_bits(cs43130->regmap, CS43130_INT_MASK_1,
 				   CS43130_PLL_RDY_INT_MASK,
 				   1 << CS43130_PLL_RDY_INT_SHIFT);
@@ -2040,8 +2074,8 @@ static int cs43130_hpload_proc(struct cs43130_private *cs43130,
 	regmap_multi_reg_write(cs43130->regmap, seq,
 			       seq_size);
 
-	ret = wait_for_completion_timeout(&cs43130->hpload_evt,
-					  msecs_to_jiffies(1000));
+	ret = cs43130_wait_for_completion(cs43130, &cs43130->hpload_evt, 1000);
+
 	regmap_read(cs43130->regmap, CS43130_INT_MASK_4, &msk);
 	if (!ret) {
 		dev_err(cs43130->dev, "Timeout waiting for HPLOAD interrupt\n");
@@ -2545,8 +2579,10 @@ static int cs43130_i2c_probe(struct i2c_client *client)
 					IRQF_ONESHOT | IRQF_TRIGGER_LOW,
 					"cs43130", cs43130);
 	if (ret != 0) {
-		dev_err(cs43130->dev, "Failed to request IRQ: %d\n", ret);
-		goto err;
+		dev_dbg(cs43130->dev, "Failed to request IRQ: %d, will poll instead\n", ret);
+		cs43130->has_irq_line = 0;
+	} else {
+		cs43130->has_irq_line = 1;
 	}
 
 	cs43130->mclk_int_src = CS43130_MCLK_SRC_RCO;
diff --git a/sound/soc/codecs/cs43130.h b/sound/soc/codecs/cs43130.h
index d3f595bbd3ba..dbdb5b262f1b 100644
--- a/sound/soc/codecs/cs43130.h
+++ b/sound/soc/codecs/cs43130.h
@@ -508,6 +508,7 @@ struct	cs43130_private {
 	struct gpio_desc		*reset_gpio;
 	unsigned int			dev_id; /* codec device ID */
 	int				xtal_ibias;
+	bool				has_irq_line;
 
 	/* shared by both DAIs */
 	struct mutex			clk_mutex;
-- 
2.34.1

