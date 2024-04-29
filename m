Return-Path: <linux-kernel+bounces-162495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26E228B5C02
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 16:54:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6ABC28733F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 14:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69C1780630;
	Mon, 29 Apr 2024 14:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="URpeoLxP"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9217B745C5;
	Mon, 29 Apr 2024 14:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714402469; cv=none; b=qR+xV8vz+0GmEQPRMAj/7osH6FtC6zmZ0+3F/fok2FrXcPKs1LG6N+lBciCT11sqwCsaGwgSDaBlRbab9E8INXDF4B2fBhJYnRnPYnNQ4ObpcmWA7YIUQfUIqjUF+HN/aKhg+K8Ax7by5UezZpA7MbPWrebtA93XhxRznmX2+1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714402469; c=relaxed/simple;
	bh=0OP1iT2oLI/HVVFj+Pz0v/3yh8vFWtEFHZCgWRQGeOA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k4m2vWicRiTU+iFbIoEO6pvoorM1kfyWysSPnRz/+5WECGEzO10AMw+xp+FrHXNx6YOEe7DT3BSGHhm7HmiiXMnfDNmSkWoR2fs4JTmogED+BE5ORLcrBK7OCXt28CyWiAB5awACzrRT2xZLZIyw5Pi645e6qmMsM9ttYa7xqr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=URpeoLxP; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-34c8f392172so1726029f8f.3;
        Mon, 29 Apr 2024 07:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714402466; x=1715007266; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0tfJMXHQAgMuRFbS4QzP6+/eEdtXTDFDEyyoUoeB4Ss=;
        b=URpeoLxPs8dKpqBQZpurBvjWUlBPIr0aMzxVltu8BQJoJIkSwRwgyPNoDWacrdr902
         4Dz6apEeJ2dABIxJj3DhuCyprWVritRqpY0Cu5ql9tEG/N85vK58hAZ84s6G6qZCxgSd
         yCkkhXuYNw5tq92K1UWcCyw5Z6KlN7lxbyd5Ehdqcg4YB0ip2G9dtUrhS78hVxkfpRys
         vLvaW9R8aunDrJs9CTiYYAvaEJ1AbCtap9AcDhPVrCnCeJayq5gGpNuKtC1uX4P9jmRi
         RviqIJss6j+TEQet+c3hA+YQlHH3IcjTkIwN3tktipGXFu1RnEEmUSxKM2G4gGCfDKID
         YVWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714402466; x=1715007266;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0tfJMXHQAgMuRFbS4QzP6+/eEdtXTDFDEyyoUoeB4Ss=;
        b=vwVcybDuR7RJyYbKAEFEWNEOKWy2YT/ase5eOS817PKGBa0C8G0CQEhgDKB2btQPTO
         WU+wXiJ/wHuKkxD/q1zZqWCwRdj3QiD28hx/BhvxL+rp0x/wmSSYamCGd/LJvhXIOJZ7
         ryefdui4DiqQGFOB63v642nrEgMh4Jt9aIlKTQlmvjDXSJWg7drF7rQKFS55V2QnTIpL
         Z3OhOUKHU7dmCSYCP7sVhST4m0BjwVnxbnRiBoTefnE9IbRi3tjA6QXDqlcpdMKJbkJC
         3XmKmzabs6kqKPEv37Emp7wzwO62C3hLrlZtPTsR1qo5qdZEvS5HIaMEJTeEpoLg5FjV
         g3iQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDXabMcZyp0LIBp2YPE1cpZxYYx+ktYgD6qz5GYklgHKoDDD+77nhlqpXtqGYMHNa/lGU6NqERS2xSvaXCP22z1c+kXeADFOm3z5Iz9EbiqT/9V0VMdc38m+6RXSycprtpHG1CH+gwx/l1QpE=
X-Gm-Message-State: AOJu0Yy4Dz7AGVI2DU4R7uMNG+x+MDIBwPy6ZPfRgcY8ZPB+GMlqy7t4
	gwJETWmbqKzrYwH0OSpYDLCKzUutR6B4itnKiqps64jGBUpsyEBscwKG+l8O1dpT8NuBDMhi583
	iQYo17bSibAZBj2o9Jl0XhPzrANL0tITY
