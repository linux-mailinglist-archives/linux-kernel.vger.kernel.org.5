Return-Path: <linux-kernel+bounces-18727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C9AD8261E1
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 23:17:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEB781F218FA
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 22:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C8EAF9F9;
	Sat,  6 Jan 2024 22:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IB47QkbH"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6192F101C8
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jan 2024 22:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704579460; x=1736115460;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JuigR2RkFX7GQS5l2ExgV/8o02li1QfT3/cMhwDWpkE=;
  b=IB47QkbHWF9d2w89I7eOBhzVSzQXWEYFDHGxA7esZuZCBLrCZM/LniXR
   qfq8mAng4+72aAbRwc6DLAelsDY5qa5zoPuUiYz1jyclXAYqF5o1vPtJ6
   UupJnWRaAzwen/6Y1yeNbbuCZO/1QmGmI+Jf7F9QppGii6fYdydbmGjyE
   hjMr24G9cYUxFK0P6oOSJApnsoCQhoBH62GeCi2LsQ7LbjQM6QlwoAyfb
   vr8ew8VXpC3hpBxZHqHOoZ/nV1ONxzubetMe0oBw1sQl/FK5ty6NXRLI4
   BIku3lJIM3MP+8l13YkoOKWcAQAh8Q8C5s0vKGCshmNU9PQoELVGRbstZ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10945"; a="4448940"
X-IronPort-AV: E=Sophos;i="6.04,337,1695711600"; 
   d="scan'208";a="4448940"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2024 14:17:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10945"; a="846860528"
X-IronPort-AV: E=Sophos;i="6.04,337,1695711600"; 
   d="scan'208";a="846860528"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 06 Jan 2024 14:17:36 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rMEz0-00034y-1K;
	Sat, 06 Jan 2024 22:17:34 +0000
Date: Sun, 7 Jan 2024 06:17:16 +0800
From: kernel test robot <lkp@intel.com>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>
Cc: oe-kbuild-all@lists.linux.dev, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Sean Christopherson <seanjc@google.com>
Subject: Re: [PATCH] x86/trampoline: Bypass compat mode in
 trampoline_start64() if not needed
Message-ID: <202401070610.WkJiWgWO-lkp@intel.com>
References: <20240106010106.25772-1-kirill.shutemov@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240106010106.25772-1-kirill.shutemov@linux.intel.com>

Hi Kirill,

kernel test robot noticed the following build errors:

[auto build test ERROR on tip/master]
[also build test ERROR on tip/x86/core tip/auto-latest linus/master v6.7-rc8 next-20240105]
[cannot apply to bp/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Kirill-A-Shutemov/x86-trampoline-Bypass-compat-mode-in-trampoline_start64-if-not-needed/20240106-090311
base:   tip/master
patch link:    https://lore.kernel.org/r/20240106010106.25772-1-kirill.shutemov%40linux.intel.com
patch subject: [PATCH] x86/trampoline: Bypass compat mode in trampoline_start64() if not needed
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20240107/202401070610.WkJiWgWO-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240107/202401070610.WkJiWgWO-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401070610.WkJiWgWO-lkp@intel.com/

All errors (new ones prefixed by >>):

   as: arch/x86/realmode/rm/trampoline_64.o: unsupported relocation type: 0x185
   arch/x86/realmode/rm/trampoline_64.S: Assembler messages:
>> arch/x86/realmode/rm/trampoline_64.S:225: Error: cannot represent relocation type BFD_RELOC_X86_64_32S
   as: arch/x86/realmode/rm/trampoline_64.o: unsupported relocation type: 0x185
   arch/x86/realmode/rm/trampoline_64.S:231: Error: cannot represent relocation type BFD_RELOC_X86_64_32S


vim +225 arch/x86/realmode/rm/trampoline_64.S

   211	
   212	SYM_CODE_START(trampoline_start64)
   213		/*
   214		 * APs start here on a direct transfer from 64-bit BIOS with identity
   215		 * mapped page tables.  Load the kernel's GDT in order to gear down to
   216		 * 32-bit mode (to handle 4-level vs. 5-level paging), and to (re)load
   217		 * segment registers.  Load the zero IDT so any fault triggers a
   218		 * shutdown instead of jumping back into BIOS.
   219		 */
   220		lidt	tr_idt(%rip)
   221		lgdt	tr_gdt64(%rip)
   222	
   223		/* Check if paging mode has to be changed */
   224		movq	%cr4, %rax
 > 225		xorq	pa_tr_cr4, %rax
   226		andq	$X86_CR4_LA57, %rax
   227		jnz	.L_switch_paging
   228	
   229		/* Paging mode is correct proceed in 64-bit mode */
   230	
   231		LOCK_AND_LOAD_REALMODE_ESP lock_pa=1
   232	
   233		movw	$__KERNEL_DS, %dx
   234		movl	%edx, %ss
   235		addl	$pa_real_mode_base, %esp
   236		movl	%edx, %ds
   237		movl	%edx, %es
   238		movl	%edx, %fs
   239		movl	%edx, %gs
   240	
   241		movl	$pa_trampoline_pgd, %eax
   242		movq	%rax, %cr3
   243	
   244		jmpq	*tr_start(%rip)
   245	.L_switch_paging:
   246		/*
   247		 * To switch between 4- and 5-level paging modes, it is necessary
   248		 * to disable paging. This must be done in the compatibility mode.
   249		 */
   250		ljmpl	*tr_compat(%rip)
   251	SYM_CODE_END(trampoline_start64)
   252	
   253		.section ".rodata","a"
   254		# Duplicate the global descriptor table
   255		# so the kernel can live anywhere
   256		.balign	16
   257	SYM_DATA_START(tr_gdt)
   258		.short	tr_gdt_end - tr_gdt - 1	# gdt limit
   259		.long	pa_tr_gdt
   260		.short	0
   261		.quad	0x00cf9b000000ffff	# __KERNEL32_CS
   262		.quad	0x00af9b000000ffff	# __KERNEL_CS
   263		.quad	0x00cf93000000ffff	# __KERNEL_DS
   264	SYM_DATA_END_LABEL(tr_gdt, SYM_L_LOCAL, tr_gdt_end)
   265	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

