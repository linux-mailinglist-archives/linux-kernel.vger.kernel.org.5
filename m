Return-Path: <linux-kernel+bounces-60407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94576850476
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 13:59:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47642283941
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 12:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6510B31A8F;
	Sat, 10 Feb 2024 12:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FGz0+lSY"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A82D47F63
	for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 12:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707569963; cv=none; b=CRxFJ2FKNjPffmeei2Ckkf4YStLRhax2o9k1XM8FwUtdqkwN/OK80p8nuGOg/MhmoijgQo1RnYr7c1FmyLuinFAgNyCNRJHWKI4ahkGwq+32YxrIxL1+xptowXv4SC9z1BpaHPOAT0yQy0mYmMniKCKkSzBeNuBE/UA7UXF4EHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707569963; c=relaxed/simple;
	bh=Cb1Eh3O2qFMqBZxKzCU4auBY0R5n95zZ3gjKmSOb9JE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pDGuBhEOS0Rynopc/OFVFNXrQ09qT/HCNZbGElKfT3elowTdfDvyuzjToAmSTiC2OMzeV4DlrXG522QsdIAseQ966hI6cyFPQ0kL5iyBlg+XycaxGSbH/KiYCy2k45nKcK+jPKE+zkqo0aLZa6LNkvMjMe6fZaTsR6fh/2dc1G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FGz0+lSY; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707569961; x=1739105961;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Cb1Eh3O2qFMqBZxKzCU4auBY0R5n95zZ3gjKmSOb9JE=;
  b=FGz0+lSYHesRWo/GmlvBc/NA1qDyxm5801lnDFn6UxMipIpm7l/AQtUF
   5bm2kpXqH9l5uTV7ZNUtn8oezpWVAv/AiXbTspueXRTS2Too4Qf/x/zLC
   qlh5GgZrcx8y1dSjiCafX1rTEhIvL23ZivY71WoJ8pL+1KCph5Ta9i+0U
   Z9MuFn9jr9OgQx0ZIqJN0Us1pAT0jSHzxLQadi8yPBE+Z9948VHXpHYDE
   qf//YBSJ8JztoR0fEADz5hnsrSUzkdGlCzOozXtjtykC2ht74MDUF1p6j
   PNexVq2kuypl1NKTRgNc9z9+VfgMAWXL9agPu2mdFKGwzzKy8iJZ9YKKK
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10979"; a="1449114"
X-IronPort-AV: E=Sophos;i="6.05,259,1701158400"; 
   d="scan'208";a="1449114"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2024 04:59:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,259,1701158400"; 
   d="scan'208";a="2380396"
Received: from lkp-server01.sh.intel.com (HELO 01f0647817ea) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 10 Feb 2024 04:59:19 -0800
Received: from kbuild by 01f0647817ea with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rYmwv-0005fm-1n;
	Sat, 10 Feb 2024 12:59:17 +0000
Date: Sat, 10 Feb 2024 20:58:40 +0800
From: kernel test robot <lkp@intel.com>
To: Max Kellermann <max.kellermann@ionos.com>, linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Max Kellermann <max.kellermann@ionos.com>
Subject: Re: [PATCH v2 02/35] include: remove unnecessary #include directives
Message-ID: <202402102047.IswSP6zZ-lkp@intel.com>
References: <20240209164027.2582906-3-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240209164027.2582906-3-max.kellermann@ionos.com>

Hi Max,

kernel test robot noticed the following build errors:

