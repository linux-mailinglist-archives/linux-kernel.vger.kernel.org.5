Return-Path: <linux-kernel+bounces-68968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46CF68582C0
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 17:39:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C85191F22F34
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 16:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B2C9130AC9;
	Fri, 16 Feb 2024 16:39:07 +0000 (UTC)
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E3912F39F;
	Fri, 16 Feb 2024 16:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708101546; cv=none; b=ei3GV/wuSyCINruwAfcpvFPkL7xSzKioG8Y3N8i8sglJuFhyYn6WF4PosFEVZK5F1ABzG4BjbgYHer+39AGpFl9urNr1Y110WLVyG/mxWnFhyu+8VWZ+1oPcNF2kPuFdAZXjyj1x65GS8LVDxzKm6lxCeEwBjVEPkHsoaW5bVsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708101546; c=relaxed/simple;
	bh=+KTMLkdPFJiKDVrsuATH5yBercsEKRSKg8auKDtRABE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NQmIq3ihcFZhdCOJQsEwniZGp3vK0L447fgX1vYOq4LDOcyhuG0xevaJGvOAFMsrPVwo9xOLd6Bxa+3nYC0vQkVb2Odz4c+fBBUe1a24Rs+dwOxwYfKm0xPvLJZEkwOcNR6KfkIQLUc5hF0AF6apGQThuZALqKN3tH+kezSBSJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.4.0)
 id 0c0b260f4d501061; Fri, 16 Feb 2024 17:38:56 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id A316F669F8B;
	Fri, 16 Feb 2024 17:38:55 +0100 (CET)
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Zhang Rui <rui.zhang@intel.com>, Kees Cook <kees@kernel.org>,
 "shiqiang.deng" <shiqiang.deng213@gmail.com>,
 Sebastian Grzywna <swiftgeek@gmail.com>, Swift Geek <swiftgeek@gmail.com>,
 Hang Zhang <zh.nvgt@gmail.com>
Subject: [PATCH v3] ACPI: Drop the custom_method debugfs interface
Date: Fri, 16 Feb 2024 17:38:55 +0100
Message-ID: <6029478.lOV4Wx5bFT@kreacher>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrvddvgdeltdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpeetgedvffethfeuteeigfefheeghfevhfduueekfeeutdfggfdttefgffetgfehvdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhsthgrtghkohhvvghrfhhlohifrdgtohhmnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepledprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegrnhgurhhihidrshhhvghvtghhvghnkhhosehlihhnuhigrdhinhht
 vghlrdgtohhmpdhrtghpthhtoheprhhuihdriihhrghnghesihhnthgvlhdrtghomhdprhgtphhtthhopehkvggvsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhhihhqihgrnhhgrdguvghnghdvudefsehgmhgrihhlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=9 Fuz1=9 Fuz2=9

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The ACPI custom_method debugfs interface is security-sensitive and
concurrent access to it is broken [1].

Moreover, the recipe for preparing a customized version of a given
control method has changed at one point due to ACPICA changes, which
has not been reflected in its documentation, so whoever used it before
has had to adapt and it had gone unnoticed for a long time.

This interface was a bad idea to start with and its implementation is
fragile at the design level.  It's been always conceptually questionable,
problematic from the security standpoint and implemented poorly.

Patches fixing its most apparent functional issues (for example, [2]) don't
actually address much of the above.

Granted, at the time it was introduced, there was no alternative, but
there is the AML debugger in the kernel now and there is the configfs
interface allowing custom ACPI tables to be loaded.  The former can be
used for extensive AML debugging and the latter can be use for testing
new AML. [3]

Accordingly, drop custom_method along with its (outdated anyway)
documentation.

Link: https://lore.kernel.org/linux-acpi/20221227063335.61474-1-zh.nvgt@gmail.com/ # [1]
https://lore.kernel.org/linux-acpi/20231111132402.4142-1-shiqiang.deng213@gmail.com/ [2]
https://stackoverflow.com/questions/62849113/how-to-unload-an-overlay-loaded-using-acpi-config-sysfs # [3]
Reported-by: Hang Zhang <zh.nvgt@gmail.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Zhang Rui <rui.zhang@intel.com>
---

v2 -> v3:
   * Update changelog.
   * Add R-by from Rui.

v1 -> v2: Update index.rst too.

---
 Documentation/firmware-guide/acpi/index.rst              |    1 
 Documentation/firmware-guide/acpi/method-customizing.rst |   89 ------------
 drivers/acpi/Kconfig                                     |   14 --
 drivers/acpi/Makefile                                    |    1 
 drivers/acpi/custom_method.c                             |  103 ---------------
 5 files changed, 208 deletions(-)

