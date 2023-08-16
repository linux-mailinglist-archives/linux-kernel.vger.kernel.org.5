Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3B2477E8E7
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 20:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345608AbjHPSlq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 14:41:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345641AbjHPSlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 14:41:22 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79AA926A8
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 11:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=CU9DWRuQVtz+NiMHTdyB07EnkShG5B6QCmpz2Q3GQuY=; b=Rez3Cb78XPGne3zPRxlwPkh4lf
        ye9rNSEVBRnOouLi9yt0lCwa5cabNtrpAp6Ql2AWv57bSwje3jdCv76RCnBHr5VlsK55ZOjGp86Yd
        Ro4iegAA3pL2xUMWr+9JPyEslQNyb74WVgSClo4qs4ut1H5uygITBWNieGcp7w8oIVVHA9p4bcdGu
        ILGqdgLyw9KgnKqO4Uw1/kMdn35EFi45oLiGvxMf8U0XvEyaNr+Bm7xLZEc9Uojoc7S89ZiMtQIEl
        ExU+OJP5KnIHuFdoMTuOsALmcx8zw4LNHHfOZ9IBomBUQsX0fdqUxjMpPCp30AIrxYTSYipnIE6f9
        wEGsCnzA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qWLSC-00GG5E-Ug; Wed, 16 Aug 2023 18:41:12 +0000
Date:   Wed, 16 Aug 2023 19:41:12 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Hugh Dickins <hughd@google.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Randy Dunlap <rdunlap@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Yu Zhao <yuzhao@google.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yang Shi <shy828301@gmail.com>
Subject: Re: [PATCH RFC v3] mm: Proper document tail pages fields for folio
Message-ID: <ZN0YSOQmSR/voPVO@casper.infradead.org>
References: <20230815212547.431693-1-peterx@redhat.com>
 <b887e764-ffa3-55ee-3c44-69cb15f8a115@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b887e764-ffa3-55ee-3c44-69cb15f8a115@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2023 at 03:33:30PM +0200, David Hildenbrand wrote:
> My simple tests passed so far. If there isn't something obvious missing,
> I can do more testing and send this as an official patch.

I think you missed one:

+++ b/mm/swapfile.c
@@ -1490,7 +1490,7 @@ int swp_swapcount(swp_entry_t entry)

        page = vmalloc_to_page(p->swap_map + offset);
        offset &= ~PAGE_MASK;
-       VM_BUG_ON(page_private(page) != SWP_CONTINUED);
+       VM_BUG_ON(page_swap_entry(page).val != SWP_CONTINUED);

        do {
                page = list_next_entry(page, lru);

I'm not smart enough to understand the use of the one in
add_swap_count_continuation().  Maybe that also needs to be fixed?
Maybe it should be fixed for consistency anyway.

