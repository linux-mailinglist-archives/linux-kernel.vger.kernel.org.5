Return-Path: <linux-kernel+bounces-72238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA06185B10D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 04:01:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FF981F21921
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 03:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D1B93E485;
	Tue, 20 Feb 2024 03:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="lWksjhKH"
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C494778B
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 03:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708398048; cv=none; b=oms9CbmM0b6+MIBbbLlYajxvCLuF67IxH1UaMf6ensPzyOjcd7M2Ag/qg+9SzjbgUOvlcPHjV48L4BnjLsJseX3Vj7PxQE9hCjRevvOyYy0UvLypT9ZImZvJAuC2clPLHLpGPsW0tOOKqlzNpHKJAUrFv5EDtGaMTyQxebT979Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708398048; c=relaxed/simple;
	bh=GhOPCcSxUoJi2epHGFQSFy2Yuds+eqX1E67Q6+MimUc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BO8/NLKE8hJL+Oiy8ZRe4pN3E1Hf9usBD0n01NRQ+pkkBbUYZqfdOd57CoE/AAWSJJ8JEUjxwFaWFKgs3DAIIT/HZCwKSfs00liOnb/6xusux5x0SVlp5he6Xqj76+pFXcu5b3UOjlSd3sSCQ2/LkB/fQOdB2UwMTBxD5niQe0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=lWksjhKH; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1708398043; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=sDGPECVwML/ab/agq9Xvg0iE7vYihMMAiv8/y6zVFrM=;
	b=lWksjhKH2QtA01OstROB4iFkSHYGy6mucOD6upLTrbDGgOO/+hmKHLAw7ghOaumYlaGGARGDMrhqQXqPk2vls4RkpiqOtKesHjCABawo53rU4iUCUY+qRxXnEmUY7B22pEPz8b7v+hSS46Fqi7nULoPptTtwoNNawQzyrM3JILs=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0W0v2vEy_1708398040;
Received: from 30.97.56.48(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W0v2vEy_1708398040)
          by smtp.aliyun-inc.com;
          Tue, 20 Feb 2024 11:00:41 +0800
Message-ID: <4f0b3586-25e2-4d21-bbb6-41f644d3d77f@linux.alibaba.com>
Date: Tue, 20 Feb 2024 11:00:39 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/4] Enable >0 order folio memory compaction
To: Zi Yan <ziy@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 "Huang, Ying" <ying.huang@intel.com>, Ryan Roberts <ryan.roberts@arm.com>,
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
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <9E3E6CD6-45DD-4E7F-B6DC-0897F38D5E81@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/2/20 10:31, Zi Yan wrote:
> On 19 Feb 2024, at 21:06, Andrew Morton wrote:
> 
>> On Fri, 16 Feb 2024 12:04:28 -0500 Zi Yan <zi.yan@sent.com> wrote:
>>
>>> Baolin's patch
>>
>> Baolin writes many patches and patches have names, please use them!
> Sorry for not being specific. I mean this fixup:
> https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/commit/?h=mm-everything-2024-02-16-01-35&id=97f749c7c82f677f89bbf4f10de7816ce9b071fe
> 
> to this patch:
> https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/commit/?h=mm-everything-2024-02-16-01-35&id=ea87b0558293a5ad597bea606fe261f7b2650cda
> 
> 
> The patch was based on top of my early version of this patchset, thus
> uses "cc->nr_migratepages -= 1 << order;" and
> "cc->nr_migratepages += 1 << order;", but now it is applied before
> mine. The change should be "cc->nr_migratepages--;" and
> "cc->nr_migratepages++;", respectively.
> 
>>
>>> on nr_migratepages was based on this one, a better fixup
>>> for it might be below. Since before my patchset, compaction only deals with
>>> order-0 pages.
>>
>> I don't understand what this means.  The patchset you sent applies OK
>> to mm-unstable so what else is there to do?
> 
> Your above fixup to Baolin's patch needs to be changed to the patch below
> and my "mm/compaction: add support for >0 order folio memory compaction" will
> need to be adjusted accordingly to be applied on top.
> 
> Let me know if anything is unclear.

Hi Andrew,

To avoid conflicts, you can drop these two patches, and I will send a 
new version with fixing the issue pointed by Vlastimilb on top of 
"mm/compaction: add support for >0 order folio memory compaction".

https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/commit/?h=mm-everything-2024-02-16-01-35&id=97f749c7c82f677f89bbf4f10de7816ce9b071fe

https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/commit/?h=mm-everything-2024-02-16-01-35&id=ea87b0558293a5ad597bea606fe261f7b2650cda

