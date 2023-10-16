Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28FD67CAA68
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 15:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233539AbjJPNt4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 09:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234084AbjJPNsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 09:48:40 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ABC5E8;
        Mon, 16 Oct 2023 06:48:14 -0700 (PDT)
Date:   Mon, 16 Oct 2023 13:48:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697464093;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=szJCQ1qcus8xfbAR7kQCZre3aSLpl0Tn4hJkHD45Xek=;
        b=vnQiGgu2GWXy/G9m9W0I9lZyiqVMvwVl2fnH9FtXamtA8ZVmfdHIZ1kOjP7PEIP8j0bJr2
        /DKYWMQ5TKOxdVMdFtZ3AImd3mL5JY6TU+IMTHMD2waB+slNSPIyTsJtVsEHG9Qknc+YUo
        lPijJAHVoZgt2jOEiIUhcm1lg2A3aESM68pPp4fFSx4OVRaoF7ZvwtjITiWiHOVrmdpn9B
        /1ZJpbuFKx+maZAA6LUTRPNAv8O6sgZkUn8rc7itPYXlkgddbC7Ewac96f1QrU4OXQ5vLd
        pKETAxsQPMS4fgSO5pv+iMsF0E7+2tUGC6OBMzniyFF4OG2YHrn1LU2wOCaiSA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697464093;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=szJCQ1qcus8xfbAR7kQCZre3aSLpl0Tn4hJkHD45Xek=;
        b=NqV4+y7B7c+jjFfCkRXdvCq9m8tCoatlEjsK3eiHyhSOAVSCT+rkpnYwDp9/WTO2uRTxMk
        Ti9I8AvAy5XgmGCA==
From:   "tip-bot2 for Yazen Ghannam" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] x86/mce: Cleanup mce_usable_address()
Cc:     Yazen Ghannam <yazen.ghannam@amd.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230613141142.36801-4-yazen.ghannam@amd.com>
References: <20230613141142.36801-4-yazen.ghannam@amd.com>
MIME-Version: 1.0
Message-ID: <169746409209.3135.13727023873339327084.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the ras/core branch of tip:

Commit-ID:     1bae0cfe4a171ccc5f731426296e45beafa096b8
Gitweb:        https://git.kernel.org/tip/1bae0cfe4a171ccc5f731426296e45beafa096b8
Author:        Yazen Ghannam <yazen.ghannam@amd.com>
AuthorDate:    Tue, 13 Jun 2023 09:11:42 -05:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 16 Oct 2023 15:37:01 +02:00

x86/mce: Cleanup mce_usable_address()

Move Intel-specific checks into a helper function.

Explicitly use "bool" for return type.

No functional change intended.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20230613141142.36801-4-yazen.ghannam@amd.com
---
 arch/x86/include/asm/mce.h         |  2 +-
 arch/x86/kernel/cpu/mce/core.c     | 33 ++++++++---------------------
 arch/x86/kernel/cpu/mce/intel.c    | 20 ++++++++++++++++++-
 arch/x86/kernel/cpu/mce/internal.h |  2 ++-
 4 files changed, 33 insertions(+), 24 deletions(-)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index 180b1cb..6de6e1d 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -245,7 +245,7 @@ static inline void cmci_recheck(void) {}
 int mce_available(struct cpuinfo_x86 *c);
 bool mce_is_memory_error(struct mce *m);
 bool mce_is_correctable(struct mce *m);
-int mce_usable_address(struct mce *m);
+bool mce_usable_address(struct mce *m);
 
 DECLARE_PER_CPU(unsigned, mce_exception_count);
 DECLARE_PER_CPU(unsigned, mce_poll_count);
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 06c21f5..0214d42 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -453,35 +453,22 @@ static void mce_irq_work_cb(struct irq_work *entry)
 	mce_schedule_work();
 }
 
-/*
- * Check if the address reported by the CPU is in a format we can parse.
- * It would be possible to add code for most other cases, but all would
- * be somewhat complicated (e.g. segment offset would require an instruction
- * parser). So only support physical addresses up to page granularity for now.
- */
-int mce_usable_address(struct mce *m)
+bool mce_usable_address(struct mce *m)
 {
 	if (!(m->status & MCI_STATUS_ADDRV))
-		return 0;
+		return false;
 
-	if (m->cpuvendor == X86_VENDOR_AMD)
+	switch (m->cpuvendor) {
+	case X86_VENDOR_AMD:
 		return amd_mce_usable_address(m);
 
-	/* Checks after this one are Intel/Zhaoxin-specific: */
-	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL &&
-	    boot_cpu_data.x86_vendor != X86_VENDOR_ZHAOXIN)
-		return 1;
-
-	if (!(m->status & MCI_STATUS_MISCV))
-		return 0;
-
-	if (MCI_MISC_ADDR_LSB(m->misc) > PAGE_SHIFT)
-		return 0;
-
-	if (MCI_MISC_ADDR_MODE(m->misc) != MCI_MISC_ADDR_PHYS)
-		return 0;
+	case X86_VENDOR_INTEL:
+	case X86_VENDOR_ZHAOXIN:
+		return intel_mce_usable_address(m);
 
-	return 1;
+	default:
+		return true;
+	}
 }
 EXPORT_SYMBOL_GPL(mce_usable_address);
 
diff --git a/arch/x86/kernel/cpu/mce/intel.c b/arch/x86/kernel/cpu/mce/intel.c
index f532355..52bce53 100644
--- a/arch/x86/kernel/cpu/mce/intel.c
+++ b/arch/x86/kernel/cpu/mce/intel.c
@@ -536,3 +536,23 @@ bool intel_filter_mce(struct mce *m)
 
 	return false;
 }
+
+/*
+ * Check if the address reported by the CPU is in a format we can parse.
+ * It would be possible to add code for most other cases, but all would
+ * be somewhat complicated (e.g. segment offset would require an instruction
+ * parser). So only support physical addresses up to page granularity for now.
+ */
+bool intel_mce_usable_address(struct mce *m)
+{
+	if (!(m->status & MCI_STATUS_MISCV))
+		return false;
+
+	if (MCI_MISC_ADDR_LSB(m->misc) > PAGE_SHIFT)
+		return false;
+
+	if (MCI_MISC_ADDR_MODE(m->misc) != MCI_MISC_ADDR_PHYS)
+		return false;
+
+	return true;
+}
diff --git a/arch/x86/kernel/cpu/mce/internal.h b/arch/x86/kernel/cpu/mce/internal.h
index a191554..e13a26c 100644
--- a/arch/x86/kernel/cpu/mce/internal.h
+++ b/arch/x86/kernel/cpu/mce/internal.h
@@ -49,6 +49,7 @@ void intel_init_cmci(void);
 void intel_init_lmce(void);
 void intel_clear_lmce(void);
 bool intel_filter_mce(struct mce *m);
+bool intel_mce_usable_address(struct mce *m);
 #else
 # define cmci_intel_adjust_timer mce_adjust_timer_default
 static inline bool mce_intel_cmci_poll(void) { return false; }
@@ -58,6 +59,7 @@ static inline void intel_init_cmci(void) { }
 static inline void intel_init_lmce(void) { }
 static inline void intel_clear_lmce(void) { }
 static inline bool intel_filter_mce(struct mce *m) { return false; }
+static inline bool intel_mce_usable_address(struct mce *m) { return false; }
 #endif
 
 void mce_timer_kick(unsigned long interval);
