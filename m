Return-Path: <linux-kernel+bounces-60421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2CBC8504A6
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 15:16:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43C8A1F2294A
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 14:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 342CC53E1F;
	Sat, 10 Feb 2024 14:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B0OPgzFm"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F582030B
	for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 14:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707574586; cv=none; b=fzvB/dfkrwJ/Sux1UiW0p7C6PZMwwjY3zyye5ECewmDZ/k51Tzy/0lWmkWqzyzHWgPwrN62O6qtlGji57GcZf7f+xSdLdbuJDyiihYfIHnTDci7SAY+fu8/FLad2ZuqChO5P93iLaxS3JbZ+5G4vAAvxVTzxtrGFZ4PalXBW29U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707574586; c=relaxed/simple;
	bh=xp9zH1WaW6uoig/Qd9fQ2SgwWOA/7EqqFkCeMF5KI/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QNy4iE86pdmaTEQWru16P+jVElPQqxw88Aa8tMtq8FRN9LD6k+eWj1BmkbkJRK/jMd4LMDCx2tMNO3TPRCeedAAvxmQDtJBZkt+jwKTfVrBVMNiExk+NA7ssjLg5UWvl61uAu2E4f0+YQUlAvUPPTT3zJgcW9DdnKx38IEakg0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B0OPgzFm; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707574584; x=1739110584;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xp9zH1WaW6uoig/Qd9fQ2SgwWOA/7EqqFkCeMF5KI/4=;
  b=B0OPgzFmcTD+yAz0ggJvrp4EQ+xBLwMDL15wdNa7fcXiQuEH6b+7tqbs
   otr1Ggz7nW2a3mzPvkbbYSlivDv88OwCfaV2bMy56WXkUFXGxCtC3X13e
   cIH4YDZ3iNzGDchNlm4v1w1nejvVag9EZooknQ3K+spjELhbQST1Z4Rmk
   kMJgiCLwFXBgB6zK9yRPgWogVSxOMax9vUhEqcEP7T+jul7TMD5/rVLvg
   xSVv3Ik1BJ8jzpyWwJsONB6RnXIwbvL03phhwdalP+Ed7Fv8aPkvhBHhC
   8STOYn/9JiRimZA7Pgo5uHeYwISZ6Ha3k2wf+YlDkLaTg1YFCy9ORRQgY
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10979"; a="1721049"
X-IronPort-AV: E=Sophos;i="6.05,259,1701158400"; 
   d="scan'208";a="1721049"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2024 06:16:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,259,1701158400"; 
   d="scan'208";a="33257272"
Received: from lkp-server01.sh.intel.com (HELO 01f0647817ea) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 10 Feb 2024 06:16:21 -0800
Received: from kbuild by 01f0647817ea with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rYo9S-0005hy-2Y;
	Sat, 10 Feb 2024 14:16:18 +0000
Date: Sat, 10 Feb 2024 22:16:07 +0800
From: kernel test robot <lkp@intel.com>
To: "Ricardo B. Marliere" <ricardo@marliere.net>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
Cc: oe-kbuild-all@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Ricardo B. Marliere" <ricardo@marliere.net>
Subject: Re: [PATCH 4/4] powerpc: ibmebus: make ibmebus_bus_type const
Message-ID: <202402102142.uphiKeqw-lkp@intel.com>
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
config: powerpc-allmodconfig (https://download.01.org/0day-ci/archive/20240210/202402102142.uphiKeqw-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240210/202402102142.uphiKeqw-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402102142.uphiKeqw-lkp@intel.com/

All errors (new ones prefixed by >>):

>> arch/powerpc/platforms/pseries/ibmebus.c:58:17: error: conflicting type qualifiers for 'ibmebus_bus_type'
      58 | struct bus_type ibmebus_bus_type;
         |                 ^~~~~~~~~~~~~~~~
   In file included from arch/powerpc/platforms/pseries/ibmebus.c:51:
   arch/powerpc/include/asm/ibmebus.h:51:30: note: previous declaration of 'ibmebus_bus_type' with type 'const struct bus_type'
      51 | extern const struct bus_type ibmebus_bus_type;
         |                              ^~~~~~~~~~~~~~~~
   In file included from arch/powerpc/platforms/pseries/ibmebus.c:40:
   arch/powerpc/platforms/pseries/ibmebus.c:445:15: error: conflicting type qualifiers for 'ibmebus_bus_type'
     445 | EXPORT_SYMBOL(ibmebus_bus_type);
         |               ^~~~~~~~~~~~~~~~
   include/linux/export.h:56:28: note: in definition of macro '__EXPORT_SYMBOL'
      56 |         extern typeof(sym) sym;                                 \
         |                            ^~~
   include/linux/export.h:68:41: note: in expansion of macro '_EXPORT_SYMBOL'
      68 | #define EXPORT_SYMBOL(sym)              _EXPORT_SYMBOL(sym, "")
         |                                         ^~~~~~~~~~~~~~
   arch/powerpc/platforms/pseries/ibmebus.c:445:1: note: in expansion of macro 'EXPORT_SYMBOL'
     445 | EXPORT_SYMBOL(ibmebus_bus_type);
         | ^~~~~~~~~~~~~
   arch/powerpc/platforms/pseries/ibmebus.c:435:23: note: previous definition of 'ibmebus_bus_type' with type 'const struct bus_type'
     435 | const struct bus_type ibmebus_bus_type = {
         |                       ^~~~~~~~~~~~~~~~


vim +/ibmebus_bus_type +58 arch/powerpc/platforms/pseries/ibmebus.c

d7a301033f1990 arch/powerpc/kernel/ibmebus.c Heiko J Schick 2005-11-16  57  
6bccf755ff5324 arch/powerpc/kernel/ibmebus.c Joachim Fenkes 2007-03-09 @58  struct bus_type ibmebus_bus_type;
6bccf755ff5324 arch/powerpc/kernel/ibmebus.c Joachim Fenkes 2007-03-09  59  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

