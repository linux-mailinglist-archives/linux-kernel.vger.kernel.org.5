Return-Path: <linux-kernel+bounces-84039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47FA786A1A1
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 22:26:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC102290FBF
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 21:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D0874EB49;
	Tue, 27 Feb 2024 21:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kufmpG25"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160F214F995
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 21:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709069113; cv=none; b=rB3EtkcW0DqCWwaxg3FjGm+IllhWCkTBpsGay/dsjntmIrXNQUrLvXAU0YvEOVKlCm3sCJ6v8Q7+0AiuoHmzIlJizK7YuFXzsZGXhOl3R5N0zz1WI+8M7rVu3Vjf4/0J+umQYQLQpmzF9Jj3VoryW0GchISvlFkwNsYKNmJNDV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709069113; c=relaxed/simple;
	bh=zY37V7XVErjfFCm2UB1xv4FpFUFrbRduDqjfiU5sWzE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BhMfu+EQYmTKPK6Wa3z2firQeMDeXihqhW2fESbmat0i8Bb91jNY5SNj4Y3NhlCgfUw5ToogLwuiB99HNWbaZC7QhYbrTJFFvABGucWk+A8tlHenNxvQD7z76gpKxCHP6h1vHW8oOXSwQpBN0iEHGdlaslJacrH7gv33TABuT0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kufmpG25; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709069112; x=1740605112;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zY37V7XVErjfFCm2UB1xv4FpFUFrbRduDqjfiU5sWzE=;
  b=kufmpG25CNxIGiYHepu/r/eRVqmVApzDcp8w5Zc4yMMf9EcD0yMJw1ww
   iOXGSW27LhSvFQBVRnFGCwZbXx9i4xsWS0mx89B60DFW5H3vUtYOxeyoJ
   wlKdEvgLThBC/UnOVDJHCE5h8WornOxeJX/TanUXDIh8SUFusPegVJskg
   P8r4e7wakeEldFm8r+memWtbFOWOTO2Y9OrLczx7JB4PyvrsoSxeUx97t
   eUVbYcbZDACSw6PE6947f0VC8nOE8g3264+fXVDLJxMhDs+gk71YETP9X
   HSdFL5XPaZ9ca3VLl0mdnPFbNBSsyiW3DFR27CT6DIFm2jXdHW5mE0X6a
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="3567041"
X-IronPort-AV: E=Sophos;i="6.06,188,1705392000"; 
   d="scan'208";a="3567041"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 13:25:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="937032908"
X-IronPort-AV: E=Sophos;i="6.06,188,1705392000"; 
   d="scan'208";a="937032908"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 27 Feb 2024 13:25:02 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 5921C9AD; Tue, 27 Feb 2024 23:24:56 +0200 (EET)
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Elena Reshetova <elena.reshetova@intel.com>,
	Jun Nakajima <jun.nakajima@intel.com>,
	Rick Edgecombe  <rick.p.edgecombe@intel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	"Kalra, Ashish" <ashish.kalra@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	"Huang, Kai" <kai.huang@intel.com>,
	Baoquan He <bhe@redhat.com>,
	kexec@lists.infradead.org,
	linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>
Subject: [PATCHv8 09/17] x86/mm: Adding callbacks to prepare encrypted memory for kexec
Date: Tue, 27 Feb 2024 23:24:44 +0200
Message-ID: <20240227212452.3228893-10-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240227212452.3228893-1-kirill.shutemov@linux.intel.com>
References: <20240227212452.3228893-1-kirill.shutemov@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

AMD SEV and Intel TDX guests allocate shared buffers for performing I/O.
This is done by allocating pages normally from the buddy allocator and
then converting them to shared using set_memory_decrypted().

On kexec, the second kernel is unaware of which memory has been
converted in this manner. It only sees E820_TYPE_RAM. Accessing shared
memory as private is fatal.

Therefore, the memory state must be reset to its original state before
starting the new kernel with kexec.

The process of converting shared memory back to private occurs in two
steps:

- enc_kexec_stop_conversion() stops new conversions.

- enc_kexec_unshare_mem() unshares all existing shared memory, reverting
  it back to private.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>x
