Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B369475B50C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 18:54:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbjGTQya (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 12:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbjGTQy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 12:54:27 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FD61173A;
        Thu, 20 Jul 2023 09:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689872066; x=1721408066;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jsTm2UaW1yv/guIOUhcU4FeneLP0J9xCcYSp75A3fpc=;
  b=GS1YICRgg4xY5E/dbmvHGHhv9BVSjUizoc/XMZAjl+tpmTftkKZyL7/0
   zSsJciPqAAQTlfi2p/FZTGCYhvGsRUP1a/gp9yiDqBSL+C3xK2euv+67C
   flY1Nw8Mb/i69t+71su4qxrfFwxsnUzuXos/Bro4+oeRi9ZRG2rX1sy4M
   idTmdrCoDwF8e9c2yBs6ir3iN28/5f0iXpFb++8fl/Gz3ZhP/POVGjwbh
   yxYU2tCwmCh3rEzL8WLaymPhkIzFuosNvVEYPe0zqmp2y6anyj+nYmDSL
   31Z47TcQYs3NaMrJDm3WR/iljVD+g/mxhJ7mtca9AahXYdb9L8amoiPpg
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="430596138"
X-IronPort-AV: E=Sophos;i="6.01,219,1684825200"; 
   d="scan'208";a="430596138"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2023 09:54:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="759638874"
X-IronPort-AV: E=Sophos;i="6.01,219,1684825200"; 
   d="scan'208";a="759638874"
Received: from lkp-server02.sh.intel.com (HELO 36946fcf73d7) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 20 Jul 2023 09:54:14 -0700
Received: from kbuild by 36946fcf73d7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qMWus-0006IH-0C;
        Thu, 20 Jul 2023 16:54:14 +0000
Date:   Fri, 21 Jul 2023 00:54:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Praveenkumar I <quic_ipkumar@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, amitk@kernel.org,
        thara.gopinath@gmail.com, rafael@kernel.org,
        daniel.lezcano@linaro.org, rui.zhang@intel.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        quic_varada@quicinc.com
Subject: Re: [PATCH v4 1/5] thermal/drivers/tsens: Add TSENS enable and
 calibration support for V2
Message-ID: <202307210014.qNnx99K8-lkp@intel.com>
References: <20230719104041.126718-2-quic_ipkumar@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230719104041.126718-2-quic_ipkumar@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Praveenkumar,

kernel test robot noticed the following build errors:

[auto build test ERROR on rafael-pm/thermal]
[also build test ERROR on robh/for-next linus/master v6.5-rc2 next-20230720]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Praveenkumar-I/thermal-drivers-tsens-Add-TSENS-enable-and-calibration-support-for-V2/20230719-184436
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal
patch link:    https://lore.kernel.org/r/20230719104041.126718-2-quic_ipkumar%40quicinc.com
patch subject: [PATCH v4 1/5] thermal/drivers/tsens: Add TSENS enable and calibration support for V2
config: arm-randconfig-r001-20230720 (https://download.01.org/0day-ci/archive/20230721/202307210014.qNnx99K8-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project.git f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce: (https://download.01.org/0day-ci/archive/20230721/202307210014.qNnx99K8-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307210014.qNnx99K8-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/thermal/qcom/tsens-v2.c:153:9: error: implicit declaration of function 'FIELD_PREP' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
                   val = FIELD_PREP(CONVERSION_SHIFT_MASK, V2_SHIFT_DEFAULT) |
                         ^
   1 error generated.

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for SM_GCC_8450
   Depends on [n]: COMMON_CLK [=y] && COMMON_CLK_QCOM [=y] && (ARM64 || COMPILE_TEST [=n])
   Selected by [y]:
   - SM_VIDEOCC_8450 [=y] && COMMON_CLK [=y] && COMMON_CLK_QCOM [=y]
   WARNING: unmet direct dependencies detected for SM_GCC_8550
   Depends on [n]: COMMON_CLK [=y] && COMMON_CLK_QCOM [=y] && (ARM64 || COMPILE_TEST [=n])
   Selected by [y]:
   - SM_GPUCC_8550 [=y] && COMMON_CLK [=y] && COMMON_CLK_QCOM [=y]


vim +/FIELD_PREP +153 drivers/thermal/qcom/tsens-v2.c

   129	
   130	static int tsens_v2_calibrate_sensor(struct device *dev, struct tsens_sensor *sensor,
   131					     struct regmap *map,  u32 mode, u32 base0, u32 base1)
   132	{
   133		u32 slope, czero, val;
   134		char name[8];
   135		int ret;
   136	
   137		/* Read offset value */
   138		ret = snprintf(name, sizeof(name), "s%d", sensor->hw_id);
   139		if (ret < 0)
   140			return ret;
   141	
   142		ret = nvmem_cell_read_variable_le_u32(dev, name, &sensor->offset);
   143		if (ret)
   144			return ret;
   145	
   146		/* Based on calib mode, program SHIFT, SLOPE and CZERO */
   147		switch (mode) {
   148		case TWO_PT_CALIB:
   149			slope = (TWO_PT_SHIFTED_GAIN / (base1 - base0));
   150	
   151			czero = (base0 + sensor->offset - ((base1 - base0) / 3));
   152	
 > 153			val = FIELD_PREP(CONVERSION_SHIFT_MASK, V2_SHIFT_DEFAULT) |
   154			      FIELD_PREP(CONVERSION_SLOPE_MASK, slope) |
   155			      FIELD_PREP(CONVERSION_CZERO_MASK, czero);
   156	
   157			fallthrough;
   158		case ONE_PT_CALIB2:
   159			czero = base0 + sensor->offset - ONE_PT_CZERO_CONST;
   160	
   161			val = FIELD_PREP(CONVERSION_SHIFT_MASK, V2_SHIFT_DEFAULT) |
   162			      FIELD_PREP(CONVERSION_SLOPE_MASK, ONE_PT_SLOPE) |
   163			      FIELD_PREP(CONVERSION_CZERO_MASK, czero);
   164	
   165			break;
   166		default:
   167			dev_dbg(dev, "calibrationless mode\n");
   168	
   169			val = FIELD_PREP(CONVERSION_SHIFT_MASK, V2_SHIFT_DEFAULT) |
   170			      FIELD_PREP(CONVERSION_SLOPE_MASK, V2_SLOPE_DEFAULT) |
   171			      FIELD_PREP(CONVERSION_CZERO_MASK, V2_CZERO_DEFAULT);
   172		}
   173	
   174		regmap_write(map, SENSOR_CONVERSION(sensor->hw_id), val);
   175	
   176		return 0;
   177	}
   178	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