[auto build test ERROR on next-20240209]
[cannot apply to drm-misc/drm-misc-next media-tree/master mkp-scsi/for-next linus/master v6.8-rc3 v6.8-rc2 v6.8-rc1 v6.8-rc3]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Max-Kellermann/include-add-missing-includes/20240210-005417
base:   next-20240209
patch link:    https://lore.kernel.org/r/20240209164027.2582906-3-max.kellermann%40ionos.com
patch subject: [PATCH v2 02/35] include: remove unnecessary #include directives
config: i386-buildonly-randconfig-006-20240210 (https://download.01.org/0day-ci/archive/20240210/202402102047.IswSP6zZ-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240210/202402102047.IswSP6zZ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402102047.IswSP6zZ-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/gpu/drm/sun4i/sun4i_layer.c:28:3: error: call to undeclared function 'kfree'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
      28 |                 kfree(state);
         |                 ^
   drivers/gpu/drm/sun4i/sun4i_layer.c:28:3: note: did you mean 'vfree'?
   include/linux/vmalloc.h:160:13: note: 'vfree' declared here
     160 | extern void vfree(const void *addr);
         |             ^
>> drivers/gpu/drm/sun4i/sun4i_layer.c:32:10: error: call to undeclared function 'kzalloc'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
      32 |         state = kzalloc(sizeof(*state), GFP_KERNEL);
         |                 ^
   drivers/gpu/drm/sun4i/sun4i_layer.c:32:10: note: did you mean 'vzalloc'?
   include/linux/vmalloc.h:140:14: note: 'vzalloc' declared here
     140 | extern void *vzalloc(unsigned long size) __alloc_size(1);
         |              ^
>> drivers/gpu/drm/sun4i/sun4i_layer.c:32:8: error: incompatible integer to pointer conversion assigning to 'struct sun4i_layer_state *' from 'int' [-Wint-conversion]
      32 |         state = kzalloc(sizeof(*state), GFP_KERNEL);
         |               ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/sun4i/sun4i_layer.c:43:9: error: call to undeclared function 'kzalloc'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
      43 |         copy = kzalloc(sizeof(*copy), GFP_KERNEL);
         |                ^
   drivers/gpu/drm/sun4i/sun4i_layer.c:43:7: error: incompatible integer to pointer conversion assigning to 'struct sun4i_layer_state *' from 'int' [-Wint-conversion]
      43 |         copy = kzalloc(sizeof(*copy), GFP_KERNEL);
         |              ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/sun4i/sun4i_layer.c:60:2: error: call to undeclared function 'kfree'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
      60 |         kfree(s_state);
         |         ^
   6 errors generated.


vim +/kfree +28 drivers/gpu/drm/sun4i/sun4i_layer.c

9026e0d122ac87 Maxime Ripard      2015-10-29  18  
d540f82adf3577 Maxime Ripard      2018-01-22  19  static void sun4i_backend_layer_reset(struct drm_plane *plane)
d540f82adf3577 Maxime Ripard      2018-01-22  20  {
d540f82adf3577 Maxime Ripard      2018-01-22  21  	struct sun4i_layer_state *state;
d540f82adf3577 Maxime Ripard      2018-01-22  22  
d540f82adf3577 Maxime Ripard      2018-01-22  23  	if (plane->state) {
d540f82adf3577 Maxime Ripard      2018-01-22  24  		state = state_to_sun4i_layer_state(plane->state);
d540f82adf3577 Maxime Ripard      2018-01-22  25  
d540f82adf3577 Maxime Ripard      2018-01-22  26  		__drm_atomic_helper_plane_destroy_state(&state->state);
d540f82adf3577 Maxime Ripard      2018-01-22  27  
d540f82adf3577 Maxime Ripard      2018-01-22 @28  		kfree(state);
d540f82adf3577 Maxime Ripard      2018-01-22  29  		plane->state = NULL;
d540f82adf3577 Maxime Ripard      2018-01-22  30  	}
d540f82adf3577 Maxime Ripard      2018-01-22  31  
d540f82adf3577 Maxime Ripard      2018-01-22 @32  	state = kzalloc(sizeof(*state), GFP_KERNEL);
e4fff65fdb526a Maxime Ripard      2022-02-21  33  	if (state)
60252323ec9c36 Alexandru Gheorghe 2018-08-04  34  		__drm_atomic_helper_plane_reset(plane, &state->state);
d540f82adf3577 Maxime Ripard      2018-01-22  35  }
d540f82adf3577 Maxime Ripard      2018-01-22  36  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

