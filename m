Return-Path: <linux-kernel+bounces-120295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA3988D574
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 05:22:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02CBB29FE21
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 04:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D758241EC;
	Wed, 27 Mar 2024 04:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FdOe85eu"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA5A23773;
	Wed, 27 Mar 2024 04:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711513339; cv=none; b=kEcZGltCzEbFFujsfK4FD0DJ+PkMXNPLVhwlKimo5ciNNWPTcI8yC/4dCYiSZ9Hxla+1Er+A9EImmvjP5Ma+avpAklLQZrK0XL5P2sTQftFs2U+zN24MfXGZnBEzPRqrNzj6mzHd6gRbvM9UNuBwgrWMdyA7rZvpbhBQztBuYYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711513339; c=relaxed/simple;
	bh=HTItWPms0pqAtokhHLP7v+ctnR3icIkNDyzsM1SRPxI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WHKWCoxRwpM3AUstcGqiWJV/NN+PhmyHdFeYVNxCrEMvQimuYOxW0cT3S0Mkozndcz1Ml01zOS6alSDzQU+hURsDCwxdeX7ndzX14ZaXDsUovjBVOyHnSL7TsjbsrLVjsnWtKejcaGiN3W74E7Ya66OIDiMPDxPlwBxhG6TBGPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FdOe85eu; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711513337; x=1743049337;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HTItWPms0pqAtokhHLP7v+ctnR3icIkNDyzsM1SRPxI=;
  b=FdOe85euLdWIOv7xDQ+eVNo8u6zvemRufl8utXQV7lAGGR73wm2r6hjl
   zlzgi9NBnTI7IPFc668zyTAvNSN2CDZyvbtsoj65glroM8u3e8Uh0MFrJ
   hdw6eUsraLoNgWJfyLIyDvdZteGPgVT6Uz0QA/je/t6YhD6IaVN3Cit+a
   FuaZ5mzej60lz+oOE2XocwJTgXZYZJirvz/4auYuhVZ+t6XXXxLC3t8Qb
   0Wd41H0rzRYzwXSbIwjNR8qQstVcwZLGgp5WltAfJfd2Q7i144Yizudf6
   vfCypPZL8GKyBdHKTbe/cbQ4mD9syzIh4NSrl80rNyKeqqASUncOHwsFV
   A==;
X-CSE-ConnectionGUID: 8uK4tGYMQHqLEJYVsMy/eA==
X-CSE-MsgGUID: MNTMRv68SdK9+H6FjMX1nQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="6458260"
X-IronPort-AV: E=Sophos;i="6.07,157,1708416000"; 
   d="scan'208";a="6458260"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 21:22:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,157,1708416000"; 
   d="scan'208";a="20892618"
Received: from lkp-server01.sh.intel.com (HELO be39aa325d23) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 26 Mar 2024 21:22:14 -0700
Received: from kbuild by be39aa325d23 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rpKnj-0000kS-0U;
	Wed, 27 Mar 2024 04:22:11 +0000
Date: Wed, 27 Mar 2024 12:21:30 +0800
From: kernel test robot <lkp@intel.com>
To: Gergo Koteles <soyer@irl.hu>, Shenghao Ding <shenghao-ding@ti.com>,
	Kevin Lu <kevin-lu@ti.com>, Baojun Xu <baojun.xu@ti.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org, Gergo Koteles <soyer@irl.hu>,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/3] ALSA: hda/tas2781: remove digital gain kcontrol
Message-ID: <202403271212.5Lxo4b20-lkp@intel.com>
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
config: i386-randconfig-011-20240326 (https://download.01.org/0day-ci/archive/20240327/202403271212.5Lxo4b20-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240327/202403271212.5Lxo4b20-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403271212.5Lxo4b20-lkp@intel.com/

All errors (new ones prefixed by >>):

>> sound/soc/codecs/tas2781-i2c.c:148:27: error: use of undeclared identifier 'dvc_tlv'
     148 |                 tas2781_digital_putvol, dvc_tlv),
         |                                         ^
>> sound/soc/codecs/tas2781-i2c.c:595:19: error: invalid application of 'sizeof' to an incomplete type 'const struct snd_kcontrol_new[]'
     595 |         .num_controls           = ARRAY_SIZE(tas2781_snd_controls),
         |                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/array_size.h:11:32: note: expanded from macro 'ARRAY_SIZE'
      11 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
         |                                ^~~~~
   2 errors generated.


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

