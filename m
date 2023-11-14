Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD2627EB70C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 20:56:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232316AbjKNT4O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 14:56:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231845AbjKNT4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 14:56:13 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C36FE102;
        Tue, 14 Nov 2023 11:56:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699991770; x=1731527770;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IGQvX3vuHuTOI2zKiTF0zCQrHKiUfa60fb5KchO4ijo=;
  b=Swlc3wQpFll/deuXRIb4dullx+lKGEHIIpxFw5BeeNsQEJHyMlpAF3bq
   SR4GeZqsMrKzfp85ZGcxKXkW1CVXrH9f5nqksNrFJgRJVwEIh4tm4FDw4
   VJr6Ol7YGNGWLYxK2/sdDAull3bhy2pg0jaIm5iHQvmADuI2T1Hf8jP/K
   +7Og0o61L9fFgSxc8IZhTwODCq8o6o06uMXanLRHQprr67EC0vWpQHfkH
   bb6Lory4/+E2yIQUbZDxGwTdJxPDUvnP+w8LdhxYRth7KaYfycXP3F1Zk
   aDOummwl8v97GfHq6knT5IlNaE2SpkYxq8jidu8FRxm+eO1bGDQlEzljt
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="3846009"
X-IronPort-AV: E=Sophos;i="6.03,302,1694761200"; 
   d="scan'208";a="3846009"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2023 11:56:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="835153317"
X-IronPort-AV: E=Sophos;i="6.03,302,1694761200"; 
   d="scan'208";a="835153317"
Received: from lkp-server02.sh.intel.com (HELO 83346ef18697) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 14 Nov 2023 11:56:06 -0800
Received: from kbuild by 83346ef18697 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r2zVz-0000cK-39;
        Tue, 14 Nov 2023 19:56:03 +0000
Date:   Wed, 15 Nov 2023 03:55:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Meng Li <Meng.Li@windriver.com>, gregkh@linuxfoundation.org,
        mathias.nyman@linux.intel.com, stern@rowland.harvard.edu,
        Basavaraj.Natikar@amd.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        meng.li@windriver.com
Subject: Re: [PATCH] usb: hcd-pci: replace usb_hcd_irq() with
 generic_handle_irq_safe() to avoid calltrace
Message-ID: <202311150335.CARpQOQl-lkp@intel.com>
References: <20231113030041.3655742-1-Meng.Li@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231113030041.3655742-1-Meng.Li@windriver.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Meng,

kernel test robot noticed the following build errors:

[auto build test ERROR on usb/usb-testing]
[also build test ERROR on usb/usb-next usb/usb-linus linus/master v6.7-rc1 next-20231114]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Meng-Li/usb-hcd-pci-replace-usb_hcd_irq-with-generic_handle_irq_safe-to-avoid-calltrace/20231113-110341
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
patch link:    https://lore.kernel.org/r/20231113030041.3655742-1-Meng.Li%40windriver.com
patch subject: [PATCH] usb: hcd-pci: replace usb_hcd_irq() with generic_handle_irq_safe() to avoid calltrace
config: x86_64-rhel-8.3-rust (https://download.01.org/0day-ci/archive/20231115/202311150335.CARpQOQl-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231115/202311150335.CARpQOQl-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311150335.CARpQOQl-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/usb/core/hcd-pci.c:328:2: error: call to undeclared function 'generic_handle_irq_safe'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           generic_handle_irq_safe(dev->irq);
           ^
   1 error generated.


vim +/generic_handle_irq_safe +328 drivers/usb/core/hcd-pci.c

   297	
   298	/**
   299	 * usb_hcd_pci_remove - shutdown processing for PCI-based HCDs
   300	 * @dev: USB Host Controller being removed
   301	 *
   302	 * Context: task context, might sleep
   303	 *
   304	 * Reverses the effect of usb_hcd_pci_probe(), first invoking
   305	 * the HCD's stop() method.  It is always called from a thread
   306	 * context, normally "rmmod", "apmd", or something similar.
   307	 *
   308	 * Store this function in the HCD's struct pci_driver as remove().
   309	 */
   310	void usb_hcd_pci_remove(struct pci_dev *dev)
   311	{
   312		struct usb_hcd		*hcd;
   313		int			hcd_driver_flags;
   314	
   315		hcd = pci_get_drvdata(dev);
   316		if (!hcd)
   317			return;
   318	
   319		hcd_driver_flags = hcd->driver->flags;
   320	
   321		if (pci_dev_run_wake(dev))
   322			pm_runtime_get_noresume(&dev->dev);
   323	
   324		/* Fake an interrupt request in order to give the driver a chance
   325		 * to test whether the controller hardware has been removed (e.g.,
   326		 * cardbus physical eject).
   327		 */
 > 328		generic_handle_irq_safe(dev->irq);
   329	
   330		/* Note: dev_set_drvdata must be called while holding the rwsem */
   331		if (dev->class == CL_EHCI) {
   332			down_write(&companions_rwsem);
   333			for_each_companion(dev, hcd, ehci_remove);
   334			usb_remove_hcd(hcd);
   335			dev_set_drvdata(&dev->dev, NULL);
   336			up_write(&companions_rwsem);
   337		} else {
   338			/* Not EHCI; just clear the companion pointer */
   339			down_read(&companions_rwsem);
   340			hcd->self.hs_companion = NULL;
   341			usb_remove_hcd(hcd);
   342			dev_set_drvdata(&dev->dev, NULL);
   343			up_read(&companions_rwsem);
   344		}
   345		usb_put_hcd(hcd);
   346		if ((hcd_driver_flags & HCD_MASK) < HCD_USB3)
   347			pci_free_irq_vectors(dev);
   348		pci_disable_device(dev);
   349	}
   350	EXPORT_SYMBOL_GPL(usb_hcd_pci_remove);
   351	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
