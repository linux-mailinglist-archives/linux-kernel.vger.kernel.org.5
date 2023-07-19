Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50A0A759853
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 16:28:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231580AbjGSO2i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 10:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230289AbjGSO2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 10:28:36 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6A2410B
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 07:28:34 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id af79cd13be357-7659db6339eso41754685a.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 07:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20221208.gappssmtp.com; s=20221208; t=1689776914; x=1690381714;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Tl31fPEVZv/XSj4GJGcrVMvmw4IX33aKorlexj1wX2k=;
        b=LAalPu6eJykTNbpvUv7GdqmiAa0NeQssVV1cu5H5/loGl4URTMZeskfrSeGtfb/S6j
         7w1DIl0VTfcOFpRB7AaTNUt7n4W5PhW1Y03cLDKqEGpdLgBoN3B17yjDaOhnNRd8ECmL
         +eYTK2flqDOooPfT0WzfOiO1odqa9CeAZ6SFHqFdmS7GAsLgCvEWQisjAL8noyuVj+Xv
         mdOLFBlOne1S1gv51gLVErVX6Yh127f2D6XMxFRUIiuSU2ZvRjoUg+DJimN7qrxi10cL
         WKeqIymmm435NdpaWWLN1fNZN93R27UGpAR0x2n6aqIz0dbFwUpedBBESx4V3qUdrrvW
         yV1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689776914; x=1690381714;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Tl31fPEVZv/XSj4GJGcrVMvmw4IX33aKorlexj1wX2k=;
        b=EQPPSLoVaS1jbUib7lX/2IQO3jfZzqN808Gi0GIgsvYG4XVyoWLRWKQzXJlE0Vqb7k
         zNfGnl3AdLqcm6+6Czw6Vv/h11gLAQLPLSGrQJrWq3ZJpUmYkbH1wLYB0HszDaUQ63dt
         0ciP+Uu/YP+Zzn7MU9boaJ1F5ZCSAK3CnvmEP0ykkanheqh2u9W8FEWZHgNbHHG4Bijy
         yX9FNdllWEMT4rS68wAIS4Yq8FqZIJvFbARfsGAl2d0rOMUYduHENV1rSEyTbhDheabA
         nST2aLqPAiAFmebq0Cr9B/gI/aEhmeOM4ya/r11KY1+bSQljM/8K3an+1YcMoAvo6CDJ
         6wZg==
X-Gm-Message-State: ABy/qLbpEHYnaePBAlVmzb1JlcCGfIUGhJR+Lgpmgqplt4ynL7jpYld6
        nhw2Ecbf5kYd2Ovoam/3aCrdrg==
X-Google-Smtp-Source: APBJJlEMrxHzKfhacxnycVwdc58qqKM0ubUIR2hO4njFovHpv9dpC8lvbXt6kfn1Msdilz1REn71SQ==
X-Received: by 2002:a05:620a:444a:b0:762:3841:c098 with SMTP id w10-20020a05620a444a00b007623841c098mr3072588qkp.30.1689776913751;
        Wed, 19 Jul 2023 07:28:33 -0700 (PDT)
Received: from localhost (2603-7000-0c01-2716-8f57-5681-ccd3-4a2e.res6.spectrum.com. [2603:7000:c01:2716:8f57:5681:ccd3:4a2e])
        by smtp.gmail.com with ESMTPSA id g20-20020a0caad4000000b00635ef0579c2sm1510550qvb.39.2023.07.19.07.28.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 07:28:33 -0700 (PDT)
Date:   Wed, 19 Jul 2023 10:28:32 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Nhat Pham <nphamcs@gmail.com>,
        Domenico Cerasuolo <cerasuolodomenico@gmail.com>,
        konrad.wilk@oracle.com, vitaly.wool@konsulko.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: kill frontswap
Message-ID: <20230719142832.GA932528@cmpxchg.org>
References: <20230714194610.828210-1-hannes@cmpxchg.org>
 <ZLIVleBYOm4HIGTZ@casper.infradead.org>
 <20230717141250.GA866068@cmpxchg.org>
 <901409ed-504b-9500-54d8-e42f832e07b0@suse.cz>
 <20230717160227.GA867137@cmpxchg.org>
 <CAJD7tkbkoph+N3E92n4xGAvVP12H=issOfAPmdrS0655Ja=qAw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJD7tkbkoph+N3E92n4xGAvVP12H=issOfAPmdrS0655Ja=qAw@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yosry,

