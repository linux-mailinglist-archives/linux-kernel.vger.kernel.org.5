Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFFDB7666D2
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 10:19:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234861AbjG1ITy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 04:19:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234855AbjG1ITR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 04:19:17 -0400
Received: from mgamail.intel.com (unknown [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3532E3ABE
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 01:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690532350; x=1722068350;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=z44PLyXJIUhGr6GRFh0SRxHKC0CgCHKIZ9/QIj4NL+E=;
  b=C7eavmUo964V2JzNmFJ+13EmLsnNxg6ogV4oBjihFnR1oMNS9AE1J2TC
   4WhwM0Vk+3AsBb9WsRRtUYs7QAtyQ9GQtZBo4ukaLbk55ACRvQJ85DUj6
   4g2rCLyeJG7OheFOjnc2MrXoutF+dwjWdOIwv6lliL1/7032be1NbzQ3u
   2g3W9waVfsVK2lYVOZoLVEdmd9sxSAOgyY+AUkw816lAWBe2hGHYnUQev
   FMHOaIFV4CDUyGho1FtIdvjxloV2pMVROzyd6C25kM1/nqY/LfvaaoQqH
   voF4DbELX0QaT80009EwZq+mflMEdeExwgKulTcvlz5JBslgQz49IhYuz
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="367415199"
X-IronPort-AV: E=Sophos;i="6.01,236,1684825200"; 
   d="scan'208";a="367415199"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2023 01:19:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="1058040616"
X-IronPort-AV: E=Sophos;i="6.01,236,1684825200"; 
   d="scan'208";a="1058040616"
Received: from lkp-server02.sh.intel.com (HELO 953e8cd98f7d) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 28 Jul 2023 01:19:05 -0700
Received: from kbuild by 953e8cd98f7d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qPIgi-00031o-0x;
        Fri, 28 Jul 2023 08:19:04 +0000
Date:   Fri, 28 Jul 2023 16:18:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     Usama Arif <usama.arif@bytedance.com>, linux-mm@kvack.org,
        muchun.song@linux.dev, mike.kravetz@oracle.com, rppt@kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        fam.zheng@bytedance.com, liangma@liangbit.com,
        simon.evans@bytedance.com, punit.agrawal@bytedance.com,
        Usama Arif <usama.arif@bytedance.com>
Subject: Re: [v1 1/6] mm: hugetlb: Skip prep of tail pages when HVO is enabled
Message-ID: <202307281636.rXw2Dlzr-lkp@intel.com>
References: <20230727204624.1942372-2-usama.arif@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230727204624.1942372-2-usama.arif@bytedance.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Usama,

kernel test robot noticed the following build warnings:

[auto build test WARNING on akpm-mm/mm-everything]

url:    https://github.com/intel-lab-lkp/linux/commits/Usama-Arif/mm-hugetlb-Skip-prep-of-tail-pages-when-HVO-is-enabled/20230728-044839
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20230727204624.1942372-2-usama.arif%40bytedance.com
patch subject: [v1 1/6] mm: hugetlb: Skip prep of tail pages when HVO is enabled
config: arm64-randconfig-r016-20230727 (https://download.01.org/0day-ci/archive/20230728/202307281636.rXw2Dlzr-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230728/202307281636.rXw2Dlzr-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307281636.rXw2Dlzr-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from mm/hugetlb.c:49:
>> mm/hugetlb_vmemmap.h:56:6: warning: no previous prototype for 'vmemmap_should_optimize' [-Wmissing-prototypes]
      56 | bool vmemmap_should_optimize(const struct hstate *h, const struct page *head)
         |      ^~~~~~~~~~~~~~~~~~~~~~~


vim +/vmemmap_should_optimize +56 mm/hugetlb_vmemmap.h

    55	
  > 56	bool vmemmap_should_optimize(const struct hstate *h, const struct page *head)
    57	{
    58		return false;
    59	}
    60	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
