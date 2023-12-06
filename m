Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D05B8074D9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 17:22:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379171AbjLFQW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 11:22:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379277AbjLFQW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 11:22:26 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 327F2D5A;
        Wed,  6 Dec 2023 08:22:32 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-6ce972ac39dso530300b3a.3;
        Wed, 06 Dec 2023 08:22:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701879751; x=1702484551; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=baY6D3HakugSlKdkq8lYBEYPJB1aqECTe+JYqVvoG18=;
        b=IreSA+hbFeAXwSRk8RMA0qS1eh5nqpOTIJ4UZCQojYeoB2AcBzRtCcpxLgZpVGuWlL
         Tj7eNIsUIESV7MXn2QF2zr6GJ3civSIL3SyqC1IwqI3egy6ycmiJ14dD6yIqFFg9NtZo
         KTzKpUrj13hwJWsxNZI5jHXZ7jLi+s5/lsQ55pXT2GEI7B4MemBIwyLwy9k5Rz+UU4cX
         zXSyWElSkf4wBxJa8dT/KyT2CyC3/w/zDHbNXoPIGvboitg9ly+p9ECstEP3NDZ95JAX
         mUqpM3jYyHClbawlJDxjXMpJFCOC7aCQVF6wYVMTgD92/st8iIAbg3AYBa9edvLizuAI
         GFEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701879751; x=1702484551;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=baY6D3HakugSlKdkq8lYBEYPJB1aqECTe+JYqVvoG18=;
        b=Jke5pUViHWIKn0W8qPdwfJhJLmTsxG3PAiwhiNGpB84bMftbhkWysFQpFTED3y2wd4
         mlTbGTG9+wyzWZIU8qH/jfzg4bQZ2U6cJ9U9s4iqw+ZccGCFj6hsV5Slow4TZycj8hyZ
         +EMfYwwhOdGabcFGDvyHuStySjyBh9toldT5qcIdp4Rbw1+knMQOA2PX/+s3yEaOVHyU
         AeehRzTATxyyZjuw9Y/ggBH938bW3ategPa6AzsVsn9gaCFZ5pM5mhREgmJYjDn02cv4
         v0mvOiBF4tNbW3zWczqDa5ZY5j3q+lwEfqpGnXxQaFMURgTSqKv5Ye7c3FXx1zhnbRfF
         FPkA==
X-Gm-Message-State: AOJu0YxatGJL0gZ/XVXYyU0CfzMyS8DAAd03FZ3y6Folb9W0Q688C4Hz
        rq5xdJeZT2rmR0WMUT4ftLc=
X-Google-Smtp-Source: AGHT+IEZHr9xLzruHubHdgTNcsqZBSjt28iSgrPzS1KsyvLVUDMb7vOGl/tBP873l0D4XbdyAYfKDA==
X-Received: by 2002:a05:6a00:4297:b0:6ce:2732:285 with SMTP id bx23-20020a056a00429700b006ce27320285mr823160pfb.52.1701879751297;
        Wed, 06 Dec 2023 08:22:31 -0800 (PST)
Received: from ares2-ThinkPad-L13-Yoga-Gen-2.. ([2400:2410:b9a0:8400:4a6a:9a6d:1147:b68b])
        by smtp.googlemail.com with ESMTPSA id gu26-20020a056a004e5a00b006be5af77f06sm183840pfb.2.2023.12.06.08.22.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 08:22:30 -0800 (PST)
From:   Vishnu Sankar <vishnuocv@gmail.com>
To:     hdegoede@redhat.com
Cc:     mpearson-lenovo@squebb.ca, ilpo.jarvinen@linux.intel.com,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        markgross@kernel.org, Vishnu Sankar <vishnuocv@gmail.com>
Subject: [PATCH] platform/x86: thinkpad_acpi: fix for incorrect fan reporting on some ThinkPad systems
Date:   Thu,  7 Dec 2023 01:20:03 +0900
Message-Id: <20231206162003.92010-1-vishnuocv@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some ThinkPad systems ECFW use non-standard addresses for fan control
and reporting. This patch adds support for such ECFW so that it can report
the correct fan values.
Tested on Thinkpads L13 Yoga Gen 2 and X13 Yoga Gen 2.

