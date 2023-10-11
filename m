Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 373627C4B13
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 08:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344701AbjJKG7V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 02:59:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344673AbjJKG7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 02:59:18 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC3799D;
        Tue, 10 Oct 2023 23:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697007556; x=1728543556;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Z7DuwbKP2JlGat4MgUygBBMWlk5dE2zreO/8FfAAWdc=;
  b=eeAnTNuxC69zdme2Q1AHC43LRc4tDJRJ+Z+5kGI6elv8efClBBkK7fwp
   1iSEu0xy+UlagREjtGEDbJscJTxbGkWCYH9vrGL0lAUTeskGNrVmbI4Jy
   9kna/7SsXOyHPPDXuXIPtE4A1Vw1FUmvUkPmhU84wVbd3QYXS9mRQJXVx
   kULNtl45L4a8yLc+4RHWgZeJjTZkZhyVx9vpFNHRIMINECNK2JpPs58wJ
   2TNgR+kQJm8dBPn+EgUNlUudT3Vxl/hoJ+R2LlMnk/7y6eb8/p6ZSWpYR
   sh4HKZQnB8Iv6I847ErMDezIXZtYHqtryYB3TukK0IrhAFqngO9F5LmLm
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="364879647"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="364879647"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 23:59:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="703617236"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="703617236"
Received: from laptop-dan-intel.ccr.corp.intel.com (HELO box.shutemov.name) ([10.252.56.166])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 23:59:07 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id A23BB10A1A3; Wed, 11 Oct 2023 09:58:56 +0300 (+03)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Fei Yang <fei.yang@intel.com>, stable@vger.kernel.org
Subject: [PATCHv2] x86/alternatives: Disable KASAN in apply_alternatives()
Date:   Wed, 11 Oct 2023 09:58:49 +0300
Message-ID: <20231011065849.19075-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fei has reported that KASAN triggers during apply_alternatives() on
5-level paging machine:

	BUG: KASAN: out-of-bounds in rcu_is_watching (./arch/x86/include/asm/atomic.h:23 ./include/linux/atomic/atomic-arch-fallback.h:444 ./include/linux/context_tracking.h:122 kernel/rcu/tree.c:699)
	Read of size 4 at addr ff110003ee6419a0 by task swapper/0/0

	CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.6.0-rc5 #12
	Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
	Call Trace:
	<TASK>
	dump_stack_lvl (lib/dump_stack.c:107)
	print_report (mm/kasan/report.c:365 mm/kasan/report.c:475)
	? __phys_addr (arch/x86/mm/physaddr.h:7 arch/x86/mm/physaddr.c:28)
	? kasan_addr_to_slab (./include/linux/mm.h:1265 (discriminator 1) mm/kasan/../slab.h:213 (discriminator 1) mm/kasan/common.c:36 (discriminator 1))
	kasan_report (mm/kasan/report.c:590)
	? rcu_is_watching (./arch/x86/include/asm/atomic.h:23 ./include/linux/atomic/atomic-arch-fallback.h:444 ./include/linux/context_tracking.h:122 kernel/rcu/tree.c:699)
	? rcu_is_watching (./arch/x86/include/asm/atomic.h:23 ./include/linux/atomic/atomic-arch-fallback.h:444 ./include/linux/context_tracking.h:122 kernel/rcu/tree.c:699)
	? apply_alternatives (arch/x86/kernel/alternative.c:415 (discriminator 1))
	__asan_load4 (mm/kasan/generic.c:259)
	rcu_is_watching (./arch/x86/include/asm/atomic.h:23 ./include/linux/atomic/atomic-arch-fallback.h:444 ./include/linux/context_tracking.h:122 kernel/rcu/tree.c:699)
	? text_poke_early (./arch/x86/include/asm/irqflags.h:42 ./arch/x86/include/asm/irqflags.h:77 ./arch/x86/include/asm/irqflags.h:135 arch/x86/kernel/alternative.c:1675)
	trace_hardirqs_on (./include/trace/events/preemptirq.h:40 (discriminator 2) ./include/trace/events/preemptirq.h:40 (discriminator 2) kernel/trace/trace_preemptirq.c:56 (discriminator 2))
	? __asan_load4 (./arch/x86/include/asm/cpufeature.h:171 mm/kasan/kasan.h:306 mm/kasan/generic.c:175 mm/kasan/generic.c:259)
	text_poke_early (./arch/x86/include/asm/irqflags.h:42 ./arch/x86/include/asm/irqflags.h:77 ./arch/x86/include/asm/irqflags.h:135 arch/x86/kernel/alternative.c:1675)
	apply_alternatives (arch/x86/kernel/alternative.c:415 (discriminator 1))
	? __asan_load4 (./arch/x86/include/asm/cpufeature.h:171 mm/kasan/kasan.h:306 mm/kasan/generic.c:175 mm/kasan/generic.c:259)
	? __pfx_apply_alternatives (arch/x86/kernel/alternative.c:400)
	? __pfx_apply_returns (arch/x86/kernel/alternative.c:720)
	? __this_cpu_preempt_check (lib/smp_processor_id.c:67)
	? _sub_I_65535_1 (init/main.c:1573)
	? int3_selftest_ip (arch/x86/kernel/alternative.c:1496)
	? __pfx_int3_selftest (arch/x86/kernel/alternative.c:1496)
	? lockdep_hardirqs_on (kernel/locking/lockdep.c:4422)
	? fpu__init_cpu_generic (./arch/x86/include/asm/irqflags.h:42 ./arch/x86/include/asm/irqflags.h:77 ./arch/x86/include/asm/irqflags.h:135 ./arch/x86/include/asm/tlbflush.h:47 arch/x86/kernel/fpu/init.c:30)
	alternative_instructions (arch/x86/kernel/alternative.c:1618)
	arch_cpu_finalize_init (arch/x86/kernel/cpu/common.c:2404)
	start_kernel (init/main.c:1037)
	x86_64_start_reservations (arch/x86/kernel/head64.c:544)
	x86_64_start_kernel (arch/x86/kernel/head64.c:486 (discriminator 5))
	secondary_startup_64_no_verify (arch/x86/kernel/head_64.S:433)
	</TASK>

	The buggy address belongs to the physical page:
	page:(____ptrval____) refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x3ee641
	flags: 0x20000000004000(reserved|node=0|zone=2)
	page_type: 0xffffffff()
	raw: 0020000000004000 ffd400000fb99048 ffd400000fb99048 0000000000000000
	raw: 0000000000000000 0000000000000000 00000001ffffffff 0000000000000000
	page dumped because: kasan: bad access detected

	Memory state around the buggy address:
	ff110003ee641880: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	ff110003ee641900: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	>ff110003ee641980: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	^
	ff110003ee641a00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	ff110003ee641a80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

