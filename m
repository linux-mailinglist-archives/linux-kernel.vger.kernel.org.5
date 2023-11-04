Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D28A57E1016
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 16:27:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbjKDPTs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 11:19:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjKDPTq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 11:19:46 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD9A7D42
        for <linux-kernel@vger.kernel.org>; Sat,  4 Nov 2023 08:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699111184; x=1730647184;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=E4nONcAXaviUdfS4mzCeKC117uG33wBRWuTHxe4gC1U=;
  b=DWbWJamr2tHreBunGGl7x7cVJIqaKDgXue6IYFjMJ71JmYMaG5StVaLA
   yp3Gegd5zwSvLQHLS/B7tmwIAo06WfK8KcOi/Vf2zq0xbOER4F5o1epOn
   jDBw5jDTpTEayCuPPrNWO2mzM0yJacu8tbx8LiNKt0F2++DxUGA0IXOuk
   KMp+DO38Y7fmVpTjodamFBXq7KeKYBfw6ZbsoI+j8RHQoZgBe6XM3Mt4B
   DNZOJeAIRX9z+9stDlCkmLlBJVupLkxSTb7Pq3Hw5AkMpa0e4i1rJdlFX
   UukH+HwJd1HhqTb36fGMgtR1KD5Oi3dKuTFNEMvC48OpPopJIHkhm3vTo
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10884"; a="10628310"
X-IronPort-AV: E=Sophos;i="6.03,277,1694761200"; 
   d="scan'208";a="10628310"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2023 08:19:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10884"; a="905639119"
X-IronPort-AV: E=Sophos;i="6.03,277,1694761200"; 
   d="scan'208";a="905639119"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 04 Nov 2023 08:19:38 -0700
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qzIQy-0004Va-2f;
        Sat, 04 Nov 2023 15:19:36 +0000
Date:   Sat, 4 Nov 2023 23:18:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     oe-kbuild-all@lists.linux.dev,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org,
        Luca Abeni <luca.abeni@santannapisa.it>,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
        Thomas Gleixner <tglx@linutronix.de>,
        Joel Fernandes <joel@joelfernandes.org>,
        Vineeth Pillai <vineeth@bitbyteword.org>,
        Shuah Khan <skhan@linuxfoundation.org>, bristot@kernel.org,
        Phil Auld <pauld@redhat.com>
Subject: Re: [PATCH v5 7/7] sched/fair: Fair server interface
Message-ID: <202311042329.PB1gTIL4-lkp@intel.com>
References: <26adad2378c8b15533e4f6216c2863341e587f57.1699095159.git.bristot@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26adad2378c8b15533e4f6216c2863341e587f57.1699095159.git.bristot@kernel.org>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tip/sched/core]
[also build test WARNING on tip/master linus/master next-20231103]
[cannot apply to tip/auto-latest v6.6]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Daniel-Bristot-de-Oliveira/sched-Unify-runtime-accounting-across-classes/20231104-201952
base:   tip/sched/core
patch link:    https://lore.kernel.org/r/26adad2378c8b15533e4f6216c2863341e587f57.1699095159.git.bristot%40kernel.org
patch subject: [PATCH v5 7/7] sched/fair: Fair server interface
config: i386-buildonly-randconfig-001-20231104 (https://download.01.org/0day-ci/archive/20231104/202311042329.PB1gTIL4-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231104/202311042329.PB1gTIL4-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311042329.PB1gTIL4-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from kernel/sched/build_utility.c:72:
>> kernel/sched/debug.c:342:57: warning: integer overflow in expression of type 'long int' results in '-100663296' [-Woverflow]
     342 | static unsigned long fair_server_period_max = (1 << 22) * NSEC_PER_USEC; /* ~4 seconds */
         |                                                         ^


vim +342 kernel/sched/debug.c

   341	
 > 342	static unsigned long fair_server_period_max = (1 << 22) * NSEC_PER_USEC; /* ~4 seconds */
   343	static unsigned long fair_server_period_min = (100) * NSEC_PER_USEC;     /* 100 us */
   344	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
