Return-Path: <linux-kernel+bounces-75945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A30085F100
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 06:37:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFC231F22717
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 05:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 098CFD516;
	Thu, 22 Feb 2024 05:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C2FudPtp"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46609168BD
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 05:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708580227; cv=none; b=lakNiDiHAmxp1xem02ytxZi+6d3IHfGlePqjXm0QIFm+Deb+FdHXCBnAWYUtv95mjqdDqJjirkAQ4/kcKFhm2dXi3fmIzmgulRSY2GuD801caI6+dmBZI6UOoJXSXqf9OrkqBG33b4TI/QS+i/MMQL32k+4g1+Y4E0A+X95u1eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708580227; c=relaxed/simple;
	bh=QeI2uBjQcu057UUOzLotCkKnUelckhJN0RTsfRbGdyE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aUhlxp0DEAcYVB2Ryt7E3GSTUoB8BRzuUO+YUgb2WKTad/3n9/VPoCqLX7eQ4mwvnM4Q5Z1EPBuq1XdK0BoBSytEWhr33vUjujEuaO/2XDkE39+XsTsFVkJnMPY04fCDKeBIQwaTUm/r0aXTMFnsJJurxA8/YUNbRBiFV4vMSdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C2FudPtp; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708580210; x=1740116210;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QeI2uBjQcu057UUOzLotCkKnUelckhJN0RTsfRbGdyE=;
  b=C2FudPtpG2etn2TqPBtGjbA75FybwVEgUkWIohuDnFsfmgbzvJlKMVWl
   4CkbDAoA1n6uAMJ3ov6ncbjpUt3HpFFtGFN1EIn6BVdCj/3G0rlszS9bN
   pw+nxcorYxDB1dUe5KqcZAfsPMj51OaH6i9Rfhopgc4GzRHpr2aWO5Me5
   TY+A/+dR9tSk8vDHob9BjebjZlKU0koNe+sMS4AndP0TqmXlxhUjsCZ2p
   VELqCYalWUeJpAvaU/nuSMos4WTJGIOKsdz06/p7CeLA7fsH6T4LwRSK8
   G9NmeRhePycwy7P5PTEG8mQkXA4q53yhUX+TM/sTs8Gdku6nSxcOw9Jle
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="13406324"
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="13406324"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2024 21:36:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="9975667"
Received: from lkp-server02.sh.intel.com (HELO 3c78fa4d504c) ([10.239.97.151])
  by fmviesa003.fm.intel.com with ESMTP; 21 Feb 2024 21:36:42 -0800
Received: from kbuild by 3c78fa4d504c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rd1l9-00061A-2w;
	Thu, 22 Feb 2024 05:36:39 +0000
Date: Thu, 22 Feb 2024 13:35:56 +0800
From: kernel test robot <lkp@intel.com>
To: Viacheslav Bocharov <adeep@lexina.in>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v2 2/3] soc: amlogic: meson-gx-socinfo-sm: Add Amlogic
 secure-monitor SoC Information driver
Message-ID: <202402221322.ifGMGQa6-lkp@intel.com>
References: <20240221143654.544444-3-adeep@lexina.in>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240221143654.544444-3-adeep@lexina.in>

Hi Viacheslav,

kernel test robot noticed the following build errors:

[auto build test ERROR on 9fc1ccccfd8d53dc7936fe6d633f2373fc9f62e8]

url:    https://github.com/intel-lab-lkp/linux/commits/Viacheslav-Bocharov/soc-amlogic-meson-gx-socinfo-move-common-code-to-header-file/20240221-224803
base:   9fc1ccccfd8d53dc7936fe6d633f2373fc9f62e8
patch link:    https://lore.kernel.org/r/20240221143654.544444-3-adeep%40lexina.in
patch subject: [PATCH v2 2/3] soc: amlogic: meson-gx-socinfo-sm: Add Amlogic secure-monitor SoC Information driver
config: arm64-randconfig-002-20240222 (https://download.01.org/0day-ci/archive/20240222/202402221322.ifGMGQa6-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240222/202402221322.ifGMGQa6-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402221322.ifGMGQa6-lkp@intel.com/

All errors (new ones prefixed by >>):

   aarch64-linux-ld: Unexpected GOT/PLT entries detected!
   aarch64-linux-ld: Unexpected run-time procedure linkages detected!
   aarch64-linux-ld: drivers/soc/amlogic/meson-gx-socinfo-sm.o: in function `socinfo_get_chipid':
>> meson-gx-socinfo-sm.c:(.text+0xac): undefined reference to `meson_sm_call_read'
   aarch64-linux-ld: drivers/soc/amlogic/meson-gx-socinfo-sm.o: in function `meson_gx_socinfo_sm_probe':
>> meson-gx-socinfo-sm.c:(.text+0x438): undefined reference to `meson_sm_get'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

