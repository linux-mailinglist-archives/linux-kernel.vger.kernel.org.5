Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA0D1755EA9
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 10:40:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbjGQIkL convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 17 Jul 2023 04:40:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjGQIkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 04:40:09 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A0CBF4;
        Mon, 17 Jul 2023 01:40:08 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id A198D826C;
        Mon, 17 Jul 2023 16:40:06 +0800 (CST)
Received: from EXMBX062.cuchost.com (172.16.6.62) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 17 Jul
 2023 16:40:06 +0800
Received: from [192.168.120.43] (171.223.208.138) by EXMBX062.cuchost.com
 (172.16.6.62) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 17 Jul
 2023 16:40:05 +0800
Message-ID: <3859b0f6-d31f-dbc3-833e-222eb6ca6b8c@starfivetech.com>
Date:   Mon, 17 Jul 2023 16:40:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v4 2/2] net: phy: motorcomm: Add pad drive strength cfg
 support
Content-Language: en-US
To:     Andrew Lunn <andrew@lunn.ch>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <netdev@vger.kernel.org>, Peter Geis <pgwipeout@gmail.com>,
        Frank <Frank.Sae@motor-comm.com>,
        "David S . Miller" <davem@davemloft.net>,
        "Eric Dumazet" <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Yanhong Wang <yanhong.wang@starfivetech.com>
References: <20230714101406.17686-1-samin.guo@starfivetech.com>
 <20230714101406.17686-3-samin.guo@starfivetech.com>
 <55cd8a47-89e5-4f62-8162-c744e1a99ad5@lunn.ch>
From:   Guo Samin <samin.guo@starfivetech.com>
In-Reply-To: <55cd8a47-89e5-4f62-8162-c744e1a99ad5@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
X-Originating-IP: [171.223.208.138]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX062.cuchost.com
 (172.16.6.62)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



-------- 原始信息 --------
主题: Re: [PATCH v4 2/2] net: phy: motorcomm: Add pad drive strength cfg support
From: Andrew Lunn <andrew@lunn.ch>
收件人: Samin Guo <samin.guo@starfivetech.com>
日期: 2023/7/15

>> +static u32 yt8531_get_ds_map(struct phy_device *phydev, u32 cur)
>> +{
>> +	u32 vol;
>> +	int i;
>> +
>> +	vol = yt8531_get_ldo_vol(phydev);
>> +	for (i = 0; i < ARRAY_SIZE(yt8531_ldo_vol); i++) {
>> +		if (yt8531_ldo_vol[i].vol == vol && yt8531_ldo_vol[i].cur == cur)
>> +			return yt8531_ldo_vol[i].ds;
>> +	}
>> +
>> +	phydev_warn(phydev,
>> +		    "No matching current value was found %d, Use default value.\n", cur);
>> +
>> +	return YT8531_RGMII_RX_DS_DEFAULT;
> 
> If there is a value in DT and it is invalid, return -EINVAL and fail
> the probe. Only use the default if there is no value in DT.
> 
>     Andrew

Will be fixed in the next version.

Thanks for taking the time to review the code.

Best regards,
Samin
