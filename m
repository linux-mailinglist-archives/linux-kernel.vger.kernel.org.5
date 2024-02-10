Return-Path: <linux-kernel+bounces-60333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F09850348
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 08:25:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DFC91C21BD8
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 07:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC5DF286AF;
	Sat, 10 Feb 2024 07:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RvkQ25jh"
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2611C28DC9
	for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 07:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707549921; cv=none; b=jq3g+ZS8ENwSmQNu4bCeuqNny+CcWbZtf7akaC7PCPTvreUqnoPdrorwhVvqQDqAtcGrjY31Y+OvHKxvApg46rG6XsX1ouFGk7+LXoNN/aUFgXtH2WAnXm44dP8NRGfYuKJL1nCtaePwEsQaF1wrYSL3n/3ioJT3xQuigxH3ehE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707549921; c=relaxed/simple;
	bh=L0POMOG7TrbiWGoQ5l3VpV9fkdZx5fLFEvO60spaDg4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sNp2sdxEaaJQyntalkTTy+jYYPRIC20nb/Eg8BDCI5sEpUVP0BN0Ig+aOqFIVVDqgJ4BbYkOKXJ7KdkexGB6tBZL0I4qGv0CJgOKP2FqsPwiJNsO5UZ51mN97wN0Y2bWd3S2wqYYI2y8y971xgPFTn7+lcnBOydaa0FR7lzHjmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=RvkQ25jh; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6dc36e501e1so1129603a34.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 23:25:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707549917; x=1708154717; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8m8phvJbCBaUpR//XQr5m++ylbpQ4FZPXh/gWEIh+SE=;
        b=RvkQ25jhHc3lzp0kdwXrt/WbI1OhHbjtwRYxdN7uuzWl3ztRGettY/kidqr6f4HU5g
         dUkxQW6xWXnQFPC6xzQ825cZfrVsj88g7opbbC/fmEgIj3PsbcO5r5JMPYZCBeI414vh
         3DU8GYlpg9GQsMhmPrabOqn0ggDgciefqKiG8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707549917; x=1708154717;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8m8phvJbCBaUpR//XQr5m++ylbpQ4FZPXh/gWEIh+SE=;
        b=BVflwvdP/r6dZhv4ILdoKOQj68SliTbzRMxpaqPmxCKCCcbiKURND6LAuk9Hd7phu1
         Djcdepq9ityCNFtPvIHCr/KaLUCdNC23uy8cDlsGsA85Ls2KIBnTasvaISDJUsP5hDg5
         epQ7Sz0SCWVu2BXVeZzXJ4UNHrdLi3/SX96duc+y2E73jc+0fbbYiNsKqnnggV5EavQe
         JwF5p277yiUX2JAHtz3l55bTc/sMKH27ldX04HmjxuOBVFNu6Y0MbEnisQfScH9lAGKs
         0t5wd7m3EFGhLXlKNSxxTKLb1cBxpqg4I3UeYytMCWbsF5sy0UF5c6x7L4mZfjP3vx5I
         VwzQ==
X-Forwarded-Encrypted: i=1; AJvYcCW8hlPH5BsLcq0Flaqxou86ZclobndedFcYuidAY6ml7hI8yd1TgQ79A9YKNDpEy1aXXfapTlXtAu/qa0067Sm45aV/T4eVJ9yIyixG
X-Gm-Message-State: AOJu0Yz4hXwpzRtZGtDkFQaXKd+VFSVZgcdWcyEANkZYOkSlI7sR6TD1
	X6E1GSWuVu3rNddds437dUslH/dUsmSDYD/ra7/yUbffTE+Jw5W7RUyVY8Uqaw==
