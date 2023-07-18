Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5570E7589D4
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 02:01:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbjGSABf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 20:01:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjGSABd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 20:01:33 -0400
Received: from out-42.mta1.migadu.com (out-42.mta1.migadu.com [IPv6:2001:41d0:203:375::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F52B1719
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 17:01:01 -0700 (PDT)
Date:   Wed, 19 Jul 2023 08:59:46 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1689724794;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MpJgs9wRGslX7B0v5r1djRNwrOTPSth9rMMf+bQv7bw=;
        b=WYnZ4pp9slmQ2hwQev8HbcppJxGxief9n5Va5HFZ1X1tR64d3tufyCKwlA6RML4tADBRvB
        B+f+tEGKcFEZzN1utrRUo0hvMhShxz/vE/k9e9lpGORIXNVD/djPI8y3fYbzt2ltu3RiOL
        +k/JLqwpVnJErwKnw/et3BFkM+7iBgA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Naoya Horiguchi <naoya.horiguchi@linux.dev>
To:     Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, willy@infradead.org,
        linmiaohe@huawei.com, naoya.horiguchi@nec.com,
        stable@vger.kernel.org
Subject: Re: [PATCH] mm/memory-failure: fix hardware poison check in
 unpoison_memory()
Message-ID: <20230718235946.GA1106729@ik1-406-35019.vs.sakura.ne.jp>
References: <20230717181812.167757-1-sidhartha.kumar@oracle.com>
 <20230718001409.GA751192@ik1-406-35019.vs.sakura.ne.jp>
 <20230718003956.GA762147@ik1-406-35019.vs.sakura.ne.jp>
 <6736667f-6456-34b5-1d1f-47219e499001@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6736667f-6456-34b5-1d1f-47219e499001@oracle.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 18, 2023 at 07:30:23AM -0700, Sidhartha Kumar wrote:
> On 7/17/23 5:39 PM, Naoya Horiguchi wrote:
> > On Tue, Jul 18, 2023 at 09:14:09AM +0900, Naoya Horiguchi wrote:
> > > On Mon, Jul 17, 2023 at 11:18:12AM -0700, Sidhartha Kumar wrote:
> > > > It was pointed out[1] that using folio_test_hwpoison() is wrong
> > > > as we need to check the indiviual page that has poison.
> > > > folio_test_hwpoison() only checks the head page so go back to using
> > > > PageHWPoison().
> > > > 
> > > > Reported-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > > > Fixes: a6fddef49eef ("mm/memory-failure: convert unpoison_memory() to folios")
> > > > Cc: stable@vger.kernel.org #v6.4
> > > > Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
> > > > 
> > > > [1]: https://lore.kernel.org/lkml/ZLIbZygG7LqSI9xe@casper.infradead.org/
> > > > ---
> > > >   mm/memory-failure.c | 2 +-
> > > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> > > > index 02b1d8f104d51..a114c8c3039cd 100644
> > > > --- a/mm/memory-failure.c
> > > > +++ b/mm/memory-failure.c
> > > > @@ -2523,7 +2523,7 @@ int unpoison_memory(unsigned long pfn)
> > > >   		goto unlock_mutex;
> > > >   	}
> > > > -	if (!folio_test_hwpoison(folio)) {
> > > > +	if (!PageHWPoison(p)) {
> > > 
> > > 
> > > I don't think this works for hwpoisoned hugetlb pages that have PageHWPoison
> > > set on the head page, rather than on the raw subpage. In the case of
> > > hwpoisoned thps, PageHWPoison is set on the raw subpage, not on the head
> > > pages.  (I believe this is not detected because no one considers the
> > > scenario of unpoisoning hwpoisoned thps, which is a rare case).  Perhaps the
> > > function is_page_hwpoison() would be useful for this purpose?
> > 
> > Sorry, I was wrong.  Checking PageHWPoison() is fine because the users of
> > unpoison should know where the PageHWPoison is set via /proc/kpageflags.
> > So this patch is OK to me after comments from other reviewers are resolved.
> > 
> 
> Hi Naoya,
> 
> While taking a closer at the patch, later in unpoison_memory() there is
> also:
> 
> -               ret = TestClearPageHWPoison(page) ? 0 : -EBUSY;
> +               ret = folio_test_clear_hwpoison(folio) ? 0 : -EBUSY;
> 
> I thought this folio conversion would be safe because page is the result of
> a compound_head() call but I'm wondering if the same issue exists here and
> we should be calling TestClearPageHWPoison() on the specific subpage by
> doing TestClearPageHWPoison(p).

In this case (get_hwpoison_page returns 0), the target of unpoison_memory was
buddy page or free huge page, so there seems not any realistic problem.
But putting back to TestClearPageHWPoison() looks consistent, so I'm fine with it.

Thanks,
Naoya Horiguchi
