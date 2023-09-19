Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65B907A6960
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 19:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231661AbjISRHK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 13:07:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbjISRHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 13:07:08 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2126.outbound.protection.outlook.com [40.107.114.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C5B5EC;
        Tue, 19 Sep 2023 10:06:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U6q2xKxa2ZO4aX3GzC3GLwJxC9N9i4KGeDaGwzZRcKy+loIMnn5nfM68J2clIJnPHD8CMdkH3OS0lUajGowBM8TZDUNx+VtSYn8ky1HbqjrF9uAO/QjKP3Qs/S1trqHp3ZirETwIididVLicg/wYRuL9BghEJv+T/+FyDbe928rATcd+fU0TQ7EB5/6SVIZYGDWGthPfHGFqkiEK549km9MnzPN96QW9y+y73DUE3cke7LBPuPXLO+r2myBsAPflPEMRX1/a3uLyLgxvH3vcMgZfM4MCrOpCFiM9RnJRNKuJqQTJF+jeRk2qvcLzrv9OmoBpiwkV0wRbaNqb5chg5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uLGrNx3vlOJmHZUrz49S+wyElou41Q1qks7ROObO2Jw=;
 b=gjb+a8qI4S+Sssd6r0jsoS0r/ZacowAYyh5D6a2XKxdFO8QOPPjLkCeClSc6VJtMVjP+wIhiWRVvr/McuNY/kDGABvNC2oFS1UT9v9MIzNYI0nhK7waZGZE/1dGPBYLZtQKQ18cc57eCeRTwilpgdlfLfBN72U3/ElZJwsLaJr3ItRI7a4oJLyQudHucfLlBCEs1qUNt+uagV9txppHxNRsmtrbzRdJID7ZEiEge+vnQEAW3X9llJj5L2v9eHjLVhIV8ihIbIj0cibIgo5Jpy7p5/AxriC6xixbBsomlpOigsZ5WCjoOqHwcl8HaFSEbzzWcAfbv/RlVRnyZc6yzlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uLGrNx3vlOJmHZUrz49S+wyElou41Q1qks7ROObO2Jw=;
 b=fApoNw+s3dFg4Rv9c0arsxoq+eGuVZLwW1uILmMUY5YZ9ON5LgGCs/pSalxeVpMlq/5yBpWRHspWrucNia7bLUky5bM3TUgtItdxxF8/P8/mv9g0vpFHbDlPV8F8VF0ILpoGr1tZvft0wRjAQcbzDXSoo3lc/yH8/GQ+tEzNIwM=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYWPR01MB9372.jpnprd01.prod.outlook.com (2603:1096:400:1a5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19; Tue, 19 Sep
 2023 17:06:55 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::9d23:32f5:9325:3706]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::9d23:32f5:9325:3706%5]) with mapi id 15.20.6792.026; Tue, 19 Sep 2023
 17:06:54 +0000
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
Thread-Index: AQHZ6isSnZZc/iqk1kePfAP8iH4mBLAiOWYAgAALsBCAABCYgIAAACWAgAAIUICAAALY8A==
Date:   Tue, 19 Sep 2023 17:06:54 +0000
Message-ID: <OS0PR01MB592242E8A1A3A22CD1B74A1986FAA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230918122411.237635-1-biju.das.jz@bp.renesas.com>
        <20230918122411.237635-4-biju.das.jz@bp.renesas.com>
        <86y1h2cjpb.wl-maz@kernel.org>
        <OS0PR01MB5922748F489467BE2539AA1886FAA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
        <87cyye3zly.wl-maz@kernel.org>
        <OS0PR01MB59228AD24951D49F3E639BFF86FAA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <87a5ti3y7i.wl-maz@kernel.org>
