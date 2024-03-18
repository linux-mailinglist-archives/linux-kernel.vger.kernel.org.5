Return-Path: <linux-kernel+bounces-106724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE1887F2A2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 22:53:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C7351F2258A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 21:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A59B859B6A;
	Mon, 18 Mar 2024 21:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iaNzDjOa"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D78159B4F
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 21:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710798794; cv=none; b=ocRGmBpARwYjI7O7nj+nxWm+YN5Phr+a6UNs9/W0KMt+tZsK8dmvmeZOlk4M9jUB7c3BF62i66bW5al4d/nff6ClQDrqH7TvyLCN6ScJzt716G0MWtIDPcGulM0kO0RVnMJPd+EC7mgyLtAa7pIwaU+oBzIi79RO43nvEMNOPrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710798794; c=relaxed/simple;
	bh=JizSFbjtx2htSyk8SkATyClTMTliTcHMUD9iIRdZRdA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aNHtLw/Rn0COUSjKUTYXdn2Pmk12Xn/XGzgStwpU8jX8xP8CfS26BwmqQOfo8d4DuAoDFXTQAWmwY7iZ3Ut92c1QfFDBmaIG7y+lv7UGqDMbeKNoswIA1gTmtqYqIA7QxvFzgD62aprks9nzFgebrDuyxyKOygi/25h/P0Anh/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=iaNzDjOa; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-29c4fe68666so3813089a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 14:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1710798791; x=1711403591; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BtzX3B0TpCLSG/r678eRw7F3f4FGYZRbRXL/8dQddU4=;
        b=iaNzDjOa64gmGV/i244zGJQEMiRulP5z1WVeu3Sqi6F00DCy2hmOmXQJ0EXDxMY8vi
         TwC5aZP9PumCTH7f40WJRSYJI5+Qb3XtGRUNxNoVIF7d9I0ZIEarXWX13A/g8qbXeGlX
         Pu/lETOdVlYDMxuaIKLb/v9yiy6nVJOd4ZB/o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710798791; x=1711403591;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BtzX3B0TpCLSG/r678eRw7F3f4FGYZRbRXL/8dQddU4=;
        b=pP3VlvQQRYf5osoPJxLocblHltMowjiq9eF7mOvxo4oIkd0sbwyc+V++tLfORdEC/B
         xEnNFREiJ6nOPaMvPTpHyByDvAVif3IlJ7lW6X6KjgjZ19O3jtwha7mL4rcGchB2cWe7
         v9GJKCKA9Ww+IPiQxwfdu4D8Lr8/LKI6T5ks/uQiLp5/tChqFda17VVn1r0nH4s3kQ4D
         PDbAOWPP+Wb4wtOQsrRA0FH7+eWJOAFTmpGGO2fGrlW6jRQw1PoTkg1OD3zmBfvaXqDC
         P/uczm84RIZdpZg8uPYUknmjjMAEx27Sds8PR2DDSUQCZW5tE98fDmzSHgn1fAooGaxt
         eL0g==
X-Forwarded-Encrypted: i=1; AJvYcCULt8ulusQ+NXv809Hwi2RPxgSOQdpkgt+oCrLp5HUG+2Y6967vuCkEhZ+CME+25tkzU1pnZENrcsU2nBaUYgv5sYeNop1fwf8ZMaRT
X-Gm-Message-State: AOJu0YzIHwpyCz5z3FneOKtket4njWxgvrOEo0kQJ6dDprLtvwRWgQWi
	HPEXzscul/mPNTeNsUfcYUwKOHffF0zCIzM5tVrayhfgi7S+vHy8QUewy7UX9w==
X-Google-Smtp-Source: AGHT+IGv4Kqn7atIxrIijFKf64/vFsVwStmAQMvmLnWKqPS6XvTIKQsbJnzlt/yktHSLuH3RG7+/jA==
X-Received: by 2002:a17:90a:12ca:b0:29d:f086:9e44 with SMTP id b10-20020a17090a12ca00b0029df0869e44mr8248526pjg.46.1710798790706;
        Mon, 18 Mar 2024 14:53:10 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id ok5-20020a17090b1d4500b0029df9355e79sm6731928pjb.13.2024.03.18.14.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 14:53:10 -0700 (PDT)
Date: Mon, 18 Mar 2024 14:53:09 -0700
From: Kees Cook <keescook@chromium.org>
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc: elver@google.com, andreyknvl@gmail.com, ryabinin.a.a@gmail.com,
	akpm@linux-foundation.org, kasan-dev@googlegroups.com,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH] ubsan: Remove unused function
Message-ID: <202403181452.500EF35300@keescook>
References: <20240315015347.2259-1-jiapeng.chong@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240315015347.2259-1-jiapeng.chong@linux.alibaba.com>

On Fri, Mar 15, 2024 at 09:53:47AM +0800, Jiapeng Chong wrote:
> The function are defined in the test_ubsan.c file, but not called
> elsewhere, so delete the unused function.
> 
> lib/test_ubsan.c:137:28: warning: unused variable 'skip_ubsan_array'.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=8541
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  lib/test_ubsan.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/lib/test_ubsan.c b/lib/test_ubsan.c
> index 276c12140ee2..be335a93224f 100644
> --- a/lib/test_ubsan.c
> +++ b/lib/test_ubsan.c
> @@ -133,11 +133,6 @@ static const test_ubsan_fp test_ubsan_array[] = {
>  	test_ubsan_misaligned_access,
>  };
>  
> -/* Excluded because they Oops the module. */
> -static const test_ubsan_fp skip_ubsan_array[] = {
> -	test_ubsan_divrem_overflow,
> -};

But then I'll get warnings about test_ubsan_divrem_overflow() being
defined and not used. :)

-Kees

> -
>  static int __init test_ubsan_init(void)
>  {
>  	unsigned int i;
> -- 
> 2.20.1.7.g153144c
> 

-- 
Kees Cook

