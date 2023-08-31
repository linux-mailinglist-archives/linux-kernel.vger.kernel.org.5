Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 798DF78ED12
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 14:29:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346244AbjHaM3t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 08:29:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231799AbjHaM3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 08:29:49 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 817B719A
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 05:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BTmtDO+xBZOfoQMGxZ2QpE27NcKVMjWoTS63e1aA26k=; b=jAhYpYq95b8S5ZQX9DMO8BVPEE
        BK5PM8iV2xU7p3qYU8bQn7a+iGSAI6iSCeA+soBPAYbx1mtfJQNqMmzs+f/SvbqUHbgq1jZ4m6Fdd
        4398M+N049JigIdBj7+tH0A5SHgugl56okhVuoHt3OxbPZAAeD5HYy3J2cBESDiatT4GFnnqx5iEX
        duGznyfgDRqTqmz+YQNRibyuBwICNagI+O+ABmeUwHXvljcY2uAcyhOslLi+dSdKy44yz4hDYOWvd
        BuMz+MjcsiM9k4jbIs2kbRRzPTFS5A8FxFfGn6ps3HruAH0Fwqm6UtXRW/p3QBg+nRUksQFMZGO0j
        PoLA0KgA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qbgnc-001HfL-Um; Thu, 31 Aug 2023 12:29:25 +0000
Date:   Thu, 31 Aug 2023 13:29:24 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     "Huang, Ying" <ying.huang@intel.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yin Fengwei <fengwei.yin@intel.com>,
        Yu Zhao <yuzhao@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>, Zi Yan <ziy@nvidia.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Itaru Kitayama <itaru.kitayama@gmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 3/5] mm: LARGE_ANON_FOLIO for improved performance
Message-ID: <ZPCHpOtYgq32leay@casper.infradead.org>
References: <20230810142942.3169679-1-ryan.roberts@arm.com>
 <20230810142942.3169679-4-ryan.roberts@arm.com>
 <87v8dg6lfu.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <5c9ba378-2920-4892-bdf0-174e47d528b7@arm.com>
 <87cyz43s63.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <4e14730b-4e4c-de30-04bb-9f3ec4a93754@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e14730b-4e4c-de30-04bb-9f3ec4a93754@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 31, 2023 at 09:57:46AM +0200, David Hildenbrand wrote:
> As raised in another mail, we can then discuss
> * how we want to call this feature (transparent large pages? there is
>   the concern that "THP" might confuse users. Maybe we can consider
>   "large" the more generic version and "huge" only PMD-size, TBD)
> * how to expose it in stats towards the user (e.g., /proc/meminfo)
> * which minimal toggles we want
> 
> I think there *really* has to be a way to disable it for a running system,
> otherwise no distro will dare pulling it in, even after we figured out the
> other stuff.
> 
> Note that for the pagecache, large folios can be disabled and distributions
> are actively making use of that.

You can't.  Well, you can for shmem/tmpfs, but you have to edit the
source code or disable CONFIG_TRANSPARENT_HUGEPAGE to disable it for XFS.