Index: linux-pm/drivers/acpi/Kconfig
===================================================================
--- linux-pm.orig/drivers/acpi/Kconfig
+++ linux-pm/drivers/acpi/Kconfig
@@ -449,20 +449,6 @@ config ACPI_HED
 	  which is used to report some hardware errors notified via
 	  SCI, mainly the corrected errors.
 
-config ACPI_CUSTOM_METHOD
-	tristate "Allow ACPI methods to be inserted/replaced at run time"
-	depends on DEBUG_FS
-	help
-	  This debug facility allows ACPI AML methods to be inserted and/or
-	  replaced without rebooting the system. For details refer to:
-	  Documentation/firmware-guide/acpi/method-customizing.rst.
-
-	  NOTE: This option is security sensitive, because it allows arbitrary
-	  kernel memory to be written to by root (uid=0) users, allowing them
-	  to bypass certain security measures (e.g. if root is not allowed to
-	  load additional kernel modules after boot, this feature may be used
-	  to override that restriction).
-
 config ACPI_BGRT
 	bool "Boottime Graphics Resource Table support"
 	depends on EFI && (X86 || ARM64)
Index: linux-pm/drivers/acpi/Makefile
===================================================================
--- linux-pm.orig/drivers/acpi/Makefile
+++ linux-pm/drivers/acpi/Makefile
@@ -101,7 +101,6 @@ obj-$(CONFIG_ACPI_SBS)		+= sbshc.o
 obj-$(CONFIG_ACPI_SBS)		+= sbs.o
 obj-$(CONFIG_ACPI_HED)		+= hed.o
 obj-$(CONFIG_ACPI_EC_DEBUGFS)	+= ec_sys.o
-obj-$(CONFIG_ACPI_CUSTOM_METHOD)+= custom_method.o
 obj-$(CONFIG_ACPI_BGRT)		+= bgrt.o
 obj-$(CONFIG_ACPI_CPPC_LIB)	+= cppc_acpi.o
 obj-$(CONFIG_ACPI_SPCR_TABLE)	+= spcr.o
