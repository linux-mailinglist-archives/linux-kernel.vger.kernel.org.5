Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC731769D67
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 18:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233653AbjGaQ6Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 12:58:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233735AbjGaQ54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 12:57:56 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB46B1FDA
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 09:57:43 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 36V5lNJJ017071;
        Mon, 31 Jul 2023 11:57:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        PODMain02222019; bh=7tXYtuHPujqaVHNe1XUnRwtzdST6xCvteK767YL3cjc=; b=
        WejIqFMAROEQlAOXVyi1lqXeaNMgfmBqJXKhpNwtVcwr4zPSjSjQ6xO8PsyeHmNl
        +SG5J4Ux85UvpCZRHN8OL6Di8RufFUclI7+3k219Mjhl3gLNEOT7sD7qIze9QFMg
        A+ciAKy/vMbnKLTvWDNFks2Cf2t0XFRJgpfbNvJUcRbQL/wMgXNWyZzItTt6kVZz
        DWQ4wF0oR4i1yzfAWP15sB8Ul59vSZawA0/4ZSAzRdeglm7rjjpNqtWEMbyaav0t
        TZNkZ2PoLYnKBBMR8TpTQxqceGfXs5NOKt+kph/JNARNMgheJRQWl/Bk3aAYLCis
        gWEyjlXbYSJs01U5i0dGIg==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3s5gk1sg45-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Jul 2023 11:57:32 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Mon, 31 Jul
 2023 17:57:30 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.30 via Frontend Transport; Mon, 31 Jul 2023 17:57:30 +0100
Received: from EDIN4L06LR3.ad.cirrus.com (EDIN4L06LR3.ad.cirrus.com [198.61.64.107])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 013A7475;
        Mon, 31 Jul 2023 16:57:29 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <tiwai@suse.com>
CC:     <perex@perex.cz>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH 1/9] ALSA: hda/cs35l56: Complete firmware reboot before calling cs_dsp_run()
Date:   Mon, 31 Jul 2023 17:57:18 +0100
Message-ID: <20230731165726.7940-2-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230731165726.7940-1-rf@opensource.cirrus.com>
References: <20230731165726.7940-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 25uoaoNGsvz6CN9TtIiilzY2EMDVF4nX
X-Proofpoint-ORIG-GUID: 25uoaoNGsvz6CN9TtIiilzY2EMDVF4nX
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the call to cs_dsp_run() in cs35l56_hda_fw_load() so that it
is after the CS35L56 has been reset/reinit'd and the regmap
cache has been synced.

cs_dsp_run() syncs up ALSA control cache values with the DSP memory
so this must not be done until the firmware has reinitialized.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 sound/pci/hda/cs35l56_hda.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/sound/pci/hda/cs35l56_hda.c b/sound/pci/hda/cs35l56_hda.c
index 4c3279f61b94..c3acda2daeeb 100644
--- a/sound/pci/hda/cs35l56_hda.c
+++ b/sound/pci/hda/cs35l56_hda.c
@@ -562,12 +562,6 @@ static int cs35l56_hda_fw_load(struct cs35l56_hda *cs35l56)
 	if (coeff_filename)
 		dev_dbg(cs35l56->base.dev, "Loaded Coefficients: %s\n", coeff_filename);
 
-	ret = cs_dsp_run(&cs35l56->cs_dsp);
-	if (ret) {
-		dev_dbg(cs35l56->base.dev, "%s: cs_dsp_run ret %d\n", __func__, ret);
-		goto err;
-	}
-
 	if (cs35l56->base.secured) {
 		ret = cs35l56_mbox_send(&cs35l56->base, CS35L56_MBOX_CMD_AUDIO_REINIT);
 		if (ret)
@@ -591,6 +585,11 @@ static int cs35l56_hda_fw_load(struct cs35l56_hda *cs35l56)
 	regmap_clear_bits(cs35l56->base.regmap, CS35L56_PROTECTION_STATUS,
 			  CS35L56_FIRMWARE_MISSING);
 	cs35l56->base.fw_patched = true;
+
+	ret = cs_dsp_run(&cs35l56->cs_dsp);
+	if (ret)
+		dev_dbg(cs35l56->base.dev, "%s: cs_dsp_run ret %d\n", __func__, ret);
+
 err:
 	pm_runtime_put(cs35l56->base.dev);
 	mutex_unlock(&cs35l56->base.irq_lock);
-- 
2.30.2

