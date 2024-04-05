Return-Path: <linux-kernel+bounces-133172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0D8B899FF0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 16:38:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2ACCE1F226CD
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 14:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 347EE16F28E;
	Fri,  5 Apr 2024 14:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eqBptXTX"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E5716D318
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 14:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712327910; cv=none; b=ss3S1tittdC4t9Zswon14Az8eiGHysYxuo66vf/GBI0nc6/r7z8b8qhUXPh86csKbzzY+mXuQ9vhUy2Y+BuWF/6o9kRpMv9jC7ygcFbmfgmIV72FgDqGceljxdGphU/MNmtmjRG1dKntXNa7pUca2tgrhdoHX3XTeYJiHOoKNyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712327910; c=relaxed/simple;
	bh=krI3p7b8O/0LkrqfedOET3v9JRzVve86MfeUXCHoD/U=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=kfPp6eyt0duByNLuFWHmFphVFpk5RYVAtvNqI/6Eud79Wx7IH015LJ5UwcOZ7LaqcC1IsMTbfREV5mvNtdLF3wYZzJVejbVoXKGF0xetKwglE8c4JzPiBnRMFAUiZcMum5lndg/8uoD1QIO8+a6IOHgw9qTuWEp5bQ1tMDQwgDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eqBptXTX; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-56e1a1c0ec9so2267580a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 07:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712327907; x=1712932707; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jq64EytimHF5MsTrKaB8604ERPcd6n9oHVseoGQ2LmI=;
        b=eqBptXTXx9q6YZXF2+zesnkWUwtWa8tgLJrtK6q4sltgZ+efiWl3+9UOU/2875JyQb
         yo3m+6MBJ9ZqHXJYUutw59fzYiOmYR8FmN2gkNRejb/+9P/Wk/YW2C/dAAg6yAz7jDg9
         IqCCs9DJ5BA0jBalbbiLqzKc/P0Po6lnIwTE/AvanMqnjjugybyyy8MFcEi3todkyYaB
         zR0m4nxNt25FSgG3aNhXCHXCo9aHc11YtHpliBKfzG35Ajt/tdbNp8nKYjsOxDGAHwZM
         X4Fi3WpyIxT5IRQPceSuRYnRjeVgVftl30dG1BY2IcfW2nij0NiFG9Q6uCCGQleS1fSO
         +/mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712327907; x=1712932707;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jq64EytimHF5MsTrKaB8604ERPcd6n9oHVseoGQ2LmI=;
        b=W8XQwmwBnxZIt28zqhT06SU3uUyUs12F+wruOZIXfE1fM9QconDybaM5R5xqmJv/Xp
         cZ0EzNrk/iJZhd/b2WbiRSJF0ZCzZuWz7VoiCKlG0fCkbMSpigqfwEwoRNmuCSAN7yUE
         TnVJ8miVa3/W+/juIRlUiSVytj6KnZTFMcr8vj4/pCLha/DnC1plNB/JWunCjtL+U/sU
         Zxwlk0UTbG78UFbWo5thNCbQTSA99YbBJ9oq8vEJMBbgBEH6dnl7r3yno4tILaTeex+j
         QX/WBL+OKLUfnMVPDeYmcLDJeW9bsVt25lB95Xbf5edvFE5Y/dyUYxzRuFFn5wLlbbtT
         RrLw==
X-Forwarded-Encrypted: i=1; AJvYcCVt1LzO8vr5CGUb+8kOtIp4QVnIdulpTpDLdB3N/AqpVhVqz1C8PwSUNmZy3gML7anPR3QeOYPfpGW756JX/aZA6JVcms4RP62HGX3S
X-Gm-Message-State: AOJu0YxnhwwPOztDWklAEKeDdcoV+nbCuQy0oHAIgzXKxCOm0ZN2yyO/
	6K0JjDDCuRaIouOelaDqPWt/EjOC4hy92I71eq6UiZkD3AA6OqzP
X-Google-Smtp-Source: AGHT+IFDhv+vjtsOlRxdmgq8zBMFrUc9BOJ3Rr/vsuyRzT3WC7eg4jtJDuBAVV1F60SijHgdh3D78g==
X-Received: by 2002:a50:c348:0:b0:56d:c6e9:ca01 with SMTP id q8-20020a50c348000000b0056dc6e9ca01mr1261481edb.15.1712327906740;
        Fri, 05 Apr 2024 07:38:26 -0700 (PDT)
