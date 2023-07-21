Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA62475BC12
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 04:03:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbjGUCDY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 22:03:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjGUCDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 22:03:22 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 184C8271E
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 19:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689905001; x=1721441001;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=I0PLZoOiy23fWeqbBAwPaAwy8L8K58M5ue5e9az8phE=;
  b=TrAJg4dQ+iWYnU9CKBRxMuBN4iT70Q+bPb0uACuvdlsbvDPRxGTWmhKd
   GETPOwgRSLdtZRjkePm72HFPWULU50JIi3WYVSrU4NNdaUqtsSfop2+rA
   2aTfz98shHWrCn+ZbGG3p89mOXrj7IjOWsgC2+E975z+NpMaK6aoGq5iP
   F6bG9U6/s+27OLbgDrrewqN/MRuDzMZCiy3HNa+zw9qc+HVMpyOhX3/Rz
   P03Bh7JcF8e0Mm7qtGBdXcLWstiR2kVygkikGsPNGmKG+Un0+tF2xgca1
   56MlH2mNkuR6QJORQpQJTHaBx39yEjUxcxdMmzKW0oUfmC0WqByyGT/LA
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="370514567"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="370514567"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2023 19:03:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="898544048"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="898544048"
Received: from lkp-server02.sh.intel.com (HELO 36946fcf73d7) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 20 Jul 2023 19:03:17 -0700
Received: from kbuild by 36946fcf73d7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qMfTu-0006jt-2Y;
        Fri, 21 Jul 2023 02:03:04 +0000
Date:   Fri, 21 Jul 2023 10:02:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peng Zhang <zhangpeng362@huawei.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, willy@infradead.org
Cc:     oe-kbuild-all@lists.linux.dev, hch@infradead.org,
        sidhartha.kumar@oracle.com, akpm@linux-foundation.org,
        wangkefeng.wang@huawei.com, sunnanyong@huawei.com,
        ZhangPeng <zhangpeng362@huawei.com>
Subject: Re: [PATCH v3 09/10] mm/page_io: convert count_swpout_vm_event() to
 take in a folio
Message-ID: <202307210922.2swqazEA-lkp@intel.com>
References: <20230720130147.4071649-10-zhangpeng362@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230720130147.4071649-10-zhangpeng362@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peng,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]
[also build test ERROR on axboe-block/for-next linus/master v6.5-rc2 next-20230720]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Peng-Zhang/mm-page_io-remove-unneeded-ClearPageUptodate/20230720-210515
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20230720130147.4071649-10-zhangpeng362%40huawei.com
patch subject: [PATCH v3 09/10] mm/page_io: convert count_swpout_vm_event() to take in a folio
config: parisc-randconfig-r006-20230720 (https://download.01.org/0day-ci/archive/20230721/202307210922.2swqazEA-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230721/202307210922.2swqazEA-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307210922.2swqazEA-lkp@intel.com/

All errors (new ones prefixed by >>):

   mm/page_io.c: In function 'count_swpout_vm_event':
>> mm/page_io.c:211:32: error: 'THP_SWPOUT' undeclared (first use in this function); did you mean 'PSWPOUT'?
     211 |                 count_vm_event(THP_SWPOUT);
         |                                ^~~~~~~~~~
         |                                PSWPOUT
   mm/page_io.c:211:32: note: each undeclared identifier is reported only once for each function it appears in


vim +211 mm/page_io.c

2f772e6cadf8ad Seth Jennings 2013-04-29  207  
c40c44eb86eb74 ZhangPeng     2023-07-20  208  static inline void count_swpout_vm_event(struct folio *folio)
225311a46411c3 Huang Ying    2017-09-06  209  {
c40c44eb86eb74 ZhangPeng     2023-07-20  210  	if (unlikely(folio_test_pmd_mappable(folio)))
225311a46411c3 Huang Ying    2017-09-06 @211  		count_vm_event(THP_SWPOUT);
c40c44eb86eb74 ZhangPeng     2023-07-20  212  	count_vm_events(PSWPOUT, folio_nr_pages(folio));
225311a46411c3 Huang Ying    2017-09-06  213  }
225311a46411c3 Huang Ying    2017-09-06  214  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
