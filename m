Return-Path: <linux-kernel+bounces-79380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A7E1862166
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 02:01:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E1C1282216
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 01:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 120981864;
	Sat, 24 Feb 2024 01:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="e8NzR+3F"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF81B15A4
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 01:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708736486; cv=none; b=EsVs2CeftJJygBBarlDpF8Na5ikOi8YBjzM/ljOxh4GvjtJit9pZUwTPQYxfSJyC1HzC2Y6A22wylb8qAkR+igm46cttP8dq/fOr6EXjF6qhuNR6NavkRWrbQK4AtO3hrTaT/3V2h8PYxXpnPT2YulaT99v7qwzASYQZdc7tJPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708736486; c=relaxed/simple;
	bh=K+YWxm3ZnA65N6uzvESG36jAKxg1RHhLnGwcPKoEkUo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qhI2IV0hrONAO6lmLsAq1pvL43/pI91maY6Lfzsn7SuS/0W6wnbiWChx2m4TAzFI9vys1BNmApBmNajCeKhVbyNsNYDI9mp4rfCUltPtGvzf0dPd29V3nEarmkEogGbr/64ovZ8yIgasEnku+et/D95ICG5QvwOZDlX0P4RH9fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=e8NzR+3F; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-5d3912c9a83so1057403a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 17:01:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708736484; x=1709341284; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DRLwM6QENBYo07bvqNRkIhBVin7jRxajehNcXch+bs4=;
        b=e8NzR+3FJP72fLHPIUoJZxSd/2svcOlFZjOI9737xBHqIIKFTGC/vqzbkpLtRkHlZB
         CBhNAUNralXCpV2B4K8ObspOoXMhzMLJKmM3fn9qZImwpokvNvYm5k+gvj2+s2WtQN8U
         OOwbY3jURKIO4cb1b6Spwc7LcQE7hh1gxN9tA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708736484; x=1709341284;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DRLwM6QENBYo07bvqNRkIhBVin7jRxajehNcXch+bs4=;
        b=pAcFMQcZa6T3tObrjuhLyYdYHULEWD3Q2ABbFQzOVLD+EeySdwwDMAAtC9rHsstSjC
         NHq49hEaCLSYVgMQKt9PrVAhkNTFSOWzI4F6kl6zgqWgLi3//+qVViTloWn7gBsLGy42
         mGxijJ/jSucnfAwufdTHLBztxlj4h5jdtyiMSuo3PSHRN23SgXXjuDksVXB8nbTVvfDf
         Bv1obWas9oCSqhHjKqni1EeeDyEa99/lT2RwnES7zWhvcLlvXqDln1bBHU1p8eScW7xC
         aJHILIeut9qwcIEC3io3PbxQRapVwwuUzKWADtuBOcYqd+AuVqKvX+Bg7xnB0jKdPyG5
         UQXg==
X-Forwarded-Encrypted: i=1; AJvYcCW6eMJfsXe1tWDITdlBLrEMlwi373wmpv6eR+bvtsr0PJF6Jk6HjcexTJWKZnpIrr954qvhckfoKnkw+lkk403sZBWDH3s+eCOA3o/D
X-Gm-Message-State: AOJu0Yzos/Cb5F/xb7B6deGaEHtULElAo2fCKbLXyswcvfSpmBzpfDY4
	cQQgkiVZ/kHB86zSFs10Nl87fxE2ddPJrCsHnwy9p0hUbC4VA/ylQpPenONjSw==
X-Google-Smtp-Source: AGHT+IEQ/boZR0NbbEtoiMOkLTe3Imh3KOI4GOUbKXTvlWKbMxa6XhC6hM+HIa944+irNktavkW2SA==
X-Received: by 2002:a05:6a21:8ccc:b0:19e:c777:5c6c with SMTP id ta12-20020a056a218ccc00b0019ec7775c6cmr1727576pzb.19.1708736482583;
        Fri, 23 Feb 2024 17:01:22 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id y5-20020a62b505000000b006e0447d48b0sm90582pfe.23.2024.02.23.17.01.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 17:01:22 -0800 (PST)
Date: Fri, 23 Feb 2024 17:01:21 -0800
From: Kees Cook <keescook@chromium.org>
To: Dmitry Vyukov <dvyukov@google.com>
Cc: Kostya Serebryany <kcc@google.com>, Vitaly Buka <vitalybuka@google.com>,
	glider@google.com, Evgeniy Stepanov <eugenis@google.com>,
	Daniel Micay <danielmicay@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
	x86@kernel.org, Pratyush Anand <panand@redhat.com>,
	Dong Bo <dongbo4@huawei.com>,
	Dmitry Safonov <dsafonov@virtuozzo.com>,
	Rik van Riel <riel@redhat.com>,
	Andy Lutomirski <luto@amacapital.net>,
	Grzegorz Andrejczuk <grzegorz.andrejczuk@intel.com>,
	linux-arm-kernel@lists.infradead.org,
	Reid Kleckner <rnk@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Collingbourne <pcc@google.com>, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, address-sanitizer@googlegroups.com
