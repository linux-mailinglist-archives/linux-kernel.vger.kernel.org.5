Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF046777DC5
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 18:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235609AbjHJQKc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 12:10:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236714AbjHJQKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 12:10:17 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07D982D54;
        Thu, 10 Aug 2023 09:09:27 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id AF9FBC0009;
        Thu, 10 Aug 2023 16:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1691683766;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4qxw6gwLHzvrbHoxYk1AwkUqX8NF1+OpN2iHArg7CaA=;
        b=h8im4XO4gMECAJCvV5ytTCW+2T3TkjoLfZOcggaEgqfObeXgqEcNJUaC+DzV3o/Cxf6zjT
        qTEWl26zXCXmb+Y+5FYvY8zGP+5FmL82aVhzq734KSmu/qk8MG1ttkQybsagZO7XJTgz4J
        6FgZfjhKoMEHj9uVbe4e5Wiz6mco2uq0BAfN1SzdWIidGo8bMu6ORZyh/GgGpOXAgzgmc4
        B96NMc2vQiEFtrzA1rOoZdNpUZHEK7ElGmxtFlHdrW/bqiLSQP3Mmc864tknRs5ZD2CpDQ
        8f1qSfHPnt5/+vofEGhte/7d2yOx6F96mJqVMAUKkAWt78ORxPLNS7MU7t8ofQ==
Message-ID: <152ee4d9-800e-545a-c2c6-08b03e9d1301@bootlin.com>
Date:   Thu, 10 Aug 2023 18:10:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 1/2] net: phylink: add a function to resume phy alone
 to fix resume issue with WoL enabled
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>,
        Clark Wang <xiaoning.wang@nxp.com>
Cc:     Paolo Abeni <pabeni@redhat.com>,
        "peppe.cavallaro@st.com" <peppe.cavallaro@st.com>,
        "alexandre.torgue@foss.st.com" <alexandre.torgue@foss.st.com>,
        "joabreu@synopsys.com" <joabreu@synopsys.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
        "andrew@lunn.ch" <andrew@lunn.ch>,
        "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20230202081559.3553637-1-xiaoning.wang@nxp.com>
 <83a8fb89ac7a69d08c9ea1422dade301dcc87297.camel@redhat.com>
 <Y/c+MQtgtKFDjEZF@shell.armlinux.org.uk>
 <HE1PR0402MB2939A09FD54E72C80C19A467F3AB9@HE1PR0402MB2939.eurprd04.prod.outlook.com>
 <Y/dIoAqWfazh9k6F@shell.armlinux.org.uk>
Content-Language: en-US
From:   =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
In-Reply-To: <Y/dIoAqWfazh9k6F@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alexis.lothore@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Clark, Russell,

On 2/23/23 12:06, Russell King (Oracle) wrote:
> On Thu, Feb 23, 2023 at 10:27:06AM +0000, Clark Wang wrote:
>> Hi Russel,
>>
>> I have sent the V4 patch set yesterday.
>> You can check it from: https://lore.kernel.org/linux-arm-kernel/20230222092636.1984847-2-xiaoning.wang@nxp.com/T/
>>
> 
> Ah yes, sent while net-next is closed.
> 
> Have you had any contact with Clément Léger ? If not, please can you
> reach out to Clément, because he has virtually the same problem. I
> don't want to end up with a load of different fixes in the mainline
> kernel for the same "we need the PHY clock enabled on stmmac" problem
> from different people.

I am resuming Clement's initial efforts on RZN1 GMAC interface, which indeed is
in need of an early PCS initialization mechanism too ([1]).

> Please try to come up with one patch set between you both to fix this.
> 
> (effectively, that's a temporary NAK on your series.)>

I would like to know if this series is still ongoing/alive ? I have checked for
follow-ups after V4 sent by Clark ([2]), but did not find anything. Clement
handed me over the topic right when Russell suggested to discuss this shared
need, so I am not sure if any mutualization discussion has happened yet ?

If not, what would be the next steps ? Based on my understanding and comments on
the [2] v3, I feel that Clark's series would be a good starting point. In order
to be able to use it in both series, we could possibly make it less specific to
the "resume" mechanism (basically, phylink_phy_resume() =>
phylink_phy_early_start() ) ? It would then prevent [1] from moving the whole
phylink_start() in stmmac_main too early (see issue raised by Russell) and allow
to just call phylink_phy_early_start() early enough, while still being usable in
the resume scenario raised by Clark. Or am I missing bigger issues with current
series ?

Regards,
Alexis

[1]
https://lore.kernel.org/linux-arm-kernel/20230116103926.276869-1-clement.leger@bootlin.com/
[2] https://lore.kernel.org/all/20230222092636.1984847-1-xiaoning.wang@nxp.com/
-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

