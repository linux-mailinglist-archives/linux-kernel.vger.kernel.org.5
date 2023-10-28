Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 005387DA4E5
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 04:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232936AbjJ1Crx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 22:47:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjJ1Crw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 22:47:52 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90724E1;
        Fri, 27 Oct 2023 19:47:48 -0700 (PDT)
Received: from dggpemm500012.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4SHP5G4Mqcz1L9G5;
        Sat, 28 Oct 2023 10:44:50 +0800 (CST)
Received: from [10.67.120.108] (10.67.120.108) by
 dggpemm500012.china.huawei.com (7.185.36.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Sat, 28 Oct 2023 10:47:45 +0800
Message-ID: <7591fe2b-f337-ad78-08b1-cfbe7254f578@huawei.com>
Date:   Sat, 28 Oct 2023 10:47:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH] scsi: libsas: fix set zero-address when device-type !=
 NO_DEVICE
Content-Language: en-CA
To:     Jason Yan <yanaijie@huawei.com>, <john.g.garry@oracle.com>,
        <jejb@linux.ibm.com>, <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <prime.zeng@hisilicon.com>,
        <kangfenglong@huawei.com>, <xiabing12@h-partners.com>
References: <20231020024240.7708-1-yangxingui@huawei.com>
 <31524a87-9e02-5e43-5d71-5747c2e6e6b0@huawei.com>
From:   yangxingui <yangxingui@huawei.com>
In-Reply-To: <31524a87-9e02-5e43-5d71-5747c2e6e6b0@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.120.108]
X-ClientProxiedBy: dggpemm100024.china.huawei.com (7.185.36.234) To
 dggpemm500012.china.huawei.com (7.185.36.89)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/10/20 11:24, Jason Yan wrote:
> On 2023/10/20 10:42, Xingui Yang wrote:
>> phy->attached_sas_addr will be set to a zero-address when
>> phy->linkrate < SAS_LINK_RATE_1_5_GBPS but device-type != NO_DEVICE,
>> and it may trigger BUG() as follows when do revalidate with zero-address:
> 
> Hi  Xingui,
> 
> Why is this zero-addressed PHY added to another port? A zero-addressed 
> PHY should not belong to any port.
Hi Jason,

[562240.062536] sas: ex 500e004aaaaaaa1f phy0 new device attached
[562240.062616] sas: ex 500e004aaaaaaa1f phy00:U:5 attached: 
0000000000000000 (stp)
port-7:7:0: trying to add phy phy-7:7:19 fails: it's already part of 
another port

we get phy0's data info:
crash> struct ex_phy 0xffff8020cead3000
struct ex_phy {
   phy_id = 0,
   phy_state = PHY_EMPTY,
   attached_dev_type = SAS_END_DEVICE,
   linkrate = SAS_PHY_RESET_IN_PROGRESS,
   attached_sata_host = 0 '\000',
   attached_sata_dev = 1 '\001',
   attached_sata_ps = 0 '\000',
   attached_tproto = SAS_PROTOCOL_NONE,
   attached_iproto = SAS_PROTOCOL_NONE,
   attached_sas_addr = "\000\000\000\000\000\000\000",
   attached_phy_id = 0 '\000',
   phy_change_count = 152,
   routing_attr = TABLE_ROUTING,
   virtual = 0 '\000',
   last_da_index = -1,
   phy = 0xffff8020ceac5000,
   port = 0xffffa0300c6f8800
}

When a new device is attached, if the address is 0 and the device type 
is not null, but stp or ssp, the device still creates a port in 
sas_ex_discover_end_dev() and add all other expander phys with the same 
sas_address 0 to this port in sas_ex_get_linkrate().

All of the phys is zero-address belongs to port-7:7:0 as follows:

crash> list sas_phy.port_siblings -s sas_phy.dev.kobj.name -s 
sas_phy.identify.sas_address  -h ffff8020ceac5000
ffff8020ceac5000
   dev.kobj.name = 0xffff803017878b00 "phy-7:7:0",
   identify.sas_address = 0,
ffff8020ceacb000
   dev.kobj.name = 0xffff803017871980 "phy-7:7:1",
   identify.sas_address = 0,
ffff8020ceade000
   dev.kobj.name = 0xffff80301787f580 "phy-7:7:2",
   identify.sas_address = 0,
ffff8020cead4000
   dev.kobj.name = 0xffff80301787d980 "phy-7:7:3",
   identify.sas_address = 0,
