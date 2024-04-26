Return-Path: <linux-kernel+bounces-160444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 31C928B3D93
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 19:06:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 886D5B210F9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 17:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47B7C15B0FA;
	Fri, 26 Apr 2024 17:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ONESOwyX"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5586C1DA58
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 17:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714151181; cv=none; b=OiYNns6Dcfvi8B4JmroCw6DwMyGBpKeI9TC87Q2NQyFOQHJyNU0AxRXryezz+yFk8i/6AMiF5rqCZo6KDoTqLL/0YrUlkDKu0nEF5LVSyVeVlteCIWP+X0Y6x7Ot/nikIg8FF4zQ8ocFVqTiCpuqTCQdcEq/EXPNoYcwEyO/Icw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714151181; c=relaxed/simple;
	bh=rUgSrXh/kUp2ce5vjmf3tVk45NuHCMnuJRWXof5A6Yg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SQaMl/igPCBqXMA2pe/GP6eCKUic2sEP6s483cbQiXBoqahuR/kBExxhg2dMtO/RxP2qxffkyCCAA1x/2bq2uU7ZIB2fpzDH9Ysn6A5Su+uN6jnlVKh8p0VxR6rRq7f6s2JJfqNwXyqNnmJ9z49fW1Z3+1oZZkif3tc0Y3kCbmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ONESOwyX; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6eddff25e4eso2122776b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 10:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714151179; x=1714755979; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SgX9HQcRhIm4KtQdq9GYft3Q0ZiwCuQWZ5JhWxXdoTI=;
        b=ONESOwyXanvGKL36PzGhd0DOJMpT5FjSFo1lvvqbpR6bpDV4ZkCE4PoMDt2xbJ4/WL
         CXccHUAGLUKusg350m6JZ5I6RK9NaAB81Jp9biFW+mti8/XllNByFlumxXcsCP46LTil
         AolJ8YJfHjRiX3GLhcWk0+fr72CKu9iYLvcPs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714151179; x=1714755979;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SgX9HQcRhIm4KtQdq9GYft3Q0ZiwCuQWZ5JhWxXdoTI=;
        b=hLGF1lQqNVGilzkPy6C0N+IpC0+9nnKF4hUjptsuwifIdJNyA5IGDKerUKbtDnF46u
         Ryd4FzXQuQtjKnrIRBf6vtKFaIFFW/Mr8VvCFtZ9Fx3lpnmREuPQtmJYpCvtkriiw63e
         QkLyLuE93yVeTfI8J7PgwS7MJ9cfS9h1Gw0LAT+rYIMTGjYM7hiUJb5TdeQ6E98Qq+Qi
         O8mADCDFPXb3TjCBShsQMD+4iPY5VwpttNEQmZvOkFkQyzZyyk4ADuQll7jUKI3psICg
         +z+64zZTnZtStqTeveiNYbPOZ1YrHRqK154+ixU+yOZd4QqFUIjOnCztETQwx1vUqRUW
         mbcQ==
X-Forwarded-Encrypted: i=1; AJvYcCULsUwWJrRxaFOAl0+m+lbTTsjLrSvT+G4/d8PEdg9J+z+DHJwEQxAex2xtLWG2kY+5uiEZGAHP434faOP/h0A6hhU76zPG9jP6Ks3k
X-Gm-Message-State: AOJu0YzHMgHFaM6u08A0ZVjua6rye5KJyb/gPxGdUwRZfpddJw8XAhqW
	rEEOgP4EiYKv36nyL6V9zCxonPi2Q+X2LDoM5tvAFwHNFFHcgVypbXqBqTIF4A==
X-Google-Smtp-Source: AGHT+IFRuONJTBeF5jWTd1Z1iUSFqM7Mlp2kx8AS+7oOD8Od6nCZUNw8lqItcPq8AJeYMewLdxXOFA==
X-Received: by 2002:a05:6a20:9703:b0:1ad:92e0:f5d7 with SMTP id hr3-20020a056a20970300b001ad92e0f5d7mr3368882pzc.46.1714151179677;
        Fri, 26 Apr 2024 10:06:19 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id jw37-20020a056a0092a500b006ecf0ad97bbsm15541913pfb.17.2024.04.26.10.06.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 10:06:18 -0700 (PDT)
Date: Fri, 26 Apr 2024 10:06:17 -0700
From: Kees Cook <keescook@chromium.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Suren Baghdasaryan <surenb@google.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] mm/slub: Avoid recursive loop with kmemleak
Message-ID: <202404261005.F7393F558@keescook>
References: <20240425205516.work.220-kees@kernel.org>
 <Ziu_qOmgnWRdAByp@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ziu_qOmgnWRdAByp@arm.com>

On Fri, Apr 26, 2024 at 03:52:24PM +0100, Catalin Marinas wrote:
> On Thu, Apr 25, 2024 at 01:55:23PM -0700, Kees Cook wrote:
> > The system will immediate fill up stack and crash when both

Oops, typo from me: "immediately". You'd never guess I'm a native English
speaker! :)

> > CONFIG_DEBUG_KMEMLEAK and CONFIG_MEM_ALLOC_PROFILING are enabled.
> > Avoid allocation tagging of kmemleak caches, otherwise recursive
> > allocation tracking occurs.
> > 
> > Fixes: 279bb991b4d9 ("mm/slab: add allocation accounting into slab allocation and free paths")
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> 
> For the kmemleak bits:
> 
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>

Thanks!

-Kees

-- 
Kees Cook

