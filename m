Return-Path: <linux-kernel+bounces-98076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 822008774C3
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 02:14:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BD4C1C20CDF
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 01:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CCBC1381;
	Sun, 10 Mar 2024 01:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L4zzl7Sq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A521510EB
	for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2024 01:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710033278; cv=none; b=XHjWzn86o6Jaq3MS94IImGvbvqclkQWK1sEdX98FDZJ4A2fk59UmzGc7fdLUY9mnG0VlGO3cVNLPHgj3kmUhXjUFrpVtp0X57ORHlQbTz009FiqK75G94klQp/fFJHH4bHkJAcWrlyVzf4bRkF8tH4R2v8fxgEmFGu1A8CgT9Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710033278; c=relaxed/simple;
	bh=6O/34PjFcS71csnsOEjl3K28HUWbJIH0EfXrtk1ettM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QbbewqXu9aFWY9fF82LiBMcbJyTjc5EpG/OFTT9/3RSts2ipjPxxGrtbs9NFSinfnQupuduAukC3tlvOo+Acx/5NCJWHWvZ5Y/Ie+swuQ8Bepftww716rJ+5uQiKBSLPQsC2S+ddR4BqpnAyQp6bkykP3fdDMW9ch5GRCKQkUBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L4zzl7Sq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 299BBC433C7
	for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2024 01:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710033278;
	bh=6O/34PjFcS71csnsOEjl3K28HUWbJIH0EfXrtk1ettM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=L4zzl7SqpN2YALvGBSUSLpL5DsUOhFt2wTrn6GCniRbi/Ac5OWYpvck6smODym9E4
	 Mz/iohTMOY0dCLcY28V/Bsxjq1vsR3e1gASf8qC6SZriLGeGSedScdWH9UDdcxlO4g
	 J2X2egnqX9RNES16Igk3XmWJEfXcaARQt+uk7ncFJ4DyBa5uE9kpzVxTKtI7mS91y5
	 oJMiBdDebFB/67z81wFPJs5luh57EU5tQVr6AQcFmXtiih7NDo2J802+kI5PeKvAmH
	 QejAvhQqpS8Evl3WgZ8ywYY2LPNYBp8p3I4hnMWTaOH4z++ljYzg5mf3xf9RIDIIMS
	 raPIZPjpXWrIg==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-51341a5aafbso3673372e87.0
        for <linux-kernel@vger.kernel.org>; Sat, 09 Mar 2024 17:14:38 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV7mJup5ZqKYmoICdi7y729y1G00K4XhlDMhdIvwMggV6ALVWv2fMbUfmVPOW052C4bIVAhTXun0CXpYA4Sps/LVhm8pZTJhNZIzLIT
X-Gm-Message-State: AOJu0YyA2hJkUIgBR/cyJDt6Htb2o8/rJad48x9PXUb/4Pq3A95bY4B1
	Uikq0wqIucH0bhsEFnGGCHXfP2pD5Xw2l+r5vHVTeh7xCpppm9xfwpCvU9n4LTN7CiDbeMclM/x
	Yszzhg4TzCO4UC2FgRY8TozJnhUA=
X-Google-Smtp-Source: AGHT+IFUT9/jcoCRAOiZQYyzdoQx2ox/XQpSlfwRPS3OLnoUueu3HoXgT7cswxHoxfc5Q2euG8xieFbqZQrPIRBbxkg=
X-Received: by 2002:a05:6512:2316:b0:512:f59d:7612 with SMTP id
 o22-20020a056512231600b00512f59d7612mr2226880lfu.57.1710033276283; Sat, 09
 Mar 2024 17:14:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240308074600.3294338-1-max.kellermann@ionos.com>
In-Reply-To: <20240308074600.3294338-1-max.kellermann@ionos.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sun, 10 Mar 2024 09:14:24 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6O02es7ZsDRjWfO=9hz8owa1SWZXkyZ=p3BO28D+ix6A@mail.gmail.com>
Message-ID: <CAAhV-H6O02es7ZsDRjWfO=9hz8owa1SWZXkyZ=p3BO28D+ix6A@mail.gmail.com>
Subject: Re: [PATCH] loongarch/pgtable.h: move {dmw,tlb}_virt_to_page() to page.h
To: Max Kellermann <max.kellermann@ionos.com>
Cc: kernel@xen0n.name, lienze@kylinos.cn, yangtiezhu@loongson.cn, 
	tglx@linutronix.de, arnd@arndb.de, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Max,

Could you please share what kind of configuration will cause a build error?

Huacai

On Fri, Mar 8, 2024 at 3:46=E2=80=AFPM Max Kellermann <max.kellermann@ionos=
com> wrote:
>
> These functions are implemented in pgtable.c, and they are needed only
> by the virt_to_pfn() macro in page.h.  Having the prototypes in
> pgtable.h causes a circular dependency between page.h and pgtable.h,
> because page.h's virt_to_pfn() needs pgtable.h for these two
> functions, and pgtable.h needs various definitions from page.h
> (e.g. pte_t and pgt_t).
>
> I suggest avoiding this circular dependency by moving the function
> prototypes to page.h, even though that is slightly incorrect, because
> they are not implemented in page.c but pgtable.c, but it's the
> simplest possible solution to this problem and the functions not used
> anywhere else.
>
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
> ---
>  arch/loongarch/include/asm/page.h    | 3 +++
>  arch/loongarch/include/asm/pgtable.h | 3 ---
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/loongarch/include/asm/page.h b/arch/loongarch/include/a=
sm/page.h
> index afb6fa16b826..44027060c54a 100644
> --- a/arch/loongarch/include/asm/page.h
> +++ b/arch/loongarch/include/asm/page.h
> @@ -75,6 +75,9 @@ typedef struct { unsigned long pgprot; } pgprot_t;
>  #define pfn_to_kaddr(pfn)      __va((pfn) << PAGE_SHIFT)
>  #define sym_to_pfn(x)          __phys_to_pfn(__pa_symbol(x))
>
> +struct page *dmw_virt_to_page(unsigned long kaddr);
> +struct page *tlb_virt_to_page(unsigned long kaddr);
> +
>  #define virt_to_pfn(kaddr)     PFN_DOWN(PHYSADDR(kaddr))
>
>  #define virt_to_page(kaddr)                                             =
               \
> diff --git a/arch/loongarch/include/asm/pgtable.h b/arch/loongarch/includ=
e/asm/pgtable.h
> index 8b5df1bbf9e9..af3acdf3481a 100644
> --- a/arch/loongarch/include/asm/pgtable.h
> +++ b/arch/loongarch/include/asm/pgtable.h
> @@ -363,9 +363,6 @@ static inline void pte_clear(struct mm_struct *mm, un=
signed long addr, pte_t *pt
>  extern pgd_t swapper_pg_dir[];
>  extern pgd_t invalid_pg_dir[];
>
> -struct page *dmw_virt_to_page(unsigned long kaddr);
> -struct page *tlb_virt_to_page(unsigned long kaddr);
> -
>  /*
>   * The following only work if pte_present() is true.
>   * Undefined behaviour if not..
> --
> 2.39.2
>
>

