Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB8277AD3CA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 10:52:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233057AbjIYIwE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 04:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232970AbjIYIwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 04:52:02 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2103.outbound.protection.outlook.com [40.107.113.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 762B6AB;
        Mon, 25 Sep 2023 01:51:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M6yvftVHmR12yl3o4Y4Jo4IBV7FeM4jYd57ZTIb+FFUzHnw/CySZayZA39wfVysT9FvkCD5blsCvHz4i9UAhzyTJb1v51UqVj7qZbscJKdS/p8473Ll0i3f1lkEZYQt1D1+/qXCFBvbV+Tc6spN8vFk1XaqsWE7lJ4mbG1jewhTCNEbq6S6HzDpne5Dm/F3KHo/yLg9hASLB0JW0YXJMcQcfkvOPuzxQ9oitwX6CLo028hmXxQObf6GEt3orGoS0FQ1KYCXINsHLlHBPPiO9j390d0+cZr7vIsjhqwOdC+gfX4JxwKtqiSwjt0HZLX/DL88LVGOI/tBLt4Gyu75tQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xgLM5HQHJrWJ/XvH/PowRg+BmNP6m6Bu7Jk/o9Ej61A=;
 b=G5I6/UOlwGQJcahhhVMb4Qww3iYfU+1pVcRzggWbyMvSLMSF1/5LHuufuo1mSti9IdL9EMtbNvNhHdyT3US/1QhGYq9ok0TNlSZjT2Hux9VCiJLtFuWX8tUQIxziFpembtCUhgoHq31Y2BsvQaE/bb8RaBIRfaA9Uba/RgOeWZoXabLMY8cmevwChCDaFoWTZtIBo91vFtfO1FiGbGCrICdtuhApy2c+M+r7SCdUhGHEj0XhH056f1AxnuenDru4Nqj70yUjIrtLq+AL3eD+F/d5Py/WuWExRHQOWzxFqix3SqEzyAbT0d7JwzFuSbRXJ7ouzLIRJsvMkovGYx03EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xgLM5HQHJrWJ/XvH/PowRg+BmNP6m6Bu7Jk/o9Ej61A=;
 b=MhEdEiGq3ZjShiuPhKBkzh2zqmYbEoneoAeoTzhCz7W8mL61yTeP2gE57eyr+hmwkbA3L8Koiv7TAuNW7wSVeqApI9CRfbpJa08GWRYgoTIcFWJTnsoZJM5b+zfNx1NiMzbA+M2/Z69g5AfNI9gOYimXEvkcjWFTcS8fMVuetK0=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYWPR01MB10322.jpnprd01.prod.outlook.com (2603:1096:400:1e6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Mon, 25 Sep
 2023 08:51:50 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::fb78:2e8c:f7f9:5629]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::fb78:2e8c:f7f9:5629%6]) with mapi id 15.20.6813.027; Mon, 25 Sep 2023
 08:51:50 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Marc Zyngier <maz@kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Biju Das <biju.das.au@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH 2/3] irqchip: renesas-rzg2l: Mask interrupts for changing
 interrupt settings
Thread-Topic: [PATCH 2/3] irqchip: renesas-rzg2l: Mask interrupts for changing
 interrupt settings
Thread-Index: AQHZ6isQu3885mmag0K4fbtCicuaxbApvkOAgAGGVSA=
Date:   Mon, 25 Sep 2023 08:51:50 +0000
Message-ID: <OS0PR01MB5922FA104CE23A02A3CFD0D186FCA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230918122411.237635-1-biju.das.jz@bp.renesas.com>
        <20230918122411.237635-3-biju.das.jz@bp.renesas.com>
 <87wmwf53bi.wl-maz@kernel.org>
