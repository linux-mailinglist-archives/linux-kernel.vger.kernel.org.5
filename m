Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32A8A7BC767
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 14:05:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343921AbjJGMFC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 08:05:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343899AbjJGMFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 08:05:01 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77658B9
        for <linux-kernel@vger.kernel.org>; Sat,  7 Oct 2023 05:04:58 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-51e28cac164so8880553a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 07 Oct 2023 05:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696680296; x=1697285096; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZP8LTpVBDLLcyeu4A3mcPz76KkhgS/D8yTcePuj1WMU=;
        b=U5uUpjQKN0jAKIBRziSle3Lcy/Yyv+3CamZ8CO/IvzhVbzr1U/eID5HP81KoIqMP5g
         g85ntfjlq3BKSeJwD4H9wxtspMhmOZmOrgnLkFXFl+Rk6tLzI9Ni816VXDZE+s1ZTsIr
         8LvaqqgTsM72/GD4PYU+djHyAuv5CXaC7fmg/muWd2d/YJPZ03j+pIlRvhgpRBia8yTX
         anVHFXVirNRUAWNBmPO6VRBW+h86uG/xdz8cq09Q9XsJaoKYx+R9/DTfhdB/d1/1XI2p
         jDj43TPJLe6Bz+XrJxI2KT3VDQk19ZKoyP538jaQyi9Q3Lt4tobHjscODwXeqSsB1N89
         Pvkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696680296; x=1697285096;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZP8LTpVBDLLcyeu4A3mcPz76KkhgS/D8yTcePuj1WMU=;
        b=ORsvK7d5VxVokP2L0d+oV9DR2tMF/pKDyGn8rL/Lm/W8pvPvPeNao/q2f0XOnGxMvl
         6XtiFpbwGv05GUaGJtfF1DTo8NGi604mJEmRMMNhfhruE8OxDoVkXPMJ/7H8RhoYQn3w
         nQqVf9BporFq35MnpwI8sQi5/HQ4txQJIYcQWJWOEOezyp4ZDPq8UZ2woq50n9R/TWAx
         I9nrUwGHV45GsQbG9CWY/FWY9CQ9wZBTsVPV0nMQP108a6wRfZstfXVxZL51OY7bkNXF
         thsBUVG/Hl05ddWmT3s/ue0dJUTIbBcr8JOYLqq3EEMCE90sRbnFJhiZpV/IRkmcTmBW
         b1Vg==
X-Gm-Message-State: AOJu0YwuJFEaXBAcF0XQvaUzNoH0Bj4qHuINd/lISf4hqNW2tZcENApq
        UL/GBZeMT4F+NntJBEsXEaGsU4w7mWGCd16FYyVF/iVa
X-Google-Smtp-Source: AGHT+IGyaugT+Xo2Bq2OhoYGX5SASkWncFbebvW1Y2JhtB3NMYJ1B822McR+Ftu/d2gCEGc0vctQGqPNCwj6eSq8Gjg=
X-Received: by 2002:a17:906:4a03:b0:9b2:be2f:e31a with SMTP id
 w3-20020a1709064a0300b009b2be2fe31amr8668474eju.31.1696680296183; Sat, 07 Oct
 2023 05:04:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230911133852.2545-1-zhiguangni01@gmail.com>
In-Reply-To: <20230911133852.2545-1-zhiguangni01@gmail.com>
From:   Liam Ni <zhiguangni01@gmail.com>
Date:   Sat, 7 Oct 2023 20:04:45 +0800
Message-ID: <CACZJ9cXvpw0T_0n5uzucTxK19r05-yV=irJ8OvXkZz6bLW8qBw@mail.gmail.com>
Subject: Re: [PATCH V4] NUMA:Improve the efficiency of calculating pages loss
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, rppt@kernel.org
Cc:     dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, akpm@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Friendly Ping

On Mon, 11 Sept 2023 at 21:39, Liam Ni <zhiguangni01@gmail.com> wrote:
>
> Optimize the way of calculating missing pages.
>
> In the previous implementation, We calculate missing pages as follows:
> 1. calculate numaram by traverse all the numa_meminfo's and for each of
> them traverse all the regions in memblock.memory to prepare for
> counting missing pages.
>
> 2. Traverse all the regions in memblock.memory again to get e820ram.
>
> 3. the missing page is (e820ram - numaram )
>
> But,it's enough to count memory in =E2=80=98memblock.memory=E2=80=99 that=
 doesn't have
