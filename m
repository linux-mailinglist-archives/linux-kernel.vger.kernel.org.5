Return-Path: <linux-kernel+bounces-27036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A551E82E979
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 07:22:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 579331F239C8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 06:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A1711097B;
	Tue, 16 Jan 2024 06:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Aol/xPA1"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752C579F6;
	Tue, 16 Jan 2024 06:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705386165; x=1736922165;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=T2HUSRrSF0gl6JOqX4YdcfSMQQjj74IfOdQ2rVoRLys=;
  b=Aol/xPA1AHpo4qJqsOS5jYQ4Qw7dtDx3Kosc/m3l+q8HIHSj+6Va41bM
   f9RVpF2xtJ93O4yPIt2QkU/SvWP3KJEMMd4JSpY6H0dADWSqkte4eBnk+
   /YG93H6780qPLejXugVsqzPntbjQCyyMsLxyeMWPZMSsrYr6oM4GHC6RR
   NnfEuJL0/LNOJAEX+n7OuJldm0m/6VAxxLACyCHuRgndSH1WXQdtfZTij
   03XgqS9mL6R7LxMh2qf1ChOpFzGILTY5iJHgC2HrJzEV4GFwoxstUwQIn
   l7Jvw7IshguVM3k6kEG0PsJ+d4gQFSTHNwdgMBiIZ5h9Ae2ZOHqVAricy
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10954"; a="390217876"
X-IronPort-AV: E=Sophos;i="6.04,198,1695711600"; 
   d="scan'208";a="390217876"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2024 22:22:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10954"; a="733504139"
X-IronPort-AV: E=Sophos;i="6.04,198,1695711600"; 
   d="scan'208";a="733504139"
Received: from lkp-server01.sh.intel.com (HELO 961aaaa5b03c) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 15 Jan 2024 22:22:40 -0800
Received: from kbuild by 961aaaa5b03c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rPcqM-00006u-2E;
	Tue, 16 Jan 2024 06:22:38 +0000
Date: Tue, 16 Jan 2024 14:22:29 +0800
From: kernel test robot <lkp@intel.com>
To: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Jens Wiklander <jens.wiklander@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Paul Gazzillo <paul@pgazz.com>,
	Necip Fazil Yildiran <fazilyildiran@gmail.com>,
	oe-kbuild-all@lists.linux.dev,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
	op-tee@lists.trustedfirmware.org, devicetree@vger.kernel.org,
	Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
Subject: Re: [PATCH 4/4] remoteproc: stm32: Add support of an OP-TEE TA to
 load the firmware
Message-ID: <202401161447.0AQqNEiO-lkp@intel.com>
References: <20240115135249.296822-5-arnaud.pouliquen@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240115135249.296822-5-arnaud.pouliquen@foss.st.com>

Hi Arnaud,

kernel test robot noticed the following build warnings:

[auto build test WARNING on remoteproc/rproc-next]
[also build test WARNING on robh/for-next linus/master v6.7 next-20240112]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Arnaud-Pouliquen/remoteproc-Add-TEE-support/20240115-215613
base:   git://git.kernel.org/pub/scm/linux/kernel/git/remoteproc/linux.git rproc-next
patch link:    https://lore.kernel.org/r/20240115135249.296822-5-arnaud.pouliquen%40foss.st.com
patch subject: [PATCH 4/4] remoteproc: stm32: Add support of an OP-TEE TA to load the firmware
config: alpha-kismet-CONFIG_TEE_REMOTEPROC-CONFIG_STM32_RPROC-0-0 (https://download.01.org/0day-ci/archive/20240116/202401161447.0AQqNEiO-lkp@intel.com/config)
reproduce: (https://download.01.org/0day-ci/archive/20240116/202401161447.0AQqNEiO-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401161447.0AQqNEiO-lkp@intel.com/

kismet warnings: (new ones prefixed by >>)
>> kismet: WARNING: unmet direct dependencies detected for TEE_REMOTEPROC when selected by STM32_RPROC
   
   WARNING: unmet direct dependencies detected for TEE_REMOTEPROC
     Depends on [n]: REMOTEPROC [=y] && OPTEE [=n]
     Selected by [y]:
     - STM32_RPROC [=y] && (ARCH_STM32 || COMPILE_TEST [=y]) && REMOTEPROC [=y]

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

