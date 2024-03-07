Return-Path: <linux-kernel+bounces-95062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2693C8748C4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 08:36:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4D702857D6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 07:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE9EB6312E;
	Thu,  7 Mar 2024 07:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ezLrdMp1"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D585B5CD;
	Thu,  7 Mar 2024 07:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709796955; cv=none; b=ZX2plos/p3aCh/oSeeXz+fy3jM06hN9Nao0HQyhIduh5u0vBeMh+M3xSWWhRLdAJ12fZr4WpmK8y9I2daqfek6MTNgktV7gJqzuV5NW86DajgDnLhopXyyrx/wWbUtxMhc4QzYpcObxhMjFNMGksKhYNPWt1nIUt19sjaptTUOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709796955; c=relaxed/simple;
	bh=O6r2yIkqMTx2clPrK+gabO6lpARf5VJGxJDcdwImDKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YVSbGBzCH5Ww2embHNOgQY7zA4rekzoL0LUrVs2GywfvQFgvBeaB+z/mfXLjRbKm2R35AwJS/3/7rIhVjPDiddK/n951uOfT3Ve77Qlbd3wVdvEMqr/AkVQy8etMO0VX/8U0Jqhoc57h9qoFgBOA6V9zdMneJzpSDYn8ZKA7J4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ezLrdMp1; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709796954; x=1741332954;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=O6r2yIkqMTx2clPrK+gabO6lpARf5VJGxJDcdwImDKY=;
  b=ezLrdMp1FKCLpUSxwzRz99cMnnrL4GjhevbatG11BHEeCc57Tyuj3EiE
   3TUFTCJGGEbGJ4NvhBTYzrO+qHBHMcXhY5+fTXoBsRUYiN9yQtK9OguLg
   9f/VGmOnf79KDfTv3vEp9CN7v0oG79MfMaQ4QSU1fWJuVHT4m2mLUzMv5
   3bLmNwq31MiRGN/8zOTVD2GC7tHwGi4s9MUa2J2vyN5uRhmj4vf+9jyg+
   eAmIZs6ctVqEnAevwG/dRuQJ3BwuNP540yqGYfafAJ54l45xaptie8pj3
   WbFHjSrTiezZ/5Al65dgOb0Lk1SOJBpyRWkJNZIUTxH9F2Ppwv4D07i4D
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11005"; a="4334678"
X-IronPort-AV: E=Sophos;i="6.06,210,1705392000"; 
   d="scan'208";a="4334678"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2024 23:35:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,210,1705392000"; 
   d="scan'208";a="10189893"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 06 Mar 2024 23:35:48 -0800
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ri8I6-0004x5-0u;
	Thu, 07 Mar 2024 07:35:46 +0000
Date: Thu, 7 Mar 2024 15:35:14 +0800
From: kernel test robot <lkp@intel.com>
To: Chancel Liu <chancel.liu@nxp.com>, shengjiu.wang@gmail.com,
	Xiubo.Lee@gmail.com, festevam@gmail.com, nicoleotsuka@gmail.com,
	lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
	tiwai@suse.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
	kernel@pengutronix.de, linux-imx@nxp.com,
	alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: oe-kbuild-all@lists.linux.dev, Chancel Liu <chancel.liu@nxp.com>
Subject: Re: [PATCH 3/4] ASoC: fsl: Let imx-audio-rpmsg register platform
 device for card
Message-ID: <202403071501.Bo3vcFpu-lkp@intel.com>
References: <20240306075510.535963-4-chancel.liu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240306075510.535963-4-chancel.liu@nxp.com>

Hi Chancel,

kernel test robot noticed the following build errors:

[auto build test ERROR on shawnguo/for-next]
[also build test ERROR on broonie-sound/for-next linus/master v6.8-rc7 next-20240306]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Chancel-Liu/ASoC-fsl-imx_pcm_rpmsg-Register-component-with-rpmsg-channel-name/20240306-155945
base:   https://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git for-next
patch link:    https://lore.kernel.org/r/20240306075510.535963-4-chancel.liu%40nxp.com
patch subject: [PATCH 3/4] ASoC: fsl: Let imx-audio-rpmsg register platform device for card
config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20240307/202403071501.Bo3vcFpu-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240307/202403071501.Bo3vcFpu-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403071501.Bo3vcFpu-lkp@intel.com/

All errors (new ones prefixed by >>):

   sound/soc/fsl/imx-audio-rpmsg.c: In function 'imx_audio_rpmsg_probe':
>> sound/soc/fsl/imx-audio-rpmsg.c:107:17: error: label 'fail' used but not defined
     107 |                 goto fail;
         |                 ^~~~


vim +/fail +107 sound/soc/fsl/imx-audio-rpmsg.c

    74	
    75	static int imx_audio_rpmsg_probe(struct rpmsg_device *rpdev)
    76	{
    77		struct imx_audio_rpmsg *data;
    78		int ret = 0;
    79	
    80		dev_info(&rpdev->dev, "new channel: 0x%x -> 0x%x!\n",
    81			 rpdev->src, rpdev->dst);
    82	
    83		data = devm_kzalloc(&rpdev->dev, sizeof(*data), GFP_KERNEL);
    84		if (!data)
    85			return -ENOMEM;
    86	
    87		dev_set_drvdata(&rpdev->dev, data);
    88	
    89		/* Register platform driver for rpmsg routine */
    90		data->rpmsg_pdev = platform_device_register_data(&rpdev->dev,
    91								 rpdev->id.name,
    92								 PLATFORM_DEVID_NONE,
    93								 NULL, 0);
    94		if (IS_ERR(data->rpmsg_pdev)) {
    95			dev_err(&rpdev->dev, "failed to register rpmsg platform.\n");
    96			ret = PTR_ERR(data->rpmsg_pdev);
    97		}
    98	
    99		data->card_pdev = platform_device_register_data(&rpdev->dev,
   100								"imx-audio-rpmsg",
   101								PLATFORM_DEVID_AUTO,
   102								rpdev->id.name,
   103								strlen(rpdev->id.name));
   104		if (IS_ERR(data->card_pdev)) {
   105			dev_err(&rpdev->dev, "failed to register rpmsg card.\n");
   106			ret = PTR_ERR(data->card_pdev);
 > 107			goto fail;
   108		}
   109	
   110		return ret;
   111	}
   112	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

