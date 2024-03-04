Return-Path: <linux-kernel+bounces-90497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB75887001C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 12:16:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6A0E286601
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 11:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09EBA383AD;
	Mon,  4 Mar 2024 11:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c5wNRuRw"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E397376FD;
	Mon,  4 Mar 2024 11:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709551004; cv=none; b=cSDc3z0D09HjI1/eXoNwzys8Q7/Fcfe+I99YxsMvR6+vzKWj5Uax3MBkK4+Ci7OcRCWtZtxHROYyiaBq2/OAYlOD0tdjjA4U/+SbgTayymd088pyUGrPqVz7PMRTpoWUI6nZQLXmmnrUH/k93Tcax0DKpYIvEIzeXUtT9LLVoKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709551004; c=relaxed/simple;
	bh=AQrOOWHGmfRbYvwpO+pjPTsk5el/uOh59X3PKshhoZI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ap9jXiDp23pvIosWwOcHQqLW1ks85AOEuzTxBlmPF4W7Z7bmXPsDiaH5QaRfR7H/SZiclIRzkbLkqHwpp+MKklaXuunKAQllcgC+vvSf0wfu69J5qRdIhakIMrbyAEwSXM7kNmHZSu/4PD7e0rvFgEfXSP1t0i3SAH/A60TjnFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c5wNRuRw; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709551002; x=1741087002;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=AQrOOWHGmfRbYvwpO+pjPTsk5el/uOh59X3PKshhoZI=;
  b=c5wNRuRw2Br9zWrDIxm2EDYf5alEfVQXN4uMCBb+N47mT17B62eW5jaY
   Kn34mmAEM6G1YJwjOtSnRaunW4aGoUstDBxgyQRPYxH6nsMDD3bJr5kh+
   CtT8Qh9AMbKen2yLgXgI6S4rpHzyr+sKUiYsIgTblHLtsKg88PMlT0TUA
   iak/UGrAdchKj9RPHz+x2ehvdfs7WhiOf+/PJhX99aJjxlrUqZy3jRZVc
   m5hMZwoA0bpPt04cM3qE9KSw0qXSmF+c21UCCKG6jwZqbx+pApjypz6bE
   2v1RLQPr94DfyLEK3NK+0NrIxbrmecoCeNi0Q+CfZHmgDMQhIx6ApGqIU
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11002"; a="14680366"
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="14680366"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 03:16:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="9541582"
Received: from syakovle-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.51.3])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 03:16:37 -0800
From: Jani Nikula <jani.nikula@intel.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, mpe@ellerman.id.au,
 naresh.kamboju@linaro.org, deller@gmx.de
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 lkft-triage@lists.linaro.org, linux-kernel@vger.kernel.org, Thomas
 Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH] fbdev/chipsfb: Include <linux/backlight.h>
In-Reply-To: <20240304103820.16708-1-tzimmermann@suse.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20240304103820.16708-1-tzimmermann@suse.de>
Date: Mon, 04 Mar 2024 13:16:26 +0200
Message-ID: <878r2y5jsl.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, 04 Mar 2024, Thomas Zimmermann <tzimmermann@suse.de> wrote:
> Fix builds with CONFIG_PMAC_BACKLIGHT=y. The include statement for
> the backlight header has recently been removed from <linux/fb.h>.
>
> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> Closes: https://lore.kernel.org/dri-devel/CA+G9fYsAk5TbqqxFC2W4oHLGA0CbTHMxbeq8QayFXTU75YiueA@mail.gmail.com/
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Fixes: 11b4eedfc87d ("fbdev: Do not include <linux/backlight.h> in header")
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Jani Nikula <jani.nikula@intel.com>
> Cc: Helge Deller <deller@gmx.de>
> Cc: linux-fbdev@vger.kernel.org
> Cc: dri-devel@lists.freedesktop.org

I would've added the include in arch/powerpc/include/asm/backlight.h
[1], but either way is fine by me.

Reviewed-by: Jani Nikula <jani.nikula@intel.com>


[1] https://lore.kernel.org/r/20240304095512.742348-1-jani.nikula@intel.com

> ---
>  drivers/video/fbdev/chipsfb.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/video/fbdev/chipsfb.c b/drivers/video/fbdev/chipsfb.c
> index b80711f13df8a..b16a905588fed 100644
> --- a/drivers/video/fbdev/chipsfb.c
> +++ b/drivers/video/fbdev/chipsfb.c
> @@ -15,6 +15,7 @@
>   */
>  
>  #include <linux/aperture.h>
> +#include <linux/backlight.h>
>  #include <linux/module.h>
>  #include <linux/kernel.h>
>  #include <linux/errno.h>

-- 
Jani Nikula, Intel

