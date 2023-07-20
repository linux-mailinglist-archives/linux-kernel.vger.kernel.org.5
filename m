Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D4A275B012
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 15:34:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231985AbjGTNdu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 09:33:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232076AbjGTNdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 09:33:35 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BD99272C
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 06:33:05 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 36K6Acqc016432;
        Thu, 20 Jul 2023 08:32:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        PODMain02222019; bh=m5DeZEEz3jTkGzJxONdedtCu4Ycd4osYT9FUHogrdRw=; b=
        L5RPClh3va/cVVEpEQHB8xeYk5qjogPNW2zTbnasC039m+oZ1Va7iayS27CjvpSe
        FubZ7OJWwA+UY0dA9V0SoNihIlTHGLTnNGAEw6xIwpY2z5qpO2pPBd98wH/+cBjd
        xBCrYQg7yvQwp1hlnPfvc4PbGjEcc5Db8w/ASQIwHEOycs4mvOMlwlMILLkwNagy
        z2KUga6yAv7DO+lh0FccAXisXm1IaW3hNfT40Qj9BGu4vkUvtr8PYoimVfiWRDV9
        WFHhO2FrZP/QI8RU5ekT3nFQrVugskCt8QLXFPJ7bwiZuraeX0WgsUDIcI26qsHF
        ZGE9c0pgtckBUTOktkN6jQ==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3rus6gx5mr-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Jul 2023 08:32:12 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Thu, 20 Jul
 2023 14:32:11 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.30 via Frontend Transport; Thu, 20 Jul 2023 14:32:11 +0100
Received: from sbinding-cirrus-dsktp2.ad.cirrus.com (unknown [198.90.238.219])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 6F2F5475;
        Thu, 20 Jul 2023 13:32:11 +0000 (UTC)
From:   Stefan Binding <sbinding@opensource.cirrus.com>
To:     Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: [PATCH v1 09/11] ALSA: hda/realtek: Support pre-/post- playback hooks for cs35l41
Date:   Thu, 20 Jul 2023 14:31:45 +0100
Message-ID: <20230720133147.1294337-10-sbinding@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230720133147.1294337-1-sbinding@opensource.cirrus.com>
References: <20230720133147.1294337-1-sbinding@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: ZDUwygU2_yM0CQX7uNIKvHJnlAUeJ-EG
X-Proofpoint-GUID: ZDUwygU2_yM0CQX7uNIKvHJnlAUeJ-EG
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hda_component now supports pre and post playback hooks.
These should be called for each amp in a loop before moving on
to the next hook.

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
---
 sound/pci/hda/patch_realtek.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index ac29965951833..4aa49d37ed9e6 100644
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

