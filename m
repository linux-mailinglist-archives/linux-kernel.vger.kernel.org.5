Return-Path: <linux-kernel+bounces-13271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB90B82024E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 23:57:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 142F61C2100C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 22:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 457A014ABB;
	Fri, 29 Dec 2023 22:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ELeoTIlu"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5DD14A94;
	Fri, 29 Dec 2023 22:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703890611; x=1735426611;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mojBHSgrIglBXbXQ1cQyn4otPV1q7r7AoBuASrqkrb4=;
  b=ELeoTIluui0e8N8kxFz92fI76CK2FzMDtec7SkIW404CZzAj+p6df2YK
   kySWliViesVGJnqDMPo8OYEhUS5Av5tANhcPGx5XmNyYbN8QiIZS7Zizi
   JSnb2avfQk1+anKchAs7YVdqZ4jC21LpHhcbt9/S7aIskr92N0/sbzE7P
   nff50JJTAZ47rBQ4akH01oeUgIPEkOmn0uAhStQRHT5hizIYutx4D7ox/
   LRO9qi3kNKHly8yHqN/sRIgYBIGFcw3Qca+KA4k4sD9uiNFGbnKYI0maP
   5hbyvFqF9A/Vn4O+TqS/SVexKQgxwYpYZ56OE2zEurUetw8tQzr0naZ4b
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10938"; a="3517938"
X-IronPort-AV: E=Sophos;i="6.04,316,1695711600"; 
   d="scan'208";a="3517938"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2023 14:56:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10938"; a="922445287"
X-IronPort-AV: E=Sophos;i="6.04,316,1695711600"; 
   d="scan'208";a="922445287"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 29 Dec 2023 14:56:48 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rJLmX-000HsX-2p;
	Fri, 29 Dec 2023 22:56:45 +0000
Date: Sat, 30 Dec 2023 06:56:40 +0800
From: kernel test robot <lkp@intel.com>
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>,
	linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, adamg@pobox.com, stable@vger.kernel.org,
	Jiri Slaby <jirislaby@kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Tobias Gruetzmacher <tobias-lists@23.gs>
Subject: Re: [PATCH] firewire: ohci: suppress unexpected system reboot in AMD
 Ryzen machines and ASM108x/VT630x PCIe cards
Message-ID: <202312300612.hrtBWbnp-lkp@intel.com>
References: <20231229035735.11127-1-o-takashi@sakamocchi.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231229035735.11127-1-o-takashi@sakamocchi.jp>

Hi Takashi,

kernel test robot noticed the following build errors:

