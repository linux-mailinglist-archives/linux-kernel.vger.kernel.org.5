Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC0B7AFF37
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 11:00:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbjI0JAB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 05:00:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjI0I76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 04:59:58 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2072.outbound.protection.outlook.com [40.107.7.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B18FA3;
        Wed, 27 Sep 2023 01:59:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IXGdFJhT510WQstqp0ayTZklLqA2jIVhidsi2CfqYh6w+U9ATubZitaZ4Hn2mY/h/jtTqULrnCYP2O+VmOM+KEDYLZjO+4Ip7aUg5Y94sskIeI6BIpNuL4m0inN9MK/EWFzKZEOrbPxJEyPYD052H1VJR6iVmnPJw43wsMXLzqGzeqJrX9lU8zDxzD5PDUmo4GdUA3UCqqMBpvUnsMBiT8deM2v+Ki9WkzPYciKHAE7WlFthvpzen8eDm/5vRvPLO0ebW7DgDm1gWmcMhqHAwGmCuwqT+4FxHg5Nh1q4gu9OaNdCGJ9ZLNpvuWDlOTg9kPsMNBOqXCubNo3WCRkLRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cbuq9RUWAez6mAm3mGHCXw7dQBrXQHvvLju20ROXRII=;
 b=JfTCnXhS7lKamDU8k1oFssDxlfnhEZ0Zgz5kcsb3swQqp2xsY+xHZ2GgdxQ07ZeMdXpVcJszK0Ko2zGxCBZBtyiDV8Is3KIGIswASqKg49iTPo3vU+oTPb12VLDxH+tcWB6Km2+hnW+KbS7TXR8ZUGvQ27iOQ/dgbAXtYLP3TDHa1kinZeIx3Jea9kwK5om6Y/AqDcJCJ/KV52cZxi7aGoKqSCgXF7VtPV9zsBaSb5eCk00236DtauClSWsjqbbcB/x2LIjPerLdanr+FrpctH9cw71YJa8yCVHEibROhZFQ9fuqLPBpV4Rnfy3gpgpl3sg3cV1YduYHSYJiZ/PEWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cbuq9RUWAez6mAm3mGHCXw7dQBrXQHvvLju20ROXRII=;
 b=mUFiC3kljYvJ3YjhWWt6+kqgxRwDKuAnRl7xlZK2+ftvF/EjlNIL+tAHX3k2Mjif+k872gndC5D1OCYIeDYwOj+326/mc5ewZnk5fnRGI0X5CitLHsgwXxQI6+TjXQU2rGoAx0Ar+dTpupjk432bNcZ1CIny2UMH/AGjnCXUSTg=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU2PR04MB8774.eurprd04.prod.outlook.com (2603:10a6:10:2e1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Wed, 27 Sep
 2023 08:59:53 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b%3]) with mapi id 15.20.6813.027; Wed, 27 Sep 2023
 08:59:53 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Marco Felsch <m.felsch@pengutronix.de>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Stefan Agner <stefan@agner.ch>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v4 4/7] gpio: vf610: add i.MX8ULP of_device_id entry
Thread-Topic: [PATCH v4 4/7] gpio: vf610: add i.MX8ULP of_device_id entry
Thread-Index: AQHZ8CmaIb7VZ5j/DE6lTgvXEo0zCrAtS+gAgAEVQoA=
Date:   Wed, 27 Sep 2023 08:59:52 +0000
Message-ID: <DU0PR04MB941726FE372D56D5DA676F9188C2A@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20230926-vf610-gpio-v4-0-b57b7f6e8368@nxp.com>
 <20230926-vf610-gpio-v4-4-b57b7f6e8368@nxp.com>
 <20230926162552.dzyrsrmtjoysrhgg@pengutronix.de>
