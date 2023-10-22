Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEA157D25E0
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 22:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232268AbjJVUbP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 16:31:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjJVUbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 16:31:14 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24054F2
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 13:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698006672; x=1729542672;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lGL1HJ+Mz8yiy7yOKQ7IK/uJoNIiEjiBN/MaS0IWs6Y=;
  b=NOPaYHu7Lpwwl7nxDDoOmE9p/9iCzYySm/ZgQzP09q4MdVtDcZHpg+zW
   6P0djziT/9OE57GJbF6Q2NL4nYYePnCO0U0HnnmpthgYWW+OCqysAfrDt
   oePQkl6xawPkFDWcWb3bFmGwqNovDuri3jFjrKrK3gTvw2bC+Dlo8Z+F9
   wh2wVHjomUjVn7uOY38SFUgB6XyKxwiH9O781cNKytQ6horiOTvxoYnsz
   j8bIO5MsOLLSW/lgQspcrc++esqdwTnBPxQEfHarnOthLegw0Klvw8PC5
   JrYg6KyNy+4Tl07OaN69eoEaxtR1KHsuusMPDs34COVMd8EUS/yWZKAyd
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10871"; a="5353024"
X-IronPort-AV: E=Sophos;i="6.03,243,1694761200"; 
   d="scan'208";a="5353024"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2023 13:31:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10871"; a="787286080"
X-IronPort-AV: E=Sophos;i="6.03,243,1694761200"; 
   d="scan'208";a="787286080"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 22 Oct 2023 13:31:09 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1quf6J-0006FW-08;
        Sun, 22 Oct 2023 20:31:07 +0000
Date:   Mon, 23 Oct 2023 04:30:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andrea della Porta <andrea.porta@suse.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, nik.borisov@suse.com,
        Andrea della Porta <andrea.porta@suse.com>
Subject: Re: [PATCH 3/4] arm64/entry-common: Make Aarch32 syscalls'
 availability depend on aarch32_enabled()
Message-ID: <202310230423.r2U4Lqr8-lkp@intel.com>
References: <88bdea628a13747bff32c0c3055d6d6ef7264d96.1697614386.git.andrea.porta@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88bdea628a13747bff32c0c3055d6d6ef7264d96.1697614386.git.andrea.porta@suse.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrea,

kernel test robot noticed the following build warnings:

[auto build test WARNING on arm64/for-next/core]
[also build test WARNING on arm-perf/for-next/perf arm/for-next arm/fixes kvmarm/next soc/for-next linus/master v6.6-rc6 next-20231020]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Andrea-della-Porta/arm64-Introduce-aarch32_enabled/20231018-191517
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/core
patch link:    https://lore.kernel.org/r/88bdea628a13747bff32c0c3055d6d6ef7264d96.1697614386.git.andrea.porta%40suse.com
patch subject: [PATCH 3/4] arm64/entry-common: Make Aarch32 syscalls' availability depend on aarch32_enabled()
config: arm64-randconfig-003-20231023 (https://download.01.org/0day-ci/archive/20231023/202310230423.r2U4Lqr8-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231023/202310230423.r2U4Lqr8-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310230423.r2U4Lqr8-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> arch/arm64/kernel/entry-common.c:805:11: warning: no previous prototype for 'el0t_32_sync_ni_handler' [-Wmissing-prototypes]
     805 | UNHANDLED(el0t, 32, sync_ni)
         |           ^~~~
   arch/arm64/kernel/entry-common.c:302:25: note: in definition of macro 'UNHANDLED'
     302 | asmlinkage void noinstr el##_##regsize##_##vector##_handler(struct pt_regs *regs)       \
         |                         ^~
>> arch/arm64/kernel/entry-common.c:806:11: warning: no previous prototype for 'el0t_32_irq_ni_handler' [-Wmissing-prototypes]
     806 | UNHANDLED(el0t, 32, irq_ni)
         |           ^~~~
   arch/arm64/kernel/entry-common.c:302:25: note: in definition of macro 'UNHANDLED'
     302 | asmlinkage void noinstr el##_##regsize##_##vector##_handler(struct pt_regs *regs)       \
         |                         ^~
>> arch/arm64/kernel/entry-common.c:807:11: warning: no previous prototype for 'el0t_32_fiq_ni_handler' [-Wmissing-prototypes]
     807 | UNHANDLED(el0t, 32, fiq_ni)
         |           ^~~~
   arch/arm64/kernel/entry-common.c:302:25: note: in definition of macro 'UNHANDLED'
     302 | asmlinkage void noinstr el##_##regsize##_##vector##_handler(struct pt_regs *regs)       \
         |                         ^~
>> arch/arm64/kernel/entry-common.c:808:11: warning: no previous prototype for 'el0t_32_error_ni_handler' [-Wmissing-prototypes]
     808 | UNHANDLED(el0t, 32, error_ni)
         |           ^~~~
   arch/arm64/kernel/entry-common.c:302:25: note: in definition of macro 'UNHANDLED'
     302 | asmlinkage void noinstr el##_##regsize##_##vector##_handler(struct pt_regs *regs)       \
         |                         ^~


vim +/el0t_32_sync_ni_handler +805 arch/arm64/kernel/entry-common.c

   803	
   804	#ifdef CONFIG_COMPAT
 > 805	UNHANDLED(el0t, 32, sync_ni)
 > 806	UNHANDLED(el0t, 32, irq_ni)
 > 807	UNHANDLED(el0t, 32, fiq_ni)
 > 808	UNHANDLED(el0t, 32, error_ni)
   809	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
