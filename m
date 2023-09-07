Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1052797EE2
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 00:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233205AbjIGW5s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 18:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbjIGW5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 18:57:47 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EF5BCF3;
        Thu,  7 Sep 2023 15:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694127463; x=1725663463;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NiD2jrGgGfQ6xnh6f7vp7lyP6csMdiSncB/f8Y5qcyU=;
  b=AeroaSU/XnqCVOJYzXordGRRPYkjAjJ6l6rL70FDWFaNAGDxphKsbnX1
   47s+BAVwzriGNH7jOZ/pI+zmNKYqHcqyj0Ep67NmBoaIqLyOb8+NReNvR
   2+uOaf98bN7Nnb0yGi74uedXuzpqvbCknTd+UrXi45GbdZ3U2lOvddfK/
   qgCZKV+nzdxHe6vduHix6V2JKgbwi6XE3+d9VcjDTlMufsDdh4Y3VMCrj
   eJUPFdt477o22F582wpwhrncdu19qiU7omO8FzQT32jBbW3StkoA5jV8/
   yZeOlUoQ/2uLZN63CuSIST4dD4rYs/oGF+SErgX10rANqxSrQDIjfbvdg
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10826"; a="443927703"
X-IronPort-AV: E=Sophos;i="6.02,236,1688454000"; 
   d="scan'208";a="443927703"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2023 15:57:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10826"; a="807721018"
X-IronPort-AV: E=Sophos;i="6.02,236,1688454000"; 
   d="scan'208";a="807721018"
Received: from lkp-server01.sh.intel.com (HELO 59b3c6e06877) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 07 Sep 2023 15:57:37 -0700
Received: from kbuild by 59b3c6e06877 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qeNwM-0001gT-2V;
        Thu, 07 Sep 2023 22:57:34 +0000
Date:   Fri, 8 Sep 2023 06:57:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Lu Hongfei <luhongfei@vivo.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bean Huo <beanhuo@micron.com>,
        Asutosh Das <quic_asutoshd@quicinc.com>,
        "Bao D. Nguyen" <quic_nguyenb@quicinc.com>,
        Arthur Simchaev <Arthur.Simchaev@wdc.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        opensource.kernel@vivo.com, luhongfei@vivo.com
Subject: Re: [PATCH 3/3] scsi: ufs: core: Add exception event handler to
 implicitly handle WB buffer resize event
Message-ID: <202309080646.NhYcVypx-lkp@intel.com>
References: <20230907094517.1961-1-luhongfei@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230907094517.1961-1-luhongfei@vivo.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lu,

kernel test robot noticed the following build errors:

[auto build test ERROR on mkp-scsi/for-next]
[also build test ERROR on jejb-scsi/for-next linus/master v6.5 next-20230907]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Lu-Hongfei/scsi-ufs-core-allow-host-driver-to-enable-wb-buffer-resize-function/20230907-234105
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mkp/scsi.git for-next
patch link:    https://lore.kernel.org/r/20230907094517.1961-1-luhongfei%40vivo.com
patch subject: [PATCH 3/3] scsi: ufs: core: Add exception event handler to implicitly handle WB buffer resize event
config: hexagon-randconfig-002-20230908 (https://download.01.org/0day-ci/archive/20230908/202309080646.NhYcVypx-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230908/202309080646.NhYcVypx-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309080646.NhYcVypx-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/ufs/core/ufshcd.c:18:
   In file included from include/linux/blkdev.h:9:
   In file included from include/linux/blk_types.h:10:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:334:
   include/asm-generic/io.h:547:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     547 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:560:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     560 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
         |                                                   ^
   In file included from drivers/ufs/core/ufshcd.c:18:
   In file included from include/linux/blkdev.h:9:
   In file included from include/linux/blk_types.h:10:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:334:
   include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     573 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
         |                                                   ^
   In file included from drivers/ufs/core/ufshcd.c:18:
   In file included from include/linux/blkdev.h:9:
   In file included from include/linux/blk_types.h:10:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:334:
   include/asm-generic/io.h:584:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     584 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:594:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     594 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:604:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     604 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
>> drivers/ufs/core/ufshcd.c:322:19: error: member reference type 'struct ufs_dev_info' is not a pointer; did you mean to use '.'?
     322 |         if (hba->dev_info->wspecversion >= 0x410
         |             ~~~~~~~~~~~~~^~
         |                          .
   drivers/ufs/core/ufshcd.c:323:22: error: member reference type 'struct ufs_dev_info' is not a pointer; did you mean to use '.'?
     323 |             && hba->dev_info->b_presrv_uspc_en
         |                ~~~~~~~~~~~~~^~
         |                             .
>> drivers/ufs/core/ufshcd.c:326:3: error: call to undeclared function 'ufshcd_enable_ee'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     326 |                 ufshcd_enable_ee(hba, mask);
         |                 ^
   drivers/ufs/core/ufshcd.c:326:3: note: did you mean 'ufshcd_enable_irq'?
   drivers/ufs/core/ufshcd.c:291:20: note: 'ufshcd_enable_irq' declared here
     291 | static inline void ufshcd_enable_irq(struct ufs_hba *hba)
         |                    ^
>> drivers/ufs/core/ufshcd.c:5642:19: error: static declaration of 'ufshcd_enable_ee' follows non-static declaration
    5642 | static inline int ufshcd_enable_ee(struct ufs_hba *hba, u16 mask)
         |                   ^
   drivers/ufs/core/ufshcd.c:326:3: note: previous implicit declaration is here
     326 |                 ufshcd_enable_ee(hba, mask);
         |                 ^
   drivers/ufs/core/ufshcd.c:10216:44: warning: shift count >= width of type [-Wshift-count-overflow]
    10216 |                 if (!dma_set_mask_and_coherent(hba->dev, DMA_BIT_MASK(64)))
          |                                                          ^~~~~~~~~~~~~~~~
   include/linux/dma-mapping.h:77:54: note: expanded from macro 'DMA_BIT_MASK'
      77 | #define DMA_BIT_MASK(n) (((n) == 64) ? ~0ULL : ((1ULL<<(n))-1))
         |                                                      ^ ~~~
   7 warnings and 4 errors generated.


vim +322 drivers/ufs/core/ufshcd.c

   306	
   307	static void ufshcd_configure_wb(struct ufs_hba *hba)
   308	{
   309		u16 mask = 0;
   310	
   311		if (!ufshcd_is_wb_allowed(hba))
   312			return;
   313	
   314		ufshcd_wb_toggle(hba, true);
   315	
   316		ufshcd_wb_toggle_buf_flush_during_h8(hba, true);
   317	
   318		if (ufshcd_is_wb_buf_flush_allowed(hba))
   319			ufshcd_wb_toggle_buf_flush(hba, true);
   320	
   321		/* Enable the WRITEBOOSTER_RESIZE_HINT exception mechanism. */
 > 322		if (hba->dev_info->wspecversion >= 0x410
   323		    && hba->dev_info->b_presrv_uspc_en
   324		    && ufshcd_is_wb_buf_resize_allowed(hba)) {
   325			mask |= MASK_EE_WRITEBOOSTER_RESIZE_HINT;
 > 326			ufshcd_enable_ee(hba, mask);
   327		}
   328	}
   329	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
