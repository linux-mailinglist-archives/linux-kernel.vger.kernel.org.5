Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F520756872
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 17:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbjGQP4u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 11:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjGQP4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 11:56:49 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B893A4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 08:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6rAKK+wxmLyxeZyfI3ZVNCD6IgYLEheT+1mkWcIo2/E=; b=ITVsMo0EZxjDbPwjtXY0q+QtNZ
        8gbl3PWmF5+IAR7w4w6H/Gm41zQRpOUIsLgchJsvXLJWhrsKhMLpwnQXdX0BARLpbAMWtIR17mf81
        8k+cba7QIun/PJbpMWeoaAwIIUKrROId6C/qlmcLannc8zhoMZvyimfHHtEpuET30xRPmWtZGXd2u
        RwVigIm0cdATeKOSJWBU68QowMBRC5VxWg2pGk/5mtMRGvqehERugmOLbJN9UezYwClx1ybGqWBDN
        YiywyLAo9rq7PVwrkpZ06ocNdso53hQsS76UHy5ZMiWv+drZ/tPxYZNWvFHsDcJLaDvdo2vw6kPEf
        y/xeajcA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qLQaX-0043ax-Dg; Mon, 17 Jul 2023 15:56:41 +0000
Date:   Mon, 17 Jul 2023 16:56:41 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Ryan Roberts <ryan.roberts@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Yin Fengwei <fengwei.yin@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Yu Zhao <yuzhao@google.com>, Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v1 2/3] mm: Implement folio_remove_rmap_range()
Message-ID: <ZLVkucGl88vxEuIu@casper.infradead.org>
References: <20230717143110.260162-1-ryan.roberts@arm.com>
 <20230717143110.260162-3-ryan.roberts@arm.com>
 <ZLVZTupQXt7pAqt8@casper.infradead.org>
 <adac1493-da6d-4581-b8b1-e5911b68cdd7@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adac1493-da6d-4581-b8b1-e5911b68cdd7@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17, 2023 at 04:49:19PM +0100, Ryan Roberts wrote:
> > We're still doing one atomic op per page on the folio's nr_pages_mapped
> > ... is it possible to batch this and use atomic_sub_return_relaxed()?
> 
> Good spot, something like this:
> 
> 	} else {
> 		for (; nr != 0; nr--, page++) {
> 			/* Is this the page's last map to be removed? */
> 			last = atomic_add_negative(-1, &page->_mapcount);
> 			if (last)
> 				nr_unmapped++;
> 		}
> 
> 		/* Pages still mapped if folio mapped entirely */
> 		nr_mapped = atomic_sub_return_relaxed(nr_unmapped, mapped);
> 		if (nr_mapped >= COMPOUND_MAPPED)
> 			nr_unmapped = 0;
> 	}

I think that's right, but my eyes always go slightly crossed trying to
read the new mapcount scheme.
