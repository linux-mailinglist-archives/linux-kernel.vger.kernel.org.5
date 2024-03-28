Return-Path: <linux-kernel+bounces-122858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92A0C88FE81
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 13:01:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 335391F25910
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 12:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDFDD7F471;
	Thu, 28 Mar 2024 12:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L10tab9S"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE797E58F;
	Thu, 28 Mar 2024 12:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711627278; cv=none; b=NUFfEWX9r/AKf/mqcASCBR9MWxQD9KFlwATJ4gOtxs2tAvTOdXnP3f8ZAbbJk2S/ZsE3osVCK7w3DZqkSrMvp6GrSB0FHlb8IC8HPL6Crb+Uj/U2mvhWF+tjTKE7hhso1Nfzt+jFIE9HhqaWR5EModKWJUAa4tUZFt2EZXaHjHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711627278; c=relaxed/simple;
	bh=PeT1k7HFtdibwwcfqd/4kcbln3gTsY92u2mVuYqFY74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eKqmDVUZj3jyy3ZKdJq//auBV9/8Ok2C+wdMGBInI+aVZ3UkHSYdRwEWb87QrfRFQw5kzp0hDeytqp/ozjveIY1PepRf64qUumI1rh7gCV9593QmZdTvNVPmAEYF0OtZIHhRKjOJMIKtc1vOMHZmGiI1+QoFxP+f0sh9i4w0knc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L10tab9S; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711627276; x=1743163276;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PeT1k7HFtdibwwcfqd/4kcbln3gTsY92u2mVuYqFY74=;
  b=L10tab9S8OyKP5W7Oim6irs6a3t5WG4z6fXzvg4V67YNZ9g/PK8tVWfo
   /GwEDPDUEUyggIYOfsttfvm9YXS51t3wS/4Y+VQIpJhU+sh4w7WOB+ymN
   4UWstQK4sge3rHveu5h1X/5o4VbyMRM49FNU7f4Wa6a3mdonNQLFWtIZE
   cd3C1s8/hHLDrCWaqIZoWynzQ0vRO0xjm/OsjlVTKQEPdoBeK/QnbZ5gr
   aBYIUVQWEUP+LkGQhVJC4uqzD2YQRRvtgIdydBzVg1R1V7twTCJYHfPSs
   sfcEg3DKYE4gqLOZIPnYOhlFlDc8d03iVfrMNW/ptzN+OuFc3tIgrJ5RU
   Q==;
X-CSE-ConnectionGUID: Qsij62tdSgiYkllHeqsHUg==
X-CSE-MsgGUID: rFRiWotlST+9mNgV1lm3sw==
X-IronPort-AV: E=McAfee;i="6600,9927,11026"; a="17502925"
X-IronPort-AV: E=Sophos;i="6.07,161,1708416000"; 
   d="scan'208";a="17502925"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2024 05:01:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,161,1708416000"; 
   d="scan'208";a="16556261"
Received: from lkp-server01.sh.intel.com (HELO be39aa325d23) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 28 Mar 2024 05:01:07 -0700
Received: from kbuild by be39aa325d23 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rpoRM-00026y-0v;
	Thu, 28 Mar 2024 12:01:04 +0000
Date: Thu, 28 Mar 2024 20:00:39 +0800
From: kernel test robot <lkp@intel.com>
To: Richard Fitzgerald <rf@opensource.cirrus.com>, broonie@kernel.org,
	tiwai@suse.com
Cc: oe-kbuild-all@lists.linux.dev, linux-sound@vger.kernel.org,
	alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
	patches@opensource.cirrus.com,
	Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: Re: [PATCH 3/3] ASoC: soc-card: Add KUnit test case for
 snd_soc_card_get_kcontrol
Message-ID: <202403281952.Sz5iE5Tm-lkp@intel.com>
References: <20240325125650.213913-4-rf@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240325125650.213913-4-rf@opensource.cirrus.com>

Hi Richard,

kernel test robot noticed the following build errors:

[auto build test ERROR on broonie-sound/for-next]
[also build test ERROR on tiwai-sound/for-next tiwai-sound/for-linus linus/master v6.9-rc1 next-20240328]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Richard-Fitzgerald/ALSA-control-Introduce-snd_ctl_find_id_mixer_locked/20240325-210026
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next
patch link:    https://lore.kernel.org/r/20240325125650.213913-4-rf%40opensource.cirrus.com
patch subject: [PATCH 3/3] ASoC: soc-card: Add KUnit test case for snd_soc_card_get_kcontrol
config: powerpc-randconfig-r081-20240328 (https://download.01.org/0day-ci/archive/20240328/202403281952.Sz5iE5Tm-lkp@intel.com/config)
compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project.git 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240328/202403281952.Sz5iE5Tm-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403281952.Sz5iE5Tm-lkp@intel.com/

All errors (new ones prefixed by >>):

>> sound/soc/soc-card-test.c:24:13: error: initializer element is not a compile-time constant
           SOC_SINGLE(test_control_names[0], SND_SOC_NOPM, 0, 1, 0),
                      ^~~~~~~~~~~~~~~~~~~~~
   include/sound/soc.h:61:48: note: expanded from macro 'SOC_SINGLE'
   {       .iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
                                                        ^~~~~
   1 error generated.


vim +24 sound/soc/soc-card-test.c

    22	
    23	static const struct snd_kcontrol_new test_card_controls[] = {
  > 24		SOC_SINGLE(test_control_names[0], SND_SOC_NOPM, 0, 1, 0),
    25		SOC_SINGLE(test_control_names[1], SND_SOC_NOPM, 1, 1, 0),
    26		SOC_SINGLE(test_control_names[2], SND_SOC_NOPM, 2, 1, 0),
    27		SOC_SINGLE(test_control_names[3], SND_SOC_NOPM, 3, 1, 0),
    28		SOC_SINGLE(test_control_names[4], SND_SOC_NOPM, 4, 1, 0),
    29		SOC_SINGLE(test_control_names[5], SND_SOC_NOPM, 5, 1, 0),
    30		SOC_SINGLE(test_control_names[6], SND_SOC_NOPM, 6, 1, 0),
    31		SOC_SINGLE(test_control_names[7], SND_SOC_NOPM, 7, 1, 0),
    32		SOC_SINGLE(test_control_names[8], SND_SOC_NOPM, 8, 1, 0),
    33		SOC_SINGLE(test_control_names[9], SND_SOC_NOPM, 9, 1, 0),
    34		SOC_SINGLE(test_control_names[10], SND_SOC_NOPM, 10, 1, 0),
    35		SOC_SINGLE(test_control_names[11], SND_SOC_NOPM, 11, 1, 0),
    36	};
    37	static_assert(ARRAY_SIZE(test_control_names) == ARRAY_SIZE(test_card_controls));
    38	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

