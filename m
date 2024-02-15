Return-Path: <linux-kernel+bounces-67379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D17FB856AA9
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 18:13:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 019EF1C23DEE
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 17:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF6D0136676;
	Thu, 15 Feb 2024 17:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eG+DcD5H"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E36413398C
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 17:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708017213; cv=none; b=Tr5OSMyRniSnOZ7zdi7Usd5CKPq/TvgGYbcaT3cZrEA9tmZqlieA9/COzErmhUiFYpVKUzxmafJJ+IIPPLzqkliaghqffeYWOYuC1X66L7wiAciimFfu+3oiVfLi2q0qAwqiiVjVLPAh6w6UGSkoj9klSrp2Ttw1VSqguwWBfh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708017213; c=relaxed/simple;
	bh=xsaNzdgB2jK3HyIS9x23MK2nn5LiqTe66zzvVyyJ7mE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Vz3+vA4fZzKl+w/+/Cci0AJpY58eE+TZd7hwf6LuF9eMaT3cmhTKyWQVFt29wRePsr82L4BzgNVVtbUKT0U7jgf+lVM4Ox28zbGoSqORinMRRWfmnFiXAGa46cZt3anSFH/uEpfOC3WXoIKYwaGN1P83encIpYmSihy/wkFTusM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eG+DcD5H; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708017211; x=1739553211;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=xsaNzdgB2jK3HyIS9x23MK2nn5LiqTe66zzvVyyJ7mE=;
  b=eG+DcD5HNVKsAPOvPfirD4hnjA4H2lwJgge6n5GHaucHlbIv0iHyUxGV
   3C0xpvIgoHxsIVGo3yICHH8Bo/+xnGBPCB5yOvW72FtE9m8oGv68WY8Nw
   rnX8eDGmDzMbj1v07hGhR5m3e4hs+NVSu1hl6LmU7x1N6igjIZqn0UjAV
   jB62qjOTBMjWCvwXDhl6+Vf5L9eCPxXq2xUhIlR+ituyq9JV9kbKekum9
   dwFPDFgrgILGidNCLqCh1kCiEuhZRSX6RhqDAg8IFCl63cXuaTxPxQhs8
   SD8KwIm2JJlLaHR7+wEYtv7yevg1Q0FDOVCr20Qizhrd6RcfxBSVoW708
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10985"; a="1992983"
X-IronPort-AV: E=Sophos;i="6.06,162,1705392000"; 
   d="scan'208";a="1992983"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 09:13:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,162,1705392000"; 
   d="scan'208";a="3879737"
Received: from lkp-server02.sh.intel.com (HELO 3c78fa4d504c) ([10.239.97.151])
  by fmviesa006.fm.intel.com with ESMTP; 15 Feb 2024 09:13:28 -0800
Received: from kbuild by 3c78fa4d504c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rafIM-0000em-2w;
	Thu, 15 Feb 2024 17:13:14 +0000
Date: Fri, 16 Feb 2024 01:12:11 +0800
From: kernel test robot <lkp@intel.com>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/WFAMNAE-next20240215 1/1]
 include/linux/fs.h:1042:29: warning: 'used' attribute does not apply to
 types
