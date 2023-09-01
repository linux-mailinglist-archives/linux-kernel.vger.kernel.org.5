Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D56ED79008E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 18:13:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344743AbjIAQNq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 12:13:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344143AbjIAQNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 12:13:43 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6AD010EF
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 09:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=NSkOr/qzarOgeHRQXx2jXIFi81Mb5b1Le+e/GncXZHA=; b=Dh9+zxZeSkMxui8dMapRCvNdfI
        p7UDpJwmo7AUHWD43+f8a94hjk+SnKBxZsP9IR4Vivk91PzA9uKmlTnlWguv3XEJK0X5N/2JZrcfT
        XN0jnAPFvrJVDeQohg9wFOOQOshNzfH8FzFYmyZjb4axtcEqM3atDc/42sZxgCEU0rjBcO+y6N1OZ
        iDPoToPEnjoXVmpogsRY93QGl5EB3kuIKY+HoMhfF0BK//pynz3jzdxU8W47N6FuwjVCVZ2ywUn2X
        dwlxOtSi9R+of3T5POCDiUc2osBTb6D3pP+Rh4y3FGh95kTVDwzdJFpIIUex4kWqeabsR8uIhTW9Y
        h1WLEilw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qc6ll-008T48-Jt; Fri, 01 Sep 2023 16:13:13 +0000
Date:   Fri, 1 Sep 2023 17:13:13 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Yang Shi <shy828301@gmail.com>
Cc:     David Hildenbrand <david@redhat.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yin Fengwei <fengwei.yin@intel.com>,
        Yu Zhao <yuzhao@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Zi Yan <ziy@nvidia.com>, Luis Chamberlain <mcgrof@kernel.org>,
        Itaru Kitayama <itaru.kitayama@gmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 3/5] mm: LARGE_ANON_FOLIO for improved performance
Message-ID: <ZPINmXyTgy2wqLqr@casper.infradead.org>
References: <20230810142942.3169679-1-ryan.roberts@arm.com>
 <20230810142942.3169679-4-ryan.roberts@arm.com>
 <87v8dg6lfu.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <5c9ba378-2920-4892-bdf0-174e47d528b7@arm.com>
 <87cyz43s63.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <4e14730b-4e4c-de30-04bb-9f3ec4a93754@redhat.com>
 <CAHbLzkog9B_NWhvYmb7=n3Fnb0oER-sXhE3=Nyx_8Kc3-dggcQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHbLzkog9B_NWhvYmb7=n3Fnb0oER-sXhE3=Nyx_8Kc3-dggcQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 31, 2023 at 10:15:09AM -0700, Yang Shi wrote:
> On Thu, Aug 31, 2023 at 12:57 AM David Hildenbrand <david@redhat.com> wrote:
> > Let's talk about that in a bi-weekly MM session. (I proposed it as a
> > topic for next week).
> >
> > As raised in another mail, we can then discuss
> > * how we want to call this feature (transparent large pages? there is
> >    the concern that "THP" might confuse users. Maybe we can consider
> >    "large" the more generic version and "huge" only PMD-size, TBD)
> 
> I tend to agree. "Huge" means PMD-mappable (transparent or HugeTLB),
> "Large" means any order but less than PMD-mappable order, "Gigantic"
> means PUD mappable. This should incur the least confusion IMHO.

"Large" means any order > 0.  The limitation to <= PMD_ORDER is simply
because I don't want to go through the whole VM and fix all the places
that assume that pmd_page() returns a head page.  The benefit to doing so
is quite small, and the work to achieve it is quite large.  The amount of
work needed should decrease over time as we convert more code to folios,
so deferring it is the right decision today.

But nobody should have the impression that large folios are smaller
than PMD size, nor even less than or equal.  Just like they shouldn't
think that large folios depend on CONFIG_TRANSPARENT_HUGEPAGE.  They do
today, but that's purely an implementation detail that will be removed
eventually.

> > I think there *really* has to be a way to disable it for a running
> > system, otherwise no distro will dare pulling it in, even after we
> > figured out the other stuff.
> 
> TBH I really don't like to tie large folio to THP toggles. THP
> (PMD-mappable) is just a special case of LAF. The large folio should
> be tried whenever it is possible ideally. But I do agree we may not be
> able to achieve the ideal case at the time being, and also understand
> the concern about regression in early adoption, so a knob that can
> disable large folio may be needed for now. But it should be just a
> simple binary knob (on/off), and should not be a part of kernel ABI
> (temporary and debugging only) IMHO.

Best of luck trying to remove it after you've shipped it ... we've
never been able to remove any of the THP toggles, only make them more
complicated.

> One more thing we may discuss is whether huge page madvise APIs should
> take effect for large folio or not.

They already do for file large folios; we listen to MADV_HUGEPAGE and
attempt to allocate PMD_ORDER folios for faults.