In-Reply-To: <87a5ti3y7i.wl-maz@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYWPR01MB9372:EE_
x-ms-office365-filtering-correlation-id: 6fca8bc7-3a3e-43bc-60ae-08dbb932d35c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /DLOnOex/H3ah0dKA3gh8n5t2DS7p7f1XstBap91EiGMrKuxAcnJNi5Y2bXnSinD45sMuQocs/uFijMA25GhOMZVETKRm7CpYe3oJFS/vbTcK8D0Sr0qjN6ISsWm50MphBPWPEzd0HgeLA6ils3gyNlXErowgOM6Rkebr3F3C1TO/Nv9TUbHjKCUVk2kfwCHxZyroY+3UsPywaPxXq2YFHQOgKtJ8H7mHTOL6r+6rLqy1En8WGuPlwyiFn47XisS6K5Uji9RCKQeetayVOtEUmg9m6MpvPtNAO6wqfE/ozLYOp0l/uZs2AM2JTwB5nfas3qzacgWIlu4xZjZA3VRAkmPS055NK7L1EzsKgBGpicdOcEyjbk4Y4T4oFT+1dEXK3HpNMtj3EW3f+pU8/Wm4Pqj2LsWNARegZfE07F1/XCDk3nyMQ5m2AnbQH0+I2SyOMMg3S9d5OIASeuSoZVNqx6FOntLhOEHO/zHtUH2TTIlOHjajJcvPNrIOjJybnnXygTZElJCv5KUIvfj/eg9UC5hb2A3nee7Mi1VEwJTvKD63biEBCPyU8JTSNs5fOYEJ6oMS9IqQwoxxlaY+Gk4+X2tIbKR2FPjaH9rTQ4+X8naNo4sFdRKQVuwpKCYM681
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(376002)(39860400002)(136003)(346002)(186009)(451199024)(1800799009)(316002)(6916009)(8936002)(8676002)(41300700001)(26005)(55016003)(9686003)(478600001)(83380400001)(71200400001)(7696005)(86362001)(122000001)(38070700005)(38100700002)(33656002)(6506007)(66946007)(66556008)(76116006)(66476007)(66446008)(54906003)(64756008)(2906002)(4326008)(5660300002)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/lSPdCr5iVpR+zRhvS2TPOIuGSAIpMPmCXNoTyNvDEK0fQnPnTDnPKYcKqZq?=
 =?us-ascii?Q?Hqt5SotpofxrHAcm7lGMA+CaQOB/NUaKvhaxafdBC8dJ++okGOQdlaGZNGai?=
 =?us-ascii?Q?xVjbFbFeTeZ9umZ2cf6MTCcCVFqRqHiDmjVXxWoXza/gTjR3K/apzpl1F5xn?=
 =?us-ascii?Q?wcc+ecg9XaCFsurnp7VefIIrhd5X3d7xkp8gto/Y8HitAw4oFyYy0oO6yiM5?=
 =?us-ascii?Q?cj08+pAHfBLkiqmpRty0Ib4ktxSI2klDnei82Tr6JiLRXcEahNhLKnaCNck+?=
 =?us-ascii?Q?CWp/v2ixl4TfMdVxHHvaO1jwsM8t/y3GJWigL8Di0jAd02IDwfAd33g02vBl?=
 =?us-ascii?Q?Aq9rD6m3MYLbPnAEC+keRudRoxJvY8KpEfFoUu1WMdl3sDiMbK+3TxGKhyUl?=
 =?us-ascii?Q?yZkeQb4d4aJ/LNBUzhRcHkpcTLjKQJLdyJTbwTFKm3eXRTAj0247Wk0rpM8q?=
 =?us-ascii?Q?x3L13WwKePlGZR43HMS+B7Q1JCwV3OMWQY8kCjLPv5V59AGaXTumAXWb5iXZ?=
 =?us-ascii?Q?HOkywRO9c4CtrZ3Q2BJueo6tVAtrPi325cZgefmz+ystBCdc/4ySDfjJtPG6?=
 =?us-ascii?Q?+0AQ4RVHdyrZdMBaeTe3yMxUH4lVAxvY5IN9CFnK47wJkx5PwgQ6jjrCwUS9?=
 =?us-ascii?Q?H+hjC9dOxD225gKyU+a7tIZEjS5I4eysvh2mwFKysRcbwRdkRp4P2WhsrD6B?=
 =?us-ascii?Q?tm0Ecg6Or++VVlB+T62hstc0Rip3hOaFaMeiVGItui/a9dNZDBbuX1Hp1Hb2?=
 =?us-ascii?Q?MQekOMIdL9yD7CC5CndrRpUta5SDewWAAsw7DEAvAZ+D6mDWj1gSEJvbIIWe?=
 =?us-ascii?Q?jjpVUetw1TDrpBZLfzc5uTMtkGGgK3EcYccm6Y5yCkJg22ZcNbdkBPxfZFK6?=
 =?us-ascii?Q?Iu2YK6+DydhslB3U92/vlhz4BxlD7DJcX5RiQiWDLy+qvDF8JADyvzyxnlAb?=
 =?us-ascii?Q?JfCwl3y0e7casyrNvsQPuAaPlW3p1gr1CNFulM7U+5lSOBK0U9N4+t7LrSBh?=
 =?us-ascii?Q?pL34AbnsAR7wzevniWDakfWneUI4XjDI4im1H3VSr4bjy9XCYsHTqPALn64T?=
 =?us-ascii?Q?ZKnmxoDKg7Arp6byaxKwefUV4cV3UVjt6LeDrIep5Dl1hZWlwV2mrMg98kki?=
 =?us-ascii?Q?Y4w+zkl+zmqh4XHz1/AlwKl3OyKVA+rPnGHCrgJO9UT+s2hjQl6Kk9TjvMm6?=
 =?us-ascii?Q?uoGdVBkxx8h1yyzbiCgdEfzClg0V6nRgjj/fFRxmOmloyVkPix2yZ0IarRlb?=
 =?us-ascii?Q?VSiWcaasS/BIIWHG9TRKNXRZFBtrlNiPDk1liU4KbapXcXMnMZeLFn7oRkqH?=
 =?us-ascii?Q?tBfoQEt5/xkrQrKjaryi41AWs2dR8pUyposvzwwprlnyoGaj1XKLe312AYTX?=
 =?us-ascii?Q?NRR3tvwMAWkaRu5GcsfQ3Qo8hMorkhqRQhH7vNe3Jsg3oPF6HP3fEqxkLlFb?=
 =?us-ascii?Q?QvuTurzPb0Go2KSUSGAO5LLDnctVrFKuGsmeR41OU/l+CMFEKA6OYcg3JTHD?=
 =?us-ascii?Q?RbN3UoE+3x4iIG3XlJJQ5H8Vnx6sq2f/aGkEh2uqUNRsBYs0bLkIj+Se746W?=
 =?us-ascii?Q?mh8qy6iXPT2siz0Av3yMIHWb8hski7NKdZPJhxYJSOJNE7iEZwHJmeiyseWD?=
 =?us-ascii?Q?kg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fca8bc7-3a3e-43bc-60ae-08dbb932d35c
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2023 17:06:54.8223
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nGGTtnfVbfM5B04dWGZTcobVcZGp3kuHZONdfRlWDNkaj8/KsKZIjPxwn+jg40BaQFf13YS09Cq4hEJRXX2XbFDSTvGAXwuI7xJXpaqpZQI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB9372
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
> On Tue, 19 Sep 2023 17:32:05 +0100,
> Biju Das <biju.das.jz@bp.renesas.com> wrote:
>=20
> [...]
>=20
> > > So you mean that you *already* lose interrupts across a disable
> > > followed by an enable? I'm slightly puzzled...
> >
> > There is no interrupt lost at all.
> >
> > Currently this patch addresses 2 issues.
> >
> > Scenario 1: Extra interrupt when we select TINT source on enable_irq()
> >
> > Getting an extra interrupt, when client drivers calls enable_irq()
> > during probe()/resume(). In this case, the irq handler on the Client
> > driver just clear the interrupt status bit.
> >
> > Issue 2: IRQ storm when we select TINT source on enable_irq()
> >
> > Here as well, we are getting an extra interrupt, when client drivers
> > calls enable_irq() during probe() and this Interrupts getting
> > generated infinitely, when the client driver calls disable_irq() in
> > irq handler and in in work queue calling enable_irq().
>=20
> How do you know this is a spurious interrupt?=20

We have PMOD on RZ/G2L SMARC EVK. So I connected it to GPIO pin
and other end to ground. During the boot, I get an interrupt
even though there is no high to low transition, when the IRQ is setup
in the probe(). From this it is a spurious interrupt.

> For all you can tell, you are
> just consuming an edge. I absolutely don't buy this workaround, because y=
ou
> have no context that allows you to discriminate between a real spurious
> interrupt and a normal interrupt that lands while the interrupt line was
> masked.
>=20
> > Currently we are not loosing interrupts, but we are getting additional
> > Interrupt(phantom) which is causing the issue.
>=20
> If you get an interrupt at probe time in the endpoint driver, that's
> probably because the device is not in a quiescent state when the interrup=
t
> is requested. And it is probably this that needs addressing.

Any pointer for addressing this issue?=20

Thanks for your help.

Cheers,
Biju
