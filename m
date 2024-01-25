Return-Path: <linux-kernel+bounces-38540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79D8A83C139
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 12:45:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28144298D0E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 11:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E86E331743;
	Thu, 25 Jan 2024 11:45:16 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB1C2C699;
	Thu, 25 Jan 2024 11:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706183116; cv=none; b=VEF3kG/YvfWBMbXtXR1Jg1wkx3USxwcnTkEZgjnxFpfkWddv1f4egWgsBVWhZswad3Wvch74vXt8uiPLyuqNTRFzDthtlIGeDhWOo7CLczFLsqhu4dg9+Vx7UoW6YCYFDBYk5maaSXvYkIk4dWvmFhOOBmJsmxK9CzvpZasqUv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706183116; c=relaxed/simple;
	bh=/KlvnDkej06RFUIB4IDB8qeRoVJxxRl/FWR79xyazg8=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=mFATXhdnd8XHUwMJU2K/K59IrabBvt79vd0CzsC8dGpWu/N7sJZYticBgwkslAxcWJwqsFzOGSHGeSzW72J3m5HVg+mGTYOETFOVkO1GtOOGm0YG417OWheKR67+Xvh02/LzhrCOrEPaH9LBjhYT7QRt2+iCvpEppOXp8jnF2yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TLJsb6Q18z4f3jqX;
	Thu, 25 Jan 2024 19:45:07 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 469AA1A017A;
	Thu, 25 Jan 2024 19:45:10 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP1 (Coremail) with SMTP id cCh0CgCXaBHESbJlToa9Bw--.16693S3;
	Thu, 25 Jan 2024 19:45:10 +0800 (CST)
Subject: Re: [PATCH v2 05/11] md: export helpers to stop sync_thread
To: Xiao Ni <xni@redhat.com>
Cc: agk@redhat.com, snitzer@kernel.org, mpatocka@redhat.com,
 dm-devel@lists.linux.dev, song@kernel.org, neilb@suse.de, heinzm@redhat.com,
 shli@fb.com, akpm@osdl.org, linux-kernel@vger.kernel.org,
 linux-raid@vger.kernel.org, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
 yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20240124091421.1261579-1-yukuai3@huawei.com>
 <20240124091421.1261579-6-yukuai3@huawei.com>
 <CALTww2_V6Cr4j7hMPnMMt-g2w_xfCHQvwBpwbyOk=5rGcap6YA@mail.gmail.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <22874ce7-6f21-1e64-eee0-dc67df367d42@huaweicloud.com>
Date: Thu, 25 Jan 2024 19:45:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CALTww2_V6Cr4j7hMPnMMt-g2w_xfCHQvwBpwbyOk=5rGcap6YA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgCXaBHESbJlToa9Bw--.16693S3
X-Coremail-Antispam: 1UD129KBjvJXoWxXF4kury3tF4rXr45WFW5Awb_yoWrtFykpr
	Z7tF95ArWayrZxXr12q3WDuayYqw1IgFWqyrWfCa4fJas2krn7tr1Y93WUCFykCa4xuw1q
	ya1jqFsxuF18WF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kI
	c2xKxwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
	AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
	17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
	IF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq
	3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
	nIWIevJa73UjIFyTuYvjfUOmhFUUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2024/01/25 19:35, Xiao Ni 写道:
> Hi all
> 
> This is the result of lvm2 tests:
> make check
> ### 426 tests: 319 passed, 74 skipped, 0 timed out, 5 warned, 28
> failed   in 56:04.914

Are you testing with this patchset? 28 failed is much more than my
test result in following:

### 426 tests: 346 passed, 70 skipped, 0 timed out, 4 warned, 6 failed 
in 118:31.437
> make[1]: *** [Makefile:138: check] Error 1
> make[1]: Leaving directory '/root/lvm2/test'
> make: *** [Makefile:89: check] Error 2
> 
> Do you know where to check which cases fail?

I saved logs and grep keyword "failed:", and the result will look like
this:

###       failed: [ndev-vanilla] shell/duplicate-vgid.sh
###       failed: [ndev-vanilla] shell/fsadm-crypt.sh
###       failed: [ndev-vanilla] shell/lvchange-raid1-writemostly.sh
###       failed: [ndev-vanilla] shell/lvconvert-repair-raid.sh
###       failed: [ndev-vanilla] shell/lvextend-raid.sh
###       failed: [ndev-vanilla] shell/select-report.sh

BTW, you can find each test log in the dir（by default) test/result/.

