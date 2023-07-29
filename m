Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 808FC767BD3
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 05:12:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234668AbjG2DL5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 23:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjG2DLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 23:11:55 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2ECE4214;
        Fri, 28 Jul 2023 20:11:52 -0700 (PDT)
Received: from kwepemm600007.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RCTzJ4y4JzrRgj;
        Sat, 29 Jul 2023 11:10:52 +0800 (CST)
Received: from [10.69.136.139] (10.69.136.139) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sat, 29 Jul 2023 11:11:49 +0800
Message-ID: <2c6514a7-db97-f345-9bc4-affd4eba2dda@huawei.com>
Date:   Sat, 29 Jul 2023 11:11:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 5/6] net: hns3: fix wrong print link down up
To:     Andrew Lunn <andrew@lunn.ch>
CC:     <yisen.zhuang@huawei.com>, <salil.mehta@huawei.com>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <shenjian15@huawei.com>,
        <wangjie125@huawei.com>, <liuyonglong@huawei.com>,
        <wangpeiyang1@huawei.com>, <netdev@vger.kernel.org>,
        <stable@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230728075840.4022760-1-shaojijie@huawei.com>
 <20230728075840.4022760-6-shaojijie@huawei.com>
 <7ce32389-550b-4beb-82b1-1b6183fdeabb@lunn.ch>
From:   Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <7ce32389-550b-4beb-82b1-1b6183fdeabb@lunn.ch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.69.136.139]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600007.china.huawei.com (7.193.23.208)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,
I understand what you mean, and sorry for my wrong description. The link
is not always up. If I turn auto-neg off, the link will go down finally.
However, there is an intervel between my operation and the link down. In
my experiment, it may be 1 min or evn 10 mins. The phy state is set to
PHY_UP immediately when I set auto-neg off. And the phy machine check the
state during a very small intervals. Thus, during my experiment, the phy
state has a followed varietion:
PHY_RUNNING -> PHY_UP -> PHY_RUNNING -> PHY_NOLINK.

We print link up/down based on phy state and link state. In aboved case,
It print looks like:
eth0 link down -- because phy state is set to PHY_UP
eth0 link up -- because phy state is set to PHY_RUNNING
eth0 link down -- because link down

This patch wants to fix the first two wrong print.
We will modify this patch description

Thanks!

   Jijie Shao


on 2023/7/28 16:57, Andrew Lunn wrote:
> On Fri, Jul 28, 2023 at 03:58:39PM +0800, Jijie Shao wrote:
>> From: Peiyang Wang <wangpeiyang1@huawei.com>
>>
>> This patch will fix a wrong print "device link down/up". Consider a case
>> that set autoneg to off with same speed and duplex configuration. The link
>> is always up while the phy state is set to PHY_UP and set back to
>> PHY_RUNNING later. It will print link down when the phy state is not
>> PHY_RUNNING. To avoid that, the condition should include PHY_UP.
> Does this really happen? If autoneg is on, and there is link, it means
> the link peer is auto using auto-neg. If you turn auto-neg off, the
> link peer is not going to know what speed to use, and so the link will
> go down. The link will only come up again when you reconfigure the
> link peer to also not use auto-neg.
>
> I don't see how you can turn auto-neg off and not loose the link.
>
>    Andrew
