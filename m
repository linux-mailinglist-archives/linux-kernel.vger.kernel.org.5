Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B39237FB0D3
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 05:11:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234559AbjK1EKx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 23:10:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbjK1EKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 23:10:51 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1929A198
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 20:10:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NHKll15xTEo9mrdFdz2lzv6dtg/D50aR80vn8riWfoE=; b=HlUOQUSKbr7DQ1gja3nUKu+/s4
        DwaB3NGfmkiikfrisc2djL9zmQHERJZhTd7zE/VvQFAEkS67pGvX+QPVAQicuCPId2JB9NydtZkKN
        BAaCzVr2w/VJ4FjGrVLtAQ/8SMYcrv5hyDOY6BNssTFsLg/OkOCP3iKX5rv8Oe+NYgaGVydzhbYtT
        P8KDh9I30jnTkzeX6h61x/fptdXccHo5/x0tLA01tPU4AeaQB1PCURKntm0hCxjS+Rv1Ar1WvC1Aa
        EnkXNx8BOnkeuoLGskMsDdQQPppN+0T1YGcx59ngob8nGFdfWi8j+cdjRA7+wpEE/8EB+zY3fJXxo
        6zeim5sw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1r7pQj-00C1MJ-O7; Tue, 28 Nov 2023 04:10:37 +0000
Date:   Tue, 28 Nov 2023 04:10:37 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Alistair Popple <apopple@nvidia.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yin Fengwei <fengwei.yin@intel.com>,
        Yu Zhao <yuzhao@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Itaru Kitayama <itaru.kitayama@gmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        John Hubbard <jhubbard@nvidia.com>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hugh Dickins <hughd@google.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v7 00/10] Small-sized THP for anonymous memory
Message-ID: <ZWVoPT4AZOLJ/eE4@casper.infradead.org>
References: <20231122162950.3854897-1-ryan.roberts@arm.com>
 <ZV9267tQEhoPzCru@casper.infradead.org>
 <f8e518f2-fb15-4295-a335-bea5a8010ab2@arm.com>
 <ZWC9lwDAjMZsNzoG@casper.infradead.org>
 <9c8f6d2a-7ed8-45d2-9684-d77489bd99b8@redhat.com>
 <ZWDG6BYqmZVpyTLL@casper.infradead.org>
 <26c361bc-6d87-4a57-9fae-ef635c9039c7@redhat.com>
 <87sf4rppuc.fsf@nvdebian.thelocal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sf4rppuc.fsf@nvdebian.thelocal>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2023 at 07:20:26PM +1100, Alistair Popple wrote:
> I don't like "large anon folios" because it seems to confuse collegaues
> when explaining that large anon folios are actually smaller than the
> existing Hugetlb/THP size. I suspect this is because they already assume
> large folios are used for THP. I guess this wouldn't be an issue if
> everyone assumed THP was implemented with huge folios, but that doesn't
> seem to be the case for me at least. Likely because the default THP size
> is often 2MB, which is hardly huge.

I find your colleagues confusing.  To me, "huge" seems bigger than
"large".  I don't seem to be the only one:

https://www.quora.com/What-is-the-difference-among-big-large-huge-enormous-and-giant
(for example)

Perhaps the problem is that people have turned "THP" into a thing in its
own right.  So they feel comfortable talking about small THP, medium THP
and large THP and ignoring that there's already a "huge" embedded in THP.

Now if you'll excuse me, I have to put my PIN number into the ATM machine.
