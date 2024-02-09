Return-Path: <linux-kernel+bounces-59746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41D5A84FB2B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 18:40:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E70531F27EEA
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 17:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC58F7EEF5;
	Fri,  9 Feb 2024 17:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GJkp8FcH"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9FF7D3ED
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 17:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707500442; cv=none; b=cl5QGVLq50NSZc5/hqegSaYSNwqJxpnW55L6vC8zB0ktu9677dFnUh+88mtQNe8qNQNclplD0SgHZLemzbQixuWonFHPDAAbqpwT6qWqf/oMw5wx+taOXa++vcic9uasZWVxdC3n5zxBhTYZqgv9vmva0gXMe5DwNgciav4RMsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707500442; c=relaxed/simple;
	bh=o8b3GPwcypa+9hVIVmQX9pFn46G5rI+gSuxMV22E/pc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l0gUWLsRDznaGDW0OOrW0gjT8GjTysb1kSQCCfa0G7i3yiqjRSV48VFm+DKAMe4ABL5MW1lDpmoqJ9dCnCEWX3sro47nGD2g8wVRPLxElgUXHIV80qNsFijQvmHPnjqQcXgi8vY7oU80qNiHzzwSU+EJRYSgxxy+rtIEloSLBRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GJkp8FcH; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707500439; x=1739036439;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=o8b3GPwcypa+9hVIVmQX9pFn46G5rI+gSuxMV22E/pc=;
  b=GJkp8FcHJWFY85pXYRegIs7PlSB+ls/1bbuucLM3yavdrKsFBO2+6k/A
   EM3Syfy52gKWgCay9jiBDpi79gUfSCeQQfWGFexGrqf9khmdLIb1/aNf+
   RkM/C+QXyFyRbCP93UdO1OJ10ouMjuldBDdCFsnq57Liixhj8NtPWtDhG
   wtsIZFjrORTOk5NuDEo6PPjwdOZiNAffpw75wFQCk1WIeUKvPd0S3pR6O
   hs8I04Hh3xEBttcRi2aceP2YiGvI+bJ0NNT31CfUFavoTdQEK0a3cQBE3
   JHhTRMWWCXJdWOs656c9Ag03B7V/02sb+019+qwb8+1mFQkm6Tv/0TRKH
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10979"; a="23948243"
X-IronPort-AV: E=Sophos;i="6.05,257,1701158400"; 
   d="scan'208";a="23948243"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 09:40:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,257,1701158400"; 
   d="scan'208";a="6637123"
Received: from lkp-server01.sh.intel.com (HELO 01f0647817ea) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 09 Feb 2024 09:40:36 -0800
Received: from kbuild by 01f0647817ea with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rYUrZ-0004z0-1p;
	Fri, 09 Feb 2024 17:40:33 +0000
Date: Sat, 10 Feb 2024 01:39:54 +0800
From: kernel test robot <lkp@intel.com>
To: Oscar Salvador <osalvador@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	linux-kernel@vger.kernel.org, Michal Hocko <mhocko@suse.com>,
	Vlastimil Babka <vbabka@suse.cz>, Marco Elver <elver@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH v7 1/4] lib/stackdepot: Move stack_record struct
 definition into the header
Message-ID: <202402100110.8JfjkMjh-lkp@intel.com>
References: <20240208234539.19113-2-osalvador@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240208234539.19113-2-osalvador@suse.de>

Hi Oscar,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-nonmm-unstable]
[also build test ERROR on linus/master v6.8-rc3]
[cannot apply to akpm-mm/mm-everything next-20240209]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Oscar-Salvador/lib-stackdepot-Move-stack_record-struct-definition-into-the-header/20240209-074611
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-nonmm-unstable
patch link:    https://lore.kernel.org/r/20240208234539.19113-2-osalvador%40suse.de
patch subject: [PATCH v7 1/4] lib/stackdepot: Move stack_record struct definition into the header
config: openrisc-defconfig (https://download.01.org/0day-ci/archive/20240210/202402100110.8JfjkMjh-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240210/202402100110.8JfjkMjh-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402100110.8JfjkMjh-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/page_ext.h:7,
                    from include/linux/mm.h:22,
                    from include/linux/pid_namespace.h:7,
                    from include/linux/ptrace.h:10,
                    from arch/openrisc/kernel/asm-offsets.c:28:
>> include/linux/stackdepot.h:59:39: error: 'CONFIG_STACKDEPOT_MAX_FRAMES' undeclared here (not in a function)
      59 |                 unsigned long entries[CONFIG_STACKDEPOT_MAX_FRAMES];    /* Frames */
         |                                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   make[3]: *** [scripts/Makefile.build:116: arch/openrisc/kernel/asm-offsets.s] Error 1
   make[3]: Target 'prepare' not remade because of errors.
   make[2]: *** [Makefile:1191: prepare0] Error 2
   make[2]: Target 'prepare' not remade because of errors.
   make[1]: *** [Makefile:240: __sub-make] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:240: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +/CONFIG_STACKDEPOT_MAX_FRAMES +59 include/linux/stackdepot.h

    51	
    52	struct stack_record {
    53		struct list_head hash_list;	/* Links in the hash table */
    54		u32 hash;			/* Hash in hash table */
    55		u32 size;			/* Number of stored frames */
    56		union handle_parts handle;	/* Constant after initialization */
    57		refcount_t count;
    58		union {
  > 59			unsigned long entries[CONFIG_STACKDEPOT_MAX_FRAMES];	/* Frames */
    60			struct {
    61				/*
    62				 * An important invariant of the implementation is to
    63				 * only place a stack record onto the freelist iff its
    64				 * refcount is zero. Because stack records with a zero
    65				 * refcount are never considered as valid, it is safe to
    66				 * union @entries and freelist management state below.
    67				 * Conversely, as soon as an entry is off the freelist
    68				 * and its refcount becomes non-zero, the below must not
    69				 * be accessed until being placed back on the freelist.
    70				 */
    71				struct list_head free_list;	/* Links in the freelist */
    72				unsigned long rcu_state;	/* RCU cookie */
    73			};
    74		};
    75	};
    76	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

