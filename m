Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0903B7EF434
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 15:14:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345993AbjKQOOK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 09:14:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230513AbjKQOOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 09:14:06 -0500
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8360CD52;
        Fri, 17 Nov 2023 06:14:02 -0800 (PST)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3AH7fERx025627;
        Fri, 17 Nov 2023 08:13:48 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        PODMain02222019; bh=eQHPmKVYs9Cxq8bgVHJlqm/zIEmuE52dOPPbKaZHA6w=; b=
        ZSBOZnkqT87yPiuSy+d12hKuHYilyKARVa/3rMuBYkBOMg1rnhzSFcVvDSL5J2uj
        w129rkzizESKiu7XQS25EAv7pMjMK/P9Q/CVbbDqqpXF0NwFR46QTWIyzzE3XTRi
        QkC4dzk3KpHc5wirY7RUyu6bkzir0blOLlFGLCbELYAEc/XcWHuxrgYZ+aDfywp0
        bIIaMLU68sBIv/dJX0Cas1pnGsOk07MBnYiHG4dT97u14lsbMG8LxkqqDf7izaTM
        pPZEfCiIHg7s5GCkbklEe9Vrjev7kMP6BcDEzSVWQNphIGS8HWaymktnZ0ZDmrTm
        ud+M08cqa+15zG7fiGY0fg==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3ua6wpfjs8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Nov 2023 08:13:48 -0600 (CST)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Fri, 17 Nov
 2023 14:13:46 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.39 via Frontend
 Transport; Fri, 17 Nov 2023 14:13:46 +0000
Received: from upx-tgl-008-ubuntu.ad.cirrus.com (upx-tgl-008-ubuntu.ad.cirrus.com [198.90.251.167])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id D8F1A3582;
        Fri, 17 Nov 2023 14:13:46 +0000 (UTC)
From:   Maciej Strozek <mstrozek@opensource.cirrus.com>
To:     Mark Brown <broonie@kernel.org>
CC:     James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Maciej Strozek <mstrozek@opensource.cirrus.com>
Subject: [PATCH 3/7] ASoC: cs43130: Allow configuration of bit clock and frame inversion
Date:   Fri, 17 Nov 2023 14:13:40 +0000
Message-ID: <20231117141344.64320-4-mstrozek@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231117141344.64320-1-mstrozek@opensource.cirrus.com>
References: <20231117141344.64320-1-mstrozek@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 3Twmk12_ptNpSR9cgVrow_2OwfaJ63fc
X-Proofpoint-ORIG-GUID: 3Twmk12_ptNpSR9cgVrow_2OwfaJ63fc
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
 sound/soc/codecs/cs43130.c | 42 ++++++++++++++++++++++++++++++++++++--
 sound/soc/codecs/cs43130.h |  1 +
 2 files changed, 41 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/cs43130.c b/sound/soc/codecs/cs43130.c
index d8ec325b9cc9..62647045d8c4 100644
--- a/sound/soc/codecs/cs43130.c
+++ b/sound/soc/codecs/cs43130.c
@@ -595,6 +595,27 @@ static int cs43130_set_sp_fmt(int dai_id, unsigned int bitwidth_sclk,
 		return -EINVAL;
 	}
 
+	switch (cs43130->dais[dai_id].dai_invert) {
+	case SND_SOC_DAIFMT_NB_NF:
+		sclk_edge = 1;
+		lrck_edge = 0;
+		break;
+	case SND_SOC_DAIFMT_IB_NF:
+		sclk_edge = 0;
+		lrck_edge = 0;
+		break;
+	case SND_SOC_DAIFMT_NB_IF:
+		sclk_edge = 1;
+		lrck_edge = 1;
+		break;
+	case SND_SOC_DAIFMT_IB_IF:
+		sclk_edge = 0;
+		lrck_edge = 1;
+		break;
+	default:
+		return -EINVAL;
+	}
+
 	switch (cs43130->dais[dai_id].dai_mode) {
 	case SND_SOC_DAIFMT_CBS_CFS:
 		dai_mode_val = 0;
@@ -607,8 +628,6 @@ static int cs43130_set_sp_fmt(int dai_id, unsigned int bitwidth_sclk,
 	}
 
 	frm_size = bitwidth_sclk * params_channels(params);
-	sclk_edge = 1;
-	lrck_edge = 0;
 	loc_ch1 = 0;
 	loc_ch2 = bitwidth_sclk * (params_channels(params) - 1);
 
@@ -1483,6 +1502,25 @@ static int cs43130_pcm_set_fmt(struct snd_soc_dai *codec_dai, unsigned int fmt)
 		return -EINVAL;
 	}
 
+	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
+	case SND_SOC_DAIFMT_NB_NF:
+		cs43130->dais[codec_dai->id].dai_invert = SND_SOC_DAIFMT_NB_NF;
+		break;
+	case SND_SOC_DAIFMT_IB_NF:
+		cs43130->dais[codec_dai->id].dai_invert = SND_SOC_DAIFMT_IB_NF;
+		break;
+	case SND_SOC_DAIFMT_NB_IF:
+		cs43130->dais[codec_dai->id].dai_invert = SND_SOC_DAIFMT_NB_IF;
+		break;
+	case SND_SOC_DAIFMT_IB_IF:
+		cs43130->dais[codec_dai->id].dai_invert = SND_SOC_DAIFMT_IB_IF;
+		break;
+	default:
+		dev_err(cs43130->dev, "Unsupported invert mode 0x%x\n",
+			fmt & SND_SOC_DAIFMT_INV_MASK);
+		return -EINVAL;
+	}
+
 	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
 	case SND_SOC_DAIFMT_I2S:
 		cs43130->dais[codec_dai->id].dai_format = SND_SOC_DAIFMT_I2S;
diff --git a/sound/soc/codecs/cs43130.h b/sound/soc/codecs/cs43130.h
index 90e8895275e7..c7b2708aebcd 100644
--- a/sound/soc/codecs/cs43130.h
+++ b/sound/soc/codecs/cs43130.h
@@ -497,6 +497,7 @@ struct cs43130_dai {
 	unsigned int			sclk;
 	unsigned int			dai_format;
 	unsigned int			dai_mode;
+	unsigned int			dai_invert;
 };
 
 struct	cs43130_private {
-- 
2.34.1

