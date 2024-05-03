Return-Path: <linux-kernel+bounces-168220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60D738BB54D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 23:12:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CD14286F65
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 21:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4885680038;
	Fri,  3 May 2024 21:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MntQvuHK"
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F6356750;
	Fri,  3 May 2024 21:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714770686; cv=none; b=j8CHgqQnbcpVaMSAFzUH1U797M0WtGrJiMwqTY5Yv0Gu8a8YWkuywA/K3QK6SZ/RPtczhjdiE40ioWEHnyrI+bc3nYSPqjLbDKMcaiprwZwK+mRIVKyeGnrpqHHOchyvGfEUtHfjpjKREPUy/KfA3eExYQxJCa68BKLhf7GPuvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714770686; c=relaxed/simple;
	bh=Ptv+iiSLneObGvUrCzFwLGZUkxeli0QQbmY91UDllNw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mg37qJJDBMQMWfvYQ83jmA0AS7uJOJnuK71WFdKf7RD02MNyW/YOpRUBSMzwINS6Xeb5SD6A6AxPNp373So2raThoQAw2HZu35P1OK/a4GBkjV4xBIE8J7thoZ7lJHLjcpPDIN6RPfLemHUt53HXQXK3uCD9eV7lFcX3488EwOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MntQvuHK; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-de610800da0so128577276.2;
        Fri, 03 May 2024 14:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714770684; x=1715375484; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HCH2vBIEGFjFQvxPgHBnwRPp7VBESajmVne9dYH/eVU=;
        b=MntQvuHKnjC/3nU3BAkBiRes0PQ4JhAvel/+lkFD0ChhjUTEHOt4ikBs5XDdgexs63
         KcsfXagkSF8mmBB59x/IkqM1EfW6/igCL80xmUXxX0qWFCdAmHQj4rb5gz+wq7qz9xRQ
         x+BlRFDdea9lvFGxbEV8fnPF/LzuK2fxdqZ1wGvFns2OcqawCs5JbPrQanHrlHTamUKe
         jIsxXVTNVXk7HEGzK10n+LcUMWsNHBAPPkhmv1PSBDvrY11m5aSR6j8ABkxvTRYMmuqs
         fD+6123HPyMnTFG92xD4DUTSV3oXev9d/ghQNoQZeMNr99EKVp26kBncv88JBIkxXeaN
         /FyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714770684; x=1715375484;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HCH2vBIEGFjFQvxPgHBnwRPp7VBESajmVne9dYH/eVU=;
        b=TV9rqQI4INgv7YRszh4Ax5Eo36Xt7C8Orlgh/InZYcprutsDg/9WlFUpdOGyQIK7/2
         PO37YHy75C7q/lu3vt/JPW6SEbKTNEMkCd88qRgbfc3tIZzXu2RCObSgj1cfpdKw0caO
         BQw5WvqKf2x0/IYkECJ2qPlqkcYLGcGTfkn3eNJ7pISoeX5I8hkJ0EwEgIh2JHmkk2tq
         Hg//3atvdYuJuhVazBXM3Gy6H4wyeHCK4pg7p7R9eECY7mbshRffxIGV5znbxglhGbz/
         ztG5889seMO8Jp8hHwS9Kh5w2L9cs7xR1yloIksyX6kqzCLQdeU/FC4C6AOBFtbYH75T
         ACTQ==
X-Forwarded-Encrypted: i=1; AJvYcCUlKaa/A1hQgDVPp/FB+q0iqcQVRweqAL2VfHc6/RAZEh6OWdEJhRUDC7PPsGYelUEAvV24zc7zDhSQi4rPHtpDUzRQA2ArMzkyJnPw9rSuz+YnhlYvre+WEjXlskGZjZVPOJXsVhy5ngaufvyoXbd1PZfNVxs7x2jdHn5nw07J33/LrSU=
X-Gm-Message-State: AOJu0Yz5jZougQjEmu8w9GcMC5a2pVz7Dr2un3qyRtLVXeVVjvqP3LbY
	YY7v2i0VTuhubZot99MqjrGVlapj0GJgt3BbxSi61znsCmY60Wf7fMjz2GeVDrMf3arW+98x0Qo
	6daIWe+v8v3V0pJ+2+ek+fBYT0VA=
