Return-Path: <linux-kernel+bounces-10336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4917A81D2EA
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 08:37:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC7B11F23104
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 07:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B28B879E3;
	Sat, 23 Dec 2023 07:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jVFetQvg"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3174E8BEA
	for <linux-kernel@vger.kernel.org>; Sat, 23 Dec 2023 07:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703317034; x=1734853034;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LzTB/JdJl6BfK3uAzYp8bhqIfFjqeISAZ0Sfr+/TWH4=;
  b=jVFetQvg/T4QK3jPC3ap50TgbgPZKyjLlsa4/irfWjqzYsrmR3E0n/YH
   dckaOfrCNpfGabSuSj+X2VmBfpfnCirRqT+xWHRrpbF2atQcZlzBbcDvB
   lkAYuJcHWT1AHRAbh/LRm5ShHSaDZc1Mcb+seYx95pTu/OIIBSif1jTAy
   IGhpyWUvGY3TR9Mk+VjW4NuYjYNkCV3BNyfTWSKXDu/F0/LemLEji4MCj
   MhvcRrv8pwCgkAl7oFDTE/+/dD67cYUbE/NHxVVZaHDLWOkkIqbkjwjwj
   SQcHxTffieklxHUpoGWiWfv6m4v8OPQOhoMeCvJy3UjPlnPccQEP4ImY2
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10932"; a="3027958"
X-IronPort-AV: E=Sophos;i="6.04,298,1695711600"; 
   d="scan'208";a="3027958"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 23:37:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10932"; a="1108711235"
X-IronPort-AV: E=Sophos;i="6.04,298,1695711600"; 
   d="scan'208";a="1108711235"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 22 Dec 2023 23:37:11 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rGwZJ-000AQT-2F;
	Sat, 23 Dec 2023 07:37:09 +0000
Date: Sat, 23 Dec 2023 15:36:37 +0800
From: kernel test robot <lkp@intel.com>
To: Kairui Song <ryncsn@gmail.com>, linux-mm@kvack.org
Cc: oe-kbuild-all@lists.linux.dev,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	Yu Zhao <yuzhao@google.com>, linux-kernel@vger.kernel.org,
	Kairui Song <kasong@tencent.com>
Subject: Re: [PATCH 2/3] mm, lru_gen: move pages in bulk when aging
Message-ID: <202312231555.KTX84YjF-lkp@intel.com>
References: <20231222102255.56993-3-ryncsn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231222102255.56993-3-ryncsn@gmail.com>

Hi Kairui,

kernel test robot noticed the following build warnings:

[auto build test WARNING on akpm-mm/mm-everything]

url:    https://github.com/intel-lab-lkp/linux/commits/Kairui-Song/mm-lru_gen-batch-update-counters-on-againg/20231222-184601
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20231222102255.56993-3-ryncsn%40gmail.com
patch subject: [PATCH 2/3] mm, lru_gen: move pages in bulk when aging
config: arc-randconfig-002-20231223 (https://download.01.org/0day-ci/archive/20231223/202312231555.KTX84YjF-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231223/202312231555.KTX84YjF-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312231555.KTX84YjF-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> mm/vmscan.c:3108:1: warning: 'inline' is not at beginning of declaration [-Wold-style-declaration]
    3108 | static void inline lru_gen_inc_bulk_finish(struct lru_gen_folio *lrugen,
         | ^~~~~~
   mm/vmscan.c:3127:1: warning: 'inline' is not at beginning of declaration [-Wold-style-declaration]
    3127 | static void inline lru_gen_try_inc_bulk(struct lru_gen_folio *lrugen, struct folio *folio,
         | ^~~~~~


vim +/inline +3108 mm/vmscan.c

  3107	
> 3108	static void inline lru_gen_inc_bulk_finish(struct lru_gen_folio *lrugen,
  3109						   int bulk_gen, bool type, int zone,
  3110						   struct gen_update_batch *batch)
  3111	{
  3112		if (!batch->head)
  3113			return;
  3114	
  3115		list_bulk_move_tail(&lrugen->folios[bulk_gen][type][zone],
  3116				    &batch->head->lru,
  3117				    &batch->tail->lru);
  3118	
  3119		batch->head = NULL;
  3120	}
  3121	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

