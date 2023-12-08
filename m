Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B734780A72A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 16:17:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574269AbjLHPRi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 10:17:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574257AbjLHPRg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 10:17:36 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D2A71996
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 07:17:42 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37B15C4339A
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 15:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702048662;
        bh=kSzj0p26fXMxcGqE7PiPZ0L9JbNQNQodTYDm9B6XDgk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VT8TiPU8AWNNluFOQ6urgB12MMJoQ9XGqf3He6NQnqBuHXn7K0cUvfcSWnM9LtbrN
         koFsKbVZC5hbEyYlHLhw821WPeZDWudAIYX0FO6onGEuaQG/d70MdIYsgu2SCBi7k5
         OKe9tnTEoKCaavIpoHOTCL3UkBtGcEZT0OFnv1FXed25sOc1gsczKk9v3vWFI/2/Ua
         bIyC8WLC2BNLV4HE1XJRpuzltph0Tl6nL2N7IKJK/EN9HnSQFK/9Wy1aphDw6w9+9K
         WEfRg2si2t833Q/8bi7T/1L6oADuo2Z12qAMNodWzwiW4OuKSZXkxyrPpJleLTV96+
         Q23sLJSYDRK8Q==
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a1ef2f5ed01so233365366b.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 07:17:42 -0800 (PST)
X-Gm-Message-State: AOJu0YwqXzoeM8pwhwLwIvGGNBkyQHplIamf6Tm40P9Z/D1hSjxHsrzW
        29oGD2ERpBqA/uElK50CGFSXxbogkDo07EdG3Rw=
X-Google-Smtp-Source: AGHT+IFJi1iRf2zgfdHRC/qtkfVNJN+lKZDFZJXXngMI6hzEX7cIwVpODsJVSSc7dCBAJTGggOiPmd4JAi61MgXaqjQ=
X-Received: by 2002:a17:907:94c9:b0:a1d:3500:6906 with SMTP id
 dn9-20020a17090794c900b00a1d35006906mr61156ejc.297.1702048660644; Fri, 08 Dec
 2023 07:17:40 -0800 (PST)
MIME-Version: 1.0
References: <20231208151036.2458921-1-guoren@kernel.org>
In-Reply-To: <20231208151036.2458921-1-guoren@kernel.org>
From:   Guo Ren <guoren@kernel.org>
Date:   Fri, 8 Dec 2023 23:17:29 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSsKnmF8EY45xiH8y+wzz0XgypzHvwAbedCGu_x0S26=A@mail.gmail.com>
Message-ID: <CAJF2gTSsKnmF8EY45xiH8y+wzz0XgypzHvwAbedCGu_x0S26=A@mail.gmail.com>
Subject: Re: [PATCH] riscv: pgtable: Enhance set_pte to prevent OoO risk
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        akpm@linux-foundation.org, alexghiti@rivosinc.com,
        catalin.marinas@arm.com, willy@infradead.org, david@redhat.com,
        muchun.song@linux.dev, will@kernel.org, peterz@infradead.org,
        rppt@kernel.org, paulmck@kernel.org, atishp@atishpatra.org,
        anup@brainfault.org, alex@ghiti.fr, mike.kravetz@oracle.com,
        dfustini@baylibre.com, wefu@redhat.com, jszhang@kernel.org,
        falcon@tinylab.org
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 8, 2023 at 11:10=E2=80=AFPM <guoren@kernel.org> wrote:
>
> From: Guo Ren <guoren@linux.alibaba.com>
>
> When changing from an invalid pte to a valid one for a kernel page,
> there is no need for tlb_flush. It's okay for the TSO memory model, but
> there is an OoO risk for the Weak one. eg:
Sorry, TSO has no Immunity. The above sentence should be rewritten with:

When changing from an invalid pte to a valid one for a kernel page,
there is no guarantee tlb_flush in Linux. So, there is an OoO risk for
riscv, e.g.:

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
>  }
>
>  void flush_icache_pte(pte_t pte);
> --
> 2.40.1
>


--=20
Best Regards
 Guo Ren
