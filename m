Return-Path: <linux-kernel+bounces-36853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5191E83A7B5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 12:26:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6EAB1F22D11
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 11:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06DFA1B274;
	Wed, 24 Jan 2024 11:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="hd6Zaf9Q"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B495D1AAD3;
	Wed, 24 Jan 2024 11:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706095588; cv=none; b=Z4eKtmkRM10MN/qu4z67rIqz4AqMyDbj5tHopgfxSiy5etfiOzl+THHn05S84Wt8/9cpx6BWusqRUhaXVRc6oIauCEha+ldg1tkxPKCSi6VWr2vTCdQ+/whUxZYCaXWDgeh3fU/NxdbjBdp47USwjEWrG2ien8W77hBNdLeJMfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706095588; c=relaxed/simple;
	bh=ACl9OKKd1hYaYZUvRjBxjN1AVItWVDBQD0aFVxnQE4c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EC856X+Z+6KGYHlc+XbDcKNSsltaFuvIDvc4QsW2UBVb52H6U4Qvq0jAT0HL4W0vqHc2qxYDGRhZaERcI9gsqVDASPqqb43v/c/HT957zDECk49krqEjXTes/YyD5Wp0mTb/IJkRsUmqV6oeWmXVAWGFux4OERMcCtLFeCT7Pk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=hd6Zaf9Q; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40O4banO023994;
	Wed, 24 Jan 2024 05:26:09 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	PODMain02222019; bh=NfaVHqV3QAdzaoZI36J4vl2G+SdDrbS5YrJZHom/gWc=; b=
	hd6Zaf9QMrjctYsmnS5RyviUHipbJk3jjMHsPQgDlPRjVoWMj147Uv6dHLyFrdmb
	rGHFaLrvY2Uurp4pO8vVVDximWqWUIaFzcJlWraHaIv4B3fIJ0Ob1RFGH/LM8mOu
	aKvVDeIRuxLRq0ryXPanFik9q3H8NWl30zeSf4KBIehjGV4s18CRU5oLtfBxuar5
	rio5ZF3H6d+Z8kANrW0FtAL16m/n4fyvQPuJ1MWbmLoLRCygtjXMUpKD/yTmIwMU
	wz/O2IsxrZSak4415c3aaPDPG+8vMDS01PPHFYd016cY5z555hk5IKzZAoJ4OBX5
	2Szd54ABF4i7nvroaTGqkg==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3vtmf9rq8g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jan 2024 05:26:09 -0600 (CST)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 24 Jan
 2024 11:26:07 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40 via Frontend Transport; Wed, 24 Jan 2024 11:26:07 +0000
Received: from ediswws06.ad.cirrus.com (ediswws06.ad.cirrus.com [198.90.251.117])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 8FE75820247;
	Wed, 24 Jan 2024 11:26:07 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <tiwai@suse.com>, <soyer@irl.hu>, <shenghao-ding@ti.com>
CC: <perex@perex.cz>, <linux-kernel@vger.kernel.org>,
        <linux-sound@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <patches@opensource.cirrus.com>,
        Richard Fitzgerald
	<rf@opensource.cirrus.com>
Subject: [PATCH 1/2] ALSA: hda: realtek: Re-work CS35L41 fixups to re-use for other amps
Date: Wed, 24 Jan 2024 11:26:06 +0000
Message-ID: <20240124112607.77614-2-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240124112607.77614-1-rf@opensource.cirrus.com>
References: <20240124112607.77614-1-rf@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: E17i4__LtRZQrKC626O6dj176eIYz-5j
X-Proofpoint-ORIG-GUID: E17i4__LtRZQrKC626O6dj176eIYz-5j
X-Proofpoint-Spam-Reason: safe

Slightly re-work the code around cs35l41_generic_fixup() and the component
binding search so that it can be re-used for other amps that use the
component binding mechanism.

The match string is stored in struct scodec_dev_name instead of hardcoding
it in the match function.

The tas2781 does not use the amp index as part of the driver name match.
But its match format string does not include a field for the index, so
snprintf() would safely ignore the p->index argument. Because of this there
is no need for a special match function for this case, the CS35L41 code
can be re-used.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
Can someone test that this doesn't break the two TAS2781 fixups?
---
 sound/pci/hda/patch_realtek.c | 83 +++++++----------------------------
 1 file changed, 15 insertions(+), 68 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 19f2eb26659d..2e2906d2dd1c 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -6841,11 +6841,12 @@ static void comp_generic_playback_hook(struct hda_pcm_stream *hinfo, struct hda_
 struct scodec_dev_name {
 	const char *bus;
 	const char *hid;
+	const char *match_str;
 	int index;
 };
 
 /* match the device name in a slightly relaxed manner */
-static int comp_match_cs35l41_dev_name(struct device *dev, void *data)
+static int comp_match_dev_name(struct device *dev, void *data)
 {
 	struct scodec_dev_name *p = data;
 	const char *d = dev_name(dev);
@@ -6859,32 +6860,12 @@ static int comp_match_cs35l41_dev_name(struct device *dev, void *data)
 	if (isdigit(d[n]))
 		n++;
 	/* the rest must be exact matching */
-	snprintf(tmp, sizeof(tmp), "-%s:00-cs35l41-hda.%d", p->hid, p->index);
+	snprintf(tmp, sizeof(tmp), p->match_str, p->hid, p->index);
 	return !strcmp(d + n, tmp);
 }
 
-static int comp_match_tas2781_dev_name(struct device *dev,
-	void *data)
-{
-	struct scodec_dev_name *p = data;
-	const char *d = dev_name(dev);
-	int n = strlen(p->bus);
-	char tmp[32];
-
-	/* check the bus name */
-	if (strncmp(d, p->bus, n))
-		return 0;
-	/* skip the bus number */
-	if (isdigit(d[n]))
-		n++;
-	/* the rest must be exact matching */
-	snprintf(tmp, sizeof(tmp), "-%s:00", p->hid);
-
-	return !strcmp(d + n, tmp);
-}
-
-static void cs35l41_generic_fixup(struct hda_codec *cdc, int action, const char *bus,
-				  const char *hid, int count)
+static void comp_generic_fixup(struct hda_codec *cdc, int action, const char *bus,
+			       const char *hid, const char *match_str, int count)
 {
 	struct device *dev = hda_codec_dev(cdc);
 	struct alc_spec *spec = cdc->spec;
@@ -6899,10 +6880,11 @@ static void cs35l41_generic_fixup(struct hda_codec *cdc, int action, const char
 				return;
 			rec->bus = bus;
 			rec->hid = hid;
+			rec->match_str = match_str;
 			rec->index = i;
 			spec->comps[i].codec = cdc;
 			component_match_add(dev, &spec->match,
-					    comp_match_cs35l41_dev_name, rec);
+					    comp_match_dev_name, rec);
 		}
 		ret = component_master_add_with_match(dev, &comp_master_ops, spec->match);
 		if (ret)
@@ -6916,83 +6898,48 @@ static void cs35l41_generic_fixup(struct hda_codec *cdc, int action, const char
 	}
 }
 
