Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 002F67C4714
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 03:14:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344550AbjJKBOJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 21:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343612AbjJKBOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 21:14:07 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 582868F;
        Tue, 10 Oct 2023 18:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696986846; x=1728522846;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yO2zbp4g6B054PlPVAli+XIoKyz9al7LS+sIVuCBe2I=;
  b=YWVNXLAOILUY359Uj9RWEbsy9R5PLNDShDUgz0LvUhAIqS2mnWnjgZIg
   bNhKt2iegNRRPLZBI9azT/OZb3h7WRNuQe3zzzgeI9ucp3+SKSrVPJNQB
   feB9BPg2VmH3PUW3X73Bme5C8pOcgZ58/F/0sUH+B0C1fTlXXq7f1s54U
   Tph6EiUlO48R2E9p16GmJ6U0vLgCHShBiwcdK5k/v8RVBCd8npUxj5nYc
   QQunAdImUUL+e+e/p4UAzYBfoLtuNRmF+SrfoesrdHzRI9nSyX5bstXpJ
   DHEycf3De/08+ySizbFzdciFjbes9NOxHj5Cg01q+L/cf676R3kzaADXC
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="387395679"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="387395679"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 18:14:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="783067102"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="783067102"
Received: from lkp-server02.sh.intel.com (HELO f64821696465) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 10 Oct 2023 18:14:02 -0700
Received: from kbuild by f64821696465 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qqNnU-0001U6-1B;
        Wed, 11 Oct 2023 01:14:00 +0000
Date:   Wed, 11 Oct 2023 09:13:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jinyu Tang <tangjinyu@tinylab.org>, rostedt@goodmis.org,
        mhiramat@kernel.org, bristot@kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, ttjjyystupid@163.com,
        falcon@tinylab.org, wangjiexun@tinylab.org,
        linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jinyu Tang <tangjinyu@tinylab.org>
Subject: Re: [PATCH v1] Ftrace: make sched_wakeup can focus on the target
 process
Message-ID: <202310110813.FxuaTrH0-lkp@intel.com>
References: <20231009153714.10743-1-tangjinyu@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231009153714.10743-1-tangjinyu@tinylab.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jinyu,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on rostedt-trace/for-next v6.6-rc5 next-20231010]
[cannot apply to rostedt-trace/for-next-urgent]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jinyu-Tang/Ftrace-make-sched_wakeup-can-focus-on-the-target-process/20231009-234127
base:   linus/master
patch link:    https://lore.kernel.org/r/20231009153714.10743-1-tangjinyu%40tinylab.org
patch subject: [PATCH v1] Ftrace: make sched_wakeup can focus on the target process
config: i386-randconfig-062-20231010 (https://download.01.org/0day-ci/archive/20231011/202310110813.FxuaTrH0-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231011/202310110813.FxuaTrH0-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310110813.FxuaTrH0-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> kernel/trace/trace_sched_wakeup.c:368:1: sparse: sparse: symbol 'sched_wakeup_mutex' was not declared. Should it be static?

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
