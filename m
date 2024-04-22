Return-Path: <linux-kernel+bounces-153875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 989808AD460
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 20:51:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 539A428853E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 18:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8C2C155359;
	Mon, 22 Apr 2024 18:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nCGfOPQ9"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444BA155311
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 18:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713811754; cv=none; b=tSICHX2UqzF1S/woCbOmu5U+6C8Ts6OjuuhBqF8k82D+Uk17or69fYTfqW2MyedYnDWLNpA1CwulVajeMJl/xbhkv2KitNvkmQGodgCuZHZTCF3OWoJNuOWQtv1H/6IhccZYjs27KlO/Nmg7kmnmXN1b+E+Bz0+ItfxV+oNlIgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713811754; c=relaxed/simple;
	bh=NEhut3AMCx5WprTtoCXYaXw0lI9Lkbu+xXEoqieubfQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kNyBeWDhFIZvSsdJwiQEfhHlLGYMntZQN/jJKb9i5rt+IPIM1w0ymgN5BQ+eKyX9SKsuq+3qDMZ0Jr5BnK6y3nru/bit98UBqFR+PUQUqvvEs3iPaPR6GgqVxq7dgTEyf9WzPEIv8argQxX/yRXJQET4ZmGt+Yk/o4uZRGhjzHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nCGfOPQ9; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713811752; x=1745347752;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=NEhut3AMCx5WprTtoCXYaXw0lI9Lkbu+xXEoqieubfQ=;
  b=nCGfOPQ9TnTkaQZ3+Tsipk38EMMkwWMhaddISWQ7Yqrm9SWq8LgY0xjj
   qQTw4egux8fCPtnHSx0i/ZmuVXPOusf/gbH//cMyOSmJQMR2yPMSRih/q
   nEXQQ61/DstQwURUamS/3mbX0iXuNLiXDGR+1En58ZFQzRI23MOuVxL1G
   6WWFFpHBqCm8a6ztPS733rZI9xyQQa9AsPbJwXahSqWMsnApty6AS/nJh
   xmRPdE7tSga+W04PTUa7JgjJfagQY0B4kgYQr/gJ/BUInshqGmB0Kaxxb
   n28CGZ7ig0BfTzHUZIOAtk1sKtwLaJChbrb0DEUUiFncCOKxh71LMic0+
   w==;
X-CSE-ConnectionGUID: 0zVbykY0RwqEG4sScT20lA==
X-CSE-MsgGUID: m0Rpop2ZTdqtZdEIB7/bIw==
X-IronPort-AV: E=McAfee;i="6600,9927,11052"; a="9585095"
X-IronPort-AV: E=Sophos;i="6.07,221,1708416000"; 
   d="scan'208";a="9585095"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 11:49:12 -0700
X-CSE-ConnectionGUID: DxtNHo/yRIWaBblTjbug5g==
X-CSE-MsgGUID: zD+11gt4Rj+Jdu6cfySs+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,221,1708416000"; 
   d="scan'208";a="61545654"
Received: from ralbanes-mobl.ger.corp.intel.com (HELO localhost) ([10.252.63.128])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 11:49:08 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Melissa Wen
 <mwen@igalia.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David
 Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, Andy
 Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/1] drm: fixed: Don't use "proxy" headers
In-Reply-To: <20240422143338.2026791-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20240422143338.2026791-1-andriy.shevchenko@linux.intel.com>
Date: Mon, 22 Apr 2024 21:49:04 +0300
Message-ID: <87r0exs067.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, 22 Apr 2024, Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> Update header inclusions to follow IWYU (Include What You Use)
> principle.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Assuming it builds, and nothing depends on other stuff from kernel.h via
drm_fixed.h,

Reviewed-by: Jani Nikula <jani.nikula@intel.com>

> ---
>  include/drm/drm_fixed.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/include/drm/drm_fixed.h b/include/drm/drm_fixed.h
> index 81572d32db0c..387fb81d5b81 100644
> --- a/include/drm/drm_fixed.h
> +++ b/include/drm/drm_fixed.h
> @@ -25,8 +25,9 @@
>  #ifndef DRM_FIXED_H
>  #define DRM_FIXED_H
>  
> -#include <linux/kernel.h>
>  #include <linux/math64.h>
> +#include <linux/types.h>
> +#include <linux/wordpart.h>
>  
>  typedef union dfixed {
>  	u32 full;

-- 
Jani Nikula, Intel

