Return-Path: <linux-kernel+bounces-45597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50E668432D2
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 02:35:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0863A28BE23
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 01:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C7DF4C98;
	Wed, 31 Jan 2024 01:35:30 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6785C184F;
	Wed, 31 Jan 2024 01:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706664930; cv=none; b=KXjoNdIg9rSwKduIImU771Frq35TK9MPSk+EAWlUAYuWGn/t505GUlnvcCjtQ4GwgICM4lj+x0C7B2BkbwXsUSzJXBOI1x8JoK+Jv15tnyavNJom0i7O+KuZXxN6MTKJom0YylYw2xFjEUemiJ/lZDYy7HwSRLig81hlqYqqdng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706664930; c=relaxed/simple;
	bh=CuQjcQuAmEkPkmyb0SvGF+nig/i1YTNHqIXMZJ3S874=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=KQ/4uc5yPz6TJl0qlAUpUK2Of3IzsytECQs+iWrlHIS1l35ycHe0Hab9E8NAtyEBq/rsYQNBySk5EBRox28hM5mEohnMo8s+yrmEFV5lnfjeocwyHrbezclOFeltiWOZkhaPVoWSmvQNto+XZAJD+JPbhysa1/vSzo1ngaqREKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4TPl3D16bYz4f3kp9;
	Wed, 31 Jan 2024 09:35:20 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 4DD571A017A;
	Wed, 31 Jan 2024 09:35:24 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP1 (Coremail) with SMTP id cCh0CgDHlxDao7llkjUCCg--.59959S3;
	Wed, 31 Jan 2024 09:35:24 +0800 (CST)
Subject: Re: [PATCH RFC v4 13/14] dm: wait for IO completion before removing
 dm device
To: Yu Kuai <yukuai1@huaweicloud.com>, Mikulas Patocka <mpatocka@redhat.com>
Cc: heinzm@redhat.com, xni@redhat.com, agk@redhat.com, snitzer@kernel.org,
 dm-devel@lists.linux.dev, song@kernel.org, jbrassow@f14.redhat.com,
 neilb@suse.de, shli@fb.com, akpm@osdl.org, linux-kernel@vger.kernel.org,
 linux-raid@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20240130021843.3608859-1-yukuai1@huaweicloud.com>
 <20240130021843.3608859-14-yukuai1@huaweicloud.com>
 <fa4cd2f8-d0e8-5b6d-2ac6-1c5f1710a5ee@redhat.com>
 <bdeac016-f57d-f917-d605-342fe9856ccf@huaweicloud.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <b3c80659-8879-6e7c-e732-5fb690b7bc97@huaweicloud.com>
Date: Wed, 31 Jan 2024 09:35:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <bdeac016-f57d-f917-d605-342fe9856ccf@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgDHlxDao7llkjUCCg--.59959S3
X-Coremail-Antispam: 1UD129KBjvJXoWxXrWxCw4kZFyUZFyrJr4kCrg_yoW5KF43pF
	Wfta43ArZ8Jr18Kw4jqa4UtFyYyF4Fq343WryxZFyxJrn3Cr90gF47XryFgFWDAFW8WF1a
	vF1DJas3ur4DJwUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9214x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWr
	Zr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYx
	BIdaVFxhVjvjDU0xZFpf9x0JUAxhLUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2024/01/30 21:05, Yu Kuai 写道:
> Hi,
> 
> 在 2024/01/30 19:46, Mikulas Patocka 写道:
>>
>>
>> On Tue, 30 Jan 2024, Yu Kuai wrote:
>>
>>> From: Yu Kuai <yukuai3@huawei.com>
>>>
>>> __dm_destroy() guarantee that device openers is zero, and then
>>> only call 'presuspend' and 'postsuspend' for the target. For
>>> request-based dm, 'md->holders' will be grabbed for each rq and
>>> __dm_destroy() will wait for 'md->holders' to be zero. However, for
>>> bio-based device, __dm_destroy() doesn't wait for all bios to be done.
>>>
>>> Fix this problem by calling dm_wait_for_completion() to wail for all
>>> inflight IO to be done, like what dm_suspend() does.
>>
>> If the number of openers is zero, it is guaranteed that there are no bios
>> in flight. Therefore, we don't have to wait for them.
>>
>> If there are bios in flight, it is a bug in the code that issues the 
>> bios.
>> You can put WARN_ON(dm_in_flight_bios(md)) there.
> 
> I add this patch because while testing, there is a problem that is
> hard to reporduce, as I mentioned in the other thread. I'll add BUG_ON()
> and try if I can still reporduce this problem without triggering it.
> 
> Thanks,
> Kuai
> 
> [12504.959682] BUG bio-296 (Not tainted): Object already free
> [12504.960239] 
> ----------------------------------------------------------------------------- 
> 
> [12504.960239]
> [12504.961209] Allocated in mempool_alloc+0xe8/0x270 age=30 cpu=1 
> pid=203288
> [12504.961905]  kmem_cache_alloc+0x36a/0x3b0
> [12504.962324]  mempool_alloc+0xe8/0x270
> [12504.962712]  bio_alloc_bioset+0x3b5/0x920
> [12504.963129]  bio_alloc_clone+0x3e/0x160
> [12504.963533]  alloc_io+0x3d/0x1f0
> [12504.963876]  dm_submit_bio+0x12f/0xa30
> [12504.964267]  __submit_bio+0x9c/0xe0
> [12504.964639]  submit_bio_noacct_nocheck+0x25a/0x570
> [12504.965136]  submit_bio_wait+0xc2/0x160
> [12504.965535]  blkdev_issue_zeroout+0x19b/0x2e0
> [12504.965991]  ext4_init_inode_table+0x246/0x560
> [12504.966462]  ext4_lazyinit_thread+0x750/0xbe0
> [12504.966922]  kthread+0x1b4/0x1f0

After adding the BUG_ON(), I can still reporducing this BUG, this really
looks like a BUG, and I don't think this is related to dm-raid. Perhaps
you guys can take a look?

Thanks,
Kuai

>>
>> Mikulas
>>
>>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>>> ---
>>>   drivers/md/dm.c | 3 +++
>>>   1 file changed, 3 insertions(+)
>>>
>>> diff --git a/drivers/md/dm.c b/drivers/md/dm.c
>>> index 8dcabf84d866..2c0eae67d0f1 100644
>>> --- a/drivers/md/dm.c
>>> +++ b/drivers/md/dm.c
>>> @@ -58,6 +58,7 @@ static DEFINE_IDR(_minor_idr);
>>>   static DEFINE_SPINLOCK(_minor_lock);
>>>   static void do_deferred_remove(struct work_struct *w);
>>> +static int dm_wait_for_completion(struct mapped_device *md, unsigned 
>>> int task_state);
>>>   static DECLARE_WORK(deferred_remove_work, do_deferred_remove);
>>> @@ -2495,6 +2496,8 @@ static void __dm_destroy(struct mapped_device 
>>> *md, bool wait)
>>>       if (!dm_suspended_md(md)) {
>>>           dm_table_presuspend_targets(map);
>>>           set_bit(DMF_SUSPENDED, &md->flags);
>>> +        if (wait)
>>> +            dm_wait_for_completion(md, TASK_UNINTERRUPTIBLE);
>>>           set_bit(DMF_POST_SUSPENDING, &md->flags);
>>>           dm_table_postsuspend_targets(map);
>>>       }
>>> -- 
>>> 2.39.2
>>>
>>
>> .
>>
> 
> .
> 


