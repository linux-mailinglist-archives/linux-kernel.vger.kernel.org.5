Return-Path: <linux-kernel+bounces-149447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C599A8A913B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 04:43:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0774AB21B98
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 02:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E6544F896;
	Thu, 18 Apr 2024 02:42:57 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A856FB0;
	Thu, 18 Apr 2024 02:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713408176; cv=none; b=q9APcIaSjMVsTv/FGkir+jm7F8VXAbvEX0KNHncJTCZn3ohaw6bnwKXTL5uagzfmfz8dZzMVYgtjrCmovAtmbowr67zJIK74AUTSNK1dS4LverU+x34ITROpZ7Eu2BcaBGa+R488kgFb34bJ9npPPN7Zm/EiH8/Y+hDi+rnufEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713408176; c=relaxed/simple;
	bh=lyNSUQkG5hAPF0cdgrzZAOyzvIpcbVYT5Loo2w3/q+Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=s5HiCvvCd4tz+8uZOefKvpIqqp58VXA6lnfLgCNLfQrEqEpljjpTz7sxtM1J7g206DNoessCm3s8Vf2HfqR5P93/4OYC2m90USj1yZ8Nv0YJP6ssMeBGCrOv4N9II3iww2mtED4uk1Nt9pxnUysUqHthmw8hYr6NMhsAGCrpFvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4VKhpK6byvzNrvV;
	Thu, 18 Apr 2024 10:40:25 +0800 (CST)
Received: from dggpemd100001.china.huawei.com (unknown [7.185.36.94])
	by mail.maildlp.com (Postfix) with ESMTPS id 5F9FF18006D;
	Thu, 18 Apr 2024 10:42:50 +0800 (CST)
Received: from [10.67.120.108] (10.67.120.108) by
 dggpemd100001.china.huawei.com (7.185.36.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 18 Apr 2024 10:42:50 +0800
Message-ID: <f1d32ff4-dba3-037b-b9f1-f20feab1304a@huawei.com>
Date: Thu, 18 Apr 2024 10:42:49 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH] scsi: libsas: Fix exp-attached end device cannot be
 scanned in again after probe failed
Content-Language: en-CA
To: Jason Yan <yanaijie@huawei.com>, <john.g.garry@oracle.com>,
	<jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
	<damien.lemoal@opensource.wdc.com>
CC: <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linuxarm@huawei.com>, <prime.zeng@hisilicon.com>,
	<chenxiang66@hisilicon.com>, <kangfenglong@huawei.com>
References: <20240416030727.17074-1-yangxingui@huawei.com>
 <e33272f8-1ff5-561f-60a3-b4d24fe27c6b@huawei.com>
 <e7e26224-0e0c-f6bf-d24e-5a9a6d84a8e1@huawei.com>
 <59f29a27-a7c4-6278-d5ac-be802027b603@huawei.com>
From: yangxingui <yangxingui@huawei.com>
In-Reply-To: <59f29a27-a7c4-6278-d5ac-be802027b603@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggpemm500007.china.huawei.com (7.185.36.183) To
 dggpemd100001.china.huawei.com (7.185.36.94)

Hi Jason,

