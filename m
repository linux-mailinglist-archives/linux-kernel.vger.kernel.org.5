Return-Path: <linux-kernel+bounces-120369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D25B88D65C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 07:27:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF3D71F2A287
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 06:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 936AD1DA24;
	Wed, 27 Mar 2024 06:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="k+WQRNWW"
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A96E1BF31
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 06:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711520857; cv=none; b=aMIXAkG/8U3gBNNX0rpfAYUsNnf3b/siT5jqld13V/1gBRTE5KGRVAxe3pNqNqWnwMVeriFhRQLnAEDYtZlThY0F9ESMH33gWhfzF7kRWjrQ1wqXj1YZOXgKJKwrIF+J6HPoIzcr35IdIWTaArRYh2iRrWglrFvVJJ2hFqmiRTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711520857; c=relaxed/simple;
	bh=Jwry8cdksNtEnfqafU1wTenlaz5Jt+IdEfFUq6uMmEE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UykiC9OgPcEJVwRVeEIb9eznvE1QAjZesz50Pl96zgCfHX0kMyF1HlSgsXS7icpmGceF0208Q/xsutcAarhtTZ6jm6/yDKW41ayaTI6Q6ZemejDPVUB/r++pSocXKRgul8uzfqik8YOtxxgiiuSGGaaFQJxuUmsMCi6RWpvogX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=k+WQRNWW; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-2282597eff5so4289647fac.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 23:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1711520854; x=1712125654; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t9YlwXsqvc7dgwQyElf+0ZLQ4rc4YzdX8Bou4Gf4VCs=;
        b=k+WQRNWWuE+PIlebvXcnZBaxc54ZNkWs1DYHAynTfZjFlKmEUYwJTy7pEyLdmgCv1j
         DhRXGHKrZUe+TBw07QhH/AnJ5M+NzgIEQj1mEsc9XfrcSmLoA9/8YNTTN2R8mGse8Br3
         xMHG63fufYhGNWS0YlD2r0WqiUt9H+wNVmmA21jGCSUtoBruAGmqg3QH29XODTW0ujCX
         l3k2Nfwod4aft9K4xW68skV9PxvJA1fDk+bjgHUjPKZii+UwFII1lP15Ik7n5Kc6N7nz
         yMteyBz31yAL998xlR4GEJpuf86wQDExQg4MC9Esrho0g4voOvKntPuKoMJwyGhoBVBo
         vxOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711520854; x=1712125654;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t9YlwXsqvc7dgwQyElf+0ZLQ4rc4YzdX8Bou4Gf4VCs=;
        b=NYEDpbmbIH0BT/H+9C+GZQFtDArU0Li/hcgFGOQFsDyFRAlRxo/SLXhgYHo4FM9XWS
         sR6EVu2tLT8ExNPvKikB22jdNeugpFxgdj7QnPcc/UVL5r3GCWo9HVBIjUFcqkOTnlKe
         BYep1ewKI4AuDxJtO6gHwYe16FyYUuXdcev//fPAOBlW3oxkqyjZGO6NJm/zQMe8wCr9
         BdU4DDOdKucK5m6VXGpRVdUTKWii2hYjcuiud36Z1r5pKQX0mAJY9v0ZlsLQsjbnpKir
         i2E1nFBU9nGvtaw9f5GUoMcnkhWCAr9GA2qaDx/VWJ975FIqc0ICRMKH5eybic4tamfV
         WFOg==
X-Forwarded-Encrypted: i=1; AJvYcCXDvUhydCzCHyN/t8CU37hHfgUuLh8NmOnXWMk3vXc0wUoGUSnSJy7/atRI2WudhJbLJ6SUE4xJG1Fb8i2fyI+QuO6E7xOzb6SkZ914
X-Gm-Message-State: AOJu0YyFw6oJCkbrSR6hgAxP+ougOeib+mZ7VAqrMjFDD/8A2BBMwrpw
	Ff+stCaXeV+iufeDf1/v1rnm7k97O5YOqELNcgnel4A/6+uS/UvVnB1RezhkBWQVPFc0Ddkg0Rv
	0pG6bhTS5eTTzB0KLENo64AQwTCjca42oCUia8JR5i5iImOPa3wqegg==
