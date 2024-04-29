Return-Path: <linux-kernel+bounces-162616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D21DF8B5E17
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 17:49:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48B1A1F21CE7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 15:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C11D84D27;
	Mon, 29 Apr 2024 15:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="dzTkWg1L"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4AA281736;
	Mon, 29 Apr 2024 15:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714405759; cv=none; b=D0RFOqFgikljlftthTQay4uqVxF4Ac98v59ND2+I3PErO+06CHpUz99PtSNwnU7/bNV2DJYTVbE2+JMZWEqnMF2d+NkwRH9zYHRNTMfMuEXpVzoGrmBEQ08SwBgRxHvvdtnQ9zpkbHmTwxc0ud2bJGxXnDQMAIyrCQUgR+XnNhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714405759; c=relaxed/simple;
	bh=fbDcR+863ldEgPUTug85jUVOFlRj10PC6IzPWMpGIyY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TZ4JBuQ7j67PtYbdMH78yOlRE4//TxJJu8SDoOG6lUs1UBUQwvWkfxTeZZ0VrkI5THK4kvtdy3aPeMd61vDXaOzIaL6raB5rKk8Gw1X7+9WdEG4sMw2S+PROPeP5RNs4GLg6sLjQxEt6fCiF6cnyvGoMc2XlmTJZsMPLUU45fj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=dzTkWg1L; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43T6vDHQ000342;
	Mon, 29 Apr 2024 10:48:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	PODMain02222019; bh=9rX3omQGqJf9uWnpTwa2t45+ZXn6wK3xOMXrQuWrcNw=; b=
	dzTkWg1LKXAWZe+YQl6RjhOj87dzoHypa4NhKE2mdg+2Ih9tnoP11wxQ0ADxxnBw
	VzGtjRVqQ+kG+DBGJbI8nbAOFUnusUj0FTJgHeib5A0qc8v3HyofQOERWkEUounp
	JG1kkSEeh26aPMis1vpB8Ov+Ip+Udxs/9f9D34mRRoP8RAO7TXCDiFriuBDN7tFJ
	k4sT8bt958igKlDeDBnKZGLWRjdqpA6QPeCCAwVML+XFVVVsYyJpBzolDbKviuV2
	G/VCszd5RRkwxFKeJyxtABuOEcatoNZny25kKgdXXkOvGhGpSQVSPydy7fyWiSCh
	b4/yOHT72kJQ0tJNDBy8dg==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3xrxry21tq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Apr 2024 10:48:58 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 29 Apr
 2024 16:48:56 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Mon, 29 Apr 2024 16:48:56 +0100
Received: from sbinding-cirrus-dsktp2.ad.cirrus.com (unknown [198.61.65.105])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id F379F82025A;
	Mon, 29 Apr 2024 15:48:55 +0000 (UTC)
From: Stefan Binding <sbinding@opensource.cirrus.com>
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC: <alsa-devel@alsa-project.org>, <linux-sound@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Stefan
 Binding" <sbinding@opensource.cirrus.com>
Subject: [PATCH v1 1/2] ALSA: hda: cs35l41: Ignore errors when configuring IRQs
Date: Mon, 29 Apr 2024 16:48:52 +0100
Message-ID: <20240429154853.9393-2-sbinding@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240429154853.9393-1-sbinding@opensource.cirrus.com>
References: <20240429154853.9393-1-sbinding@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: wWmmPx3iVyvJE8xCrS5BBZUIkpxVXHdi
X-Proofpoint-GUID: wWmmPx3iVyvJE8xCrS5BBZUIkpxVXHdi
X-Proofpoint-Spam-Reason: safe

IRQs used for CS35L41 HDA are used to detect and attempt to recover
from errors. Without these interrupts, the driver should behave as
normal.

For laptops which contain a bad configuration for the interrupt in the
BIOS, the current behaviour of failing when trying to configure the
interrupt means the probe fails, and audio is broken.

It is better for the user experience if the driver instead warns that
no interrupt is configured rather than simply failing.
The drawback is that if an error occurs without the interrupt, we
firstly would not be able to trace the issue, and secondly would not
be able to attempt to recover from the issue, but this is better than
failing immediately.

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
---
 sound/pci/hda/cs35l41_hda.c | 69 +++++++++++++++++++++++++------------
 1 file changed, 47 insertions(+), 22 deletions(-)

