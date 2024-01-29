Return-Path: <linux-kernel+bounces-43095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6BB6840B7F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 17:31:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 085512905BC
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 16:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 488AC15AADF;
	Mon, 29 Jan 2024 16:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="C1FsGSbj"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32326158D8E;
	Mon, 29 Jan 2024 16:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706545688; cv=none; b=m3xlzzzf7aZ80Th/QWLjl0Q1G+e7yavsY37gZBUiOpxFEzDoWVMIDSvJQpsr1VoCsR0h7dT5IFsU6pYwbOIAQ5vorh4NIsd2sDmFWgkrQ+wJyM1QuphqSoe1W+p/mIO+ACovp3EShkhiiRrGsVetEXrP2aptWOHwvQFAL5JW3/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706545688; c=relaxed/simple;
	bh=h0rgb6aZm4gwgUniAiZJ+bxuduUl6CsjAiO7cHkbWBM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SDpOIY65cybnHgr9ntmDrzGF3inCtyLKB7pQj2ePDvyJpkGfZBQTp3tPTKGzae5LBTJM2bqiREbmP09FpqoW5eqz4ra4i549i+wNzqYhxcGderGQjon3TyopdRrYIz3pARrUHNGWueTfyvJUNqdqVNiOboqq+8jzPKmEagdqB3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=C1FsGSbj; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40T5fM0P006968;
	Mon, 29 Jan 2024 10:27:58 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	PODMain02222019; bh=w4CGZbUCOC1yLU5NKzT5GdiUkJej28e0tOzXCRok5ms=; b=
	C1FsGSbjVsmQ7qt3rNFc5xvBEqxwaL5P1J2VMOsZGKUICcUuIa5mkFYux2xzCFyi
	N10PxZlSVZx55HFREquwZAFeMl0Ia2ACLNkgSf9tm9BI6+foKsaAQd5kzkwe8F65
	urbgaSxTYazMeMC+a1aChBnGcLa8N4rYuxAiv8q6H6iLXxB19mYNSnNCmo6YIjUp
	BSTsRLDl18c96sI2kG0AOdWTY3L0aHqhw0a0cfApZFC6y6Yhfd3Xef5I/7qCRkr7
	JSzFHNkbKCP3cLprQI7Or4pZ2b2rOkjd9/2/0uRaPPSFu0OEycGTtWN9u6XVXasM
	vhMjHgFz9O6hMicydxG+kg==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3vvy4nta8p-9
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jan 2024 10:27:58 -0600 (CST)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 29 Jan
 2024 16:27:46 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40 via Frontend Transport; Mon, 29 Jan 2024 16:27:46 +0000
Received: from EDIN4L06LR3.ad.cirrus.com (EDIN4L06LR3.ad.cirrus.com [198.61.64.204])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id E03C7820247;
	Mon, 29 Jan 2024 16:27:45 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <broonie@kernel.org>, <tiwai@suse.com>
CC: <alsa-devel@alsa-project.org>, <linux-sound@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Richard
 Fitzgerald" <rf@opensource.cirrus.com>
Subject: [PATCH 13/18] ASoC: cs35l56: Load tunings for the correct speaker models
Date: Mon, 29 Jan 2024 16:27:32 +0000
Message-ID: <20240129162737.497-14-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240129162737.497-1-rf@opensource.cirrus.com>
References: <20240129162737.497-1-rf@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: mws68Ze2d3ptg8Hci6V7kFmy9aJMOmA4
X-Proofpoint-GUID: mws68Ze2d3ptg8Hci6V7kFmy9aJMOmA4
X-Proofpoint-Spam-Reason: safe

If the "spk-id-gpios" property is present it points to GPIOs whose
value must be used to select the correct bin file to match the
speakers.

Some manufacturers use multiple sources of speakers, which need
different tunings for best performance. On these models the type of
speaker fitted is indicated by the values of one or more GPIOs. The
number formed by the GPIOs identifies the tuning required.

The speaker ID must be used in combination with the subsystem ID
(either from PCI SSID or cirrus,firmware-uid property), because the
GPIOs can only indicate variants of a specific model.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Fixes: 1a1c3d794ef6 ("ASoC: cs35l56: Use PCI SSID as the firmware UID")
---
 include/sound/cs35l56.h           |  1 +
 sound/soc/codecs/cs35l56-shared.c | 36 +++++++++++++++++++++++++++++++
 sound/soc/codecs/cs35l56.c        | 32 ++++++++++++++++++++++-----
 sound/soc/codecs/cs35l56.h        |  1 +
 4 files changed, 65 insertions(+), 5 deletions(-)

diff --git a/include/sound/cs35l56.h b/include/sound/cs35l56.h
index 5d6aefc41e64..23da6298ab37 100644
--- a/include/sound/cs35l56.h
+++ b/include/sound/cs35l56.h
@@ -289,6 +289,7 @@ void cs35l56_init_cs_dsp(struct cs35l56_base *cs35l56_base, struct cs_dsp *cs_ds
 int cs35l56_read_prot_status(struct cs35l56_base *cs35l56_base,
 			     bool *fw_missing, unsigned int *fw_version);
 int cs35l56_hw_init(struct cs35l56_base *cs35l56_base);
+int cs35l56_get_speaker_id(struct cs35l56_base *cs35l56_base);
 int cs35l56_get_bclk_freq_id(unsigned int freq);
 void cs35l56_fill_supply_names(struct regulator_bulk_data *data);
 
diff --git a/sound/soc/codecs/cs35l56-shared.c b/sound/soc/codecs/cs35l56-shared.c
index 33835535ef84..02fba4bc0a14 100644
--- a/sound/soc/codecs/cs35l56-shared.c
+++ b/sound/soc/codecs/cs35l56-shared.c
@@ -5,6 +5,7 @@
 // Copyright (C) 2023 Cirrus Logic, Inc. and
 //                    Cirrus Logic International Semiconductor Ltd.
 
+#include <linux/gpio/consumer.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 #include <linux/types.h>
@@ -736,6 +737,41 @@ int cs35l56_hw_init(struct cs35l56_base *cs35l56_base)
 }
 EXPORT_SYMBOL_NS_GPL(cs35l56_hw_init, SND_SOC_CS35L56_SHARED);
 
