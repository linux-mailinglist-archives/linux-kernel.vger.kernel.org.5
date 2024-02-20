Return-Path: <linux-kernel+bounces-72493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 266A285B430
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 08:47:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A200E1F221B9
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 07:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22B2B5B5D0;
	Tue, 20 Feb 2024 07:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KDlUkjOc"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E91D5C612
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 07:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708415248; cv=none; b=RCS0NU99yyW6rZOyGuGgJ/z/x4QpENyOWDBPj078LfRoK2d/V6OQ5yBQya/e35LUQtJo782G7zlvDZlH7sJuDDpZYJWYl9EvpAWEJhF+cWaGH6VyUCyT+dxn+LDLWTHyZBaYiF99/yNuBLxdCtwy1MubCCKcy1Dl3OwZHTcopkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708415248; c=relaxed/simple;
	bh=KDu3AIEqM9JX36Uqj21nqjSSf+QkksyfYXRio+nzlJ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zeoyaq1DGmFgtUE/sI593bYLQd2FtVCGDyq393XAxgcEuYY2kp69d1YE6Xd0klfGoOAo79tvix2sMAe/fiOAK4Hbh5QbhnvG/zgyTPoCEHSz16qeBGpATrnHCfDGfPl/vI2oJzPg3f8+QUK1+f2G8RK0VsHY99niHMlUkohkFOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KDlUkjOc; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5128b282a5aso6747e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 23:47:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708415244; x=1709020044; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ys0fTbGR+PNOalHZscSf5vFKDxK0UOyw7ua9MFwnkBs=;
        b=KDlUkjOcS8XhaiGWEkxfbF1qqtXyvqj26vOIa5NY9lM1VHNzNyeCUa7VhSoB23gvGc
         v5WdasEBVDGwksVlLghqZYAsH6FAFt3Rz9mlxpr0Kh/WOIf4bndug6a2/a4j06lrfQd1
         I35v9LY25JHk3WoiuvV9vkYop7tMY8n64LfE8z95IAr2wWvVPctlJMBIEdLynrPJpL9h
         vBrp1HwoskMHs4uYU/hGqJ1ja1hPhcmbtGui3UDIPXGDHPCw3ea7AwVglPyNI6gKcKkt
         +9NnjUmK2UrL6bOPnYCDgpOfxdO4QFVO2JLqVYDl2xRDxb4X3e5zCid+K7p7DcY4Xd0y
         VnTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708415244; x=1709020044;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ys0fTbGR+PNOalHZscSf5vFKDxK0UOyw7ua9MFwnkBs=;
        b=UwqXeYe0HGgNnlxPQ3pzkTzxTxtDPuldqVyNWosX/RggeWuyMN87Qr73LMgDxBLp5a
         tTbWVUmIeJVgfA+jaIK7SuSlPgVV3BQXaRMtuCTPb+NP7gtDq+xmUWFzuW9KjiLcTA20
         aDQCXaEWU2pg7NYH4JuBQbn2uUGBxepeYqJVlcHM7qataXH/kBwVvnaA6QVwQXUQeP/M
         jvU7tRKTgFeeyKhgvwjhkSx5tKBgxG++3HqIJexWXC35iSqbKguvllNoO5J0pI6z2VVZ
         b/MSrIuV29DJ/7Svo61BjX2bg2V59ofKo1A5GmkVoaeeUuY0BIUIUnjrXb0moSZPw73/
         oNlQ==
X-Forwarded-Encrypted: i=1; AJvYcCVa3zxdVCq+a8uybIufkKaH0+MQJ/L1gy9vyHqyvXgtjKkR2mXEwgAJaaw4u3hp18V3MkK2RCwUd/65LNbpY0ktRC1KUT14UZcQ0T2S
X-Gm-Message-State: AOJu0YxCJIjuknTEKTEIJG0Ni+RRM/Ik1OpZ0WWgesj/wAgowKxP3QTx
	SRS/TdvioGzzj8sOeHPoTP9TkKAV3Qpl7Bt9dAh3ClA+p0WEMmZaGCifLfdX537FH01GvCUEkTx
	F4I6Y9FcFEPXpikcYNFWgn8WFzK2TvsSUPoHY
