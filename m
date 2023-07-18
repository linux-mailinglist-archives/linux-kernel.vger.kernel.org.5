Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03A97757F9A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 16:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233290AbjGROcl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 10:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233185AbjGROcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 10:32:08 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 029D71FC6
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 07:31:32 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-cc7863e7b82so3742154276.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 07:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689690691; x=1692282691;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rjpIeqow7KavnD0/SRlgq73LQricx6uLDxJMeUQiZ4Q=;
        b=PPKZxxlbX67hKoW02aRYjLt7DnZCbtwFM52WyDMWojmxap2OFcv4VhrJtfyoOPmaY5
         K3dJSnLIcwzPAUuVeAVZE15JOcbVf/Qk9xdCGyrEZo01HRCrRhKm9glg7WIENRWIlzkW
         1HXFRWSXZ2Fd8fnQpyJVPZFoZ46mf5PgkuFBA6+w2T2zku8i2GfGbTAe81O7LAsxB8A6
         kXkizNhQjyq3zL101Xsj2UU6LDY34TOft7WkNZNGNcEoEQwO84n5ZOBk2ijX78886e8/
         I66q5/Avp/9sseOt8mtApcdHGoPNhCPiUukAB3GtCkY6OGImiwuASUlXC0o61p15M4k8
         sYqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689690691; x=1692282691;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rjpIeqow7KavnD0/SRlgq73LQricx6uLDxJMeUQiZ4Q=;
        b=bke0xqtRQHT3LfYS352QXtRafTgeDI0GHmp9TTfVS2izfgouDKZ2Is5rWGGKvh/X6x
         +aB2ZigX08YOAnKW74NCaEkvLyIimdLdHmh4IPEh4hJhgrCzOlzDdqB1y5HQQ13xZTzL
         2ah6rZ8c/i3ivhUeDZbCzDCIE8n/91+AGM1cX4ZS+22/77rLnYhE0Tb5bsPRu48u5Zed
         C1GpypdKjhkCEn9v6HxrOspp8L693rBMMpMjX1nCqYc2n103mRFnulwvp3Tza+T5y2Ln
         JwiUNJ9nzeuES4y3CEH+oMXJU1rrzwbzoLV3Mf24JBqJ19muONb46mE2fZUZ8oVsNymL
         6fkQ==
X-Gm-Message-State: ABy/qLZ998rjZpjMcA7Yj6R/x9H9Vr8/rKQXaCTzNmgrGc74WxBwcr7n
        K8eUBz8QPZtF4a2T15nO7wpgK5KTBnLPdJhNimiYqBJN6ho=
X-Google-Smtp-Source: APBJJlHbP2K9+0wdcMRs1ip81cmcwyNZLOlC7o4iriCt43sinSc0iTV9tvvNKQBkROzB3Os0KlriLnI/3+rVCADyVIc=
X-Received: by 2002:a5b:4d2:0:b0:cf0:8fde:c326 with SMTP id
 u18-20020a5b04d2000000b00cf08fdec326mr35365ybp.42.1689690691401; Tue, 18 Jul
 2023 07:31:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230710141408.9998-1-zhiguangni01@gmail.com>
In-Reply-To: <20230710141408.9998-1-zhiguangni01@gmail.com>
From:   Liam Ni <zhiguangni01@gmail.com>
Date:   Tue, 18 Jul 2023 22:31:20 +0800
Message-ID: <CACZJ9cXGhMhmVCJ6Yn9GHGjY3KAGi+Px9Sr63_+inwU6Fg99nA@mail.gmail.com>
Subject: Re: [PATCH V3] [PATCH V3] NUMA:Improve the efficiency of calculating
 pages loss
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        loongarch@lists.linux.dev
Cc:     zhoubinbin@loongson.cn, chenfeiyang@loongson.cn,
        jiaxun.yang@flygoat.com, rppt@kernel.org,
        akpm@linux-foundation.org, hpa@zytor.com, x86@kernel.org,
        bp@alien8.de, mingo@redhat.com, tglx@linutronix.de,
        peterz@infradead.org, luto@kernel.org, dave.hansen@linux.intel.com,
        kernel@xen0n.name, chenhuacai@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Friendly ping

