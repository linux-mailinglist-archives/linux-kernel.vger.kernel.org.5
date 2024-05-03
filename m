Return-Path: <linux-kernel+bounces-168261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B308BB5DB
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 23:35:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 237E41F220B5
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 21:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4136C71B51;
	Fri,  3 May 2024 21:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m1p4Rwzk"
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED56E5914C;
	Fri,  3 May 2024 21:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714772094; cv=none; b=Y6jarzwu+ejJ7OBMJur3bmamqlIijA4bf19DpmXgGQASdzvhMGTAqPlPNRnwhIFxUyYY/hJAGFT6FaYhgC/cwPkcJtM6EcZdUJFq17BDDhD4PZos2GgISZvNJSenjhTmXdwEcachuZZ9aWxThyYgF2ISjw/ICUnT1K/CqctXkJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714772094; c=relaxed/simple;
	bh=G+qm8/ugbECOEVX98AimsGMwO62Rp+FghrrPhBFcwwk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iKcvFv3dfL2v45LyjD0zdT9ENp/KiMjisTEKQgKihJryTsm4FLkBEtENfpIgQ9WF2ySgeSJJgWSMDWlK9kRiaNJVcGG6Fu2DrHs+Ov7kdtJGgmItsdfd5OKzRXDgF2/dqb/pN9TBXbAVRys34jK1yigVdMy5+C4/QoEDAA3bavs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m1p4Rwzk; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-de54b28c41eso174466276.0;
        Fri, 03 May 2024 14:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714772092; x=1715376892; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tC7sH68VgjfgX9UDWZ/v/q9uL8QvGp7TNkRbmhFCwL4=;
        b=m1p4Rwzky0+igvUxP9f9wcQ+rnhCXMXAfOabXcMxTOYv2ycEoOJTrHPaDOcz4/n6Y2
         TrH1TutXaA4g8Jqh7LGSp6DKGdmdTj7u+ecOhyzU5FfplNiYDUXG/zZwWlwz4z30jnIR
         xoR578/tlAtYIaWdi0iil7vqOUPU8i74e3G4yq+0muG8mFxg/pDSWmND+M+fSsJSPOMG
         eowVOh7ar6xjrq/q8J6ePNDLyDYETkw+F49vXgOxlNa+mQ7sXHRsZtAA/wzL+LShQKR/
         TA/6dzJd91n6sBjDbU7piHst71tiOzk+3VqMF9a1ua6I8XmSZ6cFz475Xhz04GqrUhbG
         Q9Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714772092; x=1715376892;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tC7sH68VgjfgX9UDWZ/v/q9uL8QvGp7TNkRbmhFCwL4=;
        b=kwrTdqzDBc99dGZOmxD/EpbXrMC2Oh6DUxHTDENc5gj1FPtTrZwg9lQ54fZQKt3SGt
         nm6dnLOU43TKbuxaevl6uvo5BmmfNV1jhkkzHzZIv789/fK4y7a8Kp0fZBSV69qY0YQE
         KLl7zfRQfRpJ7ZLYx8oSpSm8vgMYrNckqcwpNtDYPZZCcUPXFCHL82dj3+QLUyxXaNkf
         NKPg44dUdoTJSIaE/X5GLoaGjE11bBwc79nsOmNAneNl8nLAWGj9ypg7UtEl7CD2Rq3t
         /+krfJf4YZgHbD9FcKMu7CFNpyTIWA54O3AEkMAy8iEI9X+2bBIbVVRaPYgWtO77seCx
         NWyg==
X-Forwarded-Encrypted: i=1; AJvYcCUGJlQt3OWuSvQfSeYFCLZ7OW1Zs/a77NwDZxk412zDPIAIrWoxVUaKht03CxNYBfX2KvIA/7zt+iUmtOvEX1fhr0T33gSGk3TQk+315eC8W74eVYSsr4Ht2IXbbdcCEb/IYuzHFMzTXYteu5rmzCisNT/8U/XZYxK/d5S8ts/d/AsthFU=
X-Gm-Message-State: AOJu0Yx3cvRUHfE2X/zkFo4b1jBxE4+AMuNm19X6dR6YGGAKeDRBmPrL
	j6hoPyGgKPUQAkiGUjTQsxvTmha+H0zpRL7SiTtk/5x1XGoPtsyzkN/EPAeOdDuNiDvCHaN0w+v
	/ZoRnJ6Xhi9E5/1SG81F6JPDE2QE=
X-Google-Smtp-Source: AGHT+IEQvMYH3a3ssvxy7/wLXnv0LSmhPbEgC7ELP4izinqJGxMGJIE45fXICeFpMs8mFmdPFgPcOMLIbyUy2gK1MHA=
X-Received: by 2002:a25:c70c:0:b0:dc5:f51e:6a60 with SMTP id
 w12-20020a25c70c000000b00dc5f51e6a60mr3921979ybe.6.1714772091984; Fri, 03 May
 2024 14:34:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240503135455.966-1-ansuelsmth@gmail.com> <20240503135455.966-6-ansuelsmth@gmail.com>
 <5529fe79-e2f8-47ab-a0cf-2b37bb13bbd7@broadcom.com> <CABwr4_sz4DKjp_cJqTNBCyQSUhXGJM4_h1JSiK-h=8uAbPPoVQ@mail.gmail.com>
 <66355403.050a0220.9e59a.8031@mx.google.com>
