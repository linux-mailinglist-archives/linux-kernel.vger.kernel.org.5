Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 431017D8297
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 14:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344906AbjJZM05 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 08:26:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjJZM04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 08:26:56 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E67B4192
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 05:26:53 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-5a9bf4fbd3fso698409a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 05:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1698323213; x=1698928013; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PXJ5tou+MTDDsn+Qorzf1KVbPbDjWZpFZtthsZ+ew3Q=;
        b=Pk57A7J81iAJUoR6JLYx9ZibMisfO2nYMdn4graDZck2lTQciEq7fdMgbnIWeEYGWw
         DhUtvl1Gxy4bt4YJcEoMMCEVNsuNSHoEAlyum6tY2xRdF15wgeX4kssEJMf84ztawFMV
         vNCI8wOU74vqCEuDTagGcuQGsNh1yl4C/gJq2651UduCMg2V+/vN2FnG2KE1vEyMes0w
         /ffNe8LQ6jmAIK8+55o23KwVaTkGbmI4css7A4flLp2w19P60mGtVrw7OqROeOd3MTxX
         1f5KT+XEdTsnSJNPWNsNm9GspQA4tev2JBiuhz1HOftIncXrazTrmSr7/7en4DLjTuXc
         uGTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698323213; x=1698928013;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PXJ5tou+MTDDsn+Qorzf1KVbPbDjWZpFZtthsZ+ew3Q=;
        b=UyEthKOSKgFp9/1pt12a6olJj5TX6/b8qiEeMlxCntmVKK3WfVcAP2KDCOuYoonuX8
         orrv7a1XmSAcaINWtplG2u270/zxXf6/XNDgrNJh0XLzonckGoH4ddcm28hCqbkrYcyH
         Sj/Yj8aHvuVa7HmzlH0X3K0Lsjb5EnJJRyZm6TZDGh+btegbuZF9TDeBBdHtBBZVezxj
         p0yD3PQMqjQDap6A8mwrFv3MifmdVuspGhBMwSJuOstqPqsr0gKoPYrdq36+B43u+mLq
         BO3vW0Bos5fBBN+bSws3ABGZ8gvK2c3+fAvee0kcvqw3Wa7GCKwhMeDVi9CwILIrm/Eh
         Hi6A==
X-Gm-Message-State: AOJu0YzngQyiMLl+TYkH+HVhNXcOwFqQNKgqlvEk9nCNN8TaYbvnr8k3
        sJzvceUztHvhgpW423Tm2gIEECxFEAaY8EqIXfaJ2w==
X-Google-Smtp-Source: AGHT+IH80GhU4nXYY42cYgV15oqUGIZjnG/cJ28a1F8rp4lIL02+oyjlyhoHrT831HjrIFrxQZxtMTEM+EhdKGZ18eg=
X-Received: by 2002:a17:90a:f593:b0:27f:f1fa:b448 with SMTP id
 ct19-20020a17090af59300b0027ff1fab448mr2310488pjb.11.1698323213187; Thu, 26
 Oct 2023 05:26:53 -0700 (PDT)
MIME-Version: 1.0
References: <20231026101957.320572-1-bjorn@kernel.org>
In-Reply-To: <20231026101957.320572-1-bjorn@kernel.org>
From:   Anup Patel <apatel@ventanamicro.com>
Date:   Thu, 26 Oct 2023 17:56:41 +0530
Message-ID: <CAK9=C2Vcbq_ReGcK51uOYp+M2hakz=9=RNHaHFMbfxhth_4cnA@mail.gmail.com>
Subject: Re: [RFC PATCH] genirq/matrix: Dynamic bitmap allocation
To:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc:     Anup Patel <anup@brainfault.org>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 26, 2023 at 3:50=E2=80=AFPM Bj=C3=B6rn T=C3=B6pel <bjorn@kernel=
.org> wrote:
>
> From: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
>
> Some (future) users of the irq matrix allocator, do not know the size
> of the matrix bitmaps at compile time.
>
> To avoid wasting memory on unnecessary large bitmaps, size the bitmap
> at matrix allocation time.
>
> Signed-off-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
> ---
> Here's a cleaned up, boot tested, proper patch.
>
> Thomas, this is just FYI/RFC. This change would only make sense, if
> the RISC-V AIA series starts using the IRQ matrix allocator.

