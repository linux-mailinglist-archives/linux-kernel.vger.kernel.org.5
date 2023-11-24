Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DB657F6DC6
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 09:13:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345068AbjKXINc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 03:13:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232929AbjKXINP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 03:13:15 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 443001BD6;
        Fri, 24 Nov 2023 00:01:37 -0800 (PST)
Received: from dggpemd100001.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Sc6kb5DZgzMnMl;
        Fri, 24 Nov 2023 15:56:39 +0800 (CST)
Received: from [10.67.120.108] (10.67.120.108) by
 dggpemd100001.china.huawei.com (7.185.36.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1258.28; Fri, 24 Nov 2023 16:01:25 +0800
Message-ID: <a5be5696-7c77-01d5-e264-f14af9514f09@huawei.com>
Date:   Fri, 24 Nov 2023 16:01:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v4] scsi: libsas: Fix the failure of adding phy with
 zero-address to port
Content-Language: en-CA
To:     John Garry <john.g.garry@oracle.com>, <yanaijie@huawei.com>,
        <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <damien.lemoal@opensource.wdc.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <prime.zeng@hisilicon.com>,
        <kangfenglong@huawei.com>, <chenxiang66@hisilicon.com>
References: <20231117090001.35840-1-yangxingui@huawei.com>
 <32c42e1e-0399-4af4-a5ed-6a257e300fe8@oracle.com>
From:   yangxingui <yangxingui@huawei.com>
In-Reply-To: <32c42e1e-0399-4af4-a5ed-6a257e300fe8@oracle.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.120.108]
X-ClientProxiedBy: dggpemm500001.china.huawei.com (7.185.36.107) To
 dggpemd100001.china.huawei.com (7.185.36.94)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi, John

Sorry, I missed the reply to you. The improved version is as follows.

On 2023/11/23 22:52, John Garry wrote:
> On 17/11/2023 09:00, Xingui Yang wrote:
> 
> Sorry for being slow to come back to this. However I still have 
> questions...
> 
>> When connecting to the epander device, first disable and then enable the
> 
> /s/epander/expander >
> And connecting what to the expander? Is it a SATA disk?
> 
> Or the SATA disk is already attached to the expander and we are now 
> attaching the expander to the host?
Yes, the SATA disk is already attached to the expander.
> 
> It is hard to follow this.
> 
>> local phy.
> 
> So is the local phy disabled initially? Or is was it initially enabled 
> and we disable+re-enable just when attaching, so that there is a race?

When local phy is enabled and disabled repeatedly, the ex_phy status 
causing the expander may change, such as being removed. And the link 
rate of the SATA device has also changed, such as becoming 
SAS_PHY_RESET_IN_PROGRESS.

> 
>> The following BUG() will be triggered with a small probability:
>>
>> [562240.051046] sas: phy19 part of wide port with phy16
> 
> Where is this print in the code? I see "part of a wide port with 
> phy%02d" in sas_discover_dev()

