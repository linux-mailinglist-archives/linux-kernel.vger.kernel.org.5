Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65B7B78BD64
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 05:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233230AbjH2Dz0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 23:55:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232427AbjH2DzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 23:55:01 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F12E9CA
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 20:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=yMp/x0VkYc4Zey0ZBUSOtAzI93FMpN6TFWN2LIHdEJE=; b=qypBG82ZV9M0XDWrHKOlbg32hU
        KNKkDitRDRncUwYGh6LLomwMy1xG/GauQy2CdkKZhiXAR/swhmQvMa9FiCsNEKWdjOn53xjCMqmkc
        J+1TJqp9gZ1D0G5EcmOTA6ekok/GPTYgXRSHNzWeJYLzuX3z1SRUYFiYQbHXSRYHPP25BOU21NKKq
        Xf+YJ9484pEQ6U7zfyqVDSVAw4d+4WeaK3+pRt9vzSUxcc2vCc1vuIjsa7weh6a3PWAp1GPtBxHzm
        hMIjwoLCx9VWMDAg6F3VbN0zsGgPmcGfOHVMgRLNS4MxhvLzlX7LCiIrYsnaySQ12nP18oI5kK7vp
        rFq0WIqA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qapoU-004JpN-OL; Tue, 29 Aug 2023 03:54:46 +0000
Date:   Tue, 29 Aug 2023 04:54:46 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Kemeng Shi <shikemeng@huaweicloud.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, baolin.wang@linux.alibaba.com,
        mgorman@techsingularity.net, david@redhat.com
Subject: Re: [PATCH v2 7/7] mm/compaction: factor out code to test if we
 should run compaction for target order
Message-ID: <ZO1sBjE+1n3FQLbX@casper.infradead.org>
References: <20230826153617.4019189-1-shikemeng@huaweicloud.com>
 <20230826153617.4019189-8-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230826153617.4019189-8-shikemeng@huaweicloud.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 26, 2023 at 11:36:17PM +0800, Kemeng Shi wrote:
> +		if (compaction_suit_allocation_order(zone,
> +				pgdat->kcompactd_max_order,
> +				highest_zoneidx, ALLOC_WMARK_MIN) ==
> +				COMPACT_CONTINUE)

The indentation is confusing here.  It looks like COMPACT_CONTINUE is
an argument of compaction_suit_allocation_order().  How about:

		ret = compaction_suit_allocation_order(zone,
				pgdat->kcompactd_max_order,
				highest_zoneidx, ALLOC_WMARK_MIN);
		if (ret == COMPACT_CONTINUE)

(assuming there's a handy variable called ret)

You could also distinguih it by indenting COMPACT_CONTINUE by an
extra tab, but I think it's worth an extra variable just because this is
such a long line.

> +		if (compaction_suit_allocation_order(zone,
> +				cc.order, zoneid, ALLOC_WMARK_MIN) !=
> +				COMPACT_CONTINUE)
>  			continue;

Same here.
