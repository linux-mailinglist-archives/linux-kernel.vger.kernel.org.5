Return-Path: <linux-kernel+bounces-133659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B59189A6C2
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 23:59:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CE791C213B9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 21:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99A3A179651;
	Fri,  5 Apr 2024 21:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uqMYqJ64"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38145176FD7
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 21:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712354116; cv=none; b=i3WiJn2nH0Y3ILrjVmqFYqh1hSUwK3r9RS7T5J21HyryH0kErsWwVhoDq2WVT7JGtgix6DNMq7I2fufE6RGAVNMqqKGP1H9Ug+C8Z3j3ig+3SGral0v3QkxH/ZRyglwSi+uMoFtYevKv1sxe4WnCfH7JKFesfrRi67I9/DRfLNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712354116; c=relaxed/simple;
	bh=fx5yqGZ4qGVFjioJ4n68AJdEgTCdOHtWI5LNomOb0zc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uZ2Kwci5rW3MueGasidYMxRu/DeLa61qHXoTdgHQTrg7W+t7eEDRThDA3ujAgjS67jVycZ0816wK7WbdwojAwlQKvIjHg2FgNqkydIMw2gP0v5auWyh4Fz6SahNZkaxXM6BVA2M7INSk01h2HL2whJ0dBF87sbG6NYCnF4c7SP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uqMYqJ64; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-56e2e09fc27so2206161a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 14:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712354113; x=1712958913; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xbd0ewn5oeu56kYYL5RJDjYhgsk2f08lNhWKZaOdWFo=;
        b=uqMYqJ645PRkQGcaItGtnvBkpJb5WQSt2X53g6rRi2WXSub/1pQVNXbAvZo5Ha6bDw
         yKlUWOg6PdyUhuhYwXSA25g+CMDREmo03YoSpfYf4I5foSFBYd3Sasf6I3J6uxlqittU
         zTHDWwjPUm9kvD40tKrbnDcwHpFz2FWw1zfaebL3UAaoNO0I+8jVWykKc/4oudqsHSLE
         N2HLj7kTuSVCM/anXntVv+69tpd3xeil34ZLpFXIZ9XQq3E4HGdqAHIhzTxw4cUYH89r
         Tj9D/US3tpmXRFu8JkiSA0KyftTlOy9iXQI6SxlwBSqYcVfoVJoHozTJxSPS0s88/f8P
         lHgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712354113; x=1712958913;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xbd0ewn5oeu56kYYL5RJDjYhgsk2f08lNhWKZaOdWFo=;
        b=L5ABvive05qT9mlpH1dsMoBHBCWlEw9G5c8t8RJyNT8PI1rpCkat76B7edCsFH9bgR
         pnXCmpqEUQV5OcHuPzpM7KJMl1c7R5OI208D9CdrKJTUPXlnADsmZaP8XinSyZ5rqbQ1
         cHwiFOr/zGs7Yt778zkQcpCZ3c4N6wOgZIJSw0OTzhzLRbhY83s58/pCQ1n1yea0IkNS
         hk2EnuQ2iaqKjRLPh3TrIFOYnx9RafTMvozvFhWCebmzZSrE3ZrTQ6gI95QQFqY9RfQo
         fuud67P9f5Su75r/z+W6SkKbQSdFDj3WNaI7Y1AAnQkxcGuvq5ilX+jfBw+naej5W5nJ
         a6oA==
X-Forwarded-Encrypted: i=1; AJvYcCUjVYbw/XJ2xGQ6D2mntisDfsWCB45bPzJc1t2Q2oFNz33dG22OmVTM8j++B6CCp+y3cGM1cKCUAdEMyzhvw0vdfVOc91AH3wrTCDpQ
X-Gm-Message-State: AOJu0YxDa5XKBHtAt+50+6ceZH8sl14jYQs5orWJTGqhPj9Cy2cKwcve
	Y4JRb+D/7wbR60R5qy5CiWrug+ymUvqznM5E+6Kzrdug5qnL4t4tMoYyVtJ4JEG9AUw3InFPF20
	yluinxc1g+Mtyd9G8Pu3dESTmRLwaqyPF2sSWTjjQ2y4qkZ6g1M3A
X-Google-Smtp-Source: AGHT+IFYRh93zA+h1crW6xNFKbgQILfzaZh8L+UUEjWi9SkFoEZL+x5P4BdTesw1CHTV+s6cc1Dnrvhi31WUF033+zA=
X-Received: by 2002:a50:8e5d:0:b0:56e:2c34:cff2 with SMTP id
 29-20020a508e5d000000b0056e2c34cff2mr2337858edx.19.1712354113455; Fri, 05 Apr
 2024 14:55:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240405204919.1003409-1-arnd@kernel.org>
In-Reply-To: <20240405204919.1003409-1-arnd@kernel.org>
From: Justin Stitt <justinstitt@google.com>
Date: Fri, 5 Apr 2024 14:55:01 -0700
Message-ID: <CAFhGd8rj+czcvzKsFjcBs1L_jJiar1H9n7mHmnfWKNH0MpFueA@mail.gmail.com>
Subject: Re: [PATCH] x86: microcode: avoid -Wformat warning with clang-15
To: Arnd Bergmann <arnd@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>, Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Ashok Raj <ashok.raj@intel.com>, Nathan Fontenot <nathan.fontenot@amd.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 5, 2024 at 1:49=E2=80=AFPM Arnd Bergmann <arnd@kernel.org> wrot=
e:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> Older versions of clang show a warning for amd.c after a fix for a gcc
> warning:
>
> arch/x86/kernel/cpu/microcode/amd.c:478:47: error: format specifies type =
'unsigned char' but the argument has type 'u16' (aka 'unsigned short') [-We=
rror,-Wformat]
>                          "amd-ucode/microcode_amd_fam%02hhxh.bin", family=
);
>                                                      ~~~~~~        ^~~~~~
>                                                      %02hx
>
> In clang-16 and higher, this warning is disabled by default, but clang-15=
 is
> still supported, and it's trivial to avoid by adapting the types accordin=
g
> to the range of the passed data and the format string.
>
> Fixes: 2e9064faccd1 ("x86/microcode/amd: Fix snprintf() format string war=
ning in W=3D1 build")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Yeah the family only needs a byte so this is OK.

Reviewed-by: Justin Stitt <justinstitt@google.com>

> ---
>  arch/x86/kernel/cpu/microcode/amd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/mi=
crocode/amd.c
> index 13b45b9c806d..620f0af713ca 100644
> --- a/arch/x86/kernel/cpu/microcode/amd.c
> +++ b/arch/x86/kernel/cpu/microcode/amd.c
> @@ -465,7 +465,7 @@ static bool early_apply_microcode(u32 cpuid_1_eax, u3=
2 old_rev, void *ucode, siz
>         return !__apply_microcode_amd(mc);
>  }
>
> -static bool get_builtin_microcode(struct cpio_data *cp, unsigned int fam=
ily)
> +static bool get_builtin_microcode(struct cpio_data *cp, u8 family)
>  {
>         char fw_name[36] =3D "amd-ucode/microcode_amd.bin";
>         struct firmware fw;
> --
> 2.39.2
>

