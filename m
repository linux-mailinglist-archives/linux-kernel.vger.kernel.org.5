Return-Path: <linux-kernel+bounces-89102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBC0E86EA73
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 21:42:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 378E6B29F5D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 20:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A21B3D55A;
	Fri,  1 Mar 2024 20:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SEUoTPHn"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C893D3BB
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 20:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709325722; cv=none; b=GqBLfZGqQ9RLn4BrhXYr6ja2p5QFIYkQBhDgE/Zq94O2wu93+H3UYhS7PPPJvrqhPzwTJ4EamRqTBs+MM2ID1CVP9Nmj5Tg8VGyE8trRqdGcwVIrrA7+8jJmjq8rBOv4excTIq7WPV2q4+04dN9VIh0mBtf52jIexykKGlkoO5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709325722; c=relaxed/simple;
	bh=b00h7L6AGlfaD5kvd71sZ7vd6gXSPpX60QhiF/qhUzA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S6YRyxFD3YgUxMNYPyzKjFDO+7ClpaXm0DX8rLnWFdXAAX0S1wKpg0lKJ2pALqGCCrX5fmvlR9aajTJEo9z1SDf/mE4iRZHcpWF5c5+78vFTuLkDSOVZjkaVvm4PLhcgabKEZFjhnozO0jJNQSVxr8H/MWSUHQO1heBk3wGeZiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=SEUoTPHn; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-5d8ddbac4fbso2270924a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 12:42:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709325720; x=1709930520; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=l8fnGBiVDyvj0+sJf46kp+vk3quKyy9Lc46ziSRLCxE=;
        b=SEUoTPHn2JRwBvVhJO/3HAb1PqWgDpVUy2Y6wftKnM9qb36vU1yO0P5JAoLtHIz39g
         Vhx/PL9u1UfMVRrDa/e3wy2YAZOx6ZQgmWNJEvImR4WQtuNNyL4fde10ppdyFYelSRyZ
         8aKheVPSidhC9OZxizwRDS86gn1jvyQYULShA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709325720; x=1709930520;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l8fnGBiVDyvj0+sJf46kp+vk3quKyy9Lc46ziSRLCxE=;
        b=UnClwt/Aj1AF8OQAwrohgm2iwDnocw82ajVkw9w9rQPTIHt7C6AzRYmY0DOQ7pQcm5
         KJ9mp5BfIMw/k9/kQGF2D8KyRukKagsH0tBC/oG3ziOnly7H6qB2DASlEF5ZiAlVuPKH
         4I5Uqu/r113ah0SEcWXJl6AUtmlZQjLNvVOGX4nuz2Ip4ptX/TNG2VbFPYa8amSK/6Lm
         s5imJ3hTgDomRPXn4dV56MnM5eQRH1yN+dPlY+fLj17g6OQRXcpjzpHUBXKSnAk5/5N9
         7bmMP9SvKMSViiGf9cuVy7d0srJCAGgQZh84tlHIlzcHPsYT/NzASI4veWjm9ab/PVGB
         fDTA==
X-Forwarded-Encrypted: i=1; AJvYcCX4Ze5jiy6SWMHqNf9Q0Btjn+wqVTP7u8wYUfBKXiGNi9i4cDJgVq4Uy5gHlpq0dM2rrvsqbdtXFih8FSaBRD124sZ7jEHk9O95T8hm
X-Gm-Message-State: AOJu0YzD5WVpoOdPtQsg/NRMJBWOMl/A/l1W0P9asUeJ4HG5atEU/MLe
	PKLXLnS8dWKwlaeS80UiwZ6VqDd16acPOugwDqRl13d3p9aZHGPeBHLTOdAtSw==
X-Google-Smtp-Source: AGHT+IEi6FI+IEbwGBctosMmFcuCICddCBpYdWwOsgDnXRw+Iqlkx7u/X41Y65hzbIQOLhuXmk2gFg==
X-Received: by 2002:a05:6a20:299e:b0:1a0:e4a6:2d86 with SMTP id f30-20020a056a20299e00b001a0e4a62d86mr2273919pzh.59.1709325720658;
        Fri, 01 Mar 2024 12:42:00 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id r6-20020a62e406000000b006e0416c42c3sm3375303pfh.198.2024.03.01.12.41.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 12:42:00 -0800 (PST)
Date: Fri, 1 Mar 2024 12:41:59 -0800
From: Kees Cook <keescook@chromium.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Mark Brown <broonie@kernel.org>,
	Michael Hennerich <michael.hennerich@analog.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH 2/3] spi: axi-spi-engine: use __counted_by() attribute
Message-ID: <202403011235.C326E3D46@keescook>
References: <20240301-mainline-axi-spi-engine-small-cleanups-v1-0-241dfd2a79f7@baylibre.com>
 <20240301-mainline-axi-spi-engine-small-cleanups-v1-2-241dfd2a79f7@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240301-mainline-axi-spi-engine-small-cleanups-v1-2-241dfd2a79f7@baylibre.com>

On Fri, Mar 01, 2024 at 02:25:19PM -0600, David Lechner wrote:
> This adds the __counted_by() attribute to the flex array at the end of
> struct spi_engine_program in the AXI SPI Engine controller driver.
> 
> Suggested-by: Nuno Sá <nuno.sa@analog.com>
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
>  drivers/spi/spi-axi-spi-engine.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-axi-spi-engine.c b/drivers/spi/spi-axi-spi-engine.c
> index d89f75170c9e..e801eed820df 100644
> --- a/drivers/spi/spi-axi-spi-engine.c
> +++ b/drivers/spi/spi-axi-spi-engine.c
> @@ -75,7 +75,7 @@
>  
>  struct spi_engine_program {
>  	unsigned int length;
> -	uint16_t instructions[];
> +	uint16_t instructions[] __counted_by(length);
>  };

You'll also need to change places where you deal with changes to
"length", as now accesses to "instructions" will be bounds-checked
by the compiler. For example, this change:

static void spi_engine_program_add_cmd(struct spi_engine_program *p,
         bool dry, uint16_t cmd)
{
         p->length++;
         if (!dry)
                 p->instructions[p->length - 1] = cmd;
}

-- 
Kees Cook