ffff8020ceacc800
   dev.kobj.name = 0xffff80301787a480 "phy-7:7:4",
   identify.sas_address = 0,
ffff8020ceac6000
   dev.kobj.name = 0xffff803017872500 "phy-7:7:5",
   identify.sas_address = 0,
ffff8020ceacd000
   dev.kobj.name = 0xffff803041e62100 "phy-7:7:12",
   identify.sas_address = 0,
ffff8020ceadb000
   dev.kobj.name = 0xffff803041e61980 "phy-7:7:13",
   identify.sas_address = 0,
ffff8020ceac8800
   dev.kobj.name = 0xffff803041e61a00 "phy-7:7:14",
   identify.sas_address = 0,
ffff8020cead1800
   dev.kobj.name = 0xffff803041e69980 "phy-7:7:15",
   identify.sas_address = 0,


Thanks,
Xingui

> 
> Thanks,
> Jason
> 
>>
>> [562240.062536] sas: ex 500e004aaaaaaa1f phy0 new device attached
>> [562240.062616] sas: ex 500e004aaaaaaa1f phy00:U:5 attached: 
>> 0000000000000000 (stp)
>> [562240.062680]  port-7:7:0: trying to add phy phy-7:7:19 fails: it's 
>> already part of another port
>> [562240.085064] ------------[ cut here ]------------
>> [562240.096612] kernel BUG at drivers/scsi/scsi_transport_sas.c:1083!
>> [562240.109611] Internal error: Oops - BUG: 0 [#1] SMP
>> [562240.343518] Process kworker/u256:3 (pid: 435909, stack limit = 
>> 0x0000000003bcbebf)
>> [562240.421714] Workqueue: 0000:b4:02.0_disco_q sas_revalidate_domain 
>> [libsas]
>> [562240.437173] pstate: 40c00009 (nZcv daif +PAN +UAO)
>> [562240.450478] pc : sas_port_add_phy+0x13c/0x168 [scsi_transport_sas]
>> [562240.465283] lr : sas_port_add_phy+0x13c/0x168 [scsi_transport_sas]
>> [562240.479751] sp : ffff0000300cfa70
>> [562240.674822] Call trace:
>> [562240.682709]  sas_port_add_phy+0x13c/0x168 [scsi_transport_sas]
>> [562240.694013]  sas_ex_get_linkrate.isra.5+0xcc/0x128 [libsas]
>> [562240.704957]  sas_ex_discover_end_dev+0xfc/0x538 [libsas]
>> [562240.715508]  sas_ex_discover_dev+0x3cc/0x4b8 [libsas]
>> [562240.725634]  sas_ex_discover_devices+0x9c/0x1a8 [libsas]
>> [562240.735855]  sas_ex_revalidate_domain+0x2f0/0x450 [libsas]
>> [562240.746123]  sas_revalidate_domain+0x158/0x160 [libsas]
>> [562240.756014]  process_one_work+0x1b4/0x448
>> [562240.764548]  worker_thread+0x54/0x468
>> [562240.772562]  kthread+0x134/0x138
>> [562240.779989]  ret_from_fork+0x10/0x18
>>
>> So set a zero-address for phy->attached_sas_addr only when
>> phy->attached_dev_type == NO_DEVICE.
>>
>> Fixes: 7d1d86518118 ("[SCSI] libsas: fix false positive 'device 
>> attached' conditions")
>>
>> Signed-off-by: Xingui Yang <yangxingui@huawei.com>
>> ---
>>   drivers/scsi/libsas/sas_expander.c | 3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/drivers/scsi/libsas/sas_expander.c 
>> b/drivers/scsi/libsas/sas_expander.c
>> index a2204674b680..5a81754d3768 100644
>> --- a/drivers/scsi/libsas/sas_expander.c
>> +++ b/drivers/scsi/libsas/sas_expander.c
>> @@ -239,8 +239,7 @@ static void sas_set_ex_phy(struct domain_device 
>> *dev, int phy_id,
>>       /* help some expanders that fail to zero sas_address in the 'no
>>        * device' case
>>        */
>> -    if (phy->attached_dev_type == SAS_PHY_UNUSED ||
>> -        phy->linkrate < SAS_LINK_RATE_1_5_GBPS)
>> +    if (phy->attached_dev_type == SAS_PHY_UNUSED)
>>           memset(phy->attached_sas_addr, 0, SAS_ADDR_SIZE);
>>       else
>>           memcpy(phy->attached_sas_addr, dr->attached_sas_addr, 
>> SAS_ADDR_SIZE);
>>
> .