X-Google-Smtp-Source: AGHT+IHfEadp9VYsmGq1UEVeu6FrmpSgdOGjTzB+5DoH19hSgrF1zJiGbFcyAZRttnD4y1+IdZHv+1YYYkLFT5DtmOE=
X-Received: by 2002:adf:a442:0:b0:34a:5c6d:4605 with SMTP id
 e2-20020adfa442000000b0034a5c6d4605mr9573244wra.0.1714402465524; Mon, 29 Apr
 2024 07:54:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240428142937.785925-1-peteryin.openbmc@gmail.com>
 <20240428142937.785925-2-peteryin.openbmc@gmail.com> <d231737bfa9f3dd3c0a4370ab2e86557a407980d.camel@codeconstruct.com.au>
In-Reply-To: <d231737bfa9f3dd3c0a4370ab2e86557a407980d.camel@codeconstruct.com.au>
From: Peter Yin <peteryin.openbmc@gmail.com>
Date: Mon, 29 Apr 2024 22:54:14 +0800
Message-ID: <CAPSyxFRG8mooBg1QWZk8sw=cWzoUQqk=WnyAtgPfRBmQRKtvaQ@mail.gmail.com>
Subject: Re: [PATCH v8 1/1] drivers: watchdog: revise watchdog bootstatus
To: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: patrick@stwcx.xyz, Wim Van Sebroeck <wim@linux-watchdog.org>, 
	Guenter Roeck <linux@roeck-us.net>, Joel Stanley <joel@jms.id.au>, linux-watchdog@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrew,
    I am not sure how to add the Fixes tag, Is it like this?

Fixes: 6a6c7b006e5c (watchdog: aspeed: Add support for
aspeed,reset-mask DT property).
Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>

Is it the correct commit ID or should I base on which commit ID?

Thanks,
Peter.

