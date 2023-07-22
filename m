Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20B9675D98C
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 06:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbjGVEFw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 00:05:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjGVEFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 00:05:50 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DEEA1FD7
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 21:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ullnYhqG8fA5KMqRastTGiw9dH0/azv9SAaNZKVNpJY=; b=DyHXUWhekaxChDS3Qi7zTEgZqP
        XTcNxRWhZsPCkJWA1G796Q0F7o/QSV367RlYzDl3gzmqTPmGmBRVxIao5UQ7DtO8v/521Yg0Wi8e2
        t1o55guVz0Jf8uVY2YoCQcZw7KOtek7q+P/ujvy0uJjVAO9UUU+ui5U42bJIJTo/Cul10fTp/J5sb
        8tq1dss3BpjuOdr2xQl06I0Q7ONa4xPXAOAOwHK0Qc9mfQ+qg34mrXJ8kimXrJp1OE5ivBapCrdNW
        mtpMmJ4/elDQqD2dxRkAxNipns5+hiR/JXirbTPHZqZ3KWj+cxb1mqy/iphtW584MbOUBqYdxSFsV
        KJbp07aA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qN3sC-001j68-QF; Sat, 22 Jul 2023 04:05:40 +0000
Date:   Sat, 22 Jul 2023 05:05:40 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, songmuchun@bytedance.com,
        david@redhat.com
Subject: Re: [PATCH v2 0/1] change ->index to PAGE_SIZE for hugetlb pages
Message-ID: <ZLtVlJA+V2+2yjxc@casper.infradead.org>
References: <20230710230450.110064-1-sidhartha.kumar@oracle.com>
 <20230720000011.GD3240@monkey>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230720000011.GD3240@monkey>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 19, 2023 at 05:00:11PM -0700, Mike Kravetz wrote:
> On 07/10/23 16:04, Sidhartha Kumar wrote:
> > ========================== OVERVIEW ========================================
> > This patchset attempts to implement a listed filemap TODO which is
> > changing hugetlb folios to have ->index in PAGE_SIZE. This simplifies many
> > functions within filemap.c as they have to special case hugetlb pages.
> > From the RFC v1[1], Mike pointed out that hugetlb will still have to maintain
> > a huge page sized index as it is used for the reservation map and the hash
> > function for the hugetlb mutex table.
> > 
> > This patchset adds new wrappers for hugetlb code to to interact with the
> > page cache. These wrappers calculate a linear page index as this is now
> > what the page cache expects for hugetlb pages.
> > 
> > From the discussion on HGM for hugetlb[3], there is a want to remove hugetlb
> > special casing throughout the core mm code. This series accomplishes
> > a part of this by shifting complexity from filemap.c to hugetlb.c. There
> > are still checks for hugetlb within the filemap code as cgroup accounting
> > and hugetlb accounting are special cased as well. 
> > 
> > =========================== PERFORMANCE =====================================
> 
> Hi Sid,
> 
> Sorry for being dense but can you tell me what the below performance
> information means.  My concern with such a change would be any noticeable
> difference in populating a large (up to TB) hugetlb file.  My guess is
> that it is going to take longer unless xarray is optimized for this.
> 
> We do have users that create and pre-populate hugetlb files this big.
> Just want to make sure there are no surprises for them.

It's Going To Depend.  Annoyingly.

Let's say you're using 1GB pages on a 4kB PAGE_SIZE machine.  That's an
order-18 folio, so we end up skipping three layers of the tree, and if
you're going up to 1TB, it's structured:

root -> node (shift 30) -> node (shift 24) -> entry
                                           -> entry (...)
			-> node (shift 24) -> entry
					   (...)
			(...)

This is essentially no different from before where each 1GB page would
occupy a single entry.  It's just that it now occupies 2^18 entries,
and everything in the tree has a different label.

Where you will (may?) see a difference is with the 2MB entries.
An order-9 page doesn't quite fit with the order-6 nodes in the tree,
so it looks like this:

root -> node (s30) -> node (s24) -> node (s18) -> node (s12) -> entry 0
							     -> sibling
							     -> sibling
							     (...)
							     -> entry 8
							     -> sibling
							     -> sibling
							     (...)

so all of a sudden the tree is 8x as big as it used to be.  The upside
is that we lose all the calculations from filemap.c/pagemap.h.  It's a
lot better than it was perhaps five years ago when each 2MB page would
occupy 512 entries, but 8 entries is still worse than 1.

Could we do better?  Undoubtedly.  We could have variable shifts & node
sizes in the tree so that we perhaps had an s18 node that was 8x as large
(4160 bytes), and then each order-9 entry in the tree would occupy one
entry in that special large node.  I've been reluctant to introduce such
a beast without strong evidence it would help.  Or we could introduce a
small s12 node which could only store 8 entries (again an order-9 entry
would occupy one entry in such a special node).

These are things which would only benefit hugetlbfs, so there's a bit
of a chicken-and-egg problem; no demand for the feature until the work
is done, and the work maybe performs badly until the feature exists.

And then some architectures have other orders for their huge pages.
Order 11 is probably the worst possibility to exist (or in general 6n -
1), but I haven't done a detailed survey to figure out if anyone supports
such a thing.
