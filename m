Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADB2D7AB3BC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 16:35:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbjIVOfI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 10:35:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbjIVOfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 10:35:05 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2138.outbound.protection.outlook.com [40.107.114.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28FAA180;
        Fri, 22 Sep 2023 07:34:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zp1+ngPLf6PoNPkpvSeYCnd3nvDGPL9374iz9NHhSbeWWOxXH61Pz5sf2uvnSkMwLIy1rENUq+U1C0vPQHwSUYfXSqjxAXqgy/TC0N1Cu268VIyPvkApt71mRIbQzCnfkgIGj+F88XAeXcbIXlahJ+8Vo94p46nXAxm8NbouVa6ebvE1dUyF6a3IntUzOKiIAtVmTX6CJy5uUSIIJN0U2Mqv+ynbEZlEhjjl/lTblSoYKkjhQGG9vHiIb0JjzprJkF6f9pdHh+lfCLfrHvguZx8QmNTwpp5rKpUYlIpPWrBTRXBxdGjLmoelWwWoKa+BbmnonBjTp6GSPBfml0UmiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=paIMcOs6BJedKY1QleGgtJCctmQIh5kwPRZ6vA9mPfY=;
 b=TkoGbMNsOth0QmGXCqBB3mhBFVsrj9Um8nrP4gz1eAFMdsUOYiT3PtAk+OEdpKla8p5CRPr1KHo6LtUXwOO76mYlqyk5ZP9g+RKNpyDqJBa7aBuZr2RDKwRXBezxqgO75go56DQt/YqEsdVPt5/yytEEZmg/LMB/CqC6EJeSkvzYCY+WbDYemNj53CPUML26blLzGSPqKgy7QnroU8l1+nHkgbF3b6m6AlpPlNhab/pri/IJGLYcn1cP3O930aoyFvT7cRHjbozq1bHcc1onpXP1V0qWMZY+f+t/jABiYFX1a6CVxoWUqpmJEk3a03Vz9Entn2tZSTJOcasdeQ8k6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=paIMcOs6BJedKY1QleGgtJCctmQIh5kwPRZ6vA9mPfY=;
 b=wQYoTvTwFPzRASADfiogAqEhUxPZiJ8GsYNZauBrzgn0Iw2xIenSkxFk+/kd/uIkmCVrD0Qbk/LNm5wibhsy24vKgY7PGJN4fKEVwzlPH0QGWHME4MEAe7cBp5XO5DwGsemHBHVPR5xQtWhty54TBdbGv67RYbdPowrsuVXps3Q=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OSZPR01MB8631.jpnprd01.prod.outlook.com (2603:1096:604:18f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Fri, 22 Sep
 2023 14:34:53 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::9d23:32f5:9325:3706]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::9d23:32f5:9325:3706%5]) with mapi id 15.20.6813.024; Fri, 22 Sep 2023
 14:34:51 +0000
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
Thread-Index: AQHZ6isSnZZc/iqk1kePfAP8iH4mBLAiOWYAgAALsBCAABCYgIAAACWAgAAIUICAAALY8IACjJIAgAGXpyA=
Date:   Fri, 22 Sep 2023 14:34:51 +0000
Message-ID: <OS0PR01MB5922789D378A9D4D27F8C77086FFA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230918122411.237635-1-biju.das.jz@bp.renesas.com>
        <20230918122411.237635-4-biju.das.jz@bp.renesas.com>
        <86y1h2cjpb.wl-maz@kernel.org>
        <OS0PR01MB5922748F489467BE2539AA1886FAA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
        <87cyye3zly.wl-maz@kernel.org>
        <OS0PR01MB59228AD24951D49F3E639BFF86FAA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
        <87a5ti3y7i.wl-maz@kernel.org>
        <OS0PR01MB592242E8A1A3A22CD1B74A1986FAA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <871qes3qqp.wl-maz@kernel.org>
