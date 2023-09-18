Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 909A67A508B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 19:08:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231398AbjIRRIg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 13:08:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231438AbjIRRI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 13:08:26 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B6DB10C8;
        Mon, 18 Sep 2023 10:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695056884; x=1726592884;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=R0IYlcHB+mDxKxCzHImBnbsDf3CITkOOK5I/jc4Vt4g=;
  b=jHmVXcnHxtmp9g7cDHL/OkxMyvebYAO6oquBDrkJo/a+KVVdUPtx3o4J
   MkVxl3S9cxl7Cw5d2qJb8JI3a65E+VPflJvNO+0VsWgvki9hFLNCiaSba
   jC+xQpNXl1k8aT95Bhb5M2muNoIEtY3hIzw0rE6KrlLH6Zz+fRQ2ljPp0
   Q+z8C4FtEwY5cEi6NWyMwHiriy3qHJo3YdqzMX4ZIvcIzxFyCNZfOpSsY
   asldT74jT9fkq2KuYrs3kGhzAXk6jmhyWjmR6hVIsURsKZKKn0f38xiZH
   diUwLCbpjKWkYzycxjq4BIbH9mR2SrwBRF/T3lXD9m4XXeNu2jRpJ2vhc
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="377037214"
X-IronPort-AV: E=Sophos;i="6.02,157,1688454000"; 
   d="scan'208";a="377037214"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 10:08:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="775202677"
X-IronPort-AV: E=Sophos;i="6.02,157,1688454000"; 
   d="scan'208";a="775202677"
Received: from lkp-server02.sh.intel.com (HELO 9ef86b2655e5) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 18 Sep 2023 10:07:58 -0700
Received: from kbuild by 9ef86b2655e5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qiHj2-0006J6-1j;
        Mon, 18 Sep 2023 17:07:56 +0000
Date:   Tue, 19 Sep 2023 01:07:42 +0800
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
Message-ID: <202309190032.1NPAySNx-lkp@intel.com>
References: <20230918073151.7660-5-zhangqing@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230918073151.7660-5-zhangqing@rock-chips.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
config: arm64-defconfig (https://download.01.org/0day-ci/archive/20230919/202309190032.1NPAySNx-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230919/202309190032.1NPAySNx-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309190032.1NPAySNx-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/clk/rockchip/clk-rk3328.c:13:
>> drivers/clk/rockchip/clk-rk3328.c:160:7: warning: 'mux_armclk_p' defined but not used [-Wunused-const-variable=]
     160 | PNAME(mux_armclk_p)             = { "apll_core",
         |       ^~~~~~~~~~~~
   drivers/clk/rockchip/clk.h:512:43: note: in definition of macro 'PNAME'
     512 | #define PNAME(x) static const char *const x[] __initconst
         |                                           ^
--
   In file included from drivers/clk/rockchip/clk-rk3588.c:13:
>> drivers/clk/rockchip/clk-rk3588.c:447:7: warning: 'mux_armclkb23_p' defined but not used [-Wunused-const-variable=]
     447 | PNAME(mux_armclkb23_p)                  = { "xin24m", "gpll", "b1pll",};
         |       ^~~~~~~~~~~~~~~
   drivers/clk/rockchip/clk.h:512:43: note: in definition of macro 'PNAME'
     512 | #define PNAME(x) static const char *const x[] __initconst
         |                                           ^
>> drivers/clk/rockchip/clk-rk3588.c:446:7: warning: 'mux_armclkb01_p' defined but not used [-Wunused-const-variable=]
     446 | PNAME(mux_armclkb01_p)                  = { "xin24m", "gpll", "b0pll",};
         |       ^~~~~~~~~~~~~~~
   drivers/clk/rockchip/clk.h:512:43: note: in definition of macro 'PNAME'
     512 | #define PNAME(x) static const char *const x[] __initconst
         |                                           ^
>> drivers/clk/rockchip/clk-rk3588.c:445:7: warning: 'mux_armclkl_p' defined but not used [-Wunused-const-variable=]
     445 | PNAME(mux_armclkl_p)                    = { "xin24m", "gpll", "lpll" };
         |       ^~~~~~~~~~~~~
   drivers/clk/rockchip/clk.h:512:43: note: in definition of macro 'PNAME'
     512 | #define PNAME(x) static const char *const x[] __initconst
         |                                           ^


vim +/mux_armclk_p +160 drivers/clk/rockchip/clk-rk3328.c

fe3511ad8a1cf6 Elaine Zhang 2016-12-29  144  
fe3511ad8a1cf6 Elaine Zhang 2016-12-29  145  PNAME(mux_2plls_p)		= { "cpll", "gpll" };
fe3511ad8a1cf6 Elaine Zhang 2016-12-29  146  PNAME(mux_gpll_cpll_p)		= { "gpll", "cpll" };
fe3511ad8a1cf6 Elaine Zhang 2016-12-29  147  PNAME(mux_cpll_gpll_apll_p)	= { "cpll", "gpll", "apll" };
fe3511ad8a1cf6 Elaine Zhang 2016-12-29  148  PNAME(mux_2plls_xin24m_p)	= { "cpll", "gpll", "xin24m" };
fe3511ad8a1cf6 Elaine Zhang 2016-12-29  149  PNAME(mux_2plls_hdmiphy_p)	= { "cpll", "gpll",
fe3511ad8a1cf6 Elaine Zhang 2016-12-29  150  				    "dummy_hdmiphy" };
fe3511ad8a1cf6 Elaine Zhang 2016-12-29  151  PNAME(mux_4plls_p)		= { "cpll", "gpll",
fe3511ad8a1cf6 Elaine Zhang 2016-12-29  152  				    "dummy_hdmiphy",
fe3511ad8a1cf6 Elaine Zhang 2016-12-29  153  				    "usb480m" };
fe3511ad8a1cf6 Elaine Zhang 2016-12-29  154  PNAME(mux_2plls_u480m_p)	= { "cpll", "gpll",
fe3511ad8a1cf6 Elaine Zhang 2016-12-29  155  				    "usb480m" };
fe3511ad8a1cf6 Elaine Zhang 2016-12-29  156  PNAME(mux_2plls_24m_u480m_p)	= { "cpll", "gpll",
fe3511ad8a1cf6 Elaine Zhang 2016-12-29  157  				     "xin24m", "usb480m" };
fe3511ad8a1cf6 Elaine Zhang 2016-12-29  158  
fe3511ad8a1cf6 Elaine Zhang 2016-12-29  159  PNAME(mux_ddrphy_p)		= { "dpll", "apll", "cpll" };
fe3511ad8a1cf6 Elaine Zhang 2016-12-29 @160  PNAME(mux_armclk_p)		= { "apll_core",
fe3511ad8a1cf6 Elaine Zhang 2016-12-29  161  				    "gpll_core",
fe3511ad8a1cf6 Elaine Zhang 2016-12-29  162  				    "dpll_core",
fe3511ad8a1cf6 Elaine Zhang 2016-12-29  163  				    "npll_core"};
fe3511ad8a1cf6 Elaine Zhang 2016-12-29  164  PNAME(mux_hdmiphy_p)		= { "hdmi_phy", "xin24m" };
fe3511ad8a1cf6 Elaine Zhang 2016-12-29  165  PNAME(mux_usb480m_p)		= { "usb480m_phy",
fe3511ad8a1cf6 Elaine Zhang 2016-12-29  166  				    "xin24m" };
fe3511ad8a1cf6 Elaine Zhang 2016-12-29  167  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
