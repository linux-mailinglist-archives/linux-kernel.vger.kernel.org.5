Return-Path: <linux-kernel+bounces-33855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22770836F95
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:18:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46CE51C2781F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6297481C9;
	Mon, 22 Jan 2024 17:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="F2Q6SFvA"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2053.outbound.protection.outlook.com [40.107.8.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4571481C1;
	Mon, 22 Jan 2024 17:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705945622; cv=fail; b=PG/VhZG40Gn/PUyVcXJXJuByfvDmTMuPGPak/Ux3gfLjpWH0CnZPCJu4UanDK1vXyGbFAQfyG8WeC+bQEzkgEhupcUqWPnOaUYpK0IMiHU0rjgiW0uM54OFvTPkYZTJrzp7BsxDYXKGkIvG5Q39N/zD7Fyi2Z/HQo1c3sblwGKQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705945622; c=relaxed/simple;
	bh=w1RjIJzTYwVs+UdsGI8SvLYKC36FBiUEOfCrB9il0dI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NC9mrew2fh61nqwbpL2KdwL7uzphtXunu6femGj1YP1fcPlgV+P4ux3FOpeD8Rws6TX1fw+qX0pDOS0KbRARiA7tQPvu7qCS15DzJhW8Pjlb7wuOwof5kSVv7WyN3kqmreP8Rlmii+4yZqk8uugQXIMCHvvPN6FE2Gu0X3txjcs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=F2Q6SFvA; arc=fail smtp.client-ip=40.107.8.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B2aCtP13FRVE1k5ZTFSFvQ/2p1iZ9o1XzJI+neRMt/xQ9fUMS3Rsq8W/CS5hO9i3Hq9HHpGoP7DBxOo0Yece8omIQ9MC5atEqJd+a7HsWjWzTF6yYI0Ls0EcrCsjITI8Di7rQ4vza+05l2yUT6IEkjmgHqVrxkMhobJISQCcaPjMi8PVlBguWsmLwWZYgYVWA6EZfCGM+pj+EQpDCEERecygz5XcudOsdzp6D/nQObytDpc2pN0+tLFA7KPaajbyQ0BZ396BMmKZtYM3yuiF688hhKYVY87aps0qB1CFBzMn9xPqAHGakBaYwsjzgNiBWFsnNdrqdMOIT7mw30ekAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kkhhv3NxBeqQZUZVPyOMwK6zHb3nvDGsZI1y1lVtqtA=;
 b=BWMR66QuB8n8OXjd3pNgGYb0kr729ujYUIg48SXqIUcjFPWOl+OKidDkjpnP4mtlK1MmBC5SfM4FvaCsr20x+suzBmlWX8ShinskH13bzXmHLfgpEbwh9NYD1cigterK/R+HedxFO/uj5lKKceDhKDb8iPVHk/Gwm6qZtqAFnp23RHd5K++mRG6Oge22c9oos4BsoXekr33asve7gZc8mKJhq0wFT2Pj2wLPzP8+5qRh+v/HAM6ym9yHGYgQATanTNE3MBgHObD6Cwwi/d6pwqGMeCxEeiEur0xE9FiKkRAvFlatBqIQwvN5Dte0wSqCicuVMpNhh/q0AklZ2lTGYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kkhhv3NxBeqQZUZVPyOMwK6zHb3nvDGsZI1y1lVtqtA=;
 b=F2Q6SFvAXWvijix0RcG0G21DOxlUTMouAf9aG2vXwbRVxrj+KWCy+ZjttJ+8uPczvX+qX5q/CIvsGQYirQfrJ28o421hCfSklSt/MfILGhFpum7/TLMtRn7VvHrFlpGFBtggkkcnhpDEjW3vtmSafymUstN7k4SMylqJRjydFwg=
Received: from GV1PR04MB9071.eurprd04.prod.outlook.com (2603:10a6:150:22::11)
 by AM0PR04MB6883.eurprd04.prod.outlook.com (2603:10a6:208:17f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.36; Mon, 22 Jan
 2024 17:46:57 +0000
Received: from GV1PR04MB9071.eurprd04.prod.outlook.com
 ([fe80::45f1:a6de:ef4:698c]) by GV1PR04MB9071.eurprd04.prod.outlook.com
 ([fe80::45f1:a6de:ef4:698c%3]) with mapi id 15.20.7202.031; Mon, 22 Jan 2024
 17:46:57 +0000
From: Han Xu <han.xu@nxp.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, "broonie@kernel.org"
	<broonie@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	Bough Chen <haibo.chen@nxp.com>
CC: "yogeshgaur.83@gmail.com" <yogeshgaur.83@gmail.com>,
	"linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Peng Fan
	<peng.fan@nxp.com>
Subject: RE: [PATCH 2/2] dt-bindings: spi: nxp-fspi: support i.MX93 and i.MX95
Thread-Topic: [PATCH 2/2] dt-bindings: spi: nxp-fspi: support i.MX93 and
 i.MX95
Thread-Index: AQHaTRLsd5UXzThLU06Tvu1EQw24wbDmG7mg
Date: Mon, 22 Jan 2024 17:46:57 +0000
Message-ID:
 <GV1PR04MB90712E37B70D30462960D26897752@GV1PR04MB9071.eurprd04.prod.outlook.com>
References: <20240122091510.2077498-1-peng.fan@oss.nxp.com>
 <20240122091510.2077498-2-peng.fan@oss.nxp.com>
In-Reply-To: <20240122091510.2077498-2-peng.fan@oss.nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1PR04MB9071:EE_|AM0PR04MB6883:EE_
x-ms-office365-filtering-correlation-id: 3b7acfa4-4673-4b61-3ef1-08dc1b7220fb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 FcL7nf4XIhRNfP0i8Y89LjDPRi8xv7UGFZjdCAdinwai9c4AJ8fzyoDK+vmi40kJOkUU9hVS4eW/ucivg5PjNhJvuy+/jFOGbjJofEpoQoBqh8p+YKFflPOS8ZgTYRbUX2ilPh1ILa7jydezvWNA2oOaEbpWl5wk275srub6AnQ2bMbZ+YV13MmOxQCWpJ2nPVOs1kotgEkPv/Y7CsIDE/hIM5H67wqcLEdKKcHRpr5dsw58VXeV/h2t1JZEJyWWwiyI1Kh2g60GGBiEICqXCbRUJYoh/qevr4XnZ85lrcxX3WisWGkn3HDcb+916CZIldkA+H7ZxkUcRaAF2w24jl1hdIHouFdWT5cWmy/UP1o0RTtqx4s8rCltR7BnmORFOgZTDHj4eBZmVeay/JOfCos3860a/lZpQKsdjpWTdnX1MtBdyAHs6dfYeyY/WcGtMYv4NRhy7niXdSTiPPdeGGIFdrmzqalBIY07Z4lqaM9116Fa9sJfm63wDFi68SqFFWpSM5AN1Grp2YbntVC1vG6sVIroXCzVVkl2oIAkzTPY0BGXwwW1yQkO1P4pPnO822AgdKHjwFFUqXRb20X1iTBrZRjRuF7/qvanrsk/bClfGCCDBqHMRXZsKySHufBn
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9071.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(136003)(39860400002)(346002)(396003)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(38100700002)(122000001)(38070700009)(33656002)(86362001)(55016003)(83380400001)(26005)(54906003)(316002)(76116006)(110136005)(8676002)(8936002)(53546011)(7696005)(6506007)(71200400001)(478600001)(64756008)(66946007)(66556008)(66476007)(66446008)(6636002)(55236004)(9686003)(2906002)(41300700001)(52536014)(4326008)(44832011)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?VwnlU7MQnNlsSo6d6uLhrVKp5Fliwiof7COUDsKFwzx6ru8SCzFClUiTqRlz?=
 =?us-ascii?Q?9cSb8jx9KbNK63sdZrnzl0xxi397ke9MFEt5HszFfuhbnWsESH784opoTO5w?=
 =?us-ascii?Q?vFSPptwzIL+GkXfiT8FmrzIOyv2Ufr00WVs1c7508FVVTAWfJq2un56ig+o0?=
 =?us-ascii?Q?hRN00Sjk6WyG8cm4WVhJ3k0EONPbi6dyiDXdsiMhEPAI6CvDkmHqsWMXMDF/?=
 =?us-ascii?Q?78k8KDW8BYL8HNJ79bvSe+ySZI2Jt//GdaLdd3MquGuyKOH7BwKfYMJIpdv0?=
 =?us-ascii?Q?gqJPzykmW05ZGAcltEkQWetsRTawOwpkTDZfFvc8FIpbx5WiLY5icszt8CJ0?=
 =?us-ascii?Q?iqgoPIQAvef+77J2AWVaqFErzHExZT+l78wBLw+5lfMrtaAOo8wBbPttxrgP?=
 =?us-ascii?Q?I/rO9oZxFXhJa4Rv5BqCNQPGZwHZsOYdIpswptDbcWHcQleTQZ8PcOVnyZQO?=
 =?us-ascii?Q?FQo0l6JIEU4A6v8hKWEsQslnXpzXHJ5s5zIl6pbCFqjpkoAb108SHLX3GHnQ?=
 =?us-ascii?Q?nphR3dSY8cwfie8yfI5exc7dLEdKvhf+CbUEsOOf1PlWVEYM9fiVUysrGSCY?=
 =?us-ascii?Q?DNEKEduGJtzTaB/oxzcxy9Yq+85A8fjOpQasIF99T1mvIGoVvz9kaoTqX1pZ?=
 =?us-ascii?Q?kKIe0OQF7JoJATDnFEzvJ1hAXCzyU+KqVvNasXYvP3rrFY8GvVFhRzL+32p2?=
 =?us-ascii?Q?UXQxyATGZixalxcsTJC+8P/wn0BvkB5ptwalKAF0m6Ofh6O3vOzOD/JL0c4p?=
 =?us-ascii?Q?+wGIZy74WjHmkVTzcBmkyyc32bSxTkk+12ONCOpona8PbsQeveGteyicQDr/?=
 =?us-ascii?Q?FWEvVyail+MqQaNeGO5G0qaq7Whm5h0EsiHZbL5DmQagp8wwbt4pgTGwfnq2?=
 =?us-ascii?Q?wGqDMTSmn2Rk0GopzENYQrYg7nIwbRZZHyQ4M6VEunfT3Rmk1nf9v4+Mn7y8?=
 =?us-ascii?Q?n/HTxjHoWvdRkBf98fq9/3sIhEtVodK1WOM6CZdpqywF+C2AZXjfVUE+TT40?=
 =?us-ascii?Q?TNIfc8sRz09plRWbKi3H1czJJCpIoG4sh6AupmKLeS8pFlimBEX2eI3HCd9t?=
 =?us-ascii?Q?e6TQkY2PbQpmksOZ0TQZ0aMb2tN7BYULyaPMQS4jZ7U256Co+JC+Ue2ju66Q?=
 =?us-ascii?Q?2KKeSRMqxF/9l9UXQgycNFA/OofY5PpjepS/clvSoqNwbLrDn4Y5hxwWfksU?=
 =?us-ascii?Q?WwFboIr9bxUeSCBgqFyHS7vaGXAfB2n59wHusoRL2djNJB6/AhnPLUmWe4Ea?=
 =?us-ascii?Q?Cl3zGnOxGHg2tKQbQH4MCeuJlgNrpI8FH1FfM9Nqn0fxoLilJBk2mc5o9/Dh?=
 =?us-ascii?Q?Af8acn5f10tWP8QsXg4P+3/OGyfh15q3id3tJftx5IFuw912x0MoI+FU5XxW?=
 =?us-ascii?Q?ONSxKyB/ifpPzG46hd3w5BxiJ0IQumWz9paiBWbTHStfu8JXsP6M+VCX7AAl?=
 =?us-ascii?Q?3utq3FPcOsvxcNfkBlZznalltK5NGpk2Vyzh5RLY0xImUJnq3LiGu0VrHtqD?=
 =?us-ascii?Q?ZlpdO3uASfFPEED7pOfxA74fa5p3prFjRCGC5NBypOoIw/wDV1pk+C8yYpRK?=
 =?us-ascii?Q?bY1nXXmSFfmEArRPFeg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9071.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b7acfa4-4673-4b61-3ef1-08dc1b7220fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2024 17:46:57.2994
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v8SWVaJs00a79I4DHBdETQK5jA2wVhooAoBsT8UXN+Om0PJbCDxuQixpxvdU5aaP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6883



> -----Original Message-----
> From: Peng Fan (OSS) <peng.fan@oss.nxp.com>
> Sent: Monday, January 22, 2024 3:15 AM
> To: broonie@kernel.org; conor+dt@kernel.org; robh+dt@kernel.org;
> krzysztof.kozlowski+dt@linaro.org; Han Xu <han.xu@nxp.com>; Bough Chen
> <haibo.chen@nxp.com>
> Cc: yogeshgaur.83@gmail.com; linux-spi@vger.kernel.org;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; Peng Fan
> <peng.fan@nxp.com>
> Subject: [PATCH 2/2] dt-bindings: spi: nxp-fspi: support i.MX93 and i.MX9=
5
>=20
> From: Peng Fan <peng.fan@nxp.com>

Acked-by: Han Xu <han.xu@nxp.com>

>=20
> Add i.MX93/95 flexspi compatible strings, which are compatible with
> i.MX8MM
>=20
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  .../devicetree/bindings/spi/spi-nxp-fspi.yaml  | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/spi/spi-nxp-fspi.yaml
> b/Documentation/devicetree/bindings/spi/spi-nxp-fspi.yaml
> index 7fd591145480..4a5f41bde00f 100644
> --- a/Documentation/devicetree/bindings/spi/spi-nxp-fspi.yaml
> +++ b/Documentation/devicetree/bindings/spi/spi-nxp-fspi.yaml
> @@ -15,12 +15,18 @@ allOf:
>=20
>  properties:
>    compatible:
> -    enum:
> -      - nxp,imx8dxl-fspi
> -      - nxp,imx8mm-fspi
> -      - nxp,imx8mp-fspi
> -      - nxp,imx8qxp-fspi
> -      - nxp,lx2160a-fspi
> +    oneOf:
> +      - enum:
> +          - nxp,imx8dxl-fspi
> +          - nxp,imx8mm-fspi
> +          - nxp,imx8mp-fspi
> +          - nxp,imx8qxp-fspi
> +          - nxp,lx2160a-fspi
> +      - items:
> +          - enum:
> +              - nxp,imx93-fspi
> +              - nxp,imx95-fspi
> +          - const: nxp,imx8mm-fspi
>=20
>    reg:
>      items:
> --
> 2.37.1


