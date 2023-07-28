Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B224766FF8
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 16:59:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237254AbjG1O7T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 10:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234076AbjG1O7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 10:59:18 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2057.outbound.protection.outlook.com [40.107.15.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D38471FFF;
        Fri, 28 Jul 2023 07:59:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LR3KqjLI/V4b+2FwBpV71Lnmgf2llMq0hfPun3yGR1TjHSCxWacfFNew61MK/5Zb2Hhmm9W5qrcNhnTiOSCmsuDFwzE20v6jPLu5fq1g9PcPh6zzyxjCVb1k2shg1mjfl+iIkIGravT5Pk75ive367b2Su5q47gBwzQLittp3J0GZmwsZ/1LCX20lpXOXXPNU/lfgQ7bSr8DrfpuUsQMucOl47yUFV/vnK7KzK3KEel7ehJLCOKk9DiB1Y06Jzvxdv4D74bXuqwL+B61h2jTX9vX2GF6nDR4AMoEk/pk3Dcx4indfH82pqABKERwfY5i9eLK0Hzcvu5S56zOCAq8bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L9AX3gkDR9jHsoAvGD1bD1GN706QqyTP+S+LVtDDp2I=;
 b=j8gT+i6+JhAtqhx5cBMT5TNcGexlD/vNzsVqPmYzrRhN1NnIjHmR18byvaXiHm20aO0nYxwyIiNdF7FbeUBjol315LjyDBptGvKOzb4NYNjGJVj+5hRqJY+gBm/4Y7fNppzYq0Vto7DsDXD8UQuGbd2MXsaRkEDkebSe2PgAs/rgzF/4M9NWufzMq9aaI5CR70Uu7ZmOdoEc+AQqXRr6lVpi/DEf6Q/ZLGDb+hMY308a38wkvFe+q5X7zkXHBirXg15FpM9u5mz+WM4XALWhM36WmLj9s4USRJEg6mCB+4iaZBeTU/jgwR/DMD6ho72bxrYHpDdyMnkxkPhJ28o+rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L9AX3gkDR9jHsoAvGD1bD1GN706QqyTP+S+LVtDDp2I=;
 b=XK+vvzuv7djQEo/G7B1XlMIQ5jwPTTn9L85SUl69yJlt1xacrMPXUl6wHuQbGUOXVDKcEBF8qQGSwSjSvgbnh7GyBa1snutfTc9GSlcK2jb9tX7yp0TyjRYy4flZO1SnzKGd64twactt5B2QD/7oDOAE7EM4uTAp4b5Ym6fO0DU=
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com (2603:10a6:102:231::11)
 by PAXPR04MB9074.eurprd04.prod.outlook.com (2603:10a6:102:227::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 14:59:10 +0000
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::d4ee:8daa:92f4:9671]) by PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::d4ee:8daa:92f4:9671%3]) with mapi id 15.20.6631.026; Fri, 28 Jul 2023
 14:59:10 +0000
From:   Shenwei Wang <shenwei.wang@nxp.com>
To:     Andrew Halaney <ahalaney@redhat.com>
CC:     Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Vinod Koul <vkoul@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Simon Horman <simon.horman@corigine.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Wong Vee Khee <veekhee@apple.com>,
        Revanth Kumar Uppala <ruppala@nvidia.com>,
        Jochen Henneberg <jh@henneberg-systemdesign.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-amlogic@lists.infradead.org" 
        <linux-amlogic@lists.infradead.org>,
        "imx@lists.linux.dev" <imx@lists.linux.dev>,
        Frank Li <frank.li@nxp.com>
Subject: RE: [EXT] Re: [PATCH v2 net 2/2] net: stmmac: dwmac-imx: pause the
 TXC clock in fixed-link
Thread-Topic: [EXT] Re: [PATCH v2 net 2/2] net: stmmac: dwmac-imx: pause the
 TXC clock in fixed-link
