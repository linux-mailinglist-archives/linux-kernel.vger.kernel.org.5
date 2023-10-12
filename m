Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 406A37C7331
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 18:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344064AbjJLQj2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 12:39:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344027AbjJLQj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 12:39:26 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB89CA9;
        Thu, 12 Oct 2023 09:39:23 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39CGd46D036926;
        Thu, 12 Oct 2023 11:39:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1697128744;
        bh=8qGWk2MmoYlEABHB+jdRa8pwXPRY/VwhT1ctiVDXyao=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=BoKu7lrEik3wHsUbwCsTLP4bX3r3Hno9g5mdyv3kjTgcIZWUbSk1EgXKuA4yRxVMX
         lwjd0o6vk/QAl58BHsuyuG30U6VBDCOWEdVbUsCWARXzawx+5ProUGpBapM6L5xDcx
         58rv8/SsVpqeyo5l4vFm43Mdc+nl82ciOqTp1fR8=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39CGd4ws081254
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 12 Oct 2023 11:39:04 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 12
 Oct 2023 11:39:03 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 12 Oct 2023 11:39:03 -0500
Received: from [10.249.135.225] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39CGcxOT025695;
        Thu, 12 Oct 2023 11:39:00 -0500
Message-ID: <2d524100-7e34-7869-5e90-415614b767f3@ti.com>
Date:   Thu, 12 Oct 2023 22:08:58 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] net: ti: icssg-prueth: Fix tx_total_bytes count
To:     Andrew Lunn <andrew@lunn.ch>, MD Danish Anwar <danishanwar@ti.com>
CC:     Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <srk@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        <r-gunasekaran@ti.com>, Roger Quadros <rogerq@kernel.org>
References: <20231011063700.1824093-1-danishanwar@ti.com>
 <4d7c2ab9-e980-42a5-9452-79bc0d33e094@lunn.ch>
 <7b5f195f-c5c8-6847-9458-3d5563cf0112@ti.com>
 <524856b3-6876-48d1-aebf-09f7f6c71f7b@lunn.ch>
Content-Language: en-US
From:   "Anwar, Md Danish" <a0501179@ti.com>
In-Reply-To: <524856b3-6876-48d1-aebf-09f7f6c71f7b@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/12/2023 8:58 PM, Andrew Lunn wrote:
> On Thu, Oct 12, 2023 at 10:51:12AM +0530, MD Danish Anwar wrote:
>> Hi Andrew,
>>
>> On 11/10/23 18:11, Andrew Lunn wrote:
>>>> @@ -29,7 +30,12 @@ void emac_update_hardware_stats(struct prueth_emac *emac)
>>>>  			     base + icssg_all_stats[i].offset,
>>>>  			     val);
>>>>  
>>>> +		if (!strncmp(icssg_ethtool_stats[i].name, "tx_good_frames", ETH_GSTRING_LEN))
>>>> +			tx_pkt_cnt = val;
>>>
>>> Doing a strncmp seems very expensive. Could you make use of
>>> icssg_stats.offset?
>>>
>>
>> Sure. I can define the offset of these two stats and then use them in if
>> condition as below.
>>
>> #define ICSSG_TX_PACKET_OFFSET 0xA0
>> #define ICSSG_TX_BYTE_OFFSET   0xEC
>>
>> if (icssg_ethtool_stats[i].offset == ICSSG_TX_PACKET_OFFSET)
>> 	tx_pkt_cnt = val;
>>
>> if (icssg_ethtool_stats[i].offset == ICSSG_TX_BYTE_OFFSET)
>> 	emac->stats[i] -= tx_pkt_cnt * 8;
> 
> That is much better. Also consider adding something like:
> 
> BUILD_BUG_ON(ICSSG_TX_PACKET_OFFSET < ICSSG_TX_BYTE_OFFSET)
> 
> I've no idea if this is correct. Just something to prove at build time
> that ICSSG_TX_PACKET_OFFSET is read before ICSSG_TX_BYTE_OFFSET.
> 

These registers are defined sequentially in the structure
miig_stats_regs. The offset for rx_packets is 0x0, rx_broadcast_frames
is 0x4 and so on. Basically the offset for i'th stat is i * sizeof(u32).

In the structure, tx_packet is defined first (index 40, offset 0xA0) and
then tx_bytes is defined (index 59, offset 0xEC).

In emac_update_hardware_stats() all these registers are read
sequentially. Meaning first tx_packet register is read and then tx_byte.

emac_update_hardware_stats() is called every 25s (by workqueue). Every
time first tx_packet is read and then tx_byte. So every time we are
decrementing tx_bytes by 8 bytes * num of packets, the num of packets
always exists and it is read before doing this calculation.

So I don't think any check is required to make sure
ICSSG_TX_PACKET_OFFSET is read before ICSSG_TX_BYTE_OFFSET.

The hardware design is such a way that these registers are read in a
sequence and the same sequence is followed in driver (struct
miig_stats_regs)

>      Andrew

-- 
Thanks and Regards,
Md Danish Anwar
