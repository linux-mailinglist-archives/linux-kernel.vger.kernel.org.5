Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E63D2792BD8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:10:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239406AbjIERCl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 13:02:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354361AbjIELAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 07:00:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9FC6199
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 04:00:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 96D8CB811E0
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 11:00:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4589EC433CC
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 11:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693911613;
        bh=SgKV5ClqeLo1hlnR01GNFopDaqavZ/k0YiN5RC0/iBY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=snQjlbTOtWhbPjg+P/Vqfi9sJ6Aa0vKuoNjtFGHihdIJkQhRu2sYWV/szwN/5efqn
         qhXlBhrqSip9hnUAWZjB2Ki62cjqs9B3xWQ1KBa0qUliaVoLSLQFk6H8ncsO6M9ASU
         sTA3EkM1j9DClv4Dreo/1POGylXUytWwpmZobBpgLPOgGvUaJkoveeq5/YG9b1kK/p
         5vqqTN0Cflb+66vchO+UR9z6Am60JAtGWPM75nkuXiHbj7RM/QC42En2zprSELafOL
         BMf3xzG1RWP/8VVzljnnMmg6RTNJQRd5HdgguP0h+WhRom0eHszUJZ9zyQ7Bg7RgVT
         Xo4+p62lI0WvQ==
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-99bcc0adab4so351201166b.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Sep 2023 04:00:13 -0700 (PDT)
X-Gm-Message-State: AOJu0YwqoUwHPtKzvA0pyipUqkwA8YGPTH1cb6haFRaEBjk3Tf8Pxj2X
        kxyyBwkXvOu81BoGzDW1pZe4V7xVeDfEIXQ9Dqg=
X-Google-Smtp-Source: AGHT+IFgRuoOb9wfYkJVyhU+h1VY+IW46m9VrAHtO2gesGZBBFMelgYIg1qqOD5QTGCICK6cd3WvwyXqgnlDuLiOTGI=
X-Received: by 2002:a17:906:7691:b0:9a5:c8ad:20be with SMTP id
 o17-20020a170906769100b009a5c8ad20bemr7703246ejm.4.1693911611418; Tue, 05 Sep
 2023 04:00:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230905080147.1625448-1-maobibo@loongson.cn> <20230905080147.1625448-3-maobibo@loongson.cn>
In-Reply-To: <20230905080147.1625448-3-maobibo@loongson.cn>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Tue, 5 Sep 2023 18:59:59 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6DR7huH+c9ox9vsHDaQf5BAOvhvZtpKY5rKUQsEpbVOA@mail.gmail.com>
Message-ID: <CAAhV-H6DR7huH+c9ox9vsHDaQf5BAOvhvZtpKY5rKUQsEpbVOA@mail.gmail.com>
Subject: Re: [PATCH 2/2] LoongArch: Use static defined zero page rather than allocated
To:     Bibo Mao <maobibo@loongson.cn>
Cc:     WANG Xuerui <kernel@xen0n.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Bibo,

On Tue, Sep 5, 2023 at 4:01=E2=80=AFPM Bibo Mao <maobibo@loongson.cn> wrote=
:
>
> Like other popular architectures, zero page is defined in kernel
> BSS code segment, rather than dynamically alloted page. It is
> simpler.
>
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>  arch/loongarch/include/asm/mmzone.h  |  2 --
>  arch/loongarch/include/asm/pgtable.h |  6 ++----
>  arch/loongarch/kernel/numa.c         |  1 -
>  arch/loongarch/mm/init.c             | 21 +--------------------
>  4 files changed, 3 insertions(+), 27 deletions(-)
>
> diff --git a/arch/loongarch/include/asm/mmzone.h b/arch/loongarch/include=
/asm/mmzone.h
> index fe67d0b4b33d..2b9a90727e19 100644
> --- a/arch/loongarch/include/asm/mmzone.h
> +++ b/arch/loongarch/include/asm/mmzone.h
> @@ -13,6 +13,4 @@ extern struct pglist_data *node_data[];
>
>  #define NODE_DATA(nid) (node_data[(nid)])
>
> -extern void setup_zero_pages(void);
> -
>  #endif /* _ASM_MMZONE_H_ */
> diff --git a/arch/loongarch/include/asm/pgtable.h b/arch/loongarch/includ=
e/asm/pgtable.h
> index 342c5f9c25d2..70bd57daf42a 100644
> --- a/arch/loongarch/include/asm/pgtable.h
> +++ b/arch/loongarch/include/asm/pgtable.h
> @@ -70,10 +70,8 @@ struct vm_area_struct;
>   * for zero-mapped memory areas etc..
>   */
>
> -extern unsigned long empty_zero_page;
> -
> -#define ZERO_PAGE(vaddr) \
> -       (virt_to_page((void *)(empty_zero_page)))
> +extern unsigned long empty_zero_page[PAGE_SIZE / sizeof(unsigned long)];
> +#define ZERO_PAGE(vaddr)       ((void)(vaddr), virt_to_page(empty_zero_p=
age))
Can we simply use virt_to_page(empty_zero_page) here? Only x86 does it
like this now.

Huacai
>
>  /*
>   * TLB refill handlers may also map the vmalloc area into xkvrange.
> diff --git a/arch/loongarch/kernel/numa.c b/arch/loongarch/kernel/numa.c
> index 708665895b47..6f464d49f0c2 100644
> --- a/arch/loongarch/kernel/numa.c
> +++ b/arch/loongarch/kernel/numa.c
> @@ -470,7 +470,6 @@ void __init mem_init(void)
>  {
>         high_memory =3D (void *) __va(get_num_physpages() << PAGE_SHIFT);
>         memblock_free_all();
> -       setup_zero_pages();     /* This comes from node 0 */
>  }
>
>  int pcibus_to_node(struct pci_bus *bus)
> diff --git a/arch/loongarch/mm/init.c b/arch/loongarch/mm/init.c
> index 8ec668f97b00..628ebe42b519 100644
> --- a/arch/loongarch/mm/init.c
> +++ b/arch/loongarch/mm/init.c
> @@ -35,27 +35,9 @@
>  #include <asm/pgalloc.h>
>  #include <asm/tlb.h>
>
> -unsigned long empty_zero_page;
> +unsigned long empty_zero_page[PAGE_SIZE / sizeof(unsigned long)] __page_=
aligned_bss;
>  EXPORT_SYMBOL(empty_zero_page);
>
> -void setup_zero_pages(void)
> -{
> -       unsigned int order, i;
> -       struct page *page;
> -
> -       order =3D 0;
> -
> -       empty_zero_page =3D __get_free_pages(GFP_KERNEL | __GFP_ZERO, ord=
er);
> -       if (!empty_zero_page)
> -               panic("Oh boy, that early out of memory?");
> -
> -       page =3D virt_to_page((void *)empty_zero_page);
> -       split_page(page, order);
> -       for (i =3D 0; i < (1 << order); i++, page++)
> -               mark_page_reserved(page);
> -
> -}
> -
>  void copy_user_highpage(struct page *to, struct page *from,
>         unsigned long vaddr, struct vm_area_struct *vma)
>  {
> @@ -99,7 +81,6 @@ void __init mem_init(void)
>         high_memory =3D (void *) __va(max_low_pfn << PAGE_SHIFT);
>
>         memblock_free_all();
> -       setup_zero_pages();     /* Setup zeroed pages.  */
>  }
>  #endif /* !CONFIG_NUMA */
>
> --
> 2.27.0
>
>
