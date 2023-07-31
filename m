Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D0D5769D6B
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 18:58:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233727AbjGaQ6c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 12:58:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233749AbjGaQ55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 12:57:57 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 276902139
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 09:57:48 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 36V5lNJM017071;
        Mon, 31 Jul 2023 11:57:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        PODMain02222019; bh=B1C4dVatnD+uffpp5pD3N1ldXPScWgM6kyZfR+HGa+s=; b=
        mpl4OXY9B0oU0cjBazfalZ/A8CoYebXC1RbxoQ98HdDRxW5Oti2AyHxabXZzgYz4
        gHrMP33fud0BN+gDsiTBq0XsNQ4Ci3osTqWPOQzbsVGI60xaKQ8fZ6HApWxTVqhl
        xZwbUPDZ0Ouv+iZu73zCYrxtiDUrHi0yhcf21rLX+IOqTE8afTIjQGFlA9/s2mVv
        Xfx6/bD7IoD5J35d5arsGqwHHpMHuAwqFiEX/W+TAVeraaCJDsBwrlgbULhVKUkC
        iTmuCg/NXYRNJk2jrlhJ5fMm3RZi857a7B/C7ZW/8ZJMKGPB/Ie/yO1owDl5S9OP
        bqsCkGaAv64jmitNjRlmXA==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3s5gk1sg45-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Jul 2023 11:57:35 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Mon, 31 Jul
 2023 17:57:31 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.30 via Frontend Transport; Mon, 31 Jul 2023 17:57:31 +0100
Received: from EDIN4L06LR3.ad.cirrus.com (EDIN4L06LR3.ad.cirrus.com [198.61.64.107])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 145CB475;
        Mon, 31 Jul 2023 16:57:31 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <tiwai@suse.com>
CC:     <perex@perex.cz>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH 4/9] ALSA: hda/cs35l56: Always power-up and start cs_dsp
Date:   Mon, 31 Jul 2023 17:57:21 +0100
Message-ID: <20230731165726.7940-5-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230731165726.7940-1-rf@opensource.cirrus.com>
References: <20230731165726.7940-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: WNdFe9nyl-Xi5Oa92oRKJiEztYsxl5-p
X-Proofpoint-ORIG-GUID: WNdFe9nyl-Xi5Oa92oRKJiEztYsxl5-p
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Always call cs_dsp_power_up() and cs_dsp_run() in
cs35l56_hda_fw_load() even if there aren't any firmware files
to download. Also, if there aren't any firmware files to
download there is no need to do cs35l56_firmware_shutdown() and
cs35l56_system_reset().

If there aren't any firmware files there's no need to write
anything to the CS35L56 registers to make it work - it will
already be running the ROM firmware. So it's not strictly
necessary to start cs_dsp.

But it's perfectly ok to call cs_dsp_power_up() and
cs_dsp_run() without downloading any firmware. This avoids
having to support a state where audio is playing but cs_dsp
is not running.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 sound/pci/hda/cs35l56_hda.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/sound/pci/hda/cs35l56_hda.c b/sound/pci/hda/cs35l56_hda.c
index b6b8cb21da75..2870f82bfa45 100644
--- a/sound/pci/hda/cs35l56_hda.c
+++ b/sound/pci/hda/cs35l56_hda.c
@@ -536,10 +536,6 @@ static int cs35l56_hda_fw_load(struct cs35l56_hda *cs35l56)
 	cs35l56_hda_request_firmware_files(cs35l56, &wmfw_firmware, &wmfw_filename,
 					   &coeff_firmware, &coeff_filename);
 
-	/* Nothing to do - no firmware files were found to download */
-	if (!wmfw_filename && !coeff_filename)
-		return 0;
-
 	mutex_lock(&cs35l56->base.irq_lock);
 	pm_runtime_get_sync(cs35l56->base.dev);
 
@@ -549,7 +545,7 @@ static int cs35l56_hda_fw_load(struct cs35l56_hda *cs35l56)
 	 * shutdown the firmware to apply them and can use the lower cost
 	 * reinit sequence instead.
 	 */
-	if (!cs35l56->base.secured) {
+	if (!cs35l56->base.secured && (wmfw_firmware || coeff_firmware)) {
 		ret = cs35l56_firmware_shutdown(&cs35l56->base);
 		if (ret)
 			goto err;
@@ -572,8 +568,8 @@ static int cs35l56_hda_fw_load(struct cs35l56_hda *cs35l56)
 		ret = cs35l56_mbox_send(&cs35l56->base, CS35L56_MBOX_CMD_AUDIO_REINIT);
 		if (ret)
 			goto err;
-	} else {
-		/* Reset the device and wait for it to boot */
+	} else if (wmfw_firmware || coeff_firmware) {
+		/* If we downloaded firmware, reset the device and wait for it to boot */
 		cs35l56_system_reset(&cs35l56->base, false);
 		regcache_mark_dirty(cs35l56->base.regmap);
 		ret = cs35l56_wait_for_firmware_boot(&cs35l56->base);
-- 
2.30.2