X-Google-Smtp-Source: AGHT+IHRR1xYiGTzniE4e11IA4rOYDsUqBia4twRF3gawFqReZVK4ExijFnmA9WB80LUmdaOWcuc/nvUWWIQ7oAolgE=
X-Received: by 2002:a25:ad88:0:b0:de5:526d:c9c9 with SMTP id
 z8-20020a25ad88000000b00de5526dc9c9mr3987341ybi.61.1714770684086; Fri, 03 May
 2024 14:11:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240503135455.966-1-ansuelsmth@gmail.com> <20240503135455.966-6-ansuelsmth@gmail.com>
 <5529fe79-e2f8-47ab-a0cf-2b37bb13bbd7@broadcom.com>
In-Reply-To: <5529fe79-e2f8-47ab-a0cf-2b37bb13bbd7@broadcom.com>
From: =?UTF-8?Q?Daniel_Gonz=C3=A1lez_Cabanelas?= <dgcbueu@gmail.com>
Date: Fri, 3 May 2024 23:11:13 +0200
Message-ID: <CABwr4_sz4DKjp_cJqTNBCyQSUhXGJM4_h1JSiK-h=8uAbPPoVQ@mail.gmail.com>
Subject: Re: [PATCH 5/6] mips: bmips: enable RAC on BMIPS4350
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Christian Marangi <ansuelsmth@gmail.com>, Hauke Mehrtens <hauke@hauke-m.de>, 
	=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	=?UTF-8?B?w4FsdmFybyBGZXJuw6FuZGV6IFJvamFz?= <noltari@gmail.com>, 
	linux-mips@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Florian.
Bits 0 and 1 are already enabled by the bootloader, so no need to
write 0xF. I checked it on some devices with BCM6328, 6358, 6368 SoCs.

Example, without the patch, reading the RAC Configuration Register 0 and 1:

- BCM6368 booting from TP0:
root@OpenWrt:/# devmem 0xff400000
0x02A07015
root@OpenWrt:/# devmem 0xff400008
0x0000000F

- BCM6368 booting from TP1:
root@OpenWrt:/# devmem 0xff400000
0x02A0701F
root@OpenWrt:/# devmem 0xff400008
0x00000005
root@OpenWrt:/#

Regards.
Daniel

El vie, 3 may 2024 a las 20:56, Florian Fainelli
(<florian.fainelli@broadcom.com>) escribi=C3=B3:
>
> On 5/3/24 06:54, Christian Marangi wrote:
> > From: Daniel Gonz=C3=A1lez Cabanelas <dgcbueu@gmail.com>
> >
> > The data RAC is left disabled by the bootloader in some SoCs, at least =
in
> > the core it boots from.
> > Enabling this feature increases the performance up to +30% depending on=
 the
> > task.
> >
> > Signed-off-by: Daniel Gonz=C3=A1lez Cabanelas <dgcbueu@gmail.com>
> > Signed-off-by: =C3=81lvaro Fern=C3=A1ndez Rojas <noltari@gmail.com>
> > [ rework code and reduce code duplication ]
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > ---
> >   arch/mips/kernel/smp-bmips.c | 12 ++++++++++++
> >   1 file changed, 12 insertions(+)
> >
> > diff --git a/arch/mips/kernel/smp-bmips.c b/arch/mips/kernel/smp-bmips.=
c
> > index 6048c471b5ee..7bde6bbaa41f 100644
> > --- a/arch/mips/kernel/smp-bmips.c
> > +++ b/arch/mips/kernel/smp-bmips.c
> > @@ -617,6 +617,18 @@ void bmips_cpu_setup(void)
> >               __raw_readl(bmips_cbr_addr + BMIPS_RAC_ADDRESS_RANGE);
> >               break;
> >
> > +     case CPU_BMIPS4350:
> > +             u32 rac_addr =3D BMIPS_RAC_CONFIG_1;
> > +
> > +             if (!(read_c0_brcm_cmt_local() & (1 << 31)))
> > +                     rac_addr =3D BMIPS_RAC_CONFIG;
> > +
> > +             /* Enable data RAC */
> > +             cfg =3D __raw_readl(bmips_cbr_addr + rac_addr);
> > +             __raw_writel(cfg | 0xa, bmips_cbr_addr + rac_addr);
>
> This enables data pre-fetching (bit 3) and data-caching (bit 1), have
> you tried with 0xF to see if this provides any additional speed-up?
>
> Looks correct to me otherwise, I wonder if a flush would be in order
> right after enabling, though I did not see any specific instructions
> towards that part in the programming notes.
>
> > +             __raw_readl(bmips_cbr_addr + rac_addr);
> > +             break;
> > +
> >       case CPU_BMIPS4380:
> >               /* CBG workaround for early BMIPS4380 CPUs */
> >               switch (read_c0_prid()) {
>
> --
> Florian
>

