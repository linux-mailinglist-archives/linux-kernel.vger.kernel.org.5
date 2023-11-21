Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5973A7F26BC
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 08:54:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbjKUHyo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 02:54:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjKUHyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 02:54:41 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4102AF5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 23:54:38 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6AF3C43391
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 07:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700553277;
        bh=0qqhbNpCfWQutTSkCiqeCJlRWmkVKXLvp8F0pOXn88U=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=elK63l9dFeOiW9NTleQIkzMSdLLpZXQhLUWaLipboebrlxya0h1PGeh363ua+QfNe
         1h8SGgcQdV9CBXwHRnOFlw78vZN3Rpgeqh6FDtJ3+N7l/K81Qvn0FrblLIE1KEBtsx
         L05uAB6xWmaz9zGptoPTZjnbi5v8aYQAxsv6xvwP3Jr3t62OvLU30Mi8AAZ1ZBnm9F
         JNt+O2m/2Rt360Gwcty718OvyEVoLE/EORW9/yLOdFFwGBLQO6WxGYskMfxJVQ7fL0
         JF8aZFw9qnyn9H+aU5kcJDAgfqRGhpU9SDFGivYOyC8x2Ma3Dr0KPjgactpoZw7pyw
         g3jZTFAZN4lfQ==
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2851967b945so1588918a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 23:54:37 -0800 (PST)
X-Gm-Message-State: AOJu0YyDnu+KvjIPSlq++dTuk9X3n99bbpF/pIrVC3FrRzOxHk28Fm3s
        pwLiiicfPLRzdK+kiKDWovx7qTDpggZhRrabOO06QA==
X-Google-Smtp-Source: AGHT+IFYgNGkJN5vokPp4S7MS8v23ejrWQWNZ5LUqpxpit1xZPham34sBYqktuXqMQO0tLW7kPLMGQalpivWLxqUMB0=
X-Received: by 2002:a17:90b:3eca:b0:283:2805:7c7f with SMTP id
 rm10-20020a17090b3eca00b0028328057c7fmr2980093pjb.0.1700553277274; Mon, 20
 Nov 2023 23:54:37 -0800 (PST)
MIME-Version: 1.0
References: <20231119194740.94101-1-ryncsn@gmail.com> <20231119194740.94101-9-ryncsn@gmail.com>
In-Reply-To: <20231119194740.94101-9-ryncsn@gmail.com>
From:   Chris Li <chrisl@kernel.org>
Date:   Mon, 20 Nov 2023 23:54:26 -0800
X-Gmail-Original-Message-ID: <CAF8kJuPTp5AJPStY0U-Q+t7HhoZB2B9cSQJONJv+xvR3qhxd1g@mail.gmail.com>
Message-ID: <CAF8kJuPTp5AJPStY0U-Q+t7HhoZB2B9cSQJONJv+xvR3qhxd1g@mail.gmail.com>
Subject: Re: [PATCH 08/24] mm/swap: check readahead policy per entry
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

On Sun, Nov 19, 2023 at 11:48=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wro=
te:
>
> From: Kairui Song <kasong@tencent.com>
>
> Currently VMA readahead is globally disabled when any rotate disk is
> used as swap backend. So multiple swap devices are enabled, if a slower
> hard disk is set as a low priority fallback, and a high performance SSD
> is used and high priority swap device, vma readahead is disabled globally=
.
> The SSD swap device performance will drop by a lot.
>
> Check readahead policy per entry to avoid such problem.
>
> Signed-off-by: Kairui Song <kasong@tencent.com>
> ---
>  mm/swap_state.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/mm/swap_state.c b/mm/swap_state.c
> index ff6756f2e8e4..fb78f7f18ed7 100644
> --- a/mm/swap_state.c
> +++ b/mm/swap_state.c
> @@ -321,9 +321,9 @@ static inline bool swap_use_no_readahead(struct swap_=
info_struct *si, swp_entry_
>         return data_race(si->flags & SWP_SYNCHRONOUS_IO) && __swap_count(=
entry) =3D=3D 1;
>  }
>
> -static inline bool swap_use_vma_readahead(void)
> +static inline bool swap_use_vma_readahead(struct swap_info_struct *si)
>  {
> -       return READ_ONCE(enable_vma_readahead) && !atomic_read(&nr_rotate=
_swap);
> +       return data_race(si->flags & SWP_SOLIDSTATE) && READ_ONCE(enable_=
vma_readahead);

A very minor point:
I notice you change the order enable_vma_readahead to the last.
Normally if enable_vma_reachahead =3D=3D 0, there is no need to check the s=
i->flags.
The si->flags check is more expensive than simple memory load.
You might want to check enable_vma_readahead first then you can short
cut the more expensive part.

Chris
