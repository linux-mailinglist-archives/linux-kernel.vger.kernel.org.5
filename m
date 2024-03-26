Return-Path: <linux-kernel+bounces-119023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D934B88C2CE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 13:59:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 797CD1F645EF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 12:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E0191EB56;
	Tue, 26 Mar 2024 12:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HgczrhOE"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6DE5C8FF;
	Tue, 26 Mar 2024 12:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711457932; cv=none; b=I4TiyjcVM7YI2jsS3TKc6n2epd8GFcCRx/Ncwvzs7KusQmBzRzsGGjVP9bydmNpFswNBF3S4ioLPNfBGBHtqkZS41JGnc4mr3FrDZGH51zY3aFXTl4TPIHLZc9MhEZZXgJMnaDLJgWcrzsR6fbDOtAutQyN6zwR4cySaJVfRg1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711457932; c=relaxed/simple;
	bh=MtfhUEPPdvxqzOoAPyYQzVuPsUOh0otfavoqH+DBvNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UuYMabMNBX+DbD6iIY60go57zOaAXUT51wTyaxcxJWfBlNECvNuTBVtyFYT4SKtxEA8jOSRraMAGW4eoeTlakvsXYNM1kbQ22nglpAgbOAAfe97NN3PXheBad61NzY/1tYcnNhZVc1yU7qaUGWgUFgADFHVSTv4cw+vd36kUC88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HgczrhOE; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711457931; x=1742993931;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MtfhUEPPdvxqzOoAPyYQzVuPsUOh0otfavoqH+DBvNY=;
  b=HgczrhOEpGXNqmsakg/SLY84LWY2aMh438b4xSHF03g26JTY7hen7SgO
   sQR/q5ck1pR95IBLDWhWpA1XNYbYFzY7WIGH/gbqDYh+J4mkrnVvEtMoR
   CxRlBtZftEb1yTbEFvVNX70x6ZbkoMoQEU/S0uWzYBrvEKpeYew3NRQl2
   uhdEaVXa33gzfPxzdMSui2hpuwnPLoGLobeJB3z9S0MvGMNQhV8kdEK7V
   mT2NLwvzhodB66OrsrpoTpzApDDMCX5fzHhSNNbEcpRHBcQ594Jza3K0s
   AK93iJtNk3kxD8Z7nw3P6OrTHfGBtwZb4SB/PtfI0M1w8UVJdKCRZiPxF
   w==;
X-CSE-ConnectionGUID: RK+MHI/cTEK2XpodvZouBw==
X-CSE-MsgGUID: HZ+/je3iTeGFH5McCr62nQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11024"; a="6717075"
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="6717075"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 05:58:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="46972395"
Received: from lkp-server01.sh.intel.com (HELO be39aa325d23) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 26 Mar 2024 05:58:47 -0700
Received: from kbuild by be39aa325d23 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rp6O4-00003Q-2A;
	Tue, 26 Mar 2024 12:58:44 +0000
Date: Tue, 26 Mar 2024 20:58:27 +0800
From: kernel test robot <lkp@intel.com>
To: Gergo Koteles <soyer@irl.hu>, Shenghao Ding <shenghao-ding@ti.com>,
	Kevin Lu <kevin-lu@ti.com>, Baojun Xu <baojun.xu@ti.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: oe-kbuild-all@lists.linux.dev, alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	Gergo Koteles <soyer@irl.hu>, stable@vger.kernel.org
Subject: Re: [PATCH 1/3] ALSA: hda/tas2781: remove digital gain kcontrol
Message-ID: <202403262031.SxBP17EM-lkp@intel.com>
References: <313e00499eb2caadd23a92284fdec418b650b7f4.1711401621.git.soyer@irl.hu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <313e00499eb2caadd23a92284fdec418b650b7f4.1711401621.git.soyer@irl.hu>

Hi Gergo,

kernel test robot noticed the following build errors:

[auto build test ERROR on 4cece764965020c22cff7665b18a012006359095]

url:    https://github.com/intel-lab-lkp/linux/commits/Gergo-Koteles/ALSA-hda-tas2781-remove-digital-gain-kcontrol/20240326-052937
base:   4cece764965020c22cff7665b18a012006359095
patch link:    https://lore.kernel.org/r/313e00499eb2caadd23a92284fdec418b650b7f4.1711401621.git.soyer%40irl.hu
patch subject: [PATCH 1/3] ALSA: hda/tas2781: remove digital gain kcontrol
config: i386-buildonly-randconfig-004-20240326 (https://download.01.org/0day-ci/archive/20240326/202403262031.SxBP17EM-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240326/202403262031.SxBP17EM-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403262031.SxBP17EM-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from sound/soc/codecs/tas2781-i2c.c:29:
>> sound/soc/codecs/tas2781-i2c.c:148:41: error: 'dvc_tlv' undeclared here (not in a function)
     148 |                 tas2781_digital_putvol, dvc_tlv),
         |                                         ^~~~~~~
   include/sound/soc.h:271:19: note: in definition of macro 'SOC_SINGLE_RANGE_EXT_TLV'
     271 |         .tlv.p = (tlv_array), \
         |                   ^~~~~~~~~


vim +/dvc_tlv +148 sound/soc/codecs/tas2781-i2c.c

ef3bcde75d06d6 Shenghao Ding 2023-06-18  141  
ef3bcde75d06d6 Shenghao Ding 2023-06-18  142  static const struct snd_kcontrol_new tas2781_snd_controls[] = {
ef3bcde75d06d6 Shenghao Ding 2023-06-18  143  	SOC_SINGLE_RANGE_EXT_TLV("Speaker Analog Gain", TAS2781_AMP_LEVEL,
ef3bcde75d06d6 Shenghao Ding 2023-06-18  144  		1, 0, 20, 0, tas2781_amp_getvol,
ef3bcde75d06d6 Shenghao Ding 2023-06-18  145  		tas2781_amp_putvol, amp_vol_tlv),
ef3bcde75d06d6 Shenghao Ding 2023-06-18  146  	SOC_SINGLE_RANGE_EXT_TLV("Speaker Digital Gain", TAS2781_DVC_LVL,
ef3bcde75d06d6 Shenghao Ding 2023-06-18  147  		0, 0, 200, 1, tas2781_digital_getvol,
ef3bcde75d06d6 Shenghao Ding 2023-06-18 @148  		tas2781_digital_putvol, dvc_tlv),
ef3bcde75d06d6 Shenghao Ding 2023-06-18  149  	SOC_SINGLE_BOOL_EXT("Speaker Force Firmware Load", 0,
ef3bcde75d06d6 Shenghao Ding 2023-06-18  150  		tas2781_force_fwload_get, tas2781_force_fwload_put),
ef3bcde75d06d6 Shenghao Ding 2023-06-18  151  };
ef3bcde75d06d6 Shenghao Ding 2023-06-18  152  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

