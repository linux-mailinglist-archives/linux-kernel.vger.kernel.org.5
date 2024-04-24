Return-Path: <linux-kernel+bounces-157799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1920E8B1662
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 00:45:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AE811C23AF4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 22:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64F1D16E89C;
	Wed, 24 Apr 2024 22:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ip2IuUZ5"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796A716E873
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 22:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713998710; cv=none; b=jU7uYm45+QGolAL0uizOonMMZkvRc7gK60aVk3qzdfCGwpq9/agNhnDSPUeXMJshA6ambHZdg4Rfq5u6bzb7yI5hNUPW9LVmXMTyQ56szvmkNh+0Ucw+gUo2tPrNO3kk5SMZr9DDvU0nw+Maruh2mlNIQFfNiGPuD8xDc3IrY/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713998710; c=relaxed/simple;
	bh=PesUfngxJz9TzB+RXrKPi6gidufT5NJWBpNfqP6UeSg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nCMX2NAQjXP+PmF2FtZnU/LxEv4yE9w0X2riOJmc/SJZ+T3GcNz/Iz8Vi6kQXgjnoxCYjZ3e246ZPyt2fEjDOc5GswZ92Z7U7w4N/Yvwy4NxY/7zFwNd7hkFAz52zd5rFDPblMbYnoxSKVIjVaXhYBG3oLgbsv6hIQDMKlx9eTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Ip2IuUZ5; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6eddff25e4eso373786b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 15:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713998709; x=1714603509; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bQ7aAoW8uYuZUJ8c+fQ05Y2fxYHEV3uQB6MRkhy36Ug=;
        b=Ip2IuUZ5LfeaeG8LgTT7FPRSNVprS1WtQ8j+0rOBMsdFH8RkkiUSJdxlYmcWm0keco
         D0VyxtpaYBK3q8eO/87uN8z81J/XdcHp44mFnYRtTQyLFhhWKfvbInbP/sym7rPhnNN8
         73IKrRKCZtycqCXOrZtxQ2k6kD6uCr8YzTm4E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713998709; x=1714603509;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bQ7aAoW8uYuZUJ8c+fQ05Y2fxYHEV3uQB6MRkhy36Ug=;
        b=DxFjaB8M4SJ/CqXdPzYROUevaWbwHULYdCkFtjvwP88yEOJjJ4ZKifxmcNJ+7+UZgL
         BSVwVoIm7fyUaMmzaT0CsQIQnV0LSdsY90Nrw/18ZQPCbvY819dRSBJy+FOQdCcvbxya
         yeHsBfJczONs3dfr0ij3ZlCZp8LSjkdbXVKKNGXunmEWYMUjNPxt0zto3+gdU/EVrzdM
         dmprPUIz+S2v22GCzAEVm0I45Y+QtDoKJDtDiI2AeWOP0NOpRu9xfLDRi7pnAG3qkXfh
         9NJTm9b1JY5a1rR3woUWzPnBIbxXwi+JyDHRZTvilj8QbJEAeT5ZAT1MQBI/DJvNMp3J
         JdGw==
X-Forwarded-Encrypted: i=1; AJvYcCWjuS3o0FVkt/8WvkgHIYAWDJP0ikbeUE7gpBeq5MWZ8StP5RPHMaFRoa0jmA5T1h2Lm2GYNewCbI5o00d6i673gy/tPDtWZcvOBiVO
X-Gm-Message-State: AOJu0Yz/TVKk4uJHdItt+kM8LWOS1m+w/qA3v0pVoR3uWzbGIZIqvjco
	YwRqZN0XZqJ5ZgfsNHIuRj3uPS+YtMzFSEEIC9ScrYZdW5cdedxJanuY9QL9Dw==
X-Google-Smtp-Source: AGHT+IEAjXKcOqWbmJBmZ5dMg2rtYhG1LF2zwzQbtnGchw8LS/JZuvVMQDMhTtYVw79O2YlLzJPAxg==
X-Received: by 2002:a05:6a00:4fcb:b0:6eb:2b:43b4 with SMTP id le11-20020a056a004fcb00b006eb002b43b4mr5470380pfb.27.1713998708861;
        Wed, 24 Apr 2024 15:45:08 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id ln2-20020a056a003cc200b006eff6f669a1sm11902767pfb.30.2024.04.24.15.45.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 15:45:08 -0700 (PDT)
Date: Wed, 24 Apr 2024 15:45:07 -0700
From: Kees Cook <keescook@chromium.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Will Deacon <will@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Jakub Kicinski <kuba@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Uros Bizjak <ubizjak@gmail.com>, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
	netdev@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 1/4] locking/atomic/x86: Silence intentional wrapping
 addition
Message-ID: <202404241542.6AFC3042C1@keescook>
References: <20240424191225.work.780-kees@kernel.org>
 <20240424191740.3088894-1-keescook@chromium.org>
 <20240424224141.GX40213@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240424224141.GX40213@noisy.programming.kicks-ass.net>

On Thu, Apr 25, 2024 at 12:41:41AM +0200, Peter Zijlstra wrote:
> On Wed, Apr 24, 2024 at 12:17:34PM -0700, Kees Cook wrote:
> 
> > @@ -82,7 +83,7 @@ static __always_inline bool arch_atomic_add_negative(int i, atomic_t *v)
> >  
> >  static __always_inline int arch_atomic_add_return(int i, atomic_t *v)
> >  {
> > -	return i + xadd(&v->counter, i);
> > +	return wrapping_add(int, i, xadd(&v->counter, i));
> >  }
> >  #define arch_atomic_add_return arch_atomic_add_return
> 
> this is going to get old *real* quick :-/
> 
> This must be the ugliest possible way to annotate all this, and then
> litter the kernel with all this... urgh.

I'm expecting to have explicit wrapping type annotations soon[1], but for
the atomics, it's kind of a wash on how intrusive the annotations get. I
had originally wanted to mark the function (as I did in other cases)
rather than using the helper, but Mark preferred it this way. I'm happy
to do whatever! :)

-Kees

[1] https://github.com/llvm/llvm-project/pull/86618

-- 
Kees Cook