+int cs35l56_get_speaker_id(struct cs35l56_base *cs35l56_base)
+{
+	struct gpio_descs *descs;
+	int speaker_id;
+	int i, ret;
+
+	/* Read the speaker type qualifier from the motherboard GPIOs */
+	descs = gpiod_get_array_optional(cs35l56_base->dev, "spk-id", GPIOD_IN);
+	if (!descs) {
+		return -ENOENT;
+	} else if (IS_ERR(descs)) {
+		ret = PTR_ERR(descs);
+		return dev_err_probe(cs35l56_base->dev, ret, "Failed to get spk-id-gpios\n");
+	}
+
+	speaker_id = 0;
+	for (i = 0; i < descs->ndescs; i++) {
+		ret = gpiod_get_value_cansleep(descs->desc[i]);
+		if (ret < 0) {
+			dev_err_probe(cs35l56_base->dev, ret, "Failed to read spk-id[%d]\n", i);
+			goto err;
+		}
+
+		speaker_id |= (ret << i);
+	}
+
+	dev_dbg(cs35l56_base->dev, "Speaker ID = %d\n", speaker_id);
+	ret = speaker_id;
+err:
+	gpiod_put_array(descs);
+
+	return ret;
+}
+EXPORT_SYMBOL_NS_GPL(cs35l56_get_speaker_id, SND_SOC_CS35L56_SHARED);
+
 static const u32 cs35l56_bclk_valid_for_pll_freq_table[] = {
 	[0x0C] = 128000,
 	[0x0F] = 256000,
diff --git a/sound/soc/codecs/cs35l56.c b/sound/soc/codecs/cs35l56.c
index 597677422547..c23e29da4cfb 100644
--- a/sound/soc/codecs/cs35l56.c
+++ b/sound/soc/codecs/cs35l56.c
@@ -959,10 +959,19 @@ static int cs35l56_component_probe(struct snd_soc_component *component)
 
 	if (!cs35l56->dsp.system_name &&
 	    (snd_soc_card_get_pci_ssid(component->card, &vendor, &device) == 0)) {
-		cs35l56->dsp.system_name = devm_kasprintf(cs35l56->base.dev,
-							  GFP_KERNEL,
-							  "%04x%04x",
-							  vendor, device);
+		/* Append a speaker qualifier if there is a speaker ID */
+		if (cs35l56->speaker_id >= 0) {
+			cs35l56->dsp.system_name = devm_kasprintf(cs35l56->base.dev,
+								  GFP_KERNEL,
+								  "%04x%04x-spkid%d",
+								  vendor, device,
+								  cs35l56->speaker_id);
+		} else {
+			cs35l56->dsp.system_name = devm_kasprintf(cs35l56->base.dev,
+								  GFP_KERNEL,
+								  "%04x%04x",
+								  vendor, device);
+		}
 		if (!cs35l56->dsp.system_name)
 			return -ENOMEM;
 	}
@@ -1245,7 +1254,13 @@ static int cs35l56_get_firmware_uid(struct cs35l56_private *cs35l56)
 	if (ret < 0)
 		return 0;
 
-	cs35l56->dsp.system_name = devm_kstrdup(dev, prop, GFP_KERNEL);
+	/* Append a speaker qualifier if there is a speaker ID */
+	if (cs35l56->speaker_id >= 0)
+		cs35l56->dsp.system_name = devm_kasprintf(dev, GFP_KERNEL, "%s-spkid%d",
+							  prop, cs35l56->speaker_id);
+	else
+		cs35l56->dsp.system_name = devm_kstrdup(dev, prop, GFP_KERNEL);
+
 	if (cs35l56->dsp.system_name == NULL)
 		return -ENOMEM;
 
@@ -1260,6 +1275,7 @@ int cs35l56_common_probe(struct cs35l56_private *cs35l56)
 
 	init_completion(&cs35l56->init_completion);
 	mutex_init(&cs35l56->base.irq_lock);
+	cs35l56->speaker_id = -ENOENT;
 
 	dev_set_drvdata(cs35l56->base.dev, cs35l56);
 
@@ -1296,6 +1312,12 @@ int cs35l56_common_probe(struct cs35l56_private *cs35l56)
 		gpiod_set_value_cansleep(cs35l56->base.reset_gpio, 1);
 	}
 
+	ret = cs35l56_get_speaker_id(&cs35l56->base);
+	if ((ret < 0) && (ret != -ENOENT))
+		goto err;
+
+	cs35l56->speaker_id = ret;
+
 	ret = cs35l56_get_firmware_uid(cs35l56);
 	if (ret != 0)
 		goto err;
diff --git a/sound/soc/codecs/cs35l56.h b/sound/soc/codecs/cs35l56.h
index dc2fe4c91e67..596b141e3f96 100644
--- a/sound/soc/codecs/cs35l56.h
+++ b/sound/soc/codecs/cs35l56.h
@@ -45,6 +45,7 @@ struct cs35l56_private {
 	bool sdw_attached;
 	struct completion init_completion;
 
+	int speaker_id;
 	u32 rx_mask;
 	u32 tx_mask;
 	u8 asp_slot_width;
-- 
2.39.2


