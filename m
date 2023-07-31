Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 815E3769D6F
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 18:58:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233799AbjGaQ6y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 12:58:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233742AbjGaQ54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 12:57:56 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E7D5213C
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 09:57:49 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 36V5lNJL017071;
        Mon, 31 Jul 2023 11:57:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        PODMain02222019; bh=AXY+yhAp337Xwcjj3zvet6CtUqG0Njj546QB9XWh5P4=; b=
        dR3leKCTZAVrxwO0wPK+UWwW3uv94qwZytByxI1VNDrgjUIld+LaOg3VSFvq2hEY
        gsi9PJRFqeakomq5K22j6ALxETFbYrdnfmRu+KoITHpQQPyX1zL373aWg1GkGwgv
        0SMnFX2tNyPOY+gdVS2cpA3IHqtfp8MVt8aVvoUuzSgUL1+w4dhg3QqQnIwq36+G
        MXXkAf+0nckqRsfYqbrpj3J9sevjUTAgzEDKbwFuld6TEoHkvFiD0JpJ9YFabMFF
        uymVysTy77zAdAtemnmO/C4UiaFjiQFiN6aCpSpdmnkLuUySKhHi/fudSe3zEKsr
        gmOUdjQHVcKTGSPrzh+GpA==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3s5gk1sg45-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Jul 2023 11:57:33 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Mon, 31 Jul
 2023 17:57:30 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.30 via Frontend
 Transport; Mon, 31 Jul 2023 17:57:30 +0100
Received: from EDIN4L06LR3.ad.cirrus.com (EDIN4L06LR3.ad.cirrus.com [198.61.64.107])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id AEBFF11CA;
        Mon, 31 Jul 2023 16:57:30 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <tiwai@suse.com>
CC:     <perex@perex.cz>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH 3/9] ALSA: hda/cs35l56: Call cs_dsp_power_down() before reloading firmware
Date:   Mon, 31 Jul 2023 17:57:20 +0100
Message-ID: <20230731165726.7940-4-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230731165726.7940-1-rf@opensource.cirrus.com>
References: <20230731165726.7940-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: OyU2U_LcCaKSimPOtdrXDTdjC5YFF-F0
X-Proofpoint-ORIG-GUID: OyU2U_LcCaKSimPOtdrXDTdjC5YFF-F0
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When firmware is reloaded after a system resume cs_dsp_power_down() should
be called before calling cs_dsp_power_up().

The fw_patched flag should also be cleared and only set again if the
firmware download succeeded.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 sound/pci/hda/cs35l56_hda.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/pci/hda/cs35l56_hda.c b/sound/pci/hda/cs35l56_hda.c
index fda716e0db09..b6b8cb21da75 100644
--- a/sound/pci/hda/cs35l56_hda.c
+++ b/sound/pci/hda/cs35l56_hda.c
@@ -527,6 +527,12 @@ static int cs35l56_hda_fw_load(struct cs35l56_hda *cs35l56)
 	char *wmfw_filename = NULL;
 	int ret = 0;
 
+	/* Prepare for a new DSP power-up */
+	if (cs35l56->base.fw_patched)
+		cs_dsp_power_down(&cs35l56->cs_dsp);
+
+	cs35l56->base.fw_patched = false;
+
 	cs35l56_hda_request_firmware_files(cs35l56, &wmfw_firmware, &wmfw_filename,
 					   &coeff_firmware, &coeff_filename);
 
-- 
2.30.2