I have dropped "multi-MSI" support from the AIA v12 series
and also integrated the IRQ matrix allocator. This patch is
included in the AIA v12 series.

For reference, look at riscv_aia_v12 branch at:
https://github.com/avpatel/linux.git

I still need to rebase this upon device MSI domain support
from Thomas.

Regards,
Anup


>
>
> Bj=C3=B6rn
> ---
>  arch/x86/include/asm/hw_irq.h |  2 --
>  kernel/irq/matrix.c           | 28 +++++++++++++++++-----------
>  2 files changed, 17 insertions(+), 13 deletions(-)
>
> diff --git a/arch/x86/include/asm/hw_irq.h b/arch/x86/include/asm/hw_irq.=
h
> index 551829884734..dcfaa3812306 100644
> --- a/arch/x86/include/asm/hw_irq.h
> +++ b/arch/x86/include/asm/hw_irq.h
> @@ -16,8 +16,6 @@
>
>  #include <asm/irq_vectors.h>
>
> -#define IRQ_MATRIX_BITS                NR_VECTORS
> -
>  #ifndef __ASSEMBLY__
>
>  #include <linux/percpu.h>
> diff --git a/kernel/irq/matrix.c b/kernel/irq/matrix.c
> index 1698e77645ac..996cbb46d654 100644
> --- a/kernel/irq/matrix.c
> +++ b/kernel/irq/matrix.c
> @@ -8,8 +8,6 @@
>  #include <linux/cpu.h>
>  #include <linux/irq.h>
>
> -#define IRQ_MATRIX_SIZE        (BITS_TO_LONGS(IRQ_MATRIX_BITS))
> -
>  struct cpumap {
>         unsigned int            available;
>         unsigned int            allocated;
> @@ -17,8 +15,8 @@ struct cpumap {
>         unsigned int            managed_allocated;
>         bool                    initialized;
>         bool                    online;
> -       unsigned long           alloc_map[IRQ_MATRIX_SIZE];
> -       unsigned long           managed_map[IRQ_MATRIX_SIZE];
> +       unsigned long           *managed_map;
> +       unsigned long           alloc_map[];
>  };
>
>  struct irq_matrix {
> @@ -32,8 +30,8 @@ struct irq_matrix {
>         unsigned int            total_allocated;
>         unsigned int            online_maps;
>         struct cpumap __percpu  *maps;
> -       unsigned long           scratch_map[IRQ_MATRIX_SIZE];
> -       unsigned long           system_map[IRQ_MATRIX_SIZE];
> +       unsigned long           *system_map;
> +       unsigned long           scratch_map[];
>  };
>
>  #define CREATE_TRACE_POINTS
> @@ -50,24 +48,32 @@ __init struct irq_matrix *irq_alloc_matrix(unsigned i=
nt matrix_bits,
>                                            unsigned int alloc_start,
>                                            unsigned int alloc_end)
>  {
> +       unsigned int cpu, matrix_size =3D BITS_TO_LONGS(matrix_bits);
>         struct irq_matrix *m;
>
> -       if (matrix_bits > IRQ_MATRIX_BITS)
> -               return NULL;
> -
> -       m =3D kzalloc(sizeof(*m), GFP_KERNEL);
> +       m =3D kzalloc(struct_size(m, scratch_map, matrix_size * 2), GFP_K=
ERNEL);
>         if (!m)
>                 return NULL;
>
> +       m->system_map =3D &m->scratch_map[matrix_size];
> +
>         m->matrix_bits =3D matrix_bits;
>         m->alloc_start =3D alloc_start;
>         m->alloc_end =3D alloc_end;
>         m->alloc_size =3D alloc_end - alloc_start;
> -       m->maps =3D alloc_percpu(*m->maps);
> +       m->maps =3D __alloc_percpu(struct_size(m->maps, alloc_map, matrix=
_size * 2),
> +                                __alignof__(*m->maps));
>         if (!m->maps) {
>                 kfree(m);
>                 return NULL;
>         }
> +
> +       for_each_possible_cpu(cpu) {
> +               struct cpumap *cm =3D per_cpu_ptr(m->maps, cpu);
> +
> +               cm->managed_map =3D &cm->alloc_map[matrix_size];
> +       }
> +
>         return m;
>  }
>
>
> base-commit: 611da07b89fdd53f140d7b33013f255bf0ed8f34
> --
> 2.40.1
>
