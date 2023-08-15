Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADB1E77D3F6
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 22:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236024AbjHOURD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 16:17:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234668AbjHOUQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 16:16:56 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05359C7
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 13:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/9YcFGMjTmXUnLrKv4QF9PTeQWEDd0deRpHi/hJXg4I=; b=Yoz8qtkLjSkJfKTPRhC4/0t7M+
        +Y+Guwp081+fK1vH++EwchRlPbELgiRaLPpC7ubO8ncrMBIAdsx39bsSaIjslrmFOSM+b1W9hiVHS
        acpC8OIIE7ZywjizR5J8bLHbSTGylU7NgooknTMeDgTNoaWmMkWuTWXgXhzMYmn0c8OCB4TtBdlUj
        prk2P5oiXiuoquTciMa1hwsdWm7UX8lVPt4u1INl1rbgkB5EyNvZ/7UHRhoOOS4UNguXv2sM9lfL0
        PJzXaYeNSFyrObYMKw3YQ7mieS6GxwSHCkA6bkthnPvLlL3Hf2p50Dn2pJhgzzmaqF8C1tN8W6FUr
        4G0mMMFA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qW0T9-00ADGZ-My; Tue, 15 Aug 2023 20:16:47 +0000
Date:   Tue, 15 Aug 2023 21:16:47 +0100
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
Message-ID: <ZNvdL/3kzIcJWKku@casper.infradead.org>
References: <20230814184411.330496-1-peterx@redhat.com>
 <ZNqHdIi8ySqwoswd@casper.infradead.org>
 <ZNqM43Y9Pa1S8N7D@x1n>
 <ZNr08E5bublfQI0J@casper.infradead.org>
 <ZNvT8aFemCdtTpBo@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZNvT8aFemCdtTpBo@x1n>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 15, 2023 at 03:37:21PM -0400, Peter Xu wrote:
> On Tue, Aug 15, 2023 at 04:45:52AM +0100, Matthew Wilcox wrote:
> > I always forget about THP_SWAP using tail->private.  That actually needs
> > to be asserted by the compiler, not just documented.  Something along
> > these lines.
> > 
> > diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> > index 659c7b84726c..3880b3f2e321 100644
> > --- a/include/linux/mm_types.h
> > +++ b/include/linux/mm_types.h
> > @@ -340,8 +340,11 @@ struct folio {
> >  			atomic_t _pincount;
> >  #ifdef CONFIG_64BIT
> >  			unsigned int _folio_nr_pages;
> > -#endif
> > +			/* 4 byte gap here */
> >  	/* private: the union with struct page is transitional */
> > +			/* Fix THP_SWAP to not use tail->private */
> > +			unsigned long _private_1;
> > +#endif
> >  		};
> >  		struct page __page_1;
> >  	};
> > @@ -362,6 +365,9 @@ struct folio {
> >  	/* public: */
> >  			struct list_head _deferred_list;
> >  	/* private: the union with struct page is transitional */
> > +			unsigned long _avail_2a;
> > +			/* Fix THP_SWAP to not use tail->private */
> > +			unsigned long _private_2a;
> >  		};
> >  		struct page __page_2;
> >  	};
> > @@ -386,12 +392,18 @@ FOLIO_MATCH(memcg_data, memcg_data);
> >  			offsetof(struct page, pg) + sizeof(struct page))
> >  FOLIO_MATCH(flags, _flags_1);
> >  FOLIO_MATCH(compound_head, _head_1);
> > +#ifdef CONFIG_64BIT
> > +FOLIO_MATCH(private, _private_1);
> > +#endif
> >  #undef FOLIO_MATCH
> >  #define FOLIO_MATCH(pg, fl)						\
> >  	static_assert(offsetof(struct folio, fl) ==			\
> >  			offsetof(struct page, pg) + 2 * sizeof(struct page))
> >  FOLIO_MATCH(flags, _flags_2);
> >  FOLIO_MATCH(compound_head, _head_2);
> > +FOLIO_MATCH(flags, _flags_2a);
> > +FOLIO_MATCH(compound_head, _head_2a);
> > +FOLIO_MATCH(private, _private_2a);
> >  #undef FOLIO_MATCH
> >  
> >  /*
> > 
> > This is against the patchset I just posted which frees up a word in the
> > first tail page.
> 
> Okay, I assume you meant to suggest leverage FOLIO_MATCH(), which I can
> definitely try.  But then I'd hope it covers not only private field but all
> the fields that the tail pages reuses; the goal is to document everything
> no matter in what form.  I'll see what I can get..  Thanks.

No, sometimes there are things which shouldn't be documented because they
don't matter, and when changing code sometimes we forget to change the
documentation, and then people read the documentation which is different
from the code, and they get confused.

It matters that the various 'private' members line up.  It matters
that folio->index matches page->index.  It does not matter what
offset _entire_mapcount is at.  That can be moved around freely and no
documentation needs to be changed.

I don't want you to use FOLIO_MATCH to make any unnecessary assertions.
The only assertion missing is for _private_1 and _private_2a, and that's
why I wrote a patch to add them.
