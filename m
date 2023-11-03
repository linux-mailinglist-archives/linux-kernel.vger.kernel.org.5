Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFE857E0B23
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 23:30:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345123AbjKCW0Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 18:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345087AbjKCW0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 18:26:22 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B255CCA;
        Fri,  3 Nov 2023 15:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699050379; x=1730586379;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UFiIUIQtxSDpBAFGAQ0MN5i18hTqs/RaF+24duO/53E=;
  b=TgNXOBJpe9ia+sOCKQMkWJPXS9Zl9GzpzlXd9SQIhg13p6xVMyvgnPv6
   /5CNX7nbhI53IZN5R4aNTioq+aiPJ3kPJISlU79y0GmKfVKAV2iNrDpwZ
   UhGsC/F6+j/Cp7NJxwkd8aFuCcHeueL0rRnOq5sVxEnyENmmZMmaWdEbr
   6lS+lJfMyTwreBF/JecyW1tUItPnZvl4fvXfgw03aGmE7jQ4SRw9uXl+v
   P3bPm8fw/RwqR6rkgDsvKaO4mvz/53yGhGKlXViGosv7JGBWzAwgTLEN2
   Q8c+FkHsgZxO4XGlbAmhYfryJjN/QR1ozXY8tuPNZqORRR57Dmm47Q6Qr
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10883"; a="388859591"
X-IronPort-AV: E=Sophos;i="6.03,275,1694761200"; 
   d="scan'208";a="388859591"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2023 15:26:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10883"; a="796749258"
X-IronPort-AV: E=Sophos;i="6.03,275,1694761200"; 
   d="scan'208";a="796749258"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 03 Nov 2023 15:26:14 -0700
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qz2cG-00030J-0F;
        Fri, 03 Nov 2023 22:26:12 +0000
