Return-Path: <linux-kernel+bounces-91586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1D8D8713F6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 03:56:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5290BB22925
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 02:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DEDA2941C;
	Tue,  5 Mar 2024 02:56:28 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFBEA28E02;
	Tue,  5 Mar 2024 02:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709607388; cv=none; b=fj0S0nzkqFf67pQDfi9QCrJHMuMvC12jTuNm0JKnclWP5FuZ59yFs+fYMrK6Z6KZjAK194dDz4vFsxLxWJJ9RCslOmVmwveNVQFCdNawiPgfBZZwzJENn9uFQ/Vi4ZPNO5M7LMgCVTpb5POCJqsrdFgEmCx5r2ogqxxrLZ4oiGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709607388; c=relaxed/simple;
	bh=9aq1dWdZloxUMNZSHLf/pMwp0TpoxuSjANvoAXLgcUE=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=qr9Le+EYvHlp6p1eOGOvHPSH3heSdMZHakpcSgvO/jRPhrI4o4H0+/jPRgOZ9Q7hWDwJIKZGXpl/CHuWlqRjzdY3aJMNB+oUNSmbs7/yqOSKnvLLxCBwiwSi2jE0R1pdy/ec4/55IZFqFfnJfDqlRYxaZtaNJeVc6R2kvhEP0RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4TpgDw5cxbz1FLmL;
	Tue,  5 Mar 2024 10:56:16 +0800 (CST)
Received: from canpemm500005.china.huawei.com (unknown [7.192.104.229])
	by mail.maildlp.com (Postfix) with ESMTPS id 766971402CB;
	Tue,  5 Mar 2024 10:56:23 +0800 (CST)
Received: from canpemm500004.china.huawei.com (7.192.104.92) by
 canpemm500005.china.huawei.com (7.192.104.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 5 Mar 2024 10:56:23 +0800
Received: from [10.174.179.14] (10.174.179.14) by
 canpemm500004.china.huawei.com (7.192.104.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 5 Mar 2024 10:56:22 +0800
Subject: Re: [PATCH] scsi: libsas: Fix disk not being scanned in after being
 removed
To: yangxingui <yangxingui@huawei.com>, John Garry <john.g.garry@oracle.com>,
	<jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
	<damien.lemoal@opensource.wdc.com>
CC: <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linuxarm@huawei.com>, <prime.zeng@hisilicon.com>,
	<chenxiang66@hisilicon.com>, <kangfenglong@huawei.com>
References: <20240221073159.29408-1-yangxingui@huawei.com>
 <f095aa1c-f233-40f9-ad0f-fcd8fe69a80d@oracle.com>
 <e2a725ee-98b3-fd57-6ee4-af031ffbd6bc@huawei.com>
 <80050a50-af6a-5862-8c12-ccaf91c5ff74@huawei.com>
From: Jason Yan <yanaijie@huawei.com>
Message-ID: <7e1b554b-a675-14d2-59aa-7f37e3dd5994@huawei.com>
Date: Tue, 5 Mar 2024 10:56:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <80050a50-af6a-5862-8c12-ccaf91c5ff74@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500004.china.huawei.com (7.192.104.92)

On 2024/3/4 20:50, yangxingui wrote:
> Hi Jason,
> 
> On 2024/3/1 9:55, Jason Yan wrote:
>> On 2024/2/29 2:13, John Garry wrote:
>>> On 21/02/2024 07:31, Xingui Yang wrote:
>>>> As of commit d8649fc1c5e4 ("scsi: libsas: Do discovery on empty PHY to
>>>> update PHY info"), do discovery will send a new SMP_DISCOVER and update
>>>> phy->phy_change_count. We found that if the disk is reconnected and phy
>>>> change_count changes at this time, the disk scanning process will 
>>>> not be
>>>> triggered.
>>>>
>>>> So update the PHY info with the last query results.
>>>>
>>>> Fixes: d8649fc1c5e4 ("scsi: libsas: Do discovery on empty PHY to 
>>>> update PHY info")
>>>> Signed-off-by: Xingui Yang <yangxingui@huawei.com>
>>>> ---
>>>>   drivers/scsi/libsas/sas_expander.c | 9 ++++-----
>>>>   1 file changed, 4 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/drivers/scsi/libsas/sas_expander.c 
>>>> b/drivers/scsi/libsas/sas_expander.c
>>>> index a2204674b680..9563f5589948 100644
>>>> --- a/drivers/scsi/libsas/sas_expander.c
>>>> +++ b/drivers/scsi/libsas/sas_expander.c
>>>> @@ -1681,6 +1681,10 @@ int sas_get_phy_attached_dev(struct 
>>>> domain_device *dev, int phy_id,
>>>>           if (*type == 0)
>>>>               memset(sas_addr, 0, SAS_ADDR_SIZE);
>>>>       }
>>>> +
>>>> +    if ((SAS_ADDR(sas_addr) == 0) || (res == -ECOMM))
>>>
>>> It's odd to call sas_set_ex_phy() if we got res == -ECOMM. I mean, in 
>>> this this case disc_resp is not filled in as the command did not 
>>> execute, right? I know that is what the current code does, but it is 
>>> strange.
>>
>> The current code actually re-send the SMP command and update the PHY 
>> status only when the the SMP command is responded correctly.
>>
>> Xinggui, can you please fix this and send v3?
> The current location cannot directly update the phy information. The 
> previous phy information will be used later, and the previous sas 
> address will be compared with the currently queried sas address. At 
> present, v2 is more suitable after many days of testing.

OK, so let me have a closer look at v2.

Thanks,
Jason

> 
> Thanks,
> Xingui
> .

