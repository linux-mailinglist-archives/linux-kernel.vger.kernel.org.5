Return-Path: <linux-kernel+bounces-150461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D256C8A9FBF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 18:13:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8895628523D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 16:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 943B916F8EC;
	Thu, 18 Apr 2024 16:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="jDdf8fco"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15B223D7
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 16:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713456782; cv=none; b=FhdBJa4saOyVCHdxe/hpoxLgt/hcfFAvVUkDMxbuamd4ryAjZlYrw04Zp+CnFyr603wobMXd1Y+OQa3KEhD4cqIciKG5GZMyib4ixa8RSENagCnAmA4gRdTiRCAAjILVKs5pL/mwo1pB183j4ccfgwrVYX5r5xyOxWDJ2XakrcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713456782; c=relaxed/simple;
	bh=7O5CaiYMx3o81DATDCx+mdTRxyfXstzYIysSrKy8ixI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=utOtU7iliGhkk6vvXScoYuWEr9ZuePEsc7LcHQ+Kgj86OgIBBSYveyXvnLnF2eihHo7SRW5tBZ0RHoseFctXWCA+zPnKZ0LaYWhubQnSESLk0nKp1jDWxsAUCXCEr1xW5K7aMHNzcbEXS/pZQCsoyhtPr45oZjcQYYARPgFQZ0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=jDdf8fco; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2a7e19c43faso818537a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 09:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1713456780; x=1714061580; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/WYegnjNIT6ITUxIPv0/Q8MWBXWcokuDnEdLFw52f4Y=;
        b=jDdf8fcoxdYv1zIvWActMsrWTBqzfgWUVi8QW4kpIpkCy7zKx3jpTxqnoTpzQaP0n0
         cXMbS846m1O0KLEMkJPluKwyG6Pa7uQnpPTpN9/kLh30ObqWscVjpBrZ0HN3+t7gJE5o
         ASLUQvBrWXTAOz0BnANv8evlGN+3Cv3/dJO7NyzfD58orvcSoBk0G3H6X2U6DuCTwI7u
         MD4ULmnTkz21lWz1p1/zkLQVWMkRQvUA3bd6UB22z/k6Nn2u7vTd63xBBJWlZgiHR/ld
         Wvtl+qUGThRxbod+DZPaqenFEnUhq69lGSj9FlMfakTgRBFc++8NnJe92hrqZEhVJOku
         uGpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713456780; x=1714061580;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/WYegnjNIT6ITUxIPv0/Q8MWBXWcokuDnEdLFw52f4Y=;
        b=OQnx7Vxm2reKxnpeLaorXatjObodpLfpB3pbcHhNtWzAtWV/yUzbR79+Q6qeV1utzf
         6sv/s5pmjG1XutCUYNq+zBdykJnmXg/VUUPNML9VXcdcSAwkUGNHa8JJol5PwFGg65NI
         0bdgnEXxNPfuCElFB4xq4tIkj+rYjjUv3QLqDW9y4Oug64mIAXkUeT3KkkS8SsxycVSi
         T5PgcOrxqdHUrgbabKHEf7O+x+zIt3yCQYHjmJ3TQc5zdoqvApcATexL7psDbcQc0Re1
         xa2y3uxgPkIf87PhLhinEwuVcgIzvVqSF42XwfIJbinrVxLhvzGLtMkRG2mXCEe2qP/M
         LLRg==
X-Forwarded-Encrypted: i=1; AJvYcCUyHrQy0Lv+8fcCp15FNt2jUiMdXQg/zoXWdJ93YOQUAjW8XoitU9EY5Ek0ujOVmL2n3m9lJ/4rQu48oax4eohmhKoGlnJ22dWeChX1
X-Gm-Message-State: AOJu0Yx4mCL29YbEjAeSfS2ijcFkxP3oHZW/4T5quj3OqyBU+H5DOaSW
	MpwkF04/+qIAa+2BsiMj/w3tc7AlNY0g+SyZhGvZvpC+fV7PRzJC/ZDf9XYiNoiImWLPClez44O
	vdZC2FVLhjd4x0lvJcQOhNgIxU8F6I+xWl7mobg==
X-Google-Smtp-Source: AGHT+IE540tIbatlzBLLRdYDFdE/gaEn76X4nIZPEK27zBxxh80jC+Hni9udU6puJgxg5fEqmSDfdWteIZhb/AFmz3M=
X-Received: by 2002:a17:90b:4c92:b0:2a5:395e:8673 with SMTP id
 my18-20020a17090b4c9200b002a5395e8673mr3284250pjb.5.1713456779903; Thu, 18
 Apr 2024 09:12:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240418114942.52770-1-luxu.kernel@bytedance.com>
 <20240418114942.52770-2-luxu.kernel@bytedance.com> <20240418-dove-deferral-2b01100e13ca@spud>
In-Reply-To: <20240418-dove-deferral-2b01100e13ca@spud>
From: Xu Lu <luxu.kernel@bytedance.com>
Date: Fri, 19 Apr 2024 00:14:47 +0800
Message-ID: <CAPYmKFsddST1n2ZU+5=c_yPqAKTjQ4X1mKVFMZbhfo8xiB+OTA@mail.gmail.com>
Subject: Re: [External] Re: [RFC 1/2] riscv: process: Introduce idle thread
 using Zawrs extension
