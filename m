Return-Path: <linux-kernel+bounces-70240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1983859524
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 07:51:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A752E1F22D19
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 06:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E6FFDF57;
	Sun, 18 Feb 2024 06:51:44 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18EA1C2D;
	Sun, 18 Feb 2024 06:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708239103; cv=none; b=suP6Syi8xJUdzAEjwB+vRnNwKKw+oDd7RAA+nVWO1AfnSNcgQxLRokriaMGhm+Z2VHHKAhpYHogqgUcnH4PpfIteLiMvqSXuAabOxF6wa/Dg17+31nFIxBHBKAoxfXbqfrjmoV7P+1goeHAqpYVdE0Xea8fYIMP8IROMnnj8bcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708239103; c=relaxed/simple;
	bh=zK9c6FwBwVDXoRjHdnQNM9afiWPdOLqWk2VjjhNyqio=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Tl5J7JWekwyZ7a/agM2Xqf8aTq9gCiHnN3XGSSrdPro4mrJqGX6p/11fhKihGiJx54x69oAWA+hUEV8gd/jYw+P8HlzhvGRtJFzQA3yvxeEEtwaysUYgfbNbOhvi16wwyzr4x1zUQpJgoHGdaHUzgorV6cb3Kz8ta1wX2dtMhGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TcxCp0VmLz4f3jqw;
	Sun, 18 Feb 2024 14:51:34 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 258C41A0232;
	Sun, 18 Feb 2024 14:51:37 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP1 (Coremail) with SMTP id cCh0CgAX5g7xqNFlCix9EQ--.31561S3;
	Sun, 18 Feb 2024 14:51:31 +0800 (CST)
Subject: Re: [PATCH v5 03/14] md: make sure md_do_sync() will set
 MD_RECOVERY_DONE
To: Xiao Ni <xni@redhat.com>, Yu Kuai <yukuai1@huaweicloud.com>
Cc: mpatocka@redhat.com, heinzm@redhat.com, blazej.kucman@linux.intel.com,
 agk@redhat.com, snitzer@kernel.org, dm-devel@lists.linux.dev,
 song@kernel.org, jbrassow@f14.redhat.com, neilb@suse.de, shli@fb.com,
 akpm@osdl.org, linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
 yi.zhang@huawei.com, yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20240201092559.910982-1-yukuai1@huaweicloud.com>
 <20240201092559.910982-4-yukuai1@huaweicloud.com>
 <CALTww283nysUDy=jmW4w45GbS6O2nS0XLYX=KEiO2BUp5+cLaA@mail.gmail.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <15f0f260-3a2f-6d9b-e60e-c534a9a4d7d0@huaweicloud.com>
Date: Sun, 18 Feb 2024 14:51:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CALTww283nysUDy=jmW4w45GbS6O2nS0XLYX=KEiO2BUp5+cLaA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAX5g7xqNFlCix9EQ--.31561S3
X-Coremail-Antispam: 1UD129KBjvJXoWxZFWfJFy7Kr1DZw1xuw1DGFg_yoWrXrWfpa
	y8JF90yr48ArW7ZrW2qa4DXFy5Zr10qrW5CFyfW34rA3Z8K3WS9ryUCFyUAFWvyF1xJa10
	vFs8JFZ3uF9YkaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9214x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kI
	c2xKxwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
	AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
	17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
	IF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Wr1j6rW3
	Jr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYx
	BIdaVFxhVjvjDU0xZFpf9x0JUQvtAUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2024/02/18 13:56, Xiao Ni 写道:
> On Thu, Feb 1, 2024 at 5:30 PM Yu Kuai <yukuai1@huaweicloud.com> wrote:
>>
>> From: Yu Kuai <yukuai3@huawei.com>
>>
>> stop_sync_thread() will interrupt md_do_sync(), and md_do_sync() must
>> set MD_RECOVERY_DONE, so that follow up md_check_recovery() will
>> unregister sync_thread, clear MD_RECOVERY_RUNNING and wake up
>> stop_sync_thread().
>>
>> If MD_RECOVERY_WAIT is set or the array is read-only, md_do_sync() will
>> return without setting MD_RECOVERY_DONE, and after commit f52f5c71f3d4
>> ("md: fix stopping sync thread"), dm-raid switch from
>> md_reap_sync_thread() to stop_sync_thread() to unregister sync_thread
>> from md_stop() and md_stop_writes(), causing the test
>> shell/lvconvert-raid-reshape.sh hang.
>>
>> We shouldn't switch back to md_reap_sync_thread() because it's
>> problematic in the first place. Fix the problem by making sure
>> md_do_sync() will set MD_RECOVERY_DONE.
>>
>> Reported-by: Mikulas Patocka <mpatocka@redhat.com>
>> Closes: https://lore.kernel.org/all/ece2b06f-d647-6613-a534-ff4c9bec1142@redhat.com/
>> Fixes: d5d885fd514f ("md: introduce new personality funciton start()")
>> Fixes: 5fd6c1dce06e ("[PATCH] md: allow checkpoint of recovery with version-1 superblock")
>> Fixes: f52f5c71f3d4 ("md: fix stopping sync thread")
>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>> ---
>>   drivers/md/md.c | 12 ++++++++----
>>   1 file changed, 8 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/md/md.c b/drivers/md/md.c
>> index 6906d023f1d6..c65dfd156090 100644
>> --- a/drivers/md/md.c
>> +++ b/drivers/md/md.c
>> @@ -8788,12 +8788,16 @@ void md_do_sync(struct md_thread *thread)
>>          int ret;
>>
>>          /* just incase thread restarts... */
>> -       if (test_bit(MD_RECOVERY_DONE, &mddev->recovery) ||
>> -           test_bit(MD_RECOVERY_WAIT, &mddev->recovery))
>> +       if (test_bit(MD_RECOVERY_DONE, &mddev->recovery))
>>                  return;
>> -       if (!md_is_rdwr(mddev)) {/* never try to sync a read-only array */
>> +
>> +       if (test_bit(MD_RECOVERY_INTR, &mddev->recovery))
>> +               goto skip;
>> +
>> +       if (test_bit(MD_RECOVERY_WAIT, &mddev->recovery) ||
>> +           !md_is_rdwr(mddev)) {/* never try to sync a read-only array */
>>                  set_bit(MD_RECOVERY_INTR, &mddev->recovery);
>> -               return;
>> +               goto skip;
>>          }
> 
> Hi all
> 
> I have a question here. The codes above means if MD_RECOVERY_WAIT is
> set, it sets MD_RECOVERY_INTR. If so, the sync thread can't happen.
> But from the codes in md_start function:
> 
>                  set_bit(MD_RECOVERY_WAIT, &mddev->recovery);
>                  md_wakeup_thread(mddev->thread);
>                  ret = mddev->pers->start(mddev);
>                  clear_bit(MD_RECOVERY_WAIT, &mddev->recovery);
>                  md_wakeup_thread(mddev->sync_thread);
> 
> MD_RECOVERY_WAIT means "it'll run sync thread later not interrupt it".
> I guess this patch can introduce a new bug for raid5 journal?

I'm not sure what kind of problem you're talking about. After patch 4,
md_start_sync() should be the only place to register sync_thread, hence
md_start() should not see registered sync_thread. Perhaps
MD_RECOVERY_WAIT and md_wakeup_thread(mddev->sync_thread) can be removed
after patch 4?

> 
> And to resolve this deadlock, we can use this patch:
> 
> --- a/drivers/md/dm-raid.c
> +++ b/drivers/md/dm-raid.c
> @@ -3796,8 +3796,10 @@ static void raid_postsuspend(struct dm_target *ti)
>          struct raid_set *rs = ti->private;
> 
>          if (!test_and_set_bit(RT_FLAG_RS_SUSPENDED, &rs->runtime_flags)) {
> +               if (test_bit(MD_RECOVERY_WAIT, &rs->md.recovery))
> +                       clear_bit(MD_RECOVERY_WAIT, &rs->md.recovery);

You must make sure md_do_sync() is called after this if sync_thread is 
already registered, and I don't understand yet how this is guranteed. :(

Thanks,
Kuai

> 
> Regards
> Xiao
>>
>>          if (mddev_is_clustered(mddev)) {
>> --
>> 2.39.2
>>
> 
> .
> 


