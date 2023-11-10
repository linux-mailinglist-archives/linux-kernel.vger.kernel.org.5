Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93E347E7FD6
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 18:59:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234640AbjKJR7y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 12:59:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235073AbjKJR7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 12:59:13 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2056.outbound.protection.outlook.com [40.107.244.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D2AA3119E;
        Fri, 10 Nov 2023 03:44:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C+5IrTJK6fSJ3vVE+Us9Iuw8bMFzB4sA2TzfUGDvUvlyPZ54gTSbhWjMnyBCcBWFd/EAtQltszSvwqLwWIAny1+iDqAqbkfWp+7yVI/VNvq1wYWy2R26AMR/iE2sbnqs4YozWGBbFD0J/yBARDCn16MfCWH2PXVun4WoHL/H+ZdtK5vCqVwI21NN1b3NLiFu9dOYmr4NlSwSy8Co90Rrgzmwx1eQWZun7pGE6EOiNqIHIP+35LHsVwI8SjGsxr5GRJk5xNAp/GpEEy5Q/1ulIJlCkOVT/2fOPxoa3zJec4QkfqN9l5bp/2bpc3KAf8bw5egPwZcZNVCOAQn6s1w/PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G0diFgRu0w60lI+JSNEfahqwRREMvJ+oWJyYEec3x8c=;
 b=TB+G1VF39sXQkOu0pTDI8Ipgt+1MWp+0ngGxjRZJrvGu+eqnzj9kyfpYbzRFBr6IZlOKjkWCVuLB0pR5Fm4VwRScI1rwPdmQ57FZq4aqwLNXHm50RouHWAT9jkcLtn/+mOffaqw6SUB7I9jqKdInVAv1WmKAaKxAOblZ7Bcd3cDKmbYQvIlOenSSGk1eN7cpPJDS+C7b/jo5PX9ibD5ZZUdJgLJqbwI0TIqF9+AhAzqbvrQLxwV4c2DxTeiYMH38Nfc9bHnaBc4IMn+lmIPGH4Jj+sWSKaxw+wQmxNJXDNUj7DlHWokdLg0GxBQPKtXcSKXLiJuviYPJ94dlVcOefw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G0diFgRu0w60lI+JSNEfahqwRREMvJ+oWJyYEec3x8c=;
 b=CnvcYVGbMsjTCSYAzpzo9jU57yeAUkkypU3Ro9N5DpZxTJ3ti9hyNcmNfZIxUNOxloGtbbl7AI47bPMAUlUaIBFjarIg6610NoZET4dkrjxRvrbHD/VPdVRqXnpwwQqYMG6YXPbX/S9vCEaZfJzoAt33+46wjf3cH49rIORQi64=
Received: from DM4PR12MB6109.namprd12.prod.outlook.com (2603:10b6:8:ae::11) by
 IA0PR12MB7752.namprd12.prod.outlook.com (2603:10b6:208:442::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Fri, 10 Nov
 2023 11:44:25 +0000
Received: from DM4PR12MB6109.namprd12.prod.outlook.com
 ([fe80::46d8:a18a:12a:5e1b]) by DM4PR12MB6109.namprd12.prod.outlook.com
 ([fe80::46d8:a18a:12a:5e1b%3]) with mapi id 15.20.6954.028; Fri, 10 Nov 2023
 11:44:25 +0000
From:   "Guntupalli, Manikanta" <manikanta.guntupalli@amd.com>
To:     "m.brock@vanmierlo.com" <m.brock@vanmierlo.com>
CC:     "git (AMD-Xilinx)" <git@amd.com>,
        "Simek, Michal" <michal.simek@amd.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>,
        "Goud, Srinivas" <srinivas.goud@amd.com>,
        "Datta, Shubhrajyoti" <shubhrajyoti.datta@amd.com>,
        "manion05gk@gmail.com" <manion05gk@gmail.com>
Subject: RE: [PATCH V3 2/2] tty: serial: uartps: Add rs485 support to uartps
 driver
Thread-Topic: [PATCH V3 2/2] tty: serial: uartps: Add rs485 support to uartps
 driver
Thread-Index: AQHaBolGgHCwhiVjV0W/LEi57CIRGLBqXyeAgAkky6A=
Date:   Fri, 10 Nov 2023 11:44:25 +0000
Message-ID: <DM4PR12MB6109BE1D6A8643DC59D7BA358CAEA@DM4PR12MB6109.namprd12.prod.outlook.com>
References: <20231024144847.2316941-1-manikanta.guntupalli@amd.com>
 <20231024144847.2316941-3-manikanta.guntupalli@amd.com>
 <22a8b01cf7a1df0dffd78eb80bfab819@vanmierlo.com>
In-Reply-To: <22a8b01cf7a1df0dffd78eb80bfab819@vanmierlo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB6109:EE_|IA0PR12MB7752:EE_
x-ms-office365-filtering-correlation-id: bd02c5b8-52d7-4aea-c640-08dbe1e263e3
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qanwKZcOgRvxaCsctI95FSCthBGmuYRK+BJaFnAQMHuJTMdjIuG3sqgJc2BF1769NGp9zz9id4JezFE2t82R5MW1KmWaEBfAR6BMmNjCH6IMnhRKoRlFvzDULHArrMitFpjn1zXVCcp5sxIWrMN207nOlcuy/hXbIZ2Mqmef09xVGUp/VCkQw1cj+dt36iY/X7BnVxGPWu9GFqY19bEPeC0VyXb8t/U82vb7DVVc1fwVtUHRMBuwK8hqEIpKMih8Z6jfBWrVbF7KlUz64O9K4tXX4zRQ1cUF5g/do7crgweNVLqUHmQSvV/6uedan7HzlWEgO6Uh6+3p+HTb1KLswWObQEhoJz6NS4S6FuXsS0b6yJkRTQEoKOZUB8HIaD8KVgXzkp1gjG52FoishP+kwfkWoBJMn/0rgDa1ggAJ1uF4XoTl+W+7/Kw9dyOkLk31jYQlBZk65RO45V06+mcxr/xrqYJ/UyIml8vZsCxeSbZnvxugUY+uoJesRLxv3hibaI1OefAxXsL2o+5YktoJe1ie6Ow3g+A2qG3CGk8xHiXbtha15niK2JKuIIRBZElQSpMM91f3FuYsSI4eVM5zcMThYpwlEyh2jFWvL6SNbiu/TTG5xPFLbuUGMtGV6XCZ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(39860400002)(346002)(366004)(396003)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(38070700009)(122000001)(55016003)(66556008)(66946007)(38100700002)(6506007)(9686003)(66446008)(64756008)(66476007)(33656002)(7696005)(53546011)(478600001)(86362001)(26005)(8676002)(71200400001)(52536014)(76116006)(83380400001)(8936002)(4001150100001)(30864003)(6916009)(7416002)(5660300002)(2906002)(316002)(54906003)(4326008)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DDf5/3ykGsBB/LQ6CB4LPXCM+aIbgFxoyB0Bd59MYQ8QT+lZnI1tmYQvRd9K?=
 =?us-ascii?Q?APOkgWMfnnEhF1yqAz+sqDAnrXTZ79DHwSBhfRV/fGek+PWvEgEy6U6R6ORj?=
 =?us-ascii?Q?rIw5Fu8Dr6HxLpQ3C3glLc0TqYxPrQ6K7Gctwpze1mNvngKl6lmNHf3Igx5x?=
 =?us-ascii?Q?nlnbWwjtLk/ANc4/yaqq7NVx/P7ZHJGxtx2bn/stT3wtRJ83sM/JLB1GJ5Mc?=
 =?us-ascii?Q?hMR2vJnzW4betWF7f413st1UFxyUSydkJIygJ/Dd09fVZBqZdsDUKhle7ZHj?=
 =?us-ascii?Q?gAURnvUcaiJHOyeAa8CUMTm5OW1lqxrHxUYEsQclHzRLMtmzKRDL6mo77qEU?=
 =?us-ascii?Q?2vPb2FnmNURh6D0/OJa41cePTHQZkVmYpjbu1Ta7/9skhRbzyq+tKh5S69hh?=
 =?us-ascii?Q?0rqlM/2GCgHMXgdI9kLCz8TQjhMvr/b2w+s8uZQwM94jplALC34DUVYzfnSg?=
 =?us-ascii?Q?3CKoLVZzVIL4g8hDRDMupjd649ye1hXMUrzWjw8EXDOWPvamS0gGTGcnvX20?=
 =?us-ascii?Q?yhM8VBXKmvZ3bb90wdg5lqiq0sJm8TiT60ER/0bLoy1ja8SlVPyyWj3A9IKr?=
 =?us-ascii?Q?2PZ/qYyV/zBEc5pPhR3Imq+ulZpnrKTKRvZY2ZVZFknNykSVKJhnNmP56YLO?=
 =?us-ascii?Q?tRVySpBs3TexSB44TSpL9sGAPfujf4bPCgrG7B75/qBBMXMM3qzKPzTeD+Dw?=
 =?us-ascii?Q?05NYRkScDuKWVcDDe2heVuVn2S2O4opJIf9FpkJnOAn8E8IdI1jUa9Fzmqwc?=
 =?us-ascii?Q?4S208S3jRcLZlIkK0s75xFb4z9VCrl2OsNVPkfXYduWTi4SbrdP5LyMLToik?=
 =?us-ascii?Q?E/dBC6Pg/6RNf8Ja6ruHiyWAxUQziOjH9TufJb0ZIGG2fXiiExrcbxksv/0o?=
 =?us-ascii?Q?xMzpeeGIXiVP6/wHG6rrruPfhCSZ02vNRsRwaN0O3Je40Xdo3MfnlNaiKkvN?=
 =?us-ascii?Q?Xk5lspt4RvnK+6CSFO/EXbKH+DRDdbCQBgTvHMZNweuebwXHNQMGhXmZFXwu?=
 =?us-ascii?Q?aGyu4JGYnoMYaQMJSoMGckKOARylwITi/KneTXdB32QgHIihUSj6l5yXrz68?=
 =?us-ascii?Q?euIH+GSOrnHubFaIjoug89YkLYR3FBV4iq8sI3L1VJr0KlBQgwLA+3AK29GK?=
 =?us-ascii?Q?syyGiKd/z4d4GzES2obW1aNEabfL9wwTl1XYhEQBt6hV84Fx+EK07IJg95jB?=
 =?us-ascii?Q?gGSr3fL6mCqWyo9O3lVyAneBc9IZBU8sWMdqrc2akibNXqMwQxQaDXt7bVfJ?=
 =?us-ascii?Q?xSlqx37H7DKmrHFlsynb7SIzqPPKqRw5FVFR080GidqqBRbtF4qBZmRkTFD8?=
 =?us-ascii?Q?J8+0Ld7xVZL78n51h4estKzbaOGa8PmW8xG8GjV24qKtj9bvDUAQqzLlW7j/?=
 =?us-ascii?Q?0JUguhCZEBdZH8MkMHrpgaOdPbC5qH/5Lt1t+b369YxEZhy3tdwY202G52zG?=
 =?us-ascii?Q?hBYRuZX/ezi8JrLOnAdryaWlMBLTgwY9wZKhBV5AetqMNChzyhKTxq4diwiS?=
 =?us-ascii?Q?sUrIk9UG1agfl5HBNS3nKIS4Mjmc1Ud/xDcxLKj9avpKLQTWH+4LuGE5A7RZ?=
 =?us-ascii?Q?FHzWPTZjwZfoZJieaPI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd02c5b8-52d7-4aea-c640-08dbe1e263e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2023 11:44:25.7354
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H3YtCo8TzhdXx3zV2THvuhFo6SJwnkXUAI1NJtH3nv66TjxWo06MmZlosYI5d2CDUdd7qbjJ3m+oywi2rMaz/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7752
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> -----Original Message-----
> From: m.brock@vanmierlo.com <m.brock@vanmierlo.com>
> Sent: Saturday, November 4, 2023 9:17 PM
> To: Guntupalli, Manikanta <manikanta.guntupalli@amd.com>
> Cc: git (AMD-Xilinx) <git@amd.com>; Simek, Michal
> <michal.simek@amd.com>; gregkh@linuxfoundation.org;
> robh+dt@kernel.org; krzysztof.kozlowski+dt@linaro.org;
> conor+dt@kernel.org; linux-serial@vger.kernel.org;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org;
> jirislaby@kernel.org; linux-arm-kernel@lists.infradead.org; Pandey, Radhe=
y
> Shyam <radhey.shyam.pandey@amd.com>; Goud, Srinivas
> <srinivas.goud@amd.com>; Datta, Shubhrajyoti
> <shubhrajyoti.datta@amd.com>; manion05gk@gmail.com
> Subject: Re: [PATCH V3 2/2] tty: serial: uartps: Add rs485 support to uar=
tps
> driver
>=20
> Manikanta Guntupalli wrote on 2023-10-24 16:48:
> > @@ -193,6 +196,7 @@ MODULE_PARM_DESC(rx_timeout, "Rx timeout, 1-
> 255");
> >   * @clk_rate_change_nb:	Notifier block for clock changes
> >   * @quirks:		Flags for RXBS support.
> >   * @cts_override:	Modem control state override
> > + * @gpiod:		Pointer to the gpio descriptor
>=20
> Change gpiod to gpiod_rts maybe?
> Later someone might want to use a gpio for cts/dtr/dsr/dcd/ri as well.
We will fix.
>=20
> >   */
> >  struct cdns_uart {
> >  	struct uart_port	*port;
> > @@ -203,10 +207,19 @@ struct cdns_uart {
> >  	struct notifier_block	clk_rate_change_nb;
> >  	u32			quirks;
> >  	bool cts_override;
> > +	struct gpio_desc	*gpiod;
> >  };
> >  struct cdns_platform_data {
> >  	u32 quirks;
> >  };
> > +
> > +struct serial_rs485 cdns_rs485_supported =3D {
> > +	.flags =3D SER_RS485_ENABLED | SER_RS485_RTS_ON_SEND |
> > +		 SER_RS485_RTS_AFTER_SEND,
> > +	.delay_rts_before_send =3D 1,
> > +	.delay_rts_after_send =3D 1,
> > +};
> > +
> >  #define to_cdns_uart(_nb) container_of(_nb, struct cdns_uart, \
> >  		clk_rate_change_nb)
> >
> > @@ -305,6 +318,79 @@ static void cdns_uart_handle_rx(void *dev_id,
> > unsigned int isrstatus)
> >  	tty_flip_buffer_push(&port->state->port);
> >  }
> >
> > +/**
> > + * cdns_rs485_config_gpio_rts_high - Configure GPIO/RTS to high
> > + * @cdns_uart: Handle to the cdns_uart  */ static void
> > +cdns_rs485_config_gpio_rts_high(struct cdns_uart
> > *cdns_uart)
> > +{
> > +	u32 val;
> > +
> > +	if (cdns_uart->gpiod) {
> > +		gpiod_set_value(cdns_uart->gpiod, 1);
> > +	} else {
> > +		val =3D readl(cdns_uart->port->membase +
> CDNS_UART_MODEMCR);
> > +		val &=3D ~CDNS_UART_MODEMCR_RTS;
> > +		writel(val, cdns_uart->port->membase +
> CDNS_UART_MODEMCR);
> > +	}
> > +}
> > +
> > +/**
> > + * cdns_rs485_config_gpio_rts_low - Configure GPIO/RTS to low
> > + * @cdns_uart: Handle to the cdns_uart  */ static void
> > +cdns_rs485_config_gpio_rts_low(struct cdns_uart
> > *cdns_uart)
> > +{
> > +	u32 val;
> > +
> > +	if (cdns_uart->gpiod) {
> > +		gpiod_set_value(cdns_uart->gpiod, 0);
> > +	} else {
> > +		val =3D readl(cdns_uart->port->membase +
> CDNS_UART_MODEMCR);
> > +		val |=3D CDNS_UART_MODEMCR_RTS;
> > +		writel(val, cdns_uart->port->membase +
> CDNS_UART_MODEMCR);
> > +	}
> > +}
> > +
> > +/**
> > + * cdns_rs485_tx_setup - Tx setup specific to rs485
> > + * @cdns_uart: Handle to the cdns_uart  */ static void
> > +cdns_rs485_tx_setup(struct cdns_uart *cdns_uart) {
> > +	if (cdns_uart->port->rs485.flags & SER_RS485_RTS_ON_SEND)
> > +		cdns_rs485_config_gpio_rts_high(cdns_uart);
> > +	else
> > +		cdns_rs485_config_gpio_rts_low(cdns_uart);
> > +}
> > +
> > +/**
> > + * cdns_rs485_rx_setup - Rx setup specific to rs485
> > + * @cdns_uart: Handle to the cdns_uart  */ static void
> > +cdns_rs485_rx_setup(struct cdns_uart *cdns_uart) {
> > +	if (cdns_uart->port->rs485.flags & SER_RS485_RTS_AFTER_SEND)
> > +		cdns_rs485_config_gpio_rts_high(cdns_uart);
> > +	else
> > +		cdns_rs485_config_gpio_rts_low(cdns_uart);
> > +}
>=20
> Why not simply create:
> void cdns_rs485_driver_enable(struct cdns_uart *cdns_uart, bool enable)
We will fix.
>=20
> And let it handle the rs485.flags itself?
We will fix.
>=20
> > +
> > +/**
> > + * cdns_uart_tx_empty -  Check whether TX is empty
> > + * @port: Handle to the uart port structure
> > + *
> > + * Return: TIOCSER_TEMT on success, 0 otherwise  */ static unsigned
> > +int cdns_uart_tx_empty(struct uart_port *port) {
> > +	unsigned int status;
> > +
> > +	status =3D readl(port->membase + CDNS_UART_SR) &
> > +		       (CDNS_UART_SR_TXEMPTY | CDNS_UART_SR_TACTIVE);
> > +	return (status =3D=3D CDNS_UART_SR_TXEMPTY) ? TIOCSER_TEMT : 0; }
> > +
> >  /**
> >   * cdns_uart_handle_tx - Handle the bytes to be Txed.
> >   * @dev_id: Id of the UART port
> > @@ -571,6 +657,8 @@ static int cdns_uart_clk_notifier_cb(struct
> > notifier_block *nb,  static void cdns_uart_start_tx(struct uart_port
> > *port)  {
> >  	unsigned int status;
> > +	unsigned long time_out;
> > +	struct cdns_uart *cdns_uart =3D port->private_data;
> >
> >  	if (uart_tx_stopped(port))
> >  		return;
> > @@ -589,8 +677,31 @@ static void cdns_uart_start_tx(struct uart_port
> > *port)
> >
> >  	writel(CDNS_UART_IXR_TXEMPTY, port->membase +
> CDNS_UART_ISR);
> > +	if (cdns_uart->port->rs485.flags & SER_RS485_ENABLED) {
> > +		cdns_rs485_tx_setup(cdns_uart);
> > +		if (cdns_uart->port->rs485.delay_rts_before_send)
> > +			mdelay(cdns_uart->port-
> >rs485.delay_rts_before_send);
>=20
> Would it not be better to start a timer here with a callback that enables=
 the
> TXEMPTY interrupt? That would automatically call cdns_uart_handle_tx().
We will fix.
>=20
> > +	}
> > +
> >  	cdns_uart_handle_tx(port);
> >
> > +	if (cdns_uart->port->rs485.flags & SER_RS485_ENABLED) {
> > +		time_out =3D jiffies + usecs_to_jiffies(TX_TIMEOUT);
> > +		/* Wait for tx completion */
> > +		while ((cdns_uart_tx_empty(cdns_uart->port) !=3D
> TIOCSER_TEMT) &&
> > +		       time_before(jiffies, time_out))
> > +			cpu_relax();
> > +
> > +		if (cdns_uart->port->rs485.delay_rts_after_send)
> > +			mdelay(cdns_uart->port-
> >rs485.delay_rts_after_send);
> > +
> > +		/*
> > +		 * Default Rx should be setup, because RX signaling path
> > +		 * need to enable to receive data.
> > +		 */
> > +		cdns_rs485_rx_setup(cdns_uart);
> > +	}
>=20
> I think this should be done from the TXEMPTY interrupt. And again schedul=
e a
> timer to drop the DE line. You really can do this without using mdelay().
We will get TXEMPTY interrupt multiple times for large data, so doing this =
from
TXEMPTY interrupt will call this logic multiple times, but this logic need =
be to called once.
>=20
> > +
> >  	/* Enable the TX Empty interrupt */
> >  	writel(CDNS_UART_IXR_TXEMPTY, port->membase +
> CDNS_UART_IER);  } @@
> > -602,6 +713,14 @@ static void cdns_uart_start_tx(struct uart_port
> > *port)
> >  static void cdns_uart_stop_tx(struct uart_port *port)  {
> >  	unsigned int regval;
> > +	struct cdns_uart *cdns_uart =3D port->private_data;
> > +
> > +	if (cdns_uart->port->rs485.flags & SER_RS485_ENABLED) {
> > +		if (cdns_uart->port->rs485.delay_rts_after_send)
> > +			mdelay(cdns_uart->port-
> >rs485.delay_rts_after_send);
> > +
> > +		cdns_rs485_rx_setup(cdns_uart);
> > +	}
>=20
> Again, start a timer and wait for completion?
We will fix.
>=20
> >  	regval =3D readl(port->membase + CDNS_UART_CR);
> >  	regval |=3D CDNS_UART_CR_TX_DIS;
> > @@ -626,21 +745,6 @@ static void cdns_uart_stop_rx(struct uart_port
> > *port)
> >  	writel(regval, port->membase + CDNS_UART_CR);
> >  }
> >
> > -/**
> > - * cdns_uart_tx_empty -  Check whether TX is empty
> > - * @port: Handle to the uart port structure
> > - *
> > - * Return: TIOCSER_TEMT on success, 0 otherwise
> > - */
> > -static unsigned int cdns_uart_tx_empty(struct uart_port *port)
> > -{
> > -	unsigned int status;
> > -
> > -	status =3D readl(port->membase + CDNS_UART_SR) &
> > -		       (CDNS_UART_SR_TXEMPTY | CDNS_UART_SR_TACTIVE);
> > -	return (status =3D=3D CDNS_UART_SR_TXEMPTY) ? TIOCSER_TEMT : 0;
> > -}
> > -
> >  /**
> >   * cdns_uart_break_ctl - Based on the input ctl we have to start or
> > stop
> >   *			transmitting char breaks
> > @@ -829,6 +933,9 @@ static int cdns_uart_startup(struct uart_port
> > *port)
> >  		(CDNS_UART_CR_TXRST | CDNS_UART_CR_RXRST))
> >  		cpu_relax();
> >
> > +	if (cdns_uart->port->rs485.flags & SER_RS485_ENABLED)
> > +		cdns_rs485_rx_setup(cdns_uart);
> > +
> >  	/*
> >  	 * Clear the RX disable bit and then set the RX enable bit to enable
> >  	 * the receiver.
> > @@ -1455,6 +1562,23 @@ MODULE_DEVICE_TABLE(of,
> cdns_uart_of_match);
> >  /* Temporary variable for storing number of instances */
> >  static int instances;
> >
> > +/**
> > + * cdns_rs485_config - Called when an application calls TIOCSRS485
> > ioctl.
> > + * @port: Pointer to the uart_port structure
> > + * @termios: Pointer to the ktermios structure
> > + * @rs485: Pointer to the serial_rs485 structure
> > + *
> > + * Return: 0
> > + */
> > +static int cdns_rs485_config(struct uart_port *port, struct ktermios
> > *termios,
> > +			     struct serial_rs485 *rs485)
> > +{
> > +	if (rs485->flags & SER_RS485_ENABLED)
> > +		dev_dbg(port->dev, "Setting UART to RS485\n");
> > +
>=20
> Shouldn't you force automatic RTS control off here?
> And also call cdns_rs485_rx_setup()
We will fix.
>=20
> > +	return 0;
> > +}
> > +
> >  /**
> >   * cdns_uart_probe - Platform driver probe
> >   * @pdev: Pointer to the platform device structure
> > @@ -1463,6 +1587,7 @@ static int instances;
> >   */
> >  static int cdns_uart_probe(struct platform_device *pdev)
> >  {
> > +	u32 val;
> >  	int rc, id, irq;
> >  	struct uart_port *port;
> >  	struct resource *res;
> > @@ -1597,9 +1722,23 @@ static int cdns_uart_probe(struct
> > platform_device *pdev)
> >  	port->private_data =3D cdns_uart_data;
> >  	port->read_status_mask =3D CDNS_UART_IXR_TXEMPTY |
> CDNS_UART_IXR_RXTRIG
> > |
> >  			CDNS_UART_IXR_OVERRUN | CDNS_UART_IXR_TOUT;
> > +	port->rs485_config =3D cdns_rs485_config;
> > +	port->rs485_supported =3D cdns_rs485_supported;
> >  	cdns_uart_data->port =3D port;
> >  	platform_set_drvdata(pdev, port);
> >
> > +	rc =3D uart_get_rs485_mode(port);
> > +	if (rc)
> > +		goto err_out_clk_notifier;
> > +
> > +	cdns_uart_data->gpiod =3D devm_gpiod_get_optional(&pdev->dev,
> "rts",
> > +							GPIOD_OUT_LOW);
> > +	if (IS_ERR(cdns_uart_data->gpiod)) {
> > +		rc =3D PTR_ERR(cdns_uart_data->gpiod);
> > +		dev_err(port->dev, "xuartps: devm_gpiod_get_optional
> failed\n");
> > +		goto err_out_clk_notifier;
> > +	}
> > +
> >  	pm_runtime_use_autosuspend(&pdev->dev);
> >  	pm_runtime_set_autosuspend_delay(&pdev->dev,
> > UART_AUTOSUSPEND_TIMEOUT);
> >  	pm_runtime_set_active(&pdev->dev);
> > @@ -1638,6 +1777,16 @@ static int cdns_uart_probe(struct
> > platform_device *pdev)
> >  	cdns_uart_data->cts_override =3D
> > of_property_read_bool(pdev->dev.of_node,
> >  							     "cts-override");
> >
> > +	if (cdns_uart_data->port->rs485.flags & SER_RS485_ENABLED) {
> > +		if (!cdns_uart_data->gpiod) {
> > +			val =3D readl(cdns_uart_data->port->membase
> > +				    + CDNS_UART_MODEMCR);
> > +			val |=3D CDNS_UART_MODEMCR_RTS;
> > +			writel(val, cdns_uart_data->port->membase
> > +			       + CDNS_UART_MODEMCR);
> > +		}
> > +	}
>=20
> Simply call cdns_rs485_rx_setup() ?
We will fix.
>=20
> > +
> >  	instances++;
> >
> >  	return 0;
> > @@ -1646,6 +1795,7 @@ static int cdns_uart_probe(struct platform_device
> > *pdev)
> >  	pm_runtime_disable(&pdev->dev);
> >  	pm_runtime_set_suspended(&pdev->dev);
> >  	pm_runtime_dont_use_autosuspend(&pdev->dev);
> > +err_out_clk_notifier:
> >  #ifdef CONFIG_COMMON_CLK
> >  	clk_notifier_unregister(cdns_uart_data->uartclk,
> >  			&cdns_uart_data->clk_rate_change_nb);
>=20
> Please also modify cdns_uart_[s|g]et_mctrl() so they support rts-gpios.
We will fix.
>=20

Thanks,
Manikanta.