On Mon, Apr 29, 2024 at 9:50=E2=80=AFAM Andrew Jeffery
<andrew@codeconstruct.com.au> wrote:
>
> Hi Peter,
>
> Thanks for reworking the patch to reduce the branching in probe(), it
> looks a lot tidier.
>
> First, regarding the patch subject, looking at recent changes to the
> watchdog subsystem the desired pattern appears to be `watchdog:
> <controller>: <description>`. I expect you should change it to
> `watchdog: aspeed: Revise handling of bootstatus`. Currently the
> subject contains `drivers: ` which feels a bit redundant, and fails to
> mention `aspeed`, which will bound the scope of the patch for people
> skimming the mailing list.
>
> I have a bit of feedback below. It looks like a lot but mostly it's
> nitpicking at how we're naming things. Maybe the comments are a bit
> subjective but I think addressing them will help provide consistency
> for readers of the code.
>
> On Sun, 2024-04-28 at 22:29 +0800, Peter Yin wrote:
> > Regarding the AST2600 specification, the WDTn Timeout Status Register
> > (WDT10) has bit 1 reserved. Bit 1 of the status register indicates
> > on ast2500 if the boot was from the second boot source.
> > It does not indicate that the most recent reset was triggered by
> > the watchdog. The code should just be changed to set WDIOF_CARDRESET
> > if bit 0 of the status register is set. However, this bit can be clear =
when
> > watchdog register 0x0c bit1(Reset System after timeout) is enabled.
> > Thereforce include SCU register to veriy WDIOF_EXTERN1 and WDIOF_CARDRE=
SET
> > in ast2600 SCU74 or ast2400/ast2500 SCU3C.
> >
> > Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
> > ---
> >  drivers/watchdog/aspeed_wdt.c | 78 +++++++++++++++++++++++++++++++----
> >  1 file changed, 70 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/watchdog/aspeed_wdt.c b/drivers/watchdog/aspeed_wd=
t.c
> > index b4773a6aaf8c..4393625c2e96 100644
> > --- a/drivers/watchdog/aspeed_wdt.c
> > +++ b/drivers/watchdog/aspeed_wdt.c
> > @@ -11,10 +11,12 @@
> >  #include <linux/io.h>
> >  #include <linux/kernel.h>
> >  #include <linux/kstrtox.h>
> > +#include <linux/mfd/syscon.h>
> >  #include <linux/module.h>
> >  #include <linux/of.h>
> >  #include <linux/of_irq.h>
> >  #include <linux/platform_device.h>
> > +#include <linux/regmap.h>
> >  #include <linux/watchdog.h>
> >
> >  static bool nowayout =3D WATCHDOG_NOWAYOUT;
> > @@ -22,10 +24,32 @@ module_param(nowayout, bool, 0);
> >  MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (d=
efault=3D"
> >                               __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
> >
> > +//AST SCU Register
>
> Can you unpack in the comment which register this refers to? Also I
> have a mild preference for `/* */-style comments and against the `//`-
> style comments, but I won't hold the patch up on it.
>
> > +#define POWERON_RESET_FLAG           BIT(0)
> > +#define EXTERN_RESET_FLAG            BIT(1)
>
> IMO an `AST_` prefix would be helpful. At least, it would help me
> orient myself when reading use of the macro in the code.
>
> Further, can we include `SCU` in the symbol name to indicate we're not
> actually referring to a register in the WDT controller (and update the
> register and flag macros below as well)?
>
> Finally, including an indication of the register name (System Reset
> Control/Status Register for the AST2500, System Reset Status Register
> for the AST2600) is helpful too:
>
> Perhaps:
>
> ```
> #define AST_SCU_SYS_RESET_POWERON_FLAG ...
> #define AST_SCU_SYS_RESET_EXTERN_FLAG ...
> ```
>
> I'd like to see these approaches applied to the other macros you've
> introduced as well.
>
> > +
> > +#define AST2400_AST2500_SYSTEM_RESET_EVENT   0x3C
>
> If the AST2500 register offset is compatible with the AST2400 then IMO
> you can drop `_AST2500` from the macro name. The location of relevance
> for a potential bug is the assignment into the `reset_event` struct
> member below, which is straight-forward to inspect for correctness.
>
> With the prior requests in mind I'd propose:
>
> ```
> #define AST2400_SCU_SYS_RESET_STATUS ...
> ```
>
> > +#define   AST2400_WATCHDOG_RESET_FLAG        BIT(1)
> > +#define   AST2400_RESET_FLAG_CLEAR   GENMASK(2, 0)
> > +
> > +#define   AST2500_WATCHDOG_RESET_FLAG        GENMASK(4, 2)
>
> While the individual bits in the register are flags, we're extracting a
> collection of the bits from the register. My feeling is that we should
> s/_FLAG/_MASK/ in the macro names, including
> `AST2400_WATCHDOG_RESET_FLAG` for consistency (even though it is only a
> single-bit mask).
>
> > +#define   AST2500_RESET_FLAG_CLEAR   (AST2500_WATCHDOG_RESET_FLAG | \
> > +                                      POWERON_RESET_FLAG | EXTERN_RESE=
T_FLAG)
> > +
> > +#define AST2600_SYSTEM_RESET_EVENT   0x74
> > +#define   AST2600_WATCHDOG_RESET_FLAG   GENMASK(31, 16)
> > +#define   AST2600_RESET_FLAG_CLEAR   (AST2600_WATCHDOG_RESET_FLAG | \
> > +                                      POWERON_RESET_FLAG | EXTERN_RESE=
T_FLAG)
> > +
> >  struct aspeed_wdt_config {
> >       u32 ext_pulse_width_mask;
> >       u32 irq_shift;
> >       u32 irq_mask;
> > +     const char *compatible;
>
> Hmm, a compatible string for what though? From the looks of the code,
> this is for the SCU. I think it would be be helpful to prefix this with
> `scu_` to make it clear, though see the struct-style consideration
> below.
>
> > +     u32 reset_event;
>
> The datasheets refer to the register as 'status' and not 'event', so I
> suggest we use `reset_status` here. I also prefer we suffix this with
> `_reg` to actively differentiate it from the other field types (_flag)
> we're defining (so `reset_status_reg`.
>
> > +     u32 watchdog_reset_flag;
> > +     u32 extern_reset_flag;
>
> s/_flag/_mask/ if we have consensus on that macro name discussion
> above.
>
> > +     u32 reset_flag_clear;
>
> I'd prefix these with `scu_` as well. Or perhaps a nested struct?
>
> struct aspeed_wdt_config {
>     ...
>     struct {
>         const char *compatible;
>         u32 reset_event_reg;
>         u32 watchdog_reset_mask;
>         u32 extern_reset_mask;
>         u32 reset_flag_clear;
>    } scu;
>
> That way the accesses look like wdt->cfg->scu.reset_event_reg` and
> provide some context via the type system instead of deferring to object
> naming convention.
>
> >  };
> >
> >  struct aspeed_wdt {
> > @@ -39,18 +63,33 @@ static const struct aspeed_wdt_config ast2400_confi=
g =3D {
> >       .ext_pulse_width_mask =3D 0xff,
> >       .irq_shift =3D 0,
> >       .irq_mask =3D 0,
> > +     .compatible =3D "aspeed,ast2400-scu",
> > +     .reset_event =3D AST2400_AST2500_SYSTEM_RESET_EVENT,
> > +     .watchdog_reset_flag =3D AST2400_WATCHDOG_RESET_FLAG,
> > +     .extern_reset_flag =3D 0,
> > +     .reset_flag_clear =3D AST2400_RESET_FLAG_CLEAR,
> >  };
> >
> >  static const struct aspeed_wdt_config ast2500_config =3D {
> >       .ext_pulse_width_mask =3D 0xfffff,
> >       .irq_shift =3D 12,
> >       .irq_mask =3D GENMASK(31, 12),
> > +     .compatible =3D "aspeed,ast2500-scu",
> > +     .reset_event =3D AST2400_AST2500_SYSTEM_RESET_EVENT,
> > +     .watchdog_reset_flag =3D AST2500_WATCHDOG_RESET_FLAG,
> > +     .extern_reset_flag =3D EXTERN_RESET_FLAG,
> > +     .reset_flag_clear =3D AST2500_RESET_FLAG_CLEAR,
> >  };
> >
> >  static const struct aspeed_wdt_config ast2600_config =3D {
> >       .ext_pulse_width_mask =3D 0xfffff,
> >       .irq_shift =3D 0,
> >       .irq_mask =3D GENMASK(31, 10),
> > +     .compatible =3D "aspeed,ast2600-scu",
> > +     .reset_event =3D AST2600_SYSTEM_RESET_EVENT,
> > +     .watchdog_reset_flag =3D AST2600_WATCHDOG_RESET_FLAG,
> > +     .extern_reset_flag =3D EXTERN_RESET_FLAG,
> > +     .reset_flag_clear =3D AST2600_RESET_FLAG_CLEAR,
> >  };
> >
> >  static const struct of_device_id aspeed_wdt_of_table[] =3D {
> > @@ -310,6 +349,7 @@ static int aspeed_wdt_probe(struct platform_device =
*pdev)
> >       const struct of_device_id *ofdid;
> >       struct aspeed_wdt *wdt;
> >       struct device_node *np;
> > +     struct regmap *scu_base;
>
> I don't think it's necessary to have the `_base` suffix as we're not
> dealing directly with a mapped address.
>
> >       const char *reset_type;
> >       u32 duration;
> >       u32 status;
> > @@ -458,14 +498,36 @@ static int aspeed_wdt_probe(struct platform_devic=
e *pdev)
> >               writel(duration - 1, wdt->base + WDT_RESET_WIDTH);
> >       }
> >
> > -     status =3D readl(wdt->base + WDT_TIMEOUT_STATUS);
> > -     if (status & WDT_TIMEOUT_STATUS_BOOT_SECONDARY) {
>
> Dropping this condition suggests the patch is a fix. Has there been any
> discussion of adding a Fixes: tag?
>
> Andrew

