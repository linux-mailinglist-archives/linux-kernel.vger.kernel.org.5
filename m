Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A5AA7AFBBB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 09:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbjI0HOJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 03:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjI0HOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 03:14:07 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFF33BF
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 00:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695798845; x=1727334845;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xXMk41cviz8TI2cRUNeinAXs5JKVUHO3/qlU2k2Hl5o=;
  b=g7LmMexJWXl8pJFY1htfbcXDn+hwKjRNHhXr6isJhp+eUciOhZd3x7wF
   B5UBY3ugSoAy9h+/ASeCty91NCxSo9hKXxnDqThJNU+Rq76mcQkRhr4hj
   grmDkv16qF+XfsRxTJ/mzwE6OF+P065qEus3KyAM0D1Xb9V3y3f5MPTrW
   /uAUSABZqxOzI3JmQ+bZgpsEcrgzedz3a86GuqVqcSWwnQ2SIv1wcSzet
   6Vu7xS+X1/ySLVU3TSUcaUU6MuDofoZruKAKBE6dxcgNXYOcA8ogv5E0Q
   8MYLxW82Q0kMB6Yu5CNDjv6eh2u/Pjlvm1Mgw++lS1Z8bgI4M9BtoqYPS
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="366810161"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="366810161"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2023 00:14:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="428454"
Received: from lkp-server02.sh.intel.com (HELO 32c80313467c) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 27 Sep 2023 00:14:00 -0700
Received: from kbuild by 32c80313467c with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qlOk9-0003rA-17;
        Wed, 27 Sep 2023 07:13:57 +0000
Date:   Wed, 27 Sep 2023 15:13:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jim Quinlan <james.quinlan@broadcom.com>,
        Christoph Hellwig <hch@lst.de>,
        bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com
Cc:     oe-kbuild-all@lists.linux.dev,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        Eric DeVolder <eric.devolder@oracle.com>,
        Nathan Chancellor <nathan@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] ARM: Select DMA_DIRECT_REMAP to fix restricted DMA
Message-ID: <202309271425.sxoPXWOX-lkp@intel.com>
References: <20230926175208.9298-2-james.quinlan@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230926175208.9298-2-james.quinlan@broadcom.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jim,

kernel test robot noticed the following build errors:

