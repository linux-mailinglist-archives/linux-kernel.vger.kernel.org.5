Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 002417782E8
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 23:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231330AbjHJVyS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 17:54:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231254AbjHJVyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 17:54:13 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11AABED;
        Thu, 10 Aug 2023 14:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RU0sXhO2RQNDDSYdL7EeIXZJPLuZxUwbT9QsXnScSII=; b=bRUN9usCQLHI82STQKPErTe238
        j/e39iuEoltOdwRI4bvxOhW5+5HNFoWGzXga6QrC2eiUbxsdmrioGMxJoQx9t9rfEaqbXJPUKsPnQ
        iXdE7dfMGCuAShDLVrcGHkLBRrf8JxdXOp75lGbF/AFeTP3rVFCWdsshp1dfPcipglz1UFzbEngWp
        UKifiajJlzW7zG2FwDQQ6alxoV9JW1+l80uJLaN1RsJhmqhuP2ox5eFBM+YibPBJbf2Vu+C1sCFFA
        +n7LJ/H5cKWikDfiMz1JK8hvHk7hNdd7MRqvNq5U5rlnEFHZhCjZ7yfyRkO3pnYhKaUtSJx9J3Ve2
        ANF3F+gg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qUDbZ-00EvTN-Re; Thu, 10 Aug 2023 21:54:06 +0000
Date:   Thu, 10 Aug 2023 22:54:05 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Peter Xu <peterx@redhat.com>
Cc:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-doc@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Hugh Dickins <hughd@google.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Yin Fengwei <fengwei.yin@intel.com>,
        Yang Shi <shy828301@gmail.com>, Zi Yan <ziy@nvidia.com>
Subject: Re: [PATCH mm-unstable v1] mm: add a total mapcount for large folios
Message-ID: <ZNVcfdH8+N5Q83J/@casper.infradead.org>
References: <20230809083256.699513-1-david@redhat.com>
 <ZNQD4pxo8svpGmvX@x1n>
 <ZNRYx8GhYftE4Xeb@casper.infradead.org>
 <7e31254d-8889-7e79-50e1-2630bd493d59@redhat.com>
 <ZNVbIyHcqeKUDuSg@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZNVbIyHcqeKUDuSg@x1n>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023 at 05:48:19PM -0400, Peter Xu wrote:
> > Yes, that comment from Hugh primarily discusses how we could possibly
> > optimize the loop, and if relying on folio_nr_pages_mapped() to reduce the
> > iterations would be racy. As far as I can see, there are cases where "it
> > would be certainly a bad idea" :)
> 
> Is the race described about mapcount being changed right after it's read?
> Are you aware of anything specific that will be broken, and will be fixed
> with this patch?

The problem is that people check the mapcount while holding no locks;
not the PTL, not the page lock.  So it's an unfixable race.

> Having a total mapcount does sound helpful if partial folio is common
> indeed.
> 
> I'm curious whether that'll be so common after the large anon folio work -
> isn't it be sad if partial folio will be a norm?  It sounds to me that's
> the case when small page sizes should be used.. and it's prone to waste?

The problem is that entire_mapcount isn't really entire_mapcount.
It's pmd_mapcount.  I have had thoughts about using it as entire_mapcount,
but it gets gnarly when people do partial unmaps.  So the _usual_ case
ends up touching every struct page.  Which sucks.  Also it's one of the
things which stands in the way of shrinking struct page.

But it's kind of annoying to explain all of this to you individually.
There have been hundreds of emails about it over the last months on
this mailing list.  It would be nice if you could catch up instead of
jumping in.
