Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 728977A2E53
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 09:14:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237045AbjIPHNy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Sep 2023 03:13:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231708AbjIPHNr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Sep 2023 03:13:47 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65348CD8;
        Sat, 16 Sep 2023 00:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694848422; x=1726384422;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IfVUGRsiDjXqrTp/AO3llQvqyqYZF6cvh7r271j7dmQ=;
  b=eonHA4MtiojqJ16K/3iFuhRT3g214IH8J952lG+iDvuk32kF67OXIg6a
   iXwkB2tpxzetBygaEoYP6i+ISs8XyfVFYGK5MwAo8CV2+BzIcGgbif7ry
   BMEQBV6Ig4eIoTPCRCXi24MvSObs3ZeWcy8dojQoOu/qbconMTKVY41Kg
   ZnJHW8axOMoQtGY38Du1urA3CjbpYdwJOxYuE6zQl9myiBTqyFbTo93Wj
   YjJmo0EiPh6G75VgDWZ7rA6klGxgTwiI8dNZSvZoiM/stRNvDHub5Lf52
   vKNt4tV/SsYCRsc6r/YlvDapZddQ2dC6zFFT7hLQobeT+BP8dJikog0cU
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="379306013"
X-IronPort-AV: E=Sophos;i="6.02,151,1688454000"; 
   d="scan'208";a="379306013"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2023 00:13:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="810763184"
X-IronPort-AV: E=Sophos;i="6.02,151,1688454000"; 
   d="scan'208";a="810763184"
Received: from lkp-server02.sh.intel.com (HELO 9ef86b2655e5) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 16 Sep 2023 00:13:38 -0700
Received: from kbuild by 9ef86b2655e5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qhPUm-00040u-23;
        Sat, 16 Sep 2023 07:13:36 +0000
Date:   Sat, 16 Sep 2023 15:12:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ma Ke <make_ruc2021@163.com>, jhs@mojatatu.com,
        xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ma Ke <make_ruc2021@163.com>
Subject: Re: [PATCH] net: sched: htb: dont intepret cls results when asked to
 drop
Message-ID: <202309161437.vLLafFXT-lkp@intel.com>
References: <20230915142719.3411733-1-make_ruc2021@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230915142719.3411733-1-make_ruc2021@163.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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

