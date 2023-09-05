Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D109C7929AE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244701AbjIEQXK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:23:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354444AbjIELn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 07:43:28 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0686A1AB;
        Tue,  5 Sep 2023 04:43:22 -0700 (PDT)
Received: from canpemm500006.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Rg3TD6XKdzMl8L;
        Tue,  5 Sep 2023 19:40:00 +0800 (CST)
Received: from [10.174.179.200] (10.174.179.200) by
 canpemm500006.china.huawei.com (7.192.105.130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 5 Sep 2023 19:43:19 +0800
Subject: Re: [PATCH net v2] team: fix null-ptr-deref when team device type is
 changed
To:     Hangbin Liu <liuhangbin@gmail.com>
CC:     <jiri@resnulli.us>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20230905074638.3304732-1-william.xuanziyang@huawei.com>
 <ZPbsW/bOGeO9Ww8+@Laptop-X1>
From:   "Ziyang Xuan (William)" <william.xuanziyang@huawei.com>
Message-ID: <ecd693a5-105b-d2b8-5f6d-618d14b491dd@huawei.com>
Date:   Tue, 5 Sep 2023 19:43:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <ZPbsW/bOGeO9Ww8+@Laptop-X1>
Content-Type: text/plain; charset="gbk"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.200]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500006.china.huawei.com (7.192.105.130)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tue, Sep 05, 2023 at 03:46:38PM +0800, Ziyang Xuan wrote:
>> diff --git a/drivers/net/team/team.c b/drivers/net/team/team.c
>> index d3dc22509ea5..12fb5f4cff06 100644
>> --- a/drivers/net/team/team.c
>> +++ b/drivers/net/team/team.c
>> @@ -2127,7 +2127,10 @@ static const struct ethtool_ops team_ethtool_ops = {
>>  static void team_setup_by_port(struct net_device *dev,
>>  			       struct net_device *port_dev)
>>  {
>> -	dev->header_ops	= port_dev->header_ops;
>> +	if (port_dev->type == ARPHRD_ETHER)
>> +		dev->header_ops	= &eth_header_ops;
>> +	else
>> +		dev->header_ops	= port_dev->header_ops;
>>  	dev->type = port_dev->type;
>>  	dev->hard_header_len = port_dev->hard_header_len;
>>  	dev->needed_headroom = port_dev->needed_headroom;
> 
> Hmm.. Do we need to export eth_header_ops? I got error like
> ERROR: modpost: "eth_header_ops" [drivers/net/team/team.ko] undefined!
> 
> But I saw function loopback_setup() could reference this. Not sure what
> I missed here.

Yes, I also got the same error, and gave v3 patch with exporting eth_header_ops.

drivers/net/loopback.o controlled by CONFIG_NET, CONFIG_NET is bool type and usually Y.
So drivers/net/loopback.o does not need to export eth_header_ops.

> 
> Thanks
> Hangbin
> 
> .
> 
