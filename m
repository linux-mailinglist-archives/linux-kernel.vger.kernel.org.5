Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49AEE7E8215
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:57:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345082AbjKJS5Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 13:57:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbjKJS5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 13:57:11 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ECF5357AA
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 10:19:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ZMzOaie4lywyOPf2qJYwfQniWHJ785xzMVX7+oeUO70=; b=V1/+fRC4D72zEHzXEcZAduUdd1
        pb1y7v9rAMDlrrgMItIiW3TYe9rOF8vvJFo/g5sdeXUlNJEftP9ynKZ5JXZ14nEhvlI9z48e/IYRz
        NtP/pR30g/6aZwFqEzDhQPMiZwmMCTRlNB5nlaIGvh8A+Sj/JgD64+DkAzCPm7UnFP2Ict7r2gLf+
        pw15c6cCj5FUGBPRNcCaSJZEoL7pnNYgjSra9nNPzvhghugr/9u6e0xkyuXApbXois2WzbrViiuUn
        mQ+pjwy81BB9gCPf5ADmwHiv1BW86pB3tnV9RQPWrV/e/4CBQ+l+QZccPF7OXRtE4uu77H8AtI0zk
        Nht54HBw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1r1W69-00EtFN-4N; Fri, 10 Nov 2023 18:19:17 +0000
Date:   Fri, 10 Nov 2023 18:19:17 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        David Hildenbrand <david@redhat.com>,
        Gregory Price <gregory.price@memverge.com>
Subject: Re: [PATCH v2 3/7] fs/proc/page: respect folio head-page flag
 placement
Message-ID: <ZU50JT0OVdAh9q5W@casper.infradead.org>
References: <20231110033324.2455523-1-wangkefeng.wang@huawei.com>
 <20231110033324.2455523-4-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231110033324.2455523-4-wangkefeng.wang@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 10, 2023 at 11:33:20AM +0800, Kefeng Wang wrote:
> kpageflags reads page-flags directly from the page, even when the
> respective flag is only updated on the headpage of a folio.
> 
> Since most flags are stored in head flags, make k = folio->flags,
> and add new p = page->flags used for per-page flags.

You'd do better to steal Greg's commit message.

> Originally-from: Gregory Price <gregory.price@memverge.com>
> Suggested-by: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>

> @@ -202,7 +202,7 @@ u64 stable_page_flags(struct page *page)
>  	u |= kpf_copy_bit(k, KPF_MLOCKED,	PG_mlocked);
>  
>  #ifdef CONFIG_MEMORY_FAILURE
> -	u |= kpf_copy_bit(k, KPF_HWPOISON,	PG_hwpoison);
> +	u |= kpf_copy_bit(p, KPF_HWPOISON,	PG_hwpoison);

This is correct.

> @@ -211,13 +211,13 @@ u64 stable_page_flags(struct page *page)
>  
>  	u |= kpf_copy_bit(k, KPF_RESERVED,	PG_reserved);
>  	u |= kpf_copy_bit(k, KPF_MAPPEDTODISK,	PG_mappedtodisk);
> -	u |= kpf_copy_bit(k, KPF_PRIVATE,	PG_private);
> -	u |= kpf_copy_bit(k, KPF_PRIVATE_2,	PG_private_2);
> -	u |= kpf_copy_bit(k, KPF_OWNER_PRIVATE,	PG_owner_priv_1);
> +	u |= kpf_copy_bit(p, KPF_PRIVATE,	PG_private);
> +	u |= kpf_copy_bit(p, KPF_PRIVATE_2,	PG_private_2);
> +	u |= kpf_copy_bit(p, KPF_OWNER_PRIVATE,	PG_owner_priv_1);

This is not.  PG_private is not, I believe, set on tail pages.
Ditto the other two.  If you know differently ... ?

>  #ifdef CONFIG_ARCH_USES_PG_ARCH_X
> -	u |= kpf_copy_bit(k, KPF_ARCH_2,	PG_arch_2);
> -	u |= kpf_copy_bit(k, KPF_ARCH_3,	PG_arch_3);
> +	u |= kpf_copy_bit(p, KPF_ARCH_2,	PG_arch_2);
> +	u |= kpf_copy_bit(p, KPF_ARCH_3,	PG_arch_3);
>  #endif

I also don't think this is correct, but there are many uses of
PG_arch* and I may have missed something.
