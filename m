Return-Path: <linux-kernel+bounces-151041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BBC98AA841
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 08:09:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5FEF1F21E14
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 06:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACD48D515;
	Fri, 19 Apr 2024 06:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="VbNi7X53"
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07BC2C127
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 06:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713506964; cv=none; b=rrNHtgH82+yyZ96cjqkL1FdlmZneCJ73qlEnXdTr65en25qJXmGCqnm9bnoO0xJefaNYlTCCMzwh/Gay3a/urue0Tdyr5ToL+UR5XGFYAs+Ca7Wop6xu4Q9I74WDPPBGgT+jlUn6vdnkZFrCwUPw4uVeUsgRvQXXRY0WWBAwOBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713506964; c=relaxed/simple;
	bh=elPfsV609mZWZMdsMAwYLpbQHMPL6SUn7OhzB1+3T1k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gLq7nY+vFwKzXkOY68+IwzdVEsl9SDpTPBDa/oKpslERPloPhYKLgbBgL+wYW/+GAEgScWvp6zBOtdLt7PeVHM40r1YlShyMBJ/BklvBchvNsnlJjjnLRSHwZN8yXcGhkOIiR2ukE6WYsyGLMIdBFBLYD1m2ytqvNg6AbMFp7kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=VbNi7X53; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-23935d89261so366129fac.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 23:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1713506961; x=1714111761; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7kErwDd2As93lkNVtXxpSNeg6N1vaOM5yfF2rI/SIas=;
        b=VbNi7X53rWtX79EOjlQGwTGaV0PdQu+Qai3Q86Gb+xdJ5A/VlK2s9vCqiPH/E9m9t2
         ShsAoadciOUnaMwPhjOPyAkdK3T7TIUVINKSuoFYs7jWbF6kdHrBxih3yaRUo+EmOyFI
         UVH3Ql8DREoEEoDI1nMoJYwJ9g3a2iFkeQSLLlaoYVPxC2JM5SFHiCakWSDv+rUS6JGi
         R3gLEV4hihEg4+Za021JzcSrEjLEyscTmqmaIpb/lPXfFQz6ibTTMaBw+fso9EaUD4o6
         YsO5IOsU8RsPuK05rc6zbImXNVVL5fSqIB1iQeS/oZYGl/FiUT/Q9YrcvPZ5A3I6RcDP
         aphg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713506961; x=1714111761;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7kErwDd2As93lkNVtXxpSNeg6N1vaOM5yfF2rI/SIas=;
        b=HuUEwBZHBeV2fd90iI6vRmQerFNEfWc/K8l4fft2ZXMnN+HIMJbY16foqsWDTOSlAX
         VrSze//L8B37U7fOsCPjo/AI5PEArOEW9UP0dPVA1ms2Tx3QZkBN8gjTG2kSze5KCiSg
         2GVK8npx+eRrgRp0d31M2AatzGAr5LZNVIlG1KyL29mMNKJ04XJhs32SXrrEqdw4DTDe
         dQNN1nMYTvQw+Jb+40+iOZwCYimyyHKbc2ojgPZI+aNZELUCiLWfGANFCVFdwurLjOiT
         Q4QLsZK5K/JqKr/h6NcHvSQ9dLPlNYTQQUZZqHLJsp4m0HkImdsJFZf3Rsvsr0b28Vz/
         8bvw==
X-Forwarded-Encrypted: i=1; AJvYcCXON5ltef7r9vQLa/iwSys86EizkvpiHt5mnRNIARhkPHEmmraik8gr9l70EeI7OPWUdbFKvzuiOt+qH5/YAFiFMYlIA3ozVh2afs39
X-Gm-Message-State: AOJu0YzstU+hVB1QEUzC67yqLOxmPF02rEKNpqnDGJ5wph7MyKIip+ZV
	NGG7a2uyQgb0V8pfaLO2zxKuFvRIJew7buE8kEcBBJRLyM4iqYCLRoYtbUoWM9Kat7NacQvS+1C
	raHXSLn0uFqvcE/CemmHqrZneLvvUXL0+pL5zuA==
