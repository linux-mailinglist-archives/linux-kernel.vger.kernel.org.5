Return-Path: <linux-kernel+bounces-141765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DA1C8A2326
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 03:20:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 847A71C218F9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 01:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A64E4C70;
	Fri, 12 Apr 2024 01:20:42 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499922F2D
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 01:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712884841; cv=none; b=n0L2pBvrNkatUk7GtARZMChwKdaBWswsZTJw9AsHZvdI24wPxo5U/zYC0H1W7B3JOePHNnT2YlWCO6FJwthjqoFmfPkP+kQkFnZPnDl/srxq/5ZYryYldqGNivgM61CtS8K4Wq8Lhj4OyIBq5q4D55ewYpKaW7OMSFn4sG9RVt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712884841; c=relaxed/simple;
	bh=Vpzau8xtH3lzwwWEi+qfwLTEGq/v4xW3MiNgFCg3Mfs=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=MVD1Ys0HpR6smFtZ8u8Ar0hFLMf0e/hvHNkDw8UhvSZEWCtUDg3dngHYPGZ6aDxhX12BL5lC9QL3nsC6kNMqKLPsjyp4rp4B6V27goMXJq6ilsPyrM2V3iG4ngEEMgZ6T68bUV6v7QuJ5I6nErpWikIzZzJlp0MZPIneDhuzT6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VFzFh2xg9ztScQ;
	Fri, 12 Apr 2024 09:17:44 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (unknown [7.193.23.68])
	by mail.maildlp.com (Postfix) with ESMTPS id E58151400C8;
	Fri, 12 Apr 2024 09:20:29 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 12 Apr 2024 09:20:29 +0800
Subject: Re: [PATCH v2 2/4] ubi: ubi_init: Fix missed ubiblock cleanup in
 error handling path
To: Daniel Golle <daniel@makrotopia.org>
CC: <richard@nod.at>, <miquel.raynal@bootlin.com>, <ben.hutchings@mind.be>,
	<linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20240411031903.3050278-1-chengzhihao1@huawei.com>
 <20240411031903.3050278-3-chengzhihao1@huawei.com>
 <ZhgGPE_5urw2izAA@makrotopia.org>
From: Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <fb1de5ee-46d3-7148-7b59-a5d736e00f1c@huawei.com>
Date: Fri, 12 Apr 2024 09:20:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZhgGPE_5urw2izAA@makrotopia.org>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600013.china.huawei.com (7.193.23.68)

ÔÚ 2024/4/11 23:48, Daniel Golle Ð´µÀ:
> On Thu, Apr 11, 2024 at 11:19:01AM +0800, Zhihao Cheng wrote:
>> The ubiblock_init called by ubi_init will register device number, but
>> device number is not released in error handling path of ubi_init when
>> ubi is loaded by inserting module (eg. attaching failure), which leads
>> to subsequent ubi_init calls failed by running out of device number
>> (dmesg shows that "__register_blkdev: failed to get major for ubiblock").
>> Since ubiblock_init() registers notifier and invokes notification
>> functions, so we can move it after ubi_init_attach() to fix the problem.
>>
>> Fixes: 927c145208b0 ("mtd: ubi: attach from device tree")
>> Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
>> ---
>>   drivers/mtd/ubi/build.c | 51 +++++++++++++++++++++--------------------
>>   1 file changed, 26 insertions(+), 25 deletions(-)
>>
>> diff --git a/drivers/mtd/ubi/build.c b/drivers/mtd/ubi/build.c
>> index 7f95fd7968a8..bc63fbf5e947 100644
>> --- a/drivers/mtd/ubi/build.c
>> +++ b/drivers/mtd/ubi/build.c
>> @@ -1263,9 +1263,21 @@ static struct mtd_notifier ubi_mtd_notifier = {
>>   	.remove = ubi_notify_remove,
>>   };
>>   
>> +static void detach_mtd_devs(int count)
> 
> Missing __init to avoid section missmatch.
> 
> See also: https://lore.kernel.org/oe-kbuild-all/202404112327.158HJfAw-lkp@intel.com/

I think function without '__init' attributes can be called in ubi_init, 
for example misc_register, kmem_cache_create, and I verify it by make 
W=1 in local machine. And above warning(in your link) is only detected 
in my v1 series.
After investigating the '__init' and '__exit', I understand that there 
are two independent text section for these functions, for example, 
__init text section will be removed from memory after it is finished, so 
we cannot call __exit function in __init function.
> 
>> +{
>> +	int i;
>> +
>> +	for (i = 0; i < count; i++)
>> +		if (ubi_devices[i]) {
>> +			mutex_lock(&ubi_devices_mutex);
>> +			ubi_detach_mtd_dev(ubi_devices[i]->ubi_num, 1);
>> +			mutex_unlock(&ubi_devices_mutex);
>> +		}
>> +}



