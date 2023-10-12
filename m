Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85E297C6491
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 07:21:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377132AbjJLFVb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 01:21:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233879AbjJLFV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 01:21:29 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E7B590;
        Wed, 11 Oct 2023 22:21:28 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39C5LHCN051170;
        Thu, 12 Oct 2023 00:21:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1697088077;
        bh=mzJ6mczws2V1o12NE3ALNTxfbB/dSlBF4vOrX568DzU=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=Jx0wdWGinDG26kPvuiEwfOJty21+RPavdxMGn/hEds6NkWc9u5FaNSufX6gdhTSRF
         g1b5GCiW92huGNJhviPjw8fOiIOXOJGoT4UisxtduyFvlQICFVZ9+ZFHZbzvL4Cxar
         RC8CC4JT7IJuyVk98I/3G9HyYwYTL1PDBRsyyy/w=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39C5LHfM073317
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 12 Oct 2023 00:21:17 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 12
 Oct 2023 00:21:17 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 12 Oct 2023 00:21:17 -0500
Received: from [10.24.69.31] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39C5LCIS092468;
        Thu, 12 Oct 2023 00:21:13 -0500
Message-ID: <7b5f195f-c5c8-6847-9458-3d5563cf0112@ti.com>
Date:   Thu, 12 Oct 2023 10:51:12 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] net: ti: icssg-prueth: Fix tx_total_bytes count
Content-Language: en-US
To:     Andrew Lunn <andrew@lunn.ch>
CC:     Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <srk@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        <r-gunasekaran@ti.com>, Roger Quadros <rogerq@kernel.org>
References: <20231011063700.1824093-1-danishanwar@ti.com>
 <4d7c2ab9-e980-42a5-9452-79bc0d33e094@lunn.ch>
From:   MD Danish Anwar <danishanwar@ti.com>
In-Reply-To: <4d7c2ab9-e980-42a5-9452-79bc0d33e094@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On 11/10/23 18:11, Andrew Lunn wrote:
>> @@ -29,7 +30,12 @@ void emac_update_hardware_stats(struct prueth_emac *emac)
>>  			     base + icssg_all_stats[i].offset,
>>  			     val);
>>  
>> +		if (!strncmp(icssg_ethtool_stats[i].name, "tx_good_frames", ETH_GSTRING_LEN))
>> +			tx_pkt_cnt = val;
> 
> Doing a strncmp seems very expensive. Could you make use of
> icssg_stats.offset?
> 

Sure. I can define the offset of these two stats and then use them in if
condition as below.

#define ICSSG_TX_PACKET_OFFSET 0xA0
#define ICSSG_TX_BYTE_OFFSET   0xEC

if (icssg_ethtool_stats[i].offset == ICSSG_TX_PACKET_OFFSET)
	tx_pkt_cnt = val;

if (icssg_ethtool_stats[i].offset == ICSSG_TX_BYTE_OFFSET)
	emac->stats[i] -= tx_pkt_cnt * 8;


Pls let me know if this looks OK.

> 	Andrew

-- 
Thanks and Regards,
Danish