In sas_rediscover() as follow, the latest printing has changed a bit, 
what I posted is an old version of the log. The latest version also has 
similar problems.
static int sas_rediscover(struct domain_device *dev, const int phy_id)
{
	struct expander_device *ex = &dev->ex_dev;
	struct ex_phy *changed_phy = &ex->ex_phy[phy_id];
	int i;
	bool last = true;	/* is this the last phy of the port */

	for (i = 0; i < ex->num_phys; i++) {
		struct ex_phy *phy = &ex->ex_phy[i];

		if (i == phy_id)
			continue;
		if (SAS_ADDR(phy->attached_sas_addr) ==
		    SAS_ADDR(changed_phy->attached_sas_addr)) {
			SAS_DPRINTK("phy%d part of wide port with "
				    "phy%d\n", phy_id, i);
			last = false;
			break;
		}
	}
	return sas_rediscover_dev(dev, phy_id, last);
}
> 
>> [562240.051197] sas: ex 500e004aaaaaaa1f phy19:U:0 attached: 
>> 0000000000000000 (no device)
>> [562240.051203] sas: done REVALIDATING DOMAIN on port 0, pid:435909, 
>> res 0x0
>> <...>
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
>> What causes this problem:
>> 1. When phy19 was initially added to the parent port, ex_phy->port was 
>> not
> 
> phy19 is the expander phy attached to the host, right?
Yes.
> 
>> set. As a result, when phy19 was removed from the parent wide port,
> 
> You seem to be getting ahead of yourself. It has not been mentioned when 
> phy19 is removed from the parent wide port.
Expander broadcast event notification phy 19 has been disconnected as 
follows:
[562240.048606] sas: broadcast received: 0
[562240.048615] sas: REVALIDATING DOMAIN on port 0, pid:435909
[562240.048929] sas: Expander phy change count has changed
[562240.051038] sas: ex 500e004aaaaaaa1f phy0 originated BROADCAST(CHANGE)
[562240.051039] sas: ex 500e004aaaaaaa1f phy1 originated BROADCAST(CHANGE)
[562240.051040] sas: ex 500e004aaaaaaa1f phy2 originated BROADCAST(CHANGE)
[562240.051040] sas: ex 500e004aaaaaaa1f phy3 originated BROADCAST(CHANGE)
[562240.051041] sas: ex 500e004aaaaaaa1f phy4 originated BROADCAST(CHANGE)
[562240.051042] sas: ex 500e004aaaaaaa1f phy5 originated BROADCAST(CHANGE)
[562240.051043] sas: ex 500e004aaaaaaa1f phy17 originated BROADCAST(CHANGE)
[562240.051044] sas: ex 500e004aaaaaaa1f phy18 originated BROADCAST(CHANGE)
[562240.051044] sas: ex 500e004aaaaaaa1f phy19 originated BROADCAST(CHANGE)
[562240.051046] sas: phy19 part of wide port with phy16
[562240.051197] sas: ex 500e004aaaaaaa1f phy19:U:0 attached: 
0000000000000000 (no device)
[562240.051198] sas: ex 500e004aaaaaaa1f phy20 originated BROADCAST(CHANGE)
[562240.051198] sas: ex 500e004aaaaaaa1f phy22 originated BROADCAST(CHANGE)
[562240.051199] sas: ex 500e004aaaaaaa1f phy23 originated BROADCAST(CHANGE)
[562240.051203] sas: done REVALIDATING DOMAIN on port 0, pid:435909, res 0x0
[562240.051221] sas: broadcast received: 0
[562240.051230] sas: REVALIDATING DOMAIN on port 0, pid:435909
[562240.051413] sas: Expander phy change count has changed
[562240.053439] sas: ex 500e004aaaaaaa1f phy0 originated BROADCAST(CHANGE)
[562240.053439] sas: ex 500e004aaaaaaa1f phy1 originated BROADCAST(CHANGE)
[562240.053440] sas: ex 500e004aaaaaaa1f phy2 originated BROADCAST(CHANGE)
[562240.053441] sas: ex 500e004aaaaaaa1f phy3 originated BROADCAST(CHANGE)
[562240.053442] sas: ex 500e004aaaaaaa1f phy4 originated BROADCAST(CHANGE)
[562240.053443] sas: ex 500e004aaaaaaa1f phy5 originated BROADCAST(CHANGE)
[562240.053444] sas: ex 500e004aaaaaaa1f phy17 originated BROADCAST(CHANGE)
[562240.053444] sas: ex 500e004aaaaaaa1f phy18 originated BROADCAST(CHANGE)
[562240.053445] sas: ex 500e004aaaaaaa1f phy20 originated BROADCAST(CHANGE)
[562240.053446] sas: ex 500e004aaaaaaa1f phy22 originated BROADCAST(CHANGE)
[562240.053447] sas: ex 500e004aaaaaaa1f phy23 originated BROADCAST(CHANGE)
[562240.053448] sas: ex 500e004aaaaaaa1f phy0 new device attached
[562240.053521] sas: ex 500e004aaaaaaa1f phy00:U:5 attached: 
0000000000000000 (no device)
[562240.053522] sas: ex 500e004aaaaaaa1f phy1 new device attached
[562240.053601] sas: ex 500e004aaaaaaa1f phy01:U:5 attached: 
0000000000000000 (no device)
[562240.053602] sas: ex 500e004aaaaaaa1f phy2 new device attached
[562240.053682] sas: ex 500e004aaaaaaa1f phy02:U:5 attached: 
0000000000000000 (no device)
[562240.053684] sas: ex 500e004aaaaaaa1f phy3 new device attached
[562240.053763] sas: ex 500e004aaaaaaa1f phy03:U:5 attached: 
0000000000000000 (no device)
[562240.053764] sas: ex 500e004aaaaaaa1f phy4 new device attached
[562240.053843] sas: ex 500e004aaaaaaa1f phy04:U:5 attached: 
0000000000000000 (no device)
[562240.053844] sas: ex 500e004aaaaaaa1f phy5 new device attached
[562240.053924] sas: ex 500e004aaaaaaa1f phy05:U:5 attached: 
0000000000000000 (no device)
[562240.053925] sas: ex 500e004aaaaaaa1f phy17 new device attached
[562240.054008] sas: ex 500e004aaaaaaa1f phy17:U:B attached: 
5001882016000002 (host)
[562240.054015] sas: ex 500e004aaaaaaa1f phy18 new device attached
[562240.054098] sas: ex 500e004aaaaaaa1f phy18:U:B attached: 
5001882016000002 (host)
[562240.054102] sas: ex 500e004aaaaaaa1f phy20 new device attached
[562240.054186] sas: ex 500e004aaaaaaa1f phy20:U:B attached: 
5001882016000002 (host)
[562240.054190] sas: ex 500e004aaaaaaa1f phy22 new device attached
[562240.054273] sas: ex 500e004aaaaaaa1f phy22:U:B attached: 
5001882016000002 (host)
[562240.054276] sas: ex 500e004aaaaaaa1f phy23 new device attached
[562240.054360] sas: ex 500e004aaaaaaa1f phy23:U:B attached: 
5001882016000002 (host)
[562240.054364] sas: done REVALIDATING DOMAIN on port 0, pid:435909, res 0x0
> 
>> it was
>> not deleted from the phy_list of the parent port.
>>
>> 2. The rate of the newly connected SATA device to phy0 is less than 1.5G,
>> and its sas_address was set to 0. After creating port 7:7:0
> 
> is 7:7:0 the port which the SATA device is part of?
> 
>> , it attempts to
>> add the expander's other zero-addressed phy to this port.
>>
>> 3. When adding phy19 to port-7:7:0
It's a new port create by phy00:U:5. after the log:
[562240.062536] sas: ex 500e004aaaaaaa1f phy0 new device attached
[562240.062616] sas: ex 500e004aaaaaaa1f phy00:U:5 attached: 
0000000000000000 (stp)
> 
> Which would be the incorrect thing to do, right? I am basing that on my 
> assumption that 7:7:0 is the port which the SATA device is part of.
Yes. It is created by the sata device with zero address.

Thanks,
Xingui
