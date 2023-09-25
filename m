Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E07567AD7F2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 14:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231370AbjIYMZ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 08:25:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231410AbjIYMZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 08:25:23 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF1A0FC
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 05:25:15 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id 6a1803df08f44-658967a5334so39862966d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 05:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1695644715; x=1696249515; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YfegDYKBT6wkjhbo8Ou4Wlol6W+gElO2eBlC6j3i9zc=;
        b=xr+riMFD0A1PYWMPoEX+VxIAVJ68dg8dwCBgjPgJMRYhvyagfnW2yy577521U7A0iZ
         uXKPPRDIPwpYjI7+Ven/b8MbCg1/Y9GartgX0g9KioHhIC2oJtEYs15ZYMCs0bMUfeqG
         HVdC45E5ZMhp2zxRgk8OMtND5csb+6y9Jm0BINcNFg8Z4SbGKDzWQ5Cj/zjR8Ajha3q1
         MgLtUdCElFWB+nYhpRB4gBy1u2g5icX7SJOBQ+89ttlSpIjhkLRCuMKgbl8zmxMB1gCD
         V9AFe1z0dt/Ww8NnKyGAPcK6nbXz4AKcynMzHkNC8fizLJDi5xGpQA4qb6hCfcSwnVD8
         UHCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695644715; x=1696249515;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YfegDYKBT6wkjhbo8Ou4Wlol6W+gElO2eBlC6j3i9zc=;
        b=o/EFQYc7ocdthMhBTpbfTpLb8w78BnBDVCe6GhwDCng4Jtl+71GkTKx+Br6Qf62Tvc
         kl2o7z45QN4SD6MgwJxZkavSgt4I7kkOy31k8eLVrhIu2/p7fErCcFt6PGcXt9nzkWKC
         As1VPvlU2sp22ySox9Wx351xUMY/m1KoJFXFkoixKbG9AcICrwltGMliR3ncgQBfiUH8
         BHAvyzTebPrefh974RNx4jxQruGZbGq3jhEB6nr8dyxt+jBXEEaNkZBpCkxzH2w5979k
         NTOFvTDajqyc2w2tlLENlfYoZpbuKY4HjohL/ecjNZhzYPYk+AWSmu1VbFsLcvkEXP6K
         IyWQ==
X-Gm-Message-State: AOJu0YwOqstDYGoxMurWrsy3Oyih5k1zNYKRVR2avSrjmJfJBHhi6yPo
        ZSz3kxAEc8m2lU5pp0MCH531Rg==
X-Google-Smtp-Source: AGHT+IE0HQi6fewMm+p89bKgS2wyZhegjV0VPfXglDGQjZ3Ga/xG8IlIvVqHzJPZevS7sicmbehZHA==
X-Received: by 2002:a0c:f512:0:b0:65b:748:cdd3 with SMTP id j18-20020a0cf512000000b0065b0748cdd3mr3188605qvm.29.1695644714927;
        Mon, 25 Sep 2023 05:25:14 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:ba06])
        by smtp.gmail.com with ESMTPSA id e27-20020a0caa5b000000b0065b0d2f9121sm1012863qvb.68.2023.09.25.05.25.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 05:25:14 -0700 (PDT)
Date:   Mon, 25 Sep 2023 08:25:13 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Domenico Cerasuolo <cerasuolodomenico@gmail.com>
Cc:     sjenning@redhat.com, ddstreet@ieee.org, vitaly.wool@konsulko.com,
        akpm@linux-foundation.org, nphamcs@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH] mm: zswap: fix potential memory corruption on duplicate
 store
Message-ID: <20230925122513.GA347250@cmpxchg.org>
References: <20230922172211.1704917-1-cerasuolodomenico@gmail.com>
 <20230922174225.GF124289@cmpxchg.org>
 <CA+CLi1hT30jtGGVwWh8LBoLq3ijRoYdxiMB301Jc97Z9=JLHGA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+CLi1hT30jtGGVwWh8LBoLq3ijRoYdxiMB301Jc97Z9=JLHGA@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 25, 2023 at 10:36:06AM +0200, Domenico Cerasuolo wrote:
