Return-Path: <linux-kernel+bounces-81123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91ED5867085
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 11:20:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F76A1F2B2B7
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA6845336F;
	Mon, 26 Feb 2024 09:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="FwzPtilE"
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED0C52F8F
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 09:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708941584; cv=none; b=Mb7szJBOBIRoibTC56Qyq0oTVlYCLdQNlA8raOUEyJgxRTXvmW5qGUY7zrzqHrB6+mygHmdnyIN2zogpTPbU6YAtKIJtFI5+GPUPkYdee1Gc/np+HxR3Agr/wKa2oW8VDGylWV3S8Qvl7n1AZO4/Yd0Ef2iAAsmZbNHzEShWHHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708941584; c=relaxed/simple;
	bh=NbcJIQ6YYumQeXmUBBsEZnRlGvlqBA09BuKqxSIsv8g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bJu8hostXp434Zx8IGEt6XAEciIy1e629I5LdwHQ99XFFO2m26uBdJdMJ+2kBudIpewJPCmAcgSQErTBFx9IN2IUS5M+p9TLiJuXQ3sVcAUaX/ueLNAvBsn5XoViHcLDzk1k7le17xC5aJLgFVMDXrNskxLxlY7BQzOLPZ3iAIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=FwzPtilE; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1708941579; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=U3Y9+BuA9RX74PXr7GyTAAvmUXsvUnfoxwYUqPDTdvc=;
	b=FwzPtilE6UbMmAD1qpWUfNCoWULBRosQZIpkVrBcDd7YI3kepd9L4ziLsrqMiJPMQik0jieTaHE6trMJFn7x4kdnkVPMGZk36aEwpFPaAjmSZuFtLjFi1vwwaAZR0WtvZ96LofFuhACndqgX5nhVSoGWXIDjWm96srWeCPfX864=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W1GlKCY_1708941577;
Received: from 30.97.56.44(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W1GlKCY_1708941577)
          by smtp.aliyun-inc.com;
          Mon, 26 Feb 2024 17:59:38 +0800
Message-ID: <e3aac0fc-458f-4453-86a6-1bf92dc5fbd0@linux.alibaba.com>
Date: Mon, 26 Feb 2024 17:59:37 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/3] mm: hugetlb: make the hugetlb migration strategy
 consistent
To: Oscar Salvador <osalvador@suse.de>
Cc: akpm@linux-foundation.org, muchun.song@linux.dev, david@redhat.com,
 linmiaohe@huawei.com, naoya.horiguchi@nec.com, mhocko@kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <cover.1708507022.git.baolin.wang@linux.alibaba.com>
 <0514e5139b17ecf3cd9e09d86c93e586c56688dc.1708507022.git.baolin.wang@linux.alibaba.com>
 <ZdfHi142dvQuN7B-@localhost.localdomain>
 <0a06dc7f-3a49-42ba-8221-0b4a3777ac0b@linux.alibaba.com>
 <ZdipdrJoN7LS3h9m@localhost.localdomain>
 <9b49d2c8-4ace-4095-8610-8becf96eb023@linux.alibaba.com>
 <ZdxXLTDZn8fD3pEn@localhost.localdomain>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <ZdxXLTDZn8fD3pEn@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/2/26 17:17, Oscar Salvador wrote:
> On Mon, Feb 26, 2024 at 11:34:51AM +0800, Baolin Wang wrote:
>> IMO, I'm not sure whether it's appropriate to decouple
>> dequeue_hugetlb_folio_nodemask() from alloc_hugetlb_folio_nodemask() into
>> two separate functions for the users to call, because these details should
>> be hidden within the hugetlb core implementation.
>>
>> Instead, I can move the gfp_mask fiddling into a new helper, and move the
>> helper into alloc_migrate_hugetlb_folio(). Temporary hugetlb allocation has
>> its own gfp strategy seems reasonable to me.
> 
> An alternative would be to do the following, which does not futher carry
> the "reason" argument into hugetlb code.
> (Not even compile tested, just a PoC)
> 
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index c1ee640d87b1..8a89a1007dcb 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -970,6 +970,24 @@ static inline gfp_t htlb_modify_alloc_mask(struct hstate *h, gfp_t gfp_mask)
>   	return modified_mask;
>   }
> 
> +static inline bool htlb_allow_fallback(int reason)
> +{
> +	bool allowed_fallback = false;
> +
> +	switch (reason) {
> +	case MR_MEMORY_HOTPLUG:
> +	case MR_MEMORY_FAILURE:
> +	case MR_SYSCALL:
> +	case MR_MEMPOLICY_MBIND:
> +		allowed_fallback = true;
> +		break;
> +	default:
> +	        break;
> +	}
> +
> +	return allowed_fallback;
> +}
> +

