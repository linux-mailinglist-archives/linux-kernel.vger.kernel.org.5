Return-Path: <linux-kernel+bounces-65242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77B1D8549F1
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 14:02:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2ADE81F291A8
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 13:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E22B52F8A;
	Wed, 14 Feb 2024 13:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YZT00K+A"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2138F52F6E;
	Wed, 14 Feb 2024 13:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707915717; cv=none; b=jlzzghfh5omCr4P23OXTsJOvGdeXqBfeFsNY0XnogZjmGbJ/ooKG9idiEIvD144NKWFKobDn+7rZfOF1mPM+s8mZapwllt8RbK5pay4FjpRjZ7y+iQjLwgWuhFwIae58478HQ69zGxtMO9meX3Nu2fkTt9oxLIkXwEKWmlZBg+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707915717; c=relaxed/simple;
	bh=UPDRuiOXlP13ChjfIMysQjZiACzpmw75739/2c4aLa4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XAaZDNM9hrCmDpPxPF7s64lAyfCwgjBtcer7dtNTmK5qe6tKWgSyX3NGslyY12pv3MXDwWbIS0893KoJKlm/azeqf5clu5mkpeQR8pEQe+mgSL2Vp5M4bvZhwFpbKHi7Jhmx0XiLxQqlCUM1zFvw6uSLknfOqyHY/iVbUMYJGLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YZT00K+A; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707915715; x=1739451715;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UPDRuiOXlP13ChjfIMysQjZiACzpmw75739/2c4aLa4=;
  b=YZT00K+Aip+tuYn07OoxOVHlYi8NiUJx0qbk2c/f0OmOFFsKj2fr2CWv
   eSKYe4BwzmSsTLlMBPK28EiEGchMK4dO1MdqjQIAUqH7x87bY/T2o8B8f
   Pfaqpp6xIkdN+b0nDUfyKWIJy6ed5GXqewU0zNNvQXqEw37Za4wSuZuhH
   5yiTcT2+i0HyDBMjxx2zVCdO0P/ejpI8A62vdDWOwCtBd9OGtmr7Z3NIs
   rg0XAMx0faDqXNXDQphOM6LaXNaagWataF//2d7vS+4ZUv58uCYJcjN/y
   HXLgwx2+LUTdaNa+6l6T7UL3Q+RIdOFacKbWdRzP3cxgfvUwafKxicsWm
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="1866040"
X-IronPort-AV: E=Sophos;i="6.06,159,1705392000"; 
   d="scan'208";a="1866040"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 05:01:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,159,1705392000"; 
   d="scan'208";a="7776217"
Received: from lkp-server01.sh.intel.com (HELO 01f0647817ea) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 14 Feb 2024 05:01:50 -0800
Received: from kbuild by 01f0647817ea with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1raEtY-0008m6-1t;
	Wed, 14 Feb 2024 13:01:48 +0000
Date: Wed, 14 Feb 2024 21:01:22 +0800
From: kernel test robot <lkp@intel.com>
To: Balint Dobszay <balint.dobszay@arm.com>,
	op-tee@lists.trustedfirmware.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: oe-kbuild-all@lists.linux.dev, jens.wiklander@linaro.org,
	sumit.garg@linaro.org, corbet@lwn.net, balint.dobszay@arm.com,
	sudeep.holla@arm.com, gyorgy.szing@arm.com
Subject: Re: [PATCH 1/3] tee: optee: Move pool_op helper functions
Message-ID: <202402142042.JLQEGKBr-lkp@intel.com>
References: <20240213145239.379875-2-balint.dobszay@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213145239.379875-2-balint.dobszay@arm.com>

Hi Balint,

kernel test robot noticed the following build errors:

[auto build test ERROR on lwn/docs-next]
[also build test ERROR on soc/for-next linus/master v6.8-rc4 next-20240214]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Balint-Dobszay/tee-optee-Move-pool_op-helper-functions/20240213-225716
base:   git://git.lwn.net/linux.git docs-next
patch link:    https://lore.kernel.org/r/20240213145239.379875-2-balint.dobszay%40arm.com
patch subject: [PATCH 1/3] tee: optee: Move pool_op helper functions
config: s390-allyesconfig (https://download.01.org/0day-ci/archive/20240214/202402142042.JLQEGKBr-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240214/202402142042.JLQEGKBr-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402142042.JLQEGKBr-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/tee/tee_shm.c: In function 'tee_shm_pool_op_alloc_helper':
>> drivers/tee/tee_shm.c:227:22: error: implicit declaration of function 'virt_to_phys'; did you mean 'virt_to_pfn'? [-Werror=implicit-function-declaration]
     227 |         shm->paddr = virt_to_phys(shm->kaddr);
         |                      ^~~~~~~~~~~~
         |                      virt_to_pfn
   cc1: some warnings being treated as errors


vim +227 drivers/tee/tee_shm.c

   204	
   205	int tee_shm_pool_op_alloc_helper(struct tee_shm_pool *pool, struct tee_shm *shm,
   206					 size_t size, size_t align,
   207					 int (*shm_register)(struct tee_context *ctx,
   208							     struct tee_shm *shm,
   209							     struct page **pages,
   210							     size_t num_pages,
   211							     unsigned long start))
   212	{
   213		size_t nr_pages = roundup(size, PAGE_SIZE) / PAGE_SIZE;
   214		struct page **pages;
   215		unsigned int i;
   216		int rc = 0;
   217	
   218		/*
   219		 * Ignore alignment since this is already going to be page aligned
   220		 * and there's no need for any larger alignment.
   221		 */
   222		shm->kaddr = alloc_pages_exact(nr_pages * PAGE_SIZE,
   223					       GFP_KERNEL | __GFP_ZERO);
   224		if (!shm->kaddr)
   225			return -ENOMEM;
   226	
 > 227		shm->paddr = virt_to_phys(shm->kaddr);
   228		shm->size = nr_pages * PAGE_SIZE;
   229	
   230		pages = kcalloc(nr_pages, sizeof(*pages), GFP_KERNEL);
   231		if (!pages) {
   232			rc = -ENOMEM;
   233			goto err;
   234		}
   235	
   236		for (i = 0; i < nr_pages; i++)
   237			pages[i] = virt_to_page((u8 *)shm->kaddr + i * PAGE_SIZE);
   238	
   239		shm->pages = pages;
   240		shm->num_pages = nr_pages;
   241	
   242		if (shm_register) {
   243			rc = shm_register(shm->ctx, shm, pages, nr_pages,
   244					  (unsigned long)shm->kaddr);
   245			if (rc)
   246				goto err;
   247		}
   248	
   249		return 0;
   250	err:
   251		free_pages_exact(shm->kaddr, shm->size);
   252		shm->kaddr = NULL;
   253		return rc;
   254	}
   255	EXPORT_SYMBOL_GPL(tee_shm_pool_op_alloc_helper);
   256	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