In-Reply-To: <871qes3qqp.wl-maz@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|OSZPR01MB8631:EE_
x-ms-office365-filtering-correlation-id: 6c405cec-01c0-4bd1-5b7c-08dbbb7914d2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: T5/J8hG09m2sspuaWqZ8huqLkoCw7Eg0rUY/AiKUYlyrCGPYt1Vw+NvbhnQ9aNF5p8YrA4pDiZGbm5+CzUNIE3dNU4gdoys3NRZFaqCpU+qHZCjGbwx0JGCWZplo60zUa5P6hIdxh/BOD98XlrPl35e+k7SBlh/4Wkf0ahAqEgN56NPHVhaNWY3k/bjtntIM72mSgpuDiaM4788YDuoeOcfxRcVDZKXw9W333ZNHmuLFOqy9D4bb4JItdJtF7S2T5Cktp5lmkGdu/Ie+palbvq1DHxKxhDU7SpWGjMlwASDxXk7us7CBIyU12eQZXzWvDy9buewz1QdPUDCsnkENJX2CLCoVP0yP6z2+iTOmuGfSTrqz3lVFMAYyGQYuJOHPlZ8ReIuvW0C+5qiVHeMla/ltjKfp+ISINBMFUJ0V7an7kYTju8n3ST4iKjcEkEXaaPoOKzORUQxLeo8yf/Q7rxtKj0c5mIdeRC0pk33Ab0epLGx+/BRCryczfuKGpneLHSQ/kwk77CjJNJDL1NlOghc0a0QC1v0EKWjj65raDA7ky5bWHupwe4JWaHa5m43r1oxxMwJfRmovSU8AghKeJxisyUOejybWw+fsslJOBQNhJl1pGtOfl3ihelGNK32Z
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(39860400002)(366004)(136003)(396003)(186009)(1800799009)(451199024)(9686003)(38100700002)(38070700005)(33656002)(122000001)(55016003)(86362001)(83380400001)(76116006)(66556008)(66476007)(66946007)(54906003)(66446008)(64756008)(2906002)(4326008)(6916009)(8936002)(8676002)(52536014)(41300700001)(316002)(5660300002)(71200400001)(7696005)(6506007)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?buHFAlisPYLtU+6hIFIN9A6+pe+EpcaQDSoqmOFmwjHKiGjkjjX5XRXZLql4?=
 =?us-ascii?Q?TAVA4SSrwOt1Wu4cebnqJbE+hetgn1j634AMP7fyaH9v3gjO5rGCnMpTQydi?=
 =?us-ascii?Q?0k2CCdorS8o5C7dfog6HDKiwo2DPV45xSscdvLffhvBMpgg+pRcytPjU0fcb?=
 =?us-ascii?Q?lo4d8a3R89LK4iIBBopp5Z+1YnbMgg1kYpqDMIGcOldPT/7IdFdKELvu2X03?=
 =?us-ascii?Q?LC59XO9PbiMQPD5Z/eBvFBJxytXm3bXJdwJF5UwlcThaLYU37szFcOW2j/Ek?=
 =?us-ascii?Q?AO0Rs6xeitC5IFmVXwtfeV3RrCotAVi76+ohYL8eTRMicRI4biL9unSnm7XP?=
 =?us-ascii?Q?9Qj7fS6K5JNWB55AoNxU8mLDDHNcr3NNTSabqm4s3w0+g/FXkDGHO6h924KT?=
 =?us-ascii?Q?L5ZrWfKCpRAF5iWvbxCBJp+pdP8I2ozJxaGLS0clZJgYBA6qd4Rb8KRkznvg?=
 =?us-ascii?Q?/ZqCh5cNXt0vmrcETPTIguJg+8hxPdjRXkmO9OmktHYs70IWzJusjF0d4rFU?=
 =?us-ascii?Q?63dHUbS62e9XYKl4xrm03W6470h5tLBt5+PSo/OZKBsx+tqB6kECP4X9dCAM?=
 =?us-ascii?Q?KPK0HoS/9n53jCC/Ei4eC6foQdCowKepQ2t1b/4YxN7iLtN6h3OTV8fI//5z?=
 =?us-ascii?Q?a+9+zCtzpAQGfvFqjzdv6uB/++egrzuZPelmBAHe0Jrur9n+XNtHVYwg7tMQ?=
 =?us-ascii?Q?t6Kb4GDx/iI5P0Hb0ogw1u3hWg0M8V6tuFWt0eNsfY5erIxvb3A4eUqPtpS4?=
 =?us-ascii?Q?x7PQo2si9EnPC4x2prN6O8e14k1v+pMUYW2aMykj1gIVznK3hPdkuXAnRWsH?=
 =?us-ascii?Q?ahPjmUFJFNPQf1Z3sBcwh9TmWbBl5xG1Ds2rRbqpeERFlMcrhagSKyHb0CYM?=
 =?us-ascii?Q?S9KuI3rDuNJicBx5sHM1rtiZk/8Py4A/YxE55tQ6VMN0sLCk3yyWLiph2Xes?=
 =?us-ascii?Q?8tNulOKUmvpuWOcHMCaTznI9jASBic3EuJlEClFxZDYOOGzu6opdvs3kbWny?=
 =?us-ascii?Q?cXjJ80s7yI3k6XUPf1HSwGJOReOi//mFvK1heNBLa0Eb2Rp5Ely9uxLw4M31?=
 =?us-ascii?Q?8J21t141nJZiMZN114P+hOSuIvrlgA7TAzBBoXF8Oc7B+5P5SLi3puk3xNcq?=
 =?us-ascii?Q?7m1BOvwxr2vgaadCsPqEWjx/CUqMT2l+fJIc5uD2JpaKMqYxWKXWXw81KVA2?=
 =?us-ascii?Q?jMG0zV/JWBiFZUQDYWZzCriV1WcWSePG8y06czcAYT9TR3oh0qjKe1eOvUrS?=
 =?us-ascii?Q?29Vrqs5SwSyT6suYgI37wo9JhaLLL1dQprDdlSmLYPbV+dN1ijloEA7R6mYq?=
 =?us-ascii?Q?aCHhCPrb3Dk5EJ+U2/4ejqeHQn3q5Kb+IBUnrWzrIVLzbLe+LzAfwyw+GNcd?=
 =?us-ascii?Q?7WI/JvDaFarn+Nox8SvGi9pnPOdWyrpau5XvUp489nbgj0/2ROCVDYUPKg/p?=
 =?us-ascii?Q?ZW1oRmAur83YTGzfadqVVlq8b4A+W+BcuANPIzIqd98St/UfV07HK2Bx9N5f?=
 =?us-ascii?Q?uTvncuD6F7rBqiEVrERAYA3TUGaaxSc+j10Am8Je8B26Gfi2Y0RB+dkswlBq?=
 =?us-ascii?Q?4/AvsK53b9XQlMh0NzE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c405cec-01c0-4bd1-5b7c-08dbbb7914d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2023 14:34:51.7224
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q2qSUNPZnbtmBhAjASm09R+dZjwyOoH5+uxX4HYaI1btU72GyJkHEyYJmGV3EW89IHoDB8WivHGcASvBoXyj5MtqHMPCErsDIks6g2JfvAI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8631
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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
> On Tue, 19 Sep 2023 18:06:54 +0100,
> Biju Das <biju.das.jz@bp.renesas.com> wrote:
> >
> > Hi Marc Zyngier,
> >
> > > Subject: Re: [PATCH 3/3] irqchip: renesas-rzg2l: Fix irq storm with
> > > edge trigger detection for TINT
> > >
> > > On Tue, 19 Sep 2023 17:32:05 +0100,
> > > Biju Das <biju.das.jz@bp.renesas.com> wrote:
> > >
> > > [...]
> > >
> > > > > So you mean that you *already* lose interrupts across a disable
> > > > > followed by an enable? I'm slightly puzzled...
> > > >
> > > > There is no interrupt lost at all.
> > > >
> > > > Currently this patch addresses 2 issues.
> > > >
> > > > Scenario 1: Extra interrupt when we select TINT source on
> > > > enable_irq()
> > > >
> > > > Getting an extra interrupt, when client drivers calls enable_irq()
> > > > during probe()/resume(). In this case, the irq handler on the
> > > > Client driver just clear the interrupt status bit.
> > > >
> > > > Issue 2: IRQ storm when we select TINT source on enable_irq()
> > > >
> > > > Here as well, we are getting an extra interrupt, when client
> > > > drivers calls enable_irq() during probe() and this Interrupts
> > > > getting generated infinitely, when the client driver calls
> > > > disable_irq() in irq handler and in in work queue calling
> enable_irq().
> > >
> > > How do you know this is a spurious interrupt?
> >
> > We have PMOD on RZ/G2L SMARC EVK. So I connected it to GPIO pin and
> > other end to ground. During the boot, I get an interrupt even though
> > there is no high to low transition, when the IRQ is setup in the
> > probe(). From this it is a spurious interrupt.
>=20
> That doesn't really handle my question. At the point of enabling the
> interrupt and consuming the edge (which is what this patch does), how do
> you know you can readily discard this signal? This is a genuine question.
>=20
> Spurious interrupts at boot are common. The HW resets in a funky,
> unspecified state, and it's SW's job to initialise it before letting othe=
r
> agents in the system use interrupts.

