Return-Path: <linux-kernel+bounces-7632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65C7881AB04
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 00:30:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F8682869A5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 23:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE8434AF89;
	Wed, 20 Dec 2023 23:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q0KZjUIC"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29CD0495E6;
	Wed, 20 Dec 2023 23:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703115000; x=1734651000;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sNDfmG/Lc7rx8IVvaw+6DAeqnw43+bn1OAwsGOtcHuM=;
  b=Q0KZjUICnZLi/0cDBD8O8YwP1vuIE5f/dRSA4ZRVdCE4artO+JfY0Y3t
   LbZRmSdCgA/FIHmu0P05YejvvZwGf+D/e/AwvX4PaobY3nZQWQolbSSPi
   uvABLeG666KOT0y3kDG4cSG3N5+5zcXqzK8Fg9nGKVORlvrGaXO9QBWdl
   +kM3YMu2uba2Kehhfku/PZH4L4qjg+q7Wef/2ykfXivb/nNGkWFjMCkCi
   GJZY18YhPUrbiwcT7AqhY3JVBAcmnJKVj4Gd35WXbccpEEHyHmV2nHHiR
   MtwoMQrjKshOU+7TInNTIrSoKHxTQ9gp0IWQrLep1SR9nG72iSeiJmwaA
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="9272359"
X-IronPort-AV: E=Sophos;i="6.04,292,1695711600"; 
   d="scan'208";a="9272359"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2023 15:29:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,292,1695711600"; 
   d="scan'208";a="18477097"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 20 Dec 2023 15:29:55 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rG60e-0007dd-1s;
	Wed, 20 Dec 2023 23:29:52 +0000
Date: Thu, 21 Dec 2023 07:29:12 +0800
From: kernel test robot <lkp@intel.com>
To: Hangyu Hua <hbh25y@gmail.com>, jhs@mojatatu.com,
	xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	tgraf@suug.ch
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Hangyu Hua <hbh25y@gmail.com>
Subject: Re: [PATCH] net: sched: em_text: fix possible memory leak in
 em_text_destroy()
Message-ID: <202312210705.j1LTJmpH-lkp@intel.com>
References: <20231220030838.11751-1-hbh25y@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231220030838.11751-1-hbh25y@gmail.com>

Hi Hangyu,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]
[also build test ERROR on net/main linus/master v6.7-rc6 next-20231220]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Hangyu-Hua/net-sched-em_text-fix-possible-memory-leak-in-em_text_destroy/20231220-111317
base:   net-next/main
patch link:    https://lore.kernel.org/r/20231220030838.11751-1-hbh25y%40gmail.com
patch subject: [PATCH] net: sched: em_text: fix possible memory leak in em_text_destroy()
config: x86_64-rhel-8.3-rust (https://download.01.org/0day-ci/archive/20231221/202312210705.j1LTJmpH-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231221/202312210705.j1LTJmpH-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312210705.j1LTJmpH-lkp@intel.com/

All errors (new ones prefixed by >>):

>> net/sched/em_text.c:102:9: error: incompatible integer to pointer conversion passing 'unsigned long' to parameter of type 'const void *' [-Wint-conversion]
                   kfree(m->data);
                         ^~~~~~~
   include/linux/slab.h:227:24: note: passing argument to parameter 'objp' here
   void kfree(const void *objp);
                          ^
   1 error generated.


vim +102 net/sched/em_text.c

    97	
    98	static void em_text_destroy(struct tcf_ematch *m)
    99	{
   100		if (EM_TEXT_PRIV(m) && EM_TEXT_PRIV(m)->config) {
   101			textsearch_destroy(EM_TEXT_PRIV(m)->config);
 > 102			kfree(m->data);
   103		}
   104	}
   105	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

