Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B8F379AC9C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:37:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233423AbjIKUwh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 16:52:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236110AbjIKJvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 05:51:01 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DF41ED;
        Mon, 11 Sep 2023 02:50:56 -0700 (PDT)
Received: from canpemm500006.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RkhhJ1BGZzNnL7;
        Mon, 11 Sep 2023 17:47:12 +0800 (CST)
Received: from [10.174.179.200] (10.174.179.200) by
 canpemm500006.china.huawei.com (7.192.105.130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 11 Sep 2023 17:50:54 +0800
Subject: Re: [PATCH net v3] team: fix null-ptr-deref when team device type is
 changed
To:     Hangbin Liu <liuhangbin@gmail.com>
CC:     <jiri@resnulli.us>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20230905081056.3365013-1-william.xuanziyang@huawei.com>
 <ZP7Fdq1wgzzTftnE@Laptop-X1>
From:   "Ziyang Xuan (William)" <william.xuanziyang@huawei.com>
Message-ID: <6cebaa19-bf09-173e-4f44-fae5f874895a@huawei.com>
Date:   Mon, 11 Sep 2023 17:50:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <ZP7Fdq1wgzzTftnE@Laptop-X1>
Content-Type: text/plain; charset="gbk"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.200]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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

> Hi Ziyang,
> 
> You patch status is Changes Requested[1]. I think you need to repost this
> patch.
> 
> [1] https://patchwork.kernel.org/project/netdevbpf/patch/20230905081056.3365013-1-william.xuanziyang@huawei.com/
> 
Thanks for reminding. Patch v4 is sent.

> Thanks
> Hangbin
> On Tue, Sep 05, 2023 at 04:10:56PM +0800, Ziyang Xuan wrote:
>> Get a null-ptr-deref bug as follows with reproducer [1].
>>
>> BUG: kernel NULL pointer dereference, address: 0000000000000228
>> ...
>> RIP: 0010:vlan_dev_hard_header+0x35/0x140 [8021q]
>> ...
>> Call Trace:
>>  <TASK>
>>  ? __die+0x24/0x70
>>  ? page_fault_oops+0x82/0x150
>>  ? exc_page_fault+0x69/0x150
>>  ? asm_exc_page_fault+0x26/0x30
>>  ? vlan_dev_hard_header+0x35/0x140 [8021q]
>>  ? vlan_dev_hard_header+0x8e/0x140 [8021q]
>>  neigh_connected_output+0xb2/0x100
>>  ip6_finish_output2+0x1cb/0x520
>>  ? nf_hook_slow+0x43/0xc0
>>  ? ip6_mtu+0x46/0x80
>>  ip6_finish_output+0x2a/0xb0
>>  mld_sendpack+0x18f/0x250
>>  mld_ifc_work+0x39/0x160
>>  process_one_work+0x1e6/0x3f0
>>  worker_thread+0x4d/0x2f0
>>  ? __pfx_worker_thread+0x10/0x10
>>  kthread+0xe5/0x120
>>  ? __pfx_kthread+0x10/0x10
>>  ret_from_fork+0x34/0x50
>>  ? __pfx_kthread+0x10/0x10
>>  ret_from_fork_asm+0x1b/0x30
>>
>> [1]
>> $ teamd -t team0 -d -c '{"runner": {"name": "loadbalance"}}'
>> $ ip link add name t-dummy type dummy
>> $ ip link add link t-dummy name t-dummy.100 type vlan id 100
>> $ ip link add name t-nlmon type nlmon
>> $ ip link set t-nlmon master team0
>> $ ip link set t-nlmon nomaster
>> $ ip link set t-dummy up
>> $ ip link set team0 up
>> $ ip link set t-dummy.100 down
>> $ ip link set t-dummy.100 master team0
>>
>> When enslave a vlan device to team device and team device type is changed
>> from non-ether to ether, header_ops of team device is changed to
>> vlan_header_ops. That is incorrect and will trigger null-ptr-deref
>> for vlan->real_dev in vlan_dev_hard_header() because team device is not
>> a vlan device.
>>
>> Assign eth_header_ops to header_ops of team device when its type is changed
>> from non-ether to ether to fix the bug.
>>
>> Fixes: 1d76efe1577b ("team: add support for non-ethernet devices")
>> Suggested-by: Hangbin Liu <liuhangbin@gmail.com>
>> Signed-off-by: Ziyang Xuan <william.xuanziyang@huawei.com>
>> ---
>> v3:
>>   - Export eth_header_ops to fix modpost error.
>> v2:
>>   - Just modify header_ops to eth_header_ops not use ether_setup().
>> ---
>>  drivers/net/team/team.c | 5 ++++-
>>  net/ethernet/eth.c      | 1 +
>>  2 files changed, 5 insertions(+), 1 deletion(-)
>>
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
>> diff --git a/net/ethernet/eth.c b/net/ethernet/eth.c
>> index 2edc8b796a4e..157833509adb 100644
>> --- a/net/ethernet/eth.c
>> +++ b/net/ethernet/eth.c
>> @@ -347,6 +347,7 @@ const struct header_ops eth_header_ops ____cacheline_aligned = {
>>  	.cache_update	= eth_header_cache_update,
>>  	.parse_protocol	= eth_header_parse_protocol,
>>  };
>> +EXPORT_SYMBOL(eth_header_ops);
>>  
>>  /**
>>   * ether_setup - setup Ethernet network device
>> -- 
>> 2.25.1
>>
> 
> .
> 
