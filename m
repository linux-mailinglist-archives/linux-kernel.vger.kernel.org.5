Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35AE27BB595
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 12:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231821AbjJFKqd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 06:46:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231335AbjJFKqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 06:46:30 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2096.outbound.protection.outlook.com [40.107.114.96])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C9CF83;
        Fri,  6 Oct 2023 03:46:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k3kqmdZ9rB+E3GkURrGpSjDOXk/5/mlPw2ZVWjql1ZM2YKfddswAQRs+ZENE7IS6KLYcd+v3tpyXAN+fycNJPJ2g4gbmuqBFookUSwdSBQqDNkms9AGXVS0jz1hOEzoaGE940dD+KPGxqierXC6GHJKxcbMj/epcvaB4keHozn2iKfZdLOJinUYHzfcs7vNSiZ6p5nr2ZREL0yM1U2gbfhO4UmMCWMK5dyMpCw3NkBJa+gllF6pxAmxB2WGT+rSWDTW9RUR23La6sJEwL0A1kc+ZfrNPGIcPwM7s3bVTXJr95ZnM0d+Lt3HyG0wNKBvl3ht1pc/bBkr/zMKmYkgsIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h4roJ2hOLQeKgN3oC2UPicRKPoV8AhPX4UGnE/CCl/o=;
 b=Hq0K7Za94P9Bdqwua7mIFfINcj0PPvxTPjA9EEWJ5Xei6WzDLh8Gl7DSDZ2Iim54qfXRE5QpxhY4Xg4D1S9Qbmtx8KjHHyjhlR5de1K47cx5mQxB1xZGIeTy/w17RbSRYTLSsx4UoBMRQjgsr9lSQo7fGwX8AGELkvbfoP4mEH/3ghp/Bxx8vTo9vewVmxhismopdsk6NqRTsSiNRdY+DLNVtWhCuW0zMfty4qgEgDowj59qPkgTWYKWaVxehU5jNNXvsiJzjL2/zan0aYDmkYe2+MjPB6fw7kjJ1T5wgsQMZi5X7gS3QsoSOGjemkKl22LW8JRBhZfphNBHuRtQhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h4roJ2hOLQeKgN3oC2UPicRKPoV8AhPX4UGnE/CCl/o=;
 b=oge0dINQwmiKaU1inRGm42epmQ8majSywCtjWdlYHpx/OTuLRzPuxsDL4b6LuQreGAIYXZf7fwSpOv/oD1b+VWlplJ56Oj0ORdz5TqIP8qE2L4PxtiV9wzd7920aae16iH0b3PO7Wrmjx2Dk0q026V/yVl0BZBXluEcxRekwc+0=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYBPR01MB5455.jpnprd01.prod.outlook.com (2603:1096:404:8026::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.34; Fri, 6 Oct
 2023 10:46:25 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::fb78:2e8c:f7f9:5629]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::fb78:2e8c:f7f9:5629%7]) with mapi id 15.20.6838.033; Fri, 6 Oct 2023
 10:46:25 +0000
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
Thread-Index: AQHZ6isSnZZc/iqk1kePfAP8iH4mBLAiOWYAgAALsBCAABCYgIAAACWAgAAIUICAAALY8IACjJIAgAGXpyCAFilzAA==
Date:   Fri, 6 Oct 2023 10:46:25 +0000
Message-ID: <OS0PR01MB5922BDC3269CAE6624CFA5B086C9A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230918122411.237635-1-biju.das.jz@bp.renesas.com>
        <20230918122411.237635-4-biju.das.jz@bp.renesas.com>
        <86y1h2cjpb.wl-maz@kernel.org>
        <OS0PR01MB5922748F489467BE2539AA1886FAA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
        <87cyye3zly.wl-maz@kernel.org>
        <OS0PR01MB59228AD24951D49F3E639BFF86FAA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
        <87a5ti3y7i.wl-maz@kernel.org>
        <OS0PR01MB592242E8A1A3A22CD1B74A1986FAA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <871qes3qqp.wl-maz@kernel.org>
 <OS0PR01MB5922789D378A9D4D27F8C77086FFA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
