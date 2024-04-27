Return-Path: <linux-kernel+bounces-161108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB2818B4739
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 19:06:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1774A1C210BB
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 17:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6BA814291B;
	Sat, 27 Apr 2024 17:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jayf9poS"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8403D1C17
	for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2024 17:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714237603; cv=none; b=qXpkfSroc2M31VhdnnB3oIdssFfTzXvfu8VT5SntviyfaYqCQvDRGJwKu6LL3w/nPENJFcaxjEwnfZdVtM4GdtEm/YstsyHRmgyVtnV01oa8h688LB3my8XVOjQDg8wMu8nUd4Rqbh26AVJ/kd+20d1VeMRI4k3tFbWxTlqvn1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714237603; c=relaxed/simple;
	bh=IKwboz6unkUuaspdbL5m2QJO18HfYn+ShzYqre7Wt1I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n6tc9yefVwev8FWeeYbRbyN9EwG8KIFge7CRMlNlbu49zO8j3fkl6LUyBZxP0Z9m21S1hEz8RSLlG071faeX7g75Fkj12ZUM5mdR6RlgLGf6NiWqVrK4lvS085Ly5OkDmQEgRqs27q8vpMQ2npIWReoXIbTA/UFQnQiiAbfO44g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jayf9poS; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714237603; x=1745773603;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IKwboz6unkUuaspdbL5m2QJO18HfYn+ShzYqre7Wt1I=;
  b=jayf9poSUjDvEOuQDc0PJhkgIQDdBlxbteq6PQyGCOfi0kh+C/gP+tS+
   uBWThkZDf9NqRiTV6yCRM8EzQ5150dRhWRKlnVAREnyujkH6Zu0qq8r5l
   moHkK3TmaxxEaB5My+H7/12oaIgVoVqUM7S5oVIx5YYXoNWqWWe+sGnak
   hpIr6mQZT56FsP5japADoBKdu1eWaidh64an6lUOGJCKG0ppxkCQ1hfZJ
   YE7blVx4R/SQ75s3FqjmTv1kUFvMwV5f2aa6LBt/Vv2c5Nggt3prFqtWr
   7osCIlyc8cBEzZjIQSJ3t7R/lZmliBWj+ZTyl/0dEstwHvL5Xmhpjr47R
   Q==;
X-CSE-ConnectionGUID: TfVDSxU5THauvc4Zxikhwg==
X-CSE-MsgGUID: oQKOSYLvRuqu2xq8+rEZxQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11057"; a="10063540"
X-IronPort-AV: E=Sophos;i="6.07,235,1708416000"; 
   d="scan'208";a="10063540"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2024 10:06:42 -0700
X-CSE-ConnectionGUID: CF+2/vVlQgucut3jhAcIUQ==
X-CSE-MsgGUID: b/odNh/XTVue/enrZ7AJgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,235,1708416000"; 
   d="scan'208";a="25780516"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa010.fm.intel.com with ESMTP; 27 Apr 2024 10:06:37 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 023C8118; Sat, 27 Apr 2024 20:06:35 +0300 (EEST)
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: bp@alien8.de
Cc: adrian.hunter@intel.com,
	ashish.kalra@amd.com,
	bhe@redhat.com,
	dave.hansen@linux.intel.com,
	elena.reshetova@intel.com,
	jun.nakajima@intel.com,
	kai.huang@intel.com,
	kexec@lists.infradead.org,
	kirill.shutemov@linux.intel.com,
	linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	ltao@redhat.com,
	mingo@redhat.com,
	nik.borisov@suse.com,
	peterz@infradead.org,
	rafael@kernel.org,
	rick.p.edgecombe@intel.com,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	seanjc@google.com,
	tglx@linutronix.de,
	thomas.lendacky@amd.com,
	x86@kernel.org
Subject: [PATCHv10.1 09/18] x86/mm: Adding callbacks to prepare encrypted memory for kexec
Date: Sat, 27 Apr 2024 20:06:34 +0300
Message-ID: <20240427170634.2397725-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240427164747.GCZi0sM6HBCBYtgWqF@fat_crate.local>
References: <20240427164747.GCZi0sM6HBCBYtgWqF@fat_crate.local>
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
Reviewed-by: Kai Huang <kai.huang@intel.com>
Tested-by: Tao Liu <ltao@redhat.com>
---
 arch/x86/include/asm/x86_init.h |  2 ++
 arch/x86/kernel/crash.c         |  4 ++++
 arch/x86/kernel/reboot.c        | 12 ++++++++++++
 arch/x86/kernel/x86_init.c      |  4 ++++
 4 files changed, 22 insertions(+)

diff --git a/arch/x86/include/asm/x86_init.h b/arch/x86/include/asm/x86_init.h
index 28ac3cb9b987..c731e6bc4343 100644
--- a/arch/x86/include/asm/x86_init.h
+++ b/arch/x86/include/asm/x86_init.h
@@ -155,6 +155,8 @@ struct x86_guest {
 	int (*enc_status_change_finish)(unsigned long vaddr, int npages, bool enc);
 	bool (*enc_tlb_flush_required)(bool enc);
 	bool (*enc_cache_flush_required)(void);
+	void (*enc_kexec_stop_conversion)(bool crash);
+	void (*enc_kexec_unshare_mem)(void);
 };
 
 /**
diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index e74d0c4286c1..f1b261be78b4 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -128,6 +128,10 @@ void native_machine_crash_shutdown(struct pt_regs *regs)
 #ifdef CONFIG_HPET_TIMER
 	hpet_disable();
 #endif
+
+	x86_platform.guest.enc_kexec_stop_conversion(true);
+	x86_platform.guest.enc_kexec_unshare_mem();
+
 	crash_save_cpu(regs, safe_smp_processor_id());
 }
 
diff --git a/arch/x86/kernel/reboot.c b/arch/x86/kernel/reboot.c
index f3130f762784..c1920ec34f0c 100644
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
+	if (kexec_in_progress)
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
+	if (kexec_in_progress)
+		x86_platform.guest.enc_kexec_unshare_mem();
 }
 
 static void __machine_emergency_restart(int emergency)
diff --git a/arch/x86/kernel/x86_init.c b/arch/x86/kernel/x86_init.c
index a7143bb7dd93..045ce1c70070 100644
--- a/arch/x86/kernel/x86_init.c
+++ b/arch/x86/kernel/x86_init.c
@@ -138,6 +138,8 @@ static int enc_status_change_prepare_noop(unsigned long vaddr, int npages, bool
 static int enc_status_change_finish_noop(unsigned long vaddr, int npages, bool enc) { return 0; }
 static bool enc_tlb_flush_required_noop(bool enc) { return false; }
 static bool enc_cache_flush_required_noop(void) { return false; }
+static void enc_kexec_stop_conversion_noop(bool crash) {}
+static void enc_kexec_unshare_mem_noop(void) {}
 static bool is_private_mmio_noop(u64 addr) {return false; }
 
 struct x86_platform_ops x86_platform __ro_after_init = {
@@ -161,6 +163,8 @@ struct x86_platform_ops x86_platform __ro_after_init = {
 		.enc_status_change_finish  = enc_status_change_finish_noop,
 		.enc_tlb_flush_required	   = enc_tlb_flush_required_noop,
 		.enc_cache_flush_required  = enc_cache_flush_required_noop,
+		.enc_kexec_stop_conversion = enc_kexec_stop_conversion_noop,
+		.enc_kexec_unshare_mem     = enc_kexec_unshare_mem_noop,
 	},
 };
 
-- 
2.43.0


