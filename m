Return-Path: <linux-kernel+bounces-44671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 794F88425BE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 14:05:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACDDA1C256C9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 13:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C30706A355;
	Tue, 30 Jan 2024 13:05:33 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2CD24C66;
	Tue, 30 Jan 2024 13:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706619933; cv=none; b=b2f0b8WJ6OfS+hGRc5y3n0y2k8dZ3UkKyEjiiZMthSu5H+qHghhdKfpOaEynRCq6mTx6nAaC1l+2XlxCBavtB2YVNxmfQhwiQL3Q8x7hyR7hVx7JnpbQN+EScbomHzdHGf+YMAiosN/kKmwHNp6F55tAWdnFJY9V+IDlEXZTRwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706619933; c=relaxed/simple;
	bh=5pKt9gawZv7V3M8KB+8lfendOF6qiXRbOvon5VS3kOk=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=lbFK6fL45qFELWG3vsZ9TPazsPd4gicw39Abliqy/auR4eu3iLeSJbxGOMhNfT/xmlG5tgpJOMPH2g7pljIOu3ZNAkVufR1AgEUw1GyOSdH78tNsbH7WfW+LNSxrKqCPr2GycCHzaIShJTYXnuETlXPvvkseF2GwQ1FxvmLxJcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TPQPr6Sx6z4f3lfy;
	Tue, 30 Jan 2024 21:05:20 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 61FAB1A0199;
	Tue, 30 Jan 2024 21:05:27 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP1 (Coremail) with SMTP id cCh0CgBnOBEV9LhlrAXNCQ--.25794S3;
	Tue, 30 Jan 2024 21:05:27 +0800 (CST)
Subject: Re: [PATCH RFC v4 13/14] dm: wait for IO completion before removing
 dm device
To: Mikulas Patocka <mpatocka@redhat.com>, Yu Kuai <yukuai1@huaweicloud.com>
Cc: heinzm@redhat.com, xni@redhat.com, agk@redhat.com, snitzer@kernel.org,
 dm-devel@lists.linux.dev, song@kernel.org, jbrassow@f14.redhat.com,
 neilb@suse.de, shli@fb.com, akpm@osdl.org, linux-kernel@vger.kernel.org,
 linux-raid@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20240130021843.3608859-1-yukuai1@huaweicloud.com>
 <20240130021843.3608859-14-yukuai1@huaweicloud.com>
 <fa4cd2f8-d0e8-5b6d-2ac6-1c5f1710a5ee@redhat.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <bdeac016-f57d-f917-d605-342fe9856ccf@huaweicloud.com>
Date: Tue, 30 Jan 2024 21:05:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <fa4cd2f8-d0e8-5b6d-2ac6-1c5f1710a5ee@redhat.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBnOBEV9LhlrAXNCQ--.25794S3
X-Coremail-Antispam: 1UD129KBjvJXoWxAr1DuFW5ur4rWF1kJw13urg_yoW5Cr4DpF
	Wftay3tFZ8Zr13Kw4jqa1UKF1FyF4SqryfGryIvw1fA3Zxur98JF48tFWrtFWUCFyUWF13
	AF1DXas5Gr4DJ3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9F14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kI
	c2xKxwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
	AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
	17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
	IF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq
	3wCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcS
	sGvfC2KfnxnUUI43ZEXa7VUbQVy7UUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

ÔÚ 2024/01/30 19:46, Mikulas Patocka Ð´µÀ:
> 
> 
> On Tue, 30 Jan 2024, Yu Kuai wrote:
> 
>> From: Yu Kuai <yukuai3@huawei.com>
>>
>> __dm_destroy() guarantee that device openers is zero, and then
>> only call 'presuspend' and 'postsuspend' for the target. For
>> request-based dm, 'md->holders' will be grabbed for each rq and
>> __dm_destroy() will wait for 'md->holders' to be zero. However, for
>> bio-based device, __dm_destroy() doesn't wait for all bios to be done.
>>
>> Fix this problem by calling dm_wait_for_completion() to wail for all
>> inflight IO to be done, like what dm_suspend() does.
> 
> If the number of openers is zero, it is guaranteed that there are no bios
> in flight. Therefore, we don't have to wait for them.
> 
> If there are bios in flight, it is a bug in the code that issues the bios.
> You can put WARN_ON(dm_in_flight_bios(md)) there.

I add this patch because while testing, there is a problem that is
hard to reporduce, as I mentioned in the other thread. I'll add BUG_ON()
and try if I can still reporduce this problem without triggering it.

Thanks,
Kuai

[12504.959682] BUG bio-296 (Not tainted): Object already free
[12504.960239] 
-----------------------------------------------------------------------------
[12504.960239]
[12504.961209] Allocated in mempool_alloc+0xe8/0x270 age=30 cpu=1 pid=203288
[12504.961905]  kmem_cache_alloc+0x36a/0x3b0
[12504.962324]  mempool_alloc+0xe8/0x270
[12504.962712]  bio_alloc_bioset+0x3b5/0x920
[12504.963129]  bio_alloc_clone+0x3e/0x160
[12504.963533]  alloc_io+0x3d/0x1f0
[12504.963876]  dm_submit_bio+0x12f/0xa30
[12504.964267]  __submit_bio+0x9c/0xe0
[12504.964639]  submit_bio_noacct_nocheck+0x25a/0x570
[12504.965136]  submit_bio_wait+0xc2/0x160
[12504.965535]  blkdev_issue_zeroout+0x19b/0x2e0
[12504.965991]  ext4_init_inode_table+0x246/0x560
[12504.966462]  ext4_lazyinit_thread+0x750/0xbe0
[12504.966922]  kthread+0x1b4/0x1f0
> 
> Mikulas
> 
>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>> ---
>>   drivers/md/dm.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/md/dm.c b/drivers/md/dm.c
>> index 8dcabf84d866..2c0eae67d0f1 100644
>> --- a/drivers/md/dm.c
>> +++ b/drivers/md/dm.c
>> @@ -58,6 +58,7 @@ static DEFINE_IDR(_minor_idr);
>>   static DEFINE_SPINLOCK(_minor_lock);
>>   
>>   static void do_deferred_remove(struct work_struct *w);
>> +static int dm_wait_for_completion(struct mapped_device *md, unsigned int task_state);
>>   
>>   static DECLARE_WORK(deferred_remove_work, do_deferred_remove);
>>   
>> @@ -2495,6 +2496,8 @@ static void __dm_destroy(struct mapped_device *md, bool wait)
>>   	if (!dm_suspended_md(md)) {
>>   		dm_table_presuspend_targets(map);
>>   		set_bit(DMF_SUSPENDED, &md->flags);
>> +		if (wait)
>> +			dm_wait_for_completion(md, TASK_UNINTERRUPTIBLE);
>>   		set_bit(DMF_POST_SUSPENDING, &md->flags);
>>   		dm_table_postsuspend_targets(map);
>>   	}
>> -- 
>> 2.39.2
>>
> 
> .
> 


