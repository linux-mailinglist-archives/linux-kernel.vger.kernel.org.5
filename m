Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96E387761E2
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 15:58:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232662AbjHIN6j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 09:58:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232971AbjHIN6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 09:58:34 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2071.outbound.protection.outlook.com [40.107.7.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A44B210A;
        Wed,  9 Aug 2023 06:58:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l8pG1G9hp+r9gjFlNfs3m0q7Gcr3nLVF+cui1ewyoyHcfoZB0atrdxStZHCyeE3M42cbuDa2OPGD6H0ueEk+VUd7ZmdS/giITUlcjErEIVhaDzHWBTi7IIhgG3H5V+xCmc5FR26t1xmVknUFDAqTU1qTQm54PGHD/opNMrXZGu6V0YB3ceF7mEUbDffckxzmOwnkGr1CarKsyBuTM4kiOjmyArDIKocs+BQaBtF2qTehB3Cd7Mwm376pzRlitIGxG8VTEbavrQVrBWxSCJeh/0gXCFrlmG+/QxCjYk4QkpPNVR9Rup7UxwwgqwZ2eBUF73NKSD689PVoVdI10+3pbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zGirvIGS145XEQeS+x9wWJuGZRQF3ztNr9xXEvbdiO0=;
 b=V9/R+AL2WSYhtyM7V776fkvBATwrGvzWW+JgHtyRkeuOEtTSOJmZ2nmkxcgIXwchhC8W6SHD+g9fsMZelieNkYBaxUAGs5iH81+OBNbzitkLwZruyHi/wYUJkxiPH7Y5C+WjQiA8/CXrKrs9pzVnIx36Oos5rI7Mp0Ql6Puk59ci+xDE8gFW55YNheZwC6ARMFYum51Xt6y3YjD9+Ty+l0aw+w6QvqV0yxhwfPEs1KwwFKRvLNTS+1FJcLP8u/3GFQ0xFtYi4f943ZZEmXXhhAJnWCR4a+N9+qDXkE3b2HMwfXrG6M7BYuIJYy05iz/n4iCdhU4hwpWV9Sv8tmTgsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zGirvIGS145XEQeS+x9wWJuGZRQF3ztNr9xXEvbdiO0=;
 b=CEeEls5h3C4j12Vyml96ihaa9zKn4dd7imGT+5eci2ZbjrXwFNF24ZVa2yuaL7IGspgY/0Ok22PxFAsANp+NzF6cuSoMCoAq5VxiwXGUEADr7LKeuOj2p8QvDNZf+BFkuHzspg472E1/15Q/SLQavpFRaUjSgGU2QFwyVTI58QE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by PA4PR04MB9709.eurprd04.prod.outlook.com (2603:10a6:102:26b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Wed, 9 Aug
 2023 13:58:28 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::d4ed:20a0:8c0a:d9cf]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::d4ed:20a0:8c0a:d9cf%6]) with mapi id 15.20.6652.028; Wed, 9 Aug 2023
 13:58:28 +0000
Date:   Wed, 9 Aug 2023 16:58:23 +0300
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Ioana Ciornei <ciorneiioana@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "Russell King (Oracle)" <linux@armlinux.org.uk>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Ioana Ciornei <ioana.ciornei@nxp.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Andre Edich <andre.edich@microchip.com>,
        Antoine Tenart <atenart@kernel.org>,
        Baruch Siach <baruch@tkos.co.il>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Divya Koppera <Divya.Koppera@microchip.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kavya Sree Kotagiri <kavyasree.kotagiri@microchip.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Marek Vasut <marex@denx.de>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Mathias Kresin <dev@kresin.me>,
        Maxim Kochetkov <fido_max@inbox.ru>,
        Michael Walle <michael@walle.cc>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Nisar Sayed <Nisar.Sayed@microchip.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Willy Liu <willy.liu@realtek.com>,
        Yuiko Oshino <yuiko.oshino@microchip.com>
Subject: Re: [PATCH] net: phy: Don't disable irqs on shutdown if WoL is
 enabled
Message-ID: <20230809135702.4dencx4ikij7d33y@skbuf>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230804071757.383971-1-u.kleine-koenig@pengutronix.de>
X-ClientProxiedBy: AM0PR05CA0092.eurprd05.prod.outlook.com
 (2603:10a6:208:136::32) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|PA4PR04MB9709:EE_