To: Conor Dooley <conor@kernel.org>
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	andy.chiu@sifive.com, guoren@kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, lihangjing@bytedance.com, 
	dengliang.1214@bytedance.com, xieyongji@bytedance.com, 
	chaiwen.cc@bytedance.com, Andrew Jones <ajones@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 18, 2024 at 11:06=E2=80=AFPM Conor Dooley <conor@kernel.org> wr=
ote:
>
> + Drew,
>
> On Thu, Apr 18, 2024 at 07:49:41PM +0800, Xu Lu wrote:
> > The Zawrs extension introduces a new instruction WRS.NTO, which will
> > register a reservation set and causes the hart to temporarily stall
> > execution in a low-power state until a store occurs to the reservation
> > set or an interrupt is observed.
> >
> > This commit implements new version of idle thread for RISC-V via Zawrs
> > extension.
> >
> > Signed-off-by: Xu Lu <luxu.kernel@bytedance.com>
> > Reviewed-by: Hangjing Li <lihangjing@bytedance.com>
> > Reviewed-by: Liang Deng <dengliang.1214@bytedance.com>
> > Reviewed-by: Wen Chai <chaiwen.cc@bytedance.com>
> > ---
> >  arch/riscv/Kconfig                 | 24 +++++++++++++++++
> >  arch/riscv/include/asm/cpuidle.h   | 11 +-------
> >  arch/riscv/include/asm/hwcap.h     |  1 +
> >  arch/riscv/include/asm/processor.h | 17 +++++++++++++
> >  arch/riscv/kernel/cpu.c            |  5 ++++
> >  arch/riscv/kernel/cpufeature.c     |  1 +
> >  arch/riscv/kernel/process.c        | 41 +++++++++++++++++++++++++++++-
> >  7 files changed, 89 insertions(+), 11 deletions(-)
> >
> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > index be09c8836d56..a0d344e9803f 100644
> > --- a/arch/riscv/Kconfig
> > +++ b/arch/riscv/Kconfig
> > @@ -19,6 +19,7 @@ config RISCV
> >       select ARCH_ENABLE_SPLIT_PMD_PTLOCK if PGTABLE_LEVELS > 2
> >       select ARCH_ENABLE_THP_MIGRATION if TRANSPARENT_HUGEPAGE
> >       select ARCH_HAS_BINFMT_FLAT
> > +     select ARCH_HAS_CPU_FINALIZE_INIT
> >       select ARCH_HAS_CURRENT_STACK_POINTER
> >       select ARCH_HAS_DEBUG_VIRTUAL if MMU
> >       select ARCH_HAS_DEBUG_VM_PGTABLE
> > @@ -525,6 +526,20 @@ config RISCV_ISA_SVPBMT
> >
> >          If you don't know what to do here, say Y.
> >
> > +config RISCV_ISA_ZAWRS
> > +     bool "Zawrs extension support for wait-on-reservation-set instruc=
tions"
> > +     depends on RISCV_ALTERNATIVE
> > +     default y
> > +     help
> > +        Adds support to dynamically detect the presence of the Zawrs
> > +        extension and enable its usage.
>
> Drew, could you, in your update, use the wording:
>            Add support for enabling optimisations in the kernel when the
>            Zawrs extension is detected at boot.
>
> There was some confusion recently about what these options were actually
> for, because this option doesn't control "dynamic detection" as the
> ACPI or DT detection is compiled at all times. I had written a patch for
> this wording in other options at the time but had forgotten to properly
> send it:
> https://lore.kernel.org/linux-riscv/20240418-stable-railway-7cce07e1e440@=
spud/T/#u
>
> > +
> > +        The Zawrs extension defines a pair of instructions to be used
> > +        in polling loops that allows a core to enter a low-power state
> > +        and wait on a store to a memory location.
> > +
> > +        If you don't know what to do here, say Y.
> > +
> >  config TOOLCHAIN_HAS_V
> >       bool
> >       default y
> > @@ -1075,6 +1090,15 @@ endmenu # "Power management options"
> >
> >  menu "CPU Power Management"
> >
> > +config RISCV_ZAWRS_IDLE
> > +     bool "Idle thread using ZAWRS extensions"
> > +     depends on RISCV_ISA_ZAWRS
> > +     default y
> > +     help
> > +             Adds support to implement idle thread using ZAWRS extensi=
on.
> > +
> > +             If you don't know what to do here, say Y.
>
> I don't think this second option is needed, why would we not always want
> to use the Zawrs version of this when it is available? Can we do it
> unconditionally when RISCV_ISA_ZAWRS is set and the extension is
> detected at runtime?
>
> Cheers,
> Conor.

Indeed, we can always choose WRS.NTO when entering idle.

This config is introduced for the second commit in this patch series.
In the second commit, we detect whether the target cpu is idle when
sending IPI and write IPI info to the reserve set of idle cpu so as to
avoid sending a physical IPI. Besides, the target idle cpu need not to
go through traditional interrupt handling routine. However, if all
cpus are busy and hardly enter idle, this commit may introduce
performance overhead of extra instructions when sending IPI. Thus we
introduce this config just in case.

Regards,
Xu Lu

>
>

