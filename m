Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31D2C81205A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 22:04:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442709AbjLMVET (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 16:04:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233987AbjLMVEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 16:04:13 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CA78F3;
        Wed, 13 Dec 2023 13:04:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702501460; x=1734037460;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6rys3A4WrLE7CBewgpOvy2bqrVcyO63SWlnYTKMdg9I=;
  b=e5vcc2q8FJLzqiu5czwR+vzay4ZqnRM6ACjofMmdeAex0/t5fLm7BYqz
   zov59TEfnWj3RKtwSNewsR9punQSySXYCLxfU6p+71lYyhyVG182TavF+
   B+yGwRjxzZkcpbZFDgvDedOWp+yNGVboAWv/3iC4hD1AVMgWN40HTUBkR
   FVgYhdaCqiEdkKBsWFYYj8EQNdQsQcQtKcdLmBZ6Zm/ent67bxklrmyNx
   z/lIH08Zpk9ZjIFiiV3DykP8qV/NU+34bj1lP9K8wLnkDRd8dVEYvp7N9
   DfyK3++kfzsFW3HphQhjQwTkBs9ethtv12wQ6rNiiLTf5SWbNuA2BaFAu
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="8421194"
X-IronPort-AV: E=Sophos;i="6.04,273,1695711600"; 
   d="scan'208";a="8421194"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 13:04:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="723802067"
X-IronPort-AV: E=Sophos;i="6.04,273,1695711600"; 
   d="scan'208";a="723802067"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 13 Dec 2023 13:04:14 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rDWOp-000L8B-2q;
        Wed, 13 Dec 2023 21:04:11 +0000
Date:   Thu, 14 Dec 2023 05:03:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Macpaul Lin <macpaul.lin@mediatek.com>,
        Eddie Hung <eddie.hung@mediatek.com>
Subject: Re: [PATCH 2/3] usb: xhci-mtk: fix a short packet issue of gen1
 isoc-in transfer
Message-ID: <202312140415.r09Wbh8D-lkp@intel.com>
References: <20231213063543.12435-2-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231213063543.12435-2-chunfeng.yun@mediatek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chunfeng,

kernel test robot noticed the following build errors:

[auto build test ERROR on usb/usb-testing]
[also build test ERROR on usb/usb-next usb/usb-linus robh/for-next krzk/for-next linus/master v6.7-rc5 next-20231213]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Chunfeng-Yun/usb-xhci-mtk-fix-a-short-packet-issue-of-gen1-isoc-in-transfer/20231213-143959
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
patch link:    https://lore.kernel.org/r/20231213063543.12435-2-chunfeng.yun%40mediatek.com
patch subject: [PATCH 2/3] usb: xhci-mtk: fix a short packet issue of gen1 isoc-in transfer
config: arm-randconfig-001-20231213 (https://download.01.org/0day-ci/archive/20231214/202312140415.r09Wbh8D-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231214/202312140415.r09Wbh8D-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312140415.r09Wbh8D-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/usb/host/xhci-mtk.c:184:12: error: call to undeclared function 'FIELD_PREP'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     184 |                 value |= FIELD_PREP(SCH3_RXFIFO_DEPTH_MASK, 2);
         |                          ^
   1 error generated.


vim +/FIELD_PREP +184 drivers/usb/host/xhci-mtk.c

   170	
   171	/*
   172	 * workaround: usb3.2 gen1 isoc rx hw issue
   173	 * host send out unexpected ACK afer device fininsh a burst transfer with
   174	 * a short packet.
   175	 */
   176	static void xhci_mtk_rxfifo_depth_set(struct xhci_hcd_mtk *mtk)
   177	{
   178		struct usb_hcd *hcd = mtk->hcd;
   179		u32 value;
   180	
   181		if (mtk->rxfifo_depth_quirk) {
   182			value = readl(hcd->regs + HSCH_CFG1);
   183			value &= ~SCH3_RXFIFO_DEPTH_MASK;
 > 184			value |= FIELD_PREP(SCH3_RXFIFO_DEPTH_MASK, 2);
   185			writel(value, hcd->regs + HSCH_CFG1);
   186		}
   187	}
   188	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
