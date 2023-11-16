Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2773E7EE1C8
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 14:46:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345257AbjKPNqN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 08:46:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345244AbjKPNqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 08:46:07 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 632B5CE;
        Thu, 16 Nov 2023 05:46:02 -0800 (PST)
Received: from dggpemd100001.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4SWLnW1mGbz1P8Gy;
        Thu, 16 Nov 2023 21:42:39 +0800 (CST)
Received: from [10.67.120.108] (10.67.120.108) by
 dggpemd100001.china.huawei.com (7.185.36.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1258.23; Thu, 16 Nov 2023 21:46:00 +0800
Message-ID: <9cc196d7-0c4f-ef09-53b8-362d5eb599a6@huawei.com>
Date:   Thu, 16 Nov 2023 21:45:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v3] scsi: libsas: Fix set zero-address when device-type !=
 NO_DEVICE
Content-Language: en-CA
To:     John Garry <john.g.garry@oracle.com>, <yanaijie@huawei.com>,
        <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <damien.lemoal@opensource.wdc.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <prime.zeng@hisilicon.com>,
        <kangfenglong@huawei.com>, <chenxiang66@hisilicon.com>
References: <20231116035241.13730-1-yangxingui@huawei.com>
 <dea5cabb-7d9a-44b0-85e4-878c13233f6a@oracle.com>
From:   yangxingui <yangxingui@huawei.com>
In-Reply-To: <dea5cabb-7d9a-44b0-85e4-878c13233f6a@oracle.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.120.108]
X-ClientProxiedBy: dggpemm500007.china.huawei.com (7.185.36.183) To
 dggpemd100001.china.huawei.com (7.185.36.94)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, John

Thanks for you reply.

On 2023/11/16 18:13, John Garry wrote:
> On 16/11/2023 03:52, Xingui Yang wrote:
> 
> I think that patch title can be improved, but I would need to know more 
> about the problem before suggesting an improvement.
How about "Fix port add phy failed" ?
> 
>> Firstly, when ex_phy is added to the parent port, ex_phy->port is not 
>> set.
> 
> That seems correct, but why mention this now?
> 
>> As a result, sas_port_delete_phy() won't be called in
>> sas_unregister_devs_sas_addr(), and although ex_phy's sas_address is 
>> zero,
>> it is not deleted from the parent port's phy_list.
> 
> I am not sure why you mention this now either. You seem to be describing 
> how the problem occurs without actually mentioning what the problem is.
> 
>>
>> Secondly, phy->attached_sas_addr will be set to a zero-address when
>> phy->linkrate < SAS_LINK_RATE_1_5_GBPS and device-type != NO_DEVICE 
>> during
>> device registration, such as stp. It will create a new port and all other
>> ex_phys whose addresses are zero will be added to the new port in
>> sas_ex_get_linkrate(), and it may trigger BUG() as follows:
> 
> I think that it would be better to first mention this crash, i.e. the 
> problem, how you recreate it, and then describe how and why it happens, 
> and then tell us how you will fix it
How about follows:

The following processes trigger a BUG(). A new port port-7:7:0 that 
created by a new zero-address sata device tries to add phy-7:7:19 had 
the same zero-address, but phy-7:7:19 is already part of another port.

[562240.051046] sas: phy19 part of wide port with phy16
[562240.051197] sas: ex 500e004aaaaaaa1f phy19:U:0 attached: 
0000000000000000 (no device)
[562240.051203] sas: done REVALIDATING DOMAIN on port 0, pid:435909, res 0x0
[562240.062536] sas: ex 500e004aaaaaaa1f phy0 new device attached
[562240.062616] sas: ex 500e004aaaaaaa1f phy00:U:5 attached: 
0000000000000000 (stp)
[562240.062680]  port-7:7:0: trying to add phy phy-7:7:19 fails: it's 
already part of another port
[562240.085064] ------------[ cut here ]------------
[562240.096612] kernel BUG at drivers/scsi/scsi_transport_sas.c:1083!
[562240.109611] Internal error: Oops - BUG: 0 [#1] SMP
[562240.343518] Process kworker/u256:3 (pid: 435909, stack limit = 
0x0000000003bcbebf)
[562240.421714] Workqueue: 0000:b4:02.0_disco_q sas_revalidate_domain 
[libsas]
[562240.437173] pstate: 40c00009 (nZcv daif +PAN +UAO)
[562240.450478] pc : sas_port_add_phy+0x13c/0x168 [scsi_transport_sas]
[562240.465283] lr : sas_port_add_phy+0x13c/0x168 [scsi_transport_sas]
[562240.479751] sp : ffff0000300cfa70
[562240.674822] Call trace:
[562240.682709]  sas_port_add_phy+0x13c/0x168 [scsi_transport_sas]
[562240.694013]  sas_ex_get_linkrate.isra.5+0xcc/0x128 [libsas]
[562240.704957]  sas_ex_discover_end_dev+0xfc/0x538 [libsas]
[562240.715508]  sas_ex_discover_dev+0x3cc/0x4b8 [libsas]
[562240.725634]  sas_ex_discover_devices+0x9c/0x1a8 [libsas]
[562240.735855]  sas_ex_revalidate_domain+0x2f0/0x450 [libsas]
[562240.746123]  sas_revalidate_domain+0x158/0x160 [libsas]
[562240.756014]  process_one_work+0x1b4/0x448
[562240.764548]  worker_thread+0x54/0x468
[562240.772562]  kthread+0x134/0x138
[562240.779989]  ret_from_fork+0x10/0x18

We found that phy-7:7:19's port is not set when added to the parent 
port,then it hadn't be deleted from the parent port's phy_list when call
sas_unregister_devs_sas_addr(), and the link rate of the new attached 
sata device is 5 which is less then 1.5G/s, then the sata device's 
sas_address was set to a zero-address.

Fix the problem as follows:
Firstly, set ex_phy->port when ex_phy is added to the parent port. And 
set ex_dev->parent_port to NULL when the number of PHYs of the parent 
port becomes 0.

Secondly, don't set a zero-address for phy->attached_sas_addr when
phy->attached_dev_type != NO_DEVICE.

Thanks,
Xingui

> 
>>
>> [562240.051046] sas: phy19 part of wide port with phy16
>> [562240.051197] sas: ex 500e004aaaaaaa1f phy19:U:0 attached: 
>> 0000000000000000 (no device)
>> [562240.051203] sas: done REVALIDATING DOMAIN on port 0, pid:435909, 
>> res 0x0
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
>> We've done the following to solve this problem:
> 
> I'd use "Fix the problem as follows:""
> 
>> Firstly, set ex_phy->port when ex_phy is added to the parent port. And 
>> set
>> ex_dev->parent_port to NULL when the number of PHYs of the parent port
>> becomes 0.
> 
> Thanks,
> John
> 
> .
