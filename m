Return-Path: <linux-kernel+bounces-125555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 346E789287C
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 01:51:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CFF31C21060
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 00:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CC4B15A5;
	Sat, 30 Mar 2024 00:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="haU03qxE"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 060EE7E2;
	Sat, 30 Mar 2024 00:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711759879; cv=none; b=rPLTkdSkkXYbTSIShxKWdMNnyvp7KyrgQxfNcPNGv6KM1F/gY5vvg0zzzIR3QamP/WHrKiL3A7Tppt81O0U9z3/eh0oVXg7F4TN0uNruyxUbo7UiGwUa9HMcGsk+NwLtjdrJ1UeKXLZmlwYaWTTiMzFpyUTv6sRWdCTUqqrFH2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711759879; c=relaxed/simple;
	bh=ODnfLfkBj5ljw1xXMK6fJA76YDJnmnHivymq9LFP4Do=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=obLzZrNXTXy3/0YJaRQl4spVflMxVlBp0mn74NIkvVnlpOwtF1R+pJ3YJ34oRuPBi+1l1mEzWBgW9SE25LUDMOkjxlkFUEgxeDFe5aITaFbXRrA7R6CPd35xeLS0C/8XBKg5cRqLMVK6q5bDmy572HEfccE+QC48QYaomFxZnAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=haU03qxE; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711759878; x=1743295878;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ODnfLfkBj5ljw1xXMK6fJA76YDJnmnHivymq9LFP4Do=;
  b=haU03qxE+o1z+PhWJnhJVzm99N6zw/sPmZyTcBr4rfZaEO+IQdnQStx1
   P43e9UDvx93mM1Y0CCeWY8rJMd6+igrUMGODlEXYQ1BhJVYb8FbdTToPn
   bo1PuB6r8K44XiWJ19BGVz45qcGeZpL0GUiiVnA1qg0LCcgWqL+3HvIVa
   Dj56YLzLgt3OoXIl6Dch1X0rhPXZuJRSGaTEuFRjZJHpCRb92fFkuGjlN
   umNwIS/Z+qDpaaIoGHgO4zomPbYnujGHaUuwDwqq6W9KPlNvFdN+LaQXR
   //o8dSV7BgIdQebiVMg/UuuIAQpyNidm+KwNDG90nMt99KZPcx84n86Vh
   A==;
X-CSE-ConnectionGUID: M+Ui7euPR7ayiazuMSgrfg==
X-CSE-MsgGUID: lZYH3KpHRHyRTFJIfEdXfg==
X-IronPort-AV: E=McAfee;i="6600,9927,11028"; a="6893849"
X-IronPort-AV: E=Sophos;i="6.07,166,1708416000"; 
   d="scan'208";a="6893849"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2024 17:51:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,166,1708416000"; 
   d="scan'208";a="16950694"
Received: from lkp-server01.sh.intel.com (HELO be39aa325d23) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 29 Mar 2024 17:51:14 -0700
Received: from kbuild by be39aa325d23 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rqMwB-0003ny-14;
	Sat, 30 Mar 2024 00:51:11 +0000
Date: Sat, 30 Mar 2024 08:51:08 +0800
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
Message-ID: <202403300825.mjcHpoRu-lkp@intel.com>
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
config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20240330/202403300825.mjcHpoRu-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240330/202403300825.mjcHpoRu-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403300825.mjcHpoRu-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/phy/freescale/phy-fsl-imx8q-hsio.c: In function 'imx8q_hsio_set_mode':
>> drivers/phy/freescale/phy-fsl-imx8q-hsio.c:367:15: error: implicit declaration of function 'FIELD_PREP' [-Werror=implicit-function-declaration]
     367 |         val = FIELD_PREP(MODE_MASK, val);
         |               ^~~~~~~~~~
   cc1: some warnings being treated as errors


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

