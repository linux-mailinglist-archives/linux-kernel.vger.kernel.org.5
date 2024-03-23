Return-Path: <linux-kernel+bounces-112403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D473E887959
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 17:17:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81AD41F217EC
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 16:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90E5847796;
	Sat, 23 Mar 2024 16:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ZHewTpwc"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB6B8BE5
	for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 16:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711210627; cv=none; b=Hv9G5AIhZmxnInfH/pUSN5ECHh0d7RQS2vSJN3NUef9ai/300zAUXQkSxZy3O/WvKSp20tJ6MV7KYUoR0Se/K8USmZUai6XZc5QLliNHGyYWV4k5G/rgguLNRI61OdLu7zAajnYyGEvOgR2WViI8HLi/PuAwwmbEZBiew7vqj68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711210627; c=relaxed/simple;
	bh=HrDbHTBQP7Kca/aKRq5bNPlXeDF/Ou08LysYfQoaFWM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CqgvHduyq0SuyQO0RVRR3KjS5rcbDoJIoDwH1gtlQ08Bf09+sTcXvhOpXjCw1duP2b+Ou0PhaL1nLY5bIk23+CZH2AOmcUjG0bJ+MoPNH69b1EjsAzBcKbzXGbb+I92+PI5EmSDay6xD8DEGzNztK++PNM63LWFK8FH23bibziM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ZHewTpwc; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2d21cdbc85bso43109191fa.2
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 09:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1711210623; x=1711815423; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6zMFoIj7zZfTP4Vt0+D+vtNOkwelxdRNNrRRIlodJBg=;
        b=ZHewTpwcbWFfJuhKMDU99bxJIp9irzXmpSwOKiNu7WSvmlpXyCUV3ItbpzE2woj3A8
         rNTJ1QNDggJz+4HDbBBL3cq3yJfkx56AhKqFwtWs8Qk52Rh5iKHXidJoc5KJaHbFbk1R
         eP3ukQvVj4SdJj1BRA/bCY3f8YPn7/bEh7vRg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711210623; x=1711815423;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6zMFoIj7zZfTP4Vt0+D+vtNOkwelxdRNNrRRIlodJBg=;
        b=K18fmV+y8NTX9PnrwSUmb9WoIixieHR7VUymDPIGXvXgt+P984DWwo5iXKgcKG9v7/
         pAjaQ0rzMY8oRrOlZU19JyiLNfjfTRpPyvRGq49wXbS4jrBYrvOvpB6bFU+DwZZg3nxN
         zOjk8gTn4ntXLFeYdw2+nkCOUqSzVF3u40cMZgmzmAGt41VtYW/B4BxoUfjVuOKzzuoZ
         503jP2ip5vwj9fUzs7SUg3EcuDKAH7AbrEXCLeRPVNKjFpziUJckXxI6g+43kHQIm0IW
         aoUp6QAFo4gBIwtopCx1dspz+nF6ZL4vECyTqz4W8sxHoRlx6MqV2xWzOzuXoinARQ/Q
         BgSQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFGmCCrjsiTpRkiIduY1aqm5zfw//Ck9YTprF7cp2ZQ+j5x5k+zyiBG2ofQByk6328Nbu7oax+IQWTzt2cV1GCbV27B8XSam+83Miv
X-Gm-Message-State: AOJu0YxAZPbn7fwEj4S6bnUH6m1W2tivJaq2Ru6+iBOZbxwZ70r4I5a9
	3KXKV93SuVuTIW0xBnJE3zVzI89m7MD+CYgUVo1zSnUi2uahs6mSSuiHjpQ07v3K0cxt+6ZNlut
	vU5YoVQ==
