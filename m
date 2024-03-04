Return-Path: <linux-kernel+bounces-90591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75C6C8701D6
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 13:51:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A73071C233E6
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 12:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5D5E3D3BE;
	Mon,  4 Mar 2024 12:50:52 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC9DF1946C;
	Mon,  4 Mar 2024 12:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709556652; cv=none; b=sYkLOedQQnBkx7Oxcdty99ImLS1udQVlInPqbGIw/F/AjzRP7qowEufxjmRACJLi9cgTu2IFcGK3MtwcpLbqYw15j5wp5yCB53t/aTamk8RnVbpLnv9OW67JxmEyejppo3kueejbWOB9tXE0H9fDulwqOAX//QFzeG8WHccMUKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709556652; c=relaxed/simple;
	bh=si1k6+m8kih3uRFyccYJEqu1Hr+qAYqsSzmMjNBAkH8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=IA/S3vX9WPdvc22rXS4QLBVxvx+jHY4T9/epPff8Sra1u/Qr33LsUeRPNJJiph1V8dhwZ7zhsfo8eYukuDZGYAha14PRfwROpuP25T1hg30rTprlS+BEp4oHxCIRFOxQUleavy4UBsxdK8Oq6r83RqzfSKK8SYpv6Gv2+qA74Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4TpJTC5nRrz1FLgX;
	Mon,  4 Mar 2024 20:50:39 +0800 (CST)
Received: from dggpemd100001.china.huawei.com (unknown [7.185.36.94])
	by mail.maildlp.com (Postfix) with ESMTPS id D438D140113;
	Mon,  4 Mar 2024 20:50:45 +0800 (CST)
Received: from [10.67.120.108] (10.67.120.108) by
 dggpemd100001.china.huawei.com (7.185.36.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 4 Mar 2024 20:50:45 +0800
Message-ID: <80050a50-af6a-5862-8c12-ccaf91c5ff74@huawei.com>
Date: Mon, 4 Mar 2024 20:50:45 +0800
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
To: Jason Yan <yanaijie@huawei.com>, John Garry <john.g.garry@oracle.com>,
	<jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
	<damien.lemoal@opensource.wdc.com>
CC: <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linuxarm@huawei.com>, <prime.zeng@hisilicon.com>,
	<chenxiang66@hisilicon.com>, <kangfenglong@huawei.com>
References: <20240221073159.29408-1-yangxingui@huawei.com>
 <f095aa1c-f233-40f9-ad0f-fcd8fe69a80d@oracle.com>
 <e2a725ee-98b3-fd57-6ee4-af031ffbd6bc@huawei.com>
From: yangxingui <yangxingui@huawei.com>
In-Reply-To: <e2a725ee-98b3-fd57-6ee4-af031ffbd6bc@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggpemm500007.china.huawei.com (7.185.36.183) To
 dggpemd100001.china.huawei.com (7.185.36.94)

Hi Jason,

On 2024/3/1 9:55, Jason Yan wrote:
> On 2024/2/29 2:13, John Garry wrote:
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
>>
>> It's odd to call sas_set_ex_phy() if we got res == -ECOMM. I mean, in 
>> this this case disc_resp is not filled in as the command did not 
>> execute, right? I know that is what the current code does, but it is 
>> strange.
> 
> The current code actually re-send the SMP command and update the PHY 
> status only when the the SMP command is responded correctly.
> 
> Xinggui, can you please fix this and send v3?
The current location cannot directly update the phy information. The 
previous phy information will be used later, and the previous sas 
address will be compared with the currently queried sas address. At 
present, v2 is more suitable after many days of testing.

Thanks,
Xingui

