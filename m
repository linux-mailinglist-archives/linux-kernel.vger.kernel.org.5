Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9ECA7F24CC
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 05:20:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbjKUESQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 23:18:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjKUESO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 23:18:14 -0500
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62473D9;
        Mon, 20 Nov 2023 20:18:10 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3AL4Hljl022289;
        Mon, 20 Nov 2023 22:17:47 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1700540267;
        bh=iAWgjl6CeVUNIJ5xa2msryoeZqkqbfAiC09oJHoJ948=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=UOLV0lYDKXvXT2j/khhVB2jqDvq8tYYC2oFynZXHbTJSM7x76LaiuD9jQdcsgJoeH
         7qrzN0tBaPj7n0uFqdFYL2gVll89neHSyzz9tfY1cM6l8wZDkMimzbDAU/LQ/DorkO
         H20kSfPqz0w9edc8dUz1XolLp6QoxZPsyRuvDezA=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3AL4HlxS021942
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 20 Nov 2023 22:17:47 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 20
 Nov 2023 22:17:46 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 20 Nov 2023 22:17:46 -0600
Received: from [10.249.130.150] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3AL4Hf9U045593;
        Mon, 20 Nov 2023 22:17:42 -0600
Message-ID: <7b72efc1-c373-4fbb-87b0-0aa7f159b228@ti.com>
Date:   Tue, 21 Nov 2023 09:47:37 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: hsr: Add support for MC filtering at the
 slave device
To:     Wojciech Drewek <wojciech.drewek@intel.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>
CC:     <bigeasy@linutronix.de>, <horms@kernel.org>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20231120110105.18416-1-r-gunasekaran@ti.com>
 <1f836577-5f33-4662-bb32-26f99f737ee6@intel.com>
Content-Language: en-US
From:   Ravi Gunasekaran <r-gunasekaran@ti.com>
In-Reply-To: <1f836577-5f33-4662-bb32-26f99f737ee6@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/20/2023 5:10 PM, Wojciech Drewek wrote:
>
> On 20.11.2023 12:01, Ravi Gunasekaran wrote:
>> From: Murali Karicheri <m-karicheri2@ti.com>
>>
>> When MC (multicast) list is updated by the networking layer due to a
>> user command and as well as when allmulti flag is set, it needs to be
>> passed to the enslaved Ethernet devices. This patch allows this
>> to happen by implementing ndo_change_rx_flags() and ndo_set_rx_mode()
>> API calls that in turns pass it to the slave devices using
>> existing API calls.
>>
>> Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
>> Signed-off-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
>> ---
> One small nit, besides that:
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
>
>>  net/hsr/hsr_device.c | 67 +++++++++++++++++++++++++++++++++++++++++++-
>>  1 file changed, 66 insertions(+), 1 deletion(-)
>>
>> diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
>> index 306f942c3b28..4e8f4a3cefbf 100644
>> --- a/net/hsr/hsr_device.c
>> +++ b/net/hsr/hsr_device.c
>> @@ -173,7 +173,24 @@ static int hsr_dev_open(struct net_device *dev)
>>  
>>  static int hsr_dev_close(struct net_device *dev)
>>  {
>> -	/* Nothing to do here. */
>> +	struct hsr_port *port;
>> +	struct hsr_priv *hsr;
>> +
>> +	hsr = netdev_priv(dev);
>> +	hsr_for_each_port(hsr, port) {
>> +		if (port->type == HSR_PT_MASTER)
>> +			continue;
>> +		switch (port->type) {
>> +		case HSR_PT_SLAVE_A:
>> +		case HSR_PT_SLAVE_B:
>> +			dev_uc_unsync(port->dev, dev);
>> +			dev_mc_unsync(port->dev, dev);
>> +			break;
>> +		default:
>> +			break;
>> +		}
>> +	}
>> +
>>  	return 0;
>>  }
>>  
>> @@ -404,12 +421,60 @@ void hsr_del_ports(struct hsr_priv *hsr)
>>  		hsr_del_port(port);
>>  }
>>  
>> +static void hsr_ndo_set_rx_mode(struct net_device *dev)
> I wouldn't add "ndo" to the callback name, let's not stand out from other ndo callbacks here.

Thank you for reviewing the patch. I will address the above comment and send out
a v2.

>> +{
>> +	struct hsr_port *port;
>> +	struct hsr_priv *hsr;
>> +
>> +	hsr = netdev_priv(dev);
>> +
>> +	hsr_for_each_port(hsr, port) {
>> +		if (port->type == HSR_PT_MASTER)
>> +			continue;
>> +		switch (port->type) {
>> +		case HSR_PT_SLAVE_A:
>> +		case HSR_PT_SLAVE_B:
>> +			dev_mc_sync_multiple(port->dev, dev);
>> +			dev_uc_sync_multiple(port->dev, dev);
>> +			break;
>> +		default:
>> +			break;
>> +		}
>> +	}
>> +}
>> +
>> +static void hsr_change_rx_flags(struct net_device *dev, int change)
>> +{
>> +	struct hsr_port *port;
>> +	struct hsr_priv *hsr;
>> +
>> +	hsr = netdev_priv(dev);
>> +
>> +	hsr_for_each_port(hsr, port) {
>> +		if (port->type == HSR_PT_MASTER)
>> +			continue;
>> +		switch (port->type) {
>> +		case HSR_PT_SLAVE_A:
>> +		case HSR_PT_SLAVE_B:
>> +			if (change & IFF_ALLMULTI)
>> +				dev_set_allmulti(port->dev,
>> +						 dev->flags &
>> +						 IFF_ALLMULTI ? 1 : -1);
>> +			break;
>> +		default:
>> +			break;
>> +		}
>> +	}
>> +}
>> +
>>  static const struct net_device_ops hsr_device_ops = {
>>  	.ndo_change_mtu = hsr_dev_change_mtu,
>>  	.ndo_open = hsr_dev_open,
>>  	.ndo_stop = hsr_dev_close,
>>  	.ndo_start_xmit = hsr_dev_xmit,
>> +	.ndo_change_rx_flags = hsr_change_rx_flags,
>>  	.ndo_fix_features = hsr_fix_features,
>> +	.ndo_set_rx_mode = hsr_ndo_set_rx_mode,
>>  };
>>  
>>  static struct device_type hsr_type = {
>>
>> base-commit: 5a82d69d48c82e89aef44483d2a129f869f3506a

