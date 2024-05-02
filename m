Return-Path: <linux-kernel+bounces-166991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FABB8BA30A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 00:17:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A13881F2308D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 22:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DE8957CAD;
	Thu,  2 May 2024 22:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ZR2wT/bz"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0574D57CA1
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 22:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714688234; cv=none; b=X2SGHRj4MBIfe1KQNnYg66iUbnZEcdLYay0JI/cWmke8+9+WLt06DiO0BlAKDLzwdu0sptN+vEGJA2h7Z3Kke6e9gvJHKu9XdfCpsS6f6mO5xai+fz2WXubbE5fJzzfCL0WwmlbGeJ7yCr8CYcZjVhF+RQ50NGDm8CpxOfXqeVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714688234; c=relaxed/simple;
	bh=qnKN9L3Z0Au55/oPWH4SsCKSSflxsoIcUt2AGUKIs6U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dLMXOi9RycU8yEDgs83rqtCDO0bTBLdA80yUx3AqlyTQV6RvkE3HIOpENwDZ91aVczC2wNzEzYqCpqNKaniwFqNgriXiU29vZBAhqfeKPZ2Ro0M7m5IQ7L1yuCYlUEBMrO2Ao1CRr5d7jp/I6NuVF5l4YiwZEMJfZ5heKfGaDuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ZR2wT/bz; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a58fbbcd77aso722526666b.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 15:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1714688231; x=1715293031; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=r8L1plbBpC5b8hbxFDn23VRySV0QK2bnDqJWgg6u+KQ=;
        b=ZR2wT/bzj07LxaYITmm2KnlvSt7u1Fp+Dzcmyh8ccPtpzgMlv6jfFIIEjRBJ2vRJAp
         EecvibUBneNphEafdlBfcX4pjHvgMopYC+lXloTw7aLmBNuvYY+xfjzI4MNvgih769cY
         Sb0ELnQ2NO283IoJOD8SqU6jfwsRTRujO0ipw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714688231; x=1715293031;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r8L1plbBpC5b8hbxFDn23VRySV0QK2bnDqJWgg6u+KQ=;
        b=b2GXtG3KmdqgwjXQNUOxFzdZ8QTxBZIJbB7g0D9E9yz+3UCgGkbsgNH2CcFkGnfEas
         frX/sU+ItI5fzB/hLaar8iSTgrGdJ9+6ofRUVsEXHTJj2uQFk25kIzKcRb2/paQRowLO
         uS/hjk4sUm6/kANH1wdsxEeUirkuOwL5wZMM1wbusnYk/qsmy2mevyGpdCeE3rWu3dkr
         byCh58gXUsGN1nwdkfcGYByQPZqeS9i84BTX6M72o2xm1TVcxmNlLvGvfjQdyyYuQ5Ft
         7TLPTMtK1SSnEGAZTOWpRlEUe3LoGNX9sCvo+Dvfq1W0I/30jcq+NnQZDmq7O8p+jy1t
         YkFw==
X-Forwarded-Encrypted: i=1; AJvYcCVPpEFbmaKxJ566dS85VJh55DefoQynSuToKtHi7GLk86uM5tW0CFkbFFT9TzN8DvJF4GDYxHZScMPCQ1IU08H+3Wg5CoasWrILY4Eg
X-Gm-Message-State: AOJu0YyB/uBYzRXpWf4ZbQOaH/u22fuQyhpIkBfatPgkPxzj0+OdOXR4
	rFpEBix6WXE4q/Lwdi8dcCL0p8wHHjknrStBT8KWYcPmBo4ySrnIt462On8S2dBBw6DY8aHvZw9
	262ZoCg==
