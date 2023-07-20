Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CF1775B013
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 15:34:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232018AbjGTNdx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 09:33:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232080AbjGTNdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 09:33:36 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45306273E
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 06:33:07 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 36KAupUp002185;
        Thu, 20 Jul 2023 08:32:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        PODMain02222019; bh=JqcxCQdId6GERpPzL031OjgEbu9ZZ+nMWXjwJ4Papww=; b=
        CWcVXas2kL/EYnIWX94FD/TM3ZKcdS/ojD3n1ci/DgdteXi+UsL+kDvLsj8XoDjy
        tPjAK/OYNmBL0gt2ntoxtjv4KDjPDsyXM9pdJwCDe2aC84npTtvqIJmYrc362L1S
        iqD7ad82gyRYghjwljD1/zVuC5naF2BvSR0tCpGsR21CuQBMzJ40WJDPvbmXAUKl
        pVetpgTZCeZLBIu5mzvCtZdnjSFk8VNQffbOSrZ5iNf60z+gYozKcAKMf3Kixlfo
        3d/7wcYQ+iZvox9/KNtHJNvfNQjRrFH84dicVeCEO/wkVhTdmCEyFuE+Pbhy66ps
        RU+3xHV3zf9w+fPajd89sA==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3rus6gx5mq-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Jul 2023 08:32:13 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Thu, 20 Jul
 2023 14:32:11 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.30 via Frontend
 Transport; Thu, 20 Jul 2023 14:32:11 +0100
Received: from sbinding-cirrus-dsktp2.ad.cirrus.com (unknown [198.90.238.219])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 2EB5B3573;
        Thu, 20 Jul 2023 13:32:11 +0000 (UTC)
From:   Stefan Binding <sbinding@opensource.cirrus.com>
To:     Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: [PATCH v1 08/11] ALSA: hda: cs35l41: Rework System Suspend to ensure correct call separation
Date:   Thu, 20 Jul 2023 14:31:44 +0100
Message-ID: <20230720133147.1294337-9-sbinding@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230720133147.1294337-1-sbinding@opensource.cirrus.com>
References: <20230720133147.1294337-1-sbinding@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: E96zCp-pWz8hLaBlgv7tYd2abOl1nOP8
X-Proofpoint-GUID: E96zCp-pWz8hLaBlgv7tYd2abOl1nOP8
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to correctly pause audio on suspend, amps using external boost
require parts of the pause sequence to be called for all amps before moving
on to the next steps.
For example, as part of pausing the audio, the VSPK GPIO must be disabled,
but since this GPIO is controlled by one amp, but controls the boost for
all amps, it is required to separate the calls.
During playback this is achieved by using the pre and post playback hooks,
however during system suspend, this is not possible, so to separate the
calls, we use both the .prepare and .suspend calls to pause the audio.

Currently, for this reason, we do not restart audio on system resume.
However, we can support this by relying on the playback hook to resume
playback after system suspend.

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
---
 sound/pci/hda/cs35l41_hda.c | 40 ++++++++++++++++++++++++++++++++-----
 1 file changed, 35 insertions(+), 5 deletions(-)

diff --git a/sound/pci/hda/cs35l41_hda.c b/sound/pci/hda/cs35l41_hda.c
index a482d4752b3f8..70aa819cfbd64 100644
--- a/sound/pci/hda/cs35l41_hda.c
+++ b/sound/pci/hda/cs35l41_hda.c
@@ -595,6 +595,15 @@ static void cs35l41_hda_playback_hook(struct device *dev, int action)
 		mutex_unlock(&cs35l41->fw_mutex);
 		break;
 	case HDA_GEN_PCM_ACT_CLOSE:
+		mutex_lock(&cs35l41->fw_mutex);
+		if (!cs35l41->firmware_running && cs35l41->request_fw_load &&
+		    !cs35l41->fw_request_ongoing) {
+			dev_info(dev, "Requesting Firmware Load after HDA_GEN_PCM_ACT_CLOSE\n");
+			cs35l41->fw_request_ongoing = true;
+			schedule_work(&cs35l41->fw_load_work);
+		}
+		mutex_unlock(&cs35l41->fw_mutex);
+
 		/*
 		 * Playback must be finished for all amps before we start runtime suspend.
 		 * This ensures no amps are playing back when we start putting them to sleep.
@@ -681,6 +690,25 @@ static int cs35l41_ready_for_reset(struct cs35l41_hda *cs35l41)
 	return ret;
 }
 
+static int cs35l41_system_suspend_prep(struct device *dev)
+{
+	struct cs35l41_hda *cs35l41 = dev_get_drvdata(dev);
+
+	dev_dbg(cs35l41->dev, "System Suspend Prepare\n");
+
+	if (cs35l41->hw_cfg.bst_type == CS35L41_EXT_BOOST_NO_VSPK_SWITCH) {
+		dev_err_once(cs35l41->dev, "System Suspend not supported\n");
+		return 0; /* don't block the whole system suspend */
+	}
+
+	mutex_lock(&cs35l41->fw_mutex);
+	if (cs35l41->playback_started)
+		cs35l41_hda_pause_start(dev);
+	mutex_unlock(&cs35l41->fw_mutex);
+
+	return 0;
+}
+
 static int cs35l41_system_suspend(struct device *dev)
 {
 	struct cs35l41_hda *cs35l41 = dev_get_drvdata(dev);
@@ -693,6 +721,11 @@ static int cs35l41_system_suspend(struct device *dev)
 		return 0; /* don't block the whole system suspend */
 	}
 
+	mutex_lock(&cs35l41->fw_mutex);
+	if (cs35l41->playback_started)
+		cs35l41_hda_pause_done(dev);
+	mutex_unlock(&cs35l41->fw_mutex);
+
 	ret = pm_runtime_force_suspend(dev);
 	if (ret) {
 		dev_err(dev, "System Suspend Failed, unable to runtime suspend: %d\n", ret);
@@ -738,6 +771,7 @@ static int cs35l41_system_resume(struct device *dev)
 	}
 
 	mutex_lock(&cs35l41->fw_mutex);
+
 	if (cs35l41->request_fw_load && !cs35l41->fw_request_ongoing) {
 		cs35l41->fw_request_ongoing = true;
 		schedule_work(&cs35l41->fw_load_work);
@@ -770,11 +804,6 @@ static int cs35l41_runtime_suspend(struct device *dev)
 
 	mutex_lock(&cs35l41->fw_mutex);
 
-	if (cs35l41->playback_started) {
-		cs35l41_hda_pause_start(dev);
-		cs35l41_hda_pause_done(dev);
-	}
-
 	if (cs35l41->firmware_running) {
 		ret = cs35l41_enter_hibernate(cs35l41->dev, cs35l41->regmap,
 					      cs35l41->hw_cfg.bst_type);
@@ -1641,6 +1670,7 @@ EXPORT_SYMBOL_NS_GPL(cs35l41_hda_remove, SND_HDA_SCODEC_CS35L41);
 const struct dev_pm_ops cs35l41_hda_pm_ops = {
 	RUNTIME_PM_OPS(cs35l41_runtime_suspend, cs35l41_runtime_resume,
 		       cs35l41_runtime_idle)
+	.prepare = cs35l41_system_suspend_prep,
 	SYSTEM_SLEEP_PM_OPS(cs35l41_system_suspend, cs35l41_system_resume)
 };
 EXPORT_SYMBOL_NS_GPL(cs35l41_hda_pm_ops, SND_HDA_SCODEC_CS35L41);
-- 
2.34.1

