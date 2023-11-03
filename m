Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 389427E0424
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 15:01:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377725AbjKCOBB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 10:01:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230132AbjKCOBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 10:01:00 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A93551A8;
        Fri,  3 Nov 2023 07:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699020053; x=1730556053;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Rz6eCJm7BKehq5IHsWMYysRTu22nf253QJIHbXShJkA=;
  b=P8m4ouBSa2Ierr8jXb/xdPcUPBpeFtR9e697xGd5M+DQlSV/Z9UJiw4E
   hmUdHtQvDDsSczAhy5rcjkE6pOAe5FiBCkYnxqnoFoTWtd1I7ND3olz/2
   5SI442U8mEUlpsPqsT/vpNHhemOQfVzHuJ4EG0r9LrpLViApIaERoa5uY
   hzR6gUcaIJk/nIdcyy3r3ALZKTMDUcamnceRwppX8xM5cQSxHb9ifNBud
   XHa1I58BKVn/gtJbWiNSMt2f5S7lPMlr1uQ4T9kYkc/z75gOymE2n8CTl
   GcZyECgpCxKh3h0CmoGjJYBpTkAXYcGENQYGRgJ7snEgkUAMzFaDL1mVD
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10883"; a="453243547"
X-IronPort-AV: E=Sophos;i="6.03,273,1694761200"; 
   d="scan'208";a="453243547"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2023 07:00:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10883"; a="1093065345"
X-IronPort-AV: E=Sophos;i="6.03,273,1694761200"; 
   d="scan'208";a="1093065345"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 03 Nov 2023 07:00:47 -0700
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qyuj7-0002Yu-1M;
        Fri, 03 Nov 2023 14:00:45 +0000
Date:   Fri, 3 Nov 2023 21:59:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luo Jie <quic_luoj@quicinc.com>, andersson@kernel.org,
        agross@kernel.org, konrad.dybcio@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        catalin.marinas@arm.com, will@kernel.org, p.zabel@pengutronix.de
Cc:     oe-kbuild-all@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_srichara@quicinc.com,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Subject: Re: [PATCH v11 3/4] clk: qcom: common: commonize qcom_cc_really_probe
Message-ID: <202311032153.n6opqP2e-lkp@intel.com>
References: <20231103104846.30875-4-quic_luoj@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231103104846.30875-4-quic_luoj@quicinc.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luo,

kernel test robot noticed the following build errors:

[auto build test ERROR on ff269e2cd5adce4ae14f883fc9c8803bc43ee1e9]