X-Google-Smtp-Source: AGHT+IFrg2HoG7q97DhSpbXNc25ham37J0pbg6a9qU7enuIB3n4fknfbf9j25G1aDzy1MVe4/zsyJcVd9XwGgb7dOzo=
X-Received: by 2002:a05:6871:554:b0:222:7a41:b6a0 with SMTP id
 t20-20020a056871055400b002227a41b6a0mr1890669oal.6.1711520853082; Tue, 26 Mar
 2024 23:27:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240327045035.368512-1-samuel.holland@sifive.com> <20240327045035.368512-9-samuel.holland@sifive.com>
In-Reply-To: <20240327045035.368512-9-samuel.holland@sifive.com>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Wed, 27 Mar 2024 14:27:22 +0800
Message-ID: <CAEEQ3wkjgu22WjV63Xn+sJ=KoZr+rS18OCCG=7Sw7V9hrYMETg@mail.gmail.com>
Subject: Re: [External] [PATCH v6 08/13] riscv: Avoid TLB flush loops when
 affected by SiFive CIP-1200
To: Samuel Holland <samuel.holland@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Alexandre Ghiti <alexghiti@rivosinc.com>, Jisheng Zhang <jszhang@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Samuel,

On Wed, Mar 27, 2024 at 12:51=E2=80=AFPM Samuel Holland
<samuel.holland@sifive.com> wrote:
>
> Implementations affected by SiFive errata CIP-1200 have a bug which
> forces the kernel to always use the global variant of the sfence.vma
> instruction. When affected by this errata, do not attempt to flush a
> range of addresses; each iteration of the loop would actually flush the
> whole TLB instead. Instead, minimize the overall number of sfence.vma
> instructions.
>
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
> ---
>
> Changes in v6:
>  - Clarify the commit message for patch 8 based on ML discussion
>
> Changes in v4:
>  - Only set tlb_flush_all_threshold when CONFIG_MMU=3Dy.
>
> Changes in v3:
>  - New patch for v3
>
>  arch/riscv/errata/sifive/errata.c | 5 +++++
>  arch/riscv/include/asm/tlbflush.h | 2 ++
>  arch/riscv/mm/tlbflush.c          | 2 +-
>  3 files changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/arch/riscv/errata/sifive/errata.c b/arch/riscv/errata/sifive=
/errata.c
> index 3d9a32d791f7..716cfedad3a2 100644
> --- a/arch/riscv/errata/sifive/errata.c
> +++ b/arch/riscv/errata/sifive/errata.c
> @@ -42,6 +42,11 @@ static bool errata_cip_1200_check_func(unsigned long  =
arch_id, unsigned long imp
>                 return false;
>         if ((impid & 0xffffff) > 0x200630 || impid =3D=3D 0x1200626)
>                 return false;
> +
> +#ifdef CONFIG_MMU
> +       tlb_flush_all_threshold =3D 0;
> +#endif
> +
>         return true;
>  }
>
> diff --git a/arch/riscv/include/asm/tlbflush.h b/arch/riscv/include/asm/t=
lbflush.h
> index 463b615d7728..8e329721375b 100644
> --- a/arch/riscv/include/asm/tlbflush.h
> +++ b/arch/riscv/include/asm/tlbflush.h
> @@ -66,6 +66,8 @@ void arch_tlbbatch_add_pending(struct arch_tlbflush_unm=
ap_batch *batch,
>                                unsigned long uaddr);
>  void arch_flush_tlb_batched_pending(struct mm_struct *mm);
>  void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch);
> +
> +extern unsigned long tlb_flush_all_threshold;
>  #else /* CONFIG_MMU */
>  #define local_flush_tlb_all()                  do { } while (0)
>  #endif /* CONFIG_MMU */
> diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
> index ad7bdcfcc219..18af7b5053af 100644
> --- a/arch/riscv/mm/tlbflush.c
> +++ b/arch/riscv/mm/tlbflush.c
> @@ -11,7 +11,7 @@
>   * Flush entire TLB if number of entries to be flushed is greater
>   * than the threshold below.
>   */
> -static unsigned long tlb_flush_all_threshold __read_mostly =3D 64;
> +unsigned long tlb_flush_all_threshold __read_mostly =3D 64;
>
>  static void local_flush_tlb_range_threshold_asid(unsigned long start,
>                                                  unsigned long size,
> --
> 2.43.1
>

Reviewed-by: Yunhui Cui <cuiyunhui@bytedance.com>

Thanks,
Yunhui

