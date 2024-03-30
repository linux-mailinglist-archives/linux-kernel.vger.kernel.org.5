Return-Path: <linux-kernel+bounces-125591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A87AD892920
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 04:58:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E725283587
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 03:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B76A7847B;
	Sat, 30 Mar 2024 03:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Emfy5Sqo"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363A81FA5;
	Sat, 30 Mar 2024 03:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711771105; cv=none; b=D2PdiZ/09NEE8cGVeYaLKwoto5aEQcqaLiH0K3zG9aSRDicNdfTR9Y4Wu1p0DSI/Yuf7M6W6cdSHce09pCvQyV7Q4opTnfnjM5EsSHx/9mn5D5JuEG/ROD6TNmjR5XuNqODX8xBvFUJscGY79+kQ8M6sGWpX3ls/bfkTlxBdJfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711771105; c=relaxed/simple;
	bh=+1r0KuPuLBo2r548nWnxoAcgxrG2gmAGvuQwZou/czA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kwq2obNbkGGvNfdoVg1gaKR/vHN/hmaq8/zNIMcqUBK//IzeYDU/HyROUFlRC60YBvnMlbV4jVc8NNN2h28eKMusY3smJ9MXnAItUF9WE+b+vS689CwTVwwLIT+f9o46ZVbkPokRsQWvYtvsrmK9T9gNj8OsPcrzO/An8T/t1+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Emfy5Sqo; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711771102; x=1743307102;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+1r0KuPuLBo2r548nWnxoAcgxrG2gmAGvuQwZou/czA=;
  b=Emfy5SqoQSrjQrk8Qkp3SjXVExlOrmi0YaPbnXG8tzKV8EcgbLU0teLY
   /SozqdZqJnYcRHTKyiNzx3nOx6sfk3o7z1jH3fHPpoPBHXsbGppbm8GKh
   CULIaFUkybhVvzNDJ0sXWjfZqrW+bCBUlxsD/ednK1r0yKN3sGpt6oQak
   GxUSsEBsR8i/10y4Ps8qNpjuIwbjimDPqyV3vYjngO1jLgiUty0xeyUHT
   2IYIHfmcLLF/OvpEkUPFQ/hRMGJumKP9z8jzyC36eeJo/jk3v7ixV1S46
   ojXxNXa4gCoAEuhPXStfv88qXq5/uqt+lowp/TN8nwQjiUilKtOkCoSGE
   Q==;
X-CSE-ConnectionGUID: WFS1oBizQ4ugaK52YWbJCQ==
X-CSE-MsgGUID: h3+y6xDfRDOMG1vTJ2hBRg==
X-IronPort-AV: E=McAfee;i="6600,9927,11028"; a="32370308"
X-IronPort-AV: E=Sophos;i="6.07,166,1708416000"; 
   d="scan'208";a="32370308"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2024 20:58:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,166,1708416000"; 
   d="scan'208";a="17213261"
Received: from lkp-server01.sh.intel.com (HELO be39aa325d23) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 29 Mar 2024 20:58:18 -0700
Received: from kbuild by be39aa325d23 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rqPrD-0003vk-37;
	Sat, 30 Mar 2024 03:58:15 +0000
Date: Sat, 30 Mar 2024 11:57:34 +0800
From: kernel test robot <lkp@intel.com>
To: Richard Zhu <hongxing.zhu@nxp.com>, vkoul@kernel.org, kishon@kernel.org,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, frank.li@nxp.com
Cc: oe-kbuild-all@lists.linux.dev, hongxing.zhu@nxp.com,
	linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel@pengutronix.de, linux-imx@nxp.com
Subject: Re: [PATCH v1 3/3] phy: freescale: imx8q-hsio: Add i.MX8Q HSIO PHY
 driver support
Message-ID: <202403301157.mPlhQUdz-lkp@intel.com>
References: <1711699790-16494-4-git-send-email-hongxing.zhu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1711699790-16494-4-git-send-email-hongxing.zhu@nxp.com>

Hi Richard,

kernel test robot noticed the following build errors:

[auto build test ERROR on robh/for-next]
[also build test ERROR on linus/master v6.9-rc1 next-20240328]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Richard-Zhu/dt-bindings-phy-Add-i-MX8Q-HSIO-SerDes-PHY-binding/20240329-162937
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/1711699790-16494-4-git-send-email-hongxing.zhu%40nxp.com
patch subject: [PATCH v1 3/3] phy: freescale: imx8q-hsio: Add i.MX8Q HSIO PHY driver support
config: powerpc64-randconfig-r062-20240330 (https://download.01.org/0day-ci/archive/20240330/202403301157.mPlhQUdz-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project 79ba323bdd0843275019e16b6e9b35133677c514)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240330/202403301157.mPlhQUdz-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403301157.mPlhQUdz-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/phy/freescale/phy-fsl-imx8q-hsio.c:8:
   In file included from include/linux/io.h:13:
   In file included from arch/powerpc/include/asm/io.h:24:
   In file included from include/linux/mm.h:2208:
   include/linux/vmstat.h:522:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     522 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
>> drivers/phy/freescale/phy-fsl-imx8q-hsio.c:367:8: error: call to undeclared function 'FIELD_PREP'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     367 |         val = FIELD_PREP(MODE_MASK, val);
         |               ^
   1 warning and 1 error generated.


vim +/FIELD_PREP +367 drivers/phy/freescale/phy-fsl-imx8q-hsio.c

   355	
   356	static int imx8q_hsio_set_mode(struct phy *phy, enum phy_mode mode,
   357					   int submode)
   358	{
   359		u32 val;
   360		struct imx8q_hsio_lane *lane = phy_get_drvdata(phy);
   361		struct imx8q_hsio_priv *priv = lane->priv;
   362	
   363		if (lane->lane_mode != mode)
   364			return -EINVAL;
   365	
   366		val = (mode == PHY_MODE_PCIE) ? MODE_PCIE : MODE_SATA;
 > 367		val = FIELD_PREP(MODE_MASK, val);
   368		regmap_update_bits(priv->phy, lane->phy_off + CTRL0, MODE_MASK, val);
   369	
   370		switch (submode) {
   371		case PHY_MODE_PCIE_RC:
   372			val = FIELD_PREP(DEVICE_TYPE_MASK, PCI_EXP_TYPE_ROOT_PORT);
   373			break;
   374		case PHY_MODE_PCIE_EP:
   375			val = FIELD_PREP(DEVICE_TYPE_MASK, PCI_EXP_TYPE_ENDPOINT);
   376			break;
   377		default: /* Support only PCIe EP and RC now. */
   378			return 0;
   379		}
   380		if (submode)
   381			regmap_update_bits(priv->ctrl, lane->ctrl_off + CTRL0,
   382					   DEVICE_TYPE_MASK, val);
   383	
   384		return 0;
   385	}
   386	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

