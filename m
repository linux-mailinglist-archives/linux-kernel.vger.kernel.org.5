Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0474F7ECDEF
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 20:39:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234734AbjKOTjP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 14:39:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234721AbjKOTjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 14:39:13 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 665381A5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 11:39:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fBJcHqQEVaFglNHQdjjrI1nuF758JCtqWF32MgFM9JY=; b=Nepq4AU8q7jweHyqtxjH47ST2P
        OIZrV1uHP2cWjonavRphGtw6KmjvicMzQE7MUu9momz6ErjdNyc4WAZWQAOVvobZCy3mfirkHCXrA
        cEdHjYdaAB0oSOCAQJH08+D/+T7q0Zy/liRGnLbyXC975xVKyrmatuZpD7FjXHpmK/EN3GYMerEJn
        GlxomJxCxSD/8FcpXrTd12oQ5NKwskDjyUeSbst9ZNClSZolBhqj01ekFj/Av3Vfy6NpAHD3+SKFG
        2LvuWIe5lzExBgF6UYUPbnvGJ8CFFh9L6ytKZvqBUPXVqBE4nGxON4fdSAEt14jELOYDP7L26b6Hw
        aoM6O4tw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1r3Lj8-00G2SN-DY; Wed, 15 Nov 2023 19:39:06 +0000
Date:   Wed, 15 Nov 2023 19:39:06 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com, jose.pekkarinen@foxhound.fi
Subject: Re: [syzbot] [mm?] BUG: unable to handle kernel paging request in
 __pte_offset_map_lock
Message-ID: <ZVUeWvO4ypVmqlyX@casper.infradead.org>
References: <0000000000005e44550608a0806c@google.com>
 <b66659e9-a59e-fdf9-904c-ec25395b97ef@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b66659e9-a59e-fdf9-904c-ec25395b97ef@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 26, 2023 at 11:07:35PM -0700, Hugh Dickins wrote:
> I've spent a while worrying over this report, but have not been able
> glean much from it: I'm not at all familiar with arm64 debugging, so
> cannot deduce anything from the registers shown, though suspect they
> would shed good light on it; but it may just be a waste of time, since
> it was on a transient 6.6-rc6-based for-kernelci branch from last week.
> 
> If I read right, the reproducer is exercising MADV_PAGEOUT (splitting
> huge pages) and MADV_COLLAPSE (assembling huge pages), on mmaps
> MAP_FIXED MAP_SHARED MAP_ANONYMOUS i.e. shmem.
> 
> Suspicion falls on my 6.6-rc1 mm/khugepaged.c changes; but I don't see
> what's wrong, and shall probably give up and ignore this - unless an
> arm64 expert can take it further, or syzbot reproduces it on x86 on a
> known tree.

Just to tie the two threads together ... it looks to me like what's
happening is __pte_offset_map_lock() is racing with pagetable_pte_dtor().
That is, we're walking the page tables, find a pmd, look up its
page/ptdesc, but because CONFIG_LOCKDEP is enabled, ptdesc->ptl is a
pointer to a lock, and that pointer is NULL.

More discussion here:
https://lore.kernel.org/linux-mm/ZVUWLgFgu+jE3QmW@casper.infradead.org/T/#t
