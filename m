Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C0C07A6801
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 17:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233148AbjISPZJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 11:25:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232823AbjISPZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 11:25:07 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2109.outbound.protection.outlook.com [40.107.113.109])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED0D2E6B;
        Tue, 19 Sep 2023 08:25:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jDLuUaP3339RpZ+9a4HHddhzf11oY04g4t4klnpBKUubv11PeoAfc78eMHd2geO5il/e0Hmj+lj4ylyHcELH+r7O3Qt4BJeaPSMXzXGVXl3QX7iQVNbiyVBaqZI+wuXCQCKnkDoFn0b+s08G40/ksWZbIqtfxsVwzSGKjbGOlHglx313jPaj2t/ns6xPcN6yjk5GCRpNklyZkSV9Z5L5Ig+IRCXg2pdt3AgMHhqRGvOFER3rmcn+RYz5QRj1+HrSpfogfxuVu7avt+jplDmSXrodse2qFCrRCcAPWDJH47HT8vMPPeS8Vjd4znbrr8vvr1i+ejAP8b6OuXSOZET4hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/T8XS2Ui9mMPydYeKixs9wsR3zl0oPfxtqjgSiM2RKc=;
 b=PBsj11RQLW4/KZbBnhBN+Aiiq2DyZEvQM/ATSsmR86wHCY3jkyH2qZX33eXLSVoB/qU88NHU9J19lWoOrrWBStzZDbGnynFtx4WOGHcVOExT+qcLlIeiU/3xxPm55U876SsFk07TONhzo3M9W9/akTJs8NcWuxdyERkcq++0nd9cn4hpWx68FBVBn+nzCdw7thV+rHHTWBFVu05+ad8iA6ghGoNKue0+U8fiezunZ4IaPrK/ko+UF5mTX/iW9uo3c3/CfGQC6QSygKa6g/JL+PTYIJmE9Qm9/kJaZlYGL2DDsfyMxunu2PT85UQ4CvvAZ6VmWi/CmDvXd5XcywcSZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/T8XS2Ui9mMPydYeKixs9wsR3zl0oPfxtqjgSiM2RKc=;
 b=FXs/UPwc3aiMHa8RjUBssGbCIK985A9aA3huTNkmK0H81yj+StbO8XpFKFg5nxzKfubSavOXyEbJZscQ04hQLyp5JwWKbdV7W2nKWA2+5z4jVMfSvkB9gL9BvxHorlipuMK21RHMXP1QXcETtqPEf7Hw5ECqlPBqU5zjMSEogm0=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYCPR01MB10333.jpnprd01.prod.outlook.com (2603:1096:400:241::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Tue, 19 Sep
 2023 15:24:57 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::9d23:32f5:9325:3706]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::9d23:32f5:9325:3706%5]) with mapi id 15.20.6792.026; Tue, 19 Sep 2023
 15:24:53 +0000
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
Subject: RE: [PATCH 3/3] irqchip: renesas-rzg2l: Fix irq storm with edge
 trigger detection for TINT
Thread-Topic: [PATCH 3/3] irqchip: renesas-rzg2l: Fix irq storm with edge
 trigger detection for TINT
Thread-Index: AQHZ6isSnZZc/iqk1kePfAP8iH4mBLAiOWYAgAALsBA=
Date:   Tue, 19 Sep 2023 15:24:53 +0000
Message-ID: <OS0PR01MB5922748F489467BE2539AA1886FAA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230918122411.237635-1-biju.das.jz@bp.renesas.com>
        <20230918122411.237635-4-biju.das.jz@bp.renesas.com>
 <86y1h2cjpb.wl-maz@kernel.org>
