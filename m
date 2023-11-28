Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C4977FB100
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 05:42:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234602AbjK1El6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 23:41:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbjK1El4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 23:41:56 -0500
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 736531AA;
        Mon, 27 Nov 2023 20:42:02 -0800 (PST)
Received: from [192.168.1.107] (89-186-112-232.pool.digikabel.hu [89.186.112.232])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: hs@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 4934B87516;
        Tue, 28 Nov 2023 05:41:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1701146520;
        bh=6qv/nhkVe9kw+UVFtxebwNFRGl9GVaetLZvjjatGHLI=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=IhkaUsjqWZECkl4fwg0URQWwo1xqctlgqI7ObtVTXqkSfvoA6Reu2gWxTY2dooyTz
         wy5RnryJcpQLf6bhz9CLSOl2SX5RJ0Fvf1GtRvSoyjmXI6NBIUpqBgqMWWzZDh2lCn
         wt879N/8YxOrz2q6Rd801QlM+P4GrQlo0FdKSx+rURMcutswDNGkQMwHA+Ea4PVFkj
         Ho905n56TNcqICxMSt7yv30uegPsr11Fx+NJhhBYxXbUTYuDvTzei0EjfBix1FhjcY
         WHk+OVF/YNqp7dWeZco2iW8Z8NMWp5c/a2X99WYkFuNDS2YHNOiEC2sCmJYflBWgm8
         X9zhq2MRnN+nw==
Reply-To: hs@denx.de
Subject: Re: [PATCH] net: fec: fix probing of fec1 when fec0 is not probed yet
To:     Wei Fang <wei.fang@nxp.com>, Andrew Lunn <andrew@lunn.ch>,
        Heiko Schocher <heiko.schocher@gmail.com>
Cc:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Clark Wang <xiaoning.wang@nxp.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Shenwei Wang <shenwei.wang@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alexander Sverdlin <alexander.sverdlin@siemens.com>
References: <20231123132744.62519-1-hs@denx.de>
 <132aca53-6570-41a4-b2b2-0907d74f9b31@lunn.ch>
 <AM5PR04MB313982936800424F9B2E660688B8A@AM5PR04MB3139.eurprd04.prod.outlook.com>
 <227dc52c-c555-34e4-d534-1a749af15425@denx.de>
 <AM5PR04MB31395DCE58A5312BD4E8A67A88BDA@AM5PR04MB3139.eurprd04.prod.outlook.com>
From:   Heiko Schocher <hs@denx.de>
Message-ID: <af87e335-e6f2-7ffd-ba19-22289558819e@denx.de>
Date:   Tue, 28 Nov 2023 05:41:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <AM5PR04MB31395DCE58A5312BD4E8A67A88BDA@AM5PR04MB3139.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=gbk
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Wei,

