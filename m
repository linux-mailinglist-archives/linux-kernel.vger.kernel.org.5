Return-Path: <linux-kernel+bounces-51152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F23E848725
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 16:38:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0E701F23B32
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 15:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51D645F54C;
	Sat,  3 Feb 2024 15:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QhV3hOoj"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3822F5F543;
	Sat,  3 Feb 2024 15:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706974685; cv=none; b=XQMllseEm4h+Igkv589RSSLAgvKt921ivJt4YG+uDmXA0UTRzkwbC3Gu5Op/alH97UB9iu+wX+eitAjxFMDv3obmlIKmXwiCHqNa60JSfBPdyg6slVwf37dvE8cpGXJtCCU2U+9O62IIyHMEAj4VxOVmBEGpTJdCFmYJk7ItorA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706974685; c=relaxed/simple;
	bh=SNnVQo1kDmMsJArsZpVPFWmrsmhNlHXHLXsJaiu5qlo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qTKLXWtieOf1VqvFyDc8PteECsbqdJwXTz2nGyw/HN/Rtr7aKMpIzDnnu1DIyIt4BMyIZeR1PU0dSWdJu8uTrZRdO+AKL3SJUeZVwrICuo3+jnpuFiXR/McbPU8EO2eJoaIFmXrFcs3k/H5MtcZot7HT9NFEvi/k8yW5e2+XadE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QhV3hOoj; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706974683; x=1738510683;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SNnVQo1kDmMsJArsZpVPFWmrsmhNlHXHLXsJaiu5qlo=;
  b=QhV3hOojdOTaDCGY8hp429N1w2lb5AdvEsTms3hlmA0kpwnwGyPuZ/zv
   7n1trTDvxyeHqu6flWym3whGObowlRUecXxSYBgndSAA1U+dv/bkWDFDC
   vZLOaoqOR3OMs0XOwOxMVyYwmyECvRt77YvgRv2FixusRe+GpZts8uEe/
   kSAEFUF8mu6MxNuNW0rWXxvZC9fJ6F8EwbRzkDAa8c5uILiY14b8xE+cr
   HqJvY4WGmxdVdXObuVt4QzvEibWsQxWHCp+ycEe6TqwQ9wFDV5uyKFwkD
   gTu8M9/XCipWLqddeYrNu7QNjvGO8dSJix5lJeXdBw1v6DvbafFdBAl8N
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10973"; a="243130"
X-IronPort-AV: E=Sophos;i="6.05,240,1701158400"; 
   d="scan'208";a="243130"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2024 07:38:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,240,1701158400"; 
   d="scan'208";a="652517"
Received: from lkp-server02.sh.intel.com (HELO 59f4f4cd5935) ([10.239.97.151])
  by orviesa007.jf.intel.com with ESMTP; 03 Feb 2024 07:38:00 -0800
Received: from kbuild by 59f4f4cd5935 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rWI5d-0005F0-1g;
	Sat, 03 Feb 2024 15:37:57 +0000
Date: Sat, 3 Feb 2024 23:37:16 +0800
From: kernel test robot <lkp@intel.com>
To: Ekansh Gupta <quic_ekangupt@quicinc.com>,
	srinivas.kandagatla@linaro.org, linux-arm-msm@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 03/16] misc: fastrpc: Add static PD restart support
Message-ID: <202402032322.GxfJcjnK-lkp@intel.com>
References: <20240202064039.15505-4-quic_ekangupt@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240202064039.15505-4-quic_ekangupt@quicinc.com>

Hi Ekansh,

kernel test robot noticed the following build errors:

[auto build test ERROR on char-misc/char-misc-testing]
[also build test ERROR on char-misc/char-misc-next char-misc/char-misc-linus linus/master v6.8-rc2 next-20240202]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ekansh-Gupta/misc-fastrpc-Redesign-remote-heap-management/20240202-144921
base:   char-misc/char-misc-testing
patch link:    https://lore.kernel.org/r/20240202064039.15505-4-quic_ekangupt%40quicinc.com
patch subject: [PATCH v1 03/16] misc: fastrpc: Add static PD restart support
config: i386-buildonly-randconfig-006-20240203 (https://download.01.org/0day-ci/archive/20240203/202402032322.GxfJcjnK-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240203/202402032322.GxfJcjnK-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402032322.GxfJcjnK-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: drivers/misc/fastrpc.o: in function `fastrpc_setup_service_locator.constprop.0':
>> fastrpc.c:(.text+0x752): undefined reference to `pdr_handle_alloc'
>> ld: fastrpc.c:(.text+0x781): undefined reference to `pdr_add_lookup'
   ld: drivers/misc/fastrpc.o: in function `fastrpc_rpmsg_remove':
>> fastrpc.c:(.text+0x16f4): undefined reference to `pdr_handle_release'
>> ld: fastrpc.c:(.text+0x16ff): undefined reference to `pdr_handle_release'
   ld: fastrpc.c:(.text+0x172c): undefined reference to `pdr_handle_release'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

