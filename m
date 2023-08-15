Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F86077C699
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 06:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234568AbjHOEF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 00:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234598AbjHOEDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 00:03:10 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 032BB1FFA
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 20:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692071981; x=1723607981;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version:content-transfer-encoding;
  bh=/Mw7RQpLyqhx6Q6WsAXyrv5pUB4TROjZEdCTqb4BKLA=;
  b=Vm45bgniMbBaCwFnAmdxw6fDzpdKySyWXlrrSFl3ANAG+NGeGFcKxg5k
   8a4Pm8V6OtnQXrTKVh6+enzMWqaTWtQawuQo6zO0EKNhBvg2JDdbOlfje
   IzstjzwLMl5edmks7yiD19W8oTLlY0frfPtNuYSFhqTG+MlYlrxs87lCt
   Q5BedaRS6OypOIR314UVS4GQomuheOqAWpXiz4+l0JhxIDLfRuEnUaBPZ
   MbcHO4Bazoiajp+c1UgYITRb+Zao8oDySHrk41MMF4pCoVXp5hOGaXq68
   d/0J0HR+araWFm4r81tUOx86N4llRjmV068IgxBFwUlKDNEL4xdn2TAzp
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="371101945"
X-IronPort-AV: E=Sophos;i="6.01,173,1684825200"; 
   d="scan'208";a="371101945"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2023 20:59:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="803672393"
X-IronPort-AV: E=Sophos;i="6.01,173,1684825200"; 
   d="scan'208";a="803672393"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2023 20:59:38 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Zi Yan <ziy@nvidia.com>, Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH 1/4] mm: migrate: use a folio in add_page_for_migration()
References: <ZMud3RreEpsvFKuA@casper.infradead.org>
        <fb2a22cf-14ae-3594-f5f3-8680c2100d70@huawei.com>
        <F2621E68-F36E-493C-8619-ADFE05050823@nvidia.com>
        <d184ba78-97d1-a264-fc31-87dfdbe6fdff@huawei.com>
        <de0100e4-d673-428b-8d50-11ae2b7a9641@huawei.com>
        <5BBFF5D3-3416-4C0E-9FDD-655661657D67@nvidia.com>
        <a34778cb-61dd-4853-9961-afd7568cd0f7@huawei.com>
        <20230809205316.GA3537@monkey> <20230809224424.GB3537@monkey>
        <2da95492-079b-43b1-a950-d290984a21c0@huawei.com>
        <20230810162920.GA4734@monkey>
Date:   Tue, 15 Aug 2023 11:58:00 +0800
In-Reply-To: <20230810162920.GA4734@monkey> (Mike Kravetz's message of "Thu,
        10 Aug 2023 09:29:20 -0700")
Message-ID: <87wmxx7y9j.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Kravetz <mike.kravetz@oracle.com> writes:

> On 08/10/23 09:49, Kefeng Wang wrote:
>>=20
>>=20
>> On 2023/8/10 6:44, Mike Kravetz wrote:
>> > On 08/09/23 13:53, Mike Kravetz wrote:
>> > > On 08/09/23 20:37, Kefeng Wang wrote:
>> > > > >=20
>> > > > > Cc Mike to help us clarify the expected behavior of hugetlb.
>> > > > >=20
>> > > > > Hi Mike, what is the expected behavior, if a user tries to use m=
ove_pages()
>> > > > > to migrate a non head page of a hugetlb page?
>> > > >=20
>> > > > Could you give some advise, thanks
>> > > >=20
>> > >=20
>> > > Sorry, I was away for a while.
>> > >=20
>> > > It seems unfortunate that move_pages says the passed user addresses
>> > > should be aligned to page boundaries.  However, IIUC this is not che=
cked
>> > > or enforced.  Otherwise, passing a hugetlb page should return the sa=
me
>> > > error.
>> > >=20
>> > > One thought would be that hugetlb mappings should behave the same
>> > > non-hugetlb mappings.  If passed the address of a hugetlb tail page,=
 align
>> > > the address to a hugetlb boundary and migrate the page.  This change=
s the
>> > > existing behavior.  However, it would be hard to imagine anyone depe=
nding
>> > > on this.
>> > >=20
>> > > After taking a closer look at the add_page_for_migration(), it seems=
 to
>> > > just ignore passed tail pages and do nothing for such passed address=
es.
>> > > Correct?  Or, am I missing something?  Perhaps that is behavior we w=
ant/
>> > > need to preserve?
>> >=20
>> > My mistake, status -EACCES is returned when passing a tail page of a
>> > hugetlb page.
>> >=20
>>=20
>> As mentioned in previous mail=EF=BC=8C before e66f17ff7177 ("mm/hugetlb:=
 take
>> page table lock in follow_huge_pmd()") in v4.0, follow_page() will
>> return NULL on tail page for Huagetlb page, so move_pages() will return
>> -ENOENT errno, but after that commit, -EACCES is returned.
>>=20
>> Meanwhile, the behavior of THP/HUGETLB is different, the whole THP will =
be
>> migrated on a tail page, but HUGETLB will return -EACCES(after v4.0)
>> or -ENOENT(before v4.0) on tail page.
>>=20
>> > Back to the question of 'What is the expected behavior if a tail page =
is
>> > passed?'.  I do not think we have defined an expected behavior.  If
>> > anything is 'expected' I would say it is -EACCES as returned today.
>> >=20
>>=20
>> My question is,
>>=20
>> Should we keep seem behavior between HUGETLB and THP, or only change the
>> errno from -EACCES to -ENOENT/-EBUSY.
>
> Just to be clear.  When you say "keep seem behavior between HUGETLB and T=
HP",
> are you saying that you would like hugetlb to perform migration of the en=
tire
> hugetlb page if a tail page is passed?
>
> IMO, this would be ideal as it would mean that hugetlb and THP behave the=
 same
> when passed the address of a tail page.  The fewer places where hugetlb
> behavior diverges, the better.  However, this does change behavior.

A separate patch will be needed for behavior change.

> As mentioned above, I have a hard time imagining someone depending on the
> behavior that passing the address of a hugetlb tail page returns error.  =
But,
> this is almost impossible to predict.
>
> Thoughts from others?=20=20

--
Best Regards,
Huang, Ying
