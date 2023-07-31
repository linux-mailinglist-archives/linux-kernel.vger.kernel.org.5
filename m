Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41CBA769124
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 11:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbjGaJKy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 05:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjGaJKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 05:10:52 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0596AF3;
        Mon, 31 Jul 2023 02:10:49 -0700 (PDT)
Received: from kwepemm600007.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RDsrW01f2zrS4J;
        Mon, 31 Jul 2023 17:09:46 +0800 (CST)
Received: from [10.69.136.139] (10.69.136.139) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 31 Jul 2023 17:10:46 +0800
Message-ID: <a21beff2-9f38-d354-6049-aed20c18c8d4@huawei.com>
Date:   Mon, 31 Jul 2023 17:10:45 +0800
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
 <2c6514a7-db97-f345-9bc4-affd4eba2dda@huawei.com>
 <73b41fe2-12dd-4fc0-a44d-f6f94e6541fc@lunn.ch>
 <ef5489f9-43b4-ee59-699b-3f54a30c00aa@huawei.com>
 <e7219114-774f-49d0-8985-8875fd351b60@lunn.ch>
From:   Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <e7219114-774f-49d0-8985-8875fd351b60@lunn.ch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.69.136.139]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600007.china.huawei.com (7.193.23.208)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


on 2023/7/30 2:23, Andrew Lunn wrote:
>>      Now i wounder if you are fixing the wrong thing. Maybe you should be
>>      fixing the PHY so it does not report up and then down? You say 'very
>>      snall intervals', which should in fact be 1 second. So is the PHY
>>      reporting link for a number of poll intervals? 1min to 10 minutes?
>>
>>                Andrew
>>
>> Yes, according to the log records, the phy polls every second,
>> but the link status changes take time.
>> Generally, it takes 10 seconds for the phy to detect link down,
>> but occasionally it takes several minutes to detect link down,
> What PHY driver is this?
>
> It is not so clear what should actually happen with auto-neg turned
> off. With it on, and the link going down, the PHY should react after
> about 1 second. It is not supposed to react faster than that, although
> some PHYs allow fast link down notification to be configured.
>
> Have you checked 802.3 to see what it says about auto-neg off and link
> down detection?
>
> I personally would not suppress this behaviour in the MAC
> driver. Otherwise you are going to have funny combinations of special
> cases of a feature which very few people actually use, making your
> maintenance costs higher.
>
> 	    Andrew
Thanks for your suggestion, We are analyzing this issue in depth.
