Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B74B7AB3FA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 16:43:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231566AbjIVOna (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 10:43:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231547AbjIVOn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 10:43:27 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50E2B19C
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 07:43:21 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-4142ca41b89so14308641cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 07:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1695393800; x=1695998600; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q9o0eyPrPED08Whg4Z5ZxhQWffqyfOzmMnSHg2K2zdA=;
        b=UpAwaXJT3I6vbqIg2skPxeCDHNTg0PmzslN/9+KecqqnVGXaWVja/gGBo3WYPuufp6
         Q8ov6v/MgRAFoaH+6VwQtbT06snzR2mOfWiCFNyE/qfoUXxOg84CCJc+HSgA3h69RtIr
         AvuGgvSGCaQXvhf6qLt+WsoeA7we2plSkAJrXY6XPs8KCrn+iFpkkv0P7MhoPLYO8XaB
         c2cv6SZvphukvL4Bh+jX0AdQl9HAT7dO+/oPSsRewZMIHK+vIbluVMVEDgnbjSi5DW2Q
         Gv79cAZO91p9hQHOzDqRTeWXSqrZy7VPQpAv8XqThmtjTCxe7Bl1G/zqZYt1d6lEUV3T
         iJzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695393800; x=1695998600;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q9o0eyPrPED08Whg4Z5ZxhQWffqyfOzmMnSHg2K2zdA=;
        b=hL5dJluSK/1izOB0s978HMAGrna9qtZJE0n0oQBFFInhQMHCXgyL7GRWiVvILzhqoI
         IA7Q8xUd5PjQJJNhNIpZaYWnUVkflv0anrWfJOY5AwUIKDzEmn8o1z8Z6fIn0Ue4zD0c
         xFpdw5123vj1zJL4GMVRZB2x+wURZKel4FBgvCx79Fjp38HXtEkE4gJ6LNc/ePvbqyie
         bfnSgASkI95ZfRexWulNkKV7CZjWKwLe7a6Qkh4cBDArEQO25nsQtA2MulSZEPPFjFEw
         qR3GLVHTdX1gN0Z8rpxIyWOFuZho7jSUJQRL5r5ZzOUWpfkMz4vodwaMrEpLXgxfKKsw
         5prw==
X-Gm-Message-State: AOJu0YyphLPjG+5aWKLOCGusnB5Ru25f35W9jPkr5ZwPwnWiWEymwC/p
        H1D2YJGntftWk5dWTDGsgyPTU+jFadkUXQ7iUd4hpg==
X-Google-Smtp-Source: AGHT+IEj51Pc90r3QxMhk9K9tsL2rFrHblPnj7OXP5XQsNQ+DtOoZ8Qs/4DE3nnUfLiohjWib5sRDYhb1JtZkQYm084=
X-Received: by 2002:ac8:5a16:0:b0:40f:ef6d:1a31 with SMTP id
 n22-20020ac85a16000000b0040fef6d1a31mr10433299qta.13.1695393800409; Fri, 22
 Sep 2023 07:43:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230906112605.2286994-1-usama.arif@bytedance.com>
In-Reply-To: <20230906112605.2286994-1-usama.arif@bytedance.com>
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
Date:   Fri, 22 Sep 2023 10:42:44 -0400
Message-ID: <CA+CK2bAfV=tpv_DK1621pU26Gy09zR+4E=AzR76Y9=zNYUc8SA@mail.gmail.com>
Subject: Re: [v4 0/4] mm: hugetlb: Skip initialization of gigantic tail struct
 pages if freed by HVO
To:     Usama Arif <usama.arif@bytedance.com>
Cc:     linux-mm@kvack.org, muchun.song@linux.dev, mike.kravetz@oracle.com,
        rppt@kernel.org, linux-kernel@vger.kernel.org,
        songmuchun@bytedance.com, fam.zheng@bytedance.com,
        liangma@liangbit.com, punit.agrawal@bytedance.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 6, 2023 at 7:26=E2=80=AFAM Usama Arif <usama.arif@bytedance.com=
> wrote:
>
> This series moves the boot time initialization of tail struct pages of a
> gigantic page to later on in the boot. Only the
> HUGETLB_VMEMMAP_RESERVE_SIZE / sizeof(struct page) - 1 tail struct pages
> are initialized at the start. If HVO is successful, then no more tail str=
uct
> pages need to be initialized. For a 1G hugepage, this series avoid
> initialization of 262144 - 63 =3D 262081 struct pages per hugepage.
>
> When tested on a 512G system (which can allocate max 500 1G hugepages), t=
he
> kexec-boot time with HVO and DEFERRED_STRUCT_PAGE_INIT enabled without th=
is
> patchseries to running init is 3.9 seconds. With this patch it is 1.2 sec=
onds.
> This represents an approximately 70% reduction in boot time and will
> significantly reduce server downtime when using a large number of
> gigantic pages.

My use case is different, but this patch series benefits it. I have a
virtual machines with a large number of hugetlb pages. The RSS size of
the VM after boot is much smaller with this series:

Before: 9G
After: 600M

The VM has 500 1G pages, and 512G total RAM. I would add this to the
description, that this series can help reduce the VM overhead and boot
performance for those who are using hugetlb pages in the VMs.

Also, DEFERRED_STRUCT_PAGE_INIT is a requirement for this series to
work, and should be added into documentation.

Pasha

> Thanks,
> Usama
>
> [v3->v4]:
> - rebase ontop of patch "hugetlb: set hugetlb page flag before optimizing=
 vmemmap".
> - freeze head struct page ref count.
> - Change order of operations to initialize head struct page -> initialize
> the necessary tail struct pages -> attempt HVO -> initialize the rest of =
the
> tail struct pages if HVO fails.
> - (Mike Rapoport and Muchun Song) remove "_vmemmap" suffix from memblock =
reserve
> noinit flags anf functions.
>
> [v2->v3]:
> - (Muchun Song) skip prep of struct pages backing gigantic hugepages
> at boot time only.
> - (Muchun Song) move initialization of tail struct pages to after
> HVO is attempted.
>
> [v1->v2]:
> - (Mike Rapoport) Code quality improvements (function names, arguments,
> comments).
>
> [RFC->v1]:
> - (Mike Rapoport) Change from passing hugepage_size in
> memblock_alloc_try_nid_raw for skipping struct page initialization to
> using MEMBLOCK_RSRV_NOINIT flag
>
> Usama Arif (4):
>   mm: hugetlb_vmemmap: Use nid of the head page to reallocate it
>   memblock: pass memblock_type to memblock_setclr_flag
>   memblock: introduce MEMBLOCK_RSRV_NOINIT flag
>   mm: hugetlb: Skip initialization of gigantic tail struct pages if
>     freed by HVO
>
>  include/linux/memblock.h |  9 ++++++
>  mm/hugetlb.c             | 61 ++++++++++++++++++++++++++++++++++------
>  mm/hugetlb_vmemmap.c     |  4 +--
>  mm/hugetlb_vmemmap.h     |  9 +++---
>  mm/internal.h            |  3 ++
>  mm/memblock.c            | 48 ++++++++++++++++++++++---------
>  mm/mm_init.c             |  2 +-
>  7 files changed, 107 insertions(+), 29 deletions(-)
>
> --
> 2.25.1
>
>
