Return-Path: <linux-kernel+bounces-49621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C20EC846D18
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 10:57:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44697B2A82F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 09:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39D2077F21;
	Fri,  2 Feb 2024 09:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FCb8hUly"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E525182B5
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 09:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706867757; cv=none; b=C8s8PY/YR29wTDkB7QGmsutn3DQ+3ypHXB9FOj53ek4BCXqF00hPis7z+eYAN46v9mT8vsR5pp8Q+PEbZBYLC1iQ80JI5JEpMXHkDp421RBaGMBjmER7BaYXMrlptqK7VOYDeTKQ+CBpwW4yOfo5g3LUtutpiUYRfqWUnx7FxLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706867757; c=relaxed/simple;
	bh=O59W1rZXfNPZaBmcOLZqEilXjtgGOVSoG3S3sJTmryU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iUTSLwBvomE7doH56jXsOTuIdWo+hZMDiuJ0oaBr6QltkZpvYn9Zy6dL9nwAkLsCLiVn7qFXeGx2JIP0VSWc+0URD4msivHJS4Inpn2kKJkqf7ukLphWoLVpwpngw0IdvFQgytCJCfFdVDr1D8q1Y85z4kCu0ZLL2KP8HXPIShA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=FCb8hUly; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6dfebd129a1so894757b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 01:55:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706867755; x=1707472555; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RTZzqpSJXHe92TulTjdlacz0Q6VJoPoOCFnR5kE1oUA=;
        b=FCb8hUly/7Hn5k0AmkiM4TfRWo+WCZDdjKj27PEaFdeitQ1sLkIu1sizSHu0B4AXMp
         FtUzP3HrhQdpWvZKwhTaqmuEel7bp6D5kk1DdLGrWO86FPIzXFsL3kHlyptvjduO62v1
         6WUssa27+0sxIdg6MHDA0POjD1KGSwtl9N6gk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706867755; x=1707472555;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RTZzqpSJXHe92TulTjdlacz0Q6VJoPoOCFnR5kE1oUA=;
        b=sGm4Waz/zRDZ7qB+9jLDDir/uQwWkzAQQLpmjm+ZDHI+tElcD04yewrG20yOMexpX8
         xFZ2gGNKhndq0mTItGxpT0LGvcgFWjXgk1R7iLrShMRscN/UQm5R3pX1FJT9Mm56cpmQ
         fP8ILScZrHMoD5oxmuArN+2w275xySDgVt0dehsW13VjLkCxAB2xN5PpMAhfgE+aa6y0
         VEA91Nbqbu8tt4B8H4nklYf33kldOwCROQb37i5hydNEtR1ZXpEa16OpasRQtoOKnvnr
         212O7YNP1iscvesETlP5H8mOMm0jVd+P6rDVK1LvZ1GUJniFKAD1pkrJvVUnkdCiCIg2
         M9DQ==
X-Gm-Message-State: AOJu0Yz6WsmBydLflYrY9+ajqzVYQEm1PM5/BECIZsti2lwTIaOkibjl
	x4Cql0XTickMNDpe4Mf/mjzQHkUCUXNhcftJb/PEZMWy+IMmqNfsI+4yRO96CA==
X-Google-Smtp-Source: AGHT+IEzrY7FgpWZMJKnhp9KT2M9Lln/mb6GoYcRN70mwCqCp7SYfRGWQ+O4K6aa+SlbaPBZgBZjYw==
X-Received: by 2002:a62:d446:0:b0:6db:de89:d0f1 with SMTP id u6-20020a62d446000000b006dbde89d0f1mr1530767pfl.28.1706867755416;
        Fri, 02 Feb 2024 01:55:55 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUgwrw9CUQ6dYwjUU9bFmzxC3WSdwTLnKZ0VH/J0HM4XsNGZA8h/pYSnva3X7xrpG8FgYTkwtw+BXCgv0j+1JGbRDYLBD4n8L6kF6O3+1QdxQUBTxzeQ8v8FK9Md9h6S6XPPewYvaLH3Z6X5oiWTS6tNy4kKNJKPg==
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id t40-20020a056a0013a800b006dbda9a4e6bsm1197936pfg.44.2024.02.02.01.55.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 01:55:54 -0800 (PST)
Date: Fri, 2 Feb 2024 01:55:54 -0800
From: Kees Cook <keescook@chromium.org>
To: Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Marco Elver <elver@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Add UBSAN section
Message-ID: <202402020154.0266109CBF@keescook>
References: <20240130234634.work.003-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240130234634.work.003-kees@kernel.org>

On Tue, Jan 30, 2024 at 03:46:38PM -0800, Kees Cook wrote:
> The kernel hardening efforts have continued to depend more and more
> heavily on UBSAN, so make an actual MAINTAINERS entry for it.
> 
> Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>

I don't see Andrey on lkml in almost a year, so I'll drop the entry for
now. Andrey, if you want to be added, just say the word! :)

-Kees

> Cc: Marco Elver <elver@google.com>
> Cc: Andrey Konovalov <andreyknvl@gmail.com>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> Hi! I figured since I've been carrying UBSAN changes more and more lately,
> I would just make an actual entry in MAINTAINERS. Are you all interested
> in being listed as reviewers? Or would you want to be M: instead?
> ---
>  MAINTAINERS | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8d1052fa6a69..19b8802b2f12 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -22471,6 +22471,22 @@ F:	Documentation/block/ublk.rst
>  F:	drivers/block/ublk_drv.c
>  F:	include/uapi/linux/ublk_cmd.h
>  
> +UBSAN
> +M:	Kees Cook <keescook@chromium.org>
> +R:	Andrey Ryabinin <ryabinin.a.a@gmail.com>
> +R:	Marco Elver <elver@google.com>
> +R:	Andrey Konovalov <andreyknvl@gmail.com>
> +L:	linux-hardening@vger.kernel.org
> +S:	Supported
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/hardening
> +F:	Documentation/dev-tools/ubsan.rst
> +F:	include/linux/ubsan.h
> +F:	lib/Kconfig.ubsan
> +F:	lib/test_ubsan.c
> +F:	lib/ubsan.c
> +F:	scripts/Makefile.ubsan
> +K:	\bARCH_HAS_UBSAN\b
> +
>  UCLINUX (M68KNOMMU AND COLDFIRE)
>  M:	Greg Ungerer <gerg@linux-m68k.org>
>  L:	linux-m68k@lists.linux-m68k.org
> -- 
> 2.34.1
> 

-- 
Kees Cook

