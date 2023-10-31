Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAE007DC930
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 10:14:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343787AbjJaJOA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 05:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343706AbjJaJN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 05:13:59 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CD0B9F
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 02:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YApjqNuY/pq2MHNZwmUHJN8pF6DxZ+rCEU+vQbGIA8M=; b=G9ZNY+DAmo8332MzV9l/PQQwmC
        o7o5SsvLHyzxa8USmMigjOAkK37lkMQroCjd3qqlmLF1oSU5Yr6BM6YJu26qzpHp3CABAL5iiK3ss
        xogWruUgt+Q3DwWBhwYMtTCB9PMR+BqU9438Ws90S18eu3SkBLlqHZJgxiezZ9xMx/usvGnJP5oOb
        lJ+U4W6JvrNOY5WE80pkrIUdTmw/Pd0OqlS6UwU9XilyxbnqGLtVLva6NNGim5wh1Ujz+wQbeuqSP
        OL9eoTlSeq16878IMP2aCNiOssibh9H2iIsMNuQBDUFWYEu4b5JgN7YrVKr3jZUXNYEsgd3tddeCT
        itqCmHuQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qxkoi-009IZB-5G; Tue, 31 Oct 2023 09:13:44 +0000
Date:   Tue, 31 Oct 2023 09:13:44 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Gregory Price <gregory.price@memverge.com>
Cc:     Gregory Price <gourry.memverge@gmail.com>, linux-mm@kvack.org,
        akpm@linux-foundation.org, david@redhat.com, vbabka@suse.cz,
        naoya.horiguchi@linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] kpageflags: respect folio head-page flag placement
Message-ID: <ZUDFSEvpxxoGWmdG@casper.infradead.org>
References: <20231030180005.2046-1-gregory.price@memverge.com>
 <ZUA6qq6zXuc0fqOE@casper.infradead.org>
 <ZUA/IzTMokFsXS5Y@memverge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZUA/IzTMokFsXS5Y@memverge.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2023 at 07:41:23PM -0400, Gregory Price wrote:
> On Mon, Oct 30, 2023 at 11:22:18PM +0000, Matthew Wilcox wrote:
> > On Mon, Oct 30, 2023 at 02:00:05PM -0400, Gregory Price wrote:
> > > kpageflags reads page-flags directly from the page, even when the
> > > respective flag is only updated on the headpage of a folio.
> > > 
> > > Update bitchecks to use PAGEFLAG() interfaces to check folio for the
> > > referenced, dirty, lru, active, and unevictable bits.
> > 
> > But uptodate, writeback and reclaim (amongst others) are also defined
> > only on the head page.
> > 
> 
> Ah yes i was only looking at the things defined w/ PAGEFLAG defines in
> page-flags.h. I'll give it full once over can collect them all, my bad.
> 
> (also i forgot to update my commit message)
> 
> Quick question here since i have your attention: any recommendation on
> what to do for ONLY_HEAD flags?  If the provided page is not the head,
> should the flag report 0... or whatever the head says?

Thinking about it some more, really almost all flags are per-folio, not
per-page.  The only exceptions are HWPoison and AnonExclusive.  So
probably the right way to do this is to make k = folio->flags, and
then just change a few places rather than changing all the places that
test 'k'.
