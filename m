Return-Path: <linux-kernel+bounces-139658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7EAD8A0609
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 04:39:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D9A61F24964
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 02:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E55213AD3C;
	Thu, 11 Apr 2024 02:39:51 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB045F870
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 02:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712803191; cv=none; b=P3HgqXD9lathMDvJbxeekLxqpZQBYNUtrCkwNeeuZv5KhcseL7QVRvPXhxSi8HNzh4Asso7ytZOiarNtnpkBn/c6/tvoyVSQyH0SMGIP9LpNT+YiCDUmYywn2i5CIdxsMsBtK0bvf8JUVnrGnrJgV0Ylml0Z0VvMo3+GbV7FaOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712803191; c=relaxed/simple;
	bh=8sTXZZlPkCzR7YkcykYXAkUX7dCa064cGwilyQhpUuU=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=QByUgzH3IGXkOsLofeY5062BvtL4c3dyEb/EYoOY7W2I3T36H107dQ29AOHzEPcVGUAIq8rBCTvY+anSkfJTVk2qCy3Q4+9pyL1amP06+kTq/X/InVI86qP6Nm/NChsnyGSeEeGyRItyZoDgN7LoTRoIY0stRklIZdwn3FENw+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4VFP3T39Y7z29dPS;
	Thu, 11 Apr 2024 10:36:53 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (unknown [7.193.23.68])
	by mail.maildlp.com (Postfix) with ESMTPS id E3D241A0172;
	Thu, 11 Apr 2024 10:39:45 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 11 Apr 2024 10:39:45 +0800
Subject: Re: [PATCH 2/2] ubi: ubi_init: Fix missed ubiblock cleanup in error
 handling path
To: Daniel Golle <daniel@makrotopia.org>
CC: <richard@nod.at>, <linux-mtd@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
References: <20240410074033.2523399-1-chengzhihao1@huawei.com>
 <20240410074033.2523399-3-chengzhihao1@huawei.com>
 <Zhccfw4HbC_MKj65@makrotopia.org>
From: Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <5d858fbc-11cb-8d02-a4b6-a640625c7e1d@huawei.com>
Date: Thu, 11 Apr 2024 10:39:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <Zhccfw4HbC_MKj65@makrotopia.org>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600013.china.huawei.com (7.193.23.68)

ÔÚ 2024/4/11 7:10, Daniel Golle Ð´µÀ:
> Hi!
> 
> On Wed, Apr 10, 2024 at 03:40:33PM +0800, Zhihao Cheng wrote:
>> The ubiblock_init called by ubi_init will register device number, but
>> device number is not released in error handling path of ubi_init when
>> ubi is loaded by inserting module (eg. attaching failure), which leads
>> to subsequent ubi_init calls failed by running out of device number
>> (dmesg shows that "__register_blkdev: failed to get major for ubiblock").
>> Fix it by invoking ubiblock_exit() in corresponding error handling path.
> 
> Thank you for taking care of this issue.
> 
> See my comment inline below:
> 
>>
>> Fixes: 927c145208b0 ("mtd: ubi: attach from device tree")
>> Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
>> ---
>>   drivers/mtd/ubi/build.c | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/mtd/ubi/build.c b/drivers/mtd/ubi/build.c
>> index 7f95fd7968a8..354517194099 100644
>> --- a/drivers/mtd/ubi/build.c
>> +++ b/drivers/mtd/ubi/build.c
>> @@ -1380,12 +1380,13 @@ static int __init ubi_init(void)
>>   	if (ubi_is_module()) {
>>   		err = ubi_init_attach();
>>   		if (err)
>> -			goto out_mtd_notifier;
>> +			goto out_block_exit;
>>   	}
>>   
>>   	return 0;
>>   
>> -out_mtd_notifier:
>> +out_block_exit:
>> +	ubiblock_exit();
> 
> I believe that this call is the reason for the section mismatch we
> are seeing on Intel's kernel test builds:
> 
> https://lore.kernel.org/oe-kbuild-all/202404110656.wLLc5mHR-lkp@intel.com/
> 
> Also note that Ben Hutchings has supplied a more complete and imho
> better solution for this problem, which yet still suffers from the
> same problem (calling __exit function from __init function which
> results in section mismatch).
> 

My mistake, I always forget to check make W=1, I will send a new version 
to combine Ben's modifications. Thanks to point that.
> 
>>   	unregister_mtd_user(&ubi_mtd_notifier);
>>   out_debugfs:
>>   	ubi_debugfs_exit();
>> -- 
>> 2.39.2
>>
> .
> 


