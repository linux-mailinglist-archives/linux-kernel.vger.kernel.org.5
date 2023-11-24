Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20EF27F77F0
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 16:41:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbjKXPlU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 10:41:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230491AbjKXPlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 10:41:18 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 861851998;
        Fri, 24 Nov 2023 07:41:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700840484; x=1732376484;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=c2Vqe3x33aE9kTCdbYkqqP9jPVzZrJzKmfGmmqpORXA=;
  b=UKu3pAixytuP9mXP+dVovdcu4prB5K0S0sf8xDG9pxdtoJ2FhQLm2Rsm
   thpV+hHN9KbYVqN590wnOqCs6Cm+Ikz0xpQUSlesSq8g8yD/SgJD6cUBK
   XUpWJ23SWGXb9i6dEwkhFbyWBfbUReqo4njc3BEOWIMxAOGAsRarY7Xad
   ytxEKJMQMMUPPHYfjw6Sd34Z3UfrRlusxaigGklUFTe0+lX8Ks2aYYfek
   p6kQlxBbWFYB/Wp8yyIvfw5q4/LN21oMVLprxbCqY9MNGbX8PW/JAf9F3
   cRFl8fLdX3Tcougam8F1EWLGMfGse3xtXJ1mRzCFYPQX/aFn417h8+o7U
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10904"; a="423577097"
X-IronPort-AV: E=Sophos;i="6.04,224,1695711600"; 
   d="scan'208";a="423577097"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2023 07:41:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10904"; a="833714362"
X-IronPort-AV: E=Sophos;i="6.04,224,1695711600"; 
   d="scan'208";a="833714362"
Received: from lkp-server01.sh.intel.com (HELO d584ee6ebdcc) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 24 Nov 2023 07:41:21 -0800
Received: from kbuild by d584ee6ebdcc with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r6YIx-0002xm-2k;
        Fri, 24 Nov 2023 15:41:19 +0000
Date:   Fri, 24 Nov 2023 23:40:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, JP Kobryn <inwardvessel@gmail.com>,
        bpf@vger.kernel.org, kernel-team@meta.com, rostedt@goodmis.org,
        peterz@infradead.org
Subject: Re: [PATCH] rethook: Use __rcu pointer for rethook::handler
Message-ID: <202311241808.rv9ceuAh-lkp@intel.com>
References: <170078778632.209874.7893551840863388753.stgit@devnote2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170078778632.209874.7893551840863388753.stgit@devnote2>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masami,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.7-rc2 next-20231124]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Masami-Hiramatsu-Google/rethook-Use-__rcu-pointer-for-rethook-handler/20231124-090634
base:   linus/master
patch link:    https://lore.kernel.org/r/170078778632.209874.7893551840863388753.stgit%40devnote2
patch subject: [PATCH] rethook: Use __rcu pointer for rethook::handler
config: x86_64-randconfig-r113-20231124 (https://download.01.org/0day-ci/archive/20231124/202311241808.rv9ceuAh-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231124/202311241808.rv9ceuAh-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311241808.rv9ceuAh-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> kernel/trace/rethook.c:51:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
>> kernel/trace/rethook.c:51:9: sparse:    void ( [noderef] __rcu * )( ... )
>> kernel/trace/rethook.c:51:9: sparse:    void ( * )( ... )
   kernel/trace/rethook.c:66:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/trace/rethook.c:66:9: sparse:    void ( [noderef] __rcu * )( ... )
   kernel/trace/rethook.c:66:9: sparse:    void ( * )( ... )
   kernel/trace/rethook.c:110:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/trace/rethook.c:110:9: sparse:    void ( [noderef] __rcu * )( ... )
   kernel/trace/rethook.c:110:9: sparse:    void ( * )( ... )
   kernel/trace/rethook.c:140:19: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/trace/rethook.c:140:19: sparse:    void ( [noderef] __rcu * )( ... )
   kernel/trace/rethook.c:140:19: sparse:    void ( * )( ... )
   kernel/trace/rethook.c:161:19: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/trace/rethook.c:161:19: sparse:    void ( [noderef] __rcu * )( ... )
   kernel/trace/rethook.c:161:19: sparse:    void ( * )( ... )
   kernel/trace/rethook.c:305:27: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/trace/rethook.c:305:27: sparse:    void ( [noderef] __rcu * )( ... )
   kernel/trace/rethook.c:305:27: sparse:    void ( * )( ... )

vim +51 kernel/trace/rethook.c

    40	
    41	/**
    42	 * rethook_stop() - Stop using a rethook.
    43	 * @rh: the struct rethook to stop.
    44	 *
    45	 * Stop using a rethook to prepare for freeing it. If you want to wait for
    46	 * all running rethook handler before calling rethook_free(), you need to
    47	 * call this first and wait RCU, and call rethook_free().
    48	 */
    49	void rethook_stop(struct rethook *rh)
    50	{
  > 51		rcu_assign_pointer(rh->handler, NULL);
    52	}
    53	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
