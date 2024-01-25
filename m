Return-Path: <linux-kernel+bounces-37847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E8A8883B663
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 02:09:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53F37B20F3D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 01:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B7FC1877;
	Thu, 25 Jan 2024 01:09:10 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72AE27E1;
	Thu, 25 Jan 2024 01:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706144949; cv=none; b=ZxkdaOncERfGxcNNeVL98ymwPYNOt/whxneOOKZ6UA1pLShXC6jWKGjKfVVQqsRz8nkznZshDJfEb4uRFPrjlrTVKY/objKIIg7AYSwj8jiyUpJPIRGAmDZfMQ0tY58yeDiqP8OTobuzZY/OOtIdie4C46TNXLISKnsFk+4dO2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706144949; c=relaxed/simple;
	bh=DLKo5zqJOphP7s/xspolDgNhsyMTRKFCspsbqI7wfTA=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Dyx9DDK16wOHBS8tKNoXek8DsjVDbBCQWFBt1Tm6vAvopkW3q76X2EsojJgAFnZdFEAxkXkHc9W4kbsBmRE3K5nk1yG8XL3zkqnLlTc/jL8M5C1AI3FjxVtQl4apRGhjH+0P7V9ba0knzeWXZck2Gmfq/GXOB0A2ZHRpZIrYzhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4TL2lZ2l1kz4f3jJ0;
	Thu, 25 Jan 2024 09:08:58 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 525161A0172;
	Thu, 25 Jan 2024 09:09:02 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP1 (Coremail) with SMTP id cCh0CgAX6RGstLFl0+SNBw--.50668S3;
	Thu, 25 Jan 2024 09:09:02 +0800 (CST)
Subject: Re: [PATCH v2 00/11] dm-raid: fix v6.7 regressions
To: Song Liu <song@kernel.org>, mpatocka@redhat.com,
 dm-devel@lists.linux.dev, snitzer@kernel.org, agk@redhat.com
Cc: xni@redhat.com, jbrassow@f14.redhat.com, neilb@suse.de,
 heinzm@redhat.com, shli@fb.com, akpm@osdl.org, linux-kernel@vger.kernel.org,
 linux-raid@vger.kernel.org, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
 yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20240124091421.1261579-1-yukuai3@huawei.com>
 <CAPhsuW4aqpQfQvBaeDaiJwOOOy-XspdDjAdvQVfFBEvHN-WUQA@mail.gmail.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <216fbc61-4f71-3796-5ec1-2e4cfa815ced@huaweicloud.com>
Date: Thu, 25 Jan 2024 09:08:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAPhsuW4aqpQfQvBaeDaiJwOOOy-XspdDjAdvQVfFBEvHN-WUQA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAX6RGstLFl0+SNBw--.50668S3
X-Coremail-Antispam: 1UD129KBjvJXoWxCw15XryUJr13XF1fAr4ruFg_yoWrtF18pa
	yj93WYqr48CrnavrZ7t3W0qFW0kF95Jr98GF95J34UA34FkF1IyrWxGayj9FWkCw15Gw4Y
	vr45ta43ua4qyaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
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
	3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
	nIWIevJa73UjIFyTuYvjfUOmhFUUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2024/01/25 8:46, Song Liu 写道:
