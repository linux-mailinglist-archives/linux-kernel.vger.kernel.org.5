Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C229976529D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 13:38:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232890AbjG0LiT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 07:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233286AbjG0LiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 07:38:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F268E10EC
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 04:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690457839;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wWuGOPXZ2ZIchq+tvQ7qiMCMX91zMGr7l3TLmDAYNuM=;
        b=EBLs2Ub8BRpjNWYm1PUrNDLR1VFDurr6gj1snAedRA8gNglMYeN0nuYDXNi/8D+GeaDIN0
        5fXxEGChHBTaDB1JdZrGHA24VZMtzfjTaYxBG/fhuiCCYWxxFhcU+YuZ6dklJF7SbfePmX
        4A7UAe9qH21m7qarSjl6Ois16ZEocTM=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-83-XgM8hHHTPUOUjMUAXlOelA-1; Thu, 27 Jul 2023 07:37:17 -0400
X-MC-Unique: XgM8hHHTPUOUjMUAXlOelA-1
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7866b16c6f5so66035839f.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 04:37:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690457837; x=1691062637;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wWuGOPXZ2ZIchq+tvQ7qiMCMX91zMGr7l3TLmDAYNuM=;
        b=ZmaSsND9o9binM9MgDjqnTMFr3BYZZ7VDGW4rL8LfFelTYemDt9zP/D3jXZy2xM+QL
         ebsYxRHxHGi9mkGJILBvFOWUBuoeF2U45ga32MMZNqCdVC4nBDGO3wHu/wLN/NsF1hah
         j1Ad1ZBi4dOHkboigV3yeAc9DKUv1IgpzA4QBPP0dp60TXCdM62GtOW1+e8v3ZwYIKh3
         gQU2170WmtEOkb7wyEdz7/FlIkaO1teowHugIc3VKMhi7yw0W7xf3Ibil1OAVl7iWrqR
         FFeSTE5pOH/F3LDYlWjzrUMymNFzNst45Oe4EJzuSJ0ENGUJBnHXLp5rXZxiB3mD62hm
         7j3A==
X-Gm-Message-State: ABy/qLYhMat5I82qjXipPr89oMvXkWqG2cAXcmAkfkMvGzYwYtbZ9sAp
        BMuDoarSyuZhUstkfwz+9bda7Sr+QN3Eekwrc1mtGmR+gsK5+beg3G5HffZYIKMx4Gfc5c8+dei
        pserF1kO0JgPV6aa5NMAtYsbUYhyVxN74qa3NEJk0
X-Received: by 2002:a05:6e02:1e07:b0:346:4f37:8a3 with SMTP id g7-20020a056e021e0700b003464f3708a3mr3040603ila.5.1690457837168;
        Thu, 27 Jul 2023 04:37:17 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEGytVCvsiSOyBgeKRlfoTGCx1Mr7l2fVlWvdfLzhGSqzQGTBQynqQJtvR+kFOXIT2FKSSQF9Ah+zY9oNY4QVo=
X-Received: by 2002:a05:6e02:1e07:b0:346:4f37:8a3 with SMTP id
 g7-20020a056e021e0700b003464f3708a3mr3040590ila.5.1690457836860; Thu, 27 Jul
 2023 04:37:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230726073409.631838-1-liubo254@huawei.com>
In-Reply-To: <20230726073409.631838-1-liubo254@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Date:   Thu, 27 Jul 2023 13:37:06 +0200
Message-ID: <CADFyXm5nkgZjVMj3iJhqQnyA1AOmqZ-AKdaWyUD=UvZsOEOcPg@mail.gmail.com>
Subject: Re: [PATCH] smaps: Fix the abnormal memory statistics obtained
 through /proc/pid/smaps
To:     liubo <liubo254@huawei.com>
Cc:     akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, hughd@google.com, peterx@redhat.com,
        willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2023 at 9:40=E2=80=AFAM liubo <liubo254@huawei.com> wrote:
>
> In commit 474098edac26 ("mm/gup: replace FOLL_NUMA by
> gup_can_follow_protnone()"), FOLL_NUMA was removed and replaced by
> the gup_can_follow_protnone interface.
>
> However, for the case where the user-mode process uses transparent
> huge pages, when analyzing the memory usage through
> /proc/pid/smaps_rollup, the obtained memory usage is not consistent
> with the RSS in /proc/pid/status.
>
> Related examples are as follows:
> cat /proc/15427/status
> VmRSS:  20973024 kB
> RssAnon:        20971616 kB
> RssFile:            1408 kB
> RssShmem:              0 kB
>
> cat /proc/15427/smaps_rollup
> 00400000-7ffcc372d000 ---p 00000000 00:00 0 [rollup]
> Rss:            14419432 kB
> Pss:            14418079 kB
> Pss_Dirty:      14418016 kB
> Pss_Anon:       14418016 kB
> Pss_File:             63 kB
> Pss_Shmem:             0 kB
> Anonymous:      14418016 kB
> LazyFree:              0 kB
> AnonHugePages:  14417920 kB
>
> The root cause is that the traversal In the page table, the number of
> pages obtained by smaps_pmd_entry does not include the pages
> corresponding to PROTNONE,resulting in a different situation.
>

Thanks for reporting and debugging!

> Therefore, when obtaining pages through the follow_trans_huge_pmd
> interface, add the FOLL_FORCE flag to count the pages corresponding to
> PROTNONE to solve the above problem.
>

We really want to avoid the usage of FOLL_FORCE, and ideally limit it
to ptrace only.

> Signed-off-by: liubo <liubo254@huawei.com>
> Fixes: 474098edac26 ("mm/gup: replace FOLL_NUMA by gup_can_follow_protnon=
e()")
> ---
>  fs/proc/task_mmu.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index c1e6531cb02a..ed08f9b869e2 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -571,8 +571,10 @@ static void smaps_pmd_entry(pmd_t *pmd, unsigned lon=
g addr,
>         bool migration =3D false;
>
>         if (pmd_present(*pmd)) {
> -               /* FOLL_DUMP will return -EFAULT on huge zero page */
> -               page =3D follow_trans_huge_pmd(vma, addr, pmd, FOLL_DUMP)=
;
> +               /* FOLL_DUMP will return -EFAULT on huge zero page
> +                * FOLL_FORCE follow a PROT_NONE mapped page
> +                */
> +               page =3D follow_trans_huge_pmd(vma, addr, pmd, FOLL_DUMP =
| FOLL_FORCE);
>         } else if (unlikely(thp_migration_supported() && is_swap_pmd(*pmd=
))) {
>                 swp_entry_t entry =3D pmd_to_swp_entry(*pmd);

Might do as an easy fix. But we really should get rid of that
absolutely disgusting usage of follow_trans_huge_pmd().

We don't need 99% of what follow_trans_huge_pmd() does here.

Would the following also fix your issue?

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 507cd4e59d07..fc744964816e 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -587,8 +587,7 @@ static void smaps_pmd_entry(pmd_t *pmd, unsigned long a=
ddr,
        bool migration =3D false;

        if (pmd_present(*pmd)) {
-               /* FOLL_DUMP will return -EFAULT on huge zero page */
-               page =3D follow_trans_huge_pmd(vma, addr, pmd, FOLL_DUMP);
+               page =3D vm_normal_page_pmd(vma, addr, *pmd);
        } else if (unlikely(thp_migration_supported() && is_swap_pmd(*pmd))=
) {
                swp_entry_t entry =3D pmd_to_swp_entry(*pmd);

It also skips the shared zeropage and pmd_devmap(),

Otherwise, a simple pmd_page(*pmd) + is_huge_zero_pmd(*pmd) check will do, =
but I
suspect vm_normal_page_pmd() might be what we actually want to have here.

Because smaps_pte_entry() properly checks for vm_normal_page().

