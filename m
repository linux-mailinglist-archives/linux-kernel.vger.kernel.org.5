Return-Path: <linux-kernel+bounces-80473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBB5B8668CA
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 04:35:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A97CB2133D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 03:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F95D1427E;
	Mon, 26 Feb 2024 03:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="REfp/HWc"
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBFDE4C91
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 03:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708918498; cv=none; b=U08R5Tt9mjQenFPeV5eVt0Vp5xU5CWhTpai5FFpYBTjZHE0zK9DFNviq4Z7edN2WaNj0hUucAQc+3XlU565qGXCX/xqLHxpDVdpRbYKfOyuFwz3QYyAW4wcQzn7huTKA/iqhmGkOMJBP3hgJ55BhP7l1AIMyB0UgH6XqHdNjVtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708918498; c=relaxed/simple;
	bh=1rlvxNg/PaO1Mom+8niom04hyZ3Gv85Bva4WGrUPYlY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zu5YgCil/zR2oPmPu0kMTSRBExTVWt+V84PhsonCCg3FGDFoigc5IxgGtMIc+PZ9Vvko42cqEGUKn5nrZ3klAxPWcUQYuT4oJRJ9FTPFa3pDvZ6IHtlomgx4VWTHUiU0IMC9nuUr0cVusWOoxa82uYQuMbS6MROq8O16rREeTTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=REfp/HWc; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1708918493; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=sF16PtfMksFLXAGoqg1Gy1LZK+T652VTSpOR/ck/ZMU=;
	b=REfp/HWc7RdJMxdSmlVL1BhLmztNe5o0UVcyGkNOhFavQmzsD3FAWZru/Vs5N3LWTwVdqak3mm/uHfOzG68IvixzWo0tjWIxojjDTAGJ8agPWY08DNMxVukYd9hTe4l7atYIWhhp8BoqE09+PaUo70rgnsd9DknV1/iBp6Adpks=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W1AMo4-_1708918492;
Received: from 30.97.56.44(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W1AMo4-_1708918492)
          by smtp.aliyun-inc.com;
          Mon, 26 Feb 2024 11:34:52 +0800
Message-ID: <9b49d2c8-4ace-4095-8610-8becf96eb023@linux.alibaba.com>
Date: Mon, 26 Feb 2024 11:34:51 +0800
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
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <ZdipdrJoN7LS3h9m@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/2/23 22:19, Oscar Salvador wrote:
> On Fri, Feb 23, 2024 at 10:56:48AM +0800, Baolin Wang wrote:
>   
>> I previously considered passing the MR_reason argument to the
>> htlb_modify_alloc_mask(), which is only used by hugetlb migration.
>> But in alloc_hugetlb_folio_nodemask(), if there are available hugetlb on
>> other nodes, we should allow migrating, that will not break the per-node
>> hugetlb pool.
>>
>> That's why I just change the gfp_mask for allocating a new hguetlb when
>> migration, that can break the pool.
> 
> Code-wise I think this is good, but I'm having some feelings
> about where filter out the mask.
> Ok, I'm trying to get my head around this.
> It's been a while since I looked into hugetlb code, so here we go.
> 
> You mentioned that the only reason not to fiddle with gfp_mask before calling
> in alloc_hugetlb_folio_nodemask(), was that we might be able to find a hugetlb
> page in another node, and that that's ok because since all nodes remain with
> the same number of hugetlb pages, per-node pool doesn't get broken.
> 
> Now, I see that dequeue_hugetlb_folio_nodemask() first tries to get the zonelist
> of the preferred node, and AFAICS, if it has !GFP_THISNODE, it should also
> get the zonelists of all other nodes, so we might fallback.

Right.

> In the hope of finding a way to be able to filter out in htlb_modify_alloc_mask(),
> I was trying to see whether we could skip GFP_THISNODE in
> dequeue_hugetlb_folio_nodemask() but no because we might end up dequeueing
> a hugetlb which sits in another node, while we really specified __GFP_THISNODE.
> 
> The only way might be to somehow decouple dequeue_hugetlb_folio_nodemask()
> from alloc_hugetlb_folio_nodemask() and do some kind of gfp modification
> between the two calls.

IMO, I'm not sure whether it's appropriate to decouple 
dequeue_hugetlb_folio_nodemask() from alloc_hugetlb_folio_nodemask() 
into two separate functions for the users to call, because these details 
should be hidden within the hugetlb core implementation.

Instead, I can move the gfp_mask fiddling into a new helper, and move 
the helper into alloc_migrate_hugetlb_folio(). Temporary hugetlb 
allocation has its own gfp strategy seems reasonable to me.

> Another thing I dislike is the "-1" in alloc_hugetlb_folio_vma().
> I think at least it deserves a comment like "Passing -1 will make us stick
> to GFP_THISNODE".

Sure, will add some comments.

> Although that is another thing, we will pass "-1" which forces GFP_THISNODE
> when allocating a newly fresh hugetlb page, but in dequeue_hugetlb_folio_nodemask()
> we might get a page from a different node.
> That doesn't break per-node pool, but it is somehow odd?

Only hugetlb_mfill_atomic_pte() will use -1, which is used to allocate a 
temporary hugetlb to hold the copied content that will be immediately 
released if uffd copy completes (see commmit 8cc5fcbb5be8). Therefore, 
here it is allowed to fallback to available hugetlb on other nodes, but 
it is not allowed to break the per-node pool.

