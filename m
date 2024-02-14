Return-Path: <linux-kernel+bounces-64704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 573048541BD
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 04:18:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 733011C26707
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 03:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73EFD947A;
	Wed, 14 Feb 2024 03:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dnDAuaGF"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A858F8F59
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 03:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707880695; cv=none; b=oVbUwEJD4MidPT4uJsD7tYWYJukXJdlLs/osDlYT58x18BoSoKDVpolQpzCZTH1Acq28/ItHvqVhiCktfbPYZpgQxiOyK2HlgO2iDvVH/uXRNK7q1szqXw5e4bPcQEblUsARU1Hup9V7ve5/WJa4bxdVqUaHcuhhW/Xxb0ngPtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707880695; c=relaxed/simple;
	bh=bLs6qvIQvelBnVFr2iLJ+E8oY0Lgk4r6haReuBVcFiU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oInni1FITa72b8KfZ9C4VZEoVB4h6OYPwtwZ3vt+Y/V9WmNLFbL5xRWKQbSC9VuHFaISpYP2pj0uK818iOYMR82PPzfFi8/FGUx7/Y8gXrSLlrb/E4PrPQZ2uEPSVK49bFGKnOtrt9z7v2AatcLBDRVMLmQifUyu1pgghL9C//M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dnDAuaGF; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707880693; x=1739416693;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bLs6qvIQvelBnVFr2iLJ+E8oY0Lgk4r6haReuBVcFiU=;
  b=dnDAuaGFw7GqDhRZ0c1l/k0cZz7RwL0y1nYQ35HMK+GWreRd0ZbYH/2u
   o0ny5w8tLE/WqNdwvqpKuNinVFOs4OzVRXAJctWIhpK3da2c2zpbyT1hS
   yUOt7n7aj0SPKsGeGmlOyB6Ie/3xeeoVeBnLbjUTmiHWIOQj1qemAndzb
   M85qQbuM9b1FwBN2PT83c/wJUfr9mvh9q+RpG9HDK185iQ0ae/OHQWw+F
   VuTSfX3/wkEZe34PEeBTPtyFOGEjdjYgn6Nqlulh4HtaNaqEFsD7BfgVy
   6VEkVExifjU6RT2Gd1dpk1OMsgswECvC7wiI/lucAhU3hwHRnK73xaDPq
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="13302462"
X-IronPort-AV: E=Sophos;i="6.06,158,1705392000"; 
   d="scan'208";a="13302462"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2024 19:18:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,158,1705392000"; 
   d="scan'208";a="3364522"
Received: from lkp-server01.sh.intel.com (HELO 01f0647817ea) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 13 Feb 2024 19:18:06 -0800
Received: from kbuild by 01f0647817ea with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ra5md-0008Fu-1e;
	Wed, 14 Feb 2024 03:18:03 +0000
Date: Wed, 14 Feb 2024 11:17:08 +0800
From: kernel test robot <lkp@intel.com>
To: Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, tglx@linutronix.de, peterz@infradead.org,
	torvalds@linux-foundation.org, paulmck@kernel.org,
	akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
	dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	willy@infradead.org, mgorman@suse.de, jpoimboe@kernel.org,
	mark.rutland@arm.com, jgross@suse.com, andrew.cooper3@citrix.com,
	bristot@kernel.org, mathieu.desnoyers@efficios.com,
	geert@linux-m68k.org, glaubitz@physik.fu-berlin.de,
	anton.ivanov@cambridgegreys.com, mattst88@gmail.com,
	krypton@ulrich-teichert.org, rostedt@goodmis.org,
	David.Laight@aculab.com, richard@nod.at, mjguzik@gmail.com
Subject: Re: [PATCH 03/30] thread_info: tif_need_resched() now takes
 resched_t as param
Message-ID: <202402141055.evTx8Q0K-lkp@intel.com>
References: <20240213055554.1802415-4-ankur.a.arora@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213055554.1802415-4-ankur.a.arora@oracle.com>

Hi Ankur,

kernel test robot noticed the following build warnings:

