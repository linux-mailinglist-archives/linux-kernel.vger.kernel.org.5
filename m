Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92A7A7E916F
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 16:31:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231500AbjKLPbU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 10:31:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbjKLPbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 10:31:17 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B71FF26A4;
        Sun, 12 Nov 2023 07:31:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zUEpPvccKq1228cqSGVqzulj2S9OqfksLKj73WE+Ea8=; b=fwDKDwerXQt+5I6Oq5CpT5NEV6
        dIODJwyfSfESZ1FA0Upu3ke9D3NTr4V+Bya/Eo8ivD6t1FCzZJnbWrHsyRoG24PeDhWg5jX5VdH7l
        8JeQphD7K59GH0q9VKSxGwsE7RbSD+aXXjb75XPuIV4cGuLxjaS+nolKvDA+7wH3nwFgENlmFsqE6
        fsOOqIOZqy/Nuh3fC+J/WJqM2fO84CsWHTnjFOI+VUP0ZCTZeQWZrlgBhfWSdh5QJOw/cDBN5bpWq
        z/PrfJjs/ajEJ8GorbuEQHVgU6C8BOJUE54IIEIZLbgPJtVC7w7DpAaK8kRP4jWEF+WN1nec7RwTw
        kbFN5gjw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1r2CQY-008nil-SV; Sun, 12 Nov 2023 15:31:10 +0000
Date:   Sun, 12 Nov 2023 15:31:10 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     "shiqiang.deng" <shiqiang.deng213@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] test_ida: Fix compilation errors
Message-ID: <ZVDvvpuD98G+oioL@casper.infradead.org>
References: <20231112070840.327190-1-shiqiang.deng213@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231112070840.327190-1-shiqiang.deng213@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 12, 2023 at 03:08:40PM +0800, shiqiang.deng wrote:
> In lib/test_ida.c, we found that IDA_BUG_ON
> uses the ida_dump() function. When __ Kernel__ is not defined,
> a missing-prototypes error will occur during compilation.
> Fix it now.

I'm confused.  What were you doing to get this error?

> Signed-off-by: shiqiang.deng <shiqiang.deng213@gmail.com>
> ---
>  include/linux/idr.h | 4 ++++
>  lib/idr.c           | 2 +-
>  2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/idr.h b/include/linux/idr.h
> index a0dce14090a9..e091efdc0cf7 100644
> --- a/include/linux/idr.h
> +++ b/include/linux/idr.h
> @@ -109,6 +109,10 @@ static inline void idr_set_cursor(struct idr *idr, unsigned int val)
>  #define idr_unlock_irqrestore(idr, flags) \
>  				xa_unlock_irqrestore(&(idr)->idr_rt, flags)
>  
> +#ifndef __KERNEL__
> +void ida_dump(struct ida *ida);
> +#endif
> +
>  void idr_preload(gfp_t gfp_mask);
>  
>  int idr_alloc(struct idr *, void *ptr, int start, int end, gfp_t);
> diff --git a/lib/idr.c b/lib/idr.c
> index 13f2758c2377..66d0c6e30588 100644
> --- a/lib/idr.c
> +++ b/lib/idr.c
> @@ -589,7 +589,7 @@ static void ida_dump_entry(void *entry, unsigned long index)
>  	}
>  }
>  
> -static void ida_dump(struct ida *ida)
> +void ida_dump(struct ida *ida)
>  {
>  	struct xarray *xa = &ida->xa;
>  	pr_debug("ida: %p node %p free %d\n", ida, xa->xa_head,
> -- 
> 2.30.0
> 
