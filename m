Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C887C75CB66
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 17:19:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231636AbjGUPTz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 11:19:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231922AbjGUPTY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 11:19:24 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9086135B7
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 08:18:57 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 36LDppwo011284;
        Fri, 21 Jul 2023 10:18:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        PODMain02222019; bh=j37nKlnAnDmdNfGe63dPvdzAmcVymWBIePqBc5RtyJg=; b=
        bagMmyJje8RFK8jdOHL5xxSxlBSUqS3nYhNhZXKD0F7zaus68XfLkNfZcvIBCr+M
        u0xnAR5Aaz51OTeHftodNy1aAbdtWodYvrUZW6xU9Eg5X9nQkGYsp86FaOqWW5RZ
        8L2CrWdpP+FWgfU6Iox1YUOVHmQpVaLlkNVBPB34TclWYub7FLfnqKRSw2xRO4HE
        vUjW4LePI6N3tUo2BaJ23l1Q8axCT9e4GR4FZngZPvn+GBvJW6KJE+zfcn39Krbp
        6J6jDsk3nhXwGzfRur1l/2NKLce3bbqNnIX9E5wg57avy3t7l8Babp9IxfjSUI5D
        058Tm/Z9zxrGiJIDbdqjnQ==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3rus62y8g5-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Jul 2023 10:18:34 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Fri, 21 Jul
 2023 16:18:27 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.30 via Frontend
 Transport; Fri, 21 Jul 2023 16:18:27 +0100
Received: from sbinding-cirrus-dsktp2.ad.cirrus.com (unknown [198.90.238.219])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 3BA843572;
        Fri, 21 Jul 2023 15:18:27 +0000 (UTC)
From:   Stefan Binding <sbinding@opensource.cirrus.com>
To:     Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: [PATCH v2 07/11] ALSA: hda: hda_component: Add pre and post playback hooks to hda_component
Date:   Fri, 21 Jul 2023 16:18:12 +0100
Message-ID: <20230721151816.2080453-8-sbinding@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230721151816.2080453-1-sbinding@opensource.cirrus.com>
References: <20230721151816.2080453-1-sbinding@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: oPQdapLMK4Vngyeds10t5We7SIv8YL7k
X-Proofpoint-ORIG-GUID: oPQdapLMK4Vngyeds10t5We7SIv8YL7k
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These hooks can be used to add callbacks that would be run before and after
the main playback hooks. These hooks would be called for all amps, before
moving on to the next hook, i.e. pre_playback_hook would be called for
all amps, before the playback_hook is called for all amps, then finally
the post_playback_hook is called for all amps.

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
---
 sound/pci/hda/hda_component.h |  2 ++
 sound/pci/hda/patch_realtek.c | 10 +++++++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/hda_component.h b/sound/pci/hda/hda_component.h
index 534e845b9cd1d..f170aec967c18 100644
--- a/sound/pci/hda/hda_component.h
+++ b/sound/pci/hda/hda_component.h
@@ -15,5 +15,7 @@ struct hda_component {
 	struct device *dev;
 	char name[HDA_MAX_NAME_SIZE];
 	struct hda_codec *codec;
+	void (*pre_playback_hook)(struct device *dev, int action);
 	void (*playback_hook)(struct device *dev, int action);
+	void (*post_playback_hook)(struct device *dev, int action);
 };
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 52ea7d757d6ad..a6585afb77071 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -6716,9 +6716,17 @@ static void comp_generic_playback_hook(struct hda_pcm_stream *hinfo, struct hda_
 	int i;
 
 	for (i = 0; i < HDA_MAX_COMPONENTS; i++) {
-		if (spec->comps[i].dev)
+		if (spec->comps[i].dev && spec->comps[i].pre_playback_hook)
+			spec->comps[i].pre_playback_hook(spec->comps[i].dev, action);
+	}
+	for (i = 0; i < HDA_MAX_COMPONENTS; i++) {
+		if (spec->comps[i].dev && spec->comps[i].playback_hook)
 			spec->comps[i].playback_hook(spec->comps[i].dev, action);
 	}
+	for (i = 0; i < HDA_MAX_COMPONENTS; i++) {
+		if (spec->comps[i].dev && spec->comps[i].post_playback_hook)
+			spec->comps[i].post_playback_hook(spec->comps[i].dev, action);
+	}
 }
 
 struct cs35l41_dev_name {
-- 
2.34.1

