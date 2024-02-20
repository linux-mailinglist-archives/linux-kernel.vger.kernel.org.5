Return-Path: <linux-kernel+bounces-72428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC83485B31B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 07:46:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A8911C21182
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 06:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 752FC383A1;
	Tue, 20 Feb 2024 06:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NhOa+HXY"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 061611EB42
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 06:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708411546; cv=none; b=Mv1RpWVMSl6FVCjEXwuuBM0MeM97Nm/rhBKzR+T8J25EimkkrOtXuGfInVrEUWI2+zGKxKv1DI+YT2cjDm8WZa7BTifvWVqxf8JhjkhnInzkIW0VFt7HY9K28tr9APNqgH49GYZcZBLuMrn5eLGsN6xomNH1pZF6Z8R19785ee4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708411546; c=relaxed/simple;
	bh=UlplrlZiMTBNJmRAQeFK17V8E3MVS5AXL8l87/GML48=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uGHA8TX0G76Cdtcqta67KydgBiLhwsmrM/vDoQi32kvcpZb5uo9fcoC2VoCVQvn5CEip/D24jS3gKXSE186/qdoBSbKhkkdDj1E5wwE8nYPGn78oxMcNwFvuAiQdGtz2g8cv/SOBV14lr5TlP/1vrwl6AZ6zboXjV/mic9naEZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NhOa+HXY; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708411545; x=1739947545;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UlplrlZiMTBNJmRAQeFK17V8E3MVS5AXL8l87/GML48=;
  b=NhOa+HXYIKce+5WdeJ8h40bAF/vBc+16sKmrl5QYaDheuAzAvEfqr7E4
   Kpgwbq9p2RWJ872GmdupUOM7t+cxydTyn7dcOUV7vHkGrqI6Y9Ao4Px9R
   9rknVLYmBmGbVPpgtFlL0RnxP9zXqEtWYCEcza6Dk+RNVKWJuD4N4R18c
   UX3jde8kKwoJ8H9syh9nU1QuKQimSKkh+GKCetw/Xc69nTZ1mZ7tw+6AF
   ntQM1Nn28nCBdr6G+Q/c0zPY3Gk86hxH1fDGpZZYnkbYHjzFx9sR/AsSA
   L2dZ7/I3/JWH4Pq/jtnqXU/LnerpUw41kROFVIsK0L21xQCDNFijBiVqn
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="24959317"
X-IronPort-AV: E=Sophos;i="6.06,172,1705392000"; 
   d="scan'208";a="24959317"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 22:45:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,172,1705392000"; 
   d="scan'208";a="35708692"
Received: from lkp-server02.sh.intel.com (HELO 3c78fa4d504c) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 19 Feb 2024 22:45:41 -0800
Received: from kbuild by 3c78fa4d504c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rcJsh-0004I4-31;
	Tue, 20 Feb 2024 06:45:34 +0000
Date: Tue, 20 Feb 2024 14:45:13 +0800
From: kernel test robot <lkp@intel.com>
To: Anna-Maria Behnsen <anna-maria@linutronix.de>,
	linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, linux-riscv@lists.infradead.org
Subject: Re: [PATCH 06/10] riscv/vdso: Use generic union vdso_data_store
Message-ID: <202402201410.g0YeFhx8-lkp@intel.com>
References: <20240219153939.75719-7-anna-maria@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240219153939.75719-7-anna-maria@linutronix.de>

Hi Anna-Maria,

kernel test robot noticed the following build errors:

[auto build test ERROR on s390/features]
[also build test ERROR on kees/for-next/execve arm64/for-next/core linus/master v6.8-rc5 next-20240219]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Anna-Maria-Behnsen/vdso-helpers-Fix-grammar-in-comments/20240219-234251
base:   https://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git features
patch link:    https://lore.kernel.org/r/20240219153939.75719-7-anna-maria%40linutronix.de
patch subject: [PATCH 06/10] riscv/vdso: Use generic union vdso_data_store
config: riscv-allnoconfig (https://download.01.org/0day-ci/archive/20240220/202402201410.g0YeFhx8-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240220/202402201410.g0YeFhx8-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402201410.g0YeFhx8-lkp@intel.com/

All errors (new ones prefixed by >>):

>> arch/riscv/kernel/vdso.c:34:31: error: initialization of 'struct vdso_data *' from incompatible pointer type 'struct vdso_data (*)[2]' [-Werror=incompatible-pointer-types]
      34 | struct vdso_data *vdso_data = &vdso_data_store.data;
         |                               ^
   cc1: some warnings being treated as errors


vim +34 arch/riscv/kernel/vdso.c

78a743cd82a35c Tong Tiangen       2021-09-01  32  
2f3f68e0423414 Anna-Maria Behnsen 2024-02-19  33  static union vdso_data_store vdso_data_store __page_aligned_data;
ad5d1122b82fbd Vincent Chen       2020-06-09 @34  struct vdso_data *vdso_data = &vdso_data_store.data;
76d2a0493a17d4 Palmer Dabbelt     2017-07-10  35  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

