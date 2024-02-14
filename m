Return-Path: <linux-kernel+bounces-66069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B1CB855637
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 23:40:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2305828C471
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 22:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 799202511E;
	Wed, 14 Feb 2024 22:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KOPzOypk"
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D68182DF
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 22:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707950421; cv=none; b=RyTYbyZIjuG9vDO7gl+H07TNF2GcOmnInptGjzsw0dhb5BjVBRhVdi0JDn83dAEwtrMlUQgagFf1Ank2lkbL6GlB5tHb/4h/bGfBxZaa7RTVQFi3FoczwNDgaEV4CL31bXyrbgR1IHuz7ao5Wlc3cfrlKwrzWw1Bm8rTU+pbcr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707950421; c=relaxed/simple;
	bh=cANzLdZ69BXZUyjsl7ZwBQxdKLwR8JzDdiDwyOSPWKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r18MLaQyWHIBDyC4NNuu0l+940B5sLORm/iLIVE9NzmiFNWlkKv9y/j2J86AtnCrqRHqOnl347grwlx18fD9cWmzvFqGhtHX0PWXbNZQZUQkGmRuO7tg0OMBLUfX3KUM06+zzOjw8KzXx1qaxWzS8Oz1tCcW9RmLNMRyppi69Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=KOPzOypk; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-59d7cbf1279so152061eaf.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 14:40:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707950419; x=1708555219; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BKV6eQTwSUgCbVKAYzQ+RCk2l6zXw4xuEU/9A1u4Sz4=;
        b=KOPzOypkUwv12r2mSM0+cVZZg5KFgzatJqHJVVJGLm0h/XEQJ8t1+tRY+PqnzX0Sjg
         vM2nOfhFYiWgI05s22ScgFdT16VQDEHflhYaKiOIh/mVsVWTRIZ7n9zmEguQkKW34XEC
         aR3QbVd9D/m06gCRUGwUyeJmVtx3oZ9Fe588Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707950419; x=1708555219;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BKV6eQTwSUgCbVKAYzQ+RCk2l6zXw4xuEU/9A1u4Sz4=;
        b=CaUE/PcYm1EAGJ3CC+nXuQclYhQkBUDBTKq/E8pRiF3lx0QuKXGVgM/YoAbLfn20YU
         S3qJGvDVwWE9DCBP8WRZrpujA24k5wCkZvpmIqYm6BelYERh6riBWuGaZ49zPHj76Ui3
         UMpr/rRMsj1fyxa0tEGl6j22gUdQlzgG3Ifx2XDgLJnryyQweMe6zeytKOPir7WeL5TZ
         rbvrDeicQTl5DgnGwSAI/Jtnaj9E1/IvZ10F5tknEQsP3Ja6efojIaHH0YwgzNGmuMYt
         skwH0atTu1hSFlPeuToPG6MQ7IFZM0a/0m1dw1DCouDxOCkw2FB1PwwETLbMIqECzgCw
         cEyA==
X-Forwarded-Encrypted: i=1; AJvYcCXMy3PXsWvcc5Q5NDvNQApraas/r/80ZO3DI+2oFpha3QjVZUCQBxsIxGT0GL87XznSsz+jUY5paiWTpunVSTzq+5AWtQW9zHjpbiJY
X-Gm-Message-State: AOJu0YxVrOCD9VZwvkBnl2WlxHZFjPsQ1WFjOE5lgWT7Ahv0n8ZSkEbZ
	d0Ro+8wpk/tw4BnuvWWVK2SyUFL6Svxcq2BiKpOFAMQYUk46AINzr/3G4zHjX/MkuQB1SDCy/EY
	=
