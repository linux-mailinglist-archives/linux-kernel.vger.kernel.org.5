Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96A9F7A6904
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 18:32:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231687AbjISQcg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 12:32:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231858AbjISQcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 12:32:22 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2108.outbound.protection.outlook.com [40.107.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE1D0E42;
        Tue, 19 Sep 2023 09:32:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lMwgZ3smbcWqZ0velwJGbz0GInZ0t4IjPEpL5eCLlcxR6c7n0J7837Dgn/pT4ATLt5ewHaewW6s3PJ/6RGBzM8xuML4AmIq64p9gxO0kHWLylGAH6kU48il76pa3gsq2s01F3Av7OeIA6K1tOBWZQEaVSEkaqXOvsMZcuGuYG+Cn1zz/1XMdCTUDfyJGrgAY8iWqkGt8tQrpi6Z2v72Z/lxIOMitBGsQeiPEdFo6ZF+H6qnl715AWE3d7/r9gVLMYw3W4UOmoo2mqOypP0XVGhmJwz75s2pzDqvDTA1vwEDMTIq7KQKPogXspjjGg1xzsGb+vcJl9/mx2JNw/QmwGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CqORck+pVT+sbpfwl3nMHznaYFW7Qs3SLXYYExBOtME=;
 b=S+IrG9IEo0J8hK3PcsqW0jKXI8ybhC72HNwLd9KqwYwd6S/RxYoOiIflQZ8PgyUgap4KxaN5ytfHQXEEm7EvRfOEnBU6WdZfzm6ET5HKIFx5e8RUoXGcaD4TcjWlzupxW9sWSbpsp5+UBr1kX5Bpm40t+pFhg2SBhgh+ePTml69QDvozvIWwmbr5kb5hgqeyNr0Fug9aFpmJmKRanZC6q1iAh4EBBvndXH+4rSUa6AoOa1a37dx4Gn+MNQ/LAJTbWOaQL5CzwEhHzxrdIcsmydjVqvR0cprpXefz5HKh71tqc6kRnFPW3w5HcuVSm7lGaA4x15e0NGuwhgkIP7h/4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CqORck+pVT+sbpfwl3nMHznaYFW7Qs3SLXYYExBOtME=;
 b=eI67JxcWD43WSBuJE2H0a7Q+1poGzhF0mxaiZd6bdiJU4vLSJ7ZPze7PZtVSsd3D8GZ0CZvm89hwL6qzxutJriDKpbN+Cs3wO0vWqHzr4fqD46bt09iGTXl2U967elaIy9yNDwX1rZt4wXj5kD3THkHyTb7sFpKRBjlW1RT7sdc=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TY3PR01MB11114.jpnprd01.prod.outlook.com (2603:1096:400:3d3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Tue, 19 Sep
 2023 16:32:05 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::9d23:32f5:9325:3706]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::9d23:32f5:9325:3706%5]) with mapi id 15.20.6792.026; Tue, 19 Sep 2023
 16:32:05 +0000
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
Thread-Index: AQHZ6isSnZZc/iqk1kePfAP8iH4mBLAiOWYAgAALsBCAABCYgIAAACWA
Date:   Tue, 19 Sep 2023 16:32:05 +0000
Message-ID: <OS0PR01MB59228AD24951D49F3E639BFF86FAA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230918122411.237635-1-biju.das.jz@bp.renesas.com>
        <20230918122411.237635-4-biju.das.jz@bp.renesas.com>
        <86y1h2cjpb.wl-maz@kernel.org>
        <OS0PR01MB5922748F489467BE2539AA1886FAA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <87cyye3zly.wl-maz@kernel.org>
