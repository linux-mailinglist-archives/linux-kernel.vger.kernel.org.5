Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 185FB7A4DE1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 18:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbjIRQCp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 12:02:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbjIRQCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 12:02:39 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 704523AAE;
        Mon, 18 Sep 2023 08:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695052791; x=1726588791;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wrosthJUnxVMaSxcC9tfsTcexUe2H8V9t9v/2I1oI3M=;
  b=O94rOP1CGdhqabILPhlvytt42OzWYTBXuS8xDzk47JPyvUaY7c9Sz7ie
   HNnruJASFkcUjHkEbaoWS74ZsptDb94CAhnO6VPLNrDWlYy2XJmwN+Wse
   Jq5AAPL1T4uOAYDQqUUj/RnQMWBv8RlKf8tGmK3lEU2inyK7vy24nxs1I
   3mirgCwKrf5uNh6KehzDfzoTNeIHM4reXevZYTDMVrCAbD16H3iUceEL3
   Jq+KrrngvWmeGuejxa6s/ORX0n9BBN9q7Pw8rD5kM4TA0lps3R+ycypYw
   wR+NzmZkPymlnFXFxRBKtxV4po4sDlfxZnTUMxtEYfk773tUo4WhZTCcz
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="383480338"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="383480338"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 06:33:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="836016054"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="836016054"
Received: from lkp-server02.sh.intel.com (HELO 9ef86b2655e5) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 18 Sep 2023 06:33:23 -0700
Received: from kbuild by 9ef86b2655e5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qiENL-00068J-1j;
        Mon, 18 Sep 2023 13:33:20 +0000
Date:   Mon, 18 Sep 2023 21:32:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Elaine Zhang <zhangqing@rock-chips.com>, mturquette@baylibre.com,
        sboyd@kernel.org, kever.yang@rock-chips.com, heiko@sntech.de,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        huangtao@rock-chips.com, xxx@rock-chips.com, xf@rock-chips.com
Subject: Re: [PATCH v1 4/8] clk: rockchip: Avoid __clk_lookup() calls
Message-ID: <202309182118.ErkxCm5A-lkp@intel.com>
References: <20230918073151.7660-5-zhangqing@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230918073151.7660-5-zhangqing@rock-chips.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Elaine,

kernel test robot noticed the following build warnings:

