Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11BA67FE7D7
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 04:53:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344360AbjK3DxB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 22:53:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230393AbjK3DxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 22:53:00 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 078A6D66;
        Wed, 29 Nov 2023 19:53:06 -0800 (PST)
Received: from dggpemd100001.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Sgj1t5QzSzWhqd;
        Thu, 30 Nov 2023 11:52:18 +0800 (CST)
Received: from [10.67.120.108] (10.67.120.108) by
 dggpemd100001.china.huawei.com (7.185.36.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1258.28; Thu, 30 Nov 2023 11:53:03 +0800
Message-ID: <d6b20d8f-7653-6806-d7c8-0adc54f1333b@huawei.com>
Date:   Thu, 30 Nov 2023 11:53:03 +0800
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
 <baacad33-f568-6151-75a2-dfc09caf2a81@huawei.com>
 <cf98eb9f-ac42-4d9b-9cf3-3085f6fc0cda@oracle.com>
From:   yangxingui <yangxingui@huawei.com>
In-Reply-To: <cf98eb9f-ac42-4d9b-9cf3-3085f6fc0cda@oracle.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.120.108]
X-ClientProxiedBy: dggpemm500017.china.huawei.com (7.185.36.178) To
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

On 2023/11/29 20:54, John Garry wrote:
> On 28/11/2023 03:45, yangxingui wrote:
>>
>> On 2023/11/28 3:28, John Garry wrote:
>>> On 24/11/2023 02:27, yangxingui wrote:
>>>>> We already do this in sas_ex_join_wide_port(), right?
>>>> No, If the addr of ex_phy matches dev->parent, 
>>>> sas_ex_join_wide_port() will not be called, but 
>>>> sas_add_parent_port() will be called  as follows:
>>>> static int sas_ex_discover_dev(struct domain_device *dev, int phy_id)
>>>> {
>>>>          struct expander_device *ex = &dev->ex_dev;
>>>>          struct ex_phy *ex_phy = &ex->ex_phy[phy_id];
>>>>          struct domain_device *child = NULL;
>>>>          int res = 0;
>>>>
>>>>      <...>
>>>>          /* Parent and domain coherency */
>>>>          if (!dev->parent && sas_phy_match_port_addr(dev->port, 
>>>> ex_phy)) {
>>>>                  sas_add_parent_port(dev, phy_id);
>>>>                  return 0;
>>>>          }
>>>>          if (dev->parent && sas_phy_match_dev_addr(dev->parent, 
>>>> ex_phy)) {
>>>>                  sas_add_parent_port(dev, phy_id);
>>>>                  if (ex_phy->routing_attr == TABLE_ROUTING)
>>>>                          sas_configure_phy(dev, phy_id, 
>>>> dev->port->sas_addr, 1);
>>>>                  return 0;
>>>>          }
>>>>      <...>
>>>> }
>>>>
>>>>>
>>>>> I am not saying that what we do now does not have a problem - I am 
>>>>> just trying to understand what currently happens
>>>>
>>>> ok, because ex_phy->port is not set when calling 
>>>> sas_add_parent_port(), when deleting phy from the parent wide port, 
>>>> it is not removed from the phy_list of the parent wide port as follows:
>>>> static void sas_unregister_devs_sas_addr(struct domain_device *parent,
>>>>                                           int phy_id, bool last)
>>>> {
>>>>      <...>
>>>>      // Since ex_phy->port is not set, this branch will not be enter
>>>
>>> But then how does this ever work? It is because we follow path 
>>> sas_rediscover_dev() -> sas_discover_new() -> 
>>> sas_ex_discover_devices() -> sas_ex_discover_dev() -> 
>>> sas_add_parent_port(), and not sas_rediscover_dev() -> 
>>> sas_discover_new() -> sas_ex_join_wide_port()? If so, is that because 
>>> ephy->sas_attached_phy == 0 in sas_discover_new() -> 
>>> sas_ex_join_wide_port() and it fails?
>>>
>>> BTW, about something mentioned earlier - adding the phy19 with SAS_ADDR 
>>
>> Yes,
>> For phy19, when the phy is attached and added to the parent wide port, 
>> the path is:
>> sas_rediscover()
>>      ->sas_discover_new()
>>          ->sas_ex_discover_devices()
>>              ->sas_ex_discover_dev()
>>                  -> sas_add_parent_port().
> 
> ok, so then the change to set ex_phy->port = ex->parent_port looks ok. 
> Maybe we can put this in a helper with the sas_port_add_phy() call, as 
> it is duplicated in sas_ex_join_wide_port()
> 
> Do we also need to set ex_phy->phy_state (like sas_ex_join_wide_port())?

Well, okay, as follows?
+++ b/drivers/scsi/libsas/sas_expander.c
@@ -856,9 +856,7 @@ static bool sas_ex_join_wide_port(struct 
domain_device *parent, int phy_id)

                 if (!memcmp(phy->attached_sas_addr, 
ephy->attached_sas_addr,
                             SAS_ADDR_SIZE) && ephy->port) {
-                       sas_port_add_phy(ephy->port, phy->phy);
-                       phy->port = ephy->port;
-                       phy->phy_state = PHY_DEVICE_DISCOVERED;
+                       sas_port_add_ex_phy(ephy->port, phy);
                         return true;
                 }
         }