X-Google-Smtp-Source: AGHT+IGvRDTW6DJWhU2NlG6mpNNuZrO1O9fkzzQcP0p3KjQaMkXGbjSbNwn8KskwLGxI/sYq37sFd5Qst1wEVVxed8w=
X-Received: by 2002:a05:6512:3d22:b0:512:bd64:53c2 with SMTP id
 d34-20020a0565123d2200b00512bd6453c2mr136840lfv.6.1708415244247; Mon, 19 Feb
 2024 23:47:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20170807201542.GA21271@beast> <202402162238.E5D08F5968@keescook>
In-Reply-To: <202402162238.E5D08F5968@keescook>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Tue, 20 Feb 2024 08:47:09 +0100
Message-ID: <CACT4Y+ZnNdb1z7oSq0zb3XHFTcdEwSMFvcvLJxm1VrgnpaohMw@mail.gmail.com>
Subject: Re: [PATCH] mm: Revert x86_64 and arm64 ELF_ET_DYN_BASE base
To: Kees Cook <keescook@chromium.org>
Cc: Kostya Serebryany <kcc@google.com>, Vitaly Buka <vitalybuka@google.com>, glider@google.com, 
	Evgeniy Stepanov <eugenis@google.com>, Daniel Micay <danielmicay@gmail.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, 
	Pratyush Anand <panand@redhat.com>, Dong Bo <dongbo4@huawei.com>, 
	Dmitry Safonov <dsafonov@virtuozzo.com>, Rik van Riel <riel@redhat.com>, 
	Andy Lutomirski <luto@amacapital.net>, Grzegorz Andrejczuk <grzegorz.andrejczuk@intel.com>, 
	linux-arm-kernel@lists.infradead.org, Reid Kleckner <rnk@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Peter Collingbourne <pcc@google.com>, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, address-sanitizer@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

On Sat, 17 Feb 2024 at 07:50, Kees Cook <keescook@chromium.org> wrote:
>
> *extreme thread[1] necromancy*
>
> On Mon, Aug 07, 2017 at 01:15:42PM -0700, Kees Cook wrote:
> > Moving the x86_64 and arm64 PIE base from 0x555555554000 to 0x000100000000
> > broke AddressSanitizer. This is a partial revert of:
> >
> >   commit eab09532d400 ("binfmt_elf: use ELF_ET_DYN_BASE only for PIE")
> >   commit 02445990a96e ("arm64: move ELF_ET_DYN_BASE to 4GB / 4MB")
> >
> > The AddressSanitizer tool has hard-coded expectations about where
> > executable mappings are loaded. The motivation for changing the PIE
> > base in the above commits was to avoid the Stack-Clash CVEs that
> > allowed executable mappings to get too close to heap and stack. This
> > was mainly a problem on 32-bit, but the 64-bit bases were moved too,
> > in an effort to proactively protect those systems (proofs of concept
> > do exist that show 64-bit collisions, but other recent changes to fix
> > stack accounting and setuid behaviors will minimize the impact).
>
> I happened to be looking at this again today, and wondered where things
> stood. It seems like ASan's mappings are documented here:
> https://github.com/google/sanitizers/wiki/AddressSanitizerAlgorithm#64-bit
>
> This implies that it would be safe to move the ELF_ET_DYN_BASE from
> 0x555555554000 down to 0x200000000000, since the shadow map ends at
> 0x10007fff7fff. (Well, anything above there would work, I was just
> picking a "round" number above it. We could just as well use
> 0x100080000000, I think.)
>
> Is this correct? I'd like to open up some more room between mmap and
> stack...

Note that there is also TSAN and MSAN with their own mappings.
These are also different per-arch, e.g. TSAN/Linux/x86_64:
https://github.com/llvm/llvm-project/blob/d2a26a7bd5fc7cc5752337b7f4f999642feb37dc/compiler-rt/lib/tsan/rtl/tsan_platform.h#L48-L58

