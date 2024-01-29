Return-Path: <linux-kernel+bounces-43459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E13384141E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 21:22:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AFDA1F235F4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 20:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5634A76040;
	Mon, 29 Jan 2024 20:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="l6n3sbA8"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29AF66F08E
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 20:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706559764; cv=none; b=p5qg94hHpIdEZxaItajO2WgsHqAj1KDv/a4FPyVA35xTMItKA/HO8E3zPurjgyQmQfez2lDTc/GBBkaH9bhsta38fF1TQroxtpgyFluf2ZoXkndqUv9vl5+03oWK6oBE8PYSexXklAR6wufLQQJYwYHx/QkCAXxpXakz72ndTf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706559764; c=relaxed/simple;
	bh=o/NbrqV2S97L+H13EY/x2OcLCIh6zJNlJHIhIlry7AA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lL/3TW7CfwwdV9v7lsLGUfdug/0Y9Ev3+GWZYQdCCfd/O4T729znRL2h5GupVW2xH9f9db7fYyec+M7Hc9hU1aCJKplY57ewQu/3W28H+9jADjGkg9ryitLzMcVnLhc/ratShxPbcFgbzksgUbOqIICcuseCNz9J91FgRahUxwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=l6n3sbA8; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2959da74d80so397367a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 12:22:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706559761; x=1707164561; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z42ayviXl00pFftEywfCdZI1FjhKV2PnUlVfJ3EkjmY=;
        b=l6n3sbA8UIfAPfLgTY/02EhFrd04r8IE4ZzFBTKec+N1FZFBcjJ4x4/q4wFUtJCItD
         a3Wf6gUMbrZJQhe1u7fEWHbMMfQuFeFxYXl9+u4GB7gQLPG/kf/a+/jy/ECMIXLLMC2g
         XriZkhjdu3eeTbRRrpgq/KcSgMK9dijIsXufg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706559761; x=1707164561;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z42ayviXl00pFftEywfCdZI1FjhKV2PnUlVfJ3EkjmY=;
        b=VmmqdNH4Tj1a9kScchrDVDebb/svbB3fW9G/+FQrJqLidQEBuqYxTQESdNsYW+ugU0
         6yPRqV40hMJU9AhqRmcnk9cxk9Qk/SnLJAlHc1Tlrhvzaz07qQTZ497TzYxHtEd3ChvW
         0hnpm0igGSzo7iruQGKWCq8Y7t33/MThK6QY70RUEWqdT7lYTmpGzw5UYmiqThhNZERI
         Jc1dIl/oBJrQYci30Sx5+f9Mb32adTZTYFy1+g6nTNyyYXuFBBvF8Z7lTM2AfxwD1sU7
         o3Wf4ytua5RUwYBZ8vDX9x06UEIBcFqjapE0aaP3u28awisHdjyEnmF+PzWQ75lQmK9g
         u58Q==
X-Gm-Message-State: AOJu0Yw7xUWL1AGZZp+VgVv2jBDbXqEE2hm6NgQSOoytd7LlUfmBDqin
	8Xc2cBRq5kZuz04HnFlI5lJ802WZWAzQz3eswYxfN0IctGJnHJXYgPPZW6baaQ==
X-Google-Smtp-Source: AGHT+IHKFFpzQdzMeVVxTYSKwO60dgMxA8EJGc7W4MEDm2qbbjGDlc81pU8+CdO3BRwKTHCRTbIyDw==
X-Received: by 2002:a17:90a:b013:b0:290:121a:c382 with SMTP id x19-20020a17090ab01300b00290121ac382mr2629214pjq.24.1706559761292;
        Mon, 29 Jan 2024 12:22:41 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id d15-20020a17090a498f00b00291000d8210sm8568534pjh.19.2024.01.29.12.22.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 12:22:40 -0800 (PST)
