Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CCB777F545
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 13:30:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350297AbjHQL3g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 07:29:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236405AbjHQL3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 07:29:04 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C3DF30D8
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 04:28:38 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 37H705EP017258;
        Thu, 17 Aug 2023 06:27:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        PODMain02222019; bh=ozRr7lC9Q8WzRyOn8/1zIRanm0Iqd9bp6Cg1X2A42LE=; b=
        Ot7ahKT6bEMHr6fSF6cVhyXyaDnPM3YzBx0lmJaOK3qdGBMiE/IvNRctLtTIxopo
        aKKug1r+4hLMuYOrqwceb4V31zRcMnzqsMFuFSem2H6S1/jMX/4se6P6Hx5LV+IM
        wdFZKVcb2nCYB5eYGAf5RKyBwoenOIvlqpoY/RhA74baU/S2uNAj2D9eXvt9fk7C
        aHEqlD71xr63V4ViC26nTLJJNHcNyHdryxllMAnbR3sGGmw0GRiLDGUZ4frVfH2v
        Y/M1+ksHRFmWFLUyN+uf2zbpsH+48yo+o/kq+bjwUQtV8Y6uhi12KIMauvODmKhR
        A4+9vDwbtVT+VG5wwh6x2w==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3se8kqxa12-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Aug 2023 06:27:17 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Thu, 17 Aug
 2023 12:27:15 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.30 via Frontend
 Transport; Thu, 17 Aug 2023 12:27:15 +0100
Received: from EDIN4L06LR3.ad.cirrus.com (EDIN4L06LR3.ad.cirrus.com [198.61.65.68])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 4E847475;
        Thu, 17 Aug 2023 11:27:15 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Maciej Strozek <mstrozek@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH v2 1/2] ASoC: cs35l56: Read firmware uuid from a device property instead of _SUB
Date:   Thu, 17 Aug 2023 12:27:11 +0100
Message-ID: <20230817112712.16637-2-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230817112712.16637-1-rf@opensource.cirrus.com>
References: <20230817112712.16637-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: itVSdHVMW1jrOK1uFP4BIj9_tGxEAmxb
X-Proofpoint-GUID: itVSdHVMW1jrOK1uFP4BIj9_tGxEAmxb
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maciej Strozek <mstrozek@opensource.cirrus.com>

Use a device property "cirrus,firmware-uid" to get the unique firmware
identifier instead of using ACPI _SUB. There aren't any products that use
_SUB.

There will not usually be a _SUB in Soundwire nodes. The ACPI can use a
_DSD section for custom properties.

There is also a need to support instantiating this driver using software
nodes. This is for systems where the CS35L56 is a back-end device and the
ACPI refers only to the front-end audio device - there will not be any ACPI
references to CS35L56.

Fixes: e49611252900 ("ASoC: cs35l56: Add driver for Cirrus Logic CS35L56")
Signed-off-by: Maciej Strozek <mstrozek@opensource.cirrus.com>
Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
Changes since V1:
- Rebase to apply on v6.4 and v6.5
- Use devm_kstrdup() instead of kstrdup() and free()

To apply on v6.6 a 1-line change is needed:

static int cs35l56_get_firmware_uid(struct cs35l56_private *cs35l56)
{
-	struct device *dev = cs35l56->dev;
+	struct device *dev = cs35l56->base.dev;
---
 sound/soc/codecs/cs35l56.c | 31 ++++++++++++-------------------
 1 file changed, 12 insertions(+), 19 deletions(-)

diff --git a/sound/soc/codecs/cs35l56.c b/sound/soc/codecs/cs35l56.c
index c03f9d3c9a13..fd06b9f9d496 100644
--- a/sound/soc/codecs/cs35l56.c
+++ b/sound/soc/codecs/cs35l56.c
@@ -5,7 +5,6 @@
 // Copyright (C) 2023 Cirrus Logic, Inc. and
 //                    Cirrus Logic International Semiconductor Ltd.
 
-#include <linux/acpi.h>
 #include <linux/completion.h>
 #include <linux/debugfs.h>
 #include <linux/delay.h>
@@ -1354,26 +1353,22 @@ static int cs35l56_dsp_init(struct cs35l56_private *cs35l56)
 	return 0;
 }
 
-static int cs35l56_acpi_get_name(struct cs35l56_private *cs35l56)
+static int cs35l56_get_firmware_uid(struct cs35l56_private *cs35l56)
 {
-	acpi_handle handle = ACPI_HANDLE(cs35l56->dev);
-	const char *sub;
+	struct device *dev = cs35l56->dev;
+	const char *prop;
+	int ret;
 
-	/* If there is no ACPI_HANDLE, there is no ACPI for this system, return 0 */
-	if (!handle)
+	ret = device_property_read_string(dev, "cirrus,firmware-uid", &prop);
+	/* If bad sw node property, return 0 and fallback to legacy firmware path */
+	if (ret < 0)
 		return 0;
 
-	sub = acpi_get_subsystem_id(handle);
-	if (IS_ERR(sub)) {
-		/* If bad ACPI, return 0 and fallback to legacy firmware path, otherwise fail */
-		if (PTR_ERR(sub) == -ENODATA)
-			return 0;
-		else
-			return PTR_ERR(sub);
-	}
+	cs35l56->dsp.system_name = devm_kstrdup(dev, prop, GFP_KERNEL);
+	if (cs35l56->dsp.system_name == NULL)
+		return -ENOMEM;
 
-	cs35l56->dsp.system_name = sub;
-	dev_dbg(cs35l56->dev, "Subsystem ID: %s\n", cs35l56->dsp.system_name);
+	dev_dbg(dev, "Firmware UID: %s\n", cs35l56->dsp.system_name);
 
 	return 0;
 }
@@ -1417,7 +1412,7 @@ int cs35l56_common_probe(struct cs35l56_private *cs35l56)
 		gpiod_set_value_cansleep(cs35l56->reset_gpio, 1);
 	}
 
-	ret = cs35l56_acpi_get_name(cs35l56);
+	ret = cs35l56_get_firmware_uid(cs35l56);
 	if (ret != 0)
 		goto err;
 
@@ -1604,8 +1599,6 @@ void cs35l56_remove(struct cs35l56_private *cs35l56)
 
 	regcache_cache_only(cs35l56->regmap, true);
 
-	kfree(cs35l56->dsp.system_name);
-
 	gpiod_set_value_cansleep(cs35l56->reset_gpio, 0);
 	regulator_bulk_disable(ARRAY_SIZE(cs35l56->supplies), cs35l56->supplies);
 }
-- 
2.30.2

