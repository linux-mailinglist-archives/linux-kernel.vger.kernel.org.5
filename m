Return-Path: <linux-kernel+bounces-7124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEE9981A1F8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 16:14:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DE291C22F62
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 15:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D11693FB03;
	Wed, 20 Dec 2023 15:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wacwklq8"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01923D38F;
	Wed, 20 Dec 2023 15:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703085284; x=1734621284;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ULvCCsVn4cqIVLiFeZesMLdDzimmihjmZz9S7LtZK9I=;
  b=Wacwklq89/7WWhlBLn/54lbeuyQzWOtOPGArJ00suyr4/x3MkXFjzrSM
   BE3b4YRMJ1Hp5Ccz1BNdRFL/O0D+eaPmtBjwFJizkXFJh2lkyN0OihB93
   a36dx+YOEgk6uGYO53HZe1Y6/nx+WXIrpQVh/NZnmoTUqE3xEuPErF5x1
   7EPaWhzvhkK8VUHyq674sHZLMCF4/WDOxIptsntzhVHvan9NueNVjFLNB
   RoBAOzCrU47VSDNhwcTidWR9jfrWviCueAeuVdTl8iCjeKG1hS0u9PZOK
   3KA2nSLuaB10ewudteP5POTpWyKFoLGx8lYrNYCoNd27x9tdfmBa2a3bB
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="9293728"
X-IronPort-AV: E=Sophos;i="6.04,291,1695711600"; 
   d="scan'208";a="9293728"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2023 07:14:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="776372196"
X-IronPort-AV: E=Sophos;i="6.04,291,1695711600"; 
   d="scan'208";a="776372196"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 20 Dec 2023 07:14:40 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rFyHO-00073J-1B;
	Wed, 20 Dec 2023 15:14:38 +0000
Date: Wed, 20 Dec 2023 23:13:56 +0800
From: kernel test robot <lkp@intel.com>
To: Hangyu Hua <hbh25y@gmail.com>, jhs@mojatatu.com,
	xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	tgraf@suug.ch
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Hangyu Hua <hbh25y@gmail.com>
Subject: Re: [PATCH] net: sched: em_text: fix possible memory leak in
 em_text_destroy()
Message-ID: <202312202228.58nFn5h0-lkp@intel.com>
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

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]
[also build test WARNING on net/main linus/master v6.7-rc6]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Hangyu-Hua/net-sched-em_text-fix-possible-memory-leak-in-em_text_destroy/20231220-111317
base:   net-next/main
patch link:    https://lore.kernel.org/r/20231220030838.11751-1-hbh25y%40gmail.com
patch subject: [PATCH] net: sched: em_text: fix possible memory leak in em_text_destroy()
config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20231220/202312202228.58nFn5h0-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231220/202312202228.58nFn5h0-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312202228.58nFn5h0-lkp@intel.com/

All warnings (new ones prefixed by >>):

   net/sched/em_text.c: In function 'em_text_destroy':
>> net/sched/em_text.c:102:24: warning: passing argument 1 of 'kfree' makes pointer from integer without a cast [-Wint-conversion]
     102 |                 kfree(m->data);
         |                       ~^~~~~~
         |                        |
         |                        long unsigned int
   In file included from net/sched/em_text.c:8:
   include/linux/slab.h:227:24: note: expected 'const void *' but argument is of type 'long unsigned int'
     227 | void kfree(const void *objp);
         |            ~~~~~~~~~~~~^~~~


vim +/kfree +102 net/sched/em_text.c

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

