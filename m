Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8875B79DD3E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 02:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237975AbjIMAuE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 20:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbjIMAuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 20:50:03 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA53C125
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 17:49:59 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44AD9C433C9
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 00:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694566199;
        bh=JW8eFTbL5Zu4+gvs9EK1EjcoupsFINoxnXaQNhFvMsI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cOhcaKTbX6hq4EYkMnux9p7Z1U7/j+nx+uvA0cfWJdqRCgPcSwxV72N97zM826Xnn
         jQP9b4Cm1+h8WNOHb3LmPnVDtSYskpUI+t5l0JQepAqWQOhIKdjbA74A3GbHk3HdBJ
         xSQJNspwYeIlLkiREkbf+b5+KKqTDopChwv+GNFWS1cZB8kSgDOSDBf6DSVhvOEOWS
         Ce6yUGQlaJTwx+5OWiPDIh4oy326mWfPQY/BJkidQX5lf37C4Xk9Yn8PefH1w/9DLt
         2KIoZVSMDM6fZugzx+VVyKiT6pXiuy7t5Hyt+dFc2p8Luc7s1cq0CMuG7Z9i6uStJO
         lJW2tQNDCliTQ==
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2bb9a063f26so106713201fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 17:49:59 -0700 (PDT)
X-Gm-Message-State: AOJu0Yxb/5AFUjHg10KFMSBTvQnQV+gL4XQnDiJ9RX7aE/BUHfEz9aZs
        XEXZYCNdRhNSuYHHzbbjq6bgvEu2fTlmUNEjv10=
X-Google-Smtp-Source: AGHT+IFPeWbANP5jSE7BsZE5UtVXIzW1xbzm2QPBWZXcSBugS5Vq+2TMylhVh4EsL8RXgn5R+hlWEGTiu6nhQbCijZA=
X-Received: by 2002:a2e:8802:0:b0:2b5:80c9:1266 with SMTP id
 x2-20020a2e8802000000b002b580c91266mr1041477ljh.43.1694566197491; Tue, 12 Sep
 2023 17:49:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230911092810.3108092-1-chenhuacai@loongson.cn> <b96c53eb-3c6f-d981-7573-10b95c3005a2@xen0n.name>
In-Reply-To: <b96c53eb-3c6f-d981-7573-10b95c3005a2@xen0n.name>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Wed, 13 Sep 2023 08:49:45 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6p6F6j61fiFz=KdhkRX_fN+jzhhuarJdcQ0LHtTLpzKw@mail.gmail.com>
Message-ID: <CAAhV-H6p6F6j61fiFz=KdhkRX_fN+jzhhuarJdcQ0LHtTLpzKw@mail.gmail.com>
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

On Wed, Sep 13, 2023 at 12:08=E2=80=AFAM WANG Xuerui <kernel@xen0n.name> wr=
ote:
>
> On 9/11/23 17:28, Huacai Chen wrote:
> > After commit 61167ad5fecdea ("mm: pass nid to reserve_bootmem_region()"=
)
> > we get a panic if DEFERRED_STRUCT_PAGE_INIT is enabled:
> >
> > [snip]
> >
> > The reason is early memblock_reserve() in memblock_init() set node id
> Why is it that only "early" but not "late" memblock_reserve() matters? I
> failed to see the reason because the arch-specific memblock_init() isn't
> even in the backtrace, which means that *neither* is the culprit.
Late memblock_reserve() operates on subregions of memblock.memory
regions. These reserved regions will be set to the correct node at the
first iteration of memmap_init_reserved_pages().

Huacai

> > to MAX_NUMNODES, which causes NODE_DATA(nid) be a NULL dereference in
> "making NODE_DATA(nid) a NULL ..."
> > reserve_bootmem_region() -> init_reserved_page(). So set all reserved
> > memblocks on Node#0 at initialization to avoid this panic.
> >
> > Reported-by: WANG Xuerui <git@xen0n.name>
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > ---
> >   arch/loongarch/kernel/mem.c | 4 +++-
> >   1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/loongarch/kernel/mem.c b/arch/loongarch/kernel/mem.c
> > index 4a4107a6a965..aed901c57fb4 100644
> > --- a/arch/loongarch/kernel/mem.c
> > +++ b/arch/loongarch/kernel/mem.c
> > @@ -50,7 +50,6 @@ void __init memblock_init(void)
> >       }
> >
> >       memblock_set_current_limit(PFN_PHYS(max_low_pfn));
> > -     memblock_set_node(0, PHYS_ADDR_MAX, &memblock.memory, 0);
> >
> >       /* Reserve the first 2MB */
> >       memblock_reserve(PHYS_OFFSET, 0x200000);
> > @@ -58,4 +57,7 @@ void __init memblock_init(void)
> >       /* Reserve the kernel text/data/bss */
> >       memblock_reserve(__pa_symbol(&_text),
> >                        __pa_symbol(&_end) - __pa_symbol(&_text));
> > +
> > +     memblock_set_node(0, PHYS_ADDR_MAX, &memblock.memory, 0);
> > +     memblock_set_node(0, PHYS_ADDR_MAX, &memblock.reserved, 0);
> So the reordering is for being able to override the newly added
> memblocks' nids to 0, and additionally doing the same for
> memblock.reserved is the actual fix. Looks okay.
> >   }
>
> And I've tested the patch on the 2-way 3C5000L server, and it now
> correctly boots with deferred struct page init enabled. Thanks for
> providing such a quick fix!
>
> Tested-by: WANG Xuerui <git@xen0n.name>
> Reviewed-by: WANG Xuerui <git@xen0n.name>  # with nits addressed
>
> --
> WANG "xen0n" Xuerui
>
> Linux/LoongArch mailing list: https://lore.kernel.org/loongarch/
>
>
