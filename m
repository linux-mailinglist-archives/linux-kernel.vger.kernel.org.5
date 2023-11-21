Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 361CD7F34EA
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 18:25:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234176AbjKURZi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 12:25:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234036AbjKURZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 12:25:36 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 374CE9E
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 09:25:32 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCF39C433CC
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 17:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700587531;
        bh=qt6Wz1wjQVS9tVKoXRbtoCApE+YOUmxZa+rP2nFghP8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=d2sJTgAJM3C2pe6wm6FgWEP3Mp32DhS77vJvJbwKIdkQnQVF8WvAZpYqqJkIWc2Y9
         t3/BldE9o5BlD94jCDrDS0ghnjSZFF/vbrgWzWoZTFvKW4ihNkMUNKaoOMjGHsMFRG
         ukpnSeukYqQ5Gb9vf6WjMOzzjVnv649z4vAOrQ81jBByJQV0miYqoPwsj9apVnpRQ5
         kIWgN1bXN9Pc+N9HDPu1R+BbhUhgGseLaPHg7u1qhpZQ8iLHcdGph011VO8t48bdip
         Wg1LutdYKet/VOA1YBxVI26liHK29nk/fnNeocz3eV5kl1JbYPWOlJPR3qoW+YLSGM
         x+dgnB7unhCAg==
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5aa481d53e5so3906122a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 09:25:31 -0800 (PST)
X-Gm-Message-State: AOJu0YzPWC671Lx47XP8u3dQ+RbqbsO3GCzUNYdWBczcRbyOPfcR31q5
        ldfM8Gj+pEbL/NqGiYuvzfDTdIVFecKydPeZUXGXwg==
X-Google-Smtp-Source: AGHT+IGGVfRpUhMS2OniXh63UwnOagMginQmE+GvDZVCOiVoIC5mvb8KoxnZDqOxlTD9o8WLBm+c/w2aCzQhdwG3k18=
X-Received: by 2002:a17:90b:4aca:b0:27d:b9d:bd6f with SMTP id
 mh10-20020a17090b4aca00b0027d0b9dbd6fmr10246427pjb.45.1700587531325; Tue, 21
 Nov 2023 09:25:31 -0800 (PST)
MIME-Version: 1.0
References: <20231119194740.94101-1-ryncsn@gmail.com> <20231119194740.94101-17-ryncsn@gmail.com>
In-Reply-To: <20231119194740.94101-17-ryncsn@gmail.com>
From:   Chris Li <chrisl@kernel.org>
Date:   Tue, 21 Nov 2023 09:25:20 -0800
X-Gmail-Original-Message-ID: <CAF8kJuPs-pqu=SpnP+oWfSimGNUyS4sOVW8px31Jo+cHn23K8w@mail.gmail.com>
Message-ID: <CAF8kJuPs-pqu=SpnP+oWfSimGNUyS4sOVW8px31Jo+cHn23K8w@mail.gmail.com>
Subject: Re: [PATCH 16/24] mm/swap: reduce scope of get_swap_device in swapin path
To:     Kairui Song <kasong@tencent.com>
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

On Sun, Nov 19, 2023 at 11:48=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wro=
te:
>
> From: Kairui Song <kasong@tencent.com>
>
> Move get_swap_device into swapin_readahead, simplify the code
> and prepare for follow up commits.
>
> For the later part in do_swap_page, using swp_swap_info directly is fine
> since in that context, the swap device is pinned by swapcache reference.
>
> Signed-off-by: Kairui Song <kasong@tencent.com>
> ---
>  mm/memory.c     | 16 ++++------------
>  mm/swap_state.c |  8 ++++++--
>  mm/swapfile.c   |  4 +++-
>  3 files changed, 13 insertions(+), 15 deletions(-)
>
> diff --git a/mm/memory.c b/mm/memory.c
> index 22af9f3e8c75..e399b37ef395 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -3789,7 +3789,6 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>         struct folio *swapcache =3D NULL, *folio =3D NULL;
>         enum swap_cache_result cache_result;
>         struct page *page;
> -       struct swap_info_struct *si =3D NULL;
>         rmap_t rmap_flags =3D RMAP_NONE;
>         bool exclusive =3D false;
>         swp_entry_t entry;
> @@ -3845,14 +3844,11 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>                 goto out;
>         }
>
> -       /* Prevent swapoff from happening to us. */
> -       si =3D get_swap_device(entry);
> -       if (unlikely(!si))
> -               goto out;
> -
>         page =3D swapin_readahead(entry, GFP_HIGHUSER_MOVABLE,
>                                 vmf, &cache_result);
> -       if (page) {
> +       if (PTR_ERR(page) =3D=3D -EBUSY) {
> +               goto out;
> +       } else if (page) {

As Matthew suggested, using ERR_PTR(-EBUSY).
you also don't need the else here. The goto already terminates the flow.

if (page =3D=3D ERR_PTR(-EBUSY))
   goto out;

if (page) {

Chris
