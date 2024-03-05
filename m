Return-Path: <linux-kernel+bounces-91880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E3CE8717CA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 09:15:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11EFB1C211D5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 08:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEC577FBAC;
	Tue,  5 Mar 2024 08:13:38 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71197F46A;
	Tue,  5 Mar 2024 08:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709626418; cv=none; b=V1SRk22hdPmrI63w+AbrYTAS7xEP5angUiBic6pVPXpiJG9nzVi7eH92I+t1/PoSA7zHJQWlFpSQVR42Hh0Iv0c56xl+f9JiWsaDjb7GUjRbl5muOiOS5jeF7RuVeCsoCW6CS8u5LZ7tZWnn0J3ryH8/DeeOFPXvvYERHBR5RVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709626418; c=relaxed/simple;
	bh=iYtQ7w6OR03PpXoCi1pmT13C/mStvkKFlUXkTHPzHiE=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=aRQ7t0+B4xDLy5kkeApdxaMurU+a7cdoKp/ZMw6kLWA+n0DIgSLUydJHNBlYZ3YrsBj+XeE5QPI0DObw5NVQmz0vtpDkJNzrygOlA0E5bspJ4IHYwcscgqytFLJU+gFm9RYbUZeqYjvdPI5ACsff0hvyF/2UKGQZanCI1VjApAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TppGr6dpkz4f3m7Y;
	Tue,  5 Mar 2024 16:13:24 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 675171A016E;
	Tue,  5 Mar 2024 16:13:32 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP1 (Coremail) with SMTP id cCh0CgDHlxAq1OZlzJIBGA--.18003S3;
	Tue, 05 Mar 2024 16:13:32 +0800 (CST)
Subject: Re: [PATCH md-6.8 v2 2/9] md: export helpers to stop sync_thread
To: Paul Menzel <pmenzel@molgen.mpg.de>, Yu Kuai <yukuai1@huaweicloud.com>
Cc: xni@redhat.com, zkabelac@redhat.com, agk@redhat.com, snitzer@kernel.org,
 mpatocka@redhat.com, dm-devel@lists.linux.dev, song@kernel.org,
 heinzm@redhat.com, jbrassow@redhat.com, neilb@suse.de,
 linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
 yi.zhang@huawei.com, yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20240305072306.2562024-1-yukuai1@huaweicloud.com>
 <20240305072306.2562024-3-yukuai1@huaweicloud.com>
 <c0e648ea-d73e-4805-a2bb-b02ddd3ca4e2@molgen.mpg.de>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <9950cb96-ac8b-d7dd-56a0-133709f51b5f@huaweicloud.com>
Date: Tue, 5 Mar 2024 16:13:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <c0e648ea-d73e-4805-a2bb-b02ddd3ca4e2@molgen.mpg.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgDHlxAq1OZlzJIBGA--.18003S3
X-Coremail-Antispam: 1UD129KBjvJXoWxCr45Jw1xGryfJw1rCF1UAwb_yoW5Kr4Dpr
	WvqF95ArWayrZ3Zr17Xa4DCa4Yvwn7Ka4DtryfA3yfJ3ZIkr1DKF15u3Wq9FykCa1rGr1j
	y3WjgFZ3ur1xJrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9I14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWr
	Zr1UMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJb
	IYCTnIWIevJa73UjIFyTuYvjfUOmhFUUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2024/03/05 16:08, Paul Menzel 写道:
> Dear Kuai,
> 
> 
> Thank you for your patch.
> 
> Am 05.03.24 um 08:22 schrieb Yu Kuai:
>> From: Yu Kuai <yukuai3@huawei.com>
>>
>> The new heleprs will be used in dm-raid in later patches to fix
> 
> hel*pe*rs
> 
>> regressions and prevent calling md_reap_sync_thread() directly.
> 
> Please list the new functions.
> 
> 1.  md_idle_sync_thread(struct mddev *mddev);
> 2.  md_frozen_sync_thread(struct mddev *mddev);
> 3.  md_unfrozen_sync_thread(struct mddev *mddev);
> 
> I do not like the naming so much. `md_reap_sync_thread()` has the verb 
> in imperative mood. At least myself, I would not know what the functions 
> do exactly without looking at the implementation.
> 
Thanks for the suggestions, I'm not that good at naming :(

Usually I'll send a new version with updated naming, however, we must
merge this set ASAP now, perhaps can we live with this for now?

Thanks,
Kuai

> 
> Kind regards,
> 
> Paul
> 
> 
>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>> Signed-off-by: Xiao Ni <xni@redhat.com>
>> Acked-by: Mike Snitzer <snitzer@kernel.org>
>> ---
>>   drivers/md/md.c | 29 +++++++++++++++++++++++++++++
>>   drivers/md/md.h |  3 +++
>>   2 files changed, 32 insertions(+)
>>
>> diff --git a/drivers/md/md.c b/drivers/md/md.c
>> index 23f31fd1d024..22e7512a5b1e 100644
>> --- a/drivers/md/md.c
>> +++ b/drivers/md/md.c
>> @@ -4919,6 +4919,35 @@ static void stop_sync_thread(struct mddev 
>> *mddev, bool locked, bool check_seq)
>>           mddev_lock_nointr(mddev);
>>   }
>> +void md_idle_sync_thread(struct mddev *mddev)
>> +{
>> +    lockdep_assert_held(&mddev->reconfig_mutex);
>> +
>> +    clear_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
>> +    stop_sync_thread(mddev, true, true);
>> +}
>> +EXPORT_SYMBOL_GPL(md_idle_sync_thread);
>> +
>> +void md_frozen_sync_thread(struct mddev *mddev)
>> +{
>> +    lockdep_assert_held(&mddev->reconfig_mutex);
>> +
>> +    set_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
>> +    stop_sync_thread(mddev, true, false);
>> +}
>> +EXPORT_SYMBOL_GPL(md_frozen_sync_thread);
>> +
>> +void md_unfrozen_sync_thread(struct mddev *mddev)
>> +{
>> +    lockdep_assert_held(&mddev->reconfig_mutex);
>> +
>> +    clear_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
>> +    set_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
>> +    md_wakeup_thread(mddev->thread);
>> +    sysfs_notify_dirent_safe(mddev->sysfs_action);
>> +}
>> +EXPORT_SYMBOL_GPL(md_unfrozen_sync_thread);
>> +
>>   static void idle_sync_thread(struct mddev *mddev)
>>   {
>>       mutex_lock(&mddev->sync_mutex);
>> diff --git a/drivers/md/md.h b/drivers/md/md.h
>> index 8d881cc59799..437ab70ce79b 100644
>> --- a/drivers/md/md.h
>> +++ b/drivers/md/md.h
>> @@ -781,6 +781,9 @@ extern void md_rdev_clear(struct md_rdev *rdev);
>>   extern void md_handle_request(struct mddev *mddev, struct bio *bio);
>>   extern int mddev_suspend(struct mddev *mddev, bool interruptible);
>>   extern void mddev_resume(struct mddev *mddev);
>> +extern void md_idle_sync_thread(struct mddev *mddev);
>> +extern void md_frozen_sync_thread(struct mddev *mddev);
>> +extern void md_unfrozen_sync_thread(struct mddev *mddev);
>>   extern void md_reload_sb(struct mddev *mddev, int raid_disk);
>>   extern void md_update_sb(struct mddev *mddev, int force);
> .
> 


