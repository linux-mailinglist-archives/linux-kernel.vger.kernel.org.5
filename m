Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 602507B00B8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 11:40:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbjI0JkK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 05:40:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjI0JkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 05:40:05 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2120.outbound.protection.outlook.com [40.107.113.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFB9FEB;
        Wed, 27 Sep 2023 02:40:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MQYmBvQpQR+VZp/b5uIBXPbiC8YwkKFlDI0eFEANWe82wZRyx8AJnzhLqc5gcuv2ny5b35K2Ft9Z6IyLdRdS6yUFX7rVuXMivCnm1fALRCvHVbgTq55zDotdqDyUqvnBqTqZziO4744JD0BGaq1B1Wd+4INvE9bKzYy82eYElJosiIgcw5ExyeiIn3JYzcRgeBfPcHsUmAp3IDY9yd+A0MN89o8MdHvnQ6zvyfH/3QTwLBqjO2aumxVIPLdVYN6tOpJneYyE0Jir/JS7ai9XiyUlNLKZYHGzc4oMOc0aeloiXdXGSX9FMIZtBWCKXJujrjIz/rdQz3C6tWo4wPIAOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qtKUZ6qZehfvvogFWl3TjTqi7p5DrqGpVfxXzDw2LOU=;
 b=WSI/AKfa63ry7xNJme5hnqcmq/2eb4RFwA2CxkDdETV0296vcqDsL7h2qlqlNOezaA1SDdqRj74VQdUVtoo/KGj7NS09ppNnq+XYXCwyr4G5wOJl1dTWHsQS2jqVBFFXmMjbCfyQrGArC/ssC9VG/x2aybWz6sQsgpIXh5Vgcd35u+4UWJa2cwV9OC0UlHVaQF8EHVyuQ3rDvlqnIjuzhGpwV5N4rkvtIXaUc7W6YMDbm0fPSzaPnZnlYNFhEbhvLD3bysulgOQqP/sW5Nrc2VSeF/cbYCk5nTuv6lntuMOjTbQLNRCa7sycvYaw4krD9GYTuBO56oRKly4WDjmyPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qtKUZ6qZehfvvogFWl3TjTqi7p5DrqGpVfxXzDw2LOU=;
 b=YbHajPfDzEfS9CwccWeHcEYsxzxDOFHcI6WRA/JCdQB5xR0MVq+xZ2tHAiQH0b3+ke7SpDKJKH2G7kvZZBtyLS/B9E2gT3uyqqtfPtnj0srIwD/zJEoKLrfMa9iXArE9GhxSGPzF17VIYR4KZR6VjDrtSfGCAJpgzLWl8O/+B3I=
Received: from TYWPR01MB8775.jpnprd01.prod.outlook.com (2603:1096:400:169::11)
 by TYWPR01MB10981.jpnprd01.prod.outlook.com (2603:1096:400:391::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.30; Wed, 27 Sep
 2023 09:40:00 +0000
Received: from TYWPR01MB8775.jpnprd01.prod.outlook.com
 ([fe80::600a:9708:18f:2528]) by TYWPR01MB8775.jpnprd01.prod.outlook.com
 ([fe80::600a:9708:18f:2528%3]) with mapi id 15.20.6838.016; Wed, 27 Sep 2023
 09:40:00 +0000
From:   Fabrizio Castro <fabrizio.castro.jz@renesas.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH 1/2] spi: renesas,rzv2m-csi: Add SPI Slave related
 properties
Thread-Topic: [PATCH 1/2] spi: renesas,rzv2m-csi: Add SPI Slave related
 properties
Thread-Index: AQHZ8L2blakiXIKx8k6DD60xX0IJ3LAuX5YAgAALJcA=
Date:   Wed, 27 Sep 2023 09:40:00 +0000
Message-ID: <TYWPR01MB877515D00099BE7FB167605FC2C2A@TYWPR01MB8775.jpnprd01.prod.outlook.com>
References: <20230926210818.197356-1-fabrizio.castro.jz@renesas.com>
 <20230926210818.197356-2-fabrizio.castro.jz@renesas.com>
 <ZRPuSidGd5zO6pXf@finisterre.sirena.org.uk>
In-Reply-To: <ZRPuSidGd5zO6pXf@finisterre.sirena.org.uk>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB8775:EE_|TYWPR01MB10981:EE_
x-ms-office365-filtering-correlation-id: b1d46e4c-2138-4fbc-7d45-08dbbf3db7d7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8ncdOtJI+Csx5AaLu62D6LTcGKGYS+8aOI90aglL4kw+ZNv4Iaiu1ZVhnr39EZL9jpi6PE47JiamVL/yiTVmdrs66iWycHP3bB7bpv+jUAHqZGj/OWP9qWAxJ43wsYDhXp8m2m0hhgm4Y6zFzgktn7HNGUfQ7iVqDrTfv0txYBI2bwAAsetSYBrYOm1HeT4eB7skclhuvlNt/iR+MEEGyelPWEw10sOec9CNbJ+NaDVQEwk3p99IjOh2On9ukXa6KZdxgxGnjXpPAJbq+7zJfKi29vNMT2TCkXIO64tzTle5UsYYxA2q9wwaiqVc6BpkMQ/7/BgvPqnQEZLAQY0UUHCpT5GfFu1k1n+aW9Q8pG6ojnkuUQSQ06hv/81lSyoxEPPi8RtXxq7Aqcq1iaTWTwQDSgo6f1J4GLEr6uVmpxCssgD+Kdv0M/XYN4L5WPpeUnCX8ybjxyB6lY8Axu8zo6L/LI8VuH5t1gptRcdNTHxN0RrpaDsaGYfGGoFb3thXUjTihnnVhRewjp9kYELqJpWinojKKft9pgQMP6j6t0zkk74xREPcPhaCTGWMTM0Kyjxgy0vDiP6CK1O7CuqxpI7D2lG1PdqS6B/I74lvAfXm70Hy4PediQ08bmmEB3x5
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8775.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(346002)(136003)(376002)(39860400002)(230922051799003)(186009)(451199024)(1800799009)(86362001)(8936002)(8676002)(4326008)(52536014)(5660300002)(41300700001)(33656002)(2906002)(7416002)(38100700002)(38070700005)(122000001)(71200400001)(478600001)(83380400001)(54906003)(64756008)(26005)(76116006)(316002)(6506007)(66446008)(6916009)(66946007)(66476007)(7696005)(66556008)(107886003)(55016003)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LefwKnJ+EGKneedzR1hgn4RIiAdEjlbUH/EaUTlXK56YXOCoxkMjBe629dj1?=
 =?us-ascii?Q?B7ydS0OkeH9FJ73Co+MI8Ljg0zo+9fZzran8uDllixbrt2qtFmoilBYBLD7i?=
 =?us-ascii?Q?U0Nq6DNVS445NSUdbHKgzeHdOH3RSx61gEh5nstznXhnUrkIfV0ra6WKxzG3?=
 =?us-ascii?Q?T17956I5T7Nblel1YTKE38dWS8qxHGgPyK86ujLkVqZ9ELIvSxfHwR45DtAS?=
 =?us-ascii?Q?YkWBBzZH79ejjGIuOG3eBy6fAKcRJxk7/GUB05hDwPq7aMQUt91hm7xKF3n3?=
 =?us-ascii?Q?qY++frVcuEVIXQ7fuVvqSa9SGNDT9/DxZfPx88BuvrJ5zGFC8CM3Rvl4UanA?=
 =?us-ascii?Q?H6i6QhX1C8F/a7yY1uwL4UT17uesl4m1ndloEZc5/HumcNZaawkwN9efW/ck?=
 =?us-ascii?Q?dH1hUOPdQD92bkpPa1+mhI8jHbShaKhhL3tAMIkKJjKmNoK4For93wFG9NtD?=
 =?us-ascii?Q?LzslWR8jAlEuAjSsHudTw38PNGfbZwZu1ZVhD5uTFn+GIklqSIvqhUNHcK/v?=
 =?us-ascii?Q?Vuwqpc++xhp5bxqAWs+lmbymzTUIc1tSXl3py8X4qrsI0q9EpVcZAcK+m3Cw?=
 =?us-ascii?Q?B7IdUtmktFCEnYmCqf8j2Pl2+VfIKGfv1LoneenX9UMQkRiXS9jL7xLpDZIo?=
 =?us-ascii?Q?Z9O/MTdrycAtMMqbuBBPCGMNcENEcDkCwExd57h4ZCoMLtRA8DP4uPoLr8Xd?=
 =?us-ascii?Q?IoamxCVIRsARd1rp45NEKItICw5DUSwur4paO7NmdKQ87p3cFCbvqzfhbqAn?=
 =?us-ascii?Q?01ns+RnHvVB+upUQxu/3sSzbznIWvuaVl7J+V7EDL9oo8u9bnbOxG8bVAJH4?=
 =?us-ascii?Q?KTIGONoi+lS39g7diyarNCFr6YG/iclrQ1wdb2BeZOHn8NNXGIU/kC4RhdhZ?=
 =?us-ascii?Q?5ufBqfsbtDh0A4dBvX61e8nUjoYZ+sVrIShtfLMYLofUEPWOVTK/rcF3SLw2?=
 =?us-ascii?Q?OnqqnCiBitpZOHegSm9S6h2s1FmAm59LBsnKzfyEO+0Ppd0SElEp62JDxPCA?=
 =?us-ascii?Q?hY/nD+KpqOFzQeTyTuS0ZGJ92D/nVDPbCNpCZkZCrvD4JsyIz1ZmbxwrCnrK?=
 =?us-ascii?Q?4eH/AE6LGne6ZgskpBj8PR+8NxyozkGqE6ylsTMnXggfpWT+dYnBME635Llp?=
 =?us-ascii?Q?Pf6D6SiTFd8zrCt9H5W8fMEX00KY4zHr9vZF7QpiQKbQVqjdC+vGlIxS81or?=
 =?us-ascii?Q?JJbkCF0p1n2qCXEI+NfPHpFYzZ87XgPrcCBL+pGEjym+qqLiMzbowjExXxJ6?=
 =?us-ascii?Q?oRSfEqeZUCsL28kJeq+Y+dxaPEgabrR81Y2VvSPl1mk8kug4Hu+EycVm04ZB?=
 =?us-ascii?Q?4M64IvjDKLbowEC8qYwSj7esu0i3GVtz7lGy7gdnRZJ2gIUDK8rBYjGDUUqw?=
 =?us-ascii?Q?sMsuQMXxtXu4PwJkdbq9GMXGf8yaCDPG2axpxtV/cwvNFvWG1r+bqVA9CK+/?=
 =?us-ascii?Q?mbcNr5BSaMS2SYg9bLjRkLKnC5wtwQkV3P6LvxrOmi1O73KVcggstCCGUnQP?=
 =?us-ascii?Q?JBWYQCYlOh4eyFk7Xy3bQHDrc+yalotqOEaziMZNhzbSSvm5iPa6OYCMF2OY?=
 =?us-ascii?Q?pURmxu+0ZzeFzmKyAii8nMlF44aOvQIyptRdfoR60oKasziOckOXtHjhijwM?=
 =?us-ascii?Q?4w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8775.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1d46e4c-2138-4fbc-7d45-08dbbf3db7d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2023 09:40:00.1203
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: auBuol/c5PMMub7kRkLMA402m90xnz6yZD+CzUgJ1bPpkCT8zhAUdCTlFFg7jwB7hCApcdZioGYjnGlrko7/L4y9HjPDkXL6D+YawA42lkY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10981
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

Thanks for your reply!

> From: Mark Brown <broonie@kernel.org>
> Subject: Re: [PATCH 1/2] spi: renesas,rzv2m-csi: Add SPI Slave related
> properties
>=20
> On Tue, Sep 26, 2023 at 10:08:17PM +0100, Fabrizio Castro wrote:
> > The CSI IP found inside the Renesas RZ/V2M SoC can also work
> > in SPI slave mode.
> > When working in slave mode, the IP can make use of the SS
> > (Slave Select) pin, with "low" as default active level.
> > The active level of SS can be changed to "high" upon configuration.
> > This patch adds two new properties, one to make use of the
> > SS pin when in slave mode, and one to make the SS pin active high.
>=20
> Please avoid the use of outdated terminology like this, prefer "device
> mode" or similar.

Okay, I'll resend with a more modern terminology ("host" and "target").


>=20
> > +  renesas,csi-ss:
> > +    type: boolean
> > +    description:
> > +      Use CSI Slave Selection (SS) pin to enable transmission and
> reception when
> > +      in slave mode.
>=20
> When would this ever not be true when in device mode?


This IP can do without the SS pin to start operations. In fact, the
SS pin is disabled by default (I know...), it needs to be explicitly
enabled, and when enabled the pin is active low by default.

Cheers,
Fab

