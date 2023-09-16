Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2CAA7A2E63
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 09:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233424AbjIPHYE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Sep 2023 03:24:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232865AbjIPHXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Sep 2023 03:23:48 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D16B6CD8;
        Sat, 16 Sep 2023 00:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694849022; x=1726385022;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=c8i88xw7kqkRtm+RFJUtTj4XqEyRCmEHSLpdILSbhQA=;
  b=IwIbhVEFS9ctTz8z8ccdFka4LvjICuBk+O8Hqs1RppYB/Q5D/1RbYXd/
   Y2XPyEJgftakNEP9YFDOY912wqSfNltmHFiprJT59KyUiWat4DHDTbUtX
   t/XOpeH/y3/azzEKM/ogdqCTpTldTvY4CT0QNwCJyfdh1sXvDGvmgXDfC
   chdLS1n4k7ZkY3jq2a6JAZdtT9cGX6Q+GlzsRx9mlxjTYHI8mThpRnGim
   fppGcF4dQQFpIDbAGQGiDOIFvhHDXWNESAle6IrQcM+YNXPSzay23Emc+
   W+XfJPy4jjEjXlfO8lReUBRO/CvrEmgd8xtUdK0r/WuRRIRmdBEEi7mJS
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="359640194"
X-IronPort-AV: E=Sophos;i="6.02,151,1688454000"; 
   d="scan'208";a="359640194"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2023 00:23:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="745246136"
X-IronPort-AV: E=Sophos;i="6.02,151,1688454000"; 
   d="scan'208";a="745246136"
Received: from lkp-server02.sh.intel.com (HELO 9ef86b2655e5) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 16 Sep 2023 00:23:39 -0700
Received: from kbuild by 9ef86b2655e5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qhPeS-00041Q-2x;
        Sat, 16 Sep 2023 07:23:36 +0000
Date:   Sat, 16 Sep 2023 15:22:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ma Ke <make_ruc2021@163.com>, jhs@mojatatu.com,
        xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ma Ke <make_ruc2021@163.com>
Subject: Re: [PATCH] net: sched: qfq: dont intepret cls results when asked to
 drop
Message-ID: <202309161521.08Hs5BL9-lkp@intel.com>
References: <20230915142355.3411527-1-make_ruc2021@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230915142355.3411527-1-make_ruc2021@163.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ma,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]
[also build test ERROR on net/main linus/master v6.6-rc1 next-20230915]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ma-Ke/net-sched-qfq-dont-intepret-cls-results-when-asked-to-drop/20230915-222648
base:   net-next/main
patch link:    https://lore.kernel.org/r/20230915142355.3411527-1-make_ruc2021%40163.com
patch subject: [PATCH] net: sched: qfq: dont intepret cls results when asked to drop
config: x86_64-rhel-8.3-rust (https://download.01.org/0day-ci/archive/20230916/202309161521.08Hs5BL9-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230916/202309161521.08Hs5BL9-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309161521.08Hs5BL9-lkp@intel.com/

All errors (new ones prefixed by >>):

>> net/sched/sch_qfq.c:707:4: error: fallthrough annotation does not directly precede switch label
                           fallthrough;
                           ^
   include/linux/compiler_attributes.h:227:41: note: expanded from macro 'fallthrough'
   # define fallthrough                    __attribute__((__fallthrough__))
                                           ^
   1 error generated.


vim +707 net/sched/sch_qfq.c

0545a303777351 stephen hemminger   2011-04-04  678  
0545a303777351 stephen hemminger   2011-04-04  679  static struct qfq_class *qfq_classify(struct sk_buff *skb, struct Qdisc *sch,
0545a303777351 stephen hemminger   2011-04-04  680  				      int *qerr)
0545a303777351 stephen hemminger   2011-04-04  681  {
0545a303777351 stephen hemminger   2011-04-04  682  	struct qfq_sched *q = qdisc_priv(sch);
0545a303777351 stephen hemminger   2011-04-04  683  	struct qfq_class *cl;
0545a303777351 stephen hemminger   2011-04-04  684  	struct tcf_result res;
25d8c0d55f241c John Fastabend      2014-09-12  685  	struct tcf_proto *fl;
0545a303777351 stephen hemminger   2011-04-04  686  	int result;
0545a303777351 stephen hemminger   2011-04-04  687  
0545a303777351 stephen hemminger   2011-04-04  688  	if (TC_H_MAJ(skb->priority ^ sch->handle) == 0) {
0545a303777351 stephen hemminger   2011-04-04  689  		pr_debug("qfq_classify: found %d\n", skb->priority);
0545a303777351 stephen hemminger   2011-04-04  690  		cl = qfq_find_class(sch, skb->priority);
0545a303777351 stephen hemminger   2011-04-04  691  		if (cl != NULL)
0545a303777351 stephen hemminger   2011-04-04  692  			return cl;
0545a303777351 stephen hemminger   2011-04-04  693  	}
0545a303777351 stephen hemminger   2011-04-04  694  
0545a303777351 stephen hemminger   2011-04-04  695  	*qerr = NET_XMIT_SUCCESS | __NET_XMIT_BYPASS;
25d8c0d55f241c John Fastabend      2014-09-12  696  	fl = rcu_dereference_bh(q->filter_list);
3aa2605594556c Davide Caratti      2021-07-28  697  	result = tcf_classify(skb, NULL, fl, &res, false);
0545a303777351 stephen hemminger   2011-04-04  698  	if (result >= 0) {
0698b7004e7da6 Ma Ke               2023-09-15  699  		if (result == TC_ACT_SHOT)
0698b7004e7da6 Ma Ke               2023-09-15  700  			return NULL;
0545a303777351 stephen hemminger   2011-04-04  701  #ifdef CONFIG_NET_CLS_ACT
0545a303777351 stephen hemminger   2011-04-04  702  		switch (result) {
0545a303777351 stephen hemminger   2011-04-04  703  		case TC_ACT_QUEUED:
0545a303777351 stephen hemminger   2011-04-04  704  		case TC_ACT_STOLEN:
e25ea21ffa66a0 Jiri Pirko          2017-06-06  705  		case TC_ACT_TRAP:
0545a303777351 stephen hemminger   2011-04-04  706  			*qerr = NET_XMIT_SUCCESS | __NET_XMIT_STOLEN;
964201de695b8a Gustavo A. R. Silva 2020-07-07 @707  			fallthrough;
0545a303777351 stephen hemminger   2011-04-04  708  		}
0545a303777351 stephen hemminger   2011-04-04  709  #endif
0545a303777351 stephen hemminger   2011-04-04  710  		cl = (struct qfq_class *)res.class;
0545a303777351 stephen hemminger   2011-04-04  711  		if (cl == NULL)
0545a303777351 stephen hemminger   2011-04-04  712  			cl = qfq_find_class(sch, res.classid);
0545a303777351 stephen hemminger   2011-04-04  713  		return cl;
0545a303777351 stephen hemminger   2011-04-04  714  	}
0545a303777351 stephen hemminger   2011-04-04  715  
0545a303777351 stephen hemminger   2011-04-04  716  	return NULL;
0545a303777351 stephen hemminger   2011-04-04  717  }
0545a303777351 stephen hemminger   2011-04-04  718  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
