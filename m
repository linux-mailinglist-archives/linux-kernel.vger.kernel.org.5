Return-Path: <linux-kernel+bounces-38539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDB4583C135
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 12:42:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0A191C22B63
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 11:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3955B321AA;
	Thu, 25 Jan 2024 11:42:42 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6EB42C69D;
	Thu, 25 Jan 2024 11:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706182961; cv=none; b=ArRxdid3gHT/IXI+jJ8MUFau9CIcfLru+j2r2qA46StA+Tg3G+4k+7iytAewiTuBAB33qzpse81sXxObuSF1poIc6AFj+K5n7YpP+OvZHFaW/XzZsOOTktUHu2we4CT4poemsJsZJC46dQyrNwv5RcyuCci5nMR8e46zuHzIxX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706182961; c=relaxed/simple;
	bh=4200f1qVc9nUnWxLTRgmUOlP3RJ0hwGAZtZceO/Y+bc=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Z+LqXGSdHiUGVA+tocQfcqG/oNUsgZhLMGWbdW2G+Hmu2ab7UXSJZIsOg3bn7srWHwaw/54Xk4iuWzXjIPiWZO+Yb0/8SR6R4njlGJLEsyOraWcBWC2GjzdtEG/GgHObBSwFAhf6i9SL9vmf5yqxAbyXS1o8BCoAd1qw3NVQB5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4TLJnS2pg5z18LWF;
	Thu, 25 Jan 2024 19:41:32 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (unknown [7.193.23.164])
	by mail.maildlp.com (Postfix) with ESMTPS id 69C9A140487;
	Thu, 25 Jan 2024 19:42:36 +0800 (CST)
Received: from [10.174.176.73] (10.174.176.73) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 25 Jan 2024 19:42:35 +0800
Subject: Re: [PATCH v2 05/11] md: export helpers to stop sync_thread
To: Xiao Ni <xni@redhat.com>
CC: <agk@redhat.com>, <snitzer@kernel.org>, <mpatocka@redhat.com>,
	<dm-devel@lists.linux.dev>, <song@kernel.org>, <neilb@suse.de>,
	<heinzm@redhat.com>, <shli@fb.com>, <akpm@osdl.org>,
	<linux-kernel@vger.kernel.org>, <linux-raid@vger.kernel.org>,
	<yukuai1@huaweicloud.com>, <yi.zhang@huawei.com>, <yangerkun@huawei.com>
References: <20240124091421.1261579-1-yukuai3@huawei.com>
 <20240124091421.1261579-6-yukuai3@huawei.com>
 <CALTww2_V6Cr4j7hMPnMMt-g2w_xfCHQvwBpwbyOk=5rGcap6YA@mail.gmail.com>
From: Yu Kuai <yukuai3@huawei.com>
Message-ID: <d7b8043e-c921-8769-f39f-5105f2e866b6@huawei.com>
Date: Thu, 25 Jan 2024 19:42:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CALTww2_V6Cr4j7hMPnMMt-g2w_xfCHQvwBpwbyOk=5rGcap6YA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600009.china.huawei.com (7.193.23.164)

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

> make[1]: *** [Makefile:138: check] Error 1
> make[1]: Leaving directory '/root/lvm2/test'
> make: *** [Makefile:89: check] Error 2
> 
> Do you know where to check which cases fail?

I saved logs and grep keyword "failed:", and the result will look like
this:


You can find each test log in the dir test/result/
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

