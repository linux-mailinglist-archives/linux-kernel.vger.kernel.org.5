Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B51475A901
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 10:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbjGTIVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 04:21:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbjGTIVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 04:21:07 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DF4A211F
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 01:21:05 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 36K67pGv019206;
        Thu, 20 Jul 2023 03:20:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding:content-type; s=PODMain02222019; bh=l
        IXeWRFoAvkoAcWGvrpEZcMSLQ0hI8rnZXavmjUTITo=; b=OPu1UHG+DZjx/w7JX
        VHNM/ZSGep9jCcfJFbxRN+rjFcYKQNDZGjAsGKKujuFeVpjlWegy9y9Z8vvtMUjU
        ZSHx05SEmfhqmXnWmlvC/lT/a61rElmpEu33e5ymvMaAzioUpr+5OLbVEEA5gfvQ
        P3XUJoyNNRjPCC67xqqXTacFWH7jU5qAWyQPK6JfP8NxHKu1tRnauh2UrfOW5EJa
        TixRNY12fPFUwlWzj+5IDpeRahy6oxtSCeghHnh5fFn1hSTOHyDLtvWnHoKrOv7G
        ONuZv+9+G0bAU1E8X/zIN1mR3ch2V8rpIuqHfKbZTLH9OxrUZ+MYwn9Ekz9SgVvn
        C4rPA==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3rus62whkx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Jul 2023 03:20:43 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Thu, 20 Jul
 2023 09:20:41 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.30 via Frontend
 Transport; Thu, 20 Jul 2023 09:20:41 +0100
Received: from lon-bigdaddy.ad.cirrus.com (unknown [198.61.64.114])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id D55E8458;
        Thu, 20 Jul 2023 08:20:40 +0000 (UTC)
From:   Vitaly Rodionov <vitalyr@opensource.cirrus.com>
To:     Takashi Iwai <tiwai@suse.com>
CC:     Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>,
        Vitaly Rodionov <vitalyr@opensource.cirrus.com>
Subject: [PATCH 1/2] ALSA: hda/realtek: Fix generic fixup definition for cs35l41 amp
Date:   Thu, 20 Jul 2023 09:20:21 +0100
Message-ID: <20230720082022.13033-1-vitalyr@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: AGj644tg1-jiUD0g7dA1VttPMOhjA2OJ
X-Proofpoint-ORIG-GUID: AGj644tg1-jiUD0g7dA1VttPMOhjA2OJ
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Generic fixup for CS35L41 amplifies should not have vendor specific
chained fixup. For ThinkPad laptops with led issue, we can just add
specific fixup.

