Return-Path: <linux-kernel+bounces-108689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2A8E880E86
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 10:26:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADC701C20FDF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 09:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6439239AC7;
	Wed, 20 Mar 2024 09:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ak714nlQ"
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A753985A
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 09:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710926792; cv=none; b=T7SX3hf4yx+swE01BQ7oaBTUmHnSfTGKiNOu8eQpcugrOHX9bcirQKIgypxjhamOja9Hs2GgyDreqBlUvjxIaiBIJauD/dzxhCS//jYIa90Xy751h9AVX1nsk9d3AVfXobA+PdVCvhmhAlA4UTtO+ti5Vi40Lf8Oa1AhTOLXml8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710926792; c=relaxed/simple;
	bh=MfL/BPIO8j35wTci6CyzvMsrqWMQO8DyRGDFT7rsa10=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qKl0u3JC7XJypr6lU4n2Z/TGhzpT22no+9kazKiHeuPcAV1pmbt3wc3QDxQI+TlBu9ZNirMZiHXy4jj+na0Qv5iluPLjAYUT97vbMLKNwGbjc7b7p6k98H4WdmUjsfi3AEEIFErwfK+K91U2mnk0LA/NMdyi8sVCc5TH/QqBxPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=ak714nlQ; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-2222b96e4d2so3864591fac.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 02:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1710926790; x=1711531590; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wqg1Bd1Azr4G+6Sz9Ni1RmpJSEG5+j5GzmKPVhSgSGE=;
        b=ak714nlQoYu+PFdULczADyD8Z5TP4TzXQpll558RWvc9ySasT1buCsK1yfA3tzg4Df
         9a48RwCZ94rFUK5I1PdK5hDtd4/LKc/viBPJ8b0FJsOK5NIXuL0cnhLYJsTSUxU/F/FI
         oVowb5hPZ7g5z92d//BnZPOxuSgFDeJ/bRJ39dVkFe5cfvC+FEwbnBgvj/NvBVqnBRXV
         nyXa743Gc1Jqh9NbmjCXUWD3MBsY9gWAKPT0xiV8BS1kHvSZ7r1zogw3rI1p/a6JYDGa
         Z/WaqCqrRzU+VEBUnT2xuldyTlPo0pjEJKilzl77brs9mhz/lKQ/H5/NvXZKaKtXvxxa
         p6FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710926790; x=1711531590;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wqg1Bd1Azr4G+6Sz9Ni1RmpJSEG5+j5GzmKPVhSgSGE=;
        b=ukV6/c+w947hUUPsnymFT6vzLqVEF3nw7uNPeJ5xW7MeRkFM53WNiYLZfbZ+K78FYZ
         oQBRkvhD5GjPV/jNIksN1KXEAlJ+b/5T1/2EcKvDwD1VjFe6sdeQh1YLAquWQQh7x0f/
         xtrc9LvJaax/t/M0ZeHOvd0jG/RXfEUuu9I12NKbpyVZbiAwwlID+GBswbVKwQ46octu
         yk2E5zjZYwvPBmxRbVLv4MqW4rJpfBns3bmHh0HuMoIpj3dbO3EBGuPSKPMqpbDqOtzK
         ZuXggyi/LM1CBQTHqtY3TCOKq06pMd6+hwBjaL2XvHPSWip8/6Ls/Gw5NxN02UZVtIfj
         gn9g==
X-Forwarded-Encrypted: i=1; AJvYcCW+7vUlqS616bi/2D3jDC5eOMa6PkgS+LUwITm4PJc9RajzmPmlq1mkNtpNfp00pFgKJcoljE/fdPIO8kuPluz6yfLizmhtPyntnUMB
X-Gm-Message-State: AOJu0Yym2hknWFZWsAY83CCJJVPcf+92pAI2CpZA/3T5aKPX3Rj4RGbC
	7+rq3GcDzDKXJIGpfXpQDIkRn6d7f1YfoKGbR6yiDEi8vh4UFQY9nnUX/vGYcze6nTzrwf09TcD
	+1MyvGHOsa5iMWNc+q9PZimJrPI5ip7R6alV+kA==
X-Google-Smtp-Source: AGHT+IE8aYZ5bG6wSgxZaZS6rRpkFMqmPyeQj/o6j2TMk5GVEJO2WU2vuEWw9SNt63mCQzdymn2q8KqnE3GuTtt3fDM=
X-Received: by 2002:a05:6870:c34c:b0:222:b47b:36fd with SMTP id
 e12-20020a056870c34c00b00222b47b36fdmr5505043oak.45.1710926790147; Wed, 20
 Mar 2024 02:26:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240318-zve-detection-v3-0-e12d42107fa8@sifive.com> <20240318-zve-detection-v3-2-e12d42107fa8@sifive.com>
