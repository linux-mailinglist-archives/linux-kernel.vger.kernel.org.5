Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F40DD7EF439
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 15:14:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbjKQOO2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 09:14:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345949AbjKQOOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 09:14:10 -0500
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1632D4B;
        Fri, 17 Nov 2023 06:14:06 -0800 (PST)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3AH8IefO017599;
        Fri, 17 Nov 2023 08:13:54 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        PODMain02222019; bh=M6W+QVktOBh17HSN1EqFh0hC5Sn5ODIVhO8qEILw3CI=; b=
        Q+vz0Z0sPPk3Oq84zc6ryjNjyQ9+dNZ20e35fOfvatApQXucmpa4hFn59rDoMdwa
        sUru9OKW/aAMa5iNlfUGfSZzbu0CaFfi2q2jgcYjoWSW1zq0SwSTZt74kgEXLYmO
        fWY6KpzUkViYRzXKmt4Cm/LbXuLPA/iDqUATGzQTO/DVDu2UndM4dK8CXXGNl1ai
        ZDnXMyOGpHQMsi1+mF/mK+6eswRIBIS7crFOJ8IIta2q65gFY9zkRGTttqfxbMhr
        1yD1UsLLfXg1t4JRDUsoABOllzA+t7LdFsctoD3DZIwQdDRB8iaHiFv1Y+b+rPbK
        W7WsgVdQAbFnVN1n4/BH0Q==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3ua7w2qj86-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Nov 2023 08:13:54 -0600 (CST)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Fri, 17 Nov
 2023 14:13:47 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.39 via Frontend Transport; Fri, 17 Nov 2023 14:13:47 +0000
Received: from upx-tgl-008-ubuntu.ad.cirrus.com (upx-tgl-008-ubuntu.ad.cirrus.com [198.90.251.167])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 21C3E15B9;
        Fri, 17 Nov 2023 14:13:47 +0000 (UTC)
From:   Maciej Strozek <mstrozek@opensource.cirrus.com>
To:     Mark Brown <broonie@kernel.org>
CC:     James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Maciej Strozek <mstrozek@opensource.cirrus.com>
Subject: [PATCH 7/7] ASoC:cs43130: Add switch to control normal and alt hp inputs
Date:   Fri, 17 Nov 2023 14:13:44 +0000
Message-ID: <20231117141344.64320-8-mstrozek@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231117141344.64320-1-mstrozek@opensource.cirrus.com>
References: <20231117141344.64320-1-mstrozek@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: HHy7PmnneZgXiJqVC4NCra9DsHWE9Gp0
X-Proofpoint-GUID: HHy7PmnneZgXiJqVC4NCra9DsHWE9Gp0
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

Make sure these inputs are mutually exclusive as recommended by the
datasheet

Signed-off-by: Maciej Strozek <mstrozek@opensource.cirrus.com>
---
 sound/soc/codecs/cs43130.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/cs43130.c b/sound/soc/codecs/cs43130.c
index 1e7c32eedc7b..8b77bd7fa907 100644
--- a/sound/soc/codecs/cs43130.c
+++ b/sound/soc/codecs/cs43130.c
@@ -1419,7 +1419,15 @@ static int cs43130_hpin_event(struct snd_soc_dapm_widget *w,
 	return 0;
 }
 
+static const char * const bypass_mux_text[] = {
+	"Internal",
+	"Alternative",
+};
+static SOC_ENUM_SINGLE_DECL(bypass_enum, SND_SOC_NOPM, 0, bypass_mux_text);
+static const struct snd_kcontrol_new bypass_ctrl = SOC_DAPM_ENUM("Switch", bypass_enum);
+
 static const struct snd_soc_dapm_widget digital_hp_widgets[] = {
+	SND_SOC_DAPM_MUX("Bypass Switch", SND_SOC_NOPM, 0, 0, &bypass_ctrl),
 	SND_SOC_DAPM_OUTPUT("HPOUTA"),
 	SND_SOC_DAPM_OUTPUT("HPOUTB"),
 
@@ -1472,13 +1480,13 @@ static const struct snd_soc_dapm_route digital_hp_routes[] = {
 	{"DSD", NULL, "XSPIN DSD"},
 	{"HiFi DAC", NULL, "ASPIN PCM"},
 	{"HiFi DAC", NULL, "DSD"},
-	{"HPOUTA", NULL, "HiFi DAC"},
-	{"HPOUTB", NULL, "HiFi DAC"},
+	{"Bypass Switch", "Internal", "HiFi DAC"},
+	{"HPOUTA", NULL, "Bypass Switch"},
+	{"HPOUTB", NULL, "Bypass Switch"},
 };
 
 static const struct snd_soc_dapm_route analog_hp_routes[] = {
-	{"HPOUTA", NULL, "Analog Playback"},
-	{"HPOUTB", NULL, "Analog Playback"},
+	{"Bypass Switch", "Alternative", "Analog Playback"},
 };
 
 static struct snd_soc_dapm_route all_hp_routes[
-- 
2.34.1

