Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 364BB7E1293
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Nov 2023 09:27:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbjKEIXl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 03:23:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjKEIXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 03:23:40 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 085DFCF
        for <linux-kernel@vger.kernel.org>; Sun,  5 Nov 2023 01:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699172618; x=1730708618;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Fqz4lBC6dj/6UYRcXKGwmUtlDzxYIW1DwLc6SmZYKFY=;
  b=JJthOaC/cV0pxHl2OYJsG3lnjKdFbYi81YAbC8WOn272vOlue0ghPmsm
   y2YauNx4f9fdL4F9qvcfcXUyssgp9FUuux9wSS8bV+sRTc2osVU5NQj/E
   tgNkLwAgnyq8SqNTxGdNOMiScmlEpu7TqOnkMuw2637Bgi6y68q09Ak25
   vBiZccpmesY67+6Sv3ZSwRQ6SP0AqwuawXvU9ZNRH5INpkgl4NfnQonwr
   xgeKA3Lb/ymws6iOAae0xJoaocbmbFswT0U4rmHQBYCleWt8BsSuXaMHF
   h/c4uvFK+Ud/NR3M7Q3uy6zCBdiTmeLtd4p6KGNgZWuWxBXE1KcNVGPfD
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10884"; a="2106515"
X-IronPort-AV: E=Sophos;i="6.03,278,1694761200"; 
   d="scan'208";a="2106515"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2023 01:23:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,278,1694761200"; 
   d="scan'208";a="9802286"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 05 Nov 2023 01:23:35 -0700
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qzYPs-0005Bs-29;
        Sun, 05 Nov 2023 08:23:32 +0000
Date:   Sun, 5 Nov 2023 16:23:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     Uros Bizjak <ubizjak@gmail.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, Uros Bizjak <ubizjak@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 3/3] x86/callthunks: Fix and unify call thunks assembly
 snippets
Message-ID: <202311051652.38OyamEq-lkp@intel.com>
References: <20231102112850.3448745-4-ubizjak@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231102112850.3448745-4-ubizjak@gmail.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Uros,

kernel test robot noticed the following build errors:

[auto build test ERROR on tip/x86/core]
[also build test ERROR on tip/master tip/auto-latest linus/master v6.6 next-20231103]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Uros-Bizjak/x86-callthunks-Move-call-thunk-template-to-S-file/20231102-193542
base:   tip/x86/core
patch link:    https://lore.kernel.org/r/20231102112850.3448745-4-ubizjak%40gmail.com
patch subject: [PATCH 3/3] x86/callthunks: Fix and unify call thunks assembly snippets
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20231105/202311051652.38OyamEq-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231105/202311051652.38OyamEq-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311051652.38OyamEq-lkp@intel.com/

All errors (new ones prefixed by >>):

   /tmp/ccwZh9MG.s: Assembler messages:
>> /tmp/ccwZh9MG.s:27: Error: junk `(pcpu_hot+16)' after expression
>> /tmp/ccwZh9MG.s:27: Error: junk `(__x86_call_count)' after expression

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
