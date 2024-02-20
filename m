Return-Path: <linux-kernel+bounces-72408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57E3185B2E5
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 07:28:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E76D1F21FB2
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 06:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1804D59155;
	Tue, 20 Feb 2024 06:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="aPz21Wt2"
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A7D59149
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 06:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708410499; cv=none; b=kdnaxPtSkwk3eMo+JWkPaYYA6yeYjzv34+bglwXGmYxLXnB+L6OnxZHgwF1sp72syA8U6LQvMaPzdBbVS7kiwiO+39DcNQ+bChMFbMlk41C0gxnqmaW6Z2s9YBxbw0O0xCeW83GzAmJA0PvDwhvTQnWeAvfpcZnJ7jpJmBAtHLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708410499; c=relaxed/simple;
	bh=v1sEN7DrYpBxbelhKpz+nzMPVdPXSWyxn12i1zNGLMw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cZpYZ1NiC6/5RJ6d8yVNw3uFaNo7J+JcfcW4riHddVtv81aCSazyvrLo7wEsBes6+JcQBOatvcWo88UfnSDArPtmaOzM23xrD4TBxetad5IuE8OGbYF5SSFo1iTfgHpxACqiZ6nZY8CMvEKUt+Ega5MYZCdD5YsOzfzAg91XgPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=aPz21Wt2; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1708410494; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=puMJdMhcnkjp6kkrLK0SxE7fWXoN3haERSGZVmMXdyk=;
	b=aPz21Wt28Y+2VU2UQZlxQqv/jtxe0cGkAPvccFjbxXmaUz3nwQffzvw8Bk6d1Jcz6Su6pvHNzKCJROvooA1+hxgEvDeUCh4dv9wjLGoxuW2vJ6fjqX7eiROtXzDeE7A81LnLmYz/O5TnQtcczDbpekMx6vTEwKa1yXxbIYvyokI=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R771e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0W0veSm2_1708410491;
Received: from 30.97.56.48(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W0veSm2_1708410491)
          by smtp.aliyun-inc.com;
          Tue, 20 Feb 2024 14:28:12 +0800
Message-ID: <6da5c282-a522-4732-ad3c-73f6790c073e@linux.alibaba.com>
Date: Tue, 20 Feb 2024 14:28:10 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/4] Enable >0 order folio memory compaction
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, "Huang, Ying" <ying.huang@intel.com>,
 Ryan Roberts <ryan.roberts@arm.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 David Hildenbrand <david@redhat.com>, "Yin, Fengwei"
 <fengwei.yin@intel.com>, Yu Zhao <yuzhao@google.com>,
 Vlastimil Babka <vbabka@suse.cz>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Kemeng Shi
 <shikemeng@huaweicloud.com>, Mel Gorman <mgorman@techsingularity.net>,
 Rohan Puri <rohan.puri15@gmail.com>, Mcgrof Chamberlain <mcgrof@kernel.org>,
 Adam Manzanares <a.manzanares@samsung.com>,
 "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
References: <20240216170432.1268753-1-zi.yan@sent.com>
 <20240219180617.89a0daaba45ce124ef01be50@linux-foundation.org>
 <9E3E6CD6-45DD-4E7F-B6DC-0897F38D5E81@nvidia.com>
 <4f0b3586-25e2-4d21-bbb6-41f644d3d77f@linux.alibaba.com>
 <20240219193048.cbd010579aa3d2c790f6e2b9@linux-foundation.org>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20240219193048.cbd010579aa3d2c790f6e2b9@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/2/20 11:30, Andrew Morton wrote:
> On Tue, 20 Feb 2024 11:00:39 +0800 Baolin Wang <baolin.wang@linux.alibaba.com> wrote:
> 
>>> The patch was based on top of my early version of this patchset, thus
>>> uses "cc->nr_migratepages -= 1 << order;" and
>>> "cc->nr_migratepages += 1 << order;", but now it is applied before
>>> mine. The change should be "cc->nr_migratepages--;" and
>>> "cc->nr_migratepages++;", respectively.
>>>
>>>>
>>>>> on nr_migratepages was based on this one, a better fixup
>>>>> for it might be below. Since before my patchset, compaction only deals with
>>>>> order-0 pages.
>>>>
>>>> I don't understand what this means.  The patchset you sent applies OK
>>>> to mm-unstable so what else is there to do?
>>>
>>> Your above fixup to Baolin's patch needs to be changed to the patch below
>>> and my "mm/compaction: add support for >0 order folio memory compaction" will
>>> need to be adjusted accordingly to be applied on top.
>>>
>>> Let me know if anything is unclear.
>>
>> Hi Andrew,
>>
>> To avoid conflicts, you can drop these two patches, and I will send a
>> new version with fixing the issue pointed by Vlastimilb on top of
>> "mm/compaction: add support for >0 order folio memory compaction".
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/commit/?h=mm-everything-2024-02-16-01-35&id=97f749c7c82f677f89bbf4f10de7816ce9b071fe
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/commit/?h=mm-everything-2024-02-16-01-35&id=ea87b0558293a5ad597bea606fe261f7b2650cda
> 
> Well I thought I'd fixed everything up 10 minutes ago.  Please take a
> look at next mm-unstable.

Sure. And I found a minor rebase error in the compaction_alloc() 
function while Zi Yan's original patch is correct.

+	cc->nr_freepages -= 1 << order;
  	cc->nr_migratepages--;
-
-	return dst;
+	return page_rmappable_folio(&dst->page);
  }

should change to be:
cc->nr_migratepages -= 1 << order;

