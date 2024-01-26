Return-Path: <linux-kernel+bounces-40800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D680283E5D9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 23:57:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A244B22A7B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 22:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9929156473;
	Fri, 26 Jan 2024 22:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EpDBaDip"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B3155C36
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 22:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706309853; cv=none; b=azgd1ayeBpuuZMFT1/6O6/Ssu3rEr8hmNuszAc2In3REIMijJ/MTSjiyNjE4JAHGb0Z6eRQfO4Xu04ED/WsTgwMhROr4plVVWjj0BUCjPvGhvVkCRHJowxvt/ZDnw9N2uCFZm5yCf46yBeTG/P/8GqpmV/tVl9ML7iuMLfVMhvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706309853; c=relaxed/simple;
	bh=Zm28gy7JneQI86vjRiocJqTdrtybNTFIpBfp44vYclc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rS+7EN6sgZ/oSDrOySWg5Hi/CvP2L9+3B751oQdOr7dr0dlhc/VRDfzkmqIUzNOZ9h/fvP8Ra3lPLpnne4TcCOI9m3f2biUTzEZZcOwZS3RofjcQYMr02/50jNLaILgUU3MuAA/L4dimDOunemxL+wLAzv4agXk51Vk5cHNsGI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=EpDBaDip; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d7881b1843so8611705ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 14:57:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706309852; x=1706914652; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gNeQV+teY78A4CeH6MOUnq15lI/jHlKDDnV2ttEl5UM=;
        b=EpDBaDip+p2gkkUEisyEBiC+ZEK4KHlFaZkIisdXF0E/pS53NqYqDwi3o3b3cTvdtb
         swS5BqrYS9VHX95bAcjWgG1hQ8Jngwv01+rKjeIUMKJGjeUsGmU5R31sU/2bRcWddttT
         9V3GyJ2nWV2qSE/4pXXaJCVPNGf164TgQEbaA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706309852; x=1706914652;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gNeQV+teY78A4CeH6MOUnq15lI/jHlKDDnV2ttEl5UM=;
        b=HUMiRppYtrKmdireKNnnYGo87DF/UpIWVqOkMPM5zwBdIrHLmqBU4hnDcZdtYi289I
         pRGrQ163XjKN+Ine1LHLfytxeFOdal7Y/IwYuAqc1BGuxxX/Rqu0HruqkFvOPFCmj3fj
         BcwKoN26igMIJDqotrnfhPqDzkZ5K9lk4lmXkfpYGdcKOtbrraZFDWIm0K9W05XN1XHC
         grprA8huweq39bc5g9DtDKqmIJanIzJMwz0ujYDcnfR4oxqvjg606t3h6txEIpN7pJAi
         TdGGKXmA6hSe5TOXXSnN1c3WpTCudH+getaBMnb6Bj+CSvzrm6ZhWDRaGSaqe9IG/8GZ
         mwgA==
X-Gm-Message-State: AOJu0Yyt6/jSFzi+AC5WCSad+JVbP4+wrXwhIImClrrTLH0sYh2IU0ez
	GAkCwNZIZXOVdqJ16I/6QZ2Gp/voklxJR5z5/SBbAHxQrK2nLkWD6PubmcY/kA==
X-Google-Smtp-Source: AGHT+IFa/a51ef4u5Txe4lN0/riq4dPPU5C/s4ogKAjOdUPLp9voycoxbrQZLW13AiNuVW2M7eXSjw==
X-Received: by 2002:a17:902:ea08:b0:1d7:24a3:278 with SMTP id s8-20020a170902ea0800b001d724a30278mr627215plg.91.1706309851913;
        Fri, 26 Jan 2024 14:57:31 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id m9-20020a170902c44900b001d71649bf9asm1413199plm.252.2024.01.26.14.57.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 14:57:31 -0800 (PST)
Date: Fri, 26 Jan 2024 14:57:30 -0800
From: Kees Cook <keescook@chromium.org>
To: Justin Stitt <justinstitt@google.com>
Cc: linux-hardening@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>, llvm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/82] overflow: Expand check_add_overflow() for pointer
 addition
Message-ID: <202401261456.3D126A50D7@keescook>
References: <20240122235208.work.748-kees@kernel.org>
 <20240123002814.1396804-1-keescook@chromium.org>
 <20240126225257.lfgeom4rhjzx2wrf@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240126225257.lfgeom4rhjzx2wrf@google.com>

On Fri, Jan 26, 2024 at 10:52:57PM +0000, Justin Stitt wrote:
> [...]
> >  /**
> >   * check_sub_overflow() - Calculate subtraction with overflow checking
> 
> Does check_sub_overflow() deserve some more love in the future? I
> imagine "under"-flowing pointers is not at all common, though.

Yes, though I hadn't found any cases of it yet in the code, so I didn't
want to add a helper that would go unused. :)

> Nonetheless, this all looks good to me.
> 
> Reviewed-by: Justin Stitt <justinstitt@google.com>

Thanks!

-- 
Kees Cook

