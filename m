Return-Path: <linux-kernel+bounces-134974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F64589B97D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 09:58:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F5CBB23765
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 07:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CA093BBDB;
	Mon,  8 Apr 2024 07:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vrull.eu header.i=@vrull.eu header.b="Vx4wz2/Q"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014453BB22
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 07:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712562962; cv=none; b=E87GrYFET6Om2PaJvkYESZ8FoqK5PwxWy0Mxz0JvyTiL7T4wxnBW4Ur99LLr/9Qz3Y5orvW7S7wBqCM4Zne1jE197JqwCBZtGBrH12WJT6mGiXjNa50osu2vO0upWKn4PU3wAtzSofWZzIkY2NRoO71CJoAIw+hIRqXfeG2TPDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712562962; c=relaxed/simple;
	bh=QDieFEMTAi3BXAc8LDi2B4/3OA+nDSDp4zOcCNhubug=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KLmP/npzg08FSCMfra8PR9wo294i/PXVTyRQdDhklC14kjLqLf663BoZe40KaLpViQTOuxZg9yFgC+o+5X7X7OoQRuOJlPZgolO6XuMYJ0ChZ2U9v47ji9uWzxoIn/JxQPszcVfEURi6uukmZJJSdzm2PTWyIP8o2aXoT0KOJ68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vrull.eu; spf=pass smtp.mailfrom=vrull.eu; dkim=pass (2048-bit key) header.d=vrull.eu header.i=@vrull.eu header.b=Vx4wz2/Q; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vrull.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vrull.eu
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-5d8ddbac4fbso3394098a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 00:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vrull.eu; s=google; t=1712562960; x=1713167760; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HlRAgbUK4c4fePugXsYs1YBYiCmPZ//5mHvUyF++Wpg=;
        b=Vx4wz2/QuI5qMx/JHvQi/WCbCmevBOuhOLh3VGZqGSCU8fyaRiX06JDAtG4w4f8t4Z
         FVNvmm0mJWPHovU4l5bAyqsKxeqyyRnb0xTgMSVd/lpWajJLjOsWQSpuTjzrl73U3AaK
         MyL/OZe6B+7LlJNJc0xTILDnhUnGfdtH01dBgcuHG6FeJc+HnFP+GXbsoqtHMMnNBJQc
         Tjt6rV9Xds74qONu25l+Vl6Su0KkTrDek/Burs/2qwu6btuUfic5pDn81LZhTNRjlo2j
         yqUd9kx4y9a5sqenLvwcHrAjIbADeJzUu4bOf7ouGQvfItHmlUxjqpO4EEyrkKOeeOqe
         cXCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712562960; x=1713167760;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HlRAgbUK4c4fePugXsYs1YBYiCmPZ//5mHvUyF++Wpg=;
        b=u9M5BpGQdum4dyB1fVE7Whs5BEglJ5abztolaSCQZhGspAZ8xtpOqkXb9LlzRmFRhv
         i93kBr0EN3jCoaEpDqvCcj5XOERFsi/mDdE/BNy6ZiIN1R1W7c4eW4D67T8oXo6LHQbH
         z+xAenbicOV0xHT3iuBdhdkn/MSrb/6pD0m4NRZ0YYRJiiuG8x1dg/+DEqXBPONE2RPy
         rZnK26D9YUwjJhHcAvQEkBgpheH7/ZAmcbrYwL2U98XqeB8vFn/Q3M3rRx8WY8EIMHEK
         Q/T22OLVbfhGbGZzRcBTy+YTnYvwU1CBr7tCVMPikMyHRuz9cBxONU1n96NcYcEnWqw3
         1/Ag==
X-Forwarded-Encrypted: i=1; AJvYcCXzLOIH0qxvEJme+8mC3uGxQgDqFXKNNWIAzlxmmY/9J6ZLQRJQMHf4jUpAo/bggWSygeB3QFEpTb+9JWobhL4zUHuMkN/9uVhSEzWX
X-Gm-Message-State: AOJu0YyOlAFNegdc2+k20uM95IVeRcSg91tKI/R9CtRAnMsq42VpAYgj
	3x2RgOkkqom1EJGTNOgX2urh8jcNBUDeO0hGBax8Kmdc0MsZjP1P74rtspglsHDuYJdT9SFEnCo
	cXUQp4PGpW1xL4ZbDeTO1JFKmUV3f3q3aFicusQ==
