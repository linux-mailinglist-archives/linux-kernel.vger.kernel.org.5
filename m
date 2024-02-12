Return-Path: <linux-kernel+bounces-61086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F702850D12
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 04:53:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2D751F24625
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 03:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F04A646A5;
	Mon, 12 Feb 2024 03:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="FUpJaGEq"
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB99B1876
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 03:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707709992; cv=none; b=kszupXv+Uwew4kDfTq+3aBBr+GfYVV2cB4kyUas3tHk8I547Y8LepU2ZBACpuvi/w3wri3Gi0ebYnMUx1Vg9ic0QbKLoIMRi6jSAeZNSCNWx7ovE9jP6ABf2Yjd8V8yQ/Z6DbhjqwN8lFikpKV3i0Q6YUCVRUtrYEqDlXV+GlF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707709992; c=relaxed/simple;
	bh=HkMCBw0DGHALj+SwJeNyQL3YJIfK1uCy0Bfa6T+jdJM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SxaY0BYNs2HMFbfOWFhSCDdq+4IU4yK7sqhmfnWZfX1p8mg8LOWwSZmA2zA4oeNvwIlPkSngrMFzLd8dCwMoNPK65UDhIxfItFwmLzjqnO42y/KxFDt8XezgXcdPwd6JN0NzrUWlou6VsTsEqLwa40j0D/8OggS9rG6spg5Xlv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=FUpJaGEq; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-dc742fc3b68so3141314276.2
        for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 19:53:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1707709988; x=1708314788; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=inoYkFy02Usw5aZpIo0v9tkTLH+MA6a15+xw5EX4KZg=;
        b=FUpJaGEqWbPSkjcbaUW6SWnad7qOWndHNN/I8bBiodMsMY/j2eToFu0CSs9HohhDAO
         JLt/Yd7ci1YhDalR7YHAKh/fEkbGsN/TDqYnQEtSAd5x9SowRfMzFZFYK5E5bVUuZd0w
         2yPkpsdFC2xFQsQXHqpiAkuGO4S4uRf5uJRUOnBvuRQ9XnWGAAfT4mA49EVbCZaPjuAo
         Nv8cixW4fbY5p7Mg4nB8tiOvuXL8hWrKqeiY8vD5iw3eSXXZdZZHcfx9OVujAFX7+JSj
         bIldEr0DZeIEuCMmcKdC9uTAHOVKp/qTq1QQa7jjm1EAB0RYRz/4eckM9flzmPpmZL0L
         xVeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707709988; x=1708314788;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=inoYkFy02Usw5aZpIo0v9tkTLH+MA6a15+xw5EX4KZg=;
        b=ffsdMxYUYJZYtMf4VQzPGAJq7fA1nNZoPJeA2j3wWqMB0AcvkUWsS9hbyTywAik6so
         tPp6jS96glx/qEoQI7UbFpjijlQ1j88mvYIwM8iO70qZRz//iqtuvRSQYhdQX/MDthfj
         DFnQzco1sLqAiuBCNnIYviNkrA6M/IiHqO4vrCI6tiCMnqr1juOayZ8QOkxqxA94wfX6
         85C/cnJG2fwGVZfbnznbMnrxf8dbwdHjv54NwNJXpxfdSBLiU2UeJL90beEjbR5t9Fii
         zxM8+rkaERlfnioigFNfv1003CLFyNzry4ewx/ujwOEjLELpLEdLN83vX0oKfMUH5poR
         6tSw==
X-Gm-Message-State: AOJu0YwROVyyUM15Xxt/CHBebneMHGTsmhBYVHdRa5z3FAR231AQWwQw
	DPWGmYGt/bYVgIXZE9wxl+uuqI3FJosSvmbHx8JtAfp914WcMLo+IdJfTXXEIbM=
X-Google-Smtp-Source: AGHT+IHL5MMYEd6Tdu2zhzq3q3mUC0DiI3Id8m1CcO2LYxT5rJcWGiFEws38+qzB6pZwj2tc2hfMHw==
X-Received: by 2002:a05:6902:1b90:b0:dc7:443d:d9da with SMTP id ei16-20020a0569021b9000b00dc7443dd9damr5276409ybb.4.1707709988724;
        Sun, 11 Feb 2024 19:53:08 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWxRCBA6JSrWoNOmSBHvQf6ESrYKH1hwruGLxZRxzTpi22WVw8Zh02svYy6czO+Oebs6yEURoeqiGjs2EbvjVYTaJJ7SYXcjUatOekFnR3JBPHY2vrgP8nVOcY7R74nPTohxElbXP0sRsqSbCHso925i9S5LbST0C601VGvLw==
Received: from ghost ([50.146.0.2])
        by smtp.gmail.com with ESMTPSA id t5-20020a25aa85000000b00dc254858399sm1117808ybi.2.2024.02.11.19.53.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Feb 2024 19:53:07 -0800 (PST)
Date: Sun, 11 Feb 2024 19:53:06 -0800
From: Charlie Jenkins <charlie@rivosinc.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
	Palmer Dabbelt <palmer@rivosinc.com>
Subject: Re: [PATCH] MIPS: Add 'memory' clobber to csum_ipv6_magic() inline
 assembler
Message-ID: <ZcmWIhn8/G2QK+jP@ghost>
References: <20240211160837.2436375-1-linux@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240211160837.2436375-1-linux@roeck-us.net>

On Sun, Feb 11, 2024 at 08:08:37AM -0800, Guenter Roeck wrote:
> After 'lib: checksum: Use aligned accesses for ip_fast_csum and
> csum_ipv6_magic tests' was applied, the test_csum_ipv6_magic unit test
> started failing for all mips platforms, both little and bit endian.
> Oddly enough, adding debug code into test_csum_ipv6_magic() made the
> problem disappear.
> 
> The gcc manual says:
> 
> "The "memory" clobber tells the compiler that the assembly code performs
>  memory reads or writes to items other than those listed in the input
>  and output operands (for example, accessing the memory pointed to by one
>  of the input parameters)
> "
> 
> This is definitely the case for csum_ipv6_magic(). Indeed, adding the
> 'memory' clobber fixes the problem.
> 
> Cc: Charlie Jenkins <charlie@rivosinc.com>
> Cc: Palmer Dabbelt <palmer@rivosinc.com>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  arch/mips/include/asm/checksum.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/mips/include/asm/checksum.h b/arch/mips/include/asm/checksum.h
> index 4044eaf989ac..0921ddda11a4 100644
> --- a/arch/mips/include/asm/checksum.h
> +++ b/arch/mips/include/asm/checksum.h
> @@ -241,7 +241,8 @@ static __inline__ __sum16 csum_ipv6_magic(const struct in6_addr *saddr,
>  	"	.set	pop"
>  	: "=&r" (sum), "=&r" (tmp)
>  	: "r" (saddr), "r" (daddr),
> -	  "0" (htonl(len)), "r" (htonl(proto)), "r" (sum));
> +	  "0" (htonl(len)), "r" (htonl(proto)), "r" (sum)
> +	: "memory");
>  
>  	return csum_fold(sum);
>  }
> -- 
> 2.39.2
> 

Thank you for looking into this. It fixed the failure on my mips64el
qemu setup.

Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>


