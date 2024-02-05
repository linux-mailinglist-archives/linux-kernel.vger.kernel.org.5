Return-Path: <linux-kernel+bounces-52193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A5F9384952C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 09:16:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 347ACB22562
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 08:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94D5B111A4;
	Mon,  5 Feb 2024 08:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Xul78CXW"
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8781511197
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 08:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707121004; cv=none; b=UHY+SSFdrYQ2qR1vTDhWYKcwhXUgm2fkAEQCXOuIHw6sNffbdp/RYN5vIvwwWNu2JbQcFeRBLfF4j3KWEkx9cjTI08S80SD6/cENN9iCTZfdC35TtdMHc8H8bZYoZQDfWXk59pp8xBeuO2VOboK4OcY2nmdTzkEdjUgUOguzMk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707121004; c=relaxed/simple;
	bh=oIOpfu/j6HWmd1PYRGjBVdrnuollrvZEd8jWM9IYbv0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZQaM1H44U0nBeVcB8xQsMED3PFs3I7K3eI3d/cxBGUhYQbmDS+U7WUUwSsvJlX0+1SP8fPJEpA/MHMXa7iKkw7tg+OKwU/VjjtFZPlNFnI9eAyQsqCUu20c0Yg3v72OVIoiE0VsxSSEtWM4DgHiILLv914ZbDOz/4C08Xvq2myw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Xul78CXW; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1707120993; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=+N4WMM1/lsjVxwoQqsoRoiQOAtzQ+zefrthX2QtoRGc=;
	b=Xul78CXWpmZGU2XhK2nynmg6+7YX2Gu5qhwYlSHB+Q83qP3E3sv87p3P53PVy9zxGv5kTB1A5GZr15bdCgkd1JistK4vFJJtvWmPonwGByHsV8t/+urGLM7XtZNPAxHpj8TR+xkLALeBnY+WUCa+nvJuTjevSW5euvjHriohV+w=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0W06o2VN_1707120991;
Received: from 30.97.56.40(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W06o2VN_1707120991)
          by smtp.aliyun-inc.com;
          Mon, 05 Feb 2024 16:16:32 +0800
Message-ID: <36d709fb-967c-42fa-a47a-465e29e13ef6@linux.alibaba.com>
Date: Mon, 5 Feb 2024 16:16:47 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] Enable >0 order folio memory compaction
To: Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: "Huang, Ying" <ying.huang@intel.com>, Ryan Roberts
 <ryan.roberts@arm.com>, Andrew Morton <akpm@linux-foundation.org>,
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
References: <20240202161554.565023-1-zi.yan@sent.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20240202161554.565023-1-zi.yan@sent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/3/2024 12:15 AM, Zi Yan wrote:
> From: Zi Yan <ziy@nvidia.com>
> 
> Hi all,
> 
> This patchset enables >0 order folio memory compaction, which is one of
> the prerequisitions for large folio support[1]. It includes the fix[4] for
> V2 and is on top of mm-everything-2024-01-29-07-19.
> 
> I am aware of that split free pages is necessary for folio
> migration in compaction, since if >0 order free pages are never split
> and no order-0 free page is scanned, compaction will end prematurely due
> to migration returns -ENOMEM. Free page split becomes a must instead of
> an optimization.
> 
> lkp ncompare results for default LRU (-no-mglru) and CONFIG_LRU_GEN are
> shown at the bottom (on a 8-CPU (Intel Xeon E5-2650 v4 @ 2.20GHz) 16G VM).
> In sum, most of vm-scalability applications do not see performance change,
> and the others see ~4% to ~26% performance boost under default LRU and
> ~2% to ~6% performance boost under CONFIG_LRU_GEN.

For the whole series, looks good to me. And I did not find any 
regression after running thpcompact. So feel free to add:
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Tested-by: Baolin Wang <baolin.wang@linux.alibaba.com>