X-Google-Smtp-Source: AGHT+IGcdrio1ldk5+vxaJFwF0luoiodDJsqYEknT7Yw0yQZLAaWvxePby1AUdnoF7c7Z1tLFhxtqA==
X-Received: by 2002:a05:6358:3a15:b0:178:b7c0:323f with SMTP id g21-20020a0563583a1500b00178b7c0323fmr3714184rwe.19.1707950419171;
        Wed, 14 Feb 2024 14:40:19 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXrvjO9kRybzFmkrE+j6y1WylSG4Yl9Nxy/NnfqTM85wBBNGCxsWlx4otJemAN01Dnozo2f8CEFdwODsT2t1t+a40dKRJwtBYywqwilIL40XNIKoaxVpuX7Nj+Ag/0x67uPLXeCkdGUmWYuZTIwtGOOPm13TJST93bBZKp4By+OxB5JFePRpMOXVeW09l1ZUa/gDvVrYWN4r+MDgPyBeaaiQRU2ODWk
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id v11-20020a056a00148b00b006e0334e3dd9sm9710190pfu.76.2024.02.14.14.40.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 14:40:18 -0800 (PST)
Date: Wed, 14 Feb 2024 14:40:18 -0800
From: Kees Cook <keescook@chromium.org>
To: Fangrui Song <maskray@google.com>
Cc: Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	x86@kernel.org, linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	Nathan Chancellor <nathan@kernel.org>,
	Heiko Carstens <hca@linux.ibm.com>
Subject: Re: [PATCH] x86/build: Simplify patterns for unwanted section
Message-ID: <202402141433.AC69F2A3@keescook>
References: <20240214212929.3753766-1-maskray@google.com>
 <202402141405.0755DD4E5E@keescook>
 <CAFP8O3LWBHkbLwFJdmy7iSGD0cMSy1jczETo=N6oVapCgPY=sA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFP8O3LWBHkbLwFJdmy7iSGD0cMSy1jczETo=N6oVapCgPY=sA@mail.gmail.com>

On Wed, Feb 14, 2024 at 02:13:01PM -0800, Fangrui Song wrote:
> On Wed, Feb 14, 2024 at 2:07 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > On Wed, Feb 14, 2024 at 01:29:29PM -0800, Fangrui Song wrote:
> > > A s390 patch modeling its --orphan-handling= after x86 [1] sparked my
> > > motivation to simplify patterns. Commit 5354e84598f2 ("x86/build: Add
> > > asserts for unwanted sections") added asserts that certain input
> > > sections must be absent or empty. The patterns can be simplified.
> > >
> > > For dynamic relocations,
> > >
> > > *(.rela.*) is sufficient to match all dynamic relocations synthesized by
> > > GNU ld and LLD. .rela_* is unnecessary. --emit-relocs may create .rela_*
> > > sections for section names prefixed with _, but they are not matched by
> > > linker scripts.
> > >
> > > .plt instead of .plt.* is sufficient to match synthesized PLT entries.
> >
> > Do you mean ".plt.foo" matches ".plt" ?
> 
> I mean we just need .plt : { *(.plt) } , not .plt : { *(.plt) *(.plt.*) }.

But then, for example, if it gets generated, .plt.got ends up being
reported as an orphan...

> 
> The linker synthesized section for PLT entries is .plt, not suffixed.
> 
> > > .igot and .igot.plt are for non-preemptible STT_GNU_IFUNC in GNU ld (LLD
> > > just uses .got), which the kernel does not use. In addition, if .igot or

Right, the issue has been getting totally weird sections emitted by the
linker. If you're saying you'd rather those get reported as orphan
sections instead of being validated for being zero sized, and that works
for all the architectures, then okay.

> > > .igot.plt is ever non-empty, there will be .rela.* dynamic relocations
> > > leading to an assert failure anyway.
> >
> > I think at the time I was dealing with avoid multiple warnings out of
> > the linker, as I was getting orphan warnings in addition to the
> > non-empty warnings.
> >
> > >
> > > [1]: https://lore.kernel.org/all/20240207-s390-lld-and-orphan-warn-v1-6-8a665b3346ab@kernel.org/
> > >
> > > Signed-off-by: Fangrui Song <maskray@google.com>
> >
> > Is anything harmed by leaving all of this as-is?
> >
> > -Kees
> 
> No harm. But ports adopting --orphan-handling= (like s390) may copy
> the unneeded .rela_* .
> When people read .rela_*, they might think whether the kernel does
> anything special that
> .rela_* needs to be matched.

I added these because the were being generated. See commit d1c0272bc1c0
("x86/boot/compressed: Remove, discard, or assert for unwanted sections")

I don't want to suddenly start generating warnings for older/broken
linkers. (i.e. a change like this needs really careful testing, and that
needs to be detailed in the commit log.)

-Kees

-- 
Kees Cook