X-Google-Smtp-Source: AGHT+IF8MFw9/YiOGtpBctAqFKLN5ngGWQvMEOBBhDzOxbDqil3B2rmxlDylWH8LBV1hyHKTE6BaTg==
X-Received: by 2002:ac2:5b05:0:b0:515:9652:7f76 with SMTP id v5-20020ac25b05000000b0051596527f76mr1539481lfn.1.1711210622736;
        Sat, 23 Mar 2024 09:17:02 -0700 (PDT)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com. [209.85.218.53])
        by smtp.gmail.com with ESMTPSA id eo3-20020a056402530300b0056bf66a0c36sm897304edb.58.2024.03.23.09.17.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Mar 2024 09:17:02 -0700 (PDT)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a472f8c6a55so202120566b.0
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 09:17:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXCWgtD9jYv0LllenCS3R55OOwDMkk3J9iygPhDIRnHwgQzI6Spt7+654enNNCIEipSyuCa3t2D0+y7/vSPvgilRnLzvhTsM5rLwNdf
X-Received: by 2002:a17:906:bb10:b0:a47:876:28b9 with SMTP id
 jz16-20020a170906bb1000b00a47087628b9mr1783352ejb.42.1711210621595; Sat, 23
 Mar 2024 09:17:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240322165233.71698-1-brgerst@gmail.com> <CAFULd4bCufzKjaUyOcJ5MfsPBcVTj1zQiP3+FFCGo6SbxTpK2A@mail.gmail.com>
 <CAMzpN2gOZEddWUgncaLutVDihcEK-oEUdSVxsgaaX9xiMWfqPw@mail.gmail.com>
In-Reply-To: <CAMzpN2gOZEddWUgncaLutVDihcEK-oEUdSVxsgaaX9xiMWfqPw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 23 Mar 2024 09:16:45 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi0arqxMFFdM+jGv1YXXhY+ehxsmcfv+iAndD_dmpYjMA@mail.gmail.com>
Message-ID: <CAHk-=wi0arqxMFFdM+jGv1YXXhY+ehxsmcfv+iAndD_dmpYjMA@mail.gmail.com>
Subject: Re: [PATCH v4 00/16] x86-64: Stack protector and percpu improvements
To: Brian Gerst <brgerst@gmail.com>, Arnd Bergmann <arnd@arndb.de>
Cc: Uros Bizjak <ubizjak@gmail.com>, linux-kernel@vger.kernel.org, x86@kernel.org, 
	Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, 
	"H . Peter Anvin" <hpa@zytor.com>, David.Laight@aculab.com
Content-Type: text/plain; charset="UTF-8"

On Sat, 23 Mar 2024 at 06:23, Brian Gerst <brgerst@gmail.com> wrote:
>
> One small issue is that Kconfig would silently disable istackprotector
> if the compiler doesn't support the new options.  That said, the
> number of people that this would affect is very small, as just about
> any modern distribution ships a compiler newer than 8.1.

Yes, let's make the rule be that you can still compile the kernel with
gcc-5.1+, but you can't get stackprotector support unless you have
gcc-8.1+.

I'd hate to add the objtool support for an old compiler - this is a
hardening feature, not a core feature, and anybody who insists on old
compilers just won't get it.

And we have other cases like this where various debug features depend
on the gcc version, eg

  config CC_HAS_WORKING_NOSANITIZE_ADDRESS
          def_bool !CC_IS_GCC || GCC_VERSION >= 80300

so we could easily do the same for stack protector support.

And we might as well also do the semi-yearly compiler version review.
We raised the minimum to 4.9 almost four years ago, and then the jump
to 5.1 was first for arm64 due to a serious gcc code generation bug
and then globally in Sept 2021.

So it's probably time to think about that anyway,

That said, we don't actually have all that many gcc version checks
around any more, so I think the jump to 5.1 got rid of the worst of
the horrors. Most of the GCC_VERSION checks are either in gcc-plugins
(which we should just remove, imnsho - not the version checks, the
plugins entirely), or for various random minor details (warnign
enablement and the asm goto workaround).

So there doesn't seem to be a major reason to up the versioning, since
the stack protector thing can just be disabled for older versions.

But maybe even enterprise distros have upgraded anyway, and we should
be proactive.

Cc'ing Arnd, who has historically been one of the people pushing this.
He may no longer care because we haven't had huge issues.

               Linus