---
 arch/x86/include/asm/x86_init.h |  2 ++
 arch/x86/kernel/crash.c         |  6 ++++++
 arch/x86/kernel/reboot.c        | 12 ++++++++++++
 arch/x86/kernel/x86_init.c      |  4 ++++
 4 files changed, 24 insertions(+)

diff --git a/arch/x86/include/asm/x86_init.h b/arch/x86/include/asm/x86_init.h
index 17104ebab359..b4e4c2d7f967 100644
--- a/arch/x86/include/asm/x86_init.h
+++ b/arch/x86/include/asm/x86_init.h
@@ -152,6 +152,8 @@ struct x86_guest {
 	int (*enc_status_change_finish)(unsigned long vaddr, int npages, bool enc);
 	bool (*enc_tlb_flush_required)(bool enc);
 	bool (*enc_cache_flush_required)(void);
+	void (*enc_kexec_stop_conversion)(bool crash);
+	void (*enc_kexec_unshare_mem)(void);
 };
 
 /**
diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index e74d0c4286c1..7a1560d7e62d 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -128,6 +128,12 @@ void native_machine_crash_shutdown(struct pt_regs *regs)
 #ifdef CONFIG_HPET_TIMER
 	hpet_disable();
 #endif
+
+	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT)) {
+		x86_platform.guest.enc_kexec_stop_conversion(true);
+		x86_platform.guest.enc_kexec_unshare_mem();
+	}
+
 	crash_save_cpu(regs, safe_smp_processor_id());
 }
 
diff --git a/arch/x86/kernel/reboot.c b/arch/x86/kernel/reboot.c
index 830425e6d38e..0574d4ad6b41 100644
--- a/arch/x86/kernel/reboot.c
+++ b/arch/x86/kernel/reboot.c
@@ -12,6 +12,7 @@
 #include <linux/delay.h>
 #include <linux/objtool.h>
 #include <linux/pgtable.h>
+#include <linux/kexec.h>
 #include <acpi/reboot.h>
 #include <asm/io.h>
 #include <asm/apic.h>
@@ -716,6 +717,14 @@ static void native_machine_emergency_restart(void)
 
 void native_machine_shutdown(void)
 {
+	/*
+	 * Call enc_kexec_stop_conversion() while all CPUs are still active and
+	 * interrupts are enabled. This will allow all in-flight memory
+	 * conversions to finish cleanly.
+	 */
+	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT) && kexec_in_progress)
+		x86_platform.guest.enc_kexec_stop_conversion(false);
+
 	/* Stop the cpus and apics */
 #ifdef CONFIG_X86_IO_APIC
 	/*
@@ -752,6 +761,9 @@ void native_machine_shutdown(void)
 #ifdef CONFIG_X86_64
 	x86_platform.iommu_shutdown();
 #endif
+
+	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT) && kexec_in_progress)
+		x86_platform.guest.enc_kexec_unshare_mem();
 }
 
 static void __machine_emergency_restart(int emergency)
diff --git a/arch/x86/kernel/x86_init.c b/arch/x86/kernel/x86_init.c
index f0f54e109eb9..b95206ebc621 100644
--- a/arch/x86/kernel/x86_init.c
+++ b/arch/x86/kernel/x86_init.c
@@ -135,6 +135,8 @@ static int enc_status_change_prepare_noop(unsigned long vaddr, int npages, bool
 static int enc_status_change_finish_noop(unsigned long vaddr, int npages, bool enc) { return 0; }
 static bool enc_tlb_flush_required_noop(bool enc) { return false; }
 static bool enc_cache_flush_required_noop(void) { return false; }
+static void enc_kexec_stop_conversion_noop(bool crash) {}
+static void enc_kexec_unshare_mem_noop(void) {}
 static bool is_private_mmio_noop(u64 addr) {return false; }
 
 struct x86_platform_ops x86_platform __ro_after_init = {
@@ -158,6 +160,8 @@ struct x86_platform_ops x86_platform __ro_after_init = {
 		.enc_status_change_finish  = enc_status_change_finish_noop,
 		.enc_tlb_flush_required	   = enc_tlb_flush_required_noop,
 		.enc_cache_flush_required  = enc_cache_flush_required_noop,
+		.enc_kexec_stop_conversion = enc_kexec_stop_conversion_noop,
+		.enc_kexec_unshare_mem     = enc_kexec_unshare_mem_noop,
 	},
 };
 
-- 
2.43.0


