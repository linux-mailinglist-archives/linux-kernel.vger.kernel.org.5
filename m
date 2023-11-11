Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D32A7E88EE
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 04:20:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbjKKDUo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 22:20:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjKKDUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 22:20:43 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 510152591;
        Fri, 10 Nov 2023 19:20:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699672840; x=1731208840;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ARkRUyOLAIpmhjp2siRoxLvSfsSs3MBz/hMYy9pew/w=;
  b=AOPVxStzq3WLv8dklIznsqvANgMNRoeoe/egCa3ClRsLuMEVgLMQs/Jj
   e+4T7c3uEDQK4cF1aXzK7gRUVHruqks0BVQFCXCvHXf3kDOdxAkcS/sx5
   5J1FL/6jau0pHgcZoYdKLpDiAOSnMtEDBLDZS9V6ECGKKPhczDYUUYCLU
   4jMiIG8md9RTD8b/H0EeqTVOwhWwVEyfOFtEHWzjOkf9jLSgFM6DsvvnE
   Lrnr1eGLjkFaGzfLr/X/5lTPG7NsFfi+i3C2enwcFoHWyGghM8tRseg2Y
   lFxdZSqVP2jDWxs3LMu77kl3tCwPyLwW1VLvgF3KARmSudjKWSV1JZvzW
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10890"; a="375286638"
X-IronPort-AV: E=Sophos;i="6.03,294,1694761200"; 
   d="scan'208";a="375286638"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2023 19:20:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10890"; a="792980847"
X-IronPort-AV: E=Sophos;i="6.03,294,1694761200"; 
   d="scan'208";a="792980847"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 10 Nov 2023 19:20:37 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r1eXy-000AAc-2V;
        Sat, 11 Nov 2023 03:20:34 +0000
Date:   Sat, 11 Nov 2023 11:19:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Petr Mladek <pmladek@suse.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Nicolai Stange <nstange@suse.de>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>
Subject: Re: [POC 1/7] livepatch: Add callbacks for introducing and removing
 states
Message-ID: <202311111107.avVIpRi2-lkp@intel.com>
References: <20231110170428.6664-2-pmladek@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231110170428.6664-2-pmladek@suse.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Petr,

kernel test robot noticed the following build warnings:

[auto build test WARNING on shuah-kselftest/next]
[also build test WARNING on shuah-kselftest/fixes linus/master v6.6 next-20231110]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Petr-Mladek/livepatch-Add-callbacks-for-introducing-and-removing-states/20231111-014906
base:   https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git next
patch link:    https://lore.kernel.org/r/20231110170428.6664-2-pmladek%40suse.com
patch subject: [POC 1/7] livepatch: Add callbacks for introducing and removing states
config: x86_64-rhel-8.3-rust (https://download.01.org/0day-ci/archive/20231111/202311111107.avVIpRi2-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231111/202311111107.avVIpRi2-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311111107.avVIpRi2-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> kernel/livepatch/state.c:121:6: warning: no previous prototype for function 'is_state_in_other_patches' [-Wmissing-prototypes]
   bool is_state_in_other_patches(struct klp_patch *patch, struct klp_state *state)
        ^
   kernel/livepatch/state.c:121:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   bool is_state_in_other_patches(struct klp_patch *patch, struct klp_state *state)
   ^
   static 
   1 warning generated.


vim +/is_state_in_other_patches +121 kernel/livepatch/state.c

   120	
 > 121	bool is_state_in_other_patches(struct klp_patch *patch, struct klp_state *state)
   122	{
   123		struct klp_patch *old_patch;
   124		struct klp_state *old_state;
   125	
   126		klp_for_each_patch(old_patch) {
   127			if (old_patch == patch)
   128				continue;
   129	
   130			klp_for_each_state(old_patch, old_state) {
   131				if (old_state->id == state->id)
   132					return true;
   133			}
   134		}
   135	
   136		return false;
   137	}
   138	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
