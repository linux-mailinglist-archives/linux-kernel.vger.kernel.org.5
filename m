Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A36D97F25F9
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 07:51:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbjKUGvm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 01:51:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjKUGvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 01:51:41 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88872F4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 22:51:37 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22EFFC433CC
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 06:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700549497;
        bh=vcMj82j5UeYxk5/OU71PGwNMQQLupr6YDQ+K2CdWuTk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Kr/S+GB4e3na4m45XZknkUKpEmXhdtsl/hwxQraKXKJ1EkiFUoLjYsitKPSpoJtVm
         3DkJ4KsXFcwXDkN9R+YK/wqIKpVQrArNtltULfKSK/A2gbWZqWV4cyBy3r3+TGj7eq
         OdLqKXF5dV6NkJHj9tD30LKzCILXoESDubrSbKpW0UVw18N69nK19gw5ryYhyYtV6/
         HWrjCJrP2wOE9fSUz5Cncs81AW6rpAd8YyxzS0693fGXmx9R5sroJqRE5sv+gFsDXo
         Z4Pp29Xb3bSYZAffs0rvcjXUSJb5ems8icbSzrSQ6E8Q0t3gih8N+zbvK8ANacwqAC
         9FOQxFpiebsHg==
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-283a0b0bd42so2340445a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 22:51:37 -0800 (PST)
X-Gm-Message-State: AOJu0YyTtaT/zS3jYOOORpq9cXbo3SkqkqDGjPhzSRQh3suRHlZBPapo
        +VPD4KSR8xRlmZO0UnodL6btnTD9ACjcSAbEOfYCfQ==
X-Google-Smtp-Source: AGHT+IG95Iz4OSMxFcGhtEsGxJnWg/TdQGGbdNq59LFOgLURew3bL+FbZAwYhBWbgq3LJ0qvoaKk71Nu0oZr4Z5RqQE=
X-Received: by 2002:a17:90a:854c:b0:280:4af4:1a41 with SMTP id
 a12-20020a17090a854c00b002804af41a41mr2745780pjw.15.1700549496540; Mon, 20
 Nov 2023 22:51:36 -0800 (PST)
MIME-Version: 1.0
References: <20231119194740.94101-1-ryncsn@gmail.com> <20231119194740.94101-8-ryncsn@gmail.com>
In-Reply-To: <20231119194740.94101-8-ryncsn@gmail.com>
From:   Chris Li <chrisl@kernel.org>
Date:   Mon, 20 Nov 2023 22:51:25 -0800
X-Gmail-Original-Message-ID: <CAF8kJuMYHB_VWCompfGHQXuyk3MiDtka9dDfUDLxfGk40aN2Hw@mail.gmail.com>
Message-ID: <CAF8kJuMYHB_VWCompfGHQXuyk3MiDtka9dDfUDLxfGk40aN2Hw@mail.gmail.com>
Subject: Re: [PATCH 07/24] mm/swap: move swap_count to header to be shared
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kairui,

On Sun, Nov 19, 2023 at 11:48=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wro=
te:
>
> From: Kairui Song <kasong@tencent.com>
>
> No feature change, prepare for later commits.

Again, I don't see the value of having this as a stand alone patch.
If one of the later patches needs to use this function as external
rather than static, move it with the patch that uses it. From the
reviewing point of view, it is unnecessary overhead to cross reference
different patches in order to figure out why it is moved.

Chris

>
> Signed-off-by: Kairui Song <kasong@tencent.com>
> ---
>  mm/swap.h     | 5 +++++
>  mm/swapfile.c | 5 -----
>  2 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/mm/swap.h b/mm/swap.h
> index f82d43d7b52a..a9a654af791e 100644
> --- a/mm/swap.h
> +++ b/mm/swap.h
> @@ -61,6 +61,11 @@ static inline unsigned int folio_swap_flags(struct fol=
io *folio)
>  {
>         return page_swap_info(&folio->page)->flags;
>  }
> +
> +static inline unsigned char swap_count(unsigned char ent)
> +{
> +       return ent & ~SWAP_HAS_CACHE; /* may include COUNT_CONTINUED flag=
 */
> +}
>  #else /* CONFIG_SWAP */
>  struct swap_iocb;
>  static inline void swap_readpage(struct page *page, bool do_poll,
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 0142bfc71b81..a8ae472ed2b6 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -114,11 +114,6 @@ static struct swap_info_struct *swap_type_to_swap_in=
fo(int type)
>         return READ_ONCE(swap_info[type]); /* rcu_dereference() */
>  }
>
> -static inline unsigned char swap_count(unsigned char ent)
> -{
> -       return ent & ~SWAP_HAS_CACHE;   /* may include COUNT_CONTINUED fl=
ag */
> -}
> -
>  /* Reclaim the swap entry anyway if possible */
>  #define TTRS_ANYWAY            0x1
>  /*
> --
> 2.42.0
>
>
