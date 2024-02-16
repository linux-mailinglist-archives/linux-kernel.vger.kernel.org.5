Return-Path: <linux-kernel+bounces-68625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 803BB857D60
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 14:13:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA710B2494B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 13:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C47C0129A6F;
	Fri, 16 Feb 2024 13:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GS5BaKqN"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238907869A;
	Fri, 16 Feb 2024 13:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708089185; cv=none; b=swTmDZRqkcV9o07xxGUadmobnCA24BpKVtDbbDauhlBFq7U7x0v51GofwPMF+N+bt8LTjTUiteJl+zVLdejHKLc4HZ4i2qABNrGlI94WelVlRWDrA3+Gx6T3GYAe6rT2wnhrGa2wLHzvAdmZ43oZ64fIE98zjDqvoTNQHMvcBPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708089185; c=relaxed/simple;
	bh=w7PxYeL2YJi5lLDMuxgVxDRatSZggnbIIYFFi/StyVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rqjVew5IFDNVP5NQn31cOn71skeiHDxChDXH1O+It5hVc2k66oEx+p6k43fkXspmEou4IF1cMwm5ReRz9Us4ef49uQ0M0r019c3/dPasgU9HgxVWaDS2uHFuIzQ62I3Qk7IDj+aiF34ku+C1QnghF9GfzuIH2mq7Mjn92BpxgwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GS5BaKqN; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708089183; x=1739625183;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=w7PxYeL2YJi5lLDMuxgVxDRatSZggnbIIYFFi/StyVM=;
  b=GS5BaKqNgsQIZ3t5w+TgaKFsz651czMeXfIT6oy62qz1QijaP3uG9a/3
   VxM8uM8zfL6nHDFhw1M24m7DdsHTPkhHQeIm1n63y+DZdqMl6Hxq7InUW
   EFsAWI96wnhMrMzgWRH+vSLOsL2VRDimknejCPqMkFAHlVkCVNXhPmfu5
   t23qNgPfOlsUY1rPF+wmf5gbnlyD8ORBXzErLvKaDB6jVj1x3CGL2YGTK
   JtdVCpb8ZeWCI6bunxtbAa5oNpBTn5k2sNiB+1C+Q885pamSchC4CIRFL
   WWE7Df8uAjbYvMTruSqqX07hXei2iR+WGyItGn1q75vQeV7UW2kZ6/TTt
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10985"; a="2083623"
X-IronPort-AV: E=Sophos;i="6.06,164,1705392000"; 
   d="scan'208";a="2083623"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 05:13:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,164,1705392000"; 
   d="scan'208";a="3801537"
Received: from lkp-server02.sh.intel.com (HELO 3c78fa4d504c) ([10.239.97.151])
  by fmviesa009.fm.intel.com with ESMTP; 16 Feb 2024 05:12:58 -0800
Received: from kbuild by 3c78fa4d504c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ray1N-0001IA-17;
	Fri, 16 Feb 2024 13:12:54 +0000
Date: Fri, 16 Feb 2024 21:12:06 +0800
From: kernel test robot <lkp@intel.com>
To: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Yannick Fertre <yannick.fertre@foss.st.com>,
	Philippe Cornu <philippe.cornu@foss.st.com>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: oe-kbuild-all@lists.linux.dev, dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
Subject: Re: [PATCH v5 2/3] drm/stm: lvds: add new STM32 LVDS Display
 Interface Transmitter driver
Message-ID: <202402162038.HP7VzIHX-lkp@intel.com>
References: <20240206-lvds-v5-2-bd16797b0f09@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240206-lvds-v5-2-bd16797b0f09@foss.st.com>

Hi Raphael,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bb3bc3eac316b7c388733e625cc2343131b69dee]

