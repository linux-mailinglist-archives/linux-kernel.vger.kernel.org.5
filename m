Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63D207FB0A9
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 04:47:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232891AbjK1Dpy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 22:45:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234531AbjK1Dpw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 22:45:52 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D5C51AD;
        Mon, 27 Nov 2023 19:45:57 -0800 (PST)
Received: from dggpemd100001.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4SfSvH1LtYz1P8ZQ;
        Tue, 28 Nov 2023 11:42:19 +0800 (CST)
Received: from [10.67.120.108] (10.67.120.108) by
 dggpemd100001.china.huawei.com (7.185.36.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1258.28; Tue, 28 Nov 2023 11:45:55 +0800
Message-ID: <baacad33-f568-6151-75a2-dfc09caf2a81@huawei.com>
Date:   Tue, 28 Nov 2023 11:45:55 +0800
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
 <307d251f-ff49-5d8f-1f8e-aed314256732@huawei.com>
 <a13f0419-c4ef-4b8b-9757-7cf7cea32458@oracle.com>
From:   yangxingui <yangxingui@huawei.com>
In-Reply-To: <a13f0419-c4ef-4b8b-9757-7cf7cea32458@oracle.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.120.108]
X-ClientProxiedBy: dggpemm100001.china.huawei.com (7.185.36.93) To
 dggpemd100001.china.huawei.com (7.185.36.94)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

On 2023/11/28 3:28, John Garry wrote:
> On 24/11/2023 02:27, yangxingui wrote:
>>> We already do this in sas_ex_join_wide_port(), right?
>> No, If the addr of ex_phy matches dev->parent, sas_ex_join_wide_port() 
>> will not be called, but sas_add_parent_port() will be called  as follows:
>> static int sas_ex_discover_dev(struct domain_device *dev, int phy_id)
>> {
>>          struct expander_device *ex = &dev->ex_dev;
>>          struct ex_phy *ex_phy = &ex->ex_phy[phy_id];
>>          struct domain_device *child = NULL;
>>          int res = 0;
>>
>>      <...>
>>          /* Parent and domain coherency */
>>          if (!dev->parent && sas_phy_match_port_addr(dev->port, 
>> ex_phy)) {
>>                  sas_add_parent_port(dev, phy_id);
>>                  return 0;
>>          }
>>          if (dev->parent && sas_phy_match_dev_addr(dev->parent, 
>> ex_phy)) {
>>                  sas_add_parent_port(dev, phy_id);
>>                  if (ex_phy->routing_attr == TABLE_ROUTING)
>>                          sas_configure_phy(dev, phy_id, 
>> dev->port->sas_addr, 1);
>>                  return 0;
>>          }
>>      <...>
>> }
>>
>>>
>>> I am not saying that what we do now does not have a problem - I am 
>>> just trying to understand what currently happens
>>
>> ok, because ex_phy->port is not set when calling 
>> sas_add_parent_port(), when deleting phy from the parent wide port, it 
>> is not removed from the phy_list of the parent wide port as follows:
>> static void sas_unregister_devs_sas_addr(struct domain_device *parent,
>>                                           int phy_id, bool last)
>> {
>>      <...>
>>      // Since ex_phy->port is not set, this branch will not be enter
> 
> But then how does this ever work? It is because we follow path 
> sas_rediscover_dev() -> sas_discover_new() -> sas_ex_discover_devices() 
> -> sas_ex_discover_dev() -> sas_add_parent_port(), and not 
> sas_rediscover_dev() -> sas_discover_new() -> sas_ex_join_wide_port()? 
> If so, is that because ephy->sas_attached_phy == 0 in sas_discover_new() 
> -> sas_ex_join_wide_port() and it fails?
> 
> BTW, about something mentioned earlier - adding the phy19 with SAS_ADDR 

Yes,
For phy19, when the phy is attached and added to the parent wide port, 
the path is:
sas_rediscover()
	->sas_discover_new()
		->sas_ex_discover_devices()
			->sas_ex_discover_dev()
				-> sas_add_parent_port().
And the path called when it is removed from parent wide port is:
sas_rediscover()
	->sas_unregister_devs_sas_addr() // The sas address of phy19 becomes 0. 
Since ex_phy->port is NULL, phy19 is not removed from the parent wide 
port's phy_list.

For phy0, it is connected to a new sata device.
sas_rediscover()
	->sas_discover_new()->sas_ex_phy_discover()
							->sas_ex_phy_discover_helper()
								->sas_set_ex_phy() // The device type is stp. Since the linkrate 
is 5 and less than 1.5G, sas_address is set to 0.
						->sas_ex_discover_devices()
							->sas_ex_discover_dev()
								->sas_ex_discover_end_dev()
									->sas_port_alloc() // Create port-7:7:0
									->sas_ex_get_linkrate()
										->sas_port_add_phy() // Try adding phy19 to port->7:7:0, 
triggering BUG()

Thanks,
Xingui
.
