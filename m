Return-Path: <linux-kernel+bounces-108602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD78F880CD9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 09:15:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 208DBB21A95
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 08:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDA7636AE7;
	Wed, 20 Mar 2024 08:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fA/gZ4CF"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468692C85A;
	Wed, 20 Mar 2024 08:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710922509; cv=none; b=ruOkyMli7jP00mlMzHaTmiWwNmwdxuZeU0vRHO8jdfHIJYVULQzT8jLqrotSYcyWlIEzyNO/QUybIIdR5nYT3vcIpIcr1f74Z374hyvJmiUzs0QGhZmYYyiMiTTglUt+MOn2Yin8JmhD3FBYnkp5GoF8AO3qMSj9TcSWnzlZea0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710922509; c=relaxed/simple;
	bh=yqwN/XmqlhuyVKlnSnySwDvCVYusk7LG+Wgh1XYe0jc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mEaF3IiX921eiV5PRNsi7fiOWid69NxyWVGn7D3+3KEnxhfwo0CpXx6gc7P0+rNJq+ucD5uxb5ndzw6/1j16gDQ4WhPYOgPvqlIomzCfy1OLfs3Wmfpd42Xq+E5AEwDE4DF3rYYcQBPhId6iUBzPAnvm3RSCRZyNCWyrrztd/po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fA/gZ4CF; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710922507; x=1742458507;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yqwN/XmqlhuyVKlnSnySwDvCVYusk7LG+Wgh1XYe0jc=;
  b=fA/gZ4CFmA2T2AvQ6WZ4PbATl6Y5Jw1JJGg9A+EB7I9KkU9bsa/plml3
   3pwFJR1Ht5CVrXituM4BsX1pttFDDIyuKPUZaxgUysT9LXPVQ4KzTAx9E
   JNCfODH1y5JpMrqj2mwH0OAnSDiqEIlF40F3nQeWB8mxSMSLRSgJcCydB
   EaFSomJ96R1Jbb4cf3jZPn8HjRXI60vroswj1KpPniqKua3Kg3XPVHR37
   Z824Xv81kKs/0ctkLZbbDRFGGu1UF5MNAuVGxWGkyavwmp5YvucTS7OWO
   ZxpmtH0/GX5o8DzrqK4cY5qtrPRb11G7JEVwAzNB31Y3RTymyYRbHfDcf
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11018"; a="6009856"
X-IronPort-AV: E=Sophos;i="6.07,139,1708416000"; 
   d="scan'208";a="6009856"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2024 01:15:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,139,1708416000"; 
   d="scan'208";a="13972937"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 20 Mar 2024 01:15:03 -0700
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rmr6C-000IT2-1o;
	Wed, 20 Mar 2024 08:15:00 +0000
Date: Wed, 20 Mar 2024 16:14:24 +0800
From: kernel test robot <lkp@intel.com>
To: Sudan Landge <sudanl@amazon.com>, tytso@mit.edu, Jason@zx2c4.com,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, sathyanarayanan.kuppuswamy@linux.intel.com,
	thomas.lendacky@amd.com, dan.j.williams@intel.com,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, graf@amazon.de, dwmw@amazon.co.uk,
	bchalios@amazon.es, xmarcalx@amazon.co.uk
Subject: Re: [PATCH v1 4/4] virt: vmgenid: add support for devicetree bindings
Message-ID: <202403201544.8xvAuo13-lkp@intel.com>
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
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Sudan-Landge/virt-vmgenid-rearrange-code-to-make-review-easier/20240319-223642
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20240319143253.22317-5-sudanl%40amazon.com
patch subject: [PATCH v1 4/4] virt: vmgenid: add support for devicetree bindings
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20240320/202403201544.8xvAuo13-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240320/202403201544.8xvAuo13-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403201544.8xvAuo13-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/virt/vmgenid.c: In function 'vmgenid_add_acpi':
   drivers/virt/vmgenid.c:79:45: error: invalid use of undefined type 'struct acpi_device'
      79 |         status = acpi_evaluate_object(device->handle, "ADDR", NULL, &parsed);
         |                                             ^~
   drivers/virt/vmgenid.c:96:56: error: invalid use of undefined type 'struct acpi_device'
      96 |                                   devm_memremap(&device->dev, phys_addr, VMGENID_SIZE, MEMREMAP_WB)
         |                                                        ^~
   drivers/virt/vmgenid.c:102:52: error: invalid use of undefined type 'struct acpi_device'
     102 |         status = acpi_install_notify_handler(device->handle, ACPI_DEVICE_NOTIFY,
         |                                                    ^~
   drivers/virt/vmgenid.c: At top level:
>> drivers/virt/vmgenid.c:196:36: warning: 'vmgenid_acpi_ids' defined but not used [-Wunused-const-variable=]
     196 | static const struct acpi_device_id vmgenid_acpi_ids[] = {
         |                                    ^~~~~~~~~~~~~~~~


vim +/vmgenid_acpi_ids +196 drivers/virt/vmgenid.c

   195	
 > 196	static const struct acpi_device_id vmgenid_acpi_ids[] = {
   197		{ "VMGENCTR", 0 },
   198		{ "VM_GEN_COUNTER", 0 },
   199		{ }
   200	};
   201	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

