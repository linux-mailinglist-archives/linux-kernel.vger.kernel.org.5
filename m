Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1A1B7EDB5C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 06:59:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbjKPF7w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 00:59:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjKPF7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 00:59:50 -0500
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2105.outbound.protection.outlook.com [40.107.114.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF2B01A3;
        Wed, 15 Nov 2023 21:59:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nsAv1fAEYSTpGWGnNo0AZvnNo/13H2JtRbIsmHFfsQVV4BK2O2YlcfJndP5lZbFOAYekUi1/BCyzsrPnqnalVBxwh4/alUoQ9gk1enAgPM7zJKDG7K92hYQE5+IOHtkUojZLd6IvBuTer4wYLjECliy6F0xuF8fn3J/bapkoQbxAj1JBGQdFzkUcCrhkQchLd8CzsOLDRHmRdbMZGMGoqSVsB2dAP3afwac83MJMK61hzAxNfxl7BBcgPoF5LlROr2q4Wg8ZTIYwzDQ7NwJoqZT1MRLCJrQTTXBuy4WEOBn4XQ0ffVGNVgvlP0Y3YozWACpj7AXZUUKuVeeVH71oCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uogyPzWN4W6sR+6B+N74xRy2B1LJ3cOFGzBPI8LhAjs=;
 b=YwScFpT4wzXesKnS7AjHAq+HCRvGZILDM9B9qCT6nFLUQAG/MJsvAnp1njMUXRCSdmiq8MuGIypKFy0Ix4oMNbSPG3rNRCDXwNSXGXkqNQKvk06JS+AoEAjddZWCzeOgDBZypkNuSQgEezlAPTL4MHt5x0JUgRMAbqSxOhblcarrTBZCVxRt5ByW1x+iv6jVIIXiYAGiR1oWunqQ69WOyNe+755OxViV9kC+vOy6tNCoOuz4lhE3gPueUUjYFOy+opoSmgFcWvgYW14iz/nb11t1wD0r/Q9RbXhRZhGq5BPBwmD9OnsjsomxGGw/4Ltb0aHUe9CxERKW2KcVNmSfww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uogyPzWN4W6sR+6B+N74xRy2B1LJ3cOFGzBPI8LhAjs=;
 b=lyf972i9Xl0m+Xl1Ilkoh3dno49MlGyE5pZ0bRAHd8v2/+0FjL0TFppb29lG6cXuypk82aT4c9LHp5cPMKcic9BghVaWOcIYpCSP8J/EPkBNdpVshO8bKTwIjod376L9ZoUHpS05wFSiLq2pfTfAkxlGHnwZJK76AlDaLW9HLoo=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by OS3PR01MB8089.jpnprd01.prod.outlook.com
 (2603:1096:604:1bf::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.21; Thu, 16 Nov
 2023 05:59:42 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::50f5:eb2b:710a:b7c7]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::50f5:eb2b:710a:b7c7%7]) with mapi id 15.20.7002.021; Thu, 16 Nov 2023
 05:59:42 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Prabhakar <prabhakar.csengg@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
