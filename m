Return-Path: <linux-kernel+bounces-55136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F69A84B845
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 15:46:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 355DB281C32
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 14:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BBA013249E;
	Tue,  6 Feb 2024 14:46:43 +0000 (UTC)
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFFA3A59;
	Tue,  6 Feb 2024 14:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707230803; cv=none; b=jyqo98j9va7KALPGMOhmA5qDQsVFFahQlz7nr3o82SEQwDbiE2U/Mz1My1uXVdrK4/GUGAybyDzSw0WOeapNvKFtSdR1YKEu9VcFXFuTww+i8utmymVDlfOCigQgZMvAeEqnLb4uTaOhy5/BxzmDOHbtZEZCVRB8dikg49Ni994=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707230803; c=relaxed/simple;
	bh=ZzXnpvwPJC6XGz40vdMnVlfhgML6fznUfbnkGiDItuc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kP8f1APLMXBqJXMNQdv8QR64b/A5U5TOE7ZxICLlDPVdu7T0MNGckayzcfPKmdFTJOwfqDxs4yyZ+/B8RFKI9pQ1YQKixP/hBwT1Ud/NTdqihEj1h+nB83iksTljREJux4SrpFGAwCieibo0u63MpveahNyChUJ8nfjfDGFyPJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rXMiY-0006tA-EV; Tue, 06 Feb 2024 15:46:34 +0100
Message-ID: <a92ca042-b981-4f35-beec-ebf416e4239b@leemhuis.info>
Date: Tue, 6 Feb 2024 15:46:33 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Re: [PATCH 2/2] md: create symlink with disk holder after mddev
 resume
Content-Language: en-US, de-DE
To: Yu Kuai <yukuai1@huaweicloud.com>, linan666@huaweicloud.com,
 song@kernel.org
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
 yi.zhang@huawei.com, houtao1@huawei.com, yangerkun@huawei.com,
 "yukuai (C)" <yukuai3@huawei.com>,
 Linux kernel regressions list <regressions@lists.linux.dev>
References: <20231221071109.1562530-1-linan666@huaweicloud.com>
 <20231221071109.1562530-3-linan666@huaweicloud.com>
 <3b240652-580e-73d5-a318-612984902aad@huaweicloud.com>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
In-Reply-To: <3b240652-580e-73d5-a318-612984902aad@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1707230801;15674f02;
X-HE-SMSGID: 1rXMiY-0006tA-EV

Hi, Thorsten here, the Linux kernel's regression tracker.

