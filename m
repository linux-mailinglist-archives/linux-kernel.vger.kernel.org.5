Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CF6A77DBAA
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 10:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242689AbjHPIGM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 04:06:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242753AbjHPIGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 04:06:03 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76C5AAB;
        Wed, 16 Aug 2023 01:05:56 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id B982240005;
        Wed, 16 Aug 2023 08:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1692173154;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=buUZIewaBI0NnwVWRvZWmFI4Agy/t2YiSjWqh7RyJdg=;
        b=bmBzSIhkpKxI51GJqr6lE+obvn4+CITJUWkaiF5XL6RLgc8sY6iwqQHK0tXGFEnWhQFrk8
        +9oIXuYjoUpyTknm69BekCDpwSc1/+upU0dcjyNBwvD8CbgMra0phvYrSwgp8+M3nZLwp9
        E7RLPXQrNzrGYDVzgn7EuE8h6uexkNhTlZqABq/tXgV8nvU9PQmBMzFGcaVjfonr494KKd
        QTmOywfNuXAEsrOdI2blgQzNFuvkDGN+ZbFXjxzqld8JEETqd2teNzCM8/eF8BduoZLICE
        w1HvnO+CRK75TcnECZVoC3dm6sRkOWRvaNlO2HrC3QGoYgwzL8zkpaH5JhqDoQ==
Message-ID: <7483089a-ae0f-8e8b-e059-57f6e06591de@bootlin.com>
Date:   Wed, 16 Aug 2023 10:06:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 1/2] net: phylink: add a function to resume phy alone
 to fix resume issue with WoL enabled
Content-Language: en-US
To:     Clark Wang <xiaoning.wang@nxp.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Paolo Abeni <pabeni@redhat.com>,
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
 <152ee4d9-800e-545a-c2c6-08b03e9d1301@bootlin.com>
 <ZNUQOS49kP5uTgqx@shell.armlinux.org.uk>
 <AM0PR04MB5089BA7465245F67458641DEF310A@AM0PR04MB5089.eurprd04.prod.outlook.com>
From:   =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
In-Reply-To: <AM0PR04MB5089BA7465245F67458641DEF310A@AM0PR04MB5089.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alexis.lothore@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Clark,
sorry for the late reply

On 8/11/23 05:39, Clark Wang wrote:
> Hi Alexis,
> 
> I am so sorry. Clement happened to be busy at the end of March, and I was busy with other projects later, so this issue was shelved.
> If you have now taken over the job. I can work with you to solve this problem.

No worries :)

> The information he gave me at that time was saying "My need is for the PCS to be configured before the stmmac_hw_setup() is phylink_major_config().". So the reason why his patch put phylink_start() before stmmac_hw_setup() is to ensure to execute the phylink_mac_initial_config() function in phylink_start() before MAC reset, right?

Yes, I think you summed it up right. And Russell raised the issue that this
early,whole phylink setup could lead to other issues because stmmac HW was not
initialized yet while phylink is now ready
> 
> But his patch only changed stmmac_open(), that is, it only affected the sequence after the first startup.
> Have you tested the system suspend/resume?

From my understanding, that's indeed a second issue (only affecting the start
path, not the resume path), after the first one (whole phylink start).
I did not try your series yet since I wanted to get sure about the series status
first, and did not play with suspend/resume on the RZN1 platform. My current
understanding is that your series only affects the suspend/resume path, but its
concept (allowing initializing only the phy, not the whole phylink machine, for
fixed link) may be usable for the start path on RZN1 too (which is where Clement
encountered issues because of lacking RXC)

I'll pick your series and play with it on RZN1 to check how it can fit the use
case and get back to you

Thanks !
Alexis

