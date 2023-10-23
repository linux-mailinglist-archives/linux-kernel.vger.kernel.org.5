Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2F5A7D3C22
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 18:18:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233760AbjJWQS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 12:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233756AbjJWQSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 12:18:12 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 262A319A0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 09:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wJoeaIA6FR7cRFMOHhnvGNO3vbLc3uINcEPUKYT9ywY=; b=UD2TR978zD7OxJLI8Obx41DbyC
        9Z2iRwTpFFTi4LJ3BjtvZDYzJoNqqZ7tlmPrt6tY0xbLwtr75eFzvZv+pJMWlSZgMO/lXbZ+cRznJ
        7G+YTEwEO2M1tK/VH0DaObCSrYgGWPiR4+UnAVsUDxbss39LL1e5CnwaN4RmqgMYbxwVmqtmYQDmR
        dy4yQsPdQxBYI0UfH5VAUawaPjLKE8gQInb3q+cVzRW4SzrXZ82/XkrX+meF52HSb3J2yFBUYS8tk
        4ZqWGT+c9/4ddW+4bhjbwze4neoigXzjPPF1zOPOwpL0LoZCOgmUg9OzqlKAMfq5x36Sn2A4pYhxb
        VebYdxig==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1quxcb-00ElHj-Jv; Mon, 23 Oct 2023 16:17:41 +0000
Date:   Mon, 23 Oct 2023 17:17:41 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     wang wei <a929244872@163.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/page_alloc: fix the potential memory waste in
 page_frag_alloc_align
Message-ID: <ZTacpcP4zt9BS9xO@casper.infradead.org>
References: <20231023154216.376522-1-a929244872@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231023154216.376522-1-a929244872@163.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 23, 2023 at 11:42:16PM +0800, wang wei wrote:
> First step, allocating a memory fragment with size 1KB bytes uses
> page_frag_alloc_align.  It will allocate PAGE_FRAG_CACHE_MAX_SIZE
> bytes by __page_frag_cache_refill, store the pointer at nc->va and
> then return the last 1KB memory fragment which address is nc->va
> + PAGE_FRAG_CACHE_MAX_SIZE - 1KB. The remaining PAGE_FRAG_CACHE_MAX_SIZE
> - 1KB bytes of memory can Meet future memory requests.
> 
> Second step, if the caller requests a memory fragment with size
> more then PAGE_FRAG_CACHE_MAX_SIZE bytes,  page_frag_alloc_align,
> it will also allocate PAGE_FRAG_CACHE_MAX_SIZE bytes by
> __page_frag_cache_refill,  store the pointer at nc->va, and
> return NULL.  this behavior makes the rest of
> PAGE_FRAG_CACHE_MAX_SIZE - 1KB bytes memory at First step are
> wasted(allocate from buddy system but not used).

We could do this, but have you ever seen this happen, or are you
just reading code and looking for problems?  If the latter, I think
you've misunderstood how this allocator is normally used.

