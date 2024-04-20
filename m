Return-Path: <linux-kernel+bounces-152058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E2928AB825
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 02:36:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44B9B281F4C
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 00:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4FB710E4;
	Sat, 20 Apr 2024 00:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YwIK7d7F"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF30A38F
	for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2024 00:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713573381; cv=none; b=dAai5DuslZKuVE5OI4H7PjxxNwvKggEbxQutNOWjU55O1rjYTIejdwjynl5c+bh3MO5T+78io3JIdpSMuNyYGn5hetGoeKBWgKZqS996aho95xX7ksQphwSEFgd+MKI6OLiQqCunJVhhKPtVR6k+jEf1Aij4Xg54DX2U3LNy5B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713573381; c=relaxed/simple;
	bh=adroiXsVs79FpRa83a3I9kMT/edKYfdAupWkdkWbHbI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NzTqG4t8BgiO4FXytZnpAAdvPenDQphOB5GN3DZNxqjC72xXNacjlOw4KlVgGdo3yc7ew5F7AFmsPaB60aK5HpJx9JV8Skg/73y5UMp5Rs5mpKWppcQnUgEmcEEaV/lmBFuwd9ohoAoZwnLinxG4bceLz9umXurH7tNp3aj9Mno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YwIK7d7F; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713573379; x=1745109379;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=adroiXsVs79FpRa83a3I9kMT/edKYfdAupWkdkWbHbI=;
  b=YwIK7d7FHAURKnF6WCdbIKmkzC2vKqfDsL7fe1ZwFrxVeoI7zXjbuzuv
   BeJ8fPfT8Re4oyTgfyLD6pEVTZtOty+4JLopWXmXdvoTbwJX1aXldfBfi
   CIym1x8AJHteVuEV5ccDaM3QN9TaK4hcmYtxtjACBJQa9Ba7fazMtINei
   V68TGabVdeq4q/iRZSoyCRVhQJnUmlVi/7dxgkSS4R/0xrcyE0xLr4xjV
   w0IAd5Tk7A496+QwSYT2TjYJW3GJsRFcjPZt7Va8eHoclJv3zKISOtlD/
   OZPhgy6HKvpsGvDHa4qLhh5wJ+gVZx9ojD1SnuSiXmuqf7J6k1pogANgH
   w==;
X-CSE-ConnectionGUID: ylYKnTtVTTqpYdo6OGnLOw==
X-CSE-MsgGUID: kOM3WwqmS2erujASpCMI5A==
X-IronPort-AV: E=McAfee;i="6600,9927,11049"; a="9114250"
X-IronPort-AV: E=Sophos;i="6.07,215,1708416000"; 
   d="scan'208";a="9114250"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2024 17:36:18 -0700
X-CSE-ConnectionGUID: B9zqgS3SSeuvqwAywk9lag==
X-CSE-MsgGUID: H/C8eYBvQ3OPqPOd6QmliA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,215,1708416000"; 
   d="scan'208";a="23546753"
Received: from unknown (HELO 23c141fc0fd8) ([10.239.97.151])
  by fmviesa010.fm.intel.com with ESMTP; 19 Apr 2024 17:36:16 -0700
Received: from kbuild by 23c141fc0fd8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rxyiD-000AbM-0u;
	Sat, 20 Apr 2024 00:36:13 +0000
Date: Sat, 20 Apr 2024 08:35:23 +0800
From: kernel test robot <lkp@intel.com>
To: srinivas.kandagatla@linaro.org, broonie@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, perex@perex.cz,
	tiwai@suse.com, lgirdwood@gmail.com, alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org, steev@kali.org,
	jenneron@postmarketos.org,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH 2/4] ASoC: qcom: common: add Display port Jack function
Message-ID: <202404200809.tfVSiQo5-lkp@intel.com>
References: <20240419150140.92527-3-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240419150140.92527-3-srinivas.kandagatla@linaro.org>

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on broonie-sound/for-next]
[also build test WARNING on linus/master v6.9-rc4 next-20240419]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/srinivas-kandagatla-linaro-org/ASoC-qcom-q6dsp-parse-Display-port-tokens/20240419-230514
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next
patch link:    https://lore.kernel.org/r/20240419150140.92527-3-srinivas.kandagatla%40linaro.org
patch subject: [PATCH 2/4] ASoC: qcom: common: add Display port Jack function
config: arm-defconfig (https://download.01.org/0day-ci/archive/20240420/202404200809.tfVSiQo5-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project.git f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240420/202404200809.tfVSiQo5-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404200809.tfVSiQo5-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> sound/soc/qcom/common.c:250:22: warning: unused variable 'cpu_dai' [-Wunused-variable]
           struct snd_soc_dai *cpu_dai = snd_soc_rtd_to_cpu(rtd, 0);
                               ^
   1 warning generated.


vim +/cpu_dai +250 sound/soc/qcom/common.c

   246	
   247	int qcom_snd_dp_jack_setup(struct snd_soc_pcm_runtime *rtd,
   248				   struct snd_soc_jack *hdmi_jack, int hdmi_pcm_id)
   249	{
 > 250		struct snd_soc_dai *cpu_dai = snd_soc_rtd_to_cpu(rtd, 0);

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