In-Reply-To: <86y1h2cjpb.wl-maz@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYCPR01MB10333:EE_
x-ms-office365-filtering-correlation-id: e5831a11-e63e-46bb-7f82-08dbb92492ee
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2cq3ugoSITNw7bF9+xGeomn+hkQ5O8lYLiWKo2u158L+8fXS525NQF0C63X44TV8ZRCq/mfzCly6CiEaV2dGk8B2QuuYL0p3hU/SbJbbfGg9VaxpBuOHh5lyPJee/wNPCxqilv5FC+RX7m+FNjKQr7jlQLyGVQ5WdBl3uhRoIdcTJMcIEhYHmlYqLsgap+TDw7kDMTd0Nf/Y6h4XJ7/en++f7LpX0SIon+Xn0DVpeMjFVP5uqnS/ENha402Ddah63ftsBwSrG91QYWxud/D2cLStH4w/pisVGudDRqYLQrOaQ5u/AzIwYhQGJOc0/hbRe61Uv1iyShVf2vH+rkrBsZAMsDr/9ayCt8d/8tGGD/FVKEKgBaAHPWQoP70/TxBiI9cljOZaVPqKC+Lq8yEtQMaoWxx7wWt/OngP/yuWIXMfWyE4LSPGMwo0EsKHZqXbKGX3fXcknd00sELLlNY8feJFCjQoZGJl8n2Z9+zV2R5Sli/6inKfwjx03rigLxTL36Q0P2wYnzvgdD4uCbhooelj8mKiAGI9ZhYXymrehzCGGaaaFa0CXmkUvSmJ8WecpXdY3YXYSq0Ll4E2V3WZteopnjB+68HcJe/JP17ahp67oJucwapMdUTCcR7uBgjs
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(136003)(39860400002)(366004)(376002)(451199024)(1800799009)(186009)(6506007)(478600001)(5660300002)(71200400001)(55016003)(26005)(316002)(83380400001)(52536014)(86362001)(2906002)(7696005)(122000001)(54906003)(64756008)(66446008)(9686003)(76116006)(41300700001)(6916009)(66946007)(38100700002)(66476007)(66556008)(4326008)(38070700005)(8676002)(8936002)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1HwhDSQvBbD7yZIPJZ5ZIBdfXnj4pNSn5pF5Q0bl6sIHU1YfWmZuHiMIJueN?=
 =?us-ascii?Q?ZlhaE96IUJ97yfSdYPTSF6SpdA6P+Hwt1357GIHN1ZOZ5MFbf7ObubUXlGjT?=
 =?us-ascii?Q?xPTm3O6WdNb1ioLnPaFTdcvOEsbpSAmU3ZaltqSjO/CsNrMBjDOWd8VG0LlR?=
 =?us-ascii?Q?TE1aghc53v1nllr+6WLhOMBDfIBisQcWuuIG/5uJLQ/5UzQHUhSk4Xx+ckIj?=
 =?us-ascii?Q?lasogruqWNe6j3KZak1cl0wOipbfQIDS8yR6G21pwHxVpANEsl925nbmnnCi?=
 =?us-ascii?Q?7E18gAIRM/DJBeVKxdchyEb6YapgVwmZ8brHBOfP6Ooi6nqExwTldE8nVATB?=
 =?us-ascii?Q?q8rNYm1b1RwD6Ml0JyiE+1RfJpz6dAHGwb69VPwX5yjWuSntNn+xMjRriUSy?=
 =?us-ascii?Q?/nM09P7MIQN1hAoPZhs3AdtwPw2FjIOjFBdUFwWoQ8SdmOIK67lRMg2XL1bP?=
 =?us-ascii?Q?bO8W+RcC5MMUuTkyqi8C1irmuIDqUsfLdvdWqXsv5TczibfMUvl0KPueOy9X?=
 =?us-ascii?Q?sJ8raRAq9IugKQ7T1tkvdWB2peio2G3qESTuGltUnIiXPLxxSEk/yeiMn0mQ?=
 =?us-ascii?Q?Xh9g/OT4uJ0j6lCyBHa/j9S28TSVVbEAfPZUbZdr+yBhn9Ge9HgpKYOo9lvR?=
 =?us-ascii?Q?YaYgpxo0OpZIyoltNxeYxY/w74vzQY2PtJ49CKj157cM+uQ57hjGOXorgqPu?=
 =?us-ascii?Q?N/BaSSLd1PPF0b8uJ+ohybAwo27uErEcvGy3m3+xCkX5fG+mddoKHueh1fHB?=
 =?us-ascii?Q?0rwaJfcB3veU9kpvSZuJkIN7GrrVLFiG9J+919OEI99i7NiF0UBavG8S65Xi?=
 =?us-ascii?Q?obuNoenM/D2a/hSABpjzPEHzc5+0EPYcvEdIQqDW+PX7JrP3vvAbSjC3XGT+?=
 =?us-ascii?Q?8vPd1HgCQW3BY97ybhoEo9lQ1XnBo4uW5vHIOhv9ue70X3Mr0CHDT1dxpuzb?=
 =?us-ascii?Q?jREQlI/N5gpQFUt64MPqKXS237ebU6kwLiOc24f9CoGPgwr084ZIXWOc9nGX?=
 =?us-ascii?Q?cY7NujH13TPHENcSClYHoU3k1Momw6D7nNaMH69EPPC94nbdC9hlm6LdKlFr?=
 =?us-ascii?Q?dZxHLPZUJUdBXzpdYnK6bKz2ol8TAcbeqnvWxgqJp3JuJsHEViU902V1DPuL?=
 =?us-ascii?Q?qnGYlY+/QLPH4XyQYbPQOY9spe0HFVFvjWFQB5PPbpP1sJWDmZkCdItCdZzB?=
 =?us-ascii?Q?TNFhUBjFG5XPDPi0uUsBYlMguGnzoKoOqRAfKUBsyWetFPlOyMfLScx6eg5U?=
 =?us-ascii?Q?9BCbEuuRcf4FUcV2XYuVTTFNgk0g7O8BJOVMhNXCunusUWBBmAqeBOc6hgT0?=
 =?us-ascii?Q?ZSECAv9s/TYyBLGZsJm6SAl6hgbjCKV5SLaD+P3AjLAk4y2ivcaL3F5i6nkq?=
 =?us-ascii?Q?QiY779gqazrTjLew0mHNztycp8hF3iYf9StXBb7CVneQLZ9bKxe+S8MPeudL?=
 =?us-ascii?Q?U2n2i2qvB0SILqq9Mrj5G435NzUN+R0RntFvC8CKHqtptXsnkwdX1sqazd35?=
 =?us-ascii?Q?BjWbkB1WcrzIUA64n5ZVLvy36jBvM/EwaLzM4o5Bj4OZ3Kda2nn9uU1Ts4WQ?=
 =?us-ascii?Q?isclBmym4fskI/J0pOkcLBWF0KMNZ0EzJQ2PAHwsYM7Q/vyjpegzc3tBQ69F?=
 =?us-ascii?Q?gA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5831a11-e63e-46bb-7f82-08dbb92492ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2023 15:24:53.7832
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PgjD2Es93vjGuDFUjv5PxNmbobBgylglj0VCgunQ6vtoNkPMdrxWGQVOsVOXPwMoqoYQEidle9f0M/32FdbRn/o1uPtt9GkpK0BKWbFHv+Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10333
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