> the node assigned.
>
> V3:https://lore.kernel.org/all/CACZJ9cUXiWxDb6hF4JFhWe7Np82k6LopVQ+_AoGFO=
ccN4kjJqA@mail.gmail.com/#r
> V2:https://lore.kernel.org/all/20230619075315.49114-1-zhiguangni01@gmail.=
com/
> V1:https://lore.kernel.org/all/20230615142016.419570-1-zhiguangni01@gmail=
.com/
>
> Signed-off-by: Liam Ni <zhiguangni01@gmail.com>
> ---
>  arch/x86/mm/numa.c       | 33 +--------------------------------
>  include/linux/memblock.h |  1 +
>  mm/memblock.c            | 21 +++++++++++++++++++++
>  3 files changed, 23 insertions(+), 32 deletions(-)
>
> diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
> index 2aadb2019b4f..ee5f08adfaf6 100644
> --- a/arch/x86/mm/numa.c
> +++ b/arch/x86/mm/numa.c
> @@ -447,37 +447,6 @@ int __node_distance(int from, int to)
>  }
>  EXPORT_SYMBOL(__node_distance);
>
> -/*
> - * Sanity check to catch more bad NUMA configurations (they are amazingl=
y
> - * common).  Make sure the nodes cover all memory.
> - */
> -static bool __init numa_meminfo_cover_memory(const struct numa_meminfo *=
mi)
> -{
> -       u64 numaram, e820ram;
> -       int i;
> -
> -       numaram =3D 0;
> -       for (i =3D 0; i < mi->nr_blks; i++) {
> -               u64 s =3D mi->blk[i].start >> PAGE_SHIFT;
> -               u64 e =3D mi->blk[i].end >> PAGE_SHIFT;
> -               numaram +=3D e - s;
> -               numaram -=3D __absent_pages_in_range(mi->blk[i].nid, s, e=
);
> -               if ((s64)numaram < 0)
> -                       numaram =3D 0;
> -       }
> -
> -       e820ram =3D max_pfn - absent_pages_in_range(0, max_pfn);
> -
> -       /* We seem to lose 3 pages somewhere. Allow 1M of slack. */
> -       if ((s64)(e820ram - numaram) >=3D (1 << (20 - PAGE_SHIFT))) {
> -               printk(KERN_ERR "NUMA: nodes only cover %LuMB of your %Lu=
MB e820 RAM. Not used.\n",
> -                      (numaram << PAGE_SHIFT) >> 20,
> -                      (e820ram << PAGE_SHIFT) >> 20);
> -               return false;
> -       }
> -       return true;
> -}
> -
>  /*
>   * Mark all currently memblock-reserved physical memory (which covers th=
e
>   * kernel's own memory ranges) as hot-unswappable.
> @@ -583,7 +552,7 @@ static int __init numa_register_memblks(struct numa_m=
eminfo *mi)
>                         return -EINVAL;
>                 }
>         }
> -       if (!numa_meminfo_cover_memory(mi))
> +       if (!memblock_validate_numa_coverage(SZ_1M))
>                 return -EINVAL;
>
>         /* Finally register nodes. */
> diff --git a/include/linux/memblock.h b/include/linux/memblock.h
> index 1c1072e3ca06..0c3a193ebc58 100644
> --- a/include/linux/memblock.h
> +++ b/include/linux/memblock.h
> @@ -120,6 +120,7 @@ int memblock_physmem_add(phys_addr_t base, phys_addr_=
t size);
>  void memblock_trim_memory(phys_addr_t align);
>  bool memblock_overlaps_region(struct memblock_type *type,
>                               phys_addr_t base, phys_addr_t size);
> +bool memblock_validate_numa_coverage(const u64 limit);
>  int memblock_mark_hotplug(phys_addr_t base, phys_addr_t size);
>  int memblock_clear_hotplug(phys_addr_t base, phys_addr_t size);
>  int memblock_mark_mirror(phys_addr_t base, phys_addr_t size);
> diff --git a/mm/memblock.c b/mm/memblock.c
> index 0863222af4a4..8f61f868bec1 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -734,6 +734,27 @@ int __init_memblock memblock_add(phys_addr_t base, p=
hys_addr_t size)
>         return memblock_add_range(&memblock.memory, base, size, MAX_NUMNO=
DES, 0);
>  }
>
> +bool __init_memblock memblock_validate_numa_coverage(const u64 limit)
> +{
> +       unsigned long lose_pg =3D 0;
> +       unsigned long start_pfn, end_pfn;
> +       int nid, i;
> +
> +       /* calculate lose page */
> +       for_each_mem_pfn_range(i, MAX_NUMNODES, &start_pfn, &end_pfn, &ni=
d) {
> +               if (nid =3D=3D NUMA_NO_NODE)
> +                       lose_pg +=3D end_pfn - start_pfn;
> +       }
> +
> +       if (lose_pg >=3D limit) {
> +               pr_err("NUMA: We lost %ld pages.\n", lose_pg);
> +               return false;
> +       }
> +
> +       return true;
> +}
> +
> +
>  /**
>   * memblock_isolate_range - isolate given range into disjoint memblocks
>   * @type: memblock type to isolate range for
> --
> 2.25.1
>