url:    https://github.com/intel-lab-lkp/linux/commits/Raphael-Gallais-Pou/dt-bindings-display-add-STM32-LVDS-device/20240206-194740
base:   bb3bc3eac316b7c388733e625cc2343131b69dee
patch link:    https://lore.kernel.org/r/20240206-lvds-v5-2-bd16797b0f09%40foss.st.com
patch subject: [PATCH v5 2/3] drm/stm: lvds: add new STM32 LVDS Display Interface Transmitter driver
config: arm-randconfig-r132-20240214 (https://download.01.org/0day-ci/archive/20240216/202402162038.HP7VzIHX-lkp@intel.com/config)
compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project.git 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)
reproduce: (https://download.01.org/0day-ci/archive/20240216/202402162038.HP7VzIHX-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402162038.HP7VzIHX-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/gpu/drm/stm/lvds.c:318:17: sparse: sparse: symbol 'lvds_bitmap_jeida_rgb888' was not declared. Should it be static?
>> drivers/gpu/drm/stm/lvds.c:335:17: sparse: sparse: symbol 'lvds_bitmap_vesa_rgb888' was not declared. Should it be static?
   drivers/gpu/drm/stm/lvds.c: note: in included file (through include/linux/mmzone.h, include/linux/gfp.h, include/linux/stackdepot.h, ...):
   include/linux/page-flags.h:242:46: sparse: sparse: self-comparison always evaluates to false

vim +/lvds_bitmap_jeida_rgb888 +318 drivers/gpu/drm/stm/lvds.c

   308	
   309	/*
   310	 * Expected JEIDA-RGB888 data to be sent in LSB format
   311	 *	    bit6 ............................bit0
   312	 * CHAN0   {ONE, ONE, ZERO, ZERO, ZERO, ONE, ONE}
   313	 * CHAN1   {G2,  R7,  R6,   R5,   R4,   R3,  R2}
   314	 * CHAN2   {B3,  B2,  G7,   G6,   G5,   G4,  G3}
   315	 * CHAN3   {DE,  VS,  HS,   B7,   B6,   B5,  B4}
   316	 * CHAN4   {CE,  B1,  B0,   G1,   G0,   R1,  R0}
   317	 */
 > 318	enum lvds_pixel lvds_bitmap_jeida_rgb888[5][7] = {
   319		{ PIX_ONE, PIX_ONE, PIX_ZER, PIX_ZER, PIX_ZER, PIX_ONE, PIX_ONE },
   320		{ PIX_G_2, PIX_R_7, PIX_R_6, PIX_R_5, PIX_R_4, PIX_R_3, PIX_R_2 },
   321		{ PIX_B_3, PIX_B_2, PIX_G_7, PIX_G_6, PIX_G_5, PIX_G_4, PIX_G_3 },
   322		{ PIX_D_E, PIX_V_S, PIX_H_S, PIX_B_7, PIX_B_6, PIX_B_5, PIX_B_4 },
   323		{ PIX_C_E, PIX_B_1, PIX_B_0, PIX_G_1, PIX_G_0, PIX_R_1, PIX_R_0 }
   324	};
   325	
   326	/*
   327	 * Expected VESA-RGB888 data to be sent in LSB format
   328	 *	    bit6 ............................bit0
   329	 * CHAN0   {ONE, ONE, ZERO, ZERO, ZERO, ONE, ONE}
   330	 * CHAN1   {G0,  R5,  R4,   R3,   R2,   R1,  R0}
   331	 * CHAN2   {B1,  B0,  G5,   G4,   G3,   G2,  G1}
   332	 * CHAN3   {DE,  VS,  HS,   B5,   B4,   B3,  B2}
   333	 * CHAN4   {CE,  B7,  B6,   G7,   G6,   R7,  R6}
   334	 */
 > 335	enum lvds_pixel lvds_bitmap_vesa_rgb888[5][7] = {
   336		{ PIX_ONE, PIX_ONE, PIX_ZER, PIX_ZER, PIX_ZER, PIX_ONE, PIX_ONE },
   337		{ PIX_G_0, PIX_R_5, PIX_R_4, PIX_R_3, PIX_R_2, PIX_R_1, PIX_R_0 },
   338		{ PIX_B_1, PIX_B_0, PIX_G_5, PIX_G_4, PIX_G_3, PIX_G_2, PIX_G_1 },
   339		{ PIX_D_E, PIX_V_S, PIX_H_S, PIX_B_5, PIX_B_4, PIX_B_3, PIX_B_2 },
   340		{ PIX_C_E, PIX_B_7, PIX_B_6, PIX_G_7, PIX_G_6, PIX_R_7, PIX_R_6 }
   341	};
   342	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

