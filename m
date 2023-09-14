Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 097067A036E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 14:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238363AbjINMLi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 08:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238119AbjINMLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 08:11:38 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 124411BE8
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 05:11:33 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 38E9lh9Z015602;
        Thu, 14 Sep 2023 07:11:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding:content-type; s=PODMain02222019; bh=A
        nv7LULgGpfntaEAW5v8GiBoJeIf6esI1Pwibsff3+0=; b=DRGqFmblwSlQIp2bK
        +nwh5CQNs5cRfK1zpRlx9k6MbvTLR+lnEFtkg/LiAF+5HH0WEPfMHZJpQWZlK0Cq
        bS/h35Q+Kk8i46qY91NriQj2UFfCwbbjGHbY19NXTan50jbZwevjKK5ValCGQi+G
        4TGePr64qQLA/fcPSVMNx3EzMLG7KYGVv4Q1HOI2J1i9hS3GC8uDfz7DmP31ERPc
        1Xo8vbt+QRHcSrj7L52JkpT7DsiD6zLy0zhkHyMUVIkEFI04v9hfsoom4h5RFpm1
        5ClpD0ejGvEkAUrr6V1mMTTlgMESXxy9KBOvo3Wb8FXcyHXmkQjTdKrJAS5WsfCh
        X+TiA==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3t2y7sj1sm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Sep 2023 07:11:26 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.37; Thu, 14 Sep
 2023 13:11:25 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.37 via Frontend
 Transport; Thu, 14 Sep 2023 13:11:25 +0100
Received: from EDIN4L06LR3.ad.cirrus.com (EDIN4L06LR3.ad.cirrus.com [198.61.65.215])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id C4DAB3563;
        Thu, 14 Sep 2023 12:11:24 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH] ALSA: hda: cs35l56: Fix missing RESET GPIO if _SUB is missing
Date:   Thu, 14 Sep 2023 13:11:20 +0100
Message-ID: <20230914121120.6201-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: cZVWMLgfZc3ILgca3yz8QMRYONwXQDUB
X-Proofpoint-ORIG-GUID: cZVWMLgfZc3ILgca3yz8QMRYONwXQDUB
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In cs35l56_hda_read_acpi() do not return if ACPI _SUB is missing.

A missing _SUB means that the driver cannot load a system-specific
firmware, because the firmware is identified by the _SUB. But it can
fallback to a generic firmware. Unfortunately this was being handled
by immediately returning 0, which would skip the remaining ACPI
configuration in cs35l56_hda_read_acpi() and so it would not get the
RESET GPIO.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Fixes: 73cfbfa9caea ("ALSA: hda/cs35l56: Add driver for Cirrus Logic CS35L56 amplifier")
---
 sound/pci/hda/cs35l56_hda.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/sound/pci/hda/cs35l56_hda.c b/sound/pci/hda/cs35l56_hda.c
index 9e4976bdb5e0..a9844336bdc9 100644
--- a/sound/pci/hda/cs35l56_hda.c
+++ b/sound/pci/hda/cs35l56_hda.c
@@ -864,15 +864,11 @@ static int cs35l56_hda_read_acpi(struct cs35l56_hda *cs35l56, int id)
 
 	sub = acpi_get_subsystem_id(ACPI_HANDLE(cs35l56->base.dev));
 
-	if (IS_ERR(sub)) {
-		/* If no ACPI SUB, return 0 and fallback to legacy firmware path, otherwise fail */
-		if (PTR_ERR(sub) == -ENODATA)
-			return 0;
-		else
-			return PTR_ERR(sub);
-	}
-
-	cs35l56->system_name = sub;
+	if (IS_ERR(sub))
+		dev_err_probe(cs35l56->base.dev, PTR_ERR(sub),
+			      "Read ACPI _SUB failed: fallback to generic firmware\n");
+	else
+		cs35l56->system_name = sub;
 
 	cs35l56->base.reset_gpio = devm_gpiod_get_index_optional(cs35l56->base.dev,
 								 "reset",
-- 
2.30.2

