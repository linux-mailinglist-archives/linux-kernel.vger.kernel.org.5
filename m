Return-Path: <linux-kernel+bounces-32271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 634FD835946
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 03:15:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 020251F21C68
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 02:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C147EBB;
	Mon, 22 Jan 2024 02:15:19 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777B8A29;
	Mon, 22 Jan 2024 02:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705889719; cv=none; b=XnOm4ic+rtON8vaYCCTjuvL1xhi6iEb2Vt8fnBbfwBy/shTEtlZqZsG1ueW67P4wz4GXGOmB7d0PN2z+uApWlcQxnUeDfJvFEwQUJ8lJY8XvG87O1SemH7O33c/h8fQAwcuUweFGkUYrp6tG73BGP9m2Qys6VGA2EpCe1KOOsbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705889719; c=relaxed/simple;
	bh=OpqSj6buW5w7WYyTw697xfgdGiXKHBhbNUPbGeWQoKo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QxY5IJCjvdbDm1q+XTW2i0SQ3WUbffVCPd5ZOd8iaZCB7oAfgfHcGmDe7DoYAOA/5gx4OmJiazytgwDZCH3GqQ0Y5x3G1DzGqh19L+G70Qunojorg1qer5cvs/2t6IHKzwLDx3ZbElyv4ZZBIyMeyc0VEHyz5qiURxvCSRkjOmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TJDMM6FWhz4f3jpq;
	Mon, 22 Jan 2024 10:15:11 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 293761A016E;
	Mon, 22 Jan 2024 10:15:14 +0800 (CST)
Received: from [10.174.179.247] (unknown [10.174.179.247])
	by APP2 (Coremail) with SMTP id Syh0CgDnCw+xz61lL4lrBg--.27205S3;
	Mon, 22 Jan 2024 10:15:13 +0800 (CST)
Message-ID: <18ec6274-dfbc-5083-92c9-16bdbe3ed34e@huaweicloud.com>
Date: Mon, 22 Jan 2024 10:15:13 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 2/3] md: factor out a helper mddev_sync_blockdev() to
 sync mddev
To: Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>,
 linan666@huaweicloud.com
Cc: song@kernel.org, shli@fb.com, neilb@suse.com, zlliu@suse.com,
 linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
 yukuai3@huawei.com, yi.zhang@huawei.com, houtao1@huawei.com,
 yangerkun@huawei.com
References: <20240117093707.2767209-1-linan666@huaweicloud.com>
 <20240117093707.2767209-3-linan666@huaweicloud.com>
 <20240118090814.00001d0d@linux.intel.com>
From: Li Nan <linan666@huaweicloud.com>
In-Reply-To: <20240118090814.00001d0d@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgDnCw+xz61lL4lrBg--.27205S3
X-Coremail-Antispam: 1UD129KBjvdXoW7Xw1rtw4UGw4xCw4xCw4kWFg_yoWktrc_CF
	WjyF97Jr45GFn2kFyYk3yxAr9YkanrWFn7ZFy2qr43Zw17X3W8GF9Yy3s5Xws5ZFZxZFs0
	yw1fAaySvrsFqjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbfAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
	0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr
	1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIF
	xwACI402YVCY1x02628vn2kIc2xKxwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7V
	AKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
	r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6x
	IIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAI
	w20EY4v20xvaj40_Gr0_Zr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x
	0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VU1c4S5UUUUU==
X-CM-SenderInfo: polqt0awwwqx5xdzvxpfor3voofrz/



在 2024/1/18 16:08, Mariusz Tkaczyk 写道:
> On Wed, 17 Jan 2024 17:37:06 +0800
> linan666@huaweicloud.com wrote:
> 
>> From: Li Nan <linan122@huawei.com>
>>
>> There are no functional changes, prepare to sync mddev in
>> array_state_store().
>>
>> Signed-off-by: Li Nan <linan122@huawei.com>
>> ---
>>   drivers/md/md.c | 31 +++++++++++++++++++------------
>>   1 file changed, 19 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/md/md.c b/drivers/md/md.c
>> index 4bf821b89415..2c793992a604 100644
>> --- a/drivers/md/md.c
>> +++ b/drivers/md/md.c
>> @@ -529,6 +529,23 @@ void mddev_resume(struct mddev *mddev)
>>   }
>>   EXPORT_SYMBOL_GPL(mddev_resume);
>>   
>> +/* sync bdev before setting device to readonly or stopping raid*/
>> +static int mddev_sync_blockdev(struct mddev *mddev) {
> 
> Please add something about MD_CLOSING to the function name. Comment is good but
> you need open function to get it. Something like:
> mddev_set_closing_and_sync_blockdev() is more reader friendly.
> 

I agree. Let me improve this.

> Anyway, LGTM.
> Acked-by: Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
> 
> Thanks,
> Mariusz
> 
> .

-- 
Thanks,
Nan


