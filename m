Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EA75754697
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 05:42:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbjGODmY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 23:42:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjGODmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 23:42:23 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DFB110EA
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 20:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=yKjL48l7aPRw8IocgRlVRY32V+vRxNKJ9cdRkCWL6qw=; b=P/pMrUwn5P9Y9d44vXU4s64xqn
        BgNAcSxwdu1J7hdcFr3BjWrO2ghT2IqrRnE4doa/NqWIZ/J0V4oYz6Ye2DH5MtI/u8WyZFfPfoC91
        hNogEZnp4Oxya0+y/OQoCUMrIQfUdwaKfFBblKAkx4CnMgMphIpfYPEZoCUR++BdKjswJJWKXfnqh
        sU7eQJ5T4zsfC3q4qMPjKReOCKxek7xt4sD+smSPs7beK6OO7iFelmM4Sr2fcuAXn3Lh3b1CHjqRW
        DVZAIcNPceUHWSO2lUSyy1xI2ZY6y5ijetd8lLv3f2uD2wNtla9ZuM57jct1pLcDWs2fFBIVqu/Az
        OJYLOvaA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qKWAf-001nAv-9W; Sat, 15 Jul 2023 03:42:13 +0000
Date:   Sat, 15 Jul 2023 04:42:13 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Yosry Ahmed <yosryahmed@google.com>,
        Christoph Hellwig <hch@infradead.org>,
        Nhat Pham <nphamcs@gmail.com>,
        Domenico Cerasuolo <cerasuolodomenico@gmail.com>,
        konrad.wilk@oracle.com, vitaly.wool@konsulko.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: kill frontswap
Message-ID: <ZLIVleBYOm4HIGTZ@casper.infradead.org>
References: <20230714194610.828210-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230714194610.828210-1-hannes@cmpxchg.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 14, 2023 at 03:46:08PM -0400, Johannes Weiner wrote:
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 62195f72bf56..1b0128060792 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -2,7 +2,7 @@
>  /*
>   * zswap.c - zswap driver file
>   *
> - * zswap is a backend for frontswap that takes pages that are in the process
> + * zswap is a cache that takes pages that are in the process
>   * of being swapped out and attempts to compress and store them in a
>   * RAM-based memory pool.  This can result in a significant I/O reduction on
>   * the swap device and, in the case where decompressing from RAM is faster
> @@ -20,7 +20,6 @@
>  #include <linux/spinlock.h>
>  #include <linux/types.h>
>  #include <linux/atomic.h>
> -#include <linux/frontswap.h>
>  #include <linux/rbtree.h>
>  #include <linux/swap.h>
>  #include <linux/crypto.h>

To make this patch compile, I had to add zswap.h to the include list.

