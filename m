Return-Path: <linux-kernel+bounces-87844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7882386D9E0
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 03:49:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24817286C92
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 02:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67E80405CB;
	Fri,  1 Mar 2024 02:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="fx7D+E/D"
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A8427447
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 02:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709261340; cv=none; b=L2/drmxMW03ZSEo2JjM09P+oDTDTbLoMTEIGZE2oo6fmx6QyC3u5/3t4VYm+FNwP3tLLZ/tSzKjAVw3kaTKf5eJMcfTWW2k7Hnj/tAJzPphVGCxhT/MVR98gSIDKO4z1EQwrG1QYMuCaDW1RMF2Iv1GxC3BiyL0aplzedZ7az7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709261340; c=relaxed/simple;
	bh=aMeMkzsgeEYmPQ1hG8FYlMI62r0R4XfHI5tHGKJko9o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TX/BOksJkDTWix6JDPCzkQcKDUMzO9Dl7/9ADKrqIB7cUOReKnFR89Xqd0y7Dsg4Ovxx6cKMyH8ribYT0Nc8AZ8Lx5a2QBT9Wowy8CFcDWKjwNFFUIiNMhFHhqbxovbWSMS7QGSDNimQGgmDuJjmZiXbS4ndm8YzjDVjHv9VkkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=fx7D+E/D; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-21f996af9bdso675023fac.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 18:48:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1709261337; x=1709866137; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y4wL4sVLm0d8inTQGwPB9JktEU1zAMD8FxX2kgSYWC8=;
        b=fx7D+E/D93Ge8YEpJyI4N9vehNv8aXZIeR9fELoM1GdYv4BNu5GofnqG7RXsIfFkav
         O+Ni1CIothRCn7psbVcODxGwjXpnt6DK3oWTetZBabcpPWe3WSXfUA1+B0vfBCjMuPOU
         8uysjx8J+7OnAXx52DTKgFvo5+zWG/3jfflwG3YpzOa/N7VihpdpdCpVImwxnOL3ZmbB
         xGNZjqlQ0ymIvdklgHV/FZC1kzhHk+TpGSNoRTMtP8gvDRgALnLYVZqIzLXAtZ8OZE1T
         pBe8MTJfWGaGVokpf49LlX+HvxCti4zcIm3T1ptamL5eqf/lRBG14CUSNmiW9IzbHlVp
         +Dmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709261337; x=1709866137;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y4wL4sVLm0d8inTQGwPB9JktEU1zAMD8FxX2kgSYWC8=;
        b=U08hcFeVpo+HE/N3r00v+GlDRldOo77c846xlkJR6pFfIDsXvVgixGB/MaIyqF1AAn
         gGkXvbw/gbLDhsS2E2Eq4gJZf0wsAgxSzJXldu7pvBDTVo0d1xesCamlk+PHJeXg1Q8M
         Iryxx9chlfooju/jQatR80yBJjuPmQtWd/ehE9kt/WJdQ6/8mW6wMJiGYa53lqREfOQ6
         M0U6r84N2J8zbs708JlBICAGO4UjcVVPfiMPOuLXuw2u1Yiftk981pOdf6TAuq+9TxOv
         OHMmHRjHwnXv+RFa0nJm5uwOY4I9oKmodvINoMW0D2n13SJbT3HbZ8nLDC/s7ynK3JHT
         7a0w==
X-Forwarded-Encrypted: i=1; AJvYcCUq3DhVIGXFpZ0QaVleC3709XNFusgncDpTT1LR0yywzf7IQouhiHvJYmyAb82HSpm83gqxRiRuT+xnPB/SLmCbdkHolWDJs0Gghmmw
X-Gm-Message-State: AOJu0YyXWt+Zz87geyZ2phUetiRxzsXTWNgHrQTtC/UJrXehDXVGBeH4
	PDMDeFzvyboe9UGdVTDMe5wufQQ08t84EKi95sfEWbtt1bIcKjuSIHoHj9JK7ffkh1W4V7iOYQp
	6va743bySGUuXIcWCsP7abo8wf6pO9XbAKmKJZdWccZWt/aZ2PkggnA==
X-Google-Smtp-Source: AGHT+IEiTQS7oF0FArmnvNFhGVJ1tsGZOo1OMbhw60aKsqUYfW1SLdjZuDJW0kKZW//xD4oLw7aEds9MmsaU+EbtO1A=
X-Received: by 2002:a05:6871:8e82:b0:220:bd1c:6c21 with SMTP id
 zq2-20020a0568718e8200b00220bd1c6c21mr98677oab.39.1709261336948; Thu, 29 Feb
 2024 18:48:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240229232211.161961-1-samuel.holland@sifive.com> <20240229232211.161961-9-samuel.holland@sifive.com>
In-Reply-To: <20240229232211.161961-9-samuel.holland@sifive.com>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Fri, 1 Mar 2024 10:48:46 +0800
Message-ID: <CAEEQ3w=8dVxO=qtW6_-SChLJ5No+7nGgf+1fXz0wSeBhb0Kk0A@mail.gmail.com>
Subject: Re: [External] [PATCH v5 08/13] riscv: Avoid TLB flush loops when
 affected by SiFive CIP-1200
To: Samuel Holland <samuel.holland@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Alexandre Ghiti <alexghiti@rivosinc.com>, Jisheng Zhang <jszhang@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Samuel,

On Fri, Mar 1, 2024 at 7:22=E2=80=AFAM Samuel Holland <samuel.holland@sifiv=
e.com> wrote:
>
> Since implementations affected by SiFive errata CIP-1200 always use the
> global variant of the sfence.vma instruction, they only need to execute
> the instruction once. The range-based loop only hurts performance.
>
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
> ---
>
> (no changes since v4)
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
> index 365e0a0e4725..22870f213188 100644
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

If local_flush_tlb_all_asid() is used every time, more PTWs will be
generated. Will such modifications definitely improve the overall
performance?

Hi Alex, Samuel,
The relationship between flush_xx_range_asid() and nr_ptes is
basically linear growth (y=3Dkx +b), while flush_all_asid() has nothing
to do with nr_ptes (y=3Dc).
Some TLBs may do some optimization. The operation of flush all itself
requires very few cycles, but there is a certain delay between
consecutive flush all.
The intersection of the two straight lines is the optimal solution of
tlb_flush_all_threshold. In actual situations, continuous
flush_all_asid will not occur. One problem caused by flush_all_asid()
is that multiple flush entries require PTW, which causes greater
latency.
Therefore, the value of tlb_flush_all_threshold needs to be considered
or quantified. Maybe doing local_flush_tlb_page_asid() based on the
actual nr_ptes_in_range would give better overall performance.
What do you think?

Thanks,
Yunhui

