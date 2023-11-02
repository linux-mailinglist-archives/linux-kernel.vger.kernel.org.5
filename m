Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DFF87DF2F5
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 13:56:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346297AbjKBM4Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 08:56:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbjKBM4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 08:56:23 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A0B8BD
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 05:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=GgcTWdqaw8oTk+H9w/UodRkn+QGXypNGd40ay+cpcY0=; b=djPoEPuh+ZLdtsbjdVDzS8CFes
        b8Z/04IZs0mtZKhqIW/0RO3WsG6AOCROoYP8hZ04nxikF9j/LRA888xmDDtd4bQB9XsKSkQMlr9AT
        xDUZvte1c2a9XtkE2UlV8HzuHvFEiPMZ2MJF0XRgvMDTobSRQKbCqG4GbI/tZeaQpoODbsLwMxBeG
        L5B9lCNfhw8hFpIbuTa9IikQu+d4ReMcfBhFR1nENlYfnLsfa8IdnCjHLpx7wcuc4j6zYgF/SDZ8M
        iWe5IBRRL9kSBTIqpkEdXII6E5z1QzE47l93X6JWvguRQMJ8P3zTjfB2mVAa/cFyJGD3/G0TTlLf9
        xM1Yr8/g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qyXF9-004Y5E-Tc; Thu, 02 Nov 2023 12:56:15 +0000
Date:   Thu, 2 Nov 2023 12:56:15 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Should vmap() work on pages or folios?
Message-ID: <ZUOcb1YwUEDT/r3K@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For various reasons, I started looking at converting vm_struct.pages
to be vm_struct.folios.  But vmap() has me wondering because it
contains:

        if (flags & VM_MAP_PUT_PAGES) {
                area->pages = pages;
                area->nr_pages = count;
        }

In principle, then, we could call vmap() with an array of pages that
includes tail pages.  However, I think if we do that today, things
will go badly wrong.  You see, despite the name of the flag, we don't
actually call put_page().  Instead, we call __free_page() which calls
__free_pages(page, 0), which calls put_page_testzero().  Since tail
pages have a refcount of 0, it'll hit the VM_BUG_ON_PAGE().

From this, I can conclude nobody does this today.  But people might be
calling vmap() with tail pages and VM_MAP_PUT_PAGES _not_ set.  And
it's not necessarily a stupid thing to want to stitch together some
tail pages (from different folios) into a virtually contiguous block.
I thibk the primary usecase is order-0 allocations being stuck together
into a virtually contiguous block, but I haven't audited every caller
of vmap.

So what's our intent here?  Should we fix vmap() to actually work with
tail pages?  Should we require vmap() to only work on order-0 pages?
