Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED22379A584
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 10:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233155AbjIKIHr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 04:07:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbjIKIHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 04:07:46 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9858BE43;
        Mon, 11 Sep 2023 01:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694419635; x=1725955635;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EKc2l8u/kKBul3gNAYJEk/Ck38NKo2uvJewBdyW546M=;
  b=VgDOe5X5X5zZjI9/qFeeXgVsoidcjZD/MBWaxKlQHE6ljCh++krYezTL
   IOg/qeNJt9GEBxLWssqnQjenHJ3MBXKjKheoOBuA/LEHx9lgn/yw4/mBK
   aCIXL4ujaRbeT9vIw5YMJ4SCPNzn8xf18kfV2syze/2dCjhOKmP9wR9x/
   x5exyaS2510A3iyEJXagvG4sqe6Y04AXcD50cyrhdSZnWnpiMpK0vSMkr
   n5KEg5UTTAUew2uKACS/kujGRQrReEz0VdtDeLX1fOeC3kqCJ7DQrHe2y
   47Pdhu7NUxiqwL76anCsbHr4oqqEixlejlBif/3yOulK0Tj6+2eNVWgQC
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10829"; a="444438887"
X-IronPort-AV: E=Sophos;i="6.02,243,1688454000"; 
   d="scan'208";a="444438887"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 01:06:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10829"; a="693005175"
X-IronPort-AV: E=Sophos;i="6.02,243,1688454000"; 
   d="scan'208";a="693005175"
Received: from lkp-server01.sh.intel.com (HELO 59b3c6e06877) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 11 Sep 2023 01:06:47 -0700
Received: from kbuild by 59b3c6e06877 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qfbwS-0005yc-30;
        Mon, 11 Sep 2023 08:06:44 +0000
Date:   Mon, 11 Sep 2023 16:05:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yong Wu <yong.wu@mediatek.com>, Rob Herring <robh+dt@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        christian.koenig@amd.com, Matthias Brugger <matthias.bgg@gmail.com>
Cc:     oe-kbuild-all@lists.linux.dev, devicetree@vger.kernel.org,
        Conor Dooley <conor+dt@kernel.org>, jianjiao.zeng@mediatek.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        kuohong.wang@mediatek.com, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, tjmercier@google.com,
        linaro-mm-sig@lists.linaro.org, John Stultz <jstultz@google.com>,
        linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-mediatek@lists.infradead.org, linux-media@vger.kernel.org,
        Yong Wu <yong.wu@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH 4/9] dma-buf: heaps: Initialise MediaTek secure heap
Message-ID: <202309111534.u4wfJ4vk-lkp@intel.com>
References: <20230911023038.30649-5-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230911023038.30649-5-yong.wu@mediatek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yong,

kernel test robot noticed the following build errors:

[auto build test ERROR on drm-misc/drm-misc-next]
[also build test ERROR on robh/for-next linus/master v6.6-rc1 next-20230911]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Yong-Wu/dma-buf-heaps-Deduplicate-docs-and-adopt-common-format/20230911-103308
base:   git://anongit.freedesktop.org/drm/drm-misc drm-misc-next
patch link:    https://lore.kernel.org/r/20230911023038.30649-5-yong.wu%40mediatek.com
patch subject: [PATCH 4/9] dma-buf: heaps: Initialise MediaTek secure heap
config: openrisc-allmodconfig (https://download.01.org/0day-ci/archive/20230911/202309111534.u4wfJ4vk-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230911/202309111534.u4wfJ4vk-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309111534.u4wfJ4vk-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/dma-buf/heaps/mtk_secure_heap.c:68:27: error: initialization of 'struct dma_buf * (*)(struct dma_heap *, long unsigned int,  long unsigned int,  long unsigned int)' from incompatible pointer type 'struct dma_buf * (*)(struct dma_heap *, size_t,  long unsigned int,  long unsigned int)' {aka 'struct dma_buf * (*)(struct dma_heap *, unsigned int,  long unsigned int,  long unsigned int)'} [-Werror=incompatible-pointer-types]
      68 |         .allocate       = mtk_sec_heap_allocate,
         |                           ^~~~~~~~~~~~~~~~~~~~~
   drivers/dma-buf/heaps/mtk_secure_heap.c:68:27: note: (near initialization for 'mtk_sec_heap_ops.allocate')
   cc1: some warnings being treated as errors


vim +68 drivers/dma-buf/heaps/mtk_secure_heap.c

    66	
    67	static const struct dma_heap_ops mtk_sec_heap_ops = {
  > 68		.allocate	= mtk_sec_heap_allocate,
    69	};
    70	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