In-Reply-To: <87wmwf53bi.wl-maz@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYWPR01MB10322:EE_
x-ms-office365-filtering-correlation-id: 0e960588-da6f-49c4-223d-08dbbda4a89a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ezJAPZJZo2OZLwEAzliY/EOxZevjxTcUkIF/Te9rdojN0wlFSseLXqM8I2/TzF00PrnhD8Zgjvs+s/4VUxq2M1PGMEpRp3H0bGyscAKj9puxmKJghrNDlYDLRCaMUKEwfh83PPEIChNtg/qoY/HZ6A1eOCdC1DnxzQqABUimTC2siNO7s3LRwcNRdyoC2grmI7tV+e/XMHI9TUeG3t3X4yWIoaaZHn7D40CAuEA/TfWPI/F208uii811itXwC9Ee5RQqfPYz8trjqbZMB0hM30sCOCk5jIOaTqJJ7GwmebdzoK3+qbhu0ImOeXPdJsSoAnpSIZ8DLIzQq5kmZzZHt0QTP3zjGgwBk8vpGD4zZgadBKSE+mFtnnERGa7ZgNpnEfHTuNQBs0cHW9yxgoJbHOQOqGdJQCxUXDP1OMxeCGOIHwX8lchorJ+yNtZoanOSkbauwGUuLolnJNkz5iI8pOp+f+/CEkLcyEf0ol230RgwhxG+Z6mzC85qd1Ft4Tbq+5Ry9o6/OTX0535SpZEs1RzDVfumSI72iiYIwEDVldqzgUD+tEAoIsg0Mg6LzdDkT8Yjmur3s8bh/2NOGdTOhQlzz6M40hFKpwvKviBtQTDcxWfDy6Xam40pqT6ayS4u
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(346002)(366004)(376002)(396003)(230922051799003)(1800799009)(186009)(451199024)(33656002)(122000001)(38100700002)(38070700005)(86362001)(55016003)(5660300002)(9686003)(2906002)(66476007)(478600001)(41300700001)(52536014)(76116006)(316002)(66556008)(54906003)(64756008)(66446008)(6916009)(66946007)(71200400001)(6506007)(7696005)(83380400001)(4326008)(8676002)(8936002)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?iqIynDs6SfNsEemdhTp5lpBdB7QEWAZuzQyAza5JeNuinaVMzCaC7Pcwjq/x?=
 =?us-ascii?Q?R1n3qd6LDy1Tyqeyv4yNx1dX1KRqBXGKezkhDlM0eK6nT/qa25LA5kulsVze?=
 =?us-ascii?Q?TXh13SHyxSUOz4Yyv0YcM+hHPOxE/vf/aDU1TUrOEhFC461Bl0cAIAW8AFEQ?=
 =?us-ascii?Q?eUIcjXomvV3nJrzX9lfcjECXkAl/AOi3pciQq1rqc6dfeOJTUGI1u37VfDeC?=
 =?us-ascii?Q?2oZMh9UGHM/m1kl2faFDrfXz7xzOjCnuH5IPSub6WxaxV/8npo4nis7OW6GY?=
 =?us-ascii?Q?V+ZfsCkDviciFg1gPhl1AgoBAM9cI/XEZ1Q++hv3drCqcvDQw7VTwEaHrbkc?=
 =?us-ascii?Q?944pwWh/Vwi/1Vvp+5a1Cja3nSb2TD6FUiHybPLEerDBM9QcXcjPm3tqzMZ+?=
 =?us-ascii?Q?5JEypMgSSewj5R2jKQI3Agcwf5y4fHgZgjTdCdnYJKtRCROXzcTeacwZEZHA?=
 =?us-ascii?Q?u1euyW4h8xJ/em89lkzVsvfAMr0Rcbt1k2CKGkW6w7GgwLNT8ED6pFCzgTi8?=
 =?us-ascii?Q?WJrRNvLkLl8zJn5Jx9gKMyQtZE6K6H6rvmjU4gAX9Cpaq36amIYsD0xsgynB?=
 =?us-ascii?Q?zmwnB88dREiSxuRmjzpZ6ahwu3b3KLWmShszjfp8d8wnJDj/TBhL0VKfaV3U?=
 =?us-ascii?Q?3atMisVL195V2eXBjWXNwOKytTWWOA9/bkejuiQSBe5RrALhC/LwsxeOBqd7?=
 =?us-ascii?Q?GO3SQh1ZlM2BiBDDRTqV8kKXbFz+xUlhJUGC0DuAIL7seZEOgL9fcVEs/Spa?=
 =?us-ascii?Q?mTEIfdgzpVygBr03sv274nPBwGeJ3K2HQ1jxp7gaHICxnH/l/1SfyVP+mAQc?=
 =?us-ascii?Q?5iMoUSWdnwyISPznbWkT0aowIE0/3XVVTRj+1lXYuf60QeqEjRioRXbcMFb0?=
 =?us-ascii?Q?wjySUg8pejYJ6T0Up2e99oaZK4iyPYMycKZmJ40TLysyb/LIYtR2a0I9V3L+?=
 =?us-ascii?Q?gqbCOyWIiGGUBdfXtjjE9vO20naSASc7Gt2A0mPfN/Q1rBHNwgC9bI+4vbET?=
 =?us-ascii?Q?7Tn/OmBKEeFjQKP+xGY0gOvqmwzxFHayePptoQdsxmwZ++GytlXe2QMahrD8?=
 =?us-ascii?Q?1vx/BqsP53mxHtKaCnBQtBzPKP5l8n7dOn2pzB/8zMalZiebYDnYp/PIwEVx?=
 =?us-ascii?Q?t5wn+pN35KS9h5ZaBxHYMgh44YTr7m/dQ6ttr9JPFLKKENH8Zo8bX6frUqUO?=
 =?us-ascii?Q?QuxNxU7jdIi8an0KlQB++8TiA0KZQTnPfnMJuhQNdq7vpx9646N9VolaB9O0?=
 =?us-ascii?Q?QrksQ+4eBozS9cx3/YX5/Ru0P+OZv9eFLrfRjfMOI0KczhVA1ZQH0eu9wTbM?=
 =?us-ascii?Q?LAd1ojQSezMP630SZwYvLIiX+kV7E3Y/o1LU8GB3tne79JIXGwfv9UbzUz1N?=
 =?us-ascii?Q?DVnQUgeztYU9K+66NtT/Sry37RHF2GCyfUH0FN82+XipANDYpUymVMicyLdT?=
 =?us-ascii?Q?2eyjkZ2uxafbNUojNSqJ8sRnxDYOP9GAxebJRa4J8XcANKNJXmgesavC2c23?=
 =?us-ascii?Q?KnCjPXD6KsMicab2W3DraJd9L3/9s1xX3lkwzZDZGwKcc+LEB3+4Sj2yPrLi?=
 =?us-ascii?Q?EgvV73mRpdg1seplqV6CKvlWvF87L9RCZtvOpVLwxLonwFXG4RXDr3ej2jsY?=
 =?us-ascii?Q?xQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e960588-da6f-49c4-223d-08dbbda4a89a
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2023 08:51:50.3483
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kpEsXIAkKc5IRRHTlA1XJUx22QsOHLz12Qtayum72/3LSb45QlCb4kXCh6ApMy6HzbaaKkGxvMWUbKH5C20LomJbR4u7T0pW1MxpbwHBhZM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10322
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc Zyngier,

