Return-Path: <linux-kernel+bounces-109493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41406881A31
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 00:37:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D607F1F2227E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 23:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C56AF8614C;
	Wed, 20 Mar 2024 23:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XIcDpIdJ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150CB1E87E
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 23:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710977854; cv=none; b=sbMALZxFC3SRW4X37U3CmX8BM1vjCIVfTugaWfB7bznb8SEC4H5qPU8QeJ/hC6SizxGSkorenl/j9cyCFoRsmc81+4MJspCcmLuoHug+X/vzYgjFpJN6v6sjUQPi+qaeCEAhTe2lKhjS2paUrYItTUN4QRyDGBa7tfj2u25sdPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710977854; c=relaxed/simple;
	bh=QY2G2HUjy/jAZ2GKE0N9ixG0Uypx178TMnWr+UB5gSo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CYUFkDZOKX+pD19Rr0FFIz69U7Y9NEXFcjUhJdHOFBHKKVStXYYgp/hDtPcPA0rCavsdiDB1iD3Q3hPWKRMNy+0jAcTkgMbWVjk1aDChQY/Pobruht04CLuf2myx62PbdHy0YLc7Y+R8y5oEJWHLIjBJpBS8tuKgTb6sSgp+hGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XIcDpIdJ; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710977851; x=1742513851;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QY2G2HUjy/jAZ2GKE0N9ixG0Uypx178TMnWr+UB5gSo=;
  b=XIcDpIdJYzrUqVqnjgE223cuRMbKTom0qGtEjNNFZ8Tuv+3eCtpshAmx
   WjSUHQDoAFem4r7S9YLUe8KouuEoG+3opzPFHcpiT9kYHQob6nEYkbzwE
   +p+N20Ez4O3ZewzIYYH+Wq54mWbyu2IS6nLgnOrLq3irzXiD+RQulPNNR
   8lJJewzqaJznUdWLRHlIqMHHIBTJ/XbxFmGE4to6RbcttX4H85vs7d4op
   bGGiCXODINqnE43Kjx3Osnn79dUQUfh0NdhNPimKS+BT5fiQm+7aHfAEd
   4awkIAmR5zIbG6j1gv3O58BoZjagrpgP45nznKYTfT++8HegYkbCiYs2v
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11019"; a="17077954"
X-IronPort-AV: E=Sophos;i="6.07,141,1708416000"; 
   d="scan'208";a="17077954"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2024 16:37:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,141,1708416000"; 
   d="scan'208";a="45297264"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 20 Mar 2024 16:37:27 -0700
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rn5Uq-000J0R-39;
	Wed, 20 Mar 2024 23:37:24 +0000
Date: Thu, 21 Mar 2024 07:37:12 +0800
From: kernel test robot <lkp@intel.com>
To: Oscar Salvador <osalvador@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	linux-kernel@vger.kernel.org, Michal Hocko <mhocko@suse.com>,
	Vlastimil Babka <vbabka@suse.cz>, Marco Elver <elver@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	Oscar Salvador <osalvador@suse.de>,
	syzbot+41bbfdb8d41003d12c0f@syzkaller.appspotmail.com
Subject: Re: [PATCH v2 1/2] mm,page_owner: Fix refcount imbalance
Message-ID: <202403210718.9IiE8NIU-lkp@intel.com>
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
config: x86_64-randconfig-r081-20240320 (https://download.01.org/0day-ci/archive/20240321/202403210718.9IiE8NIU-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240321/202403210718.9IiE8NIU-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403210718.9IiE8NIU-lkp@intel.com/

All warnings (new ones prefixed by >>):

   mm/page_owner.c: In function 'dec_stack_record_count':
>> mm/page_owner.c:213:3: warning: ignoring return value of 'refcount_sub_and_test', declared with attribute warn_unused_result [-Wunused-result]
     213 |   refcount_sub_and_test(nr_base_pages, &stack_record->count);
         |   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/refcount_sub_and_test +213 mm/page_owner.c

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