On Mon, 10 Jul 2023 at 22:14, Liam Ni <zhiguangni01@gmail.com> wrote:
>
> The number of pages in memblock that doesn't have the node
> assigned,which also means that these pages are not in numa_info.
> So these pages can represent the number of lose pages.
>
> V2:https://lore.kernel.org/all/20230619075315.49114-1-zhiguangni01@gmail.com/
> V1:https://lore.kernel.org/all/20230615142016.419570-1-zhiguangni01@gmail.com/
>
> Signed-off-by: Liam Ni <zhiguangni01@gmail.com>
> ---
>  arch/loongarch/kernel/numa.c | 23 ++++++++---------------
>  arch/x86/mm/numa.c           | 26 +++++++-------------------
>  include/linux/mm.h           |  1 +
>  mm/mm_init.c                 | 20 ++++++++++++++++++++
>  4 files changed, 36 insertions(+), 34 deletions(-)
>
> diff --git a/arch/loongarch/kernel/numa.c b/arch/loongarch/kernel/numa.c
> index 708665895b47..0239891e4d19 100644
> --- a/arch/loongarch/kernel/numa.c
> +++ b/arch/loongarch/kernel/numa.c
> @@ -262,25 +262,18 @@ static void __init node_mem_init(unsigned int node)
>   * Sanity check to catch more bad NUMA configurations (they are amazingly
>   * common).  Make sure the nodes cover all memory.
>   */
> -static bool __init numa_meminfo_cover_memory(const struct numa_meminfo *mi)
> +static bool __init memblock_validate_numa_coverage(const u64 limit)
>  {
> -       int i;
> -       u64 numaram, biosram;
> +       u64 lo_pg;
>
> -       numaram = 0;
> -       for (i = 0; i < mi->nr_blks; i++) {
> -               u64 s = mi->blk[i].start >> PAGE_SHIFT;
> -               u64 e = mi->blk[i].end >> PAGE_SHIFT;
> +       lo_pg = max_pfn - calculate_without_node_pages_in_range();
>
> -               numaram += e - s;
> -               numaram -= __absent_pages_in_range(mi->blk[i].nid, s, e);
> -               if ((s64)numaram < 0)
> -                       numaram = 0;
> +       /* We seem to lose 3 pages somewhere. Allow 1M of slack. */
> +       if (lo_pg >= limit) {
> +               pr_err("NUMA: We lost 1m size page.\n");
> +               return false;
>         }
> -       max_pfn = max_low_pfn;
> -       biosram = max_pfn - absent_pages_in_range(0, max_pfn);
>
> -       BUG_ON((s64)(biosram - numaram) >= (1 << (20 - PAGE_SHIFT)));
>         return true;
>  }
>
> @@ -428,7 +421,7 @@ int __init init_numa_memory(void)
>                 return -EINVAL;
>
>         init_node_memblock();
> -       if (numa_meminfo_cover_memory(&numa_meminfo) == false)
> +       if (memblock_validate_numa_coverage(SZ_1M) == false)
>                 return -EINVAL;
>
>         for_each_node_mask(node, node_possible_map) {
> diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
> index 2aadb2019b4f..14feec144675 100644
> --- a/arch/x86/mm/numa.c
> +++ b/arch/x86/mm/numa.c
> @@ -451,30 +451,18 @@ EXPORT_SYMBOL(__node_distance);
>   * Sanity check to catch more bad NUMA configurations (they are amazingly
>   * common).  Make sure the nodes cover all memory.
>   */
> -static bool __init numa_meminfo_cover_memory(const struct numa_meminfo *mi)
> +static bool __init memblock_validate_numa_coverage(const u64 limit)
>  {
> -       u64 numaram, e820ram;
> -       int i;
> +       u64 lo_pg;
>
> -       numaram = 0;
> -       for (i = 0; i < mi->nr_blks; i++) {
> -               u64 s = mi->blk[i].start >> PAGE_SHIFT;
> -               u64 e = mi->blk[i].end >> PAGE_SHIFT;
> -               numaram += e - s;
> -               numaram -= __absent_pages_in_range(mi->blk[i].nid, s, e);
> -               if ((s64)numaram < 0)
> -                       numaram = 0;
> -       }
> -
> -       e820ram = max_pfn - absent_pages_in_range(0, max_pfn);
> +       lo_pg = max_pfn - calculate_without_node_pages_in_range();
>
>         /* We seem to lose 3 pages somewhere. Allow 1M of slack. */
> -       if ((s64)(e820ram - numaram) >= (1 << (20 - PAGE_SHIFT))) {
> -               printk(KERN_ERR "NUMA: nodes only cover %LuMB of your %LuMB e820 RAM. Not used.\n",
> -                      (numaram << PAGE_SHIFT) >> 20,
> -                      (e820ram << PAGE_SHIFT) >> 20);
> +       if (lo_pg >= limit) {
> +               pr_err("NUMA: We lost 1m size page.\n");
>                 return false;
>         }
> +
>         return true;
>  }
>
> @@ -583,7 +571,7 @@ static int __init numa_register_memblks(struct numa_meminfo *mi)
>                         return -EINVAL;
>                 }
>         }
> -       if (!numa_meminfo_cover_memory(mi))
> +       if (!memblock_validate_numa_coverage(SZ_1M))
>                 return -EINVAL;
>
>         /* Finally register nodes. */
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 0daef3f2f029..b32457ad1ae3 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -3043,6 +3043,7 @@ unsigned long __absent_pages_in_range(int nid, unsigned long start_pfn,
>                                                 unsigned long end_pfn);
>  extern unsigned long absent_pages_in_range(unsigned long start_pfn,
>                                                 unsigned long end_pfn);
> +extern unsigned long calculate_without_node_pages_in_range(void);
>  extern void get_pfn_range_for_nid(unsigned int nid,
>                         unsigned long *start_pfn, unsigned long *end_pfn);
>
> diff --git a/mm/mm_init.c b/mm/mm_init.c
> index 3ddd18a89b66..13a4883787e3 100644
> --- a/mm/mm_init.c
> +++ b/mm/mm_init.c
> @@ -1132,6 +1132,26 @@ static void __init adjust_zone_range_for_zone_movable(int nid,
>         }
>  }
>
> +/**
> + * @start_pfn: The start PFN to start searching for holes
> + * @end_pfn: The end PFN to stop searching for holes
> + *
> + * Return: Return the number of page frames without node assigned within a range.
> + */
> +unsigned long __init calculate_without_node_pages_in_range(void)
> +{
> +       unsigned long num_pages;
> +       unsigned long start_pfn, end_pfn;
> +       int nid, i;
> +
> +       for_each_mem_pfn_range(i, MAX_NUMNODES, &start_pfn, &end_pfn, &nid) {
> +               if (nid == NUMA_NO_NODE)
> +                       num_pages += end_pfn - start_pfn;
> +       }
> +
> +       return num_pages;
> +}
> +
>  /*
>   * Return the number of holes in a range on a node. If nid is MAX_NUMNODES,
>   * then all holes in the requested range will be accounted for.
> --
> 2.25.1
>
