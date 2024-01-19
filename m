Return-Path: <linux-kernel+bounces-31527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 768E5832F8B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 20:58:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 167601F24862
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 19:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42DD656475;
	Fri, 19 Jan 2024 19:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fD8vZtdK"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7145B55E4A
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 19:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705694318; cv=none; b=O9q0hzSa1q0mHlGxKJ9fsV9cFwLV4QZzRVai667Ptbwh2gyV7SpVMKAXlt9HpqwyBrTzp9CYY5Z4VEgfpnsQVgEOjheytMhMPuEIGsVRufx/4Mi2BnrG6giQDCr4Q+TTm+gdXD/IAt6Iw/K/UxkBWdJLnlV9L15aMLFufG44FwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705694318; c=relaxed/simple;
	bh=sThutFEPey5kn1vfPaO+vlKXcAo3DAOcgLqEvPMy/Yo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jZ13bJ7YvraqCbQ6vrIveFnbeZwhBzeEtw84paRUbSxnQge/BAEj2w9iiLIp2fantXnMzga/T8msIEk7wsvjZe1qymXUWCQvFMJhNQv8t+5M6VKna93KQF6GMa0ydB/1HV9fgdpJwwGHbJnFfPqdo9i4r0FjY4VPQsIvDbQz1WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=fD8vZtdK; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6dbbcb1aff8so837975b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 11:58:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705694316; x=1706299116; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=C2LfwYsyKiY2dEzfHpNnaI1FNPWRf8Tkgz7+9RYGVco=;
        b=fD8vZtdKgPd/0l8vPCY9s3YMnHwivIPi6pgfnbxzvoLgqrXTE/gG+agMxexYr3lpX5
         sWB4PxeV0nTdl/0FqyE2UuX0Wn9udVw/J6vAWudq/6S5Az8NzAfuU3X8i1ndYMlnvMdi
         onmdzoxFxgWp5qfL5+j1rcqhxa+d0vI5D4+O8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705694316; x=1706299116;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C2LfwYsyKiY2dEzfHpNnaI1FNPWRf8Tkgz7+9RYGVco=;
        b=Svwv4xmBstxFR7hul8iH/4FgQq7YNj11ATi6C5a59DibVbPeMPfSG9UaX2OCOHCyIY
         2jDzlYbaFNFXctKQDA3X9Wz+Jg29THOCEb26uotbAMxMAHHRapuASj6VmvhV8Kwlqpg9
         LCJzHLxZaGB+QTegoN7Acut0yeLM1OsstpqzoV7A6Q7Xhs1NtOvAv3jxPl8eUEU/hAjl
         AccTzs7GKppWnZnLU0UbICAlekR/79uxqDMaJqABO8U4C62a6r/6v9O4tA9VaCpRY7Hq
         a2dZ5ZOZVGpjmRmA491lVvMTjjbXLlC6zjMsjcCJRS9+rUVrjhrwm23PWQP/UGT5YGlN
         bjcw==
X-Gm-Message-State: AOJu0YxGNtUD793Eok8E+D3Vqpmv0QkqKTt7HX6ksEkJThDJgbnYbC+E
	vaLY1T2p1DOmTJXaH/pr6n/CuXeHtBrmdWRez2wxcC6W/yZMQSOyKw6sYrmfPg==
X-Google-Smtp-Source: AGHT+IEyAGGR1bIGI9NKgmfe9mJPaukqKPFviZSxGEnYb0DgSbPfYaWaF1LxDBX4BTna/x2dhOEsNw==
X-Received: by 2002:a05:6a20:da82:b0:19a:8556:8caa with SMTP id iy2-20020a056a20da8200b0019a85568caamr486992pzb.13.1705694315821;
        Fri, 19 Jan 2024 11:58:35 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id sm16-20020a17090b2e5000b0028dd3ac24a6sm4561644pjb.9.2024.01.19.11.58.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 11:58:35 -0800 (PST)
Date: Fri, 19 Jan 2024 11:58:34 -0800
From: Kees Cook <keescook@chromium.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>,
	Azeem Shaikh <azeemshaikh38@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
	Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] string: Remove strlcpy()
Message-ID: <202401191141.F6902E74D@keescook>
References: <20240118223301.work.079-kees@kernel.org>
 <CAHp75VerSqay6cxRQOihC321BbpAWd_TB6aPigN8XZZ=KPXtHA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75VerSqay6cxRQOihC321BbpAWd_TB6aPigN8XZZ=KPXtHA@mail.gmail.com>

On Fri, Jan 19, 2024 at 06:05:19PM +0200, Andy Shevchenko wrote:
> On Fri, Jan 19, 2024 at 12:33 AM Kees Cook <keescook@chromium.org> wrote:
> >
> > With all the users of strlcpy() removed[1] from the kernel, remove the
> > API, self-tests, and other references. Leave mentions in Documentation
> > (about its deprecation), and in checkpatch.pl (to help migrate host-only
> > tools/ usage). Long live strscpy().
> 
> ...
> 
> >   * Copies at most dstsize - 1 bytes into the destination buffer.
> > - * Unlike strlcpy the destination buffer is always padded out.
> > + * Unlike strscpy the destination buffer is always padded out.
> 
> While at it, please use the strscpy() form to refer to the function.

Oh, with the trailing "()"? Sure! Good call.

-Kees

> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Thanks!

-Kees

-- 
Kees Cook