> Subject: Re: [PATCH 3/3] irqchip: renesas-rzg2l: Fix irq storm with edge
> trigger detection for TINT
>=20
> On Mon, 18 Sep 2023 13:24:11 +0100,
> Biju Das <biju.das.jz@bp.renesas.com> wrote:
> >
> > In case of edge trigger detection, enabling the TINT source causes a
> > phantum interrupt that leads to irq storm. So clear the phantum
> > interrupt in rzg2l_irqc_irq_enable().
> >
> > This issue is observed when the irq handler disables the interrupts
> > using
> > disable_irq_nosync() and scheduling a work queue and in the work
> > queue, re-enabling the interrupt with enable_irq().
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
> > index 33a22bafedcd..78a9e90512a6 100644
> > --- a/drivers/irqchip/irq-renesas-rzg2l.c
> > +++ b/drivers/irqchip/irq-renesas-rzg2l.c
> > @@ -144,6 +144,12 @@ static void rzg2l_irqc_irq_enable(struct irq_data
> *d)
> >  		reg =3D readl_relaxed(priv->base + TSSR(tssr_index));
> >  		reg |=3D (TIEN | tint) << TSSEL_SHIFT(tssr_offset);
> >  		writel_relaxed(reg, priv->base + TSSR(tssr_index));
> > +		/*
> > +		 * In case of edge trigger detection, enabling the TINT source
> > +		 * cause a phantum interrupt that leads to irq storm. So clear
> > +		 * the phantum interrupt.
> > +		 */
> > +		rzg2l_tint_eoi(d);
>=20
> This looks incredibly unsafe. disable_irq()+enable_irq() with an interrup=
t
> being made pending in the middle, and you've lost that interrupt.

In this driver that will never happen as it clears the TINT source
during disable(), so there won't be any TINT source for interrupt detection=
 after disable().

Cheers,
Biju

> What prevents this scenario?
