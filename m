Return-Path: <linux-kernel+bounces-48346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 703FB845AB9
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 15:59:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 195AD28E21D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 14:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3545A5F493;
	Thu,  1 Feb 2024 14:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Wa6Srib0"
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5545F46A
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 14:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706799541; cv=none; b=ShyUGumKcZeMpzfn9hA2IRzqWAV+NM/CehMC8U9VngNdjlRWkFo+GDcXajGu9lzAmtURGF1Zx+pfAmkeC/SiQZbAYWUGiMVFsSQnOaKSVP+sgNfHiMivB+oh0KH15MX4ywizAGygqibxIDVIhm3LB9X/SQqkKvvn6ZpF/6Lu24M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706799541; c=relaxed/simple;
	bh=kFAFaXm8F4EL8NoAc/dHToWhGFHEfq3FZcxMdR5p91M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f9qsQmXRHWlV7rG1f57p0gdlgCQ9WXtNKP87ky+7Z4/sSLRZ9RmoajxAGkKsMSCxOcOiKyTj0XXlZo0C44fCJcb95LObzX0ZdJLvTGRuQNi79T2lszhWYPip+FfeDVKMIALsOoIxlsS3VHhIkh4su3TJLB3mJ7o3Pw0jhTGlJyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Wa6Srib0; arc=none smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-46b3359f5efso445191137.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 06:58:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706799538; x=1707404338; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dcfSreLjudsgAcLBxrHGQStk7J9Wu7zu9S6tcciGw3s=;
        b=Wa6Srib0ZYjswYkEyEi7ggfC9nWDk2zttnycI2SgNRbcz3wKfqH6W4xbsROqu8WCYM
         vM2bxgAI1U/Y4CcQwxSm38me4HlabzaDDDok/efUTSGeELtaYDI3fdn52rHCPl3H7LKv
         rHqjT5Q70q9PallkO+0sBGLp1FiWS4bdUN5+w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706799538; x=1707404338;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dcfSreLjudsgAcLBxrHGQStk7J9Wu7zu9S6tcciGw3s=;
        b=Yq7cHwu6Y4sKSY49/Uu5+8cBDkgR/H/LzWVRc28xXRNfBs7TZ1hsO9DHn7NVziBgCx
         DFSbwSU8XOdCtwlWnb7bfMlbliVy/qnHrnugmIMPgqtdiCUXkjxzFtIMPwRRDlbyt33z
         ycJ/ODCHQ5ma2CGGz6O7VuYAiMRFM3BBaCbFeK4dddzAikFbMspgg9sgDLi7m38ynMnY
         UfNQ8G/jnc+/pp3oWfzoGU53fVi9L2oaTVIJI5YQU7IyaVaXl2JfU0sfxeju8rMqiF/K
         84mp79fqT93GWCeq4gFlEx4dwmqe5CAaaue6e0jN5CCl2mX9Wl8ZOrh5o6CFL1vClNU6
         TzAA==
X-Gm-Message-State: AOJu0YxcwQHLsSCnagmnEzL72zhIbreYbZarvKrKn8quAr1tOoyMPEHh
	v4Dq830muFE5a1W8ViRotA06QCuv61woJ4nad+n7UKRnjCcEeRPZmg8pjzMt4w==
X-Google-Smtp-Source: AGHT+IGfRebD1jMZUzsq/IURTxlogmA9+3l4gxAb/wYU5kP1jo50VPR8BUXJHNfQJmkijeiOyQRyXg==
X-Received: by 2002:a05:6102:38ca:b0:46c:fb56:da14 with SMTP id k10-20020a05610238ca00b0046cfb56da14mr317906vst.27.1706799538453;
        Thu, 01 Feb 2024 06:58:58 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUDNzybqhiDIFAWMTkOAJvtYTw95gE7f5EUK05c5fuaU1RHEYRz0Oo+LLeYfbUdv1T2N9Vla3ZfQWIoAtySjjrTHFhs7XlpXejn9TDQ+/ncVCGhPSteXf4G1MuAuAhyFTpey5p4PwL9puHamPSizEF80eNhITAEtnq3GZ6o+7xE6CTkvLcrOPQAFZDzA4A/fw70N4rOGFu2zyjkprAa2EpMWN81+lq9muFAuPJrMWpEPygDFi5muz642IdrxQ+4SNj9LxvdfDMbpmL9k4o9kPUIUJFcErK+gWHAUdp8xF6688tQ1Q/keqGMPjG5gF0P1OXLIhgElJ1pwFMyTiYeI9x1ApXMScFV9/RWDz0zF9xmv3mvz29jgZs+gCPDPrYT6aQVPTP+ISt8dhInVVafxHYlhDrBc6TZWqgLByjzN9YAcA==
