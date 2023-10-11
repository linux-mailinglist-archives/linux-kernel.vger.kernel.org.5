Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79F9F7C5941
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 18:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346959AbjJKQeS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 12:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346962AbjJKQeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 12:34:13 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E0EDA4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 09:34:10 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 39B69HGL028515;
        Wed, 11 Oct 2023 11:34:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding:content-type; s=PODMain02222019; bh=b
        77U65NzPhkgOKHWlwkTamYPj/TOXrDCPIuZPvkXAr8=; b=izsJ6koh2FMzwGjfe
        N22ZfK1++M6CsJuWJk2wX1XK066MkOCCZzBpTOo235TU6a81Ux9pPlN4z19jAIq1
        6BwshNm6vPyqjXk5Isd2LASyuGmPsOBRDpRrKAJHluQi6VZDyyc6n3Mm6dAU9cKy
        JbhaWtZRSBuiSa0UU43B9a984OP0cnzn52blgigBe/iqk6gOYa8aFzfQvQyXGdrs
        CgjdEjGVZMCOz7K8NHUGwbJ0814cys6I0sEXapd9DX3vUatk2M1u0biHjKuNolal
        2x2o+CRzYgF83g2N6vlALp1n6VcVB7yHugaD87I5WwB+4RRn29CfPBF4IlDk7lMX
        7Zayw==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3tnp64gvmh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Oct 2023 11:34:00 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.37; Wed, 11 Oct
 2023 17:33:58 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.37 via Frontend
 Transport; Wed, 11 Oct 2023 17:33:58 +0100
Received: from EDIN4L06LR3.ad.cirrus.com (EDIN4L06LR3.ad.cirrus.com [198.61.65.230])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id ED81B11AA;
        Wed, 11 Oct 2023 16:33:57 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Simon Trimmer <simont@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH] ALSA: hda: cs35l56: Enable low-power hibernation mode on i2c
Date:   Wed, 11 Oct 2023 17:33:55 +0100
Message-ID: <20231011163355.18183-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: QG4T2Kyo7OWCR0NkwwwzoTUhlAOXlLTw
X-Proofpoint-ORIG-GUID: QG4T2Kyo7OWCR0NkwwwzoTUhlAOXlLTw
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Simon Trimmer <simont@opensource.cirrus.com>

This can now be re-enabled as the sequence to reliably wake the device
has been implemented in the shared ASoC code.

This has a functional dependency on commit 3df761bdbc8b
("ASoC: cs35l56: Wake transactions need to be issued twice")

To protect against this, enabling hibernation is conditional on
CS35L56_WAKE_HOLD_TIME_US being defined, which indicates that the new
hibernation sequences are available.

Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>
Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 sound/pci/hda/cs35l56_hda_i2c.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/pci/hda/cs35l56_hda_i2c.c b/sound/pci/hda/cs35l56_hda_i2c.c
index 757a4d193e0f..a9ef6d86de83 100644
--- a/sound/pci/hda/cs35l56_hda_i2c.c
+++ b/sound/pci/hda/cs35l56_hda_i2c.c
@@ -21,6 +21,10 @@ static int cs35l56_hda_i2c_probe(struct i2c_client *clt)
 		return -ENOMEM;
 
 	cs35l56->base.dev = &clt->dev;
+
+#ifdef CS35L56_WAKE_HOLD_TIME_US
+	cs35l56->base.can_hibernate = true;
+#endif
 	cs35l56->base.regmap = devm_regmap_init_i2c(clt, &cs35l56_regmap_i2c);
 	if (IS_ERR(cs35l56->base.regmap)) {
 		ret = PTR_ERR(cs35l56->base.regmap);
-- 
2.30.2

