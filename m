Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7201C7CC221
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 13:59:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234734AbjJQL7p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 07:59:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233593AbjJQL7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 07:59:43 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2081.outbound.protection.outlook.com [40.107.243.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7538B0;
        Tue, 17 Oct 2023 04:59:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SFZeVaOYGAKLplkVKi9sppZndgsXYHPyzwoRs7M8VhjVBaRaqUfRIi3fivnQNBWXWc8ShJ2hukZJUU7AdvleSuvqP5UdXnu8ozW8nswZpDEYsDC0B9UoXFqQd+UyIs3VHkx1PP1KPYwYp0zdOyiugYMEihBzV/uZY4BgCnzru4J+4DEnPhIbyLfiZapf6bmY462QAR0NQZaM61GZZ7NFZIpUCOCkobt8IvQg4OTKfJeXD2rOlqz4KPhftjRcaJVX+taoA5TX4oY47wnwlduCU9cxAos/Xk/KCeZp1XZWVuA4SYKAoA+K5kZ+eo3OyppdyFTpoXw4kS8ph7+uDrfyQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ney9QkRF18Fx/CHlRJ2Y10p5QziLceS9ZY1xEpLyx48=;
 b=R9n3ZWzHEFQFN6GE5565Y18FcCzpyDa4cvuCxTTPVut5kYrUr9jC2H4GrnUCUGUpt7pBD0lPpmdtLV+Z+rlGQ0Ov7afS5d6MjQoyJ84JSj8VBjMsdd87Ir8EuEenS8F81HFwr9SRf5C7L3zY6lmN2xxkiK9fLrThjwyZbjU2+qWAzr62CqBwklDe7/2pkHm7lb49HlYxmzRee1BZLuYJLGqUM1Xih7RILugnks7nQaXXL/KM6/fIiLooE+nCDdBzaw9vhiKmqOnaJncVRSkz5uIBussYPM/3IKJ7lHSLokznVkM5arKBI9I5r5Ogw3DjOoGTUB4/r+xqsrq/uztLPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ney9QkRF18Fx/CHlRJ2Y10p5QziLceS9ZY1xEpLyx48=;
 b=F3UD0xZgSQ8XXX5fVht20+dhnouA534Cvjf3dY62O7oBYw1GH+cMMOgjt1Xttla5pdFqRCCUFjpIbK2s1aejKEURcJIECMJuLPapeddguxihK74eHyQYIiY8oaACg03mSxhS+HZnpUe0+J3b75Z8T01Lui5Bz5Q8bPKK6RuqR20=
Received: from DM4PR12MB6109.namprd12.prod.outlook.com (2603:10b6:8:ae::11) by
 PH7PR12MB7843.namprd12.prod.outlook.com (2603:10b6:510:27e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Tue, 17 Oct
 2023 11:59:36 +0000
Received: from DM4PR12MB6109.namprd12.prod.outlook.com
 ([fe80::1ef6:8869:d228:ed8a]) by DM4PR12MB6109.namprd12.prod.outlook.com
 ([fe80::1ef6:8869:d228:ed8a%5]) with mapi id 15.20.6886.034; Tue, 17 Oct 2023
 11:59:36 +0000
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
Subject: RE: [PATCH V2 2/2] tty: serial: uartps: Add rs485 support to uartps
 driver
Thread-Topic: [PATCH V2 2/2] tty: serial: uartps: Add rs485 support to uartps
 driver
Thread-Index: AQHZ/FMvzMspQGxVL0SsVkq4HFh31bBGhVoAgAdR9zA=
Date:   Tue, 17 Oct 2023 11:59:36 +0000
Message-ID: <DM4PR12MB610907F8A6306E0A9CADAB528CD6A@DM4PR12MB6109.namprd12.prod.outlook.com>
References: <20231011145602.3619616-1-manikanta.guntupalli@amd.com>
 <20231011145602.3619616-3-manikanta.guntupalli@amd.com>
 <47fcf873a011291d06740ee9af3a45e4@vanmierlo.com>
In-Reply-To: <47fcf873a011291d06740ee9af3a45e4@vanmierlo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB6109:EE_|PH7PR12MB7843:EE_
x-ms-office365-filtering-correlation-id: 5bb03e90-2626-4b1e-3390-08dbcf0888b2
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GvqNErJwukor2ljEngriWJENhLEWeoYYFQHPcI4ejPiLp8m3eQaMal36y0IhWdKOzHiXTy5mDdjgAbhSPGjlMD0/xMCfYAji4s0S08cRsSdIFhdMgTir+y6x7W0rPsL5iq+ROyxAgyittlYjFuE9qYD5/gJj+Vf0pa0JyZGJHPmlzq3b4eFZNMbE6y1w+bKikiVpPj/QBnV839vbdy/f43//Oq/36Y1Ec/rxtbLSGb2rk6rwn8QgG/adShsWqacrHPcsPGyTxCTVBXC0PeGGmC6WzDoFuHRpmn3ETqNAOVn2cCwIltiH3p0hdYdBoPcDLBQhDGe9ooKfhAIRrCb3iRhbIiPsj5aQMeP+rlzQfx0MXtjzeKmRp6RudvtMjZtQsNijVwQ8Ui2xwuzGIYCcjzFv+W0xF76/rYShTwQxenlYrWbJ5MpqXbfsiSdprvSiCmq2De3mkWSXgtm8rtN1ATgQ5BYsi+I87nZCNexuOaq/OMMs2pBD2hqyVWEZ+UZ/4nywwvo+bKYzEF89JyJev+MPE44RmT7zm8HY7xo5QOep4eOuIsyrsubd+T/Mw3qpSlw9KNZYRpzb/vctTFbhSUt/SyOXfXrOOjY6TsByloQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(346002)(136003)(376002)(39860400002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(55016003)(66946007)(966005)(64756008)(478600001)(76116006)(66556008)(71200400001)(66446008)(66476007)(6916009)(54906003)(316002)(83380400001)(86362001)(7696005)(38100700002)(26005)(53546011)(6506007)(33656002)(122000001)(41300700001)(38070700005)(5660300002)(8936002)(8676002)(4326008)(2906002)(9686003)(4001150100001)(52536014)(7416002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wVSfXgPMY/CKkpxCIplAC3a4c2Qz2R+sWjHwZ7JKSqRbNDoznkEuh//QRLkb?=
 =?us-ascii?Q?duRDTGBhgZFCzmLyyj6kjU83iVsAAmz+lvfcw7vlwrxsMFoItdMKjGr0yv4w?=
 =?us-ascii?Q?HyZJSpj0T2O9M78bYz1mv867OCq6ERbQOtEvr6NBZZwulttDU/FKDVSy4IIG?=
 =?us-ascii?Q?F3LLPllN3L/Vp6cw6+kU+3phZdWmLG0ZyIjmakCNOAsfIrJG5QH9fk9KXTYo?=
 =?us-ascii?Q?EE9ny6SAekB/oYeMuFfevdQY+H4jh1xcwulo71IoGIzqN70GtxUkbpNRpUnG?=
 =?us-ascii?Q?4twJJhchTFRMdMKyjiGDT2/eBdcMSOux4O+bllGYxP3sEHQSpZOO0Z0bKMbH?=
 =?us-ascii?Q?N0qFscg+XiUBcJZA+262QYS9CRpASqyZqDMEIbMmW6xs6g53Oog0GVCZtByS?=
 =?us-ascii?Q?BsIunOBRtcV0VrceSIIa/l4WLHbxBGqUidTftSf28Iz3W0RxigovJViKvOeC?=
 =?us-ascii?Q?i5VFf/d9QYzt+ogYRsPfci1aw5s6RZhqCB84wvzDp4hJXN5iat55dvbPQ9tX?=
 =?us-ascii?Q?jvN6jRhaD23oBPpJTAeCJhKWRUCNl7zyyk8rX782MknIWHsl4mEgchVmLbW6?=
 =?us-ascii?Q?d2p+DS1Gq66AV4pT6nPFR757UozmIu3qH618x4LnmRdFb7Qyzw2Ro//LK5PD?=
 =?us-ascii?Q?TVN3Lk++u9YOYdsLANNMkP1VMiOaeRf/9Xoy58Hc7g0jj2xUkto0KnbZPlMV?=
 =?us-ascii?Q?pacJUUFOYWNfUt3188BBYBav9td8KoS74UfmIAeOi7fslSk+BQSZ5wQz6uhD?=
 =?us-ascii?Q?Gd986X07fWehvUQhn6wJh14E4npwOzfujAZJhmj6S/iE86buLHRx45FrO1vU?=
 =?us-ascii?Q?SkqzJjDrK1qobd8sii4Os2jw//SR7KOrMEtj1/JLB+pOQVMOdGooEAOpK4B9?=
 =?us-ascii?Q?hsEsf9syACGfz25VAngsK+Sm0BZcaav5gyKoXtqEthJKPSyBCqaeSqXg29BJ?=
 =?us-ascii?Q?INrk51Av41j88kNzSrfB5YMe0+euewJgPRM4fPcilPH3ddpr3HfN2BKu8NSW?=
 =?us-ascii?Q?aZ5EbgPlKWteaq56xTYmZD0gYJf/rikjPBm79uEMiQ9iC5nSyqPM+Jl6Rmmr?=
 =?us-ascii?Q?79m930OczwTEpNJ96Q8/fbki/uJ+5epXkJt9tHkQOPPdb1tuNFhynq/S5jYJ?=
 =?us-ascii?Q?zPJHzjWzBmRH74LIC8JtjQ6oUKuxDAXyjpnlpNcOxKIEbrVkLB5BvA9RabXz?=
 =?us-ascii?Q?sukOtFOyGZH8rTd1XuoQpPBBn73ImwKd/6DElmp+8epqaL6b6Z3VdUjAz3si?=
 =?us-ascii?Q?tDWBL3qckBWXhv33F6TliDCo448/uh/kWdDdtmq/VHgc4JN5P2OaThg5XJG/?=
 =?us-ascii?Q?sOmiSVF4yNHoI6bfiMUvkg/VLTMfZb+ErmvNkjXOWpEpz6CaCZ1euj/WSGQ/?=
 =?us-ascii?Q?raEjHH+6diLJI4itAVM/ZA5Qw+RyN6uULJbIb3GD2HIQsk+g5mmZSPqoo8sy?=
 =?us-ascii?Q?kf3Cj0n83wlWcEq3Y6rUU8Fo6AK7IHDkn88/0gY4+F3EwhiI6ieqJxDH/vOn?=
 =?us-ascii?Q?fBD/1WX8MtYMVr8OW1x1P5b8q/dB0kWqjTaBF27CRdjYae7rKw3jgeh7tew3?=
 =?us-ascii?Q?LJJOp6MSN5huWupgJxY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bb03e90-2626-4b1e-3390-08dbcf0888b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2023 11:59:36.2577
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Iw4J4mZkxNGf/vDyyuEXg4yffcDNTKuW/X3V+Wm/frSNuNzPnLQgMt9BCkRRkg7B35turcYqSsXYTvVjlCLQjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7843
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> -----Original Message-----
> From: m.brock@vanmierlo.com <m.brock@vanmierlo.com>
> Sent: Friday, October 13, 2023 12:35 AM
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
> Subject: Re: [PATCH V2 2/2] tty: serial: uartps: Add rs485 support to uar=
tps
> driver
>=20
> Manikanta Guntupalli wrote on 2023-10-11 16:56:
> > In RS485 half duplex configuration, DriverEnable and ReceiverEnable
> > shorted to each other, and at a time, any node acts as either a driver
> > or a receiver. Use either xlnx,phy-ctrl-gpios or RTS to control
> > RS485 phy as driver or a receiver.
> >
> > Signed-off-by: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
> > ---
> > Changes for V2:
> > Modify optional gpio name to xlnx,phy-ctrl-gpios.
> > Update commit description.
> > Add support for RTS, delay_rts_before_send and delay_rts_after_send in
> > RS485 mode.
> > ---
> >  drivers/tty/serial/xilinx_uartps.c | 116
> > ++++++++++++++++++++++++++++-
> >  1 file changed, 115 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/tty/serial/xilinx_uartps.c
> > b/drivers/tty/serial/xilinx_uartps.c
> > index 8e521c69a959..abddcf1a8bf4 100644
> > --- a/drivers/tty/serial/xilinx_uartps.c
> > +++ b/drivers/tty/serial/xilinx_uartps.c
> > @@ -23,6 +23,7 @@
> >  #include <linux/module.h>
> >  #include <linux/pm_runtime.h>
> >  #include <linux/iopoll.h>
> > +#include <linux/gpio.h>
> >
> >  #define CDNS_UART_TTY_NAME	"ttyPS"
> >  #define CDNS_UART_NAME		"xuartps"
> > @@ -193,6 +194,7 @@ MODULE_PARM_DESC(rx_timeout, "Rx timeout, 1-
> 255");
> >   * @clk_rate_change_nb:	Notifier block for clock changes
> >   * @quirks:		Flags for RXBS support.
> >   * @cts_override:	Modem control state override
> > + * @gpiod:		Pointer to the gpio descriptor
> >   */
> >  struct cdns_uart {
> >  	struct uart_port	*port;
> > @@ -203,10 +205,19 @@ struct cdns_uart {
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
>=20
> You promise here to support both RTS-on-send and RTS-after-send, but...
>=20
> > +	.delay_rts_before_send =3D 1,
> > +	.delay_rts_after_send =3D 1,
> > +};
> > +
> >  #define to_cdns_uart(_nb) container_of(_nb, struct cdns_uart, \
> >  		clk_rate_change_nb)
> >
> > @@ -305,6 +316,42 @@ static void cdns_uart_handle_rx(void *dev_id,
> > unsigned int isrstatus)
> >  	tty_flip_buffer_push(&port->state->port);
> >  }
> >
> > +/**
> > + * cdns_rs485_tx_setup - Tx setup specific to rs485
> > + * @cdns_uart: Handle to the cdns_uart  */ static void
> > +cdns_rs485_tx_setup(struct cdns_uart *cdns_uart) {
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
>=20
> Here you don't care about RTS-on-send or RTS-after-send anymore.
> And neither do you btw. in the if clause.
On Xilinx/AMD Kria SOM KD240 board rs485 connects via TI ISOW1432
Transceiver device, where one GPIO is used for driving DE/RE signals.
With rs485 half duplex configuration, DE and RE shorted to each other,
and at a time, any node acts as either a driver or a receiver.
We recommend using either GPIO or RTS to control RS485 phy as driver or a
receiver. So, we fall back to RTS, if rts-gpios not passed.
>=20
> > +	}
> > +}
> > +
> > +/**
> > + * cdns_rs485_rx_setup - Rx setup specific to rs485
> > + * @cdns_uart: Handle to the cdns_uart  */ static void
> > +cdns_rs485_rx_setup(struct cdns_uart *cdns_uart) {
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
>=20
> Same here.
>=20
> > +}
> > +
> > +static unsigned int cdns_uart_tx_empty(struct uart_port *port);
> > +
>=20
> I think it's better to move up the implementation than to use a forward
> declaration.
We will fix.
>=20
> >  /**
> >   * cdns_uart_handle_tx - Handle the bytes to be Txed.
> >   * @dev_id: Id of the UART port
> > @@ -313,12 +360,20 @@ static void cdns_uart_handle_rx(void *dev_id,
> > unsigned int isrstatus)  static void cdns_uart_handle_tx(void *dev_id)
> > {
> >  	struct uart_port *port =3D (struct uart_port *)dev_id;
> > +	struct cdns_uart *cdns_uart =3D port->private_data;
> >  	struct circ_buf *xmit =3D &port->state->xmit;
> > +	unsigned long time_out;
> >  	unsigned int numbytes;
> >
> > +	if (cdns_uart->port->rs485.flags & SER_RS485_ENABLED) {
> > +		cdns_rs485_tx_setup(cdns_uart);
> > +		if (cdns_uart->port->rs485.delay_rts_before_send)
> > +			mdelay(cdns_uart->port-
> >rs485.delay_rts_before_send);
>=20
> mdelay?
> https://www.kernel.org/doc/html/latest/timers/timers-howto.html
> "In general, use of mdelay is discouraged and code should be refactored t=
o
> allow for the use of msleep."
For refactoring the code will move this code snippet to start_tx, even ther=
e,
interrupts are disabled, so can't use msleep.

https://docs.kernel.org/driver-api/serial/driver.html
Documentation recommends,
start_tx
void ()(struct uart_port *port)
Start transmitting characters.
Locking: port->lock taken. Interrupts: locally disabled. This call must not=
 sleep.

>=20
> Furthermore, you're delaying before every burst of bytes here!
> Every TXEMPTY interrupt!
We will move code to start_tx.
>=20
> > +	}
> > +
> >  	if (uart_circ_empty(xmit)) {
> >  		writel(CDNS_UART_IXR_TXEMPTY, port->membase +
> CDNS_UART_IDR);
> > -		return;
> > +		goto rs485_rx_setup;
>=20
> And when there was nothing more to send you waited for nothing.
We will fix.
>=20
> >  	}
> >
> >  	numbytes =3D port->fifosize;
> > @@ -332,6 +387,23 @@ static void cdns_uart_handle_tx(void *dev_id)
> >
> >  	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
> >  		uart_write_wakeup(port);
> > +
> > +rs485_rx_setup:
> > +	if (cdns_uart->port->rs485.flags & SER_RS485_ENABLED) {
> > +		time_out =3D jiffies + usecs_to_jiffies(TX_TIMEOUT);
> > +		/* Wait for tx completion */
> > +		while ((cdns_uart_tx_empty(cdns_uart->port) !=3D
> TIOCSER_TEMT) &&
> > +		       time_before(jiffies, time_out))
> > +			cpu_relax();
> > +
> > +		/*
> > +		 * Default Rx should be setup, because RX signaling path
> > +		 * need to enable to receive data.
> > +		 */
> > +		cdns_rs485_rx_setup(cdns_uart);
> > +		if (cdns_uart->port->rs485.delay_rts_after_send)
> > +			mdelay(cdns_uart->port-
> >rs485.delay_rts_after_send);
>=20
> This is not delaying rts after send. You must keep RTS aka DE active for =
a little
> longer so even the last stop bit(s) are transmitted correctly. So this de=
lay must
> happen before cdns_rs485_rx_setup().
We will fix.
>=20
> > +	}
> >  }
> >
> >  /**
> > @@ -829,6 +901,9 @@ static int cdns_uart_startup(struct uart_port
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
> > @@ -1455,6 +1530,25 @@ MODULE_DEVICE_TABLE(of,
> cdns_uart_of_match);
> >  /* Temporary variable for storing number of instances */  static int
> > instances;
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
> > +	port->rs485 =3D *rs485;
> > +
> > +	if (rs485->flags & SER_RS485_ENABLED)
> > +		dev_dbg(port->dev, "Setting UART to RS485\n");
> > +
> > +	return 0;
> > +}
> > +
> >  /**
> >   * cdns_uart_probe - Platform driver probe
> >   * @pdev: Pointer to the platform device structure @@ -1597,9
> > +1691,28 @@ static int cdns_uart_probe(struct platform_device *pdev)
> >  	port->private_data =3D cdns_uart_data;
> >  	port->read_status_mask =3D CDNS_UART_IXR_TXEMPTY |
> > CDNS_UART_IXR_RXTRIG
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
> > "xlnx,phy-ctrl",
> > +							GPIOD_OUT_LOW);
> > +	if (IS_ERR(cdns_uart_data->gpiod)) {
> > +		rc =3D PTR_ERR(cdns_uart_data->gpiod);
> > +		dev_err(port->dev, "xuartps: devm_gpiod_get_optional
> failed\n");
> > +		goto err_out_clk_notifier;
> > +	}
> > +
> > +	if (cdns_uart_data->gpiod) {
> > +		gpiod_direction_output(cdns_uart_data->gpiod,
> GPIOD_OUT_LOW);
> > +		gpiod_set_value(cdns_uart_data->gpiod, 0);
> > +	}
> > +
> >  	pm_runtime_use_autosuspend(&pdev->dev);
> >  	pm_runtime_set_autosuspend_delay(&pdev->dev,
> > UART_AUTOSUSPEND_TIMEOUT);
> >  	pm_runtime_set_active(&pdev->dev);
> > @@ -1646,6 +1759,7 @@ static int cdns_uart_probe(struct
> > platform_device
> > *pdev)
> >  	pm_runtime_disable(&pdev->dev);
> >  	pm_runtime_set_suspended(&pdev->dev);
> >  	pm_runtime_dont_use_autosuspend(&pdev->dev);
> > +err_out_clk_notifier:
> >  #ifdef CONFIG_COMMON_CLK
> >  	clk_notifier_unregister(cdns_uart_data->uartclk,
> >  			&cdns_uart_data->clk_rate_change_nb);
>=20
> Maarten


Thanks,
Manikanta.

