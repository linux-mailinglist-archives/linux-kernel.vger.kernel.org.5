Return-Path: <linux-kernel+bounces-117458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0639688B26F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 22:14:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A326C07C1D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AA9F134401;
	Mon, 25 Mar 2024 16:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="q7DWCeZF"
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2075.outbound.protection.outlook.com [40.107.113.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D5C14292;
	Mon, 25 Mar 2024 16:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.113.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711383677; cv=fail; b=mwyXwGrRXIKQ8f5TuWfO5ET3bOihwztSX5Dnv6rQztwhtiLP6wevvyZemoOIniVdrw3BmvJm3+AMUGe/084/HUtEPvgQZ7t67wisMOVWMzXUDec78LCtpWG9ZfTNx0ofXdG1g9DCuuAiuiskHAKoGT0Qm4s5o5+pYYQMrf6KOCI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711383677; c=relaxed/simple;
	bh=th+wYdXPa04BuA81xJclF38U+n9heCBfheY5shrCXE0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IfN72vdM06uVPQp4nY8YMoV0HTn8LlIPwqVuRghl5zC7uslSsbTD9R5GboVchxOiFF0wUPWCHxQdHNU2HTAs6wLOipej/nbKmK5oWs1mA7tNe9oFVCW5w7KUPnqFWGJXu55Um1SaiPkbtOKQXXHumWAUVlaVSB/kMJf2a+DlBc8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=q7DWCeZF; arc=fail smtp.client-ip=40.107.113.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FvCKqN5WRdHL4xx9LIp8JPbJd90BglGd1SbrsZ4qptOy6qrB85g03kF+m6IjRnhvCF9R/vHe43CKGEcW4ul2A8vJsbVO4zaBo6BTCxtW+l476CkHRmHq2un9StE7ZLWoDrU+d0pDLGZVa3pdS9T7gthXI72KlXqzIUXL6WuhOmUeogPSNFaUlsezQeXUsF1z16ZSOA47pqKswTMiIz23qRXSWAKmZRh6Q8txXS0QEFhQtQ/c6nchG99aMPnvqptZHNKXQsxDC0N4H4qTsMVC/kgO7LbJA8AVT70RBCirPomHd12Fd8Dw+fJSc5CaOtcSi7xJpo7VmLweNLsfMmkxEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XBIzEqHbzOjRK1jlKlP6hnCE0ji6EvNe8SaJYAk3cR0=;
 b=nNI2AHC28gK95d0XcXFvS9ItAkjnBEhhoKz4pDj5q0vMafe/CUzYDLl95Ssi9oy2AfRwBoGdih/FuO7hk4kf1RuMJzNdDtJi6g1tQBf3BHNc2wXdexJa7XEfc0rI+4IRheQKf8odQ5CgBZM7ZTlkqHgZcGOnvBwU36vXuJr9vgMcZENr5F1RO7Elb3hJA4XZlGpz4XHoDa7I8pTHFe5PDCpfesJ7THdd8SyyL08UxSAawP1QgY5Gy87B1++eJYu/jMrwyh0K9BdcvTyvbeQlktHoSvZVDBfs8CzqXzsyUDdZrFr2YSxPCW2RWr7Ujy/qth28cQhcA2nkXoBKo5Fajg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XBIzEqHbzOjRK1jlKlP6hnCE0ji6EvNe8SaJYAk3cR0=;
 b=q7DWCeZFPUjo/HnCWigNjapCcB9W9vZkPmAvUDAa51iIpgjm2hCcIZzqkPkgFON9fozKmnhOq5iSirrMorz/cOn25j7dhGl2/Y9qS7bJh8h4V0hxKo7tHWZtqtES9RPPCZdTfPbKYaJeiahf0yR/N+qI8iBoYcex6b94FozwoYM=
Received: from OSAPR01MB1587.jpnprd01.prod.outlook.com (2603:1096:603:2e::16)
 by TY3PR01MB11483.jpnprd01.prod.outlook.com (2603:1096:400:3dd::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Mon, 25 Mar
 2024 16:21:10 +0000
Received: from OSAPR01MB1587.jpnprd01.prod.outlook.com
 ([fe80::aef6:c35b:b90d:2e3f]) by OSAPR01MB1587.jpnprd01.prod.outlook.com
 ([fe80::aef6:c35b:b90d:2e3f%5]) with mapi id 15.20.7409.028; Mon, 25 Mar 2024
 16:21:03 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Prabhakar <prabhakar.csengg@gmail.com>, Geert Uytterhoeven
	<geert+renesas@glider.be>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
	<conor+dt@kernel.org>, Magnus Damm <magnus.damm@gmail.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH v4 2/5] dt-bindings: serial: renesas,scif: Validate
 'interrupts' and 'interrupt-names'
Thread-Topic: [PATCH v4 2/5] dt-bindings: serial: renesas,scif: Validate
 'interrupts' and 'interrupt-names'
Thread-Index: AQHafGepLpCbH9nzEkaXOHWLeIChIbFIp7Lw
Date: Mon, 25 Mar 2024 16:21:02 +0000
Message-ID:
 <OSAPR01MB15871221D42B6CEAA08168C386362@OSAPR01MB1587.jpnprd01.prod.outlook.com>
References: <20240322144355.878930-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20240322144355.878930-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20240322144355.878930-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSAPR01MB1587:EE_|TY3PR01MB11483:EE_
x-ms-office365-filtering-correlation-id: e2750f48-cffe-454e-7729-08dc4ce790c6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 UqhweEYjT24Qbaore8fU2ka6b2WHiqeTxhxNccQweLgNmsE7eVmNPLF/RuosM1GOsIO4jDO+LSsYJXyb91/F9ThuL58TiusKBFjpU7qJVb+pSQ3u9pyT169eWt7cKzL9HmOS1yXMfkxGwyRI8ZO/QD5upQ/sZpPxiSWDRZmylvcvMrThbgLO3xY6N93dmrb8h2HJ24vpl0i3PYBZd5kxqeTsH3aMzTWSY8Xkm7HJ1bUqPYFIll6fSHhwIM6ELTrcRYq6yjtChmrTU8suTFRU5zw7mMoHECkqidLGxJ8qn1rNwNHWdUznk5FPPniWJxor1pyLSTdZm3lQIa6nEQYDPLt7xStuvK/u8rrU+2C5jhWEARzrjjnYnPxnJ1V6/zWvrH7ypNzv7bxc1AfDTTY2iATPUsPhcFyUPyCVuLzpaWbaNwHhdAk+saxYNs54ImMvPnzU/p9iMRAyc1FOmRNTvCR5UUI6IeqaRPPubeJ2Gv2wkLcN2Sw2vDEw6+7vL8nh1gYG5YA0N087QMurS/JZnkE/RXX2tcDdzB9o5jmSTzFyP/xhbBaI0sDo8gbOQMTP9PE5RGty/pDtnCC78DLqLagvMM4ae76PnqbZQobLp6qeTSfTv/2OEKnVesTGAQbqBrRu8Fx/nhYdTtn4KiwJmIjAxYy2ZowkfKTkCkgCK7CB9e1n7UHvRvgahwLnJReLK7qwmBgYn1KLFx1fkYrGTKZNjbq2Ldj31nSAL2Ger4M=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSAPR01MB1587.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?V3qnyoPAjYUtgx7lXNc79c6iAD+/ArayEZ5Kti1rglwD2xuf72Wf1bnJJJ1o?=
 =?us-ascii?Q?S743+oXj88CJRdXVRgc6rGhvV2I6fJYD/h6JMv/ZITX7WRSRjMma6fjJsy3c?=
 =?us-ascii?Q?MFvdKOnSm4mkmVdghHAkOa4qqjWMzUp/VwctYPQ17s+kzGXhyVYehRYcuVSy?=
 =?us-ascii?Q?GCN0dKg871cjKbmgVZXodilUywukfnjK0V3+h59xkULA8xNZ0PaDhzr7EbNZ?=
 =?us-ascii?Q?u3ynxh89JRDHu+81VGYyVeRv8ofGZOCFLCJPJ8gAwucd8Mmmbhw6NbPILuKv?=
 =?us-ascii?Q?CVraNfSXEYWMX9zYgWvr0TixO+QqdnSzirL1h1vhsPlVcZUeizsFjqoEY5X0?=
 =?us-ascii?Q?FU22PFlHx8Y+z7XAgsVJyclIGxCwHRLJFDt7q7A1I8oNZozB0QQEph4N1naf?=
 =?us-ascii?Q?lc+1GNxM3GoEJsLgSSYyJRolg71CNGbQW6ADBOP7+lfIVVDOOd7/3/JajDR7?=
 =?us-ascii?Q?2YhHyoEOhiv4wVM1hdyiuZMpbY6Q5oZ3lUwNBe+NQQv6+gK49adwTXxxpUZl?=
 =?us-ascii?Q?X9HVdLU6CBWHccmK+kjAMj3QL8ZfXA1Jp+HyYVyss87AX9SpMpcHzi4lefTS?=
 =?us-ascii?Q?wQdwOfzCsUkE8yhQpy3OyghZtzYQ9/FMe4uZL7p535SME6a+VIaZaavGMm3N?=
 =?us-ascii?Q?o9zfh+yVXXyXH2BbCbRTRXki7keWm6vzY49CNKY9F7OY5yLuVKYDzXBw4Ecv?=
 =?us-ascii?Q?QwOpet343o/vL8Hnaxi1aE9/5Fwit7Cv4RDG3KqEaSt4Xmstff8oTEyYOZr+?=
 =?us-ascii?Q?4LAMYns58rhk8k+WL/4QjzjdX8/eof3bo8yqvh9LB1KJWYp2hgH0sM8Syhdd?=
 =?us-ascii?Q?edLsGRZEwKmkCEqj3CyBOF46FKXQ9AHdi7qR0MHEN70GhxUs7Jdi7ixXq2ec?=
 =?us-ascii?Q?FP0rBBQCXueS11C/xSs+1iadj+HIUdIeUlkfkPLZBzzbBggziQ0CNP68+DN4?=
 =?us-ascii?Q?kXj/8WpIplRVG5ekUX3Wiaq+ggjv69gNSPvrEdr7T20glz+Oz4uvFdwbmDBk?=
 =?us-ascii?Q?pe9J+vyyCcqhTWAYB+w/TYu6GVTuQmwLp/q3lyiRxeGwar/j3sMIZIE6s/bW?=
 =?us-ascii?Q?S8EmUmwbQgWHuuCMyKXUvbQWUWOlztXRI3dtiX4XqomHK0fAL060fBUnArsu?=
 =?us-ascii?Q?h0eHfB8dGszcsOZ3+Wj9P6mBPP6In5RIvpZlYJfmvXrteH3f1cZRXrNZ5w0L?=
 =?us-ascii?Q?ODFGZF52kT+t5nNnWeWupv+ixJsvb05u0OFI+DkuKrAltDGBrv9wdzVNXpqw?=
 =?us-ascii?Q?JTgEIB9gt7toveeuRm3jNsuzyMlDKS5Hq/Px1hjwR9xZZpX9oXeE+zM8SU7H?=
 =?us-ascii?Q?ROHoL7LiXBMYoJvmy7IY16CNYXhwMy5+IuM3vvKR1JnwrBli6XDtyvW9UMRX?=
 =?us-ascii?Q?S5Hs5ggNGVhomomfY/xvgKwFtecg3eqzayH47VTTHrTefAq/gVjBtTE484NF?=
 =?us-ascii?Q?DryC/9T/P/pYgjc/kwbLqLKXxd7VY4KJgx4tyYF1bXljhZicmk/SVPtQRMLe?=
 =?us-ascii?Q?x1fyml30w+R9rGy/ajy/0fY1Cq0JZAetJF7PARpcmty2aL/YO45C344QksF6?=
 =?us-ascii?Q?zFM/b8GB2BkaSEUqveOHLkIOLCmv/V5MDqs0Y81gpwx7NABKn43xUZw9Q4fu?=
 =?us-ascii?Q?pQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB1587.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2750f48-cffe-454e-7729-08dc4ce790c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2024 16:21:02.9284
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8XDG+j3CH3qWslInazsD8Q56rWIh4ydkTwQMC8ziX3GhSk/duhWPhvNOny5WPimn7gOlYDolziZOLJ0apWbhYpGUfQkzRHrCxjBcH0qDa1k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB11483

Hi Prabhakar,

> -----Original Message-----
> From: Prabhakar <prabhakar.csengg@gmail.com>
> Sent: Friday, March 22, 2024 2:44 PM
> Subject: [PATCH v4 2/5] dt-bindings: serial: renesas,scif: Validate 'inte=
rrupts' and 'interrupt-
> names'
>=20
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>=20
> This commit adds support to validate the 'interrupts' and 'interrupt-name=
s'
> properties for every supported SoC. This ensures proper handling and conf=
iguration of interrupt-
> related properties across supported platforms.
>=20
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> v3->v4
> - Reverted back to v2 version of the patch.
> - Used suggestion from Krzysztof for interrupts
> - Restored RB tag from Geert
>=20
> v2->v3
> - Listed interrupts and interrupt-names for every SoC in if check
> ---
>  .../bindings/serial/renesas,scif.yaml         | 73 ++++++++++++++-----
>  1 file changed, 55 insertions(+), 18 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/serial/renesas,scif.yaml
> b/Documentation/devicetree/bindings/serial/renesas,scif.yaml
> index af72c3420453..eb2aa5e75e02 100644
> --- a/Documentation/devicetree/bindings/serial/renesas,scif.yaml
> +++ b/Documentation/devicetree/bindings/serial/renesas,scif.yaml
> @@ -86,11 +86,6 @@ properties:
>      oneOf:
>        - items:
>            - description: A combined interrupt
> -      - items:
> -          - description: Error interrupt
> -          - description: Receive buffer full interrupt
> -          - description: Transmit buffer empty interrupt
> -          - description: Break interrupt
>        - items:
>            - description: Error interrupt
>            - description: Receive buffer full interrupt @@ -98,21 +93,17 =
@@ properties:
>            - description: Break interrupt
>            - description: Data Ready interrupt
>            - description: Transmit End interrupt
> +        minItems: 4

I think here minItems is 1 as it is either 1 or 4 or 6

Cheers,
Biju

>=20
>    interrupt-names:
> -    oneOf:
> -      - items:
> -          - const: eri
> -          - const: rxi
> -          - const: txi
> -          - const: bri
> -      - items:
> -          - const: eri
> -          - const: rxi
> -          - const: txi
> -          - const: bri
> -          - const: dri
> -          - const: tei
> +    minItems: 4
> +    items:
> +      - const: eri
> +      - const: rxi
> +      - const: txi
> +      - const: bri
> +      - const: dri
> +      - const: tei
>=20
>    clocks:
>      minItems: 1
> @@ -173,6 +164,52 @@ allOf:
>        required:
>          - resets
>=20
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - renesas,rcar-gen1-scif
> +              - renesas,rcar-gen2-scif
> +              - renesas,rcar-gen3-scif
> +              - renesas,rcar-gen4-scif
> +    then:
> +      properties:
> +        interrupts:
> +          maxItems: 1
> +
> +        interrupt-names: false
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - renesas,scif-r7s72100
> +    then:
> +      properties:
> +        interrupts:
> +          minItems: 4
> +          maxItems: 4
> +
> +        interrupt-names:
> +          maxItems: 4
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - renesas,scif-r7s9210
> +              - renesas,scif-r9a07g044
> +    then:
> +      properties:
> +        interrupts:
> +          minItems: 6
> +
> +        interrupt-names:
> +          minItems: 6
> +
>  unevaluatedProperties: false
>=20
>  examples:
> --
> 2.34.1
>=20


