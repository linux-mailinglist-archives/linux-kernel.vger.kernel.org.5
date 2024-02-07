Return-Path: <linux-kernel+bounces-55762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3580E84C15C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 01:32:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 910FC1F254B7
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 00:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C6434A0F;
	Wed,  7 Feb 2024 00:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KYbiyfde"
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF22A8F5B
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 00:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707265952; cv=none; b=H2YvPn5I28VX2tuKaX6rGip9fCvP069V7Ljhdiv4ejJc78H9e9PINGdmhTnXsJ9oOtRBvQr1JKQ1PcCGrocTSTfhaTwGONH8QMC3ugH9eu96L4lxsEpitdTaq9JBE7dR6cxYbS/7A+DxmD/2k1qg5Jt+PTmKOJ92/8g6nVM2fRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707265952; c=relaxed/simple;
	bh=ax4kbwR1wG2ecwpHsW2swGQp3y7VpR79Vvh+CgItsug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u173U8ddfZt8GfEUegsH8cSFgo9duoKcpFCvmhI9hH5DTTfMvqqcxm8j7Ysw8ulYBa1djFwFL+97bC/7oMHYUdMB5pG5T2pdC4MPUf8TRBCmvqkzVuq5Q8w9G4VcJP529dCOb7wwIn0K+NXpfOU7e83YeKjAE4zx5ScwwzZb9z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KYbiyfde; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-7c01af010bcso3415439f.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 16:32:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707265950; x=1707870750; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QJXlby+AD30AsP8JwtKyQnYYLLwLHxDqcJGOtskX1jw=;
        b=KYbiyfdeSfwTPP2NVxxfCUMOF06JOc0Dhu1QtOsyxzSH/iyKgbpTvBtLv0CB13hXKs
         OZiTi7P3N7ZEM+TDwspeORv3wdckfkEUCfnKdw4lNOEoVp7w8fMaU0CRSvc+gcZ64/gi
         um8ous412hq2o3sI0LfxM/u33qnFOKLCO2vNgSKQttURnjKsIVEo1l+0FFnQ/EAa+2jZ
         il1QcHqlFf86SY3YJmJ11O2CsQDUTyYVQiRtzOmopC1GB4+gG5zzu7aINF8q5Muw6KB2
         TC9wkstRtCBFX89cV1K02aRFgrrMSMH6XE0IJqjbDnxRowLcvmBoNMaau31fVAYgWqn7
         ijBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707265950; x=1707870750;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QJXlby+AD30AsP8JwtKyQnYYLLwLHxDqcJGOtskX1jw=;
        b=lAgmZP0jc0Py5NDk6vlaWeK4dAEjCYB3ubqLnfaqgyiYNx+UEgHvAaFicdEU5jjQKa
         EDWoKkQ1Fb+K3hX0Z0qoykLLLvMN6ozFX6Q1VDo/rEygRTqGq3SpVT7tnAN5ltba4MIQ
         ideheUakAM4vAC3ApqyZ2kXEzNN2c5itpQPqntWU2u6KXm5mIBOpUDKv6tfv2QGuN1Sk
         o9p/0hcWScrV9pFsRelTeV/ulObRBa+aSwgkj5Q9e8nJ/9UtF4E7iKiC0QCjPfPDIqvm
         VQnyKCpUOWfDcI9zL5O8N9P4/RN0JDh6K0sVdtg0B8EGTXb23Y/YH1JGl2wSDHYddQoN
         SCBg==
X-Gm-Message-State: AOJu0YyOFYEcmhA8admSv/bZNQFK1eqj50hNg7c1Dzd+k3g+A6XQWWLR
	AnmCHmidbCsRcXHFoRIXfJjQP+EmSAlEOILm1PRXOll9gIg3TGzPJN9RZNJ8gw==
X-Google-Smtp-Source: AGHT+IFc68UeTfh18sBbRkqxKprSuedOLBwsjWYaAXb6UcbNSOYzvLEShWlSsdkoB4CHqFd0WVDn7A==
X-Received: by 2002:a6b:7b4b:0:b0:7c3:f398:7de8 with SMTP id m11-20020a6b7b4b000000b007c3f3987de8mr3414654iop.11.1707265949818;
        Tue, 06 Feb 2024 16:32:29 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVqEC4vX8ewfaMiHobk4xS6GjGAJVg4zEGV4f2EcUVSYtvbaa7WKav90QosTXetCDOM6AK7MFFlYmnzWOVrdd9AWRh4DNgHtFbxbbQcRQGGg62wefpQmEAtz435+IlJizHzvyB1fSQFjZUAu8Ij6jhKuiMMU29qK4Xcw8xxSPG0YiQDLk5nnwaRZrQPB9FKLoIBXwo2mW9/mFypT35cHOkm1N2lrrjqxJGqqDiQU8L97onZjq58CVrmq8JdWPwAspczV9+p65+jtwNNGsJGz/HzogXLM63QHGSLsUxgt9zRpbNMofmu5rzgyzFM9tFoDLx0rleiv6bd8sk4zLRW+MPIkXu8cl3Y4YND1BBOn+ezc3Qi7K/WF1/YVkWjXWGTQWz/+D2Fpd7aLJZxJH0A9aMcX9R0OZivHReMhWiaALR0QE8iXdSvkjvN
Received: from google.com (20.10.132.34.bc.googleusercontent.com. [34.132.10.20])
        by smtp.gmail.com with ESMTPSA id b66-20020a0295c8000000b00470b6d256c1sm2975jai.91.2024.02.06.16.32.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 16:32:28 -0800 (PST)
