Return-Path: <linux-kernel+bounces-87589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A66686D63C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 22:33:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA385B256EC
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 21:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BC336D503;
	Thu, 29 Feb 2024 21:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="I+9QetA6"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AFEF16FF47
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 21:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709242376; cv=none; b=VSKLhm4YZEjYknYRHZOXLpRZFbmqxlkUP7N1L/UycqvTYgH5d5OZ63DNqd48oNDTJSfCMZ2CLqIGkmIPub8QL0iJaqtqPfJwhsn0zQuBTrfL/FURUbqGHLAyEyxzxLhh/BcTt5YQLQAPB4QruupiE1lRxo+27kHZvSxf6eFgaEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709242376; c=relaxed/simple;
	bh=M1OIAA0ItaLeA6OMZsMNhafiM0P2mVk8eYOUN2HrEfw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jnm/JaE5ZrTAUxPg06MOcNz5Nrc3RoRORi04zhh9y4V+taCWIfi7C1of6vsH+yQgYzzquPSAC+2edK8FjCLVFi+cEiNHY/jkA6vQVMf6qD03dLnvQA3rP2XQDaj+U5OtAKl9D9CIcK+qs9LibcBiyLUM15CKujVR9pGj/IfjLSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=I+9QetA6; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-299b818d63aso1140074a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 13:32:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709242374; x=1709847174; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nZXiBnNhAhi4ZtO0SADmUcnGG7Y1r2RQ91McDK9U7hM=;
        b=I+9QetA60AKN7+t5WCRGjyqQwKr9rI+ukig6Mf/i2z299vpTYLGtWS9tn9ZHxElQkt
         dFio/wStFf14NLTi30iYq8N8D09+JygkatmXoIRG1z9YbJKvEnTi8GQHUGsOWiK/spJF
         1zSwoSK5171OWb4jpi4BY+BLYI7PQ+0/a6jaE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709242374; x=1709847174;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nZXiBnNhAhi4ZtO0SADmUcnGG7Y1r2RQ91McDK9U7hM=;
        b=NkAXZZxEZyqmluRyWZ82Z/1vqul1EA68TK6rFPdoRsF/eTxEMR1EnE9x0PWkcs9BAs
         5wRXkLXzmwTVfhvbhc/ZgQut8FHJtJ7D3EBwa2dqq/X+BnH4MCk8NQUUeN8MAql9QMvX
         7EtiJcvwzYSQ0CBip7TT6361dviJFEYf9cVx5znUmagkO+zy6YbLU2DGPz8cCgf/5GtC
         lqJvk5BntjdgR/P+nZLBEQ/6WrXBINneygTgIsl4VU/APCwC+i+oSyNEwSMMToPxfZzU
         spioUhUquUq/7VompOEuWQohe/hwo6GFYILHCw6sNvdGEcU1GtQMFMBMy2EGNZt5yjWW
         H7hw==
X-Forwarded-Encrypted: i=1; AJvYcCUUH5tTtmCwGpsaeMo9/shUzxZBZIpVmLJBqSBBqRDiq9OA/pXPH6nRo9p/QHN+nIxVGHPWM8MOSHP/WaEAbNg9Pj55I9+3a0LEAfDz
X-Gm-Message-State: AOJu0YxN6DJYXg9H5nWqPKuwF1RdlPRC9bhwt5PMjPSxYL183AulnSFZ
	Lg6W5needsI5Aw3yiZ7nk/kCm6b/TuZZYOz33Fc6k5T69RVlpcbczSp7l8vtjg==
X-Google-Smtp-Source: AGHT+IEvsn9DgpO+cW37vUplHd97MaD5TAZWQ0EdSVcQR53nFAD39hdF/sei1lWoc7NAH+n5Ef2cEw==
X-Received: by 2002:a17:90a:4491:b0:299:3c2c:b680 with SMTP id t17-20020a17090a449100b002993c2cb680mr241994pjg.15.1709242374560;
        Thu, 29 Feb 2024 13:32:54 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id c6-20020aa78806000000b006e53cc789c3sm1728164pfo.107.2024.02.29.13.32.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 13:32:54 -0800 (PST)
Date: Thu, 29 Feb 2024 13:32:53 -0800
From: Kees Cook <keescook@chromium.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Sam Ravnborg <sam@ravnborg.org>, Helge Deller <deller@gmx.de>,
	Guo Ren <guoren@kernel.org>, sparclinux@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] sparc: vdso: Disable UBSAN instrumentation
Message-ID: <202402291332.2C89081A@keescook>
References: <20240223165942.work.950-kees@kernel.org>
 <ZeDiZrrLuqkvxrIY@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZeDiZrrLuqkvxrIY@smile.fi.intel.com>

On Thu, Feb 29, 2024 at 10:00:38PM +0200, Andy Shevchenko wrote:
> On Fri, Feb 23, 2024 at 08:59:45AM -0800, Kees Cook wrote:
> > The UBSAN instrumentation cannot work in the vDSO since it is executing
> > in userspace, so disable it in the Makefile. Fixes the build failures
> > such as:
> > 
> > arch/sparc/vdso/vclock_gettime.c:217: undefined reference to `__ubsan_handle_shift_out_of_bounds'
> > 
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> > Cc: "David S. Miller" <davem@davemloft.net>
> > Cc: Andreas Larsson <andreas@gaisler.com>
> > Cc: Masahiro Yamada <masahiroy@kernel.org>
> > Cc: Sam Ravnborg <sam@ravnborg.org>
> > Cc: Helge Deller <deller@gmx.de>
> > Cc: Guo Ren <guoren@kernel.org>
> > Cc: sparclinux@vger.kernel.org
> 
> I dunno how you applied patches, but these Cc seems to appear in a few commits
> in your hardening branch.
> 
> I formatted patch from 9fd54b08040669, checked out the new branch just before
> this commit and run `git am 0001-...`. I don't see them.

Ah, hm, yes, I'll need to split up my trees a bit to get the right
results. Thanks for pointing that out!

-- 
Kees Cook

