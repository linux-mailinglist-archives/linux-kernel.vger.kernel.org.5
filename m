Return-Path: <linux-kernel+bounces-128996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9777F8962E2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 05:19:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51F0E2883FC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 03:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A23C1BF5C;
	Wed,  3 Apr 2024 03:19:44 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0213C1C6A6
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 03:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712114384; cv=none; b=UouOwdB0GcVn9+Jxf19xlMdS3ZSkeLQcnYRo2SDuVB/upY2jb5vGRdBUaoFtuv1oLEzg30DcxEcUgzXRV16Myb+cmhpDZP9Bbrp9h2PYF1M7fAnA85N8DGsB25OcPyDY9V0B1KtLxVVKa5eiO5RYpMuBMlVZ5ZufRr3zMZRgudM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712114384; c=relaxed/simple;
	bh=/5seI4hwLNtes2S2aPoGh4M8vMX4nwNFwUgv4bF3cmI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=lk6dVPeqrvzFexfZCYREmTPCZcF8HXV8EYPwyk6lmkKuLCS5ncaIsGXd5JlhcPeO71w0vdk7LJGbDR1UtSzD10M9HCc2XXIjoqfIzd24ixmLw+awX8fWRatgPzHlTRceEswGoVmkBLoDMZRYmQS+rBH0ojfPrz9g24B2g4V7Oqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4V8VKR5nz5z1QBqd;
	Wed,  3 Apr 2024 11:16:59 +0800 (CST)
Received: from dggpemm100001.china.huawei.com (unknown [7.185.36.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 93A5F18005D;
	Wed,  3 Apr 2024 11:19:33 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 3 Apr 2024 11:19:33 +0800
Message-ID: <59860bb4-0dff-4575-b4cb-b88e6e1ccb77@huawei.com>
Date: Wed, 3 Apr 2024 11:19:32 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] page_owner: Fix refcount imbalance
Content-Language: en-US
To: Oscar Salvador <osalvador@suse.de>
CC: Andrew Morton <akpm@linux-foundation.org>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>, Michal Hocko <mhocko@suse.com>, Vlastimil Babka
	<vbabka@suse.cz>, Marco Elver <elver@google.com>, Andrey Konovalov
	<andreyknvl@gmail.com>, Alexander Potapenko <glider@google.com>
References: <20240326063036.6242-1-osalvador@suse.de>
 <74b147b0-718d-4d50-be75-d6afc801cd24@huawei.com>
 <ZgwUP17giMgGksXc@localhost.localdomain>
From: Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <ZgwUP17giMgGksXc@localhost.localdomain>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm100001.china.huawei.com (7.185.36.93)



On 2024/4/2 22:20, Oscar Salvador wrote:
> On Fri, Mar 29, 2024 at 12:54:30PM +0800, Kefeng Wang wrote:
>> I still see the following memory leak, could you check it?
>>
>> /mnt/arm64 # cat /sys//kernel/debug/kmemleak
>> unreferenced object 0xffff000200d91000 (size 16):
>>    comm "kworker/4:0", pid 42, jiffies 4294892753
>>    hex dump (first 16 bytes):
>>      60 37 57 c1 00 00 ff ff 00 00 00 00 00 00 00 00  `7W.............
>>    backtrace (crc 4458f477):
>>      [<(____ptrval____)>] kmemleak_alloc+0x3c/0x50
>>      [<(____ptrval____)>] kmalloc_trace+0x20c/0x2e0
>>      [<(____ptrval____)>] __set_page_owner+0x1d0/0x2a0
>>      [<(____ptrval____)>] prep_new_page+0x108/0x138
>>      [<(____ptrval____)>] get_page_from_freelist+0x79c/0x16b8
>>      [<(____ptrval____)>] __alloc_pages+0x1bc/0x440
>>      [<(____ptrval____)>] new_slab+0x104/0x3c8
>>      [<(____ptrval____)>] ___slab_alloc+0x368/0xb20
>>      [<(____ptrval____)>] __slab_alloc.isra.0+0x3c/0x88
>>      [<(____ptrval____)>] kmalloc_trace+0x280/0x2e0
>>      [<(____ptrval____)>] __set_page_owner+0x1d0/0x2a0
>>      [<(____ptrval____)>] prep_new_page+0x108/0x138
>>      [<(____ptrval____)>] get_page_from_freelist+0x79c/0x16b8
>>      [<(____ptrval____)>] __alloc_pages+0x1bc/0x440
>>      [<(____ptrval____)>] new_slab+0x104/0x3c8
>>      [<(____ptrval____)>] ___slab_alloc+0x368/0xb20
> 
> Hi Kefeng Wang
> 
> You seem to be missing [1]
> 
> Could you try with that patch applied?
> 
> [1] https://lore.kernel.org/linux-mm/20240315222610.6870-1-osalvador@suse.de/

Hi, re-run with clean v6.9-rc2 (already include 7844c0147211
mm,page_owner: fix recursion), after booting and wait some time,
the kmemleak is still occurred.



> 
> Thanks
> 

