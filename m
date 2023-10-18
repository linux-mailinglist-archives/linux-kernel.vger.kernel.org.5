Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB4627CDB0F
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 13:57:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbjJRL5B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 07:57:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbjJRL47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 07:56:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6F5A112
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 04:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697630171;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DC7/vk7dP6oRIanNIVB76oxiPb7iU/8UpfTJ3/llL28=;
        b=Qwqp368mta+BJw4pY9VVIdvkP8iftz6CwVIG6isvwQifRyPzDGXDcNVaVQq2ytvOfkLx/0
        htrVYTHwgAaK4GimXhi8aOmuxjWqpnZuxYFp7aRp0dQ0nytYlTR+Lj/L3dFQRaSOpb4lji
        DNFt6PFstSTxlgJdpjm+vKMjQ7t+pJA=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-480-1LU317xwNpCI9unHY6dyVA-1; Wed, 18 Oct 2023 07:56:10 -0400
X-MC-Unique: 1LU317xwNpCI9unHY6dyVA-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2c51d0f97e3so33284451fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 04:56:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697630169; x=1698234969;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DC7/vk7dP6oRIanNIVB76oxiPb7iU/8UpfTJ3/llL28=;
        b=dc1PvudFjVXfpuabRnwA1lEF5RZz56nKIfIsBG55B+LtCqaqayCzFhr208TsDMtstg
         ldXQvCxPlsBRHa4To4IlMhgMb9p+LoEIUiLF97IKbh2BGY71G43DL/7wuGI6uS2WFjWn
         BZdwSkpgGcntI3PBKCVx/WTlTDGpExNyNyD2ncAceU8Va8wObV3NQHIjx6iS5XOoBuRA
         sldxFW9vXdHS5NZh1ukLFxvDjkhIIvJotRuXuodW2+VkzMyxiUrOoJRJNc78mavxhhNp
         aCL4P8RQ+/XsJELgJvTuDB1cXIJWi0rRuxXFUz37haUDnPIW92x491mNzkX+63vDvtB1
         9cVw==
X-Gm-Message-State: AOJu0YwroO2NLPxqA5+Qi/zxSGIBad+pS6R4Wr4WwBJX+iMX1M4QHrm/
        rOuagJfzzbR3SodGxcGiDyNS+2ZW6T8XyMvAAtpLjueGjEUXhTYcRYwu9CM2xFJbwt/QDf3toZw
        w/y/N2v+MlyEU7bnUt66dVOZsB/pwar/i8m4PqmQX
X-Received: by 2002:a05:651c:2125:b0:2c5:24a8:c22d with SMTP id a37-20020a05651c212500b002c524a8c22dmr5030320ljq.3.1697630169099;
        Wed, 18 Oct 2023 04:56:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFUDvEZOuEJOYIcDuFZMfpkkOMV3E7K+kqYYpIEhH+i6S9WOeZz7MEeBQbHWN5Bm4gIOzCQMbs98DbAfm4w/RA=
X-Received: by 2002:a05:651c:2125:b0:2c5:24a8:c22d with SMTP id
 a37-20020a05651c212500b002c524a8c22dmr5030303ljq.3.1697630168731; Wed, 18 Oct
 2023 04:56:08 -0700 (PDT)
MIME-Version: 1.0
References: <20231017062215.171670-1-rppt@kernel.org>
In-Reply-To: <20231017062215.171670-1-rppt@kernel.org>
From:   Mario Casquero <mcasquer@redhat.com>
Date:   Wed, 18 Oct 2023 13:55:57 +0200
Message-ID: <CAMXpfWuz_dh-oNw0OPwA+3cH_8+APe_gxikMWrXgT2x+maAaJA@mail.gmail.com>
Subject: Re: [PATCH] x86/mm: drop 4MB restriction on minimal NUMA node size
To:     Mike Rapoport <rppt@kernel.org>
Cc:     x86@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch has been successfully tested by QE. Start a VM with two
NUMA nodes, one of them with less than 2M of memory. Check there is no
kernel panic and the VM boots up smoothly.
Tested-by: Mario Casquero <mcasquer@redhat.com>

BR,
Mario