In-Reply-To: <87cyye3zly.wl-maz@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TY3PR01MB11114:EE_
x-ms-office365-filtering-correlation-id: 4744c105-b093-4d52-657c-08dbb92df5c2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: q75ZPYQrSPcgzA75TsQERKoZYopZT/TinDKEs7fHjwfxx9WKeae/ZXV6+CT/DaSgN968fVMXz/wjp+Jg1saFYk+EB+b1N4RnVFAgMzEfMxUSN9b3DwW0kHYhagDG7b2u1kpIAuNBy/mNEoS4rXP2VmS8rnCzBrZX5pw+5+10sMU/3MTlwvl8vYS1t5PpqblkJYSr0Vx76eIfxkSsL7rIoqrNPbLj45k3p2xy+5OJHXAA56UomWCEpvckPw1zjIToJFfGXKApJAEU50lVL8SzdZZSsh7Ds/3dR9QAIkdxJsE+8RIO78QKy0iawbmM4feFL77ND8B7dbPbjI6XotSNZw6O2WzUwmSDhye/4muW8Qe1/AtWSJHvF83e4mLpYjnfpgoQi/rJWeXBhC8OJwfdQm52w6kHUwjxMHmixjWx6AqerhVk8UvGj6ZmBCefaq19eBHAmDr9BWRM6A38QBVzExv4o5bzm8WNza6JxpTdEDuJgXPZjszUUO72A220knnyMtXE9IUpc7lAgv6EzbCW+be9/Zmf7njl/2ruH9wPLgnQS47PFHaboNVdf/M+si15WfUBb9zjRZLe5DwiyPc9WRymI3s4XsjjCcG/LMga1NwfryzR3pSxqgWzhtgNdzl+
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(136003)(39860400002)(396003)(366004)(186009)(1800799009)(451199024)(55016003)(38100700002)(38070700005)(6506007)(7696005)(33656002)(86362001)(122000001)(26005)(2906002)(9686003)(83380400001)(71200400001)(478600001)(5660300002)(52536014)(8676002)(4326008)(8936002)(6916009)(41300700001)(66946007)(66556008)(66476007)(64756008)(76116006)(316002)(54906003)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DD6wL2T3W+TXQH7LB6+RgJmSkbWHVFjUlSPOpkLRL1H6zoTkkABXzOYmMOZJ?=
 =?us-ascii?Q?skI1dAdL0EfF1GCllZebFF5qESvAjqufzVyXcCEVK/Ao1yF1dziuOfi2XjyR?=
 =?us-ascii?Q?CTC9uyJE4fcCH+Tv8HdUpZraeXuOS1mWlzPs0EAbeU05yFk26XzUnPzrpwhX?=
 =?us-ascii?Q?RSe462kHSqkyJi/3moHD1l7txbHy6OPeKKtwc2y6y8EcrgEjobAjqXZURAKN?=
 =?us-ascii?Q?BAG+xVNEliUQjRHVpXOq+uq0+AQTnofy9UhA9wg8pCiHY+Nmf7Dtx1mFqxl6?=
 =?us-ascii?Q?z1I1udEIK9u6lylruezxaB1TcAzjTnEyl6vIpGQtxU4aqC6jwWRyoolfBw3R?=
 =?us-ascii?Q?BsMl1IZNv0CfPwdqI6Lx7R4Q/Ph9oncdgJ/HHqblaRpstJcHCDwk/b1H8vNN?=
 =?us-ascii?Q?r1MmJqUA5P4TBdJ/uM9XpDSlFGYNRRO3PkQRb+mlilu6HM42Dheoj1LcVlwb?=
 =?us-ascii?Q?osqj0dIB0osGneqk97pqb6DrXhpd3ujQTR3OMSx+W1p5M2/rcE7Odw2oQQkD?=
 =?us-ascii?Q?gTTNNK+T4ZgFiY92Z6O+vxULpKaPV4SkfhJRvKa0IoILUwm40jdqpL9W6yZ9?=
 =?us-ascii?Q?Gn7vCoHJP/ebHZkYta00QNmSZ5gaO///NleSM9YDZTllitALde8L5AELu5UB?=
 =?us-ascii?Q?xGiwJe2bWXAJRxx4LsOuYZN/Sf8WxZHbweWYE+MItS9aRHwcBQMSuq6PPiES?=
 =?us-ascii?Q?+jiBfCFFUAlnQhqNc3EXth+rucw6HCavwmBN8Pex1gVF3esx/Xz/P5gUiNLx?=
 =?us-ascii?Q?Ub5i5rbodFhgAiYw8hHgDbkjPF8d2o14x/0dQfGOX8UYC30+PYmvI8cleJAr?=
 =?us-ascii?Q?hLv5vIJi/Ehtm9o6JmeFgNnGc8s7SPALUA9HUXBkAlcO0fAXT8znuQkTkv1Y?=
 =?us-ascii?Q?nuwpGGFsFBQ8fjpQg5NmFvCJYFxdSnFyPBLmLzr8qeQSURP5EAQ4lZW/ORpt?=
 =?us-ascii?Q?WfYOtskJvwlKdE3K9Xjda0gtPTV9OFVt3nevzEswl9h08qEfaGYvKUrNiTWE?=
 =?us-ascii?Q?6kpTsL7iMaxfhnfC0HXsHVLB38anfOBnWEUYFDuRq64mpPG3fgkO2ENCJcna?=
 =?us-ascii?Q?mUBhIRYJG22yjW+d538M57fTMIV8kzu6cNKk4jo3fqkEUcWJm37i6H+oCpi2?=
 =?us-ascii?Q?eNSPnDqgkdLHZSgPX2TCyJ+3fbnNiUrvS0bhv5rrABq6HFsZgqfPQVVjY5ql?=
 =?us-ascii?Q?auYEde3U8hT9+j/us3lCedfanymCGaU4rn3D73bTgG4PX82jrsrwchAO1/VM?=
 =?us-ascii?Q?BpJn8zutc1SiYJmUXu+CLVu1m5mnEqalbljvbBoezBGfh1abpazwYqO0HiXp?=
 =?us-ascii?Q?p0YCr47eZ2MEq4A8QlKKZVH650HF4f4A/nVglBHeZG/Of5cumzaV5Axp0Z/R?=
 =?us-ascii?Q?kL/qaY8hFYc0zpqrmsbm3JUEVLKMPoU8P5EGuuL+4Jvn/763XQ8raz5WF8Ev?=
 =?us-ascii?Q?9oLVlo1+TdVq1BDznV9AcGIcx0f5pZ95ki5o37tbzgRN9i6FIVd82FHC77Cr?=
 =?us-ascii?Q?Ye2avI02jQJ8nIRMQWhgq0AHAp9OmI3LfVQ0oWuIC9PDgvaQPV7tGV+Vpj/S?=
 =?us-ascii?Q?EJLe4p+OEN+U86yFC5JJz9JDGmL5UoZDqrn3DhZ0uIbD8CPNZddR3KsGCz+I?=
 =?us-ascii?Q?Vg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4744c105-b093-4d52-657c-08dbb92df5c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2023 16:32:05.0606
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iBCBcxqKVciiJ2NlKywyE0eeF089mWNlbhr47vLh1yrshSRNyd0jGWPhIrq1OkR1i+KMeVR581Fyh4G6ekKoEpcYr3bytVmWzDLzDl2LahM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB11114
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc Zyngier,

