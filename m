Return-Path: <linux-kernel+bounces-106975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17EE387F633
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 04:54:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4802F1C21C7D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 03:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32DCE7BB13;
	Tue, 19 Mar 2024 03:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jcyxTowY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703A97BAF7
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 03:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710820472; cv=none; b=CTB+wCfjJ/Zgfu6wdpLvGmYLgushIxlptxI6KyGFj71DpUBrN1X1Es5WR+WgO2+6u5VqaVGdXbGVd0ALzO1/VghtBAiw7fJDBHM3ZfnuVwP/kkoIkYstRIHOyPgknYniwUiqpYrCJC72rUUlXvpkkXvu66TXqomGktgnyEwlgjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710820472; c=relaxed/simple;
	bh=/XkrawLqG2i47PS72vOgp+3FbB6mD7ygQqFf/7AMfjw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H6l/NcrzMoyCgERuUTtHxjIGv108RXMh/LlL5U2VhHKvk4feaz5k2V8dw/Ho2QVrMr2R9rFxh1erGrqzRqe5ZEKp/QGUWXef5Ph3Bs1TfRrLrhwkbHyLY+66fme3QCxqejDUu4ge0rgjQuExmwDus4/dmIrMmEBQCcruzECbgyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jcyxTowY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D53EEC43394
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 03:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710820470;
	bh=/XkrawLqG2i47PS72vOgp+3FbB6mD7ygQqFf/7AMfjw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=jcyxTowYYzfrv4rpE0FqqexZohD/qnSrpgxqXaF/gpAt/03gHwAvDD90PTE8yWe3R
	 0kEPFDGtKioXB/mM4BsAgcTxonG2ZDAAT7rtKxD5haafvtL2eaMPC1c0k6vSuvk1jB
	 CrRZekiBRqi6HkRED/x66q2+Ju/GS24+VGW/NHvBkI3vXyEqeXD6ZQEyVi0jOQ/NNC
	 D77pDqnuzrzYfVN7vkifhvRS68XiTjUqdxT0Y6HriXR05AgRRizNuuWLN8xMTpfJCh
	 /DnYX8kj6wa2yb5SjRoKB6o3FO7aFN+IAyhXIkuMxIXpVeO54vKnTuxSWpG+SkxXnt
	 suLNbuPVBJoKw==
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-566e869f631so5728888a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 20:54:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUIMrhDa4f3C9FneELBR0m584pH/zLhqS3q1nSVE0YV1Dy9bB1HUjWB80sbNV2ql6SI+AXh2Fk79XwjyYtS0eHcG7QG2Fp39zrWs8+P
X-Gm-Message-State: AOJu0YwKivXkpK2kdn8hL//SUir4fvev82RSplAalXsaHlvqh4WLolnR
	9Fy6cp2PeRsKJC7l7l7JYRHg9j5uWBvu+0MR6EipJSefEFDGlayvaovJMbdtA1Z4VN1y28FHV1n
	iZ0gCwPM6hWCrjBjBjEehyCOb8h0=
X-Google-Smtp-Source: AGHT+IHULGVOK33jSlydOXp0yUv+oahLhhqOCvIpeWsTZCuGDW/Vx3lvBuGyR+N7M9F6DxqmjpoRLna7CCEpQnR47D8=
X-Received: by 2002:a05:6402:1cc4:b0:567:f643:fc5c with SMTP id
 ds4-20020a0564021cc400b00567f643fc5cmr1180305edb.20.1710820469374; Mon, 18
 Mar 2024 20:54:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240313085843.17661-1-vladimir.isaev@syntacore.com>
In-Reply-To: <20240313085843.17661-1-vladimir.isaev@syntacore.com>
From: Guo Ren <guoren@kernel.org>
Date: Tue, 19 Mar 2024 11:54:17 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSjVKhX4RZKYHo392g56yczg2j6rLUqTqR9GM3i2zOBOw@mail.gmail.com>
Message-ID: <CAJF2gTSjVKhX4RZKYHo392g56yczg2j6rLUqTqR9GM3i2zOBOw@mail.gmail.com>
Subject: Re: [PATCH] riscv: hwprobe: do not produce frtace relocation
To: Vladimir Isaev <vladimir.isaev@syntacore.com>
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	catalin.marinas@arm.com, evan@rivosinc.com, nicolas@fjasle.eu, 
	tglx@linutronix.de, samitolvanen@google.com, masahiroy@kernel.org, 
	maskray@google.com, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Roman Artemev <roman.artemev@syntacore.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 13, 2024 at 5:05=E2=80=AFPM Vladimir Isaev
<vladimir.isaev@syntacore.com> wrote:
>
> Such relocation causes crash of android linker similar to one
> described in commit e05d57dcb8c7
> ("riscv: Fixup __vdso_gettimeofday broke dynamic ftrace").
>
> Looks like this relocation is added by CONFIG_DYNAMIC_FTRACE which is
> disabled in the default android kernel.
>
> Before:
>
> readelf -rW arch/riscv/kernel/vdso/vdso.so:
>
> Relocation section '.rela.dyn' at offset 0xd00 contains 1 entry:
>     Offset             Info             Type
> 0000000000000d20  0000000000000003 R_RISCV_RELATIVE
>
> objdump:
> 0000000000000c86 <__vdso_riscv_hwprobe@@LINUX_4.15>:
>  c86:   0001                    nop
>  c88:   0001                    nop
>  c8a:   0001                    nop
>  c8c:   0001                    nop
>  c8e:   e211                    bnez    a2,c92 <__vdso_riscv_hwprobe...
>
> After:
> readelf -rW arch/riscv/kernel/vdso/vdso.so:
>
> There are no relocations in this file.
>
> objdump:
> 0000000000000c86 <__vdso_riscv_hwprobe@@LINUX_4.15>:
>  c86:   e211                    bnez    a2,c8a <__vdso_riscv_hwprobe...
>  c88:   c6b9                    beqz    a3,cd6 <__vdso_riscv_hwprobe...
>  c8a:   e739                    bnez    a4,cd8 <__vdso_riscv_hwprobe...
>  c8c:   ffffd797                auipc   a5,0xffffd
>
> Also disable SCS since it also should not be available in vdso.
>
> Fixes: aa5af0aa90ba ("RISC-V: Add hwprobe vDSO function and data")
> Signed-off-by: Roman Artemev <roman.artemev@syntacore.com>
> Signed-off-by: Vladimir Isaev <vladimir.isaev@syntacore.com>
> ---
>  arch/riscv/kernel/vdso/Makefile | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/riscv/kernel/vdso/Makefile b/arch/riscv/kernel/vdso/Mak=
efile
> index 9b517fe1b8a8..272c431ac5b9 100644
> --- a/arch/riscv/kernel/vdso/Makefile
> +++ b/arch/riscv/kernel/vdso/Makefile
> @@ -37,6 +37,7 @@ endif
>
>  # Disable -pg to prevent insert call site
>  CFLAGS_REMOVE_vgettimeofday.o =3D $(CC_FLAGS_FTRACE) $(CC_FLAGS_SCS)
> +CFLAGS_REMOVE_hwprobe.o =3D $(CC_FLAGS_FTRACE) $(CC_FLAGS_SCS)
LGTM, good catch, thanks :)

Reviewed-by: Guo Ren <guoren@kernel.org>

>
>  # Disable profiling and instrumentation for VDSO code
>  GCOV_PROFILE :=3D n
> --
> 2.43.0
>


--=20
Best Regards
 Guo Ren

