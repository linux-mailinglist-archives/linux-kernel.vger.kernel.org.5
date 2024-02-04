Return-Path: <linux-kernel+bounces-51416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC222848AFA
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 05:05:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8785D1F23B37
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 04:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 248802C9E;
	Sun,  4 Feb 2024 04:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QB+Mzl1N"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CADCA15B7;
	Sun,  4 Feb 2024 04:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707019547; cv=none; b=CcLO5m1P8uw1f1WFB/+qFK8LubFYbf/COj8ZZ55FSxjrlHtuOL9t3hbvr4ri6aa7AUTRFHnZbCbShH2OwG1xcNoTu/ec6s/T7M+m1RHeU/Ufq4+uSzR9O8Jb8KCW3WXovPJklS8RIOYxsCGXaso5G7j2mdPnWIWs7ldDz8n2yJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707019547; c=relaxed/simple;
	bh=b9XEpdFPe/PNZC2HYAEQHdLzNXB1WRKccHhHm8G9vkE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=USZ6rGCAR9Sim5Kc0JNuBSvqIIVCeKSjo3qKgSIp6Z7UbVkFE17YOMZrAOFhciEmOn1RsNSf9NJe/stoXipr4nA3Gkuq0Ij7vt9IwwRRj8DWAJTS45zNobFgqIMDpKDHwFSZowD2x3RWZHoTqDW/zXQ7T9/RAJmxx/+G5QW7SGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QB+Mzl1N; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707019546; x=1738555546;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=b9XEpdFPe/PNZC2HYAEQHdLzNXB1WRKccHhHm8G9vkE=;
  b=QB+Mzl1N2d5FOpwVpPCojpnOaX0mUnMOHJkD0lHwyIuo5YCBRYILl5Fu
   ZB13s1TQXCvipPAo/69MzBXaOdJFjtcGN9ib3U7kyPgAyAkrlTjk6spNC
   ZZ09AlC/5LF2EZ5wtwFiygvtJM0mbc8NaBv7OWHZVsW7cy9SH9ZkLhnAC
   D64wVHNlsjzxLFy1EaQ8vMuJYCoBuVqYmLu3NwRwosWyXjPNCTyYE0APK
   OBj6UBxEjjJKWYsYLDQ5FE5wZqAxwKO3QHVdLgvu3r5hvjalIz4P9geH+
   bDZuq1Fs9vz+qajEIj1C4pWizSPHVsemIjtJ4OFdWsrk43xnKOj+AK2NQ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10973"; a="11727322"
X-IronPort-AV: E=Sophos;i="6.05,242,1701158400"; 
   d="scan'208";a="11727322"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2024 20:05:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,242,1701158400"; 
   d="scan'208";a="480284"
Received: from lkp-server02.sh.intel.com (HELO 59f4f4cd5935) ([10.239.97.151])
  by fmviesa007.fm.intel.com with ESMTP; 03 Feb 2024 20:05:42 -0800
Received: from kbuild by 59f4f4cd5935 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rWTlD-0005zq-0O;
	Sun, 04 Feb 2024 04:05:39 +0000
Date: Sun, 4 Feb 2024 12:04:48 +0800
From: kernel test robot <lkp@intel.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>
Cc: oe-kbuild-all@lists.linux.dev, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 4/5] firmware: imx: support BBM module
Message-ID: <202402041140.l2qPp6Gn-lkp@intel.com>
References: <20240202-imx95-bbm-misc-v1-4-3cb743020933@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240202-imx95-bbm-misc-v1-4-3cb743020933@nxp.com>

Hi Peng,

kernel test robot noticed the following build errors:

[auto build test ERROR on 51b70ff55ed88edd19b080a524063446bcc34b62]

url:    https://github.com/intel-lab-lkp/linux/commits/Peng-Fan-OSS/dt-bindings-firmware-add-i-MX-SCMI-Extension-protocol/20240202-143439
base:   51b70ff55ed88edd19b080a524063446bcc34b62
patch link:    https://lore.kernel.org/r/20240202-imx95-bbm-misc-v1-4-3cb743020933%40nxp.com
patch subject: [PATCH 4/5] firmware: imx: support BBM module
config: s390-allyesconfig (https://download.01.org/0day-ci/archive/20240204/202402041140.l2qPp6Gn-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240204/202402041140.l2qPp6Gn-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402041140.l2qPp6Gn-lkp@intel.com/

All errors (new ones prefixed by >>):

   s390-linux-ld: drivers/firmware/imx/sm-bbm.o: in function `scmi_imx_bbm_probe':
>> sm-bbm.c:(.text+0xbdc): undefined reference to `devm_rtc_allocate_device'
>> s390-linux-ld: sm-bbm.c:(.text+0xc90): undefined reference to `__devm_rtc_register_device'
   s390-linux-ld: drivers/firmware/imx/sm-bbm.o: in function `scmi_imx_bbm_notifier':
>> sm-bbm.c:(.text+0xeb6): undefined reference to `rtc_update_irq'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

