Return-Path: <linux-kernel+bounces-22906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBFD882A531
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 01:13:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36DEE288406
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 00:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF187381;
	Thu, 11 Jan 2024 00:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fpkN7FwU"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23A5360
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 00:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-28c0565df34so2545759a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 16:13:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1704932002; x=1705536802; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Szg0f43eSi80PlaeJTnnx43hn+vtfqy0TLL8cXLjBsk=;
        b=fpkN7FwU85qlz0nQ3lBIoOopZOA86ThIXyX6fHfm2fmZ2k6lbNvfW/Y5P5NQ04tp04
         lmYTHH246RGDKkNn+7zugX6EuMhDYNZ9H5btzzuflg3PJtzEjqobMxfgxXz4UWMZ2wj+
         ruESO6Wr7uRbmzQZ9M1MOEIVZOKARN+p+SKxA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704932002; x=1705536802;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Szg0f43eSi80PlaeJTnnx43hn+vtfqy0TLL8cXLjBsk=;
        b=bnWkxAJVFCSYo6p7W80ccLxzFZ4mLAf+ZThe3kjy3DJcN8Vh0lEdhzjduKwlcpAkvb
         dFlbzD0GJ1Q6rAcXMRx6CA7QMswILE54jrIXvUluxhVFy85vOICLDNNV1eJaDElqFhEE
         JHwP0/WVslHkoGSFYKgPHWP49kkk3J1RhYnWzkowH7vggZqIeEWqP5EciqHJV7A61rtV
         BPBXXiwRhKKs/oPuzrZWhmFp2fTdpruUyjCVrdPR7ApthS05fJRAA0rfvtMqSLiqy8xG
         qTcgpd1AIXTNcqAKUG+JsGww125vZ3aG1wfszsdbkqp2wAFAl6pOav9St81JDjVZ+347
         S0ig==
X-Gm-Message-State: AOJu0Yz5HB4NqlUUDCu57ecRbuJu47ZrkMYrJThTzfuHpG+x63d2rdp/
	ncWiWwrSOROi13XYK/pl2euBkMtmwZdB
X-Google-Smtp-Source: AGHT+IFCHM86VQlaYtIos2K1xjkZsI+quKbXvg3z4JeRWQcS/8T/4zDcnuAe029PeahrP9liZJV6Dw==
X-Received: by 2002:a17:90a:6e48:b0:28c:ece4:f3e3 with SMTP id s8-20020a17090a6e4800b0028cece4f3e3mr268411pjm.85.1704932002274;
        Wed, 10 Jan 2024 16:13:22 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id bb24-20020a17090b009800b0028c9d359011sm2158027pjb.32.2024.01.10.16.13.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 16:13:21 -0800 (PST)
Date: Wed, 10 Jan 2024 16:13:21 -0800
From: Kees Cook <keescook@chromium.org>
To: alexs@kernel.org
Cc: Eric Biederman <ebiederm@xmission.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Alex Shi <alexsshi@tencent.com>,
	Sergei Trofimovich <slyich@gmail.com>, curlinhuang@tencent.com
Subject: Re: [PATCH] execve: argument list space enlargement
Message-ID: <202401101609.F791E52@keescook>
References: <20240103130722.1551670-1-alexs@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240103130722.1551670-1-alexs@kernel.org>

On Wed, Jan 03, 2024 at 09:07:22PM +0800, alexs@kernel.org wrote:
> From: Alex Shi <alexsshi@tencent.com>
> 
> Wechat using too long gcc parameters, then get a strace complain:
>   execve(...) = -1 E2BIG (Argument list too long)
> Have to increase the parameter space for this, stack has enough
> space for this enlargement.

This is the second request recently[1] to expand the argument list size,
but I remain somewhat unconvinced this needs fixing on the kernel side.

[1] https://lore.kernel.org/lkml/202310170957.DF7F7FE9FA@keescook/

If we do change it, though, as I mention in the thread above, I'd prefer
to leave the UAPI alone and just detach the kernel internals from that
hard-coded limit.

-Kees

> 
> Signed-off-by: Alex Shi <alexsshi@tencent.com>
> Cc: Alex Shi <alexsshi@tencent.com>
> To: linux-kernel@vger.kernel.org
> To: linux-mm@kvack.org
> To: Kees Cook <keescook@chromium.org>
> To: Eric Biederman <ebiederm@xmission.com>
> ---
>  include/uapi/linux/binfmts.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/uapi/linux/binfmts.h b/include/uapi/linux/binfmts.h
> index c6f9450efc12..717f6cafe8dd 100644
> --- a/include/uapi/linux/binfmts.h
> +++ b/include/uapi/linux/binfmts.h
> @@ -12,7 +12,7 @@ struct pt_regs;
>   * prevent the kernel from being unduly impacted by misaddressed pointers.
>   * MAX_ARG_STRINGS is chosen to fit in a signed 32-bit integer.
>   */
> -#define MAX_ARG_STRLEN (PAGE_SIZE * 32)
> +#define MAX_ARG_STRLEN (PAGE_SIZE * 128)
>  #define MAX_ARG_STRINGS 0x7FFFFFFF
>  
>  /* sizeof(linux_binprm->buf) */
> -- 
> 2.43.0
> 

-- 
Kees Cook