Received: from google.com (240.157.150.34.bc.googleusercontent.com. [34.150.157.240])
        by smtp.gmail.com with ESMTPSA id dh14-20020ad458ce000000b0068c81299a2bsm242562qvb.15.2024.02.01.06.58.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 06:58:58 -0800 (PST)
Date: Thu, 1 Feb 2024 14:58:56 +0000
From: Paz Zcharya <pazz@chromium.org>
To: Jani Nikula <jani.nikula@intel.com>
Cc: Jouni =?utf-8?B?SMO2Z2FuZGVy?= <jouni.hogander@intel.com>,
	Luca Coelho <luciano.coelho@intel.com>,
	Subrata Banik <subratabanik@google.com>,
	Manasi Navare <navaremanasi@chromium.org>,
	Drew Davenport <ddavenport@chromium.org>,
	Sean Paul <seanpaul@chromium.org>,
	Marcin Wojtas <mwojtas@chromium.org>, khaled.almahallawy@intel.com,
	intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm/i915/display: Include debugfs.h in
 intel_display_debugfs_params.c
Message-ID: <ZbuxsF7ubmL6lzdR@google.com>
References: <20240131204658.795278-1-pazz@chromium.org>
 <87o7d0h73r.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87o7d0h73r.fsf@intel.com>

On Thu, Feb 01, 2024 at 11:22:16AM +0200, Jani Nikula wrote:
> On Wed, 31 Jan 2024, Paz Zcharya <pazz@chromium.org> wrote:
> > Commit 8015bee0bfec ("drm/i915/display: Add framework to add parameters
> > specific to display") added the file intel_display_debugfs_params.c,
> > which calls the functions "debugfs_create_{bool, ulong, str}" -- all of
> > which are defined in <linux/debugfs.h>. The missing inclusion of this
> > header file is breaking the ChromeOS build -- add an explicit include
> > to fix that.
> >
> 
> Thanks for the patch, apparently in our configs some paths lead to
> debugfs.h. Just goes on to show how interdependent the kernel headers
> are.
> 
> Out of curiousity, what value do you have for CONFIG_DEBUG_FS kconfig?
> 
> Fixes: 8015bee0bfec ("drm/i915/display: Add framework to add parameters specific to display")
> Reviewed-by: Jani Nikula <jani.nikula@intel.com>
> 
> BR,
> Jani.
> 
Thank you so much for the super prompt reply!

In ChromeOS the value is CONFIG_DEBUG_FS=y.

Best,
Paz
> 
> > Signed-off-by: Paz Zcharya <pazz@chromium.org>
> > ---
> >  drivers/gpu/drm/i915/display/intel_display_debugfs_params.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/gpu/drm/i915/display/intel_display_debugfs_params.c b/drivers/gpu/drm/i915/display/intel_display_debugfs_params.c
> > index b7e68eb62452..f35718748555 100644
> > --- a/drivers/gpu/drm/i915/display/intel_display_debugfs_params.c
> > +++ b/drivers/gpu/drm/i915/display/intel_display_debugfs_params.c
> > @@ -3,6 +3,7 @@
> >   * Copyright © 2023 Intel Corporation
> >   */
> >  
> > +#include <linux/debugfs.h>
> >  #include <linux/kernel.h>
> >  
> >  #include <drm/drm_drv.h>
> 
> -- 
> Jani Nikula, Intel

