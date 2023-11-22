Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A99887F4AB0
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 16:35:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344508AbjKVPfX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 10:35:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235293AbjKVPej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 10:34:39 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A83F212D;
        Wed, 22 Nov 2023 07:34:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700667240; x=1732203240;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7Y9Z3YK8/R4dJKnxWdN1ttjo2dFNQU8UOECE2bBDFfA=;
  b=UwwmMxtgNsBqK/pdtnyIz01Z9Y75YkgPapNxa2AQJCz8YTX9yo4ZrINX
   TNLoOSvC3wgGKR73ThLeWgTOoTbuw85HSsUsY4VRYLY2ONqjb++E3bqra
   IKN2sOrl3A6Yyhczjtz5ryWYkzWfq/QBOa44uXRdYChlETmdhxsyyeN5w
   1zjA9xpBtiE/fSh4rGJSVMzOEjCnZlzn/M62iJMF6kxUY4RuvfCY/GQBs
   TfIZgMXGcsl3I4SX7R7LkYKp2Vwgo5wvZQ6H1EeRnPV1AcvVyIgDC88IX
   G8mYVngO2DsDrFo2JYuH7mDYBDt4YjyqMojUrsc9/5rZ/wZgvnPwKvzhF
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="377104703"
X-IronPort-AV: E=Sophos;i="6.04,219,1695711600"; 
   d="scan'208";a="377104703"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2023 07:33:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="770645824"
X-IronPort-AV: E=Sophos;i="6.04,219,1695711600"; 
   d="scan'208";a="770645824"
Received: from tshtalsx-mobl.gar.corp.intel.com (HELO [192.168.1.177]) ([10.213.178.236])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2023 07:33:53 -0800
Subject: [PATCH v3] acpi: Fix ARM32 platforms compile issue introduced by
 fw_table changes
From:   Dave Jiang <dave.jiang@intel.com>
To:     linus.walleij@linaro.org, rafael@kernel.org
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, lenb@kernel.org,
        robert.moore@intel.com, Jonathan.Cameron@huawei.com,
        dan.j.williams@intel.com, guohanjun@huawei.com, arnd@arndb.de,
        linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        cfsworks@gmail.com
Date:   Wed, 22 Nov 2023 08:33:53 -0700
Message-ID: <170066723324.2477261.2506149141979712937.stgit@djiang5-mobl3>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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

Rafael suggested [1] moving the fw_table.h include in linux/acpi.h to below
the linux/mutex.h. Remove the two includes in fw_table.h. Replace
linux/fw_table.h include in fw_table.c with linux/acpi.h.

Link: https://lore.kernel.org/linux-acpi/CAJZ5v0idWdJq3JSqQWLG5q+b+b=zkEdWR55rGYEoxh7R6N8kFQ@mail.gmail.com/
Fixes: a103f46633fd ("acpi: Move common tables helper functions to common lib")
Closes: https://lore.kernel.org/linux-acpi/20231114-arm-build-bug-v1-1-458745fe32a4@linaro.org/
Reported-by: Linus Walleij <linus.walleij@linaro.org>
Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Tested-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
v3:
- Drop fw_table.h in fw_table.c since acpi.h already included. (Rafael)
v2:
- Remove linux/acpi.h include as well in fw_table.h. (Sam)
---
 include/linux/acpi.h     |   22 +++++++++++-----------
 include/linux/fw_table.h |    3 ---
 lib/fw_table.c           |    2 +-
 3 files changed, 12 insertions(+), 15 deletions(-)

diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 54189e0e5f41..4db54e928b36 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -15,7 +15,6 @@
 #include <linux/mod_devicetable.h>
 #include <linux/property.h>
 #include <linux/uuid.h>
-#include <linux/fw_table.h>
 
 struct irq_domain;
 struct irq_domain_ops;
@@ -25,22 +24,13 @@ struct irq_domain_ops;
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
 #include <linux/dynamic_debug.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
+#include <linux/fw_table.h>
 
 #include <acpi/acpi_bus.h>
 #include <acpi/acpi_drivers.h>
@@ -48,6 +38,16 @@ struct irq_domain_ops;
 #include <acpi/acpi_io.h>
 #include <asm/acpi.h>
 
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
index ff8fa58d5818..ca49947f0a77 100644
--- a/include/linux/fw_table.h
+++ b/include/linux/fw_table.h
@@ -25,9 +25,6 @@ struct acpi_subtable_proc {
 	int count;
 };
 
-#include <linux/acpi.h>
-#include <acpi/acpi.h>
-
 union acpi_subtable_headers {
 	struct acpi_subtable_header common;
 	struct acpi_hmat_structure hmat;
diff --git a/lib/fw_table.c b/lib/fw_table.c
index b51f30a28e47..294df54e33b6 100644
--- a/lib/fw_table.c
+++ b/lib/fw_table.c
@@ -7,7 +7,7 @@
  *  Copyright (C) 2023 Intel Corp.
  */
 #include <linux/errno.h>
-#include <linux/fw_table.h>
+#include <linux/acpi.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/string.h>


