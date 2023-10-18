Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 480F77CD273
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 04:53:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229463AbjJRCxp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 22:53:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjJRCxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 22:53:44 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAB89A4
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 19:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697597622; x=1729133622;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XRBTX3nMq95vshwk7VT4ItcDuMRIOKTvp4LOww3J9sM=;
  b=kz3MsWqW4THGsmZ0sWVhLOGlMDCrbL9opaZdRYDrAicq5n98jdiBkDY8
   Wks/j1+0c/ORVFG4vgC/tO0qiwiwd3e2Gqrq8pynka/c0Lft68dEEx6UE
   hzRoU7MsFAKBkEzSJwHPOQJlkxMghp4mkYXzzdoz26uE26Ff077DMKoaU
   ebUpTL3Ef1m0L3sd8shLkxSf5cif16Phq9LUAj3RzMfvZGZIC2ukBfypf
   WKCjek4abflQxYMgib/55c4JXbiyB102YadiKsy6xutIKMEYgSlv/jt5Z
   DV8Wcro3ddkep0sqsLBXzgYj+Ru+8Slrkp8C5bxusPbXgqsUbvJDKH2P8
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="370986388"
X-IronPort-AV: E=Sophos;i="6.03,234,1694761200"; 
   d="scan'208";a="370986388"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 19:53:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="826688637"
X-IronPort-AV: E=Sophos;i="6.03,234,1694761200"; 
   d="scan'208";a="826688637"
Received: from lkp-server02.sh.intel.com (HELO f64821696465) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 17 Oct 2023 19:53:34 -0700
Received: from kbuild by f64821696465 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qswge-000APi-1E;
        Wed, 18 Oct 2023 02:53:32 +0000
Date:   Wed, 18 Oct 2023 10:53:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        maple-tree@lists.infradead.org
Cc:     oe-kbuild-all@lists.linux.dev, akpm@linux-foundation.org,
        willy@infradead.org, liam.howlett@oracle.com,
        zhangpeng.00@bytedance.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: Re: [PATCH 1/3] maple_tree: introduce mas_prealloc_calc()
Message-ID: <202310181030.sYP91twn-lkp@intel.com>
References: <20231009201639.920512-2-sidhartha.kumar@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231009201639.920512-2-sidhartha.kumar@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sidhartha,

kernel test robot noticed the following build warnings:

[auto build test WARNING on akpm-mm/mm-everything]
[also build test WARNING on linus/master v6.6-rc6 next-20231017]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Sidhartha-Kumar/maple_tree-introduce-mas_prealloc_calc/20231010-041859
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20231009201639.920512-2-sidhartha.kumar%40oracle.com
patch subject: [PATCH 1/3] maple_tree: introduce mas_prealloc_calc()
config: i386-randconfig-061-20231018 (https://download.01.org/0day-ci/archive/20231018/202310181030.sYP91twn-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231018/202310181030.sYP91twn-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310181030.sYP91twn-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> lib/maple_tree.c:5428:5: sparse: sparse: symbol 'mas_prealloc_calc' was not declared. Should it be static?

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
