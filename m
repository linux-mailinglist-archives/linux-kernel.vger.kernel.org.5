Return-Path: <linux-kernel+bounces-100348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EDCF879611
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 15:26:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9AF91B24997
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 14:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3C2C7AE74;
	Tue, 12 Mar 2024 14:26:37 +0000 (UTC)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8322F79B97;
	Tue, 12 Mar 2024 14:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710253597; cv=none; b=ccT6V7U9Oky1Q0nDGs0u4gTZxw2ebf7ZMhWZ6HvfqUis8o8vRH5M389X/rX4z2ZvmRp6WU2o2pRaewQ5L5UY+Dn/O8OJu/U2or1S7EOllO6BRyX+hEU1mkc8s58L+dXs8jlTd6WHqlf9VpqGOwetJqvF7gj6xdNcQz0v2xFer9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710253597; c=relaxed/simple;
	bh=FPvsVl876rG8CBqJE13zeDuxuUzvIKzJX5nocq9iv8Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Ua+oPMoeome7/+HcTpDN9B6k9R2knfHh3y4a8bqkWHlBe+8XTi4oM8Tsj+oQsVhduWFws8GExoFnarjfevngBNChfFChZ37IAOaCdxmqG4jm8yY/vZoE+hcGckZ7bDl/D7yf1Srwyy4RN3aRooOZHoxwezQ4JQwKngJXD/aiRcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4TvG9H719Kz1Z1kw;
	Tue, 12 Mar 2024 22:24:03 +0800 (CST)
Received: from dggpemd100001.china.huawei.com (unknown [7.185.36.94])
	by mail.maildlp.com (Postfix) with ESMTPS id D0D1418002D;
	Tue, 12 Mar 2024 22:26:30 +0800 (CST)
Received: from [10.67.120.108] (10.67.120.108) by
 dggpemd100001.china.huawei.com (7.185.36.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 12 Mar 2024 22:26:30 +0800
Message-ID: <b11f812a-aec1-bd07-1483-fe15431f4ca1@huawei.com>
Date: Tue, 12 Mar 2024 22:26:30 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v5 3/3] scsi: libsas: Fix the failure of adding phy with
 zero-address to port
Content-Language: en-CA
To: John Garry <john.g.garry@oracle.com>, <yanaijie@huawei.com>,
	<jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
	<damien.lemoal@opensource.wdc.com>
CC: <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linuxarm@huawei.com>, <prime.zeng@hisilicon.com>,
	<chenxiang66@hisilicon.com>, <kangfenglong@huawei.com>
References: <20231204122932.55741-1-yangxingui@huawei.com>
 <20231204122932.55741-4-yangxingui@huawei.com>
 <336b3084-dfae-4e91-ba31-7e08ba4e5591@oracle.com>
 <8742e128-3ac8-aa56-0596-037c38e05089@huawei.com>
 <d2fc59e0-4aa0-46fa-aaef-1d5f707d988e@oracle.com>
From: yangxingui <yangxingui@huawei.com>
In-Reply-To: <d2fc59e0-4aa0-46fa-aaef-1d5f707d988e@oracle.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggpemm500001.china.huawei.com (7.185.36.107) To
 dggpemd100001.china.huawei.com (7.185.36.94)

Hi John,

