Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CC5A7AAAFB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 09:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231878AbjIVH5U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 03:57:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjIVH5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 03:57:17 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2138.outbound.protection.outlook.com [40.107.114.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D67FCFB;
        Fri, 22 Sep 2023 00:57:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ibdg1UWEzgZarbysOdrh4oa5ddtdo0Dqv2h8H/bMrWaj0HswLhOTSyV82cGn/+E+021zTWwrurE1Pl4OnO4rFJFwHqgdPTZvoMmSgC9DIRNKLqSe/680kGHiYDPxaYqbHdEzUUcuGilZWqLCbdrDboPULIY/BZ627+4wDe3lxKeUhqf4nl6AdhwefLEdNprvYfiBV73bWDyvU6r+XyyOmtSNXuSrxG7jpKjzs3pa8j6z7vXs9L/EZp0vx012jiwVavjklQGhi6rDKD3jARz4H6PrYcsety6QWum0N2SfvlgQH+PVlSYTkdUv+J4cfNzsVMbMqmnpyNRXNP90bcrwPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RpRumWmwXbHVarokzYMx5istB5sJ8ZRArBKLTZiNWq4=;
 b=JeYrp6VGpkzf1lbuKe6LvxiGwt17J8WrQxyGyCWhTaNwghjWxK2h6pXxGeQDwcqOnYMeR5IiKBHYK+ORoxAaFISbiecf42o7TFaO551M8Uh4Dmi9Vf6JeBYiZPK/TSG+fkPuWXfxPV4Wb3gfnR2cIBkHZeA28yGX25VoFHcyiufLu3l9DowKJ3A5sJAAt7gvwOuT1lJiJvzjiXwGJV8zCuclX0e0MEeNBdaHwGqbVKaKiBgk+eXe3NEajesrALJAPBEZbTMk8sdJiY9IQP35cetpZEErESv0Vo89iWa1Qp7ESYOuZqTkt8S90K+/divSGjA0Jdv1BlgCAP7LTeKCEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RpRumWmwXbHVarokzYMx5istB5sJ8ZRArBKLTZiNWq4=;
 b=qWBWS3fWTSNRP8vTjX0w5YyXZ6R4AukeiOLnY2au+tdnx2RzqQjL1/vwdA9U/r0GOlw2JWk0x8g404szxlnUdFG1SZ//bU7MhMH4nhSKn+8WxpuwwNbAoRetSgOOZ8zyIb0Nsnkkuee1YGPw6hkJZ3o9cstx+Wuex0AHiWqdkJU=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYVPR01MB11338.jpnprd01.prod.outlook.com (2603:1096:400:36a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Fri, 22 Sep
 2023 07:57:08 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::9d23:32f5:9325:3706]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::9d23:32f5:9325:3706%5]) with mapi id 15.20.6813.017; Fri, 22 Sep 2023
 07:57:07 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
CC:     "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] irqchip: renesas-rzg2l: Convert to
 irq_data_get_irq_chip_data()
Thread-Topic: [PATCH] irqchip: renesas-rzg2l: Convert to
 irq_data_get_irq_chip_data()