On 27.11.23 07:55, Wei Fang wrote:
>> -----Original Message-----
>> From: Heiko Schocher <hs@denx.de>
>> Sent: 2023年11月24日 13:19
>> To: Wei Fang <wei.fang@nxp.com>; Andrew Lunn <andrew@lunn.ch>; Heiko
>> Schocher <heiko.schocher@gmail.com>
>> Cc: netdev@vger.kernel.org; Clark Wang <xiaoning.wang@nxp.com>; David S.
>> Miller <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>;
>> Jakub Kicinski <kuba@kernel.org>; dl-linux-imx <linux-imx@nxp.com>; Paolo
>> Abeni <pabeni@redhat.com>; Shenwei Wang <shenwei.wang@nxp.com>;
>> linux-kernel@vger.kernel.org; Alexander Sverdlin
>> <alexander.sverdlin@siemens.com>
>> Subject: Re: [PATCH] net: fec: fix probing of fec1 when fec0 is not probed yet
>>
>> Hello Wei,
>>
>> On 24.11.23 03:33, Wei Fang wrote:
>>>> -----Original Message-----
>>>> From: Andrew Lunn <andrew@lunn.ch>
>>>> Sent: 2023年11月24日 4:09
>>>> To: Heiko Schocher <heiko.schocher@gmail.com>
>>>> Cc: netdev@vger.kernel.org; Heiko Schocher <hs@denx.de>; Clark Wang
>>>> <xiaoning.wang@nxp.com>; David S. Miller <davem@davemloft.net>; Eric
>>>> Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>;
>>>> dl-linux-imx <linux-imx@nxp.com>; Paolo Abeni <pabeni@redhat.com>;
>>>> Shenwei Wang <shenwei.wang@nxp.com>; Wei Fang
>> <wei.fang@nxp.com>;
>>>> linux-kernel@vger.kernel.org
>>>> Subject: Re: [PATCH] net: fec: fix probing of fec1 when fec0 is not
>>>> probed yet
>>>>
>>>> On Thu, Nov 23, 2023 at 02:27:43PM +0100, Heiko Schocher wrote:
>>>>> it is possible that fec1 is probed before fec0. On SoCs with
>>>>> FEC_QUIRK_SINGLE_MDIO set (which means fec1 uses mii from fec0) init
>>>>> of mii fails for fec1 when fec0 is not yet probed, as fec0 setups
>>>>> mii bus. In this case fec_enet_mii_init for fec1 returns with
>>>>> -ENODEV, and so fec1 never comes up.
>>>>>
>>>>> Return here with -EPROBE_DEFER so interface gets later probed again.
>>>>>
>>>>> Found this on imx8qxp based board, using 2 ethernet interfaces, and
>>>>> from time to time, fec1 interface came not up.
>>>>>
>>>>> Signed-off-by: Heiko Schocher <hs@denx.de>
>>>>> ---
>>>>>
>>>>>  drivers/net/ethernet/freescale/fec_main.c | 2 +-
>>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/net/ethernet/freescale/fec_main.c
>>>>> b/drivers/net/ethernet/freescale/fec_main.c
>>>>> index c3b7694a7485..d956f95e7a65 100644
>>>>> --- a/drivers/net/ethernet/freescale/fec_main.c
>>>>> +++ b/drivers/net/ethernet/freescale/fec_main.c
>>>>> @@ -2445,7 +2445,7 @@ static int fec_enet_mii_init(struct
>>>> platform_device *pdev)
>>>>>  			mii_cnt++;
>>>>>  			return 0;
>>>>>  		}
>>>>> -		return -ENOENT;
>>>>> +		return -EPROBE_DEFER;
>>>>
>>>> I think this has been tried before.
>>>>
>>> Yes, there was indeed a similar patch [1] before. but this issue seems
>>> to only exist in downstream tree, because there is a local patch which is not
>> in the upstream.
>>>
>>>         /* board only enable one mii bus in default */
>>>         if (!of_get_property(np, "fsl,mii-exclusive", NULL))
>>>                 fep->quirks |= FEC_QUIRK_SINGLE_MDIO;
>>
>> Yes, sorry for overseeing this ... but there are SoCs in upstream which set
>> FEC_QUIRK_SINGLE_MDIO and so mii bus from for example fec0 is used on
>> other fecX devices, correct?
>>
> Yes, i.MX28 still uses FEC_QUIRK_SINGLE_MDIO flag in the upstream, But the
> current patch doesn't seem to completely solve this issue.
> 
> If fec1 is probed before fec0, I think its fep->dev_id should be equal to 0, so it will
> not go to the following statement.

Indeed... and than fep->dev_id is interchanged too... I wonder why not using:

	fep->dev_id = of_alias_get_id(np, "ethernet");

in fec_probe function for getting the dev_id. With that no problems with
"wrong" dev_id and also my change makes sense...

But you are correct, currently patch is useless.

>  if ((fep->quirks & FEC_QUIRK_SINGLE_MDIO) && fep->dev_id > 0) {
> 		/* fec1 uses fec0 mii_bus */
> 		if (mii_cnt && fec0_mii_bus) {
> 			fep->mii_bus = fec0_mii_bus;
> 			mii_cnt++;
> 			return 0;
> 		}
> 		return -ENOENT;
> }
> 
> I'm considering removing the FEC_QUIRK_SINGLE_MDIO flag from upstream
> in the future as it's not necessary. But not now as I am busy with other projects.

Hmm.. and what is on platforms which have this usecase?

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
