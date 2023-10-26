Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA1E67D8587
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 17:06:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345410AbjJZPGo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 11:06:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345359AbjJZPGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 11:06:34 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C90B91AA;
        Thu, 26 Oct 2023 08:06:30 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 39Q5GUrl011654;
        Thu, 26 Oct 2023 10:06:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        PODMain02222019; bh=/q3Kw4t4VTC4/a9Bku2lCi/sAJC9uB56KwypnrOkogk=; b=
        FgjtMwvK7nk6mBpvrTLCcNfGZaWDFby7l95BNA5dY94YI2kYhLF7HuISpswtpBys
        4jYov1hS7r+BXf1u3nvPwqKB6hec9hbmyXOYKKWkixwYRmpXociv/VemVrwifii+
        AOE8nLLBxTDR5S1MoouemGf2jnGjGuVB72vVG5rWLiSWoMQDy4hWI4i4Ab7nIYTr
        Y5oCwXegDJhBSjeS55nLGTPxobqorZ5hDb1NOyGXUkZ9VZZnIDwir3ZnY5FXAIwn
        KqKBQc/Z4dyrZ2vpJKLpIAMs4HHgLfoenpZaA0ePAIO+aaC3m4MwBP9a+Qcpnnha
        WzG57rCP2a4zRBMZ1MfbSg==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3tvc1x94k9-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Oct 2023 10:06:18 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.37; Thu, 26 Oct
 2023 16:06:09 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.37 via Frontend Transport; Thu, 26 Oct 2023 16:06:09 +0100
Received: from sbinding-cirrus-dsktp2.ad.cirrus.com (unknown [198.90.238.177])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 21CB0357E;
        Thu, 26 Oct 2023 15:06:09 +0000 (UTC)
From:   Stefan Binding <sbinding@opensource.cirrus.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        "Mark Brown" <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <linux-sound@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Stefan Binding" <sbinding@opensource.cirrus.com>
Subject: [PATCH v1 7/8] ALSA: hda: cs35l41: Check CSPL state after loading firmware
Date:   Thu, 26 Oct 2023 16:05:57 +0100
Message-ID: <20231026150558.2105827-8-sbinding@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026150558.2105827-1-sbinding@opensource.cirrus.com>
References: <20231026150558.2105827-1-sbinding@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: W4rZ6uY09kr0d8aBBrA7k6d90D77BfBy
X-Proofpoint-ORIG-GUID: W4rZ6uY09kr0d8aBBrA7k6d90D77BfBy
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CSPL firmware should be in RUNNING or PAUSED state after loading.
If not, the firmware has not been loaded correctly, and we can unload
it and pass the error up.

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
---
 sound/pci/hda/cs35l41_hda.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/sound/pci/hda/cs35l41_hda.c b/sound/pci/hda/cs35l41_hda.c
index 69303888be1a..496ff6a9d300 100644
--- a/sound/pci/hda/cs35l41_hda.c
+++ b/sound/pci/hda/cs35l41_hda.c
@@ -994,6 +994,7 @@ static int cs35l41_runtime_resume(struct device *dev)
 
 static int cs35l41_smart_amp(struct cs35l41_hda *cs35l41)
 {
+	unsigned int fw_status;
 	__be32 halo_sts;
 	int ret;
 
@@ -1027,6 +1028,23 @@ static int cs35l41_smart_amp(struct cs35l41_hda *cs35l41)
 		goto clean_dsp;
 	}
 
+	ret = regmap_read(cs35l41->regmap, CS35L41_DSP_MBOX_2, &fw_status);
+	if (ret < 0) {
+		dev_err(cs35l41->dev,
+			"Failed to read firmware status: %d\n", ret);
+		goto clean_dsp;
+	}
+
+	switch (fw_status) {
+	case CSPL_MBOX_STS_RUNNING:
+	case CSPL_MBOX_STS_PAUSED:
+		break;
+	default:
+		dev_err(cs35l41->dev, "Firmware status is invalid: %u\n",
+			fw_status);
+		goto clean_dsp;
+	}
+
 	ret = cs35l41_set_cspl_mbox_cmd(cs35l41->dev, cs35l41->regmap, CSPL_MBOX_CMD_PAUSE);
 	if (ret) {
 		dev_err(cs35l41->dev, "Error waiting for DSP to pause: %u\n", ret);
-- 
2.34.1