X-Google-Smtp-Source: AGHT+IFGXH9CgjzygL7g3RDaOsqnAK33JqVcOhvpwIdCpz6B+gc9aLg3nRsdV3kEWWplMIgXfa25m+7yEXgutZ/dNUQ=
X-Received: by 2002:a17:90a:1307:b0:2a2:b097:dabc with SMTP id
 h7-20020a17090a130700b002a2b097dabcmr7611521pja.31.1712562960261; Mon, 08 Apr
 2024 00:56:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240407213236.2121592-3-christoph.muellner@vrull.eu>
 <tencent_CF232CDF85208DF6BFA3076E73CC4E087306@qq.com> <CAEg0e7h0F_LaeMoS6Co1UjgLM6ML8SXtTfHW5+OQS6yedjdZPQ@mail.gmail.com>
 <tencent_459BC09115173E0624A4A0F19D2F43704F05@qq.com>
In-Reply-To: <tencent_459BC09115173E0624A4A0F19D2F43704F05@qq.com>
From: =?UTF-8?Q?Christoph_M=C3=BCllner?= <christoph.muellner@vrull.eu>
Date: Mon, 8 Apr 2024 09:55:48 +0200
Message-ID: <CAEg0e7jW=Sfc3tcc0eJwbTx=vb0HM49ZWpda972E-t=Fj1PG+g@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] riscv: T-Head: Test availability bit before
 enabling MAE errata
To: Yangyu Chen <cyy@cyyself.name>
Cc: ajones@ventanamicro.com, alex@ghiti.fr, alistair.francis@wdc.com, 
	Albert Ou <aou@eecs.berkeley.edu>, bjorn@kernel.org, 
	Conor Dooley <conor.dooley@microchip.com>, Conor Dooley <conor@kernel.org>, 
	cooper.qu@linux.alibaba.com, dbarboza@ventanamicro.com, 
	Qingfang Deng <dqfext@gmail.com>, eric.huang@linux.alibaba.com, heiko@sntech.de, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, philipp.tomsich@vrull.eu, 
	samuel.holland@sifive.com, zhiwei_liu@linux.alibaba.com, 
	Guo Ren <guoren@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 8, 2024 at 9:37=E2=80=AFAM Yangyu Chen <cyy@cyyself.name> wrote=
