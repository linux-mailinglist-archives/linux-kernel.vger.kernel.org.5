Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CD6C776C26
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 00:25:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231468AbjHIWZx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 18:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231297AbjHIWZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 18:25:52 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D0B5D2;
        Wed,  9 Aug 2023 15:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691619951; x=1723155951;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=z0glSc8LY2LtLuJc7hMlmzjpzI22Dwm4Qp6bntrmsak=;
  b=OiAPMiSUPWkwH3i8Rl9vVNsHhurPaEr2KJh5OxVmnn37tbiHqa/2E+nY
   J/sry7rTxA/jYXAcdCCT+Zzm0OgB3OEjgrOf4Cn6yNZT/VdlRQke5G1fH
   IK2zDK3eIqfoiz6kffQPDp2mGgQ8Brf0qhdcCAKSNlS2c0LhMF4gh/ZLL
   zVN3tCG4mbST6UxYK4R9Ng/OjYFchHoCDGbAWN7VRjuNbhLn6n5ENGNVL
   eux6x5fNyCPclm8ZuT8YX46OsTsvXg2ifdWDHFXG0SEQFwuoPIUbtOx4z
   LN82jGmP4AdN12QLfg41UByNtHot07qiPf/igtXBW4nsWSzMuz9ON0JRp
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="374959935"
X-IronPort-AV: E=Sophos;i="6.01,160,1684825200"; 
   d="scan'208";a="374959935"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2023 15:25:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="875458453"
Received: from lkp-server01.sh.intel.com (HELO d1ccc7e87e8f) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 09 Aug 2023 15:25:51 -0700
Received: from kbuild by d1ccc7e87e8f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qTrch-0006SC-1D;
        Wed, 09 Aug 2023 22:25:47 +0000
Date:   Thu, 10 Aug 2023 06:25:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Gustavo Luiz Duarte <gustavold@gmail.com>, netdev@vger.kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        David Ahern <dsahern@kernel.org>,
        Breno Leitao <leitao@debian.org>,
        Willem de Bruijn <willemb@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: ipmr: Call ipmr_ioctl() directly from
 ipmr_sk_ioctl()
Message-ID: <202308100626.gj6rvqoB-lkp@intel.com>
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
[also build test ERROR on net-next/main linus/master v6.5-rc5 next-20230809]
[cannot apply to horms-ipvs/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Gustavo-Luiz-Duarte/net-ipmr-Call-ipmr_ioctl-directly-from-ipmr_sk_ioctl/20230731-225918
base:   net/main
patch link:    https://lore.kernel.org/r/20230731145713.178509-1-gustavold%40gmail.com
patch subject: [PATCH] net: ipmr: Call ipmr_ioctl() directly from ipmr_sk_ioctl()
config: i386-randconfig-i011-20230809 (https://download.01.org/0day-ci/archive/20230810/202308100626.gj6rvqoB-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce: (https://download.01.org/0day-ci/archive/20230810/202308100626.gj6rvqoB-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308100626.gj6rvqoB-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: ip6mr_ioctl
   >>> referenced by mroute6.h:115 (include/linux/mroute6.h:115)
   >>>               net/core/sock.o:(sk_ioctl) in archive vmlinux.a
   >>> referenced by mroute6.h:130 (include/linux/mroute6.h:130)
   >>>               net/core/sock.o:(sk_ioctl) in archive vmlinux.a

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
