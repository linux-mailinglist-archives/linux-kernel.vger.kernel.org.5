Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12FBE7AD37A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 10:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232714AbjIYIg2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 04:36:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230435AbjIYIg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 04:36:27 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7ABA9D
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 01:36:20 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-3231df68584so2080225f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 01:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695630979; x=1696235779; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aeqAQlatwdDujYhPSrHB+qQb56NZMAb9DgwinqxqIEs=;
        b=GFwn8pRVFsPh+IbPHLfU7XmGbRI99PNir3GN+Skt0h/Lg10It2R3c4BjP/WIZAacYS
         3BvQK1Hc2Uz8y2EhPtUCu/rwSPgovvh3pqEHb6nUXNkmwWQkzrQd4YaVIiwSEU07IY/G
         rny8eg2gRe5Aot0S5rFC/JDz9cR3B6HP27x4ESbnBlnkrKX7vrknMeBWRhHnZeLl/uCV
         EUxwefNAhKFrSOG83cxUkRfLRtvdhQuChtKRbj1/20q4mzQrcdZw6YOsTGC/+g5mEmQ3
         c24bRKZnl9GNzkHA+DD9S+/hWI1AT7jE/klxZ1fOSK2sD6Pi3Lg2cxCbR4+JqGJpMkaz
         URrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695630979; x=1696235779;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aeqAQlatwdDujYhPSrHB+qQb56NZMAb9DgwinqxqIEs=;
        b=uQkefk7vBpLzrl7uTOCWQezmK9WSs5W3D7i7j1lK+UO15sqQ+h4eScD5t8kPQjJtP4
         psl6zctH3LCKSQ9sERgUkcfQ0IjdyIUJXhbYQVoqMoBA3vPvfy115D9MEf4eT52PqeKW
         VsozoZssuncw+cMUA/viHrEUGQqWNFPJ3piBvWQdcJUFBZwOl0sKhdt8raULgFBGkA1/
         H/dHz1YYYpmA//rtlGTJ7TbkriC65/H5FCICoDaX4r0HgPz+yRN+DH3azbKNDqwn2ECV
         RvaUHDriN+m1AvmsHo21P7UfnYe2KrytmPk2UH4fJk9O+sNrnO12YbgRPrpF96QtUWeD
         KKDw==
X-Gm-Message-State: AOJu0YyPeeebliM1lFRGPzwHYG5Aj/ZWNR6+OMYnHH/kD/8g5Y5aUVHA
        5u5lkQ8bWj0FVp4mud/WYST1L9P8uUWvyytS+lc=
X-Google-Smtp-Source: AGHT+IGPt5Irg12cqRt6/lQ24N6F1G7U2LNqzKgwK5lhjGj0AbzqmGGQUuBEcXRDN6KwCV91ET3d6rijl2xGviDexbw=
X-Received: by 2002:a5d:6682:0:b0:31f:9838:dfc4 with SMTP id
 l2-20020a5d6682000000b0031f9838dfc4mr5220361wru.33.1695630978949; Mon, 25 Sep
 2023 01:36:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230922172211.1704917-1-cerasuolodomenico@gmail.com> <20230922174225.GF124289@cmpxchg.org>
In-Reply-To: <20230922174225.GF124289@cmpxchg.org>
From:   Domenico Cerasuolo <cerasuolodomenico@gmail.com>
Date:   Mon, 25 Sep 2023 10:36:06 +0200
Message-ID: <CA+CLi1hT30jtGGVwWh8LBoLq3ijRoYdxiMB301Jc97Z9=JLHGA@mail.gmail.com>
Subject: Re: [PATCH] mm: zswap: fix potential memory corruption on duplicate store
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     sjenning@redhat.com, ddstreet@ieee.org, vitaly.wool@konsulko.com,
        akpm@linux-foundation.org, nphamcs@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 22, 2023 at 7:42=E2=80=AFPM Johannes Weiner <hannes@cmpxchg.org=
> wrote:
>
> On Fri, Sep 22, 2023 at 07:22:11PM +0200, Domenico Cerasuolo wrote:
> > While stress-testing zswap a memory corruption was happening when writi=
ng
> > back pages. __frontswap_store used to check for duplicate entries befor=
e
> > attempting to store a page in zswap, this was because if the store fail=
s
> > the old entry isn't removed from the tree. This change removes duplicat=
e
> > entries in zswap_store before the actual attempt.
> >
> > Based on commit ce9ecca0238b ("Linux 6.6-rc2")
> >
> > Fixes: 42c06a0e8ebe ("mm: kill frontswap")
> > Signed-off-by: Domenico Cerasuolo <cerasuolodomenico@gmail.com>
>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
>
> > @@ -1218,6 +1218,19 @@ bool zswap_store(struct folio *folio)
> >       if (!zswap_enabled || !tree)
> >               return false;
> >
> > +     /*
> > +      * If this is a duplicate, it must be removed before attempting t=
o store
> > +      * it, otherwise, if the store fails the old page won't be remove=
d from
> > +      * the tree, and it might be written back overriding the new data=
.
> > +      */
> > +     spin_lock(&tree->lock);
> > +     dupentry =3D zswap_rb_search(&tree->rbroot, offset);
> > +     if (dupentry) {
> > +             zswap_duplicate_entry++;
> > +             zswap_invalidate_entry(tree, dupentry);
> > +     }
> > +     spin_unlock(&tree->lock);
>
> Do we still need the dupe handling at the end of the function then?
>
> The dupe store happens because a page that's already in swapcache has
> changed and we're trying to swap_writepage() it again with new data.
>
> But the page is locked at this point, pinning the swap entry. So even
> after the tree lock is dropped I don't see how *another* store to the
> tree at this offset could occur while we're compressing.

My reasoning here was that frontswap used to invalidate a dupe right before
calling store(), so I thought that the check at the end of zswap_store() wa=
s
actually needed.
Since we acquire the tree lock anyway to add the new entry to the LRU, woul=
dn't
checking the result of zswap_rb_insert be a very cheap sanity check? We cou=
ld
treat it as an error and fail the store(), or just add a warning and still
invalidate the dupe?
