Return-Path: <linux-kernel+bounces-112582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 895F1887BAA
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 05:38:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBAE71F2151D
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 04:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 961B7134B0;
	Sun, 24 Mar 2024 04:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J3uzB4+K"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13FB728F1
	for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 04:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711255088; cv=none; b=bVylm2zTThS1BXqMhs9BUWlOF6WpFpKnjw7QoMmKViQYc7Hk3slAY/6F2TlMXFQoESJ6LhyFS5b26ggMQieG/0uvViyGPZKAhcw9cUxnxRaNrbwT/TdqtClfJW2Jx2Pv69b12m+wV0fdZtoj1H0t4XrmA3VSBCcvt3pGEkvEs68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711255088; c=relaxed/simple;
	bh=cY0I4yvinqbpTlBh/88UJRdHedECFcvi1rqbqKFLi0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZRblbFqc+8l8z6DpZM6cR/8JYA0UiNG8ZShhwm/kvemqVorwDH1c2d+rDRsEMgIpoJUcYitM30vvO1Uj+qqX3dYgp5RaXvhV4ZfbFeIaVB39Qnyl6dhu7VXMRN5F0wikrCEh+GdOuFobgaqHki94zjm59QA+XTaafYzWux6JqP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J3uzB4+K; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4148678b526so934005e9.0
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 21:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711255085; x=1711859885; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XfqfORZ3SpUnxkQFpfbZwZ033SwpXLSkD0EZp4G9OUY=;
        b=J3uzB4+KR7gD5fg5EGNdsOJ1uYXnAwPl9OKCF6i4tmis+JCcLJoSfTBiKuQ8tATfVm
         ncZxRG21H+1RSg8NF+WgggJNMXF5RewOi/LY47X2Dcy/Ycu1Pcn8rurCafuvf4uSOXIP
         xLvcUksdcu+9yh69okOchWWgmFOLHV1w5sVtnqeAqVSQDfX1ntLjwP0oya+hpNSHv4Zk
         CLMbNjdrMD7y17/NUeIeJKnDUv1FSogmYpMo3RaEEa1HTScMvA9AMes6ktmVCZ5vG6br
         EeCUUUo3APxhN61k68b2LlUHprVmOdY3KAq2LfrPGxf+C+7vFhwmS4JssKSftYLK6heS
         Hf1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711255085; x=1711859885;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XfqfORZ3SpUnxkQFpfbZwZ033SwpXLSkD0EZp4G9OUY=;
        b=eU+A6Kbj6RkPLsDa6ihL5H5G5gH9AeliATHPF5rJ6KPhebWwsJtxBd8ZJpXDqNHlh5
         Z/3H9XdO55TwPaoktGJ3oM7f3Q5ZunGSuNHsticHPjsQzKFBOzz+qu4IodhgVYm9jR48
         UbieL990NSiMDbachxo+1WnUISkzyS+nVaUfsMwHEE8WUXxbQ4rCQdWCs/MfaTDaxY3u
         OlLxLP9W77MFeF5k+x2YyYMnHvr8oVEoReUb+zTmvzBkNxs4qhxM8Zs29P2Ke54SbStD
         ny7FKcmz1KGrB9lt2v6b9M9f8tJBtpBvYkxC3TCsjvWyTK7cZGMeh9R7zYWq/qTiEz41
         gnFQ==
X-Gm-Message-State: AOJu0YwC3BxVUE6rP+PjCId/zUxofCRv1XcHLGbPflEjLnx7Te4bUBux
	PuNYL2fkK6Qzbg0BjL3tgDBRy+NWeM9uUuV31YUwp7uvmM0H8U+J
X-Google-Smtp-Source: AGHT+IFvg4Cgu+saKz2RC2ss+96XNPVDk6ND9DwuGtog9GrytzwRK4lpBrYlQ6Sn91hVJ5ls5qO5qw==
X-Received: by 2002:a05:600c:1382:b0:414:c5d:8520 with SMTP id u2-20020a05600c138200b004140c5d8520mr2611355wmf.27.1711255085163;
        Sat, 23 Mar 2024 21:38:05 -0700 (PDT)