Co-developed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Signed-off-by: Vishnu Sankar <vishnuocv@gmail.com>
---
 drivers/platform/x86/thinkpad_acpi.c | 88 ++++++++++++++++++++++++----
 1 file changed, 76 insertions(+), 12 deletions(-)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index d0b5fd4137bc..51ec20e07b23 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -7950,6 +7950,11 @@ static struct ibm_struct volume_driver_data = {
  * 	but the ACPI tables just mention level 7.
  */
 
+#define FAN_RPM_CAL_CONST 491520	/* FAN RPM calculation offset for some non-standard ECFW */
+
+#define FAN_NS_CTRL_STATUS	BIT(2)		/* Bit which determines control is enabled or not */
+#define FAN_NS_CTRL		BIT(4)		/* Bit which determines control is by host or EC */
+
 enum {					/* Fan control constants */
 	fan_status_offset = 0x2f,	/* EC register 0x2f */
 	fan_rpm_offset = 0x84,		/* EC register 0x84: LSB, 0x85 MSB (RPM)
@@ -7957,6 +7962,11 @@ enum {					/* Fan control constants */
 	fan_select_offset = 0x31,	/* EC register 0x31 (Firmware 7M)
 					   bit 0 selects which fan is active */
 
+	fan_status_offset_ns = 0x93,	/* Special status/control offset for non-standard EC Fan1 */
+	fan2_status_offset_ns = 0x96,	/* Special status/control offset for non-standard EC Fan2 */
+	fan_rpm_status_ns = 0x95,	/* Special offset for Fan1 RPM status for non-standard EC */
+	fan2_rpm_status_ns = 0x98,	/* Special offset for Fan2 RPM status for non-standard EC */
+
 	TP_EC_FAN_FULLSPEED = 0x40,	/* EC fan mode: full speed */
 	TP_EC_FAN_AUTO	    = 0x80,	/* EC fan mode: auto fan control */
 
@@ -7967,6 +7977,7 @@ enum fan_status_access_mode {
 	TPACPI_FAN_NONE = 0,		/* No fan status or control */
 	TPACPI_FAN_RD_ACPI_GFAN,	/* Use ACPI GFAN */
 	TPACPI_FAN_RD_TPEC,		/* Use ACPI EC regs 0x2f, 0x84-0x85 */
+	TPACPI_FAN_RD_TPEC_NS,		/* Use non-standard ACPI EC regs (eg: L13 Yoga gen2 etc.) */
 };
 
 enum fan_control_access_mode {
@@ -7994,6 +8005,8 @@ static u8 fan_control_desired_level;
 static u8 fan_control_resume_level;
 static int fan_watchdog_maxinterval;
 
+static bool fan_with_ns_addr;
+
 static struct mutex fan_mutex;
 
 static void fan_watchdog_fire(struct work_struct *ignored);
@@ -8123,6 +8136,15 @@ static int fan_get_status(u8 *status)
 		}
 
 		break;
+	case TPACPI_FAN_RD_TPEC_NS:
+		/* Default mode is AUTO which means controlled by EC */
+		if (unlikely(!acpi_ec_read(fan_status_offset_ns, &s)))
+			return -EIO;
+
+		if (likely(status))
+			*status = s;
+
+		break;
 
 	default:
 		return -ENXIO;
@@ -8139,7 +8161,8 @@ static int fan_get_status_safe(u8 *status)
 	if (mutex_lock_killable(&fan_mutex))
 		return -ERESTARTSYS;
 	rc = fan_get_status(&s);
-	if (!rc)
+	/* NS EC doesn't have register with level settings */
+	if (!rc && !fan_with_ns_addr)
 		fan_update_desired_level(s);
 	mutex_unlock(&fan_mutex);
 
@@ -8166,7 +8189,13 @@ static int fan_get_speed(unsigned int *speed)
 
 		if (likely(speed))
 			*speed = (hi << 8) | lo;
+		break;
+	case TPACPI_FAN_RD_TPEC_NS:
+		if (unlikely(!acpi_ec_read(fan_rpm_status_ns, &lo)))
+			return -EIO;
 
+		if (likely(speed))
+			*speed = lo ? FAN_RPM_CAL_CONST / lo : 0;
 		break;
 
 	default:
@@ -8178,7 +8207,7 @@ static int fan_get_speed(unsigned int *speed)
 
 static int fan2_get_speed(unsigned int *speed)
 {
-	u8 hi, lo;
+	u8 hi, lo, status;
 	bool rc;
 
 	switch (fan_status_access_mode) {
@@ -8194,7 +8223,21 @@ static int fan2_get_speed(unsigned int *speed)
 
 		if (likely(speed))
 			*speed = (hi << 8) | lo;
+		break;
 
+	case TPACPI_FAN_RD_TPEC_NS:
+		rc = !acpi_ec_read(fan2_status_offset_ns, &status);
+		if (rc)
+			return -EIO;
+		if (!(status & FAN_NS_CTRL_STATUS)) {
+			pr_info("fan fan2 control not supported\n");
+			return -EIO;
+		}
+		rc = !acpi_ec_read(fan2_rpm_status_ns, &lo);
+		if (rc)
+			return -EIO;
+		if (likely(speed))
+			*speed = lo ? FAN_RPM_CAL_CONST / lo : 0;
 		break;
 
 	default:
@@ -8697,6 +8740,7 @@ static const struct attribute_group fan_driver_attr_group = {
 #define TPACPI_FAN_2FAN		0x0002		/* EC 0x31 bit 0 selects fan2 */
 #define TPACPI_FAN_2CTL		0x0004		/* selects fan2 control */
 #define TPACPI_FAN_NOFAN	0x0008		/* no fan available */
+#define TPACPI_FAN_NS		0x0010		/* For EC with non-Standard register addresses */
 
 static const struct tpacpi_quirk fan_quirk_table[] __initconst = {
 	TPACPI_QEC_IBM('1', 'Y', TPACPI_FAN_Q1),
@@ -8715,6 +8759,8 @@ static const struct tpacpi_quirk fan_quirk_table[] __initconst = {
 	TPACPI_Q_LNV3('N', '2', 'O', TPACPI_FAN_2CTL),	/* P1 / X1 Extreme (2nd gen) */
 	TPACPI_Q_LNV3('N', '3', '0', TPACPI_FAN_2CTL),	/* P15 (1st gen) / P15v (1st gen) */
 	TPACPI_Q_LNV3('N', '3', '7', TPACPI_FAN_2CTL),  /* T15g (2nd gen) */
+	TPACPI_Q_LNV3('R', '1', 'F', TPACPI_FAN_NS),	/* L13 Yoga Gen 2 */
+	TPACPI_Q_LNV3('N', '2', 'U', TPACPI_FAN_NS),	/* X13 Yoga Gen 2*/
 	TPACPI_Q_LNV3('N', '1', 'O', TPACPI_FAN_NOFAN),	/* X1 Tablet (2nd gen) */
 };
 
@@ -8749,6 +8795,13 @@ static int __init fan_init(struct ibm_init_struct *iibm)
 		return -ENODEV;
 	}
 
+	if (quirks & TPACPI_FAN_NS) {
+		pr_info("ECFW with non-standard fan reg control found\n");
+		fan_with_ns_addr = 1;
+		/* Fan ctrl support from host is undefined for now */
+		tp_features.fan_ctrl_status_undef = 1;
+	}
+
 	if (gfan_handle) {
 		/* 570, 600e/x, 770e, 770x */
 		fan_status_access_mode = TPACPI_FAN_RD_ACPI_GFAN;
@@ -8756,11 +8809,13 @@ static int __init fan_init(struct ibm_init_struct *iibm)
 		/* all other ThinkPads: note that even old-style
 		 * ThinkPad ECs supports the fan control register */
 		if (likely(acpi_ec_read(fan_status_offset,
-					&fan_control_initial_status))) {
+					&fan_control_initial_status)) || fan_with_ns_addr) {
 			int res;
 			unsigned int speed;
 
-			fan_status_access_mode = TPACPI_FAN_RD_TPEC;
+			fan_status_access_mode = fan_with_ns_addr ?
+				TPACPI_FAN_RD_TPEC_NS : TPACPI_FAN_RD_TPEC;
+
 			if (quirks & TPACPI_FAN_Q1)
 				fan_quirk1_setup();
 			/* Try and probe the 2nd fan */
@@ -8769,7 +8824,8 @@ static int __init fan_init(struct ibm_init_struct *iibm)
 			if (res >= 0 && speed != FAN_NOT_PRESENT) {
 				/* It responded - so let's assume it's there */
 				tp_features.second_fan = 1;
-				tp_features.second_fan_ctl = 1;
+				/* fan control not currently available for ns ECFW */
+				tp_features.second_fan_ctl = fan_with_ns_addr ? 0 : 1;
 				pr_info("secondary fan control detected & enabled\n");
 			} else {
 				/* Fan not auto-detected */
@@ -8944,6 +9000,7 @@ static int fan_read(struct seq_file *m)
 			       str_enabled_disabled(status), status);
 		break;
 
+	case TPACPI_FAN_RD_TPEC_NS:
 	case TPACPI_FAN_RD_TPEC:
 		/* all except 570, 600e/x, 770e, 770x */
 		rc = fan_get_status_safe(&status);
@@ -8958,13 +9015,20 @@ static int fan_read(struct seq_file *m)
 
 		seq_printf(m, "speed:\t\t%d\n", speed);
 
-		if (status & TP_EC_FAN_FULLSPEED)
-			/* Disengaged mode takes precedence */
-			seq_printf(m, "level:\t\tdisengaged\n");
-		else if (status & TP_EC_FAN_AUTO)
-			seq_printf(m, "level:\t\tauto\n");
-		else
-			seq_printf(m, "level:\t\t%d\n", status);
+		if (fan_status_access_mode == TPACPI_FAN_RD_TPEC_NS) {
+			/* No full speed bit in NS EC*/
+			/* EC Auto mode is set by default. No other levels settings available*/
+			(status & FAN_NS_CTRL) ? seq_puts(m, "level:\t\tunknown\n")
+					: seq_puts(m, "level:\t\tauto\n");
+		} else {
+			if (status & TP_EC_FAN_FULLSPEED)
+				/* Disengaged mode takes precedence */
+				seq_puts(m, "level:\t\tdisengaged\n");
+			else if (status & TP_EC_FAN_AUTO)
+				seq_puts(m, "level:\t\tauto\n");
+			else
+				seq_printf(m, "level:\t\t%d\n", status);
+		}
 		break;
 
 	case TPACPI_FAN_NONE:
-- 
2.34.1