Message-ID: <202402160138.3DiZt3SO-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/WFAMNAE-next20240215
head:   34a5c90f36e0238bfc95cda9e2eccf7e610bff1a
commit: 34a5c90f36e0238bfc95cda9e2eccf7e610bff1a [1/1] treewide: Address -Wflexible-array-member-not-at-end warnings
config: arm-randconfig-004-20240215 (https://download.01.org/0day-ci/archive/20240216/202402160138.3DiZt3SO-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240216/202402160138.3DiZt3SO-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402160138.3DiZt3SO-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/stddef.h:5,
                    from include/uapi/linux/posix_types.h:5,
                    from include/uapi/linux/types.h:14,
                    from include/linux/types.h:6,
                    from include/linux/io.h:9,
                    from arch/arm/mach-omap2/board-generic.c:11:
>> include/linux/fs.h:1042:29: warning: 'used' attribute does not apply to types [-Wattributes]
    1042 |         struct_group_tagged(file_handle_tag, __tag,
         |                             ^~~~~~~~~~~~~~~
   include/uapi/linux/stddef.h:29:24: note: in definition of macro '__struct_group'
      29 |                 struct TAG { MEMBERS } ATTRS NAME; \
         |                        ^~~
   include/linux/fs.h:1042:9: note: in expansion of macro 'struct_group_tagged'
    1042 |         struct_group_tagged(file_handle_tag, __tag,
         |         ^~~~~~~~~~~~~~~~~~~
>> include/linux/fs.h:1042:29: warning: 'section' attribute does not apply to types [-Wattributes]
    1042 |         struct_group_tagged(file_handle_tag, __tag,
         |                             ^~~~~~~~~~~~~~~
   include/uapi/linux/stddef.h:29:24: note: in definition of macro '__struct_group'
      29 |                 struct TAG { MEMBERS } ATTRS NAME; \
         |                        ^~~
   include/linux/fs.h:1042:9: note: in expansion of macro 'struct_group_tagged'
    1042 |         struct_group_tagged(file_handle_tag, __tag,
         |         ^~~~~~~~~~~~~~~~~~~
>> include/uapi/linux/stddef.h:29:50: warning: declaration does not declare anything
      29 |                 struct TAG { MEMBERS } ATTRS NAME; \
         |                                                  ^
   include/linux/stddef.h:81:9: note: in expansion of macro '__struct_group'
      81 |         __struct_group(TAG, NAME, /* no attrs */, MEMBERS)
         |         ^~~~~~~~~~~~~~
   include/linux/fs.h:1042:9: note: in expansion of macro 'struct_group_tagged'
    1042 |         struct_group_tagged(file_handle_tag, __tag,
         |         ^~~~~~~~~~~~~~~~~~~
>> include/linux/cgroup-defs.h:545:16: warning: 'used' attribute does not apply to types [-Wattributes]
     545 |         struct bpf_local_storage __rcu  *bpf_cgrp_storage;
         |                ^~~~~~~~~~~~~~~~~
   include/uapi/linux/stddef.h:29:30: note: in definition of macro '__struct_group'
      29 |                 struct TAG { MEMBERS } ATTRS NAME; \
         |                              ^~~~~~~
   include/linux/cgroup-defs.h:398:9: note: in expansion of macro 'struct_group_tagged'
     398 |         struct_group_tagged(cgroup_tag, __tag,
         |         ^~~~~~~~~~~~~~~~~~~
>> include/linux/cgroup-defs.h:545:16: warning: 'section' attribute does not apply to types [-Wattributes]
     545 |         struct bpf_local_storage __rcu  *bpf_cgrp_storage;
         |                ^~~~~~~~~~~~~~~~~
   include/uapi/linux/stddef.h:29:30: note: in definition of macro '__struct_group'
      29 |                 struct TAG { MEMBERS } ATTRS NAME; \
         |                              ^~~~~~~
   include/linux/cgroup-defs.h:398:9: note: in expansion of macro 'struct_group_tagged'
     398 |         struct_group_tagged(cgroup_tag, __tag,
         |         ^~~~~~~~~~~~~~~~~~~
>> include/uapi/linux/stddef.h:29:50: warning: declaration does not declare anything
      29 |                 struct TAG { MEMBERS } ATTRS NAME; \
         |                                                  ^
   include/linux/stddef.h:81:9: note: in expansion of macro '__struct_group'
      81 |         __struct_group(TAG, NAME, /* no attrs */, MEMBERS)
         |         ^~~~~~~~~~~~~~
   include/linux/cgroup-defs.h:398:9: note: in expansion of macro 'struct_group_tagged'
     398 |         struct_group_tagged(cgroup_tag, __tag,
         |         ^~~~~~~~~~~~~~~~~~~
--
   In file included from include/linux/stddef.h:5,
                    from include/uapi/linux/posix_types.h:5,
                    from include/uapi/linux/types.h:14,
                    from include/linux/types.h:6,
                    from include/linux/kasan-checks.h:5,
                    from include/asm-generic/rwonce.h:26,
                    from ./arch/arm/include/generated/asm/rwonce.h:1,
                    from include/linux/compiler.h:251,
                    from include/linux/array_size.h:5,
                    from include/linux/kernel.h:16,
                    from arch/arm/mm/init.c:7:
>> include/asm-generic/tlb.h:247:36: warning: 'used' attribute does not apply to types [-Wattributes]
     247 |                             struct mmu_gather_batch     *next;
         |                                    ^~~~~~~~~~~~~~~~
   include/uapi/linux/stddef.h:29:30: note: in definition of macro '__struct_group'
      29 |                 struct TAG { MEMBERS } ATTRS NAME; \
         |                              ^~~~~~~
   include/asm-generic/tlb.h:246:9: note: in expansion of macro 'struct_group_tagged'
     246 |         struct_group_tagged(mmu_gather_batch_tag, __tag,
         |         ^~~~~~~~~~~~~~~~~~~
>> include/asm-generic/tlb.h:247:36: warning: 'section' attribute does not apply to types [-Wattributes]
     247 |                             struct mmu_gather_batch     *next;
         |                                    ^~~~~~~~~~~~~~~~
   include/uapi/linux/stddef.h:29:30: note: in definition of macro '__struct_group'
      29 |                 struct TAG { MEMBERS } ATTRS NAME; \
         |                              ^~~~~~~
   include/asm-generic/tlb.h:246:9: note: in expansion of macro 'struct_group_tagged'
     246 |         struct_group_tagged(mmu_gather_batch_tag, __tag,
         |         ^~~~~~~~~~~~~~~~~~~
>> include/uapi/linux/stddef.h:29:50: warning: declaration does not declare anything
      29 |                 struct TAG { MEMBERS } ATTRS NAME; \
         |                                                  ^
   include/linux/stddef.h:81:9: note: in expansion of macro '__struct_group'
      81 |         __struct_group(TAG, NAME, /* no attrs */, MEMBERS)
         |         ^~~~~~~~~~~~~~
   include/asm-generic/tlb.h:246:9: note: in expansion of macro 'struct_group_tagged'
     246 |         struct_group_tagged(mmu_gather_batch_tag, __tag,
         |         ^~~~~~~~~~~~~~~~~~~
--
   In file included from include/linux/stddef.h:5,
                    from include/uapi/linux/posix_types.h:5,
                    from include/uapi/linux/types.h:14,
                    from include/linux/types.h:6,
                    from include/linux/kasan-checks.h:5,
                    from include/asm-generic/rwonce.h:26,
                    from ./arch/arm/include/generated/asm/rwonce.h:1,
                    from include/linux/compiler.h:251,
                    from include/linux/build_bug.h:5,
                    from include/linux/container_of.h:5,
                    from include/linux/list.h:5,
                    from include/linux/module.h:12,
                    from arch/arm/mm/mmu.c:7:
>> include/linux/cgroup-defs.h:545:16: warning: 'used' attribute does not apply to types [-Wattributes]
     545 |         struct bpf_local_storage __rcu  *bpf_cgrp_storage;
         |                ^~~~~~~~~~~~~~~~~
   include/uapi/linux/stddef.h:29:30: note: in definition of macro '__struct_group'
      29 |                 struct TAG { MEMBERS } ATTRS NAME; \
         |                              ^~~~~~~
   include/linux/cgroup-defs.h:398:9: note: in expansion of macro 'struct_group_tagged'
     398 |         struct_group_tagged(cgroup_tag, __tag,
         |         ^~~~~~~~~~~~~~~~~~~
>> include/linux/cgroup-defs.h:545:16: warning: 'section' attribute does not apply to types [-Wattributes]
     545 |         struct bpf_local_storage __rcu  *bpf_cgrp_storage;
         |                ^~~~~~~~~~~~~~~~~
   include/uapi/linux/stddef.h:29:30: note: in definition of macro '__struct_group'
      29 |                 struct TAG { MEMBERS } ATTRS NAME; \
         |                              ^~~~~~~
   include/linux/cgroup-defs.h:398:9: note: in expansion of macro 'struct_group_tagged'
     398 |         struct_group_tagged(cgroup_tag, __tag,
         |         ^~~~~~~~~~~~~~~~~~~
>> include/uapi/linux/stddef.h:29:50: warning: declaration does not declare anything
      29 |                 struct TAG { MEMBERS } ATTRS NAME; \
         |                                                  ^
   include/linux/stddef.h:81:9: note: in expansion of macro '__struct_group'
      81 |         __struct_group(TAG, NAME, /* no attrs */, MEMBERS)
         |         ^~~~~~~~~~~~~~
   include/linux/cgroup-defs.h:398:9: note: in expansion of macro 'struct_group_tagged'
     398 |         struct_group_tagged(cgroup_tag, __tag,
         |         ^~~~~~~~~~~~~~~~~~~
>> include/asm-generic/tlb.h:247:36: warning: 'used' attribute does not apply to types [-Wattributes]
     247 |                             struct mmu_gather_batch     *next;
         |                                    ^~~~~~~~~~~~~~~~
   include/uapi/linux/stddef.h:29:30: note: in definition of macro '__struct_group'
      29 |                 struct TAG { MEMBERS } ATTRS NAME; \
         |                              ^~~~~~~
   include/asm-generic/tlb.h:246:9: note: in expansion of macro 'struct_group_tagged'
     246 |         struct_group_tagged(mmu_gather_batch_tag, __tag,
         |         ^~~~~~~~~~~~~~~~~~~
>> include/asm-generic/tlb.h:247:36: warning: 'section' attribute does not apply to types [-Wattributes]
     247 |                             struct mmu_gather_batch     *next;
         |                                    ^~~~~~~~~~~~~~~~
   include/uapi/linux/stddef.h:29:30: note: in definition of macro '__struct_group'
      29 |                 struct TAG { MEMBERS } ATTRS NAME; \
         |                              ^~~~~~~
   include/asm-generic/tlb.h:246:9: note: in expansion of macro 'struct_group_tagged'
     246 |         struct_group_tagged(mmu_gather_batch_tag, __tag,
         |         ^~~~~~~~~~~~~~~~~~~
>> include/uapi/linux/stddef.h:29:50: warning: declaration does not declare anything
      29 |                 struct TAG { MEMBERS } ATTRS NAME; \
         |                                                  ^
   include/linux/stddef.h:81:9: note: in expansion of macro '__struct_group'
      81 |         __struct_group(TAG, NAME, /* no attrs */, MEMBERS)
         |         ^~~~~~~~~~~~~~
   include/asm-generic/tlb.h:246:9: note: in expansion of macro 'struct_group_tagged'
     246 |         struct_group_tagged(mmu_gather_batch_tag, __tag,
         |         ^~~~~~~~~~~~~~~~~~~
--
   In file included from include/linux/stddef.h:5,
                    from include/uapi/linux/posix_types.h:5,
                    from include/uapi/linux/types.h:14,
                    from include/linux/types.h:6,
                    from include/linux/kasan-checks.h:5,
                    from include/asm-generic/rwonce.h:26,
                    from ./arch/arm/include/generated/asm/rwonce.h:1,
                    from include/linux/compiler.h:251,
                    from include/linux/array_size.h:5,
                    from include/linux/kernel.h:16,
                    from drivers/ata/libata-core.c:28:
>> include/linux/types.h:239:18: warning: 'used' attribute does not apply to types [-Wattributes]
     239 | #define rcu_head callback_head
         |                  ^~~~~~~~~~~~~
   include/uapi/linux/stddef.h:29:30: note: in definition of macro '__struct_group'
      29 |                 struct TAG { MEMBERS } ATTRS NAME; \
         |                              ^~~~~~~
   include/linux/bpf.h:1963:9: note: in expansion of macro 'struct_group_tagged'
    1963 |         struct_group_tagged(bpf_prog_array_tag, __tag,
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/bpf.h:1964:16: note: in expansion of macro 'rcu_head'
    1964 |         struct rcu_head rcu;
         |                ^~~~~~~~
>> include/linux/types.h:239:18: warning: 'section' attribute does not apply to types [-Wattributes]
     239 | #define rcu_head callback_head
         |                  ^~~~~~~~~~~~~
   include/uapi/linux/stddef.h:29:30: note: in definition of macro '__struct_group'
      29 |                 struct TAG { MEMBERS } ATTRS NAME; \
         |                              ^~~~~~~
   include/linux/bpf.h:1963:9: note: in expansion of macro 'struct_group_tagged'
    1963 |         struct_group_tagged(bpf_prog_array_tag, __tag,
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/bpf.h:1964:16: note: in expansion of macro 'rcu_head'
    1964 |         struct rcu_head rcu;
         |                ^~~~~~~~
>> include/uapi/linux/stddef.h:29:50: warning: declaration does not declare anything
      29 |                 struct TAG { MEMBERS } ATTRS NAME; \
         |                                                  ^
   include/linux/stddef.h:81:9: note: in expansion of macro '__struct_group'
      81 |         __struct_group(TAG, NAME, /* no attrs */, MEMBERS)
         |         ^~~~~~~~~~~~~~
   include/linux/bpf.h:1963:9: note: in expansion of macro 'struct_group_tagged'
    1963 |         struct_group_tagged(bpf_prog_array_tag, __tag,
         |         ^~~~~~~~~~~~~~~~~~~
>> include/linux/perf_event.h:124:29: warning: 'used' attribute does not apply to types [-Wattributes]
     124 |         struct_group_tagged(perf_branch_stack_tag, __tag,
         |                             ^~~~~~~~~~~~~~~~~~~~~
   include/uapi/linux/stddef.h:29:24: note: in definition of macro '__struct_group'
      29 |                 struct TAG { MEMBERS } ATTRS NAME; \
         |                        ^~~
   include/linux/perf_event.h:124:9: note: in expansion of macro 'struct_group_tagged'
     124 |         struct_group_tagged(perf_branch_stack_tag, __tag,
         |         ^~~~~~~~~~~~~~~~~~~
>> include/linux/perf_event.h:124:29: warning: 'section' attribute does not apply to types [-Wattributes]
     124 |         struct_group_tagged(perf_branch_stack_tag, __tag,
         |                             ^~~~~~~~~~~~~~~~~~~~~
   include/uapi/linux/stddef.h:29:24: note: in definition of macro '__struct_group'
      29 |                 struct TAG { MEMBERS } ATTRS NAME; \
         |                        ^~~
   include/linux/perf_event.h:124:9: note: in expansion of macro 'struct_group_tagged'
     124 |         struct_group_tagged(perf_branch_stack_tag, __tag,
         |         ^~~~~~~~~~~~~~~~~~~
>> include/uapi/linux/stddef.h:29:50: warning: declaration does not declare anything
      29 |                 struct TAG { MEMBERS } ATTRS NAME; \
         |                                                  ^
   include/linux/stddef.h:81:9: note: in expansion of macro '__struct_group'
      81 |         __struct_group(TAG, NAME, /* no attrs */, MEMBERS)
         |         ^~~~~~~~~~~~~~
   include/linux/perf_event.h:124:9: note: in expansion of macro 'struct_group_tagged'
     124 |         struct_group_tagged(perf_branch_stack_tag, __tag,
         |         ^~~~~~~~~~~~~~~~~~~
--
   In file included from include/linux/stddef.h:5,
                    from include/uapi/linux/posix_types.h:5,
                    from include/uapi/linux/types.h:14,
                    from include/linux/types.h:6,
                    from include/uapi/linux/sched.h:5,
                    from include/linux/sched.h:10,
                    from include/linux/sched/task_stack.h:9,
                    from kernel/trace/trace_stack.c:6:
>> include/linux/perf_event.h:124:29: warning: 'used' attribute does not apply to types [-Wattributes]
     124 |         struct_group_tagged(perf_branch_stack_tag, __tag,
         |                             ^~~~~~~~~~~~~~~~~~~~~
   include/uapi/linux/stddef.h:29:24: note: in definition of macro '__struct_group'
      29 |                 struct TAG { MEMBERS } ATTRS NAME; \
         |                        ^~~
   include/linux/perf_event.h:124:9: note: in expansion of macro 'struct_group_tagged'
     124 |         struct_group_tagged(perf_branch_stack_tag, __tag,
         |         ^~~~~~~~~~~~~~~~~~~
>> include/linux/perf_event.h:124:29: warning: 'section' attribute does not apply to types [-Wattributes]
     124 |         struct_group_tagged(perf_branch_stack_tag, __tag,
         |                             ^~~~~~~~~~~~~~~~~~~~~
   include/uapi/linux/stddef.h:29:24: note: in definition of macro '__struct_group'
      29 |                 struct TAG { MEMBERS } ATTRS NAME; \
         |                        ^~~
   include/linux/perf_event.h:124:9: note: in expansion of macro 'struct_group_tagged'
     124 |         struct_group_tagged(perf_branch_stack_tag, __tag,
         |         ^~~~~~~~~~~~~~~~~~~
>> include/uapi/linux/stddef.h:29:50: warning: declaration does not declare anything
      29 |                 struct TAG { MEMBERS } ATTRS NAME; \
         |                                                  ^
   include/linux/stddef.h:81:9: note: in expansion of macro '__struct_group'
      81 |         __struct_group(TAG, NAME, /* no attrs */, MEMBERS)
         |         ^~~~~~~~~~~~~~
   include/linux/perf_event.h:124:9: note: in expansion of macro 'struct_group_tagged'
     124 |         struct_group_tagged(perf_branch_stack_tag, __tag,
         |         ^~~~~~~~~~~~~~~~~~~
--
   In file included from include/linux/stddef.h:5,
                    from include/uapi/linux/posix_types.h:5,
                    from include/uapi/linux/types.h:14,
                    from include/linux/types.h:6,
                    from include/linux/kasan-checks.h:5,
                    from include/asm-generic/rwonce.h:26,
                    from ./arch/arm/include/generated/asm/rwonce.h:1,
                    from include/linux/compiler.h:251,
                    from include/linux/export.h:5,
                    from include/linux/linkage.h:7,
                    from arch/arm/include/asm/bug.h:5,
                    from include/linux/bug.h:5,
                    from include/linux/mmdebug.h:5,
                    from include/linux/mm.h:6,
                    from include/linux/ring_buffer.h:5,
                    from kernel/trace/trace.c:15:
>> include/linux/perf_event.h:124:29: warning: 'used' attribute does not apply to types [-Wattributes]
     124 |         struct_group_tagged(perf_branch_stack_tag, __tag,
         |                             ^~~~~~~~~~~~~~~~~~~~~
   include/uapi/linux/stddef.h:29:24: note: in definition of macro '__struct_group'
      29 |                 struct TAG { MEMBERS } ATTRS NAME; \
         |                        ^~~
   include/linux/perf_event.h:124:9: note: in expansion of macro 'struct_group_tagged'
     124 |         struct_group_tagged(perf_branch_stack_tag, __tag,
         |         ^~~~~~~~~~~~~~~~~~~
>> include/linux/perf_event.h:124:29: warning: 'section' attribute does not apply to types [-Wattributes]
     124 |         struct_group_tagged(perf_branch_stack_tag, __tag,
         |                             ^~~~~~~~~~~~~~~~~~~~~
   include/uapi/linux/stddef.h:29:24: note: in definition of macro '__struct_group'
      29 |                 struct TAG { MEMBERS } ATTRS NAME; \
         |                        ^~~
   include/linux/perf_event.h:124:9: note: in expansion of macro 'struct_group_tagged'
     124 |         struct_group_tagged(perf_branch_stack_tag, __tag,
         |         ^~~~~~~~~~~~~~~~~~~
>> include/uapi/linux/stddef.h:29:50: warning: declaration does not declare anything
      29 |                 struct TAG { MEMBERS } ATTRS NAME; \
         |                                                  ^
   include/linux/stddef.h:81:9: note: in expansion of macro '__struct_group'
      81 |         __struct_group(TAG, NAME, /* no attrs */, MEMBERS)
         |         ^~~~~~~~~~~~~~
   include/linux/perf_event.h:124:9: note: in expansion of macro 'struct_group_tagged'
     124 |         struct_group_tagged(perf_branch_stack_tag, __tag,
         |         ^~~~~~~~~~~~~~~~~~~
   In file included from kernel/trace/trace.c:8979:
   kernel/trace/trace_selftest.c: In function 'trace_selftest_function_regs':
   kernel/trace/trace_selftest.c:605:13: warning: variable 'len' set but not used [-Wunused-but-set-variable]
     605 |         int len;
         |             ^~~


vim +/used +1042 include/linux/fs.h

   991	
   992	/*
   993	 * f_{lock,count,pos_lock} members can be highly contended and share
   994	 * the same cacheline. f_{lock,mode} are very frequently used together
   995	 * and so share the same cacheline as well. The read-mostly
   996	 * f_{path,inode,op} are kept on a separate cacheline.
   997	 */
   998	struct file {
   999		union {
  1000			/* fput() uses task work when closing and freeing file (default). */
  1001			struct callback_head 	f_task_work;
  1002			/* fput() must use workqueue (most kernel threads). */
  1003			struct llist_node	f_llist;
  1004			unsigned int 		f_iocb_flags;
  1005		};
  1006	
  1007		/*
  1008		 * Protects f_ep, f_flags.
  1009		 * Must not be taken from IRQ context.
  1010		 */
  1011		spinlock_t		f_lock;
  1012		fmode_t			f_mode;
  1013		atomic_long_t		f_count;
  1014		struct mutex		f_pos_lock;
  1015		loff_t			f_pos;
  1016		unsigned int		f_flags;
  1017		struct fown_struct	f_owner;
  1018		const struct cred	*f_cred;
  1019		struct file_ra_state	f_ra;
  1020		struct path		f_path;
  1021		struct inode		*f_inode;	/* cached value */
  1022		const struct file_operations	*f_op;
  1023	
  1024		u64			f_version;
  1025	#ifdef CONFIG_SECURITY
  1026		void			*f_security;
  1027	#endif
  1028		/* needed for tty driver, and maybe others */
  1029		void			*private_data;
  1030	
  1031	#ifdef CONFIG_EPOLL
  1032		/* Used by fs/eventpoll.c to link all the hooks to this file */
  1033		struct hlist_head	*f_ep;
  1034	#endif /* #ifdef CONFIG_EPOLL */
  1035		struct address_space	*f_mapping;
  1036		errseq_t		f_wb_err;
  1037		errseq_t		f_sb_err; /* for syncfs */
  1038	} __randomize_layout
  1039	  __attribute__((aligned(4)));	/* lest something weird decides that 2 is OK */
  1040	
  1041	struct file_handle {
> 1042		struct_group_tagged(file_handle_tag, __tag,
  1043				    __u32 handle_bytes;
  1044				    int handle_type;
  1045				    /* file identifier */
  1046		);
  1047		unsigned char f_handle[];
  1048	};
  1049	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

