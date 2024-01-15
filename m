Return-Path: <linux-kernel+bounces-26608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 563D282E41A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 00:50:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 162CE1C2237E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 23:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 103401B7EF;
	Mon, 15 Jan 2024 23:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZbnkFmJ4"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D22A1B7E2
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 23:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705362641; x=1736898641;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=u5b66aWTKZMPvC75mhwFJMpFXPJkW3GacA+mBeRFwO0=;
  b=ZbnkFmJ4suYiXhrYSyzozBg3M9llk9jwO5BzsG5QT4M2VkUjUS13mez0
   FKNp2bsdx51z1aY037cex/Uet2tvPdrs+8uywbZwewA5aLhKtOxLZph+P
   HM+sA8DexClnIH/5tc6kAJ2L54Xx/TaqCrIIXc5dPF8Snuxbspj2QPjDK
   5L//0MGj1ZfYirtvPbbMFSczIUDWKaek8XEYCBarB48WeQfHPRWjpVyHP
   4pIdhhBxFrjfz+ePSp4iNH06nOTFXuY+oyUiVVP0OC6cikUq6Q9jgJpwu
   JNi7pqPCD6M/SWDQAvzkQEQRnVqnPKbZgtx3mPFaUxNBu3E0l1gpjQNv7
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10954"; a="13207397"
X-IronPort-AV: E=Sophos;i="6.04,197,1695711600"; 
   d="scan'208";a="13207397"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2024 15:50:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10954"; a="733413143"
X-IronPort-AV: E=Sophos;i="6.04,197,1695711600"; 
   d="scan'208";a="733413143"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 15 Jan 2024 15:50:34 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rPWiu-000CoW-1S;
	Mon, 15 Jan 2024 23:50:32 +0000
Date: Tue, 16 Jan 2024 07:49:52 +0800
From: kernel test robot <lkp@intel.com>
To: Byungchul Park <byungchul@sk.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: oe-kbuild-all@lists.linux.dev, kernel_team@skhynix.com,
	akpm@linux-foundation.org, ying.huang@intel.com, namit@vmware.com,
	vernhao@tencent.com, mgorman@techsingularity.net, hughd@google.com,
	willy@infradead.org, david@redhat.com, peterz@infradead.org,
	luto@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, rjgolo@gmail.com
Subject: Re: [PATCH v6 6/7] mm: Defer TLB flush by keeping both src and dst
 folios at migration
Message-ID: <202401160753.u2pxHstH-lkp@intel.com>
References: <20240115081953.2521-7-byungchul@sk.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240115081953.2521-7-byungchul@sk.com>

Hi Byungchul,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 0dd3ee31125508cd67f7e7172247f05b7fd1753a]

