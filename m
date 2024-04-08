Return-Path: <linux-kernel+bounces-134821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BFF689B767
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 08:00:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7C231F217AD
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 06:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FEA117745;
	Mon,  8 Apr 2024 06:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vrull.eu header.i=@vrull.eu header.b="ZPL9X2/B"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD37114294
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 06:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712556026; cv=none; b=i/kO7l2lOQAuY4g13eeI+ebUqi8EsebgpLq4eGWkrJASWbJNfl235xlKX3WIfqDYi9z0DyFgRvPCk3kCVORuAUiobJwQlw8VyFnS7u8gRjQSuDRN7rcb2DuAISNuQz5yV0DVf/d2THxqEo7lQDfbdCwQjC7rc4GerT8O8wZQpAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712556026; c=relaxed/simple;
	bh=Dgte+9seSKo1vkxhUTXpTDe9COQws0G9KKOWm8kVBfE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pTGi1ZTCOPpF4EsC7AngyuHl9P1J6IT+vvrF8CEcBwEPzSqudLMapRNRW8HIwfnlUV7s0f9TINIOvhXEnHGo2uJEl1nCnCzx++HJtiqhXY+rqVbow0yOhWcF8CQvhsMA4q20VuGPNwtzXGqmNCn+v6e6EAiqSajxmctakfs3Hpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vrull.eu; spf=pass smtp.mailfrom=vrull.eu; dkim=pass (2048-bit key) header.d=vrull.eu header.i=@vrull.eu header.b=ZPL9X2/B; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vrull.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vrull.eu
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-5c66b093b86so3800232a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 07 Apr 2024 23:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vrull.eu; s=google; t=1712556024; x=1713160824; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cDgfpTq5s9r9RpWn74/DEZBPgxC4XB+NI8yofmrMjU0=;
        b=ZPL9X2/BSVronremWSf4ymDRKuDgQZCYJQkAJVnWcVSM2CF0KbpKNEG46B3JT8xHG8
         0iUXSoE8NL7kAQo+6k2faFlT3N1neLryZvNYlK8wfGTLil8Z0aVTl6ynaW4pC0DI2D6n
         R2CDkuDUAmmDNCE/7Be4Oe+V8OZboaaD0lhaEcLTUoktA74d4EjYrXbIGfN+i2RO2Ege
         cvhFggvVnnsvOpHLqi6V2/spSuH0U+Qr+PFIAJZqS37k3JNTdpuIDxCISj8xNUuJL27m
         iyVC7eCPRj7YSg1Pnp13ZEZfsYWfXS0MfuXLX4OzU7ANssmLtERb2rmhESOzyONfunD8
         pCnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712556024; x=1713160824;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cDgfpTq5s9r9RpWn74/DEZBPgxC4XB+NI8yofmrMjU0=;
        b=QBNwn3k1wb1/oLVRBAZckSmvuhYCwfM3CplOh+2GLT2WntJFvry48UokwCpQOf2mN4
         jQjqEwH7Zs7ShofAx3yuCGN1XZGhgY8R9Etx9HxWslCAIVTZWElIqcrRpBuN40+MVRkV
         Q94v3yWoJ4x4xVxDdG6quxoDbZ6zkLghwwl3lj6tTcEKTQA5AOoWiZWIYuRK+pckVzCt
         CkcYUxsn5vBwkcMf6ttdWE49/AlLcjWFVJMj2FTpSeqnZcHwN/pRxCliQlIPK5HBYt4K
         fk42ZFNIFXmJhGA41CwJQnX9WbcZuACsNaUJZfzgYDyrTfUcEx6au2o19szVzrCe/L4v
         S3Eg==
X-Forwarded-Encrypted: i=1; AJvYcCXWGxJMnSbBcHxy7D0ppf7vvzHk1I6aQRJrL1dnbpkQ0gsr0OVVAEjkmBGGW9x9UoT9BceFgTHqDYS5FFWhbjorkIYMuEQzz47+vt1T
X-Gm-Message-State: AOJu0YyaZ5ZCD7dESIXUR69czL+agr9jhM6q2wuwaYsR0HNJjUJu3D8r
	oBqEnBxY7hjGaMGFlhTseKET2fHNvJFGdkaBm1th27prEN1FESjZd1iC6P8YGTUY+ldkOc44fbk
	6KJxdmbvulGCstC/wtNKfQcZqqJr2CTjItEG7Ag==
X-Google-Smtp-Source: AGHT+IHE9wZLzBEa3V0DyC4Aa6bZVPs3tj6YPvkoeL6bgvpCgMykM2NVNxVSXPCQ5kmB+MqIqYs5893dhAgN9VZpO2o=
X-Received: by 2002:a17:90a:3906:b0:2a0:7895:f356 with SMTP id
 y6-20020a17090a390600b002a07895f356mr11906656pjb.12.1712556023817; Sun, 07
 Apr 2024 23:00:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240407213236.2121592-3-christoph.muellner@vrull.eu> <tencent_CF232CDF85208DF6BFA3076E73CC4E087306@qq.com>
In-Reply-To: <tencent_CF232CDF85208DF6BFA3076E73CC4E087306@qq.com>
From: =?UTF-8?Q?Christoph_M=C3=BCllner?= <christoph.muellner@vrull.eu>
Date: Mon, 8 Apr 2024 08:00:12 +0200
Message-ID: <CAEg0e7h0F_LaeMoS6Co1UjgLM6ML8SXtTfHW5+OQS6yedjdZPQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] riscv: T-Head: Test availability bit before
 enabling MAE errata
