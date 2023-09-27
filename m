Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64F927B0CEB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 21:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbjI0Tux (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 15:50:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjI0Tuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 15:50:51 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41DC6CC;
        Wed, 27 Sep 2023 12:50:50 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id 46e09a7af769-6c0ab18e084so1534571a34.1;
        Wed, 27 Sep 2023 12:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695844249; x=1696449049; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FH/NxmP2RCQOsY4lSyrrpkX9+5FMG8YQqPOFXQlGqXM=;
        b=PXxndxy3IVxrYLkJ7EXhtCr69+zyjEdQNNmw4bAt42WbAR9t/Txu6i3jWLRbxqo9pA
         ksfUX3RF5B10bpJtN8zO9lS99x0pfIVA0XG0LIvJhp3fys933obs5wycksFluwYs+T3t
         jt8/ZAKct7Jq8hIQ3cy9v4QOTej4r4+f8r7fly2sSH6slwu1vX7pop+aBy2A1sWb5CqM
         nTUrbZa6LwGoNszNmYj4OpQR+weL/Vqn64CeVyxvoCxWVYxY1kcotRwF4oTQMZ++xIO3
         M9+kEwTraxGa0cr3taNqJbWBPx6EijNH1UV3MpB01/F2NSRtz2RS+Z2H0sgzxWoppQuY
         x+CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695844249; x=1696449049;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FH/NxmP2RCQOsY4lSyrrpkX9+5FMG8YQqPOFXQlGqXM=;
        b=myDCWT45jkAc0V74Nvaxd87eEONjugpjwJ1PEiVtaT55gh2dr3B0NG2DAV71VkIMqk
         b7gy31oIjpS6QeAWljUorSnOpeVGNMDoQKzcFz5B6DEt3+EBt6vKw2tLp98OCZrouyMX
         ryxTVXzZ28j/xFvhzwrC9kmPzl8GBivT0zjss4INmwhX9obNgP/3c/sWFaON0DUfWrlH
         4Kp8AkgqSqrPiUIfm2fkzl9nmh3Jq4XUM9pjVZaLb7GKgTen9uzRc/WEwafay7oXrs7I
         /edTVekNPKKUKpge/9Sou042n4UMhgJe9veC0LUwr+aaHBnuYOQIB/q8BAWzW9E7gNEm
         AlNw==
X-Gm-Message-State: AOJu0YwEWge2qvb8MJxHBSsQ0y5coQPIQb7eRR1zke8w6JlIwQ7Uwcpu
        fBQL3O3PTPBPDl1kfr/tyl4=
X-Google-Smtp-Source: AGHT+IGJXp8r609KVR76vGLnM4P2Q1kswKMJP9yMBDCNxbvNi2Fxl5AnKj3OKXQD0TCkfqECs97KBw==
X-Received: by 2002:a05:6358:9fb0:b0:147:eb87:3665 with SMTP id fy48-20020a0563589fb000b00147eb873665mr2494500rwb.3.1695844249394;
        Wed, 27 Sep 2023 12:50:49 -0700 (PDT)
Received: from anarsoul-xps15.lan ([2604:3d08:7780:c13::398])
        by smtp.gmail.com with ESMTPSA id u7-20020a637907000000b00584b293d157sm3416650pgc.80.2023.09.27.12.50.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 12:50:48 -0700 (PDT)
From:   Vasily Khoruzhick <anarsoul@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Vasily Khoruzhick <anarsoul@gmail.com>, stable@vger.kernel.org
Subject: [PATCH v2] ACPI: FPDT: properly handle invalid FPDT subtables
Date:   Wed, 27 Sep 2023 12:50:02 -0700
Message-ID: <20230927195035.2174949-1-anarsoul@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Buggy BIOSes may have invalid FPDT subtables, e.g. on my hardware:

S3PT subtable:

7F20FE30: 53 33 50 54 24 00 00 00-00 00 00 00 00 00 18 01  *S3PT$...........*
7F20FE40: 00 00 00 00 00 00 00 00-00 00 00 00 00 00 00 00  *................*
7F20FE50: 00 00 00 00

Here the first record has zero length.

FBPT subtable:

7F20FE50:             46 42 50 54-3C 00 00 00 46 42 50 54  *....FBPT<...FBPT*
7F20FE60: 02 00 30 02 00 00 00 00-00 00 00 00 00 00 00 00  *..0.............*
7F20FE70: 2A A6 BC 6E 0B 00 00 00-1A 44 41 70 0B 00 00 00  **..n.....DAp....*
7F20FE80: 00 00 00 00 00 00 00 00-00 00 00 00 00 00 00 00  *................*

And here FBPT table has FBPT signature repeated instead of the first
record.

Current code will be looping indefinitely due to zero length records, so
break out of the loop if record length is zero.

While we are here, add proper handling for fpdt_process_subtable()
failures.

Fixes: d1eb86e59be0 ("ACPI: tables: introduce support for FPDT table")
Cc: stable@vger.kernel.org
Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
v2: return error from fpdt_process_subtable() if zero-length record is
found and handle fpdt_process_subtable() failures

 drivers/acpi/acpi_fpdt.c | 42 ++++++++++++++++++++++++++++++++--------
 1 file changed, 34 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/acpi_fpdt.c b/drivers/acpi/acpi_fpdt.c
index a2056c4c8cb7..c97c6e3936cc 100644
--- a/drivers/acpi/acpi_fpdt.c
+++ b/drivers/acpi/acpi_fpdt.c
@@ -194,12 +194,19 @@ static int fpdt_process_subtable(u64 address, u32 subtable_type)
 		record_header = (void *)subtable_header + offset;
 		offset += record_header->length;
 
+		if (!record_header->length) {
+			pr_err(FW_BUG "Zero-length record found.\n");
+			result = -EINVAL;
+			goto err;
+		}
+
 		switch (record_header->type) {
 		case RECORD_S3_RESUME:
 			if (subtable_type != SUBTABLE_S3PT) {
 				pr_err(FW_BUG "Invalid record %d for subtable %s\n",
 				     record_header->type, signature);
-				return -EINVAL;
+				result = -EINVAL;
+				goto err;
 			}
 			if (record_resume) {
 				pr_err("Duplicate resume performance record found.\n");
@@ -208,7 +215,7 @@ static int fpdt_process_subtable(u64 address, u32 subtable_type)
 			record_resume = (struct resume_performance_record *)record_header;
 			result = sysfs_create_group(fpdt_kobj, &resume_attr_group);
 			if (result)
-				return result;
+				goto err;
 			break;
 		case RECORD_S3_SUSPEND:
 			if (subtable_type != SUBTABLE_S3PT) {
@@ -223,13 +230,14 @@ static int fpdt_process_subtable(u64 address, u32 subtable_type)
 			record_suspend = (struct suspend_performance_record *)record_header;
 			result = sysfs_create_group(fpdt_kobj, &suspend_attr_group);
 			if (result)
-				return result;
+				goto err;
 			break;
 		case RECORD_BOOT:
 			if (subtable_type != SUBTABLE_FBPT) {
 				pr_err(FW_BUG "Invalid %d for subtable %s\n",
 				     record_header->type, signature);
-				return -EINVAL;
+				result = -EINVAL;
+				goto err;
 			}
 			if (record_boot) {
 				pr_err("Duplicate boot performance record found.\n");
@@ -238,7 +246,7 @@ static int fpdt_process_subtable(u64 address, u32 subtable_type)
 			record_boot = (struct boot_performance_record *)record_header;
 			result = sysfs_create_group(fpdt_kobj, &boot_attr_group);
 			if (result)
-				return result;
+				goto err;
 			break;
 
 		default:
@@ -247,6 +255,16 @@ static int fpdt_process_subtable(u64 address, u32 subtable_type)
 		}
 	}
 	return 0;
+
+err:
+	if (record_boot)
+		sysfs_remove_group(fpdt_kobj, &boot_attr_group);
+	if (record_suspend)
+		sysfs_remove_group(fpdt_kobj, &suspend_attr_group);
+	if (record_resume)
+		sysfs_remove_group(fpdt_kobj, &resume_attr_group);
+
+	return result;
 }
 
 static int __init acpi_init_fpdt(void)
@@ -255,6 +273,7 @@ static int __init acpi_init_fpdt(void)
 	struct acpi_table_header *header;
 	struct fpdt_subtable_entry *subtable;
 	u32 offset = sizeof(*header);
+	int result;
 
 	status = acpi_get_table(ACPI_SIG_FPDT, 0, &header);
 
@@ -263,8 +282,8 @@ static int __init acpi_init_fpdt(void)
 
 	fpdt_kobj = kobject_create_and_add("fpdt", acpi_kobj);
 	if (!fpdt_kobj) {
-		acpi_put_table(header);
-		return -ENOMEM;
+		result = -ENOMEM;
+		goto err_nomem;
 	}
 
 	while (offset < header->length) {
@@ -272,8 +291,10 @@ static int __init acpi_init_fpdt(void)
 		switch (subtable->type) {
 		case SUBTABLE_FBPT:
 		case SUBTABLE_S3PT:
-			fpdt_process_subtable(subtable->address,
+			result = fpdt_process_subtable(subtable->address,
 					      subtable->type);
+			if (result)
+				goto err_subtable;
 			break;
 		default:
 			/* Other types are reserved in ACPI 6.4 spec. */
@@ -282,6 +303,11 @@ static int __init acpi_init_fpdt(void)
 		offset += sizeof(*subtable);
 	}
 	return 0;
+err_subtable:
+	kobject_put(fpdt_kobj);
+err_nomem:
+	acpi_put_table(header);
+	return result;
 }
 
 fs_initcall(acpi_init_fpdt);
-- 
2.42.0

