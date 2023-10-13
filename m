Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E3207C8875
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 17:19:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232304AbjJMPTR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 11:19:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232270AbjJMPTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 11:19:16 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FB3EBB
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 08:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jtSZR0F1KHMpVPGE+pJqe/+tO1g6GlVRmaItwdLPXhA=; b=wYWLKRI5iAPongq6yhQThdC8/k
        A4G3V5git/3R0IpNBM8V7UruHWvHlDMogoIuV1N5vXjRNNd3Su+NSthrHyI/WDQ48Flmm2fwvIdp+
        qwMx3ZrAdGp0R2roiCR9vWLoxgpoQmfNRO9T1/r7HiL3duUhP7HHoXRmmZf+INJ9gkFZj69lzBmxf
        ZCtMNc8LTdR7IqTmAsJkbJqPbeb0LXbyCChwiXRtmRTnlTxtsRK32QMRGU3O+PhWK1paBQpd8MquT
        N/9kUW1XK5aYzg1SY2a0Wuke2jH232VBCJO+dkW13NVQlsyenqMqSn//JrtkHjmnjamLv+o1R7m1+
        +cCqxIlQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qrJwQ-0064qj-0x; Fri, 13 Oct 2023 15:19:06 +0000
Date:   Fri, 13 Oct 2023 16:19:05 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ying.huang@intel.com,
        david@redhat.com, Zi Yan <ziy@nvidia.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH -next v2 18/19] mm: use folio_xchg_last_cpupid() in
 wp_page_reuse()
Message-ID: <ZSlf6fPfuOo4QmDt@casper.infradead.org>
References: <20231013085603.1227349-1-wangkefeng.wang@huawei.com>
 <20231013085603.1227349-19-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231013085603.1227349-19-wangkefeng.wang@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 13, 2023 at 04:56:02PM +0800, Kefeng Wang wrote:
> Convert to use folio_xchg_last_cpupid() in wp_page_reuse(), and remove
> page variable.

... another case where we're changing behaviour and need to argue it's
desirable.

> -	/*
> -	 * Clear the pages cpupid information as the existing
> -	 * information potentially belongs to a now completely
> -	 * unrelated process.
> -	 */
> -	if (page)
> -		page_cpupid_xchg_last(page, (1 << LAST_CPUPID_SHIFT) - 1);
> +	if (folio) {
> +		VM_BUG_ON(folio_test_anon(folio) &&
> +			  !PageAnonExclusive(vmf->page));
> +		/*
> +		 * Clear the pages cpupid information as the existing

s/pages/folio's/

> +		 * information potentially belongs to a now completely
> +		 * unrelated process.
> +		 */
> +		folio_xchg_last_cpupid(folio, (1 << LAST_CPUPID_SHIFT) - 1);
> +	}
