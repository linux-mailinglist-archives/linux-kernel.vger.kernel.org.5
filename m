Return-Path: <linux-kernel+bounces-41233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A44DB83EDC9
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 16:08:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B6F9B22660
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 15:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC3AE28DC8;
	Sat, 27 Jan 2024 15:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="Ij4u53kX"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B91249EB
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 15:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706368101; cv=none; b=ERvE72nW8zDPhBCnZSIhrkd3YDPI6bZbgtbfPcacPraCFh7Zd/OXdezP98PFn+bFC8AmFwySoO/5spc6Fbz6y0dQ+vCwdnaEiXEi/JUcECDYm+1+8b7/H8CQsmH18gIfc1oCuWUZLzEi680NVEqM3ViRwdO1SP9pBaSf5cuecDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706368101; c=relaxed/simple;
	bh=lqA+NQQLLMZw5KhLr+kca1nqBHSMjxIlkYvhvzl1e3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aJxvGcTg1N42E2DanT3SQ9oFrgT7SKFVBjPm9FhZcg50qbN/An7NV8bb9vJdcgU6CINp/xTuwQi8i7hRxZux8N9PvwvbcZQ0w4ed5oguS86JDoHDzeB0+aQiMUEwND2C2pohjdZ3Sg0NnAaOGtR5B0wLFJCOLPiwinZLr09CZd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=Ij4u53kX; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1706367673;
	bh=lqA+NQQLLMZw5KhLr+kca1nqBHSMjxIlkYvhvzl1e3U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ij4u53kXty8NdbYb18xtg8xeFdO5EuZIyluZJn7/9hij3dKZEDlj+owK4FQdvwOtJ
	 OJ+wkvp+Nn60imahkWZaO0dKdKa4yl7jrU2kF9kS19tcqs2O8L3vWuynapERfWY7c7
	 1/jcn6Jo3TGp+pzB90pDUjeJLeoQtcW5JVC+Lofg=
Date: Sat, 27 Jan 2024 15:53:32 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Rodrigo Campos <rodrigo@sdfg.com.ar>
Cc: Willy Tarreau <w@1wt.eu>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/1] tools/nolibc/string: export strlen()
Message-ID: <9abed5e3-cd61-474e-bb16-13243709f5c5@t-8ch.de>
References: <20240126142411.22972-1-rodrigo@sdfg.com.ar>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240126142411.22972-1-rodrigo@sdfg.com.ar>

Hi!

On 2024-01-26 15:24:10+0100, Rodrigo Campos wrote:
> Hi, while using nolibc on debian testing, I found that compilation fails when using strlcat().
> 
> The compilation fails with:
> 
>             cc -fno-asynchronous-unwind-tables -fno-ident -s -Os -nostdlib -lgcc  -static -o test test.c
>             /usr/bin/ld: /tmp/cccIasKL.o: in function `main':
>             test.c:(.text.startup+0x1e): undefined reference to `strlen'
>             collect2: error: ld returned 1 exit status
> 
> This is using debian testing, with gcc 13.2.0.

I can reproduce the issue with gcc 13.2.1 on Arch.

> A small repro case that fails with this error on debian is:
> 
> 	int main(void) {
> 		char dst[6] = "12";
> 		char *src = "abc";
> 		strlcat(dst, src, 6);
> 	
> 		printf("dst is: %s\n", dst);
> 	
> 		return 0;
> 	}
> 
> Please note that this code is not using strlen() and strlcat() doesn't seems to use it either.

I think the comment in strlen() explains it:

    Note that gcc12 recognizes an strlen() pattern and replaces it with a
    jump to strlen().

strlcat() indeed contains this pattern.

I was able to fix the issue by replacing the open-coded strlen() in
strlcat() with a call to the function and that also fixed the issue.

It seems nicer to me as a fix, on the other hand the change to a weak
definition will also catch other instances of the issue.
Maybe we do both.

> First I noted that removing the attribute unused in strlen(), the compilation worked fine. And then
> I noticied that other functions had the attribute weak, a custom section and export the function.
> 
> In particular, what happens here seems to be the same as in commit "tools/nolibc/string: export memset() and
> memmove()" (8d304a374023), as removing the -Os or adding the -ffreestanding seem to fix the issue.
> So, I did the same as that commit, for strlen().
> 
> However, I'm not 100% confident on how to check that this is done by the compiler to later replace
> it and provide a builtin. I'm not sure how that was verified for commit 8d304a374023, but if you let
> me know, I can verify it too.
> 
> What do you think?

Personally I don't know how it was verified, we'll have to wait for
Willy on that.

> As a side note, it seems strlcat()/strlcpy() fail to set the terminating null byte on some cases,
> and the return code is not always the same as when using libbsd. It seems to be only on "error"
> cases, and not sure if it's worth fixing all/some of those cases.
> 
> Let me know if you think it is worth adding some _simple_ patches (I don't think it is worth fixing
> all the cases, the code is to fix all of the cases is probably not nice and not worth it).

Souns reasonable to me to fix the return values.
And get some tests for it.

> Best,
> Rodrigo
> 
> ---
> 
> 
> Rodrigo Campos (1):
>   tools/nolibc/string: export strlen()

