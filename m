Return-Path: <linux-kernel+bounces-50947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E82684842A
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 08:08:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1729528690E
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 07:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2711F495F0;
	Sat,  3 Feb 2024 07:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Btrmv4XQ"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4964B5C1;
	Sat,  3 Feb 2024 07:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706944109; cv=none; b=Kqiq7uNZzBBL7j17q+nlL/NF8Q6Z4AumTi9fv3RkgZVs5vDVmT61UM5y9b/PR3mg3caNILvF3XShGym/rmP0i7F1662/4SgOSXYeVKupYqRai0w84e2fOtF/KmeDcUAqwZOeT08o5tYGdZ7tf7b3ZvNlDu5cgLshmLRZzwQM5zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706944109; c=relaxed/simple;
	bh=QikV9LjfXCKhq110UZUbqz0FYd57gjfWzqI2NfGAlhI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZrX0fUbDGmv5cLaa7/18hGLAdEKkha/Hxyw9GL0I1ANxsXyTIn3w6RL5OXnNQDT/4HiOGvDD8Bv2URxk9U+coyFzDyWj4igeNhg6m5yhfkZ+c420col8asGsSDNVKP4QQ5/x58U+GsnpSKuf5YjSX4ni7taGnd0t10xtNdAHpnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Btrmv4XQ; arc=none smtp.client-ip=192.55.52.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706944106; x=1738480106;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QikV9LjfXCKhq110UZUbqz0FYd57gjfWzqI2NfGAlhI=;
  b=Btrmv4XQaDWLQ1LaQKxFQYKUAJK1rpYAA+Fe1Vd/wtvkNpj2J1I395b5
   diIdn6UzpLT02lDUtWH2jZI/wjMZtvl1bEo1qds2NgQM7L0yZBNHQkV5x
   nMepge98CnsZ8+CQwc70WPRr/WMSK+bh+QUlBDlsBE6yqCvWpbfw4d05/
   URJjDA3waYt3wBBV866FWYVA1/Lo1uQv7XpmUCoxOS68ttnae3Lc5eVFX
   G3TSyuBeJ2jZ6FWBqSMX94F0CklWKD92pE3DpQb6rmUy8qrsa7U4+JH+C
   HN68Iwvg61L9T4as1ciIutfoxRFXa8UTMOkX6UOab75yTCxZm+vJFDBC+
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="435436787"
X-IronPort-AV: E=Sophos;i="6.05,240,1701158400"; 
   d="scan'208";a="435436787"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 23:08:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,240,1701158400"; 
   d="scan'208";a="278653"
Received: from lkp-server02.sh.intel.com (HELO 59f4f4cd5935) ([10.239.97.151])
  by fmviesa010.fm.intel.com with ESMTP; 02 Feb 2024 23:08:22 -0800
Received: from kbuild by 59f4f4cd5935 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rWA8R-0004j8-1p;
	Sat, 03 Feb 2024 07:08:19 +0000
Date: Sat, 3 Feb 2024 15:07:45 +0800
From: kernel test robot <lkp@intel.com>
To: Chris Packham <chris.packham@alliedtelesis.co.nz>,
	alexandre.belloni@bootlin.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	jdelvare@suse.com, linux@roeck-us.net, antoniu.miclaus@analog.com,
	noname.nuno@gmail.com
Cc: oe-kbuild-all@lists.linux.dev, linux-rtc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
	Zeynep Arslanbenzer <Zeynep.Arslanbenzer@analog.com>,
	Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: Re: [PATCH v6 1/2] drivers: rtc: add max313xx series rtc driver
Message-ID: <202402031414.zapkL312-lkp@intel.com>
References: <20240202025241.834283-2-chris.packham@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240202025241.834283-2-chris.packham@alliedtelesis.co.nz>

Hi Chris,

kernel test robot noticed the following build warnings:

