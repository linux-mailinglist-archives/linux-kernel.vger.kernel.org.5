Return-Path: <linux-kernel+bounces-100840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA1F2879DED
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 22:53:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E4951F21B90
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 21:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35D97143759;
	Tue, 12 Mar 2024 21:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DcMXjwU6"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228EF143748
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 21:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710280429; cv=none; b=lS2LGfXJm5bSE8w1kir/lMSVxrIZFHXnRVFNk6YGHORizu7AKhi+6UQAv+QWkPRGDWg1MmOEUUkhaYEqGK0LzWGxOuEbBgZDeNDhv9s+G8R/YTJE0E5NPiVgUKeqqk370pJWSFbbeK/7wxtdGGDC6trIZey+HAjtuQOe9dXmF1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710280429; c=relaxed/simple;
	bh=G/4hgM5wTxTmcKRjygTzdn2/ODwGo/XzRcupSuCiDhk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P6/xnVuHiJZHGaNHpPCH9DQMjL+YF9k2mUnAHFs1IM2TIJBvghFqi8JIMwW1yjvDO65Eks0SYx9rdSEPm4YE86yRtvfU75DSdi3g8+HeXYgfPeRlqJD8yAWk+GsFRzjZQkdrcyzA5OsjobYQ3Hs0Wtp9zElQhEpK+Ps/EWOnXrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=DcMXjwU6; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6e46dcd8feaso3732040b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 14:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1710280427; x=1710885227; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WRdVUDa2pta5KTvFc1TATmL7fgNoVWU4s2HJtfq2h88=;
        b=DcMXjwU6D7ZrXjjXKE4tykgbSaRw0TFieADBO1R/PU2HXROSSmvjPox8tWcagM2njS
         UQ0ULslyDc2QlWNuhArc2JqJISt31OdL0q7odDIDghiq4/qqFYNPD+QIzVQSf6MfkSBJ
         ErRA3azwkH4JAnvq8ZcMaXI00exrsBAVTO1kU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710280427; x=1710885227;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WRdVUDa2pta5KTvFc1TATmL7fgNoVWU4s2HJtfq2h88=;
        b=FfaA9xmcGbA9JHgRFdDK4OwtCE6H7Tbn+TogBYB3+Qqsn7Dh+NhOxHteoUfqbpvlPs
         ha7EdvK0fR+fUlzKvugPMFacdGAzbv6tNig1XhA3HuEAp8BxDStZbg1USp/dfgZILmwl
         MNl7b3Nuo6SCPHmq9XEnhy/OOK905GkPQS0Q9w0tQ2XUKt2OMIyLfAbBTwcLvF86Or0H
         Bb6ybYsg/wk7VAmnnSBHKbKfuE4JkcQ6lXFt9BdBP1O2l6cDA8grtjfD8qx2R1I7M4tw
         8d3qcWn0V0eUxNgJ60DFwnwnkInk8yTz3RYFOgC8dNbDqZR4Gc37PdL8UseHp555m1d0
         VQTw==
X-Forwarded-Encrypted: i=1; AJvYcCXTCP+gbaUhMQSLvAA/u6lQVicDztfgG9/MrNd4ki9hRc7ffwywMgbVJ1larwtE7yFpJWeV6dOmQ4EMM4VmSihHc9xNgJGB6APzNOVC
X-Gm-Message-State: AOJu0Yygdgr0ZbyIq5pSvip1gAHv7SBjCSSVJR6/oVtaBhRlvFX45/KP
	E3Cpcu5YTjITe4yfO9LmPoBngk5ePmSO3bgfHENcEpBYQivqgcsJC4oDbH+chA==
X-Google-Smtp-Source: AGHT+IFqNTbSHg5S7yBJU7eqizCMy2N+F3f//0dRar/vDWfMpE1iigmGI34L3PlR68X94oFiT6tW4A==
X-Received: by 2002:a05:6a00:4fcb:b0:6e6:afa3:7b32 with SMTP id le11-20020a056a004fcb00b006e6afa37b32mr843588pfb.6.1710280427387;
        Tue, 12 Mar 2024 14:53:47 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id v21-20020aa78095000000b006e694719fa0sm4235092pff.147.2024.03.12.14.53.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 14:53:46 -0700 (PDT)
Date: Tue, 12 Mar 2024 14:53:46 -0700
From: Kees Cook <keescook@chromium.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Cc: Masahiro Yamada <masahiroy@kernel.org>, linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
Subject: Re: [PATCH 2/2] gcc-plugins: disable plugins when gmp.h is
 unavailable
Message-ID: <202403121452.701C91AF6E@keescook>
References: <20240312-gcc-plugins-gmp-v1-0-c5e082437b9e@linutronix.de>
 <20240312-gcc-plugins-gmp-v1-2-c5e082437b9e@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240312-gcc-plugins-gmp-v1-2-c5e082437b9e@linutronix.de>

On Tue, Mar 12, 2024 at 04:03:30PM +0100, Thomas Weiﬂschuh wrote:
> The header gmp.h is meant to be picked up from the host system.
> 
> When it is unavailable the plugin build fails:
> 
> In file included from ../crosstools/gcc-13.2.0-nolibc/i386-linux/bin/../lib/gcc/i386-linux/13.2.0/plugin/include/gcc-plugin.h:28,
>                  from ../scripts/gcc-plugins/gcc-common.h:7,
>                  from ../scripts/gcc-plugins/stackleak_plugin.c:30:
> ../crosstools/gcc-13.2.0-nolibc/i386-linux/bin/../lib/gcc/i386-linux/13.2.0/plugin/include/system.h:703:10: fatal error: gmp.h: No such file or directory
>   703 | #include <gmp.h>
>       |          ^~~~~~~
> 
> Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> ---
>  scripts/gcc-plugins/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/scripts/gcc-plugins/Kconfig b/scripts/gcc-plugins/Kconfig
> index e383cda05367..a664fb5cdde5 100644
> --- a/scripts/gcc-plugins/Kconfig
> +++ b/scripts/gcc-plugins/Kconfig
> @@ -10,6 +10,7 @@ menuconfig GCC_PLUGINS
>  	depends on HAVE_GCC_PLUGINS
>  	depends on CC_IS_GCC
>  	depends on $(success,test -e $(shell,$(CC) -print-file-name=plugin)/include/plugin-version.h)
> +	depends on $(host-cc-option,-include gmp.h)

Why does the prior depends not fail? That's where plugin detection is
happening.

-- 
Kees Cook

