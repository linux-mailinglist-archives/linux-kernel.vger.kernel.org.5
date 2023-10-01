Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDCDA7B44F9
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 04:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233459AbjJACyj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 22:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjJACyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 22:54:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D060DD3
        for <linux-kernel@vger.kernel.org>; Sat, 30 Sep 2023 19:54:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0723CC433C7;
        Sun,  1 Oct 2023 02:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1696128875;
        bh=lhdylN6ubXsWPNt/SHxBMnKveIpOU1CtLRkaa4GXlHs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=aAyrQlCzHV97txvA9wz6K4iZTOs+XVz/J+6DN8XzLEl+8WVMfNpb1Ei1ZkZfXGI7Z
         QsMBfKvnEqp/6+rs/zHgc1xqYfi7bzVoEEznhs+C9OjJThLV+LfZDsguheUMlTRL94
         CBxaWM8/kSSUm9aSMoy31gVYeIbfYEd/BqNaMspg=
Date:   Sat, 30 Sep 2023 19:54:34 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     riel@surriel.com
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        linux-mm@kvack.org, muchun.song@linux.dev, mike.kravetz@oracle.com,
        leit@meta.com, willy@infradead.org
Subject: Re: [PATCH v5 0/3] hugetlbfs: close race between MADV_DONTNEED and
 page fault
Message-Id: <20230930195434.3507483510ba7961985fbeb2@linux-foundation.org>
In-Reply-To: <20231001005659.2185316-1-riel@surriel.com>
References: <20231001005659.2185316-1-riel@surriel.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 30 Sep 2023 20:55:47 -0400 riel@surriel.com wrote:

> v5: somehow a __vma_private_lock(vma) test failed to make it from my tree into the v4 series, fix that
> v4: fix unmap_vmas locking issue pointed out by Mike Kravetz, and resulting lockdep fallout
> v3: fix compile error w/ lockdep and test case errors with patch 3
> v2: fix the locking bug found with the libhugetlbfs tests.
> 
> Malloc libraries, like jemalloc and tcalloc, take decisions on when
> to call madvise independently from the code in the main application.
> 
> This sometimes results in the application page faulting on an address,
> right after the malloc library has shot down the backing memory with
> MADV_DONTNEED.
> 
> Usually this is harmless, because we always have some 4kB pages
> sitting around to satisfy a page fault. However, with hugetlbfs
> systems often allocate only the exact number of huge pages that
> the application wants.
> 
> Due to TLB batching, hugetlbfs MADV_DONTNEED will free pages outside of
> any lock taken on the page fault path, which can open up the following
> race condition:
> 
>        CPU 1                            CPU 2
> 
>        MADV_DONTNEED
>        unmap page
>        shoot down TLB entry
>                                        page fault
>                                        fail to allocate a huge page
>                                        killed with SIGBUS
>        free page
> 
> Fix that race by extending the hugetlb_vma_lock locking scheme to also
> cover private hugetlb mappings (with resv_map), and pulling the locking 
> from __unmap_hugepage_final_range into helper functions called from
> zap_page_range_single. This ensures page faults stay locked out of
> the MADV_DONTNEED VMA until the huge pages have actually been freed.

Didn't we decide that [1/3] and [2/3] should be cc:stable?

> The third patch in the series is more of an RFC. Using the
> invalidate_lock instead of the hugetlb_vma_lock greatly simplifies
> the code, but at the cost of turning a per-VMA lock into a lock
> per backing hugetlbfs file, which could slow things down when
> multiple processes are mapping the same hugetlbfs file.

"could slow things down" is testable-for?

This third one I'd queue up for testing for a 6.7-rc1 merge, so I'll split
the series apart.  Not a problem, but it would be a little better if
things were originally packaged that way.