X-Google-Smtp-Source: AGHT+IElngRtfqOH7jE59C2E77px2P+jsgE2ilQV5OGTU5uO/TGyfz9K4uKnQQ8sPYMnkLE7+Gwnww==
X-Received: by 2002:a9d:6c4d:0:b0:6e2:b26f:82d4 with SMTP id g13-20020a9d6c4d000000b006e2b26f82d4mr1634235otq.23.1707549917218;
        Fri, 09 Feb 2024 23:25:17 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXWI+Qtz60dxMswupBxoATcUXayLu78VKmIYUB1WV7w5wAxJbzvFP5mOZyvKdqJTtivs97R3xpPqAcG6vl0W3hrjqBLJ4abTYwk+uFosaNu9NdJAdot9OanBEGqJvAYdugjCCKGmU3qXq3nHO6ohvfy9z/1wmNye7lW0R82vCupE6IcNGcmvVnS992QdBjh6V2xzVuTC3KBjMuGsM8KMF6iTUNlj9uiU/ZC5CFyoOU2FD701MXJ+2OabJHC8M1bcn+tks2vNmnOpfZ6wsrgBtWP5KLzxwcSLinuPpDj8Kr38lYK4rLetIFt3Rk9JInWt3sexODtvyg7pr3a9fmWNh95LflZZhHTXIcEEYWdOwb6MZLNXl/zTJmrmqUPQ/3eibOXfibW7jArw5x0i5Poqd+OuYu7gax/GbQ9Se9v2sVd4WYblg==
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id y20-20020a62b514000000b006ddb0dde293sm1669384pfe.65.2024.02.09.23.25.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 23:25:16 -0800 (PST)
Date: Fri, 9 Feb 2024 23:25:16 -0800
From: Kees Cook <keescook@chromium.org>
To: Erick Archer <erick.archer@gmx.com>
Cc: Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] drm/i915: Add flex arrays to struct i915_syncmap
Message-ID: <202402092322.09287B8@keescook>
References: <20240208181318.4259-1-erick.archer@gmx.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240208181318.4259-1-erick.archer@gmx.com>

On Thu, Feb 08, 2024 at 07:13:18PM +0100, Erick Archer wrote:
> The "struct i915_syncmap" uses a dynamically sized set of trailing
> elements. It can use an "u32" array or a "struct i915_syncmap *"
> array.
> 
> So, use the preferred way in the kernel declaring flexible arrays [1].
> Because there are two possibilities for the trailing arrays, it is
> necessary to declare a union and use the DECLARE_FLEX_ARRAY macro.
> 
> The comment can be removed as the union is now clear enough.
> 
> Also, avoid the open-coded arithmetic in the memory allocator functions
> [2] using the "struct_size" macro.
> 
> Moreover, refactor the "__sync_seqno" and "__sync_child" functions due
> to now it is possible to use the union members added to the structure.
> This way, it is also possible to avoid the open-coded arithmetic in
> pointers.
> 
> Link: https://www.kernel.org/doc/html/next/process/deprecated.html#zero-length-and-one-element-arrays [1]
> Link: https://www.kernel.org/doc/html/next/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments [2]
> Signed-off-by: Erick Archer <erick.archer@gmx.com>
> ---
>  drivers/gpu/drm/i915/i915_syncmap.c | 19 ++++++++-----------
>  1 file changed, 8 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/i915_syncmap.c b/drivers/gpu/drm/i915/i915_syncmap.c
> index 60404dbb2e9f..df6437c37373 100644
> --- a/drivers/gpu/drm/i915/i915_syncmap.c
> +++ b/drivers/gpu/drm/i915/i915_syncmap.c
> @@ -75,13 +75,10 @@ struct i915_syncmap {
>  	unsigned int height;
>  	unsigned int bitmap;
>  	struct i915_syncmap *parent;
> -	/*
> -	 * Following this header is an array of either seqno or child pointers:
> -	 * union {
> -	 *	u32 seqno[KSYNCMAP];
> -	 *	struct i915_syncmap *child[KSYNCMAP];
> -	 * };
> -	 */
> +	union {
> +		DECLARE_FLEX_ARRAY(u32, seqno);
> +		DECLARE_FLEX_ARRAY(struct i915_syncmap *, child);
> +	};

This is a new code pattern for me! Trailing arrays of different element
sizes but with a fixed element count. :)

I hope when __counted_by is expanded to take expressions we can add a
literal. :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

