Return-Path: <linux-kernel+bounces-70255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 360E385954B
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 08:47:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EF13282022
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 07:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 362D1EAD5;
	Sun, 18 Feb 2024 07:47:24 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A47D294;
	Sun, 18 Feb 2024 07:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708242443; cv=none; b=ePhboZEsATNCu7vJrfTxud5YGoU588jmYItXs1cIKFx/syfm27yNrl+DpoYdn/h9uHpCNigYQ9AJ1fqDU5T0qcbCVZd41+XJfo/bunxh/6m7wuh5v0ua6qOVJ05QKPOQtpAcAIcpULCTy31Rj1Ef9SHtf4Ya0NrUrNXWZJX8Rzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708242443; c=relaxed/simple;
	bh=tiqzXuBxTbUFsemp1dU5cIN58mwX4m/IRncxJKZ6RiM=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=XHgQl5ir9jAJ7ZcqWx4huq3v1H2ayxa/u6ilQBoW6d+RPmYCXt9MorZMtCThF1s2BqvjHhWXXIBZOLPm9VnoB8gY2jGWsfxbuQcu9lq3Xv2McTTysf2NzOF8LkyuuLiUxAKFhBRdjM9w+asupf5DIHGOBkAU8oKPfOZnncPqdv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TcyRx3dvbz4f3lDW;
	Sun, 18 Feb 2024 15:47:09 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 863E31A0199;
	Sun, 18 Feb 2024 15:47:16 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP1 (Coremail) with SMTP id cCh0CgAn+REAttFlmUSBEQ--.9016S3;
	Sun, 18 Feb 2024 15:47:13 +0800 (CST)
Subject: Re: [PATCH] block: fix deadlock between bd_link_disk_holder and
 partition scan
To: Song Liu <song@kernel.org>, Li Nan <linan666@huaweicloud.com>
Cc: axboe@kernel.dk, linux-raid@vger.kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, yi.zhang@huawei.com, houtao1@huawei.com,
 yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20240207092756.2087888-1-linan666@huaweicloud.com>
 <CAPhsuW74hLiW_KTv3xohwMAcPZ9gp2TvLST4tY7H3O8cA26TTg@mail.gmail.com>
 <6849835d-a3ac-e840-09e9-8539e7953fe4@huaweicloud.com>
 <CAPhsuW4k_C=UxwESU4t7R+fpoAJ_HE8g_PpCJXSUGWOdbpCEoQ@mail.gmail.com>
 <CAPhsuW4H=ehc1UiuFdhBXZUfU_okQ=-rbti1oEWHcs7ajT89iw@mail.gmail.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <6211cd80-6573-656d-e198-befe074030d8@huaweicloud.com>
Date: Sun, 18 Feb 2024 15:47:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAPhsuW4H=ehc1UiuFdhBXZUfU_okQ=-rbti1oEWHcs7ajT89iw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAn+REAttFlmUSBEQ--.9016S3
X-Coremail-Antispam: 1UD129KBjvJXoWxtFWUtrWDWryftrW3JF4xJFb_yoW7Wr13pr
	Z7tanxtr1UJFnxu3y7ta4kuF10qw1UKr42qr9xW3y7ZwnFyrn3WF1F9r45uF1Ykw1xJFyD
	Ja1UWa47Gw10krUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9214x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kI
	c2xKxwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
	AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
	17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
	IF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Wr1j6rW3
	Jr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYx
	BIdaVFxhVjvjDU0xZFpf9x0JUq38nUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2024/02/17 3:03, Song Liu 写道:
> On Thu, Feb 8, 2024 at 4:49 PM Song Liu <song@kernel.org> wrote:
>>
>> On Thu, Feb 8, 2024 at 12:44 AM Li Nan <linan666@huaweicloud.com> wrote:
>>>
>>>
>>>
>>> 在 2024/2/8 14:50, Song Liu 写道:
>>>> On Wed, Feb 7, 2024 at 1:32 AM <linan666@huaweicloud.com> wrote:
>>>>>
>>>>> From: Li Nan <linan122@huawei.com>
>>>>>
>>>>> 'open_mutex' of gendisk is used to protect open/close block devices. But
>>>>> in bd_link_disk_holder(), it is used to protect the creation of symlink
>>>>> between holding disk and slave bdev, which introduces some issues.
>>>>>
>>>>> When bd_link_disk_holder() is called, the driver is usually in the process
>>>>> of initialization/modification and may suspend submitting io. At this
>>>>> time, any io hold 'open_mutex', such as scanning partitions, can cause
>>>>> deadlocks. For example, in raid:
>>>>>
>>>>> T1                              T2
>>>>> bdev_open_by_dev
>>>>>    lock open_mutex [1]
>>>>>    ...
>>>>>     efi_partition
>>>>>     ...
>>>>>      md_submit_bio
>>>>>                                   md_ioctl mddev_syspend
>>>>>                                     -> suspend all io
>>>>>                                    md_add_new_disk
>>>>>                                     bind_rdev_to_array
>>>>>                                      bd_link_disk_holder
>>>>>                                       try lock open_mutex [2]
>>>>>       md_handle_request
>>>>>        -> wait mddev_resume
>>>>>
>>>>> T1 scan partition, T2 add a new device to raid. T1 waits for T2 to resume
>>>>> mddev, but T2 waits for open_mutex held by T1. Deadlock occurs.
>>>>>
>>>>> Fix it by introducing a local mutex 'holder_mutex' to replace 'open_mutex'.
>>>>
>>>> Is this to fix [1]? Do we need some Fixes and/or Closes tags?
>>>>
>>>
>>> No. Just use another way to fix [2], and both [2] and this patch can fix
>>> the issue. I am not sure about the root cause of [1] yet.
>>>
>>> [2] https://patchwork.kernel.org/project/linux-raid/list/?series=812045
>>>
>>>> Could you please add steps to reproduce this issue?
>>>
>>> We need to modify the kernel, add sleep in md_submit_bio() and md_ioctl()
>>> as below, and then:
>>>     1. mdadm -CR /dev/md0 -l1 -n2 /dev/sd[bc]  #create a raid
>>>     2. echo 1 > /sys/module/md_mod/parameters/error_inject  #enable sleep
>>>     3. 'mdadm --add /dev/md0 /dev/sda'  #add a disk to raid
>>>     4. submit ioctl BLKRRPART to raid within 10s.
>>
>> The analysis makes sense. I also hit the issue a couple times without adding
>> extra delays. But I am not sure whether this is the best fix (I didn't find real
>> issues with it either).
> 
> To be extra safe and future proof, we can do something like the
> following to only
> suspend the array for ADD_NEW_DISK on not-running arrays.
> 
> This appear to solve the problem reported in
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=218459
> 
> Thanks,
> Song
> 
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index 9e41a9aaba8b..395911d5f4d6 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -7570,10 +7570,11 @@ static inline bool md_ioctl_valid(unsigned int cmd)
>          }
>   }
> 
> -static bool md_ioctl_need_suspend(unsigned int cmd)
> +static bool md_ioctl_need_suspend(struct mddev *mddev, unsigned int cmd)
>   {
>          switch (cmd) {
>          case ADD_NEW_DISK:
> +               return mddev->pers != NULL;

Did you check already that this problem is not related that 'active_io'
is leaked for flush IO?

I don't understand the problem reported yet. If 'mddev->pers' is not set
yet, md_submit_bio() will return directly, and 'active_io' should not be
grabbed in the first place.

md_run() is the only place to convert 'mddev->pers' from NULL to a real
personality, and it's protected by 'reconfig_mutex', however,
md_ioctl_need_suspend() is called without 'reconfig_mutex', hence there
is a race condition:

md_ioctl_need_suspend		array_state_store
  // mddev->pers is NULL, return false
				 mddev_lock
				 do_md_run
				  mddev->pers = xxx
				 mddev_unlock

  // mddev_suspend is not called
  mddev_lock
  md_add_new_disk
   if (mddev->pers)
    md_import_device
    bind_rdev_to_array
    add_bound_rdev
     mddev->pers->hot_add_disk
     -> hot add disk without suspending

Thanks,
Kuai

>          case HOT_ADD_DISK:
>          case HOT_REMOVE_DISK:
>          case SET_BITMAP_FILE:
> @@ -7625,6 +7626,7 @@ static int md_ioctl(struct block_device *bdev,
> blk_mode_t mode,
>          void __user *argp = (void __user *)arg;
>          struct mddev *mddev = NULL;
>          bool did_set_md_closing = false;
> +       bool need_suspend;
> 
>          if (!md_ioctl_valid(cmd))
>                  return -ENOTTY;
> @@ -7716,8 +7718,11 @@ static int md_ioctl(struct block_device *bdev,
> blk_mode_t mode,
>          if (!md_is_rdwr(mddev))
>                  flush_work(&mddev->sync_work);
> 
> -       err = md_ioctl_need_suspend(cmd) ? mddev_suspend_and_lock(mddev) :
> -                                          mddev_lock(mddev);
> +       need_suspend = md_ioctl_need_suspend(mddev, cmd);
> +       if (need_suspend)
> +               err = mddev_suspend_and_lock(mddev);
> +       else
> +               err = mddev_lock(mddev);
>          if (err) {
>                  pr_debug("md: ioctl lock interrupted, reason %d, cmd %d\n",
>                           err, cmd);
> @@ -7846,8 +7851,10 @@ static int md_ioctl(struct block_device *bdev,
> blk_mode_t mode,
>              err != -EINVAL)
>                  mddev->hold_active = 0;
> 
> -       md_ioctl_need_suspend(cmd) ? mddev_unlock_and_resume(mddev) :
> -                                    mddev_unlock(mddev);
> +       if (need_suspend)
> +               mddev_unlock_and_resume(mddev);
> +       else
> +               mddev_unlock(mddev);
> 
>   out:
>          if(did_set_md_closing)
> .
> 