url:    https://github.com/intel-lab-lkp/linux/commits/Byungchul-Park/x86-tlb-Add-APIs-manipulating-tlb-batch-s-arch-data/20240115-162220
base:   0dd3ee31125508cd67f7e7172247f05b7fd1753a
patch link:    https://lore.kernel.org/r/20240115081953.2521-7-byungchul%40sk.com
patch subject: [PATCH v6 6/7] mm: Defer TLB flush by keeping both src and dst folios at migration
config: alpha-allnoconfig (https://download.01.org/0day-ci/archive/20240116/202401160753.u2pxHstH-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240116/202401160753.u2pxHstH-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401160753.u2pxHstH-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/pid_namespace.h:7,
                    from include/linux/ptrace.h:10,
                    from arch/alpha/kernel/asm-offsets.c:11:
>> include/linux/mm.h:2046:43: warning: 'struct arch_tlbflush_unmap_batch' declared inside parameter list will not be visible outside of this definition or declaration
    2046 | static inline void migrc_flush_end(struct arch_tlbflush_unmap_batch *arch) {}
         |                                           ^~~~~~~~~~~~~~~~~~~~~~~~~
   arch/alpha/kernel/asm-offsets.c:15:6: warning: no previous prototype for 'foo' [-Wmissing-prototypes]
      15 | void foo(void)
         |      ^~~
--
   In file included from arch/alpha/kernel/traps.c:13:
>> include/linux/mm.h:2046:43: warning: 'struct arch_tlbflush_unmap_batch' declared inside parameter list will not be visible outside of this definition or declaration
    2046 | static inline void migrc_flush_end(struct arch_tlbflush_unmap_batch *arch) {}
         |                                           ^~~~~~~~~~~~~~~~~~~~~~~~~
   arch/alpha/kernel/traps.c:210:1: warning: no previous prototype for 'do_entArith' [-Wmissing-prototypes]
     210 | do_entArith(unsigned long summary, unsigned long write_mask,
         | ^~~~~~~~~~~
   arch/alpha/kernel/traps.c:232:1: warning: no previous prototype for 'do_entIF' [-Wmissing-prototypes]
     232 | do_entIF(unsigned long type, struct pt_regs *regs)
         | ^~~~~~~~
   arch/alpha/kernel/traps.c:399:1: warning: no previous prototype for 'do_entDbg' [-Wmissing-prototypes]
     399 | do_entDbg(struct pt_regs *regs)
         | ^~~~~~~~~
   arch/alpha/kernel/traps.c:435:1: warning: no previous prototype for 'do_entUna' [-Wmissing-prototypes]
     435 | do_entUna(void * va, unsigned long opcode, unsigned long reg,
         | ^~~~~~~~~
   arch/alpha/kernel/traps.c:720:1: warning: no previous prototype for 'do_entUnaUser' [-Wmissing-prototypes]
     720 | do_entUnaUser(void __user * va, unsigned long opcode,
         | ^~~~~~~~~~~~~
   arch/alpha/kernel/traps.c:975:1: warning: no previous prototype for 'trap_init' [-Wmissing-prototypes]
     975 | trap_init(void)
         | ^~~~~~~~~
--
   In file included from arch/alpha/kernel/process.c:20:
>> include/linux/mm.h:2046:43: warning: 'struct arch_tlbflush_unmap_batch' declared inside parameter list will not be visible outside of this definition or declaration
    2046 | static inline void migrc_flush_end(struct arch_tlbflush_unmap_batch *arch) {}
         |                                           ^~~~~~~~~~~~~~~~~~~~~~~~~
--
   In file included from arch/alpha/include/asm/io.h:8,
                    from include/linux/io.h:13,
                    from include/linux/irq.h:20,
                    from include/asm-generic/hardirq.h:17,
                    from arch/alpha/include/asm/hardirq.h:8,
                    from include/linux/hardirq.h:11,
                    from include/linux/interrupt.h:11,
                    from include/linux/kernel_stat.h:9,
                    from arch/alpha/kernel/irq.c:17:
>> include/linux/mm.h:2046:43: warning: 'struct arch_tlbflush_unmap_batch' declared inside parameter list will not be visible outside of this definition or declaration
    2046 | static inline void migrc_flush_end(struct arch_tlbflush_unmap_batch *arch) {}
         |                                           ^~~~~~~~~~~~~~~~~~~~~~~~~
   arch/alpha/kernel/irq.c:96:1: warning: no previous prototype for 'handle_irq' [-Wmissing-prototypes]
      96 | handle_irq(int irq)
         | ^~~~~~~~~~
--
   In file included from arch/alpha/include/asm/io.h:8,
                    from include/linux/io.h:13,
                    from include/linux/irq.h:20,
                    from arch/alpha/kernel/irq_alpha.c:8:
>> include/linux/mm.h:2046:43: warning: 'struct arch_tlbflush_unmap_batch' declared inside parameter list will not be visible outside of this definition or declaration
    2046 | static inline void migrc_flush_end(struct arch_tlbflush_unmap_batch *arch) {}
         |                                           ^~~~~~~~~~~~~~~~~~~~~~~~~
   arch/alpha/kernel/irq_alpha.c:45:1: warning: no previous prototype for 'do_entInt' [-Wmissing-prototypes]
      45 | do_entInt(unsigned long type, unsigned long vector,
         | ^~~~~~~~~
--
   In file included from include/linux/pid_namespace.h:7,
                    from include/linux/ptrace.h:10,
                    from arch/alpha/kernel/signal.c:16:
>> include/linux/mm.h:2046:43: warning: 'struct arch_tlbflush_unmap_batch' declared inside parameter list will not be visible outside of this definition or declaration
    2046 | static inline void migrc_flush_end(struct arch_tlbflush_unmap_batch *arch) {}
         |                                           ^~~~~~~~~~~~~~~~~~~~~~~~~
   arch/alpha/kernel/signal.c:205:1: warning: no previous prototype for 'do_sigreturn' [-Wmissing-prototypes]
     205 | do_sigreturn(struct sigcontext __user *sc)
         | ^~~~~~~~~~~~
   arch/alpha/kernel/signal.c:233:1: warning: no previous prototype for 'do_rt_sigreturn' [-Wmissing-prototypes]
     233 | do_rt_sigreturn(struct rt_sigframe __user *frame)
         | ^~~~~~~~~~~~~~~
   arch/alpha/kernel/signal.c:523:1: warning: no previous prototype for 'do_work_pending' [-Wmissing-prototypes]
     523 | do_work_pending(struct pt_regs *regs, unsigned long thread_flags,
         | ^~~~~~~~~~~~~~~
--
   In file included from arch/alpha/kernel/ptrace.c:11:
>> include/linux/mm.h:2046:43: warning: 'struct arch_tlbflush_unmap_batch' declared inside parameter list will not be visible outside of this definition or declaration
    2046 | static inline void migrc_flush_end(struct arch_tlbflush_unmap_batch *arch) {}
         |                                           ^~~~~~~~~~~~~~~~~~~~~~~~~
   arch/alpha/kernel/ptrace.c:322:26: warning: no previous prototype for 'syscall_trace_enter' [-Wmissing-prototypes]
     322 | asmlinkage unsigned long syscall_trace_enter(void)
         |                          ^~~~~~~~~~~~~~~~~~~
   arch/alpha/kernel/ptrace.c:334:1: warning: no previous prototype for 'syscall_trace_leave' [-Wmissing-prototypes]
     334 | syscall_trace_leave(void)
         | ^~~~~~~~~~~~~~~~~~~
--
   In file included from arch/alpha/kernel/time.c:28:
>> include/linux/mm.h:2046:43: warning: 'struct arch_tlbflush_unmap_batch' declared inside parameter list will not be visible outside of this definition or declaration
    2046 | static inline void migrc_flush_end(struct arch_tlbflush_unmap_batch *arch) {}
         |                                           ^~~~~~~~~~~~~~~~~~~~~~~~~
   arch/alpha/kernel/time.c:64:6: warning: no previous prototype for 'arch_irq_work_raise' [-Wmissing-prototypes]
      64 | void arch_irq_work_raise(void)
         |      ^~~~~~~~~~~~~~~~~~~
--
   In file included from arch/alpha/include/asm/io.h:8,
                    from arch/alpha/kernel/io.c:10:
>> include/linux/mm.h:2046:43: warning: 'struct arch_tlbflush_unmap_batch' declared inside parameter list will not be visible outside of this definition or declaration
    2046 | static inline void migrc_flush_end(struct arch_tlbflush_unmap_batch *arch) {}
         |                                           ^~~~~~~~~~~~~~~~~~~~~~~~~
   arch/alpha/kernel/io.c:654:1: warning: no previous prototype for 'scr_memcpyw' [-Wmissing-prototypes]
     654 | scr_memcpyw(u16 *d, const u16 *s, unsigned int count)
         | ^~~~~~~~~~~
--
   In file included from arch/alpha/include/asm/io.h:8,
                    from include/linux/io.h:13,
                    from include/linux/irq.h:20,
                    from include/asm-generic/hardirq.h:17,
                    from arch/alpha/include/asm/hardirq.h:8,
                    from include/linux/hardirq.h:11,
                    from include/linux/interrupt.h:11,
                    from include/linux/pci.h:38,
                    from arch/alpha/kernel/pci.c:17:
>> include/linux/mm.h:2046:43: warning: 'struct arch_tlbflush_unmap_batch' declared inside parameter list will not be visible outside of this definition or declaration
    2046 | static inline void migrc_flush_end(struct arch_tlbflush_unmap_batch *arch) {}
         |                                           ^~~~~~~~~~~~~~~~~~~~~~~~~
   arch/alpha/kernel/pci.c:285:1: warning: no previous prototype for 'pcibios_claim_one_bus' [-Wmissing-prototypes]
     285 | pcibios_claim_one_bus(struct pci_bus *b)
         | ^~~~~~~~~~~~~~~~~~~~~
--
   In file included from arch/alpha/include/asm/io.h:8,
                    from arch/alpha/kernel/core_cia.c:16:
>> include/linux/mm.h:2046:43: warning: 'struct arch_tlbflush_unmap_batch' declared inside parameter list will not be visible outside of this definition or declaration
    2046 | static inline void migrc_flush_end(struct arch_tlbflush_unmap_batch *arch) {}
         |                                           ^~~~~~~~~~~~~~~~~~~~~~~~~
   arch/alpha/kernel/core_cia.c:284:1: warning: no previous prototype for 'cia_pci_tbi_try2' [-Wmissing-prototypes]
     284 | cia_pci_tbi_try2(struct pci_controller *hose,
         | ^~~~~~~~~~~~~~~~
   arch/alpha/kernel/core_cia.c:580:1: warning: no previous prototype for 'cia_save_srm_settings' [-Wmissing-prototypes]
     580 | cia_save_srm_settings(int is_pyxis)
         | ^~~~~~~~~~~~~~~~~~~~~
   arch/alpha/kernel/core_cia.c:606:1: warning: no previous prototype for 'cia_restore_srm_settings' [-Wmissing-prototypes]
     606 | cia_restore_srm_settings(void)
         | ^~~~~~~~~~~~~~~~~~~~~~~~
.


vim +2046 include/linux/mm.h

  2040	
  2041	#if defined(CONFIG_MIGRATION) && defined(CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH)
  2042	extern void migrc_flush_start(void);
  2043	extern void migrc_flush_end(struct arch_tlbflush_unmap_batch *arch);
  2044	#else
  2045	static inline void migrc_flush_start(void) {}
> 2046	static inline void migrc_flush_end(struct arch_tlbflush_unmap_batch *arch) {}
  2047	#endif
  2048	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

