Return-Path: <linux-kernel+bounces-109530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39269881A90
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 02:10:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 568471C20EFA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 01:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00A991C2E;
	Thu, 21 Mar 2024 01:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ICyHrNbx"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E04F811;
	Thu, 21 Mar 2024 01:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710983436; cv=none; b=ldT1hVsjhlPtOj0p+3Q8mxUC02dGT++acGE6sEvtW7Ub8X0P1eP/AeM5uj85jYvDtzc3B1TwmWpcBky0ILTkp8VDfSXSvVWAd8inWQstIGQFz6w+STYWCQkhnxcxR2McVCgFzhpWfh6SROmeQoua2i5ZJS3wOBZL2S6ta3kuFos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710983436; c=relaxed/simple;
	bh=2w1fH3LDsNuaN6Ld0HB4fkphXyRR53FgPKy5ZeIFQA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tr5lfLMX+KrNraCVx7JU7juIXztjwn1LbUJAoRZ+iyTS9Uqoz/acRhuCA58JaK0ZnPMzZ8RMKU4noFudbmVfKtd9EdGQSVAIrt9rhC1Xk98PVIoPoYKdSTw0xz4I6w0E3mdm1W5+bX2x1IoePL46Mpr/jPvebqdK/RwHE197aXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ICyHrNbx; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710983434; x=1742519434;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2w1fH3LDsNuaN6Ld0HB4fkphXyRR53FgPKy5ZeIFQA0=;
  b=ICyHrNbxbfw3QY5Wkzxk0NZysf5ZVisxDfEkoqmoDS8waLkXGQ8SdqO5
   dx/iodemB4UuZa250MzrW8DrzayPvTLO1IGXWzFy25HzTN9UqJkXfCBFz
   3e+kyGW137JYCd4XLqERAUeP+LHvt7AC4nUMUmSOsKkrhj9vQqKVfvI5G
   tA49EykvJc/jUp8mvJXGNwM0me2JP3J1oNDvG8IqmFoocq9QYGw0sb9Kl
   bJ8JVeYWS10yUZKsQxoth1kmkh0X0bZot7UAF3VXTj/oSDsBdxt/wE4FO
   P/MLZcmw5BuQlr8lMOtmqDWE2Nk5eDa+jsk1pEFYFF7xqm3l6GMCNdSYF
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11019"; a="5833802"
X-IronPort-AV: E=Sophos;i="6.07,141,1708416000"; 
   d="scan'208";a="5833802"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2024 18:10:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,141,1708416000"; 
   d="scan'208";a="45436962"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 20 Mar 2024 18:10:29 -0700
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rn6ws-000J3X-34;
	Thu, 21 Mar 2024 01:10:26 +0000
Date: Thu, 21 Mar 2024 09:10:23 +0800
From: kernel test robot <lkp@intel.com>
To: Sudan Landge <sudanl@amazon.com>, tytso@mit.edu, Jason@zx2c4.com,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, sathyanarayanan.kuppuswamy@linux.intel.com,
	thomas.lendacky@amd.com, dan.j.williams@intel.com,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, graf@amazon.de, dwmw@amazon.co.uk,
	bchalios@amazon.es, xmarcalx@amazon.co.uk
Subject: Re: [PATCH v1 4/4] virt: vmgenid: add support for devicetree bindings
Message-ID: <202403210806.pMEGAp0x-lkp@intel.com>
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

kernel test robot noticed the following build errors:

