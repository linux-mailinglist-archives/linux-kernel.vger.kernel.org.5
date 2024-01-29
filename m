Return-Path: <linux-kernel+bounces-43090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38D6D840B73
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 17:30:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E94C828EE0E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 16:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 495BE158D94;
	Mon, 29 Jan 2024 16:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="g4/gtMUe"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9059D157E81;
	Mon, 29 Jan 2024 16:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706545685; cv=none; b=aAyTHkVYs0k+30Z/j930tQaketpV2NEs3PgY8NPckxjLl8nMdeD23kelAWg+qoiNaxV71eqpbVFC97nPZ969w4+qXninneK6CKvlizJMLuvIxEyzBS4hPyvb8WerbbT2lIquo/gkbuKpqCd+6WrHZ7VGE+o83g/bMuhZ5F6i32s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706545685; c=relaxed/simple;
	bh=aNsf8rFngmr4TYBrPemJAolCtcIkgvbOTrD34WK1ofM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QQYYv7ZFR3hJktMz6t7ncEHAEnBMY9bNNa3JI/ReAYqQaYjt3akMPjvN8DDa1o0RYUMBSPuLtaVO+L2KuCTYKo142Eo+ELDktewh4gByqOsX9djxLLL0bG9KO+1ivjQOFAfPctea73xhVOS9mfBc4ITJxSaBWE54HtLlUR9YXZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=g4/gtMUe; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40T5fM0J006968;
	Mon, 29 Jan 2024 10:27:56 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	PODMain02222019; bh=hWIZx3SVGmXaP46UN8UM0rv5QCRd2JlcYKJUxWaPxiw=; b=
	g4/gtMUeCr9LbazmIhlkHShBXNV42hHdSdW2QsTwJ85mYLvYrMvjj+nyjALN5i0x
	t0mOzbvGnCJTqUPKjr8H5CB23gXVsnnc1coY4vVromAJ1O8sRFfEJCkR9MJuOIRC
	HXOxRwbrdoXtRwX6B/9OhdWeOEThox9UNKURdQahUfnk6qgb3O/V0CRC6Dh+nJR6
	JCFteRbZUqBFm+WqQ0D7sfxVHHd/+3Xbg5goPC9gwVXykri260haT0KbdALa4LVl
	T7y9jIaSThvLqIqmlS5TX9dLG95WUr/AEKjAyyRM7DEnIXf1fqHXRkoBHbi0TiZA
	66fgSWjv6Qmx1Ox/ja+hmA==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3vvy4nta8p-6
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jan 2024 10:27:55 -0600 (CST)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 29 Jan
 2024 16:27:44 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.40 via Frontend Transport; Mon, 29 Jan 2024 16:27:44 +0000
Received: from EDIN4L06LR3.ad.cirrus.com (EDIN4L06LR3.ad.cirrus.com [198.61.64.204])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 7E545820247;
	Mon, 29 Jan 2024 16:27:44 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <broonie@kernel.org>, <tiwai@suse.com>
CC: <alsa-devel@alsa-project.org>, <linux-sound@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Richard
 Fitzgerald" <rf@opensource.cirrus.com>
Subject: [PATCH 09/18] ALSA: hda: cs35l56: Initialize all ASP1 registers
Date: Mon, 29 Jan 2024 16:27:28 +0000
Message-ID: <20240129162737.497-10-rf@opensource.cirrus.com>
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
X-Proofpoint-ORIG-GUID: naKf23TEBYC8V5T512tzgCeMK3gg3Fb0
X-Proofpoint-GUID: naKf23TEBYC8V5T512tzgCeMK3gg3Fb0
X-Proofpoint-Spam-Reason: safe

Add ASP1_FRAME_CONTROL1, ASP1_FRAME_CONTROL5 and the ASP1_TX?_INPUT
registers to the sequence used to initialize the ASP configuration.
Write this sequence to the cache and directly to the registers to
ensure that they match.

A system-specific firmware can patch these registers to values that are
not the silicon default, so that the CS35L56 boots already in the
configuration used by Windows or by "driverless" Windows setups such
as factory tuning.

These may not match how Linux is configuring the HDA codec. And anyway
on Linux the ALSA controls are used to configure routing options.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Fixes: 73cfbfa9caea ("ALSA: hda/cs35l56: Add driver for Cirrus Logic CS35L56 amplifier")
---
 sound/pci/hda/cs35l56_hda.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/sound/pci/hda/cs35l56_hda.c b/sound/pci/hda/cs35l56_hda.c
index b61e1de8c4bf..f22bcb104a4e 100644
--- a/sound/pci/hda/cs35l56_hda.c
+++ b/sound/pci/hda/cs35l56_hda.c
@@ -30,14 +30,23 @@
   *  ASP1_RX_WL = 24 bits per sample
   *  ASP1_TX_WL = 24 bits per sample
   *  ASP1_RXn_EN 1..3 and ASP1_TXn_EN 1..4 disabled
+  *
+  * Override any Windows-specific mixer settings applied by the firmware.
   */
 static const struct reg_sequence cs35l56_hda_dai_config[] = {
 	{ CS35L56_ASP1_CONTROL1,	0x00000021 },
 	{ CS35L56_ASP1_CONTROL2,	0x20200200 },
 	{ CS35L56_ASP1_CONTROL3,	0x00000003 },
+	{ CS35L56_ASP1_FRAME_CONTROL1,	0x03020100 },
+	{ CS35L56_ASP1_FRAME_CONTROL5,	0x00020100 },
 	{ CS35L56_ASP1_DATA_CONTROL5,	0x00000018 },
 	{ CS35L56_ASP1_DATA_CONTROL1,	0x00000018 },
 	{ CS35L56_ASP1_ENABLES1,	0x00000000 },
+	{ CS35L56_ASP1TX1_INPUT,	0x00000018 },
+	{ CS35L56_ASP1TX2_INPUT,	0x00000019 },
+	{ CS35L56_ASP1TX3_INPUT,	0x00000020 },
+	{ CS35L56_ASP1TX4_INPUT,	0x00000028 },
+
 };
 
 static void cs35l56_hda_play(struct cs35l56_hda *cs35l56)
@@ -133,6 +142,10 @@ static int cs35l56_hda_runtime_resume(struct device *dev)
 		}
 	}
 
+	ret = cs35l56_force_sync_asp1_registers_from_cache(&cs35l56->base);
+	if (ret)
+		goto err;
+
 	return 0;
 
 err:
@@ -976,6 +989,9 @@ int cs35l56_hda_common_probe(struct cs35l56_hda *cs35l56, int id)
 
 	regmap_multi_reg_write(cs35l56->base.regmap, cs35l56_hda_dai_config,
 			       ARRAY_SIZE(cs35l56_hda_dai_config));
+	ret = cs35l56_force_sync_asp1_registers_from_cache(&cs35l56->base);
+	if (ret)
+		goto err;
 
 	/*
 	 * By default only enable one ASP1TXn, where n=amplifier index,
-- 
2.39.2


