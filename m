Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B67E7F9B13
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 08:42:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbjK0HmT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 02:42:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjK0HmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 02:42:17 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8E9C12F
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 23:42:23 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EA9AC433CB
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 07:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701070943;
        bh=8FsHT2Xzon2e0xd3rsRca6eGh3KS8yCnz1RZFCNvPxY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HnwmaykAFhH00oP/GM9Lhke7OaPq5UUVWk9tlQwSfzs+nHHyRtlfrXjSQv9uYGwuh
         eb3VPBICH22rStDvM35PrzQbCR8/iraKKRkd9sJd1NGxFal+cOtLfN+b+j2WvEEwtA
         asuaysndIrxQXXz4DNqydexnUKEOkwnrhQJZWajm8dca0o6WCL/bmsKTa0Fs+gLXCW
         6hTAkCE5BIi66HIeyGjXirTVBy+QXd3ttn/Lybb+mN34XcbzA+fLLgk115J1VYL3lw
         ECAvE793NRSTl2ba4zG9UfVciI82s5P9Y9PrKTwIArS6h23S8Ff/R8fZiYs9DNBg+M
         eXBqQApnNMqgw==
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-285d32c6f07so378009a91.1
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 23:42:23 -0800 (PST)
X-Gm-Message-State: AOJu0YyEYt5c+Xyl4Vn2fEbdhu0JB0THeervmfm+wlvOEjukOE1Lj7EO
        8P4eSNWDEjGwNxGo+fvcUWRsQBuvBHhBW+V19H8EAA==
X-Google-Smtp-Source: AGHT+IE/9MLy2mP4Tya7d9XuqJFTMzuCQNibPnrO8JXb6SHZorbet3mA6rmkka/00WZDPzV9QBKFvE2tKxiEkrhrTfk=
X-Received: by 2002:a17:90a:1a03:b0:280:2652:d4e with SMTP id
 3-20020a17090a1a0300b0028026520d4emr9440658pjk.29.1701070942704; Sun, 26 Nov
 2023 23:42:22 -0800 (PST)
MIME-Version: 1.0
References: <20231121090624.1814733-1-liushixin2@huawei.com>
 <ZVyp5eETLTT0PCYj@tiehlicka> <32fe518a-e962-14ae-badc-719390386db9@huawei.com>
 <CAJD7tkbC=Z6qAE+b6Ch5eVxNY7k0p98i_=RY0m4_3yg5C_zv+A@mail.gmail.com>
 <ZV3BWZ4ZaD5Rj_HS@tiehlicka> <ZV3TQCElHpcp0h0V@tiehlicka> <CAJD7tka0=JR1s0OzQ0+H8ksFhvB2aBHXx_2-hVc97Enah9DqGQ@mail.gmail.com>
 <ZV3_6UH28KMt0ZDb@tiehlicka> <87msv58068.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <ZWDPuR5Ssx07nBHb@tiehlicka> <87h6l77wl5.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87h6l77wl5.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   Chris Li <chrisl@kernel.org>
Date:   Sun, 26 Nov 2023 23:42:11 -0800
X-Gmail-Original-Message-ID: <CAF8kJuOcMDpqZV+9+QjK-hsoJLGhoBzBOczAc7+UMypVJresSw@mail.gmail.com>
Message-ID: <CAF8kJuOcMDpqZV+9+QjK-hsoJLGhoBzBOczAc7+UMypVJresSw@mail.gmail.com>
Subject: Re: [PATCH v10] mm: vmscan: try to reclaim swapcache pages if no swap space
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        Yosry Ahmed <yosryahmed@google.com>,
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

Hi Ying,

On Sun, Nov 26, 2023 at 6:36=E2=80=AFPM Huang, Ying <ying.huang@intel.com> =
wrote:
>
> Michal Hocko <mhocko@suse.com> writes:
>
> > On Thu 23-11-23 14:15:59, Huang, Ying wrote:
> >> Michal Hocko <mhocko@suse.com> writes:
> > [...]
> >> > Yes swapcache pages are indeed more complicated but most of the time
> >> > they just go away as well, no?
> >>
> >> When we swapin a page, we will put it in swapcache too.  And the page
> >> can be in that state for long time if there is more than 50% free spac=
e
> >> in the swap device.
> >
> > True, but why is that a problem? If you encounter such a swapped in pag=
e
> > on the file LRU then the page should be referened and as such should be
> > activated, no?
>
> This just means that anonymous pages in file LRU aren't temporary or
> short-term.  So we need to consider that.  For example, the original
> method to balance between anonymous pages and file pages need to be
> re-designed.  The anonymous pages are considered hotter than file pages
> in general.

 I agree with Ying that anonymous pages typically have different page
access patterns than file pages, so we might want to treat them
differently to reclaim them effectively.
One random idea:
How about we put the anonymous page in a swap cache in a different LRU
than the rest of the anonymous pages. Then shrinking against those
pages in the swap cache would be more effective.Instead of having
[anon, file] LRU, now we have [anon not in swap cache, anon in swap
cache, file] LRU

Chris
