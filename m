Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D95CF7AF6BC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 01:29:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232013AbjIZX3y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 19:29:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjIZX1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 19:27:53 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EBE41F9D0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 15:32:20 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A278C43215;
        Tue, 26 Sep 2023 21:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1695762931;
        bh=8Ow3T98wjJTpXnAUN+3mn4M9J+ijsbPHhUgnoSqynpo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Gid+BjIVN7lHoeH6PgshhbGSLsnYcSQ1UpDs30BX2V0A6+VgKPuvAql/4YzmQKvG5
         g1KibwCqaFMsRCeNj6/WTFIm6f4P330z30ldUIT0SfYVGTP2m1Oo1xbGSEPRGP0dwG
         NxvraLRp4y9jId8iLhVbFiSEqYLXBbeFcl93UiJw=
Date:   Tue, 26 Sep 2023 14:15:30 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     riel@surriel.com
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        linux-mm@kvack.org, muchun.song@linux.dev, mike.kravetz@oracle.com,
        leit@meta.com, willy@infradead.org
Subject: Re: [PATCH 2/3] hugetlbfs: close race between MADV_DONTNEED and
 page fault
Message-Id: <20230926141530.26bc8550f2f2411945b566f1@linux-foundation.org>
In-Reply-To: <20230926031245.795759-3-riel@surriel.com>
References: <20230926031245.795759-1-riel@surriel.com>
        <20230926031245.795759-3-riel@surriel.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Sep 2023 23:10:51 -0400 riel@surriel.com wrote:

> From: Rik van Riel <riel@surriel.com>
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
> Fix that race by pulling the locking from __unmap_hugepage_final_range
> into helper functions called from zap_page_range_single. This ensures
> page faults stay locked out of the MADV_DONTNEED VMA until the
> huge pages have actually been freed.
> 

Was a -stable backport considered?
