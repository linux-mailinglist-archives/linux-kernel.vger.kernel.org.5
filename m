Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 396F77A0909
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 17:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240875AbjINPZl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 11:25:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235048AbjINPZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 11:25:40 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA35DC6
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 08:25:35 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 38ECunMr020490;
        Thu, 14 Sep 2023 10:25:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding:content-type; s=PODMain02222019; bh=q
        ygg2TVwFG6lKmZeeKC9INbE7+tFtemrFvcVvzZt+To=; b=qi+ZUMqO1tU9ij+0V
        q5mfM2KtEBchrQTsq7seqoCFLjCKcjm+SFrzGAdgLhQqjy98CzRPVv8oo4SY1aLH
        vW1OdwLMZUwSbCkfV1bOt7mINd+t+w0Dd8PtqLZuKxY3KzOeDzLCL1/TsS7Bicq5
        BW6v57nqHwhdVeiNoiHt2zdNxwcBuZqQdNMAsyEHrvfUqDtP+8+SVQgYiqlIJwNK
        +u8Qlu2wG0KUwCwxd020b01ZHh3sO2Blg0x+NEINStyYH5d/++1dmChKSpkF/UBC
        +bq4ZTP72TYMfyX9J54+V8cV5CBPxcmlBotpen3Fsu1Cml5a/EYFMcgWWgo+FCGQ
        9tqPA==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3t2y7sj9g5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Sep 2023 10:25:28 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.37; Thu, 14 Sep
 2023 16:25:27 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.37 via Frontend Transport; Thu, 14 Sep 2023 16:25:27 +0100
Received: from EDIN4L06LR3.ad.cirrus.com (EDIN4L06LR3.ad.cirrus.com [198.61.65.215])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id E561F3563;
        Thu, 14 Sep 2023 15:25:26 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH v2] ALSA: hda: cs35l56: Fix missing RESET GPIO if _SUB is missing
Date:   Thu, 14 Sep 2023 16:25:25 +0100
Message-ID: <20230914152525.20829-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: hvb46J8ibE00wLVH5auGSVmnOad4e6AQ
X-Proofpoint-ORIG-GUID: hvb46J8ibE00wLVH5auGSVmnOad4e6AQ
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In cs35l56_hda_read_acpi() do not return if ACPI _SUB is missing.

A missing _SUB means that the driver cannot load a system-specific
firmware, because the firmware is identified by the _SUB. But it can
fallback to a generic firmware. Unfortunately this was being handled
by immediately returning 0, which would skip the remaining ACPI
configuration in cs35l56_hda_read_acpi() and so it would not get the
RESET GPIO.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Fixes: 73cfbfa9caea ("ALSA: hda/cs35l56: Add driver for Cirrus Logic CS35L56 amplifier")
---
 sound/pci/hda/cs35l56_hda.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/sound/pci/hda/cs35l56_hda.c b/sound/pci/hda/cs35l56_hda.c
index bc75865b5de8..87ffe8fbff99 100644
--- a/sound/pci/hda/cs35l56_hda.c
+++ b/sound/pci/hda/cs35l56_hda.c
@@ -865,15 +865,13 @@ static int cs35l56_hda_read_acpi(struct cs35l56_hda *cs35l56, int id)
 	sub = acpi_get_subsystem_id(ACPI_HANDLE(cs35l56->base.dev));
 
 	if (IS_ERR(sub)) {
-		/* If no ACPI SUB, return 0 and fallback to legacy firmware path, otherwise fail */
-		if (PTR_ERR(sub) == -ENODATA)
-			return 0;
-		else
-			return PTR_ERR(sub);
+		dev_info(cs35l56->base.dev,
+			 "Read ACPI _SUB failed(%ld): fallback to generic firmware\n",
+			 PTR_ERR(sub));
+	} else {
+		cs35l56->system_name = sub;
 	}
 
-	cs35l56->system_name = sub;
-
 	cs35l56->base.reset_gpio = devm_gpiod_get_index_optional(cs35l56->base.dev,
 								 "reset",
 								 cs35l56->index,
-- 
2.30.2

