Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0CBE77C7E2
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 08:35:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235126AbjHOGfO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 02:35:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235231AbjHOGeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 02:34:24 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2308A1BE6
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 23:34:18 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-58c5aecea4eso2009087b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 23:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692081257; x=1692686057;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CxAoE5eSsUJ3Vpa248rsUjBgcZlqW5zx3rfHtPXFetE=;
        b=p9+S6hsrqoi9/yc4fLyRQJ95h3qITRTFxdQEqhTJUhKaf0i0Jq2XhWghBIyPtmk/uJ
         4M5rigTywIy/m6/mqluMBYNqiUseBjkuhrD18FHdjGgYia3YM0ohXGUPvtYtuJbUMGeY
         KVH2ky0rlQ6+hENvUAmulC7cWSQSP/LKt+gOFFRQrWskd7A62t+qW5uDKWGsrqjzQyk+
         fLqCcbbNzqddLJlXUy8iNMraK1vN+/eGlLwEF2khEeWeMKnJ7UuQbpgWL7j/mRLCk4cz
         YpGbv7Zwl3yPNwj3AN+GR84frj8c9W+wGv9rPeefkMFN0+K0UD0PoEDwA3yJa5lDyBmb
         07KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692081257; x=1692686057;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CxAoE5eSsUJ3Vpa248rsUjBgcZlqW5zx3rfHtPXFetE=;
        b=L8AMwDIeR9fGkztWObHTsuglBDJYcW3KRFahSjGId1p/pQlvBAdL7vXapY3Itfs29p
         +KPx6JP9Z11199namrsskk5/Qt2ewqe9Vrq/hImxwQjVeoxijl376GqHuX+5qU9NWW4O
         MNBDXfDYaMv2QFHPCz9Ljl7aWoMIONh9l+6Jawm7yDTRFHokjqrtKqqrSgcHxmDXZXC9
         eTpQKVRfWJ0AqJiVkpXbGvEhJtVjcyAHuBvDfnOZxt/1NawMFiClEQNX98Dl75SfOREN
         tvOSiQZSlJ1W8QFkNThdOBkGpfxfwUgQTUtawvmCUoKW/IEy09rQol5CzL9D8okPlW1+
         ymIg==
X-Gm-Message-State: AOJu0Yz57fW+GJmDAQnk/1vo8kkaDURYyuhTrV3drrAnQbaU+VP7r7a/
        7KRjwecScAB/6Mmfkrt0tM4jrg==
X-Google-Smtp-Source: AGHT+IH+fi/XU+DF2DJSdgQk63a8BNgNbEsx1w15WGuNkVMjLKqhEPN8ZgYcWj0XgH+EA3OAGhi3nA==
X-Received: by 2002:a81:a1cc:0:b0:58c:5463:85ec with SMTP id y195-20020a81a1cc000000b0058c546385ecmr1880290ywg.23.1692081257133;
        Mon, 14 Aug 2023 23:34:17 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id r30-20020a81441e000000b005836fc7df19sm3235677ywa.81.2023.08.14.23.34.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 23:34:16 -0700 (PDT)
Date:   Mon, 14 Aug 2023 23:34:05 -0700 (PDT)
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
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        sparclinux@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [BUG] Re: [PATCH v3 10/13] mm/khugepaged: collapse_pte_mapped_thp()
 with mmap_read_lock()
In-Reply-To: <CAG48ez0FxiRC4d3VTu_a9h=rg5FW-kYD5Rg5xo_RDBM0LTTqZQ@mail.gmail.com>
Message-ID: <cacd4a19-386d-8bea-400-e99778dbc3b@google.com>
References: <7cd843a9-aa80-14f-5eb2-33427363c20@google.com> <b53be6a4-7715-51f9-aad-f1347dcb7c4@google.com> <CAG48ez0FxiRC4d3VTu_a9h=rg5FW-kYD5Rg5xo_RDBM0LTTqZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463760895-1382586557-1692081256=:4366"
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

---1463760895-1382586557-1692081256=:4366
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

Thanks a lot, Jann. I haven't thought about it at all yet; and just
tried to reproduce, but haven't yet got the "BUG: Bad rss-counter":
just see "Invalid argument" on the UFFDIO_COPY ioctl.
Will investigate tomorrow.

Hugh
---1463760895-1382586557-1692081256=:4366--
