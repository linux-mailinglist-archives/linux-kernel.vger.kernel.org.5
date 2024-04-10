Return-Path: <linux-kernel+bounces-139347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA5EE8A01AA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 23:05:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4B7D282A02
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 21:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAA8E1836CC;
	Wed, 10 Apr 2024 21:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ClXzkN3C"
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29571181CFD
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 21:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712783105; cv=none; b=IKyoMW46bPgLn1UCsFgJcVbpKiJZbgAkqOR6tO4AkHxPYscWjgzgoR+yW87FQL4fwmhVVCdedrRCXfjk0e98V0/+/tYeyH9TojyfyvlY+rZhAEUoZa5w4azZI6ZJk3nbEL24RyLC88uldFc0PKcm+ETZarBy/nw9RppPelERBvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712783105; c=relaxed/simple;
	bh=Epm6y+/+ewLDaCEGj8jeg26lhCahwkzccVZSayI3ovA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JqDuGEKdrOJfotVk59qoiU7N3ApLnVah9vwGMcuD9EGxk4JaOvK29G8SKpWlfNDDkO2E5n2HPCoaK8szRt92C9xfGq1cjzW8ZLJWTkCVi1gcks2YpRboVWhJpLjEiRFrEtwPtWuYix91ZMkvJFHji/vCNYyJQ1rt9VyjkumqsTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ClXzkN3C; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-7d5e3fb7f2fso148901439f.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 14:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712783101; x=1713387901; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5qCz8E3Di/VZoyQ+H4jHMjBhox36aDiBbL8BntpRuyE=;
        b=ClXzkN3CyH68JwPDsy0+DSvqvlUeBgFiCVyW1luq/5p8gW4pbxN9TmiPIleb007RrW
         c51Itp4a6oVurrYQbySFE8PUDgdA3HTgVHUE23lxd64PF2PG44SVPBr+DFkSyvodr+dC
         mMtT3m8HXzjSWIetg3oGSrcK89oJTT8/Q6Sg+vAJCGwiV4cXLfePzMB1gNRlhBSo8Jbx
         FgZwFhZnFAbJKB6wS430FcNYM9Kuzt3gyYyAwUipV6V1rP243axEQr/cLxuGXGkO+x1j
         wEW2Almj7UUlcV2jLtyXtKTLv46i2fJqHLwBoVMTD5OeiWLWJcdNI0cPqJzzomD/19MN
         86JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712783101; x=1713387901;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5qCz8E3Di/VZoyQ+H4jHMjBhox36aDiBbL8BntpRuyE=;
        b=vurpMMBmER/xUtLrxl0AToVBCDfp4Mz4odch3Oj3mMZFvs969UclDo18bwk5Gvz1N0
         0oMxsbdqUDpsURMCuuS2btmMc9Ez18CxL3QnEJ8mKzgkPaFdPV7H06CAFdB5sEnjpEza
         tcuJ3WonSKNxg19FZYX/akMn6L/Q5ZgBJXITPyOOJHJhWCh/p7/nLvlfAfmTPuvawk3+
         kNm5PvKgKuDM6OX1a9OLBjt6XnaLyPhDC6j9CcijtQJRcwjsOl1efJ0PxU1x+29pog7W
         czsE1q5aDCLB1eqsiDtOWSZ9GprtLwkPAdH/QgBM82s7cA1Ub7I6BgvJa/ejWgLiIz6p
         Ld+A==
X-Forwarded-Encrypted: i=1; AJvYcCVXSj3t9YLbt8wqUL8sT+eo5K9CiSnyHvZVsLnhxe9K1TD0NIKWcY1H0XE6i+RiXQHST9hqps+YxzL25xyECrzeUqMAwAITvJ2NmmmY
X-Gm-Message-State: AOJu0Yx8nPtRle6XxLJH6VXxRAJB+giaM0k16Jf8T8b9k6LK3PcNQlEO
	FjwvPRcs4MkgYaIaQ5zF4s6pKliBLkurLuDb6cam1rZZ286LKyCYXnAVT1Kniw==
X-Google-Smtp-Source: AGHT+IHN3/xecRCfid5g0bOH7LkZ8yJnDUd9LCUKGxMaS0A+hxkDrR8tOjgJoTgIYqX095KCqX+cBg==
X-Received: by 2002:a05:6602:4981:b0:7d0:c9c7:f52f with SMTP id eg1-20020a056602498100b007d0c9c7f52fmr5030577iob.6.1712783099842;
        Wed, 10 Apr 2024 14:04:59 -0700 (PDT)
Received: from google.com (30.64.135.34.bc.googleusercontent.com. [34.135.64.30])
        by smtp.gmail.com with ESMTPSA id n5-20020a05663831c500b0047be760081asm4119002jav.154.2024.04.10.14.04.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 14:04:59 -0700 (PDT)
Date: Wed, 10 Apr 2024 21:04:54 +0000
From: Justin Stitt <justinstitt@google.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: linux-kbuild@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, 
	Richard Russon <ldm@flatcap.org>, Jens Axboe <axboe@kernel.dk>, 
	Robert Moore <robert.moore@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
	Len Brown <lenb@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Masahiro Yamada <masahiroy@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, 
	Lin Ming <ming.m.lin@intel.com>, Alexey Starikovskiy <astarikovskiy@suse.de>, 
	linux-ntfs-dev@lists.sourceforge.net, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] [v2] test_hexdump: avoid string truncation warning
Message-ID: <fg6iv2dqwladc4d6tqzgg26mcyxz7c5bfn7gscic63c2qmhrz5@zvfm2btcf4fp>
References: <20240409140059.3806717-1-arnd@kernel.org>
 <20240409140059.3806717-2-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240409140059.3806717-2-arnd@kernel.org>

On Tue, Apr 09, 2024 at 04:00:54PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> gcc can warn when a string is too long to fit into the strncpy()
> destination buffer, as it is here depending on the function
> arguments:
> 
>     inlined from 'test_hexdump_prepare_test.constprop' at /home/arnd/arm-soc/lib/test_hexdump.c:116:3:
> include/linux/fortify-string.h:108:33: error: '__builtin_strncpy' output truncated copying between 0 and 32 bytes from a string of length 32 [-Werror=stringop-truncation]
>   108 | #define __underlying_strncpy    __builtin_strncpy
>       |                                 ^
> include/linux/fortify-string.h:187:16: note: in expansion of macro '__underlying_strncpy'
>   187 |         return __underlying_strncpy(p, q, size);
>       |                ^~~~~~~~~~~~~~~~~~~~
> 
> The intention here is to copy exactly 'l' bytes without any padding or
> NUL-termination, so the most logical change is to use memcpy(), just as
> a previous change adapted the other output from strncpy() to memcpy().
> 
> Cc: Justin Stitt <justinstitt@google.com>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

This looks better than the previous strscpy() usage.

Acked-by: Justin Stitt <justinstitt@google.com>

> ---
> ---
>  lib/test_hexdump.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/test_hexdump.c b/lib/test_hexdump.c
> index b916801f23a8..fe2682bb21e6 100644
> --- a/lib/test_hexdump.c
> +++ b/lib/test_hexdump.c
> @@ -113,7 +113,7 @@ static void __init test_hexdump_prepare_test(size_t len, int rowsize,
>  			*p++ = ' ';
>  		} while (p < test + rs * 2 + rs / gs + 1);
>  
> -		strncpy(p, data_a, l);
> +		memcpy(p, data_a, l);
>  		p += l;
>  	}
>  
> -- 
> 2.39.2
> 

