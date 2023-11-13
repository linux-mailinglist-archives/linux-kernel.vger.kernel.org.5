Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86FC27EA2DA
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 19:30:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231519AbjKMSa5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 13:30:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbjKMSaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 13:30:55 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBD0A10EC
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 10:30:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=MHY5DgRsGlef0gPl4g05l9qLDqCoWUNy1TAlPD0LkNg=; b=jIXR0VxMBYaxT4FZjUlh/ah+Mc
        8YG9RNZ0biVkigNeUCTjla2ktm4jdMGXLBDygyIiNq/bvROgLOse1rYvU6MUbOD5X8XP5fSmv7w69
        +vVDY4mGqC1LBYoP7EL0SStRmGkbX9QQTlT2fBNwuVRIULs6OBBx5wREUtXHfoyiZBahXVNE7qpF5
        M6u7oBAYD2wCwizYnyM9wV3dVgZrM9Nuruihyutyl5q2ItLNHBuvfRVNauOldRoU4UtBv/F3YZFSS
        Y8zyikH8upeDkcKuCwvRvEwc9sKYewpFUxxyUg0aeOSHRQkQEkAqjW2UxS2JximD+DKtH01KUrPJW
        sZMLgDkw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1r2bhk-00Fmtf-Tu; Mon, 13 Nov 2023 18:30:37 +0000
Date:   Mon, 13 Nov 2023 18:30:36 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Zi Yan <ziy@nvidia.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Huang, Ying" <ying.huang@intel.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        "Yin, Fengwei" <fengwei.yin@intel.com>,
        Yu Zhao <yuzhao@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Kemeng Shi <shikemeng@huaweicloud.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Rohan Puri <rohan.puri15@gmail.com>,
        Mcgrof Chamberlain <mcgrof@kernel.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: Re: [PATCH v1 1/4] mm/compaction: enable compacting >0 order folios.
Message-ID: <ZVJrTEDRzjIfL7kq@casper.infradead.org>
References: <20231113170157.280181-1-zi.yan@sent.com>
 <20231113170157.280181-2-zi.yan@sent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231113170157.280181-2-zi.yan@sent.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 13, 2023 at 12:01:54PM -0500, Zi Yan wrote:
> +	/* this makes migrate_pages() split the source page and retry */
> +	if (folio_order(src) > 0)
> +		return NULL;

Nit: folio_test_large() is more efficient than folio_order() > 0.
The former simply tests the bit, while the second tests the bit, then
loads folio->_order to check it's >0.  We know it will be, but there's
no way to tell gcc that if the bit is set, this value is definitely not 0.