In-Reply-To: <66355403.050a0220.9e59a.8031@mx.google.com>
From: =?UTF-8?Q?Daniel_Gonz=C3=A1lez_Cabanelas?= <dgcbueu@gmail.com>
Date: Fri, 3 May 2024 23:34:41 +0200
Message-ID: <CABwr4_u6bgdWHeYwyDTW3xoM-z+JaEPan98jY7QZjP6thgkGRA@mail.gmail.com>
Subject: Re: [PATCH 5/6] mips: bmips: enable RAC on BMIPS4350
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>, Hauke Mehrtens <hauke@hauke-m.de>, 
	=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	=?UTF-8?B?w4FsdmFybyBGZXJuw6FuZGV6IFJvamFz?= <noltari@gmail.com>, 
	linux-mips@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

El vie, 3 may 2024 a las 23:15, Christian Marangi
(<ansuelsmth@gmail.com>) escribi=C3=B3:
>
> On Fri, May 03, 2024 at 11:11:13PM +0200, Daniel Gonz=C3=A1lez Cabanelas =
wrote:
> > El vie, 3 may 2024 a las 20:56, Florian Fainelli
> > (<florian.fainelli@broadcom.com>) escribi=C3=B3:
> > >
> > > On 5/3/24 06:54, Christian Marangi wrote:
> > > > From: Daniel Gonz=C3=A1lez Cabanelas <dgcbueu@gmail.com>
> > > >
> > > > The data RAC is left disabled by the bootloader in some SoCs, at le=
ast in
> > > > the core it boots from.
> > > > Enabling this feature increases the performance up to +30% dependin=
g on the
> > > > task.
> > > >
> > > > Signed-off-by: Daniel Gonz=C3=A1lez Cabanelas <dgcbueu@gmail.com>
> > > > Signed-off-by: =C3=81lvaro Fern=C3=A1ndez Rojas <noltari@gmail.com>
> > > > [ rework code and reduce code duplication ]
> > > > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > > > ---
> > > >   arch/mips/kernel/smp-bmips.c | 12 ++++++++++++
> > > >   1 file changed, 12 insertions(+)
> > > >
> > > > diff --git a/arch/mips/kernel/smp-bmips.c b/arch/mips/kernel/smp-bm=
ips.c
> > > > index 6048c471b5ee..7bde6bbaa41f 100644
> > > > --- a/arch/mips/kernel/smp-bmips.c
> > > > +++ b/arch/mips/kernel/smp-bmips.c
> > > > @@ -617,6 +617,18 @@ void bmips_cpu_setup(void)
> > > >               __raw_readl(bmips_cbr_addr + BMIPS_RAC_ADDRESS_RANGE)=
;
> > > >               break;
> > > >
> > > > +     case CPU_BMIPS4350:
> > > > +             u32 rac_addr =3D BMIPS_RAC_CONFIG_1;
> > > > +
> > > > +             if (!(read_c0_brcm_cmt_local() & (1 << 31)))
> > > > +                     rac_addr =3D BMIPS_RAC_CONFIG;
> > > > +
> > > > +             /* Enable data RAC */
> > > > +             cfg =3D __raw_readl(bmips_cbr_addr + rac_addr);
> > > > +             __raw_writel(cfg | 0xa, bmips_cbr_addr + rac_addr);
> > >
> > > This enables data pre-fetching (bit 3) and data-caching (bit 1), have
> > > you tried with 0xF to see if this provides any additional speed-up?
> > >
> > > Looks correct to me otherwise, I wonder if a flush would be in order
> > > right after enabling, though I did not see any specific instructions
> > > towards that part in the programming notes.
> > >
> > > > +             __raw_readl(bmips_cbr_addr + rac_addr);
> > > > +             break;
> > > > +
> > > >       case CPU_BMIPS4380:
> > > >               /* CBG workaround for early BMIPS4380 CPUs */
> > > >               switch (read_c0_prid()) {
> > >
> > Hi Florian.
> > Bits 0 and 1 are already enabled by the bootloader, so no need to

I meant bits 0 and 2. These are the RAC bits:
#define RAC_FLH         (1 << 8)
#define RAC_DPF         (1 << 6)
#define RAC_NCH         (1 << 5)
#define RAC_C_INV       (1 << 4)
#define RAC_PF_D        (1 << 3)
#define RAC_PF_I        (1 << 2)
#define RAC_D           (1 << 1)
#define RAC_I           (1 << 0)

> > write 0xF. I checked it on some devices with BCM6328, 6358, 6368 SoCs.
> >
> > Example, without the patch, reading the RAC Configuration Register 0 an=
d 1:
> >
> > - BCM6368 booting from TP0:
> > root@OpenWrt:/# devmem 0xff400000
> > 0x02A07015
> > root@OpenWrt:/# devmem 0xff400008
> > 0x0000000F
> >
> > - BCM6368 booting from TP1:
> > root@OpenWrt:/# devmem 0xff400000
> > 0x02A0701F
> > root@OpenWrt:/# devmem 0xff400008
> > 0x00000005
> > root@OpenWrt:/#
> >
>
> [ fixed the top-post ]
>
> If that's the case then i'm setting 0xf since we verified it doesn't
> cause problem and it's already set.

It's harmless to re-enable the instruction bits. BTW the log commit
refers only to data RAC, 0xF is enabling both the data and instruction
RAC.

Daniel
>
> --
>         Ansuel

