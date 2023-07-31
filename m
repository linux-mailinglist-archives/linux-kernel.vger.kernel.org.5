Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BC6C769D6A
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 18:58:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233748AbjGaQ6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 12:58:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233751AbjGaQ55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 12:57:57 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FE68213D
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 09:57:50 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 36V5lNJN017071;
        Mon, 31 Jul 2023 11:57:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        PODMain02222019; bh=R7ZjjUfa6yJOj++gCN2+TabvdRaWxzaSedPyz17+U0k=; b=
        oLjutGfmin0E7RLlySjbfdbDa+44PhaRSXLZYdAAMUmSF/GvUGRRZHgdsOCafOCl
        Ejgrk3ZW+tSrGQtFR58CvV4+cRNPxDInLVviCiSoxB1yS0RaAikpyq6nrjnpChj9
        l0DWmBOPSRd3QZGBxkEbeYtjICZRznrlzTtnwiVLUzendX95Mdrkm7eVrOcLUI3N
        2nrSFdKBzm5MjPIbPoLkw+AOaGYkUPz+dvZSI8fOgcPUQCuzH9gOuhASUcLLlCte
        kUJQ5+LnjPaIz/UPrCiA3ODrfYWJ637+Qsbl97SEFUZNf07e0ftbazJDSeEoXYkt
        keMuQKhUl435GnYzWxW9MQ==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3s5gk1sg45-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Jul 2023 11:57:35 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Mon, 31 Jul
 2023 17:57:32 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.30 via Frontend
 Transport; Mon, 31 Jul 2023 17:57:32 +0100
Received: from EDIN4L06LR3.ad.cirrus.com (EDIN4L06LR3.ad.cirrus.com [198.61.64.107])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id CEA4E45D;
        Mon, 31 Jul 2023 16:57:31 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <tiwai@suse.com>
CC:     <perex@perex.cz>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH 6/9] ALSA: hda/cs35l56: cs_dsp_power_down() on cs35l56_hda_fw_load() error path
Date:   Mon, 31 Jul 2023 17:57:23 +0100
Message-ID: <20230731165726.7940-7-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230731165726.7940-1-rf@opensource.cirrus.com>
References: <20230731165726.7940-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: bB_xhwoyVLFnhBvAfJRqahOqp3F2rvgI
X-Proofpoint-ORIG-GUID: bB_xhwoyVLFnhBvAfJRqahOqp3F2rvgI
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If cs35l56_hda_fw_load() successfully called cs_dsp_power_up() the error
path must balance that with a call to cs_dsp_power_down().

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 sound/pci/hda/cs35l56_hda.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/sound/pci/hda/cs35l56_hda.c b/sound/pci/hda/cs35l56_hda.c
index e8c41a4a0c40..803fa2da9ea4 100644
--- a/sound/pci/hda/cs35l56_hda.c
+++ b/sound/pci/hda/cs35l56_hda.c
@@ -567,20 +567,20 @@ static int cs35l56_hda_fw_load(struct cs35l56_hda *cs35l56)
 	if (cs35l56->base.secured) {
 		ret = cs35l56_mbox_send(&cs35l56->base, CS35L56_MBOX_CMD_AUDIO_REINIT);
 		if (ret)
-			goto err;
+			goto err_powered_up;
 	} else if (wmfw_firmware || coeff_firmware) {
 		/* If we downloaded firmware, reset the device and wait for it to boot */
 		cs35l56_system_reset(&cs35l56->base, false);
 		regcache_mark_dirty(cs35l56->base.regmap);
 		ret = cs35l56_wait_for_firmware_boot(&cs35l56->base);
 		if (ret)
-			goto err;
+			goto err_powered_up;
 	}
 
 	/* Disable auto-hibernate so that runtime_pm has control */
 	ret = cs35l56_mbox_send(&cs35l56->base, CS35L56_MBOX_CMD_PREVENT_AUTO_HIBERNATE);
 	if (ret)
-		goto err;
+		goto err_powered_up;
 
 	regcache_sync(cs35l56->base.regmap);
 
@@ -592,6 +592,9 @@ static int cs35l56_hda_fw_load(struct cs35l56_hda *cs35l56)
 	if (ret)
 		dev_dbg(cs35l56->base.dev, "%s: cs_dsp_run ret %d\n", __func__, ret);
 
+err_powered_up:
+	if (!cs35l56->base.fw_patched)
+		cs_dsp_power_down(&cs35l56->cs_dsp);
 err:
 	pm_runtime_put(cs35l56->base.dev);
 	mutex_unlock(&cs35l56->base.irq_lock);
-- 
2.30.2

