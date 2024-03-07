Return-Path: <linux-kernel+bounces-96081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 095E78756D9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 20:15:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B50B1C20FE0
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 19:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0F77135A7C;
	Thu,  7 Mar 2024 19:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dq+vSyWM"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 666371350CD
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 19:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709838928; cv=none; b=AzO3wUgUgc0za5aWtwxFyKHwCxcdWgw5GcdyJ3eB2lK4kQxs+ZkXWXV6S8NJxikDhHlP/ZjSuyKfwI1QMEjnHksnwlUqUzcy1yBRPJ3jezWKNRtf1Tu6BYleg5agnwSUupeGOeS/UREzOfW8Kz12hkPI8Qgw6i5r4K1VC0A5qHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709838928; c=relaxed/simple;
	bh=iV+OYTSsiAzVIZf65NDnap/uKAr9OJdA2mFdEdjwGZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hhmaEqa3Bz2ktgzrRbwly/nKCmBEdzNAZD4GY3sxQ2uGXPcDyIDRqxOeZEge64Ivu70SKmu4dA3tzI9Owm2yhEnrtMyCbMyC202+yk075LkDzXpPgjZ1R8cp4obOLMriFVp8tdscTss1F8fUiKnc15UtcdyMtg5GUhiU29EL0Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=dq+vSyWM; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5ce9555d42eso994487a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 11:15:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709838924; x=1710443724; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=adtXnm+UfFx0dkkz1N9cMCbOWjdrx1dY7LOvsQ2Ti4s=;
        b=dq+vSyWMx07f1I7q8OSlwaEyKVGWuMHhIUietyCQKCmhgA9gPbe0NuwOA1SqIGXMao
         fjnmh20hIoaHsJnUB/AIj/ElqPgvBmyb3VlceNRxEunMUv3YI708eYNm3DSUtdtQeKhZ
         bV9DV1gVQx6p5kNv699NwrAWIQ8JA5SBCvoD0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709838924; x=1710443724;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=adtXnm+UfFx0dkkz1N9cMCbOWjdrx1dY7LOvsQ2Ti4s=;
        b=TEwUeq0pPrdgfiD5uO4TLQkOzrBt8hJs4LEcnqz0l4NZOjNleBu4BeMawlpxX8fxN6
         0wYVQXAMae7Mp/PEjhrbNwTbQfT5hIWmR4bgjA5jY2xRY+zHxJ1Xf4V/aHYadICOhwgb
         U99I7HPTml1lSW+fRPRN+35NadObFszWW4OBfEswXtyY6Fh+WfvEl4I+YpBy7It1SuDE
         jgoqsxMhcVUL8HL9nVUZaHWY8Nh1a2Cd+1umMaZjnuOcFPKK37OLexC8UDmktMgYVfqC
         A59u1MRvEjZBl7zDRmi6oPXfbhu9mXpcDsceIBN8/EixxtWTx29c0b6/s6hKlq6Txz9P
         IugQ==
X-Forwarded-Encrypted: i=1; AJvYcCVvDDBg+fRWwu+nbmPua7pMUib2Q0CTvm/VBfmtLGt1pm1dTZv5ZeKhPopicxCJUOMEqJ0Z/k/GBmZCS9orr4/7IJPYIU2asHThfE2w
X-Gm-Message-State: AOJu0YyCQYi1wBIYIMcPI3BbwLyvsEWhPQXLzmIySqXIgae2r1wax/u4
	y1w0CX1uTJoDEAvU+cN1I44kj9j/u8wks+dkSAK8n9bYw5eNiIWqYPdplngD+w==
X-Google-Smtp-Source: AGHT+IEfz0ZlLYkTZgYNEzshYOrsBM9a29I/dbatU4XBUS/LLZXPEPxmsUjxmgrOyECAYIyMWb6Mxg==
X-Received: by 2002:a17:902:6845:b0:1db:e78e:b38d with SMTP id f5-20020a170902684500b001dbe78eb38dmr8469823pln.18.1709838924636;
        Thu, 07 Mar 2024 11:15:24 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id li4-20020a170903294400b001d8f82c61cdsm15036341plb.231.2024.03.07.11.15.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 11:15:24 -0800 (PST)
Date: Thu, 7 Mar 2024 11:15:23 -0800
From: Kees Cook <keescook@chromium.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Jeremy Linton <jeremy.linton@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mark Brown <broonie@kernel.org>, Guo Hui <guohui@uniontech.com>,
	Manoj.Iyer@arm.com, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, James Yang <james.yang@arm.com>,
	Shiyou Huang <shiyou.huang@arm.com>
Subject: Re: [PATCH 1/1] arm64: syscall: Direct PRNG kstack randomization
Message-ID: <202403071112.01B4579@keescook>
References: <20240305221824.3300322-1-jeremy.linton@arm.com>
 <20240305221824.3300322-2-jeremy.linton@arm.com>
 <202403051526.0BE26F99E@keescook>
 <34351804-ad1d-498f-932a-c1844b78589f@app.fastmail.com>
 <38f9541b-dd88-4d49-af3b-bc7880a4e2f4@arm.com>
 <f1dd15ce-69af-4315-8d7c-b7a480e541aa@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1dd15ce-69af-4315-8d7c-b7a480e541aa@app.fastmail.com>

On Thu, Mar 07, 2024 at 12:10:34PM +0100, Arnd Bergmann wrote:
> There is not even any attempt to use the most random bits of
> the cycle counter, as both the high 22 to 24 bits get masked
> out (to keep the wasted stack space small) and the low 3 or 4
> bits get ignored because of stack alignment. If there was
> any desire to make it more random, a trivial improvement
> would be:
> 
> +++ b/include/linux/randomize_kstack.h
> @@ -80,7 +80,7 @@ DECLARE_PER_CPU(u32, kstack_offset);
>         if (static_branch_maybe(CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT, \
>                                 &randomize_kstack_offset)) {            \
>                 u32 offset = raw_cpu_read(kstack_offset);               \
> -               offset ^= (rand);                                       \
> +               offset = ror32(offset, 5) & (rand);                     \

Shouldn't this stay ^ instead of & ?

>                 raw_cpu_write(kstack_offset, offset);                   \
>         }                                                               \
>  } while (0)

But yeah, we should likely make this change regardless.

> My impression is that is is already bordering on becoming
> a "bespoke rng" implementation that Jason was objecting to,
> so the current version is intentionally left weak in order
> to not even give the appearance of being a security relevant
> feature.

I don't think it's bad to make a trivial improvement to entropy diffusion.

-- 
Kees Cook

