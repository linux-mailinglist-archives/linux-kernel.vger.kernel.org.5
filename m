Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 673AA7E9671
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 06:18:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232876AbjKMFSh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 00:18:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230397AbjKMFSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 00:18:35 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88E6C1735
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 21:18:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Mw5XVGZ53qHqO6W75lYP3KgdM5arMrga6Cb5+Lo7O5w=; b=jEuPH2X3TXGxfIus5MqSUUo0rE
        WbVw0o+U0Q5hXmq+HbiaQlrcdxkwZDdFRWSX1yy5UzPeVxebXs3+jWvyz3dN5OF1ExcMg8u7ZkYVt
        Fq1ePl76US38DuAlbHhjPFEwWaQ1fY3u84J/UjOdHoIDuu7txdFJsNAHja7cfk9MHYfRtcb/Cdob3
        hB28RS6D8bCKXnNBRCmv5MXJ9BQv89ucTxyUcrkIKyb5tz3AqyfJYjSLCw1nn+H4jlrajcrptNuNK
        LeiEeGoUS/gHIp54evg6FVSDhmCPJDqMRnstXRABo5Fo0EgV9eHdKHTP0ZRdYjlbbBjcg5E8RJs/6
        UZfxZZFQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1r2PKq-00CLiX-S5; Mon, 13 Nov 2023 05:18:08 +0000
Date:   Mon, 13 Nov 2023 05:18:08 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Ryan Roberts <ryan.roberts@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yin Fengwei <fengwei.yin@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Yu Zhao <yuzhao@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Itaru Kitayama <itaru.kitayama@gmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hugh Dickins <hughd@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6 0/9] variable-order, large folios for anonymous memory
Message-ID: <ZVGxkMeY50JSesaj@casper.infradead.org>
References: <20230929114421.3761121-1-ryan.roberts@arm.com>
 <c507308d-bdd4-5f9e-d4ff-e96e4520be85@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c507308d-bdd4-5f9e-d4ff-e96e4520be85@nvidia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 12, 2023 at 10:57:47PM -0500, John Hubbard wrote:
> I've done some initial performance testing of this patchset on an arm64
> SBSA server. When these patches are combined with the arm64 arch contpte
> patches in Ryan's git tree (he has conveniently combined everything
> here: [1]), we are seeing a remarkable, consistent speedup of 10.5x on
> some memory-intensive workloads. Many test runs, conducted independently
> by different engineers and on different machines, have convinced me and
> my colleagues that this is an accurate result.
> 
> In order to achieve that result, we used the git tree in [1] with
> following settings:
> 
>     echo always >/sys/kernel/mm/transparent_hugepage/enabled
>     echo recommend >/sys/kernel/mm/transparent_hugepage/anon_orders
> 
> This was on a aarch64 machine configure to use a 64KB base page size.
> That configuration means that the PMD size is 512MB, which is of course
> too large for practical use as a pure PMD-THP. However, with with these
> small-size (less than PMD-sized) THPs, we get the improvements in TLB
> coverage, while still getting pages that are small enough to be
> effectively usable.

That is quite remarkable!

My hope is to abolish the 64kB page size configuration.  ie instead of
using the mixture of page sizes that you currently are -- 64k and
1M (right?  Order-0, and order-4), that 4k, 64k and 2MB (order-0,
order-4 and order-9) will provide better performance.

Have you run any experiements with a 4kB page size?
