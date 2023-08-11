Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3037D778589
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 04:38:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbjHKCiz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 22:38:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjHKCiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 22:38:54 -0400
Received: from out-106.mta0.migadu.com (out-106.mta0.migadu.com [91.218.175.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41F432D48
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 19:38:53 -0700 (PDT)
Message-ID: <d7c3d17b-1181-cdbc-0a6d-76347fa9028c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1691721531;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f0UWXP0oSE67vFnh9XOEDFZVA8Iyap9YePKn5P2Rhhw=;
        b=ThcjeZnfx8DIGxXHHN4A1Vixa/7OFrsqcjxoMNsz6gw1jf8Gy5bzrLWBpHvkLj9/pyp6Hg
        3P/edRVUySdVUYBvRue5gOxVM5FfP6iL6HNMwcnUp1Lch9NdDLzwW80pa07b6DPYfy9NEp
        ImydhBaWsOb9/SvnwjKSxkTPFYibm1Q=
Date:   Fri, 11 Aug 2023 10:38:39 +0800
MIME-Version: 1.0
Subject: Re: [PATCH] arm64: mm: use ptep_clear() instead of pte_clear() in
 clear_flush()
Content-Language: en-US
To:     catalin.marinas@arm.com, will@kernel.org,
        akpm@linux-foundation.org, pasha.tatashin@soleen.com,
        muchun.song@linux.dev, wangkefeng.wang@huawei.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230810093241.1181142-1-qi.zheng@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <20230810093241.1181142-1-qi.zheng@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


I wrote wrong Kefeng's email address before, correct it now.


On 2023/8/10 17:32, Qi Zheng wrote:
> From: Qi Zheng <zhengqi.arch@bytedance.com>
> 
> In clear_flush(), the original pte may be a present entry, so we should
> use ptep_clear() to let page_table_check track the pte clearing operation,
> otherwise it may cause false positive in subsequent set_pte_at().
> 
> Fixes: 42b2547137f5 ("arm64/mm: enable ARCH_SUPPORTS_PAGE_TABLE_CHECK")
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> ---
>   arch/arm64/mm/hugetlbpage.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
> index 21716c940682..9c52718ea750 100644
> --- a/arch/arm64/mm/hugetlbpage.c
> +++ b/arch/arm64/mm/hugetlbpage.c
> @@ -236,7 +236,7 @@ static void clear_flush(struct mm_struct *mm,
>   	unsigned long i, saddr = addr;
>   
>   	for (i = 0; i < ncontig; i++, addr += pgsize, ptep++)
> -		pte_clear(mm, addr, ptep);
> +		ptep_clear(mm, addr, ptep);
>   
>   	flush_tlb_range(&vma, saddr, addr);
>   }
