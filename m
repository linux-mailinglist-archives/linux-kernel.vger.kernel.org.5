Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 807737F62B4
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 16:26:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346051AbjKWP0e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 10:26:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346027AbjKWP0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 10:26:32 -0500
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3CA4B2;
        Thu, 23 Nov 2023 07:26:36 -0800 (PST)
Received: from [192.168.1.107] (89-186-112-232.pool.digikabel.hu [89.186.112.232])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: hs@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id D2CCF87640;
        Thu, 23 Nov 2023 16:26:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1700753194;
        bh=tADxMhqmym43UtaltuF6ideItA5aCnkrDR4RpjiaUqs=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=xTBTLhosRSikzas9acB1UsbUoffinOBIu3tEnayeLY8j5J/RCVCfVRWTlrC7x6y7I
         dsV8R7Pv44VIu7LzF0R+ZDA2+yU0w/P2kV0PJLXu/aVCOKmNp6yfZVyV8Ruj2SiIr7
         bAAEQdwOK84GIHehfKt3tT7zX/YVax9ztrJgNAjBF+U99HfR8WQE4yjiWVhuosl5Dx
         cUBdEizLTWGMCfA1OwayXaoGmy/3P/bP4RRRjRVL7MdTfYgVvfM0isGAdguR2fDNtJ
         NNFEkhm0BxXTR0cPPx/H67C8Rnj2U1X291r9hTElzzPbg9E3Km3RUJ0ghKcINDVMWN
         1AR3LHSZRKUXQ==
Reply-To: hs@denx.de
Subject: Re: [PATCH] net: fec: fix probing of fec1 when fec0 is not probed yet
To:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        netdev@vger.kernel.org, Heiko Schocher <heiko.schocher@gmail.com>
Cc:     Clark Wang <xiaoning.wang@nxp.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Shenwei Wang <shenwei.wang@nxp.com>,
        Wei Fang <wei.fang@nxp.com>, linux-kernel@vger.kernel.org
References: <20231123132744.62519-1-hs@denx.de> <5992842.lOV4Wx5bFT@steina-w>
From:   Heiko Schocher <hs@denx.de>
Message-ID: <1af63dea-e333-cef7-2bc6-bbf4eb8c3881@denx.de>
Date:   Thu, 23 Nov 2023 16:26:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <5992842.lOV4Wx5bFT@steina-w>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Alexander,

On 23.11.23 16:11, Alexander Stein wrote:
> Hello Heiko,
> 
> Am Donnerstag, 23. November 2023, 14:27:43 CET schrieb Heiko Schocher:
>> it is possible that fec1 is probed before fec0. On SoCs
>> with FEC_QUIRK_SINGLE_MDIO set (which means fec1 uses mii
>> from fec0) init of mii fails for fec1 when fec0 is not yet
>> probed, as fec0 setups mii bus. In this case fec_enet_mii_init
>> for fec1 returns with -ENODEV, and so fec1 never comes up.
>>
>> Return here with -EPROBE_DEFER so interface gets later
>> probed again.
>>
>> Found this on imx8qxp based board, using 2 ethernet interfaces,
>> and from time to time, fec1 interface came not up.
> 
> But FEC_QUIRK_SINGLE_MDIO is only set for imx28. How is this related to 
> imx8qxp?

Ah, yes ... customer uses NXP based kernel there is:

        /* board only enable one mii bus in default */
        if (!of_get_property(np, "fsl,mii-exclusive", NULL))
                fep->quirks |= FEC_QUIRK_SINGLE_MDIO;

which is missing in mainline... nevertheless patch fixes a problem
with boards having quirk FEC_QUIRK_SINGLE_MDIO set.

> Will this also help for imx6ul when fec1 is almost always probed before fec0 
> due to order of DT nodes?

Yep, I think so...  do you have the chance to test such a setup?

bye,
Heiko
> 
> Best regards,
> Alexander
> 
>> Signed-off-by: Heiko Schocher <hs@denx.de>
>> ---
>>
>>  drivers/net/ethernet/freescale/fec_main.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/ethernet/freescale/fec_main.c
>> b/drivers/net/ethernet/freescale/fec_main.c index
>> c3b7694a7485..d956f95e7a65 100644
>> --- a/drivers/net/ethernet/freescale/fec_main.c
>> +++ b/drivers/net/ethernet/freescale/fec_main.c
>> @@ -2445,7 +2445,7 @@ static int fec_enet_mii_init(struct platform_device
>> *pdev) mii_cnt++;
>>  			return 0;
>>  		}
>> -		return -ENOENT;
>> +		return -EPROBE_DEFER;
>>  	}
>>
>>  	bus_freq = 2500000; /* 2.5MHz by default */
> 
> 

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