thanks for the review. I hope I saw everything you commented on ;) -
can you please trim your replies to the relevant hunks?

On Tue, Jul 18, 2023 at 11:52:45AM -0700, Yosry Ahmed wrote:
> On Mon, Jul 17, 2023 at 9:02 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
> > -/*
> > - * "Get" data from frontswap associated with swaptype and offset that were
> > - * specified when the data was put to frontswap and use it to fill the
> > - * specified page with data. Page must be locked and in the swap cache.
> > - */
> > -int __frontswap_load(struct page *page)
> > -{
> > -       int ret = -1;
> > -       swp_entry_t entry = { .val = page_private(page), };
> > -       int type = swp_type(entry);
> > -       struct swap_info_struct *sis = swap_info[type];
> > -       pgoff_t offset = swp_offset(entry);
> > -       bool exclusive = false;
> > -
> > -       VM_BUG_ON(!frontswap_ops);
> > -       VM_BUG_ON(!PageLocked(page));
> > -       VM_BUG_ON(sis == NULL);
> > -
> > -       if (!__frontswap_test(sis, offset))
> > -               return -1;
> 
> With the removal of the above, it will be a bit slower to realize an
> entry is not in zswap and read it from disk (bitmask test vs. rbtree
> lookup). I guess in the swapin path (especially from disk), it would
> not matter much in practice. Just a note (mostly to myself).

I briefly considered moving that bitmap to zswap, but it actually
seems quite backwards. It adds overhead to the fast path, where
entries are in-cache, in order to optimize the cold path that requires
IO. As long as compression is faster than IO, zswap is expected to see
the (much) bigger share of transactions in any sane config.

> > @@ -1356,15 +1342,12 @@ static int zswap_frontswap_store(unsigned type, pgoff_t offset,
> >
> >         /* map */
> >         spin_lock(&tree->lock);
> > -       do {
> > -               ret = zswap_rb_insert(&tree->rbroot, entry, &dupentry);
> > -               if (ret == -EEXIST) {
> > -                       zswap_duplicate_entry++;
> > -                       /* remove from rbtree */
> > -                       zswap_rb_erase(&tree->rbroot, dupentry);
> > -                       zswap_entry_put(tree, dupentry);
> > -               }
> > -       } while (ret == -EEXIST);
> > +       while (zswap_rb_insert(&tree->rbroot, entry, &dupentry) == -EEXIST) {
> > +               zswap_duplicate_entry++;
> > +               /* remove from rbtree */
> > +               zswap_rb_erase(&tree->rbroot, dupentry);
> > +               zswap_entry_put(tree, dupentry);
> 
> nit: it would be nice to replace the above two lines with
> zswap_invalidate_entry(), which also keeps it clear that we maintain
> the frontswap semantics of invalidating a duplicated entry.

Agreed, that's better. I'll send a follow-up.

> > @@ -1418,7 +1401,7 @@ static int zswap_frontswap_load(unsigned type, pgoff_t offset,
> >         if (!entry) {
> >                 /* entry was written back */
> 
> nit: the above comment is now obsolete. We may not find the entry
> because it was never stored in zswap in the first place (since we
> dropped the frontswap map, we won't know before we do the lookup
> here).

Good catch. I'll send a delta fix to Andrew.

> LGTM with a few nits above, probably they can be done in follow up
> patches. Thanks for the cleanup!
> 
> FWIW:
> Acked-by: Yosry Ahmed <yosryahmed@google.com>

Thanks!

Andrew, could you please fold this in?

---

From 86eeba389d7478e5794877254af6cc0310c835c7 Mon Sep 17 00:00:00 2001
From: Johannes Weiner <hannes@cmpxchg.org>
Date: Wed, 19 Jul 2023 10:21:49 -0400
Subject: [PATCH] mm: kill frontswap fix

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/zswap.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index d58672f23d43..583ef7b84dc3 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1399,7 +1399,6 @@ bool zswap_load(struct page *page)
 	spin_lock(&tree->lock);
 	entry = zswap_entry_find_get(&tree->rbroot, offset);
 	if (!entry) {
-		/* entry was written back */
 		spin_unlock(&tree->lock);
 		return false;
 	}
-- 
2.41.0
