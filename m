Return-Path: <linux-kernel+bounces-108951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C3BD881267
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 14:36:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8E37B22D3E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 13:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8AB441C86;
	Wed, 20 Mar 2024 13:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RDsB6ZPV"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18273FB3E;
	Wed, 20 Mar 2024 13:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710941778; cv=none; b=OOanQN9MXSTL/ghVjlLJffZJbXBCkR0/coblZBeqPfNYZJhM1erLt0E77fL/eoZlVnNEH6eruQeGJZVkKBm4u+YTmaCY01d6Bfz1jv/Qn8j5rqLKL4ju1bjAfNJ8O4eZWJ5MC3Xk9fnhG1mktg8dIfZmHRfX36wq4Kpz20AvhFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710941778; c=relaxed/simple;
	bh=op7s3VIhu6ib3PNmj5YG5b+N/TeJP1zP0hWcTZI3rwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HOD3XXOVN7Y+ElOscbWIaACRVfTFZRLq/QbVCp9zeFqNZvucpWnsDI8ohHxW1RsvuducydWx7VQ4nS22GrE0jM/OUuq9JQYqBCBVfw/nHi7zmlS44dB7S/Cno0i2XYp2UD0J1dDuUpD9qRSAbKbDd73U8tJTKcxGe9ccLDDqYME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RDsB6ZPV; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710941775; x=1742477775;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=op7s3VIhu6ib3PNmj5YG5b+N/TeJP1zP0hWcTZI3rwA=;
  b=RDsB6ZPVrVpxNStV1Wam/SrJdZlCOCV7oT3U0C7qnar9A0ttdwCUmsgI
   BZpgQcq5PS4SEP0d3rHAmUgvHLjd1sUNlBvGJ6p4ruqs4gK42RbQPhf/Q
   VKBX0zjbgVQURznhc49zby4AVaYf+dm9UVTIaGNcfm410y9jVCQG8Z2Pz
   ofCv4q/HkhiuXCqUhvLZUKHikwIlpzNfodJ5ZR6kKXSwuikNuXYXpiyRq
   yaXvzFrFZIWC7uHapz8aMvKOH5HvzILBaNz0+hCV1OGWj0iB+mp6h+Yib
   BGwoEF2habDhEcM4F14AVO6JAwWhOs24HLN7eS9KVLHu6SCnURmAKK6kx
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11018"; a="17007644"
X-IronPort-AV: E=Sophos;i="6.07,140,1708416000"; 
   d="scan'208";a="17007644"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2024 06:36:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,140,1708416000"; 
   d="scan'208";a="14235955"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 20 Mar 2024 06:36:11 -0700
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rmw6y-000IeJ-2m;
	Wed, 20 Mar 2024 13:36:08 +0000
Date: Wed, 20 Mar 2024 21:35:28 +0800
From: kernel test robot <lkp@intel.com>
To: Sudan Landge <sudanl@amazon.com>, tytso@mit.edu, Jason@zx2c4.com,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, sathyanarayanan.kuppuswamy@linux.intel.com,
	thomas.lendacky@amd.com, dan.j.williams@intel.com,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, graf@amazon.de, dwmw@amazon.co.uk,
	bchalios@amazon.es, xmarcalx@amazon.co.uk
Subject: Re: [PATCH v1 4/4] virt: vmgenid: add support for devicetree bindings
Message-ID: <202403202139.GabdWRiZ-lkp@intel.com>
References: <20240319143253.22317-5-sudanl@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240319143253.22317-5-sudanl@amazon.com>

Hi Sudan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on robh/for-next]
[also build test WARNING on linus/master v6.8 next-20240320]
[cannot apply to crng-random/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Sudan-Landge/virt-vmgenid-rearrange-code-to-make-review-easier/20240319-223642
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20240319143253.22317-5-sudanl%40amazon.com
patch subject: [PATCH v1 4/4] virt: vmgenid: add support for devicetree bindings
config: x86_64-randconfig-121-20240320 (https://download.01.org/0day-ci/archive/20240320/202403202139.GabdWRiZ-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240320/202403202139.GabdWRiZ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403202139.GabdWRiZ-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/virt/vmgenid.c:133:50: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected unsigned char [usertype] *next_id @@     got void [noderef] __iomem * @@
   drivers/virt/vmgenid.c:133:50: sparse:     expected unsigned char [usertype] *next_id
   drivers/virt/vmgenid.c:133:50: sparse:     got void [noderef] __iomem *

vim +133 drivers/virt/vmgenid.c

   114	
   115	static int vmgenid_add_of(struct device *dev, struct vmgenid_state *state)
   116	{
   117		struct resource res;
   118		int ret = 0;
   119	
   120		if (of_address_to_resource(dev->of_node, 0, &res)) {
   121			dev_err(dev, "Failed to get resources from device tree");
   122			ret = -EINVAL;
   123			goto out;
   124		}
   125	
   126		if (!__request_mem_region(res.start, resource_size(&res),
   127					  "vmgenid", IORESOURCE_EXCLUSIVE)) {
   128			dev_err(dev, "Failed to request mem region");
   129			ret = -EINVAL;
   130			goto out;
   131		}
   132	
 > 133		ret = setup_vmgenid_state(state, of_iomap(dev->of_node, 0));
   134		if (ret)
   135			goto out;
   136	
   137		state->irq = irq_of_parse_and_map(dev->of_node, 0);
   138		dev->driver_data = state;
   139	
   140		if (request_irq(state->irq, vmgenid_of_irq_handler,
   141				IRQF_SHARED, "vmgenid", dev) < 0) {
   142			dev_err(dev, "request_irq failed");
   143			dev->driver_data = NULL;
   144			ret = -EINVAL;
   145			goto out;
   146		}
   147	
   148	out:
   149		return ret;
   150	}
   151	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

