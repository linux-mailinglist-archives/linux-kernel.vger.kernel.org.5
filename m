Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC307F1B47
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 18:45:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231680AbjKTRpD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 12:45:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbjKTRpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 12:45:01 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EB0C9E
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 09:44:58 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0636C43391
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 17:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700502298;
        bh=QdIwQbi78L4iTaYOXSKTeqxE+zsyBy4NQBji7YRcekk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tYPrWGsasDFSPcl3O8bKV1fTHxguNi4I5jhP8NhpHTqaz8jt3l4rDFIWY8KLK3sXN
         lM7BV3u7AjHXcjs+g2v6Jh0ne7RHiFszbywARTlT2hP1wFw8UmWuVCp4a5PwFHbFiU
         F9CLDpaD1PrmU3FbouaXIb3wUo0JsQNsPrOezqAJZhzIb/ffDDSZcHbET4reLzNJMS
         YJ1M8RDNryz8KCI4X4QJNNDvUFvSWldbVqX9tp+SVOhWLDJ5ihzob7vOxOlCfb2Ydg
         Mnn/hz9twBuX8V4hyGKO5d77C8927UOQj+vfZSH4spQ3Trp/qsHwQ6SouYbQdSNY8p
         4/MOaO90ignLw==
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-280200949c3so3122957a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 09:44:57 -0800 (PST)
X-Gm-Message-State: AOJu0YymUJOASgA/d+UNvewZZ1DsYO8kWGON0OipP0n0BXqFeG3xKVqE
        jNgZEQy4HplQH3zRio+KL7n+h0xm6VSm4XiWLZa2BQ==
X-Google-Smtp-Source: AGHT+IFI+CQqJyVWsvXC9ndBboiTV94uGDMRbrItRTKY1+Z0K9hsVFu9dAGsddeT5wb1+o5lmC6o89+AgC3mEm0M9ec=
X-Received: by 2002:a17:90b:3883:b0:27d:4f1f:47f6 with SMTP id
 mu3-20020a17090b388300b0027d4f1f47f6mr6589184pjb.32.1700502297360; Mon, 20
 Nov 2023 09:44:57 -0800 (PST)
MIME-Version: 1.0
References: <20231119194740.94101-1-ryncsn@gmail.com> <20231119194740.94101-5-ryncsn@gmail.com>
 <CAF8kJuNbcvwmojMB2Vp2LjTBxZtKFO_Zng4TODqADxmNPn2kCg@mail.gmail.com> <CAMgjq7D_OJiaNPWquFqxk5DKZXqoUMrD7Y_CRM7D0RnRnHmW7Q@mail.gmail.com>
In-Reply-To: <CAMgjq7D_OJiaNPWquFqxk5DKZXqoUMrD7Y_CRM7D0RnRnHmW7Q@mail.gmail.com>
From:   Chris Li <chrisl@kernel.org>
Date:   Mon, 20 Nov 2023 09:44:46 -0800
X-Gmail-Original-Message-ID: <CAF8kJuOzXAy8Er_knD0hi60Tb+XDMrijg-W83KD=Zdjqbu1Dmw@mail.gmail.com>
Message-ID: <CAF8kJuOzXAy8Er_knD0hi60Tb+XDMrijg-W83KD=Zdjqbu1Dmw@mail.gmail.com>
Subject: Re: [PATCH 04/24] mm/swap: avoid setting page lock bit and doing
 extra unlock check
To:     Kairui Song <ryncsn@gmail.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        "Huang, Ying" <ying.huang@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2023 at 3:15=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wrot=
e:
> > > diff --git a/mm/swap_state.c b/mm/swap_state.c
> > > index ac4fa404eaa7..45dd8b7c195d 100644
> > > --- a/mm/swap_state.c
> > > +++ b/mm/swap_state.c
> > > @@ -458,6 +458,8 @@ struct page *__read_swap_cache_async(swp_entry_t =
entry, gfp_t gfp_mask,
> >
> > You move the mem_cgroup_swapin_charge_folio() inside the for loop:
> >
> >
> >         for (;;) {
> >                 int err;
> >                 /*
> >                  * First check the swap cache.  Since this is normally
> >                  * called after swap_cache_get_folio() failed, re-calli=
ng
> >                  * that would confuse statistics.
> >                  */
> >                 folio =3D filemap_get_folio(swap_address_space(entry),
> >                                                 swp_offset(entry));
> >
> >
> > >                                                 mpol, ilx, numa_node_=
id());
> > >                 if (!folio)
> > >                          goto fail_put_swap;
> > > +               if (mem_cgroup_swapin_charge_folio(folio, NULL, gfp_m=
ask, entry))
> > > +                       goto fail_put_folio;
> >
> > Wouldn't it cause repeat charging of the folio when it is racing
> > against others in the for loop?
>
> The race loser will call folio_put and discharge it?

There are two different charges. Memcg charging and memcg swapin charging.
The folio_put will do the memcg discharge, the corresponding memcg
charge is in follio allocation.
Memcg swapin charge does things differently, it needs to modify the
swap relately accounting.
The memcg uncharge is not a pair for memcg swapin charge.

> > >                 /*
> > >                  * Swap entry may have been freed since our caller ob=
served it.
> > > @@ -483,13 +485,9 @@ struct page *__read_swap_cache_async(swp_entry_t=
 entry, gfp_t gfp_mask,
> > >         /*
> > >          * The swap entry is ours to swap in. Prepare the new page.
> > >          */
> > > -
> > >         __folio_set_locked(folio);
> > >         __folio_set_swapbacked(folio);
> > >
> > > -       if (mem_cgroup_swapin_charge_folio(folio, NULL, gfp_mask, ent=
ry))
> > > -               goto fail_unlock;
> > > -
> >
> > The original code makes the charge outside of the for loop. Only the
> > winner can charge once.
>
> Right, this patch may make the charge/dis-charge path more complex for
> race swapin, I'll re-check this part.

It is more than just complex, it seems to change the behavior of this code.

Chris