[auto build test WARNING on abelloni/rtc-next]
[also build test WARNING on robh/for-next linus/master v6.8-rc2 next-20240202]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Chris-Packham/drivers-rtc-add-max313xx-series-rtc-driver/20240202-105538
base:   https://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git rtc-next
patch link:    https://lore.kernel.org/r/20240202025241.834283-2-chris.packham%40alliedtelesis.co.nz
patch subject: [PATCH v6 1/2] drivers: rtc: add max313xx series rtc driver
config: i386-randconfig-063-20240203 (https://download.01.org/0day-ci/archive/20240203/202402031414.zapkL312-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240203/202402031414.zapkL312-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402031414.zapkL312-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/rtc/rtc-max313xx.c:546:21: sparse: sparse: symbol 'max313xx_nvmem_cfg' was not declared. Should it be static?
>> drivers/rtc/rtc-max313xx.c:656:22: sparse: sparse: symbol 'max313xx_clk_init' was not declared. Should it be static?

vim +/max313xx_nvmem_cfg +546 drivers/rtc/rtc-max313xx.c

   545	
 > 546	struct nvmem_config max313xx_nvmem_cfg = {
   547		.reg_read = max313xx_nvmem_reg_read,
   548		.reg_write = max313xx_nvmem_reg_write,
   549		.word_size = 8,
   550	};
   551	
   552	static unsigned long max313xx_clkout_recalc_rate(struct clk_hw *hw,
   553							 unsigned long parent_rate)
   554	{
   555		struct max313xx *rtc = clk_hw_to_max313xx(hw);
   556		const struct clkout_cfg *clkout = rtc->chip->clkout;
   557		unsigned int freq_mask;
   558		unsigned int reg;
   559		int ret;
   560	
   561		ret = regmap_read(rtc->regmap, clkout->reg, &reg);
   562		if (ret)
   563			return 0;
   564	
   565		freq_mask = __roundup_pow_of_two(clkout->freq_size) - 1;
   566	
   567		return clkout->freq_avail[(reg >> clkout->freq_pos) & freq_mask];
   568	}
   569	
   570	static long max313xx_clkout_round_rate(struct clk_hw *hw, unsigned long rate,
   571					       unsigned long *prate)
   572	{
   573		struct max313xx *rtc = clk_hw_to_max313xx(hw);
   574		struct clkout_cfg *clkout = rtc->chip->clkout;
   575		int index;
   576	
   577		index = find_closest(rate, clkout->freq_avail, clkout->freq_size);
   578		return clkout->freq_avail[index];
   579	}
   580	
   581	static int max313xx_clkout_set_rate(struct clk_hw *hw, unsigned long rate,
   582					    unsigned long parent_rate)
   583	{
   584		struct max313xx *rtc = clk_hw_to_max313xx(hw);
   585		struct clkout_cfg *clkout = rtc->chip->clkout;
   586		unsigned int freq_mask;
   587		int index;
   588	
   589		index = find_closest(rate, clkout->freq_avail, clkout->freq_size);
   590		freq_mask = __roundup_pow_of_two(clkout->freq_size) - 1;
   591	
   592		return regmap_update_bits(rtc->regmap, clkout->reg,
   593					  freq_mask << clkout->freq_pos,
   594					  index << clkout->freq_pos);
   595	}
   596	
   597	static int max313xx_clkout_enable(struct clk_hw *hw)
   598	{
   599		struct max313xx *rtc = clk_hw_to_max313xx(hw);
   600		struct clkout_cfg *clkout = rtc->chip->clkout;
   601	
   602		if (clkout->en_invert)
   603			return regmap_clear_bits(rtc->regmap, clkout->reg,
   604						 clkout->en_bit);
   605	
   606		return regmap_set_bits(rtc->regmap, clkout->reg,  clkout->en_bit);
   607	}
   608	
   609	static void max313xx_clkout_disable(struct clk_hw *hw)
   610	{
   611		struct max313xx *rtc = clk_hw_to_max313xx(hw);
   612		struct clkout_cfg *clkout = rtc->chip->clkout;
   613	
   614		switch (rtc->id) {
   615		case ID_MAX31331:
   616		case ID_MAX31334:
   617			if (rtc->irq > 0) {
   618				dev_err(rtc->rtc->dev.parent,
   619					"clkout cannot be disabled when IRQ is requested");
   620				return;
   621			}
   622			break;
   623		default:
   624			break;
   625		}
   626	
   627		if (clkout->en_invert)
   628			regmap_set_bits(rtc->regmap, clkout->reg, clkout->en_bit);
   629		else
   630			regmap_clear_bits(rtc->regmap, clkout->reg,  clkout->en_bit);
   631	}
   632	
   633	static int max313xx_clkout_is_enabled(struct clk_hw *hw)
   634	{
   635		struct max313xx *rtc = clk_hw_to_max313xx(hw);
   636		struct clkout_cfg *clkout = rtc->chip->clkout;
   637		unsigned int reg;
   638		int ret;
   639	
   640		ret = regmap_read(rtc->regmap, clkout->reg, &reg);
   641		if (ret)
   642			return ret;
   643	
   644		return !!(reg & clkout->en_bit) ^ clkout->en_invert;
   645	}
   646	
   647	static const struct clk_ops max313xx_clkout_ops = {
   648		.recalc_rate = max313xx_clkout_recalc_rate,
   649		.round_rate = max313xx_clkout_round_rate,
   650		.set_rate = max313xx_clkout_set_rate,
   651		.enable = max313xx_clkout_enable,
   652		.disable = max313xx_clkout_disable,
   653		.is_enabled = max313xx_clkout_is_enabled,
   654	};
   655	
 > 656	struct clk_init_data max313xx_clk_init = {
   657		.name = "max313xx-clkout",
   658		.ops = &max313xx_clkout_ops,
   659	};
   660	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