Thread-Index: AQHZwJ6ZmPtrsmRv9UGenRTta+C4Xq/N8VmAgAFS/EA=
Date:   Fri, 28 Jul 2023 14:59:09 +0000
Message-ID: <PAXPR04MB9185ED93B2165AC1E6B84DCC8906A@PAXPR04MB9185.eurprd04.prod.outlook.com>
References: <20230727152503.2199550-1-shenwei.wang@nxp.com>
 <20230727152503.2199550-3-shenwei.wang@nxp.com>
 <4govb566nypifbtqp5lcbsjhvoyble5luww3onaa2liinboguf@4kgihys6vhrg>
In-Reply-To: <4govb566nypifbtqp5lcbsjhvoyble5luww3onaa2liinboguf@4kgihys6vhrg>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9185:EE_|PAXPR04MB9074:EE_
x-ms-office365-filtering-correlation-id: e2deb4c3-200b-4ff7-095f-08db8f7b32e5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1jE/96M5iks7qpR1sUOJo1IIQIb4WuAJCMRCNX6cr9QiuS145EfgiAwTGDBXFcd1TKwAtJWIQD2rtzXmMVc0Viw7Svn1Et1/J/Ax7Stn0eimzP9njH455WcVCsCe8UQPG1mMxQ4Kgmb7WOM9UpLvkenvvDkYWPRr0QoitP90z/VJ9p2fx7e62Cs1jjZZ9nmNZCB0GuDY7Z+OoyBbfXA4BJsdiggpHLKVAt5MmmDXWx5TWzyh29fruahzCozbLbAJpo0h1r3EDf1mJ9xra8elK6got7Iz1IJOsm0MN2v9a+FqnHtOGCg9tygF3JnMJPYc8znerDl8eWHSe1jTfp1NpxO/k/VKObjNrZGA6MgWL/6DpyAS4ITzx6MSYKkPa3FDwxmprVoE7vDJPgz6mzeZyO7y5rqu8yMXxKSb4jsv5+z6NPWXF1xfRB9Rw7mTELCexlLi5aN0leUpsuI2p1M7FYVR7Dp9cMmKtDsamAMOmcyiLAZNRP/G3J+8qEYswCHnRcxG6UBzYrvZHFgdScMhLMMsa2aPIlGbf/dgljo9aWsQuptaT2yzRg9hHI8Ma5V6pE5F30oDWEpkar5UbQ5vFhnr23/E7NvqpvGLi+wPVsXGxhcOu8q1nAIbdrVG0x3p
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9185.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(136003)(346002)(366004)(39860400002)(451199021)(71200400001)(5660300002)(7696005)(478600001)(83380400001)(53546011)(26005)(55236004)(6506007)(9686003)(38100700002)(6916009)(76116006)(66446008)(4326008)(54906003)(122000001)(64756008)(186003)(66476007)(66556008)(66946007)(52536014)(7406005)(7416002)(86362001)(8676002)(8936002)(38070700005)(2906002)(41300700001)(44832011)(316002)(55016003)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bZn/+UkOgdKFFMd6MPi0IoJe6tgQZ+h5CtLBqeydMG5Woa/XeqkbpDbZd9zd?=
 =?us-ascii?Q?XVtmIC/uACq3VpSYtdOApJRSW6e+fqYQBM6zSNh1jR0X1rG8EWGWcpIcm8To?=
 =?us-ascii?Q?8zdRAJS3231sAb1eZY5yZ/QFeq6xSR1V+QRpyqP5yOliYiNMF+aZmJsMLp3b?=
 =?us-ascii?Q?XXpxxZVpwSCVvWgkeda/SN704NAhfZtiQ307mfPDhCHLz8UR3mRyFGkW2jUc?=
 =?us-ascii?Q?S95OW1PhQmdGSDGDvDn2jm4AW8inMzzhP9MDw/L27d3CqJld7JVAGK5s5ltu?=
 =?us-ascii?Q?MiAagH8SyDnC7zT4Pg/kp3zoXswUNL9S0C+YfX2PAKTl7rIOJOZKMZYMPKwP?=
 =?us-ascii?Q?ZDf/Xcs4/2QFYKBwl8QblYcgfCdXA0ivjca2CL9plJnzmthVe94NumtNpJfX?=
 =?us-ascii?Q?X2YW/xetD6prr2j2pUERAWfsDBVZIvCdZF2QiJToIVzl0uqydzKYQG+x0NoL?=
 =?us-ascii?Q?VXKaTixgYHF32MgnJz+EvvjLYv7gAVlbqcZuLqzAhlb2ZplTsR9fISiizl+Y?=
 =?us-ascii?Q?d37Fw+yhE/RQC8StosoR1JFNnQKJ0Um0sNxQMX09xdTW00CpJgIyd4ybcVHO?=
 =?us-ascii?Q?Xau3+8Zxo3EQ3HjAZeBLCYqKk7ILIsqhAHJLVYK3OeOnvUdsRCs788d11b9x?=
 =?us-ascii?Q?fXj2+YPKaAeKmE/TK+R7yFQHTLKTiHWrOA3xZjnD0HECsExsvIqxHTYLegLB?=
 =?us-ascii?Q?ysPANVXIWtla9p5SPmKmV0RYhwlvyWJ8bg2s1z28Af8brS+qMIeh2NsqmyKf?=
 =?us-ascii?Q?xxZc9pvXaDeZdTDnM4TpvKfF/BOTmn3wjkBhYuChb0RfsjrAULnjzwAx9Dfs?=
 =?us-ascii?Q?AqhxvvhnQdfjuIQEaOw5rYTDJl5h+di3l5gaSN53Osl01tWKhlIy3llyVDaB?=
 =?us-ascii?Q?BEarbBSuFmAKyqgJ99pb51VQd0iq/ZMFUPmK8EwWx0JtzVZRPukF+DDwi7Y/?=
 =?us-ascii?Q?jBEax6eYF1Orvu10OPaG0SbQnm1RRBSwqoeMVj8mKWoic1FEH3tB/HhjUso5?=
 =?us-ascii?Q?bTs+CfVQgHosIM1bzfFYZedapgBK6l2gUMdBJqMBxVjrNR+pwzSMqzYSgP0g?=
 =?us-ascii?Q?6Sbh0Ic/1zkw3VSRgea1C1gfRj3BXkULd1R344H6AoXegPWutU0wuzyxlaWJ?=
 =?us-ascii?Q?ADOgQnMLhBJRA4no4AOLu3LQrx1aF+kW2VWSPqKInSJnT2SdOF4cHQSTSOhm?=
 =?us-ascii?Q?VgrixhGIB3AgyPyVgkQSqVP5eTAMqf8cl9Z9CwuSTZVcM1j4ELZqwBYlrcSW?=
 =?us-ascii?Q?d95jyo44Pb9zlxdYGlBOCvDuCjd/gFJchSF+QtnbxrEgcjFWX7VKo7hTbzS3?=
 =?us-ascii?Q?EuLPJ8VldI8akZsZ5g5YCAKqPuGuI6zVOmwx0snc83vB2gNZN4NAMWFoy8pP?=
 =?us-ascii?Q?kCm3bSFzsH4GzOYjoTwpO8ep/DbmXeb7UwIgaGRy6QU3oxv4YBnR6oxGJD3i?=
 =?us-ascii?Q?hdybZZ61HXJe3c4wYnAiolfoMhfEvaxRYTCNj8DTDulxBoj7Xgzn5TL+FkYb?=
 =?us-ascii?Q?oUQTVk5cA8G/JCVs88i2kHItCjJ9VuHfIsZZMu8Xn2XBvgfGaWbL7+UJvFgw?=
 =?us-ascii?Q?wQmavR4uP5SuM99nyXyxfafSo3r9WEUOtBRgknl8?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9185.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2deb4c3-200b-4ff7-095f-08db8f7b32e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2023 14:59:10.0060
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KNCwNL5XbNWQU74LTtBYpdMuekU7IiVMGE2lMPTMYCDajlTuXQ6DccAl3M6YJ0z8hOY53kY1K1Pe8FA7sWhzLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9074
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Andrew Halaney <ahalaney@redhat.com>
> Sent: Thursday, July 27, 2023 1:37 PM
> To: Shenwei Wang <shenwei.wang@nxp.com>
> Cc: Russell King <linux@armlinux.org.uk>; David S. Miller
> <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>; Jakub
> Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>; Maxime
> Coquelin <mcoquelin.stm32@gmail.com>; Shawn Guo <shawnguo@kernel.org>;
> Sascha Hauer <s.hauer@pengutronix.de>; Neil Armstrong
> <neil.armstrong@linaro.org>; Kevin Hilman <khilman@baylibre.com>; Vinod
> Koul <vkoul@kernel.org>; Chen-Yu Tsai <wens@csie.org>; Jernej Skrabec
> > required silent interval on the clock line for SJA1105 to complete the
> > frequency transition and enable the internal TDLs.
> >
> > So far we have only enabled this feature on the i.MX93 platform.
> >
>=20
> I'd just like to highlight that because of a quirk (I think this is not
> standard) in the particular connected switch on a board you're making the=
 whole
