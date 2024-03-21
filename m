Return-Path: <linux-kernel+bounces-110259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C6CE885C34
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 16:41:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D75231F26CC7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 15:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0F2986ADB;
	Thu, 21 Mar 2024 15:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fn34fFjB"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC47820304;
	Thu, 21 Mar 2024 15:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711035457; cv=none; b=Hw0E6Ik623041jnwXDlnyoWG1D0YhC78sSG4ZBfgDspr4fmQc5G1jP5zTZcu8GA9gQEegV97pXCRFvoHVtk1GV8ENYkyXeDd6ljLOe4SDTyOYK97QPQJbuW4sxBbhgo4vm01ptk6wc/fINfkU22ztuLxrgqPEBbIkNMoWVEvy5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711035457; c=relaxed/simple;
	bh=dOYNT79qk9MioScuYTUeX2HdGhASPtDv2e6R6SOo5sY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qZtc94NvBufW6hbNoMSyE/2QyzmNPNOy3sxAJkeLPqq1F2MVs6mA3eI73D4H3XbQy63GcVOrt1Q0T3aImsQOGJLVtkZkyPXCFLkdc942efdFQsYcO3KKIGxm7RkmK0q7TqiKNcJgmX4pT7y4nWUOP0YlYW/EphEO96TmmbLXEaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fn34fFjB; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711035455; x=1742571455;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=dOYNT79qk9MioScuYTUeX2HdGhASPtDv2e6R6SOo5sY=;
  b=fn34fFjBSysEoOYzC/1lg9cepJpzRuM9UnvlNaj6tMDXAZsk9qdzmAXD
   z6VFFCKV0cINwQHr0Vt9XT0a5rMiH24Y+IHB7hiFzZTheyN1pJ4Wg597r
   KidatMgLdYNTi1eoqXTjaajBB/3/Ra/rxsyyCzg+xDUPtpz8OqGtsWWiT
   xl2Mstl812EDxeYPo/Or4ulGIr/4gQbPsFOSoEW+eID4ugKZVJYYAEMsF
   tFZXI4F0VCl6oMeOIfD3Ef5LXVsTxWkJgJcWI4sMXrucODylAolodCZ8g
   aU3cBPNVi0i14sdJ4bco+WWkgbPKbQ/mcCaidskSAHMpkt3zGZh20lJ5+
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11020"; a="9836963"
X-IronPort-AV: E=Sophos;i="6.07,143,1708416000"; 
   d="scan'208";a="9836963"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2024 08:37:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,143,1708416000"; 
   d="scan'208";a="15198266"
Received: from unknown (HELO localhost) ([10.237.66.160])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2024 08:37:30 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Amogh Cheluvaraj <amogh.linux.kernel.dev@gmail.com>, airlied@gmail.com,
 daniel@ffwll.ch, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, corbet@lwn.net, javier.carrasco.cruz@gmail.com,
 skhan@linuxfoundation.org
Cc: Amogh Cheluvaraj <amogh.linux.kernel.dev@gmail.com>,
 dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix duplicate C declaration warnings
In-Reply-To: <20240321115738.51188-1-amogh.linux.kernel.dev@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20240321115738.51188-1-amogh.linux.kernel.dev@gmail.com>
Date: Thu, 21 Mar 2024 17:37:25 +0200
Message-ID: <871q83mw96.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, 21 Mar 2024, Amogh Cheluvaraj <amogh.linux.kernel.dev@gmail.com> wrote:
> Fix the duplicate C declaration warnings found on
> Documentation/gpu/drm-kms.rst that was found by
> compiling htmldocs

Please paste the warnings here.

BR,
Jani.


>
> Signed-off-by: Amogh Cheluvaraj <amogh.linux.kernel.dev@gmail.com>
> ---
>  Documentation/gpu/drm-kms.rst | 6 ------
>  1 file changed, 6 deletions(-)
>
> diff --git a/Documentation/gpu/drm-kms.rst b/Documentation/gpu/drm-kms.rst
> index 13d3627d8bc0..a4145f391e43 100644
> --- a/Documentation/gpu/drm-kms.rst
> +++ b/Documentation/gpu/drm-kms.rst
> @@ -357,9 +357,6 @@ Format Functions Reference
>  .. kernel-doc:: include/drm/drm_fourcc.h
>     :internal:
>  
> -.. kernel-doc:: drivers/gpu/drm/drm_fourcc.c
> -   :export:
> -
>  .. _kms_dumb_buffer_objects:
>  
>  Dumb Buffer Objects
> @@ -458,9 +455,6 @@ KMS Locking
>  .. kernel-doc:: include/drm/drm_modeset_lock.h
>     :internal:
>  
> -.. kernel-doc:: drivers/gpu/drm/drm_modeset_lock.c
> -   :export:
> -
>  KMS Properties
>  ==============

-- 
Jani Nikula, Intel