Index: linux-pm/drivers/acpi/custom_method.c
===================================================================
--- linux-pm.orig/drivers/acpi/custom_method.c
+++ /dev/null
@@ -1,103 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * custom_method.c - debugfs interface for customizing ACPI control method
- */
-
-#include <linux/init.h>
-#include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/uaccess.h>
-#include <linux/debugfs.h>
-#include <linux/acpi.h>
-#include <linux/security.h>
-
-#include "internal.h"
-
-MODULE_LICENSE("GPL");
-
-static struct dentry *cm_dentry;
-
-/* /sys/kernel/debug/acpi/custom_method */
-
-static ssize_t cm_write(struct file *file, const char __user *user_buf,
-			size_t count, loff_t *ppos)
-{
-	static char *buf;
-	static u32 max_size;
-	static u32 uncopied_bytes;
-
-	struct acpi_table_header table;
-	acpi_status status;
-	int ret;
-
-	ret = security_locked_down(LOCKDOWN_ACPI_TABLES);
-	if (ret)
-		return ret;
-
-	if (!(*ppos)) {
-		/* parse the table header to get the table length */
-		if (count <= sizeof(struct acpi_table_header))
-			return -EINVAL;
-		if (copy_from_user(&table, user_buf,
-				   sizeof(struct acpi_table_header)))
-			return -EFAULT;
-		uncopied_bytes = max_size = table.length;
-		/* make sure the buf is not allocated */
-		kfree(buf);
-		buf = kzalloc(max_size, GFP_KERNEL);
-		if (!buf)
-			return -ENOMEM;
-	}
-
-	if (buf == NULL)
-		return -EINVAL;
-
-	if ((*ppos > max_size) ||
-	    (*ppos + count > max_size) ||
-	    (*ppos + count < count) ||
-	    (count > uncopied_bytes)) {
-		kfree(buf);
-		buf = NULL;
-		return -EINVAL;
-	}
-
-	if (copy_from_user(buf + (*ppos), user_buf, count)) {
-		kfree(buf);
-		buf = NULL;
-		return -EFAULT;
-	}
-
-	uncopied_bytes -= count;
-	*ppos += count;
-
-	if (!uncopied_bytes) {
-		status = acpi_install_method(buf);
-		kfree(buf);
-		buf = NULL;
-		if (ACPI_FAILURE(status))
-			return -EINVAL;
-		add_taint(TAINT_OVERRIDDEN_ACPI_TABLE, LOCKDEP_NOW_UNRELIABLE);
-	}
-
-	return count;
-}
-
-static const struct file_operations cm_fops = {
-	.write = cm_write,
-	.llseek = default_llseek,
-};
-
-static int __init acpi_custom_method_init(void)
-{
-	cm_dentry = debugfs_create_file("custom_method", S_IWUSR,
-					acpi_debugfs_dir, NULL, &cm_fops);
-	return 0;
-}
-
-static void __exit acpi_custom_method_exit(void)
-{
-	debugfs_remove(cm_dentry);
-}
-
-module_init(acpi_custom_method_init);
-module_exit(acpi_custom_method_exit);
Index: linux-pm/Documentation/firmware-guide/acpi/method-customizing.rst
===================================================================
--- linux-pm.orig/Documentation/firmware-guide/acpi/method-customizing.rst
+++ /dev/null
@@ -1,89 +0,0 @@
-.. SPDX-License-Identifier: GPL-2.0
-
-=======================================
-Linux ACPI Custom Control Method How To
-=======================================
-
-:Author: Zhang Rui <rui.zhang@intel.com>
-
-
-Linux supports customizing ACPI control methods at runtime.
-
-Users can use this to:
-
-1. override an existing method which may not work correctly,
-   or just for debugging purposes.
-2. insert a completely new method in order to create a missing
-   method such as _OFF, _ON, _STA, _INI, etc.
-
-For these cases, it is far simpler to dynamically install a single
-control method rather than override the entire DSDT, because kernel
-rebuild/reboot is not needed and test result can be got in minutes.
-
-.. note::
-
-  - Only ACPI METHOD can be overridden, any other object types like
-    "Device", "OperationRegion", are not recognized. Methods
-    declared inside scope operators are also not supported.
-
-  - The same ACPI control method can be overridden for many times,
-    and it's always the latest one that used by Linux/kernel.
-
-  - To get the ACPI debug object output (Store (AAAA, Debug)),
-    please run::
-
-      echo 1 > /sys/module/acpi/parameters/aml_debug_output
-
-
-1. override an existing method
-==============================
-a) get the ACPI table via ACPI sysfs I/F. e.g. to get the DSDT,
-   just run "cat /sys/firmware/acpi/tables/DSDT > /tmp/dsdt.dat"
-b) disassemble the table by running "iasl -d dsdt.dat".
-c) rewrite the ASL code of the method and save it in a new file,
-d) package the new file (psr.asl) to an ACPI table format.
-   Here is an example of a customized \_SB._AC._PSR method::
-
-      DefinitionBlock ("", "SSDT", 1, "", "", 0x20080715)
-      {
-         Method (\_SB_.AC._PSR, 0, NotSerialized)
-         {
-            Store ("In AC _PSR", Debug)
-            Return (ACON)
-         }
-      }
-
-   Note that the full pathname of the method in ACPI namespace
-   should be used.
-e) assemble the file to generate the AML code of the method.
-   e.g. "iasl -vw 6084 psr.asl" (psr.aml is generated as a result)
-   If parameter "-vw 6084" is not supported by your iASL compiler,
-   please try a newer version.
-f) mount debugfs by "mount -t debugfs none /sys/kernel/debug"
-g) override the old method via the debugfs by running
-   "cat /tmp/psr.aml > /sys/kernel/debug/acpi/custom_method"
-
-2. insert a new method
-======================
-This is easier than overriding an existing method.
-We just need to create the ASL code of the method we want to
-insert and then follow the step c) ~ g) in section 1.
-
-3. undo your changes
-====================
-The "undo" operation is not supported for a new inserted method
-right now, i.e. we can not remove a method currently.
-For an overridden method, in order to undo your changes, please
-save a copy of the method original ASL code in step c) section 1,
-and redo step c) ~ g) to override the method with the original one.
-
-
-.. note:: We can use a kernel with multiple custom ACPI method running,
-   But each individual write to debugfs can implement a SINGLE
-   method override. i.e. if we want to insert/override multiple
-   ACPI methods, we need to redo step c) ~ g) for multiple times.
-
-.. note:: Be aware that root can mis-use this driver to modify arbitrary
-   memory and gain additional rights, if root's privileges got
-   restricted (for example if root is not allowed to load additional
-   modules after boot).
Index: linux-pm/Documentation/firmware-guide/acpi/index.rst
===================================================================
--- linux-pm.orig/Documentation/firmware-guide/acpi/index.rst
+++ linux-pm/Documentation/firmware-guide/acpi/index.rst
@@ -14,7 +14,6 @@ ACPI Support
    dsd/phy
    enumeration
    osi
-   method-customizing
    method-tracing
    DSD-properties-rules
    debug




