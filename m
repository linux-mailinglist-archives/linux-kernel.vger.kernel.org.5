Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD932808083
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 07:07:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377274AbjLGGHm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 01:07:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjLGGHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 01:07:40 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96A171AD
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 22:07:27 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-6cea5548eb2so281925b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 22:07:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1701929247; x=1702534047; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CntnxtK8Lx+9VhkTFQ4ebm7POn5Zxrcf29EHIgvNJN0=;
        b=WlI0GPF3I3dIcPgLOJ/7qXmQrMM8WI21QcwqWyg91OE/boodOo98D3t6WcXKhKAVOR
         dKpIQ0z7QK0AAW07+SOA0c0PSUsCkqe1qgtHDk9jDek0RQevs/oRU6+Bw0OqNOvSUEoS
         wtub83VOQjwltuNM2zPem6NFE7WP8Gcu6iXhiMFJMYinA0RyMdRbf57cRjQa+WNqweAi
         b1gCOHFTiRNbppc4zwTuhmzyJ/4xVOOyTggI1fXDhRYn6T1/l/5emr/9XS4hnClzRv+a
         DzQkPBIczn16tyrKbI9GkiL7OiVXZqmFTuTpRVRZm5V3gmCgn3YFp0eNndHH8Q2qD5Ak
         Q8mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701929247; x=1702534047;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CntnxtK8Lx+9VhkTFQ4ebm7POn5Zxrcf29EHIgvNJN0=;
        b=hGOOor1E3PcXJAMNczxB7Uk1a1KGxHlu8PzECQsZGnhFIbTnNk5nvVhSG+K5o/a/kx
         gptOB8rETCH60CFB5vqIronatRvWKM8+var/OyXqwXxznNbjgks+7B1wsK1YSJGwqsRg
         XRU3b5YgDyCjN3383tG14/XpOZPxjubC3zLyuPy5A8NRGqQfn2a6kE1xP+5ryiJuOwfY
         v7MjLSJVahJXKxc8R2XWQnMvlmVNFUEjhNxURzyO5OoouaYhNBrwD//QSAIBpvkJ8EzK
         APCI0MsdsdZrBnTSd/lReUMgLLZ4t56ti0bp5UKnncQYItwnCcwkWjVoSXlpSlv1iwoA
         Ct1w==
X-Gm-Message-State: AOJu0YwktxXUYhssVvM+sA/KCQYp3MBwhf8Uz+xotIJnvJ+5BT4pNUNY
        yQdd7of1Y8Owf/FIqVjBUvGfPc5yN4ED2jToeXXUsUc/wj1PYHLW
X-Google-Smtp-Source: AGHT+IHJu91Tjssa9ODu4I/8j76aunhpadRAahrgX9O537p/MfigaphqCAFaLUl6bs7BN+tpMxad9Bl3Ss9NAq9LwGM=
X-Received: by 2002:a05:6a20:a196:b0:18f:97c:8a40 with SMTP id
 r22-20020a056a20a19600b0018f097c8a40mr1783720pzk.107.1701929247028; Wed, 06
 Dec 2023 22:07:27 -0800 (PST)
MIME-Version: 1.0
References: <20231123065708.91345-1-luxu.kernel@bytedance.com>
In-Reply-To: <20231123065708.91345-1-luxu.kernel@bytedance.com>
From:   Xu Lu <luxu.kernel@bytedance.com>
Date:   Thu, 7 Dec 2023 14:07:15 +0800
Message-ID: <CAPYmKFvSXRo5d3T3OwJ6tZEer-8o=G3uUVrd7mXOFjGsfVPy3w@mail.gmail.com>
Subject: Re: [RFC PATCH V1 00/11] riscv: Introduce 64K base page
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, ardb@kernel.org, anup@brainfault.org,
        atishp@atishpatra.org
Cc:     dengliang.1214@bytedance.com, xieyongji@bytedance.com,
        lihangjing@bytedance.com, songmuchun@bytedance.com,
        punit.agrawal@bytedance.com, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A gentle ping.