> "fsl,imx93" platform (compatible) implement said switch quirk.
>=20
> If you don't think there's any harm in doing that for other fixed-link sc=
enarios,
> that's fine I suppose... but just highlighting that.
>=20
> I have no idea at a higher level how else you'd tackle this. You could ad=
d a dt
> property for this, but I also don't love that you'd probably encode it in=
 the MAC
> (maybe in the fixed-link description it would be more attractive). At lea=
st as a dt
> property it isn't unconditional.
>=20

This change won't impact the function of any normal cases, introducing a dt=
 property
is not necessary IMO.

> > Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>
> > Reviewed-by: Frank Li <frank.li@nxp.com>
> > ---
> >  .../net/ethernet/stmicro/stmmac/dwmac-imx.c   | 45 +++++++++++++++++++
> >  1 file changed, 45 insertions(+)
> >
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
> > b/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
> > index 53ee5a42c071..e7819960128e 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
> > @@ -40,6 +40,9 @@
> >  #define DMA_BUS_MODE                 0x00001000
> >  #define DMA_BUS_MODE_SFT_RESET               (0x1 << 0)
> >  #define RMII_RESET_SPEED             (0x3 << 14)
> > +#define MII_RESET_SPEED                      (0x2 << 14)
> > +#define RGMII_RESET_SPEED            (0x0 << 14)
> > +#define CTRL_SPEED_MASK                      (0x3 << 14)
>=20
> GENMASK() would be cleaner, as well as BIT() usage, but I do see the driv=
er
> currently does shifts.. so /me shrugs
>=20

