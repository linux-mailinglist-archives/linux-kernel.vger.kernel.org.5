Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EE6A75A3C3
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 03:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbjGTBKH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 21:10:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjGTBKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 21:10:06 -0400
Received: from out-5.mta0.migadu.com (out-5.mta0.migadu.com [IPv6:2001:41d0:1004:224b::5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8B031FCD
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 18:10:04 -0700 (PDT)
Date:   Thu, 20 Jul 2023 10:09:53 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1689815400;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=m/woi+iwth7PiSnAVGWtu7ZbwG0Aj9umjdxvpP67I5M=;
        b=wijwoG3JIlea8iJ8xMSNk15XuZBsckN2GbuhsO9bDBj+IWmsq+3XexHW9EYwVqcwmdOF3C
        uxzxUVTe/Uor8+ZBA1QwBMzPMwEEAptoZzV4J3nQ0RBAr9CJMZi3e6e5RRzCAO6tjXHCBv
        h9O/UsItgL3ocPftMYET+B6K+al/pL0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Naoya Horiguchi <naoya.horiguchi@linux.dev>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, naoya.horiguchi@nec.com,
        shy828301@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] mm: memory-failure: add PageOffline() check
Message-ID: <20230720010953.GC1583723@ik1-406-35019.vs.sakura.ne.jp>
References: <20230715031729.2420338-1-linmiaohe@huawei.com>
 <20230715031729.2420338-5-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230715031729.2420338-5-linmiaohe@huawei.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 15, 2023 at 11:17:29AM +0800, Miaohe Lin wrote:
> Memory failure is not interested in logically offlined page. Skip this
> type of pages.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  mm/memory-failure.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 42e63b0ab5f7..ed79b69837de 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -1559,7 +1559,7 @@ static bool hwpoison_user_mappings(struct page *p, unsigned long pfn,
>  	 * Here we are interested only in user-mapped pages, so skip any
>  	 * other types of pages.
>  	 */
> -	if (PageReserved(p) || PageSlab(p) || PageTable(p))
> +	if (PageReserved(p) || PageSlab(p) || PageTable(p) || PageOffline(p))

hwpoison_user_mappings() is called after some checks are done, so I'm not
sure that it's the right place to check PageOffline().
We could check it before setting PageHWPoison() as we do at the beginning of
memory_failure() around pfn_to_online_page().  Does it make sense?

Thanks,
Naoya Horiguchi

>  		return true;
>  	if (!(PageLRU(hpage) || PageHuge(p)))
>  		return true;
> @@ -2513,7 +2513,8 @@ int unpoison_memory(unsigned long pfn)
>  		goto unlock_mutex;
>  	}
>  
> -	if (folio_test_slab(folio) || PageTable(&folio->page) || folio_test_reserved(folio))
> +	if (folio_test_slab(folio) || PageTable(&folio->page) ||
> +	    folio_test_reserved(folio) || PageOffline(&folio->page))
>  		goto unlock_mutex;
>  
>  	/*
> -- 
> 2.33.0
> 
> 
> 
