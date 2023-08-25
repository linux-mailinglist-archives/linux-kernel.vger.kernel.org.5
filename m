Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBC97787D1B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 03:27:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235538AbjHYB1V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 21:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236076AbjHYB1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 21:27:05 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E88B1FC1;
        Thu, 24 Aug 2023 18:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692926822; x=1724462822;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=v0UeNta87Sx8HA/Ip3QXS/fJh65LXYDTOgPDQc5jqwo=;
  b=atmm1UJVyoffA/o6fx9VrlufZ9F+kgATswe3dTaqKQuANaZiGZDU6Ypj
   QtgqkQg3WEN6gZQMHphtiAG8904MSSht2WbVZKMzmZr5hOAkpm5lyx94W
   Zmuxs1CfNfz7bslt/8jghIgKwfCoCPKq3LgmDfPD7YY4cVm4K24ARyhd3
   uYakFvFNXxMqUwc5oNnkIUkp9I8Hkea6vBZqZYmL0MmWvJU7vw2+XKmZJ
   TM5Unyme06L72gXQ8eYxq74fcyT3rw0ANP1CIfHejJQhQDVLYddoDcb96
   ME3O1w3TaRVVa3xfCRWeU3B3dKtL3o0ZzCEjgIV5DPs5xnpRJ2LupqnOD
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="354932353"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="354932353"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2023 18:27:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="730858553"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="730858553"
Received: from lkp-server02.sh.intel.com (HELO daf8bb0a381d) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 24 Aug 2023 18:26:57 -0700
Received: from kbuild by daf8bb0a381d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qZLbE-000368-0i;
        Fri, 25 Aug 2023 01:26:56 +0000
Date:   Fri, 25 Aug 2023 09:26:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Puranjay Mohan <puranjay12@gmail.com>, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, pulehui@huawei.com,
        conor.dooley@microchip.com, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, kpsingh@kernel.org, bjorn@kernel.org,
        bpf@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, puranjay12@gmail.com
Subject: Re: [PATCH bpf-next v2 2/3] riscv: implement a memset like function
 for text
Message-ID: <202308250924.NlFcBoND-lkp@intel.com>
References: <20230824133135.1176709-3-puranjay12@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230824133135.1176709-3-puranjay12@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Puranjay,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Puranjay-Mohan/riscv-extend-patch_text_nosync-for-multiple-pages/20230824-213410
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20230824133135.1176709-3-puranjay12%40gmail.com
patch subject: [PATCH bpf-next v2 2/3] riscv: implement a memset like function for text
config: riscv-allnoconfig (https://download.01.org/0day-ci/archive/20230825/202308250924.NlFcBoND-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230825/202308250924.NlFcBoND-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308250924.NlFcBoND-lkp@intel.com/

All warnings (new ones prefixed by >>):

   arch/riscv/kernel/patch.c: In function '__patch_insn_set':
>> arch/riscv/kernel/patch.c:61:13: warning: unused variable 'ret' [-Wunused-variable]
      61 |         int ret;
         |             ^~~


vim +/ret +61 arch/riscv/kernel/patch.c

    56	
    57	static int __patch_insn_set(void *addr, const int c, size_t len)
    58	{
    59		void *waddr = addr;
    60		bool across_pages = (((uintptr_t) addr & ~PAGE_MASK) + len) > PAGE_SIZE;
  > 61		int ret;
    62	
    63		/*
    64		 * Only two pages can be mapped at a time for writing.
    65		 */
    66		if (len > 2 * PAGE_SIZE)
    67			return -EINVAL;
    68	
    69		if (across_pages)
    70			patch_map(addr + PAGE_SIZE, FIX_TEXT_POKE1);
    71	
    72		waddr = patch_map(addr, FIX_TEXT_POKE0);
    73	
    74		memset(waddr, c, len);
    75	
    76		patch_unmap(FIX_TEXT_POKE0);
    77	
    78		if (across_pages)
    79			patch_unmap(FIX_TEXT_POKE1);
    80	
    81		return 0;
    82	}
    83	NOKPROBE_SYMBOL(__patch_insn_set);
    84	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
