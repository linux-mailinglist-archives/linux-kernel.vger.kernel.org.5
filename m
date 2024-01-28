Return-Path: <linux-kernel+bounces-41639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7986D83F5B5
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 15:03:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01A661F22D72
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 14:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B3A0241E9;
	Sun, 28 Jan 2024 14:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hw+rL0Au"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA4023748;
	Sun, 28 Jan 2024 14:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706450614; cv=none; b=K/C5SQAFD2X0J5laumq9lZjVLD9kqOrOLzKQevme8hpKZdco76MApe996qiVfVRNcQvYCcMSnF78NcP/LVwvxBC02CHRqryRotKDYoIz6BPXULXqO2AHQtQ5wwYSBz1osVHxuBjjRE+hneJ1h/0Ar6UmWvSBF0ds2WsPtiedXd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706450614; c=relaxed/simple;
	bh=QPKARJhphJTFFYHrEyYFlYgl8/7ZAhez9TimfUCJ8Ek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=No/UhxktnpgnpKvc1OaMvnEEuDH9zdmzj6PFWgwAvEr5wvDSkmrvop59iCxzvY7XHB/Hf+eYfvmiJjZDBVkm++psOjpUIDW8yY9+iYpQzIfsyiBiOTyJ2vpbABTuBU+dzD6EMCRJWk1f/sol/20UpB1KaLpNfjB0LTgX9AFSXok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hw+rL0Au; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706450612; x=1737986612;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QPKARJhphJTFFYHrEyYFlYgl8/7ZAhez9TimfUCJ8Ek=;
  b=hw+rL0AueG+Bemx188kmIITPFk46DT58rY9fvqvbRYAD9Ri/ZWan0gB8
   fNAZf6oQT0VTyanLltOKilpOd0JMC+9Oy753IuCKAXRpvOkTNK3eFkobR
   SS1fEKv6ksOLX1vYgkqgK/mS+ahb9EK9H1YL1wHpZX6Hu+IKWtD2ZfnRs
   DqxtWmnbK2CLjwvU5Z42VIwQvy7f48YPPfmDIGWy01DXKvmfG2w2EiVsT
   ZXOhNHz4I5LfyEit1ZGiaPnaq7SPdMo1ngF+ccctYkbGfCVFm1nbkoJtH
   vvRIObqnm5gpPYrNyXeFxCmpZ9s6t/Cp+n8HQbwt0S42h4QC2aA1bIiBb
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10966"; a="2604464"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="2604464"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2024 06:03:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="29273411"
Received: from lkp-server01.sh.intel.com (HELO 370188f8dc87) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 28 Jan 2024 06:03:29 -0800
Received: from kbuild by 370188f8dc87 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rU5ks-0003RI-1M;
	Sun, 28 Jan 2024 14:03:26 +0000
Date: Sun, 28 Jan 2024 22:02:31 +0800
From: kernel test robot <lkp@intel.com>
To: "Jason J. Herne" <jjherne@linux.ibm.com>, linux-s390@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	pasic@linux.ibm.com, akrowiak@linux.ibm.com
Subject: Re: [PATCH 3/3] s390/vfio-ap: Add write support to sysfs attr
 ap_config
Message-ID: <202401282141.A8V47yFI-lkp@intel.com>
References: <20240126143533.14043-4-jjherne@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240126143533.14043-4-jjherne@linux.ibm.com>

Hi Jason,

kernel test robot noticed the following build warnings:

[auto build test WARNING on kvms390/next]
[cannot apply to s390/features linus/master v6.8-rc1 next-20240125]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jason-J-Herne/s390-ap-Externalize-AP-bus-specific-bitmap-reading-function/20240126-223952
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git next
patch link:    https://lore.kernel.org/r/20240126143533.14043-4-jjherne%40linux.ibm.com
patch subject: [PATCH 3/3] s390/vfio-ap: Add write support to sysfs attr ap_config
config: s390-defconfig (https://download.01.org/0day-ci/archive/20240128/202401282141.A8V47yFI-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240128/202401282141.A8V47yFI-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401282141.A8V47yFI-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/cpumask.h:12,
                    from include/linux/smp.h:13,
                    from include/linux/lockdep.h:14,
                    from include/linux/spinlock.h:63,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:7,
                    from include/linux/mm.h:7,
                    from include/linux/scatterlist.h:8,
                    from include/linux/iommu.h:10,
                    from include/linux/vfio.h:12,
                    from drivers/s390/crypto/vfio_ap_ops.c:12:
   In function 'bitmap_copy',
       inlined from 'ap_matrix_copy' at drivers/s390/crypto/vfio_ap_ops.c:1593:2,
       inlined from 'ap_config_store' at drivers/s390/crypto/vfio_ap_ops.c:1616:2:
>> include/linux/bitmap.h:245:17: warning: 'memcpy' reading 32 bytes from a region of size 0 [-Wstringop-overread]
     245 |                 memcpy(dst, src, len);
         |                 ^~~~~~~~~~~~~~~~~~~~~
   In function 'ap_config_store':
   cc1: note: source object is likely at address zero
   In function 'bitmap_copy',
       inlined from 'ap_matrix_copy' at drivers/s390/crypto/vfio_ap_ops.c:1594:2,
       inlined from 'ap_config_store' at drivers/s390/crypto/vfio_ap_ops.c:1616:2:
>> include/linux/bitmap.h:245:17: warning: 'memcpy' reading 32 bytes from a region of size 0 [-Wstringop-overread]
     245 |                 memcpy(dst, src, len);
         |                 ^~~~~~~~~~~~~~~~~~~~~
   In function 'ap_config_store':
   cc1: note: source object is likely at address zero
   In function 'bitmap_copy',
       inlined from 'ap_matrix_copy' at drivers/s390/crypto/vfio_ap_ops.c:1595:2,
       inlined from 'ap_config_store' at drivers/s390/crypto/vfio_ap_ops.c:1616:2:
>> include/linux/bitmap.h:245:17: warning: 'memcpy' reading 32 bytes from a region of size 0 [-Wstringop-overread]
     245 |                 memcpy(dst, src, len);
         |                 ^~~~~~~~~~~~~~~~~~~~~
   In function 'ap_config_store':
   cc1: note: source object is likely at address zero


vim +/memcpy +245 include/linux/bitmap.h

^1da177e4c3f41 Linus Torvalds    2005-04-16  236  
^1da177e4c3f41 Linus Torvalds    2005-04-16  237  static inline void bitmap_copy(unsigned long *dst, const unsigned long *src,
8b4daad52fee77 Rasmus Villemoes  2015-02-12  238  			unsigned int nbits)
^1da177e4c3f41 Linus Torvalds    2005-04-16  239  {
8b4daad52fee77 Rasmus Villemoes  2015-02-12  240  	unsigned int len = BITS_TO_LONGS(nbits) * sizeof(unsigned long);
3e7e5baaaba780 Alexander Lobakin 2022-06-24  241  
3e7e5baaaba780 Alexander Lobakin 2022-06-24  242  	if (small_const_nbits(nbits))
3e7e5baaaba780 Alexander Lobakin 2022-06-24  243  		*dst = *src;
3e7e5baaaba780 Alexander Lobakin 2022-06-24  244  	else
^1da177e4c3f41 Linus Torvalds    2005-04-16 @245  		memcpy(dst, src, len);
^1da177e4c3f41 Linus Torvalds    2005-04-16  246  }
^1da177e4c3f41 Linus Torvalds    2005-04-16  247  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

