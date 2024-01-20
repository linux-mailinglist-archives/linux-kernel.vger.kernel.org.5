Return-Path: <linux-kernel+bounces-31708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFE8E8332C8
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 05:53:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7B29B2311E
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 04:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 158881FD2;
	Sat, 20 Jan 2024 04:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IEMnr3ES"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B462D15C5;
	Sat, 20 Jan 2024 04:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705726414; cv=none; b=uwlX3kXAyhHMTWlazC+CRqud32/Oc+P16gw50uy80IMY+a/E+nm+REw4wiYz/6TsuP4YF43RaGpYxxrIjYwR10qRNxKs4m97aOZPTN7LNgunjMRVaoH9o+/+PEJPjrhVdwBfabo3XfgVV4LABI70YAcV5K8beQyYMhQrdYrQ1D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705726414; c=relaxed/simple;
	bh=ORrLc+xjKGUPxA9uxulNGeyU1mju4Nwt8QJoJJN3VpY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=okVPGNpS6Dx70Wttxh0Os76zYlFkyUj0XXvANMYPyCEGPriSSEpAExK0Agsf1WNO115KgZXdEhUBSn7MBNxn6YBgwxmQDYegJ5O/HODckE/fT20Me/MFQQ+Cij9WK4sGDfzUJC3oA2dDv7P34uw45cZ/tv2CIzu7aOuKuU1Ni5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IEMnr3ES; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705726413; x=1737262413;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ORrLc+xjKGUPxA9uxulNGeyU1mju4Nwt8QJoJJN3VpY=;
  b=IEMnr3ESivP9hHPUMXyriSDDjC9RkEGCMi/YwmJxc7P2sFXhPx77t+s5
   TF5+YABcpEMk0Gt3D2n2MCSyK5ObNnd3P8+c6hbWgHa38k5AUHH3W1/q3
   kghxjTaWH2ZpypBlSSScCgEEhrpIOEDelYgSHMqjot6hAwJ9m7OZnJs2c
   FxlIeRgevmigqMIvZCruJ8AIOlo1cvpVDZ6LwMnWqaUX30nZkH9JLdZg0
   d/5L5bpOi6Pp29Po83Ldin/ho0UgzPdycbiXPwpRcLe823At6A0JuScju
   mnNkZFKsTmM0CFnltowyyEH2MDHyeMXEuNWADmcQbYjznX8Hm1iF0S46T
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10957"; a="821001"
X-IronPort-AV: E=Sophos;i="6.05,206,1701158400"; 
   d="scan'208";a="821001"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2024 20:53:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10957"; a="928558440"
X-IronPort-AV: E=Sophos;i="6.05,206,1701158400"; 
   d="scan'208";a="928558440"
Received: from lkp-server01.sh.intel.com (HELO 961aaaa5b03c) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 19 Jan 2024 20:53:27 -0800
Received: from kbuild by 961aaaa5b03c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rR3MC-0004lG-2d;
	Sat, 20 Jan 2024 04:53:24 +0000
Date: Sat, 20 Jan 2024 12:52:39 +0800
From: kernel test robot <lkp@intel.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	gregkh@linuxfoundation.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	heikki.krogerus@linux.intel.com, matthias.bgg@gmail.com,
	dmitry.baryshkov@linaro.org, neil.armstrong@linaro.org,
	andersson@kernel.org, nathan@kernel.org, luca.weiss@fairphone.com,
	tianping.fang@mediatek.com, linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, kernel@collabora.com,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v2 2/2] usb: typec: mux: Add ITE IT5205 Alternate Mode
 Passive MUX driver
Message-ID: <202401201228.eFyUxBzW-lkp@intel.com>
References: <20240119125812.239197-3-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240119125812.239197-3-angelogioacchino.delregno@collabora.com>

Hi AngeloGioacchino,

kernel test robot noticed the following build errors:

[auto build test ERROR on usb/usb-testing]
[also build test ERROR on usb/usb-next usb/usb-linus robh/for-next westeri-thunderbolt/next linus/master v6.7 next-20240119]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/AngeloGioacchino-Del-Regno/dt-bindings-usb-Introduce-ITE-IT5205-Alt-Mode-Passive-MUX/20240119-210119
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
patch link:    https://lore.kernel.org/r/20240119125812.239197-3-angelogioacchino.delregno%40collabora.com
patch subject: [PATCH v2 2/2] usb: typec: mux: Add ITE IT5205 Alternate Mode Passive MUX driver
config: i386-allmodconfig (https://download.01.org/0day-ci/archive/20240120/202401201228.eFyUxBzW-lkp@intel.com/config)
compiler: ClangBuiltLinux clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240120/202401201228.eFyUxBzW-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401201228.eFyUxBzW-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/usb/typec/mux/it5205.c:278:25: error: use of undeclared identifier 'it5205_match_table'; did you mean 'it5205_of_table'?
     278 | MODULE_DEVICE_TABLE(of, it5205_match_table);
         |                         ^~~~~~~~~~~~~~~~~~
         |                         it5205_of_table
   include/linux/module.h:244:15: note: expanded from macro 'MODULE_DEVICE_TABLE'
     244 | extern typeof(name) __mod_##type##__##name##_device_table               \
         |               ^
   drivers/usb/typec/mux/it5205.c:274:34: note: 'it5205_of_table' declared here
     274 | static const struct of_device_id it5205_of_table[] = {
         |                                  ^
   1 error generated.


vim +278 drivers/usb/typec/mux/it5205.c

   273	
   274	static const struct of_device_id it5205_of_table[] = {
   275		{ .compatible = "ite,it5205" },
   276		{ /* sentinel */ }
   277	};
 > 278	MODULE_DEVICE_TABLE(of, it5205_match_table);
   279	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

