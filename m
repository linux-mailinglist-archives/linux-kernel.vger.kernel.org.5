Return-Path: <linux-kernel+bounces-59446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D0FD84F73A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 15:25:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58D4F288262
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 14:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 753EF692E1;
	Fri,  9 Feb 2024 14:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PeBUrsdZ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132854F1F6
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 14:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707488730; cv=none; b=i6vUMo9t41qo1NUe02ylpJtb01CVdXiJDv5JGlXdVDOIk/1bssftuuwjG6Wap+hLquUt+jDO82pzSPEFBkx6GrfY30G4ls46t6V+FhdDTYi8TbXJ7RYKWg1YLGffAfDy9APzV90wJ15oXhUwnI4VzbsgEOhargP9Hpu/MOh24WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707488730; c=relaxed/simple;
	bh=SrZf75A1fwGhAa0JIttbmp/PWGFSXiErzRNHTtR/VCo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NVnTwjKSS3W2WT1W7Vf1rT6iBYtthh76qYJByfD1cjiKsqrLjJt6xWaauomMdsVuckggfjrsL7nbBY6LI9P6BLLBTX9hZhvLJcuO6+06CkG0Lqy60tczq2Riqg5QPjL/Oc4w5nZdbSbKGoZv0SbgqhRg2fBJ6zMruyvup57WGpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PeBUrsdZ; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707488729; x=1739024729;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=SrZf75A1fwGhAa0JIttbmp/PWGFSXiErzRNHTtR/VCo=;
  b=PeBUrsdZBHnxooQck+dN9MtkxECFJaAzH3opS6JYALSiYvqa4kdiIgCd
   yDCJbIvJlnCOiFr+Qbz2+bulUauvyLQTvxIM3lqcy9HxGhk+79OT3RHju
   GYvFQ17cO2CpAN4WHlQUMRPhe+YHFGCr9zoqganBa0GljBl5BnxhPTkPR
   USbk+gHxJ5gLYdEkj6FK5lfWGcOmMkl2QFNKU96YVY04NcwxMcqQRC+Lr
   eEQ6CqDUgioK3e7MkIKaom7/hWw+KTabT5RWiEb0+03vEZrRRsrS/kabP
   y904KlHxTWxz6iECyFl9O2lUbF1SPxr/kD3yU47jo+bc0sEzFJNYxUzwt
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10979"; a="1581320"
X-IronPort-AV: E=Sophos;i="6.05,257,1701158400"; 
   d="scan'208";a="1581320"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 06:25:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,257,1701158400"; 
   d="scan'208";a="1980765"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa010.jf.intel.com with ESMTP; 09 Feb 2024 06:25:25 -0800
Received: from [10.249.138.141] (mwajdecz-MOBL.ger.corp.intel.com [10.249.138.141])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id B791727BB4;
	Fri,  9 Feb 2024 14:25:23 +0000 (GMT)
Message-ID: <b00baf72-7ef5-4a10-97c0-a9b7eb5a86f3@intel.com>
Date: Fri, 9 Feb 2024 15:25:21 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/tests: mm: Convert to drm_dbg_printer
To: =?UTF-8?Q?Micha=C5=82_Winiarski?= <michal.winiarski@intel.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Jani Nikula <jani.nikula@intel.com>, Luca Coelho <luciano.coelho@intel.com>
References: <20240209140818.106685-1-michal.winiarski@intel.com>
Content-Language: en-US
From: Michal Wajdeczko <michal.wajdeczko@intel.com>
In-Reply-To: <20240209140818.106685-1-michal.winiarski@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 09.02.2024 15:08, Michał Winiarski wrote:
> Fix one of the tests in drm_mm that was not converted prior to
> drm_debug_printer removal, causing tests build failure.
> 
> Fixes: e154c4fc7bf2d ("drm: remove drm_debug_printer in favor of drm_dbg_printer")
> Signed-off-by: Michał Winiarski <michal.winiarski@intel.com>

Reviewed-by: Michal Wajdeczko <michal.wajdeczko@intel.com>

> ---
>  drivers/gpu/drm/tests/drm_mm_test.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/tests/drm_mm_test.c b/drivers/gpu/drm/tests/drm_mm_test.c
> index 1eb0c304f9607..3488d930e3a38 100644
> --- a/drivers/gpu/drm/tests/drm_mm_test.c
> +++ b/drivers/gpu/drm/tests/drm_mm_test.c
> @@ -188,7 +188,7 @@ static void drm_test_mm_init(struct kunit *test)
>  
>  static void drm_test_mm_debug(struct kunit *test)
>  {
> -	struct drm_printer p = drm_debug_printer(test->name);
> +	struct drm_printer p = drm_dbg_printer(NULL, DRM_UT_CORE, test->name);
>  	struct drm_mm mm;
>  	struct drm_mm_node nodes[2];
>  

