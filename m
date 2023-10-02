Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3ACB7B579F
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 18:13:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238400AbjJBQCJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 12:02:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238367AbjJBQCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 12:02:07 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A515D3
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 09:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vPWjZhtEz0XZOfaHC6v5q0++fyRvHTSEI8HhpIfDjOA=; b=E6lZ4CUI7Wr7e0ZDL5o1kKW2iH
        8dZp176IPQmhLWHsCYyq+xODP0IoDOkbBLN2HdkbJw41kE7l1ko/zDp/jpboryWxKxSG5KZHC8pZI
        VE9MUGh6v0h+FW4wV3opPFMo19kgDo9xm+gWXHqJKAcApZoRkJ6e8MrJ+jN6GhpeLeg67YWNCdRUR
        zQVR6O/phSWirUIYJ7/SlxxHCO3XguVu12sPxqU5kFhLlB9ihyNpL4gSeHaDXuCziSrGsjTWQ6Rol
        sksg8yoe7FlsZOWsbkCGn95h6EAdP01ExcE6YEph7I69sGRyEpsHt9iOJmJctkRRmXxcT8lX7H/qc
        mGMv4mGA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qnLMu-009vnO-6t; Mon, 02 Oct 2023 16:02:00 +0000
Date:   Mon, 2 Oct 2023 17:02:00 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] mm/filemap: clarify filemap_fault() comments for not
 uptodate case
Message-ID: <ZRrpeNrmcNdTO5Qp@casper.infradead.org>
References: <20230930231029.88196-1-lstoakes@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230930231029.88196-1-lstoakes@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 01, 2023 at 12:10:29AM +0100, Lorenzo Stoakes wrote:
> The existing comments in filemap_fault() suggest that, after either a minor
> fault has occurred and filemap_get_folio() found a folio in the page cache,
> or a major fault arose and __filemap_get_folio(FGP_CREATE...) did the job
> (having relied on do_sync_mmap_readahead() or filemap_read_folio() to read
> in the folio), the only possible reason it could not be uptodate is because
> of an error.
> 
> This is not so, as if, for instance, the fault occurred within a VMA which
> had the VM_RAND_READ flag set (via madvise() with the MADV_RANDOM flag
> specified), this would cause even synchronous readahead to fail to read in
> the folio.
> 
> I confirmed this by dropping page caches and faulting in memory madvise()'d
> this way, observing that this code path was reached on each occasion.
> 
> Clarify the comments to include this case, and additionally update the
> comment recently added around the invalidate lock logic to make it clear
> the comment explicitly refers to the minor fault case.

I do appreciate the comment being made accurate, but I wonder if we
shouldn't change the code to match the comment.  We're got two "should"s
pointing in different directions -- we "should" not use readahead if
readahead is disabled, and we "should" always use readahead first,
using read_folio() only if readahead doesn't succeed.

The code isn't ideally structured for this, but I'm going to play with
it a bit and see what I can create.
