Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07ED778B5F8
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 19:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232900AbjH1RGt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 13:06:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232763AbjH1RGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 13:06:14 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16E45C5;
        Mon, 28 Aug 2023 10:06:12 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 37SF2s64001342;
        Mon, 28 Aug 2023 12:05:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        PODMain02222019; bh=emwn8Rh+GiK839KOBaZXWgo02wchBa0++hofCDljvaE=; b=
        mq8I3sCQVEmNVUdpUtoEkXKsxTwm8b2gszrJ8dTyoJYV42aIeIQvpQm6zibnO5wb
        9fYl4b9aC2Ew4ZXbgifu1fLFEfxUtlDBfxwcEDsTwH9D+DpdHKtCas7oDXLWP6FD
        w2UClyZWxk1HHIqN3Ac+Yi5P6OUWOjV8Hz0YY+RXQTAEYfLVUecGY/Z9Ps+ekVrw
        CFTd58tyPfokBppENz+Xk4hx+DUXRlVSrNDsW+MjwwVQJyjz6mHzhBN/eMwKBbJu
        c3mXuZW6WQKUxBqbM3v5IUlxAqJ3IuBCAV0+F2RFbbV/CtP7STmjG41dXanDnh0K
        PMOtNPWMomtHE4UvUWelNg==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3sqesyae72-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Aug 2023 12:05:54 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.37; Mon, 28 Aug
 2023 18:05:52 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.37 via Frontend
 Transport; Mon, 28 Aug 2023 18:05:52 +0100
Received: from vkarpovich-ThinkStation-P620.crystal.cirrus.com (vkarpovich-ThinkStation-P620.ad.cirrus.com [141.131.145.49])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id A6A9A11D4;
        Mon, 28 Aug 2023 17:05:50 +0000 (UTC)
From:   Vlad Karpovich <vkarpovi@opensource.cirrus.com>
To:     James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Rob Herring <robh+dt@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <RicardoRivera-Matosricardo.rivera-matos@cirrus.com>,
        Vlad Karpovich <vkarpovi@opensource.cirrus.com>
Subject: [PATCH 6/7] ASoC: cs35l45: Connect DSP to the monitoring signals
Date:   Mon, 28 Aug 2023 12:05:24 -0500
Message-ID: <20230828170525.335671-6-vkarpovi@opensource.cirrus.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230828170525.335671-1-vkarpovi@opensource.cirrus.com>
References: <20230828170525.335671-1-vkarpovi@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: qc2UoEWanY0NIkKlynDHo9Ng0q0dSHOU
X-Proofpoint-GUID: qc2UoEWanY0NIkKlynDHo9Ng0q0dSHOU
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        UPPERCASE_50_75 autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Link VMON, IMON, TEMPMON, VDD_BSTMON and VDD_BATTMON
to DSP1. The CSPL firmware uses them for the speaker calibration
and monitoring.

Signed-off-by: Vlad Karpovich <vkarpovi@opensource.cirrus.com>
---
 sound/soc/codecs/cs35l45.c | 33 +++++++++++++++++++++++++++------
 sound/soc/codecs/cs35l45.h |  1 +
 2 files changed, 28 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/cs35l45.c b/sound/soc/codecs/cs35l45.c
