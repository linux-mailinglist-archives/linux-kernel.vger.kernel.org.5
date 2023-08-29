Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13A1E78C94D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 18:05:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237390AbjH2QEv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 12:04:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237418AbjH2QEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 12:04:45 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CA63193
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 09:04:42 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 37T5NIS9018221;
        Tue, 29 Aug 2023 11:04:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding:content-type; s=PODMain02222019; bh=I
        ossbza8GwL87hC4l6+2yc0jPbBH11QSTUNCI7BFD/M=; b=ogn1TMIdJhnDHbvi3
        QuyMgWA7yFCHLwSgBYZStYuDnNwC7aRek8bLNQ2cJRM5xNDb4aQHIjJZiTNGz/I5
        jV6/mZ3cs4nK1HKEFdws2QjnwUD2fFQZPEVQwHrZlD1/478lu+1YhAGZseINvsZk
        SOUUq8tGL7Gk+ppbUc3s9+8r9qP2+jRZ4sAKG/R0mF9VtkXUbzdgBPDmPoDg6waI
        tuK+kHiE26c9/l2C7dNgGzCzMgj6sCNaC67O4LFX2HyQYhZKkySqQQuvyST1KFrT
        f9ov9cOBvoohKv0y5So1hKpnb3M3+M7yUsSVxa/TPK4BLrD448iTX+qKapMET95g
        4nBEQ==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3sqesybsuj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Aug 2023 11:04:35 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.37; Tue, 29 Aug
 2023 17:04:33 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.37 via Frontend Transport; Tue, 29 Aug 2023 17:04:33 +0100
Received: from edi-sw-dsktp-006.ad.cirrus.com (edi-sw-dsktp-006.ad.cirrus.com [198.90.251.75])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 1DCD711D4;
        Tue, 29 Aug 2023 16:04:33 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>,
        Simon Trimmer <simont@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH] ASoC: cs35l56: Waiting for firmware to boot must be tolerant of I/O errors
Date:   Tue, 29 Aug 2023 17:04:33 +0100
Message-ID: <20230829160433.2647889-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: im8d37YlNdLDuFNT9NP-dchYbQph1y00
X-Proofpoint-GUID: im8d37YlNdLDuFNT9NP-dchYbQph1y00
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Simon Trimmer <simont@opensource.cirrus.com>

Ignore failure to read from the cs35l56 when polling as the device will
NAK i2c accesses until it has booted and this would terminate the poll
of regmap_read_poll_timeout().

Fixes: 8a731fd37f8b ("ASoC: cs35l56: Move utility functions to shared file")
Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>
Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 sound/soc/codecs/cs35l56-shared.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/sound/soc/codecs/cs35l56-shared.c b/sound/soc/codecs/cs35l56-shared.c
index ae373f335ea8..98b1e63360ae 100644
--- a/sound/soc/codecs/cs35l56-shared.c
+++ b/sound/soc/codecs/cs35l56-shared.c
@@ -243,26 +243,27 @@ int cs35l56_wait_for_firmware_boot(struct cs35l56_base *cs35l56_base)
 {
 	unsigned int reg;
 	unsigned int val;
-	int ret;
+	int read_ret, poll_ret;
 
 	if (cs35l56_base->rev < CS35L56_REVID_B0)
 		reg = CS35L56_DSP1_HALO_STATE_A1;
 	else
 		reg = CS35L56_DSP1_HALO_STATE;
 
-	ret = regmap_read_poll_timeout(cs35l56_base->regmap, reg,
-				       val,
-				       (val < 0xFFFF) && (val >= CS35L56_HALO_STATE_BOOT_DONE),
-				       CS35L56_HALO_STATE_POLL_US,
-				       CS35L56_HALO_STATE_TIMEOUT_US);
+	/*
+	 * This can't be a regmap_read_poll_timeout() because cs35l56 will NAK
+	 * I2C until it has booted which would terminate the poll
+	 */
+	poll_ret = read_poll_timeout(regmap_read, read_ret,
+				     (val < 0xFFFF) && (val >= CS35L56_HALO_STATE_BOOT_DONE),
+				     CS35L56_HALO_STATE_POLL_US,
+				     CS35L56_HALO_STATE_TIMEOUT_US,
+				     false,
+				     cs35l56_base->regmap, reg, &val);
 
-	if ((ret < 0) && (ret != -ETIMEDOUT)) {
-		dev_err(cs35l56_base->dev, "Failed to read HALO_STATE: %d\n", ret);
-		return ret;
-	}
-
-	if ((ret == -ETIMEDOUT) || (val != CS35L56_HALO_STATE_BOOT_DONE)) {
-		dev_err(cs35l56_base->dev, "Firmware boot fail: HALO_STATE=%#x\n", val);
+	if (poll_ret) {
+		dev_err(cs35l56_base->dev, "Firmware boot timed out(%d): HALO_STATE=%#x\n",
+			read_ret, val);
 		return -EIO;
 	}
 
-- 
2.30.2

