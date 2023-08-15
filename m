Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65C5E77C687
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 05:54:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234528AbjHODxy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 23:53:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234617AbjHODv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 23:51:59 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F63E1BCB
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 20:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tpgOMn6tupkg0P9G8ls5DuN8dJfuULFXJ/njpEhLLnw=; b=bg5cqlPueHT6akZgRTTSPMZaUd
        FHlH+YLGkfAh+RZzgSYetab8tX5v8EHIBsw23fiE9I8HTEDHc2Y7ht1b9XmdYJROmsJkX1AfHDr5b
        7dRcEdQxlD1UN1CjlETmirYTv/K5TY/Cu9cgXeOUC23FlK0zhTYqYVnUqi9gmhImLDOdqIguHhbqV
        ZKmWxB1vPg0ylWCj9/W0DwCHjR+IjsaDKA0GWM+5gmhqlMcLNPEDVE7zVfegzPvrrhsnvC2oHrVtl
        lOr3stiitSDAgBbRmh4KQ9asUb0esS9iCQUMYXV5qvW2nFUYUSsm7z7pnswzuJYtbw+51hzLdQW9/
        mMn8rEpQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qVl0C-005viq-Mf; Tue, 15 Aug 2023 03:45:52 +0000
Date:   Tue, 15 Aug 2023 04:45:52 +0100
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
Message-ID: <ZNr08E5bublfQI0J@casper.infradead.org>
References: <20230814184411.330496-1-peterx@redhat.com>
 <ZNqHdIi8ySqwoswd@casper.infradead.org>
 <ZNqM43Y9Pa1S8N7D@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZNqM43Y9Pa1S8N7D@x1n>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2023 at 04:21:55PM -0400, Peter Xu wrote:
> On Mon, Aug 14, 2023 at 08:58:44PM +0100, Matthew Wilcox wrote:
> > On Mon, Aug 14, 2023 at 02:44:08PM -0400, Peter Xu wrote:
> > 
> > Look, this is all still too complicated.  And you're trying to make
> > something better that I'm trying to make disappear.  I'd really rather
> > you spent your time worrying about making userfaultfd use folios
> > than faffing with this.
> 
> I saw that internally some of uffd already start to use folio, while I
> don't think the syscall part needs changing yet - the ranged API should
> work for folio when it comes, and other than that folio should be hidden
> and transparent, afaiu.
> 
> Do you mean when large folios can land on anon/shmem we can start to
> allocate large folios there for uffd operations?  Or something else?

Hm, I thought there were some parts that still needed to be converted.
But I don't see anything obvious right now.

> > @@ -360,6 +363,7 @@ struct folio {
> >  			unsigned long _head_2a;
> >  	/* public: */
> >  			struct list_head _deferred_list;
> > +			/* three more words available here */
> 
> .. not really three more words here but 2 for 32 bits and 1 for 64 bits.
> In my patch 3 I used "8 bytes free" so it's applicable to both.

I always forget about THP_SWAP using tail->private.  That actually needs
to be asserted by the compiler, not just documented.  Something along
these lines.

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 659c7b84726c..3880b3f2e321 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -340,8 +340,11 @@ struct folio {
 			atomic_t _pincount;
 #ifdef CONFIG_64BIT
 			unsigned int _folio_nr_pages;
-#endif
+			/* 4 byte gap here */
 	/* private: the union with struct page is transitional */
+			/* Fix THP_SWAP to not use tail->private */
+			unsigned long _private_1;
+#endif
 		};
 		struct page __page_1;
 	};
@@ -362,6 +365,9 @@ struct folio {
 	/* public: */
 			struct list_head _deferred_list;
 	/* private: the union with struct page is transitional */
+			unsigned long _avail_2a;
+			/* Fix THP_SWAP to not use tail->private */
+			unsigned long _private_2a;
 		};
 		struct page __page_2;
 	};
@@ -386,12 +392,18 @@ FOLIO_MATCH(memcg_data, memcg_data);
 			offsetof(struct page, pg) + sizeof(struct page))
 FOLIO_MATCH(flags, _flags_1);
 FOLIO_MATCH(compound_head, _head_1);
+#ifdef CONFIG_64BIT
+FOLIO_MATCH(private, _private_1);
+#endif
 #undef FOLIO_MATCH
 #define FOLIO_MATCH(pg, fl)						\
 	static_assert(offsetof(struct folio, fl) ==			\
 			offsetof(struct page, pg) + 2 * sizeof(struct page))
 FOLIO_MATCH(flags, _flags_2);
 FOLIO_MATCH(compound_head, _head_2);
+FOLIO_MATCH(flags, _flags_2a);
+FOLIO_MATCH(compound_head, _head_2a);
+FOLIO_MATCH(private, _private_2a);
 #undef FOLIO_MATCH
 
 /*

This is against the patchset I just posted which frees up a word in the
first tail page.

