Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81A8980AA67
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 18:17:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574333AbjLHRRV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 12:17:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233782AbjLHRRQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 12:17:16 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBDC810E3;
        Fri,  8 Dec 2023 09:17:21 -0800 (PST)
Date:   Fri, 08 Dec 2023 17:17:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1702055840;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=gh09TPzypnck/FA5Ej2jNvr7L9opBLDGxc+LKMUTktY=;
        b=MPEf9gM+JTTx5SqKAdS1nbMlNUvDcF6NpnFhAxqutw91vHRRtB2zu+WPpY2xG1upEO/GTv
        qipkfUh7TdmvI74P7Z3lVgvGGgCAnphs20F9EUE+XqqBQydQOE61qsm2DMJzEUIU4dunnd
        eaVwaePTghFy5U3O2BmPpkD+aSIAkRJ7gOm++6+HcD9Vgu9peAA0/2nP/altdlfYyglmXv
        iku6AOFbsUppZVfZNa9vlry96Q1ueBkhmSmyqMNDm7qcXBZoUNjC/Ewns6IHruO5cZfhGv
        uEnuuKtp9EZJcS5nXC8nZ6tJeH1AWPPvjxsr3Y1UikHyGSb92TJsaHJaTLmgYw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1702055840;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=gh09TPzypnck/FA5Ej2jNvr7L9opBLDGxc+LKMUTktY=;
        b=p6DXvwJjoKUDY970d/Xf3TrwJUsHO6KDxogRIHkkUx3GsJcrX0Cw/9nEhbK72ZtAbY6xQ1
        v2BULHNshRMWcoCw==
From:   "tip-bot2 for Kai Huang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/tdx] x86/virt/tdx: Handle TDX interaction with sleep and
 hibernation
Cc:     Kai Huang <kai.huang@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <170205583969.398.4926155283661461906.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/tdx branch of tip:

Commit-ID:     f3f6aa68640298fb966811b991c7b8efee67e181
Gitweb:        https://git.kernel.org/tip/f3f6aa68640298fb966811b991c7b8efee67e181
Author:        Kai Huang <kai.huang@intel.com>
AuthorDate:    Fri, 08 Dec 2023 09:07:36 -08:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Fri, 08 Dec 2023 09:12:46 -08:00

x86/virt/tdx: Handle TDX interaction with sleep and hibernation

TDX is incompatible with hibernation and some ACPI sleep states.
Users must disable hibernation to use TDX.  Users must also disable
TDX if they want to use ACPI S3 sleep.

This feels a bit wonky and asymmetric, but it avoids adding any new
command-line parameters for now.  It can be improved if users hate it
too much.

Long version:

TDX cannot survive from S3 and deeper states.  The hardware resets and
disables TDX completely when platform goes to S3 and deeper.  Both TDX
guests and the TDX module get destroyed permanently.

The kernel uses S3 to support suspend-to-ram, and S4 or deeper states to
support hibernation.  The kernel also maintains TDX states to track
whether it has been initialized and its metadata resource, etc.  After
resuming from S3 or hibernation, these TDX states won't be correct
anymore.

Theoretically, the kernel can do more complicated things like resetting
TDX internal states and TDX module metadata before going to S3 or
deeper, and re-initialize TDX module after resuming, etc, but there is
no way to save/restore TDX guests for now.

Until TDX supports full save and restore of TDX guests, there is no big
value to handle TDX module in suspend and hibernation alone.  To make
things simple, just choose to make TDX mutually exclusive with S3 and
hibernation.

Note the TDX module is initialized at runtime.  To avoid having to deal
with the fuss of determining TDX state at runtime, just choose TDX vs S3
and hibernation at kernel early boot.  It's a bad user experience if the
choice of TDX and S3/hibernation is done at runtime anyway, i.e., the
user can experience being able to do S3/hibernation but later becoming
unable to due to TDX being enabled.

Disable TDX in kernel early boot when hibernation support is available.
Currently there's no mechanism exposed by the hibernation code to allow
other kernel code to disable hibernation once for all.  Users that want
TDX must disable hibernation, like using hibername=no on the command
line.

Disable ACPI S3 when TDX is enabled by the BIOS.  For now the user needs
to disable TDX in the BIOS to use ACPI S3.  A new kernel command line
can be added in the future if there's a need to let user disable TDX
host via kernel command line.

Alternatively, the kernel could disable TDX when ACPI S3 is supported
and request the user to disable S3 to use TDX.  But there's no existing
kernel command line to do that, and BIOS doesn't always have an option
to disable S3.

[ dhansen: subject / changelog tweaks ]

Signed-off-by: Kai Huang <kai.huang@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/all/20231208170740.53979-16-dave.hansen%40intel.com
---
 arch/x86/virt/vmx/tdx/tdx.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index 48fb1b3..6d030f6 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -25,6 +25,8 @@
 #include <linux/align.h>
 #include <linux/sort.h>
 #include <linux/log2.h>
+#include <linux/acpi.h>
+#include <linux/suspend.h>
 #include <asm/page.h>
 #include <asm/special_insns.h>
 #include <asm/msr-index.h>
@@ -1329,6 +1331,15 @@ void __init tdx_init(void)
 		return;
 	}
 
+	/*
+	 * At this point, hibernation_available() indicates whether or
+	 * not hibernation support has been permanently disabled.
+	 */
+	if (hibernation_available()) {
+		pr_err("initialization failed: Hibernation support is enabled\n");
+		return;
+	}
+
 	err = register_memory_notifier(&tdx_memory_nb);
 	if (err) {
 		pr_err("initialization failed: register_memory_notifier() failed (%d)\n",
@@ -1336,6 +1347,11 @@ void __init tdx_init(void)
 		return;
 	}
 
+#if defined(CONFIG_ACPI) && defined(CONFIG_SUSPEND)
+	pr_info("Disable ACPI S3. Turn off TDX in the BIOS to use ACPI S3.\n");
+	acpi_suspend_lowlevel = NULL;
+#endif
+
 	/*
 	 * Just use the first TDX KeyID as the 'global KeyID' and
 	 * leave the rest for TDX guests.
