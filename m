Return-Path: <linux-kernel+bounces-160872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B06778B43DB
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 04:50:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE2D72838B5
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 02:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B3EB3A1DC;
	Sat, 27 Apr 2024 02:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="btkVV4fK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6EFB364A0
	for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2024 02:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714186226; cv=none; b=Xbm5RrfEL5vVmr8ZQcBuRkAldDpX90EvUJ141Ihp4+Q8kVzj2mSriN9TaQFGjw82gOOC5nhnsRnbE3llZ5wLmrijtssoJmxcjb/7ITseiUF5QFJWS1rOeIpc/jE8FJgvNL1aMr5QHcPEOJpvOFoTRL8kwZP0nCMq9u523mOs+iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714186226; c=relaxed/simple;
	bh=drPixRzIsCAu9f877pcNV1e6g4ifHH4yrnxROSeHr4g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mJ1uC3n0f1/kHuNw2GiR0vCs1o+Da5zQyNQ4P145fggzuBkIipGqgtXUP3wa6nSbEmb2ddJwNtsPtYUcQP36PvfY2qnRZhIb4P+75fq7mjwrrJcGh4YTNGnc6OjAJfxW1InZ4Fv2/twGJELyz9tlK7glAIET1sCokJ55yw7i34E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=btkVV4fK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F909C32782
	for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2024 02:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714186226;
	bh=drPixRzIsCAu9f877pcNV1e6g4ifHH4yrnxROSeHr4g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=btkVV4fKGoxngkXFbP+WAqBniYlfZgPOnmr7XCqK+QjUOz7txT2+pyIo4OqNYkiwk
	 jQxX2uBu4wCsX00uUiFxPaGrSSVfTBImWhMhZehuOnuPiBe5PZ7cpJeLX0QYITpryl
	 7Q8BWSubrgDlOGrNQwa4yT5AT8p0bCBVXLd+APciNDHRGy4vdsv/R7oxKY5pSa/apN
	 7ikt46h77ZY/AwYBdIsSxpgl+TeppD9mCXTlIW8oHNxPlTvCylXv64nQwJG4uovT9t
	 GBVPoDvsxLfiMFHsEWvGPzrf2AakxgFLdvyVNXTF6q7v+sGyTLz2BjiVP8H8sh3Jyi
	 vNmpefXKcuwqQ==
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-572669fd9f9so748371a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 19:50:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWSjd3oMjUTEe2rpvB+YGITUlwK5xMzNcgKd8r/QOLbF0PC+P6LPP/j/jcavIwilvIyzfKHJELT5Wpvh/DvzKU0tTLAfehSVKzAi1Rq
X-Gm-Message-State: AOJu0YwmEznKff8U6Dud787039gyjxw4DWhdFnx3HdfpRmRrZAX1Qx4o
	coGpMX6c70WRp/CYsi4QzlNDnz03QUX8MufzuM7VYtf8MQskWUBeW22A1AqEw7Vr92l2+1kLJmY
	f405+yJP+3Uw90mpXZQ/Kq14eWMk=
X-Google-Smtp-Source: AGHT+IEiRXSE9z+ztJw1xDxNpukDmsgSS+b2Sfps4U5tpNL/NYNfW8WvdFlYkHS72+OYpiryOnOaSOB/LKfg5AFZRs4=
X-Received: by 2002:a17:906:28d9:b0:a55:63de:9aa9 with SMTP id
 p25-20020a17090628d900b00a5563de9aa9mr2892264ejd.49.1714186224939; Fri, 26
 Apr 2024 19:50:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240426121442.882029-1-xry111@xry111.site>
In-Reply-To: <20240426121442.882029-1-xry111@xry111.site>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sat, 27 Apr 2024 10:50:12 +0800
X-Gmail-Original-Message-ID: <CAAhV-H74cQ4XdDez5PipCxUZTpfS=CA6azL5qob=jGGebobD6g@mail.gmail.com>
Message-ID: <CAAhV-H74cQ4XdDez5PipCxUZTpfS=CA6azL5qob=jGGebobD6g@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: Provide __lshrti3, __ashrti3, and __ashrti3
To: Xi Ruoyao <xry111@xry111.site>
Cc: WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Tiezhu Yang <yangtiezhu@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Ruoyao,

I don't think #ifdef CONFIG_ARCH_SUPPORTS_INT128 is needed here.
S390/ARM64/RISCV all built it unconditionally. And I think this patch
can be squashed to the one enable ARCH_SUPPORTS_INT128, as S390 does.

Huacai

