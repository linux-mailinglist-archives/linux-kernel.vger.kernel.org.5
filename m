Return-Path: <linux-kernel+bounces-60175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91BD485010B
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 01:20:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C56311C22F4F
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 00:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6926B111E;
	Sat, 10 Feb 2024 00:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gaoYixg3"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5339B366
	for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 00:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707524415; cv=none; b=b3WD9s49jfa9d3zRpLcwl2j8ocGafrFUwLHzncmU/Q0R9iw9ZyY+1yXtzjoWsBbsCIqhX2DmwuC+gz9N12WVQySSIJyI3I7sZ5Fqem/l+R1n87vWD2/XEdMtYrbCeO+zEUQFb36biS4IZdjNIjprHfusQXqLMyZUJoAkw6h4IdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707524415; c=relaxed/simple;
	bh=0xSehnWOhUJDEMMPQy+ntR0zNBeZLK2efFoW8K5pQW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gTe7OKLYT1FMyh728h6uN9AS7SIgmeAfTBrXDPTtmTsXhIh2dKmuQ5bx7Sfw7H/YGO9d6bRximgGT2j7ujfGtitI2MZ6O3hSsgcSNhIGZWFIxaA9nAMOVFi1PiAOv0WLj1wKJTRijw0D5s+IMHV/j9+Xc6yfpee2ijqLS9kqduY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=gaoYixg3; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6d9f94b9186so1320624b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 16:20:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707524413; x=1708129213; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3xeDP/fFDWc1FaB3KHKxe3CtekZS5GdE8FoXXkdCZ34=;
        b=gaoYixg3PNHBdwUBDMXHehi9CaXeK6Qk0G4FfuhFiYKBMWLoJLPjHdCbVuR7U8Vjr4
         JacuUe1IdJVUzRFzqCN6kJokJR3tJR8ekYnJ5uj1IpwOdzC3SDeCVB0X3uYaL4R/RzUO
         ATlbnusNZAyE8zXJabGAHpi1JAnPXSo+/gDzM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707524413; x=1708129213;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3xeDP/fFDWc1FaB3KHKxe3CtekZS5GdE8FoXXkdCZ34=;
        b=kN/NXy9mAEq5De3nuf+J0QSF1bLLQriS4fcqDK4sFXk+MOxDA8Wx6Rx+0XOsUwlmzF
         IJBtvLTGKwEWlwSvmnYbhtg3bf+NhIyB0soAnplp3lgr4eLJzt0cYdTaA0nP1wkyAbVu
         t8ijREJbskbVHJvSwrwrQP4C/sH2kSkA4d837biGb3/5PVA6f8bP+roo01RG4po9dZK3
         W1e6URdP/k756HwU6TueWH41nMR/yhlnFV3fRHCgiOHI2SPJAv+uTvlrOG4ijtat1cyB
         tcEnS6CtsDR4J2w0RCKCMOgMghzBchzczNFmhpaG+bprMByGNzme6FnB7V0T38rvsjs2
         0Ykg==
X-Gm-Message-State: AOJu0Yywmj4GzYow1nUbFfkGoPyC07/vWzURLD9YJxPEUT2w4uyAOqx9
	Ms9NDvAWWTCsmnl1jQoz2C13w+K9J1rpLCIwvF/olYNa3GktcihsK+oFdTkxmw==
X-Google-Smtp-Source: AGHT+IHGG5bvzmrn9ED2lC8Vqhz6kp2tJlcSJ6X+2ZZPbLUQCb06KGLYHbjXDO+ph4LGoZZBo0zjCA==
X-Received: by 2002:a05:6a00:1743:b0:6e0:540e:bf43 with SMTP id j3-20020a056a00174300b006e0540ebf43mr1056819pfc.33.1707524412865;
        Fri, 09 Feb 2024 16:20:12 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUfGHrJnljx2XckhnLiwGzFjO3g2MweYpXgXRSyekz83OtnJ4E1hV9lD09ACuUqtjeI/EcAe1tWbe9p+8pVU/BLGCarDM5pMfvdK9vVNvzszS6mMFUOHQbddOr4mD+ZXtFOZqrrHGxxAVb9vvc5udKrovz573DrrRfHcTgx0RpvByblN9FN/Ce06tjyTQHOjM3jSo/n4gZD6M6ztWUk4CAOJ6aekeZuOiqFHWKB2sotfDTaW06TPhvCwmyAcnJPwUxt+vwDVhLVm6ma3peazCo0NbWKwRY3eRJtz7p+JNCClOE+Qca0g2eJrrh7UYLrx6wt3TwZvcrZJTfSvvwcklYYPg==
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id y20-20020a62b514000000b006ddb0dde293sm1136147pfe.65.2024.02.09.16.20.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 16:20:12 -0800 (PST)
Date: Fri, 9 Feb 2024 16:20:11 -0800
From: Kees Cook <keescook@chromium.org>
To: Erick Archer <erick.archer@gmx.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] irqchip/irq-bcm7038-l1: Prefer struct_size over open
 coded arithmetic
Message-ID: <202402091620.006E59FF9@keescook>
References: <20240209183128.10273-1-erick.archer@gmx.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240209183128.10273-1-erick.archer@gmx.com>

On Fri, Feb 09, 2024 at 07:31:28PM +0100, Erick Archer wrote:
> This is an effort to get rid of all multiplications from allocation
> functions in order to prevent integer overflows [1].
> 
> As the cpu variable is a pointer to "struct bcm7038_l1_cpu" and this
> structure ends in a flexible array:
> 
> struct bcm7038_l1_cpu {
> 	void __iomem	*map_base;
> 	u32		mask_cache[];
> };
> 
> the preferred way in the kernel is to use the struct_size() helper to
> do the arithmetic instead of the argument "size + count * size" in the
> kzalloc() function.
> 
> This way, the code is more readable and more safer.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments [1]
> Link: https://github.com/KSPP/linux/issues/162 [2]
> 
> Signed-off-by: Erick Archer <erick.archer@gmx.com>

Yeah, looks right to me.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

