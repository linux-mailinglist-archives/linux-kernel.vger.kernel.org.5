Return-Path: <linux-kernel+bounces-43716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53472841849
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 02:30:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2D5A285B41
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 01:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 587E43611D;
	Tue, 30 Jan 2024 01:30:42 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E8C2E40E;
	Tue, 30 Jan 2024 01:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706578241; cv=none; b=fO2dP37198/alb6LpzZ8PpNVSaXAA3yvdlMaRwWvV6GkIiHSkyYUvzOmKYT+Zk6vE3dsC76d6+ihSSQPUYl/7LchmAmhfrhj6oh7ubJmrdMX8RiYfCACwoZ/bh369PiKfWib2Q5ohMiEmCtToZYZ0uODJMpAfJSZy79ljq19aYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706578241; c=relaxed/simple;
	bh=0QtepIhapBUQYBXsTlb3iozbTJoWSBaagWuqgVCvxwc=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=is7c4TfZ4ep9n9UiFIcBzSXtWo33eVyGrWF2gWnXYjKN6OsBFr68I6u77d72WEVFqYEgqZsKGCYrofI/jboj4c8iq5c8eBE20XYavwmVWXgM6VO0qlilaza+5V8xlDVsyo2QQKI1p0p/OqNSqJFmFcsD0oiecD5TgbKYRESqFOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TP6zy5xTQz4f3lgJ;
	Tue, 30 Jan 2024 09:30:22 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 4C64F1A01E9;
	Tue, 30 Jan 2024 09:30:29 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP1 (Coremail) with SMTP id cCh0CgDHlxAzUbhlL0+cCQ--.50348S3;
	Tue, 30 Jan 2024 09:30:29 +0800 (CST)
Subject: Re: [PATCH] scsi: sd: unregister device if device_add_disk() failed
 in sd_probe()
To: Luis Chamberlain <mcgrof@kernel.org>, Yu Kuai <yukuai1@huaweicloud.com>
Cc: linan666@huaweicloud.com, jejb@linux.ibm.com, martin.petersen@oracle.com,
 linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linan122@huawei.com, yi.zhang@huawei.com, houtao1@huawei.com,
 yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20231208082335.1754205-1-linan666@huaweicloud.com>
 <ZYUxZc/my2v6UfFJ@bombadil.infradead.org>
 <78fb6d82-c50a-8fea-ae6d-551fd35656bf@huaweicloud.com>
 <ZbfkZxMVpVI97zmk@bombadil.infradead.org>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <8d75f4dc-554c-b0ae-3e92-d2cf033dc555@huaweicloud.com>
Date: Tue, 30 Jan 2024 09:30:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZbfkZxMVpVI97zmk@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgDHlxAzUbhlL0+cCQ--.50348S3
X-Coremail-Antispam: 1UD129KBjvJXoWxZr48ArWUJr47GFyfuF48Zwb_yoWrKFWxpF
	WDWa90krW8Gr1UCwn0vrWUZa45Kw40y34fXry8G34Yg3s8XryYqFW3GFW5Wa4fJrZrCF4U
	JrW7GryxW3W8Jw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9F14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E
	3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcS
	sGvfC2KfnxnUUI43ZEXa7VUbXdbUUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2024/01/30 1:46, Luis Chamberlain 写道:
> On Fri, Dec 22, 2023 at 04:27:16PM +0800, Yu Kuai wrote:
>> Hi,
>>
>> 在 2023/12/22 14:49, Luis Chamberlain 写道:
>>> On Fri, Dec 08, 2023 at 04:23:35PM +0800, linan666@huaweicloud.com wrote:
>>>> From: Li Nan <linan122@huawei.com>
>>>>
>>>> "if device_add() succeeds, you should call device_del() when you want to
>>>> get rid of it."
>>>>
>>>> In sd_probe(), device_add_disk() fails when device_add() has already
>>>> succeeded, so change put_device() to device_unregister() to ensure device
>>>> resources are released.
>>>>
>>>> Fixes: 2a7a891f4c40 ("scsi: sd: Add error handling support for add_disk()")
>>>> Signed-off-by: Li Nan <linan122@huawei.com>
>>>
>>> Nacked-by: Luis Chamberlain <mcgrof@kernel.org>
>>>
>>>> ---
>>>>    drivers/scsi/sd.c | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
>>>> index 542a4bbb21bc..d81cbeee06eb 100644
>>>> --- a/drivers/scsi/sd.c
>>>> +++ b/drivers/scsi/sd.c
>>>> @@ -3736,7 +3736,7 @@ static int sd_probe(struct device *dev)
>>>>    	error = device_add_disk(dev, gd, NULL);
>>>>    	if (error) {
>>>> -		put_device(&sdkp->disk_dev);
>>>> +		device_unregister(&sdkp->disk_dev);
>>>>    		put_disk(gd);
>>>>    		goto out;
>>>>    	}
>>>
>>> This is incorrect, device_unregister() calls:
>>>
>>> void device_unregister(struct device *dev)
>>> {
>>> 	pr_debug("device: '%s': %s\n", dev_name(dev), __func__);
>>> 	device_del(dev);
>>> 	put_device(dev);
>>> }
>>>
>>> So you're adding what you believe to be a correct missing device_del().
>>> But what you missed is that if device_add_disk() fails then device_add()
>>> did not succeed because the new code we have in the kernel *today* unwinds
>>> this for us now.
>>
>> I'm confused here, there are two device here, one is 'sdkp->disk_dev',
>> one is gendisk->part0->bd_device, and the order in which they
>> initialize:
>>
>> sd_probe
>> device_add(&sdkp->disk_dev) -> succeed
>> device_add_disk -> failed, and device_add(bd_device) did not succeed
>> put_device(&sdkp->disk_dev) -> device_del is missed
>>
>> I don't see that if device_add_disk() fail, device_del() for
>> 'sdkp->disk_dev'is called from anywhere. Do I missing anything?
> 
> Ah then the fix is still incorrect and the commit log should
> describe that this is for another device.
> 
> How about this instead?
> 
>>From c3f6e03f4a82aa253b6c487a293dcd576393b606 Mon Sep 17 00:00:00 2001
> From: Luis Chamberlain <mcgrof@kernel.org>
> Date: Mon, 29 Jan 2024 09:25:18 -0800
> Subject: [PATCH] sd: remove extra put_device() for extra scsi device
> 
> The sd driver first device_add() its own device, and later use
> device_add_disk() with another device. When we added error handling
> for device_add_disk() we now call put_disk() and that will trigger
> disk_release() when the refcount is 0. That will end up calling
> the block driver's disk->fops->free_disk() if one is defined. The

This is incorrect. GD_ADDED will only set when device_add_disk()
succeed, and free_disk() will only be called from disk_release() if
GD_ADDED is set. I think Li Nan's patch is correct.

> sd driver has scsi_disk_free_disk() as its free_disk() and that
> does the proper put_device(&sdkp->disk_dev) for us so we should not
> need to call it, however we are left still missing the device_del()
> for it.
> 
> While at it, unwind with scsi_autopm_put_device(sdp) *prior* to
> putting to device as we do in sd_remove().
> 
> Reported-by: Li Nan <linan122@huawei.com>
> Reported-by: Yu Kuai <yukuai1@huaweicloud.com>
> Fixes: 2a7a891f4c40 ("scsi: sd: Add error handling support for add_disk()")
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>   drivers/scsi/sd.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
> index 7f949adbadfd..6475a3c947f8 100644
> --- a/drivers/scsi/sd.c
> +++ b/drivers/scsi/sd.c
> @@ -3693,8 +3693,9 @@ static int sd_probe(struct device *dev)
>   
>   	error = device_add(&sdkp->disk_dev);
>   	if (error) {
> +		scsi_autopm_put_device(sdp);
>   		put_device(&sdkp->disk_dev);
> -		goto out;
> +		return error;

I don't see why this is necessary, the tag 'out' is still there. If
you think is a problem, I think you need a separate patch to call
scsi_autopm_put_device() before putting the device.

Thanks,
Kuai

>   	}
>   
>   	dev_set_drvdata(dev, sdkp);
> @@ -3734,9 +3735,10 @@ static int sd_probe(struct device *dev)
>   
>   	error = device_add_disk(dev, gd, NULL);
>   	if (error) {
> -		put_device(&sdkp->disk_dev);
> +		scsi_autopm_put_device(sdp);
> +		device_del(&sdkp->disk_dev);
>   		put_disk(gd);
> -		goto out;
> +		return error;
>   	}
>   
>   	if (sdkp->security) {
> 