On Fri, Apr 26, 2024 at 8:14=E2=80=AFPM Xi Ruoyao <xry111@xry111.site> wrot=
e:
>
> After selecting ARCH_SUPPORTS_INT128, when optimizing for size the
> compiler generates calls to __lshrti3, __ashrti3, and __ashrti3 for
> shifting __int128 values, causing a link failure:
>
>     loongarch64-unknown-linux-gnu-ld: kernel/sched/fair.o: in
>     function `mul_u64_u32_shr':
>     <PATH>/include/linux/math64.h:161:(.text+0x5e4): undefined
>     reference to `__lshrti3'
>
> Provide the implementation of these functions if ARCH_SUPPORTS_INT128.
>
> Reported-by: Huacai Chen <chenhuacai@kernel.org>
> Closes: https://lore.kernel.org/loongarch/CAAhV-H5EZ=3D7OF7CSiYyZ8_+wWuen=
po=3DK2WT8-6mAT4CvzUC_4g@mail.gmail.com/
> Signed-off-by: Xi Ruoyao <xry111@xry111.site>
> ---
>  arch/loongarch/include/asm/asm-prototypes.h |  6 +++
>  arch/loongarch/lib/Makefile                 |  2 +
>  arch/loongarch/lib/tishift.S                | 56 +++++++++++++++++++++
>  3 files changed, 64 insertions(+)
>  create mode 100644 arch/loongarch/lib/tishift.S
>
> diff --git a/arch/loongarch/include/asm/asm-prototypes.h b/arch/loongarch=
/include/asm/asm-prototypes.h
> index cf8e1a4e7c19..51f224bcfc65 100644
> --- a/arch/loongarch/include/asm/asm-prototypes.h
> +++ b/arch/loongarch/include/asm/asm-prototypes.h
> @@ -6,3 +6,9 @@
>  #include <asm/page.h>
>  #include <asm/ftrace.h>
>  #include <asm-generic/asm-prototypes.h>
> +
> +#ifdef CONFIG_ARCH_SUPPORTS_INT128
> +__int128_t __ashlti3(__int128_t a, int b);
> +__int128_t __ashrti3(__int128_t a, int b);
> +__int128_t __lshrti3(__int128_t a, int b);
> +#endif
> diff --git a/arch/loongarch/lib/Makefile b/arch/loongarch/lib/Makefile
> index a77bf160bfc4..f61af161f16e 100644
> --- a/arch/loongarch/lib/Makefile
> +++ b/arch/loongarch/lib/Makefile
> @@ -9,3 +9,5 @@ lib-y   +=3D delay.o memset.o memcpy.o memmove.o \
>  obj-$(CONFIG_CPU_HAS_LSX) +=3D xor_simd.o xor_simd_glue.o
>
>  obj-$(CONFIG_FUNCTION_ERROR_INJECTION) +=3D error-inject.o
> +
> +obj-$(CONFIG_ARCH_SUPPORTS_INT128) +=3D tishift.o
> diff --git a/arch/loongarch/lib/tishift.S b/arch/loongarch/lib/tishift.S
> new file mode 100644
> index 000000000000..eb43f29f4d0b
> --- /dev/null
> +++ b/arch/loongarch/lib/tishift.S
> @@ -0,0 +1,56 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +
> +#include <asm/asmmacro.h>
> +#include <linux/linkage.h>
> +#include <linux/export.h>
> +
> +SYM_FUNC_START(__lshrti3)
> +       slli.d  t2, a1, 1
> +       nor     t3, zero, a2
> +       srl.d   t1, a0, a2
> +       sll.d   t2, t2, t3
> +       andi    t0, a2, 64
> +       srl.d   a1, a1, a2
> +       or      t1, t2, t1
> +       maskeqz a0, a1, t0
> +       masknez a1, a1, t0
> +       masknez t0, t1, t0
> +       or      a0, t0, a0
> +       jr      ra
> +SYM_FUNC_END(__lshrti3)
> +EXPORT_SYMBOL(__lshrti3)
> +
> +SYM_FUNC_START(__ashrti3)
> +       nor     t3, zero, a2
> +       slli.d  t2, a1, 1
> +       srl.d   t1, a0, a2
> +       sll.d   t2, t2, t3
> +       andi    t0, a2, 64
> +       or      t1, t2, t1
> +       sra.d   a2, a1, a2
> +       srai.d  a1, a1, 63
> +       maskeqz a0, a2, t0
> +       maskeqz a1, a1, t0
> +       masknez a2, a2, t0
> +       masknez t0, t1, t0
> +       or      a1, a1, a2
> +       or      a0, t0, a0
> +       jr      ra
> +SYM_FUNC_END(__ashrti3)
> +EXPORT_SYMBOL(__ashrti3)
> +
> +SYM_FUNC_START(__ashlti3)
> +       srli.d  t2, a0, 1
> +       nor     t3, zero, a2
> +       sll.d   t1, a1, a2
> +       srl.d   t2, t2, t3
> +       andi    t0, a2, 64
> +       sll.d   a0, a0, a2
> +       or      t1, t2, t1
> +       maskeqz a1, a0, t0
> +       masknez a0, a0, t0
> +       masknez t0, t1, t0
> +       or      a1, t0, a1
> +       jr      ra
> +SYM_FUNC_END(__ashlti3)
> +EXPORT_SYMBOL(__ashlti3)
> --
> 2.44.0
>