url:    https://github.com/intel-lab-lkp/linux/commits/Ma-Ke/net-sched-htb-dont-intepret-cls-results-when-asked-to-drop/20230915-223020
base:   net-next/main
patch link:    https://lore.kernel.org/r/20230915142719.3411733-1-make_ruc2021%40163.com
patch subject: [PATCH] net: sched: htb: dont intepret cls results when asked to drop
config: x86_64-rhel-8.3-rust (https://download.01.org/0day-ci/archive/20230916/202309161437.vLLafFXT-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230916/202309161437.vLLafFXT-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309161437.vLLafFXT-lkp@intel.com/

All errors (new ones prefixed by >>):

>> net/sched/sch_htb.c:254:4: error: fallthrough annotation does not directly precede switch label
                           fallthrough;
                           ^
   include/linux/compiler_attributes.h:227:41: note: expanded from macro 'fallthrough'
   # define fallthrough                    __attribute__((__fallthrough__))
                                           ^
   1 error generated.


vim +254 net/sched/sch_htb.c

43d253781f6321 Randy Dunlap        2023-01-01  203  
^1da177e4c3f41 Linus Torvalds      2005-04-16  204  /**
^1da177e4c3f41 Linus Torvalds      2005-04-16  205   * htb_classify - classify a packet into class
43d253781f6321 Randy Dunlap        2023-01-01  206   * @skb: the socket buffer
43d253781f6321 Randy Dunlap        2023-01-01  207   * @sch: the active queue discipline
43d253781f6321 Randy Dunlap        2023-01-01  208   * @qerr: pointer for returned status code
^1da177e4c3f41 Linus Torvalds      2005-04-16  209   *
^1da177e4c3f41 Linus Torvalds      2005-04-16  210   * It returns NULL if the packet should be dropped or -1 if the packet
^1da177e4c3f41 Linus Torvalds      2005-04-16  211   * should be passed directly thru. In all other cases leaf class is returned.
^1da177e4c3f41 Linus Torvalds      2005-04-16  212   * We allow direct class selection by classid in priority. The we examine
^1da177e4c3f41 Linus Torvalds      2005-04-16  213   * filters in qdisc and in inner nodes (if higher filter points to the inner
^1da177e4c3f41 Linus Torvalds      2005-04-16  214   * node). If we end up with classid MAJOR:0 we enqueue the skb into special
^1da177e4c3f41 Linus Torvalds      2005-04-16  215   * internal fifo (direct). These packets then go directly thru. If we still
25985edcedea63 Lucas De Marchi     2011-03-30  216   * have no valid leaf we try to use MAJOR:default leaf. It still unsuccessful
^1da177e4c3f41 Linus Torvalds      2005-04-16  217   * then finish and return direct queue.
^1da177e4c3f41 Linus Torvalds      2005-04-16  218   */
87990467d387f9 Stephen Hemminger   2006-08-10  219  static struct htb_class *htb_classify(struct sk_buff *skb, struct Qdisc *sch,
87990467d387f9 Stephen Hemminger   2006-08-10  220  				      int *qerr)
^1da177e4c3f41 Linus Torvalds      2005-04-16  221  {
^1da177e4c3f41 Linus Torvalds      2005-04-16  222  	struct htb_sched *q = qdisc_priv(sch);
^1da177e4c3f41 Linus Torvalds      2005-04-16  223  	struct htb_class *cl;
^1da177e4c3f41 Linus Torvalds      2005-04-16  224  	struct tcf_result res;
^1da177e4c3f41 Linus Torvalds      2005-04-16  225  	struct tcf_proto *tcf;
^1da177e4c3f41 Linus Torvalds      2005-04-16  226  	int result;
^1da177e4c3f41 Linus Torvalds      2005-04-16  227  
^1da177e4c3f41 Linus Torvalds      2005-04-16  228  	/* allow to select class by setting skb->priority to valid classid;
cc7ec456f82da7 Eric Dumazet        2011-01-19  229  	 * note that nfmark can be used too by attaching filter fw with no
cc7ec456f82da7 Eric Dumazet        2011-01-19  230  	 * rules in it
cc7ec456f82da7 Eric Dumazet        2011-01-19  231  	 */
^1da177e4c3f41 Linus Torvalds      2005-04-16  232  	if (skb->priority == sch->handle)
^1da177e4c3f41 Linus Torvalds      2005-04-16  233  		return HTB_DIRECT;	/* X:0 (direct flow) selected */
cc7ec456f82da7 Eric Dumazet        2011-01-19  234  	cl = htb_find(skb->priority, sch);
29824310ce3e32 Harry Mason         2014-01-17  235  	if (cl) {
29824310ce3e32 Harry Mason         2014-01-17  236  		if (cl->level == 0)
^1da177e4c3f41 Linus Torvalds      2005-04-16  237  			return cl;
29824310ce3e32 Harry Mason         2014-01-17  238  		/* Start with inner filter chain if a non-leaf class is selected */
25d8c0d55f241c John Fastabend      2014-09-12  239  		tcf = rcu_dereference_bh(cl->filter_list);
29824310ce3e32 Harry Mason         2014-01-17  240  	} else {
25d8c0d55f241c John Fastabend      2014-09-12  241  		tcf = rcu_dereference_bh(q->filter_list);
29824310ce3e32 Harry Mason         2014-01-17  242  	}
^1da177e4c3f41 Linus Torvalds      2005-04-16  243  
c27f339af90bb8 Jarek Poplawski     2008-08-04  244  	*qerr = NET_XMIT_SUCCESS | __NET_XMIT_BYPASS;
3aa2605594556c Davide Caratti      2021-07-28  245  	while (tcf && (result = tcf_classify(skb, NULL, tcf, &res, false)) >= 0) {
4505a19ed317f1 Ma Ke               2023-09-15  246  		if (result == TC_ACT_SHOT)
4505a19ed317f1 Ma Ke               2023-09-15  247  			return NULL;
^1da177e4c3f41 Linus Torvalds      2005-04-16  248  #ifdef CONFIG_NET_CLS_ACT
^1da177e4c3f41 Linus Torvalds      2005-04-16  249  		switch (result) {
^1da177e4c3f41 Linus Torvalds      2005-04-16  250  		case TC_ACT_QUEUED:
^1da177e4c3f41 Linus Torvalds      2005-04-16  251  		case TC_ACT_STOLEN:
e25ea21ffa66a0 Jiri Pirko          2017-06-06  252  		case TC_ACT_TRAP:
378a2f090f7a47 Jarek Poplawski     2008-08-04  253  			*qerr = NET_XMIT_SUCCESS | __NET_XMIT_STOLEN;
964201de695b8a Gustavo A. R. Silva 2020-07-07 @254  			fallthrough;
^1da177e4c3f41 Linus Torvalds      2005-04-16  255  		}
^1da177e4c3f41 Linus Torvalds      2005-04-16  256  #endif
cc7ec456f82da7 Eric Dumazet        2011-01-19  257  		cl = (void *)res.class;
cc7ec456f82da7 Eric Dumazet        2011-01-19  258  		if (!cl) {
^1da177e4c3f41 Linus Torvalds      2005-04-16  259  			if (res.classid == sch->handle)
^1da177e4c3f41 Linus Torvalds      2005-04-16  260  				return HTB_DIRECT;	/* X:0 (direct flow) */
cc7ec456f82da7 Eric Dumazet        2011-01-19  261  			cl = htb_find(res.classid, sch);
cc7ec456f82da7 Eric Dumazet        2011-01-19  262  			if (!cl)
^1da177e4c3f41 Linus Torvalds      2005-04-16  263  				break;	/* filter selected invalid classid */
^1da177e4c3f41 Linus Torvalds      2005-04-16  264  		}
^1da177e4c3f41 Linus Torvalds      2005-04-16  265  		if (!cl->level)
^1da177e4c3f41 Linus Torvalds      2005-04-16  266  			return cl;	/* we hit leaf; return it */
^1da177e4c3f41 Linus Torvalds      2005-04-16  267  
^1da177e4c3f41 Linus Torvalds      2005-04-16  268  		/* we have got inner class; apply inner filter chain */
25d8c0d55f241c John Fastabend      2014-09-12  269  		tcf = rcu_dereference_bh(cl->filter_list);
^1da177e4c3f41 Linus Torvalds      2005-04-16  270  	}
^1da177e4c3f41 Linus Torvalds      2005-04-16  271  	/* classification failed; try to use default class */
^1da177e4c3f41 Linus Torvalds      2005-04-16  272  	cl = htb_find(TC_H_MAKE(TC_H_MAJ(sch->handle), q->defcls), sch);
^1da177e4c3f41 Linus Torvalds      2005-04-16  273  	if (!cl || cl->level)
^1da177e4c3f41 Linus Torvalds      2005-04-16  274  		return HTB_DIRECT;	/* bad default .. this is safe bet */
^1da177e4c3f41 Linus Torvalds      2005-04-16  275  	return cl;
^1da177e4c3f41 Linus Torvalds      2005-04-16  276  }
^1da177e4c3f41 Linus Torvalds      2005-04-16  277  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