On 21.12.23 09:49, Yu Kuai wrote:
> 在 2023/12/21 15:11, linan666@huaweicloud.com 写道:
>> From: Li Nan <linan122@huawei.com>
>>
>> There is a risk of deadlock when a process gets disk->open_mutex after
>> suspending mddev, because other processes may hold open_mutex while
>> submitting io. For example:
>> [...]
> Nice catch! This patch looks good except that the new flag
> 'SymlinkCreated' doesn't look accurate, perhaps 'HolderLinked'
> will make more sense.
> 
>> Fix it by getting disk->open_mutex after mddev resume, iterating each
>> mddev->disk to create symlink for rdev which has not been created yet.
>> and moving bd_unlink_disk_holder() to mddev_unlock(), rdev has been
>> deleted from mddev->disks here, which can avoid concurrent bind and
>> unbind,
>>
>> Fixes: 1b0a2d950ee2 ("md: use new apis to suspend array for ioctls
>> involed array reconfiguration")

Hey, what happened to that patch? It looks a lot like things stalled
here. I'm asking, because there is a regression report that claims
1b0a2d950ee2 to be the culprit that might or might not be causes by the
problem this patch tries to fix:
https://bugzilla.kernel.org/show_bug.cgi?id=218459

Ciao, Thorsten

>> Signed-off-by: Li Nan <linan122@huawei.com>
>> ---
>>   drivers/md/md.c | 39 +++++++++++++++++++++++++++++----------
>>   1 file changed, 29 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/md/md.c b/drivers/md/md.c
>> index d6612b922c76..c128570f2a5d 100644
>> --- a/drivers/md/md.c
>> +++ b/drivers/md/md.c
>> @@ -521,6 +521,20 @@ void mddev_resume(struct mddev *mddev)
>>   }
>>   EXPORT_SYMBOL_GPL(mddev_resume);
>>   +static void md_link_disk_holder(struct mddev *mddev)
>> +{
>> +    struct md_rdev *rdev;
>> +
>> +    rcu_read_lock();
>> +    rdev_for_each_rcu(rdev, mddev) {
>> +        if (test_bit(SymlinkCreated, &rdev->flags))
>> +            continue;
>> +        if (!bd_link_disk_holder(rdev->bdev, mddev->gendisk))
>> +            set_bit(SymlinkCreated, &rdev->flags);
>> +    }
>> +    rcu_read_unlock();
>> +}
>> +
>>   /*
>>    * Generic flush handling for md
>>    */
>> @@ -902,6 +916,11 @@ void mddev_unlock(struct mddev *mddev)
>>         list_for_each_entry_safe(rdev, tmp, &delete, same_set) {
>>           list_del_init(&rdev->same_set);
>> +        if (test_bit(SymlinkCreated, &rdev->flags)) {
>> +            bd_unlink_disk_holder(rdev->bdev, rdev->mddev->gendisk);
>> +            clear_bit(SymlinkCreated, &rdev->flags);
>> +        }
>> +        rdev->mddev = NULL;
>>           kobject_del(&rdev->kobj);
>>           export_rdev(rdev, mddev);
>>       }
>> @@ -2526,8 +2545,6 @@ static int bind_rdev_to_array(struct md_rdev
>> *rdev, struct mddev *mddev)
>>           sysfs_get_dirent_safe(rdev->kobj.sd, "bad_blocks");
>>         list_add_rcu(&rdev->same_set, &mddev->disks);
>> -    if (!bd_link_disk_holder(rdev->bdev, mddev->gendisk))
>> -        set_bit(SymlinkCreated, &rdev->flags);
>>         /* May as well allow recovery to be retried once */
>>       mddev->recovery_disabled++;
>> @@ -2562,14 +2579,9 @@ static void md_kick_rdev_from_array(struct
>> md_rdev *rdev)
>>   {
>>       struct mddev *mddev = rdev->mddev;
>>   -    if (test_bit(SymlinkCreated, &rdev->flags)) {
>> -        bd_unlink_disk_holder(rdev->bdev, rdev->mddev->gendisk);
>> -        clear_bit(SymlinkCreated, &rdev->flags);
>> -    }
>>       list_del_rcu(&rdev->same_set);
>>       pr_debug("md: unbind<%pg>\n", rdev->bdev);
>>       mddev_destroy_serial_pool(rdev->mddev, rdev);
>> -    rdev->mddev = NULL;
>>       sysfs_remove_link(&rdev->kobj, "block");
>>       sysfs_put(rdev->sysfs_state);
>>       sysfs_put(rdev->sysfs_unack_badblocks);
>> @@ -4667,8 +4679,10 @@ new_dev_store(struct mddev *mddev, const char
>> *buf, size_t len)
>>       if (err)
>>           export_rdev(rdev, mddev);
>>       mddev_unlock_and_resume(mddev);
>> -    if (!err)
>> +    if (!err) {
>> +        md_link_disk_holder(mddev);
>>           md_new_event();
>> +    }
>>       return err ? err : len;
>>   }
>>   @@ -6606,6 +6620,7 @@ static void autorun_devices(int part)
>>               }
>>               autorun_array(mddev);
>>               mddev_unlock_and_resume(mddev);
>> +            md_link_disk_holder(mddev);
>>           }
>>           /* on success, candidates will be empty, on error
>>            * it won't...
>> @@ -7832,8 +7847,12 @@ static int md_ioctl(struct block_device *bdev,
>> blk_mode_t mode,
>>           err != -EINVAL)
>>           mddev->hold_active = 0;
>>   -    md_ioctl_need_suspend(cmd) ? mddev_unlock_and_resume(mddev) :
>> -                     mddev_unlock(mddev);
>> +    if (md_ioctl_need_suspend(cmd)) {
>> +        mddev_unlock_and_resume(mddev);
>> +        md_link_disk_holder(mddev);
>> +    } else {
>> +        mddev_unlock(mddev);
>> +    }
>>     out:
>>       if(did_set_md_closing)
>>
> 

