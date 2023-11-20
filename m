Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B55C17F2094
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 23:48:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbjKTWs3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 17:48:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjKTWs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 17:48:27 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38CBDC8;
        Mon, 20 Nov 2023 14:48:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700520504; x=1732056504;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fTRRJlE/QbOq1AY/NZVPgjpWsBGhsZKTJso+C3zB68Y=;
  b=FYceWNAm3FxsNile2LQa73XiAFod4K/XXvi6V5s6CGAKYNeN17G2OQp+
   wKso7kAtZebja2OgziYQtMn7Yik0o7htksmfUZsch4Vfqw0BlbUPkDh6h
   htKthh1aYTZ1HMpkaF0MvbKzzUkFl7qc8qO5eM1CVJhiQ2WeaP9HTbJjM
   reCPHq6y3SvzYbHaph2vMXyd+C6Jm/lKZ9MBqWunAk4bQ/z9YIOR9Grpu
   ut0tyd51yY3qvPQ59yaKes/gj+dDXOqZ8z/WSOQnd84gzMLC/3YL1WDwd
   5dtC9Vt31/1tKz1pdTHJd4tv0zwb1wjjtYmhdNGoFcfG8SLS2BacZUiY2
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="4913017"
X-IronPort-AV: E=Sophos;i="6.04,214,1695711600"; 
   d="scan'208";a="4913017"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 14:48:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="939914968"
X-IronPort-AV: E=Sophos;i="6.04,214,1695711600"; 
   d="scan'208";a="939914968"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 20 Nov 2023 14:48:15 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r5D3t-00071M-1K;
        Mon, 20 Nov 2023 22:48:13 +0000
Date:   Tue, 21 Nov 2023 06:47:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-arch@vger.kernel.org, x86@kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, Jason Baron <jbaron@akamai.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Feng Tang <feng.tang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>,
        Michael Kelley <mikelley@microsoft.com>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Subject: Re: [PATCH 1/5] jump_label,module: Don't alloc static_key_mod for
 __ro_after_init keys
Message-ID: <202311210601.9dbatTYU-lkp@intel.com>
References: <20231120105528.760306-2-vschneid@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231120105528.760306-2-vschneid@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Valentin,

kernel test robot noticed the following build errors:

[auto build test ERROR on tip/x86/core]
[also build test ERROR on linus/master v6.7-rc2 next-20231120]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Valentin-Schneider/jump_label-module-Don-t-alloc-static_key_mod-for-__ro_after_init-keys/20231120-190044
base:   tip/x86/core
patch link:    https://lore.kernel.org/r/20231120105528.760306-2-vschneid%40redhat.com
patch subject: [PATCH 1/5] jump_label,module: Don't alloc static_key_mod for __ro_after_init keys
config: i386-allnoconfig (https://download.01.org/0day-ci/archive/20231121/202311210601.9dbatTYU-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231121/202311210601.9dbatTYU-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311210601.9dbatTYU-lkp@intel.com/

All errors (new ones prefixed by >>):

>> init/main.c:1406:3: error: call to undeclared function 'jump_label_ro'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
                   jump_label_ro();
                   ^
   init/main.c:1406:3: note: did you mean 'jump_label_lock'?
   include/linux/jump_label.h:315:20: note: 'jump_label_lock' declared here
   static inline void jump_label_lock(void) {}
                      ^
   1 error generated.


vim +/jump_label_ro +1406 init/main.c

  1394	
  1395	#ifdef CONFIG_STRICT_KERNEL_RWX
  1396	static void mark_readonly(void)
  1397	{
  1398		if (rodata_enabled) {
  1399			/*
  1400			 * load_module() results in W+X mappings, which are cleaned
  1401			 * up with call_rcu().  Let's make sure that queued work is
  1402			 * flushed so that we don't hit false positives looking for
  1403			 * insecure pages which are W+X.
  1404			 */
  1405			rcu_barrier();
> 1406			jump_label_ro();
  1407			mark_rodata_ro();
  1408			rodata_test();
  1409		} else
  1410			pr_info("Kernel memory protection disabled.\n");
  1411	}
  1412	#elif defined(CONFIG_ARCH_HAS_STRICT_KERNEL_RWX)
  1413	static inline void mark_readonly(void)
  1414	{
  1415		pr_warn("Kernel memory protection not selected by kernel config.\n");
  1416	}
  1417	#else
  1418	static inline void mark_readonly(void)
  1419	{
  1420		pr_warn("This architecture does not have kernel memory protection.\n");
  1421	}
  1422	#endif
  1423	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
