Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D3C575A2EF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 01:49:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbjGSXtI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 19:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbjGSXtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 19:49:07 -0400
Received: from out-31.mta0.migadu.com (out-31.mta0.migadu.com [IPv6:2001:41d0:1004:224b::1f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC4D110CC
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 16:49:00 -0700 (PDT)
Date:   Thu, 20 Jul 2023 08:48:51 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1689810539;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=syvfTk4Dwy2SNCCHiR6ypoxjlZnkHSELyWQn5gr7mrA=;
        b=R9ofCcUVk9rkeed6QkHRQY5OOufYCQu+YUWvZZqSw2tyHFqgz7kau/VDncMWqXyrEMrYNo
        pqxwoTe0SRpgzI/KDU3M+ddMMMoO+Msvq9hBhUewmjj77t6Df/hFQXq721tww2WdgtYxaF
        h7AjvdzowRZfLnYDhuhB2rAbQx83/HI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Naoya Horiguchi <naoya.horiguchi@linux.dev>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, naoya.horiguchi@nec.com,
        shy828301@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] mm: memory-failure: fix potential unexpected return
 value from unpoison_memory()
Message-ID: <20230719234851.GA1583723@ik1-406-35019.vs.sakura.ne.jp>
References: <20230715031729.2420338-1-linmiaohe@huawei.com>
 <20230715031729.2420338-3-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230715031729.2420338-3-linmiaohe@huawei.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 15, 2023 at 11:17:27AM +0800, Miaohe Lin wrote:
> If unpoison_memory() fails to clear page hwpoisoned flag, return value
> ret is expected to be -EBUSY. But when get_hwpoison_page() returns 1
> and fails to clear page hwpoisoned flag due to races, return value will
> be unexpected 1 leading to users being confused.

Thank you for fixing this.

> 
> Fixes: bf181c582588 ("mm/hwpoison: fix unpoison_memory()")
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  mm/memory-failure.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 9ab97016877e..ac074f82f5b3 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -2546,11 +2546,11 @@ int unpoison_memory(unsigned long pfn)
>  			unpoison_pr_info("Unpoison: failed to grab page %#lx\n",
>  					 pfn, &unpoison_rs);
>  	} else {
> +		ret = -EBUSY;

It seems be a code smell to me that the variable "ret" is used not only to
save the return value of unpoison_memory(), but also to save the return
value from get_hwpoison_page(). So I think that it might be better to use
another auto-variable solely to save the return value of get_hwpoison_page.
Then ret has the initial value -EBUSY at this point and no need to
reinitialize it.

Thanks,
Naoya Horiguchi

>  		if (PageHuge(p)) {
>  			huge = true;
>  			count = folio_free_raw_hwp(folio, false);
>  			if (count == 0) {
> -				ret = -EBUSY;
>  				folio_put(folio);
>  				goto unlock_mutex;
>  			}
> -- 
> 2.33.0
> 
> 
> 
