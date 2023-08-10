Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 602B0777212
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 10:06:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233510AbjHJIGa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 04:06:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbjHJIG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 04:06:27 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8AFD1703;
        Thu, 10 Aug 2023 01:06:25 -0700 (PDT)
Received: from kwepemm600007.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RLzxK0WL4z1L9X1;
        Thu, 10 Aug 2023 16:05:09 +0800 (CST)
Received: from [10.69.136.139] (10.69.136.139) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 10 Aug 2023 16:06:20 +0800
Message-ID: <5bd40f2f-7b19-1c49-336a-25da7b574c5e@huawei.com>
Date:   Thu, 10 Aug 2023 16:06:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC:     <yisen.zhuang@huawei.com>, <salil.mehta@huawei.com>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <shenjian15@huawei.com>,
        <wangjie125@huawei.com>, <liuyonglong@huawei.com>,
        <wangpeiyang1@huawei.com>, <netdev@vger.kernel.org>,
        <stable@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net 5/6] net: hns3: fix wrong print link down up
From:   Jijie Shao <shaojijie@huawei.com>
To:     Andrew Lunn <andrew@lunn.ch>
References: <20230728075840.4022760-1-shaojijie@huawei.com>
 <20230728075840.4022760-6-shaojijie@huawei.com>
 <7ce32389-550b-4beb-82b1-1b6183fdeabb@lunn.ch>
 <2c6514a7-db97-f345-9bc4-affd4eba2dda@huawei.com>
 <73b41fe2-12dd-4fc0-a44d-f6f94e6541fc@lunn.ch>
 <ef5489f9-43b4-ee59-699b-3f54a30c00aa@huawei.com>
 <e7219114-774f-49d0-8985-8875fd351b60@lunn.ch>
 <a21beff2-9f38-d354-6049-aed20c18c8d4@huawei.com>
In-Reply-To: <a21beff2-9f38-d354-6049-aed20c18c8d4@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.69.136.139]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600007.china.huawei.com (7.193.23.208)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


on 2023/7/31 17:10, Jijie Shao wrote:
> What PHY driver is this?
>>
>> It is not so clear what should actually happen with auto-neg turned
>> off. With it on, and the link going down, the PHY should react after
>> about 1 second. It is not supposed to react faster than that, although
>> some PHYs allow fast link down notification to be configured.
>>
>> Have you checked 802.3 to see what it says about auto-neg off and link
>> down detection?
>>
>> I personally would not suppress this behaviour in the MAC
>> driver. Otherwise you are going to have funny combinations of special
>> cases of a feature which very few people actually use, making your
>> maintenance costs higher.
>>
>>         Andrew

Hi Andrew,
We trace how the PHY state machine changed and show as followed:

[ 1974.220847][ T362] hns3 0000:35:00.0 eth1: set link(phy): autoneg=0, 
speed=100, duplex=1
[ 1974.233694][ T362] hns3 0000:35:00.0 eth1: link down
[ 1974.267444][ T32] RTL8211F Gigabit Ethernet mii-0000:35:00.0:02: PHY 
state change UP -> RUNNING
[ 1974.892830][ T7] hns3 0000:35:00.0 eth1: link up
[ 2004.277425][ T32] RTL8211F Gigabit Ethernet mii-0000:35:00.0:02: PHY 
state change RUNNING -> NOLINK
[ 2004.797731][ T7] hns3 0000:35:00.0 eth1: link down

Meanwhile, we also open tracing event about mdio and here are some 
useful logs:

kworker/1:0-19 [001] .... 1973.329775: mdio_access: mii-0000:35:00.0 
read phy:0x02 reg:0x00 val:0x1040
kworker/1:0-19 [001] .... 1973.331964: mdio_access: mii-0000:35:00.0 
read phy:0x02 reg:0x01 val:0x79ad
kworker/2:1-32 [002] .... 1974.247627: mdio_access: mii-0000:35:00.0 
read phy:0x02 reg:0x00 val:0x1040
kworker/2:1-32 [002] .... 1974.249870: mdio_access: mii-0000:35:00.0 
write phy:0x02 reg:0x00 val:0x2100
kworker/2:1-32 [002] .... 1974.252069: mdio_access: mii-0000:35:00.0 
read phy:0x02 reg:0x00 val:0x2100
kworker/2:1-32 [002] .... 1974.254143: mdio_access: mii-0000:35:00.0 
read phy:0x02 reg:0x01 val:0x798d
....
kworker/2:1-32 [002] .... 2003.240015: mdio_access: mii-0000:35:00.0 
read phy:0x02 reg:0x01 val:0x798d
....
kworker/2:1-32 [002] .... 2004.269525: mdio_access: mii-0000:35:00.0 
read phy:0x02 reg:0x01 val:0x7989

As you can see, the link state changed after 30 seconds when only 
setting autoneg off. When the BMSR changed, the PHY driver change state 
immediately. This patch wants to fixed the first link down up showed on 
logs cause the link do not changed.


Regards
Jijie Shao

