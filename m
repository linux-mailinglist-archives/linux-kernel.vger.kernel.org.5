Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85BEC77414F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 19:18:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234300AbjHHRSX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 13:18:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234302AbjHHRRg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 13:17:36 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 787D81DC9A;
        Tue,  8 Aug 2023 09:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691510832; x=1723046832;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kJCDgp5sRmlWoO/VG7oNBaGSk6kyXjxy6z+c89DOgxk=;
  b=gD01RJzfPQny10OtjNmvjHZHBggUGJjfKyYRpqP1mPEjGKZ/nd8W4r2b
   141/s7F+sv/ohJdxAujuAmGBeZ/ahrk15eGsabW5F7458aWlknuPwtt3u
   Sn5LjUwqXCWACdOhGFQx6xyR5ugLap//fTupiFo3NGoLVx0OYSwXzOQcf
   Fb+KnHntHI/i+GI6EPKHxuPNdxJAdmBu4x+C4LxqE73Vc6D1TfcGlYzPl
   Rgxwk7OLrV0kb8GANxx9kSikr5m8xrOcWfGhcgHkEgxdJ5qwKoW7pOqFl
   xfeA48E+yyfpCbAw9U//t2AokylWa2YEAxMSKiZEN9p5vwc1U0UJ8/eKL
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="351084472"
X-IronPort-AV: E=Sophos;i="6.01,263,1684825200"; 
   d="scan'208";a="351084472"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2023 03:17:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="977798345"
X-IronPort-AV: E=Sophos;i="6.01,263,1684825200"; 
   d="scan'208";a="977798345"
Received: from lkp-server01.sh.intel.com (HELO d1ccc7e87e8f) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 08 Aug 2023 03:17:55 -0700
Received: from kbuild by d1ccc7e87e8f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qTJml-0005Hm-0D;
        Tue, 08 Aug 2023 10:17:55 +0000
Date:   Tue, 8 Aug 2023 18:17:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     "GONG, Ruiqi" <gongruiqi@huaweicloud.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        Roopa Prabhu <roopa@nvidia.com>,
        Nikolay Aleksandrov <razor@blackwall.org>,
        Kees Cook <keescook@chromium.org>
Cc:     oe-kbuild-all@lists.linux.dev, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org, netdev@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wang Weiyang <wangweiyang2@huawei.com>,
        Xiu Jianfeng <xiujianfeng@huawei.com>,
        gongruiqi@huaweicloud.com
Subject: Re: [PATCH] netfilter: ebtables: fix fortify warnings
Message-ID: <202308081840.VN5BvVWf-lkp@intel.com>
References: <20230808014821.241688-1-gongruiqi@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230808014821.241688-1-gongruiqi@huaweicloud.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ruiqi,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on horms-ipvs/master v6.5-rc5 next-20230808]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/GONG-Ruiqi/netfilter-ebtables-fix-fortify-warnings/20230808-095125
base:   linus/master
patch link:    https://lore.kernel.org/r/20230808014821.241688-1-gongruiqi%40huaweicloud.com
patch subject: [PATCH] netfilter: ebtables: fix fortify warnings
config: i386-randconfig-r011-20230808 (https://download.01.org/0day-ci/archive/20230808/202308081840.VN5BvVWf-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230808/202308081840.VN5BvVWf-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308081840.VN5BvVWf-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from <command-line>:
>> ./usr/include/linux/netfilter_bridge/ebtables.h:185:9: error: expected specifier-qualifier-list before 'struct_group'
     185 |         struct_group(offsets,
         |         ^~~~~~~~~~~~
   ./usr/include/linux/netfilter_bridge/ebtables.h: In function 'ebt_get_target':
>> ./usr/include/linux/netfilter_bridge/ebtables.h:199:57: error: 'struct ebt_entry' has no member named 'target_offset'
     199 |         return (struct ebt_entry_target *)((char *)e + e->target_offset);
         |                                                         ^~

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
