Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E5A3783121
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 21:51:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbjHUTsr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 15:48:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjHUTsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 15:48:46 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40D9610E
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 12:48:42 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-d45caf42d73so3691685276.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 12:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692647321; x=1693252121;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TJzCfpxhVh8Bz41vGC0rk+kXrKf+GdQm6b6DEBJLp4Y=;
        b=O+l83h2LbZSW4NI8EbJgXLVItI++RMuU2J1wzOBcgSbKmzQuEPI9eXLtSoWmn6sq+J
         am9dOa1SFWGD7j5vN6h935pR1gM8rVAxXJEVaSWFJUrDFCRm4UId8TzMlS8g+nEJHA0L
         HVmidw/jdT5JEjucAIAVHt18vnuAYYelLXsgg/3kJuYSEB8p5NXviLWxA6djEjfHQuvd
         Tut8+np5BGIFwbD617Gj+qlh50yuNuK3sAB8TJC0oDpzrOvNE36+gxIvWggycyL1tEG0
         x92tpf/QJeruWhF9JQ1/ULRqj6tCPttInh9D1ON2tnwj/rA0zB3U4trgXTgmjiozXI6e
         zKYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692647321; x=1693252121;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TJzCfpxhVh8Bz41vGC0rk+kXrKf+GdQm6b6DEBJLp4Y=;
        b=dDsdbeFg9RzH9yfS8B5pQLBkTj1TKINK85Lkvph4e5ySDHo9029G2e4jXUPlKv1CoW
         03FQfCyuX3aOQDmhUgzcyCzoUCecGnPnGVGShFoNwODYl0OL+sS+4wN/EG5zhta8TU5t
         GHluIexUgATNAF8lBBAXsrI40WLp09gjiUvVbZF3ggNYEALjTzt1QfnYsrSZyDtktP5m
         wOR5nt4ptKrqj1GseOlpxpxkG2giWI09Jsl/A/h3HYRSprN7u38Ou44Vic5vdRVAWX0s
         RVFhCV70WdDpeM54hFTCnjidwbUv0GXvu25Cmp0HEwAKkwqaM0HgJ2Rdwlfmv2eLtr0X
         exlg==
X-Gm-Message-State: AOJu0YxBJHnURAEEVjGNNzgSoSfpnWDCX4eKK391mFn5zRrVStaK/1sb
        1w7WGVGYFm6H7UmTitDtl5YRYg==
X-Google-Smtp-Source: AGHT+IGa6N7zVO856T4SuLkkv15XMUTmB6PRYCGx3mJYt/D6fAu3o2zmClsjUxquvXD3gtA1EwMqjA==
X-Received: by 2002:a25:157:0:b0:ced:974a:1aae with SMTP id 84-20020a250157000000b00ced974a1aaemr7593100ybb.58.1692647321154;
        Mon, 21 Aug 2023 12:48:41 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id z4-20020a259cc4000000b00d5c4c949349sm1335996ybo.13.2023.08.21.12.48.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 12:48:40 -0700 (PDT)
Date:   Mon, 21 Aug 2023 12:48:29 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Jann Horn <jannh@google.com>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Yang Shi <shy828301@gmail.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Peter Xu <peterx@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Alistair Popple <apopple@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Steven Price <steven.price@arm.com>,
        SeongJae Park <sj@kernel.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Huang Ying <ying.huang@intel.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Zack Rusin <zackr@vmware.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Minchan Kim <minchan@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Song Liu <song@kernel.org>,
        Thomas Hellstrom <thomas.hellstrom@linux.intel.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vishal Moola <vishal.moola@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>, Zi Yan <ziy@nvidia.com>,
        Zach O'Keefe <zokeefe@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        sparclinux@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [BUG] Re: [PATCH v3 10/13] mm/khugepaged: collapse_pte_mapped_thp()
 with mmap_read_lock()