[auto build test WARNING on paulmck-rcu/dev]
[also build test WARNING on tip/core/entry linus/master v6.8-rc4 next-20240213]
[cannot apply to tip/sched/core]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ankur-Arora/preempt-introduce-CONFIG_PREEMPT_AUTO/20240213-140748
base:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev
patch link:    https://lore.kernel.org/r/20240213055554.1802415-4-ankur.a.arora%40oracle.com
patch subject: [PATCH 03/30] thread_info: tif_need_resched() now takes resched_t as param
config: x86_64-buildonly-randconfig-002-20240213 (https://download.01.org/0day-ci/archive/20240214/202402141055.evTx8Q0K-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240214/202402141055.evTx8Q0K-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402141055.evTx8Q0K-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> vmlinux.o: warning: objtool: mwait_idle+0xd: call to tif_resched.constprop.0() leaves .noinstr.text section
>> vmlinux.o: warning: objtool: poll_idle+0x2c: call to tif_resched.constprop.0() leaves .noinstr.text section


objdump-func vmlinux.o mwait_idle:
0000 0000000000000060 <mwait_idle>:
0000   60:	53                   	push   %rbx
0001   61:	48 8b 1c 25 00 00 00 00 	mov    0x0,%rbx	65: R_X86_64_32S	pcpu_hot
0009   69:	80 4b 02 20          	orb    $0x20,0x2(%rbx)
000d   6d:	e8 00 00 00 00       	call   72 <mwait_idle+0x12>	6e: R_X86_64_PC32	.text+0xfe73c
0012   72:	48 63 f0             	movslq %eax,%rsi
0015   75:	48 0f a3 33          	bt     %rsi,(%rbx)
0019   79:	72 3a                	jb     b5 <mwait_idle+0x55>
001b   7b:	48 8b 05 00 00 00 00 	mov    0x0(%rip),%rax        # 82 <mwait_idle+0x22>	7e: R_X86_64_PC32	boot_cpu_data+0x6c
0022   82:	48 0f ba e0 27       	bt     $0x27,%rax
0027   87:	72 46                	jb     cf <mwait_idle+0x6f>
0029   89:	31 d2                	xor    %edx,%edx
002b   8b:	48 89 d8             	mov    %rbx,%rax
002e   8e:	48 89 d1             	mov    %rdx,%rcx
0031   91:	0f 01 c8             	monitor %rax,%ecx,%edx
0034   94:	48 0f a3 33          	bt     %rsi,(%rbx)
0038   98:	72 1b                	jb     b5 <mwait_idle+0x55>
003a   9a:	8b 05 00 00 00 00    	mov    0x0(%rip),%eax        # a0 <mwait_idle+0x40>	9c: R_X86_64_PC32	mds_idle_clear-0x4
0040   a0:	85 c0                	test   %eax,%eax
0042   a2:	7e 07                	jle    ab <mwait_idle+0x4b>
0044   a4:	0f 00 2d 00 00 00 00 	verw   0x0(%rip)        # ab <mwait_idle+0x4b>	a7: R_X86_64_PC32	.rodata+0x15cd2
004b   ab:	31 c0                	xor    %eax,%eax
004d   ad:	48 89 c1             	mov    %rax,%rcx
0050   b0:	fb                   	sti
0051   b1:	0f 01 c9             	mwait  %eax,%ecx
0054   b4:	fa                   	cli
0055   b5:	48 8b 04 25 00 00 00 00 	mov    0x0,%rax	b9: R_X86_64_32S	pcpu_hot
005d   bd:	80 60 02 df          	andb   $0xdf,0x2(%rax)
0061   c1:	5b                   	pop    %rbx
0062   c2:	31 c0                	xor    %eax,%eax
0064   c4:	31 d2                	xor    %edx,%edx
0066   c6:	31 c9                	xor    %ecx,%ecx
0068   c8:	31 f6                	xor    %esi,%esi
006a   ca:	e9 00 00 00 00       	jmp    cf <mwait_idle+0x6f>	cb: R_X86_64_PLT32	__x86_return_thunk-0x4
006f   cf:	0f ae f0             	mfence
0072   d2:	0f ae 3b             	clflush (%rbx)
0075   d5:	0f ae f0             	mfence
0078   d8:	eb af                	jmp    89 <mwait_idle+0x29>
007a   da:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