In-Reply-To: <OS0PR01MB5922789D378A9D4D27F8C77086FFA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYBPR01MB5455:EE_
x-ms-office365-filtering-correlation-id: 01c9bdae-6ec3-49d6-47c1-08dbc6597cd0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: b5qlv59kDWeUvWyjSpb/JXkjHGHqSRM1YY740gSfWmWyEwpWpvOVjEL38h1A/iHRIK3TbABhZqqqnBAUZilQ5nlMmx870bZ97ylTU6IvlUgQddjJgnLn0HJruREEqofB3oJdtP/9/S6g7/puKvnIcW1hVdvE8gnjB63pXlIxkLHtLPkbGMAqrFWQ3OBB07TP9oCNDOyal2iAMT5HSbeK02kRWO9Vd9pIgzGtSZdTfbbksU3t5ALJ+4uU23LW+Qw1fWlaptDlGbo+bNpFyx1pbH9t0OdMC+OM1T/0z97eVexkQP9qzYbPmZcmPFoHQyYy60XSdW3CrkOeo91T28HsIaeNkgTRRXDOnyqADlZzddWlyT4mEqDHSWfrv3ku/MpiIKCKmCzi6sKBab62k/Kxpz6DP2WO1Ck3zIwLkjXt0s4ckFMrHHuW2Oa5+hnBUDT5xtu+FIKdSudeTdKbsw+AFBcQexJx4JJOCmG/XWkmiIlbh+8H6kCmTbRozCfArDLfMw74D3qYCSb1KhI0Xs5vNifYwtt/PvCEAtxyNvCpLfOW+W8ES94wv1LGDepVqLm3xLzuK0KA0tvGq30GOEldk99eW4M5dYd9EALjqKoL21KIL7YJ2cy2o5VZYnbGjo58
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(346002)(396003)(376002)(366004)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(71200400001)(41300700001)(5660300002)(9686003)(122000001)(86362001)(52536014)(478600001)(38100700002)(7696005)(8936002)(38070700005)(66446008)(4326008)(8676002)(6506007)(2906002)(64756008)(26005)(66946007)(54906003)(66476007)(66556008)(316002)(55016003)(6916009)(83380400001)(33656002)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fpjZxL86iSzAO51KD9nBKz/OWOmaotIRyTZAZWd3ghbPn5RI1yP8PzJDtEJb?=
 =?us-ascii?Q?EKzMf56YQxKxakWKtjwQVVKnAWjukSFmfnVSkYl7ewzzBF7X4gQn83tW0I3v?=
 =?us-ascii?Q?y+FZHjQva8aVVlwqKtR2pifHdeUUSwcbKNVXs5+pKFSexicTn9BaR8Aeg+c4?=
 =?us-ascii?Q?31gCbMSdE9qZxTkR8kutU/9xIWPRuylZ/wcOiZiT1aWfd9cR2M+Qlr3+fCbD?=
 =?us-ascii?Q?5al+wNNDvCB1jYD3C+kxDrBu53tgTJRbt3MoCEZYaH8Ac5744Rx5lr+dfrdK?=
 =?us-ascii?Q?aqNuSHbyapbVAZWtLs/1tDBLe3nJxm69x+e5kwFCVM5g05WlZDWd9lQ7fucb?=
 =?us-ascii?Q?acaWk4amMan0yMcDMIYvA4lucleI9QnQteFpVZjKtImPpit09R164CqWPTMC?=
 =?us-ascii?Q?XD0A2o7+ND3lIUsgbCU1f6B9hAKR9MeQbVBk9GYfx91QQWFsAPwKO5TEnYcP?=
 =?us-ascii?Q?KMSfNqJFaxhFs7v5i1tOzXdO1/EaoD+joa9KwXdFeFZ8D/9tLkRc9ObT9SOJ?=
 =?us-ascii?Q?h7O1Xkg0JMzxjtBTH75mnzhxIvaGmIF7BkGlAB/hc93IVMn3v2sUv44wZ+kS?=
 =?us-ascii?Q?1dC02X9rRLcGnWIqcchX7eawJGFh5ZNp985s5SnlEUkky/S8QQVvU1sASufi?=
 =?us-ascii?Q?VTrf+tQWfsuX2NRD92WbA/VoALUwGf6a/VQNw6766qWUDhl8hYrbMwlqdJ3e?=
 =?us-ascii?Q?Rc0J6Pz9zHkRFPxa00gHfz2NBnoziKyf41hfi2JN95v/sXBWWdFLAXF72CJG?=
 =?us-ascii?Q?hpLE/bbho2u5fFKgKbKjgqsS4+aouyR7X6kAgt1dimLf9wpxJJZl+UeBvXae?=
 =?us-ascii?Q?tRzIwpPmsBnZ0bnM916M3qPl7bzoUeJdlSbYnDrNXrAMO1+cihBGV6X5MBRF?=
 =?us-ascii?Q?WmzWJFDUNe7EtRLLjUsGHT1czO7mjThrepjztXauk6qqPKQoNWx4GE0drbS2?=
 =?us-ascii?Q?hFAIp/Ls0SrZeCuaJuWU/LTeQSn+q95CnQxZmjP5NkDuVIXhn3xtgl0lmFGc?=
 =?us-ascii?Q?0OAgTg0sR8wm6tskNYJn1WuMsTgD9PFOOjKQFqQtfflbRab7qcdbmZGhMqVR?=
 =?us-ascii?Q?HNlBTlCnjeU2v5yyBKMIOxTWPPibAPk1wu+6D6qRZj8WePDCUps987awB6Jh?=
 =?us-ascii?Q?bjg/8KJ23BNJurjp1ARyZ2H1ZB1ftvpu/WYcZQFCZ7V3vDFuHls0de/ao+Yd?=
 =?us-ascii?Q?HNHbE7XGKe8UsCuRCT4d5t4VV8lgcTzr6zEIgRhQE8QRNos2phipM6KazP5t?=
 =?us-ascii?Q?8c3q701mF5c4Xa3RBr5Lu++PdmCZenvsR3tY/hIRTw4gBpDq8Xs9hH5yw194?=
 =?us-ascii?Q?Gu5iL9CzrZdrC78KD08RYUD/GKwzZwNJMK96YG1ti85OL30jPCi3SOSyJDt2?=
 =?us-ascii?Q?0jWBKbehSUhUI6v7xGTGp3ptawQfvlEjFOa1bZI5atHdjImfiIcr1fmrhX1l?=
 =?us-ascii?Q?L7/MQxdJEa3bwpfuJz9RYUoF/8MARUxY3FrtvIPHi2gRuIjptJxOc/+XeIDv?=
 =?us-ascii?Q?SmxFULSYQyIsRYwlp4/RQ5Ndg7Qx/TSnPLQuXLQQGn+0qPX/HMx0uD3I4uwo?=
 =?us-ascii?Q?Yd7Rrg/+MN4uCePo5jMOJIhuMpEhA8LOfd88+p+zqccbBLOvtXshuOjkv3M6?=
 =?us-ascii?Q?XA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01c9bdae-6ec3-49d6-47c1-08dbc6597cd0
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2023 10:46:25.0876
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0BDsJ7oYUoE6JNCFs5ZaPwt1r24jIugo0Qkpj2IRN6oUsWXQDzIBOwU9d1GdvBdVcBesqD/GDvPUiffJZ1hj3acI/5Khe9r9gHlDPxKX8P0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYBPR01MB5455
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

