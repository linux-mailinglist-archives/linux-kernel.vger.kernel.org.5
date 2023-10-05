Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D05F7BA166
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:53:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238576AbjJEOno convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 5 Oct 2023 10:43:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236839AbjJEOio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:38:44 -0400
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C09064F6F9
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 07:02:53 -0700 (PDT)
Received: from imladris.home.surriel.com ([10.0.13.28] helo=imladris.surriel.com)
        by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <riel@shelob.surriel.com>)
        id 1qoOJl-000234-17;
        Thu, 05 Oct 2023 09:23:05 -0400
Message-ID: <99b67e2408c260f53958e98226449fd2bb6a58d8.camel@surriel.com>
Subject: Re: [PATCH 2/3] hugetlbfs: close race between MADV_DONTNEED and
 page fault
From:   Rik van Riel <riel@surriel.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        muchun.song@linux.dev, leit@meta.com, willy@infradead.org,
        stable@kernel.org
Date:   Thu, 05 Oct 2023 09:23:05 -0400
In-Reply-To: <20231005031959.GA13437@monkey>
References: <20231004032814.3108383-1-riel@surriel.com>
         <20231004032814.3108383-3-riel@surriel.com> <20231005031959.GA13437@monkey>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
Sender: riel@surriel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-10-04 at 20:19 -0700, Mike Kravetz wrote:
> On 10/03/23 23:25, riel@surriel.com wrote:
> > 
> > @@ -5457,11 +5460,12 @@ void __unmap_hugepage_range_final(struct
> > mmu_gather *tlb,
> >                  * someone else.
> >                  */
> >                 __hugetlb_vma_unlock_write_free(vma);
> > -               i_mmap_unlock_write(vma->vm_file->f_mapping);
> >         } else {
> > -               i_mmap_unlock_write(vma->vm_file->f_mapping);
> >                 hugetlb_vma_unlock_write(vma);
> >         }
> > +
> > +       if (vma->vm_file)
> > +               i_mmap_unlock_write(vma->vm_file->f_mapping);
> >  }
> 
> In the case of a mmap(hugetlbfs_file_mmap) error, the per-vma hugetlb
> lock will not be setup.  The hugetlb_vma_lock/unlock routines do not
> check for this as they were previously always called after the lock
> was
> set up.  So, we can now get:

Wait, the hugetlb_vma_(un)lock_{read,write} functions do
have checks for the presence of the lock:

void hugetlb_vma_lock_read(struct vm_area_struct *vma)
{
        if (__vma_shareable_lock(vma)) {
                struct hugetlb_vma_lock *vma_lock = vma-
>vm_private_data;

                down_read(&vma_lock->rw_sema);
        } else if (__vma_private_lock(vma)) {
                struct resv_map *resv_map = vma_resv_map(vma);

                down_read(&resv_map->rw_sema);
        }
}

Both __vma_shareable_lock and __vma_private_lock check that
vma->vm_private_data points at something.

Exactly what corner case am I missing here?

What leaves vma->vm_private_data pointing at something
invalid?

> 
> +++ b/mm/hugetlb.c
> @@ -5503,10 +5503,12 @@ void __unmap_hugepage_range(struct mmu_gather
> *tlb, struct vm_area_struct *vma,
>  void __hugetlb_zap_begin(struct vm_area_struct *vma,
>                          unsigned long *start, unsigned long *end)
>  {
> +       if (!vma->vm_file)      /* hugetlbfs_file_mmap error */
> +               return;
> +

This does not seem quite correct, because the locking is needed to
avoid the race between MADV_DONTNEED and the page fault path.


> Another way to resolve would be to fix up the hugetlb_vma_lock/unlock
> routines
> to check for and handle a null lock.

I thought I had that already. 

Does __vma_shareable_lock need to check for !vma->vm_file ?

-- 
All Rights Reversed.
