Return-Path: <linux-kernel+bounces-97742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A3D0876EAC
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 03:09:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 179E21C20DB0
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 02:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79FFB20317;
	Sat,  9 Mar 2024 02:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="162fV91/"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2621023A2
	for <linux-kernel@vger.kernel.org>; Sat,  9 Mar 2024 02:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709950183; cv=none; b=l9p9vRJHibo5Z3OY0Pdo9c+kk39wYr9+3anKWPKeSYkK+sMUmR0Qfsq2pdhJJlUq8oMPNYV7/e1CnH0AKwNtNGNLwd2LFGEAVBo12NEVUzfT3MO4jGCKdy7ojwr1+YlyZhSvjKzOg3GfjBOjQ7Y6/JpBH2AOr2ZcKc63Kubfo00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709950183; c=relaxed/simple;
	bh=fT2eqEK6ZX28H5ccaTmcMsNQ6nqglFnzvb6+pgySt8M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZJfOmWM05yLtCCRgSMm36zFXYy9RgN/zktbuB42SysMWlMTEQxud6EqEkURZJisbQx6S/Vp/5d8V0U0IbiiKDbcX7MWawvx6AkD5SNHQlrTMmVeXduzEonxcwYXYotrMsRVZgSpSg3nQUpTIl8oQvXPyJZkvs04z6f5+i9R5zVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=162fV91/; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-568251882d7so6857a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 18:09:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709950180; x=1710554980; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5iA/O5FAuZIkkJpLARXGwTKQU7mlJK2bNxZqfqbSr2E=;
        b=162fV91/XLOMEVNu91kVDZW9v62EwBIoAJ6EGL0eth1xx+4E3qI4HCMkc9ZHzAiJWr
         uxmyJNPircX+RGcRCM9H0bxjIew2rU/YY0mie6mRepV05xeWiQhgsLRHh/GJi9exhQ3K
         QbsNCRmq4fNrCDQ7dVA5P3TA0M1/B8p/y08qjrU9zelDcIatjzq9TrZQLxPjhVXh7jnj
         r1jouNfrwCJY458HZ9NfSjlhwiee+STd7gGbDwMvcXiGBSwT4IalZus6pj6qzJ/PQJa6
         J26Dea5K2hi4INEP5+YfcmcaxGIZsxkdSnOMzA6zRxVl4+1tCoP9CfDA4S5bhGCSX9KX
         voQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709950180; x=1710554980;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5iA/O5FAuZIkkJpLARXGwTKQU7mlJK2bNxZqfqbSr2E=;
        b=LDOPuXWn4Zv4axPZpDmpPucRxEx7r/aLjFeWxYaF22dGQzDVmSCaNlaO39dhHEiOxt
         KOPn7KtgTt4g+hQ0bsVPrtOkd2N7j3kN09oJsIhzMwxS5YEYJq85ibMo8KFrvgp5z4YB
         KqH+zd1Vux0sU+jVvBgXpXd3LNSDCNipgA1dEyIrzJ9KfpIeviYoDFj4ospHjj2bfkjB
         /xxWJR9akv334Vz6KbhVUnoB/4SGxr2FdpH4dzVB1WPMg8UAAHLM5EqVbNWN9lT9R7F+
         1z2vrYeDvuwj2ZFryDA6znjD1lL7iJ1VfMz/jK5Q94CTfQcfjRnHuH4gJ9w4AGT7XnLJ
         Tqww==
X-Forwarded-Encrypted: i=1; AJvYcCWR+YfU7/PsDxHuVYsifCqWo0dnIoELgXA8pnvlc5jKvQGN2QBm9lu5E/If/L0I+nQbw94HuTNN8QaeGbuWS5BK3/w9p4xQ9hrYC2KX
X-Gm-Message-State: AOJu0Yzkl578yWQUVOxP94s1lcJynsUVPEqJont5pn1Gr0/zPpb94f0o
	Zl6MNrsKKJFc+01/NJbfZzfQV6w05oBDwpI20nJk1XSOf62IFIHXzd50w67zuDtW9iY4e/tOyko
	PpeSiUsUzzr+b6/8LIilIsMVYYwufJvHql0k=
X-Google-Smtp-Source: AGHT+IH1wfEsl3zKB9H3Vyi4xiJuc8O27VmE0VqduNPgWy5WeVV80OQIL23LnY8tOoMP/pNpbewIu2F/rKRc58j5SR0=
X-Received: by 2002:aa7:cb57:0:b0:568:2a4d:9881 with SMTP id
 w23-20020aa7cb57000000b005682a4d9881mr247846edt.7.1709950180312; Fri, 08 Mar
 2024 18:09:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240308131512.44324-1-adrian.hunter@intel.com> <20240308131512.44324-2-adrian.hunter@intel.com>
In-Reply-To: <20240308131512.44324-2-adrian.hunter@intel.com>
From: John Stultz <jstultz@google.com>
Date: Fri, 8 Mar 2024 18:09:27 -0800
Message-ID: <CANDhNCppmiSEGXErDZ5=gpWFNrS5+Y_vY3e76vhqCwpxKZ+bnw@mail.gmail.com>
Subject: Re: [PATCH 01/19] vdso: Consolidate vdso_calc_delta()
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, 
	Vincenzo Frascino <vincenzo.frascino@arm.com>, Stephen Boyd <sboyd@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>, 
	Anna-Maria Behnsen <anna-maria@linutronix.de>, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 8, 2024 at 5:15=E2=80=AFAM Adrian Hunter <adrian.hunter@intel.c=
om> wrote:
>
> Consolidate vdso_calc_delta(), in preparation for further simplification.
>
> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  arch/powerpc/include/asm/vdso/gettimeofday.h | 17 ++---------------
>  arch/s390/include/asm/vdso/gettimeofday.h    |  7 ++-----
>  lib/vdso/gettimeofday.c                      |  4 ++++
>  3 files changed, 8 insertions(+), 20 deletions(-)
>
> --- a/lib/vdso/gettimeofday.c
> +++ b/lib/vdso/gettimeofday.c
> @@ -13,7 +13,11 @@
>  static __always_inline
>  u64 vdso_calc_delta(u64 cycles, u64 last, u64 mask, u32 mult)
>  {
> +#ifdef VDSO_DELTA_NOMASK
> +       return (cycles - last) * mult;
> +#else
>         return ((cycles - last) & mask) * mult;
> +#endif
>  }

Nit: Just for readability, usually we avoid #ifdefs inside of functions.

Instead maybe:
#ifdef VDSO_DELTA_NOMASK
static __always_inline
u64 vdso_calc_delta(u64 cycles, u64 last, u64 mask, u32 mult)
 {
       return (cycles - last) * mult;
 }
#else
static __always_inline
u64 vdso_calc_delta(u64 cycles, u64 last, u64 mask, u32 mult)
 {
      return ((cycles - last) & mask) * mult;
 }
#endif