On machines with 5-level paging, cpu_feature_enabled(X86_FEATURE_LA57)
got patched. It includes KASAN code, where KASAN_SHADOW_START depends on
__VIRTUAL_MASK_SHIFT, which is defined with the cpu_feature_enabled().

KASAN gets confused when apply_alternatives() patches the
KASAN_SHADOW_START users. A test patch that makes KASAN_SHADOW_START
static, by replacing __VIRTUAL_MASK_SHIFT with 56, fixes the issue.

Disable KASAN while kernel patches alternatives.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reported-by: Fei Yang <fei.yang@intel.com>
Fixes: 6657fca06e3f ("x86/mm: Allow to boot without LA57 if CONFIG_X86_5LEVEL=y")
Cc: stable@vger.kernel.org
---

 v2:
  - Move kasan_disable/_enable_current() to cover whole loop, not only
    text_poke_early();
  - Adjust commit message.

---
 arch/x86/kernel/alternative.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 517ee01503be..b4cc4d7c0825 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -403,6 +403,17 @@ void __init_or_module noinline apply_alternatives(struct alt_instr *start,
 	u8 insn_buff[MAX_PATCH_LEN];
 
 	DPRINTK(ALT, "alt table %px, -> %px", start, end);
+
+	/*
+	 * In the case CONFIG_X86_5LEVEL=y, KASAN_SHADOW_START is defined using
+	 * cpu_feature_enabled(X86_FEATURE_LA57) and is therefore patched here.
+	 * During the process, KASAN becomes confused and triggers
+	 * a false-positive out-of-bound report.
+	 *
+	 * Disable KASAN until the patching is complete.
+	 */
+	kasan_disable_current();
+
 	/*
 	 * The scan order should be from start to end. A later scanned
 	 * alternative code can overwrite previously scanned alternative code.
@@ -452,6 +463,8 @@ void __init_or_module noinline apply_alternatives(struct alt_instr *start,
 
 		text_poke_early(instr, insn_buff, insn_buff_sz);
 	}
+
+	kasan_enable_current();
 }
 
 static inline bool is_jcc32(struct insn *insn)
-- 
2.41.0

