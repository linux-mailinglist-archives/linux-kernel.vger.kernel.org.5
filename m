Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E2077CA3CD
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 11:15:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232725AbjJPJPC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 05:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232963AbjJPJOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 05:14:48 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 084F1100;
        Mon, 16 Oct 2023 02:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697447687; x=1728983687;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5b1jrtRvpTLCn6MVfh7i01hTlZB4zdayHotD/uWXh4c=;
  b=h3va2YfHgb3MSdvxdvbsGZqtIW8dEfr5/r657DRhOkHmUDD+4bp9mYtQ
   eN1NNfty0nohk1/x5j/qPVzOD/FBmb5jdwVU7Lo6sM66uvr6K+HEXLNQd
   hJladbAc5acwJM+edF/xa6roqhdoYZwS+VJj/5mrRZ6HKrNyfqgTzW/jX
   OwoPhVruFrWPnUgTXLgPYDSvtEf0+mKkUnxj/mLyh1KI/Zpvx912Tv+Oo
   q2KR/VBpz+TnKnpD23d1jwvRbD5JkuayECycB+EhEPZnIerPAUjPdmaUe
   tIYoXv7pPZ62hJcihjNZaPEkzf0RjoVxHC/QrMd+AXr/3wJe3Rx0mKdeT
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="375851335"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; 
   d="scan'208";a="375851335"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 02:14:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="790732235"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; 
   d="scan'208";a="790732235"
Received: from lkp-server02.sh.intel.com (HELO f64821696465) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 16 Oct 2023 02:14:42 -0700
Received: from kbuild by f64821696465 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qsJgO-0008Fz-14;
        Mon, 16 Oct 2023 09:14:40 +0000
Date:   Mon, 16 Oct 2023 17:14:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     xiaolinkui <xiaolinkui@126.com>, pablo@netfilter.org,
        kadlec@netfilter.org, fw@strlen.de, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        justinstitt@google.com, kuniyu@amazon.com
Cc:     oe-kbuild-all@lists.linux.dev, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Linkui Xiao <xiaolinkui@kylinos.cn>
Subject: Re: [PATCH] netfilter: ipset: wait for xt_recseq on all cpus
Message-ID: <202310161728.mW3lt1Jl-lkp@intel.com>
References: <20231005115022.12902-1-xiaolinkui@126.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231005115022.12902-1-xiaolinkui@126.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi xiaolinkui,

kernel test robot noticed the following build errors:

[auto build test ERROR on netfilter-nf/main]
[also build test ERROR on nf-next/master horms-ipvs/master linus/master v6.6-rc6 next-20231016]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/xiaolinkui/netfilter-ipset-wait-for-xt_recseq-on-all-cpus/20231005-234042
base:   git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf.git main
patch link:    https://lore.kernel.org/r/20231005115022.12902-1-xiaolinkui%40126.com
patch subject: [PATCH] netfilter: ipset: wait for xt_recseq on all cpus
config: i386-randconfig-016-20231016 (https://download.01.org/0day-ci/archive/20231016/202310161728.mW3lt1Jl-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231016/202310161728.mW3lt1Jl-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310161728.mW3lt1Jl-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: net/netfilter/ipset/ip_set_core.o: in function `wait_xt_recseq':
>> net/netfilter/ipset/ip_set_core.c:1194: undefined reference to `xt_recseq'


vim +1194 net/netfilter/ipset/ip_set_core.c

  1187	
  1188	static void wait_xt_recseq(void)
  1189	{
  1190		unsigned int cpu;
  1191	
  1192		/* wait for even xt_recseq on all cpus */
  1193		for_each_possible_cpu(cpu) {
> 1194			seqcount_t *s = &per_cpu(xt_recseq, cpu);
  1195			u32 seq = raw_read_seqcount(s);
  1196	
  1197			if (seq & 1) {
  1198				do {
  1199					cond_resched();
  1200					cpu_relax();
  1201				} while (seq == raw_read_seqcount(s));
  1202			}
  1203		}
  1204	}
  1205	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
