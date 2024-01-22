Return-Path: <linux-kernel+bounces-32270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC819835944
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 03:14:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB3AB1C2150D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 02:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A0FDEA4;
	Mon, 22 Jan 2024 02:14:28 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1511847;
	Mon, 22 Jan 2024 02:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705889667; cv=none; b=ALvUyhrVHLzCbaqmNNaNhRNwq+aPkEpesMGDKH16rWnE4kNyNEXmswGbmSaIbS2pFjxnUXKYZcZexWRp3RyVgGCr1Ghe8qjy8rgimROnigqxyOmmncOal+mu/gzyuHEQbXcfEyuOARq2v4sCUvUq08uOmlAhOo8aOOimsQJi940=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705889667; c=relaxed/simple;
	bh=29z8AGhRsGH8QR8QAhcPdKbpoRwMk7pBxMoqGk4HLvo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZYf5WZspYCgeaL+0CqFB9xiO96Nxv5HxMpuPKbZk6IIevoVGs2rJJ8n8RFr0XNxUyTbR5OhD4RIelu7KggUlfTltBUApphGAmFGelAvGLOb6nlO+shufV3TEQh/Al8+fMeAzm8AhBM2BUDQMg9ZTvhiWypZkK3kGQI7iYzzaqnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TJDLF31lFz4f3jqK;
	Mon, 22 Jan 2024 10:14:13 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id AF8E31A016E;
	Mon, 22 Jan 2024 10:14:15 +0800 (CST)
Received: from [10.174.179.247] (unknown [10.174.179.247])
	by APP2 (Coremail) with SMTP id Syh0CgDnCg51z61lAHZrBg--.15193S3;
	Mon, 22 Jan 2024 10:14:15 +0800 (CST)
Message-ID: <030267fa-6f61-e87d-c827-8d2c3d9113c3@huaweicloud.com>
Date: Mon, 22 Jan 2024 10:14:13 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 1/3] md: Don't clear MD_CLOSING when the raid is about
 to stop
To: Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>,
 linan666@huaweicloud.com
Cc: song@kernel.org, shli@fb.com, neilb@suse.com, zlliu@suse.com,
 linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
 yukuai3@huawei.com, yi.zhang@huawei.com, houtao1@huawei.com,
 yangerkun@huawei.com
References: <20240117093707.2767209-1-linan666@huaweicloud.com>
 <20240117093707.2767209-2-linan666@huaweicloud.com>
 <20240118083525.00002b15@linux.intel.com>
From: Li Nan <linan666@huaweicloud.com>
In-Reply-To: <20240118083525.00002b15@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgDnCg51z61lAHZrBg--.15193S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr17ZFyfKryDKr4fJFy8Grg_yoW8tF47pa
	yrJF1Yyrs8Jry7CayaqF4kXa4Fgw4ftrWDtry2yFWrZ3Zru347JrySgrWqgrn8Wr9agF1j
	qa1UXa4kuF1vgrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBI14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
	F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r
	4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v
	4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x
	0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
	7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcV
	C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF
	04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aV
	CY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbHa0DUUUUU==
X-CM-SenderInfo: polqt0awwwqx5xdzvxpfor3voofrz/



在 2024/1/18 15:35, Mariusz Tkaczyk 写道:
> On Wed, 17 Jan 2024 17:37:05 +0800
> linan666@huaweicloud.com wrote:
> 
>> From: Li Nan <linan122@huawei.com>
>>
>> The raid should not be opened anymore when it is about to be stopped.
>> However, other processes can open it again if the flag MD_CLOSING is
>> cleared before exiting. From now on, this flag will not be cleared when
>> the raid will be stopped.
>>
>> Fixes: 065e519e71b2 ("md: MD_CLOSING needs to be cleared after called
>> md_set_readonly or do_md_stop") Signed-off-by: Li Nan <linan122@huawei.com>
>> ---
>>   drivers/md/md.c | 16 +++++++++++++++-
>>   1 file changed, 15 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/md/md.c b/drivers/md/md.c
>> index 9bdd57324c37..4bf821b89415 100644
>> --- a/drivers/md/md.c
>> +++ b/drivers/md/md.c
>> @@ -6254,7 +6254,15 @@ static void md_clean(struct mddev *mddev)
>>   	mddev->persistent = 0;
>>   	mddev->level = LEVEL_NONE;
>>   	mddev->clevel[0] = 0;
>> -	mddev->flags = 0;
>> +	/*
>> +	 * Don't clear MD_CLOSING, or mddev can be opened again.
>> +	 * 'hold_active != 0' means mddev is still in the creation
>> +	 * process and will be used later.
>> +	 */
>> +	if (mddev->hold_active)
>> +		mddev->flags = 0;
>> +	else
>> +		mddev->flags &= BIT_ULL_MASK(MD_CLOSING);
>>   	mddev->sb_flags = 0;
>>   	mddev->ro = MD_RDWR;
>>   	mddev->metadata_type[0] = 0;
>> @@ -7728,6 +7736,12 @@ static int md_ioctl(struct block_device *bdev,
>> blk_mode_t mode,
>>   	case STOP_ARRAY:
>>   		err = do_md_stop(mddev, 0, bdev);
>> +		if (!err)
>> +			/*
>> +			 * mddev has been stopped, keep flag the
>> +			 * MD_CLOSING to prevent reuse.
>> +			 */
>> +			did_set_md_closing = false;
> 
> Hello Nan,
> The meaning of the "did_set_md_closing" is to notify that MD_CLOSING was set in
> this function, to know how to behave on error.
> You gave it another meaning "Do not clear MD_CLOSING because we want it to stay"
> Please consider how to solve this confusion. I see the comment you added but I
> think we can have this solved better, maybe just name it as "clear_md_closing"?
> 

Thanks for your review, I will rename it in next version.

> Anyway it looks acceptable to me:
> Acked-by: Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
> 
> Thanks,
> Mariusz
> 
> .

-- 
Thanks,
Nan