[auto build test ERROR on ieee1394-linux1394/for-next]
[also build test ERROR on ieee1394-linux1394/for-linus linus/master v6.7-rc7 next-20231222]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Takashi-Sakamoto/firewire-ohci-suppress-unexpected-system-reboot-in-AMD-Ryzen-machines-and-ASM108x-VT630x-PCIe-cards/20231229-120311
base:   https://git.kernel.org/pub/scm/linux/kernel/git/ieee1394/linux1394.git for-next
patch link:    https://lore.kernel.org/r/20231229035735.11127-1-o-takashi%40sakamocchi.jp
patch subject: [PATCH] firewire: ohci: suppress unexpected system reboot in AMD Ryzen machines and ASM108x/VT630x PCIe cards
config: loongarch-randconfig-r081-20231229 (https://download.01.org/0day-ci/archive/20231230/202312300612.hrtBWbnp-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231230/202312300612.hrtBWbnp-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312300612.hrtBWbnp-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/firewire/ohci.c: In function 'pci_probe':
>> drivers/firewire/ohci.c:3679:70: error: macro "detect_vt630x_with_asm1083_on_amd_ryzen_machine" passed 2 arguments, but takes just 1
    3679 |         if (detect_vt630x_with_asm1083_on_amd_ryzen_machine(dev, ohci))
         |                                                                      ^
   drivers/firewire/ohci.c:3573: note: macro "detect_vt630x_with_asm1083_on_amd_ryzen_machine" defined here
    3573 | #define detect_vt630x_with_asm1083_on_amd_ryzen_machine(pdev)   false
         | 
>> drivers/firewire/ohci.c:3679:13: error: 'detect_vt630x_with_asm1083_on_amd_ryzen_machine' undeclared (first use in this function)
    3679 |         if (detect_vt630x_with_asm1083_on_amd_ryzen_machine(dev, ohci))
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/firewire/ohci.c:3679:13: note: each undeclared identifier is reported only once for each function it appears in


vim +/detect_vt630x_with_asm1083_on_amd_ryzen_machine +3679 drivers/firewire/ohci.c

  3617	
  3618	static int pci_probe(struct pci_dev *dev,
  3619				       const struct pci_device_id *ent)
  3620	{
  3621		struct fw_ohci *ohci;
  3622		u32 bus_options, max_receive, link_speed, version;
  3623		u64 guid;
  3624		int i, err;
  3625		size_t size;
  3626	
  3627		if (dev->vendor == PCI_VENDOR_ID_PINNACLE_SYSTEMS) {
  3628			dev_err(&dev->dev, "Pinnacle MovieBoard is not yet supported\n");
  3629			return -ENOSYS;
  3630		}
  3631	
  3632		ohci = devres_alloc(release_ohci, sizeof(*ohci), GFP_KERNEL);
  3633		if (ohci == NULL)
  3634			return -ENOMEM;
  3635		fw_card_initialize(&ohci->card, &ohci_driver, &dev->dev);
  3636		pci_set_drvdata(dev, ohci);
  3637		pmac_ohci_on(dev);
  3638		devres_add(&dev->dev, ohci);
  3639	
  3640		err = pcim_enable_device(dev);
  3641		if (err) {
  3642			dev_err(&dev->dev, "failed to enable OHCI hardware\n");
  3643			return err;
  3644		}
  3645	
  3646		pci_set_master(dev);
  3647		pci_write_config_dword(dev, OHCI1394_PCI_HCI_Control, 0);
  3648	
  3649		spin_lock_init(&ohci->lock);
  3650		mutex_init(&ohci->phy_reg_mutex);
  3651	
  3652		INIT_WORK(&ohci->bus_reset_work, bus_reset_work);
  3653	
  3654		if (!(pci_resource_flags(dev, 0) & IORESOURCE_MEM) ||
  3655		    pci_resource_len(dev, 0) < OHCI1394_REGISTER_SIZE) {
  3656			ohci_err(ohci, "invalid MMIO resource\n");
  3657			return -ENXIO;
  3658		}
  3659	
  3660		err = pcim_iomap_regions(dev, 1 << 0, ohci_driver_name);
  3661		if (err) {
  3662			ohci_err(ohci, "request and map MMIO resource unavailable\n");
  3663			return -ENXIO;
  3664		}
  3665		ohci->registers = pcim_iomap_table(dev)[0];
  3666	
  3667		for (i = 0; i < ARRAY_SIZE(ohci_quirks); i++)
  3668			if ((ohci_quirks[i].vendor == dev->vendor) &&
  3669			    (ohci_quirks[i].device == (unsigned short)PCI_ANY_ID ||
  3670			     ohci_quirks[i].device == dev->device) &&
  3671			    (ohci_quirks[i].revision == (unsigned short)PCI_ANY_ID ||
  3672			     ohci_quirks[i].revision >= dev->revision)) {
  3673				ohci->quirks = ohci_quirks[i].flags;
  3674				break;
  3675			}
  3676		if (param_quirks)
  3677			ohci->quirks = param_quirks;
  3678	
> 3679		if (detect_vt630x_with_asm1083_on_amd_ryzen_machine(dev, ohci))
  3680			ohci->quirks |= QUIRK_REBOOT_BY_CYCLE_TIMER_READ;
  3681	
  3682		/*
  3683		 * Because dma_alloc_coherent() allocates at least one page,
  3684		 * we save space by using a common buffer for the AR request/
  3685		 * response descriptors and the self IDs buffer.
  3686		 */
  3687		BUILD_BUG_ON(AR_BUFFERS * sizeof(struct descriptor) > PAGE_SIZE/4);
  3688		BUILD_BUG_ON(SELF_ID_BUF_SIZE > PAGE_SIZE/2);
  3689		ohci->misc_buffer = dmam_alloc_coherent(&dev->dev, PAGE_SIZE, &ohci->misc_buffer_bus,
  3690							GFP_KERNEL);
  3691		if (!ohci->misc_buffer)
  3692			return -ENOMEM;
  3693	
  3694		err = ar_context_init(&ohci->ar_request_ctx, ohci, 0,
  3695				      OHCI1394_AsReqRcvContextControlSet);
  3696		if (err < 0)
  3697			return err;
  3698	
  3699		err = ar_context_init(&ohci->ar_response_ctx, ohci, PAGE_SIZE/4,
  3700				      OHCI1394_AsRspRcvContextControlSet);
  3701		if (err < 0)
  3702			return err;
  3703	
  3704		err = context_init(&ohci->at_request_ctx, ohci,
  3705				   OHCI1394_AsReqTrContextControlSet, handle_at_packet);
  3706		if (err < 0)
  3707			return err;
  3708	
  3709		err = context_init(&ohci->at_response_ctx, ohci,
  3710				   OHCI1394_AsRspTrContextControlSet, handle_at_packet);
  3711		if (err < 0)
  3712			return err;
  3713	
  3714		reg_write(ohci, OHCI1394_IsoRecvIntMaskSet, ~0);
  3715		ohci->ir_context_channels = ~0ULL;
  3716		ohci->ir_context_support = reg_read(ohci, OHCI1394_IsoRecvIntMaskSet);
  3717		reg_write(ohci, OHCI1394_IsoRecvIntMaskClear, ~0);
  3718		ohci->ir_context_mask = ohci->ir_context_support;
  3719		ohci->n_ir = hweight32(ohci->ir_context_mask);
  3720		size = sizeof(struct iso_context) * ohci->n_ir;
  3721		ohci->ir_context_list = devm_kzalloc(&dev->dev, size, GFP_KERNEL);
  3722		if (!ohci->ir_context_list)
  3723			return -ENOMEM;
  3724	
  3725		reg_write(ohci, OHCI1394_IsoXmitIntMaskSet, ~0);
  3726		ohci->it_context_support = reg_read(ohci, OHCI1394_IsoXmitIntMaskSet);
  3727		/* JMicron JMB38x often shows 0 at first read, just ignore it */
  3728		if (!ohci->it_context_support) {
  3729			ohci_notice(ohci, "overriding IsoXmitIntMask\n");
  3730			ohci->it_context_support = 0xf;
  3731		}
  3732		reg_write(ohci, OHCI1394_IsoXmitIntMaskClear, ~0);
  3733		ohci->it_context_mask = ohci->it_context_support;
  3734		ohci->n_it = hweight32(ohci->it_context_mask);
  3735		size = sizeof(struct iso_context) * ohci->n_it;
  3736		ohci->it_context_list = devm_kzalloc(&dev->dev, size, GFP_KERNEL);
  3737		if (!ohci->it_context_list)
  3738			return -ENOMEM;
  3739	
  3740		ohci->self_id     = ohci->misc_buffer     + PAGE_SIZE/2;
  3741		ohci->self_id_bus = ohci->misc_buffer_bus + PAGE_SIZE/2;
  3742	
  3743		bus_options = reg_read(ohci, OHCI1394_BusOptions);
  3744		max_receive = (bus_options >> 12) & 0xf;
  3745		link_speed = bus_options & 0x7;
  3746		guid = ((u64) reg_read(ohci, OHCI1394_GUIDHi) << 32) |
  3747			reg_read(ohci, OHCI1394_GUIDLo);
  3748	
  3749		if (!(ohci->quirks & QUIRK_NO_MSI))
  3750			pci_enable_msi(dev);
  3751		err = devm_request_irq(&dev->dev, dev->irq, irq_handler,
  3752				       pci_dev_msi_enabled(dev) ? 0 : IRQF_SHARED, ohci_driver_name, ohci);
  3753		if (err < 0) {
  3754			ohci_err(ohci, "failed to allocate interrupt %d\n", dev->irq);
  3755			goto fail_msi;
  3756		}
  3757	
  3758		err = fw_card_add(&ohci->card, max_receive, link_speed, guid);
  3759		if (err)
  3760			goto fail_msi;
  3761	
  3762		version = reg_read(ohci, OHCI1394_Version) & 0x00ff00ff;
  3763		ohci_notice(ohci,
  3764			    "added OHCI v%x.%x device as card %d, "
  3765			    "%d IR + %d IT contexts, quirks 0x%x%s\n",
  3766			    version >> 16, version & 0xff, ohci->card.index,
  3767			    ohci->n_ir, ohci->n_it, ohci->quirks,
  3768			    reg_read(ohci, OHCI1394_PhyUpperBound) ?
  3769				", physUB" : "");
  3770	
  3771		return 0;
  3772	
  3773	 fail_msi:
  3774		pci_disable_msi(dev);
  3775	
  3776		return err;
  3777	}
  3778	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

