Return-Path: <linux-kernel+bounces-143109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FECF8A3451
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 19:05:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3F201F21EAB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 17:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 585D114BFBC;
	Fri, 12 Apr 2024 17:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="gPhjJHla"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A158914BF8A
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 17:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712941522; cv=none; b=V2bT2FaiDGqtomvXKdnmW0GIR+wb74cYUas9UhLzXJXcIGSS83U962fACSYuq7f+UyMTP2fI07HbVdA5egvCGvEoG2pbOxYU965/WQ/kFhE76YjRAjs4pbVLIGJ21YRlG8urM1R35f+UrWA0gAtjMiZPMPpw7zL8/786sPTJf6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712941522; c=relaxed/simple;
	bh=0iWl1Io+EcPTnphzUKNTmq8fNPf9pTiT7i8KtPiB01w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZQfjGaLIQDjQKNxmlByiCOTuFxBfirUvuiSWoMylynI7sqAaJC+Z0iQ7bYv3YSYqAoRUF9UgANZxcJs98Ru9QQkXxsxpGq8ipAa6bfupe/QigFHP1wZfCk/k/CNlVZoE19o14lKA0aFJz56iHGzSN+6dliA8OxmcvTJbQpuYpGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=gPhjJHla; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2d717603aa5so13567121fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 10:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1712941519; x=1713546319; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o2+F6Z5+nSqcwJp5/u9iM3I5euO/lGGwbVB876NJ+N8=;
        b=gPhjJHlaLUE/e3w+17PhCQyuh4F72X36mqiM3kO60Ot4HdC/t42y0c4b9UUv5NxYxY
         MXIysTqFeyRPReWvMCuU3Ey6MDPWZ5l6Toi6InbxxGf0//W2sebHi6mH4UgPnbGZCBDI
         dBzaYo0BbMnKud/8M8zmVY3gAjZULsPQx4FJwQanynAFknTMwZurVr0Y4pVijmE2AD0X
         1P2DklG7e5Z9EUHGwNf0GD8n/W+qlPU1WhkK0C3mfrtlD8eRiB/G45Uh5VswDiemz3nT
         80qMcVXiiSLEEBdli1V4vkVtwX65hdmBhAy66DBTUurt9K6XK+8QkIe8tHgfkhW6VdAo
         nDfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712941519; x=1713546319;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o2+F6Z5+nSqcwJp5/u9iM3I5euO/lGGwbVB876NJ+N8=;
        b=hUPkcWUGEL9K6sHC8laAMdo98SLWvA0YxTOXwrNXAI8zRlGfIyHsvRRS+YOzIzSDY3
         9R6j0tf5tKK24R9jF+2/usmNNYBZwj66mQsiomZbUStOxcpW0FJjNCSiT9/6mFnEXLYU
         xSiruK/QrWKDxGsleaGTFwRbGvINuQ4mvetoLaP6TOHNsXuCGFmNiTvpxXHcIbZRi/fS
         DYMMp5eG9yXK60+0O0AH+Q/4vPQUMI5oAjZ8+b28DJT7bazwJ8BH9eq9aCPt2dNJllmL
         oP7ZJXZ/XFS3Io79NAtK8JtmP258THrFmbJM7hn1A4gj+O0cS99QXYT8dvERCS47abZk
         SggA==
X-Forwarded-Encrypted: i=1; AJvYcCX0gZxn+sqnkR1I4P68Tsjofr+/c++UctSpQAdtPrbSNsn3nxncN26v9YFGZjfhEC7dbFtzGr4Ub4rZ0PB6bxE8bpLdAUbndTZfaYEj
X-Gm-Message-State: AOJu0YxuAcVR5iQBEyOArxFY+oOlrArySajy2BnHVHvreA1mtw/AUczE
	Js1//aTMPUds86mNWhTcgpSyTA800xkgqsWKqzHEqWuUhyqlvgc6RQBUdxZpblvhHCYJZzxkRZk
	pmhEsnP6KSYH9N6ZWNhlDV4Ve+eohqFdg/zaknHcaHXw9zQB5ZYo=