Fixes: a6ac60b36dade (ALSA: hda/realtek: Fix mute led issue on thinkpad with cs35l41 s-codec)
Signed-off-by: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
---
 sound/pci/hda/patch_realtek.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index e2f8b608de82..56cbf5b38d48 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -7213,6 +7213,7 @@ enum {
 	ALC287_FIXUP_YOGA9_14IAP7_BASS_SPK_PIN,
 	ALC295_FIXUP_DELL_INSPIRON_TOP_SPEAKERS,
 	ALC236_FIXUP_DELL_DUAL_CODECS,
+	ALC287_FIXUP_CS35L41_I2C_2_THINKPAD_ACPI,
 };
 
 /* A special fixup for Lenovo C940 and Yoga Duet 7;
@@ -9145,8 +9146,6 @@ static const struct hda_fixup alc269_fixups[] = {
 	[ALC287_FIXUP_CS35L41_I2C_2] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = cs35l41_fixup_i2c_two,
-		.chained = true,
-		.chain_id = ALC269_FIXUP_THINKPAD_ACPI,
 	},
 	[ALC287_FIXUP_CS35L41_I2C_2_HP_GPIO_LED] = {
 		.type = HDA_FIXUP_FUNC,
@@ -9283,6 +9282,12 @@ static const struct hda_fixup alc269_fixups[] = {
 		.chained = true,
 		.chain_id = ALC255_FIXUP_DELL1_MIC_NO_PRESENCE,
 	},
+	[ALC287_FIXUP_CS35L41_I2C_2_THINKPAD_ACPI] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = cs35l41_fixup_i2c_two,
+		.chained = true,
+		.chain_id = ALC269_FIXUP_THINKPAD_ACPI,
+	},
 };
 
 static const struct snd_pci_quirk alc269_fixup_tbl[] = {
@@ -9810,14 +9815,14 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x17aa, 0x22be, "Thinkpad X1 Carbon 8th", ALC285_FIXUP_THINKPAD_HEADSET_JACK),
 	SND_PCI_QUIRK(0x17aa, 0x22c1, "Thinkpad P1 Gen 3", ALC285_FIXUP_THINKPAD_NO_BASS_SPK_HEADSET_JACK),
 	SND_PCI_QUIRK(0x17aa, 0x22c2, "Thinkpad X1 Extreme Gen 3", ALC285_FIXUP_THINKPAD_NO_BASS_SPK_HEADSET_JACK),
-	SND_PCI_QUIRK(0x17aa, 0x22f1, "Thinkpad", ALC287_FIXUP_CS35L41_I2C_2),
-	SND_PCI_QUIRK(0x17aa, 0x22f2, "Thinkpad", ALC287_FIXUP_CS35L41_I2C_2),
-	SND_PCI_QUIRK(0x17aa, 0x22f3, "Thinkpad", ALC287_FIXUP_CS35L41_I2C_2),
-	SND_PCI_QUIRK(0x17aa, 0x2316, "Thinkpad P1 Gen 6", ALC287_FIXUP_CS35L41_I2C_2),
-	SND_PCI_QUIRK(0x17aa, 0x2317, "Thinkpad P1 Gen 6", ALC287_FIXUP_CS35L41_I2C_2),
-	SND_PCI_QUIRK(0x17aa, 0x2318, "Thinkpad Z13 Gen2", ALC287_FIXUP_CS35L41_I2C_2),
-	SND_PCI_QUIRK(0x17aa, 0x2319, "Thinkpad Z16 Gen2", ALC287_FIXUP_CS35L41_I2C_2),
-	SND_PCI_QUIRK(0x17aa, 0x231a, "Thinkpad Z16 Gen2", ALC287_FIXUP_CS35L41_I2C_2),
+	SND_PCI_QUIRK(0x17aa, 0x22f1, "Thinkpad", ALC287_FIXUP_CS35L41_I2C_2_THINKPAD_ACPI),
+	SND_PCI_QUIRK(0x17aa, 0x22f2, "Thinkpad", ALC287_FIXUP_CS35L41_I2C_2_THINKPAD_ACPI),
+	SND_PCI_QUIRK(0x17aa, 0x22f3, "Thinkpad", ALC287_FIXUP_CS35L41_I2C_2_THINKPAD_ACPI),
+	SND_PCI_QUIRK(0x17aa, 0x2316, "Thinkpad P1 Gen 6", ALC287_FIXUP_CS35L41_I2C_2_THINKPAD_ACPI),
+	SND_PCI_QUIRK(0x17aa, 0x2317, "Thinkpad P1 Gen 6", ALC287_FIXUP_CS35L41_I2C_2_THINKPAD_ACPI),
+	SND_PCI_QUIRK(0x17aa, 0x2318, "Thinkpad Z13 Gen2", ALC287_FIXUP_CS35L41_I2C_2_THINKPAD_ACPI),
+	SND_PCI_QUIRK(0x17aa, 0x2319, "Thinkpad Z16 Gen2", ALC287_FIXUP_CS35L41_I2C_2_THINKPAD_ACPI),
+	SND_PCI_QUIRK(0x17aa, 0x231a, "Thinkpad Z16 Gen2", ALC287_FIXUP_CS35L41_I2C_2_THINKPAD_ACPI),
 	SND_PCI_QUIRK(0x17aa, 0x30bb, "ThinkCentre AIO", ALC233_FIXUP_LENOVO_LINE2_MIC_HOTKEY),
 	SND_PCI_QUIRK(0x17aa, 0x30e2, "ThinkCentre AIO", ALC233_FIXUP_LENOVO_LINE2_MIC_HOTKEY),
 	SND_PCI_QUIRK(0x17aa, 0x310c, "ThinkCentre Station", ALC294_FIXUP_LENOVO_MIC_LOCATION),
-- 
2.34.1

