Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3B807F32EB
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 16:58:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234851AbjKUP6X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 10:58:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234854AbjKUP6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 10:58:17 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41799D49;
        Tue, 21 Nov 2023 07:58:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700582294; x=1732118294;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=itjj7X5Il/CLPzOHoOlkC+igDSCWB8zI/FawmL7Ca+8=;
  b=CDQ/VY2bHU+sws+4qlWk996SRaQynOckojutQMgxDBjtpIB3wtILIulW
   flEQrZOPgTfiSyDcbFy4ffPExTvdg88/jzE7n3GQKIlXVcVZ9xQRUvNad
   h4dOHKK5xdMdE3PaFXH88oFECpfKxfOWsCgp5CqzT6b0HQ/2Ffmk2x3b6
   ujyW1ZzhoiMXx4gW6CQDhdLwBcwguE/ko4Da3DCH/yJGow6gtcm9p2X2b
   fJYPFazW7vAvzYKON3LdpyH5pFE00mOZ42KlMPKy6kgrC7kh08y+kiLrS
   dC3GZ0IriVw8S3+ZkGrRdZ1ITTdM8aBkj6gN60FgzR92gBuEJhLPhrCxD
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="391640571"
X-IronPort-AV: E=Sophos;i="6.04,216,1695711600"; 
   d="scan'208";a="391640571"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 07:58:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="837090201"
X-IronPort-AV: E=Sophos;i="6.04,216,1695711600"; 
   d="scan'208";a="837090201"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.123.89])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 07:58:13 -0800
Subject: [PATCH] acpi: Fix ARM32 platforms compile issue introduced by
 fw_table changes
From:   Dave Jiang <dave.jiang@intel.com>
To:     linus.walleij@linaro.org, rafael@kernel.org
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, lenb@kernel.org,
        robert.moore@intel.com, Jonathan.Cameron@huawei.com,
        dan.j.williams@intel.com, guohanjun@huawei.com, arnd@arndb.de,
        linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Date:   Tue, 21 Nov 2023 08:58:12 -0700
Message-ID: <170058229266.2356592.11579977558324549374.stgit@djiang5-mobl3>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus reported that:
After commit a103f46633fd the kernel stopped compiling for
several ARM32 platforms that I am building with a bare metal
compiler. Bare metal compilers (arm-none-eabi-) don't
define __linux__.

This is because the header <acpi/platform/acenv.h> is now
in the include path for <linux/irq.h>:

  CC      arch/arm/kernel/irq.o
  CC      kernel/sysctl.o
  CC      crypto/api.o
In file included from ../include/acpi/acpi.h:22,
                 from ../include/linux/fw_table.h:29,
                 from ../include/linux/acpi.h:18,
                 from ../include/linux/irqchip.h:14,
                 from ../arch/arm/kernel/irq.c:25:
../include/acpi/platform/acenv.h:218:2: error: #error Unknown target environment
  218 | #error Unknown target environment
      |  ^~~~~

The issue is caused by the introducing of splitting out the ACPI code to
support the new generic fw_table code.

Rafael suggested moving the fw_table.h include in linux/acpi.h to below
the asm/acpi.h. The move also helped with eliminating the inclusion of
acpi/acpi.h in fw_table.h. The unfortunate circular inclusion of
linux/acpi.h is needed for fw_table.h due fw_table code needing the
defined acpi structs in order to build.

Fixes: a103f46633fd ("acpi: Move common tables helper functions to common lib")
Reported-by: Linus Walleij <linus.walleij@linaro.org>
Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 include/linux/acpi.h     |   23 ++++++++++++-----------
 include/linux/fw_table.h |    1 -
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 54189e0e5f41..2789beb26138 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -15,7 +15,6 @@
 #include <linux/mod_devicetable.h>
 #include <linux/property.h>
 #include <linux/uuid.h>
-#include <linux/fw_table.h>
 
 struct irq_domain;
 struct irq_domain_ops;
@@ -25,16 +24,6 @@ struct irq_domain_ops;
 #endif
 #include <acpi/acpi.h>
 
-#ifdef CONFIG_ACPI_TABLE_LIB
-#define EXPORT_SYMBOL_ACPI_LIB(x) EXPORT_SYMBOL_NS_GPL(x, ACPI)
-#define __init_or_acpilib
-#define __initdata_or_acpilib
-#else
-#define EXPORT_SYMBOL_ACPI_LIB(x)
-#define __init_or_acpilib __init
-#define __initdata_or_acpilib __initdata
-#endif
-
 #ifdef	CONFIG_ACPI
 
 #include <linux/list.h>
@@ -48,6 +37,18 @@ struct irq_domain_ops;
 #include <acpi/acpi_io.h>
 #include <asm/acpi.h>
 
+#include <linux/fw_table.h>
+
+#ifdef CONFIG_ACPI_TABLE_LIB
+#define EXPORT_SYMBOL_ACPI_LIB(x) EXPORT_SYMBOL_NS_GPL(x, ACPI)
+#define __init_or_acpilib
+#define __initdata_or_acpilib
+#else
+#define EXPORT_SYMBOL_ACPI_LIB(x)
+#define __init_or_acpilib __init
+#define __initdata_or_acpilib __initdata
+#endif
+
 static inline acpi_handle acpi_device_handle(struct acpi_device *adev)
 {
 	return adev ? adev->handle : NULL;
diff --git a/include/linux/fw_table.h b/include/linux/fw_table.h
index ff8fa58d5818..a722300c215b 100644
--- a/include/linux/fw_table.h
+++ b/include/linux/fw_table.h
@@ -26,7 +26,6 @@ struct acpi_subtable_proc {
 };
 
 #include <linux/acpi.h>
-#include <acpi/acpi.h>
 
 union acpi_subtable_headers {
 	struct acpi_subtable_header common;