X-Google-Smtp-Source: AGHT+IFTwWgekolEJQkFIbbTNtxauFKuhwni5/Gb89sRytgSj62M43pT7a0jCUkjzdpqZU6SGxa9xotVOWrotjKfpBI=
X-Received: by 2002:a2e:9b06:0:b0:2d5:122a:4b1f with SMTP id
 u6-20020a2e9b06000000b002d5122a4b1fmr2435885lji.43.1712941518949; Fri, 12 Apr
 2024 10:05:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240411-dev-charlie-support_thead_vector_6_9-v1-0-4af9815ec746@rivosinc.com>
 <20240411-dev-charlie-support_thead_vector_6_9-v1-14-4af9815ec746@rivosinc.com>
 <20240412-moonshine-acting-0df1a90b86d2@wendy>
In-Reply-To: <20240412-moonshine-acting-0df1a90b86d2@wendy>
From: Evan Green <evan@rivosinc.com>
Date: Fri, 12 Apr 2024 10:04:42 -0700
Message-ID: <CALs-HsviR8E-sRvzz7pd5eVGb4+XsAdG1hhbZOPf+m3Cu4JP_Q@mail.gmail.com>
Subject: Re: [PATCH 14/19] riscv: hwprobe: Disambiguate vector and
 xtheadvector in hwprobe
To: Conor Dooley <conor.dooley@microchip.com>
Cc: Charlie Jenkins <charlie@rivosinc.com>, Conor Dooley <conor@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	=?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, linux-riscv@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Palmer Dabbelt <palmer@rivosinc.com>, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 12, 2024 at 4:35=E2=80=AFAM Conor Dooley <conor.dooley@microchi=
p.com> wrote:
>
> On Thu, Apr 11, 2024 at 09:11:20PM -0700, Charlie Jenkins wrote:
> > Ensure that hwprobe does not flag "v" when xtheadvector is present.
> >
> > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> > ---
> >  arch/riscv/kernel/sys_hwprobe.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_hw=
probe.c
> > index 8cae41a502dd..e0a42c851511 100644
> > --- a/arch/riscv/kernel/sys_hwprobe.c
> > +++ b/arch/riscv/kernel/sys_hwprobe.c
> > @@ -69,7 +69,7 @@ static void hwprobe_isa_ext0(struct riscv_hwprobe *pa=
ir,
> >       if (riscv_isa_extension_available(NULL, c))
> >               pair->value |=3D RISCV_HWPROBE_IMA_C;
> >
> > -     if (has_vector())
> > +     if (has_vector() && !riscv_has_vendor_extension_unlikely(RISCV_IS=
A_VENDOR_EXT_XTHEADVECTOR))
>
> Hmm, I think this is "dangerous". has_vector() is used across the kernel
> now in several places for the in-kernel vector. I don't think that
> has_vector() should return true for the T-Head stuff given that &
> has_vector() should represent the ratified spec. I'll have to think
> about this one and how nasty this makes any of the save/restore code
> etc.

Yeah, my nose crinkled here as well. If you're having to do a
vendorish thing in this generic spot, then others may too, suggesting
perhaps this isn't the cleanest way to go about it. Ideally extensions
are all additive, rather than subtractive, I guess?


>
> >               pair->value |=3D RISCV_HWPROBE_IMA_V;
> >
> >       /*
> > @@ -112,7 +112,7 @@ static void hwprobe_isa_ext0(struct riscv_hwprobe *=
pair,
> >               EXT_KEY(ZACAS);
> >               EXT_KEY(ZICOND);
> >
> > -             if (has_vector()) {
> > +             if (has_vector() && !riscv_has_vendor_extension_unlikely(=
RISCV_ISA_VENDOR_EXT_XTHEADVECTOR)) {
> >                       EXT_KEY(ZVBB);
> >                       EXT_KEY(ZVBC);
> >                       EXT_KEY(ZVKB);
> >
> > --
> > 2.44.0
> >