CC:     Magnus Damm <magnus.damm@gmail.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH] dt-bindings: usb: renesas,usbhs: Document RZ/Five SoC
Thread-Topic: [PATCH] dt-bindings: usb: renesas,usbhs: Document RZ/Five SoC
Thread-Index: AQHaGAi5pfcoPaHtXU2I31nKTqUDy7B8c8Lg
Date:   Thu, 16 Nov 2023 05:59:42 +0000
Message-ID: <TYBPR01MB534131675F2857FC72E1143ED8B0A@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <20231115211407.32067-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20231115211407.32067-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYBPR01MB5341:EE_|OS3PR01MB8089:EE_
x-ms-office365-filtering-correlation-id: 81bfd528-0120-478e-4253-08dbe6693a4a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RcwKYrMp3CgoWe+FmraAJeFOW0NA+A1WUN9I+vNazEkISTVBFpuhDap3fkv+dle0H41gkaA9AKR0w2JOFMaYdP1hOIJKApph5aVfzUdjT3PmVxYM6nbZMSrslo/9xN37Q+QeYMO/1CCqhz1w8cGrpdPW2JMv3tZJJqeCZpom4pdb3PGwnzJWRKCo9yoimmtwGZjUKOTbuGPkKWvzP2DLntwcCdl6jmDt+Jay8rRdG2674sYHqKXOULsnfUMLTrP+pq1919weNazi6hAY3zml7hnV3tGOwPAMUOe9pM+V0lS6V1wHFMqN25k5+Tlr8jciTQaGyqhRP2x99dnbj3v4kNXNa97+7Zdwo5d2y7YNrAkkE61a3uqX4hVSd+/YqD/7UhI7Bd1hedCW96nYX+1KyEFZwOWKvCG38CP0Okt1mJD8aVgjCjudCpvAyumbffTZk6F/W54GrEqAwOOUNmgod3IphtvzBg7qPidEqEJPhTiUSCr/jDD8ysgZAQKq3GEa9EgZD6lv2MQmSF80Iv17+jfWtfWhXYTicAdutwvZzzsfMIfbnDkw2ON+lQoXaB+SiGL2qe8Ov/qnRboWYJ66KRJWJnsH7np/1EBUEDhFiMO89RZbIqrtHEcj8W807wab
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(346002)(136003)(396003)(376002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(55016003)(86362001)(33656002)(478600001)(66946007)(66556008)(110136005)(38070700009)(76116006)(66446008)(66476007)(54906003)(64756008)(316002)(7696005)(6506007)(9686003)(4326008)(8676002)(8936002)(71200400001)(107886003)(52536014)(122000001)(83380400001)(7416002)(5660300002)(2906002)(41300700001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dBUt0ZJMl3903WZ0euySh5VGaad8UdxwuT44vrm6TARIvunkwPgOUeyx1Sh+?=
 =?us-ascii?Q?7JuxxodfBiAc0UOQiKPBsrpSCBcukHIEz4Kvp45wHb3mFrTqeDy34xTmp0B6?=
 =?us-ascii?Q?aWL3u/7mLTiomdYvKmfZeDoaL4Q7TctrGZQxzUntcSv3xF2h86BjjTliYgi3?=
 =?us-ascii?Q?XHe9oFm9dFYwdLnA5An1B8NQbtz6967OvMIkVYHKSndjhYyw+4eemUpGhnbw?=
 =?us-ascii?Q?rkScOHOS5RnCFXp28xN6zDI5PqvwmKQ5brddw5XACPX00oOeC1FY2v5ud2NL?=
 =?us-ascii?Q?rjRTdl/Sh+qr8PYGdNnK5XqEC2FPcWtA0XM+S8UOZ88Jk1gvW70WtEiePoqb?=
 =?us-ascii?Q?6w1V4hFs1GHI4erNsd4+aQ80luM0BiaJq8/4QYVTBiT1EcQE0ZNzxOIkh19C?=
 =?us-ascii?Q?zNY1rOSwsGoPmV7sXmjauK9DVxQx5s9eQtnEIxVNH22hmiyBMlEfh3c81Odf?=
 =?us-ascii?Q?zX6Xyxtplplm0FQr8cBCqLhhn6nbnhs5uXMxXwMCGrQkuzz+HcbncDDt3MKo?=
 =?us-ascii?Q?bE9JupsReGAkK5JdB32EgOYB14TB/RgzOUtkxrUEZsSadmS+LMp8GLMpRKDR?=
 =?us-ascii?Q?P7XVqC1raFRn7X5vmtANaF9xcpVeS8kLY1OIoVPVFEpL3ujVd/n2HSh+m9Xl?=
 =?us-ascii?Q?mpVuD3esoiLjg20rI9N1Ubk/PL3+tKkR5dbyKjacsQTI4LTpHCxzwWPQ5msu?=
 =?us-ascii?Q?wtiI3MjE1RG9PuK8w7ENPIJKNOjPBAchBbVoJCW8pF9FFqr85PkMO+aEpyLJ?=
 =?us-ascii?Q?VILIpK0X+UumMW9M1lGq7Dle3yY06zYi5ezAAvNTUsMP4eQvSVdmqWnaGoE9?=
 =?us-ascii?Q?d0UIXgRAjcDSnqeseAdGGTMM1b2Z1SsPweG7IEK6VtCdgAZnLTEkqdYpGeZC?=
 =?us-ascii?Q?VU98hlvYFLvyj7K2pdydbCB4vB/F3eIfbDpiel3qTbW/owUOz9CAPKQVA2Gy?=
 =?us-ascii?Q?e/hgFctCm2DsoUrZLwpdevUHJExdf4alEsJjdTeIpYXE7EKfw/hPEVKqpFHI?=
 =?us-ascii?Q?LkiIXRFOjPbPvEj60rz2Ng+NwnoU9vNpqW7N+6Z2YLxf4NpBJyLlRtIQ0GVX?=
 =?us-ascii?Q?um0xysz2VyOQAVBFnq6pLDDrAMhrWhhWxf7WGhVg391PH+rFpnawFQjkuG/d?=
 =?us-ascii?Q?vvR4HP8Wv6eCznegQW++YZec7creFjtmRE6/WnbVAPF3i5nAIOeCH4JaBcnj?=
 =?us-ascii?Q?P63mP7ihJGFrLc1ddJ4gHJLGbo2IMWtS73cGwRsb0AqDvLEeDJwqy9S5d6c0?=
 =?us-ascii?Q?ec+keqjdSeFZWAgPg1WAW3MuT4W+JnYZ4Nqsvyep5KKh8JVP2ZtisA5XzOpR?=
 =?us-ascii?Q?I8Lt8evmGcmHrbJlQ56cKqJF7UEBirrcyBvjHi1YWeBRtfG9x7KAbryF7kHf?=
 =?us-ascii?Q?Q0n/W83CIOhJtQH6G5xVdZrZ61khKAhoShHCBkNXwrNZYo9KhrlEhvgCvWsu?=
 =?us-ascii?Q?SgaserKqCeaQ56iuqpofSkJ9iqKawnW4PgDgDGTqyXd3GWPZZXqq0ll8M+Sa?=
 =?us-ascii?Q?zWoffo9YA8cGd8+WyoEcWbj/UyZDK70LVAtb/bgPdz9XgAmxdN4luVcR86bn?=
 =?us-ascii?Q?ccwcnR+5vmaHcSXBQkZHExJ52cmkXNsC62UBv2gmzUCZBD7Zb4fBw22kSI95?=
 =?us-ascii?Q?fSR7fiUTkaSxy6CL7HwgP5KwbzOPemax4ZPl4Xfnv5d82jKSl9ynZn88QQgN?=
 =?us-ascii?Q?hssnYw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81bfd528-0120-478e-4253-08dbe6693a4a
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2023 05:59:42.6818
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iVqrfNg9CiTfRFD50rZa9zX3wOo2KNaQsVIKasbsHDrxINi0v1sHV/LcSrq4E61Dq71LEFUWEHPFmwaJrulb1Y/4XaXAuFh46pjGRAJ+EPJTSm3w78IceQnfPs+xWCPM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8089
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prabhakar-san,

> From: Prabhakar, Sent: Thursday, November 16, 2023 6:14 AM
>=20
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>=20
> The USBHS IP block on the RZ/Five SoC is identical to one found on the
> RZ/G2UL SoC. "renesas,usbhs-r9a07g043" compatible string will be used on
> the RZ/Five SoC so to make this clear and to keep this file consistent,
> update the comment to include RZ/Five SoC.
>=20
> No driver changes are required as generic compatible string
> "renesas,rza2-usbhs" will be used as a fallback on RZ/Five SoC.
>=20
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Thank you for the patch!

Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Best regards,
Yoshihiro Shimoda

> ---
>  Documentation/devicetree/bindings/usb/renesas,usbhs.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/usb/renesas,usbhs.yaml
> b/Documentation/devicetree/bindings/usb/renesas,usbhs.yaml
> index bad55dfb2fa0..40ada78f2328 100644
> --- a/Documentation/devicetree/bindings/usb/renesas,usbhs.yaml
> +++ b/Documentation/devicetree/bindings/usb/renesas,usbhs.yaml
> @@ -19,7 +19,7 @@ properties:
>        - items:
>            - enum:
>                - renesas,usbhs-r7s9210   # RZ/A2
> -              - renesas,usbhs-r9a07g043 # RZ/G2UL
> +              - renesas,usbhs-r9a07g043 # RZ/G2UL and RZ/Five
>                - renesas,usbhs-r9a07g044 # RZ/G2{L,LC}
>                - renesas,usbhs-r9a07g054 # RZ/V2L
>            - const: renesas,rza2-usbhs
> --
> 2.34.1

