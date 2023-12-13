Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9C2781082F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 03:23:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378304AbjLMCXB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 21:23:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378400AbjLMCWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 21:22:44 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF841BC
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 18:22:21 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B8C4C43391
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 02:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702434141;
        bh=wwCgm+IFjqFyxUBy11fFZfn6oiOr0/BXrjgrdZ1mWyg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=MRtu+hmU4CkJurSA+0yTo4zFOwkQjx6jo6GwjN2I4q4AIdx+cHWzDP+9TtJ3+WFoM
         aQ40bxwPHQ0BRMj4QezD4VfPgxfi+8H0CeKYrifSS2lVBsZ/0XWF7YRN3T8zWfgFPA
         uumVIUe7gCjYhfd2aL6IXbUEGs+5rVVnA/kXXYST58i3KT4xkamiN54BLkxfKDP5po
         lElzd9bUkVPeNhe7kM1bC5lLzBCHjEpHftGfMsHPFHzLHVaSdjrbhNGk9QNXfAD1YE
         HLvMe/vrEwaVj6K1c8m537yho50ezftINb2ief0tlMNuxFmnIItHdplkk0OzWI/kMF
         AVcgwvc761ULA==
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-58d08497aa1so4065528eaf.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 18:22:21 -0800 (PST)
X-Gm-Message-State: AOJu0YzA7Mdr1+oT1DrgShMK3HLRzO2NUy1ZG1W9tUfes+Y+4NbG1FXf
        HyOIeGvMiLou87831zPQZpAuZGGKEDttGImHtyRNQg==
X-Google-Smtp-Source: AGHT+IHdIzK2hZu/4raabTovfoFExqE0zHuUM405JETYLRfcMLTywTWtMmLl1Nu1fFOkxwfh2F92Yinr1bo9lZPjNMk=
X-Received: by 2002:a05:6358:9889:b0:16d:e1d8:22c7 with SMTP id
 q9-20020a056358988900b0016de1d822c7mr7530145rwa.29.1702434140415; Tue, 12 Dec
 2023 18:22:20 -0800 (PST)
MIME-Version: 1.0
References: <20231119194740.94101-1-ryncsn@gmail.com> <20231119194740.94101-19-ryncsn@gmail.com>
 <CAF8kJuNmzGSCE_VhXboXF4tGbLvJXxXYM6j-vkF4d1CkRB-z5A@mail.gmail.com> <CAMgjq7AwFiDb7cAMkWMWb3vkccie1-tocmZfT7m4WRb_UKPghg@mail.gmail.com>
In-Reply-To: <CAMgjq7AwFiDb7cAMkWMWb3vkccie1-tocmZfT7m4WRb_UKPghg@mail.gmail.com>
From:   Chris Li <chrisl@kernel.org>
Date:   Tue, 12 Dec 2023 18:22:07 -0800
X-Gmail-Original-Message-ID: <CAF8kJuOsMLb_5D0vVDFm2kVstJHzkOQK_Xp2g_fQL9hAMQuoHw@mail.gmail.com>
Message-ID: <CAF8kJuOsMLb_5D0vVDFm2kVstJHzkOQK_Xp2g_fQL9hAMQuoHw@mail.gmail.com>
Subject: Re: [PATCH 18/24] mm/swap: introduce a helper non fault swapin
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

On Tue, Nov 28, 2023 at 3:22=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wrot=
e:
>
> > >  /*
> > >   * Make sure huge_gfp is always more limited than limit_gfp.
> > >   * Some of the flags set permissions, while others set limitations.
> > > @@ -1854,9 +1838,12 @@ static int shmem_swapin_folio(struct inode *in=
ode, pgoff_t index,
> > >  {
> > >         struct address_space *mapping =3D inode->i_mapping;
> > >         struct shmem_inode_info *info =3D SHMEM_I(inode);
> > > -       struct swap_info_struct *si;
> > > +       enum swap_cache_result result;
> > >         struct folio *folio =3D NULL;
> > > +       struct mempolicy *mpol;
> > > +       struct page *page;
> > >         swp_entry_t swap;
> > > +       pgoff_t ilx;
> > >         int error;
> > >
> > >         VM_BUG_ON(!*foliop || !xa_is_value(*foliop));
> > > @@ -1866,34 +1853,30 @@ static int shmem_swapin_folio(struct inode *i=
node, pgoff_t index,
> > >         if (is_poisoned_swp_entry(swap))
> > >                 return -EIO;
> > >
> > > -       si =3D get_swap_device(swap);
> > > -       if (!si) {
> > > +       mpol =3D shmem_get_pgoff_policy(info, index, 0, &ilx);
> > > +       page =3D swapin_page_non_fault(swap, gfp, mpol, ilx, fault_mm=
, &result);
>
> Hi Chris,
>
> I've been trying to address these issues in V2, most issue in other
> patches have a straight solution, some could be discuss in seperate
> series, but I come up with some thoughts here:
>
> >
> > Notice this "result" CAN be outdated. e.g. after this call, the swap
> > cache can be changed by another thread generating the swap page fault
> > and installing the folio into the swap cache or removing it.
>
> This is true, and it seems a potential race also exist before this
> series for direct (no swapcache) swapin path (do_swap_page) if I
> understand it correctly:

I just noticed I missed this email while I was cleaning up my email
archive. Sorry for the late reply. Traveling does not help either.

I am not aware of swap in racing bugs in the existing code. Racing,
yes. If you discover a code path for racing causing bug, please report
it.
>
> In do_swap_page path, multiple process could swapin the page at the
> same time (a mapped once page can still be shared by sub threads),
> they could get different folios. The later pte lock and pte_same check
> is not enough, because while one process is not holding the pte lock,
> another process could read-in, swap_free the entry, then swap-out the
> page again, using same entry, an ABA problem. The race is not likely
> to happen in reality but in theory possible.

Have you taken into account that if the page was locked, then it
wasn't able to change from the swapcache? I think the swap cache find
and get function will return the page locked. Then swapcache will not
be able to change the mapping as long as the page is still locked.

>
> Same issue for shmem here, there are
> shmem_confirm_swap/shmem_add_to_page_cache check later to prevent
> re-installing into shmem mapping for direct swap in, but also not
> enough. Other process could read-in and re-swapout using same entry so
> the mapping entry seems unchanged during the time window. Still very
> unlikely to happen in reality, but not impossible.

Please take a look again with the page lock information. Report back
if you still think there is a racing bug in the existing code. We can
take a closer look at the concurrent call stack to trigger the bug.

Chris

>
> When swapcache is used there is no such issue, since swap lock and
> swap_map are used to sync all readers, and while one reader is still
> holding the folio, the entry is locked through swapcache, or if a
> folio is removed from swapcache, folio_test_swapcache will fail, and
> the reader could retry.
>
> I'm trying to come up with a better locking for direct swap in, am I
> missing anything here? Correct me if I get it wrong...
>
