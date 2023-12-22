Return-Path: <linux-kernel+bounces-9659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8522781C90E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 12:25:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 319C5B239D5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 11:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBE33179B3;
	Fri, 22 Dec 2023 11:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LMcUbWVb"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4B51799E
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 11:25:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D511C433CD
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 11:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703244330;
	bh=fHYii6xXiPmGhLTNNk4Nv4pE45XCV3c4HwqYoSgnecs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=LMcUbWVbm4K7JZSvGhS0H4phPHmuFuQ4+eZm+vCFCwsJI04394W/GY5nkhrZnzuNC
	 78ey/b+EcgE8ElFkDbBFgoRH/PgLKygpaz5P2WBJ67n2o0MhU0odkHNE+Vzpor1GoB
	 VZAMPETMM4gvkg3TkrdsWLadzYm9+Wvoro2NyPUJ0/VVkkhQtvyDOhnezaIB9v/OtM
	 LJEscFs8JJCYn2VB5Yd9W8NO6mpsFqmXXy0hJlHUJcKRSPsusKoGNzK13dW2OGhSVn
	 th5XIvu+1ZtexMVFy/UqmZzvabkY+zpaSg3A4UELtOllInPqSfDpQa/d1BVbjYRyZa
	 Xrex71JcSXa7A==
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-336897b6bd6so1450079f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 03:25:30 -0800 (PST)
X-Gm-Message-State: AOJu0YwtqMnmIQqliN9ytpoFgkgpVxEHZnnj9jcZW36/L2lXyyAHgfcZ
	S3P8f90CIw8lzwuMsf7awY/q+gIunTFVFFCIw8Q=
X-Google-Smtp-Source: AGHT+IGmmJD9R1aPfi+R41Wym7ooeb+AvNkOO/8LfjdPnuAdavPQkfFIDGqGU6mn+snPt+0EyuVPVzKCMQho9M1cd5U=
X-Received: by 2002:a05:600c:1f82:b0:40c:708b:cf52 with SMTP id
 je2-20020a05600c1f8200b0040c708bcf52mr611856wmb.122.1703244328590; Fri, 22
 Dec 2023 03:25:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231221154702.2267684-1-guoren@kernel.org> <20231221154702.2267684-5-guoren@kernel.org>
 <ZYUZ8QUJxCL93Fgv@LeoBras>
In-Reply-To: <ZYUZ8QUJxCL93Fgv@LeoBras>
From: Guo Ren <guoren@kernel.org>
Date: Fri, 22 Dec 2023 19:25:16 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTX7AjexoRUw=ZS34HEWno7H3zvnXA+Q7TYsztNU=k2cg@mail.gmail.com>
Message-ID: <CAJF2gTTX7AjexoRUw=ZS34HEWno7H3zvnXA+Q7TYsztNU=k2cg@mail.gmail.com>
Subject: Re: [PATCH V2 4/4] riscv: mm: Optimize TASK_SIZE definition
To: Leonardo Bras <leobras@redhat.com>
Cc: linux-kernel@vger.kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	alexghiti@rivosinc.com, charlie@rivosinc.com, xiao.w.wang@intel.com, 
	david@redhat.com, panqinglin2020@iscas.ac.cn, rick.p.edgecombe@intel.com, 
	willy@infradead.org, bjorn@rivosinc.com, conor.dooley@microchip.com, 
	cleger@rivosinc.com, linux-riscv@lists.infradead.org, 
	Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 22, 2023 at 1:09=E2=80=AFPM Leonardo Bras <leobras@redhat.com> =
wrote:
>
> On Thu, Dec 21, 2023 at 10:47:01AM -0500, guoren@kernel.org wrote:
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > Unify the TASK_SIZE definition with VA_BITS for better readability.
> > Add COMPAT mode user address space info in the comment.
> >
> > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > Signed-off-by: Guo Ren <guoren@kernel.org>
> > ---
> >  arch/riscv/include/asm/pgtable.h | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/=
pgtable.h
> > index e415582276ec..d165ddae3b42 100644
> > --- a/arch/riscv/include/asm/pgtable.h
> > +++ b/arch/riscv/include/asm/pgtable.h
> > @@ -866,6 +866,7 @@ static inline pte_t pte_swp_clear_exclusive(pte_t p=
te)
> >   * Note that PGDIR_SIZE must evenly divide TASK_SIZE.
> >   * Task size is:
> >   * -        0x9fc00000       (~2.5GB) for RV32.
> > + * -        0x80000000       (   2GB) for RV64 compat mode
> >   * -      0x4000000000       ( 256GB) for RV64 using SV39 mmu
> >   * -    0x800000000000       ( 128TB) for RV64 using SV48 mmu
> >   * - 0x100000000000000       (  64PB) for RV64 using SV57 mmu
> > @@ -877,11 +878,11 @@ static inline pte_t pte_swp_clear_exclusive(pte_t=
 pte)
> >   * Similarly for SV57, bits 63=E2=80=9357 must be equal to bit 56.
> >   */
> >  #ifdef CONFIG_64BIT
> > -#define TASK_SIZE_64 (PGDIR_SIZE * PTRS_PER_PGD / 2)
> > +#define TASK_SIZE_64 (UL(1) << (VA_BITS - 1))
>
> Checked for l5, l4 and l3, and it seems a correct replacement.
>
> >
> >  #ifdef CONFIG_COMPAT
> > -#define TASK_SIZE_32 (_AC(0x80000000, UL))
> > -#define TASK_SIZE    (test_thread_flag(TIF_32BIT) ? \
> > +#define TASK_SIZE_32 (UL(1) << (VA_BITS_SV32 - 1))
>
> Oh, much better. Thanks for removing the magic number :)
>
> > +#define TASK_SIZE    (is_compat_task() ? \
> >                        TASK_SIZE_32 : TASK_SIZE_64)
I would remove is_compat_task() in the next version because your patch
contains that.

> >  #else
> >  #define TASK_SIZE    TASK_SIZE_64
> > --
> > 2.40.1
> >
>
> That's much more readable IMO now. Thanks!
>
> FWIW:
> Reviewed-by: Leonardo Bras <leobras@redhat.com>
>


--=20
Best Regards
 Guo Ren

