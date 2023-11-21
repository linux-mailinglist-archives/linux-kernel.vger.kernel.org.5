Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6E877F2C06
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 12:48:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233753AbjKULs7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 06:48:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjKULs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 06:48:57 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2044E9C
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 03:48:54 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E1DFC433C8;
        Tue, 21 Nov 2023 11:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700567333;
        bh=LVOxFSwAPN+ofpreb4kzEhImD73DSJhJl3zz/ic5nw4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=lQls28AR1h7JUm8TIDaywL6CC3RMHJEXkRbvGqRGHcGH18xd0acGMqGy7yrDFKXhT
         qPUPJHmGBbbn8r0OBxWI2Hj//XiFKkY6z8ueHVK58DLRuoHdrquhPuyab4LkUNbjHB
         +8t1z11CRJanX2MjHieo50vG1AAroZCkjuazWRPBvxfnzrBxLyZI9BTfrYsYzzyLrJ
         cuYXItjv4Q1r9xLEwvCJdFanF7KibWcM4c1VYk+OSc6SjrpKdX4vTfRzt2d2/2mFJl
         vkveQVD/2LrZR8+ItiygPDJ4N/zGibFecndoWPUMzVD1g9Pnv54iuPHk7no0PB9wBv
         nMLkd9IMKxEpg==
Message-ID: <93e0ef82-ab79-4f46-8f39-5f91f4e8ca89@kernel.org>
Date:   Tue, 21 Nov 2023 13:48:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 net-next 6/7] net: ethernet: ti: am65-cpsw-qos: Add
 Frame Preemption MAC Merge support
Content-Language: en-US
To:     Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, s-vadapalli@ti.com, r-gunasekaran@ti.com,
        vigneshr@ti.com, srk@ti.com, horms@kernel.org, p-varis@ti.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231120140147.78726-1-rogerq@kernel.org>
 <20231120140147.78726-7-rogerq@kernel.org>
 <20231120232620.uciap4bazypzlg3g@skbuf>
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20231120232620.uciap4bazypzlg3g@skbuf>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 21/11/2023 01:26, Vladimir Oltean wrote:
> On Mon, Nov 20, 2023 at 04:01:46PM +0200, Roger Quadros wrote:
>> Changelog:
>>
>> v6:
>> - get mutex around am65_cpsw_iet_commit_preemptible_tcs() in
>>   am65_cpsw_iet_change_preemptible_tcs()
>> - use "preemption" instead of "pre-emption"
>> - call am65_cpsw_setup_mqprio() from within am65_cpsw_setup_taprio()
>> - Now works with kselftest except the last test which fails
>>

<snip>

>> diff --git a/drivers/net/ethernet/ti/am65-cpsw-qos.c b/drivers/net/ethernet/ti/am65-cpsw-qos.c
>> index 60f625e1350b..8443c13c9ff6 100644
>> --- a/drivers/net/ethernet/ti/am65-cpsw-qos.c
>> +++ b/drivers/net/ethernet/ti/am65-cpsw-qos.c
>> @@ -4,9 +4,11 @@
>>   *
>>   * quality of service module includes:
>>   * Enhanced Scheduler Traffic (EST - P802.1Qbv/D2.2)
>> + * Interspersed Express Traffic (IET - P802.3br/D2.0)
>>   */
>>  
>>  #include <linux/pm_runtime.h>
>> +#include <linux/units.h>
> 
> If this was ordered alphabetically, u comes after t.
> 
>>  #include <linux/time.h>
>>  #include <net/pkt_cls.h>
>>  
>> @@ -259,6 +266,196 @@ static int am65_cpsw_setup_mqprio(struct net_device *ndev, void *type_data)
>>  	return ret;
>>  }
>>  
>> +static int am65_cpsw_iet_set_verify_timeout_count(struct am65_cpsw_port *port)
>> +{
>> +	int verify_time_ms = port->qos.iet.verify_time_ms;
>> +	int link_speed = port->qos.link_speed;
>> +	u32 val;
>> +
>> +	if (WARN_ON(link_speed == SPEED_UNKNOWN))
>> +		return -ENODEV;
>> +
>> +	/* The number of wireside clocks contained in the verify
>> +	 * timeout counter. The default is 0x1312d0
>> +	 * (10ms at 125Mhz in 1G mode).
>> +	 */
>> +	val = 125 * HZ_PER_MHZ;	/* assuming 125MHz wireside clock */
>> +
>> +	val /= MILLIHZ_PER_HZ;		/* count per ms timeout */
>> +	val *= verify_time_ms;		/* count for timeout ms */
>> +	if (link_speed < SPEED_1000)
>> +		val <<= 1;	/* FIXME: Is this correct? */
> 
> Is there any way to find out and remove the FIXME? Like running the
> selftest at SPEED_100?

I checked at SPEED_100 without the above if condition and it works so I'll
drop it in next revision.

> 
>> +
>> +	if (val > AM65_CPSW_PN_MAC_VERIFY_CNT_MASK)
>> +		return -EINVAL;
>> +
>> +	writel(val, port->port_base + AM65_CPSW_PN_REG_IET_VERIFY);
>> +
>> +	return 0;
>> +}
>> +

-- 
cheers,
-roger