Received: from gmail.com (195-38-112-2.pool.digikabel.hu. [195.38.112.2])
        by smtp.gmail.com with ESMTPSA id g4-20020a05600c310400b0041462294fe3sm4153320wmo.42.2024.03.23.21.38.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Mar 2024 21:38:04 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Sun, 24 Mar 2024 05:38:02 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Dave Hansen <dave.hansen@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, jgross@suse.com, tglx@linutronix.de,
	x86@kernel.org, bp@alien8.de
Subject: Re: [PATCH 1/4] x86/cpu: Add and use new CPUID region helper
Message-ID: <Zf+uKi42qFoHLAUg@gmail.com>
References: <20240322175629.01E8B39D@davehans-spike.ostc.intel.com>
 <20240322175630.72CE974F@davehans-spike.ostc.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240322175630.72CE974F@davehans-spike.ostc.intel.com>


* Dave Hansen <dave.hansen@linux.intel.com> wrote:

> 
> From: Dave Hansen <dave.hansen@linux.intel.com>
> 
> There are some (before now) unwritten rules about CPUID "regions".
> Basically, there is a 32-bit address space of CPUID leaves.  The
> top 16 bits address a "region" and the first leaf in a region
> is special.
> 
> The kernel only has a few spots that care about this, but it's
> rather hard to make sense of the code as is.
> 
> Add a helper that explains regions.  Use it where applicable.
> 
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Juergen Gross <jgross@suse.com>
> ---
> 
>  b/arch/x86/include/asm/cpuid.h    |   59 ++++++++++++++++++++++++++++++++++++++
>  b/arch/x86/kernel/cpu/common.c    |   13 +++-----
>  b/arch/x86/kernel/cpu/transmeta.c |    9 +----
>  b/arch/x86/xen/enlighten_pv.c     |    9 +----
>  4 files changed, 69 insertions(+), 21 deletions(-)
> 
> diff -puN arch/x86/include/asm/cpuid.h~cpuid-regions arch/x86/include/asm/cpuid.h
> --- a/arch/x86/include/asm/cpuid.h~cpuid-regions	2024-03-18 15:12:20.676308753 -0700
> +++ b/arch/x86/include/asm/cpuid.h	2024-03-22 09:17:13.296507986 -0700
> @@ -168,4 +168,63 @@ static inline uint32_t hypervisor_cpuid_
>  	return 0;
>  }
>  
> +/*
> + * By convention, CPUID is broken up into regions which each
> + * have 2^16 leaves.  EAX in the first leaf of each valid
> + * region returns the maximum valid leaf in that region.
> + *
> + * The regions can be thought of as being vendor-specific
> + * areas of CPUID, but that's imprecise because everybody
> + * implements the "Intel" region and Intel implements the
> + * AMD region.  There are a few well-known regions:
> + *  - Intel	(0x0000)
> + *  - AMD	(0x8000)
> + *  - Transmeta	(0x8086)
> + *  - Centaur	(0xC000)
> + *
> + * Consider a CPU that where the maximum leaf in the Transmeta
> + * region is 2.  On such a CPU, leaf 0x80860000 would contain:
> + * EAX==0x80860002.
> + * region-^^^^
> + *   max leaf-^^^^

Minor nit:

 s/a CPU that where the
  /a CPU where the

> +	 * possible for the last basic leaf to _resemble_ a
> +	 * valid first leaf from a region that doesn't exist.
> +	 * But Intel at least seems to pad out the basic region
> +	 * with 0's, possibly to avoid this.
> +	 */
> +        if ((eax >> 16) != region)
> +		return 0;
> +
> +	return eax;

There's whitespace damage at the 'if' line.

Thanks,

	Ingo

