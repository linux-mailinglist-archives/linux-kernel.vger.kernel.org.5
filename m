Return-Path: <linux-kernel+bounces-77860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8A60860B1C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 08:04:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA1691C224FD
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 07:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED03E134D1;
	Fri, 23 Feb 2024 07:04:10 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8BF12E5E;
	Fri, 23 Feb 2024 07:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708671850; cv=none; b=Zz1/seuJp3Zube0zuUUGr0ADDXaskIGEOumF+AK/INgCbZIoiMxWXlJ0FPyi5Ur4ULOGAMQBbgq7CS+T7kMHAKnwt3Ij6ig8jMb9n7jZGPi/NzRPB05IV4Xj0I+qz6TmW28u35r+ksOgVWvioOskuUdJCke8uYhsZHcdOnIr+J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708671850; c=relaxed/simple;
	bh=T43BLEbFn/rY6Onlkz3M/nH7U1rGkzTWtfmwRvtPX34=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=pivkHnrDYyC2gCSiN3gsSFuPNpehruMCwYwHPSRIocXN56F1SgSMrTeKwRk0dIjt4LCOzSzF2Nskvlhs5tl3WJ3u+GJEDADih38OGaKZ7yEyTRmQWxbNIQdvCccUhq0iiUdMT2rv+zKPm33MZoCLqjsHtmoxb9S+YAy7mQpn8AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Th18D0w7Wz1FLFm;
	Fri, 23 Feb 2024 14:59:08 +0800 (CST)
Received: from canpemm500003.china.huawei.com (unknown [7.192.105.39])
	by mail.maildlp.com (Postfix) with ESMTPS id D2CE31400CC;
	Fri, 23 Feb 2024 15:04:01 +0800 (CST)
Received: from canpemm500004.china.huawei.com (7.192.104.92) by
 canpemm500003.china.huawei.com (7.192.105.39) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 23 Feb 2024 15:04:01 +0800
Received: from [10.174.179.14] (10.174.179.14) by
 canpemm500004.china.huawei.com (7.192.104.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 23 Feb 2024 15:04:00 +0800
Subject: Re: [PATCH] scsi: libsas: Fix disk not being scanned in after being
 removed
To: yangxingui <yangxingui@huawei.com>, John Garry <john.g.garry@oracle.com>,
	<jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
	<damien.lemoal@opensource.wdc.com>
CC: <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linuxarm@huawei.com>, <prime.zeng@hisilicon.com>,
	<chenxiang66@hisilicon.com>, <kangfenglong@huawei.com>
References: <20240221073159.29408-1-yangxingui@huawei.com>
 <d765d2c5-3451-4519-a5e1-9e8f28dcd6b3@oracle.com>
 <cdf241a7-8504-5b87-2d18-d2a971f6ebb9@huawei.com>
From: Jason Yan <yanaijie@huawei.com>
Message-ID: <8dc34f04-943b-26fd-01bc-34fb98803503@huawei.com>
Date: Fri, 23 Feb 2024 15:04:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <cdf241a7-8504-5b87-2d18-d2a971f6ebb9@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500004.china.huawei.com (7.192.104.92)

On 2024/2/23 12:04, yangxingui wrote:
> Hi, John
> 
> On 2024/2/22 20:41, John Garry wrote:
>> On 21/02/2024 07:31, Xingui Yang wrote:
>>> As of commit d8649fc1c5e4 ("scsi: libsas: Do discovery on empty PHY to
>>> update PHY info"), do discovery will send a new SMP_DISCOVER and update
>>> phy->phy_change_count. We found that if the disk is reconnected and phy
>>> change_count changes at this time, the disk scanning process will not be
>>> triggered.
>>>
>>> So update the PHY info with the last query results.
>>>
>>> Fixes: d8649fc1c5e4 ("scsi: libsas: Do discovery on empty PHY to 
>>> update PHY info")
>>> Signed-off-by: Xingui Yang <yangxingui@huawei.com>
>>> ---
>>>   drivers/scsi/libsas/sas_expander.c | 9 ++++-----
>>>   1 file changed, 4 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/scsi/libsas/sas_expander.c 
>>> b/drivers/scsi/libsas/sas_expander.c
>>> index a2204674b680..9563f5589948 100644
>>> --- a/drivers/scsi/libsas/sas_expander.c
>>> +++ b/drivers/scsi/libsas/sas_expander.c
>>> @@ -1681,6 +1681,10 @@ int sas_get_phy_attached_dev(struct 
>>> domain_device *dev, int phy_id,
>>>           if (*type == 0)
>>>               memset(sas_addr, 0, SAS_ADDR_SIZE);
>>>       }
>>> +
>>> +    if ((SAS_ADDR(sas_addr) == 0) || (res == -ECOMM))
>>> +        sas_set_ex_phy(dev, phy_id, disc_resp);
>>> +
>>>       kfree(disc_resp);
>>>       return res;
>>>   }
>>> @@ -1972,11 +1976,6 @@ static int sas_rediscover_dev(struct 
>>> domain_device *dev, int phy_id,
>>>       if ((SAS_ADDR(sas_addr) == 0) || (res == -ECOMM)) {
>>>           phy->phy_state = PHY_EMPTY;
>>>           sas_unregister_devs_sas_addr(dev, phy_id, last);
>>> -        /*
>>> -         * Even though the PHY is empty, for convenience we discover
>>> -         * the PHY to update the PHY info, like negotiated linkrate.
>>> -         */
>>> -        sas_ex_phy_discover(dev, phy_id);
>>
>> It would be nice to be able to call sas_set_ex_phy() here (instead of 
>> sas_get_phy_attached_dev()), but I assume that you can't do that as 
>> the disc_resp memory is not available.
>>
>> If we were to manually set the PHY info here instead, how would that 
>> look?
> Yes, I think it is indeed better to use sas_set_ex_phy, as you said, 
> disc_resp memory is not available. Maybe we can use sas_get_phy_discover 
> instead of sas_get_phy_attached_dev so we can use disc_resp?

Can we directly set phy->negotiated_linkrate = SAS_PHY_DISABLED here? 
For an empty PHY the other variables means nothing, so why bother get 
and update them?

Thanks,
Jason