Thread-Index: AQHZ7SmokDeLt4CMNkeQ0Rk0k0FwJLAmed9g
Date:   Fri, 22 Sep 2023 07:57:07 +0000
Message-ID: <OS0PR01MB5922CD31ADB81DBD7BB65EF086FFA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <3241c1386e1ba0bc288496a36365bd764e17fdae.1695368979.git.geert+renesas@glider.be>
In-Reply-To: <3241c1386e1ba0bc288496a36365bd764e17fdae.1695368979.git.geert+renesas@glider.be>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYVPR01MB11338:EE_
x-ms-office365-filtering-correlation-id: a8c7ddfc-a89e-4d8f-335f-08dbbb4184d0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TvOg1ASpVuYdS4vuYwp3cLJ/KchP2Yu3e8FMgk1U+JUOZSYiOlCD1hYyi8uSuXxp0B01rVTWzOz6q7LFEZH9bV/clrjmAJQj3RaAqP/8cFCTa/J4QWt+DQRv/zaxXdsgwl07eOpYrPBDh5/AxAg/jFndAL+TpGHKCsqZwgObEt06xDwDPhrpfj0cejUzfawkg0XmQ6gD+MowxcJfGr1uqUGB4YqnWPbWjJD8HueCBAxBHAb8sre3EILqIFCVmDfxzdQnqmYZmCyfA/kkzv3KmqWf09kHWf9ZtU5XP/Etj/t7P91zQDqgz68v5v4I7l8Vm2oS6ukn/pLFPX0AONDARvjhuYd2Mw4DIZpKK0r5g99HH8r8riJ4DR3Jl4q3XSYBaLlY8bBe8muk9+8FYcP0SP+RSFKA8A92r/EmUr4DMf12Th7ycpvQ1jiCvCuF3BYSIM/3LYM+WV8xEXgl3prK9AQnsDDpx8ROBpNDld7IwSq+QexmuiTr9TbEvKxO8mFeQL6XI3OM4035FUm9YhjfxtraGmLUPsRmImp7E1U8D4YZ3Oo7ymkCCeCQHB29QGP6ZfK0UqQlQsicxTFSsROt8XSOVpzmMWk70ERCdSmZzoYXsXuf7oYWP5wMNV841WEA
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(39860400002)(136003)(346002)(366004)(186009)(451199024)(1800799009)(2906002)(55016003)(33656002)(71200400001)(26005)(9686003)(7696005)(6506007)(83380400001)(122000001)(38070700005)(38100700002)(478600001)(66446008)(64756008)(66476007)(66556008)(316002)(6636002)(4326008)(110136005)(54906003)(5660300002)(66946007)(86362001)(76116006)(41300700001)(8936002)(52536014)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ouE+OhIPDDP+k9kHMumEf7H2OPXscmCIToKFYkPnKwYKPi52miaM0LWT4mob?=
 =?us-ascii?Q?8pWLHhYLr2Rg7GlIZdYfpI9n6QlDBoJ2rENdcfmuTnd3OO9TVCd2mWvxTvOG?=
 =?us-ascii?Q?AmCDGa5sEYBI31QKUN5U9QHJso4jJXXHTzzb+UF16f7D3D5GTmLS3GpUS4Gx?=
 =?us-ascii?Q?bHTldb79aczv0LcWyQ2ByTnnYSMt07rJk0Ecg+Ee6bP9qpvlYO6F+KLR+6U2?=
 =?us-ascii?Q?Dv5jb20z5tKFlFKOWtS7ZRruQ4Xo5E0gtwCufCIn/cASCVm9HlMACQVlWaM/?=
 =?us-ascii?Q?Yqr1a0066cUJ0xtbRqMrIYzG0NnkdNZPk244t88BlH/8f9hBxB9TTOQFq7gr?=
 =?us-ascii?Q?fUuBVv7vXzsOdFMr/gESZuw2TrF4Mx2vkFExUugbc/J56Sw8YdLPIUjhvlI0?=
 =?us-ascii?Q?EnnQjmY1ijxmBCSoK/dN7tAuE0tfLkTd2fSYwAagYAhKQe+eKP+kQy6s8H9z?=
 =?us-ascii?Q?I5M5DqiSbM4qbVn+Zlz4J/Y7vahIfErK2ieGngurEGNdVh6es2HzoDkRB4f9?=
 =?us-ascii?Q?z9M78w7LvX1VVg+rkWAktbJubYTfbXqpu6AU/jS1KeVb2EHKdrQaXmpsrXI4?=
 =?us-ascii?Q?dLNIoojI6KWLc9V+mpwIKSbhlmga7hSBDvm2Z2tamUA+pghAeuv+ss9Y1IAO?=
 =?us-ascii?Q?JZiDg7uTmEXgwHk1wAJLj9gsmuRqeVtYGG1trwsHCcotdtyROStVFIRcfiU/?=
 =?us-ascii?Q?IK6aRXeFw8x1WslNaf5Fq/foRavuaDbed28JDH45gS+gz/EQHaLt6EMZrfPK?=
 =?us-ascii?Q?c7kXNXiK+rR658LsUuZ0wty0XC3qC5NBuPJB+DTP5D/vETPDwzbf7wYe8vxH?=
 =?us-ascii?Q?RJkYVcegT1k5xbJLOtNu4ME+VvyzSjN0eOWGhNWh6QRIrKgsBSkaMLzTps0R?=
 =?us-ascii?Q?p+JckpvbYKMBowlpmTj2+OUT3GZ+lMb4RGfTm+kmp4P+WbeHS+oLqqya0VFq?=
 =?us-ascii?Q?ml7cCXONNpWU25l0Y7Jh8fMFsql3aErhh9YrwnZBfZ4GUxyX5Iz0DsdRlknh?=
 =?us-ascii?Q?HfGEmsU5WsOaCOG9RMfn2tWO0FJmpquUxxekRuFf1AxXhs9lSRe4Rch1LhEG?=
 =?us-ascii?Q?trHUN/3q/1Jom2pQxdNyIp785SnLcqP1q9fRmFCNaE8nCsfTKP7d7Ky7/SYo?=
 =?us-ascii?Q?NCyIEvN5EW2T/QF6/sAH4fGzTf7cwupoXXx87OawCfGlGcXK1pnaKF0heFg9?=
 =?us-ascii?Q?UvtvXGBrQo3NrPYIylZwG4dK8AMRPKIzsIQ8dYRkvrLqtgjo9W9jywN/CVoL?=
 =?us-ascii?Q?aYBZU07jXYr1o6X/4BZZOl0+p78QOgn18qcwJFSLGo/CwI7hfWfJBHW+kQuu?=
 =?us-ascii?Q?8mChQorbMKBvbdPhksmML/jpH0Bh/E9gN1GH+bX1XzX6jvAvzKxPk+NjoxMi?=
 =?us-ascii?Q?NeO3hAce0hIikIfJ4og2SlHXNnYfFmjGOTs1b7xJ3n6RKoUD1kh+V2+i5CWD?=
 =?us-ascii?Q?bJ4Q2BD1G0GmyRaZOUK+LTmHwN0q4nJ9y1w5RaVpHXgh4e7oU4yzHHzFmly4?=
 =?us-ascii?Q?TcxiRvSuB87eRFIuLftWMFaPkqWIbJvsLe1rbS/OvBnzvSvcOM2hOcMW9//V?=
 =?us-ascii?Q?IaW5zknKgk5LmNesKIBKP3Rguwoj2CcZ8EFqskaqQxqaEx4m2c9FRchVV3uQ?=
 =?us-ascii?Q?og=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8c7ddfc-a89e-4d8f-335f-08dbbb4184d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2023 07:57:07.8265
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Hj55SarQlqhElrZvFIaKr/OU5us3/41AM39R4z2HrIUklw0ls6r3frUXgXwP8WW+V3oCL4le9Gzx/VP3rk5kKtU5c/e8+8M5N7+gWEQQI1I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYVPR01MB11338
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert Uytterhoeven,

