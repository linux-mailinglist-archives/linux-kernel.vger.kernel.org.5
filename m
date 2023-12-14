Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 310C8812C4C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 10:57:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443481AbjLNJ4f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 04:56:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443490AbjLNJ4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 04:56:33 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2315ABD;
        Thu, 14 Dec 2023 01:56:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702547799; x=1734083799;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xl+adE3EBbL+epRoD376FkUCc+tO7nfywRkSDIRzlSo=;
  b=bwuYLstOoU2kF1DTpplmcHjZsdHN7TykP1AxZ9ULAAgT9VLizDtzfFCo
   y+lqda6Tx4gm2He7qWCOmrcHh6oFjQ8N5K+sWxKKACd8ig/gjbPWiEz3D
   kUCQQRR7ZSVY1hLKWBYTk3ST7l0CG57vFrdfqIKh/jlEM8VtEmnHf2Oj/
   5G279Leoow8Y2SJ9EZA5f3HRg9SdAOwuzSR2IO1exLh6XqfQ0ztb6dQGg
   /c/R5Yhm4B0CDOrJlWOFUmkmVWaMaSJewYoCovARP475IcjLWq2Cm0/oS
   I/WDKCJCYFF522eIzguwPtrIJhA6no6ZSlUs4CGehh+htgb6cT6S3nH6K
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="459419570"
X-IronPort-AV: E=Sophos;i="6.04,275,1695711600"; 
   d="scan'208";a="459419570"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 01:56:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="1021452267"
X-IronPort-AV: E=Sophos;i="6.04,275,1695711600"; 
   d="scan'208";a="1021452267"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 14 Dec 2023 01:56:33 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rDiSE-000LsN-2s;
        Thu, 14 Dec 2023 09:56:30 +0000
Date:   Thu, 14 Dec 2023 17:56:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sherry Sun <sherry.sun@nxp.com>, hongxing.zhu@nxp.com,
        l.stach@pengutronix.de, lpieralisi@kernel.org, kw@linux.com,
        robh@kernel.org, bhelgaas@google.com,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com
Cc:     oe-kbuild-all@lists.linux.dev, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 1/4] PCI: imx6: Add pci host wakeup support on imx
 platforms.
Message-ID: <202312141719.j5GCLQry-lkp@intel.com>
References: <20231213092850.1706042-2-sherry.sun@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231213092850.1706042-2-sherry.sun@nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sherry,

kernel test robot noticed the following build warnings:

[auto build test WARNING on pci/next]
[also build test WARNING on pci/for-linus shawnguo/for-next robh/for-next linus/master v6.7-rc5 next-20231214]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Sherry-Sun/PCI-imx6-Add-pci-host-wakeup-support-on-imx-platforms/20231213-173031
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/20231213092850.1706042-2-sherry.sun%40nxp.com
patch subject: [PATCH V2 1/4] PCI: imx6: Add pci host wakeup support on imx platforms.
config: alpha-randconfig-r112-20231214 (https://download.01.org/0day-ci/archive/20231214/202312141719.j5GCLQry-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231214/202312141719.j5GCLQry-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312141719.j5GCLQry-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/pci/controller/dwc/pci-imx6.c:1267:13: sparse: sparse: symbol 'host_wake_irq_handler' was not declared. Should it be static?
   drivers/pci/controller/dwc/pci-imx6.c: note: in included file (through include/linux/mmzone.h, include/linux/gfp.h, include/linux/umh.h, include/linux/kmod.h, ...):
   include/linux/page-flags.h:242:46: sparse: sparse: self-comparison always evaluates to false

vim +/host_wake_irq_handler +1267 drivers/pci/controller/dwc/pci-imx6.c

  1266	
> 1267	irqreturn_t host_wake_irq_handler(int irq, void *priv)
  1268	{
  1269		struct imx6_pcie *imx6_pcie = priv;
  1270		struct device *dev = imx6_pcie->pci->dev;
  1271	
  1272		/* Notify PM core we are wakeup source */
  1273		pm_wakeup_event(dev, 0);
  1274		pm_system_wakeup();
  1275	
  1276		return IRQ_HANDLED;
  1277	}
  1278	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
