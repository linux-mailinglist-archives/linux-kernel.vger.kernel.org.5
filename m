Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF7F7AD3E2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 10:56:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232974AbjIYI46 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 04:56:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232936AbjIYI45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 04:56:57 -0400
Received: from out-204.mta0.migadu.com (out-204.mta0.migadu.com [IPv6:2001:41d0:1004:224b::cc])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A117DF
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 01:56:49 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1695632208;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kyckiC55caP9KWh/3WatOnX5yiAYCuwEaRClig5LT6Y=;
        b=ZCi899+4Hxeiwo5hoDEXrXPS765wHNZlDs5vt+ZMbQoCuu3P3uUqcWgF30jTKCbMA9+WtP
        cEe40Ea8WIWQ5jrUh5it9uKUqewGRRGVZ8BW0ZdfGrz2H98vcgVSNh9sYyDxs5/fvrSxe4
        ZwqN9uppcIv1uYipsp++zO5A8YMyUcI=
Mime-Version: 1.0
Subject: Re: [PATCH v5 2/8] hugetlb: restructure pool allocations
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20230925003953.142620-3-mike.kravetz@oracle.com>
Date:   Mon, 25 Sep 2023 16:56:03 +0800
Cc:     Linux-MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Rientjes <rientjes@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Barry Song <21cnbao@gmail.com>, Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Xiongchun Duan <duanxiongchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Transfer-Encoding: 7bit
Message-Id: <9D82738C-AF1D-44E6-8982-8A5A13F04687@linux.dev>
References: <20230925003953.142620-1-mike.kravetz@oracle.com>
 <20230925003953.142620-3-mike.kravetz@oracle.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Sep 25, 2023, at 08:39, Mike Kravetz <mike.kravetz@oracle.com> wrote:
> 
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

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks.