X-MS-Office365-Filtering-Correlation-Id: de48ae2d-4260-46e6-cb58-08db98e0b51f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p9BmT9X4ofhx/COvHA6hBM34g+peCogmsh4czuRp3aVb4UeRecxdzcwMkbkZioEsq2pRxFz8+oM+Gi9hQ5VkK9PhD5tsh1deGOGce4b2G5zmuye97xKvngnDqjMiGFxaqjQIeTylIor88XdNkCpnB/vgiUEVYqWxgn/o6MW8TSFqK9ZQ0PoONu/fefWfoOnHPKZjOQ25pvEogveVy60mAn7LyCTFLD6B2wN5nJN6LZmSsuq2mjKfAZcA3/rJD0RqliP350fwvHeEehz8eDsXFd6g5dFcLZAGyfX4Kk2PgaIeVQjLWwV38eTMkUPzDOCqkWwzNIwSrE3KaMNUTZ614my3QSiUOZ9DBzB7ZhLvXNMJRsYJ6iPyr1oEjt3KJhc9ghzaCjEtLWQplYONVPcYkLyrKAN6irRabbQKZAVWs0+wKKfIUjFfYM6PFlaAyE1H5Ak8umkWfrvc0N+z++WZGs38def5rdoLv5voOsDWcMprfSwZGMPakCmt31c3YTztOh5d/SA055UhMmRzbwny95yUl92ZiBoU//2zSaATBrE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(366004)(396003)(346002)(39860400002)(376002)(136003)(1800799006)(186006)(451199021)(6666004)(83380400001)(66574015)(2906002)(38100700002)(66946007)(4326008)(44832011)(7416002)(8936002)(7406005)(8676002)(6916009)(5660300002)(66556008)(66476007)(478600001)(86362001)(33716001)(6512007)(9686003)(26005)(6486002)(316002)(966005)(54906003)(41300700001)(1076003)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?Y+NrEOW2VzWLgI8BWCl+zs9uZ6MbFhWSAp+ZInMnOZ1VUuIdtcuQk7kZtW?=
 =?iso-8859-1?Q?QZLK4QgLZE9PpvzmN9pJVUi6fYRx/ExhyujXfltAJb5GvhGtsUlVLB3zBT?=
 =?iso-8859-1?Q?h1W6TUQUjllP2MsmM+WEY1qU0Yrf3lLSz11daUvBjoEcupXpeLZeZs95HA?=
 =?iso-8859-1?Q?cFcAid8AnSQdPUZro4FDkvYs4+FBaVXgTJ+7rFmDz2LtTjg3lWeCzRqnE7?=
 =?iso-8859-1?Q?8mSEtfE253AcOp3UnET1mmxufnjCBGuQm5tsT01sC1iezmwG7SD4hJCxMq?=
 =?iso-8859-1?Q?qOMW+BAY62vwhe0lHYE9m6/1/MSOoiw5pEQccyZ1l03MEFPtIcL5fLh5Vs?=
 =?iso-8859-1?Q?slH3TmyOueoUOflwLIwdCoJZwIZXm2R4LnM74jsvq5xeTWKJvFk7JLKqmE?=
 =?iso-8859-1?Q?yWYvUhJ5MMkjzN1IisXFzcLO+/mEjoZlHStHwkL6J79eJEvGkqDiFwmsRd?=
 =?iso-8859-1?Q?jiVX6p+fa9kD3JUILKHNg4kwR9OvUzwJnqNBtBLxskZN63raFGSgIkr5hg?=
 =?iso-8859-1?Q?XbEBlpBXUsIS/uIEA1sgN/H58DU7WvFZDf9aaF0afQfeAWiTWT19UqlI3E?=
 =?iso-8859-1?Q?J7JL683UebvE3vvTauNMx74HWAzG5QlsKiHMhHKFFZx5SgUxYFAGVeWHbQ?=
 =?iso-8859-1?Q?+Zbtote2qMNpqYyqIfuCugruWngoS5ZqoXSumMjASVk4ab71Tb0Hn0/Uxb?=
 =?iso-8859-1?Q?f0/JZZZ292BZl3nUxsmzkxE3qXZCDlBzegnXPT0vSdDx8Qooz3gW1tDxyU?=
 =?iso-8859-1?Q?4omjudlpM9QYkaS9vX+QlgfKtdJ8BEjozxwQXG3Y9mlACaB3tiXpUx/E1d?=
 =?iso-8859-1?Q?/GcrPYAwyLASRtEPVs8TT6+BP0UQUKskKrqBc8zKfUHoUTVwKvczpxCaJZ?=
 =?iso-8859-1?Q?YfCxSGUeSvtMNq3tbjFe2ltrTjey6mRzp+jQoVhRnMuRJqgcdTCLrf9GV6?=
 =?iso-8859-1?Q?L8QP/p76W1cUl24ybDFZU+stfVTxCvn0pJ0RkXRonAxDgD4z7OOidYO2Aw?=
 =?iso-8859-1?Q?7FDZbFZf8BfTn5DEW23j7MuYHZIEr7bxTjwH290/OJbYiPwCaW8lcp2AEk?=
 =?iso-8859-1?Q?cUHdYMPlQtffFVv0DpsjaacvMgO+YwZZAzH3JzybzIjAhjxPFBdKQLmPyx?=
 =?iso-8859-1?Q?QBnDHcj6gqPCUjsphwn5ToxLLq4qUM0rUrHRiJDLpoT9GMBn2MNjOxcB46?=
 =?iso-8859-1?Q?THVOqIZ9DnbDbZH/ONRjEgCDkuqo0OtPpmVjo+ZC2cwGQlPg0KTpdRub8G?=
 =?iso-8859-1?Q?skkVHRe2O71riv0dz3WWdaQ1NCTTFTj9CdROlVVIjc8g0LKIm9O+uqQFC4?=
 =?iso-8859-1?Q?a4fJTi3MY8ih13pkublUR02zlYX/2/gA57e4UMtdxLgnsiW3WyJ1RZRob2?=
 =?iso-8859-1?Q?xFd3+bRX2XE7RWPpTxu+cVSIv7NNMW1dcH68PbBFqEPzezhvyQsL+oz6Gx?=
 =?iso-8859-1?Q?Rdm/MTTeRLTZb0zl/RAnr9afZjX0koK4rt3h1UDDsSnROttAVYIZmRZ4O+?=
 =?iso-8859-1?Q?etVsQPFuWOK2bENewgB4sIau0vSYBK/kAABakXKw+zJkwIQAydkHemy37C?=
 =?iso-8859-1?Q?d5Y/mZW/ebNp/98ho2tJV5bfWTbdkwIYMEKa4DspbTvLmtJt2ZrdGDOVI9?=
 =?iso-8859-1?Q?wNuIxzjG+xDJrGL8h6kMBobQWzujfzX1elTlIW1rgSROjSDn5TBKQcEg?=
 =?iso-8859-1?Q?=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de48ae2d-4260-46e6-cb58-08db98e0b51f
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 13:58:28.3924
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m/mCLhE0ZKnuAWJ8y+aR1HlazOlmvEUAUGvo8Zkmq+y8Pc/VJ/D4ax2O09hSomIYteqA53HCPusM4E0VxGbMEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9709
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Uwe,