diff --git a/drivers/scsi/libsas/sas_internal.h 
b/drivers/scsi/libsas/sas_internal.h
index e860d5b19880..39ffa60a9a01 100644
--- a/drivers/scsi/libsas/sas_internal.h
+++ b/drivers/scsi/libsas/sas_internal.h
@@ -189,6 +189,13 @@ static inline void sas_phy_set_target(struct 
asd_sas_phy *p, struct domain_devic
         }
  }

+static inline void sas_port_add_ex_phy(struct sas_port *port, struct 
ex_phy *ex_phy)
+{
+       sas_port_add_phy(port, ex_phy->phy);
+       ex_phy->port = port;
+       ex_phy->phy_state = PHY_DEVICE_DISCOVERED;
+}
+
  static inline void sas_add_parent_port(struct domain_device *dev, int 
phy_id)
  {
         struct expander_device *ex = &dev->ex_dev;
@@ -201,8 +208,7 @@ static inline void sas_add_parent_port(struct 
domain_device *dev, int phy_id)
                 BUG_ON(sas_port_add(ex->parent_port));
                 sas_port_mark_backlink(ex->parent_port);
         }
-       sas_port_add_phy(ex->parent_port, ex_phy->phy);
+       sas_port_add_ex_phy(ex->parent_port, ex_phy);
  }

> 
>> And the path called when it is removed from parent wide port is:
>> sas_rediscover()
>>      ->sas_unregister_devs_sas_addr() // The sas address of phy19 
>> becomes 0. Since ex_phy->port is NULL, phy19 is not removed from the 
>> parent wide port's phy_list.
>>
>> For phy0, it is connected to a new sata device.
>> sas_rediscover()
>>      ->sas_discover_new()->sas_ex_phy_discover()
>>                              ->sas_ex_phy_discover_helper()
>>                                  ->sas_set_ex_phy() // The device type 
>> is stp. Since the linkrate is 5 and less than 1.5G, sas_address is set 
>> to 0.
> 
> Then when we get the proper linkrate later, will we then rediscover and 
> set the proper SAS address? I am just wondering if this change is really 
> required?
Yes, but in fact it has not reached that stage yet. After setting the 
address to 0, it will continue to create a new port and try to add other 
phys with the same address as it to this new port.

> 
> BTW, Even with the change to set ex_phy->port = ex->parent_port, are we 
> still joining the host-attached expander phy (19) to a port with SAS 
> address == 0?
Yes, in order to avoid this situation, in the current patch, we will not 
force the SAS address to be set to 0 when the device type is not NULL, 
but will still use the address obtained after requesting the expander.


Thanks,
Xingui
