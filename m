Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96C107FB0CC
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 05:06:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234559AbjK1EF5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 23:05:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234489AbjK1EFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 23:05:55 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4BB11AD
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 20:06:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9wOfKfUX3TH3E1LKOSPQ8crkusNA/WZ2sGV/FY6tU6E=; b=sjg/pnwlbXTgkJMCX/BSOJVCyZ
        v8qquO6PnPWQnuAlFF77pQ5yqVxBPvHuAC+TioLpsDXXhfpLdw2cQZ5o06bjW2W6s2urwrmPx3ZiG
        RpdKaQe5QOAoEkO7uJ2o8zJ0yxUVdsDoXcIZKrFiq2rQQ/brHkGD2Kmacbj0XuNUd3aLneWMUTaHH
        J5jX3H0hkRitJqwmIpg3I/VJWiDVwAYDOBuVVb6yZgsqXZCrcDN3YLtwd2J+QmLd23+sW8MMY20bn
        29m3dwNa2OF805UdckypKnphj1BWwutsLkuxOvQndYcqKCt5DHxLmXo4vLIOI9NF1UU1NwB611/Q1
        T92ZMrQg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1r7pLj-00C1Bx-4g; Tue, 28 Nov 2023 04:05:27 +0000
Date:   Tue, 28 Nov 2023 04:05:27 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Ryan Roberts <ryan.roberts@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yin Fengwei <fengwei.yin@intel.com>,
        Yu Zhao <yuzhao@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Itaru Kitayama <itaru.kitayama@gmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        John Hubbard <jhubbard@nvidia.com>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hugh Dickins <hughd@google.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v7 00/10] Small-sized THP for anonymous memory
Message-ID: <ZWVnBwe8dUO5CgTp@casper.infradead.org>
References: <20231122162950.3854897-1-ryan.roberts@arm.com>
 <ZV9267tQEhoPzCru@casper.infradead.org>
 <f8e518f2-fb15-4295-a335-bea5a8010ab2@arm.com>
 <ZWC9lwDAjMZsNzoG@casper.infradead.org>
 <9c8f6d2a-7ed8-45d2-9684-d77489bd99b8@redhat.com>
 <ZWDG6BYqmZVpyTLL@casper.infradead.org>
 <26c361bc-6d87-4a57-9fae-ef635c9039c7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26c361bc-6d87-4a57-9fae-ef635c9039c7@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 24, 2023 at 06:34:10PM +0100, David Hildenbrand wrote:
> On 24.11.23 16:53, Matthew Wilcox wrote:
> > > * we already have PMD-sized "large anon folios" in THP
> > 
> > Right, those are already accounted as THP, and that's what users expect.
> > If we're allocating 1024 x 64kB chunks of memory, the user won't be able
> > to distinguish that from 32 x 2MB chunks of memory, and yet the
> > performance profile for some applications will be very different.
> 
> Very right, and because there will be a difference between 1024 x 64kB, 2048
> x 32 kB and so forth, we need new memory stats either way.
> 
> Ryan had some ideas on that, but currently, that's considered future work,
> just like it likely is for the pagecache as well and needs much more
> thoughts.
> 
> Initially, the admin will have to enable all that for anon either way. It
> all boils down to one memory statistic for anon memory (AnonHugePages)
> that's messed-up already.

So we have FileHugePages which is very carefully only PMD-sized large
folios.  If people start making AnonHugePages count non-PMD-sized
large folios, that's going to be inconsistent.

> > am objecting to the use of the term "small THP" on the grounds of
> > confusion and linguistic nonsense.
> 
> Maybe that's the reason why FreeBSD calls them "medium-sized superpages",
> because "Medium-sized" seems to be more appropriate to express something "in
> between".

I don't mind "medium" in the name.

> So far I thought the reason was because they focused on 64k only.
> 
> Never trust a German guy on naming suggestions. John has so far been my
> naming expert, so I'm hoping he can help.
> 
> "Sub-pmd-sized THP" is just mouthful. But then, again, this is would just be
> a temporary name, and in the future THP will just naturally come in multiple
> sizes (and others here seem to agree on that).

I do not.  If we'd come to this fifteen years ago, maybe, but people now
have an understanding that THPs are necessarily PMD sized.

