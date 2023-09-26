Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22E987AE30F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 02:47:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231826AbjIZAro convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 25 Sep 2023 20:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjIZArn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 20:47:43 -0400
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6702109
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 17:47:36 -0700 (PDT)
Received: from imladris.home.surriel.com ([10.0.13.28] helo=imladris.surriel.com)
        by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <riel@shelob.surriel.com>)
        id 1qkwE0-0000aR-1t;
        Mon, 25 Sep 2023 20:46:52 -0400
Message-ID: <3b7221768bebd9cac5ab8004dca901c4f2faf3cb.camel@surriel.com>
Subject: Re: [PATCH 2/3] hugetlbfs: close race between MADV_DONTNEED and
 page fault
From:   Rik van Riel <riel@surriel.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        muchun.song@linux.dev, leit@meta.com, willy@infradead.org
Date:   Mon, 25 Sep 2023 20:46:52 -0400
In-Reply-To: <20230925222539.GC11309@monkey>
References: <20230925203030.703439-1-riel@surriel.com>
         <20230925203030.703439-3-riel@surriel.com> <20230925222539.GC11309@monkey>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
Sender: riel@surriel.com
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-09-25 at 15:25 -0700, Mike Kravetz wrote:
> On 09/25/23 16:28, riel@surriel.com wrote:
> > 
> > -void __unmap_hugepage_range_final(struct mmu_gather *tlb,
> > -                         struct vm_area_struct *vma, unsigned long
> > start,
> > -                         unsigned long end, struct page *ref_page,
> > -                         zap_flags_t zap_flags)
> > +void __hugetlb_zap_begin(struct vm_area_struct *vma,
> > +                        unsigned long *start, unsigned long *end)
> >  {
> > +       adjust_range_if_pmd_sharing_possible(vma, start, end);
> >         hugetlb_vma_lock_write(vma);
> >         i_mmap_lock_write(vma->vm_file->f_mapping);
> > +}
> 
> __unmap_hugepage_range_final() was called from unmap_single_vma.
> unmap_single_vma has two callers, zap_page_range_single and
> unmap_vmas.
> 
> When the locking was moved into hugetlb_zap_begin, it was only added
> to the
> zap_page_range_single call path.  Calls from unmap_vmas are missing
> the
> locking.

Oh, that's a fun one.

I suppose the locking of the f_mapping lock, and calling
adjust_range_if_pmd_sharing_possible matters for the call
from unmap_vmas, while the call tho hugetlb_vma_lock_write
really doesn't matter, since unmap_vmas is called with the
mmap_sem held for write, which already excludes page faults.

I'll add the call there for v4.

Good catch.

-- 
All Rights Reversed.
