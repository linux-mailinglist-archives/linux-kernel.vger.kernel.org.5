Return-Path: <linux-kernel+bounces-70131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C83E8593CB
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 02:15:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C090D282554
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 01:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B618139B;
	Sun, 18 Feb 2024 01:15:08 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3894A5F;
	Sun, 18 Feb 2024 01:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708218907; cv=none; b=pO9dFk9hiQWTgi2aEpHp7OLtUTiszsK7Pxg5NnkX44DQRHqNbmatK5syG4vVl4c+th5LmSdq4snc4iu8sxL0wlrlCKuTxcTfSALzmJ6dSuHno2a1IuuqVqf6RzIPXomWr5kAOhzTY6hSsn86n1KzBG5LwdQVRngffhKCHlsLHnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708218907; c=relaxed/simple;
	bh=WNYcIjv6dxAPGu8R95Wts3twQDLv7SS0rU1XiqORXeI=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=eJsmSy4pyNOMZJWZA+Ys4lzC+XT7b9lQFdmxxlkDuLrLtidDc1eZS/FkibrFJpAx2D5H3vyUXVYg5SApcD6/VTIb/O/cp3GfgyJ+/TzmkhwcfEbXPlAb6f29syjixhmeplMi04FxyWZz2dOyjBt8auK8HyjAvd+G+CWNqfIh6uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4TcnlN1tqZz4f3jdm;
	Sun, 18 Feb 2024 09:14:56 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 1B7901A0172;
	Sun, 18 Feb 2024 09:15:01 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP1 (Coremail) with SMTP id cCh0CgDHlxARWtFll6JkEQ--.11973S3;
	Sun, 18 Feb 2024 09:14:59 +0800 (CST)
Subject: Re: [PATCH v5 01/14] md: don't ignore suspended array in
 md_check_recovery()
To: Xiao Ni <xni@redhat.com>, Yu Kuai <yukuai1@huaweicloud.com>
Cc: mpatocka@redhat.com, heinzm@redhat.com, blazej.kucman@linux.intel.com,
 agk@redhat.com, snitzer@kernel.org, dm-devel@lists.linux.dev,
 song@kernel.org, jbrassow@f14.redhat.com, neilb@suse.de, shli@fb.com,
 akpm@osdl.org, linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
 yi.zhang@huawei.com, yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20240201092559.910982-1-yukuai1@huaweicloud.com>
 <20240201092559.910982-2-yukuai1@huaweicloud.com>
 <CALTww2-ZhRBJOD3jXs=xKFaD=iR=dtoC9h2rUQi5Stpi+tJ9Bw@mail.gmail.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <64d27757-9387-09dc-48e8-a9eedd67f075@huaweicloud.com>
Date: Sun, 18 Feb 2024 09:14:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CALTww2-ZhRBJOD3jXs=xKFaD=iR=dtoC9h2rUQi5Stpi+tJ9Bw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgDHlxARWtFll6JkEQ--.11973S3
X-Coremail-Antispam: 1UD129KBjvJXoWxZFW7uF4kKr1UGFWfKw48Zwb_yoW5Aw1fpa
	yI9F1YkrWUAFW7Ca42g3WDZa4rtw1YgrW7Ary3G34rAas3Gw1fGFWFgFW5XF1qyF1IgF4v
	qa15Jay5uw18KF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9F14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E
	3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcS
	sGvfC2KfnxnUUI43ZEXa7VUbQVy7UUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2024/02/16 14:58, Xiao Ni 写道:
> On Thu, Feb 1, 2024 at 5:30 PM Yu Kuai <yukuai1@huaweicloud.com> wrote:
>>
>> From: Yu Kuai <yukuai3@huawei.com>
>>
>> mddev_suspend() never stop sync_thread, hence it doesn't make sense to
>> ignore suspended array in md_check_recovery(), which might cause
>> sync_thread can't be unregistered.
>>
>> After commit f52f5c71f3d4 ("md: fix stopping sync thread"), following
>> hang can be triggered by test shell/integrity-caching.sh:
> 
> Hi Kuai
> 
> After applying this patch, it's still stuck at mddev_suspend. Maybe
> the deadlock can be fixed by other patches from the patch set. But
> this patch can't fix this issue. If so, the comment is not right.

This patch alone can't fix the problem that mddev_suspend() can stuck
thoroughly, patches 1-4 will all be needed.

Thanks,
Kuai

> 
>>
>> 1) suspend the array:
>> raid_postsuspend
>>   mddev_suspend
>>
>> 2) stop the array:
>> raid_dtr
>>   md_stop
>>    __md_stop_writes
>>     stop_sync_thread
>>      set_bit(MD_RECOVERY_INTR, &mddev->recovery);
>>      md_wakeup_thread_directly(mddev->sync_thread);
>>      wait_event(..., !test_bit(MD_RECOVERY_RUNNING, &mddev->recovery))
>>
>> 3) sync thread done:
>> md_do_sync
>>   set_bit(MD_RECOVERY_DONE, &mddev->recovery);
>>   md_wakeup_thread(mddev->thread);
>>
>> 4) daemon thread can't unregister sync thread:
>> md_check_recovery
>>   if (mddev->suspended)
>>     return; -> return directly
>>   md_read_sync_thread
>>   clear_bit(MD_RECOVERY_RUNNING, &mddev->recovery);
>>   -> MD_RECOVERY_RUNNING can't be cleared, hence step 2 hang;
> 
> I add some debug logs when stopping dmraid with lvremove command. The
> step you mentioned are sequential but not async. The process is :
> dev_remove->dm_destroy->__dm_destroy->dm_table_postsuspend_targets(raid_postsuspend)
> -> dm_table_destroy(raid_dtr). It looks like mddev_suspend is waiting
> for active_io to be zero.
> 
> Best Regards
> Xiao
> 
>> This problem is not just related to dm-raid, fix it by ignoring
>> suspended array in md_check_recovery(). And follow up patches will
>> improve dm-raid better to frozen sync thread during suspend.
>>
>> Reported-by: Mikulas Patocka <mpatocka@redhat.com>
>> Closes: https://lore.kernel.org/all/8fb335e-6d2c-dbb5-d7-ded8db5145a@redhat.com/
>> Fixes: 68866e425be2 ("MD: no sync IO while suspended")
>> Fixes: f52f5c71f3d4 ("md: fix stopping sync thread")
>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>> ---
>>   drivers/md/md.c | 3 ---
>>   1 file changed, 3 deletions(-)
>>
>> diff --git a/drivers/md/md.c b/drivers/md/md.c
>> index 2266358d8074..07b80278eaa5 100644
>> --- a/drivers/md/md.c
>> +++ b/drivers/md/md.c
>> @@ -9469,9 +9469,6 @@ static void md_start_sync(struct work_struct *ws)
>>    */
>>   void md_check_recovery(struct mddev *mddev)
>>   {
>> -       if (READ_ONCE(mddev->suspended))
>> -               return;
>> -
>>          if (mddev->bitmap)
>>                  md_bitmap_daemon_work(mddev);
>>
>> --
>> 2.39.2
>>
> 
> 
> .
> 


