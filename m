Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D83427FCAF5
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 00:45:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346642AbjK1XpS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 18:45:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjK1XpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 18:45:17 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE0341727
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 15:45:23 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A00EC433C8
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 23:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701215123;
        bh=c5hTYvlFDuS4/yvEogM5PHkabW5ZbLst+WDDOGe66dM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=STWGDOJUdWImIIAGbydMmvu7UrSSvfqbPgqrcwG8dQ3DTs89x2eZ7B6zKI/kKlQm8
         kg5VXvo7DPGTMOBrMjEHhNTA/qMlAkEDqnjTMJ4BvuWI5jrR3mbRzizbUmT91w71z5
         5+bXkAE13ICYnsOW1oEAvjhNqg7TxhL7LLCLyeDTLv7+fwjk9KOZ8VyZ9U+zp8X1JU
         le6oU5utYcsvTm7YrnUSXEaePNmAlFVXNxIPHKmZUq03ztL5eR1B++nuW/a59Bs+0r
         GboszV29DlZi7Kx5FJUtkFhs2d4/ihBDMACP6F0aLYxFrJyE7moMzO2dITnCVeIA38
         ryvBiqlUleweg==
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-285be6134ecso2370405a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 15:45:23 -0800 (PST)
X-Gm-Message-State: AOJu0YwWOrTupCFyQ5AzvT+TFC7Xc+rO0GcDM9c1kZ9bkhBBe0na1xfZ
        TckW8slLcPHR92DZ9t37//XQcnLCMaDMq8i7l4inzg==
X-Google-Smtp-Source: AGHT+IGdFS8Bsul2mdGiC/tCtB+HU6iOQ3kNjL4sxTCJdac4jDtFdDYLq7mNaL4RD3laDYaf1g/6TFKZQKUwwYafFDU=
X-Received: by 2002:a17:90b:1e44:b0:285:b019:1505 with SMTP id
 pi4-20020a17090b1e4400b00285b0191505mr11406711pjb.45.1701215122938; Tue, 28
 Nov 2023 15:45:22 -0800 (PST)
MIME-Version: 1.0
References: <ZV3BWZ4ZaD5Rj_HS@tiehlicka> <ZV3TQCElHpcp0h0V@tiehlicka>
 <CAJD7tka0=JR1s0OzQ0+H8ksFhvB2aBHXx_2-hVc97Enah9DqGQ@mail.gmail.com>
 <ZV3_6UH28KMt0ZDb@tiehlicka> <87msv58068.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <ZWDPuR5Ssx07nBHb@tiehlicka> <87h6l77wl5.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <CAF8kJuOcMDpqZV+9+QjK-hsoJLGhoBzBOczAc7+UMypVJresSw@mail.gmail.com>
 <87bkbf7gz6.fsf@yhuang6-desk2.ccr.corp.intel.com> <CAF8kJuNKH_vcF-=6nw3zP5cMaZHLudHZfxNDtHm0K2BXJ+EAgA@mail.gmail.com>
 <ZWUKziMl6cFV2uWN@google.com> <CAJD7tkZNa_3mWYeix_Xc-BFRNVMkBF3uzL0JCkZOYw5ubAaj9w@mail.gmail.com>
In-Reply-To: <CAJD7tkZNa_3mWYeix_Xc-BFRNVMkBF3uzL0JCkZOYw5ubAaj9w@mail.gmail.com>
From:   Chris Li <chrisl@kernel.org>
Date:   Tue, 28 Nov 2023 15:45:11 -0800
X-Gmail-Original-Message-ID: <CAF8kJuObOEdK1vdSSmBGqYnQi3a77hC28O_f+yudiAmwOAm-gg@mail.gmail.com>
Message-ID: <CAF8kJuObOEdK1vdSSmBGqYnQi3a77hC28O_f+yudiAmwOAm-gg@mail.gmail.com>
Subject: Re: [PATCH v10] mm: vmscan: try to reclaim swapcache pages if no swap space
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Minchan Kim <minchan@kernel.org>,
        "Huang, Ying" <ying.huang@intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Yu Zhao <yuzhao@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sachin Sant <sachinp@linux.ibm.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
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

On Mon, Nov 27, 2023 at 1:57=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com>=
 wrote:

> >
> > Exactly. Since swap cache has different life time with page cache, they
> > would be usually dropped when pages are unmapped(unless they are shared
> > with others but anon is usually exclusive private) so I wonder how much
> > memory we can save.
>
> I think the point of this patch is not saving memory, but rather
> avoiding an OOM condition that will happen if we have no swap space
> left, but some pages left in the swap cache. Of course, the OOM
> avoidance will come at the cost of extra work in reclaim to swap those
> pages out.

You are discussing how to use the memory that got freed. e.g. using
other apps so avoid OOM.
I am asking how much memory can be freed by this patch. That number is
still useful to understand how effective the patch is.  Does it
justify the additional complexity?

> The only case where I think this might be harmful is if there's plenty
> of pages to reclaim on the file LRU, and instead we opt to chase down
> the few swap cache pages. So perhaps we can add a check to only set
> sc->swapcache_only if the number of pages in the swap cache is more
> than the number of pages on the file LRU or similar? Just make sure we
> don't chase the swapcache pages down if there's plenty to scan on the
> file LRU?

One idea is that we need to measure how effective the reclaim was
toward the swap cache. If we do a lot of work but are not able to
reclaim much from the swap cache, then additional reclaim work on swap
cache is not going to be effective.
MGLRU has a PID controller to adjust the reclaim ratio between the
file and anonymous LRU. That is one way of measuring the effectiveness
of the reclaim. Use the feedback to adjust the follow up reclaim work.
I kind of wish we could have some feedback machine like this for the
swap cache reclaim as well. Not sure how complicated it is to
implement one.

Chris