Okay.

> >
> >  struct imx_dwmac_ops {
> >       u32 addr_width;
> > @@ -56,6 +59,7 @@ struct imx_priv_data {
> >       struct regmap *intf_regmap;
> >       u32 intf_reg_off;
> >       bool rmii_refclk_ext;
> > +     void __iomem *base_addr;
> >
> >       const struct imx_dwmac_ops *ops;
> >       struct plat_stmmacenet_data *plat_dat; @@ -212,6 +216,44 @@
> > static void imx_dwmac_fix_speed(void *priv, uint speed, uint mode)
> >               dev_err(dwmac->dev, "failed to set tx rate %lu\n",
> > rate);  }
> >
> > +static void imx_dwmac_fix_speed_mx93(void *priv, uint speed, uint
> > +mode) {
> > +     struct imx_priv_data *dwmac =3D priv;
> > +     int ctrl, old_ctrl, iface;
> > +
> > +     imx_dwmac_fix_speed(priv, speed, mode);
> > +
> > +     if (!dwmac || mode !=3D MLO_AN_FIXED)
> > +             return;
> > +
> > +     if (regmap_read(dwmac->intf_regmap, dwmac->intf_reg_off, &iface))
> > +             return;
> > +
> > +     iface &=3D MX93_GPR_ENET_QOS_INTF_MODE_MASK;
> > +     old_ctrl =3D readl(dwmac->base_addr + MAC_CTRL_REG);
> > +     ctrl =3D old_ctrl & ~CTRL_SPEED_MASK;
> > +
> > +     /* by default ctrl will be RGMII */
> > +     if (iface =3D=3D MX93_GPR_ENET_QOS_INTF_SEL_RMII)
> > +             ctrl |=3D RMII_RESET_SPEED;
> > +     if (iface =3D=3D MX93_GPR_ENET_QOS_INTF_SEL_MII)
> > +             ctrl |=3D MII_RESET_SPEED;
>=20
> I see that ctrl right now would select RGMII, but I think it would read m=
ore
> clearly if you handled it and made the above an if/else if/else statement=
 (since
> they're exclusive of eachother) vs two independent if's.
>=20

I think I did too much here. The other two cases should be removed as only=
=20
RGMII requires to add delays on the clock line.

> > +
> > +     writel(ctrl, dwmac->base_addr + MAC_CTRL_REG);
> > +
> > +     /* Ensure the settings for CTRL are applied */
> > +     wmb();
>=20
> I saw this and recently have been wondering about this sort of pattern (n=
ot an
> expert on this). From what I can tell it seems reading the register back =
is the
> preferred pattern to force the write out. The above works, but it feels t=
o me
> personally akin to how local_lock() in the kernel is a more fine grained
> mechanism than using preempt_disable(). But that's pretty opinionated. Se=
e
> device-io.rst and io_ordering.rst for how I came to that conclusion.
>=20

wmb is necessary here as we want to delay such a period after the registers=
 are
written. But the location should be moved to before the usleep_range() line=
, so
that it could avoid the scenario #2 that you pointed out below.

Thanks,
Shenwei

> > +
> > +     regmap_update_bits(dwmac->intf_regmap, dwmac->intf_reg_off,
> > +                        MX93_GPR_ENET_QOS_INTF_MODE_MASK, 0);
> > +     usleep_range(50, 100);
> > +     iface |=3D MX93_GPR_ENET_QOS_CLK_GEN_EN;
> > +     regmap_update_bits(dwmac->intf_regmap, dwmac->intf_reg_off,
> > +                        MX93_GPR_ENET_QOS_INTF_MODE_MASK, iface);
> > +
> > +     writel(old_ctrl, dwmac->base_addr + MAC_CTRL_REG); }
>=20
> I don't have any documentation for the registers here, and as you can see=
 I'm an
> amateur with respect to memory ordering based on my prior comment.
>=20
> But you:
>=20
>     1. Read intf_reg_off into variable iface
>     2. Write the RESET_SPEED for the appropriate mode to MAC_CTRL_REG
>     3. wmb() to ensure that write goes through
>     4. Read intf_reg_off (regmap_update_bits())
>     5. Write 0 to MX93_GPR_ENET_QOS_INTF_MODE_MASK within intf_reg_off
> (regmap_update_bits())
>     6. Sleep for 50-100 us
>     7. Read intf_reg_off (regmap_update_bits())
>     8. Write MX93_GPR_ENET_QOS_CLK_GEN_EN | iface (from 1) to
>        MX93_GPR_ENET_QOS_INTF_MODE_MASK within intf_reg_off
> (regmap_update_bits())
>=20
> I don't know what those bits do, but your description sounds like you are=
 trying
> to stop the clock for 50-100 us. In your code, if I understand the memory
> ordering correctly, both of the following could
> occur:
>=20
>     1. Write RESET_SPEED
>     2. Write 0 to MX93_GPR_ENET_QOS_INTF_MODE_MASK
>     3. sleep
>     4. Restore MX93_GPR_ENET_QOS_CLK_GEN_EN | iface
>=20
>     or
>=20
>     1. Write RESET_SPEED
>     2. sleep
>     3. Write 0 to MX93_GPR_ENET_QOS_INTF_MODE_MASK
>     4. Restore MX93_GPR_ENET_QOS_CLK_GEN_EN | iface
>=20
> is the latter acceptable to you, or does that wmb() (or alternative) need=
 to move?
> It seems to me only the first situation would stop the clock before sleep=
ing, but
> that's going off the names in this driver only.
>=20
> In either case, shouldn't regmap_update_bits() force a read of said bits,=
 which
> would remove the need for that wmb() altogether to synchronize the two wr=
ites?