> On Wed, Jan 24, 2024 at 1:18 AM Yu Kuai <yukuai3@huawei.com> wrote:
>>
>> First regression related to stop sync thread:
>>
>> The lifetime of sync_thread is designed as following:
>>
>> 1) Decide want to start sync_thread, set MD_RECOVERY_NEEDED, and wake up
>> daemon thread;
>> 2) Daemon thread detect that MD_RECOVERY_NEEDED is set, then set
>> MD_RECOVERY_RUNNING and register sync_thread;
>> 3) Execute md_do_sync() for the actual work, if it's done or
>> interrupted, it will set MD_RECOVERY_DONE and wake up daemone thread;
>> 4) Daemon thread detect that MD_RECOVERY_DONE is set, then clear
>> MD_RECOVERY_RUNNING and unregister sync_thread;
>>
>> In v6.7, we fix md/raid to follow this design by commit f52f5c71f3d4
>> ("md: fix stopping sync thread"), however, dm-raid is not considered at
>> that time, and following test will hang:
>>
>> shell/integrity-caching.sh
>> shell/lvconvert-raid-reshape.sh
>>
>> This patch set fix the broken test by patch 1-4;
>>   - patch 1 fix that step 4) is broken by suspended array;
>>   - patch 2 fix that step 4) is broken by read-only array;
>>   - patch 3 fix that step 3) is broken that md_do_sync() doesn't set
>>   MD_RECOVERY_DONE; Noted that this patch will introdece new problem that
>>   data will be corrupted, which will be fixed in later patches.
>>   - patch 4 fix that setp 1) is broken that sync_thread is register and
>>   MD_RECOVERY_RUNNING is set directly;
>>
>> With patch 1-4, the above test won't hang anymore, however, the test
>> will still fail and complain that ext4 is corrupted;
>>
>> Second regression related to frozen sync thread:
>>
>> Noted that for raid456, if reshape is interrupted, then call
>> "pers->start_reshape" will corrupt data. This is because dm-raid rely on
>> md_do_sync() doesn't set MD_RECOVERY_DONE so that new sync_thread won't
>> be registered, and patch 3 just break this.
>>
>>   - Patch 5-6 fix this problem by interrupting reshape and frozen
>>   sync_thread in dm_suspend(), then unfrozen and continue reshape in
>> dm_resume(). It's verified that dm-raid tests won't complain that
>> ext4 is corrupted anymore.
>>   - Patch 7 fix the problem that raid_message() call
>>   md_reap_sync_thread() directly, without holding 'reconfig_mutex'.
>>
>> Last regression related to dm-raid456 IO concurrent with reshape:
>>
>> For raid456, if reshape is still in progress, then IO across reshape
>> position will wait for reshape to make progress. However, for dm-raid,
>> in following cases reshape will never make progress hence IO will hang:
>>
>> 1) the array is read-only;
>> 2) MD_RECOVERY_WAIT is set;
>> 3) MD_RECOVERY_FROZEN is set;
>>
>> After commit c467e97f079f ("md/raid6: use valid sector values to determine
>> if an I/O should wait on the reshape") fix the problem that IO across
>> reshape position doesn't wait for reshape, the dm-raid test
>> shell/lvconvert-raid-reshape.sh start to hang at raid5_make_request().
>>
>> For md/raid, the problem doesn't exist because:
>>
>> 1) If array is read-only, it can switch to read-write by ioctl/sysfs;
>> 2) md/raid never set MD_RECOVERY_WAIT;
>> 3) If MD_RECOVERY_FROZEN is set, mddev_suspend() doesn't hold
>>     'reconfig_mutex' anymore, it can be cleared and reshape can continue by
>>     sysfs api 'sync_action'.
>>
>> However, I'm not sure yet how to avoid the problem in dm-raid yet.
>>
>>   - patch 9-11 fix this problem by detecting the above 3 cases in
>>   dm_suspend(), and fail those IO directly.
>>
>> If user really meet the IO error, then it means they're reading the wrong
>> data before c467e97f079f. And it's safe to read/write the array after
>> reshape make progress successfully.
> 
> c467e97f079f got back ported to stable kernels (6.6.13, for example). We
> will need some fixes for them (to fix shell/lvconvert-raid-reshape.sh).
> 
> Mikulas and folks, please help review the analysis above and dm-raid
> changes. The failure was triggered by c467e97f079f. However, the commit
> is doing the right thing, so we really shouldn't revert it.
> 
>>
>> Tests:
>>
>> I already run the following two tests many times and verified that they
>> won't fail anymore:
>>
>> shell/integrity-caching.sh
>> shell/lvconvert-raid-reshape.sh
> 
> shell/lvconvert-raid-reshape-linear_to_raid6-single-type.sh is failing
> with upstream + this set. (I need to fix some trivial compilation errors,
> which are probably last minute typos).

I'm running test for this patchset overnight in my vm, and this test has
been ran for 9 times and all passed. Looks like I can't reporduce this
in my vm.

Thanks,
Kuai

> 
> Thanks,
> Song
> 
> .
> 


