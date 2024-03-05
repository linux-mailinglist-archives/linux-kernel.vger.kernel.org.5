Return-Path: <linux-kernel+bounces-92266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0C90871DAE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 12:29:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 652CE289791
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 11:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65A7F5C61F;
	Tue,  5 Mar 2024 11:25:46 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC15D5C5EA;
	Tue,  5 Mar 2024 11:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709637945; cv=none; b=EaRlDpQcvpHWuKS1O9ddtnLAjrrDd+BVTDKu25jn4IDvbyyA55acPaqDxnvuouvX/5O8PABaumaztCVVC4amoIOo/DHxo8SlbUQfX2aPyr/Rxd0mP/loZm9cKujluI9C8mUtfTCnaPl7i0/zyo50UPmZLD6tHXbQ6iGDtkmlfUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709637945; c=relaxed/simple;
	bh=bWd1eT40X/hwHp5WSMPfe4kK7Kcuvxaxtjt4Df76y6Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=WtTRol4Y1eqw3asUigygiLyU8AzkpWze3jvpuHHj+Acyev20n1sO0E4iBXSCMEexTTOyaGFlt4T8iKY04sIIkp7HLLaumZIkVxJ1/iSiCjTzn2dhW/ptsD8JKkRRD72+RgU1vFKyIP9Ig0QFMFo45DEEU4h8c4S4cL4N8ZZ3xDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4TptTt282Mz1h1CG;
	Tue,  5 Mar 2024 19:23:14 +0800 (CST)
Received: from dggpemd100001.china.huawei.com (unknown [7.185.36.94])
	by mail.maildlp.com (Postfix) with ESMTPS id 6259F1A0172;
	Tue,  5 Mar 2024 19:25:34 +0800 (CST)