:
>
>
>
> > On Apr 8, 2024, at 14:00, Christoph M=C3=BCllner <christoph.muellner@vr=
ull.eu> wrote:
> >
> > On Mon, Apr 8, 2024 at 3:58=E2=80=AFAM Yangyu Chen <cyy@cyyself.name> w=
rote:
> >>
> >> On 2024/4/8 05:32, Christoph M=C3=BCllner wrote:
> >>> T-Head's memory attribute extension (XTheadMae) (non-compatible
> >>> equivalent of RVI's Svpbmt) is currently assumed for all T-Head harts=
.
> >>> However, QEMU recently decided to drop acceptance of guests that writ=
e
> >>> reserved bits in PTEs.
> >>> As XTheadMae uses reserved bits in PTEs and Linux applies the MAE err=
ata
> >>> for all T-Head harts, this broke the Linux startup on QEMU emulations
> >>> of the C906 emulation.
> >>>
> >>> This patch attempts to address this issue by testing the MAE-enable b=
it
> >>> in the th.sxstatus CSR. This CSR is available in HW and can be
> >>> emulated in QEMU.
> >>>
> >>> This patch also makes the XTheadMae probing mechanism reliable, becau=
se
> >>> a test for the right combination of mvendorid, marchid, and mimpid
> >>> is not sufficient to enable MAE.
> >>>
> >>> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> >>> Signed-off-by: Christoph M=C3=BCllner <christoph.muellner@vrull.eu>
> >>> ---
> >>>  arch/riscv/errata/thead/errata.c | 14 ++++++++++----
> >>>  1 file changed, 10 insertions(+), 4 deletions(-)
> >>>
> >>> diff --git a/arch/riscv/errata/thead/errata.c b/arch/riscv/errata/the=
ad/errata.c
> >>> index 6e7ee1f16bee..bf6a0a6318ee 100644
> >>> --- a/arch/riscv/errata/thead/errata.c
> >>> +++ b/arch/riscv/errata/thead/errata.c
> >>> @@ -19,6 +19,9 @@
> >>>  #include <asm/patch.h>f
> >>>  #include <asm/vendorid_list.h>
> >>>
> >>> +#define CSR_TH_SXSTATUS              0x5c0
> >>> +#define SXSTATUS_MAEE                _AC(0x200000, UL)
> >>> +
> >>>  static bool errata_probe_mae(unsigned int stage,
> >>>                           unsigned long arch_id, unsigned long impid)
> >>>  {
> >>> @@ -28,11 +31,14 @@ static bool errata_probe_mae(unsigned int stage,
> >>>      if (arch_id !=3D 0 || impid !=3D 0)
> >>>              return false;
> >>>
> >>
> >> I would raise a little concern about keeping this "if" statement for
> >> arch_id and imp_id after we have probed it in this CSR way. I would li=
ke to
> >> remove it and move the CSR probe earlier than RISCV_ALTERNATIVES.
> >>
> >> I added CC to guoren for more opinions.
> >>
> >> Even T-Head C908 comes in 2023, which supports RVV 1.0 and also keeps =
MAEE.
> >> But it also supports Svpbmt, and we can perform the switch by clearing=
 the
> >> MAEE bit in CSR_TH_MXSTATUS in M-Mode Software.
> >>
> >> Moreover, T-Head MAEE may not be removed in the future of T-Head CPUs.=
 We
> >> can see something from the T-Head C908 User Manual that adds a Securit=
y bit
> >> to MAEE. So, it might used in their own TEE implementation and will no=
t be
> >> removed.
> >>
> >> However, C908 has arch_id and impid, which are not equal to zero. You =
can
> >> see it from the C908 boot log [2] from my patch to support K230 [3]. S=
o, if
> >> we have probed MAEE using CSR, you confirmed that this bit will also b=
e set
> >> in the C906 core. We can only probe it this way and no longer use arch=
_id
> >> and imp_id. And if the arch_id and imp_id probes get removed, we shoul=
d
> >> also move the csr probe earlier than riscv alternatives.
> >
> > We keep the probing via arch_id=3D=3D0&&impid=3D=3D0 because we had tha=
t
> > already in the kernel and don't want to break existing functionality.
> >
> > From the discussions that we had about the v1 and v2 of this series,
> > my impression is that we should use DT properties instead of probing
> > arch_id and impid. So, if C908 support is needed, this should probably
> > be introduced using DT properties. The logic would then be:
> > * if arch_id =3D=3D 0 and impid =3D=3D 0 then decide based on th.sxstat=
us.MAEE
> > * else test if "xtheadmae" is in the DT
> >
> >
>
> I know about it, and Conor also mentioned adding this property to DT a fe=
w
> months ago. I agree with this at that time. But for now, you have found t=
he
> T-Head document description about this, and we can probe MAE using CSR ev=
en
> on C906. I think only probing in CSR will be a better way to do that. It
> can maintain compatibility with some early cores, such as C906. And will
> also support some new cores with non-zero arch_id and impl_id but may hav=
e
> MAE enabled, such as C908.
>
> For future concerns, T-Head said from their documentation that
> "Availability: The th.sxstatus CSR is available on all systems whose
> mvendorid CSR holds a value of 0x5B7." [1] and this extension is frozen a=
nd
> stable. I think it's okay to have MAE errara for some cpus whose impl_id
> and arch_id are non-zero. And T-Head may have used this for their TEE, so
> it might never be removed.

I wrote that specification. And yes, T-Head reviewed that part.
But there is no guarantee for future cores.

The question is: why should the kernel have to care about that?
This can all be addressed (hidden) in FW, where core-specific
routines can test the required bits in vendor CSRs and set DT properties
that match the core's configuration.

> Since it might never be removed, if some vendor uses it and makes it hard
> to run the mainline kernel since it requires setting CSR in M-Mode softwa=
re
> or changing the DT, they may be hard to change for some security reasons
> for TEE, I think it's not right.
>
> I'm also waiting for Conor's opinion about this.
>
> [1] https://github.com/T-head-Semi/thead-extension-spec/blob/master/xthea=
dsxstatus.adoc
>
> Thanks,
> Yangyu Chen
>
> >
> >
> >>
> >> [1] https://occ-intl-prod.oss-ap-southeast-1.aliyuncs.com/resource//16=
99268369347/XuanTie-C908-UserManual.pdf
> >> [2] https://gist.github.com/cyyself/b9445f38cc3ba1094924bd41c9086176
> >> [3] https://lore.kernel.org/linux-riscv/tencent_D1180541B4B31C0371DB63=
4A42681A5BF809@qq.com/
> >>
> >> Thanks,
> >> Yangyu Chen
> >>
> >>> -     if (stage =3D=3D RISCV_ALTERNATIVES_EARLY_BOOT ||
> >>> -         stage =3D=3D RISCV_ALTERNATIVES_MODULE)
> >>> -             return true;
> >>> +     if (stage !=3D RISCV_ALTERNATIVES_EARLY_BOOT &&
> >>> +         stage !=3D RISCV_ALTERNATIVES_MODULE)
> >>> +             return false;
> >>>
> >>> -     return false;
> >>> +     if (!(csr_read(CSR_TH_SXSTATUS) & SXSTATUS_MAEE))
> >>> +             return false;
> >>> +
> >>> +     return true;
> >>>  }
> >>>
> >>>  /*
> >>
>

