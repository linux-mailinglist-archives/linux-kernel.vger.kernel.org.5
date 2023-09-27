Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89BAD7B02E5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 13:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231518AbjI0L1Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 07:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231612AbjI0L1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 07:27:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3304C10E2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 04:26:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D3D1C433C8;
        Wed, 27 Sep 2023 11:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695813995;
        bh=3/kJu0BAtwkj3xJ9fdAbiBLvvVYc2eBsWVfENf9O048=;
        h=Date:Subject:To:References:Cc:From:In-Reply-To:From;
        b=PUT96mbnyi935kDaCn6iWqoadw2bcA5kl4k5iOwiWGVd430pk0xIrzndkmBat8MT6
         0kgG86LdZn0mBlaK6ESrTrJL4oEBfAmtN+6LE0S/RzPiHrbxol7GaPi7XJmmildsqY
         eBhXOFzT2JHo6zduNlkR7dzPza1YNVJNYB7DB0wmVK0aFOi21/xgo01VOCxRzWNATC
         9Po9tWszGFN4QfmCVi7LcZjj3wx1uAMUzFDb/Kw5aXfc1Cejc/oc0Nj3D9ix7OTS08
         lOFDjKx2BHGWP/mUcw+Xegt+mYMeu+CljZ6q9LBOrum31vCHoJW8oJaWD0lD6lfyMS
         1zHLK7RyC+Mww==
Message-ID: <ddc10c41-515f-48c9-966d-4ae7756d208c@kernel.org>
Date:   Wed, 27 Sep 2023 13:26:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/8] hugetlb: restructure pool allocations
Content-Language: en-US
To:     Mike Kravetz <mike.kravetz@oracle.com>
References: <20230925234837.86786-3-mike.kravetz@oracle.com>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Xiongchun Duan <duanxiongchun@bytedance.com>,
        Barry Song <21cnbao@gmail.com>,
        David Rientjes <rientjes@google.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Joao Martins <joao.m.martins@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>,
        linux-kernel@vger.kernel.org
From:   Konrad Dybcio <konradybcio@kernel.org>
In-Reply-To: <20230925234837.86786-3-mike.kravetz@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 26.09.2023 01:48, Mike Kravetz wrote:
> Allocation of a hugetlb page for the hugetlb pool is done by the routine
> alloc_pool_huge_page.  This routine will allocate contiguous pages from
> a low level allocator, prep the pages for usage as a hugetlb page and
> then add the resulting hugetlb page to the pool.
> 
> In the 'prep' stage, optional vmemmap optimization is done.  For
> performance reasons we want to perform vmemmap optimization on multiple
> hugetlb pages at once.  To do this, restructure the hugetlb pool
> allocation code such that vmemmap optimization can be isolated and later
> batched.
> 
> The code to allocate hugetlb pages from bootmem was also modified to
> allow batching.
> 
> No functional changes, only code restructure.
> 
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> Reviewed-by: Muchun Song <songmuchun@bytedance.com>
> ---
Hi, looks like this patch prevents today's next from booting
on at least one Qualcomm ARM64 platform. Reverting it makes
the device boot again.

Konrad
