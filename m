Return-Path: <linux-kernel+bounces-109192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D326E8815F1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 17:54:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AC831F228CB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 16:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F44A69DFA;
	Wed, 20 Mar 2024 16:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oApQYWZ5"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CBFC28F0;
	Wed, 20 Mar 2024 16:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710953666; cv=none; b=HwJPrgPFHVo+v6gcNkmsWlIMd4zi265fkyCIiNOmP/7aW3q76NaBrqXEc+MCQ5osFKwdtyc5AQJXmJ+ECzecOwsHEmHBlyG9QXeDBePhIg3+rT34cDbrF+9/y6cpdT3ndv+zmB2ckXj7iPJPfdmwL78g6yOSKqpSa7zNneA0CVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710953666; c=relaxed/simple;
	bh=Iubavo7BjR+bf7HBoYLQ/BAa3lZgJugLDuOQ6vnMMGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tzldSgzrqws0KEoOylwYBOSdhxc5AdhC7FaXXHk64KFGewhqDublrZqFoGXKBAOAgijsOjMuuPWzQl389DktcoMuB/hDDkGdifdpeTBf+16ncmWdcgHs/mk/kMgNkcTe5mzr0WPfUqmX/Bzw0b+yl552vV33F1ryocILvE0RAF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oApQYWZ5; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710953664; x=1742489664;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Iubavo7BjR+bf7HBoYLQ/BAa3lZgJugLDuOQ6vnMMGw=;
  b=oApQYWZ5fcbqjDLKy7Kbp67lxOd1WXkw/vyoGaiaDIlrg+shTfBVDcRI
   Ce/cjTTWihvpmhlFpBwXIEkGRkwbnxSfFWBLd7j1vEl98rAfoO4C2hsDC
   Oz3fR961IA3Xgs+i4ADRfP5pPoAp1uzGqfeot9r0yo55Fj05sOFmy0JEE
   +EjaDCHNRuz4PUsVc2UbMxeNjVbtvVCpPdaYnyG3DjA0Znr2FJcwJKI30
   SQQEcc0CWsHb4UXqpxv899leI9a+Yva3tB9/BZLWnOAIohiGstQleEL2I
   U+BCQef73rM3LSJ0kL8YIK1qEvxZiqySukmw99KFdHMD2plEmJMVdypq9
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11019"; a="17032573"
X-IronPort-AV: E=Sophos;i="6.07,140,1708416000"; 
   d="scan'208";a="17032573"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2024 09:54:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,140,1708416000"; 
   d="scan'208";a="18859636"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 20 Mar 2024 09:54:18 -0700
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rmzCh-000InH-2n;
	Wed, 20 Mar 2024 16:54:15 +0000
Date: Thu, 21 Mar 2024 00:54:01 +0800
From: kernel test robot <lkp@intel.com>
To: Sudan Landge <sudanl@amazon.com>, tytso@mit.edu, Jason@zx2c4.com,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, sathyanarayanan.kuppuswamy@linux.intel.com,
	thomas.lendacky@amd.com, dan.j.williams@intel.com,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, graf@amazon.de,
	dwmw@amazon.co.uk, bchalios@amazon.es, xmarcalx@amazon.co.uk
Subject: Re: [PATCH v1 4/4] virt: vmgenid: add support for devicetree bindings
Message-ID: <202403210035.LODSw2s6-lkp@intel.com>
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
config: hexagon-allmodconfig (https://download.01.org/0day-ci/archive/20240321/202403210035.LODSw2s6-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project 8f68022f8e6e54d1aeae4ed301f5a015963089b7)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240321/202403210035.LODSw2s6-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403210035.LODSw2s6-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/virt/vmgenid.c:16:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:547:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     547 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:560:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     560 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
         |                                                   ^
   In file included from drivers/virt/vmgenid.c:16:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     573 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
         |                                                   ^
   In file included from drivers/virt/vmgenid.c:16:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:584:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     584 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:594:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     594 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:604:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     604 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
>> drivers/virt/vmgenid.c:79:38: error: incomplete definition of type 'struct acpi_device'
      79 |         status = acpi_evaluate_object(device->handle, "ADDR", NULL, &parsed);
         |                                       ~~~~~~^
   include/linux/acpi.h:795:8: note: forward declaration of 'struct acpi_device'
     795 | struct acpi_device;
         |        ^
   drivers/virt/vmgenid.c:96:28: error: incomplete definition of type 'struct acpi_device'
      96 |                                   devm_memremap(&device->dev, phys_addr, VMGENID_SIZE, MEMREMAP_WB)
         |                                                  ~~~~~~^
   include/linux/acpi.h:795:8: note: forward declaration of 'struct acpi_device'
     795 | struct acpi_device;
         |        ^
   drivers/virt/vmgenid.c:102:45: error: incomplete definition of type 'struct acpi_device'
     102 |         status = acpi_install_notify_handler(device->handle, ACPI_DEVICE_NOTIFY,
         |                                              ~~~~~~^
   include/linux/acpi.h:795:8: note: forward declaration of 'struct acpi_device'
     795 | struct acpi_device;
         |        ^
   6 warnings and 3 errors generated.


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

