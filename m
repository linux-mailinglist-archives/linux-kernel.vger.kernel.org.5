Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F7B37C6495
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 07:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377111AbjJLFWe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 01:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233879AbjJLFWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 01:22:33 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E05B6B8;
        Wed, 11 Oct 2023 22:22:28 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39C5M5NY096685;
        Thu, 12 Oct 2023 00:22:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1697088126;
        bh=sR8v2G3utIU7rWWAjyLio03N6v8AvgwFgGJx+mKzXls=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=mYnRMGjHzkCHJwNKVJKVbqx8en38Gvqj2ab020objjlRs/eNC5GT8TIYIf9lQ4ziV
         D0ca4CngIcyTEvbTjD/5/ryf9KaonLhYfrh8CQC1prdPRQ9j99925ip6qvv2tNLgJH
         J3z/E0wAIt4ci3peYCfiFWsn3Db04Y6ODCJDXdAA=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39C5M5KI073674
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 12 Oct 2023 00:22:05 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 12
 Oct 2023 00:22:05 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 12 Oct 2023 00:22:05 -0500
Received: from [10.24.69.31] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39C5M1Fr023148;
        Thu, 12 Oct 2023 00:22:02 -0500
Message-ID: <5e330c1e-3d5e-ad1b-1333-d7595cd47069@ti.com>
Date:   Thu, 12 Oct 2023 10:52:01 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] net: ti: icssg-prueth: Fix tx_total_bytes count
Content-Language: en-US
To:     Ravi Gunasekaran <r-gunasekaran@ti.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <srk@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Roger Quadros <rogerq@kernel.org>
References: <20231011063700.1824093-1-danishanwar@ti.com>
 <3bc32261-fdcf-2cea-cae2-f4dddc147d96@ti.com>
From:   MD Danish Anwar <danishanwar@ti.com>
In-Reply-To: <3bc32261-fdcf-2cea-cae2-f4dddc147d96@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10/23 15:16, Ravi Gunasekaran wrote:
> 
> 
> On 10/11/23 12:07 PM, MD Danish Anwar wrote:
>> ICSSG HW stats on TX side considers 8 preamble bytes as data bytes. Due
>> to this the tx_total_bytes of one interface doesn't match the
>> rx_total_bytes of other interface when two ICSSG interfaces are
> 
> The errata is on the ICSSG Tx side regardless of which interface it is
> connected to. Please rephrase this part of the message to something like,
> "rx_total_bytes of the link partner".
> 

Sure Ravi, I'll update the commit message.

>> connected with each other. There is no public errata available yet.
>>
>> As a workaround to fix this, decrease tx_total_bytes by 8 bytes for every
>> tx frame.
>>
>> Fixes: c1e10d5dc7a1 ("net: ti: icssg-prueth: Add ICSSG Stats")
>> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
>> ---
>>  drivers/net/ethernet/ti/icssg/icssg_stats.c | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/ti/icssg/icssg_stats.c b/drivers/net/ethernet/ti/icssg/icssg_stats.c
>> index bb0b33927e3b..dc12edcbac02 100644
>> --- a/drivers/net/ethernet/ti/icssg/icssg_stats.c
>> +++ b/drivers/net/ethernet/ti/icssg/icssg_stats.c
>> @@ -18,6 +18,7 @@ void emac_update_hardware_stats(struct prueth_emac *emac)
>>  	struct prueth *prueth = emac->prueth;
>>  	int slice = prueth_emac_slice(emac);
>>  	u32 base = stats_base[slice];
>> +	u32 tx_pkt_cnt = 0;
>>  	u32 val;
>>  	int i;
>>  
>> @@ -29,7 +30,12 @@ void emac_update_hardware_stats(struct prueth_emac *emac)
>>  			     base + icssg_all_stats[i].offset,
>>  			     val);
>>  
>> +		if (!strncmp(icssg_ethtool_stats[i].name, "tx_good_frames", ETH_GSTRING_LEN))
>> +			tx_pkt_cnt = val;
>> +
>>  		emac->stats[i] += val;
>> +		if (!strncmp(icssg_ethtool_stats[i].name, "tx_total_bytes", ETH_GSTRING_LEN))
>> +			emac->stats[i] -= tx_pkt_cnt * 8;
>>  	}
>>  }
>>  
> 

-- 
Thanks and Regards,
Danish
