Return-Path: <linux-kernel+bounces-49577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2287D846BF2
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 10:29:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 557251C273E6
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 09:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EA5D78B76;
	Fri,  2 Feb 2024 09:26:48 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4114A78695;
	Fri,  2 Feb 2024 09:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706866007; cv=none; b=LEkuq/imxzPKhCrBkXuYMmSQcynrgyofiSYSm6eMRcAJo6WuCPD5vQp525aDi7egd/1pFuJ/R0XahbAY78N07uL/iqmBFNyLlPL7k5rvPZPrPda51164qcG8Re6ly5yXI8Kx1hoOdWnv42sctK+NkjO7nkGTGgPuCZfHY1J/GCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706866007; c=relaxed/simple;
	bh=OOM8fEsZue+jykrDPVZl0c5ujgpHE/2kRMLlWDClr1w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p+Z0TKwVCLOzlp+BpBr7WH+1ei5wH3U7grF8nkca24Ev5leo69UwC/BYDpQaFpQt6MC6LqUH+PAr0HOS2R2FDTYBKmNgYtDANczoOtD1dfyuHXyl8qDbpLAitLmt4vqYOf2Y8UQ5mQ5N3YPqU9FHF4uA1R56sxehxEd7IjVJLSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TR9Q15QSFz4f3mHK;
	Fri,  2 Feb 2024 17:26:33 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 52E0F1A038B;
	Fri,  2 Feb 2024 17:26:40 +0800 (CST)
Received: from [10.174.179.247] (unknown [10.174.179.247])
	by APP2 (Coremail) with SMTP id Syh0CgBXfA9MtbxlzzQZCw--.59821S3;
	Fri, 02 Feb 2024 17:26:40 +0800 (CST)
Message-ID: <c73fc514-78c1-20c6-b543-d8e7cd16f200@huaweicloud.com>
Date: Fri, 2 Feb 2024 17:26:36 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v5 7/8] md: sync blockdev before stopping raid or setting
 readonly
To: Yu Kuai <yukuai1@huaweicloud.com>, linan666@huaweicloud.com,
 song@kernel.org, neilb@suse.com, mariusz.tkaczyk@linux.intel.com, shli@fb.com
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
 yi.zhang@huawei.com, houtao1@huawei.com, yangerkun@huawei.com,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20240201063404.772797-1-linan666@huaweicloud.com>
 <20240201063404.772797-8-linan666@huaweicloud.com>
 <8f6a305f-75ed-f103-4a52-9e88699d9289@huaweicloud.com>
From: Li Nan <linan666@huaweicloud.com>
In-Reply-To: <8f6a305f-75ed-f103-4a52-9e88699d9289@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgBXfA9MtbxlzzQZCw--.59821S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Ww4DWFWftry5tw1xCr43trb_yoW8CFyfpF
	Z7JFy5uryjq3savw17JF18Ga4rXw1xtayUKryava48ZFy5ArnFgrWrWrn0gryDKrWxJF4j
	qw1UJasxuFy7tF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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



在 2024/2/2 10:12, Yu Kuai 写道:
> Hi,
> 
> 在 2024/02/01 14:34, linan666@huaweicloud.com 写道:
>> From: Li Nan <linan122@huawei.com>
>>
>> Commit a05b7ea03d72 ("md: avoid crash when stopping md array races
>> with closing other open fds.") added sync_block before stopping raid and
>> setting readonly. Later in commit 260fa034ef7a ("md: avoid deadlock when
>> dirty buffers during md_stop.") it is moved to ioctl. array_state_store()
>> was ignored. Add sync blockdev to array_state_store() now.
> 
> You're not just adding sync_blockdev() here. Please rewrite the tittle
> and commit message.
> 
>>
>> Signed-off-by: Li Nan <linan122@huawei.com>
>> ---
>>   drivers/md/md.c | 16 ++++++++++++++++
>>   1 file changed, 16 insertions(+)
>>
>> diff --git a/drivers/md/md.c b/drivers/md/md.c
>> index 4c7a0225f77d..86becf0015f5 100644
>> --- a/drivers/md/md.c
>> +++ b/drivers/md/md.c
>> @@ -4493,6 +4493,16 @@ array_state_store(struct mddev *mddev, const char 
>> *buf, size_t len)
>>       case broken:        /* cannot be set */
>>       case bad_word:
>>           return -EINVAL;
>> +    case clear:
>> +    case readonly:
>> +    case inactive:
>> +    case read_auto:
>> +        if (!mddev->pers || !md_is_rdwr(mddev))
>> +            break;
>> +        err = mddev_set_closing_and_sync_blockdev(mddev);
> 
> In this context, mddev->openers should be zero, and such check is in
> do_md_stop() and md_set_readonly():
> 

Yeah, the checks in do_md_stop() and md_set_readonly() can be removed after
this patch. However, 'mddev->open_metux' is used to protect MD_CLOSING and
'mddev->openers', it can be removed in these functions, too.

I will fix it later. Thanks for your review.

> if (atomic_read(&mddev->openers) > !!bdev).
> 
> Thanks,
> Kuai
> 



-- 
Thanks,
Nan