Date: Wed, 7 Feb 2024 00:32:24 +0000
From: Justin Stitt <justinstitt@google.com>
To: Kees Cook <keescook@chromium.org>
Cc: Andy Shevchenko <andy@kernel.org>, linux-hardening@vger.kernel.org,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowang@redhat.com>, kernel test robot <lkp@intel.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Azeem Shaikh <azeemshaikh38@gmail.com>,
	linux-kernel@vger.kernel.org, linux-um@lists.infradead.org
Subject: Re: [PATCH v3 1/4] string: Redefine strscpy_pad() as a macro
Message-ID: <20240207003224.gzatchm47gy3aihv@google.com>
References: <20240206142027.make.107-kees@kernel.org>
 <20240206142221.2208763-1-keescook@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240206142221.2208763-1-keescook@chromium.org>

Hi,

On Tue, Feb 06, 2024 at 06:22:16AM -0800, Kees Cook wrote:
> In preparation for making strscpy_pad()'s 3rd argument optional, redefine
> it as a macro. This also has the benefit of allowing greater FORITFY
> introspection, as it couldn't see into the strscpy() nor the memset()
> within strscpy_pad().
>
> Cc: Andy Shevchenko <andy@kernel.org>
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  include/linux/string.h | 33 +++++++++++++++++++++++++++++++--
>  lib/string_helpers.c   | 34 ----------------------------------
>  2 files changed, 31 insertions(+), 36 deletions(-)
>
> diff --git a/include/linux/string.h b/include/linux/string.h
> index ab148d8dbfc1..03f59cf7fe72 100644
> --- a/include/linux/string.h
> +++ b/include/linux/string.h
> @@ -70,8 +70,37 @@ extern char * strncpy(char *,const char *, __kernel_size_t);
>  ssize_t strscpy(char *, const char *, size_t);
>  #endif
>
> -/* Wraps calls to strscpy()/memset(), no arch specific code required */
> -ssize_t strscpy_pad(char *dest, const char *src, size_t count);
> +/**
> + * strscpy_pad() - Copy a C-string into a sized buffer
> + * @dest: Where to copy the string to
> + * @src: Where to copy the string from
> + * @count: Size of destination buffer
> + *
> + * Copy the string, or as much of it as fits, into the dest buffer. The
> + * behavior is undefined if the string buffers overlap. The destination
> + * buffer is always %NUL terminated, unless it's zero-sized.
> + *
> + * If the source string is shorter than the destination buffer, zeros
> + * the tail of the destination buffer.
> + *
> + * For full explanation of why you may want to consider using the
> + * 'strscpy' functions please see the function docstring for strscpy().
> + *
> + * Returns:
> + * * The number of characters copied (not including the trailing %NULs)
> + * * -E2BIG if count is 0 or @src was truncated.
> + */
> +#define strscpy_pad(dest, src, count)	({			\
> +	char *__dst = (dest);						\
> +	const char *__src = (src);					\
> +	const size_t __count = (count);					\
> +	ssize_t __wrote;						\
> +									\
> +	__wrote = strscpy(__dst, __src, __count);			\
> +	if (__wrote >= 0 && __wrote < __count)				\
> +		memset(__dst + __wrote + 1, 0, __count - __wrote - 1);	\
> +	__wrote;							\
> +})
>
>  #ifndef __HAVE_ARCH_STRCAT
>  extern char * strcat(char *, const char *);
> diff --git a/lib/string_helpers.c b/lib/string_helpers.c
> index 7713f73e66b0..606c3099013f 100644
> --- a/lib/string_helpers.c
> +++ b/lib/string_helpers.c
> @@ -825,40 +825,6 @@ char **devm_kasprintf_strarray(struct device *dev, const char *prefix, size_t n)
>  }
>  EXPORT_SYMBOL_GPL(devm_kasprintf_strarray);
>
> -/**
> - * strscpy_pad() - Copy a C-string into a sized buffer
> - * @dest: Where to copy the string to
> - * @src: Where to copy the string from
> - * @count: Size of destination buffer
> - *
> - * Copy the string, or as much of it as fits, into the dest buffer.  The
> - * behavior is undefined if the string buffers overlap.  The destination
> - * buffer is always %NUL terminated, unless it's zero-sized.
> - *
> - * If the source string is shorter than the destination buffer, zeros
> - * the tail of the destination buffer.
> - *
> - * For full explanation of why you may want to consider using the
> - * 'strscpy' functions please see the function docstring for strscpy().
> - *
> - * Returns:
> - * * The number of characters copied (not including the trailing %NUL)
> - * * -E2BIG if count is 0 or @src was truncated.
> - */
> -ssize_t strscpy_pad(char *dest, const char *src, size_t count)
> -{
> -	ssize_t written;
> -
> -	written = strscpy(dest, src, count);
> -	if (written < 0 || written == count - 1)
> -		return written;
> -
> -	memset(dest + written + 1, 0, count - written - 1);
> -
> -	return written;
> -}
> -EXPORT_SYMBOL(strscpy_pad);

Yep, looks good. This is reminiscent of strtomem and strtomem_pad.

Reviewed-by: Justin Stitt <justinstitt@google.com>

> -
>  /**
>   * skip_spaces - Removes leading whitespace from @str.
>   * @str: The string to be stripped.
> --
> 2.34.1
>

Thanks
Justin