In-Reply-To: <20230926162552.dzyrsrmtjoysrhgg@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|DU2PR04MB8774:EE_
x-ms-office365-filtering-correlation-id: 005357cb-c086-4552-7b92-08dbbf381d13
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Rs2HA9xAwDa8o07TbkSTSBkTanhsj3NXuPDy1NT5qX5U5pcjiALssxAcWsYT0MPHBajry0ReQa93Qi8+g7Yba5HqrMh2E0XKEqDP/lTjazXugxYC2En5TqSP7vCeMPQttMLMKM7IvHpqtutiijF+KKXBQf5cwdln1e+EJq5yF8zytcXGC6NVLb8hZ9mP9CQUVLsyM63io2y4CsgJ36SrjYaWWihAZwKbXVmvII4obaEtb3m18idTGlOpvRSpwJwE9YBVb3mw6oAk1xwis6DKx3eXG3CGCH1uu1f8xIYjGumya5F6PFgER8uCPgcTMOIJvzlZTe5gZtlubuFuCykzqtkDksv8cZzcM/ReJnnXDBQh0fIJapDZRx0Ruuyi3tSrVlRrjOfPmMXcJ0PchpzyHKvS+evZ7aezmnw/GS9o7cV5+/YX0ngmDd7U9ZTF1bdg0W/m3IoXA6kx6D0JyGoMytWqwYL5O1uCgdgm23HcVkfeSpNA/wBlsJtdzTRFyEtwvIPBC3TIIf2FUkXM2V6UNBhljkLcWoX3oVrZIS0Zb4Dw4xuaIGkJXLthzdhSMMn0C5UIT6zu86UiJPUUKFp/xOnGtv5cq2TP58YBdD/4Pm3+UeQHtIBgKEQfcW7QpFOw
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(39860400002)(366004)(396003)(136003)(230922051799003)(186009)(1800799009)(451199024)(71200400001)(6506007)(26005)(66556008)(66476007)(9686003)(33656002)(86362001)(66446008)(7696005)(64756008)(110136005)(38070700005)(478600001)(122000001)(38100700002)(2906002)(76116006)(83380400001)(54906003)(55016003)(5660300002)(316002)(8936002)(66946007)(4326008)(44832011)(41300700001)(52536014)(8676002)(7416002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PpzuIxYanwhLtIm06SINv+rq/cCmtKu5MqvmAb7M+Cpvmj2MtM3xGsWC1Akj?=
 =?us-ascii?Q?wCD7pyj6QPOS9blJv0oi/KPMEOAk+hV9m7ifUVRfE/45yDcjPGieHoIoPXeJ?=
 =?us-ascii?Q?PE6rc2lsvZoSfOAXv9RuEKu9jfyW90KBALITzRIdqJjDDyodglMyuiZBko0G?=
 =?us-ascii?Q?24Nw4UEdGSSk2Hkz9BuSvo+YlT5RmTpQWqgOw9JBOjwdPMeHQLlbM+NVPXM7?=
 =?us-ascii?Q?R0YU9CxhjKm2HfCtpX2b6cSLOnvrFEmeZjG2pcwT1J7lC4SWTr0o0UxduHVJ?=
 =?us-ascii?Q?DoIKXYSi8BWCwFytQ92+BB5cBiLtMOSCyLfHLgE3CJQieFVH8/mTxE0lN4X1?=
 =?us-ascii?Q?kNXZm9RQloupC4wEwxkD5D/bC9TUGDrccCl9vkqnvMl/HEzsmCVwbJCsXuhV?=
 =?us-ascii?Q?ZjFuIbEqx/aMTf399i8aA+hvQxVQ5LYjc8qcpJz0kRJvD6vmEDRlEQy1QH5j?=
 =?us-ascii?Q?lnNwUEYppbARgBxn2/B/fZfY1RKSs4Y/5O8rrhgEPrLVyF/W2fyrR5iXB92X?=
 =?us-ascii?Q?456jzawykfIchT+/fPdzRW3/1FgxBZJzpgnrJHX7LX1Rtj/vvIIIATOXAkqe?=
 =?us-ascii?Q?lf7JG1WJ6DRgqVvPztzRkkMExagNV8B0fO59xHx5wzoDqQAnOKHPLEgwOmro?=
 =?us-ascii?Q?Wi5fFQUi/iypR4G8Z5rH3nuSffeULzinxMDzs4MXOwNbPAiQkODHrfhBjvus?=
 =?us-ascii?Q?Le0zZ5tHjvcii8cVgWsFHo0CDLTBxhrfwGyeLMqh7XmP44WGz72G1VVMAfqm?=
 =?us-ascii?Q?LWeG711QVWVSOwTuNxtx6a6ufiNd8rwXP+faKprZiin5hnk5xmYWjuNoDHGe?=
 =?us-ascii?Q?4stoKY1SNaaKJYNexfyWPY4s4GXMl5NfPytstEOV4bblAoh0o1kINGzS4N7A?=
 =?us-ascii?Q?PneHwuIlzoMW8gTLI8IKV4fdkqFnfMoIZ8Xnub2BJdwzhalZ2TcfWAVliWu9?=
 =?us-ascii?Q?x6UuWDSLQdJSB3vSEGS/mFLXXGk6IHRa2dF/tQZ3FRgr2uxaEU8Dws/87f5V?=
 =?us-ascii?Q?NLwaumjFipcqAPeAJbhfl17/by7dpwIJ/4aGC95SaszRCv3EMdWmWTIW0KLh?=
 =?us-ascii?Q?wBKEj2+KZFRdLUtheH641HG1lZ6jeBhxsdL1CXxx02n7PJeg6OAF1UezHuPs?=
 =?us-ascii?Q?pbQZTPFfQC33fz9YGc1Da7zcH3o5dI9KWOPVpVXhQCOusZGOaeXOE+BtBKPW?=
 =?us-ascii?Q?+iNEXh9BnRr0ONOaX+skpBmzqolFB7Eztew/L7nW0E5D+xlm3tp8oCQ2VigM?=
 =?us-ascii?Q?2Shs6KHqa8m3TlZzqqlhgMFgJKfMMBI9cfojKfafUfNDq1NImPniBA2JaWXM?=
 =?us-ascii?Q?v0VYBbUJfH115VYS3FlApJqJr7geVvNO7CY4Qu+JXbm5lLUaTmRmAxy3b7M8?=
 =?us-ascii?Q?0Ghi2FuiNG+8pdPHeW0IgZ3nHjETAcf45fD8Jx+ZqxwOZPE7pIJCiWCQQlb7?=
 =?us-ascii?Q?zSqdZUVNDFRG80tlrA+fEhXlq+0G6iaRY7O6GF7aqZqVHfcoisPdk7Ryl2x6?=
 =?us-ascii?Q?FH4KM/aqI5iJj3BCk+KfeQawhh+odsCglp8CFeOGQjZZ7fcgLZrP+4RWdEth?=
 =?us-ascii?Q?eBFVHlApYPJ2yXzNKMI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 005357cb-c086-4552-7b92-08dbbf381d13
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2023 08:59:52.9490
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JEI95sfr+gQz0lUvB8EdcKPCOi5N6QPaD/JXoWvDBLrxZf8aZSb6dv94F6S2JolGz0O+NvXihham1Ax3tZmcTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8774
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [PATCH v4 4/7] gpio: vf610: add i.MX8ULP of_device_id entry
>=20
> On 23-09-26, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > i.MX8ULP/93 GPIO supports similar feature as i.MX7ULP GPIO, but
> > i.MX8ULP is actually not hardware compatible with i.MX7ULP. i.MX8ULP
> > only has one register base, not two bases. i.MX8ULP and i.MX93
> > actually has two interrupts for each gpio controller, one for
> > Trustzone non-secure world, one for secure world.
> >
> > Although the Linux Kernel driver gpio-vf610.c could work with
> > fsl,imx7ulp-gpio compatible, it is based on some tricks did in device
> > tree with some offset added to base address.
> >
> > Add a new of_device_id entry for i.MX8ULP. But to make the driver
> > could also support old bindings, check the compatible string first,
> > before check the device data.
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >  drivers/gpio/gpio-vf610.c | 40
> > ++++++++++++++++++++++++++++++++++------
> >  1 file changed, 34 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/gpio/gpio-vf610.c b/drivers/gpio/gpio-vf610.c
> > index dbc7ba0ee72c..49867d5db642 100644
> > --- a/drivers/gpio/gpio-vf610.c
> > +++ b/drivers/gpio/gpio-vf610.c
> > @@ -25,6 +25,7 @@
> >  struct fsl_gpio_soc_data {
> >  	/* SoCs has a Port Data Direction Register (PDDR) */
> >  	bool have_paddr;
> > +	bool have_dual_base;
> >  };
> >
> >  struct vf610_gpio_port {
> > @@ -60,13 +61,22 @@ struct vf610_gpio_port {
> >  #define PORT_INT_EITHER_EDGE	0xb
> >  #define PORT_INT_LOGIC_ONE	0xc
> >
> > +#define IMX8ULP_GPIO_BASE_OFF	0x40
> > +#define IMX8ULP_BASE_OFF	0x80
> > +
> >  static const struct fsl_gpio_soc_data imx_data =3D {
> >  	.have_paddr =3D true,
> > +	.have_dual_base =3D true,
> > +};
> > +
> > +static const struct fsl_gpio_soc_data imx8ulp_data =3D {
> > +	.have_paddr =3D true,
> >  };
> >
> >  static const struct of_device_id vf610_gpio_dt_ids[] =3D {
> >  	{ .compatible =3D "fsl,vf610-gpio",	.data =3D NULL, },
> >  	{ .compatible =3D "fsl,imx7ulp-gpio",	.data =3D &imx_data, },
> > +	{ .compatible =3D "fsl,imx8ulp-gpio",	.data =3D &imx8ulp_data, },
> >  	{ /* sentinel */ }
> >  };
> >
> > @@ -263,19 +273,37 @@ static int vf610_gpio_probe(struct
> platform_device *pdev)
> >  	struct gpio_irq_chip *girq;
> >  	int i;
> >  	int ret;
> > +	bool dual_base =3D false;
> >
> >  	port =3D devm_kzalloc(dev, sizeof(*port), GFP_KERNEL);
> >  	if (!port)
> >  		return -ENOMEM;
> >
> >  	port->sdata =3D of_device_get_match_data(dev);
> > -	port->base =3D devm_platform_ioremap_resource(pdev, 0);
> > -	if (IS_ERR(port->base))
> > -		return PTR_ERR(port->base);
> >
> > -	port->gpio_base =3D devm_platform_ioremap_resource(pdev, 1);
> > -	if (IS_ERR(port->gpio_base))
> > -		return PTR_ERR(port->gpio_base);
> > +	/* support old compatible strings */
> > +	if (device_is_compatible(dev, "fsl,imx7ulp-gpio") &&
> > +	    (device_is_compatible(dev, "fsl,imx93-gpio") ||
> > +	    (device_is_compatible(dev, "fsl,imx8ulp-gpio"))))
> > +		dual_base =3D true;
>=20
> Could be simplified even further, if we would add the have_dual_base for =
the
> vf610 as well within this patch.

ok, need move part of patch 5 into patch 4, Then patch 5 just drop the
port->sdata check.

Will wait a few days before post V5 in case people has comments on
other parts.

Thanks,
Peng.

>=20
> 	dual_base =3D port->sdata->have_dual_base;
>=20
> 	/* support old bindings */
> 	if (device_is_compatible(dev, "fsl,imx7ulp-gpio") &&
> 	    (device_is_compatible(dev, "fsl,imx93-gpio") ||
> 	    (device_is_compatible(dev, "fsl,imx8ulp-gpio"))))
> 		dual_base =3D true;
>=20
> 	if (dual_base) {
> 		...
>=20
> Regards,
>   Marco
>=20
> > +	if ((port->sdata && port->sdata->have_dual_base) || dual_base) {
> > +		port->base =3D devm_platform_ioremap_resource(pdev, 0);
> > +		if (IS_ERR(port->base))
> > +			return PTR_ERR(port->base);
> > +
> > +		port->gpio_base =3D devm_platform_ioremap_resource(pdev,
> 1);
> > +		if (IS_ERR(port->gpio_base))
> > +			return PTR_ERR(port->gpio_base);
> > +	} else {
> > +		port->base =3D devm_platform_ioremap_resource(pdev, 0);
> > +		if (IS_ERR(port->base))
> > +			return PTR_ERR(port->base);
> > +
> > +		port->gpio_base =3D port->base + IMX8ULP_GPIO_BASE_OFF;
> > +		port->base =3D port->base + IMX8ULP_BASE_OFF;
> > +	}
> > +
> >
> >  	port->irq =3D platform_get_irq(pdev, 0);
> >  	if (port->irq < 0)
> >
> > --
> > 2.37.1
> >
> >