X-Google-Smtp-Source: AGHT+IFhiYrolgfrl++kOroPy3k/4GRu/0s9idDR9MzAH26SEbLXbCWr8N1NxuaC3Jx772r80tNkRA==
X-Received: by 2002:a17:906:fcc3:b0:a59:7766:e4ed with SMTP id qx3-20020a170906fcc300b00a597766e4edmr447525ejb.32.1714688231284;
        Thu, 02 May 2024 15:17:11 -0700 (PDT)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com. [209.85.218.52])
        by smtp.gmail.com with ESMTPSA id mj19-20020a170906af9300b00a593f8483a9sm986306ejb.22.2024.05.02.15.17.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 May 2024 15:17:11 -0700 (PDT)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a55911bff66so1114266166b.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 15:17:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUW81i1y9J1skHa+RjDm8REBzOJrQJsmF3o11JeU8Xh/vENHLD8aCWy6fdLVWTfcvm1x4JJ4RJ7Y/xlgZ2sTyqajniL7nGcQEQZNOf8
X-Received: by 2002:a17:906:2b94:b0:a59:4101:433e with SMTP id
 m20-20020a1709062b9400b00a594101433emr448463ejg.35.1714688229488; Thu, 02 May
 2024 15:17:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <b67e79d4-06cb-4a45-a906-b9e0fbae22c5@paulmck-laptop>
 <20240501230130.1111603-12-paulmck@kernel.org> <1376850f47279e3a3f4f40e3de2784ae3ac30414.camel@physik.fu-berlin.de>
 <b7ae0feb-d401-43ee-8d5f-ce62ca224638@paulmck-laptop> <6f7743601fe7bd50c2855a8fd1ed8f766ef03cac.camel@physik.fu-berlin.de>
 <9a4e1928-961d-43af-9951-71786b97062a@paulmck-laptop> <20240502205345.GK2118490@ZenIV>
 <20240502210122.GA2322432@ZenIV>
In-Reply-To: <20240502210122.GA2322432@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 2 May 2024 15:16:52 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj-Jt7MgFC4-yr6DdvCVDoy1nu0W9W2zmaGZm6u=b2qTg@mail.gmail.com>
Message-ID: <CAHk-=wj-Jt7MgFC4-yr6DdvCVDoy1nu0W9W2zmaGZm6u=b2qTg@mail.gmail.com>
Subject: Re: alpha cmpxchg.h (was Re: [PATCH v2 cmpxchg 12/13] sh: Emulate
 one-byte cmpxchg)
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, linux-arch@vger.kernel.org, 
	linux-kernel@vger.kernel.org, elver@google.com, akpm@linux-foundation.org, 
	tglx@linutronix.de, peterz@infradead.org, dianders@chromium.org, 
	pmladek@suse.com, arnd@arndb.de, kernel-team@meta.com, 
	Andi Shyti <andi.shyti@linux.intel.com>, Palmer Dabbelt <palmer@rivosinc.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, linux-sh@vger.kernel.org, linux-alpha@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 2 May 2024 at 14:01, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> +static inline unsigned long
> +____xchg_u8(volatile char *m, unsigned long val)
> +{
> +       unsigned long ret, tmp, addr64;
> +
> +       __asm__ __volatile__(
> +       "       andnot  %4,7,%3\n"
> +       "       insbl   %1,%4,%1\n"
> +       "1:     ldq_l   %2,0(%3)\n"
> +       "       extbl   %2,%4,%0\n"
> +       "       mskbl   %2,%4,%2\n"
> +       "       or      %1,%2,%2\n"
> +       "       stq_c   %2,0(%3)\n"
> +       "       beq     %2,2f\n"
> +       ".subsection 2\n"
> +       "2:     br      1b\n"
> +       ".previous"
> +       : "=&r" (ret), "=&r" (val), "=&r" (tmp), "=&r" (addr64)
> +       : "r" ((long)m), "1" (val) : "memory");
> +
> +       return ret;
> +}

Side note: if you move this around, I think you should just uninline
it too and turn it into a function call.

This inline asm doesn't actually take any advantage of the inlining.
The main reason to inline something like this is that you could then
deal with different compile-time alignments better than using the
generic software sequence. But that's not what the inline asm actually
does, and it uses the worst-case code sequence for inserting the byte.

Put that together with "byte and word xchg are rare", and it really
smells to me like we shouldn't be inlining this.

Now, the 32-bit and 64-bit cases are different - more common, but also
much simpler code sequences. They seem worth inlining.

That said, maybe for alpha, the "just move code around" is better than
"fix up old bad decisions" just because the effort is lower.

              Linus