On 2023/12/6 2:13, John Garry wrote:
> On 05/12/2023 13:22, yangxingui wrote:
>>
>> On 2023/12/5 2:05, John Garry wrote:
>>> On 04/12/2023 12:29, Xingui Yang wrote:
>>>> When the expander device which attached many SATA disks is connected to
>>>> the host, first disable and then enable the local phy. The following 
>>>> BUG()
>>>> will be triggered with a small probability:
>>>>
>>>> [562240.051046] sas: phy19 part of wide port with phy16
>>>
>>> Please use code from latest kernel. This again seems to be the old 
>>> comment format.
>> Ok.
>>>
>>>> [562240.051197] sas: ex 500e004aaaaaaa1f phy19:U:0 attached: 
>>>> 0000000000000000 (no device)
>>>
>>> The log at 562240.051046 tells that phy19 formed a wideport with 
>>> phy16, but then here we see that phy19 has attached SAS address 0. 
>>> How did we form a wideport with a phy with sas address 0? Sorry if I 
>>> asked this before, but I looked through the thread and it is not clear.
>> Ok, the early address of phy19 is not 0, and forms a wide port with 
>> phy16. But now phy19 has been unregistered and the sas address of 
>> phy19 is set to 0.
> 
> ok, so the old logs are simply misleading: "sas: phy19 part of wide port 
> with phy16" implies that we have joined phy19 to a wideport with phy16.
> 
> Indeed, my change to that vague print is more than 4.5 years old now - 
> see commit a5b38d3159.
> 
> Sorry to say, but that does not fill me full of confidence that the 
> changes in this series are suitable for a mainline kernel. Please don't 
> do that. Test against the very recent mainline kernel.
This problem will occasionally occur in new versions. I updated a 
version and split the patch to make this problem easier to deal with.
> 
>>
>>>
>>>> [562240.051203] sas: done REVALIDATING DOMAIN on port 0, pid:435909, 
>>>> res 0x0
>>>> <...>
>>>> [562240.062536] sas: ex 500e004aaaaaaa1f phy0 new device attached
>>>> [562240.062616] sas: ex 500e004aaaaaaa1f phy00:U:5 attached: 
>>>> 0000000000000000 (stp)
>>>> [562240.062680]  port-7:7:0: trying to add phy phy-7:7:19 fails: 
>>>> it's already part of another port
>>>> [562240.085064] ------------[ cut here ]------------
>>>> [562240.096612] kernel BUG at drivers/scsi/scsi_transport_sas.c:1083!
>>>> [562240.109611] Internal error: Oops - BUG: 0 [#1] SMP
>>>> [562240.343518] Process kworker/u256:3 (pid: 435909, stack limit = 
>>>> 0x0000000003bcbebf)
>>>> [562240.421714] Workqueue: 0000:b4:02.0_disco_q 
>>>> sas_revalidate_domain [libsas]
>>>> [562240.437173] pstate: 40c00009 (nZcv daif +PAN +UAO)
>>>> [562240.450478] pc : sas_port_add_phy+0x13c/0x168 [scsi_transport_sas]
>>>> [562240.465283] lr : sas_port_add_phy+0x13c/0x168 [scsi_transport_sas]
>>>> [562240.479751] sp : ffff0000300cfa70
>>>> [562240.674822] Call trace:
>>>> [562240.682709]  sas_port_add_phy+0x13c/0x168 [scsi_transport_sas]
>>>> [562240.694013]  sas_ex_get_linkrate.isra.5+0xcc/0x128 [libsas]
>>>> [562240.704957]  sas_ex_discover_end_dev+0xfc/0x538 [libsas]
>>>> [562240.715508]  sas_ex_discover_dev+0x3cc/0x4b8 [libsas]
>>>> [562240.725634]  sas_ex_discover_devices+0x9c/0x1a8 [libsas]
>>>> [562240.735855]  sas_ex_revalidate_domain+0x2f0/0x450 [libsas]
>>>> [562240.746123]  sas_revalidate_domain+0x158/0x160 [libsas]
>>>> [562240.756014]  process_one_work+0x1b4/0x448
>>>> [562240.764548]  worker_thread+0x54/0x468
>>>> [562240.772562]  kthread+0x134/0x138
>>>> [562240.779989]  ret_from_fork+0x10/0x18
>>>>
>>>> What causes this problem:
>>>> 1. For phy19, when the phy is attached and added to the parent wide 
>>>> port,
>>>> the path is:
>>>> sas_rediscover()
>>>>      ->sas_discover_new()
>>>>          ->sas_ex_discover_devices()
>>>>              ->sas_ex_discover_dev()
>>>>                  -> sas_add_parent_port()
>>>>
>>>> ex_phy->port was not set and when it is removed from parent wide 
>>>> port the
>>>> path is:
>>>> sas_rediscover()
>>>>      ->sas_unregister_devs_sas_addr()
>>>
>>>
>>> Sorry, but that is not a callpath. Maybe you condensed it. Please 
>>> expand it.
I updated a version and split the patch to make this problem easier to 
deal with.
>> Ok.
>>>
>>>>
>>>> Then the sas address of phy19 becomes 0, and since ex_phy->port is 
>>>> NULL,
>>>> phy19 was not removed from the parent wide port's phy_list.
>>>>
>>>> 2. For phy0, it is connected to a new sata device and the path is:
>>>> sas_rediscover()
>>>>      ->sas_discover_new()->sas_ex_phy_discover()
>>>>                              ->sas_ex_phy_discover_helper()
>>>>                                  ->sas_set_ex_phy()
>>>>                          ->sas_ex_discover_devices()
>>>>                              ->sas_ex_discover_dev()
>>>>                                  ->sas_ex_discover_end_dev()
>>>>                                      ->sas_port_alloc() // Create 
>>>> port-7:7:0
>>>>                                      ->sas_ex_get_linkrate()
>>>>                                          ->sas_port_add_phy()
>>>>
>>>> The type of the newly connected device is stp, but the linkrate is 5 
>>>> which
>>>> less than 1.5G, then the sas address is set to 0 in sas_set_ex_phy().
>>>
>>> I don't understand why we do anything when in this state. linkrate == 
>>> 5 means phy reset in progress. Can we just bail out until the SATA 
>>> phy is in a decent shape? I assume that when the SATA phy is in "up" 
>>> state that we get a broadcast event and can re-evaluate.
>> You are saying that we use a method similar to SAS_SATA_SPINUP_HOLD?
> 
> Maybe. Can we simply re-use SAS_SATA_SPINUP_HOLD handling? Is it suitable?
 From the SAS Protocol Layer - 4 (SPL-4) interpretation of 
RESET_IN_PROGRESS, Phy is enabled and the expander phy is performing an 
SMP PHY CONTROL function (see 9.4.3.28) phy operation of LINK RESET or 
HARD RESET.
This value is returned if the specified phy contained a value of 8h to 
Fh in this field when an SMP PHY CONTROL function phy operation of LINK 
RESET or HARD RESET phy operation is processed.
Maybe, we should not need to perform operations of LINK RESET.
> 
>>>
>>>> Subsequently, a new port port-7:7:0 was created and tried to add 
>>>> phy19 with
>>>> the same zero-address to this new port. However, phy19 still belongs to
>>>> another port, then a BUG() was triggered in sas_ex_get_linkrate().
>>>>
>>>> Fix the problem as follows:
>>>> 1. Use sas_port_add_ex_phy() instead of sas_port_add_phy() when 
>>>> ex_phy is
>>>> added to the parent port.
>>>
>>> this seems ok
>>>
>>>>
>>>> 2. Set ex_dev->parent_port to NULL when the number of phy on the port
>>>> becomes 0.
>>>>
>>>> 3. When phy->attached_dev_type != NO_DEVICE, do not set the zero 
>>>> address
>>>> for phy->attached_sas_addr.
>>>>
>>>> Fixes: 2908d778ab3e ("[SCSI] aic94xx: new driver")
>>>> Fixes: 7d1d86518118 ("[SCSI] libsas: fix false positive 'device 
>>>> attached' conditions")
>>>> Signed-off-by: Xingui Yang <yangxingui@huawei.com>
>>>> ---
>>>>   drivers/scsi/libsas/sas_expander.c | 10 ++++++----
>>>>   1 file changed, 6 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/drivers/scsi/libsas/sas_expander.c 
>>>> b/drivers/scsi/libsas/sas_expander.c
>>>> index 7aa968b85e1e..9152152d5e10 100644
>>>> --- a/drivers/scsi/libsas/sas_expander.c
>>>> +++ b/drivers/scsi/libsas/sas_expander.c
>>>> @@ -45,7 +45,7 @@ static void sas_add_parent_port(struct 
>>>> domain_device *dev, int phy_id)
>>>>           BUG_ON(sas_port_add(ex->parent_port));
>>>>           sas_port_mark_backlink(ex->parent_port);
>>>>       }
>>>> -    sas_port_add_phy(ex->parent_port, ex_phy->phy);
>>>> +    sas_port_add_ex_phy(ex->parent_port, ex_phy);
>>>>   }
>>>>   /* ---------- SMP task management ---------- */
>>>> @@ -261,8 +261,7 @@ static void sas_set_ex_phy(struct domain_device 
>>>> *dev, int phy_id,
>>>>       /* help some expanders that fail to zero sas_address in the 'no
>>>>        * device' case
>>>>        */
>>>
>>> Please pay attention to this comment. It seems that some expanders 
>>> require us to explicitly zero the SAS address.
>> Yes, we have reviewed this point, and its modification is for some 
>> expanders to report that the sas address isn't zero in the "no device" 
>> case. The current modification does not affect its original problem 
>> fix, we just removed its linkrate judgment.
> 
> ok
> 
>>>
>>>> -    if (phy->attached_dev_type == SAS_PHY_UNUSED ||
>>>> -        phy->linkrate < SAS_LINK_RATE_1_5_GBPS)
>>>> +    if (phy->attached_dev_type == SAS_PHY_UNUSED)
>>>>           memset(phy->attached_sas_addr, 0, SAS_ADDR_SIZE);
>>>>       else
>>>>           memcpy(phy->attached_sas_addr, dr->attached_sas_addr, 
>>>> SAS_ADDR_SIZE);
>>>> @@ -1864,9 +1863,12 @@ static void 
>>>> sas_unregister_devs_sas_addr(struct domain_device *parent,
>>>>       if (phy->port) {
>>>>           sas_port_delete_phy(phy->port, phy->phy);
>>>>           sas_device_set_phy(found, phy->port);
>>>> -        if (phy->port->num_phys == 0)
>>>> +        if (phy->port->num_phys == 0) {
>>>>               list_add_tail(&phy->port->del_list,
>>>>                   &parent->port->sas_port_del_list);
>>>> +            if (ex_dev->parent_port == phy->port)
>>>> +                ex_dev->parent_port = NULL;
>>>
>>> This does not feel like the right place to do this. So the port which 
>>> we queue to free is the ex_dev->parent_port, right?
>> Yes, we found that if ex_dev->parent_port is not set to NULL, after 
>> the port is released, if there is a new ex_phy connection, use-after-free 
> 
> Do you mean really a memory use-after-free, like which KASAN would report?
Yes, it will trigger panic.
> 
> 
>> problems will occur. And the current branch is to determine whether 
>> the number of phys on the port is 0. I think it is more appropriate to 
>> set parent_port. Do you have any better suggestions?
> 
> Let me check again...
> 
>>>
>>> BTW, do you know why it's called ex_dev->parent_port and not 
>>> ex_dev->port? I find the name parent_port confusing...
>> It is the port connected to the upper-level device, so named  
>> parent_port.
> 
> But isn't this just the sas_port for the expander device attachment to 
> the host and more closely associated to the expander itself?
> 
> Thanks,
> John
> 
> .
Thanks,
Xingui