Thanks for providing an alternative implementation. However, I still 
prefer to hide these details into hugetlb core, since users do not need 
to pay excessive attention to these hugetlb details. So something like:

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 418d66953224..e8eb08bbc688 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2567,13 +2567,38 @@ static struct folio 
*alloc_surplus_hugetlb_folio(struct hstate *h,
  }

  static struct folio *alloc_migrate_hugetlb_folio(struct hstate *h, 
gfp_t gfp_mask,
-                                    int nid, nodemask_t *nmask)
+                                    int nid, nodemask_t *nmask, int reason)
  {
         struct folio *folio;
+       bool allowed_fallback = false;

         if (hstate_is_gigantic(h))
                 return NULL;

+       if (gfp_mask & __GFP_THISNODE)
+               goto alloc_new;
+
+       /*
+        * Note: the memory offline, memory failure and migration 
syscalls will
+        * be allowed to fallback to other nodes due to lack of a better 
chioce,
+        * that might break the per-node hugetlb pool. While other cases 
will
+        * set the __GFP_THISNODE to avoid breaking the per-node hugetlb 
pool.
+        */
+       switch (reason) {
+       case MR_MEMORY_HOTPLUG:
+       case MR_MEMORY_FAILURE:
+       case MR_MEMORY_FAILURE:
+       case MR_SYSCALL:
+       case MR_MEMPOLICY_MBIND:
+               allowed_fallback = true;
+               break;
+       default:
+               break;
+       }
+
+       if (!allowed_fallback)
+               gfp_mask |= __GFP_THISNODE;
+
+alloc_new:
         folio = alloc_fresh_hugetlb_folio(h, gfp_mask, nid, nmask, NULL);
         if (!folio)
                 return NULL;
@@ -2621,7 +2646,7 @@ struct folio 
*alloc_buddy_hugetlb_folio_with_mpol(struct hstate *h,

  /* folio migration callback function */
  struct folio *alloc_hugetlb_folio_nodemask(struct hstate *h, int 
preferred_nid,
-               nodemask_t *nmask, gfp_t gfp_mask)
                 return NULL;
@@ -2621,7 +2646,7 @@ struct folio 
*alloc_buddy_hugetlb_folio_with_mpol(struct hstate *h,

  /* folio migration callback function */
  struct folio *alloc_hugetlb_folio_nodemask(struct hstate *h, int 
preferred_nid,
-               nodemask_t *nmask, gfp_t gfp_mask)
+               nodemask_t *nmask, gfp_t gfp_mask, int reason)
  {
         spin_lock_irq(&hugetlb_lock);
         if (available_huge_pages(h)) {
@@ -2636,7 +2661,7 @@ struct folio *alloc_hugetlb_folio_nodemask(struct 
hstate *h, int preferred_nid,
         }
         spin_unlock_irq(&hugetlb_lock);

-       return alloc_migrate_hugetlb_folio(h, gfp_mask, preferred_nid, 
nmask);
+       return alloc_migrate_hugetlb_folio(h, gfp_mask, preferred_nid, 
nmask, reason);
  }

  /*
@@ -6653,7 +6678,13 @@ static struct folio 
*alloc_hugetlb_folio_vma(struct hstate *h,

         gfp_mask = htlb_alloc_mask(h);
         node = huge_node(vma, address, gfp_mask, &mpol, &nodemask);
-       folio = alloc_hugetlb_folio_nodemask(h, node, nodemask, gfp_mask);
+       /*
+        * This is used to allocate a temporary hugetlb to hold the copied
+        * content, which will then be copied again to the final hugetlb
+        * consuming a reservation. Set the migrate reason to -1 to indicate
+        * that breaking the per-node hugetlb pool is not allowed in 
this case.
+        */
+       folio = alloc_hugetlb_folio_nodemask(h, node, nodemask, 
gfp_mask, -1);
         mpol_cond_put(mpol);

         return folio;


What do you think? Thanks.