To: Yangyu Chen <cyy@cyyself.name>
Cc: ajones@ventanamicro.com, alex@ghiti.fr, alistair.francis@wdc.com, 
	aou@eecs.berkeley.edu, bjorn@kernel.org, conor.dooley@microchip.com, 
	conor@kernel.org, cooper.qu@linux.alibaba.com, dbarboza@ventanamicro.com, 
	dqfext@gmail.com, eric.huang@linux.alibaba.com, heiko@sntech.de, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	palmer@dabbelt.com, paul.walmsley@sifive.com, philipp.tomsich@vrull.eu, 
	samuel.holland@sifive.com, zhiwei_liu@linux.alibaba.com, guoren@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 8, 2024 at 3:58=E2=80=AFAM Yangyu Chen <cyy@cyyself.name> wrote=
:
>
> On 2024/4/8 05:32, Christoph M=C3=BCllner wrote:
> > T-Head's memory attribute extension (XTheadMae) (non-compatible
> > equivalent of RVI's Svpbmt) is currently assumed for all T-Head harts.
> > However, QEMU recently decided to drop acceptance of guests that write
> > reserved bits in PTEs.
> > As XTheadMae uses reserved bits in PTEs and Linux applies the MAE errat=
a
> > for all T-Head harts, this broke the Linux startup on QEMU emulations
> > of the C906 emulation.
> >
> > This patch attempts to address this issue by testing the MAE-enable bit
> > in the th.sxstatus CSR. This CSR is available in HW and can be
> > emulated in QEMU.
> >
> > This patch also makes the XTheadMae probing mechanism reliable, because
> > a test for the right combination of mvendorid, marchid, and mimpid
> > is not sufficient to enable MAE.
> >
> > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> > Signed-off-by: Christoph M=C3=BCllner <christoph.muellner@vrull.eu>
> > ---
> >   arch/riscv/errata/thead/errata.c | 14 ++++++++++----
> >   1 file changed, 10 insertions(+), 4 deletions(-)
> >
> > diff --git a/arch/riscv/errata/thead/errata.c b/arch/riscv/errata/thead=
/errata.c
> > index 6e7ee1f16bee..bf6a0a6318ee 100644
> > --- a/arch/riscv/errata/thead/errata.c
> > +++ b/arch/riscv/errata/thead/errata.c
> > @@ -19,6 +19,9 @@
> >   #include <asm/patch.h>f
> >   #include <asm/vendorid_list.h>
> >
> > +#define CSR_TH_SXSTATUS              0x5c0
> > +#define SXSTATUS_MAEE                _AC(0x200000, UL)
> > +
> >   static bool errata_probe_mae(unsigned int stage,
> >                            unsigned long arch_id, unsigned long impid)
> >   {
> > @@ -28,11 +31,14 @@ static bool errata_probe_mae(unsigned int stage,
> >       if (arch_id !=3D 0 || impid !=3D 0)
> >               return false;
> >
>
> I would raise a little concern about keeping this "if" statement for
> arch_id and imp_id after we have probed it in this CSR way. I would like =
to
> remove it and move the CSR probe earlier than RISCV_ALTERNATIVES.
>
> I added CC to guoren for more opinions.
>
> Even T-Head C908 comes in 2023, which supports RVV 1.0 and also keeps MAE=
E.
> But it also supports Svpbmt, and we can perform the switch by clearing th=
e
> MAEE bit in CSR_TH_MXSTATUS in M-Mode Software.
>
> Moreover, T-Head MAEE may not be removed in the future of T-Head CPUs. We
> can see something from the T-Head C908 User Manual that adds a Security b=
it
> to MAEE. So, it might used in their own TEE implementation and will not b=
e
> removed.
>
> However, C908 has arch_id and impid, which are not equal to zero. You can
> see it from the C908 boot log [2] from my patch to support K230 [3]. So, =
if
> we have probed MAEE using CSR, you confirmed that this bit will also be s=
et
> in the C906 core. We can only probe it this way and no longer use arch_id
> and imp_id. And if the arch_id and imp_id probes get removed, we should
> also move the csr probe earlier than riscv alternatives.

We keep the probing via arch_id=3D=3D0&&impid=3D=3D0 because we had that
already in the kernel and don't want to break existing functionality.

From the discussions that we had about the v1 and v2 of this series,
my impression is that we should use DT properties instead of probing
arch_id and impid. So, if C908 support is needed, this should probably
be introduced using DT properties. The logic would then be:
* if arch_id =3D=3D 0 and impid =3D=3D 0 then decide based on th.sxstatus.M=
AEE
* else test if "xtheadmae" is in the DT




>
> [1] https://occ-intl-prod.oss-ap-southeast-1.aliyuncs.com/resource//16992=
68369347/XuanTie-C908-UserManual.pdf
> [2] https://gist.github.com/cyyself/b9445f38cc3ba1094924bd41c9086176
> [3] https://lore.kernel.org/linux-riscv/tencent_D1180541B4B31C0371DB634A4=
2681A5BF809@qq.com/
>
> Thanks,
> Yangyu Chen
>
> > -     if (stage =3D=3D RISCV_ALTERNATIVES_EARLY_BOOT ||
> > -         stage =3D=3D RISCV_ALTERNATIVES_MODULE)
> > -             return true;
> > +     if (stage !=3D RISCV_ALTERNATIVES_EARLY_BOOT &&
> > +         stage !=3D RISCV_ALTERNATIVES_MODULE)
> > +             return false;
> >
> > -     return false;
> > +     if (!(csr_read(CSR_TH_SXSTATUS) & SXSTATUS_MAEE))
> > +             return false;
> > +
> > +     return true;
> >   }
> >
> >   /*
>