> Subject: RE: [PATCH 3/3] irqchip: renesas-rzg2l: Fix irq storm with edge
> trigger detection for TINT
>=20
> Hi Marc Zyngier,
>=20
> Thanks for the feedback.
>=20
> > Subject: Re: [PATCH 3/3] irqchip: renesas-rzg2l: Fix irq storm with
> > edge trigger detection for TINT
> >
> > On Tue, 19 Sep 2023 18:06:54 +0100,
> > Biju Das <biju.das.jz@bp.renesas.com> wrote:
> > >
> > > Hi Marc Zyngier,
> > >
> > > > Subject: Re: [PATCH 3/3] irqchip: renesas-rzg2l: Fix irq storm
> > > > with edge trigger detection for TINT
> > > >
> > > > On Tue, 19 Sep 2023 17:32:05 +0100, Biju Das
> > > > <biju.das.jz@bp.renesas.com> wrote:
> > > >
> > > > [...]
> > > >
> > > > > > So you mean that you *already* lose interrupts across a
> > > > > > disable followed by an enable? I'm slightly puzzled...
> > > > >
> > > > > There is no interrupt lost at all.
> > > > >
> > > > > Currently this patch addresses 2 issues.
> > > > >
> > > > > Scenario 1: Extra interrupt when we select TINT source on
> > > > > enable_irq()
> > > > >
> > > > > Getting an extra interrupt, when client drivers calls
> > > > > enable_irq() during probe()/resume(). In this case, the irq
> > > > > handler on the Client driver just clear the interrupt status bit.
> > > > >
> > > > > Issue 2: IRQ storm when we select TINT source on enable_irq()
> > > > >
> > > > > Here as well, we are getting an extra interrupt, when client
> > > > > drivers calls enable_irq() during probe() and this Interrupts
> > > > > getting generated infinitely, when the client driver calls
> > > > > disable_irq() in irq handler and in in work queue calling
> > enable_irq().
> > > >
> > > > How do you know this is a spurious interrupt?
> > >
> > > We have PMOD on RZ/G2L SMARC EVK. So I connected it to GPIO pin and
> > > other end to ground. During the boot, I get an interrupt even though
> > > there is no high to low transition, when the IRQ is setup in the
> > > probe(). From this it is a spurious interrupt.
> >
> > That doesn't really handle my question. At the point of enabling the
> > interrupt and consuming the edge (which is what this patch does), how
> > do you know you can readily discard this signal? This is a genuine
> question.
> >
> > Spurious interrupts at boot are common. The HW resets in a funky,
> > unspecified state, and it's SW's job to initialise it before letting
> > other agents in the system use interrupts.
>=20
> I got your point related to loosing interrupts.
>=20
> Now I can detect spurious interrupts for edge trigger.
>=20
> Pin controller driver has a read-only register to monitor input values of
> GPIO input pins, use that register values before/after rzg2l_irq_enable()
> with TINT Status Control Register (TSCR) in IRQ controller to detect the
> spurious interrupt.
>=20
> Eg:
> 1) Check PIN_43_0 value (ex: low)in pinctrl driver
> 2) Enable the IRQ using rzg2l_irq_enable()/ irq_chip_enable_parent()in
> pinctrl driver
> 3) Check PIN_43_0 value (ex: low) in pinctrl driver
> 4) Check the TINT Status Control Register(TSCR) in IRQ controller driver
>=20
>      If the values in 1 and 3 are same and the status in 4 is set, then
> there is a spurious interrupt.
>=20
> >
> > >
> > > > For all you can tell, you are
> > > > just consuming an edge. I absolutely don't buy this workaround,
> > > > because you have no context that allows you to discriminate
> > > > between a real spurious interrupt and a normal interrupt that
> > > > lands while the interrupt line was masked.
> > > >
> > > > > Currently we are not loosing interrupts, but we are getting
> > > > > additional
> > > > > Interrupt(phantom) which is causing the issue.
> > > >
> > > > If you get an interrupt at probe time in the endpoint driver,
> > > > that's probably because the device is not in a quiescent state
> > > > when the interrupt is requested. And it is probably this that needs
> addressing.
> > >
> > > Any pointer for addressing this issue?
> >
> > Nothing but the most basic stuff: you should make sure that the
> > interrupt isn't enabled before you can actually handle it, and triage i=
t
> as spurious.
>=20
> For the GPIO interrupt case I have,
>=20
> RTC driver(endpoint)--> Pin controller driver -->IRQ controller driver--
> >GIC controller.
>=20
> 1) I have configured the pin as GPIO interrupts in pin controller driver
> 2) Set the IRQ detection in IRQ controller for edge trigger
> 3) The moment I set the IRQ source in IRQ controller
>    I get an interrupt, even though there is no voltage transition.
>=20
> Here the system is setup properly, but there is a spurious interrupt.
> Currently don't know how to handle it?
>=20
> Any pointers for handling this issue?
>=20
> Note:
>  Currently the pin controller driver is not configuring GPIO as GPIO inpu=
t
> in Port Mode Register for the GPIO interrupts instead it is using reset
> value which is "Hi-Z". I will send a patch to fix it.

An update, I have found a way to fix the spurious interrupt issue.

Spurious interrupt is generated if we do simultaneous writing of
TINT Source selection and TINT Source enable in TSSRx register.

If we write the register in correct order, then there is no issue.
i.e., first set the TINT Source selection and after that enable it.

Looks like it is a HW race condition. I am checking this issue with HW team=
.

Cheers,
Biju