In-Reply-To: <20240318-zve-detection-v3-2-e12d42107fa8@sifive.com>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Wed, 20 Mar 2024 17:26:19 +0800
Message-ID: <CAEEQ3wncGPZ8W5ZnGW=by4UZFwS5f_4BrfEJn8a2fe9F-0uB-w@mail.gmail.com>
Subject: Re: [External] [PATCH v3 2/7] riscv: smp: fail booting up smp if
 inconsistent vlen is detected
To: Andy Chiu <andy.chiu@sifive.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Vincent Chen <vincent.chen@sifive.com>, 
	Heiko Stuebner <heiko@sntech.de>, Conor Dooley <conor.dooley@microchip.com>, 
	Conor Dooley <conor@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Jonathan Corbet <corbet@lwn.net>, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Palmer Dabbelt <palmer@rivosinc.com>, Greentime Hu <greentime.hu@sifive.com>, 
	Guo Ren <guoren@kernel.org>, devicetree@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andy,

On Mon, Mar 18, 2024 at 6:40=E2=80=AFPM Andy Chiu <andy.chiu@sifive.com> wr=
ote:
>
> Currently we only support Vector for SMP platforms, that is, all SMP
> cores have the same vlenb. If we happen to detect a mismatching vlen, it
> is better to just fail bootting it up to prevent further race/scheduling
> issues.
>
> Also, move .Lsecondary_park forward and chage `tail smp_callin` into a
> regular call in the early assembly. So a core would be parked right
> after a return from smp_callin. Note that a successful smp_callin
> does not return.
>
> Fixes: 7017858eb2d7 ("riscv: Introduce riscv_v_vsize to record size of Ve=
ctor context")
> Reported-by: Conor Dooley <conor.dooley@microchip.com>
> Closes: https://lore.kernel.org/linux-riscv/20240228-vicinity-cornstalk-4=
b8eb5fe5730@spud/
> Signed-off-by: Andy Chiu <andy.chiu@sifive.com>
> ---
> Changelog v2:
>  - update commit message to explain asm code change (Conor)
> ---
>  arch/riscv/kernel/head.S    | 14 +++++++-------
>  arch/riscv/kernel/smpboot.c | 14 +++++++++-----
>  2 files changed, 16 insertions(+), 12 deletions(-)
>
> diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
> index 4236a69c35cb..a158fa9f2656 100644
> --- a/arch/riscv/kernel/head.S
> +++ b/arch/riscv/kernel/head.S
> @@ -165,9 +165,15 @@ secondary_start_sbi:
>  #endif
>         call .Lsetup_trap_vector
>         scs_load_current
> -       tail smp_callin
> +       call smp_callin
>  #endif /* CONFIG_SMP */
>
> +.align 2
> +.Lsecondary_park:
> +       /* We lack SMP support or have too many harts, so park this hart =
*/

It is best to modify the comments here, instead of "lack SMP support..."


> +       wfi
> +       j .Lsecondary_park
> +
>  .align 2
>  .Lsetup_trap_vector:
>         /* Set trap vector to exception handler */
> @@ -181,12 +187,6 @@ secondary_start_sbi:
>         csrw CSR_SCRATCH, zero
>         ret
>
> -.align 2
> -.Lsecondary_park:
> -       /* We lack SMP support or have too many harts, so park this hart =
*/
> -       wfi
> -       j .Lsecondary_park
> -
>  SYM_CODE_END(_start)
>
>  SYM_CODE_START(_start_kernel)
> diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
> index cfbe4b840d42..1f86ee10192f 100644
> --- a/arch/riscv/kernel/smpboot.c
> +++ b/arch/riscv/kernel/smpboot.c
> @@ -218,6 +218,15 @@ asmlinkage __visible void smp_callin(void)
>         struct mm_struct *mm =3D &init_mm;
>         unsigned int curr_cpuid =3D smp_processor_id();
>
> +       if (has_vector()) {
> +               /*
> +                * Return as early as possible so the hart with a mismatc=
hing
> +                * vlen won't boot.
> +                */
> +               if (riscv_v_setup_vsize())
> +                       return;
> +       }
> +
>         /* All kernel threads share the same mm context.  */
>         mmgrab(mm);
>         current->active_mm =3D mm;
> @@ -230,11 +239,6 @@ asmlinkage __visible void smp_callin(void)
>         numa_add_cpu(curr_cpuid);
>         set_cpu_online(curr_cpuid, 1);
>
> -       if (has_vector()) {
> -               if (riscv_v_setup_vsize())
> -                       elf_hwcap &=3D ~COMPAT_HWCAP_ISA_V;
> -       }
> -
>         riscv_user_isa_enable();
>
>         /*
>
> --
> 2.44.0.rc2
>
>

Thanks,
Yunhui

