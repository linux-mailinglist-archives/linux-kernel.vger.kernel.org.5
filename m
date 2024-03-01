Return-Path: <linux-kernel+bounces-87804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 572F086D940
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 02:55:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E68E91F21F58
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 01:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17D6638F9A;
	Fri,  1 Mar 2024 01:55:39 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76F538DC3;
	Fri,  1 Mar 2024 01:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709258138; cv=none; b=TiCiakTg3jiEo+SQp1oW9N+VpUEuJc1HiKqRCxx+IuQ7134KYq3yAlxm4Dfd7KLePeP0JPOuIOwLP2bnCGAenBeZ9gEJVaj6aPWx9zgDFCHnHj3YUfsT90nDozPRszhgiQbwgsRbT4BFC1dS2CQDzowq9NFWm2fTaE+Wz8sQnMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709258138; c=relaxed/simple;
	bh=oqWoH8VhvOjQFKWrC83og1gw9x5C8cR+JCMt9m9J5hM=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=O+RlPo1KOIMltdUESKz51ro/ZqGtLyWmDD6N0q9U/bfpDNZuzNUNeIrSa2oR83qgWGlWva6EZxOx3J4WRfzP33fJUtfDvUEiHYBQOrNQQsPJu0TS/ScqFhLsZ0CWimwtE4g0EqnoOu93zd4rHzWk/qFmyueLNOleOCwXu5Rwgis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4TmB2T0nQ4z1Q96j;
	Fri,  1 Mar 2024 09:53:37 +0800 (CST)
Received: from canpemm100001.china.huawei.com (unknown [7.192.105.122])
	by mail.maildlp.com (Postfix) with ESMTPS id C68C914037F;
	Fri,  1 Mar 2024 09:55:27 +0800 (CST)
Received: from canpemm500004.china.huawei.com (7.192.104.92) by
 canpemm100001.china.huawei.com (7.192.105.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 1 Mar 2024 09:55:27 +0800
Received: from [10.174.179.14] (10.174.179.14) by
 canpemm500004.china.huawei.com (7.192.104.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 1 Mar 2024 09:55:26 +0800
Subject: Re: [PATCH] scsi: libsas: Fix disk not being scanned in after being
 removed
To: John Garry <john.g.garry@oracle.com>, Xingui Yang <yangxingui@huawei.com>,
	<jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
	<damien.lemoal@opensource.wdc.com>
CC: <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linuxarm@huawei.com>, <prime.zeng@hisilicon.com>,
	<chenxiang66@hisilicon.com>, <kangfenglong@huawei.com>
References: <20240221073159.29408-1-yangxingui@huawei.com>
 <f095aa1c-f233-40f9-ad0f-fcd8fe69a80d@oracle.com>
From: Jason Yan <yanaijie@huawei.com>
Message-ID: <e2a725ee-98b3-fd57-6ee4-af031ffbd6bc@huawei.com>
Date: Fri, 1 Mar 2024 09:55:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <f095aa1c-f233-40f9-ad0f-fcd8fe69a80d@oracle.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500004.china.huawei.com (7.192.104.92)

On 2024/2/29 2:13, John Garry wrote:
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
> 
> It's odd to call sas_set_ex_phy() if we got res == -ECOMM. I mean, in 
> this this case disc_resp is not filled in as the command did not 
> execute, right? I know that is what the current code does, but it is 
> strange.

The current code actually re-send the SMP command and update the PHY 
status only when the the SMP command is responded correctly.

Xinggui, can you please fix this and send v3?

Thanks,
Jason


