Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D3777F0C6A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 08:04:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbjKTHE3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 02:04:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231948AbjKTHET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 02:04:19 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8D7B90
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 23:04:14 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73AEFC433CC
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 07:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700463854;
        bh=qiloXOTVSC5/MXUHvVybdWbggFP8b1JfMoFufd+ahfo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=l8aUn1Cy0AIbLReZUlsmgeys4vb1gi+fl81kQ46N0jr4xZFuwI2Zcr5dVdgQoho8U
         BEJZCmAVMYkiV7PBp2M5Sgk5UZz4/XCDpRPZUl8KeodiydyD2HiAY7HzDVJnUldVQG
         qCOBEw5LUBjgh3mbChX+IByKygyx4iqTnQpXYxVQtlkZpnossgA+CyHRdYtmAA5Ght
         iWhoWD+7nV+xW2rKS9LGfliOB1BhrHWhhKJ2vO5trJr+s87nm/Hv0i+SgHKlCAVR0d
         OY6JqmGHElWrkljh9mdSk09ARNFp5n12UxPiG323WwutXQ+eaYaWYyHbpG1n3UG6gL
         xEv9UhjdnwSqw==
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-28041176e77so2690949a91.0
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 23:04:14 -0800 (PST)
X-Gm-Message-State: AOJu0YxpzaGecmjuLpM1MpGiqH98rGFkEWjjjoQqiYaXvC49oTgFEez7
        KQkftslXR/+rmxw/y8et26FH2lV+1dqyVRd3tV5MkQ==
X-Google-Smtp-Source: AGHT+IFUvHWev1HZRq7Nds7EmaBQD72V9+Bxuj94dFczycxOV4JtYnoayvNTdkt+JgSi/FxtPL1EuiimMj6iobctFjM=
X-Received: by 2002:a17:90b:4d09:b0:280:a68d:7a35 with SMTP id
 mw9-20020a17090b4d0900b00280a68d7a35mr4652404pjb.22.1700463853818; Sun, 19
 Nov 2023 23:04:13 -0800 (PST)
MIME-Version: 1.0
References: <20231119194740.94101-1-ryncsn@gmail.com> <20231119194740.94101-20-ryncsn@gmail.com>
In-Reply-To: <20231119194740.94101-20-ryncsn@gmail.com>
From:   Chris Li <chrisl@kernel.org>
Date:   Sun, 19 Nov 2023 23:04:02 -0800
X-Gmail-Original-Message-ID: <CAF8kJuMJMBjn2VGq8aUzv_t4+k0zPW8WvJaraYe-8GRbX0q1fg@mail.gmail.com>
Message-ID: <CAF8kJuMJMBjn2VGq8aUzv_t4+k0zPW8WvJaraYe-8GRbX0q1fg@mail.gmail.com>
Subject: Re: [PATCH 19/24] shmem, swap: refactor error check on OOM or race
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

Hi Kairui,

On Sun, Nov 19, 2023 at 11:49=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wro=
te:
>
> From: Kairui Song <kasong@tencent.com>
>
> It should always check if a swap entry is already swaped in on error,
> fix potential false error issue.
>
> Signed-off-by: Kairui Song <kasong@tencent.com>
> ---
>  mm/shmem.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 81d129aa66d1..6154b5b68b8f 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -1857,13 +1857,11 @@ static int shmem_swapin_folio(struct inode *inode=
, pgoff_t index,
>         page =3D swapin_page_non_fault(swap, gfp, mpol, ilx, fault_mm, &r=
esult);
>         mpol_cond_put(mpol);
>
> -       if (PTR_ERR(page) =3D=3D -EBUSY) {
> -               if (!shmem_confirm_swap(mapping, index, swap))
> -                       return -EEXIST;

Do you intentionally remove checking shmem_confirm_swap()?
I am not sure I am following.

> +       if (IS_ERR_OR_NULL(page)) {
> +               if (!page)
> +                       error =3D -ENOMEM;
>                 else
> -                       return -EINVAL;
> -       } else if (!page) {
> -               error =3D -ENOMEM;
> +                       error =3D -EINVAL;

The resulting code is a bit hard to read in diff. In plan source it is like=
:

        if (IS_ERR_OR_NULL(page)) {
                if (!page)
                        error =3D -ENOMEM;
                else
                        error =3D -EINVAL;
                goto failed;
        } else {
                folio =3D page_folio(page);
                if (fault_type && result !=3D SWAP_CACHE_HIT) {
                        *fault_type |=3D VM_FAULT_MAJOR;
                        count_vm_event(PGMAJFAULT);
                        count_memcg_event_mm(fault_mm, PGMAJFAULT);
                }
        }

First of all, if the first always "goto failed", the second else is not nee=
ded.
The whole else block can be flatten one indentation.

 if (IS_ERR_OR_NULL(page)) {
                if (!page)
                        error =3D -ENOMEM;
                else
                        error =3D -EINVAL;
                goto failed;
  } else {

Can be rewrite as following with less indentation:

if (!page) {
     error =3D -ENOMEM;
     goto failed;
}
if (IS_ERR(page)) {
     error =3D -EINVAL;
     goto failed;
}
/* else block */

Am I missing something and misreading your code?

Chris
