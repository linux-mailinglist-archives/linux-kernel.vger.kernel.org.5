Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA0AA78DD6C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243831AbjH3St4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242202AbjH3H0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 03:26:22 -0400
Received: from out-248.mta0.migadu.com (out-248.mta0.migadu.com [IPv6:2001:41d0:1004:224b::f8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 789B7CC9
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 00:26:19 -0700 (PDT)
Message-ID: <8e298c9f-1ef3-5c99-d7b5-47fd6703cf83@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1693380377;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UQ1Q28mUI4wAI7dYMunCxPxgjzO360+MZ42FSzQKfTM=;
        b=ssplN9k4AtK5wKKEk1JHLy0iSy3Eoap8VcOCw6gIM/h86ywKqNdgpyoSvBaNis1cwJtQ9P
        3dKUhyFLmlhL3UGh5vVPDfdecvvUxkeX1N5Rrz5YlBRHSQ33jw8qRdZ24ieJcKPz0bqyH1
        U2F2pQdVJOWv7SibFk0ksf/8FOGuYsA=
Date:   Wed, 30 Aug 2023 15:26:11 +0800
MIME-Version: 1.0
Subject: Re: [PATCH 09/12] hugetlb_vmemmap: Optimistically set Optimized flag
To:     Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Rientjes <rientjes@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Xiongchun Duan <duanxiongchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20230825190436.55045-1-mike.kravetz@oracle.com>
 <20230825190436.55045-10-mike.kravetz@oracle.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20230825190436.55045-10-mike.kravetz@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/8/26 03:04, Mike Kravetz wrote:
> At the beginning of hugetlb_vmemmap_optimize, optimistically set
> the HPageVmemmapOptimized flag in the head page.  Clear the flag
> if the operation fails.
>
> No change in behavior.  However, this will become important in
> subsequent patches where we batch delay TLB flushing.  We need to
> make sure the content in the old and new vmemmap pages are the same.

Sorry, I didn't get the point here. Could you elaborate it?

>
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> ---
>   mm/hugetlb_vmemmap.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
> index e390170c0887..500a118915ff 100644
> --- a/mm/hugetlb_vmemmap.c
> +++ b/mm/hugetlb_vmemmap.c
> @@ -566,7 +566,9 @@ static void __hugetlb_vmemmap_optimize(const struct hstate *h,
>   	if (!vmemmap_should_optimize(h, head))
>   		return;
>   
> +	/* Optimistically assume success */
>   	static_branch_inc(&hugetlb_optimize_vmemmap_key);
> +	SetHPageVmemmapOptimized(head);
>   
>   	vmemmap_end	= vmemmap_start + hugetlb_vmemmap_size(h);
>   	vmemmap_reuse	= vmemmap_start;
> @@ -577,10 +579,10 @@ static void __hugetlb_vmemmap_optimize(const struct hstate *h,
>   	 * to the page which @vmemmap_reuse is mapped to, then free the pages
>   	 * which the range [@vmemmap_start, @vmemmap_end] is mapped to.
>   	 */
> -	if (vmemmap_remap_free(vmemmap_start, vmemmap_end, vmemmap_reuse, bulk_pages))
> +	if (vmemmap_remap_free(vmemmap_start, vmemmap_end, vmemmap_reuse, bulk_pages)) {
>   		static_branch_dec(&hugetlb_optimize_vmemmap_key);
> -	else
> -		SetHPageVmemmapOptimized(head);
> +		ClearHPageVmemmapOptimized(head);
> +	}
>   }
>   
>   /**

