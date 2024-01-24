Return-Path: <linux-kernel+bounces-36392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F97A839FF9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 04:14:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD9CB1C23AA6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 03:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 404085C85;
	Wed, 24 Jan 2024 03:14:30 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2201D46BF;
	Wed, 24 Jan 2024 03:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706066069; cv=none; b=bRBePVbFlsS55/lFPCd8Bd9EPLcj7c7QCqxtMyjG5cv5ymKYafRK56ewjqlYGWwerUyPHKO2BvWMzkiRJxj1DE84SAUqoxtSKKa1JXld0r8iAr4WUZuuGdoi1mRnNhX7PeHD7OPsoN8HWa0nWkydQxicrmXs+Z2WMHn94+boqAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706066069; c=relaxed/simple;
	bh=g3vDQVNYQHCfXhK9AZEZvl7enAqSQCJdQIj+M8vN8m8=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=mUq5zyRHNpFRzsFXghDVRAHwbI55cRBl6rrlNrVeEWKN+zl/lqUy7jSKPNTAOfnLGtguYduhZemSIMdqTC+FtW8LCSFpvWNrt+UcwrkiE/tDFrrA+NlB3ZOg6Gb0rjuAbCybFDCxfZQu2kkiQIEh5aQThriezsuokESBKRWrVRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TKTZd0SHRz4f3lgR;
	Wed, 24 Jan 2024 11:14:17 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 58BB11A017A;
	Wed, 24 Jan 2024 11:14:23 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP1 (Coremail) with SMTP id cCh0CgBXKBGNgLBloWgsBw--.40402S3;
	Wed, 24 Jan 2024 11:14:23 +0800 (CST)
Subject: Re: [PATCH 3/5] md: make sure md_do_sync() will set MD_RECOVERY_DONE
To: Xiao Ni <xni@redhat.com>, Yu Kuai <yukuai1@huaweicloud.com>
Cc: mpatocka@redhat.com, dm-devel@lists.linux.dev, msnitzer@redhat.com,
 heinzm@redhat.com, song@kernel.org, linux-raid@vger.kernel.org,
 linux-kernel@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20240120103734.4155446-1-yukuai1@huaweicloud.com>
 <20240120103734.4155446-4-yukuai1@huaweicloud.com>
 <CALTww28NL+yBT8bcL2=ATJr79eL45=TF-EXHUD8NsfCXXTG3Qw@mail.gmail.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <c024a07e-0a93-aaad-a946-ac74ae3bdaeb@huaweicloud.com>
Date: Wed, 24 Jan 2024 11:14:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CALTww28NL+yBT8bcL2=ATJr79eL45=TF-EXHUD8NsfCXXTG3Qw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBXKBGNgLBloWgsBw--.40402S3
X-Coremail-Antispam: 1UD129KBjvJXoWxWF15Gw13GFWfWr18tFW5ZFb_yoW5Ww15p3
	y8GFn0krW8Ary29F9Fqa4YqFyY9r4FyrZ8CFyfWwn8Ar93Kr13GFy0ka1UZFWDAF1fJa10
	va15JF9xZFyFkFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4U
	JVW0owA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kI
	c2xKxwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
	AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
	17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
	IF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq
	3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
	nIWIevJa73UjIFyTuYvjfUoOJ5UUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2024/01/24 10:58, Xiao Ni 写道:
> Hi all
> 
> MD_RECOVERY_WAIT was introduced in d5d885fd5. From this patch,
> MD_RECOVERY_WAIT only has one usage during creating raid device.
> resync job needs to wait until pers->start finishes(The only place
> which is checked). If we remove it from md_do_sync, will it break the
> logic? Or we don't need this flag anymore? If so can we remove this
> flag?
> 
> dm-raid uses this bit in patch 644e2537f (dm raid: fix stripe adding
> reshape deadlock). It's the reason why md_do_sync can't set
> MD_RECOVERY_DONE. Now we stop sync thread asynchronously, can we
> revert this patch?

I made some changes that will be sent for v2 that sync_thread is frozen
from dm suspend to resume, so I think the flag can be removed, and I
actually tried that, howver, dm-raid tests failed because ext4 is
corrupted. Anyway, let's focus on dm-raid regression for now and we can
try to remove this flag later.

Thanks,
Kuai

> 
> Best Regards
> Xiao
> 
> On Sat, Jan 20, 2024 at 6:41 PM Yu Kuai <yukuai1@huaweicloud.com> wrote:
>>
>> From: Yu Kuai <yukuai3@huawei.com>
>>
>> stop_sync_thread() will interrupt md_do_sync(), and md_do_sync() must
>> set MD_RECOVERY_DONE, so that follow up md_check_recovery() will
>> unregister sync_thread, clear MD_RECOVERY_RUNNING and wake up
>> stop_sync_thread().
>>
>> Before this patch, if MD_RECOVERY_WAIT is set or the array is read-only,
>> md_do_sync() will return without setting MD_RECOVERY_DONE, hence use
>> stop_sync_thread() directly will hang because md_check_recovery() can't
>> clear MD_RECOVERY_RUNNING, which is possible for dm-raid.
>>
>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>> ---
>>   drivers/md/md.c | 10 ++++++----
>>   1 file changed, 6 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/md/md.c b/drivers/md/md.c
>> index 6906d023f1d6..ba45c7be3dbe 100644
>> --- a/drivers/md/md.c
>> +++ b/drivers/md/md.c
>> @@ -8788,12 +8788,13 @@ void md_do_sync(struct md_thread *thread)
>>          int ret;
>>
>>          /* just incase thread restarts... */
>> -       if (test_bit(MD_RECOVERY_DONE, &mddev->recovery) ||
>> -           test_bit(MD_RECOVERY_WAIT, &mddev->recovery))
>> +       if (test_bit(MD_RECOVERY_DONE, &mddev->recovery))
>>                  return;
>> -       if (!md_is_rdwr(mddev)) {/* never try to sync a read-only array */
>> +
>> +       if (test_bit(MD_RECOVERY_WAIT, &mddev->recovery) ||
>> +           !md_is_rdwr(mddev)) {/* never try to sync a read-only array */
>>                  set_bit(MD_RECOVERY_INTR, &mddev->recovery);
>> -               return;
>> +               goto out;
>>          }
>>
>>          if (mddev_is_clustered(mddev)) {
>> @@ -9171,6 +9172,7 @@ void md_do_sync(struct md_thread *thread)
>>                                                  mddev->array_sectors);
>>          }
>>
>> +out:
>>          spin_lock(&mddev->lock);
>>          if (!test_bit(MD_RECOVERY_INTR, &mddev->recovery)) {
>>                  /* We completed so min/max setting can be forgotten if used. */
>> --
>> 2.39.2
>>
>>
> 
> .
> 


