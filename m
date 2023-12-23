Return-Path: <linux-kernel+bounces-10503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C13981D528
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 17:49:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B96A1F220ED
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 16:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68DF51119C;
	Sat, 23 Dec 2023 16:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cp5axuEG"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F089310940
	for <linux-kernel@vger.kernel.org>; Sat, 23 Dec 2023 16:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703350179; x=1734886179;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/S5uzL9+H61s2Jns5PxqIIJyFYN0g/vKObALDuHWy6o=;
  b=Cp5axuEG1gSI6TMoQX6XtO7Fmz8488mvaiHHxUcMoPLncQPytrDLcemC
   JPJ4QV0x/NZlPcETo1tFQs46K80R83W8onDNMedheBGbjNWIqkeLr86So
   kON6oXXRhsMvQJYMCa1M8LNAzzfOeNVdEjymQSyhnlc7EbRkogov9oXJs
   ktHKktJ+9w5nTOUTjWMt/Z9EVRsqZLd3/xJaiLLKemt3FtCBJrEVYKdzR
   FiAO5gkZ6HkTog7Ipdn8MKDXoxSktRJu+62LHJREYIiyC/vi89neOFyfT
   lHKjNlh4eIwr8KU+b6FXWI4yTzzC9gff93ur3fUJrCcpS8Pl8poakX+8w
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10933"; a="9599616"
X-IronPort-AV: E=Sophos;i="6.04,299,1695711600"; 
   d="scan'208";a="9599616"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2023 08:49:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10933"; a="811652591"
X-IronPort-AV: E=Sophos;i="6.04,299,1695711600"; 
   d="scan'208";a="811652591"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 23 Dec 2023 08:49:33 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rH5BW-000BDP-2q;
	Sat, 23 Dec 2023 16:49:17 +0000
Date: Sun, 24 Dec 2023 00:41:50 +0800
From: kernel test robot <lkp@intel.com>
To: Mark Hasemeyer <markhas@chromium.org>,
	LKML <linux-kernel@vger.kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Raul Rangel <rrangel@chromium.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Rob Herring <robh@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>,
	Mark Hasemeyer <markhas@chromium.org>,
	Benson Leung <bleung@chromium.org>,
	Bhanu Prakash Maiya <bhanumaiya@chromium.org>,
	Chen-Yu Tsai <wenst@chromium.org>,
	Guenter Roeck <groeck@chromium.org>, Lee Jones <lee@kernel.org>,
	Prashant Malani <pmalani@chromium.org>,
	Rob Barnes <robbarnes@google.com>,
	Stephen Boyd <swboyd@chromium.org>, chrome-platform@lists.linux.dev
Subject: Re: [PATCH v2 22/22] platform/chrome: cros_ec: Use PM subsystem to
 manage wakeirq
Message-ID: <202312240045.wiFeDc1T-lkp@intel.com>
References: <20231220165423.v2.22.Ieee574a0e94fbaae01fd6883ffe2ceeb98d7df28@changeid>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231220165423.v2.22.Ieee574a0e94fbaae01fd6883ffe2ceeb98d7df28@changeid>

Hi Mark,

kernel test robot noticed the following build errors:

[auto build test ERROR on robh/for-next]
[also build test ERROR on chrome-platform/for-next chrome-platform/for-firmware-next wsa/i2c/for-next driver-core/driver-core-testing driver-core/driver-core-next driver-core/driver-core-linus linus/master v6.7-rc6 next-20231222]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Mark-Hasemeyer/gpiolib-acpi-Modify-acpi_dev_irq_wake_get_by-to-use-resource/20231222-172104
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20231220165423.v2.22.Ieee574a0e94fbaae01fd6883ffe2ceeb98d7df28%40changeid
patch subject: [PATCH v2 22/22] platform/chrome: cros_ec: Use PM subsystem to manage wakeirq
config: i386-allmodconfig (https://download.01.org/0day-ci/archive/20231224/202312240045.wiFeDc1T-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231224/202312240045.wiFeDc1T-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312240045.wiFeDc1T-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/platform/chrome/cros_ec_lpc.c:66:2: error: expected ';' after top level declarator
   }
    ^
    ;
   1 error generated.


vim +66 drivers/platform/chrome/cros_ec_lpc.c

    51	
    52	static const struct dmi_system_id untrusted_fw_irq_wake_capable[] = {
    53		{
    54			.ident = "Brya",
    55			.matches = {
    56				DMI_MATCH(DMI_PRODUCT_FAMILY, "Google_Brya")
    57			}
    58		},
    59		{
    60			.ident = "Brask",
    61			.matches = {
    62				DMI_MATCH(DMI_PRODUCT_FAMILY, "Google_Brask")
    63			}
    64		},
    65		{ }
  > 66	}
    67	MODULE_DEVICE_TABLE(dmi, untrusted_fw_irq_wake_capable);
    68	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