-static void tas2781_generic_fixup(struct hda_codec *cdc, int action,
-	const char *bus, const char *hid)
-{
-	struct device *dev = hda_codec_dev(cdc);
-	struct alc_spec *spec = cdc->spec;
-	struct scodec_dev_name *rec;
-	int ret;
-
-	switch (action) {
-	case HDA_FIXUP_ACT_PRE_PROBE:
-		rec = devm_kmalloc(dev, sizeof(*rec), GFP_KERNEL);
-		if (!rec)
-			return;
-		rec->bus = bus;
-		rec->hid = hid;
-		rec->index = 0;
-		spec->comps[0].codec = cdc;
-		component_match_add(dev, &spec->match,
-			comp_match_tas2781_dev_name, rec);
-		ret = component_master_add_with_match(dev, &comp_master_ops,
-			spec->match);
-		if (ret)
-			codec_err(cdc,
-				"Fail to register component aggregator %d\n",
-				ret);
-		else
-			spec->gen.pcm_playback_hook =
-				comp_generic_playback_hook;
-		break;
-	case HDA_FIXUP_ACT_FREE:
-		component_master_del(dev, &comp_master_ops);
-		break;
-	}
-}
-
 static void cs35l41_fixup_i2c_two(struct hda_codec *cdc, const struct hda_fixup *fix, int action)
 {
-	cs35l41_generic_fixup(cdc, action, "i2c", "CSC3551", 2);
+	comp_generic_fixup(cdc, action, "i2c", "CSC3551", "-%s:00-cs35l41-hda.%d", 2);
 }
 
 static void cs35l41_fixup_i2c_four(struct hda_codec *cdc, const struct hda_fixup *fix, int action)
 {
-	cs35l41_generic_fixup(cdc, action, "i2c", "CSC3551", 4);
+	comp_generic_fixup(cdc, action, "i2c", "CSC3551", "-%s:00-cs35l41-hda.%d", 4);
 }
 
 static void cs35l41_fixup_spi_two(struct hda_codec *codec, const struct hda_fixup *fix, int action)
 {
-	cs35l41_generic_fixup(codec, action, "spi", "CSC3551", 2);
+	comp_generic_fixup(codec, action, "spi", "CSC3551", "-%s:00-cs35l41-hda.%d", 2);
 }
 
 static void cs35l41_fixup_spi_four(struct hda_codec *codec, const struct hda_fixup *fix, int action)
 {
-	cs35l41_generic_fixup(codec, action, "spi", "CSC3551", 4);
+	comp_generic_fixup(codec, action, "spi", "CSC3551", "-%s:00-cs35l41-hda.%d", 4);
 }
 
 static void alc287_fixup_legion_16achg6_speakers(struct hda_codec *cdc, const struct hda_fixup *fix,
 						 int action)
 {
-	cs35l41_generic_fixup(cdc, action, "i2c", "CLSA0100", 2);
+	comp_generic_fixup(cdc, action, "i2c", "CLSA0100", "-%s:00-cs35l41-hda.%d", 2);
 }
 
 static void alc287_fixup_legion_16ithg6_speakers(struct hda_codec *cdc, const struct hda_fixup *fix,
 						 int action)
 {
-	cs35l41_generic_fixup(cdc, action, "i2c", "CLSA0101", 2);
+	comp_generic_fixup(cdc, action, "i2c", "CLSA0101", "-%s:00-cs35l41-hda.%d", 2);
 }
 
 static void tas2781_fixup_i2c(struct hda_codec *cdc,
 	const struct hda_fixup *fix, int action)
 {
-	 tas2781_generic_fixup(cdc, action, "i2c", "TIAS2781");
+	comp_generic_fixup(cdc, action, "i2c", "TIAS2781", "-%s:00", 1);
 }
 
 static void yoga7_14arb7_fixup_i2c(struct hda_codec *cdc,
 	const struct hda_fixup *fix, int action)
 {
-	 tas2781_generic_fixup(cdc, action, "i2c", "INT8866");
+	comp_generic_fixup(cdc, action, "i2c", "INT8866", "-%s:00", 1);
 }
 
 /* for alc295_fixup_hp_top_speakers */
-- 
2.30.2