> Subject: [PATCH] irqchip: renesas-rzg2l: Convert to
> irq_data_get_irq_chip_data()
>=20
> Use the existing irq_data_get_irq_chip_data() helper instead of open-codi=
ng
> the same operation.
>=20
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/irqchip/irq-renesas-rzg2l.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/irqchip/irq-renesas-rzg2l.c b/drivers/irqchip/irq-
> renesas-rzg2l.c
> index 4bbfa2b0a4df9b83..c0f3c09affa64511 100644
> --- a/drivers/irqchip/irq-renesas-rzg2l.c
> +++ b/drivers/irqchip/irq-renesas-rzg2l.c
> @@ -131,7 +131,7 @@ static void rzg2l_irqc_irq_enable(struct irq_data *d)
>=20
>  	if (hw_irq >=3D IRQC_TINT_START && hw_irq < IRQC_NUM_IRQ) {
>  		struct rzg2l_irqc_priv *priv =3D irq_data_to_priv(d);
> -		unsigned long tint =3D (uintptr_t)d->chip_data;
> +		unsigned long tint =3D (uintptr_t)irq_data_get_irq_chip_data(d);

Maybe variable defintion in x-mas tree reverse order
for consistency??

Cheers,
Biju

>  		u32 offset =3D hw_irq - IRQC_TINT_START;
>  		u32 tssr_offset =3D TSSR_OFFSET(offset);
>  		u8 tssr_index =3D TSSR_INDEX(offset);
> --
> 2.34.1