> Subject: Re: [PATCH 3/3] irqchip: renesas-rzg2l: Fix irq storm with edge
> trigger detection for TINT
>=20
> On Tue, 19 Sep 2023 16:24:53 +0100,
> Biju Das <biju.das.jz@bp.renesas.com> wrote:
> >
> > Hi Marc Zyngier,
> >
> > Thanks for the feedback.
> >
> > > Subject: Re: [PATCH 3/3] irqchip: renesas-rzg2l: Fix irq storm with
> > > edge trigger detection for TINT
> > >
> > > On Mon, 18 Sep 2023 13:24:11 +0100,
> > > Biju Das <biju.das.jz@bp.renesas.com> wrote:
> > > >
> > > > In case of edge trigger detection, enabling the TINT source causes
> > > > a phantum interrupt that leads to irq storm. So clear the phantum
> > > > interrupt in rzg2l_irqc_irq_enable().
> > > >
> > > > This issue is observed when the irq handler disables the
> > > > interrupts using
> > > > disable_irq_nosync() and scheduling a work queue and in the work
> > > > queue, re-enabling the interrupt with enable_irq().
> > > >
> > > > Fixes: 3fed09559cd8 ("irqchip: Add RZ/G2L IA55 Interrupt
> > > > Controller
> > > > driver")
> > > > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > > > Tested-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> > > > ---
> > > >  drivers/irqchip/irq-renesas-rzg2l.c | 6 ++++++
> > > >  1 file changed, 6 insertions(+)
> > > >
> > > > diff --git a/drivers/irqchip/irq-renesas-rzg2l.c
> > > > b/drivers/irqchip/irq-renesas-rzg2l.c
> > > > index 33a22bafedcd..78a9e90512a6 100644
> > > > --- a/drivers/irqchip/irq-renesas-rzg2l.c
> > > > +++ b/drivers/irqchip/irq-renesas-rzg2l.c
> > > > @@ -144,6 +144,12 @@ static void rzg2l_irqc_irq_enable(struct
> > > > irq_data
> > > *d)
> > > >  		reg =3D readl_relaxed(priv->base + TSSR(tssr_index));
> > > >  		reg |=3D (TIEN | tint) << TSSEL_SHIFT(tssr_offset);
> > > >  		writel_relaxed(reg, priv->base + TSSR(tssr_index));
> > > > +		/*
> > > > +		 * In case of edge trigger detection, enabling the TINT
> source
> > > > +		 * cause a phantum interrupt that leads to irq storm. So
> clear
> > > > +		 * the phantum interrupt.
> > > > +		 */
> > > > +		rzg2l_tint_eoi(d);
> > >
> > > This looks incredibly unsafe. disable_irq()+enable_irq() with an
> > > interrupt being made pending in the middle, and you've lost that
> interrupt.
> >
> > In this driver that will never happen as it clears the TINT source
> > during disable(), so there won't be any TINT source for interrupt
> > detection after disable().
>=20
> So you mean that you *already* lose interrupts across a disable followed =
by
> an enable? I'm slightly puzzled...

There is no interrupt lost at all.=20

Currently this patch addresses 2 issues.

Scenario 1: Extra interrupt when we select TINT source on enable_irq()

Getting an extra interrupt, when client drivers calls enable_irq() during p=
robe()/resume(). In this case, the irq handler on the
Client driver just clear the interrupt status bit.

Issue 2: IRQ storm when we select TINT source on enable_irq()

Here as well, we are getting an extra interrupt, when client drivers calls =
enable_irq() during probe() and this Interrupts getting generated infinitel=
y, when the client driver calls disable_irq() in irq handler and in in work=
 queue calling enable_irq().

Currently we are not loosing interrupts, but we are getting additional
Interrupt(phantom) which is causing the issue.

Cheers,
Biju