Search "linux/" in that file for other arches, e.g.:
https://github.com/llvm/llvm-project/blob/d2a26a7bd5fc7cc5752337b7f4f999642feb37dc/compiler-rt/lib/tsan/rtl/tsan_platform.h#L156-L165
https://github.com/llvm/llvm-project/blob/d2a26a7bd5fc7cc5752337b7f4f999642feb37dc/compiler-rt/lib/tsan/rtl/tsan_platform.h#L187-L196
https://github.com/llvm/llvm-project/blob/d2a26a7bd5fc7cc5752337b7f4f999642feb37dc/compiler-rt/lib/tsan/rtl/tsan_platform.h#L218-L227
https://github.com/llvm/llvm-project/blob/d2a26a7bd5fc7cc5752337b7f4f999642feb37dc/compiler-rt/lib/tsan/rtl/tsan_platform.h#L252-L263

And MSAN mappings:
https://github.com/llvm/llvm-project/blob/d2a26a7bd5fc7cc5752337b7f4f999642feb37dc/compiler-rt/lib/msan/msan.h#L44-L61


> Thanks!
>
> -Kees
>
> [1] https://lore.kernel.org/lkml/20170807201542.GA21271@beast/
>
> >
> > The new 32-bit PIE base is fine for ASan (since it matches the ET_EXEC
> > base), so only the 64-bit PIE base needs to be reverted to let x86 and
> > arm64 ASan binaries run again. Future changes to the 64-bit PIE base on
> > these architectures can be made optional once a more dynamic method for
> > dealing with AddressSanitizer is found. (e.g. always loading PIE into
> > the mmap region for marked binaries.)
> >
> > Reported-by: Kostya Serebryany <kcc@google.com>
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> >  arch/arm64/include/asm/elf.h | 4 ++--
> >  arch/x86/include/asm/elf.h   | 4 ++--
> >  2 files changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/arch/arm64/include/asm/elf.h b/arch/arm64/include/asm/elf.h
> > index acae781f7359..3288c2b36731 100644
> > --- a/arch/arm64/include/asm/elf.h
> > +++ b/arch/arm64/include/asm/elf.h
> > @@ -114,10 +114,10 @@
> >
> >  /*
> >   * This is the base location for PIE (ET_DYN with INTERP) loads. On
> > - * 64-bit, this is raised to 4GB to leave the entire 32-bit address
> > + * 64-bit, this is above 4GB to leave the entire 32-bit address
> >   * space open for things that want to use the area for 32-bit pointers.
> >   */
> > -#define ELF_ET_DYN_BASE              0x100000000UL
> > +#define ELF_ET_DYN_BASE              (2 * TASK_SIZE_64 / 3)
> >
> >  #ifndef __ASSEMBLY__
> >
> > diff --git a/arch/x86/include/asm/elf.h b/arch/x86/include/asm/elf.h
> > index 1c18d83d3f09..9aeb91935ce0 100644
> > --- a/arch/x86/include/asm/elf.h
> > +++ b/arch/x86/include/asm/elf.h
> > @@ -247,11 +247,11 @@ extern int force_personality32;
> >
> >  /*
> >   * This is the base location for PIE (ET_DYN with INTERP) loads. On
> > - * 64-bit, this is raised to 4GB to leave the entire 32-bit address
> > + * 64-bit, this is above 4GB to leave the entire 32-bit address
> >   * space open for things that want to use the area for 32-bit pointers.
> >   */
> >  #define ELF_ET_DYN_BASE              (mmap_is_ia32() ? 0x000400000UL : \
> > -                                               0x100000000UL)
> > +                                               (TASK_SIZE / 3 * 2))
> >
> >  /* This yields a mask that user programs can use to figure out what
> >     instruction set this CPU supports.  This could be done in user space,
> > --
> > 2.7.4
> >
> >
> > --
> > Kees Cook
> > Pixel Security
>
> --
> Kees Cook