> In the resume process, phylink_major_config() is called in phylink_resolve(). It is a work. In some cases on some of our platforms, this work may not be executed in time, which will lead to the lack of RXC, which will cause the MAC reset to fail.
> 
> Best Regards,
> Clark Wang
> 
>> -----Original Message-----
>> From: Russell King <linux@armlinux.org.uk>
>> Sent: 2023年8月11日 0:29
>> To: Alexis Lothoré <alexis.lothore@bootlin.com>
>> Cc: Clark Wang <xiaoning.wang@nxp.com>; Paolo Abeni
>> <pabeni@redhat.com>; peppe.cavallaro@st.com;
>> alexandre.torgue@foss.st.com; joabreu@synopsys.com;
>> davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
>> mcoquelin.stm32@gmail.com; andrew@lunn.ch; hkallweit1@gmail.com;
>> netdev@vger.kernel.org; linux-stm32@st-md-mailman.stormreply.com;
>> linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
>> dl-linux-imx <linux-imx@nxp.com>; Thomas Petazzoni
>> <thomas.petazzoni@bootlin.com>
>> Subject: Re: [PATCH V3 1/2] net: phylink: add a function to resume phy alone to
>> fix resume issue with WoL enabled
>>
>> On Thu, Aug 10, 2023 at 06:10:04PM +0200, Alexis Lothoré wrote:
>>> Hello Clark, Russell,
>>>
>>> On 2/23/23 12:06, Russell King (Oracle) wrote:
>>>> On Thu, Feb 23, 2023 at 10:27:06AM +0000, Clark Wang wrote:
>>>>> Hi Russel,
>>>>>
>>>>> I have sent the V4 patch set yesterday.
>>>>> You can check it from:
>> https://lore.ker/
>> nel.org%2Flinux-arm-kernel%2F20230222092636.1984847-2-xiaoning.wang%4
>> 0nxp.com%2FT%2F&data=05%7C01%7Cxiaoning.wang%40nxp.com%7Ccc3388
>> b42e244474ceb608db99bedff0%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0
>> %7C0%7C638272817295048537%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4
>> wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7
>> C%7C%7C&sdata=k3kDU5bfPF6eVBjhEAKbUmbO%2FU%2BwwBCMRVW0%2B
>> w5a0D0%3D&reserved=0
>>>>>
>>>>
>>>> Ah yes, sent while net-next is closed.
>>>>
>>>> Have you had any contact with Clément Léger ? If not, please can you
>>>> reach out to Clément, because he has virtually the same problem. I
>>>> don't want to end up with a load of different fixes in the mainline
>>>> kernel for the same "we need the PHY clock enabled on stmmac" problem
>>>> from different people.
>>>
>>> I am resuming Clement's initial efforts on RZN1 GMAC interface, which
>> indeed is
>>> in need of an early PCS initialization mechanism too ([1]).
>>>
>>>> Please try to come up with one patch set between you both to fix this.
>>>>
>>>> (effectively, that's a temporary NAK on your series.)>
>>>
>>> I would like to know if this series is still ongoing/alive ? I have checked for
>>> follow-ups after V4 sent by Clark ([2]), but did not find anything. Clement
>>> handed me over the topic right when Russell suggested to discuss this shared
>>> need, so I am not sure if any mutualization discussion has happened yet ?
>>>
>>> If not, what would be the next steps ? Based on my understanding and
>> comments on
>>> the [2] v3, I feel that Clark's series would be a good starting point. In order
>>> to be able to use it in both series, we could possibly make it less specific to
>>> the "resume" mechanism (basically, phylink_phy_resume() =>
>>> phylink_phy_early_start() ) ? It would then prevent [1] from moving the whole
>>> phylink_start() in stmmac_main too early (see issue raised by Russell) and
>> allow
>>> to just call phylink_phy_early_start() early enough, while still being usable in
>>> the resume scenario raised by Clark. Or am I missing bigger issues with
>> current
>>> series ?
>>
>> The whole thing died a death as soon as I suggested that the two parties
>> work together, so currently as far as I'm concerned, the issue is dead
>> and no patches have been merged to fix it.
>>
>> As I stated, I don't want to merge one solution, and then have the other
>> solution then come along later... the simple answer would have been for
>> party A to test party B's changes to see whether they solved the
>> problem, but clearly that never happened.
>>
>> If there's an unwillingness to work together to solve a common problem,
>> then the problem will remain unsolved.
>>
>> Note that we also have an ongoing discussion because of the AR803x PHYs
>> and their default-enabled hibernation mode, for which I've proposed
>> this patch. I haven't considered whether it should impact the resume
>> problem - it probably _should_ and it should probably cause the PHY to
>> resume outputting its clock when it resumes (which should have already
>> happened by the time stmmac begins resuming.)
>>
>> However, as no one seems prepared to constructively comment on either
>> my proposal nor (so far) the patch, there's no guarantee that we'll
>> merge the change below.
>>
>> So, right now I've no idea what's going to become of stmmac and its
>> requirement to have RXC always present. It seems there's multiple
>> issues that that requirement causes.
>>
>> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>> b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>> index fcab363d8dfa..a954f1d61709 100644
>> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>> @@ -1254,6 +1254,11 @@ static int stmmac_phy_setup(struct stmmac_priv
>> *priv)
>>                       ~(MAC_10HD | MAC_100HD | MAC_1000HD);
>>       priv->phylink_config.mac_managed_pm = true;
>>
>> +     /* stmmac always requires a receive clock in order for things like
>> +      * hardware reset to work.
>> +      */
>> +     priv->phylink_config.mac_requires_rxc = true;
>> +
>>       phylink = phylink_create(&priv->phylink_config, fwnode,
>>                                mode, &stmmac_phylink_mac_ops);
>>       if (IS_ERR(phylink))
>> diff --git a/drivers/net/phy/at803x.c b/drivers/net/phy/at803x.c
>> index 13c4121fa309..619a63a0d14f 100644
>> --- a/drivers/net/phy/at803x.c
>> +++ b/drivers/net/phy/at803x.c
>> @@ -990,7 +990,8 @@ static int at803x_hibernation_mode_config(struct
>> phy_device *phydev)
>>       /* The default after hardware reset is hibernation mode enabled. After
>>        * software reset, the value is retained.
>>        */
>> -     if (!(priv->flags & AT803X_DISABLE_HIBERNATION_MODE))
>> +     if (!(priv->flags & AT803X_DISABLE_HIBERNATION_MODE) &&
>> +         !(phydev->dev_flags & PHY_F_RXC_ALWAYS_ON))
>>               return 0;
>>
>>       return at803x_debug_reg_mask(phydev,
>> AT803X_DEBUG_REG_HIB_CTRL,
>> diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
>> index 4f1c8bb199e9..6568a2759101 100644
>> --- a/drivers/net/phy/phylink.c
>> +++ b/drivers/net/phy/phylink.c
>> @@ -1830,6 +1830,8 @@ static int phylink_bringup_phy(struct phylink *pl,
>> struct phy_device *phy,
>>  static int phylink_attach_phy(struct phylink *pl, struct phy_device *phy,
>>                             phy_interface_t interface)
>>  {
>> +     u32 flags = 0;
>> +
>>       if (WARN_ON(pl->cfg_link_an_mode == MLO_AN_FIXED ||
>>                   (pl->cfg_link_an_mode == MLO_AN_INBAND &&
>>                    phy_interface_mode_is_8023z(interface) && !pl->sfp_bus)))
>> @@ -1838,7 +1840,10 @@ static int phylink_attach_phy(struct phylink *pl,
>> struct phy_device *phy,
>>       if (pl->phydev)
>>               return -EBUSY;
>>
>> -     return phy_attach_direct(pl->netdev, phy, 0, interface);
>> +     if (pl->config.mac_requires_rxc)
>> +             flags |= PHY_F_RXC_ALWAYS_ON;
>> +
>> +     return phy_attach_direct(pl->netdev, phy, flags, interface);
>>  }
>>
>>  /**
>> @@ -1941,6 +1946,9 @@ int phylink_fwnode_phy_connect(struct phylink *pl,
>>               pl->link_config.interface = pl->link_interface;
>>       }
>>
>> +     if (pl->config.mac_requires_rxc)
>> +             flags |= PHY_F_RXC_ALWAYS_ON;
>> +
>>       ret = phy_attach_direct(pl->netdev, phy_dev, flags,
>>                               pl->link_interface);
>>       phy_device_free(phy_dev);
>> diff --git a/include/linux/phy.h b/include/linux/phy.h
>> index ba08b0e60279..79df5e01707d 100644
>> --- a/include/linux/phy.h
>> +++ b/include/linux/phy.h
>> @@ -761,6 +761,7 @@ struct phy_device {
>>
>>  /* Generic phy_device::dev_flags */
>>  #define PHY_F_NO_IRQ         0x80000000
>> +#define PHY_F_RXC_ALWAYS_ON  BIT(30)
>>
>>  static inline struct phy_device *to_phy_device(const struct device *dev)
>>  {
>> diff --git a/include/linux/phylink.h b/include/linux/phylink.h
>> index 789c516c6b4a..a83c1a77338f 100644
>> --- a/include/linux/phylink.h
>> +++ b/include/linux/phylink.h
>> @@ -204,6 +204,7 @@ enum phylink_op_type {
>>   * @poll_fixed_state: if true, starts link_poll,
>>   *                 if MAC link is at %MLO_AN_FIXED mode.
>>   * @mac_managed_pm: if true, indicate the MAC driver is responsible for
>> PHY PM.
>> + * @mac_requires_rxc: if true, the MAC always requires a receive clock from
>> PHY.
>>   * @ovr_an_inband: if true, override PCS to MLO_AN_INBAND
>>   * @get_fixed_state: callback to execute to determine the fixed link state,
>>   *                if MAC link is at %MLO_AN_FIXED mode.
>> @@ -216,6 +217,7 @@ struct phylink_config {
>>       enum phylink_op_type type;
>>       bool poll_fixed_state;
>>       bool mac_managed_pm;
>> +     bool mac_requires_rxc;
>>       bool ovr_an_inband;
>>       void (*get_fixed_state)(struct phylink_config *config,
>>                               struct phylink_link_state *state);
>>
>> --
>> RMK's Patch system:
>> https://www.ar/
>> mlinux.org.uk%2Fdeveloper%2Fpatches%2F&data=05%7C01%7Cxiaoning.wan
>> g%40nxp.com%7Ccc3388b42e244474ceb608db99bedff0%7C686ea1d3bc2b4c6
>> fa92cd99c5c301635%7C0%7C0%7C638272817295048537%7CUnknown%7CT
>> WFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJ
>> XVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=%2FLZFtiTfr1ZM%2B7OZ%2FM7I
>> JkZH42DVgcNMZx8VohBSv38%3D&reserved=0
>> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