On 2024/4/18 9:46, Jason Yan wrote:
> On 2024/4/17 15:47, yangxingui wrote:
>>
>>
>> On 2024/4/17 9:46, Jason Yan wrote:
>>> Hi Xingui,
>>>
>>> On 2024/4/16 11:07, Xingui Yang wrote:
>>>> We found that it is judged as broadcast flutter and exits directly 
>>>> when the
>>>> exp-attached end device reconnects after the end device probe failed.
>>>
>>> Can you please describe how to reproduce this issue in detail?
>> The test steps we currently construct are to simulate link 
>> abnormalities and adjust the rate of the remote phy when running IO on 
>> all disks.
>>
>> When the sata disk is probed and the IDENTIFY command is sent to the 
>> disk, the expander return rate is abnormal, causing sata disk probe 
>> fail. But there may be many reasons for device probe failure, 
>> including expander or disk instability or link abnormalities.
>>
>>>
>>> Thanks,
>>> Jason
>>>
>>>>
>>>> [78779.654026] sas: broadcast received: 0
>>>> [78779.654037] sas: REVALIDATING DOMAIN on port 0, pid:10
>>>> [78779.654680] sas: ex 500e004aaaaaaa1f phy05 change count has changed
>>>> [78779.662977] sas: ex 500e004aaaaaaa1f phy05 originated 
>>>> BROADCAST(CHANGE)
>>>> [78779.662986] sas: ex 500e004aaaaaaa1f phy05 new device attached
>>>> [78779.663079] sas: ex 500e004aaaaaaa1f phy05:U:8 attached: 
>>>> 500e004aaaaaaa05 (stp)
>>>> [78779.693542] hisi_sas_v3_hw 0000:b4:02.0: dev[16:5] found
>>>> [78779.701155] sas: done REVALIDATING DOMAIN on port 0, pid:10, res 0x0
>>>> [78779.707864] sas: Enter sas_scsi_recover_host busy: 0 failed: 0
>>>> ...
>>>> [78835.161307] sas: --- Exit sas_scsi_recover_host: busy: 0 failed: 
>>>> 0 tries: 1
>>>> [78835.171344] sas: sas_probe_sata: for exp-attached device 
>>>> 500e004aaaaaaa05 returned -19
>>>> [78835.180879] hisi_sas_v3_hw 0000:b4:02.0: dev[16:5] is gone
>>>> [78835.187487] sas: broadcast received: 0
>>>> [78835.187504] sas: REVALIDATING DOMAIN on port 0, pid:10
>>>> [78835.188263] sas: ex 500e004aaaaaaa1f phy05 change count has changed
>>>> [78835.195870] sas: ex 500e004aaaaaaa1f phy05 originated 
>>>> BROADCAST(CHANGE)
>>>> [78835.195875] sas: ex 500e004aaaaaaa1f rediscovering phy05
>>>> [78835.196022] sas: ex 500e004aaaaaaa1f phy05:U:A attached: 
>>>> 500e004aaaaaaa05 (stp)
>>>> [78835.196026] sas: ex 500e004aaaaaaa1f phy05 broadcast flutter
>>>> [78835.197615] sas: done REVALIDATING DOMAIN on port 0, pid:10, res 0x0
>>>>
>>>> The cause of the problem is that the related ex_phy information was not
>>>> cleared after the end device probe failed. In order to solve the above
>>>> problem, a function sas_ex_unregister_end_dev() is defined to clear the
>>>> ex_phy information and unregister the end device when the 
>>>> exp-attached end
>>>> device probe failed.
>>>>
>>>> As the sata device is an asynchronous probe, the sata device may probe
>>>> failed after done REVALIDATING DOMAIN. Then after the port is added 
>>>> to the
>>>> sas_port_del_list, the port will not be deleted until the end of the 
>>>> next
>>>> REVALIDATING DOMAIN and sas_destruct_ports() is called. A warning about
>>>> creating a duplicate port will occur in the new REVALIDATING DOMAIN 
>>>> when
>>>> the end device reconnects. Therefore, the previous destroy_list and
>>>> sas_port_del_list should be handled before REVALIDATING DOMAIN.
>>>>
>>>> Signed-off-by: Xingui Yang <yangxingui@huawei.com>
>>>> ---
>>>>   drivers/scsi/libsas/sas_discover.c |  2 ++
>>>>   drivers/scsi/libsas/sas_expander.c | 16 ++++++++++++++++
>>>>   drivers/scsi/libsas/sas_internal.h |  6 +++++-
>>>>   3 files changed, 23 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/scsi/libsas/sas_discover.c 
>>>> b/drivers/scsi/libsas/sas_discover.c
>>>> index 8fb7c41c0962..aae90153f4c6 100644
>>>> --- a/drivers/scsi/libsas/sas_discover.c
>>>> +++ b/drivers/scsi/libsas/sas_discover.c
>>>> @@ -517,6 +517,8 @@ static void sas_revalidate_domain(struct 
>>>> work_struct *work)
>>>>       struct sas_ha_struct *ha = port->ha;
>>>>       struct domain_device *ddev = port->port_dev;
>>>> +    sas_destruct_devices(port);
>>>> +    sas_destruct_ports(port);
>>>>       /* prevent revalidation from finding sata links in recovery */
>>>>       mutex_lock(&ha->disco_mutex);
>>>>       if (test_bit(SAS_HA_ATA_EH_ACTIVE, &ha->state)) {
>>>> diff --git a/drivers/scsi/libsas/sas_expander.c 
>>>> b/drivers/scsi/libsas/sas_expander.c
>>>> index f6e6db8b8aba..6ae1f4aaaf61 100644
>>>> --- a/drivers/scsi/libsas/sas_expander.c
>>>> +++ b/drivers/scsi/libsas/sas_expander.c
>>>> @@ -1856,6 +1856,22 @@ static void 
>>>> sas_unregister_devs_sas_addr(struct domain_device *parent,
>>>>       }
>>>>   }
>>>> +void sas_ex_unregister_end_dev(struct domain_device *dev)
>>>> +{
>>>> +    struct domain_device *parent = dev->parent;
>>>> +    struct expander_device *parent_ex = &parent->ex_dev;
>>>> +    int i;
>>>> +
>>>> +    for (i = 0; i < parent_ex->num_phys; i++) {
>>>> +        struct ex_phy *phy = &parent_ex->ex_phy[i];
>>>> +
>>>> +        if (sas_phy_match_dev_addr(dev, phy)) {
>>>> +            sas_unregister_devs_sas_addr(parent, i, true);
>>>> +            break;
>>>> +        }
>>>> +    }
>>>
>>> Did you mean this end device is a wide-port end device ? How could 
>>> this happen?
>>
>> No, the end device described here is a non-expander device. Such as: 
>> sata/sas disk. But these devices are exp-attached.
> 
> If it is not a wide port, why do they have the same sas address here? 
> Why do you add this function to unregister these PHYs? And the last 
> parameter of sas_unregister_devs_sas_addr() means the last PHY of the 
> wide port, you just all passed true, it is irrational.
The non-expander end device does not have a wide port, such as a sata 
disk, and there is only one ex_phy corresponding to it. This function 
finds the ex_phy corresponding to the end dev through dev->sas_addr, 
then clears the ex_phy information and unregister the end device.

Thanks,
Xingui