In-Reply-To: <CAG48ez0FxiRC4d3VTu_a9h=rg5FW-kYD5Rg5xo_RDBM0LTTqZQ@mail.gmail.com>
Message-ID: <e71190cf-c1e7-87d3-7a61-b4753c3932ed@google.com>
References: <7cd843a9-aa80-14f-5eb2-33427363c20@google.com> <b53be6a4-7715-51f9-aad-f1347dcb7c4@google.com> <CAG48ez0FxiRC4d3VTu_a9h=rg5FW-kYD5Rg5xo_RDBM0LTTqZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463760895-1083013748-1692647320=:5414"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463760895-1083013748-1692647320=:5414
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 14 Aug 2023, Jann Horn wrote:
> On Wed, Jul 12, 2023 at 6:42=E2=80=AFAM Hugh Dickins <hughd@google.com> w=
rote:
> > Bring collapse_and_free_pmd() back into collapse_pte_mapped_thp().
> > It does need mmap_read_lock(), but it does not need mmap_write_lock(),
> > nor vma_start_write() nor i_mmap lock nor anon_vma lock.  All racing
> > paths are relying on pte_offset_map_lock() and pmd_lock(), so use those=
=2E
>=20
> We can still have a racing userfaultfd operation at the "/* step 4:
> remove page table */" point that installs a new PTE before the page
> table is removed.

And you've been very polite not to remind me that this is exactly
what you warned me about, in connection with retract_page_tables(),
nearly three months ago:

https://lore.kernel.org/linux-mm/CAG48ez0aF1Rf1apSjn9YcnfyFQ4YqSd4GqB6f2wfh=
F7jMdi5Hg@mail.gmail.com/

>=20
> To reproduce, patch a delay into the kernel like this:
>=20
>=20
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 9a6e0d507759..27cc8dfbf3a7 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -20,6 +20,7 @@
>  #include <linux/swapops.h>
>  #include <linux/shmem_fs.h>
>  #include <linux/ksm.h>
> +#include <linux/delay.h>
>=20
>  #include <asm/tlb.h>
>  #include <asm/pgalloc.h>
> @@ -1617,6 +1618,11 @@ int collapse_pte_mapped_thp(struct mm_struct
> *mm, unsigned long addr,
>         }
>=20
>         /* step 4: remove page table */
> +       if (strcmp(current->comm, "DELAYME") =3D=3D 0) {
> +               pr_warn("%s: BEGIN DELAY INJECTION\n", __func__);
> +               mdelay(5000);
> +               pr_warn("%s: END DELAY INJECTION\n", __func__);
> +       }
>=20
>         /* Huge page lock is still held, so page table must remain empty =
*/
>         pml =3D pmd_lock(mm, pmd);
>=20
>=20
> And then run the attached reproducer against mm/mm-everything. You
> should get this in dmesg:
>=20
> [  206.578096] BUG: Bad rss-counter state mm:000000000942ebea
> type:MM_ANONPAGES val:1

Very helpful, thank you Jann.

I got a bit distracted when I then found mm's recent addition of
UFFDIO_POISON: thought I needed to change both collapse_pte_mapped_thp()
and retract_page_tables() now to cope with mfill_atomic_pte_poison()
inserting into even a userfaultfd_armed shared VMA.

But eventually, on second thoughts, realized that's only inserting a pte
marker, invalid, so won't cause any actual trouble.  A little untidy,
to leave that behind in a supposedly empty page table about to be freed,
but not worth refactoring these functions to avoid a non-bug.

And though syzbot and JH may find some fun with it, I don't think any
real application would be insertng a PTE_MARKER_POISONED where a huge
page collapse is almost complete.

So I scaled back to a more proportionate fix, following.  Sorry, I've
slightly messed up applying the "DELAY INJECTION" patch above: not
intentional, honest!  (mdelay while holding the locks is still good.)

Hugh
---1463760895-1083013748-1692647320=:5414--
