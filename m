Return-Path: <linux-kernel+bounces-60358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36CC58503C6
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 11:00:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAB571F2335B
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 10:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0271536121;
	Sat, 10 Feb 2024 10:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GdqDcR1K"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F90024214
	for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 10:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707559218; cv=none; b=Hcpz/C4Ce94bj0IITseiJN1Mrsz7klhdVOxe0rnBhxaUuai9RpHxChh1FfxXQAWG2WSMDgsFPJWWKnFCAeyMoJX5yoydpW+PL1BUJ7Y2a09JrGcaSg8P5C/SK8iTN5xAL13U9p6U+oTZ/x50N25IHZ0XfqbnUCL23Q6UGdIeAjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707559218; c=relaxed/simple;
	bh=xvt3QW9sfPX4CbxPjCUl0Ga19OdD1/2rQMzUTZom8nE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CoSQKAYsQODJK9uTjb62l/EgArg66wMRZxVLhehEMEYkLhhCy3VHUL4mHjn4CLtTugO6rtZ7R2z6NGUte7I4YLA2Mj+9V0G7JTDDm05Ne9ZXvyLoOUeUxsZ/G3FjgyL1ZWQpgub697ZVORgQWfTPt+AF+qsNdpfwwuxvG9PriUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GdqDcR1K; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707559216; x=1739095216;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xvt3QW9sfPX4CbxPjCUl0Ga19OdD1/2rQMzUTZom8nE=;
  b=GdqDcR1Kch9I/qsJxyTLOu0yOd8Cw4QJSUXsULPcQK41mZFVr7x7MO/5
   HC0ONKPFWkPZXXbGg7ZfEevwo53oYW0qTeCcJTszGBU0p2/5pjb9zAxH7
   twyJM+vKZ1bX1r5pGZQAVn+hP4Nnc07tq/7PsW1mtYZA2DvM1k+qBv3mF
   pKJyr9f4j+//ZfWUXACZnd8CJKQbEiDwJCuE9YIKToAZAbSkjxmMu325Z
   M/rNoQqBYIBUkjlgNpYTX8fsgH1JCCzH9eNKksV0wW29u0Lpj/rzx58ps
   YXCYqgu6wA2r3TWt0Kcg6jmk7CFgUSxKfrT4JYuNTB6d6TUACJxk7vSIa
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10979"; a="1414192"
X-IronPort-AV: E=Sophos;i="6.05,259,1701158400"; 
   d="scan'208";a="1414192"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2024 02:00:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,259,1701158400"; 
   d="scan'208";a="2169807"
Received: from lkp-server01.sh.intel.com (HELO 01f0647817ea) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 10 Feb 2024 02:00:12 -0800
Received: from kbuild by 01f0647817ea with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rYk9Z-0005YK-17;
	Sat, 10 Feb 2024 10:00:09 +0000
Date: Sat, 10 Feb 2024 17:59:52 +0800
From: kernel test robot <lkp@intel.com>
To: Oscar Salvador <osalvador@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	linux-kernel@vger.kernel.org, Michal Hocko <mhocko@suse.com>,
	Vlastimil Babka <vbabka@suse.cz>, Marco Elver <elver@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH v7 1/4] lib/stackdepot: Move stack_record struct
 definition into the header
Message-ID: <202402101724.VBz4JA0y-lkp@intel.com>
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
config: mips-xway_defconfig (https://download.01.org/0day-ci/archive/20240210/202402101724.VBz4JA0y-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project ac0577177f053ba7e7016e1b7e44cf5932d00b03)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240210/202402101724.VBz4JA0y-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402101724.VBz4JA0y-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from arch/mips/kernel/asm-offsets.c:15:
   In file included from include/linux/mm.h:22:
   In file included from include/linux/page_ext.h:7:
>> include/linux/stackdepot.h:59:25: error: use of undeclared identifier 'CONFIG_STACKDEPOT_MAX_FRAMES'
      59 |                 unsigned long entries[CONFIG_STACKDEPOT_MAX_FRAMES];    /* Frames */
         |                                       ^
   1 error generated.
   make[3]: *** [scripts/Makefile.build:116: arch/mips/kernel/asm-offsets.s] Error 1
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

