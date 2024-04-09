Return-Path: <linux-kernel+bounces-136963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 058DD89DA61
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 15:36:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 321A41C22F98
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 13:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25ED51304B4;
	Tue,  9 Apr 2024 13:32:21 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC5E7FBD3
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 13:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712669540; cv=none; b=M6HCtUqmsVbwcbb+/lW0y4ldCRD4JMk65y3QJYb2fElAqt5XgUa5f8MYsPiCVyrJxPvLX6bjK9FeHGH53aejjoHglUCAvMbG8InxavvYK+Wn8oYtHOrQ5tGvEPnCl0V+77vQ6k+piBZUFjr4o2a4OyP/Cmst/RlIWFt34DLKuuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712669540; c=relaxed/simple;
	bh=dMqGeHAHH7zcug3J3Ku1senR0ip7h5j/VVoBZ3xVssw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=S+/mfRcM+wQSXfwhW6fpc9KOmGouUJP43uoMdHPgOev9Y44zXRYUBuF3tF5fb4P1rxt6yOXDMpkl7Zc7lAAwwlGathY0ha+oUNnWQSGCFZt9rgtgdLEhnLF4KxoFhu19wlTW2fVMCPC3UfePvmKA8ctRB107XK18hYMT1tQ5tC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4VDRd029GSzXlBL;
	Tue,  9 Apr 2024 21:29:08 +0800 (CST)
Received: from dggpemm100001.china.huawei.com (unknown [7.185.36.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 38254140118;
	Tue,  9 Apr 2024 21:32:15 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 9 Apr 2024 21:32:14 +0800
Message-ID: <c0bed01f-0cd4-49d5-9e8b-1ea6cc9a760a@huawei.com>
Date: Tue, 9 Apr 2024 21:32:14 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/4] page_owner: Fix refcount imbalance and print fixup
Content-Language: en-US
To: Oscar Salvador <osalvador@suse.de>, Andrew Morton
	<akpm@linux-foundation.org>
CC: <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, Michal Hocko
	<mhocko@suse.com>, Vlastimil Babka <vbabka@suse.cz>, Marco Elver
	<elver@google.com>, Andrey Konovalov <andreyknvl@gmail.com>, Alexander
 Potapenko <glider@google.com>, Alexandre Ghiti <alexghiti@rivosinc.com>
References: <20240404070702.2744-1-osalvador@suse.de>
From: Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <20240404070702.2744-1-osalvador@suse.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm100001.china.huawei.com (7.185.36.93)



On 2024/4/4 15:06, Oscar Salvador wrote:
> This series consists of a refactoring/correctness of updating the metadata
> of tail pages, a couple of fixups for the refcounting part and a fixup for
> the stack_start() function.
> 
>>From this series on, instead of counting the stacks, we count the outstanding
> nr_base_pages each stack has, which gives us a much better memory overview.
> The other fixup is for the migration part.
> 
> A more detailed explanation can be found in the changelog of the respective
> patches.

I think this also should be merged into 6.9-rc1 asap, it is easy to 
occur when migration.

Tested-by: Kefeng Wang <wangkefeng.wang@huawei.com>

> 
> v3 -> v4:
>   - Fix some typos remarked by Vlastimil
>   - Add Reviewed-by tag from Vlastimil and Tested-by tag from Alexandre Ghiti
>     (closed a syzbot report for RISC)
> 
> Oscar Salvador (4):
>    mm,page_owner: Update metadata for tail pages
>    mm,page_owner: Fix refcount imbalance
>    mm,page_owner: Fix accounting of pages when migrating
>    mm,page_owner: Fix printing of stack records
> 
>   Documentation/mm/page_owner.rst |  73 +++++++------
>   mm/page_owner.c                 | 188 ++++++++++++++++++--------------
>   2 files changed, 147 insertions(+), 114 deletions(-)
> 

