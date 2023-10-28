Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D7D77DA830
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 19:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbjJ1RPm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Oct 2023 13:15:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjJ1RPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Oct 2023 13:15:40 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C77E11F
        for <linux-kernel@vger.kernel.org>; Sat, 28 Oct 2023 10:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698513335; x=1730049335;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Yat7hK8CnokZkhtzDWk7L5zPuap20RZoYveWqGkLz0A=;
  b=PD4qugeNQ+H68HWSZ0pvKbWsCoQZQY85ip7KEVvraT3BPsiAENYoyDsy
   iaKktHW3XvkVvlZuydkEIHuNkkUupppAgqjdKLzS4l6ykl3NK3utc7vun
   9dvPxXOtarVa3p3YY/pqeeKdTIivsuw24yGThvpESj/JzyfGP0qBWNzqi
   juTBVG3ojAKsuSkAfTDG8FcTuncV914Z85Me/0Pkyp/mxl7t8XOkwnFCy
   Iybvq9GDcSNF9OfE16VPNOxbTVXGKYioAANExa53i4l4QAZaFgJ6LRanA
   M9GqIV5Guc4kY4f7yraYHAIq8yQz4Vx8FYeTUJYZOBWIkoG7KUhyl6hEB
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10877"; a="385115271"
X-IronPort-AV: E=Sophos;i="6.03,259,1694761200"; 
   d="scan'208";a="385115271"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2023 10:15:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10877"; a="933393801"
X-IronPort-AV: E=Sophos;i="6.03,259,1694761200"; 
   d="scan'208";a="933393801"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 28 Oct 2023 10:15:31 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qwmuH-000Bvl-1Z;
        Sat, 28 Oct 2023 17:15:29 +0000
Date:   Sun, 29 Oct 2023 01:14:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Woodhouse <dwmw2@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH] lockdep: add lockdep_cleanup_dead_cpu()
Message-ID: <202310290041.L5ndwcQ9-lkp@intel.com>
References: <e5ba02138c31da60daf91ce505ac3860d022332b.camel@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e5ba02138c31da60daf91ce505ac3860d022332b.camel@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tip/smp/core]
[also build test WARNING on tip/locking/core linus/master v6.6-rc7 next-20231027]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/David-Woodhouse/lockdep-add-lockdep_cleanup_dead_cpu/20231028-191538
base:   tip/smp/core
patch link:    https://lore.kernel.org/r/e5ba02138c31da60daf91ce505ac3860d022332b.camel%40infradead.org
patch subject: [PATCH] lockdep: add lockdep_cleanup_dead_cpu()
config: powerpc-allyesconfig (https://download.01.org/0day-ci/archive/20231029/202310290041.L5ndwcQ9-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231029/202310290041.L5ndwcQ9-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310290041.L5ndwcQ9-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> kernel/locking/lockdep.c:4557: warning: Function parameter or member 'cpu' not described in 'lockdep_cleanup_dead_cpu'
>> kernel/locking/lockdep.c:4557: warning: Function parameter or member 'idle' not described in 'lockdep_cleanup_dead_cpu'


vim +4557 kernel/locking/lockdep.c

  4548	
  4549	/**
  4550	 * lockdep_cleanup_dead_cpu - Ensure CPU lockdep state is cleanly stopped
  4551	 *
  4552	 * Invoked after the CPU is dead. Ensures that the tracing infrastructure
  4553	 * is left in a suitable state for the CPU to be subsequently brought
  4554	 * online again.
  4555	 */
  4556	void lockdep_cleanup_dead_cpu(unsigned int cpu, struct task_struct *idle)
> 4557	{
  4558		if (unlikely(!debug_locks))
  4559			return;
  4560	
  4561		if (unlikely(per_cpu(hardirqs_enabled, cpu))) {
  4562			pr_warn("CPU %u left hardirqs enabled!", cpu);
  4563			if (idle)
  4564				print_irqtrace_events(idle);
  4565			/* Clean it up for when the CPU comes online again. */
  4566			per_cpu(hardirqs_enabled, cpu) = 0;
  4567		}
  4568	}
  4569	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
