Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65D6377515B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 05:26:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbjHID0g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 23:26:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbjHID0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 23:26:34 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 149BB1999;
        Tue,  8 Aug 2023 20:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691551594; x=1723087594;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xAd/kJ56EpFtJhQIEshMgdLpGVfeYcAheNB3lv9FRGs=;
  b=GoVGJfjPrRBQR09KgzJhB6N8Qq71RRfstyOoA6aWQIXXcZBdyGBa2XGC
   pLAUX/79NZnrrhaLGqNCWE+kiPgfzpb1s1hmgrByjo32HzSch5KUY4ero
   czvScJaj62PMH42LuB/3KO5RlCeyQttpstqmWkt7X5LsUypum7391D3YM
   NA/aoCuPuB3hiXmC58yMr6CPZgYirIzYkTtyAMKKS+hu9PGeOy5bNbHK6
   chVEhJ8qh/EWkefhC9GcIm8dRw+f3+gIlf2tdOJtr6Jup5bGEomQuAQn1
   Gh/dv+uMIifo42iWalL1ejNbQh37R6OmNdq/slq+wO2hKiwLm5/ITfVew
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="374720054"
X-IronPort-AV: E=Sophos;i="6.01,158,1684825200"; 
   d="scan'208";a="374720054"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2023 20:26:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="708537411"
X-IronPort-AV: E=Sophos;i="6.01,158,1684825200"; 
   d="scan'208";a="708537411"
Received: from lkp-server01.sh.intel.com (HELO d1ccc7e87e8f) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 08 Aug 2023 20:26:21 -0700
Received: from kbuild by d1ccc7e87e8f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qTZq0-0005m8-0u;
        Wed, 09 Aug 2023 03:26:20 +0000
Date:   Wed, 9 Aug 2023 11:26:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Gustavo Luiz Duarte <gustavold@gmail.com>, netdev@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        David Ahern <dsahern@kernel.org>,
        Breno Leitao <leitao@debian.org>,
        Willem de Bruijn <willemb@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: ipmr: Call ipmr_ioctl() directly from
 ipmr_sk_ioctl()
Message-ID: <202308091122.z4eVvCI5-lkp@intel.com>
References: <20230731145713.178509-1-gustavold@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230731145713.178509-1-gustavold@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gustavo,

kernel test robot noticed the following build errors:

[auto build test ERROR on net/main]
[also build test ERROR on net-next/main linus/master v6.5-rc5 next-20230808]
[cannot apply to horms-ipvs/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Gustavo-Luiz-Duarte/net-ipmr-Call-ipmr_ioctl-directly-from-ipmr_sk_ioctl/20230731-225918
base:   net/main
patch link:    https://lore.kernel.org/r/20230731145713.178509-1-gustavold%40gmail.com
patch subject: [PATCH] net: ipmr: Call ipmr_ioctl() directly from ipmr_sk_ioctl()
config: x86_64-randconfig-x054-20230808 (https://download.01.org/0day-ci/archive/20230809/202308091122.z4eVvCI5-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230809/202308091122.z4eVvCI5-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308091122.z4eVvCI5-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: net/core/sock.o: in function `ip6mr_sk_ioctl':
>> include/linux/mroute6.h:115: undefined reference to `ip6mr_ioctl'
>> ld: include/linux/mroute6.h:130: undefined reference to `ip6mr_ioctl'


vim +115 include/linux/mroute6.h

    95	
    96	struct rtmsg;
    97	extern int ip6mr_get_route(struct net *net, struct sk_buff *skb,
    98				   struct rtmsg *rtm, u32 portid);
    99	
   100	#ifdef CONFIG_IPV6_MROUTE
   101	bool mroute6_is_socket(struct net *net, struct sk_buff *skb);
   102	extern int ip6mr_sk_done(struct sock *sk);
   103	static inline int ip6mr_sk_ioctl(struct sock *sk, unsigned int cmd,
   104					 void __user *arg)
   105	{
   106		int ret;
   107	
   108		switch (cmd) {
   109		case SIOCGETMIFCNT_IN6: {
   110			struct sioc_mif_req6 karg;
   111	
   112			if (copy_from_user(&karg, arg, sizeof(karg)))
   113				return -EFAULT;
   114	
 > 115			ret = ip6mr_ioctl(sk, cmd, &karg);
   116			if (ret)
   117				return ret;
   118	
   119			if (copy_to_user(arg, &karg, sizeof(karg)))
   120				return -EFAULT;
   121	
   122			return 0;
   123			}
   124		case SIOCGETSGCNT_IN6: {
   125			struct sioc_sg_req6 karg;
   126	
   127			if (copy_from_user(&karg, arg, sizeof(karg)))
   128				return -EFAULT;
   129	
 > 130			ret = ip6mr_ioctl(sk, cmd, &karg);
   131			if (ret)
   132				return ret;
   133	
   134			if (copy_to_user(arg, &karg, sizeof(karg)))
   135				return -EFAULT;
   136	
   137			return 0;
   138			}
   139		}
   140	
   141		return 1;
   142	}
   143	#else
   144	static inline bool mroute6_is_socket(struct net *net, struct sk_buff *skb)
   145	{
   146		return false;
   147	}
   148	static inline int ip6mr_sk_done(struct sock *sk)
   149	{
   150		return 0;
   151	}
   152	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