Date:   Sat, 4 Nov 2023 06:25:05 +0800
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
Message-ID: <202311040623.9oyUHQ6A-lkp@intel.com>
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
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20231104/202311040623.9oyUHQ6A-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231104/202311040623.9oyUHQ6A-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311040623.9oyUHQ6A-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/clk/qcom/camcc-sm8550.c: In function 'cam_cc_sm8550_probe':
>> drivers/clk/qcom/camcc-sm8550.c:3547:36: error: passing argument 1 of 'qcom_cc_really_probe' from incompatible pointer type [-Werror=incompatible-pointer-types]
    3547 |         ret = qcom_cc_really_probe(pdev, &cam_cc_sm8550_desc, regmap);
         |                                    ^~~~
         |                                    |
         |                                    struct platform_device *
   In file included from drivers/clk/qcom/camcc-sm8550.c:19:
   drivers/clk/qcom/common.h:61:48: note: expected 'struct device *' but argument is of type 'struct platform_device *'
      61 | extern int qcom_cc_really_probe(struct device *dev,
         |                                 ~~~~~~~~~~~~~~~^~~
   cc1: some warnings being treated as errors


vim +/qcom_cc_really_probe +3547 drivers/clk/qcom/camcc-sm8550.c

ccc4e6a061a21d Jagadeesh Kona 2023-07-07  3505  
ccc4e6a061a21d Jagadeesh Kona 2023-07-07  3506  static int cam_cc_sm8550_probe(struct platform_device *pdev)
ccc4e6a061a21d Jagadeesh Kona 2023-07-07  3507  {
ccc4e6a061a21d Jagadeesh Kona 2023-07-07  3508  	struct regmap *regmap;
ccc4e6a061a21d Jagadeesh Kona 2023-07-07  3509  	int ret;
ccc4e6a061a21d Jagadeesh Kona 2023-07-07  3510  
ccc4e6a061a21d Jagadeesh Kona 2023-07-07  3511  	ret = devm_pm_runtime_enable(&pdev->dev);
ccc4e6a061a21d Jagadeesh Kona 2023-07-07  3512  	if (ret)
ccc4e6a061a21d Jagadeesh Kona 2023-07-07  3513  		return ret;
ccc4e6a061a21d Jagadeesh Kona 2023-07-07  3514  
ccc4e6a061a21d Jagadeesh Kona 2023-07-07  3515  	ret = pm_runtime_resume_and_get(&pdev->dev);
ccc4e6a061a21d Jagadeesh Kona 2023-07-07  3516  	if (ret)
ccc4e6a061a21d Jagadeesh Kona 2023-07-07  3517  		return ret;
ccc4e6a061a21d Jagadeesh Kona 2023-07-07  3518  
ccc4e6a061a21d Jagadeesh Kona 2023-07-07  3519  	regmap = qcom_cc_map(pdev, &cam_cc_sm8550_desc);
ccc4e6a061a21d Jagadeesh Kona 2023-07-07  3520  	if (IS_ERR(regmap)) {
ccc4e6a061a21d Jagadeesh Kona 2023-07-07  3521  		pm_runtime_put(&pdev->dev);
ccc4e6a061a21d Jagadeesh Kona 2023-07-07  3522  		return PTR_ERR(regmap);
ccc4e6a061a21d Jagadeesh Kona 2023-07-07  3523  	}
ccc4e6a061a21d Jagadeesh Kona 2023-07-07  3524  
ccc4e6a061a21d Jagadeesh Kona 2023-07-07  3525  	clk_lucid_ole_pll_configure(&cam_cc_pll0, regmap, &cam_cc_pll0_config);
ccc4e6a061a21d Jagadeesh Kona 2023-07-07  3526  	clk_lucid_ole_pll_configure(&cam_cc_pll1, regmap, &cam_cc_pll1_config);
ccc4e6a061a21d Jagadeesh Kona 2023-07-07  3527  	clk_rivian_evo_pll_configure(&cam_cc_pll2, regmap, &cam_cc_pll2_config);
ccc4e6a061a21d Jagadeesh Kona 2023-07-07  3528  	clk_lucid_ole_pll_configure(&cam_cc_pll3, regmap, &cam_cc_pll3_config);
ccc4e6a061a21d Jagadeesh Kona 2023-07-07  3529  	clk_lucid_ole_pll_configure(&cam_cc_pll4, regmap, &cam_cc_pll4_config);
ccc4e6a061a21d Jagadeesh Kona 2023-07-07  3530  	clk_lucid_ole_pll_configure(&cam_cc_pll5, regmap, &cam_cc_pll5_config);
ccc4e6a061a21d Jagadeesh Kona 2023-07-07  3531  	clk_lucid_ole_pll_configure(&cam_cc_pll6, regmap, &cam_cc_pll6_config);
ccc4e6a061a21d Jagadeesh Kona 2023-07-07  3532  	clk_lucid_ole_pll_configure(&cam_cc_pll7, regmap, &cam_cc_pll7_config);
ccc4e6a061a21d Jagadeesh Kona 2023-07-07  3533  	clk_lucid_ole_pll_configure(&cam_cc_pll8, regmap, &cam_cc_pll8_config);
ccc4e6a061a21d Jagadeesh Kona 2023-07-07  3534  	clk_lucid_ole_pll_configure(&cam_cc_pll9, regmap, &cam_cc_pll9_config);
ccc4e6a061a21d Jagadeesh Kona 2023-07-07  3535  	clk_lucid_ole_pll_configure(&cam_cc_pll10, regmap, &cam_cc_pll10_config);
ccc4e6a061a21d Jagadeesh Kona 2023-07-07  3536  	clk_lucid_ole_pll_configure(&cam_cc_pll11, regmap, &cam_cc_pll11_config);
ccc4e6a061a21d Jagadeesh Kona 2023-07-07  3537  	clk_lucid_ole_pll_configure(&cam_cc_pll12, regmap, &cam_cc_pll12_config);
ccc4e6a061a21d Jagadeesh Kona 2023-07-07  3538  
ccc4e6a061a21d Jagadeesh Kona 2023-07-07  3539  	/*
ccc4e6a061a21d Jagadeesh Kona 2023-07-07  3540  	 * Keep clocks always enabled:
ccc4e6a061a21d Jagadeesh Kona 2023-07-07  3541  	 *	cam_cc_gdsc_clk
ccc4e6a061a21d Jagadeesh Kona 2023-07-07  3542  	 *	cam_cc_sleep_clk
ccc4e6a061a21d Jagadeesh Kona 2023-07-07  3543  	 */
ccc4e6a061a21d Jagadeesh Kona 2023-07-07  3544  	regmap_update_bits(regmap, 0x1419c, BIT(0), BIT(0));
ccc4e6a061a21d Jagadeesh Kona 2023-07-07  3545  	regmap_update_bits(regmap, 0x142cc, BIT(0), BIT(0));
ccc4e6a061a21d Jagadeesh Kona 2023-07-07  3546  
ccc4e6a061a21d Jagadeesh Kona 2023-07-07 @3547  	ret = qcom_cc_really_probe(pdev, &cam_cc_sm8550_desc, regmap);
ccc4e6a061a21d Jagadeesh Kona 2023-07-07  3548  
ccc4e6a061a21d Jagadeesh Kona 2023-07-07  3549  	pm_runtime_put(&pdev->dev);
ccc4e6a061a21d Jagadeesh Kona 2023-07-07  3550  
ccc4e6a061a21d Jagadeesh Kona 2023-07-07  3551  	return ret;
ccc4e6a061a21d Jagadeesh Kona 2023-07-07  3552  }
ccc4e6a061a21d Jagadeesh Kona 2023-07-07  3553  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
