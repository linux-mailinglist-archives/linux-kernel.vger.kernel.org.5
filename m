Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1131C7E82FB
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 20:44:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344458AbjKJTdX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 14:33:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345599AbjKJTdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 14:33:05 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B8817EC4;
        Fri, 10 Nov 2023 11:16:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699643805; x=1731179805;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=myYJkjJglpdQ79ldx0ce9qdatGoner9BgOpSWsFYIiI=;
  b=Uv1aRss2cR3N8Yc+wfixrPhNY5ARmmZCOIQqfUHGU+kt7Xq4KnT5Qkky
   eeXTurXaTumG/vgxAG2eKyqSannWjf4RAr7jkrRmYDVh8eX86ghSEJmZR
   krYyb6uv6XT1F8cdyWsK9B7+XSQh1cyyJKZ4rLfXCPJey5tI4oZUa5yuY
   3Or3WpS14th7uIKkV51AB3FkS0p/hRpNwV3kyFqOIl5XQ7mfzPoqCpaPl
   gDgtZSTNcW0/QuORHkC/8QPPB7EO3HY2Ohsw/zT2NCnHivlEr96J7A7Ac
   2ltdGs7YSniydG70oSOYTGPNWpo0PGQNOJyE/sMui53IM2qqHdqdYRh+Q
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10890"; a="369556316"
X-IronPort-AV: E=Sophos;i="6.03,291,1694761200"; 
   d="scan'208";a="369556316"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2023 11:16:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10890"; a="881038973"
X-IronPort-AV: E=Sophos;i="6.03,291,1694761200"; 
   d="scan'208";a="881038973"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 10 Nov 2023 11:16:42 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r1Wzg-0009qU-1U;
        Fri, 10 Nov 2023 19:16:40 +0000
Date:   Sat, 11 Nov 2023 03:15:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Dae R. Jeong" <threeearcat@gmail.com>, borisp@nvidia.com,
        john.fastabend@gmail.com, kuba@kernel.org, davem@davemloft.net,
        edumazet@google.com, pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, ywchoi@casys.kaist.ac.kr
Subject: Re: [PATCH] tls: fix missing memory barrier in tls_init
Message-ID: <202311110243.1Rkt9wSg-lkp@intel.com>
References: <ZU4Mk_RfzvRpwkmX@dragonet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZU4Mk_RfzvRpwkmX@dragonet>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dae,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.6 next-20231110]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Dae-R-Jeong/tls-fix-missing-memory-barrier-in-tls_init/20231110-190047
base:   linus/master
patch link:    https://lore.kernel.org/r/ZU4Mk_RfzvRpwkmX%40dragonet
patch subject: [PATCH] tls: fix missing memory barrier in tls_init
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20231111/202311110243.1Rkt9wSg-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231111/202311110243.1Rkt9wSg-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311110243.1Rkt9wSg-lkp@intel.com/

All errors (new ones prefixed by >>):

   alpha-linux-ld: net/tls/tls_toe.o: in function `tls_toe_bypass':
>> (.text+0x280): undefined reference to `tls_ctx_create'
>> alpha-linux-ld: (.text+0x288): undefined reference to `tls_ctx_create'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
