Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE667F6B99
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 06:09:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231225AbjKXFJ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 00:09:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjKXFJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 00:09:26 -0500
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06B26D6E;
        Thu, 23 Nov 2023 21:09:32 -0800 (PST)
Received: from [192.168.1.107] (89-186-112-232.pool.digikabel.hu [89.186.112.232])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: hs@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 6617886335;
        Fri, 24 Nov 2023 06:09:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1700802571;
        bh=4YBefhqNpH7LZt/7V9zhmWY+xwqF9GTyIUhDbvPuqbk=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Zb4XlSxHe9J/+9bpf8klpiyoLLd/KnB7G4J9uwuxojT1NZVlp/iR6UpHcc6MnbpYC
         rgyYQsps+RbDVAtKX6DJk4qnqsXhvXK0TqO7OYC6yVN2uKaluxy0+N55T8V3iFuaYz
         OHLJkAOi++W5w6N2oxVqMLQE/tSbzyoEsD9MroFXn/1T53T6kn5z73cmvUdiM5gBGl
         qctEQrTS4Fs4w5G/66yobUrIEzOM4Pi7usYxwSKDGPuyqqzeJs1RFP0gbMUsmc+lZz
         TCtYVpaQ2BaHxpd8dU6Qw9ljLAShh8JsBdHMNfPPHl48SroRrukThvsaZsCWVCdHke
         oracUzCILJ5Mw==
Reply-To: hs@denx.de
Subject: Re: [PATCH] net: fec: fix probing of fec1 when fec0 is not probed yet
To:     Andrew Lunn <andrew@lunn.ch>,
        Heiko Schocher <heiko.schocher@gmail.com>
Cc:     netdev@vger.kernel.org, Clark Wang <xiaoning.wang@nxp.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Shenwei Wang <shenwei.wang@nxp.com>,
        Wei Fang <wei.fang@nxp.com>, linux-kernel@vger.kernel.org
References: <20231123132744.62519-1-hs@denx.de>
 <132aca53-6570-41a4-b2b2-0907d74f9b31@lunn.ch>
From:   Heiko Schocher <hs@denx.de>
Message-ID: <307682f4-b691-7198-ba96-454b973bd555@denx.de>
Date:   Fri, 24 Nov 2023 06:09:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <132aca53-6570-41a4-b2b2-0907d74f9b31@lunn.ch>
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

Hello Andrew,

On 23.11.23 21:09, Andrew Lunn wrote:
> On Thu, Nov 23, 2023 at 02:27:43PM +0100, Heiko Schocher wrote:
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
>>
>> Signed-off-by: Heiko Schocher <hs@denx.de>
>> ---
>>
>>  drivers/net/ethernet/freescale/fec_main.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
>> index c3b7694a7485..d956f95e7a65 100644
>> --- a/drivers/net/ethernet/freescale/fec_main.c
>> +++ b/drivers/net/ethernet/freescale/fec_main.c
>> @@ -2445,7 +2445,7 @@ static int fec_enet_mii_init(struct platform_device *pdev)
>>  			mii_cnt++;
>>  			return 0;
>>  		}
>> -		return -ENOENT;
>> +		return -EPROBE_DEFER;
> 
> I think this has been tried before.

Oh, wasn;t aware of it...

> Are there any issues with the mii_cnt++; I thought the previous
> attempt as this had problems with the wrong mdio bus being assigned to
> fep->mii_bus ? But i could be remembering wrongly.

The problem with returning -ENOENT is, that the probe never called
again ... with returning -EPROBE_DEFER, the device gets probed
later again.

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
