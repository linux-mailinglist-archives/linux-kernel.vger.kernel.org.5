Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 613B67FB15D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 06:39:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343552AbjK1Fj0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 00:39:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234635AbjK1FjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 00:39:23 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 309D0E6
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 21:39:29 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1cfaf05db73so77135ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 21:39:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701149968; x=1701754768; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hd11373At0fgNthDfz475jB2pnftz8WhsrA0gYblitY=;
        b=bXsqjc+O5lZombFifNkiB/W9AfwHyZFQ5SLgjbDKMWasF8nfXxWucjm+pLF9q3ltG8
         hWu+arqrb5nyPU5LfwYm3OQqevjctUuBwRkzRQo9/TD8xmYcXESa0baCmh8igVavgGAU
         A+bJonGvaqIDwNd5J1K9IB6tgYId5oH3Gn5jCz9ShWNpUwe7mARFCA5czA1Q04PKKk+j
         qII1dgoS7kry8uzXKIdABg91Fg6+7nt2hROBNRJmJ/XTU4lJbf1Hx7vjLvTA8zxhySZC
         sZKi1YoBWc1RamGA7oevhBsV1Ea6eybFg7uRFdbpf+Em5JTHNa/5SlFtOGDJE6IIWv/6
         PLvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701149968; x=1701754768;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hd11373At0fgNthDfz475jB2pnftz8WhsrA0gYblitY=;
        b=Nqw3Y80WR1GJLICSaUU0GhdRpGv8J2l8mTBqOnrfjIbUAOxMhKLQveDm1K7qBENJXA
         qZtIw0tr5Tc+0OyBW6NP+2cxCQmuOlJokZLdnx62elYQJCdv020MZqdOsyAONwejjKBK
         zEHlIWH7gpCOW6pEGeoPXv5H6ud+D0cMcgv3ThXxwB7epNfdyg3Ler2/92til3nXpbe1
         W1b/m0K1Y7PXjdeyWzqXPfqQNhBV5JC9MZHRVzXplFfHFTBZM4qVofROQ6cHmJaKjMoA
         yZtp/vzPaVZucaST8r2/V+leV75fBGGo0YarBrdRksOzymJ9I5zyJe1fM/4cDHjJ/w5P
         7RVg==
X-Gm-Message-State: AOJu0YwXOSvC9IKCJY6K0eykxI2T0m8yCZSXSPBWp3rX++KZp+XKy5sU
        de3oesDGKE7Rsk9sBL/SxMcmP08sdHheRFVJ61z8Kg==
X-Google-Smtp-Source: AGHT+IHMM+TBLPbm7+22ArJ0V2KCgdhbcD8w4150pEudfRnDapexGxJDfjwu4kPbNStb74F9bfmDWp9Y8DnvbExoUpc=
X-Received: by 2002:a17:903:1206:b0:1cf:6f62:88d9 with SMTP id
 l6-20020a170903120600b001cf6f6288d9mr1243304plh.9.1701149968448; Mon, 27 Nov
 2023 21:39:28 -0800 (PST)
MIME-Version: 1.0
References: <20231119165721.9849-1-alexandru.elisei@arm.com> <20231119165721.9849-22-alexandru.elisei@arm.com>
In-Reply-To: <20231119165721.9849-22-alexandru.elisei@arm.com>
From:   Peter Collingbourne <pcc@google.com>
Date:   Mon, 27 Nov 2023 21:39:17 -0800
Message-ID: <CAMn1gO5WYC5Xx7LfBxN_j-xqkVT+tjXP5PqDfrvhgqPOa0ZCsA@mail.gmail.com>
Subject: Re: [PATCH RFC v2 21/27] mm: arm64: Handle tag storage pages mapped
 before mprotect(PROT_MTE)
To:     Alexandru Elisei <alexandru.elisei@arm.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, oliver.upton@linux.dev,
        maz@kernel.org, james.morse@arm.com, suzuki.poulose@arm.com,
        yuzenghui@huawei.com, arnd@arndb.de, akpm@linux-foundation.org,
        mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, mhiramat@kernel.org,
        rppt@kernel.org, hughd@google.com, steven.price@arm.com,
        anshuman.khandual@arm.com, vincenzo.frascino@arm.com,
        david@redhat.com, eugenis@google.com, kcc@google.com,
        hyesoo.yu@samsung.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexandru,

