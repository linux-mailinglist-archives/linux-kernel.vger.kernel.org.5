Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DA237F2356
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 02:55:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233245AbjKUBz6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 20:55:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232997AbjKUBz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 20:55:57 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE80E85
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 17:55:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700531753; x=1732067753;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=kq28EHYGvh4sRWAhKoXm/zX2T5wCVpxNHx7fWDZxre4=;
  b=Km1jFg8af4VDlODwv8t/8pO/knm5yhE3u1CaiX6P0SSy0QuBNzEMapNm
   UxjgJXpNXxMc5Lxz8S9456GNmtuD5deTQ07T/C1q6sztcWG19pyM8qpE/
   c9OQsasFmlPpLCxAGcO57RAVrsDcANOHKulWBah0cPiahxGMgNqc8j8uW
   Y95QeZCsxOXKX7yesl40gYLONg5c8OtDBqaabFH+D5yhvq68uPvccsMgc
   Qdaedn46VrxklrBASIEvwspe0Nj5qk8bzeX5AD5hg5sVv7dAa/E0Tigup
   lB6sPQGI+Hhi1rAbENurb2gwhT8Yy2/0lBxTIZN5m+7B9/OHiumbCrRus
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="458238706"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="458238706"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 17:55:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="910314635"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="910314635"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 17:55:49 -0800
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
In-Reply-To: <CAJD7tkamaGjmP0anhez+JHxJx++UQcykyxRDieQxcTt5Q4+YuQ@mail.gmail.com>
        (Yosry Ahmed's message of "Mon, 20 Nov 2023 17:15:15 -0800")
References: <20231113130601.3350915-1-hezhongkun.hzk@bytedance.com>
        <CAJD7tkY8SwROmNEaBAhkS4OKj33g-6fHsKFeYKW3afT+yAbvxA@mail.gmail.com>
        <CAF8kJuPonfuOtipdifXwBny2H7cy6m6BL8mWFVXzfb9JSdYq3Q@mail.gmail.com>
        <CAJD7tkYMiJiXTTgAN34TP8QTr-ViAuEFddYes=ac+1ErenjCZw@mail.gmail.com>
        <CAF8kJuOC30feLGs0bNHOxMjSZ3uqF1y7eUdJ4p-w-myP8c1cFg@mail.gmail.com>
        <8734x1cdtr.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <CAJD7tkbfjhC8SHZ=KspVfrTECZyY8BYrPGcLVLJcJRwXXdYDrw@mail.gmail.com>
        <87edgkapsz.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <CAJD7tkamaGjmP0anhez+JHxJx++UQcykyxRDieQxcTt5Q4+YuQ@mail.gmail.com>
Date:   Tue, 21 Nov 2023 09:53:48 +0800
Message-ID: <875y1vc1n7.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yosry Ahmed <yosryahmed@google.com> writes:

> On Mon, Nov 20, 2023 at 4:57=E2=80=AFPM Huang, Ying <ying.huang@intel.com=
> wrote:
>>
>> Yosry Ahmed <yosryahmed@google.com> writes:
>>
>> > On Sun, Nov 19, 2023 at 7:20=E2=80=AFPM Huang, Ying <ying.huang@intel.=
com> wrote:
>> >>
>> >> Chris Li <chriscli@google.com> writes:
>> >>
>> >> > On Thu, Nov 16, 2023 at 12:19=E2=80=AFPM Yosry Ahmed <yosryahmed@go=
ogle.com> wrote:
>> >> >>
>> >> >> Not bypassing the swap slot cache, just make the callbacks to
>> >> >> invalidate the zswap entry, do memg uncharging, etc when the slot =
is
>> >> >> no longer used and is entering the swap slot cache (i.e. when
>> >> >> free_swap_slot() is called), instead of when draining the swap slot
>> >> >> cache (i.e. when swap_range_free() is called). For all parts of MM
>> >> >> outside of swap, the swap entry is freed when free_swap_slot() is
>> >> >> called. We don't free it immediately because of caching, but this
>> >> >> should be transparent to other parts of MM (e.g. zswap, memcg, etc=
).
>> >> >
>> >> > That will cancel the batching effect on the swap slot free, making =
the
>> >> > common case for  swapping  faults take longer to complete, righ?
>> >> > If I recall correctly, the uncharge is the expensive part of the sw=
ap
>> >> > slot free operation.
>> >> > I just want to figure out what we are trading off against. This is =
not
>> >> > one side wins all situations.
>> >>
>> >> Per my understanding, we don't batch memcg uncharging in
>> >> swap_entry_free() now.  Although it's possible and may improve
>> >> performance.
>> >
>> > Yes. It actually causes a long tail in swapin fault latency as Chris
>> > discovered in our prod. I am wondering if doing the memcg uncharging
>> > outside the slots cache will actually amortize the cost instead.
>> >
>> > Regardless of memcg charging, which is more complicated, I think we
>> > should at least move the call to zswap_invalidate() before the slots
>> > cache. I would prefer that we move everything non-swapfile specific
>> > outside the slots cache layer (zswap_invalidate(),
>> > arch_swap_invalidate_page(),  clear_shadow_from_swap_cache(),
>> > mem_cgroup_uncharge_swap(), ..).  However, if some of those are
>> > controversial, we can move some of them for now.
>>
>> That makes sense for me.
>>
>> > When draining free swap slots from the cache, swap_range_free() is
>> > called with nr_entries =3D=3D 1 anyway, so I can't see how any batchin=
g is
>> > going on. If anything it should help amortize the cost.
>>
>> In swapcache_free_entries(), the sis->lock will be held to free multiple
>> swap slots via swap_info_get_cont() if possible.  This can reduce
>> sis->lock contention.
>
> Ah yes that's a good point. Since most of these callbacks don't
> actually access sis, but use the swap entry value itself, I am
> guessing the reason we need to hold the lock for all these callbacks
> is to prevent swapoff and swapon reusing the same swap entry on a
> different swap device, right?

In,

swapcache_free_entries()
  swap_entry_free()
    swap_range_free()

Quite some sis fields will be accessed.

--
Best Regards,
Huang, Ying
