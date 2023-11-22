Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49A6B7F3E7A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 07:59:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233968AbjKVG7e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 01:59:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbjKVG7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 01:59:32 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9770DD
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 22:59:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700636367; x=1732172367;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=lz4P4yyNksj4DKVXnTX7lbEklY3XdyKKBLRol+9exJI=;
  b=USNUWDQnEtbpf2dsMZt23opzeb0UI841eGE1fkFAEXm64V61RrRVxQje
   DrhYpQXYoNhznYJepTGy5smZHDvp8QZoYk0ONcJlzkjF3WipWpqvnzHFb
   OOxGAnpNIkCxLejZ89+RM0aX3UZ8cf7ptDwcK2UAlQfo4Vr6DjSay+h18
   rRvAivUIKuUurwJmIk3iwBqN9n0UnZUtu1EeOeA+2d8Z7B58UbZjDhxHy
   swFhCG1RVZwUhLxF/wuRSbMn5mV/qW2hbBA3CWIvgRPUBWaLd2bFUVY1Q
   9oFeTMXoYLm9DCfUyojSNp3de1irlImpLa+ijeK6adOWYCzo7Fxp3SRNs
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="13547314"
X-IronPort-AV: E=Sophos;i="6.04,218,1695711600"; 
   d="scan'208";a="13547314"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 22:59:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="832913554"
X-IronPort-AV: E=Sophos;i="6.04,218,1695711600"; 
   d="scan'208";a="832913554"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 22:59:24 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Liu Shixin <liushixin2@huawei.com>, Michal Hocko <mhocko@suse.com>,
        Yu Zhao <yuzhao@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sachin Sant <sachinp@linux.ibm.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10] mm: vmscan: try to reclaim swapcache pages if no
 swap space
In-Reply-To: <CAJD7tkbC=Z6qAE+b6Ch5eVxNY7k0p98i_=RY0m4_3yg5C_zv+A@mail.gmail.com>
        (Yosry Ahmed's message of "Tue, 21 Nov 2023 22:44:32 -0800")
References: <20231121090624.1814733-1-liushixin2@huawei.com>
        <ZVyp5eETLTT0PCYj@tiehlicka>
        <32fe518a-e962-14ae-badc-719390386db9@huawei.com>
        <CAJD7tkbC=Z6qAE+b6Ch5eVxNY7k0p98i_=RY0m4_3yg5C_zv+A@mail.gmail.com>
Date:   Wed, 22 Nov 2023 14:57:24 +0800
Message-ID: <878r6q9sx7.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yosry Ahmed <yosryahmed@google.com> writes:

> On Tue, Nov 21, 2023 at 10:41=E2=80=AFPM Liu Shixin <liushixin2@huawei.co=
m> wrote:
>>
>>
>> On 2023/11/21 21:00, Michal Hocko wrote:
>> > On Tue 21-11-23 17:06:24, Liu Shixin wrote:
>> >
>> > However, in swapcache_only mode, the scan count still increased when s=
can
>> > non-swapcache pages because there are large number of non-swapcache pa=
ges
>> > and rare swapcache pages in swapcache_only mode, and if the non-swapca=
che
>> > is skipped and do not count, the scan of pages in isolate_lru_folios()=
 can
>> > eventually lead to hung task, just as Sachin reported [2].
>> > I find this paragraph really confusing! I guess what you meant to say =
is
>> > that a real swapcache_only is problematic because it can end up not
>> > making any progress, correct?
>> This paragraph is going to explain why checking swapcache_only after sca=
n +=3D nr_pages;
>> >
>> > AFAIU you have addressed that problem by making swapcache_only anon LRU
>> > specific, right? That would be certainly more robust as you can still
>> > reclaim from file LRUs. I cannot say I like that because swapcache_only
>> > is a bit confusing and I do not think we want to grow more special
>> > purpose reclaim types. Would it be possible/reasonable to instead put
>> > swapcache pages on the file LRU instead?
>> It looks like a good idea, but I'm not sure if it's possible. I can try =
it, is there anything to
>> pay attention to?
>
> I think this might be more intrusive than we think. Every time a page
> is added to or removed from the swap cache, we will need to move it
> between LRUs. All pages on the anon LRU will need to go through the
> file LRU before being reclaimed. I think this might be too big of a
> change to achieve this patch's goal.

We need to identify swap cache pages on file LRU firstly.  It appears
hard from the current definition of page flags.

  /* Filesystems */
  PG_checked =3D PG_owner_priv_1,

  /* SwapBacked */
  PG_swapcache =3D PG_owner_priv_1,       /* Swap page: swp_entry_t in priv=
ate */

--
Best Regards,
Huang, Ying
