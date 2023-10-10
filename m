Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAC8C7C042C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 21:11:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343866AbjJJTLf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 15:11:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343774AbjJJTLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 15:11:30 -0400
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EA11AF
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 12:11:28 -0700 (PDT)
Received: by mail-oo1-xc2d.google.com with SMTP id 006d021491bc7-5812eaed1eeso1089432eaf.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 12:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696965088; x=1697569888; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r9C33FK/mhypuEKRvbN96wMq7Q2blPztB7nZo12h8b8=;
        b=K99N8LMCFcezI03ZLMWZPuinFXtnVIXD+bigeH2El7rmulazD9AvhDe1XOTcfvGH3Q
         i1DSt2cNVbq8eXkFcbYcOs8/0GKKfGwNkGMrP9rYUmkltItfQkMqdp9HTdAAunhQNc4e
         BG0HqknB3SbpMNRMaeLXxK5/dY03aYgYJFaoGTLB6paO5aXDD637V/gWa5OlTUcTVSBo
         3KxL5sj6Y/a6GPdF5QYylqlUEoNy2dhT5uzFcdU7lHSquTHiTuulD0mVKbtrC4BSiobK
         8jzw5IDcGadDYY6wiXN12Z7RCyv3LnCycrLB+8w+po1jikl4LdwiwhVmcfhU9rODrEWM
         M1dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696965088; x=1697569888;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r9C33FK/mhypuEKRvbN96wMq7Q2blPztB7nZo12h8b8=;
        b=nNRb2G+awdhdj62UoNEips22X4/ClSbVJKkAzBlLs8IUAHpP5PJh+deKogXTW8mI17
         dJ4dbp0OB5phd+BPYgLtRvXzrvYZtvU3QPfUjp5EF6G3lcZ0YPSP2OKIpU4lAnQX32io
         2DXmPnvcs7cxWW3LAQ7u2/98p4e0Lii+CcIN3tePBHf3RBhWkn140KofvPp/7/Tr99sq
         QxKXOXC13DRRNzozd5EaqzZu7IfdQhleBYkZdBAod6DF8B4+fz26Rb9Oy/DJq2dWIw60
         pyWqcnCIqFgI+9Z5P1cWKZ4ooRgww/c38pQqwofhtmxgQqL4AC1Z/cpc1cJgX8gm3y/m
         MDvA==
X-Gm-Message-State: AOJu0YyNGRqLYQLdf7MQN3RL+eo5dP1DoOzs8bLEnJ8r9OmJSNe+qcUb
        m0xFkZtRBtuBmHCvUo8CG5VfYTgFGwm4sW76qkg=
X-Google-Smtp-Source: AGHT+IH6dRoUciMjgYLJk6PPxfjAtk7XfoSMwaSpFdWn4qtmxLsLRTU4XkvMLjfMaPaKXk1Dov3ncHoPahlMrRoARhY=
X-Received: by 2002:a05:6358:7246:b0:14f:9904:a17f with SMTP id
 i6-20020a056358724600b0014f9904a17fmr12015198rwa.15.1696965087737; Tue, 10
 Oct 2023 12:11:27 -0700 (PDT)
MIME-Version: 1.0
References: <20231009073748.159228-1-haibo.li@mediatek.com>
In-Reply-To: <20231009073748.159228-1-haibo.li@mediatek.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Tue, 10 Oct 2023 21:11:15 +0200
Message-ID: <CA+fCnZev8zdLV2Q4P5gyGEvLZpmpd5Afi8j3KAyHTFGKt5oTOg@mail.gmail.com>
Subject: Re: [PATCH v2] kasan:print the original fault addr when access
 invalid shadow
To:     Haibo Li <haibo.li@mediatek.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, xiaoming.yu@mediatek.com,
        Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 9, 2023 at 9:37=E2=80=AFAM Haibo Li <haibo.li@mediatek.com> wro=
