Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19DEB7D8589
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 17:06:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231528AbjJZPGw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 11:06:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345371AbjJZPGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 11:06:34 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDB261AE;
        Thu, 26 Oct 2023 08:06:31 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 39Q5GUrk011654;
        Thu, 26 Oct 2023 10:06:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        PODMain02222019; bh=aVS/k/o9GgQrl9MbNJJRmT2pCbqgdTBbMvRC49HEs3I=; b=
        CqmUOW1QFN+R8yYC1KTnwLmwDmYXbhma6M7+oX2skXH2fwCrvPIXlp3yvJtd8hZ9
        A0pyADUxlmRqQiz9aygmctQXY6waCu8g0FNnwQFU+gAZVIeIRMUAzoiJ2WfHruqp
        0mLSxpUtVWItzUQoH/8/hsuzkIUpWF0wFZctGjL7Q0la8LAsGiWjJGwIVMw8coHW
        sBhFsVpz6whzm2AKTm50X09iU1xO2fyqql3XKAbSQcgAUs084kL2LFrRZDcrJh4j
        0qAqxMeLSQOB6Xu+DRs1YlJBDuwvkhitVJ/5Y3tXQ99qaSvwWO1SvrepEPJBQM0g
        Tx5/QLdHn2MyLy3T2pqH0w==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3tvc1x94k9-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Oct 2023 10:06:17 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.37; Thu, 26 Oct
 2023 16:06:09 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.37 via Frontend
 Transport; Thu, 26 Oct 2023 16:06:09 +0100
Received: from sbinding-cirrus-dsktp2.ad.cirrus.com (unknown [198.90.238.177])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id CD6D7357D;
        Thu, 26 Oct 2023 15:06:08 +0000 (UTC)
From:   Stefan Binding <sbinding@opensource.cirrus.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        "Mark Brown" <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <linux-sound@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Stefan Binding" <sbinding@opensource.cirrus.com>
Subject: [PATCH v1 6/8] ALSA: hda: cs35l41: Do not unload firmware before reset in system suspend
Date:   Thu, 26 Oct 2023 16:05:56 +0100
Message-ID: <20231026150558.2105827-7-sbinding@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026150558.2105827-1-sbinding@opensource.cirrus.com>
References: <20231026150558.2105827-1-sbinding@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 77tcB9QBMrf3J9m3UWL9pZxdtnLaMN5E
X-Proofpoint-ORIG-GUID: 77tcB9QBMrf3J9m3UWL9pZxdtnLaMN5E
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Given the part is about to reset due to system suspend, and we are
already in hibernate, there is no need to wake up the amp, just to get
it ready to be reset. We just need to ensure cs_dsp is ready for reset
by resetting the states.

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
---
 sound/pci/hda/cs35l41_hda.c | 33 ++++-----------------------------
 1 file changed, 4 insertions(+), 29 deletions(-)

diff --git a/sound/pci/hda/cs35l41_hda.c b/sound/pci/hda/cs35l41_hda.c
index 9746c64ff0dd..69303888be1a 100644
--- a/sound/pci/hda/cs35l41_hda.c
+++ b/sound/pci/hda/cs35l41_hda.c
@@ -760,41 +760,16 @@ int cs35l41_verify_id(struct cs35l41_hda *cs35l41, unsigned int *regid, unsigned
 
 static int cs35l41_ready_for_reset(struct cs35l41_hda *cs35l41)
 {
-	int ret = 0;
-
 	mutex_lock(&cs35l41->fw_mutex);
 	if (cs35l41->firmware_running) {
-
-		regcache_cache_only(cs35l41->regmap, false);
-
-		ret = cs35l41_exit_hibernate(cs35l41->dev, cs35l41->regmap);
-		if (ret) {
-			dev_warn(cs35l41->dev, "Unable to exit Hibernate.");
-			goto err;
-		}
-
-		/* Test key needs to be unlocked to allow the OTP settings to re-apply */
-		cs35l41_test_key_unlock(cs35l41->dev, cs35l41->regmap);
-		ret = regcache_sync(cs35l41->regmap);
-		cs35l41_test_key_lock(cs35l41->dev, cs35l41->regmap);
-		if (ret) {
-			dev_err(cs35l41->dev, "Failed to restore register cache: %d\n", ret);
-			goto err;
-		}
-
-		if (cs35l41->hw_cfg.bst_type == CS35L41_EXT_BOOST)
-			cs35l41_init_boost(cs35l41->dev, cs35l41->regmap, &cs35l41->hw_cfg);
-
-		cs35l41_shutdown_dsp(cs35l41);
-		cs35l41_safe_reset(cs35l41->regmap, cs35l41->hw_cfg.bst_type);
+		cs35l41->cs_dsp.running = false;
+		cs35l41->cs_dsp.booted = false;
+		cs35l41->firmware_running = false;
 	}
-err:
-	regcache_cache_only(cs35l41->regmap, true);
 	regcache_mark_dirty(cs35l41->regmap);
-
 	mutex_unlock(&cs35l41->fw_mutex);
 
-	return ret;
+	return 0;
 }
 
 static int cs35l41_system_suspend_prep(struct device *dev)
-- 
2.34.1