index efd2d6aa3d67..6c8f179b9c1c 100644
--- a/sound/soc/codecs/cs35l45.c
+++ b/sound/soc/codecs/cs35l45.c
@@ -433,17 +433,25 @@ static const struct snd_soc_dapm_widget cs35l45_dapm_widgets[] = {
 
 	SND_SOC_DAPM_SIGGEN("VMON_SRC"),
 	SND_SOC_DAPM_SIGGEN("IMON_SRC"),
+	SND_SOC_DAPM_SIGGEN("TEMPMON_SRC"),
 	SND_SOC_DAPM_SIGGEN("VDD_BATTMON_SRC"),
 	SND_SOC_DAPM_SIGGEN("VDD_BSTMON_SRC"),
 	SND_SOC_DAPM_SIGGEN("ERR_VOL"),
 	SND_SOC_DAPM_SIGGEN("AMP_INTP"),
 	SND_SOC_DAPM_SIGGEN("IL_TARGET"),
-	SND_SOC_DAPM_ADC("VMON", NULL, CS35L45_BLOCK_ENABLES, CS35L45_VMON_EN_SHIFT, 0),
-	SND_SOC_DAPM_ADC("IMON", NULL, CS35L45_BLOCK_ENABLES, CS35L45_IMON_EN_SHIFT, 0),
-	SND_SOC_DAPM_ADC("VDD_BATTMON", NULL, CS35L45_BLOCK_ENABLES,
-			 CS35L45_VDD_BATTMON_EN_SHIFT, 0),
-	SND_SOC_DAPM_ADC("VDD_BSTMON", NULL, CS35L45_BLOCK_ENABLES,
-			 CS35L45_VDD_BSTMON_EN_SHIFT, 0),
+
+	SND_SOC_DAPM_SUPPLY("VMON_EN", CS35L45_BLOCK_ENABLES, CS35L45_VMON_EN_SHIFT, 0, NULL, 0),
+	SND_SOC_DAPM_SUPPLY("IMON_EN", CS35L45_BLOCK_ENABLES, CS35L45_IMON_EN_SHIFT, 0, NULL, 0),
+	SND_SOC_DAPM_SUPPLY("TEMPMON_EN", CS35L45_BLOCK_ENABLES, CS35L45_TEMPMON_EN_SHIFT, 0, NULL, 0),
+	SND_SOC_DAPM_SUPPLY("VDD_BATTMON_EN", CS35L45_BLOCK_ENABLES, CS35L45_VDD_BATTMON_EN_SHIFT, 0, NULL, 0),
+	SND_SOC_DAPM_SUPPLY("VDD_BSTMON_EN", CS35L45_BLOCK_ENABLES, CS35L45_VDD_BSTMON_EN_SHIFT, 0, NULL, 0),
+
+	SND_SOC_DAPM_ADC("VMON", NULL, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_ADC("IMON", NULL, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_ADC("TEMPMON", NULL, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_ADC("VDD_BATTMON", NULL, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_ADC("VDD_BSTMON", NULL, SND_SOC_NOPM, 0, 0),
+
 
 	SND_SOC_DAPM_AIF_IN("ASP_RX1", NULL, 0, CS35L45_ASP_ENABLES1, CS35L45_ASP_RX1_EN_SHIFT, 0),
 	SND_SOC_DAPM_AIF_IN("ASP_RX2", NULL, 1, CS35L45_ASP_ENABLES1, CS35L45_ASP_RX2_EN_SHIFT, 0),
@@ -503,9 +511,16 @@ static const struct snd_soc_dapm_route cs35l45_dapm_routes[] = {
 	/* Feedback */
 	{ "VMON", NULL, "VMON_SRC" },
 	{ "IMON", NULL, "IMON_SRC" },
+	{ "TEMPMON", NULL, "TEMPMON_SRC" },
 	{ "VDD_BATTMON", NULL, "VDD_BATTMON_SRC" },
 	{ "VDD_BSTMON", NULL, "VDD_BSTMON_SRC" },
 
+	{ "VMON", NULL, "VMON_EN" },
+	{ "IMON", NULL, "IMON_EN" },
+	{ "TEMPMON", NULL, "TEMPMON_EN" },
+	{ "VDD_BATTMON", NULL, "VDD_BATTMON_EN" },
+	{ "VDD_BSTMON", NULL, "VDD_BSTMON_EN" },
+
 	{ "Capture", NULL, "ASP_TX1"},
 	{ "Capture", NULL, "ASP_TX2"},
 	{ "Capture", NULL, "ASP_TX3"},
@@ -560,6 +575,12 @@ static const struct snd_soc_dapm_route cs35l45_dapm_routes[] = {
 	{"DSP1", NULL, "DSP_RX7 Source"},
 	{"DSP1", NULL, "DSP_RX8 Source"},
 
+	{"DSP1", NULL, "VMON_EN"},
+	{"DSP1", NULL, "IMON_EN"},
+	{"DSP1", NULL, "VDD_BATTMON_EN"},
+	{"DSP1", NULL, "VDD_BSTMON_EN"},
+	{"DSP1", NULL, "TEMPMON_EN"},
+
 	{"DSP1 Preload", NULL, "DSP1 Preloader"},
 	{"DSP1", NULL, "DSP1 Preloader"},
 
diff --git a/sound/soc/codecs/cs35l45.h b/sound/soc/codecs/cs35l45.h
index 16857321d945..e2ebcf58d7e0 100644
--- a/sound/soc/codecs/cs35l45.h
+++ b/sound/soc/codecs/cs35l45.h
@@ -165,6 +165,7 @@
 /* BLOCK_ENABLES */
 #define CS35L45_IMON_EN_SHIFT			13
 #define CS35L45_VMON_EN_SHIFT			12
+#define CS35L45_TEMPMON_EN_SHIFT		10
 #define CS35L45_VDD_BSTMON_EN_SHIFT		9
 #define CS35L45_VDD_BATTMON_EN_SHIFT		8
 #define CS35L45_BST_EN_SHIFT			4
-- 
2.25.1