te:
>
> when the checked address is illegal,the corresponding shadow address
> from kasan_mem_to_shadow may have no mapping in mmu table.
> Access such shadow address causes kernel oops.
> Here is a sample about oops on arm64(VA 39bit)
> with KASAN_SW_TAGS and KASAN_OUTLINE on:
>
> [ffffffb80aaaaaaa] pgd=3D000000005d3ce003, p4d=3D000000005d3ce003,
>     pud=3D000000005d3ce003, pmd=3D0000000000000000
> Internal error: Oops: 0000000096000006 [#1] PREEMPT SMP
> Modules linked in:
> CPU: 3 PID: 100 Comm: sh Not tainted 6.6.0-rc1-dirty #43
> Hardware name: linux,dummy-virt (DT)
> pstate: 80000005 (Nzcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=3D--)
> pc : __hwasan_load8_noabort+0x5c/0x90
> lr : do_ib_ob+0xf4/0x110
> ffffffb80aaaaaaa is the shadow address for efffff80aaaaaaaa.
> The problem is reading invalid shadow in kasan_check_range.
>
> The generic kasan also has similar oops.
>
> It only reports the shadow address which causes oops but not
> the original address.
>
> Commit 2f004eea0fc8("x86/kasan: Print original address on #GP")
> introduce to kasan_non_canonical_hook but limit it to KASAN_INLINE.
>
> This patch extends it to KASAN_OUTLINE mode.
>
> Signed-off-by: Haibo Li <haibo.li@mediatek.com>
> ---
> v2:
> - In view of the possible perf impact by checking shadow address,change
>    to use kasan_non_canonical_hook as it works after oops.
> ---
>  include/linux/kasan.h | 6 +++---
>  mm/kasan/report.c     | 4 +---
>  2 files changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/include/linux/kasan.h b/include/linux/kasan.h
> index 3df5499f7936..a707ee8b19ce 100644
> --- a/include/linux/kasan.h
> +++ b/include/linux/kasan.h
> @@ -466,10 +466,10 @@ static inline void kasan_free_module_shadow(const s=
truct vm_struct *vm) {}
>
>  #endif /* (CONFIG_KASAN_GENERIC || CONFIG_KASAN_SW_TAGS) && !CONFIG_KASA=
N_VMALLOC */
>
> -#ifdef CONFIG_KASAN_INLINE
> +#ifdef CONFIG_KASAN
>  void kasan_non_canonical_hook(unsigned long addr);
> -#else /* CONFIG_KASAN_INLINE */
> +#else /* CONFIG_KASAN */
>  static inline void kasan_non_canonical_hook(unsigned long addr) { }
> -#endif /* CONFIG_KASAN_INLINE */
> +#endif /* CONFIG_KASAN */
>
>  #endif /* LINUX_KASAN_H */
> diff --git a/mm/kasan/report.c b/mm/kasan/report.c
> index ca4b6ff080a6..3974e4549c3e 100644
> --- a/mm/kasan/report.c
> +++ b/mm/kasan/report.c
> @@ -621,9 +621,8 @@ void kasan_report_async(void)
>  }
>  #endif /* CONFIG_KASAN_HW_TAGS */
>
> -#ifdef CONFIG_KASAN_INLINE
>  /*
> - * With CONFIG_KASAN_INLINE, accesses to bogus pointers (outside the hig=
h
> + * With CONFIG_KASAN, accesses to bogus pointers (outside the high
>   * canonical half of the address space) cause out-of-bounds shadow memor=
y reads
>   * before the actual access. For addresses in the low canonical half of =
the
>   * address space, as well as most non-canonical addresses, that out-of-b=
ounds
> @@ -659,4 +658,3 @@ void kasan_non_canonical_hook(unsigned long addr)
>         pr_alert("KASAN: %s in range [0x%016lx-0x%016lx]\n", bug_type,
>                  orig_addr, orig_addr + KASAN_GRANULE_SIZE - 1);
>  }
> -#endif
> --
> 2.18.0
>

Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>

Thank you!

On a related note, I have debugged the reason why
kasan_non_canonical_hook sometimes doesn't get engaged properly for
the SW_TAGS mode. I'll post a fix next week.
