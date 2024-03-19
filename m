Return-Path: <linux-kernel+bounces-107570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F2AB87FE41
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 14:12:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6245E1C20D68
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 13:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B89D08062A;
	Tue, 19 Mar 2024 13:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BvImBKnT"
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC9958230
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 13:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710853808; cv=none; b=B0dt4VMf0QL9i/6VvJuIIq6FjM+6UPf+7/2IfM1D6AoAZkvUBd1PkQqQR+dG3J3E7+fn5aJQz5KZ9GNpLL+jlFkIZtv80q53BDaEffTyRApIXTOOb8j9ZXT7DYw0WCN8RmRcpzedgTbwN4g79XhACFxPoOW68Jqe+7bDEfbz3W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710853808; c=relaxed/simple;
	bh=0dvYBcaS+GLzeeTigmUeacFy9DSO3NmaRo/kJjo+lH4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k9faYMb4NP7JtqW8l4H63iDYObz1R0v14VAhMhppCQ/ZRxZ3qs7ncMd1cO32RbPJvwHtgRELi1qohQmG8xgUKVmIosW7wFSyxq3fWHgQ+Z8JfZGp2v0joWRg5Go9Y9H/yWAgChP0zXZCVUnEinwq70uF2yGbwVV3kwsPYpA83Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BvImBKnT; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-6e67d42422aso2496940a34.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 06:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710853805; x=1711458605; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Iy9c4kHlPN+YL7k6cDR7TckwLJz+xP7Q/3HFbDS5m8c=;
        b=BvImBKnTrAIdxq5vfS+0BnP6sMfhtXEYeTU3duURtXpNNhYud18Nkebeq/fwzcYjKw
         xDJavSuRjHWt7x6aAAmNu4qeiOoXonlzVhhlcuYJb3BfofhNdQt+sSIwHbLHS871IAla
         W1Ds0CFiFZX2CnJcd9jY6g3BdVf8/ZZrsaHtpqop4YMH0TR/b0Z5oHsmWbiHxR4hMHei
         wFyQwfxR1ryCyZkcNWIcQuq5O/UWT2Zhe0apjsxQNigH//gdtMdYcKfqN/biZI5A3C0I
         ItPrr22NJWh0k8ZToIa4DoLw+y97JCVTmiDa8iVjDuDGgr0yDSe2JFYs8FJKrbc3tcAD
         gPaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710853805; x=1711458605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Iy9c4kHlPN+YL7k6cDR7TckwLJz+xP7Q/3HFbDS5m8c=;
        b=naKHVhdyGoYHXvOrQlWsY4S2wfU26Za+ur86qwP79mjIoDYGtulxEs8BQTqpiauCGq
         Jmjej+8x6GIOS3QZ8lQlt230Jp9lkEH1jX+d1d0eAjHg7sXIwD6dg1Ap1FgCy35WHanj
         u4CwiAZmkGWWJjoFC4D5J9shc+hCXaIsuK1upkOtdiGzHQGmGGpLV8tQ6l0EZ6ffo8Ro
         RQmM+VFol0NkkG5ZdhUq2s9EZlI/eEz+PUAIQnRqKYosHNoH8PZ5q5Lqri3yFwT8hg3B
         66xOuNAJ5YhR2YGQOVSkHX6PuaKh++OMjAJqL/B+ZZW0z6lDnp0c+6J3rTKA8u7++VF0
         uLRQ==
X-Forwarded-Encrypted: i=1; AJvYcCXj3hsHFNVakrF0aGr1Z93WMfOG85A4b1aCm9tF2yyxTFpPwmCekppcu2lXR+VoJA/P8BKQxQ63U/f4KVm14a4jjp6GJ9LhNE/K3ceG
X-Gm-Message-State: AOJu0Yz8IGPvgmUUKo++BgA8Lv3GvIHIvhoqimp+0wCvS34idAAU8JOw
	FPxEoC7YZCZcC5kTh4J9wJoYmpfFZZla+R2syqK2j1OceW++vVsr2wBu7eD6q6NZEF7rm8F45UQ
	JdpPQxCXoc39Egwd3MItKJbOrjg==
