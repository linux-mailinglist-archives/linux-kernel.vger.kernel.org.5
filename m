Return-Path: <linux-kernel+bounces-146047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7078E8A5F73
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 02:46:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F5FF1F21EE2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 00:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40F3A4C7E;
	Tue, 16 Apr 2024 00:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="P0gwi6j9"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE5D1849
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 00:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713228390; cv=none; b=uyQwhD7d+4oo08H5fx5AUF74JXDCggHoR42k17SNIRyoQE0CCIMppF9Th4woCMO1tZmXJX49HkjU+mZJiYSmTgZW7byI+Vct5vPn0URXStJrmKpJv33VwdeRqI2TrmvvMznGQJp3s/zU1sbZeoSj0d8pelNKCSF6cnvxaceRe5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713228390; c=relaxed/simple;
	bh=015eEwhLzWafHkc0BsCRogWYfs3SqoEKVTXAAy/Fhf0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pdNGnz3UmRxvRuENG+s+z0IyOF/D62rxjB4waLI82LF70e+RJW5PBzOH0FuaXlnrycGUVT6/XiMsxGd1BWNZrZi2IH74eUNXjx/fubki0RufCfA0w4aq6wNd/coAGjFfDEk+VmyOJLmLczeHyj0nlNCgEgGBF/fMX4Vmm81EAn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=P0gwi6j9; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1e51398cc4eso36781665ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 17:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713228388; x=1713833188; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SarbV9gzd7Ext5uREk+cO+VjFEa4L7Rs/CELnpCJsv8=;
        b=P0gwi6j9oLI/Dwi5h7eAZTZi3aI00LBxvktANtbgHKKzHAFmz68iLfOWl05rx1bfUA
         ldfTKzej5CEwBxGW74Sf6f2U2kl01+mMPBmpYzmOQhl9oYWn35vpzvak3m1jaTylVs+c
         Ceq5Habm015Kj15goXxJKgXLhBfEglQax9Wl8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713228388; x=1713833188;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SarbV9gzd7Ext5uREk+cO+VjFEa4L7Rs/CELnpCJsv8=;
        b=gZYed3egUnDOLXOLgdNCh2/fCzrRpeEDVq9awKWpdw7z3z1mNsvnIGrDQ/Vu6dkGLr
         3kmRhjEFLPtNzzi9hJv+6agQQsz2izUtb0TUVvBzRHhd06zPBrsV5Qf8+kkjkrzf6nge
         /gnOc9YvcjuGzgiQn5OKVoPG4BaE+og1K2ZJha4pQfkmke4uDevvxdU4jmXDR+GiwtST
         KyP3vdasr6r/0429PoqqU8vKA5dD63joNOQcZcw3I8skpv+O0c64HABTo9To0/eCe6nH
         HhxIsIxs9LbcFcmk4IPYpvxmjB44X19vXrqJ+9UxnzYIsSLGrXzmUfxwPlgyNc7xjcCH
         +wtA==
X-Forwarded-Encrypted: i=1; AJvYcCUM7voNuHTow4AdfFzz/tVlSoCBQXPVI1ArDS1Z8OV0eqDME7UTiAvEFPpztz3Pu1ZAegOg18g+RHXdU6iGKpoyBlGTq+onz9MLgbNf
X-Gm-Message-State: AOJu0YzcBHn4fF0ZLD5mHWnMLGVeIiLwlzVl8XBx5sCJSjzj6C9jXjeH
	aDdc2fPnTiC3M5kWX2WIowNtuJOv/qAHanHIcRkozT9RON0YvK0kQoZyb0rynw==
X-Google-Smtp-Source: AGHT+IHX1mELGRta6OeQsH8t8lp3e5H1mp/8L3cNAf/ZlRUnfUwX1Jl3r6/rRS9SAEK7dC+5kIawkw==
X-Received: by 2002:a17:902:82c4:b0:1e4:b4f5:5cfa with SMTP id u4-20020a17090282c400b001e4b4f55cfamr11411241plz.27.1713228388653;
        Mon, 15 Apr 2024 17:46:28 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id im22-20020a170902bb1600b001e3d2314f4bsm8688355plb.132.2024.04.15.17.46.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 17:46:28 -0700 (PDT)
Date: Mon, 15 Apr 2024 17:46:27 -0700
From: Kees Cook <keescook@chromium.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Marco Elver <elver@google.com>, Justin Stitt <justinstitt@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	kasan-dev@googlegroups.com, linux-hardening@vger.kernel.org,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH] ubsan: Add awareness of signed integer overflow traps
Message-ID: <202404151738.AC6F6C210@keescook>
References: <20240415182832.work.932-kees@kernel.org>
 <20240415183454.GB1011455@dev-arch.thelio-3990X>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240415183454.GB1011455@dev-arch.thelio-3990X>

On Mon, Apr 15, 2024 at 11:34:54AM -0700, Nathan Chancellor wrote:
> On Mon, Apr 15, 2024 at 11:28:35AM -0700, Kees Cook wrote:
> > On arm64, UBSAN traps can be decoded from the trap instruction. Add the
> > add, sub, and mul overflow trap codes now that CONFIG_UBSAN_SIGNED_WRAP
> > exists. Seen under clang 19:
> > 
> >   Internal error: UBSAN: unrecognized failure code: 00000000f2005515 [#1] PREEMPT SMP
> > 
> > Reported-by: Nathan Chancellor <nathan@kernel.org>
> > Closes: https://lore.kernel.org/lkml/20240411-fix-ubsan-in-hardening-config-v1-0-e0177c80ffaa@kernel.org
> > Fixes: 557f8c582a9b ("ubsan: Reintroduce signed overflow sanitizer")
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> 
> As I mentioned, CONFIG_UBSAN_SIGNED_INTEGER_WRAP needs to be
> CONFIG_UBSAN_SIGNED_WRAP. I applied this change with that fix up and the

Whoops; thanks!

> warning now becomes:
> 
>   Internal error: UBSAN: integer subtraction overflow: 00000000f2005515 [#1] PREEMPT SMP

Perfecto. :)

> So:
> 
> Tested-by: Nathan Chancellor <nathan@kernel.org>

Thanks!

-- 
Kees Cook

