Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3A578050F4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 11:45:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345009AbjLEKpH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 05:45:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235078AbjLEKpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 05:45:05 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 687D1FA;
        Tue,  5 Dec 2023 02:45:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701773112; x=1733309112;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SOLccH3Xzc++EaBQ0v6eolcJHqG0ji0sa1DvQVydOv4=;
  b=B/Pzv3q33kt8RpyZTy/nN4u42ZFajAZmXfsTKeD8tjpYhp42/TC16GYj
   ojRlnTUVc9MaTnwB5XaNZdyJ+S+4fXb9RIkXpNhebVWMY4TCCSVmOs4cM
   lmc8UhjjpDBe6/1nBV8/M/p+8wbozHlFSnQ968ASyoPMjFZWJVZly3MCC
   j2BlG9RBsmSRn1vBh/CZa59BePhRPgvWrqDd1vwO9DHsh8Gatu8scdG0V
   e3aC/gFjpJwoiHvAz4T9jn8yJMlYpSa9ZrVT9gpqzrg2afvNzBSegEG2w
   oDHjqn8i1CkdgEz4SR/l+x2gUKGeYQwgY7YRvSYM1HaqUapCYOLUDtg5m
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="393609836"
X-IronPort-AV: E=Sophos;i="6.04,251,1695711600"; 
   d="scan'208";a="393609836"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 02:45:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="914758875"
X-IronPort-AV: E=Sophos;i="6.04,251,1695711600"; 
   d="scan'208";a="914758875"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 05 Dec 2023 02:45:05 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rASus-0008na-2J;
        Tue, 05 Dec 2023 10:45:03 +0000
Date:   Tue, 5 Dec 2023 18:44:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Philipp Stanner <pstanner@redhat.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Hanjun Guo <guohanjun@huawei.com>, NeilBrown <neilb@suse.de>,
        Kent Overstreet <kmo@daterainc.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Uladzislau Koshchanka <koshchanka@gmail.com>,
        John Sanpe <sanpeqf@gmail.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        David Gow <davidgow@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "wuqiang.matt" <wuqiang.matt@bytedance.com>,
        Yury Norov <yury.norov@gmail.com>,
        Jason Baron <jbaron@akamai.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ben Dooks <ben.dooks@codethink.co.uk>, dakr@redhat.com
Cc:     oe-kbuild-all@lists.linux.dev,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-arch@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3 5/5] lib, pci: unify generic pci_iounmap()
Message-ID: <202312051813.09WbvusW-lkp@intel.com>
References: <20231204123834.29247-6-pstanner@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231204123834.29247-6-pstanner@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Philipp,

kernel test robot noticed the following build errors:

[auto build test ERROR on pci/next]
[also build test ERROR on pci/for-linus arnd-asm-generic/master kees/for-next/pstore kees/for-next/kspp linus/master v6.7-rc4 next-20231205]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Philipp-Stanner/lib-pci_iomap-c-fix-cleanup-bugs-in-pci_iounmap/20231204-204128
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/20231204123834.29247-6-pstanner%40redhat.com
patch subject: [PATCH v3 5/5] lib, pci: unify generic pci_iounmap()
config: openrisc-virt_defconfig (https://download.01.org/0day-ci/archive/20231205/202312051813.09WbvusW-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231205/202312051813.09WbvusW-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312051813.09WbvusW-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/pci/iomap.c: In function 'pci_iounmap':
>> drivers/pci/iomap.c:155:17: error: implicit declaration of function 'ioport_unmap'; did you mean 'devm_ioport_unmap'? [-Werror=implicit-function-declaration]
     155 |                 ioport_unmap(addr);
         |                 ^~~~~~~~~~~~
         |                 devm_ioport_unmap
   cc1: some warnings being treated as errors


vim +155 drivers/pci/iomap.c

   144	
   145	/**
   146	 * pci_iounmap - Unmapp a mapping
   147	 * @dev: PCI device the mapping belongs to
   148	 * @addr: start address of the mapping
   149	 *
   150	 * Unmapp a PIO or MMIO mapping.
   151	 */
   152	void pci_iounmap(struct pci_dev *dev, void __iomem *addr)
   153	{
   154		if (iomem_is_ioport(addr)) {
 > 155			ioport_unmap(addr);
   156			return;
   157		}
   158	
   159		iounmap(addr);
   160	}
   161	EXPORT_SYMBOL(pci_iounmap);
   162	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