Thanks,
Kuai

> 
> Best Regards
> Xiao
> 
> On Wed, Jan 24, 2024 at 5:19 PM Yu Kuai <yukuai3@huawei.com> wrote:
>>
>> The new heleprs will be used in dm-raid in later patches to fix
>> regressions and prevent calling md_reap_sync_thread() directly.
>>
>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>> ---
>>   drivers/md/md.c | 41 +++++++++++++++++++++++++++++++++++++----
>>   drivers/md/md.h |  3 +++
>>   2 files changed, 40 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/md/md.c b/drivers/md/md.c
>> index 6c5d0a372927..90cf31b53804 100644
>> --- a/drivers/md/md.c
>> +++ b/drivers/md/md.c
>> @@ -4915,30 +4915,63 @@ static void stop_sync_thread(struct mddev *mddev, bool locked, bool check_seq)
>>                  mddev_lock_nointr(mddev);
>>   }
>>
>> -static void idle_sync_thread(struct mddev *mddev)
>> +void md_idle_sync_thread(struct mddev *mddev)
>>   {
>> +       lockdep_assert_held(mddev->reconfig_mutex);
>> +
>>          mutex_lock(&mddev->sync_mutex);
>>          clear_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
>> +       stop_sync_thread(mddev, true, true);
>> +       mutex_unlock(&mddev->sync_mutex);
>> +}
>> +EXPORT_SYMBOL_GPL(md_idle_sync_thread);
>> +
>> +void md_frozen_sync_thread(struct mddev *mddev)
>> +{
>> +       lockdep_assert_held(mddev->reconfig_mutex);
>> +
>> +       mutex_lock(&mddev->sync_mutex);
>> +       set_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
>> +       stop_sync_thread(mddev, true, false);
>> +       mutex_unlock(&mddev->sync_mutex);
>> +}
>> +EXPORT_SYMBOL_GPL(md_frozen_sync_thread);
>>
>> +void md_unfrozen_sync_thread(struct mddev *mddev)
>> +{
>> +       lockdep_assert_held(mddev->reconfig_mutex);
>> +
>> +       mutex_lock(&mddev->sync_mutex);
>> +       clear_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
>> +       set_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
>> +       md_wakeup_thread(mddev->thread);
>> +       sysfs_notify_dirent_safe(mddev->sysfs_action);
>> +       mutex_unlock(&mddev->sync_mutex);
>> +}
>> +EXPORT_SYMBOL_GPL(md_unfrozen_sync_thread);
>> +
>> +static void idle_sync_thread(struct mddev *mddev)
>> +{
>>          if (mddev_lock(mddev)) {
>>                  mutex_unlock(&mddev->sync_mutex);
>>                  return;
>>          }
>>
>> +       mutex_lock(&mddev->sync_mutex);
>> +       clear_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
>>          stop_sync_thread(mddev, false, true);
>>          mutex_unlock(&mddev->sync_mutex);
>>   }
>>
>>   static void frozen_sync_thread(struct mddev *mddev)
>>   {
>> -       mutex_lock(&mddev->sync_mutex);
>> -       set_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
>> -
>>          if (mddev_lock(mddev)) {
>>                  mutex_unlock(&mddev->sync_mutex);
>>                  return;
>>          }
>>
>> +       mutex_lock(&mddev->sync_mutex);
>> +       set_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
>>          stop_sync_thread(mddev, false, false);
>>          mutex_unlock(&mddev->sync_mutex);
>>   }
>> diff --git a/drivers/md/md.h b/drivers/md/md.h
>> index 8d881cc59799..437ab70ce79b 100644
>> --- a/drivers/md/md.h
>> +++ b/drivers/md/md.h
>> @@ -781,6 +781,9 @@ extern void md_rdev_clear(struct md_rdev *rdev);
>>   extern void md_handle_request(struct mddev *mddev, struct bio *bio);
>>   extern int mddev_suspend(struct mddev *mddev, bool interruptible);
>>   extern void mddev_resume(struct mddev *mddev);
>> +extern void md_idle_sync_thread(struct mddev *mddev);
>> +extern void md_frozen_sync_thread(struct mddev *mddev);
>> +extern void md_unfrozen_sync_thread(struct mddev *mddev);
>>
>>   extern void md_reload_sb(struct mddev *mddev, int raid_disk);
>>   extern void md_update_sb(struct mddev *mddev, int force);
>> --
>> 2.39.2
>>
> 
> .
> 


