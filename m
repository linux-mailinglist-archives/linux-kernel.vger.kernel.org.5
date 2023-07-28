Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44B25766B78
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 13:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236191AbjG1LN5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 07:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234120AbjG1LNz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 07:13:55 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CCE110FC;
        Fri, 28 Jul 2023 04:13:55 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 36S9SC8k015067;
        Fri, 28 Jul 2023 06:13:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding:content-type; s=PODMain02222019; bh=F
        mlLIoAxDKqi8A1/MVbQMyVNZ+iK+/Sg6x60UKzwjbM=; b=c0KYT5iK19zV8HNTr
        JX1tzVGiuox9CzNYDsxlSLx3DoxK2BWoJwHwLl29fLcoaTZrR62U8LR6AhyFaVSM
        cdRAb9ilXfmkOYuOb3pPIriRppwem+TfiRLBxPclKMKNmUI581O2y3MOuZ+Hig3j
        sUeEr6kDlS4zjTTzgK599KeBv8GrWkkjiYkgTw4m93pNPSfhoMLiVgSVAMeG40E3
        wSsQ8yU+alXpaE7rXRYndcecow4V2Xgkg8mXqtoaC8rntSwImcVMvwoYGwDXEaYi
        GBf5Tc6zM5iwUR9BJSaGfkBQ9KikCdJNDdmaWBNCpT9Sjf78fZ5arHoguYzcPhU7
        hC0ng==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3s2q713ben-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Jul 2023 06:13:50 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Fri, 28 Jul
 2023 12:13:48 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.30 via Frontend
 Transport; Fri, 28 Jul 2023 12:13:48 +0100
Received: from EDIN4L06LR3.ad.cirrus.com (EDIN4L06LR3.ad.cirrus.com [198.61.65.196])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 596E145D;
        Fri, 28 Jul 2023 11:13:48 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <rafael@kernel.org>, <hdegoede@redhat.com>
CC:     <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Simon Trimmer <simont@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH v3] ACPI: scan: Create platform device for CS35L56
Date:   Fri, 28 Jul 2023 12:13:45 +0100
Message-ID: <20230728111345.7224-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: Y6TbL0G5APPmcETfijmSwe1Ub1ddwpmH
X-Proofpoint-ORIG-GUID: Y6TbL0G5APPmcETfijmSwe1Ub1ddwpmH
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Simon Trimmer <simont@opensource.cirrus.com>

The ACPI device CSC3556 is a Cirrus Logic CS35L56 mono amplifier which
is used in multiples, and can be connected either to I2C or SPI.

There will be multiple instances under the same Device() node. Add it
to ignore_serial_bus_ids and handle it in the serial-multi-instantiate
driver.

There can be a 5th I2cSerialBusV2, but this is an alias address and doesn't
represent a real device. Ignore this by having a dummy 5th entry in the
serial-multi-instantiate instance list with the name of a non-existent
driver, on the same pattern as done for bsg2150.

Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>
Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 drivers/acpi/scan.c                             |  1 +
 drivers/platform/x86/serial-multi-instantiate.c | 14 ++++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 5b145f1aaa1b..87e385542576 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1714,6 +1714,7 @@ static bool acpi_device_enumeration_by_parent(struct acpi_device *device)
 		{"BSG1160", },
 		{"BSG2150", },
 		{"CSC3551", },
+		{"CSC3556", },
 		{"INT33FE", },
 		{"INT3515", },
 		/* Non-conforming _HID for Cirrus Logic already released */
diff --git a/drivers/platform/x86/serial-multi-instantiate.c b/drivers/platform/x86/serial-multi-instantiate.c
index 2c2abf69f049..8158e3cf5d6d 100644
--- a/drivers/platform/x86/serial-multi-instantiate.c
+++ b/drivers/platform/x86/serial-multi-instantiate.c
@@ -329,6 +329,19 @@ static const struct smi_node cs35l41_hda = {
 	.bus_type = SMI_AUTO_DETECT,
 };
 
+static const struct smi_node cs35l56_hda = {
+	.instances = {
+		{ "cs35l56-hda", IRQ_RESOURCE_AUTO, 0 },
+		{ "cs35l56-hda", IRQ_RESOURCE_AUTO, 0 },
+		{ "cs35l56-hda", IRQ_RESOURCE_AUTO, 0 },
+		{ "cs35l56-hda", IRQ_RESOURCE_AUTO, 0 },
+		/* a 5th entry is an alias address, not a real device */
+		{ "cs35l56-hda_dummy_dev" },
+		{}
+	},
+	.bus_type = SMI_AUTO_DETECT,
+};
+
 /*
  * Note new device-ids must also be added to ignore_serial_bus_ids in
  * drivers/acpi/scan.c: acpi_device_enumeration_by_parent().
@@ -337,6 +350,7 @@ static const struct acpi_device_id smi_acpi_ids[] = {
 	{ "BSG1160", (unsigned long)&bsg1160_data },
 	{ "BSG2150", (unsigned long)&bsg2150_data },
 	{ "CSC3551", (unsigned long)&cs35l41_hda },
+	{ "CSC3556", (unsigned long)&cs35l56_hda },
 	{ "INT3515", (unsigned long)&int3515_data },
 	/* Non-conforming _HID for Cirrus Logic already released */
 	{ "CLSA0100", (unsigned long)&cs35l41_hda },
-- 
2.30.2