Thanks for the feedback.

> Subject: Re: [PATCH 2/3] irqchip: renesas-rzg2l: Mask interrupts for
> changing interrupt settings
>=20
> On Mon, 18 Sep 2023 13:24:10 +0100,
> Biju Das <biju.das.jz@bp.renesas.com> wrote:
> >
> > As per RZ/G2L hardware manual Rev.1.30 section 8.8.3 Precaution when
> > changing interrupt settings,  we need to mask the interrupts for any
> > changes in below settings:
> >
> >  * When changing the noise filter settings.
> >  * When switching the GPIO pins to IRQ or GPIOINT.
> >  * When changing the source of TINT.
> >  * When changing the interrupt detection method.
> >
> > This patch masks the interrupts when there is a change in the
> > interrupt detection method and changing the source of TINT.
> >
> > Fixes: 3fed09559cd8 ("irqchip: Add RZ/G2L IA55 Interrupt Controller
> > driver")
> > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > Tested-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> > ---
> >  drivers/irqchip/irq-renesas-rzg2l.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/drivers/irqchip/irq-renesas-rzg2l.c
> > b/drivers/irqchip/irq-renesas-rzg2l.c
> > index 2cee5477be6b..33a22bafedcd 100644
> > --- a/drivers/irqchip/irq-renesas-rzg2l.c
> > +++ b/drivers/irqchip/irq-renesas-rzg2l.c
> > @@ -116,11 +116,13 @@ static void rzg2l_irqc_irq_disable(struct irq_dat=
a
> *d)
> >  		u8 tssr_index =3D TSSR_INDEX(offset);
> >  		u32 reg;
> >
> > +		irq_chip_mask_parent(d);
> >  		raw_spin_lock(&priv->lock);
> >  		reg =3D readl_relaxed(priv->base + TSSR(tssr_index));
> >  		reg &=3D ~(TSSEL_MASK << TSSEL_SHIFT(tssr_offset));
> >  		writel_relaxed(reg, priv->base + TSSR(tssr_index));
> >  		raw_spin_unlock(&priv->lock);
> > +		irq_chip_unmask_parent(d);
>=20
> What guarantees that the parent irqchip state has been correctly restored=
?
> Nothing refcounts the nesting of mask/unmask.
>=20
> >  	}
> >  	irq_chip_disable_parent(d);
>=20
> I'd rather you start by *disabling* the parent, and then none of that
> matters at all.

