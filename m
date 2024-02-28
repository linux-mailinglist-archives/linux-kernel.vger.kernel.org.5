Return-Path: <linux-kernel+bounces-85078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2BFE86B014
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 14:14:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EBB528A55E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 13:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BAE214AD3B;
	Wed, 28 Feb 2024 13:13:58 +0000 (UTC)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06AAE149E0B;
	Wed, 28 Feb 2024 13:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709126037; cv=none; b=ZdP5ak93nlT60V92o77ZoU8oIkDghEBijn7mqLlqkHn4gp2r7d1r5iiFVwll1XlxBX0Lgb0L1o24gWYacaGc6z6VAXdFFbZPrXiejqxb0VdeTPN/IMGtwcoplA6rZ/EEE+YN94AHge2QnpZzzUqXfYYS6CTOwd9KR7zZymM1LRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709126037; c=relaxed/simple;
	bh=HgwVfW0K+Hhu2RJ2w8yehDlFn8KAHL04pm/mocETtp0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ScBJPmK63lQa0ygbcYtugbbP+p4ex4A5fps5HNG/WC1bzdj3Wv9WvEw4UHtU49+YA4dH38wtlf7cOU780oHn3dEZ2n2JzMeKTmQhESlhsITeiT79Z2qdXfxkhz4JGEONxOFX2CxMl6TLm6JTzkBClN84KDnxn4XGUGqGcM18Uwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4TlFCZ73XBzqhs3;
	Wed, 28 Feb 2024 21:13:14 +0800 (CST)
Received: from dggpemd100001.china.huawei.com (unknown [7.185.36.94])
	by mail.maildlp.com (Postfix) with ESMTPS id 3CE591A016B;
	Wed, 28 Feb 2024 21:13:52 +0800 (CST)
Received: from [10.67.120.108] (10.67.120.108) by
 dggpemd100001.china.huawei.com (7.185.36.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 28 Feb 2024 21:13:51 +0800
Message-ID: <693dec74-1750-191e-cbc3-37f993d165ac@huawei.com>
Date: Wed, 28 Feb 2024 21:13:51 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH] scsi: libsas: Fix disk not being scanned in after being
 removed
Content-Language: en-CA
To: John Garry <john.g.garry@oracle.com>, <yanaijie@huawei.com>,
	<jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
	<damien.lemoal@opensource.wdc.com>
CC: <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linuxarm@huawei.com>, <prime.zeng@hisilicon.com>,
	<chenxiang66@hisilicon.com>, <kangfenglong@huawei.com>
References: <20240221073159.29408-1-yangxingui@huawei.com>
 <d765d2c5-3451-4519-a5e1-9e8f28dcd6b3@oracle.com>
From: yangxingui <yangxingui@huawei.com>
In-Reply-To: <d765d2c5-3451-4519-a5e1-9e8f28dcd6b3@oracle.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggpemm100023.china.huawei.com (7.185.36.248) To
 dggpemd100001.china.huawei.com (7.185.36.94)

Hi John,

On 2024/2/22 20:41, John Garry wrote:
> On 21/02/2024 07:31, Xingui Yang wrote:
>> As of commit d8649fc1c5e4 ("scsi: libsas: Do discovery on empty PHY to
>> update PHY info"), do discovery will send a new SMP_DISCOVER and update
>> phy->phy_change_count. We found that if the disk is reconnected and phy
>> change_count changes at this time, the disk scanning process will not be
>> triggered.
>>
>> So update the PHY info with the last query results.
>>
>> Fixes: d8649fc1c5e4 ("scsi: libsas: Do discovery on empty PHY to 
>> update PHY info")
>> Signed-off-by: Xingui Yang <yangxingui@huawei.com>
>> ---
>>   drivers/scsi/libsas/sas_expander.c | 9 ++++-----
>>   1 file changed, 4 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/scsi/libsas/sas_expander.c 
>> b/drivers/scsi/libsas/sas_expander.c
>> index a2204674b680..9563f5589948 100644
>> --- a/drivers/scsi/libsas/sas_expander.c
>> +++ b/drivers/scsi/libsas/sas_expander.c
>> @@ -1681,6 +1681,10 @@ int sas_get_phy_attached_dev(struct 
>> domain_device *dev, int phy_id,
>>           if (*type == 0)
>>               memset(sas_addr, 0, SAS_ADDR_SIZE);
>>       }
>> +
>> +    if ((SAS_ADDR(sas_addr) == 0) || (res == -ECOMM))
>> +        sas_set_ex_phy(dev, phy_id, disc_resp);
>> +
>>       kfree(disc_resp);
>>       return res;
>>   }
>> @@ -1972,11 +1976,6 @@ static int sas_rediscover_dev(struct 
>> domain_device *dev, int phy_id,
>>       if ((SAS_ADDR(sas_addr) == 0) || (res == -ECOMM)) {
>>           phy->phy_state = PHY_EMPTY;
>>           sas_unregister_devs_sas_addr(dev, phy_id, last);
>> -        /*
>> -         * Even though the PHY is empty, for convenience we discover
>> -         * the PHY to update the PHY info, like negotiated linkrate.
>> -         */
>> -        sas_ex_phy_discover(dev, phy_id);
> 
> It would be nice to be able to call sas_set_ex_phy() here (instead of 
> sas_get_phy_attached_dev()), but I assume that you can't do that as the 
> disc_resp memory is not available.
> 
By the way, I have updated a version and call sas_set_ex_phy() here, 
please check it again.

Thanks,
Xingui

