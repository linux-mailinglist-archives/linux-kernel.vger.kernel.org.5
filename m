Return-Path: <linux-kernel+bounces-109239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43BC88816A2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 18:36:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCCDF283153
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 17:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E49326A340;
	Wed, 20 Mar 2024 17:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K5tuHYZY"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51618524B7
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 17:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710956185; cv=none; b=sC3KrmEzJyRlAY7QPrT8D8XbR1wMlpotz77dBB+Krgk5WR2L4aCQLkreuip0V3/PbjJJ/BmRr+BCCA4V37pc3nnnm5OSKzSoTVLf7paiPoI53DGZnjmz0w2/eYq0DLndrzbFTlP7Z1VWXGmgNPEtAKS3l6RNjehUdwKR3X9pOeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710956185; c=relaxed/simple;
	bh=614TyGgZR8YUe7ivLVIdx/2LjYPVT1YP379tVWiMKOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YwlOqLgDW6TZHhuXvjrALegOSzMrIzlcxJWrDuw+z4aT2xoOMCW1stVEbwuXhJIXB0s5XglCXcdnf50FDHt28KEEMBsxODt/TbI/0iyelSFRhLs54hdDJJvCbzOWCL6IDCY6mo8ZW53yqP3xrscjkNNSTPtYeU2OhtSNg1uFNJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K5tuHYZY; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710956183; x=1742492183;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=614TyGgZR8YUe7ivLVIdx/2LjYPVT1YP379tVWiMKOI=;
  b=K5tuHYZYRslRKZwIJs20rW49fhjpkxjdP+iYTbzncHhdL0CFL8VeTxVs
   i6nFND3rGzhPi713t8VT/rG5lpUfbz6fVxGrcgZ/xfoqr7hLeeqQY8kZ4
   iUSx0mAXFja4ixu7uRpVuGimy1Tqp+i2rdFIPSWJy+buPT2Qd5wJAwigU
   YwWhd7M/a3K1ZrGsmIszazJbHSgOfdxwcFWjk/i7behJWZQ4j++w+ykMu
   2GNIRtc3ex75cBf0+2y41YRgWhuayxtKf2AthFN6A8ynnznfPl9NbY64U
   WERI6/XAxF8M7qmLp5Ocazc4xxcYnpatE220SZwWDP4XHt5SF8+SfAZ9q
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11019"; a="8851141"
X-IronPort-AV: E=Sophos;i="6.07,140,1708416000"; 
   d="scan'208";a="8851141"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2024 10:36:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,140,1708416000"; 
   d="scan'208";a="14303809"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 20 Mar 2024 10:36:19 -0700
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rmzrN-000Ip9-0i;
	Wed, 20 Mar 2024 17:36:17 +0000
Date: Thu, 21 Mar 2024 01:35:55 +0800
From: kernel test robot <lkp@intel.com>
To: Oscar Salvador <osalvador@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	linux-kernel@vger.kernel.org, Michal Hocko <mhocko@suse.com>,
	Vlastimil Babka <vbabka@suse.cz>, Marco Elver <elver@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	Oscar Salvador <osalvador@suse.de>,
	syzbot+41bbfdb8d41003d12c0f@syzkaller.appspotmail.com
Subject: Re: [PATCH v2 1/2] mm,page_owner: Fix refcount imbalance
Message-ID: <202403210131.YLR6USxm-lkp@intel.com>
References: <20240319183212.17156-2-osalvador@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240319183212.17156-2-osalvador@suse.de>

Hi Oscar,

kernel test robot noticed the following build warnings:

[auto build test WARNING on akpm-mm/mm-everything]
[also build test WARNING on linus/master next-20240320]
[cannot apply to v6.8]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Oscar-Salvador/mm-page_owner-Fix-refcount-imbalance/20240320-023302
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20240319183212.17156-2-osalvador%40suse.de
patch subject: [PATCH v2 1/2] mm,page_owner: Fix refcount imbalance
config: x86_64-buildonly-randconfig-004-20240320 (https://download.01.org/0day-ci/archive/20240321/202403210131.YLR6USxm-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240321/202403210131.YLR6USxm-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403210131.YLR6USxm-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> mm/page_owner.c:213:3: warning: ignoring return value of function declared with 'warn_unused_result' attribute [-Wunused-result]
     213 |                 refcount_sub_and_test(nr_base_pages, &stack_record->count);
         |                 ^~~~~~~~~~~~~~~~~~~~~ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   1 warning generated.


vim +/warn_unused_result +213 mm/page_owner.c

   206	
   207	static void dec_stack_record_count(depot_stack_handle_t handle,
   208					   int nr_base_pages)
   209	{
   210		struct stack_record *stack_record = __stack_depot_get_stack_record(handle);
   211	
   212		if (stack_record)
 > 213			refcount_sub_and_test(nr_base_pages, &stack_record->count);
   214	}
   215	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

