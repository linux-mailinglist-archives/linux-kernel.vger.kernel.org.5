Return-Path: <linux-kernel+bounces-75201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF6B85E498
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 18:31:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7FFE1F25336
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 17:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD9FF83CCD;
	Wed, 21 Feb 2024 17:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CBIp/lFd"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862DA1C20
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 17:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708536679; cv=none; b=LVJWzEgcxJ6QFeljNf0cCx0II9hu/DfPyhaJyJn0BSiLhyCFN0N/J/oY2icLtOTyBSGeNKjF4i9iSmWNhzC+tK3Exahv7QMpgrfm5z+XIO/iXOlows9OSTRkhxDoZSVSoTn+H8F6AeEYSpPNmtMkkCQJ82ZF7RgUJO49NOD1Bec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708536679; c=relaxed/simple;
	bh=x4m0ZIEdqBXtWBesysoHgAjQIPLTEUcC/b3cdm0G0oU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gNjjVIuMDLJSkfIU9eY2wr7GeVaNhtzLLstJhI5oKQS1fSLacyOgYUWv4SOOVwBIEP+B6COIkQtrDTGZxgrs41ErwMKn04+6s4ncK5jmqUDIGBaMbVUuBoaSMGeE6I572EZCH4MGsPI+U/WwsL+VMj63osl3oRicvDyIsss7L1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CBIp/lFd; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708536679; x=1740072679;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=x4m0ZIEdqBXtWBesysoHgAjQIPLTEUcC/b3cdm0G0oU=;
  b=CBIp/lFdBqB8d3vMyZ82FvnrGzNGLuKYvqFa58nKCTraIKvLpqx9W1pf
   VWK28IIfQHRYUJdwRAVkjzWOV7/o5QEq8bNbEuwTc8YwaKyDup5qJFbkW
   IXcpG6TRKIkQiquhjTeo3+dyTFlkGj5IWStPT7wRZqNxqJFbbc5BA3eD6
   Vr7R1bfm473Cneo8ZWPFnBvFIKqzS94quzVsvW+JU6y3uf1DGH7JOoDhq
   Ep43/fcbZr4tcGFJBBvth88cl3F9EpjLs0qntXDKJLXbmunqxbm6RQRly
   IRBDIS8g0/omdlXabKZT3HxLozrAqQTJIvOBVx/aGP8hnDzwxHaM5MhIb
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="25177046"
X-IronPort-AV: E=Sophos;i="6.06,176,1705392000"; 
   d="scan'208";a="25177046"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2024 09:31:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="827382575"
X-IronPort-AV: E=Sophos;i="6.06,176,1705392000"; 
   d="scan'208";a="827382575"
Received: from lkp-server02.sh.intel.com (HELO 3c78fa4d504c) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 21 Feb 2024 09:31:15 -0800
Received: from kbuild by 3c78fa4d504c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rcqR0-0005Xw-22;
	Wed, 21 Feb 2024 17:31:08 +0000
Date: Thu, 22 Feb 2024 01:30:42 +0800
From: kernel test robot <lkp@intel.com>
To: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>, linux-mm@kvack.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
	muchun.song@linux.dev,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: Re: [PATCH 1/3] mm/memory: Change vmf_anon_prepare() to be non-static
Message-ID: <202402220109.SIlFdfQ5-lkp@intel.com>
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
config: arm-defconfig (https://download.01.org/0day-ci/archive/20240222/202402220109.SIlFdfQ5-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project.git f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240222/202402220109.SIlFdfQ5-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402220109.SIlFdfQ5-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> mm/memory.c:3283:12: warning: no previous prototype for function 'vmf_anon_prepare' [-Wmissing-prototypes]
   vm_fault_t vmf_anon_prepare(struct vm_fault *vmf)
              ^
   mm/memory.c:3283:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   vm_fault_t vmf_anon_prepare(struct vm_fault *vmf)
   ^
   static 
   1 warning generated.


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

