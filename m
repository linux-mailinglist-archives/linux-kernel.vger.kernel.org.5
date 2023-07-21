Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 004BA75CB64
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 17:19:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232040AbjGUPTw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 11:19:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231888AbjGUPTY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 11:19:24 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7EF535B1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 08:18:56 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 36LDppwl011284;
        Fri, 21 Jul 2023 10:18:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        PODMain02222019; bh=VPgIFBsUn3H5pnKrozNRp6S6xNZJzvk/yj1GdWeV/2w=; b=
        ZKmCigc7FhfyzYcrvwcajY32aAvQMV5HGMcbMUFjPYqMqnwGkGQ110ytI74UFs2U
        7PSmiUjr1CidrEWFWf+/Y8fiZdY19kKOOr2qp9sggsgc6S2E865WANx3a/UGQmaq
        Eu+JzLm2yHfuuinZRbsEcaeNAimy6wL1B/wCyokVkAzKLnodVoClWJIdKTTCAFyW
        qwrsol8T/qTst1sZnhtLnoYsSGiOktnLvtXnCaG4wIb3XXV0hjQJbehCmLlv7Qyr
        eod8iRD3yIg3Z3CXJ9HNOWHrdi31HYVOiWhxv5hOZw2j12RmvcFm9cwnxYM9bSUB
        SCXuqZiC6vwqsaibw7+rLA==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3rus62y8g5-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Jul 2023 10:18:31 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Fri, 21 Jul
 2023 16:18:26 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.30 via Frontend
 Transport; Fri, 21 Jul 2023 16:18:26 +0100
Received: from sbinding-cirrus-dsktp2.ad.cirrus.com (unknown [198.90.238.219])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id ACFE33560;
        Fri, 21 Jul 2023 15:18:26 +0000 (UTC)
From:   Stefan Binding <sbinding@opensource.cirrus.com>
To:     Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: [PATCH v2 05/11] ALSA: hda: cs35l41: Ensure we pass up any errors during system suspend.
Date:   Fri, 21 Jul 2023 16:18:10 +0100
Message-ID: <20230721151816.2080453-6-sbinding@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230721151816.2080453-1-sbinding@opensource.cirrus.com>
References: <20230721151816.2080453-1-sbinding@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: j4bellYsHj3HXBjwmM23TvP8QmmmQ3V4
X-Proofpoint-ORIG-GUID: j4bellYsHj3HXBjwmM23TvP8QmmmQ3V4
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

There are several steps required to put the system into system suspend.
Some of these steps may fail, so the driver should pass up the errors
if they occur.

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
---
 sound/pci/hda/cs35l41_hda.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/sound/pci/hda/cs35l41_hda.c b/sound/pci/hda/cs35l41_hda.c
index f42457147ce47..d4a11f7b5dbd1 100644
--- a/sound/pci/hda/cs35l41_hda.c
+++ b/sound/pci/hda/cs35l41_hda.c
@@ -626,17 +626,22 @@ static int cs35l41_system_suspend(struct device *dev)
 	}
 
 	ret = pm_runtime_force_suspend(dev);
-	if (ret)
+	if (ret) {
+		dev_err(dev, "System Suspend Failed, unable to runtime suspend: %d\n", ret);
 		return ret;
+	}
 
 	/* Shutdown DSP before system suspend */
-	cs35l41_ready_for_reset(cs35l41);
+	ret = cs35l41_ready_for_reset(cs35l41);
+
+	if (ret)
+		dev_err(dev, "System Suspend Failed, not ready for Reset: %d\n", ret);
 
 	/*
 	 * Reset GPIO may be shared, so cannot reset here.
 	 * However beyond this point, amps may be powered down.
 	 */
-	return 0;
+	return ret;
 }
 
 static int cs35l41_system_resume(struct device *dev)
@@ -659,9 +664,13 @@ static int cs35l41_system_resume(struct device *dev)
 	usleep_range(2000, 2100);
 
 	ret = pm_runtime_force_resume(dev);
+	if (ret) {
+		dev_err(dev, "System Resume Failed: Unable to runtime resume: %d\n", ret);
+		return ret;
+	}
 
 	mutex_lock(&cs35l41->fw_mutex);
-	if (!ret && cs35l41->request_fw_load && !cs35l41->fw_request_ongoing) {
+	if (cs35l41->request_fw_load && !cs35l41->fw_request_ongoing) {
 		cs35l41->fw_request_ongoing = true;
 		schedule_work(&cs35l41->fw_load_work);
 	}
-- 
2.34.1

