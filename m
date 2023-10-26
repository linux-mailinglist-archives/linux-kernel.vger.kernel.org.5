Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2630D7D8585
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 17:06:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345389AbjJZPGh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 11:06:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345352AbjJZPGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 11:06:32 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B869E18F;
        Thu, 26 Oct 2023 08:06:30 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 39Q5GUre011654;
        Thu, 26 Oct 2023 10:06:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        PODMain02222019; bh=HEYmwSUimQpCUbn2HslBt1VQ9u6Os9uGPZpmdnfD33s=; b=
        F1bBjs5ZcxfAlLAroOAqoB85Ty66qD/8tHrHOu7Cp25fmktx9NhBye/T8YYKa2FF
        zIBSlmPyeLYFSWFgLY7oe8nwTYwhLl7XTiVjIkjDmV61f54jBXT8Bkt5tT8R99Jk
        wqP+P1j79+fu7BuM89XIXmxlvCwuaX7Y4tfsJoGMi1CcLoaKzklahlhiSrVYR2bT
        Rf+ySMxSPSr7/+8qTR8AezoiGo/S4WYFNq8YF1Jg2xKSahNpM7Z7afrNSojwIc4h
        o8S954+4vNSJT3JF1SdJ9YL+xL4JiA59Ok2kRuWmS2opWqWOB9bvRRIWcqQS0mRK
        RdEenZqxuL2yDxI2h3bXaQ==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3tvc1x94k9-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Oct 2023 10:06:10 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.37; Thu, 26 Oct
 2023 16:06:07 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.37 via Frontend
 Transport; Thu, 26 Oct 2023 16:06:07 +0100
Received: from sbinding-cirrus-dsktp2.ad.cirrus.com (unknown [198.90.238.177])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 5C64711AA;
        Thu, 26 Oct 2023 15:06:07 +0000 (UTC)
From:   Stefan Binding <sbinding@opensource.cirrus.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        "Mark Brown" <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <linux-sound@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Stefan Binding" <sbinding@opensource.cirrus.com>
Subject: [PATCH v1 1/8] ALSA: hda: cs35l41: Use reset label to get GPIO for HP Zbook Fury 17 G9
Date:   Thu, 26 Oct 2023 16:05:51 +0100
Message-ID: <20231026150558.2105827-2-sbinding@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026150558.2105827-1-sbinding@opensource.cirrus.com>
References: <20231026150558.2105827-1-sbinding@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: nUl2VjwxRNApK1UpUFXHASgEJ5J032wV
X-Proofpoint-ORIG-GUID: nUl2VjwxRNApK1UpUFXHASgEJ5J032wV
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This laptop has an incorrect setting in its _DSD for boost type, but
the rest of the _DSD is correct, and we can still use the reset label
to obtain the reset gpio.

Also fix channel map so that amp 0 is right, and amp 1 is left.

Fixes: 581523ee3652 ("ALSA: hda: cs35l41: Override the _DSD for HP Zbook Fury 17 G9 to correct boost type")

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
---
 sound/pci/hda/cs35l41_hda_property.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/cs35l41_hda_property.c b/sound/pci/hda/cs35l41_hda_property.c
index b62a4e6968e2..c83328971728 100644
--- a/sound/pci/hda/cs35l41_hda_property.c
+++ b/sound/pci/hda/cs35l41_hda_property.c
@@ -58,9 +58,16 @@ static int hp_vision_acpi_fix(struct cs35l41_hda *cs35l41, struct device *physde
 
 	cs35l41->index = id;
 	cs35l41->channel_index = 0;
-	cs35l41->reset_gpio = gpiod_get_index(physdev, NULL, 1, GPIOD_OUT_HIGH);
+
+	/*
+	 * This system has _DSD, it just contains an error, so we can still get the reset using
+	 * the "reset" label.
+	 */
+	cs35l41->reset_gpio = fwnode_gpiod_get_index(acpi_fwnode_handle(cs35l41->dacpi), "reset",
+						     cs35l41->index, GPIOD_OUT_LOW,
+						     "cs35l41-reset");
 	cs35l41->speaker_id = -ENOENT;
-	hw_cfg->spk_pos = cs35l41->index ? 1 : 0; // right:left
+	hw_cfg->spk_pos = cs35l41->index ? 0 : 1; // right:left
 	hw_cfg->gpio1.func = CS35L41_NOT_USED;
 	hw_cfg->gpio1.valid = true;
 	hw_cfg->gpio2.func = CS35L41_INTERRUPT;
-- 
2.34.1

