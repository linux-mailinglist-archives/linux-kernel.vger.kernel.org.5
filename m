Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D111377D4C2
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 23:03:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239900AbjHOVDX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 17:03:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239795AbjHOVDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 17:03:14 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD03BF2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 14:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=LL1KvLzHhFBkD9AIgyLeOWRCgKApYsdyPiFaKvkG4Kw=; b=t7INgrVDxYvVPkKl8NvNusUivq
        +mjmtqF3WuGWK5tAOOlooiiXAIDjJbWuQ7yLCFc/omenuUj0QyEVTWOH9Ic8nDFDOCM1IT6jP4Etm
        /28k3tRPfvfELDoKX6eMxyfJKsP4Am8Cnq5SISHsUA5qPUjECYEkMqomdPk+8RdpJoG7c9QL8pEN7
        T1CWO3QyP7Nh1Dw1kxjf+5yPkQPbipvz+arnhiuhS+CPX6HWc7YuGkHXZuRtCN1dosoWxUqzbvTu9
        gnkv8PCBbiGrEusBOF2jEXME65osBRUw1Xd+/tBDlaArzPCs+z6lG5+8hgWCWWvzDbXLwLk3x1WRN
        u+rUk5JQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qW1Bs-00AQJq-Th; Tue, 15 Aug 2023 21:03:00 +0000
Date:   Tue, 15 Aug 2023 22:03:00 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Mike Kravetz <mike.kravetz@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Yang Shi <shy828301@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>
Subject: Re: [PATCH RFC v2 0/3] mm: Properly document tail pages for a folio
Message-ID: <ZNvoBAhrRvJI3COY@casper.infradead.org>
References: <20230814184411.330496-1-peterx@redhat.com>
 <ZNqHdIi8ySqwoswd@casper.infradead.org>
 <ZNqM43Y9Pa1S8N7D@x1n>
 <ZNr08E5bublfQI0J@casper.infradead.org>
 <ZNvT8aFemCdtTpBo@x1n>
 <ZNvdL/3kzIcJWKku@casper.infradead.org>
 <ZNvidA8/FkfHk/YU@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZNvidA8/FkfHk/YU@x1n>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 15, 2023 at 04:39:16PM -0400, Peter Xu wrote:
> On Tue, Aug 15, 2023 at 09:16:47PM +0100, Matthew Wilcox wrote:
> > No, sometimes there are things which shouldn't be documented because they
> > don't matter, and when changing code sometimes we forget to change the
> > documentation, and then people read the documentation which is different
> > from the code, and they get confused.
> > 
> > It matters that the various 'private' members line up.  It matters
> > that folio->index matches page->index.  It does not matter what
> > offset _entire_mapcount is at.  That can be moved around freely and no
> > documentation needs to be changed.
> > 
> > I don't want you to use FOLIO_MATCH to make any unnecessary assertions.
> > The only assertion missing is for _private_1 and _private_2a, and that's
> > why I wrote a patch to add them.
> 
> I didn't mean to add assertions for _entire_mapcount (I don't even know
> how..), but _mapcount and _refcount to clamp the fields, then all fields
> can be clear, just like head/flags clamping the start of fields.

Ah!  mapcount does make sense, yes.  We could just put a
			/* no more space here */
comment in, but an assert works too.

> One thing I can understand that you'd like to avoid these "offset" things
> is perhaps because you keep that in mind to, one day, have mmdesc replacing
> folio so folio doesn't need to match struct page at all some day,
> ideally. The order of fields, size of fields, etc. none of them should
> matter, when it comes, and we should go toward that.  However my argument
> would be that, before that day comes IMHO we need some good documentation
> for us to know how the fields look like now, why they worked, and how to
> reuse new fields.. when that comes, we can just safely remove these
> documentations.
> 
> It's just that these 'offset's still matter and matters a lot now, imho,
> but it's very confusing when read without some help.

No, that's not why I'm opposed to them.  I'm opposed to over-documenting
things, as I just outlined.  Documentation is necessary and good for all
kinds of reasons, but it should be meaningful and not prone to rot.  If
there's a tool that can tell you something, there's no point in
documenting it; that's why I pointed you towards pahole.  I also
like "documentation" which is checked by the compiler, hence the
existence of the FOLIO_MATCH macro which documents that the two
structures line up, and the compiler checks that they do.  FOLIO_MATCH
even caught a bug!

> Let me try one more time to see how you think about it on an rfcv3.  If
> that still doesn't get any form of ack from you, I'll put this aside.

At least we've got to something that I like the idea of ;-)