Subject: Re: [PATCH] mm: Revert x86_64 and arm64 ELF_ET_DYN_BASE base
Message-ID: <202402231649.086D1A3A@keescook>
References: <20170807201542.GA21271@beast>
 <202402162238.E5D08F5968@keescook>
 <CACT4Y+ZnNdb1z7oSq0zb3XHFTcdEwSMFvcvLJxm1VrgnpaohMw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+ZnNdb1z7oSq0zb3XHFTcdEwSMFvcvLJxm1VrgnpaohMw@mail.gmail.com>

On Tue, Feb 20, 2024 at 08:47:09AM +0100, Dmitry Vyukov wrote:
> On Sat, 17 Feb 2024 at 07:50, Kees Cook <keescook@chromium.org> wrote:
> >
> > *extreme thread[1] necromancy*
> >
> > On Mon, Aug 07, 2017 at 01:15:42PM -0700, Kees Cook wrote:
> > > Moving the x86_64 and arm64 PIE base from 0x555555554000 to 0x000100000000
> > > broke AddressSanitizer. This is a partial revert of:
> > >
> > >   commit eab09532d400 ("binfmt_elf: use ELF_ET_DYN_BASE only for PIE")
> > >   commit 02445990a96e ("arm64: move ELF_ET_DYN_BASE to 4GB / 4MB")
> > >
> > > The AddressSanitizer tool has hard-coded expectations about where
> > > executable mappings are loaded. The motivation for changing the PIE
> > > base in the above commits was to avoid the Stack-Clash CVEs that
> > > allowed executable mappings to get too close to heap and stack. This
> > > was mainly a problem on 32-bit, but the 64-bit bases were moved too,
> > > in an effort to proactively protect those systems (proofs of concept
> > > do exist that show 64-bit collisions, but other recent changes to fix
> > > stack accounting and setuid behaviors will minimize the impact).
> >
> > I happened to be looking at this again today, and wondered where things
> > stood. It seems like ASan's mappings are documented here:
> > https://github.com/google/sanitizers/wiki/AddressSanitizerAlgorithm#64-bit
> >
> > This implies that it would be safe to move the ELF_ET_DYN_BASE from
> > 0x555555554000 down to 0x200000000000, since the shadow map ends at
> > 0x10007fff7fff. (Well, anything above there would work, I was just
> > picking a "round" number above it. We could just as well use
> > 0x100080000000, I think.)
> >
> > Is this correct? I'd like to open up some more room between mmap and
> > stack...

Thanks for the details!

> Note that there is also TSAN and MSAN with their own mappings.
> These are also different per-arch, e.g. TSAN/Linux/x86_64:
> https://github.com/llvm/llvm-project/blob/d2a26a7bd5fc7cc5752337b7f4f999642feb37dc/compiler-rt/lib/tsan/rtl/tsan_platform.h#L48-L58
> Search "linux/" in that file for other arches, e.g.:
> https://github.com/llvm/llvm-project/blob/d2a26a7bd5fc7cc5752337b7f4f999642feb37dc/compiler-rt/lib/tsan/rtl/tsan_platform.h#L156-L165
> https://github.com/llvm/llvm-project/blob/d2a26a7bd5fc7cc5752337b7f4f999642feb37dc/compiler-rt/lib/tsan/rtl/tsan_platform.h#L187-L196
> https://github.com/llvm/llvm-project/blob/d2a26a7bd5fc7cc5752337b7f4f999642feb37dc/compiler-rt/lib/tsan/rtl/tsan_platform.h#L218-L227
> https://github.com/llvm/llvm-project/blob/d2a26a7bd5fc7cc5752337b7f4f999642feb37dc/compiler-rt/lib/tsan/rtl/tsan_platform.h#L252-L263

Depending on VA size, these are effectively all below 0x3800 0000 0000.

> 
> And MSAN mappings:
> https://github.com/llvm/llvm-project/blob/d2a26a7bd5fc7cc5752337b7f4f999642feb37dc/compiler-rt/lib/msan/msan.h#L44-L61

These are all below 0x1000 0000 0000.

So there probably isn't much benefit in reducing the PIE program
position below the current 0x55....

Okay, thanks!

-- 
Kees Cook