Date: Mon, 29 Jan 2024 12:22:40 -0800
From: Kees Cook <keescook@chromium.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Marco Elver <elver@google.com>, Miguel Ojeda <ojeda@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Peter Zijlstra <peterz@infradead.org>, Hao Luo <haoluo@google.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Fangrui Song <maskray@google.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Nicolas Schier <nicolas@fjasle.eu>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
	llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 2/6] ubsan: Reintroduce signed and unsigned overflow
 sanitizers
Message-ID: <202401291221.99D8568D0@keescook>
References: <20240129175033.work.813-kees@kernel.org>
 <20240129180046.3774731-2-keescook@chromium.org>
 <20240129195418.hftkcdksptmpfv3i@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240129195418.hftkcdksptmpfv3i@google.com>

On Mon, Jan 29, 2024 at 07:54:18PM +0000, Justin Stitt wrote:
> Hi,
> 
> On Mon, Jan 29, 2024 at 10:00:39AM -0800, Kees Cook wrote:
> > Effectively revert commit 6aaa31aeb9cf ("ubsan: remove overflow
> > checks"), to allow the kernel to be built with the "overflow"
> > sanitizers again. This gives developers a chance to experiment[1][2][3]
> > with the instrumentation again, while compilers adjust their sanitizers
> > to deal with the impact of -fno-strict-oveflow (i.e. moving from
> > "overflow" checking to "wrap-around" checking).
> >
> > Notably, the naming of the options is adjusted to use the name "WRAP"
> > instead of "OVERFLOW". In the strictest sense, arithmetic "overflow"
> > happens when a result exceeds the storage of the type, and is considered
> > by the C standard and compilers to be undefined behavior for signed
> > and pointer types (without -fno-strict-overflow). Unsigned arithmetic
> > overflow is defined as always wrapping around.
> >
> > Because the kernel is built with -fno-strict-overflow, signed and pointer
> > arithmetic is defined to always wrap around instead of "overflowing"
> > (which could either be elided due to being undefined behavior or would
> > wrap around, which led to very weird bugs in the kernel).
> >
> > So, the config options are added back as CONFIG_UBSAN_SIGNED_WRAP and
> > CONFIG_UBSAN_UNSIGNED_WRAP. Since the kernel has several places that
> > explicitly depend on wrap-around behavior (e.g. counters, atomics, crypto,
> > etc), also introduce the __signed_wrap and __unsigned_wrap function
> > attributes for annotating functions where wrapping is expected and should
> > not be instrumented. This will allow us to distinguish in the kernel
> > between intentional and unintentional cases of arithmetic wrap-around.
> >
> > Additionally keep these disabled under CONFIG_COMPILE_TEST for now.
> 
> This is present in the patch but perhaps its worth noting here that x86
> has trouble booting with the unsigned-integer-overflow sanitizer on.

Yeah, though this is fixed later in the series.

> 
> >
> > Link: https://github.com/KSPP/linux/issues/26 [1]
> > Link: https://github.com/KSPP/linux/issues/27 [2]
> > Link: https://github.com/KSPP/linux/issues/344 [3]
> > Cc: Justin Stitt <justinstitt@google.com>
> > Cc: Miguel Ojeda <ojeda@kernel.org>
> > Cc: Nathan Chancellor <nathan@kernel.org>
> > Cc: Nick Desaulniers <ndesaulniers@google.com>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Marco Elver <elver@google.com>
> > Cc: Hao Luo <haoluo@google.com>
> > Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> 
> 
> This patch adheres to the language semantics as I understand them.
> Moreover, we would've had to send a patch similar to this once we land
> some better sanitizer + -fno-strict-oveflow support in the compilers.
> 
> Currently, though, -fsanitize=signed-integer-overflow instruments very
> little (if anything at all) due to compiler optimizations in conjunction
> with -fno-strict-oveflow. I am working on a new
> -fsanitize=signed-integer-wrap in Clang which will instrument more
> arithmetic even under -fno-strict-oveflow.

Agreed -- I'm mainly getting these back into the kernel so folks working
on this have a common base to work from.

> Reviewed-by: Justin Stitt <justinstitt@google.com>

Thanks!

-Kees

-- 
Kees Cook

