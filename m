Return-Path: <linux-kernel+bounces-71073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCAC685A054
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 10:55:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E6831F22BC1
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 09:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE5742561F;
	Mon, 19 Feb 2024 09:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="cJVJhjkM"
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38DB525614;
	Mon, 19 Feb 2024 09:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708336484; cv=none; b=WKOekneIpiJUa8zEFif7A6VZj2IHyejE62RyivaLbSYStWD28Bfo74y9+s5oFjqCm9cFZ/ShZHz0StNLbWzxnF1xhdkfyJ5pnv6RPKxc/PX/Qz5N0aoxBOTxnRmTmbCTckG8CjBAT5snwjd8Gyb0lgqqSa37ofFQC6PqCLZ9ps4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708336484; c=relaxed/simple;
	bh=2PGHb0YK6zNzLpgmDozQJqP4grk2DdHx3T5vOsHWuqg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dN5DFuCH+2SPV2Wm9VFXzTDfT6AVzoCLyAL9LrOWC6iB/XELCSzSUMY/LPqpuDhHJj2TFvjK0ZV2LSFrONzFGLNsU0LvMr38lRAVW98Rknj+QLFc+iGdNH0Pv28I1/Z5mMOajwZshsKZzopNUnQGULbGa78yuurAdvvL/JZtyIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=cJVJhjkM; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1708336479; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=HjH7v7MwvWWsSPBnkhGSwPRvi6ZG5EixZmbA5olhbF8=;
	b=cJVJhjkMFc3/SgYQ5niz4Vqd0l0S7c6Bt+wDTOKDZ80IP5Yn0WA0Cg5q6YgfscolA3eCof5yPsHqECoqSxmUDOoNm5Edc9Vaax3M32e8ZCcN8e63ARlxPnsJfieIIgSDH6x04NNsK/PtPaRZ5i9mjafUA6esGWagQW5jaqg/45c=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W0sB01V_1708336477;
Received: from 30.97.56.48(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W0sB01V_1708336477)
          by smtp.aliyun-inc.com;
          Mon, 19 Feb 2024 17:54:38 +0800
Message-ID: <f9ca3b97-002d-46b0-904b-c9b1859ee236@linux.alibaba.com>
Date: Mon, 19 Feb 2024 17:54:36 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/vmscan: Fix a bug calling wakeup_kswapd() with a wrong
 zone index
To: Oscar Salvador <osalvador@suse.de>
Cc: Byungchul Park <byungchul@sk.com>, akpm@linux-foundation.org,
 ying.huang@intel.com, hannes@cmpxchg.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, kernel_team@skhynix.com, stable@vger.kernel.org
References: <20240216111502.79759-1-byungchul@sk.com>
 <517e58d4-7537-4d9f-8893-0130c65c3fdb@linux.alibaba.com>
 <ZdMNGvUOWnNn9zDh@localhost.localdomain>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <ZdMNGvUOWnNn9zDh@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/2/19 16:11, Oscar Salvador wrote:
> On Mon, Feb 19, 2024 at 02:25:11PM +0800, Baolin Wang wrote:
>> This means that there is no memory on the target node？ if so, we can add a
>> check at the beginning to avoid calling unnecessary
>> migrate_misplaced_folio().
>>
>> diff --git a/mm/memory.c b/mm/memory.c
>> index e95503d7544e..a64a1aac463f 100644
>> --- a/mm/memory.c
>> +++ b/mm/memory.c
>> @@ -5182,7 +5182,7 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
>>          else
>>                  last_cpupid = folio_last_cpupid(folio);
>>          target_nid = numa_migrate_prep(folio, vma, vmf->address, nid,
>> &flags);
>> -       if (target_nid == NUMA_NO_NODE) {
>> +       if (target_nid == NUMA_NO_NODE || !node_state(target_nid, N_MEMORY))
>> {
>>                  folio_put(folio);
>>                  goto out_map;
>>          }
>>
>> (similar changes for do_huge_pmd_numa_page())
> 
> With the check in place from [1], numa_migrate_prep() will also return
> NUMA_NO_NODE, so no need for this one here.
> 
> And I did not check, but I assume that do_huge_pmd_numa_page() also ends
> up calling numa_migrate_prep().
> 
> [1] https://lore.kernel.org/lkml/20240219041920.1183-1-byungchul@sk.com/
Right. I missed this patch before. So with checking in 
should_numa_migrate_memory(), I guess current changes in 
numamigrate_isolate_folio() can also be dropped, it will never hit a 
memoryless node after the patch [1], no?

