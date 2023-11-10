Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E53F7E80E5
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:20:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345885AbjKJSUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 13:20:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235608AbjKJSRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 13:17:18 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A112F36C4B;
        Fri, 10 Nov 2023 06:21:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699626119; x=1731162119;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ln6nQab9ywcVhQrTHU5Lg3Qaj627vK0Zz872TRuVk5A=;
  b=gerxeJzMAoTrohF1+1xYKUoXaxNueeF0ov4ZR7Y4fFXJWHNp7OQyXIKO
   rVYO1USy37z9lR6oM4uJ4tnQypOiMQBeGKVJNIWH+aYWJVZB7copKpvCc
   8GhXRJIRxH8bbMq7xFGsIDWixeY7ZG1WAwZxzxg38CryzEuTxt8WXG9nX
   OSjTzkswXaH/AarCo0bHVEjE78Tlo1WmyqXQz9AeOfi1aIIa5/ZjnUX57
   agGg/mngOiVz0JNJZE6I3Zib/t+g7P3rPlHX1+UjVz5EMUqRVtdoT7/BN
   QTrmSGQN1X+Kg/X20R0nWDfEI7zl5BqVmXc1/Qc8vRO4Z+4L184ZE5jpr
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10890"; a="456686918"
X-IronPort-AV: E=Sophos;i="6.03,291,1694761200"; 
   d="scan'208";a="456686918"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2023 06:21:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10890"; a="1095198564"
X-IronPort-AV: E=Sophos;i="6.03,291,1694761200"; 
   d="scan'208";a="1095198564"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 10 Nov 2023 06:21:56 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r1SOP-0009dO-21;
        Fri, 10 Nov 2023 14:21:53 +0000
Date:   Fri, 10 Nov 2023 22:19:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Dae R. Jeong" <threeearcat@gmail.com>, borisp@nvidia.com,
        john.fastabend@gmail.com, kuba@kernel.org, davem@davemloft.net,
        edumazet@google.com, pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, ywchoi@casys.kaist.ac.kr
Subject: Re: [PATCH] tls: fix missing memory barrier in tls_init
Message-ID: <202311102254.YAU3c8F7-lkp@intel.com>
References: <ZU4Mk_RfzvRpwkmX@dragonet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZU4Mk_RfzvRpwkmX@dragonet>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
config: csky-randconfig-002-20231110 (https://download.01.org/0day-ci/archive/20231110/202311102254.YAU3c8F7-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231110/202311102254.YAU3c8F7-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311102254.YAU3c8F7-lkp@intel.com/

All errors (new ones prefixed by >>):

   csky-linux-ld: net/tls/tls_toe.o: in function `tls_toe_bypass':
>> tls_toe.c:(.text+0xf4): undefined reference to `tls_ctx_create'
>> csky-linux-ld: tls_toe.c:(.text+0x14c): undefined reference to `tls_ctx_create'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