On Sun, Nov 19, 2023 at 8:59=E2=80=AFAM Alexandru Elisei
<alexandru.elisei@arm.com> wrote:
>
> Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
> ---
>  arch/arm64/include/asm/mte_tag_storage.h |  1 +
>  arch/arm64/kernel/mte_tag_storage.c      | 15 +++++++
>  arch/arm64/mm/fault.c                    | 55 ++++++++++++++++++++++++
>  include/linux/migrate.h                  |  8 +++-
>  include/linux/migrate_mode.h             |  1 +
>  mm/internal.h                            |  6 ---
>  6 files changed, 78 insertions(+), 8 deletions(-)
>
> diff --git a/arch/arm64/include/asm/mte_tag_storage.h b/arch/arm64/includ=
e/asm/mte_tag_storage.h
> index b97406d369ce..6a8b19a6a758 100644
> --- a/arch/arm64/include/asm/mte_tag_storage.h
> +++ b/arch/arm64/include/asm/mte_tag_storage.h
> @@ -33,6 +33,7 @@ int reserve_tag_storage(struct page *page, int order, g=
fp_t gfp);
>  void free_tag_storage(struct page *page, int order);
>
>  bool page_tag_storage_reserved(struct page *page);
> +bool page_is_tag_storage(struct page *page);
>
>  vm_fault_t handle_page_missing_tag_storage(struct vm_fault *vmf);
>  vm_fault_t handle_huge_page_missing_tag_storage(struct vm_fault *vmf);
> diff --git a/arch/arm64/kernel/mte_tag_storage.c b/arch/arm64/kernel/mte_=
tag_storage.c
> index a1cc239f7211..5096ce859136 100644
> --- a/arch/arm64/kernel/mte_tag_storage.c
> +++ b/arch/arm64/kernel/mte_tag_storage.c
> @@ -500,6 +500,21 @@ bool page_tag_storage_reserved(struct page *page)
>         return test_bit(PG_tag_storage_reserved, &page->flags);
>  }
>
> +bool page_is_tag_storage(struct page *page)
> +{
> +       unsigned long pfn =3D page_to_pfn(page);
> +       struct range *tag_range;
> +       int i;
> +
> +       for (i =3D 0; i < num_tag_regions; i++) {
> +               tag_range =3D &tag_regions[i].tag_range;
> +               if (tag_range->start <=3D pfn && pfn <=3D tag_range->end)
> +                       return true;
> +       }
> +
> +       return false;
> +}
> +
>  int reserve_tag_storage(struct page *page, int order, gfp_t gfp)
>  {
>         unsigned long start_block, end_block;
> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> index 6730a0812a24..964c5ae161a3 100644
> --- a/arch/arm64/mm/fault.c
> +++ b/arch/arm64/mm/fault.c
> @@ -12,6 +12,7 @@
>  #include <linux/extable.h>
>  #include <linux/kfence.h>
>  #include <linux/signal.h>
> +#include <linux/migrate.h>
>  #include <linux/mm.h>
>  #include <linux/hardirq.h>
>  #include <linux/init.h>
> @@ -956,6 +957,50 @@ void tag_clear_highpage(struct page *page)
>  }
>
>  #ifdef CONFIG_ARM64_MTE_TAG_STORAGE
> +
> +#define MR_TAGGED_TAG_STORAGE  MR_ARCH_1
> +
> +extern bool isolate_lru_page(struct page *page);
> +extern void putback_movable_pages(struct list_head *l);

Could we move these declarations to a non-mm-internal header and
#include it instead of manually declaring them here?

> +
> +/* Returns with the page reference dropped. */
> +static void migrate_tag_storage_page(struct page *page)
> +{
> +       struct migration_target_control mtc =3D {
> +               .nid =3D NUMA_NO_NODE,
> +               .gfp_mask =3D GFP_HIGHUSER_MOVABLE | __GFP_TAGGED,
> +       };
> +       unsigned long i, nr_pages =3D compound_nr(page);
> +       LIST_HEAD(pagelist);
> +       int ret, tries;
> +
> +       lru_cache_disable();
> +
> +       for (i =3D 0; i < nr_pages; i++) {
> +               if (!isolate_lru_page(page + i)) {
> +                       ret =3D -EAGAIN;
> +                       goto out;
> +               }
> +               /* Isolate just grabbed another reference, drop ours. */
> +               put_page(page + i);
> +               list_add_tail(&(page + i)->lru, &pagelist);
> +       }
> +
> +       tries =3D 5;
> +       while (tries--) {
> +               ret =3D migrate_pages(&pagelist, alloc_migration_target, =
NULL, (unsigned long)&mtc,
> +                                   MIGRATE_SYNC, MR_TAGGED_TAG_STORAGE, =
NULL);
> +               if (ret =3D=3D 0 || ret !=3D -EBUSY)

This could be simplified to:

if (ret !=3D -EBUSY)

Peter
