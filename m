Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B03B75B017
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 15:34:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232072AbjGTNeC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 09:34:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232075AbjGTNde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 09:33:34 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E6C62712
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 06:33:04 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 36KAupUo002185;
        Thu, 20 Jul 2023 08:32:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        PODMain02222019; bh=i4r8F+GfmuK4opOrNQVX10rqTiZBZAw0XXyfo15gL98=; b=
        dFk67YTMY5c5RWTsHAt7Ol3HXH+cHjSXlh/q/qCrQ5sIkodtT6H9UZUlo0AhJOeu
        FdDddWduJQMY7e4sFBfikZ8UO40zAULB/70Czuvx4Lc8TQLFvYlnKvwFNko8xDwe
        t3PhzScjoxdF2x63wb+yZAr5zQK8althk1kz55TBlwlfmpAxP2+jltYumlBvoYDN
        bTtMAV8ESYPfLJuZw087RXpvbEb5AW+ep3ZILSk23k+XWjzD+UEAJ0qXiOuT6Udf
        z762fOHeU6oiNxdh5GH2eVrSMvhXVS/BbKOQivNeVlFTKroKPg0EVZKruS2eDg71
        7UpO1KYuQklYWjScGGDeDQ==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3rus6gx5mq-5
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
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id E26CF3572;
        Thu, 20 Jul 2023 13:32:10 +0000 (UTC)
From:   Stefan Binding <sbinding@opensource.cirrus.com>
To:     Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: [PATCH v1 07/11] ALSA: hda: cs35l41: Use pre and post playback hooks
Date:   Thu, 20 Jul 2023 14:31:43 +0100
Message-ID: <20230720133147.1294337-8-sbinding@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230720133147.1294337-1-sbinding@opensource.cirrus.com>
References: <20230720133147.1294337-1-sbinding@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: GECEfqfM1kfzXNjxWcsoAtfCzATbTnOz
X-Proofpoint-GUID: GECEfqfM1kfzXNjxWcsoAtfCzATbTnOz
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use new hooks to ensure separation between play/pause actions,
as required by external boost.

External Boost on CS35L41 requires the amp to go through a
particular sequence of steps. One of these steps involes
the setting of a GPIO. This GPIO is connected to one or
more of the amps, and it may control the boost for all of
the amps. To ensure that the GPIO is set when it is safe
to do so, and to ensure that boost is ready for the rest of
the sequence to be able to continue, we must ensure that
the each part of the sequence is executed for each amp
before moving on to the next part of the sequence.

Some of the Play and Pause actions have moved from Open to
Prepare. This is because Open is not guaranteed to be called
again on system resume, whereas Prepare should.

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
---
 sound/pci/hda/cs35l41_hda.c | 53 ++++++++++++++++++++++++++++++-------
 1 file changed, 43 insertions(+), 10 deletions(-)

diff --git a/sound/pci/hda/cs35l41_hda.c b/sound/pci/hda/cs35l41_hda.c
index f77583b46b6b0..a482d4752b3f8 100644
--- a/sound/pci/hda/cs35l41_hda.c
+++ b/sound/pci/hda/cs35l41_hda.c
@@ -556,37 +556,68 @@ static void cs35l41_hda_pause_done(struct device *dev)
 	cs35l41->playback_started = false;
 }
 
+static void cs35l41_hda_pre_playback_hook(struct device *dev, int action)
+{
+	struct cs35l41_hda *cs35l41 = dev_get_drvdata(dev);
+
+	switch (action) {
+	case HDA_GEN_PCM_ACT_CLEANUP:
+		mutex_lock(&cs35l41->fw_mutex);
+		cs35l41_hda_pause_start(dev);
+		mutex_unlock(&cs35l41->fw_mutex);
+		break;
+	default:
+		break;
+	}
+}
 static void cs35l41_hda_playback_hook(struct device *dev, int action)
 {
 	struct cs35l41_hda *cs35l41 = dev_get_drvdata(dev);
 
 	switch (action) {
 	case HDA_GEN_PCM_ACT_OPEN:
+		/*
+		 * All amps must be resumed before we can start playing back.
+		 * This ensures, for external boost, that all amps are in AMP_SAFE mode.
+		 * Do this in HDA_GEN_PCM_ACT_OPEN, since this is run prior to any of the
+		 * other actions.
+		 */
 		pm_runtime_get_sync(dev);
-		mutex_lock(&cs35l41->fw_mutex);
-		cs35l41_hda_play_start(dev);
-		mutex_unlock(&cs35l41->fw_mutex);
 		break;
 	case HDA_GEN_PCM_ACT_PREPARE:
 		mutex_lock(&cs35l41->fw_mutex);
-		cs35l41_hda_play_done(dev);
+		cs35l41_hda_play_start(dev);
 		mutex_unlock(&cs35l41->fw_mutex);
 		break;
 	case HDA_GEN_PCM_ACT_CLEANUP:
 		mutex_lock(&cs35l41->fw_mutex);
-		cs35l41_hda_pause_start(dev);
+		cs35l41_hda_pause_done(dev);
 		mutex_unlock(&cs35l41->fw_mutex);
 		break;
 	case HDA_GEN_PCM_ACT_CLOSE:
-		mutex_lock(&cs35l41->fw_mutex);
-		cs35l41_hda_pause_done(dev);
-		mutex_unlock(&cs35l41->fw_mutex);
-
+		/*
+		 * Playback must be finished for all amps before we start runtime suspend.
+		 * This ensures no amps are playing back when we start putting them to sleep.
+		 */
 		pm_runtime_mark_last_busy(dev);
 		pm_runtime_put_autosuspend(dev);
 		break;
 	default:
-		dev_warn(cs35l41->dev, "Playback action not supported: %d\n", action);
+		break;
+	}
+}
+
+static void cs35l41_hda_post_playback_hook(struct device *dev, int action)
+{
+	struct cs35l41_hda *cs35l41 = dev_get_drvdata(dev);
+
+	switch (action) {
+	case HDA_GEN_PCM_ACT_PREPARE:
+		mutex_lock(&cs35l41->fw_mutex);
+		cs35l41_hda_play_done(dev);
+		mutex_unlock(&cs35l41->fw_mutex);
+		break;
+	default:
 		break;
 	}
 }
@@ -1037,6 +1068,8 @@ static int cs35l41_hda_bind(struct device *dev, struct device *master, void *mas
 	ret = cs35l41_create_controls(cs35l41);
 
 	comps->playback_hook = cs35l41_hda_playback_hook;
+	comps->pre_playback_hook = cs35l41_hda_pre_playback_hook;
+	comps->post_playback_hook = cs35l41_hda_post_playback_hook;
 
 	mutex_unlock(&cs35l41->fw_mutex);
 
-- 
2.34.1

