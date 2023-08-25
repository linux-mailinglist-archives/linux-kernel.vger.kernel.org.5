Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 916C8787F62
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 07:43:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238596AbjHYFmx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 01:42:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235814AbjHYFm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 01:42:27 -0400
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 895DC1BC2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 22:42:25 -0700 (PDT)
Received: by mail-oo1-xc35.google.com with SMTP id 006d021491bc7-5733bcf6eb6so358722eaf.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 22:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1692942145; x=1693546945;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=46o2vqzFPDatSdHHNgzmWzwxYNKn1sS6WAkkKsDp+P8=;
        b=iSDdxw5l8aoqBZJ4nD6SokRw3rT8X3hGggDXOyna2TIlR6C3uHvECy+sCU87a3rwc+
         IekTKTZk23NeVMWedddmN5w2OjuY4kTL/ugWIiXLM2fdeVnLwtY+pXxMbttlXg11SxUP
         TNvJvSUouzkMrNzRf/j34oNAWOJi9l3lyxUHHpNpQUgIsGCeXXmKS6DijRhAQeYUwFPW
         LIdqHsJdkTbu98jUlzLq8k7+wKPvxdlWE4gQAUw2ikoCbXQIeMGkcyeOKnT8cDW58YF5
         HIulo0JBXv4bLd6IH7cXuP69yQZ1xhT+9WxIGetXjIGhMkc7UI/9MIoFNI69FtOHW1O4
         f2cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692942145; x=1693546945;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=46o2vqzFPDatSdHHNgzmWzwxYNKn1sS6WAkkKsDp+P8=;
        b=Cx879lYDZ1/EqvgnAT2u2yMLl52DFj5vSWaSG0lRQ18tc+E3LoGCV9PUP6EwIorDvl
         XzyM5eIzvWVn9Pg2YBV5cWN9Wo/CrLLd+RG0TIDQ1OUxomyRPHL3ZWRNAHO2fWNZMyuC
         6wImzOrYqK73Tb9nU7pNAZ3CzjSPN3VPOM9cYtTLpQ+psWU0OJjzgERl0DhNYnTOVWvQ
         9sDpb67MNobs2NR46p51HvmxUooqo4PxsuslL311R5Zcr+Kq13KUU4anBGjJ44jfdB+O
         aKkW1W0/eT0L6w8ficRvVMbfkUBUDoJ9NaFeLDsN31TE+t+5j7/1z5THNt0L5UsFRFtw
         sVIQ==
X-Gm-Message-State: AOJu0YyyOx7K4NKT4oHOYMDRjyxhYVd31ctaMWBw0GMkfBFl6RfCrSbL
        3DwyJ9ubpwXd2keaqsn9UsJ6oSeNwwT73ToWelFSHw==
X-Google-Smtp-Source: AGHT+IGjjgqLBVEzKJWPplZ0yLZ67zAtldLS8M5GU6WX96OgKZs21aUbBltUW9QWJCntrD6UtrYTNSbrXXrJm5D3SsU=
X-Received: by 2002:a4a:919c:0:b0:572:b659:a236 with SMTP id
 d28-20020a4a919c000000b00572b659a236mr3903937ooh.6.1692942144830; Thu, 24 Aug
 2023 22:42:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230129064956.143664-1-tjytimi@163.com>
In-Reply-To: <20230129064956.143664-1-tjytimi@163.com>
From:   Yong-Xuan Wang <yongxuan.wang@sifive.com>
Date:   Fri, 25 Aug 2023 13:42:13 +0800
Message-ID: <CAMWQL2gBj84qhBopi=YKmHaUose2ggALKtOWqb6adDiuvS5xcg@mail.gmail.com>
Subject: Re: [PATCH v1] riscv: support arch_has_hw_pte_young()
To:     Jinyu Tang <tjytimi@163.com>
Cc:     palmer@rivosinc.com, paul.walmsley@sifive.com, palmer@dabbelt.com,
        yuzhao@google.com, conor.dooley@microchip.com,
        ajones@ventanamicro.com, guoren@kernel.org, tongtiangen@huawei.com,
        anup@brainfault.org, akpm@linux-foundation.org, falcon@tinylab.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Greentime Hu <greentime.hu@sifive.com>,
        Vincent Chen <vincent.chen@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jinyu,

It seems like it has been a while since the last release of this patch. Do
you have any plans for the patch recently? Or, do you mind sharing any
internal progress on the patch?

We are starting to work on the Svadu extension of pte A/D bit feature on
Linux. Do you find any places where we may potentially work together to
get things moving? Also, I am willing to base on top of your work and
continue sending the series (by keeping all the credits from the original
work)

Please let me know if you have any thoughts, thanks :)

Regards,
Yong-Xuan

On Sun, Jan 29, 2023 at 2:53=E2=80=AFPM Jinyu Tang <tjytimi@163.com> wrote:
>
> The arch_has_hw_pte_young() is false for riscv by default. If it's
> false, page table walk is almost skipped for MGLRU reclaim. And it
> will also cause useless step in __wp_page_copy_user().
>
> RISC-V Privileged Book says that riscv have two schemes to manage A
> and D bit.
>
> So add a config for selecting, the default is true. For simple
> implementation riscv CPU which just generate page fault, unselect it.
>
> Signed-off-by: Jinyu Tang <tjytimi@163.com>
> ---
>  arch/riscv/Kconfig               | 10 ++++++++++
>  arch/riscv/include/asm/pgtable.h |  7 +++++++
>  2 files changed, 17 insertions(+)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index e2b656043abf..17c82885549c 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -180,6 +180,16 @@ config PAGE_OFFSET
>         default 0x80000000 if 64BIT && !MMU
>         default 0xff60000000000000 if 64BIT
>
> +config ARCH_HAS_HARDWARE_PTE_YOUNG
> +       bool "Hardware Set PTE Access Bit"
> +       default y
> +       help
> +         Select if hardware set A bit when PTE is accessed. The default =
is
> +         'Y', because most RISC-V CPU hardware can manage A and D bit.
> +         But RISC-V may have simple implementation that do not support
> +         hardware set A bit but only generate page fault, for that case =
just
> +         unselect it.
> +
>  config KASAN_SHADOW_OFFSET
>         hex
>         depends on KASAN_GENERIC
> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pg=
table.h
> index 4eba9a98d0e3..1db54ab4e1ba 100644
> --- a/arch/riscv/include/asm/pgtable.h
> +++ b/arch/riscv/include/asm/pgtable.h
> @@ -532,6 +532,13 @@ static inline int ptep_clear_flush_young(struct vm_a=
rea_struct *vma,
>          */
>         return ptep_test_and_clear_young(vma, address, ptep);
>  }
> +#ifdef CONFIG_ARCH_HAS_HARDWARE_PTE_YOUNG
> +#define arch_has_hw_pte_young arch_has_hw_pte_young
> +static inline bool arch_has_hw_pte_young(void)
> +{
> +       return true;
> +}
> +#endif
>
>  #define pgprot_noncached pgprot_noncached
>  static inline pgprot_t pgprot_noncached(pgprot_t _prot)
> --
> 2.30.2
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
