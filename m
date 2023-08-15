Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF8BE77D14A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 19:47:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238945AbjHORrG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 13:47:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239000AbjHORq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 13:46:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26D971BD2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 10:46:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AF7ED65313
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 17:46:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C48A2C433C8;
        Tue, 15 Aug 2023 17:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692121617;
        bh=EgN0FumDkhZ0MVW7N3arVVnjWU5cWx8JVh19S9+fGtE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WZ/UtuLePrd6cpAfJQvckif9G6ui3J5q9uxnrTGiW6p+sagXMWY1zyMd+Er9j5SJZ
         dOIqZTTcKzbcNN7+KDyRwtv5Ol3kHcYwXsgo+VZUF0/YSuyT8lOYho16xonITrro97
         LX8zZcdJ5x0KyTbzbdl7rz6zeIyzp5khg953CvdfQOjD53c1XhzpnochQCrVPDgkeb
         gnLT9V2NGSMv1+lE0dacCjCG3+xhSAV+M7PN23fgYUMB4MwHIymuhMqVGZCMAsrEoO
         j7FtFzxS86sH9ni1RRMmoeclCcIw38TQdgqLNsU7qH4cLcxv1rqf6I1FtfliEDbZAL
         Lf3bcWTVJbzNg==
Date:   Tue, 15 Aug 2023 10:46:55 -0700
From:   Chris Li <chrisl@kernel.org>
To:     Kemeng Shi <shikemeng@huaweicloud.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, baolin.wang@linux.alibaba.com,
        mgorman@techsingularity.net, david@redhat.com, willy@infradead.org
Subject: Re: [PATCH 2/2] mm/page_alloc: remove unnecessary parameter batch of
 nr_pcp_free
Message-ID: <ZNu6D+1y3agQRZgr@google.com>
References: <20230809100754.3094517-1-shikemeng@huaweicloud.com>
 <20230809100754.3094517-3-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230809100754.3094517-3-shikemeng@huaweicloud.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kemeng,

Since I am discussing the other patch in this series, I might just commend on this one
as well.

On Wed, Aug 09, 2023 at 06:07:54PM +0800, Kemeng Shi wrote:
> We get batch from pcp and just pass it to nr_pcp_free immediately. Get
> batch from pcp inside nr_pcp_free to remove unnecessary parameter batch.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> ---
>  mm/page_alloc.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 1ddcb2707d05..bb1d14e806ad 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -2376,10 +2376,10 @@ static bool free_unref_page_prepare(struct page *page, unsigned long pfn,
>  	return true;
>  }
>  
> -static int nr_pcp_free(struct per_cpu_pages *pcp, int high, int batch,
> -		       bool free_high)
> +static int nr_pcp_free(struct per_cpu_pages *pcp, int high, bool free_high)
>  {
>  	int min_nr_free, max_nr_free;
> +	int batch = READ_ONCE(pcp->batch);

Because nr_pcp_free is static and has only one caller. This function gets inlined
at the caller's side. I verified that on X86_64 compiled code.

So this fix in my opinion is not worthwhile to fix. It will produce the same
machine code. One minor side effect is that it will hide the commit under it
in "git blame".

Chris