url:    https://github.com/intel-lab-lkp/linux/commits/Luo-Jie/clk-qcom-branch-Add-clk_branch2_prepare_ops/20231103-185251
base:   ff269e2cd5adce4ae14f883fc9c8803bc43ee1e9
patch link:    https://lore.kernel.org/r/20231103104846.30875-4-quic_luoj%40quicinc.com
patch subject: [PATCH v11 3/4] clk: qcom: common: commonize qcom_cc_really_probe
config: csky-randconfig-002-20231103 (https://download.01.org/0day-ci/archive/20231103/202311032153.n6opqP2e-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231103/202311032153.n6opqP2e-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311032153.n6opqP2e-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/clk/qcom/gcc-sm4450.c: In function 'gcc_sm4450_probe':
>> drivers/clk/qcom/gcc-sm4450.c:2874:37: error: passing argument 1 of 'qcom_cc_really_probe' from incompatible pointer type [-Werror=incompatible-pointer-types]
    2874 |         return qcom_cc_really_probe(pdev, &gcc_sm4450_desc, regmap);
         |                                     ^~~~
         |                                     |
         |                                     struct platform_device *
   In file included from drivers/clk/qcom/clk-regmap-mux.h:11,
                    from drivers/clk/qcom/gcc-sm4450.c:19:
   drivers/clk/qcom/common.h:61:48: note: expected 'struct device *' but argument is of type 'struct platform_device *'
      61 | extern int qcom_cc_really_probe(struct device *dev,
         |                                 ~~~~~~~~~~~~~~~^~~
   cc1: some warnings being treated as errors


vim +/qcom_cc_really_probe +2874 drivers/clk/qcom/gcc-sm4450.c

c32c4ef98baca6d Ajit Pandey 2023-09-09  2834  
c32c4ef98baca6d Ajit Pandey 2023-09-09  2835  static int gcc_sm4450_probe(struct platform_device *pdev)
c32c4ef98baca6d Ajit Pandey 2023-09-09  2836  {
c32c4ef98baca6d Ajit Pandey 2023-09-09  2837  	struct regmap *regmap;
c32c4ef98baca6d Ajit Pandey 2023-09-09  2838  	int ret;
c32c4ef98baca6d Ajit Pandey 2023-09-09  2839  
c32c4ef98baca6d Ajit Pandey 2023-09-09  2840  	regmap = qcom_cc_map(pdev, &gcc_sm4450_desc);
c32c4ef98baca6d Ajit Pandey 2023-09-09  2841  	if (IS_ERR(regmap))
c32c4ef98baca6d Ajit Pandey 2023-09-09  2842  		return PTR_ERR(regmap);
c32c4ef98baca6d Ajit Pandey 2023-09-09  2843  
c32c4ef98baca6d Ajit Pandey 2023-09-09  2844  	clk_lucid_evo_pll_configure(&gcc_gpll3, regmap, &gcc_gpll3_config);
c32c4ef98baca6d Ajit Pandey 2023-09-09  2845  	ret = qcom_cc_register_rcg_dfs(regmap, gcc_dfs_clocks,
c32c4ef98baca6d Ajit Pandey 2023-09-09  2846  				       ARRAY_SIZE(gcc_dfs_clocks));
c32c4ef98baca6d Ajit Pandey 2023-09-09  2847  	if (ret)
c32c4ef98baca6d Ajit Pandey 2023-09-09  2848  		return ret;
c32c4ef98baca6d Ajit Pandey 2023-09-09  2849  
c32c4ef98baca6d Ajit Pandey 2023-09-09  2850  	qcom_branch_set_force_mem_core(regmap, gcc_ufs_phy_ice_core_clk, true);
c32c4ef98baca6d Ajit Pandey 2023-09-09  2851  
c32c4ef98baca6d Ajit Pandey 2023-09-09  2852  	/*
c32c4ef98baca6d Ajit Pandey 2023-09-09  2853  	 * Keep clocks always enabled:
c32c4ef98baca6d Ajit Pandey 2023-09-09  2854  	 * gcc_camera_ahb_clk
c32c4ef98baca6d Ajit Pandey 2023-09-09  2855  	 * gcc_camera_sleep_clk
c32c4ef98baca6d Ajit Pandey 2023-09-09  2856  	 * gcc_camera_xo_clk
c32c4ef98baca6d Ajit Pandey 2023-09-09  2857  	 * gcc_disp_ahb_clk
c32c4ef98baca6d Ajit Pandey 2023-09-09  2858  	 * gcc_disp_xo_clk
c32c4ef98baca6d Ajit Pandey 2023-09-09  2859  	 * gcc_gpu_cfg_ahb_clk
c32c4ef98baca6d Ajit Pandey 2023-09-09  2860  	 * gcc_video_ahb_clk
c32c4ef98baca6d Ajit Pandey 2023-09-09  2861  	 * gcc_video_xo_clk
c32c4ef98baca6d Ajit Pandey 2023-09-09  2862  	 */
c32c4ef98baca6d Ajit Pandey 2023-09-09  2863  	regmap_update_bits(regmap, 0x36004, BIT(0), BIT(0));
c32c4ef98baca6d Ajit Pandey 2023-09-09  2864  	regmap_update_bits(regmap, 0x36018, BIT(0), BIT(0));
c32c4ef98baca6d Ajit Pandey 2023-09-09  2865  	regmap_update_bits(regmap, 0x3601c, BIT(0), BIT(0));
c32c4ef98baca6d Ajit Pandey 2023-09-09  2866  	regmap_update_bits(regmap, 0x37004, BIT(0), BIT(0));
c32c4ef98baca6d Ajit Pandey 2023-09-09  2867  	regmap_update_bits(regmap, 0x37014, BIT(0), BIT(0));
c32c4ef98baca6d Ajit Pandey 2023-09-09  2868  	regmap_update_bits(regmap, 0x81004, BIT(0), BIT(0));
c32c4ef98baca6d Ajit Pandey 2023-09-09  2869  	regmap_update_bits(regmap, 0x42004, BIT(0), BIT(0));
c32c4ef98baca6d Ajit Pandey 2023-09-09  2870  	regmap_update_bits(regmap, 0x42018, BIT(0), BIT(0));
c32c4ef98baca6d Ajit Pandey 2023-09-09  2871  
c32c4ef98baca6d Ajit Pandey 2023-09-09  2872  	regmap_update_bits(regmap, 0x4201c, BIT(21), BIT(21));
c32c4ef98baca6d Ajit Pandey 2023-09-09  2873  
c32c4ef98baca6d Ajit Pandey 2023-09-09 @2874  	return qcom_cc_really_probe(pdev, &gcc_sm4450_desc, regmap);
c32c4ef98baca6d Ajit Pandey 2023-09-09  2875  }
c32c4ef98baca6d Ajit Pandey 2023-09-09  2876  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
