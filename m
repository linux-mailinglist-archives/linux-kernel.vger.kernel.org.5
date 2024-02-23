Return-Path: <linux-kernel+bounces-77749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5B148609B8
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 05:04:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D70911C24865
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 04:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 256A810A0F;
	Fri, 23 Feb 2024 04:04:09 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29BA1DDBB;
	Fri, 23 Feb 2024 04:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708661048; cv=none; b=Ns9tJn9o5eP9SKFfzn3Dcse6ubkVXNQs9Vd5BCSRsCPu01XANeJqeKsj0XCX7C3b28VUfkEflnEXn4+RqfDv86eCouwv0nkgKUoTQF57+DSZxQZWqQDquzS7Bo/v/5SJOncAQH5A0qu5UeGC+s/ISIjDuvKYT3/uRv+t/vQfM/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708661048; c=relaxed/simple;
	bh=+jJXh3JI6/eDHOXx7UoyvGGmWo03Sw60R1FpgN7AYBo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=MjzhH8z5K2GXQ+vVrpsInMiwgc8zqPLAInFk0ckjGLq3jRs2wvvuoP3BPvznGtHtTI28/jraBzImaBDf0FpSGT76XuauOEAXPbjLpYyZp+9ww1+CZm9N4rz8Ci9R3T1u+t4dzgvWR5NdTXpp2OIPhtAF1w0K9dWa8dkIYJD7m9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4TgxCx3vkgzXhJB;
	Fri, 23 Feb 2024 12:02:05 +0800 (CST)
Received: from dggpemd100001.china.huawei.com (unknown [7.185.36.94])
	by mail.maildlp.com (Postfix) with ESMTPS id 913B31400CA;
	Fri, 23 Feb 2024 12:04:02 +0800 (CST)
Received: from [10.67.120.108] (10.67.120.108) by
 dggpemd100001.china.huawei.com (7.185.36.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 23 Feb 2024 12:04:02 +0800
Message-ID: <cdf241a7-8504-5b87-2d18-d2a971f6ebb9@huawei.com>
Date: Fri, 23 Feb 2024 12:04:01 +0800
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
X-ClientProxiedBy: dggpemm500004.china.huawei.com (7.185.36.219) To
 dggpemd100001.china.huawei.com (7.185.36.94)

Hi, John

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
> If we were to manually set the PHY info here instead, how would that look?
Yes, I think it is indeed better to use sas_set_ex_phy, as you said, 
disc_resp memory is not available. Maybe we can use sas_get_phy_discover 
instead of sas_get_phy_attached_dev so we can use disc_resp?
as follow:
+++ b/drivers/scsi/libsas/sas_expander.c
@@ -1940,6 +1940,7 @@ static int sas_rediscover_dev(struct domain_device 
*dev, int phy_id,
         struct expander_device *ex = &dev->ex_dev;
         struct ex_phy *phy = &ex->ex_phy[phy_id];
         enum sas_device_type type = SAS_PHY_UNUSED;
+       struct smp_disc_resp *disc_resp;
         u8 sas_addr[SAS_ADDR_SIZE];
         char msg[80] = "";
         int res;
@@ -1951,33 +1952,41 @@ static int sas_rediscover_dev(struct 
domain_device *dev, int phy_id,
                  SAS_ADDR(dev->sas_addr), phy_id, msg);

         memset(sas_addr, 0, SAS_ADDR_SIZE);
-       res = sas_get_phy_attached_dev(dev, phy_id, sas_addr, &type);
+       disc_resp = alloc_smp_resp(DISCOVER_RESP_SIZE);
+       if (!disc_resp)
+               return -ENOMEM;
+       res = sas_get_phy_discover(dev, phy_id, disc_resp);
..
-               /*
-                * Even though the PHY is empty, for convenience we discover
-                * the PHY to update the PHY info, like negotiated linkrate.
-                */
-               sas_ex_phy_discover(dev, phy_id);
-               return res;
+		if (res == 0)
+               	sas_set_ex_phy(dev, phy_id, disc_resp);
+               goto out;

..

+out:
+	kfree(disc_resp);
+	return res;

Thanks.
Xingui