[auto build test WARNING on rockchip/for-next]
[also build test WARNING on clk/clk-next linus/master v6.6-rc2 next-20230918]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Elaine-Zhang/clk-clk-fractional-divider-Export-clk_fractional_divider_general_approximation-API/20230918-154652
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git for-next
patch link:    https://lore.kernel.org/r/20230918073151.7660-5-zhangqing%40rock-chips.com
patch subject: [PATCH v1 4/8] clk: rockchip: Avoid __clk_lookup() calls
config: arm-defconfig (https://download.01.org/0day-ci/archive/20230918/202309182118.ErkxCm5A-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230918/202309182118.ErkxCm5A-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309182118.ErkxCm5A-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/clk/rockchip/clk-rv1126.c:14:
>> drivers/clk/rockchip/clk-rv1126.c:157:7: warning: 'mux_armclk_p' defined but not used [-Wunused-const-variable=]
     157 | PNAME(mux_armclk_p)                     = { "gpll", "cpll", "apll" };
         |       ^~~~~~~~~~~~
   drivers/clk/rockchip/clk.h:512:43: note: in definition of macro 'PNAME'
     512 | #define PNAME(x) static const char *const x[] __initconst
         |                                           ^


vim +/mux_armclk_p +157 drivers/clk/rockchip/clk-rv1126.c

2408ab5aa876cb Jagan Teki 2022-09-15  @14  #include "clk.h"
2408ab5aa876cb Jagan Teki 2022-09-15   15  
2408ab5aa876cb Jagan Teki 2022-09-15   16  #define RV1126_GMAC_CON			0x460
2408ab5aa876cb Jagan Teki 2022-09-15   17  #define RV1126_GRF_IOFUNC_CON1		0x10264
2408ab5aa876cb Jagan Teki 2022-09-15   18  #define RV1126_GRF_SOC_STATUS0		0x10
2408ab5aa876cb Jagan Teki 2022-09-15   19  
2408ab5aa876cb Jagan Teki 2022-09-15   20  #define RV1126_FRAC_MAX_PRATE		1200000000
2408ab5aa876cb Jagan Teki 2022-09-15   21  #define RV1126_CSIOUT_FRAC_MAX_PRATE	300000000
2408ab5aa876cb Jagan Teki 2022-09-15   22  
2408ab5aa876cb Jagan Teki 2022-09-15   23  enum rv1126_pmu_plls {
2408ab5aa876cb Jagan Teki 2022-09-15   24  	gpll,
2408ab5aa876cb Jagan Teki 2022-09-15   25  };
2408ab5aa876cb Jagan Teki 2022-09-15   26  
2408ab5aa876cb Jagan Teki 2022-09-15   27  enum rv1126_plls {
2408ab5aa876cb Jagan Teki 2022-09-15   28  	apll, dpll, cpll, hpll,
2408ab5aa876cb Jagan Teki 2022-09-15   29  };
2408ab5aa876cb Jagan Teki 2022-09-15   30  
2408ab5aa876cb Jagan Teki 2022-09-15   31  static struct rockchip_pll_rate_table rv1126_pll_rates[] = {
2408ab5aa876cb Jagan Teki 2022-09-15   32  	/* _mhz, _refdiv, _fbdiv, _postdiv1, _postdiv2, _dsmpd, _frac */
2408ab5aa876cb Jagan Teki 2022-09-15   33  	RK3036_PLL_RATE(1608000000, 1, 67, 1, 1, 1, 0),
2408ab5aa876cb Jagan Teki 2022-09-15   34  	RK3036_PLL_RATE(1600000000, 3, 200, 1, 1, 1, 0),
2408ab5aa876cb Jagan Teki 2022-09-15   35  	RK3036_PLL_RATE(1584000000, 1, 132, 2, 1, 1, 0),
2408ab5aa876cb Jagan Teki 2022-09-15   36  	RK3036_PLL_RATE(1560000000, 1, 130, 2, 1, 1, 0),
2408ab5aa876cb Jagan Teki 2022-09-15   37  	RK3036_PLL_RATE(1536000000, 1, 128, 2, 1, 1, 0),
2408ab5aa876cb Jagan Teki 2022-09-15   38  	RK3036_PLL_RATE(1512000000, 1, 126, 2, 1, 1, 0),
2408ab5aa876cb Jagan Teki 2022-09-15   39  	RK3036_PLL_RATE(1488000000, 1, 124, 2, 1, 1, 0),
2408ab5aa876cb Jagan Teki 2022-09-15   40  	RK3036_PLL_RATE(1464000000, 1, 122, 2, 1, 1, 0),
2408ab5aa876cb Jagan Teki 2022-09-15   41  	RK3036_PLL_RATE(1440000000, 1, 120, 2, 1, 1, 0),
2408ab5aa876cb Jagan Teki 2022-09-15   42  	RK3036_PLL_RATE(1416000000, 1, 118, 2, 1, 1, 0),
2408ab5aa876cb Jagan Teki 2022-09-15   43  	RK3036_PLL_RATE(1400000000, 3, 350, 2, 1, 1, 0),
2408ab5aa876cb Jagan Teki 2022-09-15   44  	RK3036_PLL_RATE(1392000000, 1, 116, 2, 1, 1, 0),
2408ab5aa876cb Jagan Teki 2022-09-15   45  	RK3036_PLL_RATE(1368000000, 1, 114, 2, 1, 1, 0),
2408ab5aa876cb Jagan Teki 2022-09-15   46  	RK3036_PLL_RATE(1344000000, 1, 112, 2, 1, 1, 0),
2408ab5aa876cb Jagan Teki 2022-09-15   47  	RK3036_PLL_RATE(1320000000, 1, 110, 2, 1, 1, 0),
2408ab5aa876cb Jagan Teki 2022-09-15   48  	RK3036_PLL_RATE(1296000000, 1, 108, 2, 1, 1, 0),
2408ab5aa876cb Jagan Teki 2022-09-15   49  	RK3036_PLL_RATE(1272000000, 1, 106, 2, 1, 1, 0),
2408ab5aa876cb Jagan Teki 2022-09-15   50  	RK3036_PLL_RATE(1248000000, 1, 104, 2, 1, 1, 0),
2408ab5aa876cb Jagan Teki 2022-09-15   51  	RK3036_PLL_RATE(1200000000, 1, 100, 2, 1, 1, 0),
2408ab5aa876cb Jagan Teki 2022-09-15   52  	RK3036_PLL_RATE(1188000000, 1, 99, 2, 1, 1, 0),
2408ab5aa876cb Jagan Teki 2022-09-15   53  	RK3036_PLL_RATE(1104000000, 1, 92, 2, 1, 1, 0),
2408ab5aa876cb Jagan Teki 2022-09-15   54  	RK3036_PLL_RATE(1100000000, 3, 275, 2, 1, 1, 0),
2408ab5aa876cb Jagan Teki 2022-09-15   55  	RK3036_PLL_RATE(1008000000, 1, 84, 2, 1, 1, 0),
2408ab5aa876cb Jagan Teki 2022-09-15   56  	RK3036_PLL_RATE(1000000000, 3, 250, 2, 1, 1, 0),
2408ab5aa876cb Jagan Teki 2022-09-15   57  	RK3036_PLL_RATE(984000000, 1, 82, 2, 1, 1, 0),
2408ab5aa876cb Jagan Teki 2022-09-15   58  	RK3036_PLL_RATE(960000000, 1, 80, 2, 1, 1, 0),
2408ab5aa876cb Jagan Teki 2022-09-15   59  	RK3036_PLL_RATE(936000000, 1, 78, 2, 1, 1, 0),
2408ab5aa876cb Jagan Teki 2022-09-15   60  	RK3036_PLL_RATE(912000000, 1, 76, 2, 1, 1, 0),
2408ab5aa876cb Jagan Teki 2022-09-15   61  	RK3036_PLL_RATE(900000000, 1, 75, 2, 1, 1, 0),
2408ab5aa876cb Jagan Teki 2022-09-15   62  	RK3036_PLL_RATE(888000000, 1, 74, 2, 1, 1, 0),
2408ab5aa876cb Jagan Teki 2022-09-15   63  	RK3036_PLL_RATE(864000000, 1, 72, 2, 1, 1, 0),
2408ab5aa876cb Jagan Teki 2022-09-15   64  	RK3036_PLL_RATE(840000000, 1, 70, 2, 1, 1, 0),
2408ab5aa876cb Jagan Teki 2022-09-15   65  	RK3036_PLL_RATE(816000000, 1, 68, 2, 1, 1, 0),
2408ab5aa876cb Jagan Teki 2022-09-15   66  	RK3036_PLL_RATE(800000000, 3, 200, 2, 1, 1, 0),
2408ab5aa876cb Jagan Teki 2022-09-15   67  	RK3036_PLL_RATE(700000000, 3, 350, 4, 1, 1, 0),
2408ab5aa876cb Jagan Teki 2022-09-15   68  	RK3036_PLL_RATE(696000000, 1, 116, 4, 1, 1, 0),
2408ab5aa876cb Jagan Teki 2022-09-15   69  	RK3036_PLL_RATE(624000000, 1, 104, 4, 1, 1, 0),
2408ab5aa876cb Jagan Teki 2022-09-15   70  	RK3036_PLL_RATE(600000000, 1, 100, 4, 1, 1, 0),
2408ab5aa876cb Jagan Teki 2022-09-15   71  	RK3036_PLL_RATE(594000000, 1, 99, 4, 1, 1, 0),
2408ab5aa876cb Jagan Teki 2022-09-15   72  	RK3036_PLL_RATE(504000000, 1, 84, 4, 1, 1, 0),
2408ab5aa876cb Jagan Teki 2022-09-15   73  	RK3036_PLL_RATE(500000000, 1, 125, 6, 1, 1, 0),
2408ab5aa876cb Jagan Teki 2022-09-15   74  	RK3036_PLL_RATE(408000000, 1, 68, 2, 2, 1, 0),
2408ab5aa876cb Jagan Teki 2022-09-15   75  	RK3036_PLL_RATE(312000000, 1, 78, 6, 1, 1, 0),
2408ab5aa876cb Jagan Teki 2022-09-15   76  	RK3036_PLL_RATE(216000000, 1, 72, 4, 2, 1, 0),
2408ab5aa876cb Jagan Teki 2022-09-15   77  	RK3036_PLL_RATE(96000000, 1, 96, 6, 4, 1, 0),
2408ab5aa876cb Jagan Teki 2022-09-15   78  	{ /* sentinel */ },
2408ab5aa876cb Jagan Teki 2022-09-15   79  };
2408ab5aa876cb Jagan Teki 2022-09-15   80  
2408ab5aa876cb Jagan Teki 2022-09-15   81  #define RV1126_DIV_ACLK_CORE_MASK	0xf
2408ab5aa876cb Jagan Teki 2022-09-15   82  #define RV1126_DIV_ACLK_CORE_SHIFT	4
2408ab5aa876cb Jagan Teki 2022-09-15   83  #define RV1126_DIV_PCLK_DBG_MASK	0x7
2408ab5aa876cb Jagan Teki 2022-09-15   84  #define RV1126_DIV_PCLK_DBG_SHIFT	0
2408ab5aa876cb Jagan Teki 2022-09-15   85  
2408ab5aa876cb Jagan Teki 2022-09-15   86  #define RV1126_CLKSEL1(_aclk_core, _pclk_dbg)				\
2408ab5aa876cb Jagan Teki 2022-09-15   87  {									\
2408ab5aa876cb Jagan Teki 2022-09-15   88  	.reg = RV1126_CLKSEL_CON(1),					\
2408ab5aa876cb Jagan Teki 2022-09-15   89  	.val = HIWORD_UPDATE(_aclk_core, RV1126_DIV_ACLK_CORE_MASK,	\
2408ab5aa876cb Jagan Teki 2022-09-15   90  			     RV1126_DIV_ACLK_CORE_SHIFT) |		\
2408ab5aa876cb Jagan Teki 2022-09-15   91  	       HIWORD_UPDATE(_pclk_dbg, RV1126_DIV_PCLK_DBG_MASK,	\
2408ab5aa876cb Jagan Teki 2022-09-15   92  			     RV1126_DIV_PCLK_DBG_SHIFT),		\
2408ab5aa876cb Jagan Teki 2022-09-15   93  }
2408ab5aa876cb Jagan Teki 2022-09-15   94  
2408ab5aa876cb Jagan Teki 2022-09-15   95  #define RV1126_CPUCLK_RATE(_prate, _aclk_core, _pclk_dbg)		\
2408ab5aa876cb Jagan Teki 2022-09-15   96  {									\
2408ab5aa876cb Jagan Teki 2022-09-15   97  	.prate = _prate,						\
2408ab5aa876cb Jagan Teki 2022-09-15   98  	.divs = {							\
2408ab5aa876cb Jagan Teki 2022-09-15   99  		RV1126_CLKSEL1(_aclk_core, _pclk_dbg),			\
2408ab5aa876cb Jagan Teki 2022-09-15  100  	},								\
2408ab5aa876cb Jagan Teki 2022-09-15  101  }
2408ab5aa876cb Jagan Teki 2022-09-15  102  
2408ab5aa876cb Jagan Teki 2022-09-15  103  static struct rockchip_cpuclk_rate_table rv1126_cpuclk_rates[] __initdata = {
2408ab5aa876cb Jagan Teki 2022-09-15  104  	RV1126_CPUCLK_RATE(1608000000, 1, 7),
2408ab5aa876cb Jagan Teki 2022-09-15  105  	RV1126_CPUCLK_RATE(1584000000, 1, 7),
2408ab5aa876cb Jagan Teki 2022-09-15  106  	RV1126_CPUCLK_RATE(1560000000, 1, 7),
2408ab5aa876cb Jagan Teki 2022-09-15  107  	RV1126_CPUCLK_RATE(1536000000, 1, 7),
2408ab5aa876cb Jagan Teki 2022-09-15  108  	RV1126_CPUCLK_RATE(1512000000, 1, 7),
2408ab5aa876cb Jagan Teki 2022-09-15  109  	RV1126_CPUCLK_RATE(1488000000, 1, 5),
2408ab5aa876cb Jagan Teki 2022-09-15  110  	RV1126_CPUCLK_RATE(1464000000, 1, 5),
2408ab5aa876cb Jagan Teki 2022-09-15  111  	RV1126_CPUCLK_RATE(1440000000, 1, 5),
2408ab5aa876cb Jagan Teki 2022-09-15  112  	RV1126_CPUCLK_RATE(1416000000, 1, 5),
2408ab5aa876cb Jagan Teki 2022-09-15  113  	RV1126_CPUCLK_RATE(1392000000, 1, 5),
2408ab5aa876cb Jagan Teki 2022-09-15  114  	RV1126_CPUCLK_RATE(1368000000, 1, 5),
2408ab5aa876cb Jagan Teki 2022-09-15  115  	RV1126_CPUCLK_RATE(1344000000, 1, 5),
2408ab5aa876cb Jagan Teki 2022-09-15  116  	RV1126_CPUCLK_RATE(1320000000, 1, 5),
2408ab5aa876cb Jagan Teki 2022-09-15  117  	RV1126_CPUCLK_RATE(1296000000, 1, 5),
2408ab5aa876cb Jagan Teki 2022-09-15  118  	RV1126_CPUCLK_RATE(1272000000, 1, 5),
2408ab5aa876cb Jagan Teki 2022-09-15  119  	RV1126_CPUCLK_RATE(1248000000, 1, 5),
2408ab5aa876cb Jagan Teki 2022-09-15  120  	RV1126_CPUCLK_RATE(1224000000, 1, 5),
2408ab5aa876cb Jagan Teki 2022-09-15  121  	RV1126_CPUCLK_RATE(1200000000, 1, 5),
2408ab5aa876cb Jagan Teki 2022-09-15  122  	RV1126_CPUCLK_RATE(1104000000, 1, 5),
2408ab5aa876cb Jagan Teki 2022-09-15  123  	RV1126_CPUCLK_RATE(1008000000, 1, 5),
2408ab5aa876cb Jagan Teki 2022-09-15  124  	RV1126_CPUCLK_RATE(912000000, 1, 5),
2408ab5aa876cb Jagan Teki 2022-09-15  125  	RV1126_CPUCLK_RATE(816000000, 1, 3),
2408ab5aa876cb Jagan Teki 2022-09-15  126  	RV1126_CPUCLK_RATE(696000000, 1, 3),
2408ab5aa876cb Jagan Teki 2022-09-15  127  	RV1126_CPUCLK_RATE(600000000, 1, 3),
2408ab5aa876cb Jagan Teki 2022-09-15  128  	RV1126_CPUCLK_RATE(408000000, 1, 1),
2408ab5aa876cb Jagan Teki 2022-09-15  129  	RV1126_CPUCLK_RATE(312000000, 1, 1),
2408ab5aa876cb Jagan Teki 2022-09-15  130  	RV1126_CPUCLK_RATE(216000000,  1, 1),
2408ab5aa876cb Jagan Teki 2022-09-15  131  	RV1126_CPUCLK_RATE(96000000, 1, 1),
2408ab5aa876cb Jagan Teki 2022-09-15  132  };
2408ab5aa876cb Jagan Teki 2022-09-15  133  
2408ab5aa876cb Jagan Teki 2022-09-15  134  static const struct rockchip_cpuclk_reg_data rv1126_cpuclk_data = {
2408ab5aa876cb Jagan Teki 2022-09-15  135  	.core_reg[0] = RV1126_CLKSEL_CON(0),
2408ab5aa876cb Jagan Teki 2022-09-15  136  	.div_core_shift[0] = 0,
2408ab5aa876cb Jagan Teki 2022-09-15  137  	.div_core_mask[0] = 0x1f,
2408ab5aa876cb Jagan Teki 2022-09-15  138  	.num_cores = 1,
2408ab5aa876cb Jagan Teki 2022-09-15  139  	.mux_core_alt = 0,
2408ab5aa876cb Jagan Teki 2022-09-15  140  	.mux_core_main = 2,
2408ab5aa876cb Jagan Teki 2022-09-15  141  	.mux_core_shift = 6,
2408ab5aa876cb Jagan Teki 2022-09-15  142  	.mux_core_mask = 0x3,
2408ab5aa876cb Jagan Teki 2022-09-15  143  };
2408ab5aa876cb Jagan Teki 2022-09-15  144  
2408ab5aa876cb Jagan Teki 2022-09-15  145  PNAME(mux_pll_p)			= { "xin24m" };
2408ab5aa876cb Jagan Teki 2022-09-15  146  PNAME(mux_rtc32k_p)			= { "clk_pmupvtm_divout", "xin32k", "clk_osc0_div32k" };
2408ab5aa876cb Jagan Teki 2022-09-15  147  PNAME(mux_wifi_p)			= { "clk_wifi_osc0", "clk_wifi_div" };
2408ab5aa876cb Jagan Teki 2022-09-15  148  PNAME(mux_gpll_usb480m_cpll_xin24m_p)	= { "gpll", "usb480m", "cpll", "xin24m" };
2408ab5aa876cb Jagan Teki 2022-09-15  149  PNAME(mux_uart1_p)			= { "sclk_uart1_div", "sclk_uart1_fracdiv", "xin24m" };
2408ab5aa876cb Jagan Teki 2022-09-15  150  PNAME(mux_xin24m_gpll_p)		= { "xin24m", "gpll" };
2408ab5aa876cb Jagan Teki 2022-09-15  151  PNAME(mux_gpll_xin24m_p)		= { "gpll", "xin24m" };
2408ab5aa876cb Jagan Teki 2022-09-15  152  PNAME(mux_xin24m_32k_p)			= { "xin24m", "clk_rtc32k" };
2408ab5aa876cb Jagan Teki 2022-09-15  153  PNAME(mux_usbphy_otg_ref_p)		= { "clk_ref12m", "xin_osc0_div2_usbphyref_otg" };
2408ab5aa876cb Jagan Teki 2022-09-15  154  PNAME(mux_usbphy_host_ref_p)		= { "clk_ref12m", "xin_osc0_div2_usbphyref_host" };
2408ab5aa876cb Jagan Teki 2022-09-15  155  PNAME(mux_mipidsiphy_ref_p)		= { "clk_ref24m", "xin_osc0_mipiphyref" };
2408ab5aa876cb Jagan Teki 2022-09-15  156  PNAME(mux_usb480m_p)			= { "xin24m", "usb480m_phy", "clk_rtc32k" };
2408ab5aa876cb Jagan Teki 2022-09-15 @157  PNAME(mux_armclk_p)			= { "gpll", "cpll", "apll" };
2408ab5aa876cb Jagan Teki 2022-09-15  158  PNAME(mux_gpll_cpll_dpll_p)		= { "gpll", "cpll", "dummy_dpll" };
2408ab5aa876cb Jagan Teki 2022-09-15  159  PNAME(mux_gpll_cpll_p)			= { "gpll", "cpll" };
2408ab5aa876cb Jagan Teki 2022-09-15  160  PNAME(mux_hclk_pclk_pdbus_p)		= { "gpll", "dummy_cpll" };
2408ab5aa876cb Jagan Teki 2022-09-15  161  PNAME(mux_gpll_cpll_usb480m_xin24m_p)	= { "gpll", "cpll", "usb480m", "xin24m" };
2408ab5aa876cb Jagan Teki 2022-09-15  162  PNAME(mux_uart0_p)			= { "sclk_uart0_div", "sclk_uart0_frac", "xin24m" };
2408ab5aa876cb Jagan Teki 2022-09-15  163  PNAME(mux_uart2_p)			= { "sclk_uart2_div", "sclk_uart2_frac", "xin24m" };
2408ab5aa876cb Jagan Teki 2022-09-15  164  PNAME(mux_uart3_p)			= { "sclk_uart3_div", "sclk_uart3_frac", "xin24m" };
2408ab5aa876cb Jagan Teki 2022-09-15  165  PNAME(mux_uart4_p)			= { "sclk_uart4_div", "sclk_uart4_frac", "xin24m" };
2408ab5aa876cb Jagan Teki 2022-09-15  166  PNAME(mux_uart5_p)			= { "sclk_uart5_div", "sclk_uart5_frac", "xin24m" };
2408ab5aa876cb Jagan Teki 2022-09-15  167  PNAME(mux_cpll_gpll_p)			= { "cpll", "gpll" };
2408ab5aa876cb Jagan Teki 2022-09-15  168  PNAME(mux_i2s0_tx_p)			= { "mclk_i2s0_tx_div", "mclk_i2s0_tx_fracdiv", "i2s0_mclkin", "xin12m" };
2408ab5aa876cb Jagan Teki 2022-09-15  169  PNAME(mux_i2s0_rx_p)			= { "mclk_i2s0_rx_div", "mclk_i2s0_rx_fracdiv", "i2s0_mclkin", "xin12m" };
2408ab5aa876cb Jagan Teki 2022-09-15  170  PNAME(mux_i2s0_tx_out2io_p)		= { "mclk_i2s0_tx", "xin12m" };
2408ab5aa876cb Jagan Teki 2022-09-15  171  PNAME(mux_i2s0_rx_out2io_p)		= { "mclk_i2s0_rx", "xin12m" };
2408ab5aa876cb Jagan Teki 2022-09-15  172  PNAME(mux_i2s1_p)			= { "mclk_i2s1_div", "mclk_i2s1_fracdiv", "i2s1_mclkin", "xin12m" };
2408ab5aa876cb Jagan Teki 2022-09-15  173  PNAME(mux_i2s1_out2io_p)		= { "mclk_i2s1", "xin12m" };
2408ab5aa876cb Jagan Teki 2022-09-15  174  PNAME(mux_i2s2_p)			= { "mclk_i2s2_div", "mclk_i2s2_fracdiv", "i2s2_mclkin", "xin12m" };
2408ab5aa876cb Jagan Teki 2022-09-15  175  PNAME(mux_i2s2_out2io_p)		= { "mclk_i2s2", "xin12m" };
2408ab5aa876cb Jagan Teki 2022-09-15  176  PNAME(mux_gpll_cpll_xin24m_p)		= { "gpll", "cpll", "xin24m" };
2408ab5aa876cb Jagan Teki 2022-09-15  177  PNAME(mux_audpwm_p)			= { "sclk_audpwm_div", "sclk_audpwm_fracdiv", "xin24m" };
5c7a71fd82350c Jagan Teki 2023-07-31  178  PNAME(mux_dclk_vop_p)			= { "dclk_vop_div", "dclk_vop_fracdiv", "xin24m" };
2408ab5aa876cb Jagan Teki 2022-09-15  179  PNAME(mux_usb480m_gpll_p)		= { "usb480m", "gpll" };
2408ab5aa876cb Jagan Teki 2022-09-15  180  PNAME(clk_gmac_src_m0_p)		= { "clk_gmac_div", "clk_gmac_rgmii_m0" };
2408ab5aa876cb Jagan Teki 2022-09-15  181  PNAME(clk_gmac_src_m1_p)		= { "clk_gmac_div", "clk_gmac_rgmii_m1" };
2408ab5aa876cb Jagan Teki 2022-09-15  182  PNAME(mux_clk_gmac_src_p)		= { "clk_gmac_src_m0", "clk_gmac_src_m1" };
2408ab5aa876cb Jagan Teki 2022-09-15  183  PNAME(mux_rgmii_clk_p)			= { "clk_gmac_tx_div50", "clk_gmac_tx_div5", "clk_gmac_tx_src", "clk_gmac_tx_src"};
2408ab5aa876cb Jagan Teki 2022-09-15  184  PNAME(mux_rmii_clk_p)			= { "clk_gmac_rx_div20", "clk_gmac_rx_div2" };
2408ab5aa876cb Jagan Teki 2022-09-15  185  PNAME(mux_gmac_tx_rx_p)			= { "rgmii_mode_clk", "rmii_mode_clk" };
2408ab5aa876cb Jagan Teki 2022-09-15  186  PNAME(mux_dpll_gpll_p)			= { "dpll", "gpll" };
2408ab5aa876cb Jagan Teki 2022-09-15  187  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
