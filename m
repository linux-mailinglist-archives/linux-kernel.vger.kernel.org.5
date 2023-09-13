Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AADB079DD9A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 03:34:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238038AbjIMBeI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 21:34:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbjIMBeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 21:34:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9484210F6
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 18:34:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 297C5C433CA
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 01:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694568843;
        bh=1cOduB5NzSAFGxdYlZ9mahDJ+zC1TtAF7RTbwxcPz4M=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=UlyvFtNlpxRaQjmL1KQi1Em1880aU2p17ODm9mHMtKXHSg77yoaRNUMxQ3egDP38Y
         IWq+faLpDhlQt35WbyXJFfKIs8d46sYpo9uk0xvGc7m1cZ8EufHjKZwcUuJYQY7n6P
         FNRP1iy/K3fwPlmvsiQdZ9CmcY3/Z0w5FoirSjK89ukIOJFvJTbH6NYxi9qMikprfJ
         gxTzkeF5s/PVsBu96kaK24kBgymeUk+5friohyZZUm1OpuTOUqhVQxxiTOn0MPb7Wa
         SnMIqUrkAoq4ytxvGDmlK9t7/QrD+V0cjjD5inVJrUC1s9OQCXhdJKkgajFeL4q2er
         xa7+/BTWTqnNQ==
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-9ad8d0be93aso94685866b.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 18:34:03 -0700 (PDT)
X-Gm-Message-State: AOJu0YyA1iczUY2NIe0CDmZk4SrS5tdedde7PXasNBLLoJx3ABBCBfsF
        9nhA+GayTklYHkkXfyb2lK6s1gyHcx4DeOFc0d0=
X-Google-Smtp-Source: AGHT+IFitKFfgjVq2xMFZUjgUnzIxGnh2YXc/Y2i4oL1rDRwl4MnjzLDTZMWcWcvrwcsIzo8g4NOLltJnq+4hzps6CI=
X-Received: by 2002:a17:906:5a42:b0:9a1:b528:d0f6 with SMTP id
 my2-20020a1709065a4200b009a1b528d0f6mr1515299ejc.27.1694568841506; Tue, 12
 Sep 2023 18:34:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230911092810.3108092-1-chenhuacai@loongson.cn>
 <b96c53eb-3c6f-d981-7573-10b95c3005a2@xen0n.name> <CAAhV-H6p6F6j61fiFz=KdhkRX_fN+jzhhuarJdcQ0LHtTLpzKw@mail.gmail.com>
 <bfdcbbb0-3df0-1778-6250-99e1120bb077@xen0n.name>
In-Reply-To: <bfdcbbb0-3df0-1778-6250-99e1120bb077@xen0n.name>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Wed, 13 Sep 2023 09:33:49 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7r2iNVUstHuYHj8Ve=sY9c5JoMvZNX_pDaUVhL7oGWXw@mail.gmail.com>
Message-ID: <CAAhV-H7r2iNVUstHuYHj8Ve=sY9c5JoMvZNX_pDaUVhL7oGWXw@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: Set all reserved memblocks on Node#0 at initialization
To:     WANG Xuerui <kernel@xen0n.name>
Cc:     Huacai Chen <chenhuacai@loongson.cn>, loongarch@lists.linux.dev,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn,
        WANG Xuerui <git@xen0n.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 13, 2023 at 9:23=E2=80=AFAM WANG Xuerui <kernel@xen0n.name> wro=
te:
>
> On 9/13/23 08:49, Huacai Chen wrote:
> > On Wed, Sep 13, 2023 at 12:08=E2=80=AFAM WANG Xuerui <kernel@xen0n.name=
> wrote:
> >> On 9/11/23 17:28, Huacai Chen wrote:
> >>> After commit 61167ad5fecdea ("mm: pass nid to reserve_bootmem_region(=
)")
> >>> we get a panic if DEFERRED_STRUCT_PAGE_INIT is enabled:
> >>>
> >>> [snip]
> >>>
> >>> The reason is early memblock_reserve() in memblock_init() set node id
> >> Why is it that only "early" but not "late" memblock_reserve() matters?=
 I
