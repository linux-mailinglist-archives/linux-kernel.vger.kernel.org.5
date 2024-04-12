Return-Path: <linux-kernel+bounces-141767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 21C4F8A232B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 03:25:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5A09B21CB1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 01:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55FEDCA64;
	Fri, 12 Apr 2024 01:25:06 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB2153A7;
	Fri, 12 Apr 2024 01:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712885105; cv=none; b=W9Ht0J5w8uPRn1dCtFmeYXJcW8oWJJtZlq4eZa6d1/bIgqpneRO4ASMzT0mQMisLwZbAqJuzhoXFwjCRjgbNovXzrdmphpxwMzgIKNDBQ5FVF/vGboSLB8olt3LiisHJh5+5c89FJH243y2uHZ6+jmEIJXpxGzzWZDofZpUEajo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712885105; c=relaxed/simple;
	bh=O0eIe2ihpeSlVWIlBvvKzXMwbIuK7YeK/f8u4Bks4+E=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=I43++5PbiCDfdnk6Ya4zoLU6bnl/NYNCY1WdCGY6UmS1R04MDUMJvY2YO70H2S+OfaKnSn4sIWh/nHo/NIPf3WBGRkb7PTDQ6yu/TQqHb6CTGwotvuDMHVjTMlFUChD8nkchKFty82uNR6kFhGjWHAfXAQi0BYNxz18C24M3md8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4VFzLv0M7kz1R5k7;
	Fri, 12 Apr 2024 09:22:15 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (unknown [7.193.23.164])
	by mail.maildlp.com (Postfix) with ESMTPS id 6366218006B;
	Fri, 12 Apr 2024 09:25:00 +0800 (CST)
Received: from [10.174.176.73] (10.174.176.73) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 12 Apr 2024 09:24:59 +0800
Subject: Re: [PATCH -next 1/2] block: fix that blk_time_get_ns() doesn't
 update time after schedule
To: Jens Axboe <axboe@kernel.dk>, Yu Kuai <yukuai1@huaweicloud.com>,
	<johannes.thumshirn@wdc.com>
CC: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<yi.zhang@huawei.com>, <yangerkun@huawei.com>
References: <20240411032349.3051233-1-yukuai1@huaweicloud.com>
 <20240411032349.3051233-2-yukuai1@huaweicloud.com>
 <9a4f8738-6ad5-407e-a938-83395aa1df4f@kernel.dk>
From: Yu Kuai <yukuai3@huawei.com>
Message-ID: <7baaea10-5a3d-5efa-158b-f10448232031@huawei.com>
Date: Fri, 12 Apr 2024 09:24:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <9a4f8738-6ad5-407e-a938-83395aa1df4f@kernel.dk>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600009.china.huawei.com (7.193.23.164)

Hi,

在 2024/04/12 0:44, Jens Axboe 写道:
> On 4/10/24 9:23 PM, Yu Kuai wrote:
>> diff --git a/block/blk-core.c b/block/blk-core.c
>> index a16b5abdbbf5..e317d7bc0696 100644
>> --- a/block/blk-core.c
>> +++ b/block/blk-core.c
>> @@ -1195,6 +1195,7 @@ void __blk_flush_plug(struct blk_plug *plug, bool from_schedule)
>>   	if (unlikely(!rq_list_empty(plug->cached_rq)))
>>   		blk_mq_free_plug_rqs(plug);
>>   
>> +	plug->cur_ktime = 0;
>>   	current->flags &= ~PF_BLOCK_TS;
>>   }
> 
> We can just use blk_plug_invalidate_ts() here, but not really important.
> I think this one should go into 6.9, and patch 2 should go into 6.10,
> however.

This sounds great! Do you want me to update and send them separately?

Thanks,
Kuai

> 