On Thu, Nov 23, 2023 at 2:57=E2=80=AFPM Xu Lu <luxu.kernel@bytedance.com> w=
rote:
>
> Some existing architectures like ARM supports base page larger than 4K
> as their MMU supports more page sizes. Thus, besides hugetlb page and
> transparent huge page, there is another way for these architectures to
> enjoy the benefits of fewer TLB misses without worrying about cost of
> splitting and merging huge pages. However, on architectures with only
> 4K MMU, larger base page is unavailable now.
>
> This patch series attempts to break through the limitation of MMU and
> supports larger base page on RISC-V, which only supports 4K page size
> now.
>
> The key idea to implement larger base page based on 4K MMU is to
> decouple the MMU page from the base page in view of kernel mm, which we
> denote as software page. In contrary to software page, we denote the MMU
> page as hardware page. Below is the difference between these two kinds
> of pages.
>
> 1. Kernel memory management module manages, allocates and maps memory at
> a granularity of software page, which should not be restricted by
> MMU and can be larger than hardware page.
>
> 2. Architecture page table operations should be carried out from MMU's
> perspective and page table entries are encoded at a granularity of
> hardware page, which is 4K on RISC-V MMU now.
>
> The main work to decouple these two kinds of pages lies in architecture
> code. For example, we turn the pte_t struct to an array of page table
> entries to match it with software page which can be larger than hardware
> page, and adapt the page table operations accordingly. For 64K software
> base page, the pte_t struct now contains 16 contiguous page table
> entries which point to 16 contiguous 4K hardware pages.
>
> To achieve the benefits of large base page, we applies Svnapot for each
> base page's mapping. The Svnapot extension on RISC-V is like contiguous
> PTE on ARM64. It allows ptes of a naturally aligned power-of 2 size
> memory range be encoded in the same format to save the TLB space.
>
> This patch series is the first version and is based on v6.7-rc1. This
> version supports both bare metal and virtualization scenarios.
>
> In the next versions, we will continue on the following works:
>
> 1. Reduce the memory usage of page table page as it only uses 4K space
> while costs a whole base page.
>
> 2. When IMSIC interrupt file is smaller than 64K, extra isolation
> measures for the interrupt file are needed. (S)PMP and IOPMP may be good
> choices.
>
> 3. More consideration is needed to make this patch series collaborate
> with folios better.
>
> 4. Support 64K base page on IOMMU.
>
> 5. The performance test is on schedule to verify the actual performance
> improvement and the decrease in TLB miss rate.
>
> Thanks in advance for comments.
>
> Xu Lu (11):
>   mm: Fix misused APIs on huge pte
>   riscv: Introduce concept of hardware base page
>   riscv: Adapt pte struct to gap between hw page and sw page
>   riscv: Adapt pte operations to gap between hw page and sw page
>   riscv: Decouple pmd operations and pte operations
>   riscv: Distinguish pmd huge pte and napot huge pte
>   riscv: Adapt satp operations to gap between hw page and sw page
>   riscv: Apply Svnapot for base page mapping
>   riscv: Adjust fix_btmap slots number to match variable page size
>   riscv: kvm: Adapt kvm to gap between hw page and sw page
>   riscv: Introduce 64K page size
>
>  arch/Kconfig                        |   1 +
>  arch/riscv/Kconfig                  |  28 +++
>  arch/riscv/include/asm/fixmap.h     |   3 +-
>  arch/riscv/include/asm/hugetlb.h    |  71 ++++++-
>  arch/riscv/include/asm/page.h       |  16 +-
>  arch/riscv/include/asm/pgalloc.h    |  21 ++-
>  arch/riscv/include/asm/pgtable-32.h |   2 +-
>  arch/riscv/include/asm/pgtable-64.h |  45 +++--
>  arch/riscv/include/asm/pgtable.h    | 282 +++++++++++++++++++++++-----
>  arch/riscv/kernel/efi.c             |   2 +-
>  arch/riscv/kernel/head.S            |   4 +-
>  arch/riscv/kernel/hibernate.c       |   3 +-
>  arch/riscv/kvm/mmu.c                | 198 +++++++++++++------
>  arch/riscv/mm/context.c             |   7 +-
>  arch/riscv/mm/fault.c               |   1 +
>  arch/riscv/mm/hugetlbpage.c         |  42 +++--
>  arch/riscv/mm/init.c                |  25 +--
>  arch/riscv/mm/kasan_init.c          |   7 +-
>  arch/riscv/mm/pageattr.c            |   2 +-
>  fs/proc/task_mmu.c                  |   2 +-
>  include/asm-generic/hugetlb.h       |   7 +
>  include/asm-generic/pgtable-nopmd.h |   1 +
>  include/linux/pgtable.h             |   6 +
>  mm/hugetlb.c                        |   2 +-
>  mm/migrate.c                        |   5 +-
>  mm/mprotect.c                       |   2 +-
>  mm/rmap.c                           |  10 +-
>  mm/vmalloc.c                        |   3 +-
>  28 files changed, 616 insertions(+), 182 deletions(-)
>
> --
> 2.20.1
>
