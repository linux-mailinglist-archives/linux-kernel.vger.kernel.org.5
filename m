Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5062676DB6B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 01:18:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232705AbjHBXSx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 19:18:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230460AbjHBXSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 19:18:44 -0400
Received: from mgamail.intel.com (unknown [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 326C7FB;
        Wed,  2 Aug 2023 16:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691018317; x=1722554317;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SnhoA5/+6/yFD18HW0GV1yHz1WPLSZnPwIv9nFl7vTg=;
  b=EFsFrXTYXa2oWl1XWHZW2oKe+xJBavdMSKyqjqwze/3PK0HjOKOKO0Q/
   efikLjYuGVTS2rnQyUa5MXNVt++stpy8Bn0Fs/Vs8UFpaJrIba9G0+s/D
   LqoYyIPoEkHG/XwwtOFPrW3r72NKA9ViNZOaIX+E1t7zl1z5u47yP//PM
   VzJgqbTub8qR8uYjcna4PC7mSPtoXyOvzIV56bHQ7i5mPArPdC+QOl5eo
   KMCA11T1JIZrIbQONY9YjJYmzNLFF21hMKd4Kuq8lL1nXec0pf6gmtvJM
   BaoYI5N3zkS2QRN8+AJJ+6oGB7QonkMiQnmKVko1J7raa6MrA6v3UPpH1
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="349320358"
X-IronPort-AV: E=Sophos;i="6.01,250,1684825200"; 
   d="scan'208";a="349320358"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2023 16:18:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="679262015"
X-IronPort-AV: E=Sophos;i="6.01,250,1684825200"; 
   d="scan'208";a="679262015"
Received: from lkp-server01.sh.intel.com (HELO d1ccc7e87e8f) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 02 Aug 2023 16:18:32 -0700
Received: from kbuild by d1ccc7e87e8f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qRL6t-0001ZD-2w;
        Wed, 02 Aug 2023 23:18:31 +0000
Date:   Thu, 3 Aug 2023 07:17:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     Gerd Bayer <gbayer@linux.ibm.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        Jan Karcher <jaka@linux.ibm.com>,
        Tony Lu <tonylu@linux.alibaba.com>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     oe-kbuild-all@lists.linux.dev,
        Karsten Graul <kgraul@linux.ibm.com>,
        "D . Wythe" <alibuda@linux.alibaba.com>,
        Wen Gu <guwen@linux.alibaba.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 2/2] net/smc: Use correct buffer sizes when switching
 between TCP and SMC
Message-ID: <202308030722.dV3X9uUQ-lkp@intel.com>
References: <20230802093313.1501605-3-gbayer@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230802093313.1501605-3-gbayer@linux.ibm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gerd,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]
[also build test ERROR on linus/master v6.5-rc4 next-20230802]
[cannot apply to net/main]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Gerd-Bayer/net-smc-Fix-setsockopt-and-sysctl-to-specify-same-buffer-size-again/20230802-193805
base:   net-next/main
patch link:    https://lore.kernel.org/r/20230802093313.1501605-3-gbayer%40linux.ibm.com
patch subject: [PATCH net 2/2] net/smc: Use correct buffer sizes when switching between TCP and SMC
config: nios2-randconfig-r006-20230731 (https://download.01.org/0day-ci/archive/20230803/202308030722.dV3X9uUQ-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230803/202308030722.dV3X9uUQ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308030722.dV3X9uUQ-lkp@intel.com/

All errors (new ones prefixed by >>):

   net/smc/af_smc.c: In function 'smc_adjust_sock_bufsizes':
>> net/smc/af_smc.c:465:27: error: 'possible_net_t' has no member named 'net'
     465 |         nnet = nsk->sk_net.net;
         |                           ^


vim +465 net/smc/af_smc.c

   438	
   439	/* copy only relevant settings and flags of SOL_SOCKET level from smc to
   440	 * clc socket (since smc is not called for these options from net/core)
   441	 */
   442	
   443	#define SK_FLAGS_SMC_TO_CLC ((1UL << SOCK_URGINLINE) | \
   444				     (1UL << SOCK_KEEPOPEN) | \
   445				     (1UL << SOCK_LINGER) | \
   446				     (1UL << SOCK_BROADCAST) | \
   447				     (1UL << SOCK_TIMESTAMP) | \
   448				     (1UL << SOCK_DBG) | \
   449				     (1UL << SOCK_RCVTSTAMP) | \
   450				     (1UL << SOCK_RCVTSTAMPNS) | \
   451				     (1UL << SOCK_LOCALROUTE) | \
   452				     (1UL << SOCK_TIMESTAMPING_RX_SOFTWARE) | \
   453				     (1UL << SOCK_RXQ_OVFL) | \
   454				     (1UL << SOCK_WIFI_STATUS) | \
   455				     (1UL << SOCK_NOFCS) | \
   456				     (1UL << SOCK_FILTER_LOCKED) | \
   457				     (1UL << SOCK_TSTAMP_NEW))
   458	
   459	/* if set, use value set by setsockopt() - else use IPv4 or SMC sysctl value */
   460	static void smc_adjust_sock_bufsizes(struct sock *nsk, struct sock *osk,
   461					     unsigned long mask)
   462	{
   463		struct net *nnet;
   464	
 > 465		nnet = nsk->sk_net.net;
   466	
   467		nsk->sk_userlocks = osk->sk_userlocks;
   468	
   469		if (osk->sk_userlocks & SOCK_SNDBUF_LOCK) {
   470			nsk->sk_sndbuf = osk->sk_sndbuf;
   471		} else {
   472			if (mask == SK_FLAGS_SMC_TO_CLC)
   473				WRITE_ONCE(nsk->sk_sndbuf,
   474					   READ_ONCE(nnet->ipv4.sysctl_tcp_wmem[1]));
   475			else
   476				WRITE_ONCE(nsk->sk_sndbuf,
   477					   2 * READ_ONCE(nnet->smc.sysctl_wmem));
   478		}
   479		if (osk->sk_userlocks & SOCK_RCVBUF_LOCK) {
   480			nsk->sk_rcvbuf = osk->sk_rcvbuf;
   481		} else {
   482			if (mask == SK_FLAGS_SMC_TO_CLC)
   483				WRITE_ONCE(nsk->sk_rcvbuf,
   484					   READ_ONCE(nnet->ipv4.sysctl_tcp_rmem[1]));
   485			else
   486				WRITE_ONCE(nsk->sk_rcvbuf,
   487					   2 * READ_ONCE(nnet->smc.sysctl_rmem));
   488		}
   489	}
   490	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