Agreed. Will do this in next version.

>=20
> >  }
> > @@ -137,11 +139,13 @@ static void rzg2l_irqc_irq_enable(struct irq_data
> *d)
> >  		u8 tssr_index =3D TSSR_INDEX(offset);
> >  		u32 reg;
> >
> > +		irq_chip_mask_parent(d);
> >  		raw_spin_lock(&priv->lock);
> >  		reg =3D readl_relaxed(priv->base + TSSR(tssr_index));
> >  		reg |=3D (TIEN | tint) << TSSEL_SHIFT(tssr_offset);
> >  		writel_relaxed(reg, priv->base + TSSR(tssr_index));
> >  		raw_spin_unlock(&priv->lock);
> > +		irq_chip_unmask_parent(d);
> >  	}
> >  	irq_chip_enable_parent(d);
>=20
> Same thing: if the parent was disabled, why do we need to do anything?

OK. It is not required.

>=20
>=20
> >  }
> > @@ -226,10 +230,12 @@ static int rzg2l_irqc_set_type(struct irq_data *d=
,
> unsigned int type)
> >  	unsigned int hw_irq =3D irqd_to_hwirq(d);
> >  	int ret =3D -EINVAL;
> >
> > +	irq_chip_mask_parent(d);
> >  	if (hw_irq >=3D IRQC_IRQ_START && hw_irq <=3D IRQC_IRQ_COUNT)
> >  		ret =3D rzg2l_irq_set_type(d, type);
> >  	else if (hw_irq >=3D IRQC_TINT_START && hw_irq < IRQC_NUM_IRQ)
> >  		ret =3D rzg2l_tint_set_edge(d, type);
> > +	irq_chip_unmask_parent(d);
>=20
> This one is the only interesting one: why don't you mask the interrupt at
> the local level rather than on the parent? And this should be conditioned
> on the interrupt state itself (enabled or disabled), not done
> unconditionally.

OK. Will do this locally by conditioned on the interrupt state.

Cheers,
Biju