On Tue, Oct 17, 2023 at 8:24=E2=80=AFAM Mike Rapoport <rppt@kernel.org> wro=
te:
>
> From: "Mike Rapoport (IBM)" <rppt@kernel.org>
>
> Qi Zheng reports crashes in a production environment and provides a
> simplified example as a reproducer:
>
>   For example, if we use qemu to start a two NUMA node kernel,
>   one of the nodes has 2M memory (less than NODE_MIN_SIZE),
>   and the other node has 2G, then we will encounter the
>   following panic:
>
>   [    0.149844] BUG: kernel NULL pointer dereference, address: 000000000=
0000000
>   [    0.150783] #PF: supervisor write access in kernel mode
>   [    0.151488] #PF: error_code(0x0002) - not-present page
>   <...>
>   [    0.156056] RIP: 0010:_raw_spin_lock_irqsave+0x22/0x40
>   <...>
>   [    0.169781] Call Trace:
>   [    0.170159]  <TASK>
>   [    0.170448]  deactivate_slab+0x187/0x3c0
>   [    0.171031]  ? bootstrap+0x1b/0x10e
>   [    0.171559]  ? preempt_count_sub+0x9/0xa0
>   [    0.172145]  ? kmem_cache_alloc+0x12c/0x440
>   [    0.172735]  ? bootstrap+0x1b/0x10e
>   [    0.173236]  bootstrap+0x6b/0x10e
>   [    0.173720]  kmem_cache_init+0x10a/0x188
>   [    0.174240]  start_kernel+0x415/0x6ac
>   [    0.174738]  secondary_startup_64_no_verify+0xe0/0xeb
>   [    0.175417]  </TASK>
>   [    0.175713] Modules linked in:
>   [    0.176117] CR2: 0000000000000000
>
> The crashes happen because of inconsistency between nodemask that has
> nodes with less than 4MB as memoryless and the actual memory fed into
> core mm.
>
> The commit 9391a3f9c7f1 ("[PATCH] x86_64: Clear more state when ignoring
> empty node in SRAT parsing") that introduced minimal size of a NUMA node
> does not explain why a node size cannot be less than 4MB and what boot
> failures this restriction might fix.
>
> Since then a lot has changed and core mm won't confuse badly about small
> node sizes.
>
> Drop the limitation for the minimal node size.
>
> Reported-by: Qi Zheng <zhengqi.arch@bytedance.com>
> Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
> Acked-by: David Hildenbrand <david@redhat.com>
> Acked-by: Michal Hocko <mhocko@suse.com>
> Link: https://lore.kernel.org/all/20230212110305.93670-1-zhengqi.arch@byt=
edance.com/
> ---
>  arch/x86/include/asm/numa.h | 7 -------
>  arch/x86/mm/numa.c          | 7 -------
>  2 files changed, 14 deletions(-)
>
> diff --git a/arch/x86/include/asm/numa.h b/arch/x86/include/asm/numa.h
> index e3bae2b60a0d..ef2844d69173 100644
> --- a/arch/x86/include/asm/numa.h
> +++ b/arch/x86/include/asm/numa.h
> @@ -12,13 +12,6 @@
>
>  #define NR_NODE_MEMBLKS                (MAX_NUMNODES*2)
>
> -/*
> - * Too small node sizes may confuse the VM badly. Usually they
> - * result from BIOS bugs. So dont recognize nodes as standalone
> - * NUMA entities that have less than this amount of RAM listed:
> - */
> -#define NODE_MIN_SIZE (4*1024*1024)
> -
>  extern int numa_off;
>
>  /*
> diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
> index 2aadb2019b4f..55e3d895f15c 100644
> --- a/arch/x86/mm/numa.c
> +++ b/arch/x86/mm/numa.c
> @@ -601,13 +601,6 @@ static int __init numa_register_memblks(struct numa_=
meminfo *mi)
>                 if (start >=3D end)
>                         continue;
>
> -               /*
> -                * Don't confuse VM with a node that doesn't have the
> -                * minimum amount of memory:
> -                */
> -               if (end && (end - start) < NODE_MIN_SIZE)
> -                       continue;
> -
>                 alloc_node_data(nid);
>         }
>
>
> base-commit: 94f6f0550c625fab1f373bb86a6669b45e9748b3
> --
> 2.39.2
>

