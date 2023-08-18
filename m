Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F109C781298
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 20:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379367AbjHRSKK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 14:10:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379361AbjHRSJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 14:09:40 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4B233C38
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 11:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=VRDqbKuqBMb+gqInip+OmxdZgkD0IFs70avkREn6tD0=; b=Va9jaw8IWo48unCr5H2SXvXnG7
        zLewaTKZQnZSKRn5CV43gSbB52dnfgtZQrZIxOvv50CCkfrMiWMUskSlRJDjDWBqPEq1LCKPAi2Lz
        TPEJRZ7CRxR6TymnJez4fgF5LVLrxv6Wi19lJxguO286EX/iv+BalcBq2DoPaACyb2mlr+znCGS3j
        H8Gqq8eE5oX/a2JXRiePTkZsMfS4fOMoECP6Ncs2dekZSckwVCRPreJW+R2jHn7o+6YWNth9kNPZD
        X+5jN9xBFw48jebwuFMaFvfCieD7U1k0aUA3qQ8Xb+Sk42HwkUOCfvLoDVkEN9THfKC09/ibgAB88
        AnqB8gpg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qX3uf-00AtC0-WE; Fri, 18 Aug 2023 18:09:34 +0000
Date:   Fri, 18 Aug 2023 19:09:33 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        songmuchun@bytedance.com, mike.kravetz@oracle.com
Subject: Re: [PATCH v6] mm/filemap: remove hugetlb special casing in filemap.c
Message-ID: <ZN+z3Q3hAn/GG+d3@casper.infradead.org>
References: <20230817181836.103744-1-sidhartha.kumar@oracle.com>
 <20230818110309.e9debd8b988cb8ca4a1019be@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230818110309.e9debd8b988cb8ca4a1019be@linux-foundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 18, 2023 at 11:03:09AM -0700, Andrew Morton wrote:
> On Thu, 17 Aug 2023 11:18:36 -0700 Sidhartha Kumar <sidhartha.kumar@oracle.com> wrote:
> 
> > Perf was used to check the performance differences after the patch. Overall
> > the performance is similar to mainline with a very small larger overhead that
> > occurs in __filemap_add_folio() and hugetlb_add_to_page_cache(). This is because
> > of the larger overhead that occurs in xa_load() and xa_store() as the
> > xarray is now using more entries to store hugetlb folios in the page cache.
> 
> So... why merge the patch?  To save 40 lines of code?
> 
> I mean, if a patch which added 40 lines yielded a "very small"
> reduction in overhead, we'd probably merge it!
> 
> Or is there some wider reason for this which the changelog omitted?

Sidhartha's benchmarks are for hugetlbfs which is where we're likely
to see performance regressions.  What's not shown are any performance
numbers for !hugetlbfs.  The functions where this patch removes code
are used on _every_ page cache lookup, so given the typical difference
in number of lookups performed against hugetlb vs non-hugetlb files,
even saving 0.1% performance on non-hugetlb files will lead to fewer
instructions executed overall.

There's also a conceptual reduction in complexity.  We no longer need to
think about whether the inode is hugetlb or not before doing the lookup
and scaling the byte offset differently.
