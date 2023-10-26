Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDBF37D7F37
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 11:03:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbjJZJDb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 05:03:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjJZJDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 05:03:30 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 180F210E
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 02:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698311008; x=1729847008;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tdMCYhhtdDyuQ1YyIqyhjZ6BXjSHRnJQZrR/uUizRRA=;
  b=cTWFYcXVXDQYzMxza63AL4Z/w3sjJKTdVjDwhaPbPaKtP8ObBIW+D6Nx
   8kH1KYTgytkz5cG+nHaYWOlu8ZtPBJbK1FGJxcv1acsYkBrYkwIEFnu7S
   Ecwz+GwPVhVR/wF6w/WMylBLnoFqgZnykN152licc735DVfBi54FgyyFc
   IZcDfCSSjp29WdlszP1EtiI3p1/vJaJqUF7FOy1aJPEldJT2SmS7ouTrL
   HDb8VdQXy1yHHKX7ZNTUQwz3uzQCiRD7V5i+YGV+KXJyR8TkO1oHso8y+
   roLZ6aX15iRdYCzOhcJ9Pi4CuOUeK489BL2B2Q8Nsu/aPzsJ3bzQBsFgP
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="386376293"
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; 
   d="scan'208";a="386376293"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2023 02:03:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="752648781"
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; 
   d="scan'208";a="752648781"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 26 Oct 2023 02:03:13 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qvwGl-0009fP-1J;
        Thu, 26 Oct 2023 09:03:11 +0000
Date:   Thu, 26 Oct 2023 17:02:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, virtualization@lists.linux-foundation.org
Cc:     oe-kbuild-all@lists.linux.dev, Juergen Gross <jgross@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ajay Kaher <akaher@vmware.com>,
        Alexey Makhalov <amakhalov@vmware.com>,
        VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v3 4/5] x86/paravirt: switch mixed paravirt/alternative
 calls to alternative_2
Message-ID: <202310261653.LKIRqagq-lkp@intel.com>
References: <20231019091520.14540-5-jgross@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231019091520.14540-5-jgross@suse.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Juergen,

kernel test robot noticed the following build errors:

[auto build test ERROR on kvm/queue]
[also build test ERROR on tip/master linus/master v6.6-rc7 next-20231025]
[cannot apply to tip/x86/core kvm/linux-next tip/auto-latest]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Juergen-Gross/x86-paravirt-move-some-functions-and-defines-to-alternative/20231019-171709
base:   https://git.kernel.org/pub/scm/virt/kvm/kvm.git queue
patch link:    https://lore.kernel.org/r/20231019091520.14540-5-jgross%40suse.com
patch subject: [PATCH v3 4/5] x86/paravirt: switch mixed paravirt/alternative calls to alternative_2
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20231026/202310261653.LKIRqagq-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231026/202310261653.LKIRqagq-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310261653.LKIRqagq-lkp@intel.com/

All errors (new ones prefixed by >>):

   arch/x86/entry/entry_64.S: Assembler messages:
>> arch/x86/entry/entry_64.S:454: Error: no such instruction: `alt_call_instr'
   arch/x86/entry/entry_64.S:319:  Info: macro invoked from here
   arch/x86/entry/entry_64.S:1138:   Info: macro invoked from here


vim +454 arch/x86/entry/entry_64.S

6368558c37107b Thomas Gleixner 2020-05-21  442  
cfa82a00533f70 Thomas Gleixner 2020-02-25  443  /**
cfa82a00533f70 Thomas Gleixner 2020-02-25  444   * idtentry_mce_db - Macro to generate entry stubs for #MC and #DB
cfa82a00533f70 Thomas Gleixner 2020-02-25  445   * @vector:		Vector number
cfa82a00533f70 Thomas Gleixner 2020-02-25  446   * @asmsym:		ASM symbol for the entry point
cfa82a00533f70 Thomas Gleixner 2020-02-25  447   * @cfunc:		C function to be called
cfa82a00533f70 Thomas Gleixner 2020-02-25  448   *
cfa82a00533f70 Thomas Gleixner 2020-02-25  449   * The macro emits code to set up the kernel context for #MC and #DB
cfa82a00533f70 Thomas Gleixner 2020-02-25  450   *
cfa82a00533f70 Thomas Gleixner 2020-02-25  451   * If the entry comes from user space it uses the normal entry path
cfa82a00533f70 Thomas Gleixner 2020-02-25  452   * including the return to user space work and preemption checks on
cfa82a00533f70 Thomas Gleixner 2020-02-25  453   * exit.
cfa82a00533f70 Thomas Gleixner 2020-02-25 @454   *
cfa82a00533f70 Thomas Gleixner 2020-02-25  455   * If hits in kernel mode then it needs to go through the paranoid
cfa82a00533f70 Thomas Gleixner 2020-02-25  456   * entry as the exception can hit any random state. No preemption
cfa82a00533f70 Thomas Gleixner 2020-02-25  457   * check on exit to keep the paranoid path simple.
cfa82a00533f70 Thomas Gleixner 2020-02-25  458   */
cfa82a00533f70 Thomas Gleixner 2020-02-25  459  .macro idtentry_mce_db vector asmsym cfunc
cfa82a00533f70 Thomas Gleixner 2020-02-25  460  SYM_CODE_START(\asmsym)
4708ea14bef314 Josh Poimboeuf  2023-03-01  461  	UNWIND_HINT_IRET_ENTRY
8f93402b92d443 Peter Zijlstra  2022-03-08  462  	ENDBR
cfa82a00533f70 Thomas Gleixner 2020-02-25  463  	ASM_CLAC
c64cc2802a784e Lai Jiangshan   2022-04-21  464  	cld
cfa82a00533f70 Thomas Gleixner 2020-02-25  465  
cfa82a00533f70 Thomas Gleixner 2020-02-25  466  	pushq	$-1			/* ORIG_RAX: no syscall to restart */
cfa82a00533f70 Thomas Gleixner 2020-02-25  467  
cfa82a00533f70 Thomas Gleixner 2020-02-25  468  	/*
cfa82a00533f70 Thomas Gleixner 2020-02-25  469  	 * If the entry is from userspace, switch stacks and treat it as
cfa82a00533f70 Thomas Gleixner 2020-02-25  470  	 * a normal entry.
cfa82a00533f70 Thomas Gleixner 2020-02-25  471  	 */
cfa82a00533f70 Thomas Gleixner 2020-02-25  472  	testb	$3, CS-ORIG_RAX(%rsp)
cfa82a00533f70 Thomas Gleixner 2020-02-25  473  	jnz	.Lfrom_usermode_switch_stack_\@
cfa82a00533f70 Thomas Gleixner 2020-02-25  474  
c82965f9e53005 Chang S. Bae    2020-05-28  475  	/* paranoid_entry returns GS information for paranoid_exit in EBX. */
cfa82a00533f70 Thomas Gleixner 2020-02-25  476  	call	paranoid_entry
cfa82a00533f70 Thomas Gleixner 2020-02-25  477  
cfa82a00533f70 Thomas Gleixner 2020-02-25  478  	UNWIND_HINT_REGS
cfa82a00533f70 Thomas Gleixner 2020-02-25  479  
cfa82a00533f70 Thomas Gleixner 2020-02-25  480  	movq	%rsp, %rdi		/* pt_regs pointer */
cfa82a00533f70 Thomas Gleixner 2020-02-25  481  
cfa82a00533f70 Thomas Gleixner 2020-02-25  482  	call	\cfunc
cfa82a00533f70 Thomas Gleixner 2020-02-25  483  
cfa82a00533f70 Thomas Gleixner 2020-02-25  484  	jmp	paranoid_exit
cfa82a00533f70 Thomas Gleixner 2020-02-25  485  
cfa82a00533f70 Thomas Gleixner 2020-02-25  486  	/* Switch to the regular task stack and use the noist entry point */
cfa82a00533f70 Thomas Gleixner 2020-02-25  487  .Lfrom_usermode_switch_stack_\@:
e2dcb5f1390715 Thomas Gleixner 2020-05-21  488  	idtentry_body noist_\cfunc, has_error_code=0
cfa82a00533f70 Thomas Gleixner 2020-02-25  489  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
