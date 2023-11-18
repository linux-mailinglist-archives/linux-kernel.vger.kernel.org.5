Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF63F7F02EF
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 21:41:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbjKRUlo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 15:41:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbjKRUlm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 15:41:42 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CBDAD5
        for <linux-kernel@vger.kernel.org>; Sat, 18 Nov 2023 12:41:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700340098; x=1731876098;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SNOxp2VKi69QamJfV6FHH/Q0V+/45fY4L6p3Mwj1vf0=;
  b=Vfk/mn+K6AafoMYqZ/UuyXhAoXv5xAlzyQJrohW9IM7h4Hn9nmweqB63
   FvTgM6QDL8KYLPibHQcqiHw7kFbhaMFltzL8dYWGVz0okuZVFRGlA12dy
   cy51FXRYcLdFxeTvk7yoU8zdwRj9YXhgenYDdwCbMxWpqaz+S3RoyJqRb
   gNsE2l4prUMtjhIZdaBVqXoTuh9SdEqxjxK1PKXwMYtJQOSsy2ds7uYQy
   jQxsn8aNzmoZvkGza7CLU5P+9GUOlI/OHyh3aEnrr+OlvdnONVgH2HNdG
   54g2BET1jWY77l+Nm1+7i6PhhW3+4n2eEdpCW3JDrsvrEjEU7y7RU99DU
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10898"; a="477670331"
X-IronPort-AV: E=Sophos;i="6.04,209,1695711600"; 
   d="scan'208";a="477670331"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2023 12:41:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10898"; a="742376792"
X-IronPort-AV: E=Sophos;i="6.04,209,1695711600"; 
   d="scan'208";a="742376792"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 18 Nov 2023 12:41:35 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r4S8D-0004GV-1o;
        Sat, 18 Nov 2023 20:41:33 +0000
Date:   Sun, 19 Nov 2023 04:40:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     qiwuchen55@gmail.com, catalin.marinas@arm.com, will@kernel.org
Cc:     oe-kbuild-all@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        chenqiwu <qiwu.chen@transsion.com>
Subject: Re: [PATCH] arm64: Add user stacktrace support
Message-ID: <202311190405.QUvoF0b3-lkp@intel.com>
References: <20231118134504.154842-1-qiwu.chen@transsion.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231118134504.154842-1-qiwu.chen@transsion.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on arm64/for-next/core]
[also build test WARNING on linus/master v6.7-rc1 next-20231117]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/qiwuchen55-gmail-com/arm64-Add-user-stacktrace-support/20231118-214756
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/core
patch link:    https://lore.kernel.org/r/20231118134504.154842-1-qiwu.chen%40transsion.com
patch subject: [PATCH] arm64: Add user stacktrace support
config: arm64-randconfig-r071-20231119 (https://download.01.org/0day-ci/archive/20231119/202311190405.QUvoF0b3-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231119/202311190405.QUvoF0b3-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311190405.QUvoF0b3-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> arch/arm64/kernel/stacktrace.c:393: warning: expecting prototype for stack_trace_save_user(). Prototype was for arch_stack_walk_user() instead


vim +393 arch/arm64/kernel/stacktrace.c

   384	
   385	/**
   386	 * stack_trace_save_user - Save user space stack traces into a storage array
   387	 * @consume_entry: Callback for save a user space stack trace
   388	 * @cookie:	Caller supplied pointer handed back by arch_stack_walk()
   389	 * @regs: The pt_regs pointer of current task
   390	 */
   391	void arch_stack_walk_user(stack_trace_consume_fn consume_entry, void *cookie,
   392				  const struct pt_regs *regs)
 > 393	{
   394		struct stack_frame_user frame;
   395		struct vm_area_struct *vma;
   396		unsigned long userstack_start, userstack_end;
   397		struct task_struct *tsk = current;
   398	
   399		/* TODO: support stack unwind for compat user mode */
   400		if (!regs || !user_mode(regs) || compat_user_mode(regs))
   401			return;
   402	
   403		userstack_start = regs->user_regs.sp;
   404		vma = find_user_stack_vma(tsk, userstack_start);
   405		if (!vma)
   406			return;
   407	
   408		userstack_end = vma->vm_end;
   409		frame.fp = regs->user_regs.regs[29];
   410		frame.sp = userstack_start;
   411		frame.pc = regs->user_regs.pc;
   412	
   413		while (1) {
   414			unsigned long where = frame.pc;
   415	
   416			/* Sanity check: ABI requires pc to be aligned 4 bytes. */
   417			if (!where || where & 0x3)
   418				break;
   419			if (!consume_entry(cookie, where))
   420				break;
   421			if (arch_unwind_user_frame(tsk, userstack_end, &frame) < 0)
   422				break;
   423		}
   424	}
   425	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