[auto build test ERROR on arm/for-next]
[also build test ERROR on linus/master hch-configfs/for-next arm/fixes v6.6-rc3 next-20230927]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jim-Quinlan/ARM-Select-DMA_DIRECT_REMAP-to-fix-restricted-DMA/20230927-025212
base:   git://git.armlinux.org.uk/~rmk/linux-arm.git for-next
patch link:    https://lore.kernel.org/r/20230926175208.9298-2-james.quinlan%40broadcom.com
patch subject: [PATCH v1 1/1] ARM: Select DMA_DIRECT_REMAP to fix restricted DMA
config: arm-allnoconfig (https://download.01.org/0day-ci/archive/20230927/202309271425.sxoPXWOX-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230927/202309271425.sxoPXWOX-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309271425.sxoPXWOX-lkp@intel.com/

All errors (new ones prefixed by >>):

   kernel/dma/pool.c: In function 'atomic_pool_expand':
>> kernel/dma/pool.c:105:44: error: implicit declaration of function 'pgprot_dmacoherent' [-Werror=implicit-function-declaration]
     105 |                                            pgprot_dmacoherent(PAGE_KERNEL),
         |                                            ^~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/pgprot_dmacoherent +105 kernel/dma/pool.c

d7e673ec2c8e0ea Nicolas Saenz Julienne 2020-08-14   78  
54adadf9b08571f David Rientjes         2020-04-20   79  static int atomic_pool_expand(struct gen_pool *pool, size_t pool_size,
54adadf9b08571f David Rientjes         2020-04-20   80  			      gfp_t gfp)
e860c299ac0d738 David Rientjes         2020-04-14   81  {
54adadf9b08571f David Rientjes         2020-04-20   82  	unsigned int order;
892fc9f6835ecf0 Dan Carpenter          2020-08-26   83  	struct page *page = NULL;
e860c299ac0d738 David Rientjes         2020-04-14   84  	void *addr;
54adadf9b08571f David Rientjes         2020-04-20   85  	int ret = -ENOMEM;
54adadf9b08571f David Rientjes         2020-04-20   86  
23baf831a32c04f Kirill A. Shutemov     2023-03-15   87  	/* Cannot allocate larger than MAX_ORDER */
23baf831a32c04f Kirill A. Shutemov     2023-03-15   88  	order = min(get_order(pool_size), MAX_ORDER);
54adadf9b08571f David Rientjes         2020-04-20   89  
54adadf9b08571f David Rientjes         2020-04-20   90  	do {
54adadf9b08571f David Rientjes         2020-04-20   91  		pool_size = 1 << (PAGE_SHIFT + order);
d7e673ec2c8e0ea Nicolas Saenz Julienne 2020-08-14   92  		if (cma_in_zone(gfp))
d7e673ec2c8e0ea Nicolas Saenz Julienne 2020-08-14   93  			page = dma_alloc_from_contiguous(NULL, 1 << order,
d7e673ec2c8e0ea Nicolas Saenz Julienne 2020-08-14   94  							 order, false);
d7e673ec2c8e0ea Nicolas Saenz Julienne 2020-08-14   95  		if (!page)
c84dc6e68a1d246 David Rientjes         2020-04-14   96  			page = alloc_pages(gfp, order);
54adadf9b08571f David Rientjes         2020-04-20   97  	} while (!page && order-- > 0);
e860c299ac0d738 David Rientjes         2020-04-14   98  	if (!page)
e860c299ac0d738 David Rientjes         2020-04-14   99  		goto out;
e860c299ac0d738 David Rientjes         2020-04-14  100  
c84dc6e68a1d246 David Rientjes         2020-04-14  101  	arch_dma_prep_coherent(page, pool_size);
e860c299ac0d738 David Rientjes         2020-04-14  102  
76a19940bd62a81 David Rientjes         2020-04-14  103  #ifdef CONFIG_DMA_DIRECT_REMAP
c84dc6e68a1d246 David Rientjes         2020-04-14  104  	addr = dma_common_contiguous_remap(page, pool_size,
e860c299ac0d738 David Rientjes         2020-04-14 @105  					   pgprot_dmacoherent(PAGE_KERNEL),
e860c299ac0d738 David Rientjes         2020-04-14  106  					   __builtin_return_address(0));
e860c299ac0d738 David Rientjes         2020-04-14  107  	if (!addr)
54adadf9b08571f David Rientjes         2020-04-20  108  		goto free_page;
76a19940bd62a81 David Rientjes         2020-04-14  109  #else
76a19940bd62a81 David Rientjes         2020-04-14  110  	addr = page_to_virt(page);
76a19940bd62a81 David Rientjes         2020-04-14  111  #endif
76a19940bd62a81 David Rientjes         2020-04-14  112  	/*
76a19940bd62a81 David Rientjes         2020-04-14  113  	 * Memory in the atomic DMA pools must be unencrypted, the pools do not
2f5388a29be82a6 Christoph Hellwig      2020-08-17  114  	 * shrink so no re-encryption occurs in dma_direct_free().
76a19940bd62a81 David Rientjes         2020-04-14  115  	 */
76a19940bd62a81 David Rientjes         2020-04-14  116  	ret = set_memory_decrypted((unsigned long)page_to_virt(page),
76a19940bd62a81 David Rientjes         2020-04-14  117  				   1 << order);
76a19940bd62a81 David Rientjes         2020-04-14  118  	if (ret)
76a19940bd62a81 David Rientjes         2020-04-14  119  		goto remove_mapping;
54adadf9b08571f David Rientjes         2020-04-20  120  	ret = gen_pool_add_virt(pool, (unsigned long)addr, page_to_phys(page),
54adadf9b08571f David Rientjes         2020-04-20  121  				pool_size, NUMA_NO_NODE);
e860c299ac0d738 David Rientjes         2020-04-14  122  	if (ret)
76a19940bd62a81 David Rientjes         2020-04-14  123  		goto encrypt_mapping;
e860c299ac0d738 David Rientjes         2020-04-14  124  
2edc5bb3c5cc421 David Rientjes         2020-04-14  125  	dma_atomic_pool_size_add(gfp, pool_size);
e860c299ac0d738 David Rientjes         2020-04-14  126  	return 0;
e860c299ac0d738 David Rientjes         2020-04-14  127  
76a19940bd62a81 David Rientjes         2020-04-14  128  encrypt_mapping:
76a19940bd62a81 David Rientjes         2020-04-14  129  	ret = set_memory_encrypted((unsigned long)page_to_virt(page),
76a19940bd62a81 David Rientjes         2020-04-14  130  				   1 << order);
76a19940bd62a81 David Rientjes         2020-04-14  131  	if (WARN_ON_ONCE(ret)) {
76a19940bd62a81 David Rientjes         2020-04-14  132  		/* Decrypt succeeded but encrypt failed, purposely leak */
76a19940bd62a81 David Rientjes         2020-04-14  133  		goto out;
76a19940bd62a81 David Rientjes         2020-04-14  134  	}
e860c299ac0d738 David Rientjes         2020-04-14  135  remove_mapping:
76a19940bd62a81 David Rientjes         2020-04-14  136  #ifdef CONFIG_DMA_DIRECT_REMAP
c84dc6e68a1d246 David Rientjes         2020-04-14  137  	dma_common_free_remap(addr, pool_size);
76a19940bd62a81 David Rientjes         2020-04-14  138  #endif
76a19940bd62a81 David Rientjes         2020-04-14  139  free_page: __maybe_unused
c84dc6e68a1d246 David Rientjes         2020-04-14  140  	__free_pages(page, order);
e860c299ac0d738 David Rientjes         2020-04-14  141  out:
54adadf9b08571f David Rientjes         2020-04-20  142  	return ret;
54adadf9b08571f David Rientjes         2020-04-20  143  }
54adadf9b08571f David Rientjes         2020-04-20  144  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