[auto build test ERROR on robh/for-next]
[also build test ERROR on linus/master v6.8 next-20240320]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Sudan-Landge/virt-vmgenid-rearrange-code-to-make-review-easier/20240319-223642
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20240319143253.22317-5-sudanl%40amazon.com
patch subject: [PATCH v1 4/4] virt: vmgenid: add support for devicetree bindings
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20240321/202403210806.pMEGAp0x-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240321/202403210806.pMEGAp0x-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403210806.pMEGAp0x-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/virt/vmgenid.c: In function 'vmgenid_add_acpi':
>> drivers/virt/vmgenid.c:79:45: error: invalid use of undefined type 'struct acpi_device'
      79 |         status = acpi_evaluate_object(device->handle, "ADDR", NULL, &parsed);
         |                                             ^~
   drivers/virt/vmgenid.c:96:56: error: invalid use of undefined type 'struct acpi_device'
      96 |                                   devm_memremap(&device->dev, phys_addr, VMGENID_SIZE, MEMREMAP_WB)
         |                                                        ^~
   drivers/virt/vmgenid.c:102:52: error: invalid use of undefined type 'struct acpi_device'
     102 |         status = acpi_install_notify_handler(device->handle, ACPI_DEVICE_NOTIFY,
         |                                                    ^~
   drivers/virt/vmgenid.c: At top level:
   drivers/virt/vmgenid.c:196:36: warning: 'vmgenid_acpi_ids' defined but not used [-Wunused-const-variable=]
     196 | static const struct acpi_device_id vmgenid_acpi_ids[] = {
         |                                    ^~~~~~~~~~~~~~~~


vim +79 drivers/virt/vmgenid.c

657fab4d1001e1 Sudan Landge       2024-03-19   69  
657fab4d1001e1 Sudan Landge       2024-03-19   70  static int vmgenid_add_acpi(struct device *dev, struct vmgenid_state *state)
657fab4d1001e1 Sudan Landge       2024-03-19   71  {
657fab4d1001e1 Sudan Landge       2024-03-19   72  	struct acpi_device *device = ACPI_COMPANION(dev);
af6b54e2b5baa5 Jason A. Donenfeld 2022-02-23   73  	struct acpi_buffer parsed = { ACPI_ALLOCATE_BUFFER };
af6b54e2b5baa5 Jason A. Donenfeld 2022-02-23   74  	union acpi_object *obj;
af6b54e2b5baa5 Jason A. Donenfeld 2022-02-23   75  	phys_addr_t phys_addr;
af6b54e2b5baa5 Jason A. Donenfeld 2022-02-23   76  	acpi_status status;
af6b54e2b5baa5 Jason A. Donenfeld 2022-02-23   77  	int ret = 0;
af6b54e2b5baa5 Jason A. Donenfeld 2022-02-23   78  
af6b54e2b5baa5 Jason A. Donenfeld 2022-02-23  @79  	status = acpi_evaluate_object(device->handle, "ADDR", NULL, &parsed);
af6b54e2b5baa5 Jason A. Donenfeld 2022-02-23   80  	if (ACPI_FAILURE(status)) {
af6b54e2b5baa5 Jason A. Donenfeld 2022-02-23   81  		ACPI_EXCEPTION((AE_INFO, status, "Evaluating ADDR"));
af6b54e2b5baa5 Jason A. Donenfeld 2022-02-23   82  		return -ENODEV;
af6b54e2b5baa5 Jason A. Donenfeld 2022-02-23   83  	}
af6b54e2b5baa5 Jason A. Donenfeld 2022-02-23   84  	obj = parsed.pointer;
af6b54e2b5baa5 Jason A. Donenfeld 2022-02-23   85  	if (!obj || obj->type != ACPI_TYPE_PACKAGE || obj->package.count != 2 ||
af6b54e2b5baa5 Jason A. Donenfeld 2022-02-23   86  	    obj->package.elements[0].type != ACPI_TYPE_INTEGER ||
af6b54e2b5baa5 Jason A. Donenfeld 2022-02-23   87  	    obj->package.elements[1].type != ACPI_TYPE_INTEGER) {
af6b54e2b5baa5 Jason A. Donenfeld 2022-02-23   88  		ret = -EINVAL;
af6b54e2b5baa5 Jason A. Donenfeld 2022-02-23   89  		goto out;
af6b54e2b5baa5 Jason A. Donenfeld 2022-02-23   90  	}
af6b54e2b5baa5 Jason A. Donenfeld 2022-02-23   91  
af6b54e2b5baa5 Jason A. Donenfeld 2022-02-23   92  	phys_addr = (obj->package.elements[0].integer.value << 0) |
af6b54e2b5baa5 Jason A. Donenfeld 2022-02-23   93  		    (obj->package.elements[1].integer.value << 32);
657fab4d1001e1 Sudan Landge       2024-03-19   94  
657fab4d1001e1 Sudan Landge       2024-03-19   95  	ret = setup_vmgenid_state(state,
657fab4d1001e1 Sudan Landge       2024-03-19   96  				  devm_memremap(&device->dev, phys_addr, VMGENID_SIZE, MEMREMAP_WB)
657fab4d1001e1 Sudan Landge       2024-03-19   97  				 );
657fab4d1001e1 Sudan Landge       2024-03-19   98  	if (ret)
657fab4d1001e1 Sudan Landge       2024-03-19   99  		goto out;
657fab4d1001e1 Sudan Landge       2024-03-19  100  
657fab4d1001e1 Sudan Landge       2024-03-19  101  	dev->driver_data = state;
657fab4d1001e1 Sudan Landge       2024-03-19  102  	status = acpi_install_notify_handler(device->handle, ACPI_DEVICE_NOTIFY,
657fab4d1001e1 Sudan Landge       2024-03-19  103  					     vmgenid_acpi_handler, dev);
657fab4d1001e1 Sudan Landge       2024-03-19  104  	if (ACPI_FAILURE(status)) {
657fab4d1001e1 Sudan Landge       2024-03-19  105  		dev_err(dev, "Failed to install acpi notify handler");
657fab4d1001e1 Sudan Landge       2024-03-19  106  		ret = -ENODEV;
657fab4d1001e1 Sudan Landge       2024-03-19  107  		dev->driver_data = NULL;
af6b54e2b5baa5 Jason A. Donenfeld 2022-02-23  108  		goto out;
af6b54e2b5baa5 Jason A. Donenfeld 2022-02-23  109  	}
657fab4d1001e1 Sudan Landge       2024-03-19  110  out:
657fab4d1001e1 Sudan Landge       2024-03-19  111  	ACPI_FREE(parsed.pointer);
657fab4d1001e1 Sudan Landge       2024-03-19  112  	return ret;
657fab4d1001e1 Sudan Landge       2024-03-19  113  }
af6b54e2b5baa5 Jason A. Donenfeld 2022-02-23  114  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

