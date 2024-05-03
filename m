Return-Path: <linux-kernel+bounces-168134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAA938BB411
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 21:32:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75DBD2860A4
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 19:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EAF8158A35;
	Fri,  3 May 2024 19:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EMmYTq8F"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2170C63CF
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 19:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714764668; cv=none; b=obSIj8D963TnxWi2qX0F9b7jfWB7pyYqXpTksCrXP6INVi/i18F85ms7V7r42xTumDW10X9/kuot7XMNDwjme0hvPiOo1yI1Fhtq4uJrMzt7vP6FDj8Uxg5Nx3Z6SnUiMF+T+envWfD1iZFITTA1P0FPBglBlgyXf+1rxbkd4mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714764668; c=relaxed/simple;
	bh=x28zhPQYDxN9o4XVDCDp8X1jPK2/Y8lfsDGM/Wyqw1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pclYL9Gvkb2WVj5P/iGB8dOGLECBO3wu5ub7YB+bQegxvVqboUUUSyyfWc4/Z9IejOqVIsx8opVdD4Ao/3tu0YWVJDxmztiV9L/WXeNbDZGDUBFFho5BwjMTdzKYBQ5kVcuAFSlWsk8dOOS22QKqsbIAbdBxZgu66MzCS5UJzDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=EMmYTq8F; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-6082fd3e96eso11706a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 12:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714764665; x=1715369465; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=g7QXE4DBpUN1TlvOlHazjxp5PU0glIr0ZC2ULeQ3beM=;
        b=EMmYTq8FcnWNpEfEnDuUuEn35bSpggBuRRS9ej+n4B4UDZYnU/bXDuGJpfgiU+9js0
         2rHL0PBoe5CRRli68Rhx4oAxQUmmd/KdhslbhXK8wscdoY5pLDi7XBIW6F5koifZzc2Z
         j8pL5pE/Kz4XlUiE2VqzRK2Z26ujvbhHOmU2Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714764665; x=1715369465;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g7QXE4DBpUN1TlvOlHazjxp5PU0glIr0ZC2ULeQ3beM=;
        b=GOUF+NNutlUDf3HdRzv6Ext0gbm+CydtZ8jl9hihFCfWbd/EIdDC3JP8KLMYhdCepB
         fAq1Jl7kfXlhBCQj1hU7HH+z6cm15oOysSH2V20P3aMddrMJwjLxVchMnin0RP2ajlhG
         C3nPnJT6xQkFEHyrXPezeB4uP97zPqrmto6UncCSHpijs3dECAvunEtVzwd18vwUTA9J
         49+49AnVd8k+bLLm8WwU01ux+N1U/fPi+KpNpYG+cau+P69wRqrD557K71PkZ+dFVkUw
         fwphjgXnL+zfZ/iRIbjvfsO7fbKfvURlTnqiO5BoWsQB0t5h1bO76nF1+ZFjU992l1cf
         bYHg==
X-Forwarded-Encrypted: i=1; AJvYcCWEW5Jj7SA1Qixc0/oCe5FcFf94isyXCZRQLBjXH0+dy5NYGpnPHD00L5hVnzomTuTo3xFuWJfpDsuUE7v9YNe6frPhkhoJDb03co4q
X-Gm-Message-State: AOJu0YxHek/CPXz3S3QG+rDuDW/0tQ2E4ucstChW0WMGEpWiqjcoeo8e
	FJV25KPvEhwNnpc3XL0D0Qjax2XsLV4v2lZz3AIXBY7X35HP4af0VeaGhc2IKWXcyuOcrWME8ww
	=
X-Google-Smtp-Source: AGHT+IEbb/3D0nXc0Je0N+ipwjcG+uekqZpepX1LOoATHx5do+IW7TcvLbcHgkaK0O1cKziTuDQRyw==
X-Received: by 2002:a05:6a21:31c7:b0:1af:55e7:633d with SMTP id zb7-20020a056a2131c700b001af55e7633dmr4672289pzb.0.1714764665382;
        Fri, 03 May 2024 12:31:05 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id gp9-20020a056a003b8900b006ea8cc9250bsm3420413pfb.44.2024.05.03.12.31.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 12:31:04 -0700 (PDT)
Date: Fri, 3 May 2024 12:31:04 -0700
From: Kees Cook <keescook@chromium.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Alexander Popov <alex.popov@linux.com>, linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Luis Chamberlain <mcgrof@kernel.org>,
	Joel Granados <j.granados@samsung.com>
Subject: Re: [PATCH] stackleak: don't modify ctl_table argument
Message-ID: <202405031229.9856D89B7A@keescook>
References: <20240503-sysctl-const-stackleak-v1-1-603fecb19170@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240503-sysctl-const-stackleak-v1-1-603fecb19170@weissschuh.net>

On Fri, May 03, 2024 at 03:44:09PM +0200, Thomas Weiﬂschuh wrote:
> Sysctl handlers are not supposed to modify the ctl_table passed to them.
> Adapt the logic to work with a temporary
> variable, similar to how it is done in other parts of the kernel.
> 
> This is also a prerequisite to enforce the immutability of the argument
> through the callbacks prototy.
                        ^^^^^^^

Was this supposed to be "prototype"? I couldn't quite figure out what
was meant there; the sentence reads fine to me without the word there at
all. :)

> 
> Fixes: 964c9dff0091 ("stackleak: Allow runtime disabling of kernel stack erasing")
> Cc: stable@vger.kernel.org
> Acked-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> ---
> This was split out of my sysctl-const-handler series [0].
> 
> As that series will take some more time, submit the patch on its own,
> as it is a generic bugfix that is valuable on its own.
> And I can get it out of my books.
> 
> Changelog in contrast to the patch in the series:
> * Reword commit message to remove strong relation to the constification
> * Cc stable
> 
> [0] https://lore.kernel.org/lkml/20240423-sysctl-const-handler-v3-0-e0beccb836e2@weissschuh.net/
> 
> Cc: Joel Granados <j.granados@samsung.com>
> ---
>  kernel/stackleak.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/stackleak.c b/kernel/stackleak.c
> index 34c9d81eea94..b292e5ca0b7d 100644
> --- a/kernel/stackleak.c
> +++ b/kernel/stackleak.c
> @@ -27,10 +27,11 @@ static int stack_erasing_sysctl(struct ctl_table *table, int write,
>  	int ret = 0;
>  	int state = !static_branch_unlikely(&stack_erasing_bypass);
>  	int prev_state = state;
> +	struct ctl_table tmp = *table;
>  
> -	table->data = &state;
> -	table->maxlen = sizeof(int);
> -	ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
> +	tmp.data = &state;
> +	tmp.maxlen = sizeof(int);
> +	ret = proc_dointvec_minmax(&tmp, write, buffer, lenp, ppos);

In looking at this yet again, I can't figure out why maxlen is being
set. It starts its life as sizeof(int):

static struct ctl_table stackleak_sysctls[] = {
        {
                .procname       = "stack_erasing",
                .data           = NULL,
                .maxlen         = sizeof(int),

-Kees

>  	state = !!state;
>  	if (ret || !write || state == prev_state)
>  		return ret;
> 
> ---
> base-commit: f03359bca01bf4372cf2c118cd9a987a5951b1c8
> change-id: 20240503-sysctl-const-stackleak-af3e67bc65b0
> 
> Best regards,
> -- 
> Thomas Weiﬂschuh <linux@weissschuh.net>
> 

-- 
Kees Cook

