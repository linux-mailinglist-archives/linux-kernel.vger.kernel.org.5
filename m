Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DEC080C101
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 06:52:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233313AbjLKFw0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 00:52:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233244AbjLKFwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 00:52:12 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA6C110A
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 21:52:15 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-3333224c7b9so3699130f8f.1
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 21:52:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1702273934; x=1702878734; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MHJV2PGMjruAfWeCQ41TtmWURkmDfN3OTSvooiPRx+Y=;
        b=f8BdcQIjY/a8NDfUlBPgs6jJytd5UH/v4rN9QimndE/Fgn6C6VVD6FqxFJJ22AZuys
         7dHv5sB5oAPnL0fhGi0jh9gitOOoK1T36q4CoTgU1PNAatNZL2mBpToQI9au0yu4UVuq
         S/XcKWnamkC9qGlOO0nChDW/eGFm6mURmY1QqYI+ZQAYcD+sWfvfzCkl0PeJMVIZdaQY
         lJUsd1Hwiptz40oHJ4vIhENHk0DusVGB7FJuCSHQ2JGVylCG0o0UapsXUbCeLMpxCR9o
         Dfj/+9pA2OyRe22r9SocWr/57dWzxN9sZ4BeIqgfSLXIJdLZHenmWXUu3Hk58kC+HkER
         ETYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702273934; x=1702878734;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MHJV2PGMjruAfWeCQ41TtmWURkmDfN3OTSvooiPRx+Y=;
        b=v3Z8lIP7Qh7M2CeXInkfV1hhE5DQ/SNSkk74TKnGW1VRsNq8FfZO6GLsqhX5XNWVjF
         53lmfmhLNBvVcyYR2dNyl08Fp0Q0doc77X6fx9uNhLY0bzeWPKdBtthYAIoDmPItRcoF
         WB36U9euE90NAxGM+2WIEV0zdyu06yGmKdEX6Fn59WlmvfYerVK+HLVUZWb8ibCqXkbt
         HUytCCUhIJxL8/MQZinqe/3h4AytMflbDeD28sYaqF6BqH+Qv1pmU2hxskpLlugxryVO
         HRQPqulOARigl31i6xmcRAmW/2qweSPjWf/r4vkHi/b/MrxiNE2sOE8n/wwaTjNGrkmt
         Rm1w==
X-Gm-Message-State: AOJu0YwgE8Kz8SrM3omkepdWZxCOPUKq/Bp48xGEmrNE0XkM4kQ1rha2
        wEAn5mqpUqgEBrckBoaxwiCo9hcZ72hpZiZKQUgNVg==
X-Google-Smtp-Source: AGHT+IEjOKGFDA2vI+3U82Soa8M47/BlWX+5s44Eg4L1nrXQr5ZUb04KeSpBoC4PSdGVYVSTPrqI1PAj4/mx9UCkEPc=
X-Received: by 2002:a05:6000:1104:b0:333:4a78:c5ed with SMTP id
 z4-20020a056000110400b003334a78c5edmr1900351wrw.19.1702273934069; Sun, 10 Dec
 2023 21:52:14 -0800 (PST)
MIME-Version: 1.0
References: <20231208151036.2458921-1-guoren@kernel.org>
In-Reply-To: <20231208151036.2458921-1-guoren@kernel.org>
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
Date:   Mon, 11 Dec 2023 06:52:02 +0100
Message-ID: <CAHVXubjfuKZ1PBYQ8By41OX65YpAma3_kmSL7urT8L0PmMxFnQ@mail.gmail.com>
Subject: Re: [PATCH] riscv: pgtable: Enhance set_pte to prevent OoO risk
To:     guoren@kernel.org
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        akpm@linux-foundation.org, catalin.marinas@arm.com,
        willy@infradead.org, david@redhat.com, muchun.song@linux.dev,
        will@kernel.org, peterz@infradead.org, rppt@kernel.org,
        paulmck@kernel.org, atishp@atishpatra.org, anup@brainfault.org,
        alex@ghiti.fr, mike.kravetz@oracle.com, dfustini@baylibre.com,
        wefu@redhat.com, jszhang@kernel.org, falcon@tinylab.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guo,

On Fri, Dec 8, 2023 at 4:10=E2=80=AFPM <guoren@kernel.org> wrote:
>
> From: Guo Ren <guoren@linux.alibaba.com>
>
> When changing from an invalid pte to a valid one for a kernel page,
> there is no need for tlb_flush. It's okay for the TSO memory model, but
> there is an OoO risk for the Weak one. eg:
>
> sd t0, (a0) // a0 =3D pte address, pteval is changed from invalid to vali=
d
> ...
> ld t1, (a1) // a1 =3D va of above pte
>
> If the ld instruction is executed speculatively before the sd
> instruction. Then it would bring an invalid entry into the TLB, and when
> the ld instruction retired, a spurious page fault occurred. Because the
> vmemmap has been ignored by vmalloc_fault, the spurious page fault would
> cause kernel panic.
>
> This patch was inspired by the commit: 7f0b1bf04511 ("arm64: Fix barriers
> used for page table modifications"). For RISC-V, there is no requirement
> in the spec to guarantee all tlb entries are valid and no requirement to
> PTW filter out invalid entries. Of course, micro-arch could give a more
> robust design, but here, use a software fence to guarantee.
>
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Signed-off-by: Guo Ren <guoren@kernel.org>
> ---
>  arch/riscv/include/asm/pgtable.h | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pg=
table.h
> index 294044429e8e..2fae5a5438e0 100644
> --- a/arch/riscv/include/asm/pgtable.h
> +++ b/arch/riscv/include/asm/pgtable.h
> @@ -511,6 +511,13 @@ static inline int pte_same(pte_t pte_a, pte_t pte_b)
>  static inline void set_pte(pte_t *ptep, pte_t pteval)
>  {
>         *ptep =3D pteval;
> +
> +       /*
> +        * Only if the new pte is present and kernel, otherwise TLB
> +        * maintenance or update_mmu_cache() have the necessary barriers.
> +        */
> +       if (pte_val(pteval) & (_PAGE_PRESENT | _PAGE_GLOBAL))
> +               RISCV_FENCE(rw,rw);

Only a sfence.vma can guarantee that the PTW actually sees a new
mapping, a fence is not enough. That being said, new kernel mappings
(vmalloc ones) are correctly handled in the kernel by using
flush_cache_vmap(). Did you observe something that this patch fixes?

Thanks,

Alex

>  }
>
>  void flush_icache_pte(pte_t pte);
> --
> 2.40.1
>
