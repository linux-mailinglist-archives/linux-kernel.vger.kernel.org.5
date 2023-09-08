Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F0427987FB
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 15:35:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234019AbjIHNfx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 09:35:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234143AbjIHNfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 09:35:52 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC5011FF2
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 06:35:14 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 388DVCU0024816;
        Fri, 8 Sep 2023 08:34:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        PODMain02222019; bh=MaHpdygZ/aP2aJTDzDqitZm8Hr1umO0xthwnGH/UKh4=; b=
        G6WMWTjK+brkm/8fSwE632PICyjNw+OxehYRavKt5MIvmaKtDRJvMd+4XoPVzfWG
        8slrv3IVHn0V9D0a2dSmZ/Ur/ZuxF6Qa89UIBjd08Qc5w8H4dY1xpZeQnbLQZcSA
        XYwnMT52rSanUiyYN0cQsKn8PVxPx4dL3nXy3dVA49h3ycmzteBH/aOwBLBLIZXt
        WMVMEzrPgDOQO9/C4I8H+YVY9JhQ8xO9sH4ns3b60oHrS1kDmwtPDNuw3cf3461E
        HXtj1AKSbLuepPqQ5Nhlw7N7zorlCes7kFLBeHPC/Xc+aPOFT2hJfrFV16tDO8j3
        nloycS5FoFYoWFccXkQMjQ==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3t04h1g08b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Sep 2023 08:34:39 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.37; Fri, 8 Sep
 2023 14:34:30 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.37 via Frontend Transport; Fri, 8 Sep 2023 14:34:30 +0100
Received: from sbinding-cirrus-dsktp2.ad.cirrus.com (unknown [198.90.238.124])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 940AD46B;
        Fri,  8 Sep 2023 13:34:30 +0000 (UTC)
From:   Stefan Binding <sbinding@opensource.cirrus.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: [PATCH v2 2/2] ALSA: hda: cs35l41: Add read-only ALSA control for forced mute
Date:   Fri, 8 Sep 2023 14:34:21 +0100
Message-ID: <20230908133421.2483508-3-sbinding@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230908133421.2483508-1-sbinding@opensource.cirrus.com>
References: <20230908133421.2483508-1-sbinding@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: Ct-XlMM3c1eiSANC6gJislT3L00ODqoi
X-Proofpoint-GUID: Ct-XlMM3c1eiSANC6gJislT3L00ODqoi
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the CS35L41 amp is requested to mute using the ACPI
notification mechanism, userspace is not notified that the amp
is muted. To allow userspace to know about the mute, add an
ALSA control which tracks the forced mute override.
This control does not track the overall mute state of the amp,
since the amp is only unmuted during playback anyway, instead
it tracks the mute override request from the ACPI notification.

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
---
 sound/pci/hda/cs35l41_hda.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/sound/pci/hda/cs35l41_hda.c b/sound/pci/hda/cs35l41_hda.c
index 18ca00c0a8cd..92b815ce193b 100644
--- a/sound/pci/hda/cs35l41_hda.c
+++ b/sound/pci/hda/cs35l41_hda.c
@@ -972,6 +972,15 @@ static int cs35l41_fw_load_ctl_get(struct snd_kcontrol *kcontrol,
 	return 0;
 }
 
+static int cs35l41_mute_override_ctl_get(struct snd_kcontrol *kcontrol,
+					 struct snd_ctl_elem_value *ucontrol)
+{
+	struct cs35l41_hda *cs35l41 = snd_kcontrol_chip(kcontrol);
+
+	ucontrol->value.integer.value[0] = cs35l41->mute_override;
+	return 0;
+}
+
 static void cs35l41_fw_load_work(struct work_struct *work)
 {
 	struct cs35l41_hda *cs35l41 = container_of(work, struct cs35l41_hda, fw_load_work);
@@ -1055,6 +1064,7 @@ static int cs35l41_create_controls(struct cs35l41_hda *cs35l41)
 {
 	char fw_type_ctl_name[SNDRV_CTL_ELEM_ID_NAME_MAXLEN];
 	char fw_load_ctl_name[SNDRV_CTL_ELEM_ID_NAME_MAXLEN];
+	char mute_override_ctl_name[SNDRV_CTL_ELEM_ID_NAME_MAXLEN];
 	struct snd_kcontrol_new fw_type_ctl = {
 		.name = fw_type_ctl_name,
 		.iface = SNDRV_CTL_ELEM_IFACE_CARD,
@@ -1069,12 +1079,21 @@ static int cs35l41_create_controls(struct cs35l41_hda *cs35l41)
 		.get = cs35l41_fw_load_ctl_get,
 		.put = cs35l41_fw_load_ctl_put,
 	};
+	struct snd_kcontrol_new mute_override_ctl = {
+		.name = mute_override_ctl_name,
+		.iface = SNDRV_CTL_ELEM_IFACE_CARD,
+		.info = snd_ctl_boolean_mono_info,
+		.access = SNDRV_CTL_ELEM_ACCESS_READ | SNDRV_CTL_ELEM_ACCESS_VOLATILE,
+		.get = cs35l41_mute_override_ctl_get,
+	};
 	int ret;
 
 	scnprintf(fw_type_ctl_name, SNDRV_CTL_ELEM_ID_NAME_MAXLEN, "%s DSP1 Firmware Type",
 		  cs35l41->amp_name);
 	scnprintf(fw_load_ctl_name, SNDRV_CTL_ELEM_ID_NAME_MAXLEN, "%s DSP1 Firmware Load",
 		  cs35l41->amp_name);
+	scnprintf(mute_override_ctl_name, SNDRV_CTL_ELEM_ID_NAME_MAXLEN, "%s Forced Mute Status",
+		  cs35l41->amp_name);
 
 	ret = snd_ctl_add(cs35l41->codec->card, snd_ctl_new1(&fw_type_ctl, cs35l41));
 	if (ret) {
@@ -1092,6 +1111,15 @@ static int cs35l41_create_controls(struct cs35l41_hda *cs35l41)
 
 	dev_dbg(cs35l41->dev, "Added Control %s\n", fw_load_ctl.name);
 
+	ret = snd_ctl_add(cs35l41->codec->card, snd_ctl_new1(&mute_override_ctl, cs35l41));
+	if (ret) {
+		dev_err(cs35l41->dev, "Failed to add KControl %s = %d\n", mute_override_ctl.name,
+			ret);
+		return ret;
+	}
+
+	dev_dbg(cs35l41->dev, "Added Control %s\n", mute_override_ctl.name);
+
 	return 0;
 }
 
-- 
2.34.1

