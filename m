Return-Path: <linux-kernel+bounces-163083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 722E98B64FB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 23:58:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2703E2831CE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 21:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD589190696;
	Mon, 29 Apr 2024 21:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZDD1p7Ek"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B84190682
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 21:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714427909; cv=none; b=qJ/+BCUJfCO0nhOQ11DKr5HiE0uzeDUyz16ASRZJzbKLP5nDnB7VUkBGfMXiSiJdg8BOOsRybezIpBOsx4Kl1+2dGPOQzBwsaeHpF23o9jL2F43x0qc0jLZlb1fxlHQNemgAq1oPGFzXc75EwNVtRjE7uBrEuP4JXCtolDos/iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714427909; c=relaxed/simple;
	bh=i6lqpid3/ifH983zglzaRmJlc7nvZzdwdzL3SlBT1GI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uSDMls2euWv4SmRQ5T8Qi1hpKRb3WhzJAShFzx5MBi5oNIWNFCpvEueyYUNS1RSifJWrRvYyq79IJlXwpXgKdpPii2Mjczy9Hbz2gqmLj0W6U+kL9kfikvdnLiCPJ8BFgmLFUyggM5hExo0jHn1pWHBzXzZgUrEeAz9mlaT8Idg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ZDD1p7Ek; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6f28bb6d747so4276257b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 14:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714427906; x=1715032706; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Pt4pmVDe1gHqk8GSYJUn0euBaNvq8Bf6JSXO1Xsdf5U=;
        b=ZDD1p7EkJ56UE59hBbkIXdaJny5SS7tlrgfC95duBrz9Jy/R1boGAkiR3UTX8rLp3l
         CD5bhyv129qrcu3CneUU2vuGss+Nj5M+f8MMPk3Cvu5PMnE4s1Y8FYNDfCgz2jlR1Gu6
         MQkbj65WMSZJ2GGDsfviDw40TgIDVVVQgynXQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714427906; x=1715032706;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pt4pmVDe1gHqk8GSYJUn0euBaNvq8Bf6JSXO1Xsdf5U=;
        b=NlH7WlySUEbuS8xfKsatrdMT2OjkR6xFQtFs3TxGNY0GVzIsDTdzGLZUuPvHdqkh6d
         mp7ns19QdZLDFv/ye1Lqw3xUDfrh6dh8/6ZA99tD2MVFuyLOz23eBzuFCEcg6wb5at7y
         DyW+mK9hCPRj2/rgBeB6Y6VzwIcszKRdaWsiZ5Im3U4sKVcpu+TwWiF29jCncpUcDwwI
         ZEYvUODTpQNY928nEyAtOUM5zlqM6t2shKv3+wPhtH+EixSEAVgPrU2d9C6fJTMw4tQE
         simWshJyEC2pTS2QqZq8wS5UPFVgWs9dMbSSW7Kap68JtXcH27Dw0ApDrkSCb0DC+Jj1
         yiDA==
X-Forwarded-Encrypted: i=1; AJvYcCXZsODdZN/4dICzk1qlCBmk5uVg9ORscet8iJoMyjAuBj3R+C5pF+El059WyE5OrsY6y2mGk2bleBt1UoQhK+hSvOx9IPnebj6HLImU
X-Gm-Message-State: AOJu0Yz0SPZz2FliLs/mokxQTIvK2UMAkOL8B1pOYQIPSYW3A77XUd40
	l1R87sa1K1k0LN+FRvqyJQUo6YfSLBvKPvwxrPH4k9tJSdx5+2vt8cHM8wE/lw==
X-Google-Smtp-Source: AGHT+IEsWmJgVhdteBNFpcp99zENVzWfPLc9Uvz/OFqNT+c1CKX09b/Qwv6MZ23E7a+08D6po9slVQ==
X-Received: by 2002:a05:6a00:2315:b0:6ec:ec8f:d588 with SMTP id h21-20020a056a00231500b006ecec8fd588mr13038861pfh.16.1714427906391;
        Mon, 29 Apr 2024 14:58:26 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id ff3-20020a056a002f4300b006eab6f3d8a9sm19709557pfb.207.2024.04.29.14.58.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 14:58:25 -0700 (PDT)
Date: Mon, 29 Apr 2024 14:58:25 -0700
From: Kees Cook <keescook@chromium.org>
To: Justin Stitt <justinstitt@google.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] PM: hibernate: replace deprecated strncpy with strscpy
Message-ID: <202404291457.8E79DC5@keescook>
References: <20240429-strncpy-kernel-power-hibernate-c-v1-1-8688f492d3e6@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240429-strncpy-kernel-power-hibernate-c-v1-1-8688f492d3e6@google.com>

On Mon, Apr 29, 2024 at 08:50:30PM +0000, Justin Stitt wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> This kernel config option is simply assigned with the resume_file
> buffer. It should be NUL-terminated but not necessarily NUL-padded as
> per its further usage with other string apis:
> |	static int __init find_resume_device(void)
> |	{
> |		if (!strlen(resume_file))
> |			return -ENOENT;
> |
> |		pm_pr_dbg("Checking hibernation image partition %s\n", resume_file);
> 
> Use strscpy [2] as it guarantees NUL-termination on the destination
> buffer. Specifically, use the new 2-argument version of strscpy()
> introduced in Commit e6584c3964f2f ("string: Allow 2-argument
> strscpy()").
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
> Note: build-tested only.
> 
> Found with: $ rg "strncpy\("
> ---
>  kernel/power/hibernate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
> index 43b1a82e800c..0a213f69a9e4 100644
> --- a/kernel/power/hibernate.c
> +++ b/kernel/power/hibernate.c
> @@ -1361,7 +1361,7 @@ static int __init resume_setup(char *str)
>  	if (noresume)
>  		return 1;
>  
> -	strncpy(resume_file, str, 255);
> +	strscpy(resume_file, str);
>  	return 1;
>  }
>  

Yup, this looks correct to me. resume_file is:

static char resume_file[256] = CONFIG_PM_STD_PARTITION;

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

