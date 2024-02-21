Return-Path: <linux-kernel+bounces-75377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 96D0485E763
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 20:38:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27AD9B26160
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 19:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 128E986130;
	Wed, 21 Feb 2024 19:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IkWoDTgx"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F1382D9B
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 19:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708544299; cv=none; b=Qn5c0l6jA7T2C6/CUfpXv+2OycBLChmuGIs3e+ummiB5DAZ1vkdrNiBOBBiHXFqAYauBrNE2K00bxK4VABfxIXkb8v6BwRBOXZrSkqSRf5gUmaXxHJNjWzErS5GIMckDb+RJuLrOFVD4AevuaLbrDXNcgbG+01lPlxhmHqzVgyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708544299; c=relaxed/simple;
	bh=j2hyT32Z+CHnHObDPjKK9F3++oQu/n8hJRgF7S31qi0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IRwqMlgOw8Tqeb2goyhM/ookweZDcyzDZWMbkJ1vxweD6wns+19i+y5vtBLcvEGyPxjl1LIQTOf8SStX1rf6wQkaRTZ8moRJhWK3n8iaHPROic3+0mCb/fnlCo/AZJVCedRH6SkP6JL/slvcwzcXbWKoDmNbQHzFBvPmA5LpCFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IkWoDTgx; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708544296; x=1740080296;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=j2hyT32Z+CHnHObDPjKK9F3++oQu/n8hJRgF7S31qi0=;
  b=IkWoDTgxEnJXUsWj1Z07OX4gwPg4SuKX84D6XXYKVbGbTxTXaIMbrL4Y
   ONSOGhDqkvl2Beq5ZfvxoB0IRJ1i7bATXCbnhw6e9D+ABw6efui6zGy9w
   bRbCLm5FrLSGxuwLl/YdGSD3eg4sBvIXYK8N17xlGhNyb5Qbcd+QeHR9/
   E6YrkUUrSA6L9J0TltfQ1SzymrNQLbnfq1PgEMvMX/Lltcu1uh6X549Ug
   KW/ogMbIwjQyTFahsGdXDEefiEgMUc19+W9jxBk8my0muoLSUubAwO8GS
   LkVb7N09rL0GUPwxjBL2HkNtWy7ipeGsvBb+ekJDj7pGQDTbWgpxAncec
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="20165533"
X-IronPort-AV: E=Sophos;i="6.06,176,1705392000"; 
   d="scan'208";a="20165533"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2024 11:38:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,176,1705392000"; 
   d="scan'208";a="5446532"
Received: from lkp-server02.sh.intel.com (HELO 3c78fa4d504c) ([10.239.97.151])
  by fmviesa006.fm.intel.com with ESMTP; 21 Feb 2024 11:38:14 -0800
Received: from kbuild by 3c78fa4d504c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rcsQ0-0005fM-0h;
	Wed, 21 Feb 2024 19:38:12 +0000
Date: Thu, 22 Feb 2024 03:37:50 +0800
From: kernel test robot <lkp@intel.com>
To: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>, linux-mm@kvack.org
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org, muchun.song@linux.dev,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: Re: [PATCH 1/3] mm/memory: Change vmf_anon_prepare() to be non-static
Message-ID: <202402220352.930oDAQ6-lkp@intel.com>
References: <20240220231424.126600-2-vishal.moola@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240220231424.126600-2-vishal.moola@gmail.com>

Hi Vishal,

kernel test robot noticed the following build warnings:

[auto build test WARNING on akpm-mm/mm-everything]
[also build test WARNING on linus/master v6.8-rc5 next-20240221]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Vishal-Moola-Oracle/mm-memory-Change-vmf_anon_prepare-to-be-non-static/20240221-071907
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20240220231424.126600-2-vishal.moola%40gmail.com
patch subject: [PATCH 1/3] mm/memory: Change vmf_anon_prepare() to be non-static
config: alpha-allnoconfig (https://download.01.org/0day-ci/archive/20240222/202402220352.930oDAQ6-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240222/202402220352.930oDAQ6-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402220352.930oDAQ6-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> mm/memory.c:3283:12: warning: no previous prototype for 'vmf_anon_prepare' [-Wmissing-prototypes]
    3283 | vm_fault_t vmf_anon_prepare(struct vm_fault *vmf)
         |            ^~~~~~~~~~~~~~~~


vim +/vmf_anon_prepare +3283 mm/memory.c

  3282	
> 3283	vm_fault_t vmf_anon_prepare(struct vm_fault *vmf)
  3284	{
  3285		struct vm_area_struct *vma = vmf->vma;
  3286	
  3287		if (likely(vma->anon_vma))
  3288			return 0;
  3289		if (vmf->flags & FAULT_FLAG_VMA_LOCK) {
  3290			vma_end_read(vma);
  3291			return VM_FAULT_RETRY;
  3292		}
  3293		if (__anon_vma_prepare(vma))
  3294			return VM_FAULT_OOM;
  3295		return 0;
  3296	}
  3297	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

