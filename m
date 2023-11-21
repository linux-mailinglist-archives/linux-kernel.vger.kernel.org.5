Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9DCA7F22A5
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 01:57:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232792AbjKUA5K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 19:57:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjKUA5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 19:57:08 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 938F2BC
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 16:57:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700528224; x=1732064224;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=nMU2J77ghZ+e8qdA0h9ywIv9K6Jb8YxZyIcZx9Q1D4U=;
  b=fdj4QgCfK4oCSPpNMVuBEIIMdXwKifhavNnaWpwAk9rOWbkKRBeRe4jw
   53PSXllCUqy95DsewXPrMzYzPDxSDr+iZoVM0eMygiItA4w5eUtGkdI0O
   iV7zeaXkYbCv5OCIbGPEe1DR0eU2y+IadaqKeyoC4HjFqXjX9d8JB2Xd/
   lbCbaE4GxULOBFg1zcLUKjGcJ+dhPQCtkl2B0FfKBLoz8zeRluxHoQnXE
   xBtJjSk49+AEpNURVLx1rN8H4FxNpf9+gYnDjFnmf0wNGolczzUnJD6Ij
   VV+TqBOKVjeN1cwgdnz6Wc6xObDxCFnhjJkgEDgT+ciNuAkGzNj/45nI0
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="394580409"
X-IronPort-AV: E=Sophos;i="6.04,214,1695711600"; 
   d="scan'208";a="394580409"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 16:56:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="716376843"
X-IronPort-AV: E=Sophos;i="6.04,214,1695711600"; 
   d="scan'208";a="716376843"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 16:56:53 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Chris Li <chriscli@google.com>,
        Zhongkun He <hezhongkun.hzk@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Nhat Pham <nphamcs@gmail.com>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm:zswap: fix zswap entry reclamation failure in two
 scenarios
In-Reply-To: <CAJD7tkbfjhC8SHZ=KspVfrTECZyY8BYrPGcLVLJcJRwXXdYDrw@mail.gmail.com>
        (Yosry Ahmed's message of "Mon, 20 Nov 2023 10:52:25 -0800")
References: <20231113130601.3350915-1-hezhongkun.hzk@bytedance.com>
        <CAJD7tkY8SwROmNEaBAhkS4OKj33g-6fHsKFeYKW3afT+yAbvxA@mail.gmail.com>
        <CAF8kJuPonfuOtipdifXwBny2H7cy6m6BL8mWFVXzfb9JSdYq3Q@mail.gmail.com>
        <CAJD7tkYMiJiXTTgAN34TP8QTr-ViAuEFddYes=ac+1ErenjCZw@mail.gmail.com>
        <CAF8kJuOC30feLGs0bNHOxMjSZ3uqF1y7eUdJ4p-w-myP8c1cFg@mail.gmail.com>
        <8734x1cdtr.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <CAJD7tkbfjhC8SHZ=KspVfrTECZyY8BYrPGcLVLJcJRwXXdYDrw@mail.gmail.com>
Date:   Tue, 21 Nov 2023 08:54:52 +0800
Message-ID: <87edgkapsz.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yosry Ahmed <yosryahmed@google.com> writes:

> On Sun, Nov 19, 2023 at 7:20=E2=80=AFPM Huang, Ying <ying.huang@intel.com=
> wrote:
>>
>> Chris Li <chriscli@google.com> writes:
>>
>> > On Thu, Nov 16, 2023 at 12:19=E2=80=AFPM Yosry Ahmed <yosryahmed@googl=
e.com> wrote:
>> >>
>> >> Not bypassing the swap slot cache, just make the callbacks to
>> >> invalidate the zswap entry, do memg uncharging, etc when the slot is
>> >> no longer used and is entering the swap slot cache (i.e. when
>> >> free_swap_slot() is called), instead of when draining the swap slot
>> >> cache (i.e. when swap_range_free() is called). For all parts of MM
>> >> outside of swap, the swap entry is freed when free_swap_slot() is
>> >> called. We don't free it immediately because of caching, but this
>> >> should be transparent to other parts of MM (e.g. zswap, memcg, etc).
>> >
>> > That will cancel the batching effect on the swap slot free, making the
>> > common case for  swapping  faults take longer to complete, righ?
>> > If I recall correctly, the uncharge is the expensive part of the swap
>> > slot free operation.
>> > I just want to figure out what we are trading off against. This is not
>> > one side wins all situations.
>>
>> Per my understanding, we don't batch memcg uncharging in
>> swap_entry_free() now.  Although it's possible and may improve
>> performance.
>
> Yes. It actually causes a long tail in swapin fault latency as Chris
> discovered in our prod. I am wondering if doing the memcg uncharging
> outside the slots cache will actually amortize the cost instead.
>
> Regardless of memcg charging, which is more complicated, I think we
> should at least move the call to zswap_invalidate() before the slots
> cache. I would prefer that we move everything non-swapfile specific
> outside the slots cache layer (zswap_invalidate(),
> arch_swap_invalidate_page(),  clear_shadow_from_swap_cache(),
> mem_cgroup_uncharge_swap(), ..).  However, if some of those are
> controversial, we can move some of them for now.

That makes sense for me.

> When draining free swap slots from the cache, swap_range_free() is
> called with nr_entries =3D=3D 1 anyway, so I can't see how any batching is
> going on. If anything it should help amortize the cost.

In swapcache_free_entries(), the sis->lock will be held to free multiple
swap slots via swap_info_get_cont() if possible.  This can reduce
sis->lock contention.

--
Best Regards,
Huang, Ying