(I hope the threading won't be broken)

On Fri, Aug 04, 2023 at 09:17:57AM +0200, Uwe Kleine-König wrote:
> Most PHYs signal WoL using an interrupt. So disabling interrupts breaks
> WoL at least on PHYs covered by the marvell driver. So skip disabling
> irqs on shutdown if WoL is enabled.
> 
> While at it also explain the motivation that irqs are disabled at all.
> 
> Fixes: e2f016cf7751 ("net: phy: add a shutdown procedure")
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
> Hello,
> 
> while I'm not sure that disabling interrupts is a good idea in general,
> this change at least should fix the WoL case. Note that this change is
> only compile tested as next doesn't boot on my test machine (because of
> https://git.kernel.org/linus/b3574f579ece24439c90e9a179742c61205fbcfa)
> and 6.1 (which is the other kernel I have running) doesn't know about
> .wol_enabled. I don't want to delay this fix until I bisected this new
> issue.
> 
> Assuming this patch is eligible for backporting to stable, maybe point
> out that it depends on v6.5-rc1~163^2~286^2~2 ("net: phy: Allow drivers
> to always call into ->suspend()"). Didn't try to backport that.
> 
> Best regards
> Uwe
> 
>  drivers/net/phy/phy_device.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
> index 61921d4dbb13..6d1526bdd1d7 100644
> --- a/drivers/net/phy/phy_device.c
> +++ b/drivers/net/phy/phy_device.c
> @@ -3340,6 +3340,15 @@ static void phy_shutdown(struct device *dev)
>  	if (phydev->state == PHY_READY || !phydev->attached_dev)
>  		return;
>  
> +	/* Most phys signal WoL via the irq line. So for these irqs shouldn't be
> +	 * disabled.
> +	 */
> +	if (phydev->wol_enabled)
> +		return;
> +
> +	/* On shutdown disable irqs to prevent an irq storm on systems where the
> +	 * irq line is shared by several devices.
> +	 */
>  	phy_disable_interrupts(phydev);
>  }
>  
> -- 
> 2.40.1
> 
> 

I think the idea is not bad and something along these lines might be the
way to go, but I don't think it works (as currently implemented, and
tested by me, prints below).

Upon a quick search, phydev->wol_enabled is only set from phy_suspend(),
and phy_suspend() isn't invoked from the ethnl_set_wol() call stack.

Confirmed this way:

$ ethtool -s end0 wol g # &enet0 in the device tree
$ reboot -f
Rebooting.
[  288.682444] Qualcomm Atheros AR8031/AR8033 mdio@2d24000:02: phy_shutdown: wol_enabled 0
[  288.690935] Qualcomm Atheros AR8031/AR8033 mdio@2d24000:01: phy_shutdown: wol_enabled 0
[  288.736145] reboot: Restarting system

This is on the arch/arm/boot/dts/nxp/ls/ls1021a-tsn.dts, the same board
as the one which Ioana worked on (with the shared AR8031 PHY interrupts).

Sure, it needs to be mentioned that WoL + shared PHY interrupts is not
by any means an impossible combination, but it still won't work reliably.
I guess that's ok temporarily, since WoL requires user opt-in, so in the
default configuration, the LS1021A-TSN is not broken by this change (in
its functional variant).

pw-bot: cr