> >> failed to see the reason because the arch-specific memblock_init() isn=
't
> >> even in the backtrace, which means that *neither* is the culprit.
> > Late memblock_reserve() operates on subregions of memblock.memory
> > regions. These reserved regions will be set to the correct node at the
> > first iteration of memmap_init_reserved_pages().
> Thanks for the clarification. According to the code behavior (and the
> comment I left on the reordering change below) I'm now sure the intended
> meaning is "calling memblock_reserve() after memblock_set_node() is
> effectively leaving those regions with nid=3DMAX_NUMNODES" (or something
> like that, pointing out that the memblock_set_node() call actually had
> no effect in this case). "Early" and "late" in the context of init code
> can be especially confusing IMO :-)
The "early call" specifically means these lines:

        /* Reserve the first 2MB */
        memblock_reserve(PHYS_OFFSET, 0x200000);

        /* Reserve the kernel text/data/bss */
        memblock_reserve(__pa_symbol(&_text),
                         __pa_symbol(&_end) - __pa_symbol(&_text));

These two regions can be out of initial memory maps. Other later
memblock_reserve() regions must be in initial memory maps, so will get
a correct node id.

Huacai

> >
> > Huacai
> >
> >>> to MAX_NUMNODES, which causes NODE_DATA(nid) be a NULL dereference in
> >> "making NODE_DATA(nid) a NULL ..."
> >>> reserve_bootmem_region() -> init_reserved_page(). So set all reserved
> >>> memblocks on Node#0 at initialization to avoid this panic.
> >>>
> >>> Reported-by: WANG Xuerui <git@xen0n.name>
> >>> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> >>> ---
> >>>    arch/loongarch/kernel/mem.c | 4 +++-
> >>>    1 file changed, 3 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/arch/loongarch/kernel/mem.c b/arch/loongarch/kernel/mem.=
c
> >>> index 4a4107a6a965..aed901c57fb4 100644
> >>> --- a/arch/loongarch/kernel/mem.c
> >>> +++ b/arch/loongarch/kernel/mem.c
> >>> @@ -50,7 +50,6 @@ void __init memblock_init(void)
> >>>        }
> >>>
> >>>        memblock_set_current_limit(PFN_PHYS(max_low_pfn));
> >>> -     memblock_set_node(0, PHYS_ADDR_MAX, &memblock.memory, 0);
> >>>
> >>>        /* Reserve the first 2MB */
> >>>        memblock_reserve(PHYS_OFFSET, 0x200000);
> >>> @@ -58,4 +57,7 @@ void __init memblock_init(void)
> >>>        /* Reserve the kernel text/data/bss */
> >>>        memblock_reserve(__pa_symbol(&_text),
> >>>                         __pa_symbol(&_end) - __pa_symbol(&_text));
> >>> +
> >>> +     memblock_set_node(0, PHYS_ADDR_MAX, &memblock.memory, 0);
> >>> +     memblock_set_node(0, PHYS_ADDR_MAX, &memblock.reserved, 0);
> >> So the reordering is for being able to override the newly added
> >> memblocks' nids to 0, and additionally doing the same for
> >> memblock.reserved is the actual fix. Looks okay.
> >>>    }
> >> And I've tested the patch on the 2-way 3C5000L server, and it now
> >> correctly boots with deferred struct page init enabled. Thanks for
> >> providing such a quick fix!
> >>
> >> Tested-by: WANG Xuerui <git@xen0n.name>
> >> Reviewed-by: WANG Xuerui <git@xen0n.name>  # with nits addressed
> >>
> >> --
> >> WANG "xen0n" Xuerui
> >>
> >> Linux/LoongArch mailing list: https://lore.kernel.org/loongarch/
> >>
> >>
> --
> WANG "xen0n" Xuerui
>
> Linux/LoongArch mailing list: https://lore.kernel.org/loongarch/
>
