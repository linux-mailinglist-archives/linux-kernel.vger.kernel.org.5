Return-Path: <linux-kernel+bounces-124107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A782789124B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 05:06:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D90151C239BC
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 04:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 038613A1CC;
	Fri, 29 Mar 2024 04:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bMy3Z14z"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04F339FF7
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 04:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711685191; cv=none; b=HLOnB/jiVhfnmykZEVJ5MwjzVLy21p4wWw+t4fcbsoxjGbrW6Nm0uFbMwZPVs3slxJ/GsjolgqWaEVqb4IhDR00VZhUxOp+kjafFTVzgbn6enCsSC5+/sxkwc8PyGgObYiMt0x3C4sSlB0WwbkQAr/gEE6jnmZoozUOcl7FGYyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711685191; c=relaxed/simple;
	bh=7Q5Z3h+GFGsGFPfvmakMEwLiWFpW7YiCnjBbtwkQFtw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KfGlJ6QtgnF7523oV79PRzCQi0Rrgi3iIoG0sB8k3cEXh5EXlN/nlIP2+i3DG1G/HaHlTpaCtItCnZWpee8fKszZ4/9+XfxmtTtSxJjPNt45CG/cFqOLa1E+Hhhj9ox74OCGCrt3yn/PuHoNThwHKtsV58M3V8awzuiSQL9ZJB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=bMy3Z14z; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1e0d82d441bso15217155ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 21:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711685189; x=1712289989; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=x+IKl5jgXsGZi0mbCPhq9hLR3oi5JgzC/vagz7Y/keo=;
        b=bMy3Z14z4OHkngyCwvIj0vGgxhuf/ts6nKWquAa3YhCq+ZEjjVjKI38VkdGUWFJum4
         uLDYnnlo2fuspzTXscg83rq2oXyq9yM1pZrx15t91RpjOZ/6tqymT0oLkd5W86pnj8HY
         Uldwn/9I6BNTICL1Yc9Ti6Z7cV8aCbI5mI8fw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711685189; x=1712289989;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x+IKl5jgXsGZi0mbCPhq9hLR3oi5JgzC/vagz7Y/keo=;
        b=MMfKmHK+HUxKIR0zIQ2N0bVshzKhlzU1adHpaSH00JrGJ1px7s3RirQ9ExUPU4w8CC
         yKSWAmg//ntjJ4u5zys0J6S4FsUCelkUdUxuBhv/iyQSDXGasG5Nj2Y93f1PFmBvzFtX
         r1mGKrvCBFKNB12cpvbDX5OI+3K7ByqfLQhYMRBL97iehHI6jV0bypDvDs5KfTK9Tpqg
         fP+PhoVNCfFh+MUMc6cq0Prni/NqkdqSgFdC094yChf0R4dkJUXHiThS+RBQzSsiTXnF
         LB7J1mWqXvM3EBor7XCV+f0a7Err0uscnaUjgl8IOqIWH4nmQfQxWHl4hy3gUuqPxTq1
         DiCA==
X-Forwarded-Encrypted: i=1; AJvYcCXtvkLrX4XHdLkYyAgiQWg294L3SYwkSmNuVpks3RNsdV67VaoxP/uhwO8QvEWm6NS3wDQu48ac1IR/05ahNdmOTEDSr8wmgsDl/dnZ
X-Gm-Message-State: AOJu0Ywos0Q5elOWvOtL8SkJ9qA/yqH0GgLcJoe5uP77Iw1Mt8Nes5KE
	NftM7Sqj/BSPQp4IF6dmD+st6yEQNtWZFZ+vuwHWrBDPY3RS3K2Qy2kuKjhrZQ==
X-Google-Smtp-Source: AGHT+IExHIZRx4aycuBDHgCgeixTvQb45vK5L7KK3PjbTyeTfdK0wlFMrkIFG+tcak2Z0aNtfOlnQw==
X-Received: by 2002:a17:902:ec81:b0:1e0:58e:88a8 with SMTP id x1-20020a170902ec8100b001e0058e88a8mr1776848plg.52.1711685189298;
        Thu, 28 Mar 2024 21:06:29 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id u5-20020a170903124500b001db9e12cd62sm2470242plh.10.2024.03.28.21.06.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 21:06:28 -0700 (PDT)
Date: Thu, 28 Mar 2024 21:06:28 -0700
From: Kees Cook <keescook@chromium.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Timur Tabi <timur@kernel.org>, Helge Deller <deller@gmx.de>,
	linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] video: fbdev: fsl-diu-fb: replace deprecated strncpy
 with strscpy_pad
Message-ID: <202403282106.4D3757F@keescook>
References: <20240320-strncpy-drivers-video-fbdev-fsl-diu-fb-c-v1-1-3cd3c012fa8c@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240320-strncpy-drivers-video-fbdev-fsl-diu-fb-c-v1-1-3cd3c012fa8c@google.com>

On Wed, Mar 20, 2024 at 10:48:50PM +0000, Justin Stitt wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> A better alternative is strscpy() as it guarantees NUL-termination on
> the destination buffer.
> 
> Since we are eventually copying over to userspace, let's ensure we
> NUL-pad the destination buffer by using the pad variant of strscpy.
> - core/fb_chrdev.c:
> 234 |	err = copy_to_user(&fix32->id, &fix->id, sizeof(fix32->id));
> 
> Furthermore, we can use the new 2-argument variants of strscpy() and
> strscpy_pad() introduced by Commit e6584c3964f2f ("string: Allow
> 2-argument strscpy()") to simplify the syntax even more.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