Received: from smtpclient.apple ([132.68.46.1])
        by smtp.gmail.com with ESMTPSA id j13-20020a50ed0d000000b0056c4372c161sm855756eds.55.2024.04.05.07.38.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Apr 2024 07:38:26 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.500.171.1.1\))
Subject: Re: [PATCH] x86/percpu: Use __force to cast from __percpu address
 space
From: Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <20240402175058.52649-1-ubizjak@gmail.com>
Date: Fri, 5 Apr 2024 17:38:13 +0300
Cc: the arch/x86 maintainers <x86@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Charlemagne Lasse <charlemagnelasse@gmail.com>,
 Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
 Ingo Molnar <mingo@kernel.org>,
 Andy Lutomirski <luto@kernel.org>,
 Brian Gerst <brgerst@gmail.com>,
 Denys Vlasenko <dvlasenk@redhat.com>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Josh Poimboeuf <jpoimboe@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <0F9CDB7B-E8DD-43E5-9394-233A9289B3E0@gmail.com>
References: <20240402175058.52649-1-ubizjak@gmail.com>
To: Uros Bizjak <ubizjak@gmail.com>
X-Mailer: Apple Mail (2.3774.500.171.1.1)



> On 2 Apr 2024, at 20:50, Uros Bizjak <ubizjak@gmail.com> wrote:
>=20
> Fix sparse warning when casting from __percpu address space by using
> __force in the cast. x86 named address spaces are not considered to
> be subspaces of the generic (flat) address space, so explicit casts
> are required to convert pointers between these address spaces and the
> generic address space (the application should cast to uintptr_t and
> apply the segment base offset). The cast to uintptr_t removes
> __percpu address space tag and sparse reports:
>=20
>  warning: cast removes address space '__percpu' of expression
>=20
> Use __force to inform sparse that the cast is intentional.
>=20
> Reported-by: Charlemagne Lasse <charlemagnelasse@gmail.com>
> Closes: =
https://lore.kernel.org/lkml/CAFGhKbzev7W4aHwhFPWwMZQEHenVgZUj7=3DaunFieVq=
Zg3mt14A@mail.gmail.com/
> Fixes: 9a462b9eafa6 ("x86/percpu: Use compiler segment prefix =
qualifier")
> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> Cc: Nadav Amit <nadav.amit@gmail.com>
> Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Brian Gerst <brgerst@gmail.com>
> Cc: Denys Vlasenko <dvlasenk@redhat.com>
> Cc: H. Peter Anvin <hpa@zytor.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Josh Poimboeuf <jpoimboe@redhat.com>
> ---
> arch/x86/include/asm/percpu.h | 6 +++---
> 1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/arch/x86/include/asm/percpu.h =
b/arch/x86/include/asm/percpu.h
> index 1f6404e0c428..20696df5d567 100644
> --- a/arch/x86/include/asm/percpu.h
> +++ b/arch/x86/include/asm/percpu.h
> @@ -77,7 +77,7 @@
> #define arch_raw_cpu_ptr(_ptr) \
> ({ \
> unsigned long tcp_ptr__ =3D __raw_my_cpu_offset; \
> - tcp_ptr__ +=3D (unsigned long)(_ptr); \
> + tcp_ptr__ +=3D (__force unsigned long)(_ptr); \
> (typeof(*(_ptr)) __kernel __force *)tcp_ptr__; \
> })
> #else
> @@ -96,8 +96,8 @@
> #endif /* CONFIG_SMP */
>=20
> #define __my_cpu_type(var) typeof(var) __percpu_seg_override
> -#define __my_cpu_ptr(ptr) (__my_cpu_type(*ptr) *)(uintptr_t)(ptr)
> -#define __my_cpu_var(var) (*__my_cpu_ptr(&var))
> +#define __my_cpu_ptr(ptr) (__my_cpu_type(*ptr)*)(__force =
uintptr_t)(ptr)
> +#define __my_cpu_var(var) (*__my_cpu_ptr(&(var)))

If you use "(var)=E2=80=9D in __my_cpu_var(),, you might just as well =
change the first to:

  #define __my_cpu_ptr(ptr) (__my_cpu_type(*(ptr))*)(__force =
uintptr_t)(ptr)

[ not that I think of any real issue it might cause - just for =
consistency]

Anyhow,

Asked-by: Nadav Amit <nadav.amit@gmail.com>=

