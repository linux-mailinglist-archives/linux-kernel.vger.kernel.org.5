Return-Path: <linux-kernel+bounces-120362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0749788D646
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 07:16:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89F65B21856
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 06:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 503751BF35;
	Wed, 27 Mar 2024 06:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Xo7vTBJi"
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06FE171CC
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 06:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711520174; cv=none; b=jYROhqtVorZwJnzYJ26Ubuini4vIw5oOpk3b6SEcGeqFD/gaioGJkNtDueYTHw5zLyTf/qH3zxqKub7OQZm6wfImgUtiZY0T+UbnnSkRv0x0vK7fsL14qk+Q1bSLNcix2eqEKejViy+91p7cV8zYeD96Ln/LhSDK1XRrrfNibVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711520174; c=relaxed/simple;
	bh=YyCynSucS6U+XPV2fYpF5SbSkiOgoxVK7j+SNkVIXVY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vBe2iqxK+3vHkM6nTZj162zbhyJbfkCQYauIGIRa8CnFE76jrKlOLsm/n9XcRNBCQux5CfDhxnrBJ+J+55RcmuUxFlgF7WGT1HjHrYlCKhOAMCdmHUhAS3HuLHoji3SS2YVqxAGezdX3ed6Ph2gZPNos4sDAp28YJpf6k/PwcA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Xo7vTBJi; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-21e45ece781so4061310fac.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 23:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1711520171; x=1712124971; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3kGrOBgnau6vlPoQysPMrILfu8WUrfgT3mQotZjW+mc=;
        b=Xo7vTBJiMIrDouqFE+FKsMNW6/GGYMWnBCJIkYBkCVZGf3ChDpEoLWVKVZydY40yYM
         I8ZN4t/UXJoRW45dH2HeQksFe6XLhJa5f/adLc8Vo53dkiXb7Cg/i1Ixz8IklkFc1gfz
         jDngskszo85sjPdTp2izVlwC6DdU4YSi2p7UYJy1hO1wqaV5lr6brSSGYs+lWLnFNslx
         0gxRZHUIVVCPB7nduFX6aHNFj2FsF6yPPVmoc9JcV+lQMJkOOnX1Cbxiz8mv2SbIOi7L
         C9bKK6w40Bd53mLpSjn1XfkvrwLncokb2zp1WEGda7pHCRuc/zDhd3uIq4al2TRK+krk
         5PKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711520171; x=1712124971;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3kGrOBgnau6vlPoQysPMrILfu8WUrfgT3mQotZjW+mc=;
        b=fmu67u+mKq7wSpihvHAWSqQy9ofQI1sPBEecY+2qbjn+I1eGnZruyd5JnBVNRTMN0J
         /51aBe9+wQ8STk9GNjDRN8itqH48aXbXtezIce8lAICrbp2rjrhofmyayD9cN5UZqZxT
         QMK7ALZSzubHBF5mozU+gdXFa7+G+FLDn1hJJQBnRe2BDahd4lTemZrnaUwBxI6AfXk+
         ErWv4s5AktdSuebpJZWL2S9HxwCoWfHFpoAuE5uxr3GprhLrZUetrhObr8aIjjlKy5PT
         ZluS6/8gv3L0hXrr6gYJF2X1caDQSPV43NnvTHyIrIFV7F4FLRimo4db9MV9pdAFYRy1
         wASA==
X-Forwarded-Encrypted: i=1; AJvYcCWyWwu6CLNN46ScfGCDay+h/AJKnZGbVC52WN0udLHzReW6OQy2y47Lv/TDC4zBavKwMw7jzmxnS9gIBh+BYId1zlo/bbHp4VjeWXjc
X-Gm-Message-State: AOJu0YzzOtDdrfw4k5ub1LkvFhylLN40PsR8tKL8LgZdZu6BXltLhtBN
	DVbQR25qsg7TIB0Dg+DFipvS/y4yhIcQ1MMF9a6mVZ4swVzuvqI6J2gSAAVpiyYAPbpDQFfwG7C
	asZdIduKzeyqXhga5wCLRdkmqdqjXPL751jBZ7w==
X-Google-Smtp-Source: AGHT+IFMN4eguJVk3/hsOcDrMysDAHcROyUhqeIkyR5+eDOdU7O92ItiCwYebfMEfrCeDl/m8weQrCQAFQsrwiKAFBg=
X-Received: by 2002:a05:6870:c0c4:b0:229:ec0e:7361 with SMTP id
 e4-20020a056870c0c400b00229ec0e7361mr1762070oad.29.1711520171010; Tue, 26 Mar
 2024 23:16:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240327045035.368512-1-samuel.holland@sifive.com> <20240327045035.368512-6-samuel.holland@sifive.com>
In-Reply-To: <20240327045035.368512-6-samuel.holland@sifive.com>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Wed, 27 Mar 2024 14:16:00 +0800
Message-ID: <CAEEQ3wm4SoC6rvv2qtVdP+4ZF1q41EEHUpwnagNgFwxkG5iw_w@mail.gmail.com>
Subject: Re: [External] [PATCH v6 05/13] riscv: Only send remote fences when
 some other CPU is online
To: Samuel Holland <samuel.holland@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Alexandre Ghiti <alexghiti@rivosinc.com>, Jisheng Zhang <jszhang@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Samuel,

On Wed, Mar 27, 2024 at 12:50=E2=80=AFPM Samuel Holland
<samuel.holland@sifive.com> wrote:
>
> If no other CPU is online, a local cache or TLB flush is sufficient.
> These checks can be constant-folded when SMP is disabled.
>
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
> ---
>
> (no changes since v4)
>
> Changes in v4:
>  - New patch for v4
>
>  arch/riscv/mm/cacheflush.c | 4 +++-
>  arch/riscv/mm/tlbflush.c   | 4 +++-
>  2 files changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/mm/cacheflush.c b/arch/riscv/mm/cacheflush.c
> index d76fc73e594b..f5be1fec8191 100644
> --- a/arch/riscv/mm/cacheflush.c
> +++ b/arch/riscv/mm/cacheflush.c
> @@ -21,7 +21,9 @@ void flush_icache_all(void)
>  {
>         local_flush_icache_all();
>
> -       if (riscv_use_sbi_for_rfence())
> +       if (num_online_cpus() < 2)
> +               return;
> +       else if (riscv_use_sbi_for_rfence())
>                 sbi_remote_fence_i(NULL);
>         else
>                 on_each_cpu(ipi_remote_fence_i, NULL, 1);
> diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
> index da821315d43e..0901aa47b58f 100644
> --- a/arch/riscv/mm/tlbflush.c
> +++ b/arch/riscv/mm/tlbflush.c
> @@ -79,7 +79,9 @@ static void __ipi_flush_tlb_all(void *info)
>
>  void flush_tlb_all(void)
>  {
> -       if (riscv_use_sbi_for_rfence())
> +       if (num_online_cpus() < 2)
> +               local_flush_tlb_all();
> +       else if (riscv_use_sbi_for_rfence())
>                 sbi_remote_sfence_vma_asid(NULL, 0, FLUSH_TLB_MAX_SIZE, F=
LUSH_TLB_NO_ASID);
>         else
>                 on_each_cpu(__ipi_flush_tlb_all, NULL, 1);
> --
> 2.43.1
>

From a perceptual point of view, the modification here is not
necessary. There is such logic in on_each_cpu(). Can you share your
test data?


Thanks,
Yunhui

