Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1C2C769D71
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 18:58:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231458AbjGaQ65 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 12:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233884AbjGaQ6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 12:58:21 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA2E219AC
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 09:57:54 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 36V5lNJP017071;
        Mon, 31 Jul 2023 11:57:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-type:content-transfer-encoding; s=
        PODMain02222019; bh=kRJVBU+w59VixbMTEBoEeJzDYTKtrgAfvQuFksOXNx0=; b=
        ZCja9J4LUmngD4dKpu4UV4uTEGLSZPaw56mjm4odBmi7vOm1ioEEwiOynETFu+L+
        0SsehrOJmveWuyWa3ro9AyZ8Z1hpYmE5Vo+xjjAmaCuKHexCE7yxF2KPXbi17l2A
        roSDAvemQrBs26Gk8Z4+VizY/fydbkBP6WJ8d6SePhFCRAACPlaP2ZDsD1kTak3r
        x3/aBrfDLzJHmnPF6aazYANOsjyB56u3zJnWdM57mmtDXqOCc0OFYdilYTPra8xu
        FkCTztR/+5D2yr+nK+P+iEKbkdxN00uOnWvZlaT8IJ3VXyBgW3A6VkTdhy8EWcd5
        FqgZWrdXyUD0LME0rLBPhg==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3s5gk1sg45-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Jul 2023 11:57:37 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Mon, 31 Jul
 2023 17:57:32 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.30 via Frontend
 Transport; Mon, 31 Jul 2023 17:57:32 +0100
Received: from EDIN4L06LR3.ad.cirrus.com (EDIN4L06LR3.ad.cirrus.com [198.61.64.107])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 9976B11D3;
        Mon, 31 Jul 2023 16:57:32 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <tiwai@suse.com>
CC:     <perex@perex.cz>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH 8/9] ALSA: hda/cs35l56: Fail if .bin not found and firmware not patched
Date:   Mon, 31 Jul 2023 17:57:25 +0100
Message-ID: <20230731165726.7940-9-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230731165726.7940-1-rf@opensource.cirrus.com>
References: <20230731165726.7940-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: KD3mdf9fl-XadVx_X5Byy68JUQFon4mY
X-Proofpoint-ORIG-GUID: KD3mdf9fl-XadVx_X5Byy68JUQFon4mY
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A tuning patch is always needed to enable the ASP audio port.
If the BIOS did not patch the firmware, then it is mandatory to
have a .bin file.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 sound/pci/hda/cs35l56_hda.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/cs35l56_hda.c b/sound/pci/hda/cs35l56_hda.c
index 8f1665d38c92..004740509dbd 100644
--- a/sound/pci/hda/cs35l56_hda.c
+++ b/sound/pci/hda/cs35l56_hda.c
@@ -555,6 +555,16 @@ static int cs35l56_hda_fw_load(struct cs35l56_hda *cs35l56)
 						   &coeff_firmware, &coeff_filename);
 	}
 
+	/*
+	 * If the BIOS didn't patch the firmware a bin file is mandatory to
+	 * enable the ASP·
+	 */
+	if (!coeff_firmware && firmware_missing) {
+		dev_err(cs35l56->base.dev, ".bin file required but not found\n");
+		ret = -ENOENT;
+		goto err_fw_release;
+	}
+
 	mutex_lock(&cs35l56->base.irq_lock);
 
 	/*
@@ -615,7 +625,7 @@ static int cs35l56_hda_fw_load(struct cs35l56_hda *cs35l56)
 		cs_dsp_power_down(&cs35l56->cs_dsp);
 err:
 	mutex_unlock(&cs35l56->base.irq_lock);
-
+err_fw_release:
 	cs35l56_hda_release_firmware_files(wmfw_firmware, wmfw_filename,
 					   coeff_firmware, coeff_filename);
 err_pm_put:
-- 
2.30.2

