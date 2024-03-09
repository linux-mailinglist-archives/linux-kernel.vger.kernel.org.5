Return-Path: <linux-kernel+bounces-98014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9484877355
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 19:40:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBA0E1C210A9
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 18:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FD144643B;
	Sat,  9 Mar 2024 18:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S2x6/nUU"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0883B25630;
	Sat,  9 Mar 2024 18:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710009641; cv=none; b=roJgZa08VAXPZoWBZyX+rI9/t7q+wryppYGKLpBOtGiN4gA4lRG4HJNN87ToygCxoDrFcXDyW2IeFE7fRnUEQmP6m0blIihBMwtvt9l3EcfZwX0ECPLWqeGb0YiDp9x+b5RwzpvORrVVOfOzKIjNHSHWDhSdDaVA5Plzb8RR8oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710009641; c=relaxed/simple;
	bh=iI05tamoUJkUacvbgp0hTUzaN2hNmy8JMBHjYuB49Jg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HIe/Yhp+TadgsOkCxKczO2ENUt+xQvoX/E93VeE1J817yhp2y+lck7Xv/FEK/i4hsM8B0UzWHyrpcILWDGI6lU4zOWhV5wtPXQ03ou7S3E1FLNpvIDya3FR3Be5LIbKCJDLVJu/82+3/p8JSL1IPQOrIw9PyeQINBGAEAOPewXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S2x6/nUU; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710009638; x=1741545638;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iI05tamoUJkUacvbgp0hTUzaN2hNmy8JMBHjYuB49Jg=;
  b=S2x6/nUUgqJAyZKM6u3oNE+Hyg1MOnUpk8kZdept+ZTwQB6CyB9FDWoG
   Ue/PV6AkDc9+VjSa/mOcCehZL7FXJh9+BR6+egzXY5dyJJAZLApFHaKvD
   2f8rcp0oKK4eX2aNgn1BBnKvDvD9wlLtFTe+jNpC0N4bBKO3DDlS4vkC2
   KmlvcznJ6O+ltTshGWMLNb67OWU+sfxluiCwxnh2VH/dZPSZRG+eGBze1
   czzA3wFzeRkg8ADo+zsGYyZTcQ0z01jrRwUIOVCJFV/bUAYxChJpVgRk5
   VGuDB6cNnuBdMjESg0tP6Wghv5p/c5BbN+ydXuBMDWyyaqlnxYBsnuEmv
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11008"; a="4897007"
X-IronPort-AV: E=Sophos;i="6.07,113,1708416000"; 
   d="scan'208";a="4897007"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2024 10:40:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,113,1708416000"; 
   d="scan'208";a="11332735"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 09 Mar 2024 10:40:36 -0800
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rj1cX-0007aR-1S;
	Sat, 09 Mar 2024 18:40:33 +0000
Date: Sun, 10 Mar 2024 02:39:47 +0800
From: kernel test robot <lkp@intel.com>
To: tumic@gpxsee.org, Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Martin =?utf-8?B?VMWvbWE=?= <martin.tuma@digiteqautomotive.com>
Subject: Re: [PATCH v2 2/2] media: mgb4: Add support for V4L2_CAP_TIMEPERFRAME
Message-ID: <202403100204.fyBLGfk1-lkp@intel.com>
References: <20240307121822.1852-3-tumic@gpxsee.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240307121822.1852-3-tumic@gpxsee.org>

Hi,

kernel test robot noticed the following build errors:

[auto build test ERROR on 65e6a2773d655172143cc0b927cdc89549842895]

url:    https://github.com/intel-lab-lkp/linux/commits/tumic-gpxsee-org/media-mgb4-Add-support-for-YUV-image-formats/20240307-192243
base:   65e6a2773d655172143cc0b927cdc89549842895
patch link:    https://lore.kernel.org/r/20240307121822.1852-3-tumic%40gpxsee.org
patch subject: [PATCH v2 2/2] media: mgb4: Add support for V4L2_CAP_TIMEPERFRAME
config: arm-allyesconfig (https://download.01.org/0day-ci/archive/20240310/202403100204.fyBLGfk1-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240310/202403100204.fyBLGfk1-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403100204.fyBLGfk1-lkp@intel.com/

All errors (new ones prefixed by >>):

   arm-linux-gnueabi-ld: drivers/media/pci/mgb4/mgb4_vin.o: in function `vidioc_s_parm':
>> mgb4_vin.c:(.text+0x1d64): undefined reference to `__aeabi_uldivmod'
>> arm-linux-gnueabi-ld: mgb4_vin.c:(.text+0x1e48): undefined reference to `__aeabi_uldivmod'
   arm-linux-gnueabi-ld: drivers/media/pci/mgb4/mgb4_vout.o: in function `vidioc_s_parm':
>> mgb4_vout.c:(.text+0x183c): undefined reference to `__aeabi_uldivmod'
>> arm-linux-gnueabi-ld: mgb4_vout.c:(.text+0x1920): undefined reference to `__aeabi_uldivmod'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

