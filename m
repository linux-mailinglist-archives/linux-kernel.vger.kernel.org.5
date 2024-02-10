Return-Path: <linux-kernel+bounces-60574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 506E08506E8
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 23:56:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 832AF1C21E8F
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 22:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 889295FEEE;
	Sat, 10 Feb 2024 22:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jH4Az/Oq"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646E55FDDA
	for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 22:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707605806; cv=none; b=NJILBkoUo/l39yk6e7L90TGeFFTBLVAPyRgS4rYez5mbWtmktEo7AEjqPGchar19iZp4ipjvZFiLeIdwRcvEdiaaM8KkXGhZb1KVi9AHu2b9ilHGKPXFNtVm3QJoMDAHgOklhDRlWPvz/ftd33yd7EN+xf3OLOasxU6aCQk1C2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707605806; c=relaxed/simple;
	bh=kznykOs2boAsIDcRBVKJBzW2mUxpRYIaGPtEKyKzJRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r7WovdPgRy86eYfLXh5QgEsb897LAqenIOhfJjj0Pd4VSxQXzb6Ms9iMhIQ/hQFjhBLqdqnpYjEIrBCLPnPy2opyZqMoHnveNOWg4bF1poDNYKmIbDkdXnONbOhRQTRnTB1+gjaPkJ1qfEQ8YpfkpPJpMi6/3Q/23Z9mfWT8zY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jH4Az/Oq; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707605804; x=1739141804;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kznykOs2boAsIDcRBVKJBzW2mUxpRYIaGPtEKyKzJRQ=;
  b=jH4Az/OqQKUtvi23vWkBn1rqXRb5zCcaq4JVwZrFo/LjTogrmXLhfdj8
   G0dzTeHuojrIHfpI8k1pRwlQ5V/BqoO1QjlwgJP9OubBHU/sGEC4jHSp0
   eUgOd0k50udU2l9nDaKrwdFVWLdi1a00CWgvi0ypQCyvbcXG5hHjoNTH1
   X90T9MCsbrrhgj/54IkqBdX6V2CYbF5LBg5zWlxg6iweCeOIeLDtO1d9r
   y8l5tLiBmpx4Cb0uF9JcZZcHshmJ3NHAerKyz1ombmJB6Rc3fzhfY0sG1
   SrGqjK10tVse6zGmM5Ln0nwRu3IVBlPGA6q6VfvkaxRbak0QXVQZzTSe/
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10980"; a="12322143"
X-IronPort-AV: E=Sophos;i="6.05,259,1701158400"; 
   d="scan'208";a="12322143"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2024 14:56:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,259,1701158400"; 
   d="scan'208";a="2548626"
Received: from lkp-server01.sh.intel.com (HELO 01f0647817ea) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 10 Feb 2024 14:56:40 -0800
Received: from kbuild by 01f0647817ea with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rYwH0-00069a-13;
	Sat, 10 Feb 2024 22:56:38 +0000
Date: Sun, 11 Feb 2024 06:56:04 +0800
From: kernel test robot <lkp@intel.com>
To: "Ricardo B. Marliere" <ricardo@marliere.net>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Ricardo B. Marliere" <ricardo@marliere.net>
Subject: Re: [PATCH 4/4] powerpc: ibmebus: make ibmebus_bus_type const
Message-ID: <202402110615.H1X3DSiC-lkp@intel.com>
References: <20240209-bus_cleanup-powerpc2-v1-4-79a56dcaebb1@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240209-bus_cleanup-powerpc2-v1-4-79a56dcaebb1@marliere.net>

Hi Ricardo,

kernel test robot noticed the following build errors:

[auto build test ERROR on 41bccc98fb7931d63d03f326a746ac4d429c1dd3]

url:    https://github.com/intel-lab-lkp/linux/commits/Ricardo-B-Marliere/powerpc-vio-move-device-attributes-into-a-new-ifdef/20240210-080925
base:   41bccc98fb7931d63d03f326a746ac4d429c1dd3
patch link:    https://lore.kernel.org/r/20240209-bus_cleanup-powerpc2-v1-4-79a56dcaebb1%40marliere.net
patch subject: [PATCH 4/4] powerpc: ibmebus: make ibmebus_bus_type const
config: powerpc-allyesconfig (https://download.01.org/0day-ci/archive/20240211/202402110615.H1X3DSiC-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project ac0577177f053ba7e7016e1b7e44cf5932d00b03)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240211/202402110615.H1X3DSiC-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402110615.H1X3DSiC-lkp@intel.com/

All errors (new ones prefixed by >>):

>> arch/powerpc/platforms/pseries/ibmebus.c:58:17: error: redefinition of 'ibmebus_bus_type' with a different type: 'struct bus_type' vs 'const struct bus_type'
      58 | struct bus_type ibmebus_bus_type;
         |                 ^
   arch/powerpc/include/asm/ibmebus.h:51:30: note: previous declaration is here
      51 | extern const struct bus_type ibmebus_bus_type;
         |                              ^
   arch/powerpc/platforms/pseries/ibmebus.c:134:17: warning: shift count >= width of type [-Wshift-count-overflow]
     134 |         return mask == DMA_BIT_MASK(64);
         |                        ^~~~~~~~~~~~~~~~
   include/linux/dma-mapping.h:77:54: note: expanded from macro 'DMA_BIT_MASK'
      77 | #define DMA_BIT_MASK(n) (((n) == 64) ? ~0ULL : ((1ULL<<(n))-1))
         |                                                      ^ ~~~
   arch/powerpc/platforms/pseries/ibmebus.c:139:9: warning: shift count >= width of type [-Wshift-count-overflow]
     139 |         return DMA_BIT_MASK(64);
         |                ^~~~~~~~~~~~~~~~
   include/linux/dma-mapping.h:77:54: note: expanded from macro 'DMA_BIT_MASK'
      77 | #define DMA_BIT_MASK(n) (((n) == 64) ? ~0ULL : ((1ULL<<(n))-1))
         |                                                      ^ ~~~
   2 warnings and 1 error generated.


vim +58 arch/powerpc/platforms/pseries/ibmebus.c

d7a301033f1990 arch/powerpc/kernel/ibmebus.c Heiko J Schick 2005-11-16  57  
6bccf755ff5324 arch/powerpc/kernel/ibmebus.c Joachim Fenkes 2007-03-09 @58  struct bus_type ibmebus_bus_type;
6bccf755ff5324 arch/powerpc/kernel/ibmebus.c Joachim Fenkes 2007-03-09  59  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

