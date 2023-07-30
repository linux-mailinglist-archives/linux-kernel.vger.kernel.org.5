Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A872276877C
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 21:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbjG3Tdv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 15:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjG3Tdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 15:33:49 -0400
Received: from mgamail.intel.com (unknown [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3EA010CE
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 12:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690745627; x=1722281627;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=S67jVmUCAunF8JsytsqO9gyKo71S+VkEoVn6n4arx8A=;
  b=T/4DaqnZ0t7AF9rbjmCwECYIRKtdebSQJT+mUxc0Dnu28HhgV/C5jPFZ
   v32eiVT+6XFcuq02e0q4HW+1Z1nsELgEi7OuZjpWff751nY9C9acPTghV
   8Cj0N0xjOwrIsVjWyHzR4Ahv4naY6O3zxUK0bifHQaouzNjDCZYicZVww
   2Yz43YeFkKnTVSevOtjCETRl31Xw/146+h+YsWqHzHqxNKqdfKOb5CmC0
   qfcM/YhAu07TfKfhK6YoZrAJfnrvhwbheLw+/XsIY8KkKoOqIhmidfYCy
   ps2NLbrBPWYopVTQQyQOdHQl4kRQFQ8bYj0KznTlPSP/gI3+QOtJy9kD/
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10787"; a="455244754"
X-IronPort-AV: E=Sophos;i="6.01,242,1684825200"; 
   d="scan'208";a="455244754"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2023 12:33:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10787"; a="851805916"
X-IronPort-AV: E=Sophos;i="6.01,242,1684825200"; 
   d="scan'208";a="851805916"
Received: from lkp-server02.sh.intel.com (HELO 953e8cd98f7d) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 30 Jul 2023 12:33:44 -0700
Received: from kbuild by 953e8cd98f7d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qQCAi-0004kh-0E;
        Sun, 30 Jul 2023 19:33:44 +0000
Date:   Mon, 31 Jul 2023 03:33:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Usama Arif <usama.arif@bytedance.com>, linux-mm@kvack.org,
        muchun.song@linux.dev, mike.kravetz@oracle.com, rppt@kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        fam.zheng@bytedance.com, liangma@liangbit.com,
        simon.evans@bytedance.com, punit.agrawal@bytedance.com,
        Usama Arif <usama.arif@bytedance.com>
Subject: Re: [v2 6/6] mm: hugetlb: Skip initialization of struct pages freed
 later by HVO
Message-ID: <202307310358.frHhrM7f-lkp@intel.com>
References: <20230730151606.2871391-7-usama.arif@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230730151606.2871391-7-usama.arif@bytedance.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Usama,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]

url:    https://github.com/intel-lab-lkp/linux/commits/Usama-Arif/mm-hugetlb-Skip-prep-of-tail-pages-when-HVO-is-enabled/20230730-231750
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20230730151606.2871391-7-usama.arif%40bytedance.com
patch subject: [v2 6/6] mm: hugetlb: Skip initialization of struct pages freed later by HVO
config: riscv-randconfig-r014-20230730 (https://download.01.org/0day-ci/archive/20230731/202307310358.frHhrM7f-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230731/202307310358.frHhrM7f-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307310358.frHhrM7f-lkp@intel.com/

All errors (new ones prefixed by >>):

   riscv64-linux-ld: mm/hugetlb.o: in function `.LVL1074':
>> hugetlb.c:(.init.text+0xf4): undefined reference to `vmemmap_optimize_enabled'
   riscv64-linux-ld: mm/hugetlb.o: in function `.LVL1075':
   hugetlb.c:(.init.text+0xf8): undefined reference to `vmemmap_optimize_enabled'
   riscv64-linux-ld: mm/hugetlb.o: in function `.L0 ':
   hugetlb.c:(.init.text+0x16e): undefined reference to `vmemmap_optimize_enabled'
>> riscv64-linux-ld: hugetlb.c:(.init.text+0x172): undefined reference to `vmemmap_optimize_enabled'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
