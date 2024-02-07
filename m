Return-Path: <linux-kernel+bounces-55912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2869C84C34C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 04:50:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A86421F21FB6
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 03:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C89D812E78;
	Wed,  7 Feb 2024 03:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WRSfXb5g"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873FB12E74;
	Wed,  7 Feb 2024 03:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707277780; cv=none; b=GfaE0Jj6Cc1utxWn4akcSi7XpOlYwQXMBx+xSxbIR7Rko9nkMDt/OScI0o37iX1I6TjccjTk6wTi0yo3/CH8W2ukQJroxRoYk41kpBKB3fsNFOjVvX+nE18vtzIgPgBkOMV/GxfdXiasGqFVWyeyGz803Z8We/wxrlJN/WUUmfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707277780; c=relaxed/simple;
	bh=ObkV3zInduvhSkY4zn3MNEHSwTQuIk8E/taDaK7eh1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nNVk/sglDjWRYFWYii+Xr1CyUYmJSm/N55jL45CsBsQCtUw5dY3YPXqjeFAT7Sjpz4RI3tSdXK0dswxpViPHKfxpzvSVp62DK3VOuqhe+YHcaMiT6ocfIr+NBKKBdx5/DaHe5Q9OO+u83+oNw5AVuLQXkA89qYT5r5oPTv0XFzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WRSfXb5g; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707277777; x=1738813777;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ObkV3zInduvhSkY4zn3MNEHSwTQuIk8E/taDaK7eh1I=;
  b=WRSfXb5gX94iaJDY/smAUga9ND1/koJxgx9QM+6pFzyxwxnJPEp0PE3O
   vMOhq+iqzC6iFNSjoZY/ghtD/ZJmak6ICePDQAQFUcY0TTnBf5qzIa+gV
   Q55bVPS7WzNX6xrAGu5wdXNGopomZCbjsqAaKh/s7z5F4mZwIb9T2Q2LR
   wzgunk/nLiRhpz/jowJ5J3S3V4aIXAX4P6QYo1r7zhPuCtated2lkU83f
   eHSHFGOCLxPjo54WmEfXXAcrVewJybhGVWXgPkHC6oY1DYl2CnYP4ZSWg
   wXLAxYUnLR3BFV0RE9ZbziFmiZVPek2Sa+gOIJpmKFXpIQtIDl3rKCLq4
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10976"; a="1049669"
X-IronPort-AV: E=Sophos;i="6.05,250,1701158400"; 
   d="scan'208";a="1049669"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 19:49:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,250,1701158400"; 
   d="scan'208";a="5825634"
Received: from lkp-server01.sh.intel.com (HELO 01f0647817ea) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 06 Feb 2024 19:49:32 -0800
Received: from kbuild by 01f0647817ea with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rXYwE-00024y-1S;
	Wed, 07 Feb 2024 03:49:30 +0000
Date: Wed, 7 Feb 2024 11:49:27 +0800
From: kernel test robot <lkp@intel.com>
To: Jagadeesh Kona <quic_jkona@quicinc.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
	Taniya Das <quic_tdas@quicinc.com>, linux-arm-msm@vger.kernel.org,
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Imran Shaik <quic_imrashai@quicinc.com>,
	Ajit Pandey <quic_ajipan@quicinc.com>,
	Jagadeesh Kona <quic_jkona@quicinc.com>
Subject: Re: [PATCH 2/5] clk: qcom: videocc-sm8550: Add support for SM8650
 videocc
Message-ID: <202402071128.aZc6BNmF-lkp@intel.com>
References: <20240206113145.31096-3-quic_jkona@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240206113145.31096-3-quic_jkona@quicinc.com>

Hi Jagadeesh,

kernel test robot noticed the following build warnings:

[auto build test WARNING on clk/clk-next]
[also build test WARNING on robh/for-next linus/master v6.8-rc3 next-20240206]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jagadeesh-Kona/dt-bindings-clock-qcom-Add-video-clock-bindings-for-SM8650/20240206-194148
base:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-next
patch link:    https://lore.kernel.org/r/20240206113145.31096-3-quic_jkona%40quicinc.com
patch subject: [PATCH 2/5] clk: qcom: videocc-sm8550: Add support for SM8650 videocc
config: i386-buildonly-randconfig-002-20240207 (https://download.01.org/0day-ci/archive/20240207/202402071128.aZc6BNmF-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240207/202402071128.aZc6BNmF-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402071128.aZc6BNmF-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/clk/qcom/videocc-sm8550.c:570:14: warning: variable 'offset' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
     570 |         } else  if (of_device_is_compatible(pdev->dev.of_node, "qcom,sm8650-videocc")) {
         |                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/clk/qcom/videocc-sm8550.c:590:29: note: uninitialized use occurs here
     590 |         regmap_update_bits(regmap, offset, BIT(0), BIT(0));
         |                                    ^~~~~~
   drivers/clk/qcom/videocc-sm8550.c:570:10: note: remove the 'if' if its condition is always true
     570 |         } else  if (of_device_is_compatible(pdev->dev.of_node, "qcom,sm8650-videocc")) {
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/clk/qcom/videocc-sm8550.c:547:12: note: initialize the variable 'offset' to silence this warning
     547 |         u32 offset;
         |                   ^
         |                    = 0
   1 warning generated.


vim +570 drivers/clk/qcom/videocc-sm8550.c

   542	
   543	static int video_cc_sm8550_probe(struct platform_device *pdev)
   544	{
   545		struct regmap *regmap;
   546		int ret;
   547		u32 offset;
   548	
   549		ret = devm_pm_runtime_enable(&pdev->dev);
   550		if (ret)
   551			return ret;
   552	
   553		ret = pm_runtime_resume_and_get(&pdev->dev);
   554		if (ret)
   555			return ret;
   556	
   557		regmap = qcom_cc_map(pdev, &video_cc_sm8550_desc);
   558		if (IS_ERR(regmap)) {
   559			pm_runtime_put(&pdev->dev);
   560			return PTR_ERR(regmap);
   561		}
   562	
   563		if (of_device_is_compatible(pdev->dev.of_node, "qcom,sm8550-videocc")) {
   564			video_cc_sm8550_clocks[VIDEO_CC_MVS0_SHIFT_CLK] = NULL;
   565			video_cc_sm8550_clocks[VIDEO_CC_MVS0C_SHIFT_CLK] = NULL;
   566			video_cc_sm8550_clocks[VIDEO_CC_MVS1_SHIFT_CLK] = NULL;
   567			video_cc_sm8550_clocks[VIDEO_CC_MVS1C_SHIFT_CLK] = NULL;
   568			video_cc_sm8550_clocks[VIDEO_CC_XO_CLK_SRC] = NULL;
   569			offset = 0x8140;
 > 570		} else  if (of_device_is_compatible(pdev->dev.of_node, "qcom,sm8650-videocc")) {
   571			video_cc_pll0_config.l = 0x1e;
   572			video_cc_pll0_config.alpha = 0xa000;
   573			video_cc_pll1_config.l = 0x2b;
   574			video_cc_pll1_config.alpha = 0xc000;
   575			video_cc_mvs0_clk_src.freq_tbl = ftbl_video_cc_mvs0_clk_src_sm8650;
   576			video_cc_mvs1_clk_src.freq_tbl = ftbl_video_cc_mvs1_clk_src_sm8650;
   577			offset = 0x8150;
   578		}
   579	
   580		clk_lucid_ole_pll_configure(&video_cc_pll0, regmap, &video_cc_pll0_config);
   581		clk_lucid_ole_pll_configure(&video_cc_pll1, regmap, &video_cc_pll1_config);
   582	
   583		/*
   584		 * Keep clocks always enabled:
   585		 *	video_cc_ahb_clk
   586		 *	video_cc_sleep_clk
   587		 *	video_cc_xo_clk
   588		 */
   589		regmap_update_bits(regmap, 0x80f4, BIT(0), BIT(0));
   590		regmap_update_bits(regmap, offset, BIT(0), BIT(0));
   591		regmap_update_bits(regmap, 0x8124, BIT(0), BIT(0));
   592	
   593		ret = qcom_cc_really_probe(pdev, &video_cc_sm8550_desc, regmap);
   594	
   595		pm_runtime_put(&pdev->dev);
   596	
   597		return ret;
   598	}
   599	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

