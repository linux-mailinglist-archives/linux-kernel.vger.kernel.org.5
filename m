Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 080FD7EF7E8
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 20:37:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346171AbjKQThN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 14:37:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232010AbjKQThM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 14:37:12 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D145AD4F
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 11:37:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Hg3+9uA2o75brJVv8ImTnM2XP71Dnb1sX48npnh9pbc=; b=LCBRuKbX3R/y7j0INeyp4apKAB
        gBEvjp8kRp3eRbYo9PZuPrOtKQsJ+cLc1F/SxtXiVGoEZA6qboo3ydYREqGIFx1bqdfSPleLVOR2E
        R/8Y4lG6OIFKqc5CXb/1Myx+tRb1MMOXivJ9HTXx0nxmX4VxYhcVFqT+klcjBzF2btIlkonztl/fc
        mDXKeruHlW8b0EI9V7e+OVi6OjmPn8SGYIwqJnT0h/DBTZlD/tHXiMC3JCfKfYWwvkz9EjWncJDUE
        8hWcxWuZffJsvX/H0wQiGVZG0Cu+xaUsOSpVJIJZKK29vulFQBc314IGGMIs99N7gGxRtnfIN24VA
        NLbZUjig==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1r44e9-00BEGO-NL; Fri, 17 Nov 2023 19:36:57 +0000
Date:   Fri, 17 Nov 2023 19:36:57 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Barry Song <21cnbao@gmail.com>
Cc:     David Hildenbrand <david@redhat.com>, steven.price@arm.com,
        akpm@linux-foundation.org, ryan.roberts@arm.com,
        catalin.marinas@arm.com, will@kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhocko@suse.com,
        shy828301@gmail.com, v-songbaohua@oppo.com,
        wangkefeng.wang@huawei.com, xiang@kernel.org, ying.huang@intel.com,
        yuzhao@google.com
Subject: Re: [RFC V3 PATCH] arm64: mm: swap: save and restore mte tags for
 large folios
Message-ID: <ZVfA2Z8XyD3qtTMZ@casper.infradead.org>
References: <20231114014313.67232-1-v-songbaohua@oppo.com>
 <d8fd421e-00f3-453e-9665-df3fdcc239eb@redhat.com>
 <CAGsJ_4wD9Ug=CLi6Cdw3Ve5q8-1u7MmipLtEGQTfWmU9BJFJOQ@mail.gmail.com>
 <864489b3-5d85-4145-b5bb-5d8a74b9b92d@redhat.com>
 <CAGsJ_4wsWzhosZJWegOb8ggoON3KdiH1mO-8mFZd7kWcn6diuw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGsJ_4wsWzhosZJWegOb8ggoON3KdiH1mO-8mFZd7kWcn6diuw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 17, 2023 at 07:47:00AM +0800, Barry Song wrote:
> This has been discussed. Steven, Ryan and I all don't think this is a good
> option. in case we have a large folio with 16 basepages, as do_swap_page
> can only map one base page for each page fault, that means we have
> to restore 16(tags we restore in each page fault) * 16(the times of page faults)
> for this large folio.

That doesn't seem all that hard to fix?  Call set_ptes() instead of
set_pte_at().  The biggest thing, I guess, is making sure that all
the PTEs you're going to set up are still pte_none().

