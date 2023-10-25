Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB6007D6011
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 04:48:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232149AbjJYCst (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 22:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjJYCss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 22:48:48 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFE3F10C6;
        Tue, 24 Oct 2023 19:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698202125; x=1729738125;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=azUlyA21SeatZiUGey5HRxkPF9GFPbbtRO+RTIbX3CY=;
  b=nVO6wzNfbClFk/X/6qcLnbjFp/BUs0Rj3NAQuEU0r7g0s1ZBayezKa7O
   8zPJE0EC0Hmpfh3cp3hngEKP3OEa1uynz281KXmw/2EC+KyUwssDe02iL
   Nz4hIH606fjh/JZR5O4RNjS5uFSHTCbLSl+sMfEvxgxZ2E+1nx0srs11u
   gslBuKgwlv448i65mZmZufCt3nkj0mPQrEewQ4QIlpkEAb9B9dgm6hECR
   TvSDQI3EzblRDpyLtv8m1vY/cJS2IJLy425LJIxARIJlxmUXDojo9y6nC
   QVW8e/EcQvh9q7p/XxtrPQtMpuCLk+29ybrsqryYXr397F5mXJrzw6Ka3
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="386109889"
X-IronPort-AV: E=Sophos;i="6.03,249,1694761200"; 
   d="scan'208";a="386109889"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 19:48:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,249,1694761200"; 
   d="scan'208";a="6677498"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 24 Oct 2023 19:48:36 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qvTwn-0008YJ-0c;
        Wed, 25 Oct 2023 02:48:41 +0000
Date:   Wed, 25 Oct 2023 10:48:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>, linux-mips@vger.kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, tsbogend@alpha.franken.de,
        gregory.clement@bootlin.com, vladimir.kondratiev@intel.com,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: Re: [PATCH 3/5] MIPS: Fix set_uncached_handler for ebase in XKPHYS
Message-ID: <202310251032.BvEIZ6Xk-lkp@intel.com>
References: <20231023191400.170052-4-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231023191400.170052-4-jiaxun.yang@flygoat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiaxun,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.6-rc7 next-20231024]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jiaxun-Yang/MIPS-Export-higher-highest-relocation-functions-in-uasm/20231024-034657
base:   linus/master
patch link:    https://lore.kernel.org/r/20231023191400.170052-4-jiaxun.yang%40flygoat.com
patch subject: [PATCH 3/5] MIPS: Fix set_uncached_handler for ebase in XKPHYS
config: mips-loongson1c_defconfig (https://download.01.org/0day-ci/archive/20231025/202310251032.BvEIZ6Xk-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231025/202310251032.BvEIZ6Xk-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310251032.BvEIZ6Xk-lkp@intel.com/

All errors (new ones prefixed by >>):

    1402 | asmlinkage void do_cpu(struct pt_regs *regs)
         |                 ^
   arch/mips/kernel/traps.c:1402:12: note: declare 'static' if the function is not intended to be used outside of this translation unit
    1402 | asmlinkage void do_cpu(struct pt_regs *regs)
         |            ^
         |            static 
   arch/mips/kernel/traps.c:1507:17: warning: no previous prototype for function 'do_msa_fpe' [-Wmissing-prototypes]
    1507 | asmlinkage void do_msa_fpe(struct pt_regs *regs, unsigned int msacsr)
         |                 ^
   arch/mips/kernel/traps.c:1507:12: note: declare 'static' if the function is not intended to be used outside of this translation unit
    1507 | asmlinkage void do_msa_fpe(struct pt_regs *regs, unsigned int msacsr)
         |            ^
         |            static 
   arch/mips/kernel/traps.c:1527:17: warning: no previous prototype for function 'do_msa' [-Wmissing-prototypes]
    1527 | asmlinkage void do_msa(struct pt_regs *regs)
         |                 ^
   arch/mips/kernel/traps.c:1527:12: note: declare 'static' if the function is not intended to be used outside of this translation unit
    1527 | asmlinkage void do_msa(struct pt_regs *regs)
         |            ^
         |            static 
   arch/mips/kernel/traps.c:1548:17: warning: no previous prototype for function 'do_mdmx' [-Wmissing-prototypes]
    1548 | asmlinkage void do_mdmx(struct pt_regs *regs)
         |                 ^
   arch/mips/kernel/traps.c:1548:12: note: declare 'static' if the function is not intended to be used outside of this translation unit
    1548 | asmlinkage void do_mdmx(struct pt_regs *regs)
         |            ^
         |            static 
   arch/mips/kernel/traps.c:1560:17: warning: no previous prototype for function 'do_watch' [-Wmissing-prototypes]
    1560 | asmlinkage void do_watch(struct pt_regs *regs)
         |                 ^
   arch/mips/kernel/traps.c:1560:12: note: declare 'static' if the function is not intended to be used outside of this translation unit
    1560 | asmlinkage void do_watch(struct pt_regs *regs)
         |            ^
         |            static 
   arch/mips/kernel/traps.c:1590:17: warning: variable 'prev_state' set but not used [-Wunused-but-set-variable]
    1590 |         enum ctx_state prev_state;
         |                        ^
   arch/mips/kernel/traps.c:1587:17: warning: no previous prototype for function 'do_mcheck' [-Wmissing-prototypes]
    1587 | asmlinkage void do_mcheck(struct pt_regs *regs)
         |                 ^
   arch/mips/kernel/traps.c:1587:12: note: declare 'static' if the function is not intended to be used outside of this translation unit
    1587 | asmlinkage void do_mcheck(struct pt_regs *regs)
         |            ^
         |            static 
   arch/mips/kernel/traps.c:1612:17: warning: no previous prototype for function 'do_mt' [-Wmissing-prototypes]
    1612 | asmlinkage void do_mt(struct pt_regs *regs)
         |                 ^
   arch/mips/kernel/traps.c:1612:12: note: declare 'static' if the function is not intended to be used outside of this translation unit
    1612 | asmlinkage void do_mt(struct pt_regs *regs)
         |            ^
         |            static 
   arch/mips/kernel/traps.c:1648:17: warning: no previous prototype for function 'do_dsp' [-Wmissing-prototypes]
    1648 | asmlinkage void do_dsp(struct pt_regs *regs)
         |                 ^
   arch/mips/kernel/traps.c:1648:12: note: declare 'static' if the function is not intended to be used outside of this translation unit
    1648 | asmlinkage void do_dsp(struct pt_regs *regs)
         |            ^
         |            static 
   arch/mips/kernel/traps.c:1656:17: warning: no previous prototype for function 'do_reserved' [-Wmissing-prototypes]
    1656 | asmlinkage void do_reserved(struct pt_regs *regs)
         |                 ^
   arch/mips/kernel/traps.c:1656:12: note: declare 'static' if the function is not intended to be used outside of this translation unit
    1656 | asmlinkage void do_reserved(struct pt_regs *regs)
         |            ^
         |            static 
   arch/mips/kernel/traps.c:1832:17: warning: no previous prototype for function 'cache_parity_error' [-Wmissing-prototypes]
    1832 | asmlinkage void cache_parity_error(void)
         |                 ^
   arch/mips/kernel/traps.c:1832:12: note: declare 'static' if the function is not intended to be used outside of this translation unit
    1832 | asmlinkage void cache_parity_error(void)
         |            ^
         |            static 
   arch/mips/kernel/traps.c:1880:17: warning: no previous prototype for function 'do_ftlb' [-Wmissing-prototypes]
    1880 | asmlinkage void do_ftlb(void)
         |                 ^
   arch/mips/kernel/traps.c:1880:12: note: declare 'static' if the function is not intended to be used outside of this translation unit
    1880 | asmlinkage void do_ftlb(void)
         |            ^
         |            static 
   arch/mips/kernel/traps.c:1909:17: warning: no previous prototype for function 'do_gsexc' [-Wmissing-prototypes]
    1909 | asmlinkage void do_gsexc(struct pt_regs *regs, u32 diag1)
         |                 ^
   arch/mips/kernel/traps.c:1909:12: note: declare 'static' if the function is not intended to be used outside of this translation unit
    1909 | asmlinkage void do_gsexc(struct pt_regs *regs, u32 diag1)
         |            ^
         |            static 
   arch/mips/kernel/traps.c:1944:6: warning: no previous prototype for function 'ejtag_exception_handler' [-Wmissing-prototypes]
    1944 | void ejtag_exception_handler(struct pt_regs *regs)
         |      ^
   arch/mips/kernel/traps.c:1944:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
    1944 | void ejtag_exception_handler(struct pt_regs *regs)
         | ^
         | static 
   arch/mips/kernel/traps.c:1989:17: warning: no previous prototype for function 'nmi_exception_handler' [-Wmissing-prototypes]
    1989 | void __noreturn nmi_exception_handler(struct pt_regs *regs)
         |                 ^
   arch/mips/kernel/traps.c:1989:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
    1989 | void __noreturn nmi_exception_handler(struct pt_regs *regs)
         | ^
         | static 
>> arch/mips/kernel/traps.c:2349:33: error: call to undeclared function 'TO_UNCAC'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    2349 |         unsigned long uncached_ebase = TO_UNCAC(__pa(ebase));
         |                                        ^
   22 warnings and 1 error generated.


vim +/TO_UNCAC +2349 arch/mips/kernel/traps.c

  2337	
  2338	static const char panic_null_cerr[] =
  2339		"Trying to set NULL cache error exception handler\n";
  2340	
  2341	/*
  2342	 * Install uncached CPU exception handler.
  2343	 * This is suitable only for the cache error exception which is the only
  2344	 * exception handler that is being run uncached.
  2345	 */
  2346	void set_uncached_handler(unsigned long offset, void *addr,
  2347		unsigned long size)
  2348	{
> 2349		unsigned long uncached_ebase = TO_UNCAC(__pa(ebase));
  2350	
  2351		if (!addr)
  2352			panic(panic_null_cerr);
  2353	
  2354		memcpy((void *)(uncached_ebase + offset), addr, size);
  2355	}
  2356	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
