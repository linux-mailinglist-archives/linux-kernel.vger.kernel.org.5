Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B1CE77E6F1
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 18:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344936AbjHPQtm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 12:49:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344993AbjHPQte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 12:49:34 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27D4E272B
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 09:49:24 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 37G5L6Ul023417;
        Wed, 16 Aug 2023 11:49:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        PODMain02222019; bh=ciRFu0viKeYSMqpvc1bi/uXL1528HUaekAc7k6yN6C0=; b=
        Oap43+jczlrr4NNLqfpyTREjTndSjyqODPj0LSTK3C6u8OyCAZJQhZ9bxwlKlx2G
        oMjaQ4TuLkc4CFZjjadVwAz5WxWeKYUTjw+2rnpc7hJQiU4UhKwsCARAiKBlDBDJ
        TGzPEzV2+xQNxHPDfW6Lhrdg40K5duBfFFo98C3yepFv5l3oOInuEv/6QicVgWNk
        VLIAyyBV0FLqTXpJykkwt1PFqhT6ZKrhiA9ib3Ir/mTwPwxMJDal+fVehmxCe0TL
        nQwyyjOqc6drniYUjVQioR9YReL4yBaMIExswogJSQtqMwkT6t06P/psuzjasDuk
        6AX51qv4airHwKB3VDRUVg==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3se8kqw8gb-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Aug 2023 11:49:12 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Wed, 16 Aug
 2023 17:49:09 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.30 via Frontend
 Transport; Wed, 16 Aug 2023 17:49:09 +0100
Received: from EDIN4L06LR3.ad.cirrus.com (EDIN4L06LR3.ad.cirrus.com [198.61.65.68])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 497313578;
        Wed, 16 Aug 2023 16:49:09 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Maciej Strozek <mstrozek@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH 2/2] ASoC: cs35l56: Read firmware uuid from a device property instead of _SUB
Date:   Wed, 16 Aug 2023 17:49:06 +0100
Message-ID: <20230816164906.42-3-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230816164906.42-1-rf@opensource.cirrus.com>
References: <20230816164906.42-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: wppAZtXu97TQCjb-Xmou5E9aPQCOnKkQ
X-Proofpoint-GUID: wppAZtXu97TQCjb-Xmou5E9aPQCOnKkQ
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maciej Strozek <mstrozek@opensource.cirrus.com>

Use a device property "cirrus,firmware-uid" to get the unique firmware
identifier instead of using ACPI _SUB.

There will not usually be a _SUB in Soundwire nodes. The ACPI can use a
_DSD section for custom properties.

There is also a need to support instantiating this driver using software
nodes. This is for systems where the CS35L56 is a back-end device and the
ACPI refers only to the front-end audio device - there will not be any ACPI
references to CS35L56.

Signed-off-by: Maciej Strozek <mstrozek@opensource.cirrus.com>
Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 sound/soc/codecs/cs35l56.c | 31 ++++++++++++++-----------------
 1 file changed, 14 insertions(+), 17 deletions(-)

diff --git a/sound/soc/codecs/cs35l56.c b/sound/soc/codecs/cs35l56.c
index 3a9ec8724cc1..1f4cee097119 100644
--- a/sound/soc/codecs/cs35l56.c
+++ b/sound/soc/codecs/cs35l56.c
@@ -5,7 +5,6 @@
 // Copyright (C) 2023 Cirrus Logic, Inc. and
 //                    Cirrus Logic International Semiconductor Ltd.
 
-#include <linux/acpi.h>
 #include <linux/completion.h>
 #include <linux/debugfs.h>
 #include <linux/delay.h>
@@ -1029,26 +1028,24 @@ static int cs35l56_dsp_init(struct cs35l56_private *cs35l56)
 	return 0;
 }
 
-static int cs35l56_acpi_get_name(struct cs35l56_private *cs35l56)
+static int cs35l56_get_firmware_uid(struct cs35l56_private *cs35l56)
 {
-	acpi_handle handle = ACPI_HANDLE(cs35l56->base.dev);
-	const char *sub;
+	const char *prop;
+	int ret;
 
-	/* If there is no ACPI_HANDLE, there is no ACPI for this system, return 0 */
-	if (!handle)
+	ret = device_property_read_string(cs35l56->base.dev, "cirrus,firmware-uid",
+					  &prop);
+	/*
+	 * If bad sw node property, return 0 and fallback to legacy firmware path
+	 */
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
+	cs35l56->dsp.system_name = kstrdup(prop, GFP_KERNEL);
+	if (cs35l56->dsp.system_name == NULL)
+		return -ENOMEM;
 
-	cs35l56->dsp.system_name = sub;
-	dev_dbg(cs35l56->base.dev, "Subsystem ID: %s\n", cs35l56->dsp.system_name);
+	dev_dbg(cs35l56->base.dev, "Firmware UID: %s\n", cs35l56->dsp.system_name);
 
 	return 0;
 }
@@ -1095,7 +1092,7 @@ int cs35l56_common_probe(struct cs35l56_private *cs35l56)
 		gpiod_set_value_cansleep(cs35l56->base.reset_gpio, 1);
 	}
 
-	ret = cs35l56_acpi_get_name(cs35l56);
+	ret = cs35l56_get_firmware_uid(cs35l56);
 	if (ret != 0)
 		goto err;
 
-- 
2.30.2