I got your point related to loosing interrupts.

Now I can detect spurious interrupts for edge trigger.

Pin controller driver has a read-only register to monitor input values of G=
PIO input pins, use that register values before/after rzg2l_irq_enable() wi=
th TINT Status Control Register (TSCR)
in IRQ controller to detect the spurious interrupt.

Eg:
1) Check PIN_43_0 value (ex: low)in pinctrl driver
2) Enable the IRQ using rzg2l_irq_enable()/ irq_chip_enable_parent()in pinc=
trl driver
3) Check PIN_43_0 value (ex: low) in pinctrl driver
4) Check the TINT Status Control Register(TSCR) in IRQ controller driver

     If the values in 1 and 3 are same and the status in 4 is set, then the=
re is a spurious interrupt.

>=20
> >
> > > For all you can tell, you are
> > > just consuming an edge. I absolutely don't buy this workaround,
> > > because you have no context that allows you to discriminate between
> > > a real spurious interrupt and a normal interrupt that lands while
> > > the interrupt line was masked.
> > >
> > > > Currently we are not loosing interrupts, but we are getting
> > > > additional
> > > > Interrupt(phantom) which is causing the issue.
> > >
> > > If you get an interrupt at probe time in the endpoint driver, that's
> > > probably because the device is not in a quiescent state when the
> > > interrupt is requested. And it is probably this that needs addressing=
.
> >
> > Any pointer for addressing this issue?
>=20
> Nothing but the most basic stuff: you should make sure that the interrupt
> isn't enabled before you can actually handle it, and triage it as spuriou=
s.

For the GPIO interrupt case I have,

RTC driver(endpoint)--> Pin controller driver -->IRQ controller driver-->GI=
C controller.

1) I have configured the pin as GPIO interrupts in pin controller driver
2) Set the IRQ detection in IRQ controller for edge trigger
3) The moment I set the IRQ source in IRQ controller=20
   I get an interrupt, even though there is no voltage transition.

Here the system is setup properly, but there is a spurious interrupt. Curre=
ntly don't know how to handle it?=20

Any pointers for handling this issue?

Note:
 Currently the pin controller driver is not configuring GPIO as GPIO input =
in Port Mode Register for the GPIO interrupts instead it is using reset val=
ue which is "Hi-Z". I will send a patch to fix it.

Cheers,
Biju
