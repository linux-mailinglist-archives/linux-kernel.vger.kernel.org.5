Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 663427EB4A7
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 17:21:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233612AbjKNQVg convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 14 Nov 2023 11:21:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjKNQVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 11:21:34 -0500
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E56B210A;
        Tue, 14 Nov 2023 08:21:31 -0800 (PST)
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-1eb6c559ab4so3408706fac.0;
        Tue, 14 Nov 2023 08:21:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699978891; x=1700583691;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DuNuFoZ4uO4dR0HE9qyyNud2qzT4ASdzzadzSQPKUKc=;
        b=sJc1WfFF5pCahokV2+mhQaaAe/63p57Bm2ftKA7rmQ4+Wj3CoNvqAEPL0aj3BGdTV6
         D8SNXA5ufnuhIUp4Bo/CLCGuQ1MfxbDUg+GdmAgwzESre2sOh+P5rBNovdlQhut1F9Qh
         8yGHYJ8oOW97/6asymD+m87Qm9BNKZo/eqjzyPyLFS5RVegRpO7KnhUO/ETDeW2DK2Ek
         +K27nawFDjvB/KrS6m5o+tWcYcv5kviiAZFCMMFTjDzclePkDwPywQUozJeQLByypoW+
         IZK82NStR3VSdHPMi50B3MubmXagHyqHBAyIuCPFwMGsDW7dqG3NMn1XedWPxrzFraE+
         s7gA==
X-Gm-Message-State: AOJu0YzDqD2HcTTsEE/fXxrCwnkYT6HFpMsQlR9WeTvajoOyfrpjJ634
        apQgg8ZK8F0Vu2E4sIOPXqtwFZ3mirSKog==
X-Google-Smtp-Source: AGHT+IFEf60/iiS/fuFQRnqTMDKAr11l7xBhVr9RX2WtN2TWbGubqSJYssCXWrC+Xq67+8QxTRytdw==
X-Received: by 2002:a05:6870:2b04:b0:1e9:94c1:9179 with SMTP id ld4-20020a0568702b0400b001e994c19179mr14377190oab.21.1699978891043;
        Tue, 14 Nov 2023 08:21:31 -0800 (PST)
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com. [209.85.167.176])
        by smtp.gmail.com with ESMTPSA id zh16-20020a0568716b9000b001f38fa43830sm1412360oab.38.2023.11.14.08.21.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Nov 2023 08:21:30 -0800 (PST)
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3b2e73a17a0so3527030b6e.3;
        Tue, 14 Nov 2023 08:21:30 -0800 (PST)
X-Received: by 2002:a05:6358:7246:b0:169:a9d4:3faf with SMTP id
 i6-20020a056358724600b00169a9d43fafmr3969586rwa.11.1699978890353; Tue, 14 Nov
 2023 08:21:30 -0800 (PST)
MIME-Version: 1.0
References: <20231023025125.90972-1-liushixin2@huawei.com>
In-Reply-To: <20231023025125.90972-1-liushixin2@huawei.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 14 Nov 2023 17:21:18 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWj0UzwNaxUvcocTfh481qRJpOWwXxsJCTJfu1oCqvgdA@mail.gmail.com>
Message-ID: <CAMuHMdWj0UzwNaxUvcocTfh481qRJpOWwXxsJCTJfu1oCqvgdA@mail.gmail.com>
Subject: Re: [PATCH -next] mm/kmemleak: move the initialisation of object to __link_object
To:     Liu Shixin <liushixin2@huawei.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Patrick Wang <patrick.wang.shcn@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Liu,

On Mon, Oct 23, 2023 at 3:52 AM Liu Shixin <liushixin2@huawei.com> wrote:
> Leave __alloc_object() just do the actual allocation and __link_object()
> do the full initialisation.
>
> Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Liu Shixin <liushixin2@huawei.com>

Thanks for your patch, which is now commit 245245c2fffd0050
("mm/kmemleak: move the initialisation of object to __link_object")
in v6.7-rc1.

I have bisected to this commit the BUG splat below (seen on various
platforms).  Reverting this commit fixes the issue.

 Memory: 7923468K/8257536K available (9024K kernel code, 5144K rwdata,
4088K rodata, 3072K init, 18331K bss, 268532K reserved, 65536K
cma-reserved)
 SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
+
+=============================
+[ BUG: Invalid wait context ]
+6.6.0-rc4-white-hawk-00387-g245245c2fffd #192 Not tainted
+-----------------------------
+swapper/0 is trying to lock:
+ffffffc0814bbed8 (&zone->lock){....}-{3:3}, at: __rmqueue_pcplist+0x4ac/0x53c
+other info that might help us debug this:
+context-{5:5}
+3 locks held by swapper/0:
+ #0: ffffffc0813cd720 (slab_mutex){....}-{4:4}, at:
kmem_cache_create_usercopy+0xac/0x2e0
+ #1: ffffffc0813d93e8 (kmemleak_lock){....}-{2:2}, at:
__create_object+0x48/0x98
+ #2: ffffff86bef6cc98 (&pcp->lock){....}-{3:3}, at:
get_page_from_freelist+0x184/0x7c0
+stack backtrace:
+CPU: 0 PID: 0 Comm: swapper Not tainted
6.6.0-rc4-white-hawk-00387-g245245c2fffd #192
+Hardware name: Renesas White Hawk CPU and Breakout boards based on
r8a779g0 (DT)
+Call trace:
+ dump_backtrace+0xac/0xe4
+ show_stack+0x14/0x20
+ dump_stack_lvl+0x68/0x94
+ dump_stack+0x14/0x1c
+ __lock_acquire+0x390/0xffc
+ lock_acquire+0x230/0x28c
+ _raw_spin_lock_irqsave+0x54/0x70
+ __rmqueue_pcplist+0x4ac/0x53c
+ get_page_from_freelist+0x2a8/0x7c0
+ __alloc_pages+0xf4/0x9f8
+ __stack_depot_save+0x178/0x3c8
+ stack_depot_save+0x10/0x18
+ set_track_prepare+0x44/0x70
+ __link_object+0xd0/0x220
+ __create_object+0x64/0x98
+ kmemleak_alloc+0x28/0x34
+ slab_post_alloc_hook.constprop.0+0xbc/0xc4
+ kmem_cache_alloc+0xd4/0x158
+ kmem_cache_create_usercopy+0x1c8/0x2e0
+ kmem_cache_create+0x18/0x20
+ kmemleak_init+0x74/0xfc
+ mm_core_init+0x214/0x250
+ start_kernel+0x2cc/0x4ec
+ __primary_switched+0xb4/0xbc
 trace event string verifier disabled
 Running RCU self tests

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
