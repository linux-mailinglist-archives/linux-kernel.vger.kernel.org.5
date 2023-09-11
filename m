Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEFB279B73C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355071AbjIKV4M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:56:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244347AbjIKUJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 16:09:47 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3C56185
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 13:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694462981; x=1725998981;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=7wOA6Gs1iwFi6J+xDSuXuyZqEgViuwzD+WY2znHPznI=;
  b=RYo0jENym3TuHqSJxA/XjBH7hjrOXM582umHNPpTi8hCHwVZIpF9w3Ar
   2tg32FQuTnXkgdL8VBXTPIpYooFFhkZg9ORunbqNyVGf/iCVGdiS6wxiQ
   vYk4eZRNuczuTmuVp0u8N0jdUyYK1WAeiuzQJ5g1NYvoNBJJrKPTv1Axy
   zbbuMLiWscgoqQA8AHyV8csH9anMjsInzSNiIt3w55CSGHX626oXhTyJG
   XC+5z51ukS6GB0yTu3x7a39mX1vq8V8QzGw10VQO8NKj2X8xtRztFpbyd
   BuZ8egNQHAHHE+fWjw4apCleSQyqlmrf15+GYSO9c6b11eOp/feXLYjUu
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="380894663"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="380894663"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 13:09:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="743469329"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="743469329"
Received: from lkp-server01.sh.intel.com (HELO 59b3c6e06877) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 11 Sep 2023 13:09:39 -0700
Received: from kbuild by 59b3c6e06877 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qfnE1-0006gi-0c;
        Mon, 11 Sep 2023 20:09:37 +0000
Date:   Tue, 12 Sep 2023 04:09:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: drivers/pci/pci.c:4195 pci_pio_to_address() warn: unsigned 'pio' is
 never less than zero.
Message-ID: <202309120432.dJjt8xMp-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   0bb80ecc33a8fb5a682236443c1e740d5c917d1d
commit: 3b59ca944687b8651849f51b15c23e3fdbf07394 PCI: Simplify pci_pio_to_address()
date:   2 weeks ago
config: openrisc-randconfig-r071-20230906 (https://download.01.org/0day-ci/archive/20230912/202309120432.dJjt8xMp-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230912/202309120432.dJjt8xMp-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309120432.dJjt8xMp-lkp@intel.com/

smatch warnings:
drivers/pci/pci.c:4195 pci_pio_to_address() warn: unsigned 'pio' is never less than zero.

vim +/pio +4195 drivers/pci/pci.c

  4191	
  4192	phys_addr_t pci_pio_to_address(unsigned long pio)
  4193	{
  4194	#ifdef PCI_IOBASE
> 4195		if (pio < MMIO_UPPER_LIMIT)
  4196			return logic_pio_to_hwaddr(pio);
  4197	#endif
  4198	
  4199		return (phys_addr_t) OF_BAD_ADDR;
  4200	}
  4201	EXPORT_SYMBOL_GPL(pci_pio_to_address);
  4202	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
