Return-Path: <linux-kernel+bounces-93599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E157873271
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 10:23:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D65F5B2E4DD
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 09:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AAB0612C3;
	Wed,  6 Mar 2024 09:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="NMXr92U9"
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2063.outbound.protection.outlook.com [40.107.114.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F0F1426B;
	Wed,  6 Mar 2024 09:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.114.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709715991; cv=fail; b=EjXWkel57gnOzIe6obM1Jqxf47Cgyo8j1IDtV2+oqe+S9v+jg41xt88O4h4eXBvgAxSRLj/Ii03dKd2fbZY41EHl328+V+WkOpwi0SGfrr+A1/YInzuuCLmkreNaLq0pAPP4Ns7AoNbZueUSYVzov27ijFVv02XIP19x3QKnvJA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709715991; c=relaxed/simple;
	bh=l6iOfGIY1s63jq5qInzp8zyoOvFJPZvB2saF9OTZHy8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=epA5+xodikLMsJTM9yqPI3+YTuYVoXBtLzGjYp08XRlIs53CbSGZU5n4ZQwR+Z/hYdCKPuq1DnjxzsVPlWTbX6fnNXHHHcgHHV4oEKcruaCIjEs8cA7PiuQTnbIQJjIOiMlSrR+xzqfvH6N8GZ1CvXdLMiAlDo0y3OG0FnEAUCU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=NMXr92U9; arc=fail smtp.client-ip=40.107.114.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H5sLy+yNMi7bvTk9jYXxTHaDTVoOOhuHObCJ5BmXUF75sW+mvlOQKQuUTWlcQwSQ34UZykMvcIGz36m3Dp7GL8ZG23z30xT+0iZwuuo7WDoH4vngvDM0Hgh2A5fX3Ju1qsa+AmqKalSba0SNrgeKwGBMyZ/kr+EE8cyyPgn2Od8Nq3NWZHf0BZvGLM5bUxVWmIN8IIe5RlJ32391vjnf/No1QkJshdeCBoKET4LE3TsRWRwz5EfA2rBDw0QFxW7+fkfALGmvkVZU7Pn9pqbFECTQDJARW2ukePdk8+x4qEm/EJML2kkAZlxzo7YHQVOO+TLRLacSnkrCPRkb5eNYtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C+Cu6Lt6D+jsMLJ8GvekTqNmWJgc3/MPO6Es2bQK5L0=;
 b=InkpAh6uXCkconOqRkDTispq9wQ0hUWySO+SMoW+LwKTac9GNQYkHNIJ+3HOXq82jtdZWe1dqsBpomDGkNJuyyzDCOujqptCyT4kBoxFQFxvjku1SuJRsa8PgopoSLbOOMvkYsZqs+C9kjuUGQLkiwPts20rhds+npwwV8/q0ags3XxkLIHZ6h60KOJ9fT14OTIIYJyxg2SjSLxhm0PANj2Wh8EL3rIWL5QVQJ7VQTNgfsZWjU8B1FEVUNC0RMBFdOztb+r9tRlDwT9o7S/qnHpONCYJManXtSjqkEfvQQ+23S0ALbKFT2WHYi9tD18wmgsOg9r7r5RxU8Os+F70+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C+Cu6Lt6D+jsMLJ8GvekTqNmWJgc3/MPO6Es2bQK5L0=;
 b=NMXr92U9xsuY0HZEHguSlJMciNLxCdTL9lne2RieyrRnavFut4WOCGyM44HNLco9P2GujsLDuUfEyBid4Sd8ggeDS1TW61J6h5fJl6fumloCPdqQQUglNUYZtVOMvZ4uDICfPiHJ6TFkPk8QjzRopIREi4+yT9rdebUb7e8iDbQ=
Received: from TYCPR01MB11269.jpnprd01.prod.outlook.com
 (2603:1096:400:3c0::10) by OS3PR01MB7852.jpnprd01.prod.outlook.com
 (2603:1096:604:161::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Wed, 6 Mar
 2024 09:06:22 +0000
Received: from TYCPR01MB11269.jpnprd01.prod.outlook.com
 ([fe80::9013:d19:4845:e226]) by TYCPR01MB11269.jpnprd01.prod.outlook.com
 ([fe80::9013:d19:4845:e226%4]) with mapi id 15.20.7339.035; Wed, 6 Mar 2024
 09:06:22 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Tim Pambor <tp@osasysteme.de>, Geert Uytterhoeven
	<geert+renesas@glider.be>
CC: Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
	<conor+dt@kernel.org>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] arm64: dts: r9a07g044: Add complete CPU cache information
Thread-Topic: [PATCH] arm64: dts: r9a07g044: Add complete CPU cache
 information
Thread-Index: AQHabw/kpjnAM2gjZU23vtSxor3NMbEqbAcA
Date: Wed, 6 Mar 2024 09:06:22 +0000
Message-ID:
 <TYCPR01MB112696A947F31C31FE3A3AFF586212@TYCPR01MB11269.jpnprd01.prod.outlook.com>
References: <20240305151336.144707-1-tp@osasysteme.de>
In-Reply-To: <20240305151336.144707-1-tp@osasysteme.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB11269:EE_|OS3PR01MB7852:EE_
x-ms-office365-filtering-correlation-id: fc144ec9-6e5c-4350-959e-08dc3dbcb1b4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 oKna+cQCc+jL9pCd+/mYbiKd5O+nlvkx6e30+d4ztF/Aw5o5MUUQi7ohxmgXVUU5t+3DuJtDezj5smCLD8FYNWwAASKb8nH/5MvobanNCx0/wd7vTDBjlWho4/MtvnjMwSFVl9qmm3FDiMRUk4avIzvJpYjjT3eai10YiLUAa4NQ8edr82ZtL9NzJdspH2FUc4zIQyN9I3Gd1JkR3TzAUYG4McIyMjHAcSTeU3+LLdAm+FWnTOpTpcJxTLR/NoS8ECvG7wpD4cM2c3m7cfIojHKVADi98fzt2dLe1AMHlKRw0CFwX2fRAdr2yWToReVGag7AVGkzAm50RiUxNUYP+D8Ai88AwB5WREwFb0eaf96PWFJmCFQVl6F3gtkEzkT5PjteZSSi3MhKcU25ZMrgebxoe3EEwO/NH8rmgBt+4S4zL9C+cI5UiqXjMlPIJKT484/V+X+SW66PZ5p9ewEXjnoasX2TCMIagrtNRE+pouIVJkZE55vEIFvOL8NM43222oZs3eKhmke7xnHGu1ncQSZwfNlmokTW2IbGmQ0Wi1/iJb17kO0eQUjfqE33gVIa0bROTgi1H1+r6sF+D6gIy2m+Le+zwm4ZdpQfZYWEYci+RbTt7jI1ZZHTxQVvAstqUCdPOSXCLUHrCF/5iBaSq9cIOvHxMngPfOFsYTzhUBih6icjcCvRUJVll5uIQOuzJ8bRwkk/B/dhdGYvr3Uoe1hHs5ZRqAFwlVFUem3S/Uc=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11269.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?YYB+NQ4Eu5ideVbakt6CqX8+rWCRT6as3lw/4c4suNBzammQNPDHxi91tlfu?=
 =?us-ascii?Q?KeK+LPM8X6PLYpO2cSa0NaU6DX1/YQnXwgIRkHd7xoRTStomJrlxIIVBd9JM?=
 =?us-ascii?Q?wpbo1Q+/URQvMl+sUsBS/baYVw+iXMcNgZXvf4YWMLP1HPzt1wrR8GR6MnCC?=
 =?us-ascii?Q?r+nRmhjbpdrEts3z5z5VnTbG2R+PaTCTREiBXCul8/RTXeE2oug/d9kiHikC?=
 =?us-ascii?Q?smOrgrDhRFlnx3xiT7epwkT3JFXne9SgshQYra5V+bzD2ucY0Y813b33SA2n?=
 =?us-ascii?Q?FDfk5jWPijvjqmntZVe9F9qcf4aJVhRNBA1CAvljmDo9tNsmgZyC3ak1ts1B?=
 =?us-ascii?Q?ppWgj//PAHMhjnjE+OguTJwLa0Xi/C7nPxSev5xxVQfxtkqtzE9kbKGOLNwX?=
 =?us-ascii?Q?OL6xhK6eA6D/q3iykEVnVJMN+rvlZUKDK4IFAwQKcIySYo7Rb1SrmDAuSCIJ?=
 =?us-ascii?Q?ELQ3IichiK4k2gMepqpIyeI585y4BaDbxeGJWC+tLcFCtdofD3oa5YpY8Xws?=
 =?us-ascii?Q?jPfbIwS6kjor7fj+5E0oWUIbad10dlmBVwMh2e4UDasa3iES20WckO66Eh4U?=
 =?us-ascii?Q?kStBMvR8NrxcMX2v/43WNZ2iH+wUFQqPHLH3oJL5Pge024BWhRG4lWvreQY8?=
 =?us-ascii?Q?xW6nYTl8BW1yCh1w3CjIRySSVbRoju40qMPdQ9AR6sFgoUEO9kHW1umt/Wkx?=
 =?us-ascii?Q?8V60yp4PsFvOaCmSHmhEdl7YNhNtlsgYsOwAgchiHOdeCojyq3ZiOSqzF3UK?=
 =?us-ascii?Q?1q/5fHjBnULYlL/uFxhmLfKsR0TeT4hvGMVOnmAxlFlM3P2wR1VruAf+kB4K?=
 =?us-ascii?Q?0oLTjPrEpAU/3OO+6ej9ZlcXeYYoYOgkdDNcIIaJE+hNuHDajbtDVXzt8kP2?=
 =?us-ascii?Q?y3zApWVLmaSSnviR13z/K+R2/GKH0JuS1JdvCKGegmDFt1SUqN6oL3D61BGw?=
 =?us-ascii?Q?35+qXW2PM+dI7cNmhUyn1K3ERaO5vDr4uzXZ0c8R3K426VlVwWDjMnK0th8Y?=
 =?us-ascii?Q?aS94ROvQKWVrtNi80bIPPIPLQ2EKaoim+DrJJlpQzcU7Hbzwwwh3kgTkKGan?=
 =?us-ascii?Q?racGShmqwumo+kg9sXSNuuOXKVZbm5hOPs5qGaIyyikg9rsSxuMG9TwHlbf+?=
 =?us-ascii?Q?Vqzud2hViA+0NPi92dhXMXZWTzOTuNr/mwJhrqa+WULYc+ku3NyDJARpr01Q?=
 =?us-ascii?Q?u6KOaOGFr+Ny6Y8r3JwSSIvsiLw+4ld1tRvrq6tBuaRC2bOrS7LsOcA1gcPJ?=
 =?us-ascii?Q?76u2GqrX7OZnTmtrP9K/pHbKNbfD5LNetdDEsJXlU7KjDf6jPikj50DDkJy3?=
 =?us-ascii?Q?me92ycaWxbz7ThxW4RxHwimb4g26QwOMAFVwNxq2H9k6V4FXwKBSywfgZeVn?=
 =?us-ascii?Q?tnSaEGDwCKQhcDdCSY14Qf1YapRhYbTj8OG57eNxyMwbyRKiUWgw/wb/FUyl?=
 =?us-ascii?Q?8WCiNLlE+SKpM/W9mArXiDQrDC9AdY751vxRvrpmvJjQ8Uvi49mi42r9/hDr?=
 =?us-ascii?Q?i/OT5ZhazA+1sR4ptijnduxs+7NAs9d49/521nHc8Q/bfrfksEr8HAllzKKI?=
 =?us-ascii?Q?l4oCOUBjBqnRtv/9Eb3VmzX9IC8R6MzdyK744SiT4FZSJ1C1s6NX7u7vFK/8?=
 =?us-ascii?Q?Gw=3D=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11269.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc144ec9-6e5c-4350-959e-08dc3dbcb1b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2024 09:06:22.3691
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bci49tX6BBwX9BoZ2smKxYiht3xcG68AXXINPx9Lxr6U2R8a5fxibX2ryXizqa61FeBo6bpjOOKxP2N8uUU5V2ItIJWl4Z5ujfOEorB6XcM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB7852

Hi Tim Pambor,

Thanks for the patch.

> -----Original Message-----
> From: Tim Pambor <tp@osasysteme.de>
> Sent: Tuesday, March 5, 2024 3:14 PM
> Subject: [PATCH] arm64: dts: r9a07g044: Add complete CPU cache informatio=
n
>=20
> Based on ARM Cortex-A55 TRM and RZG2/L user's manual, each Cortex-A55 has

RZ/G2L

> - 32 KB of L1 4-way, set-associative instruction cache
> - 32 KB of L1 4-way, set-associative data cache
>=20
> Each cache has a cache line length of 64B and therefore there are
> 32768B/(4 * 64B)=3D128 sets for each cache.
>=20
> RZG2/L are not configured with the optional per-core L2 cache but only ha=
ve a L3 cache shared among all
RZ/G2L
> cores. In this case, the L3 cache appears as a L2 cache to the system. Th=
erefore, specify "cache-level
> =3D <2>" for the L3 cache.

You mean for L3 Cache, cache-level =3D <2> if there is no L2 Cache on the s=
ystem? Does it need any update
on dt-bindings to make this clear?

Cheers,
Biju

>=20
> Signed-off-by: Tim Pambor <tp@osasysteme.de>
> ---
>  arch/arm64/boot/dts/renesas/r9a07g044.dtsi | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/arm64/boot/dts/renesas/r9a07g044.dtsi b/arch/arm64/boot=
/dts/renesas/r9a07g044.dtsi
> index 9f00b75d2bd0..6379c850526a 100644
> --- a/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
> @@ -89,6 +89,12 @@ cpu0: cpu@0 {
>  			reg =3D <0>;
>  			device_type =3D "cpu";
>  			#cooling-cells =3D <2>;
> +			d-cache-size =3D <0x8000>;
> +			d-cache-line-size =3D <64>;
> +			d-cache-sets =3D <128>;
> +			i-cache-size =3D <0x8000>;
> +			i-cache-line-size =3D <64>;
> +			i-cache-sets =3D <128>;
>  			next-level-cache =3D <&L3_CA55>;
>  			enable-method =3D "psci";
>  			clocks =3D <&cpg CPG_CORE R9A07G044_CLK_I>; @@ -99,6 +105,12 @@ cpu1:=
 cpu@100 {
>  			compatible =3D "arm,cortex-a55";
>  			reg =3D <0x100>;
>  			device_type =3D "cpu";
> +			d-cache-size =3D <0x8000>;
> +			d-cache-line-size =3D <64>;
> +			d-cache-sets =3D <128>;
> +			i-cache-size =3D <0x8000>;
> +			i-cache-line-size =3D <64>;
> +			i-cache-sets =3D <128>;
>  			next-level-cache =3D <&L3_CA55>;
>  			enable-method =3D "psci";
>  			clocks =3D <&cpg CPG_CORE R9A07G044_CLK_I>; @@ -109,7 +121,7 @@ L3_CA=
55: cache-
> controller-0 {
>  			compatible =3D "cache";
>  			cache-unified;
>  			cache-size =3D <0x40000>;
> -			cache-level =3D <3>;
> +			cache-level =3D <2>;
>  		};
>  	};
>=20
> --
> 2.43.0
>=20