diff --git a/sound/pci/hda/cs35l41_hda.c b/sound/pci/hda/cs35l41_hda.c
index 74076fa45dd6..6c49e5c6cd20 100644
--- a/sound/pci/hda/cs35l41_hda.c
+++ b/sound/pci/hda/cs35l41_hda.c
@@ -1594,13 +1594,56 @@ static struct regmap_irq_chip cs35l41_regmap_irq_chip = {
 	.runtime_pm = true,
 };
 
+static void cs35l41_configure_interrupt(struct cs35l41_hda *cs35l41, int irq_pol)
+{
+	int irq;
+	int ret;
+	int i;
+
+	if (!cs35l41->irq) {
+		dev_warn(cs35l41->dev, "No Interrupt Found");
+		goto err;
+	}
+
+	ret = devm_regmap_add_irq_chip(cs35l41->dev, cs35l41->regmap, cs35l41->irq,
+					IRQF_ONESHOT | IRQF_SHARED | irq_pol,
+					0, &cs35l41_regmap_irq_chip, &cs35l41->irq_data);
+	if (ret) {
+		dev_dbg(cs35l41->dev, "Unable to add IRQ Chip: %d.", ret);
+		goto err;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(cs35l41_irqs); i++) {
+		irq = regmap_irq_get_virq(cs35l41->irq_data, cs35l41_irqs[i].irq);
+		if (irq < 0) {
+			ret = irq;
+			dev_dbg(cs35l41->dev, "Unable to map IRQ %s: %d.", cs35l41_irqs[i].name,
+				ret);
+			goto err;
+		}
+
+		ret = devm_request_threaded_irq(cs35l41->dev, irq, NULL,
+						cs35l41_irqs[i].handler,
+						IRQF_ONESHOT | IRQF_SHARED | irq_pol,
+						cs35l41_irqs[i].name, cs35l41);
+		if (ret) {
+			dev_dbg(cs35l41->dev, "Unable to allocate IRQ %s:: %d.",
+				cs35l41_irqs[i].name, ret);
+			goto err;
+		}
+	}
+	return;
+err:
+	dev_warn(cs35l41->dev,
+		 "IRQ Config Failed. Amp errors may not be recoverable without reboot.");
+}
+
 static int cs35l41_hda_apply_properties(struct cs35l41_hda *cs35l41)
 {
 	struct cs35l41_hw_cfg *hw_cfg = &cs35l41->hw_cfg;
 	bool using_irq = false;
-	int irq, irq_pol;
+	int irq_pol;
 	int ret;
-	int i;
 
 	if (!cs35l41->hw_cfg.valid)
 		return -EINVAL;
@@ -1643,26 +1686,8 @@ static int cs35l41_hda_apply_properties(struct cs35l41_hda *cs35l41)
 
 	irq_pol = cs35l41_gpio_config(cs35l41->regmap, hw_cfg);
 
-	if (cs35l41->irq && using_irq) {
-		ret = devm_regmap_add_irq_chip(cs35l41->dev, cs35l41->regmap, cs35l41->irq,
-					       IRQF_ONESHOT | IRQF_SHARED | irq_pol,
-					       0, &cs35l41_regmap_irq_chip, &cs35l41->irq_data);
-		if (ret)
-			return ret;
-
-		for (i = 0; i < ARRAY_SIZE(cs35l41_irqs); i++) {
-			irq = regmap_irq_get_virq(cs35l41->irq_data, cs35l41_irqs[i].irq);
-			if (irq < 0)
-				return irq;
-
-			ret = devm_request_threaded_irq(cs35l41->dev, irq, NULL,
-							cs35l41_irqs[i].handler,
-							IRQF_ONESHOT | IRQF_SHARED | irq_pol,
-							cs35l41_irqs[i].name, cs35l41);
-			if (ret)
-				return ret;
-		}
-	}
+	if (using_irq)
+		cs35l41_configure_interrupt(cs35l41, irq_pol);
 
 	return cs35l41_hda_channel_map(cs35l41->dev, 0, NULL, 1, &hw_cfg->spk_pos);
 }
-- 
2.34.1


