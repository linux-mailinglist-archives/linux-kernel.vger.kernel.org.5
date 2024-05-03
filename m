Return-Path: <linux-kernel+bounces-167993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB3078BB1FD
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 19:55:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60C77282423
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 17:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 211741586F3;
	Fri,  3 May 2024 17:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="I7Bpelm0"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2954813B593
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 17:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714758938; cv=none; b=jEzTdeH7vrk03LyJ1pLsCQJQgw4Gcjeu6V9wqO9FJDjUDztc9J9+eXn9cRBFCmQSg/aL/6t4YS6gqWZGL0UTJU6Xx2XD2xAjOufaZWnr8skSQok7MITLWxHOyCuRHKHZTJ9L5gniTGP9R3IftBAnK61w4B/Jlqkd1eYqDLIPo8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714758938; c=relaxed/simple;
	bh=y3FTe/yZF4coOVNZnP08rsN6uKtTbcXmWT1Sw/5yX0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tBDnzir3fgNIWhViMEQJC41axOkv+HqXXdzYBqxli0zncEwDj4HQ0s0edE2O7nE0sZnpHmXeI93PjSz3OL745Hvw0TirFnC9wHuLyLK/ytu6khb8aB+WswYpy9zX+egQLd5p65hLK2oFs+4mYqcEgXeMxCfbzAgS+82X201z9rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=I7Bpelm0; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1eb24e3a2d9so70131285ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 10:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714758935; x=1715363735; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=P3szH4sxaPwAp0vnc9Q5nq9mDwhSGAgkyGp9dC8w3aY=;
        b=I7Bpelm0zmKoC7Il/cXvk491ccGh2erQBEUqfCrAaKsj7rD/V1Wri2IPC7V+ZZPGtZ
         SfUV2Sl/25OfdQjW7AXVYlm/MZViHGfzrtGBcgk3I26rPOW4uWpKw70FiBEbSfVXqaIx
         erQri9AeiWXq33z4IQEpZc3NDR06D1jd+n/8o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714758935; x=1715363735;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P3szH4sxaPwAp0vnc9Q5nq9mDwhSGAgkyGp9dC8w3aY=;
        b=XCny8BBbMHl8+JV/P32KlpVN7Nbprjiu0F1BVFfQ25OnVTfQDuTMGkpGWzCJLE/FK9
         oAPsvOWsonHzeob7m8+XCxg5i79qvGRH1Fuq/1f3+uHETXaM9/yfL5nH24RZK6D9OQSH
         JtMXKzbQODKXU5plvwbPzmy88jT96sWanGXWgxe7TaQacqmJLS6nGrNXRHhUHW0k2ou5
         GZ6cbe+f2xgMv/drB5XZIDRkUxcZY3SdE6gCiNhoCPXXEg09GNrTLMBbkasELj2H9XnM
         84ciW92jmQHtdFZxJ6xJRzsVLrWfrExlf96k57/ES9YliJOiiMTfMgK8bhoYQdsuncnS
         Zccg==
X-Forwarded-Encrypted: i=1; AJvYcCXIc+2mGWK4MhwIy8pc32vjV46E/2QtFp9W88Ks+1awSZWmVPX7pe/FHvLzIzcR/HNZDcDr1ZZzt4LpN2lKRIxJDR09pwAS5BpPYkYN
X-Gm-Message-State: AOJu0YxJJ6LWbe06x+7O0he9FxYXyTFrZSfGHRhpnCOdLK0ZZXvSr0Wf
	q5yvjQ5jnYYGviDRdAvtnUqQXzKRI7dn894ikiTOImfY+sLcdATiLDPjIfTKDQ==
X-Google-Smtp-Source: AGHT+IHkJw5A8PcSewyYDCRkDgMfU3P1H8c5aehvN8EioZ0XkEs3+oWSN6CDc45ewDHdxINqVBBJeA==
X-Received: by 2002:a17:902:7615:b0:1e4:b4f5:5cfa with SMTP id k21-20020a170902761500b001e4b4f55cfamr3282835pll.27.1714758935489;
        Fri, 03 May 2024 10:55:35 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id q7-20020a17090311c700b001e97772524asm3526577plh.234.2024.05.03.10.55.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 10:55:34 -0700 (PDT)
Date: Fri, 3 May 2024 10:55:33 -0700
From: Kees Cook <keescook@chromium.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Alexander Popov <alex.popov@linux.com>, linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Luis Chamberlain <mcgrof@kernel.org>,
	Joel Granados <j.granados@samsung.com>
Subject: Re: [PATCH] stackleak: don't modify ctl_table argument
Message-ID: <202405031054.9FFA75B@keescook>
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
> 
> Fixes: 964c9dff0091 ("stackleak: Allow runtime disabling of kernel stack erasing")
> Cc: stable@vger.kernel.org

I realize I've already Acked, but does this actually need to be CCed
to stable?

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
>  	state = !!state;
>  	if (ret || !write || state == prev_state)
>  		return ret;

I can pick this up; thanks!

-Kees

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