Received: from [10.67.120.108] (10.67.120.108) by
 dggpemd100001.china.huawei.com (7.185.36.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 5 Mar 2024 19:25:34 +0800
Message-ID: <15c6d1cf-0aaa-0a01-5bf4-0762f45d7676@huawei.com>
Date: Tue, 5 Mar 2024 19:25:33 +0800
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
To: John Garry <john.g.garry@oracle.com>, Jason Yan <yanaijie@huawei.com>,
	<jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
	<damien.lemoal@opensource.wdc.com>
CC: <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linuxarm@huawei.com>, <prime.zeng@hisilicon.com>,
	<chenxiang66@hisilicon.com>, <kangfenglong@huawei.com>
References: <20240221073159.29408-1-yangxingui@huawei.com>
 <f095aa1c-f233-40f9-ad0f-fcd8fe69a80d@oracle.com>
 <e2a725ee-98b3-fd57-6ee4-af031ffbd6bc@huawei.com>
 <80050a50-af6a-5862-8c12-ccaf91c5ff74@huawei.com>
 <7e1b554b-a675-14d2-59aa-7f37e3dd5994@huawei.com>
 <a7eb46e3-997c-4746-b820-a09229e75581@oracle.com>
From: yangxingui <yangxingui@huawei.com>
In-Reply-To: <a7eb46e3-997c-4746-b820-a09229e75581@oracle.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggpemm100022.china.huawei.com (7.185.36.132) To
 dggpemd100001.china.huawei.com (7.185.36.94)


Hi John,
On 2024/3/5 18:15, John Garry wrote:
> On 05/03/2024 02:56, Jason Yan wrote:
>> On 2024/3/4 20:50, yangxingui wrote:
>>> Hi Jason,
>>>
>>> On 2024/3/1 9:55, Jason Yan wrote:
>>>> On 2024/2/29 2:13, John Garry wrote:
>>>>> On 21/02/2024 07:31, Xingui Yang wrote:
>>>>>> As of commit d8649fc1c5e4 ("scsi: libsas: Do discovery on empty 
>>>>>> PHY to
>>>>>> update PHY info"), do discovery will send a new SMP_DISCOVER and 
>>>>>> update
>>>>>> phy->phy_change_count. We found that if the disk is reconnected 
>>>>>> and phy
>>>>>> change_count changes at this time, the disk scanning process will 
>>>>>> not be
>>>>>> triggered.
>>>>>>
>>>>>> So update the PHY info with the last query results.
>>>>>>
>>>>>> Fixes: d8649fc1c5e4 ("scsi: libsas: Do discovery on empty PHY to 
>>>>>> update PHY info")
>>>>>> Signed-off-by: Xingui Yang <yangxingui@huawei.com>kkkkk
>>>>>> ---
>>>>>>   drivers/scsi/libsas/sas_expander.c | 9 ++++-----
>>>>>>   1 file changed, 4 insertions(+), 5 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/scsi/libsas/sas_expander.c 
>>>>>> b/drivers/scsi/libsas/sas_expander.c
>>>>>> index a2204674b680..9563f5589948 100644
>>>>>> --- a/drivers/scsi/libsas/sas_expander.c
>>>>>> +++ b/drivers/scsi/libsas/sas_expander.c
>>>>>> @@ -1681,6 +1681,10 @@ int sas_get_phy_attached_dev(struct 
>>>>>> domain_device *dev, int phy_id,
>>>>>>           if (*type == 0)
>>>>>>               memset(sas_addr, 0, SAS_ADDR_SIZE);
>>>>>>       }
>>>>>> +
>>>>>> +    if ((SAS_ADDR(sas_addr) == 0) || (res == -ECOMM))
>>>>>
>>>>> It's odd to call sas_set_ex_phy() if we got res == -ECOMM. I mean, 
>>>>> in this this case disc_resp is not filled in as the command did not 
>>>>> execute, right? I know that is what the current code does, but it 
>>>>> is strange.
>>>>
>>>> The current code actually re-send the SMP command and update the PHY 
>>>> status only when the the SMP command is responded correctly.
>>>>
>>>> Xinggui, can you please fix this and send v3?
>>> The current location cannot directly update the phy information. The 
>>> previous phy information will be used later, and the previous sas 
>>> address will be compared with the currently queried sas address. At 
>>> present, v2 is more suitable after many days of testing.
> 
> I don't understand this. Where is the previous SAS address compared to 
> the current SAS address?
> 
> Could this work:
> 
> diff --git a/drivers/scsi/libsas/sas_expander.c 
> b/drivers/scsi/libsas/sas_expander.c
> index a2204674b680..e190038ba7bd 100644
> --- a/drivers/scsi/libsas/sas_expander.c
> +++ b/drivers/scsi/libsas/sas_expander.c
> @@ -1675,11 +1675,13 @@ int sas_get_phy_attached_dev(struct 
> domain_device *dev, int phy_id,
> 
>          res = sas_get_phy_discover(dev, phy_id, disc_resp);
>          if (res == 0) {
> -               memcpy(sas_addr, disc_resp->disc.attached_sas_addr,
> -                      SAS_ADDR_SIZE);
>                  *type = to_dev_type(&disc_resp->disc);
> -               if (*type == 0)
> +               if (*type == SAS_PHY_UNUSED)
>                          memset(sas_addr, 0, SAS_ADDR_SIZE);
> +               else
> +                       memcpy(sas_addr, disc_resp->disc.attached_sas_addr,
> +                      SAS_ADDR_SIZE);
> +               sas_set_ex_phy(dev, phy_id, disc_resp);
>          }
>          kfree(disc_resp);
>          return res;
> lines 1-21/21 (END)
> 
> It's like the change in this patch.
This doesn't work properly. the previous sas address will be compared 
with the currently queried sas address and the previous phy information 
will also be used when calling sas_unregister_devs_sas_addr() after the 
sas_rediscover_dev() function calls sas_get_phy_attached_dev(). 
Therefore, it is more appropriate to update the phy information after 
the device is unregistered. as follows:
static int sas_rediscover_dev(struct domain_device *dev, int phy_id,
                               bool last, int sibling)
{
	...
        res = sas_get_phy_attached_dev(dev, phy_id, sas_addr, &type);
         switch (res) {
         case SMP_RESP_NO_PHY:
                 phy->phy_state = PHY_NOT_PRESENT;
                 sas_unregister_devs_sas_addr(dev, phy_id, last);
                 return res;
         case SMP_RESP_PHY_VACANT:
                 phy->phy_state = PHY_VACANT;
                 sas_unregister_devs_sas_addr(dev, phy_id, last);
                 return res;
         case SMP_RESP_FUNC_ACC:
                 break;
         case -ECOMM:
                 break;
         default:
                 return res;
         }

         if ((SAS_ADDR(sas_addr) == 0) || (res == -ECOMM)) {
                 phy->phy_state = PHY_EMPTY;
                 sas_unregister_devs_sas_addr(dev, phy_id, last);
                 /*
                  * Even though the PHY is empty, for convenience we 
discover
                  * the PHY to update the PHY info, like negotiated 
linkrate.
                  */
                 sas_ex_phy_discover(dev, phy_id);
                 return res;
         } else if (SAS_ADDR(sas_addr) == 
SAS_ADDR(phy->attached_sas_addr) && // <=== Compare the previous sas 
address with the current sas address
                    dev_type_flutter(type, phy->attached_dev_type)) {
                 struct domain_device *ata_dev = sas_ex_to_ata(dev, phy_id);
                 char *action = "";

                 sas_ex_phy_discover(dev, phy_id);

                 if (ata_dev && phy->attached_dev_type == SAS_SATA_PENDING)
                         action = ", needs recovery";
                 pr_debug("ex %016llx phy%02d broadcast flutter%s\n",
                          SAS_ADDR(dev->sas_addr), phy_id, action);
                 return res;
         }

> 
> 
>>
>> OK, so let me have a closer look at v2.
> 
> I have to say that v2 is quite complicated...
Yes, but it works.

Thanks,
Xingui

