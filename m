Return-Path: <linux-kernel+bounces-122816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1420688FDCA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 12:11:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1B732975EC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 11:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ABEF7E0E5;
	Thu, 28 Mar 2024 11:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SF/KD1cn"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308EC374EF
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 11:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711624274; cv=none; b=fUcsdkpbKawakoIliGOylTF8CWuXMMDek2yzf+yW5eRK9RDCb57eBvvYdP6CrAm6RUMnyCDJn+6OJvRAMnXWUzUJK/YOrAoQXF0beTRvUOJL2UnihGcIP++oldfXiuZZmwwk3s6yWHTwMQM4M11Tnx1voA09DVITdUY3dxmOKXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711624274; c=relaxed/simple;
	bh=0sjnUhGSLWF4zdEeCOtICFa6SD4hLB0WrMWUZ010M2M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ap7ixnps3bpeEWIit8ZfgowAeEsnceqQKgDf+CDT2fL38sx3p9ZcPJ7Wb5tubRDfhSMLVwlCJphO9yqjzrsdkx/wghqoh4t0UAFOowVS3nH3IKdlczzLakNnvH1H+u++AEbPmloioyMaGUzRq7lNRTa7xdBas8h0F6V6zY/I8cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SF/KD1cn; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711624273; x=1743160273;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=0sjnUhGSLWF4zdEeCOtICFa6SD4hLB0WrMWUZ010M2M=;
  b=SF/KD1cnq7+1T1miHqS+0y0yBtfMX3zWu46E2Ro54sFs95q9E2kobvtg
   BzT4L7CeaOwmoGwXgNHgPBaI5AaCWQamvPs7f4vL2nWWhZ0Zj822nY01X
   ngM/0KAG0FZ6hz3tOIOeA1Pym1i5IVLL3IPDkEEUa4cUv4f+ZdXYoReay
   ahyh9o/MAooHkSUQlnfwet6SXPSqQQrp2NoSjzRqRoJr6OePs5cSvsS9T
   mkZ9y9791W0MO9jW4eG/QVjNIX+jsrehv/iSbHr8+dVOAfT7LF6pczIwy
   fk9rVmTlGjrM47yXQ01cW6t/XcYG0jo7KqP9u86x0dp3ImW6V3z2sPtUC
   w==;
X-CSE-ConnectionGUID: HJs1G2kCR3+vymIbbrFUbA==
X-CSE-MsgGUID: by14qiRnSx6Lzh4fnqEPhQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11026"; a="18205792"
X-IronPort-AV: E=Sophos;i="6.07,161,1708416000"; 
   d="scan'208";a="18205792"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2024 04:11:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,161,1708416000"; 
   d="scan'208";a="17229579"
Received: from abdulqaf-mobl2.amr.corp.intel.com (HELO localhost) ([10.252.57.138])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2024 04:11:09 -0700
From: Jani Nikula <jani.nikula@intel.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Hamza Mahfooz <hamza.mahfooz@amd.com>,
 Javier Martinez Canillas <javierm@redhat.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Geert
 Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH] drm: DRM_WERROR should depend on DRM
In-Reply-To: <87msqkhhts.fsf@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <631a1f4c066181b54617bfe2f38b0bd0ac865b68.1711474200.git.geert+renesas@glider.be>
 <87msqkhhts.fsf@intel.com>
Date: Thu, 28 Mar 2024 13:11:06 +0200
Message-ID: <87jzlmfw6t.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, 26 Mar 2024, Jani Nikula <jani.nikula@intel.com> wrote:
> On Tue, 26 Mar 2024, Geert Uytterhoeven <geert+renesas@glider.be> wrote:
>> There is no point in asking the user about enforcing the DRM compiler
>> warning policy when configuring a kernel without DRM support.
>>
>> Fixes: f89632a9e5fa6c47 ("drm: Add CONFIG_DRM_WERROR")
>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> D'oh! My bad.
>
> Reviewed-by: Jani Nikula <jani.nikula@intel.com>

And pushed to drm-misc-next. Thanks for the patch!

BR,
Jani.

>
>> ---
>>  drivers/gpu/drm/Kconfig | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
>> index f2bcf5504aa77679..2e1b23ccf30423a9 100644
>> --- a/drivers/gpu/drm/Kconfig
>> +++ b/drivers/gpu/drm/Kconfig
>> @@ -423,7 +423,7 @@ config DRM_PRIVACY_SCREEN
>>  
>>  config DRM_WERROR
>>  	bool "Compile the drm subsystem with warnings as errors"
>> -	depends on EXPERT
>> +	depends on DRM && EXPERT
>>  	default n
>>  	help
>>  	  A kernel build should not cause any compiler warnings, and this

-- 
Jani Nikula, Intel

