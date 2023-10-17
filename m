Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9022E7CB7B3
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 02:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233859AbjJQA6N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 20:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233956AbjJQA6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 20:58:11 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC119D9
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 17:58:09 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-9ae2cc4d17eso833939566b.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 17:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697504288; x=1698109088; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XopfoIaD0vICDU6P6tysbL85r4xFf9d1dB0gt4rGljE=;
        b=4yVR4vj4EMDAwF8jWD9VkEwe+OMXu08ZpVceSTlNMPvJT2y0hwlJ6MkQdWiMyJe3ak
         W7xiV2s8OjgqCdVwA0muL1FFSAr1ZcS+a2IN/btLdehr2tOAZCJmj8c9XQL3TjA/3b4f
         rYkLXA7wX5CqH4l2enYfhwn1WwCteUU0MD/E8PV2RrHiKgHeKauBittGltJ8TwNTOSQw
         BkWJJvycZLImEDgXNJcGzH6bHGzGRIS1LkLluh33fRclU7yAla+2EbNE61dherrkwBtz
         L6DtaI+DBZaIm3P7dmZ7u5Fo3BIruxBclXc45wtkGp215O/xsImx9tDMm4tH5eKS3V5F
         Q1FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697504288; x=1698109088;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XopfoIaD0vICDU6P6tysbL85r4xFf9d1dB0gt4rGljE=;
        b=AlMbHE10hodTmvGRctRUCh6Htd2H4w3WWkyDJKkXHDn2sygK1pLzlAZgFPO5XZlAsn
         nYvnjliaxWFrRhJ6Yhw+/VyWudS1X8tTK+vVO+69jA11n9tIWwx2HI1BURdMKsqPn+bh
         5UQRNdJOLsFuWtzzaq8wvqoGVkF9/venZY8+HrVyJ06I5BoueJ5paLik1oDY2NctDe1y
         iEu7Tk5DfjWtsYWeBwPq9lw6/vjSKDhOalGFUeYI8MqvPAjfxaB4aoMx23zkRiYMUjAv
         8K2irozlWH76To9ng2XLUH5cQ8he5I3ykvfDnTMwpBMmDoY+AcV3WZNQh2vyJIVVaDHj
         x8SQ==
X-Gm-Message-State: AOJu0YwXG+48QDbUG1skcy7D559P49btFPNlFIh+wmKbBO/SGwEbn3Gl
        QbtltnTsfCc6zaqJf70c6quyj7ZDEqI5qic/xpqz/w==
X-Google-Smtp-Source: AGHT+IFK1M6KpqfG7RQqhCU3ImlGX/ViDMUnVCHADn/RkIcTD7fh3M3Q+wiR9AVlEOf9vxfvlyzeJkQ4Rt7sWmp6n2E=
X-Received: by 2002:a17:907:2cc4:b0:9bd:cd8b:6253 with SMTP id
 hg4-20020a1709072cc400b009bdcd8b6253mr437887ejc.33.1697504288035; Mon, 16 Oct
 2023 17:58:08 -0700 (PDT)
MIME-Version: 1.0
References: <20231017003519.1426574-1-nphamcs@gmail.com>
In-Reply-To: <20231017003519.1426574-1-nphamcs@gmail.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Mon, 16 Oct 2023 17:57:31 -0700
Message-ID: <CAJD7tka6XRyzYndRNEFZmi0Zj4DD2KnVzt=vMGhfF4iN2B4VKw@mail.gmail.com>
Subject: Re: [PATCH 0/2] minimize swapping on zswap store failure
To:     Nhat Pham <nphamcs@gmail.com>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org,
        cerasuolodomenico@gmail.com, sjenning@redhat.com,
        ddstreet@ieee.org, vitaly.wool@konsulko.com, hughd@google.com,
        corbet@lwn.net, konrad.wilk@oracle.com, senozhatsky@chromium.org,
        rppt@kernel.org, linux-mm@kvack.org, kernel-team@meta.com,
        linux-kernel@vger.kernel.org, david@ixit.cz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2023 at 5:35=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> wrote=
:
>
> Currently, when a zswap store attempt fails, the page is immediately
> swapped out. This could happen for a variety of reasons. For instance,
> the compression algorithm could fail (such as when the data is not
> compressible), or the backend allocator might not be able to find a
> suitable slot for the compressed page. If these pages are needed
> later on, users will incur IOs from swapins.
>
> This issue prevents the adoption of zswap for potential users who
> cannot tolerate the latency associated with swapping. In many cases,
> these IOs are avoidable if we just keep in memory the pages that zswap
> fail to store.
>
> This patch series add two new features for zswap that will alleviate
> the risk of swapping:
>
> a) When a store attempt fail, keep the page untouched in memory
> instead of swapping it out.

What about writeback when the zswap limit is hit? I understand the
problem, but I am wondering if this is the correct way of fixing it.
We really need to make zswap work without a backing swapfile, which I
think is the correct way to fix all these problems. I was working on
that, but unfortunately I had to pivot to something else before I had
something that was working.

At Google, we have "ghost" swapfiles that we use just to use zswap
without a swapfile. They are sparse files, and we have internal kernel
patches to flag them and never try to actually write to them.

I am not sure how many bandaids we can afford before doing the right
thing. I understand it's a much larger surgery, perhaps there is a way
to get a short-term fix that is also a step towards the final state we
want to reach instead?

>
> b) If the store attempt fails at the compression step, allow the page
> to be stored in its uncompressed form in the zswap pool. This maintains
> the LRU ordering of pages, which will be helpful for accurate
> memory reclaim (zswap writeback in particular).

This is dangerous. Johannes and I discussed this before. This means
that reclaim can end up allocating more memory instead of freeing.
Allocations made in the reclaim path are made under the assumption
that we will eventually free memory. In this case, we won't. In the
worst case scenario, reclaim can leave the system/memcg in a worse
state than before it started.

Perhaps there is a way we can do this without allocating a zswap entry?

I thought before about having a special list_head that allows us to
use the lower bits of the pointers as markers, similar to the xarray.
The markers can be used to place different objects on the same list.
We can have a list that is a mixture of struct page and struct
zswap_entry. I never pursued this idea, and I am sure someone will
scream at me for suggesting it. Maybe there is a less convoluted way
to keep the LRU ordering intact without allocating memory on the
reclaim path.

>
> These features could be enabled independently via two new zswap module
> parameters.
>
> Nhat Pham (2):
>   swap: allows swap bypassing on zswap store failure
>   zswap: store uncompressed pages when compression algorithm fails
>
>  Documentation/admin-guide/mm/zswap.rst | 16 +++++++
>  include/linux/zswap.h                  |  9 ++++
>  mm/page_io.c                           |  6 +++
>  mm/shmem.c                             |  8 +++-
>  mm/zswap.c                             | 64 +++++++++++++++++++++++---
>  5 files changed, 95 insertions(+), 8 deletions(-)
>
> --
> 2.34.1
