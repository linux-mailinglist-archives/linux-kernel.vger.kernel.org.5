Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DCA27F5811
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 07:18:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232115AbjKWGSL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 01:18:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbjKWGSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 01:18:10 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B882610E
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 22:18:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700720296; x=1732256296;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=pU5XgnaIyhhzJE/LMU8OzUII0Qq9Lz5PhG+Q/UbLT6E=;
  b=VUke5nsRtnEs8EczVJmhurpfkM7N+YTyKLqQjHbjQyQkNHqolV+C4fiI
   u70ko2MAp+v+iaL2/ZrkYjMrwKXg8gh9NMipSWwFf0Xe08DXX2qjP6SWN
   XSLZmgHBa7TS8Q5p9M8lH3ZnNJb6EK54k/XUt2La5EkfbmAq0F75pk/Cb
   6OQzKrmZ5T2Genl/0dV/8NtmrMY+YbBoCUosBn6GSfvBSnvRD2PxR/aiW
   GhbP0EgJ1cZHCLFWi9W/ny43GSS/HAnOYzFwhvg9LHq98zywAP92YUArt
   XmdgkPAOqk81UpiSlpzg0yQxGBb8GrXi1CBvr0f34/MTHDOXCtNJtFe5L
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="396114103"
X-IronPort-AV: E=Sophos;i="6.04,220,1695711600"; 
   d="scan'208";a="396114103"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2023 22:18:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="767108348"
X-IronPort-AV: E=Sophos;i="6.04,220,1695711600"; 
   d="scan'208";a="767108348"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2023 22:18:00 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Yosry Ahmed <yosryahmed@google.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Yu Zhao <yuzhao@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sachin Sant <sachinp@linux.ibm.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10] mm: vmscan: try to reclaim swapcache pages if no
 swap space
In-Reply-To: <ZV3_6UH28KMt0ZDb@tiehlicka> (Michal Hocko's message of "Wed, 22
        Nov 2023 14:19:37 +0100")
References: <20231121090624.1814733-1-liushixin2@huawei.com>
        <ZVyp5eETLTT0PCYj@tiehlicka>
        <32fe518a-e962-14ae-badc-719390386db9@huawei.com>
        <CAJD7tkbC=Z6qAE+b6Ch5eVxNY7k0p98i_=RY0m4_3yg5C_zv+A@mail.gmail.com>
        <ZV3BWZ4ZaD5Rj_HS@tiehlicka> <ZV3TQCElHpcp0h0V@tiehlicka>
        <CAJD7tka0=JR1s0OzQ0+H8ksFhvB2aBHXx_2-hVc97Enah9DqGQ@mail.gmail.com>
        <ZV3_6UH28KMt0ZDb@tiehlicka>
Date:   Thu, 23 Nov 2023 14:15:59 +0800
Message-ID: <87msv58068.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Hocko <mhocko@suse.com> writes:

> On Wed 22-11-23 02:39:15, Yosry Ahmed wrote:
>> On Wed, Nov 22, 2023 at 2:09=E2=80=AFAM Michal Hocko <mhocko@suse.com> w=
rote:
>> >
>> > On Wed 22-11-23 09:52:42, Michal Hocko wrote:
>> > > On Tue 21-11-23 22:44:32, Yosry Ahmed wrote:
>> > > > On Tue, Nov 21, 2023 at 10:41=E2=80=AFPM Liu Shixin <liushixin2@hu=
awei.com> wrote:
>> > > > >
>> > > > >
>> > > > > On 2023/11/21 21:00, Michal Hocko wrote:
>> > > > > > On Tue 21-11-23 17:06:24, Liu Shixin wrote:
>> > > > > >
>> > > > > > However, in swapcache_only mode, the scan count still increase=
d when scan
>> > > > > > non-swapcache pages because there are large number of non-swap=
cache pages
>> > > > > > and rare swapcache pages in swapcache_only mode, and if the no=
n-swapcache
>> > > > > > is skipped and do not count, the scan of pages in isolate_lru_=
folios() can
>> > > > > > eventually lead to hung task, just as Sachin reported [2].
>> > > > > > I find this paragraph really confusing! I guess what you meant=
 to say is
>> > > > > > that a real swapcache_only is problematic because it can end u=
p not
>> > > > > > making any progress, correct?
>> > > > > This paragraph is going to explain why checking swapcache_only a=
fter scan +=3D nr_pages;
>> > > > > >
>> > > > > > AFAIU you have addressed that problem by making swapcache_only=
 anon LRU
>> > > > > > specific, right? That would be certainly more robust as you ca=
n still
>> > > > > > reclaim from file LRUs. I cannot say I like that because swapc=
ache_only
>> > > > > > is a bit confusing and I do not think we want to grow more spe=
cial
>> > > > > > purpose reclaim types. Would it be possible/reasonable to inst=
ead put
>> > > > > > swapcache pages on the file LRU instead?
>> > > > > It looks like a good idea, but I'm not sure if it's possible. I =
can try it, is there anything to
>> > > > > pay attention to?
>> > > >
>> > > > I think this might be more intrusive than we think. Every time a p=
age
>> > > > is added to or removed from the swap cache, we will need to move it
>> > > > between LRUs. All pages on the anon LRU will need to go through the
>> > > > file LRU before being reclaimed. I think this might be too big of a
>> > > > change to achieve this patch's goal.
>> > >
>> > > TBH I am not really sure how complex that might turn out to be.
>> > > Swapcache tends to be full of subtle issues. So you might be right b=
ut
>> > > it would be better to know _why_ this is not possible before we end =
up
>> > > phising for couple of swapcache pages on potentially huge anon LRU to
>> > > isolate them. Think of TB sized machines in this context.
>> >
>> > Forgot to mention that it is not really far fetched from comparing this
>> > to MADV_FREE pages. Those are anonymous but we do not want to keep them
>> > on anon LRU because we want to age them indepdendent on the swap
>> > availability as they are just dropped during reclaim. Not too much
>> > different from swapcache pages. There are more constrains on those but
>> > fundamentally this is the same problem, no?
>>=20
>> I agree it's not a first, but swap cache pages are more complicated
>> because they can go back and forth, unlike MADV_FREE pages which
>> usually go on a one way ticket AFAICT.
>
> Yes swapcache pages are indeed more complicated but most of the time
> they just go away as well, no?

When we swapin a page, we will put it in swapcache too.  And the page
can be in that state for long time if there is more than 50% free space
in the swap device.

> MADV_FREE can be reinitiated if they are
> written as well. So fundamentally they are not that different.
>

[snip]

--
Best Regards,
Huang, Ying