> On Fri, Sep 22, 2023 at 7:42 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
> >
> > On Fri, Sep 22, 2023 at 07:22:11PM +0200, Domenico Cerasuolo wrote:
> > > While stress-testing zswap a memory corruption was happening when writing
> > > back pages. __frontswap_store used to check for duplicate entries before
> > > attempting to store a page in zswap, this was because if the store fails
> > > the old entry isn't removed from the tree. This change removes duplicate
> > > entries in zswap_store before the actual attempt.
> > >
> > > Based on commit ce9ecca0238b ("Linux 6.6-rc2")
> > >
> > > Fixes: 42c06a0e8ebe ("mm: kill frontswap")
> > > Signed-off-by: Domenico Cerasuolo <cerasuolodomenico@gmail.com>
> >
> > Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> >
> > > @@ -1218,6 +1218,19 @@ bool zswap_store(struct folio *folio)
> > >       if (!zswap_enabled || !tree)
> > >               return false;
> > >
> > > +     /*
> > > +      * If this is a duplicate, it must be removed before attempting to store
> > > +      * it, otherwise, if the store fails the old page won't be removed from
> > > +      * the tree, and it might be written back overriding the new data.
> > > +      */
> > > +     spin_lock(&tree->lock);
> > > +     dupentry = zswap_rb_search(&tree->rbroot, offset);
> > > +     if (dupentry) {
> > > +             zswap_duplicate_entry++;
> > > +             zswap_invalidate_entry(tree, dupentry);
> > > +     }
> > > +     spin_unlock(&tree->lock);
> >
> > Do we still need the dupe handling at the end of the function then?
> >
> > The dupe store happens because a page that's already in swapcache has
> > changed and we're trying to swap_writepage() it again with new data.
> >
> > But the page is locked at this point, pinning the swap entry. So even
> > after the tree lock is dropped I don't see how *another* store to the
> > tree at this offset could occur while we're compressing.
> 
> My reasoning here was that frontswap used to invalidate a dupe right before
> calling store(), so I thought that the check at the end of zswap_store() was
> actually needed.

Ok the git history is actually really enlightening of how this came to
be. Initially, frontswap didn't invalidate. Only zswap did. Then
someone ran into exactly the scenario that you encountered:

commit fb993fa1a2f669215fa03a09eed7848f2663e336
Author: Weijie Yang <weijie.yang@samsung.com>
Date:   Tue Dec 2 15:59:25 2014 -0800

    mm: frontswap: invalidate expired data on a dup-store failure
    
    If a frontswap dup-store failed, it should invalidate the expired page
    in the backend, or it could trigger some data corruption issue.
    Such as:
     1. use zswap as the frontswap backend with writeback feature
     2. store a swap page(version_1) to entry A, success
     3. dup-store a newer page(version_2) to the same entry A, fail
     4. use __swap_writepage() write version_2 page to swapfile, success
     5. zswap do shrink, writeback version_1 page to swapfile
     6. version_2 page is overwrited by version_1, data corrupt.
    
    This patch fixes this issue by invalidating expired data immediately
    when meet a dup-store failure.

This split the invalidation duty: On store success, zswap would
invalidate. On store failure, frontswap would.

Then this patch moved the invalidate in frontswap to before the store:

commit d1dc6f1bcf1e998e7ce65fc120da371ab047a999
Author: Dan Streetman <ddstreet@ieee.org>
Date:   Wed Jun 24 16:58:18 2015 -0700

    frontswap: allow multiple backends

at which point the after-store invalidate in zswap became unnecessary.

> Since we acquire the tree lock anyway to add the new entry to the LRU, wouldn't
> checking the result of zswap_rb_insert be a very cheap sanity check? We could
> treat it as an error and fail the store(), or just add a warning and still
> invalidate the dupe?

Yeah, it's less about performance and more about code clarity.

A warning probably makes the most sense. It gives us the sanity check
and an opportunity to document expectations wrt the swapcache, while
keeping the code resilient against data corruption.
