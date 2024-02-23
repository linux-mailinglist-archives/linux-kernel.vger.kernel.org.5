Return-Path: <linux-kernel+bounces-79327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 517C48620D0
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 00:52:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC2991F2437A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 23:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F39F014DFF8;
	Fri, 23 Feb 2024 23:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MvDk78s+"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F2F14DFD4
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 23:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708732323; cv=none; b=WJ0C7xJ0sH/d2jGDE7ykXE9ywtPeoKsQy+tKrrUngCkO1kkrQ+FoKc9YGZiGMmh1rF11ALXHH7nLio6Y54QCJXich+uvVN7/ngxz/B5mQGpJbKg/7gbHjLVkV/xofKh+3P4NkziTuftSFsZoqBnObqKoW2etFeJZAa317wehwfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708732323; c=relaxed/simple;
	bh=GHuNMsqWXJuF/kg0+z875A2i/BTrjQmPOaqdumwnZn4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q3a7lVk65yfX6pl8GFB1VsVpD/xfJ5Lxi33l3bcivboAIy4U3lLXj21oXxoaOvG8oviJrcheP1jdujNP4CVseocL8K3S79VDnlbSBW2Jg6ge/iEbaRRresdUtvb9jhq5h/7Du1zhDG+ZqsBquS5oe5rWt/SdVjXOOXZ0Zdhjulk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=MvDk78s+; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1dbae7b8ff2so6017865ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 15:52:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708732321; x=1709337121; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JLZflnFtR+MomtbJ09mQku5GVn57VLGAF/Xrv5PCZG0=;
        b=MvDk78s+aFAjzTC1a7ODrPD0l7xtefq3Jum7NSDymx7wT9bbL4u8RZiwAUE6e1d2wV
         c7coTp5aAPKlFlEDJETRJPrWKl5Rhe4Qi7h3DJThPxTkPbMwe+eDf8uzI2Iz5iL5swdJ
         KWqRQ8pAgJMEMz7hSfl7OnwIkyMEMRIouJhIk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708732321; x=1709337121;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JLZflnFtR+MomtbJ09mQku5GVn57VLGAF/Xrv5PCZG0=;
        b=PCay0iAcCvZHic+Al0zwumW7L4/UUTFn8w6D5y00fPRjbRdjz/9cMeDV5ACp1VW5zA
         Tz/IhLgkGEvBvkd7fvSe/HVjYvDjXdoRVwhi45g+KgNStQOY3HqR0qA8/u/viD7P+l/j
         aTRKOOVb76RAdZGlf8xFLSpiaQv3hykrBhN/Rzjn9m05ijsano00Gtvq/TrMH/xTNx98
         qeon7yJOwMqtfKgy4iwomSPuulkDH6LrJY+nFxinU9Rbgn/FFyw7qD/3wBxYTP7Sys58
         Ej9T4YibZJ2KsIvJbsO3RzA3R+h4gETiXNjtFCGL1j8BT/U5iCXdRv0DvjpSyTBGKE06
         12PQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwRnE2I60TEmPMGJjCd/vZoOCH0wOG4XlowsmL8XSI5jlngFgrgKE5424p8sRLFJ6AwoW2qQJ6XHev31tRoLlnklORg30f/7GM0cjW
X-Gm-Message-State: AOJu0YyNcjiCCvzqXcw0nnSXz/y+Aj3kNiz2JrKtj+kvHyIQKw0tkQgv
	Q3QaWwJ16n0ayBLdr5DNulX1Na+Sg+Jqnqb0mDaqgBncMUu7vgapIV1j9HMc0w==
X-Google-Smtp-Source: AGHT+IFFyNuCCx0hnNDUwiZnyXaUbeIjzlqiyryn7pZN+bOQKRIR1yW1knjt1lMaQCZnLltrZwdoiQ==
X-Received: by 2002:a17:902:db02:b0:1dc:2d4d:45a1 with SMTP id m2-20020a170902db0200b001dc2d4d45a1mr1859775plx.19.1708732321176;
        Fri, 23 Feb 2024 15:52:01 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id h15-20020a170902f7cf00b001db7ed47968sm12212835plw.30.2024.02.23.15.52.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 15:52:00 -0800 (PST)
Date: Fri, 23 Feb 2024 15:52:00 -0800
From: Kees Cook <keescook@chromium.org>
To: Jann Horn <jannh@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] x86/boot: avoid recompiling kaslr.c for incremental
 rebuilds
Message-ID: <202402231550.80B97C8E@keescook>
References: <20240220192144.2050167-1-jannh@google.com>
 <20240220192144.2050167-4-jannh@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240220192144.2050167-4-jannh@google.com>

On Tue, Feb 20, 2024 at 08:21:44PM +0100, Jann Horn wrote:
> Currently, every kernel rebuild needs to compile kaslr.c again because
> UTS_VERSION changes on every rebuild.
> Move the build string into a separate object file to speed things up.
> 
> Signed-off-by: Jann Horn <jannh@google.com>
> ---
>  arch/x86/boot/compressed/dynamic_vars.c |  8 ++++++++
>  arch/x86/boot/compressed/dynamic_vars.h |  3 +++
>  arch/x86/boot/compressed/kaslr.c        | 10 ++--------
>  3 files changed, 13 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/x86/boot/compressed/dynamic_vars.c b/arch/x86/boot/compressed/dynamic_vars.c
> index cda64ff4b6da..15a57fbb05e3 100644
> --- a/arch/x86/boot/compressed/dynamic_vars.c
> +++ b/arch/x86/boot/compressed/dynamic_vars.c
> @@ -1,9 +1,17 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #include <linux/const.h>
>  #include "dynamic_vars.h"
> +#include <generated/compile.h>
> +#include <generated/utsrelease.h>
> +#include <generated/utsversion.h>
>  #include "../voffset.h"
>  
>  const unsigned long vo__text = VO__text;
>  const unsigned long vo___bss_start = VO___bss_start;
>  const unsigned long vo__end = VO__end;
>  const unsigned long kernel_total_size = VO__end - VO__text;
> +
> +/* Simplified build-specific string for starting entropy. */
> +const char build_str[] = UTS_RELEASE " (" LINUX_COMPILE_BY "@"
> +		LINUX_COMPILE_HOST ") (" LINUX_COMPILER ") " UTS_VERSION;
> +unsigned long build_str_len = sizeof(build_str)-1;

This can be const too, yes? (Also, you didn't want to include the
trailing NUL in the xor?

Otherwise, yeah, I like this whole series.

-- 
Kees Cook

