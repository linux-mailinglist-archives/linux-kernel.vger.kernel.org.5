Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 335A4771862
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 04:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbjHGCg5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Aug 2023 22:36:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjHGCg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Aug 2023 22:36:56 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE63C97
        for <linux-kernel@vger.kernel.org>; Sun,  6 Aug 2023 19:36:54 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RK0mc5Hr8z1KCKd;
        Mon,  7 Aug 2023 10:35:44 +0800 (CST)
Received: from [10.174.151.185] (10.174.151.185) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 7 Aug 2023 10:36:52 +0800
Subject: Re: [PATCH v2] mm/mm_init: use helper macro BITS_PER_LONG and
 BITS_PER_BYTE
To:     <akpm@linux-foundation.org>, <rppt@kernel.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20230807023247.308414-1-linmiaohe@huawei.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <d9c91c2b-cdd9-e4c9-9790-1d4276895430@huawei.com>
Date:   Mon, 7 Aug 2023 10:36:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20230807023247.308414-1-linmiaohe@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.151.185]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/8/7 10:32, Miaohe Lin wrote:
> It's more readable to use helper macro BITS_PER_LONG and BITS_PER_BYTE.
> No functional change intended.
> 

I forgot to collect the Reviewed-by tag and resend one. Sorry for make noise.

> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
> v2:
>   use BITS_PER_BYTE per Mike. Thanks.
> ---
>  mm/mm_init.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/mm_init.c b/mm/mm_init.c
> index 66aca3f6accd..93b1febd4a32 100644
> --- a/mm/mm_init.c
> +++ b/mm/mm_init.c
> @@ -79,7 +79,7 @@ void __init mminit_verify_pageflags_layout(void)
>  	int shift, width;
>  	unsigned long or_mask, add_mask;
>  
> -	shift = 8 * sizeof(unsigned long);
> +	shift = BITS_PER_LONG;
>  	width = shift - SECTIONS_WIDTH - NODES_WIDTH - ZONES_WIDTH
>  		- LAST_CPUPID_SHIFT - KASAN_TAG_WIDTH - LRU_GEN_WIDTH - LRU_REFS_WIDTH;
>  	mminit_dprintk(MMINIT_TRACE, "pageflags_layout_widths",
> @@ -1431,9 +1431,9 @@ static unsigned long __init usemap_size(unsigned long zone_start_pfn, unsigned l
>  	usemapsize = roundup(zonesize, pageblock_nr_pages);
>  	usemapsize = usemapsize >> pageblock_order;
>  	usemapsize *= NR_PAGEBLOCK_BITS;
> -	usemapsize = roundup(usemapsize, 8 * sizeof(unsigned long));
> +	usemapsize = roundup(usemapsize, BITS_PER_LONG);
>  
> -	return usemapsize / 8;
> +	return usemapsize / BITS_PER_BYTE;
>  }
>  
>  static void __ref setup_usemap(struct zone *zone)
> 