X-Google-Smtp-Source: AGHT+IFiJTLnnWExlyf1jzE8UHpYFqX2X9xmHGVJevF5AC5Z2o5R2kV7+PY0ghjCFO++qBKYcDqZsz70DYQOwrd6nAc=
X-Received: by 2002:a05:6870:968e:b0:22e:7d06:d489 with SMTP id
 o14-20020a056870968e00b0022e7d06d489mr1319197oaq.19.1713506961126; Thu, 18
 Apr 2024 23:09:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240412-zve-detection-v4-0-e0c45bb6b253@sifive.com> <20240412-zve-detection-v4-2-e0c45bb6b253@sifive.com>
In-Reply-To: <20240412-zve-detection-v4-2-e0c45bb6b253@sifive.com>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Fri, 19 Apr 2024 14:09:10 +0800
Message-ID: <CAEEQ3wn97huwhpvTJH7kD2R=xagNRWd=YcoYwGOU17BRYNopgw@mail.gmail.com>
Subject: Re: [External] [PATCH v4 2/9] riscv: smp: fail booting up smp if
 inconsistent vlen is detected
To: Andy Chiu <andy.chiu@sifive.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Conor Dooley <conor.dooley@microchip.com>, 
	Heiko Stuebner <heiko@sntech.de>, Guo Ren <guoren@kernel.org>, Conor Dooley <conor@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Jonathan Corbet <corbet@lwn.net>, Evan Green <evan@rivosinc.com>, 
	=?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>, 
	Shuah Khan <shuah@kernel.org>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>, 
	Vincent Chen <vincent.chen@sifive.com>, Greentime Hu <greentime.hu@sifive.com>, 
	devicetree@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andy,

On Fri, Apr 12, 2024 at 2:50=E2=80=AFPM Andy Chiu <andy.chiu@sifive.com> wr=
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
> Changelog v4:
>  - update comment also in the assembly code (Yunhui)
> Changelog v2:
>  - update commit message to explain asm code change (Conor)
> ---
>  arch/riscv/kernel/head.S    | 19 ++++++++++++-------
>  arch/riscv/kernel/smpboot.c | 14 +++++++++-----
>  2 files changed, 21 insertions(+), 12 deletions(-)
>
> diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
> index 4236a69c35cb..a00f7523cb91 100644
> --- a/arch/riscv/kernel/head.S
> +++ b/arch/riscv/kernel/head.S
> @@ -165,9 +165,20 @@ secondary_start_sbi:
>  #endif
>         call .Lsetup_trap_vector
>         scs_load_current
> -       tail smp_callin
> +       call smp_callin
>  #endif /* CONFIG_SMP */
>
> +.align 2
> +.Lsecondary_park:
> +       /*
> +        * Park this hart if we:
> +        *  - have too many harts on CONFIG_RISCV_BOOT_SPINWAIT
> +        *  - receive an early trap, before setup_trap_vector finished
> +        *  - fail in smp_callin(), as a successful one wouldn't return
> +        */
> +       wfi
> +       j .Lsecondary_park
> +
>  .align 2
>  .Lsetup_trap_vector:
>         /* Set trap vector to exception handler */
> @@ -181,12 +192,6 @@ secondary_start_sbi:
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
> index d41090fc3203..673437ccc13d 100644
> --- a/arch/riscv/kernel/smpboot.c
> +++ b/arch/riscv/kernel/smpboot.c
> @@ -214,6 +214,15 @@ asmlinkage __visible void smp_callin(void)
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
> @@ -226,11 +235,6 @@ asmlinkage __visible void smp_callin(void)
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

Reviewed-by: Yunhui Cui <cuiyunhui@bytedance.com>


Thanks,
Yunhui