X-Google-Smtp-Source: AGHT+IFFF7AeYVVcotB7GHVWIQf7SiS7SJH3uokS18F2NoVc3LEHuCO6ALkC70OMLpQYJnp0bJXOpfv5pNlkpfvuMbo=
X-Received: by 2002:a05:6808:3843:b0:3c3:889b:9877 with SMTP id
 ej3-20020a056808384300b003c3889b9877mr8560204oib.37.1710853805539; Tue, 19
 Mar 2024 06:10:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240319104418.284519-1-ubizjak@gmail.com>
In-Reply-To: <20240319104418.284519-1-ubizjak@gmail.com>
From: Brian Gerst <brgerst@gmail.com>
Date: Tue, 19 Mar 2024 09:09:51 -0400
Message-ID: <CAMzpN2iTU05j5R1L9=LhjDoQ9krOymzOWH9QHi50vq-fAaOM5w@mail.gmail.com>
Subject: Re: [PATCH -tip 0/3] x86/asm: Use generic asm operand modifiers
 instead of %P in asm templates
To: Uros Bizjak <ubizjak@gmail.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, 
	Andy Lutomirski <luto@kernel.org>, Denys Vlasenko <dvlasenk@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, 
	Josh Poimboeuf <jpoimboe@redhat.com>, Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 19, 2024 at 6:44=E2=80=AFAM Uros Bizjak <ubizjak@gmail.com> wro=
te:
>
> The "P" asm operand modifier is a x86 target-specific modifier.
>
> For x86_64, when used with a symbol reference, the "P" modifier
> emits "sym" instead of "sym(%rip)". When used with a constant, the
> "P" modifier emits "cst" instead of "$cst". This property is used to
> emit bare symbol references and bare constants without all
> syntax-specific prefixes.
>
> The generic "c", "n" and "a" operand modifiers should be used instead.
> The following table shows the modifiers supported by all targets and
> their effects:
>
> Modifier    Description
> -----------------------------------------------------------
> 'c'         Require a constant operand and print the
>             constant expression with no punctuation.
> 'n'         Like '%c' except that the value of the constant
>             is negated before printing.
> 'a'         Substitute a memory reference, with the actual
>             operand treated as the address.  This may be
>             useful when outputting a "load address"
>             instruction, because often the assembler syntax
>             for such an instruction requires you to write
>             the operand as if it were a memory reference.
>
> Also note that unlike GCC, clang emits %rip-relative symbol
> reference with "P" asm operand modifier, so the patch also unifies
> symbol handling with both compilers.
>
> No functional changes intended.
>
> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Brian Gerst <brgerst@gmail.com>
> Cc: Denys Vlasenko <dvlasenk@redhat.com>
> Cc: H. Peter Anvin <hpa@zytor.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Josh Poimboeuf <jpoimboe@redhat.com>
> Cc: Sean Christopherson <seanjc@google.com>
>
> Uros Bizjak (3):
>   x86/asm: Remove %P operand modifier from altinstr asm templates
>   x86/asm: Use %c/%n instead of %P operand modifier in asm templates
>   x86/asm: Use %a instead of %P operand modifier in asm templates
>
>  arch/x86/boot/main.c                 |  4 ++--
>  arch/x86/include/asm/alternative.h   | 22 +++++++++++-----------
>  arch/x86/include/asm/apic.h          |  2 +-
>  arch/x86/include/asm/atomic64_32.h   |  2 +-
>  arch/x86/include/asm/cpufeature.h    |  4 ++--
>  arch/x86/include/asm/irq_stack.h     |  2 +-
>  arch/x86/include/asm/processor.h     |  6 +++---
>  arch/x86/include/asm/special_insns.h |  4 ++--
>  arch/x86/include/asm/uaccess.h       |  4 ++--
>  9 files changed, 25 insertions(+), 25 deletions(-)
>
> --
> 2.44.0
>

My one concern is does this work with older compilers?  Technically,
GCC 5.1 is still supported.  I seem to recall some issues around these
modifiers in the past, but don't remember any details.  Otherwise,
it's a nice cleanup.


Brian Gerst

