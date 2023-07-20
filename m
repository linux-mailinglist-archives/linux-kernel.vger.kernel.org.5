Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BC2075AA94
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 11:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbjGTJZV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 05:25:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjGTJZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 05:25:08 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8F872AA6F;
        Thu, 20 Jul 2023 02:08:02 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4R66Gx5Dn5z18LYT;
        Thu, 20 Jul 2023 17:05:45 +0800 (CST)
Received: from [10.174.151.185] (10.174.151.185) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 20 Jul 2023 17:06:30 +0800
Subject: Re: [PATCH] mm/memory-failure: fix hardware poison check in
 unpoison_memory()
To:     Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
CC:     <akpm@linux-foundation.org>, <willy@infradead.org>,
        <naoya.horiguchi@nec.com>, <stable@vger.kernel.org>
References: <20230717181812.167757-1-sidhartha.kumar@oracle.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <0f1f354b-7308-d170-d84e-3c64161be647@huawei.com>
Date:   Thu, 20 Jul 2023 17:06:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20230717181812.167757-1-sidhartha.kumar@oracle.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.151.185]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/7/18 2:18, Sidhartha Kumar wrote:
> It was pointed out[1] that using folio_test_hwpoison() is wrong
> as we need to check the indiviual page that has poison.
> folio_test_hwpoison() only checks the head page so go back to using
> PageHWPoison().
> 
> Reported-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Fixes: a6fddef49eef ("mm/memory-failure: convert unpoison_memory() to folios")
> Cc: stable@vger.kernel.org #v6.4
> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
> 
> [1]: https://lore.kernel.org/lkml/ZLIbZygG7LqSI9xe@casper.infradead.org/
> ---
>  mm/memory-failure.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 02b1d8f104d51..a114c8c3039cd 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -2523,7 +2523,7 @@ int unpoison_memory(unsigned long pfn)
>  		goto unlock_mutex;
>  	}
>  
> -	if (!folio_test_hwpoison(folio)) {
> +	if (!PageHWPoison(p)) {

For successfully handled pages, they should be non-compound pages (dissolved, splitted or normal pages).
So this patch makes no change for them. But for failed to hwpoisoned thp and hugetlb, there's some difference.
But since Naoya points out that, "the users of unpoison should know where the PageHWPoison is set via
/proc/kpageflags.", I'm fine with this patch.

Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>

Thanks.


