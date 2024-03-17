Return-Path: <linux-kernel+bounces-105492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A28787DF35
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 19:26:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EB861F21118
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 18:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E49C1D554;
	Sun, 17 Mar 2024 18:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="E9mv0ZmN"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2086.outbound.protection.outlook.com [40.107.20.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28791CD2D;
	Sun, 17 Mar 2024 18:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710700003; cv=fail; b=CzVlTg8JxLr7A4C9C6DhSc2BGFZLG5D3Pe3S3Tx/zOlHRePNTBeb2bpslGtIR9BSJd819joXDHggy6ix5VScRdvMiQR0ofiZYI5f9qNWliSopN5i4kB0+vvlRTvkL7clyN9cii5hqguH2UmFTkDKxugeNUzT6CWsrBTqK1JjlJo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710700003; c=relaxed/simple;
	bh=H7iSEMAWNOvFi3o/29Xis8xVfu1/aY63D9bxtxIRbvc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FHOxG93yjEGCe8k1sxpFUhvAWr3RNeHjcwn3PRcTO2Vrg8EnTOVcslxtyBe2E8MVW687oTf0rUUwhxpIz6iWe0PVA6p6CUx/J7IM+gjcSgYzy5WIylVd3mBxv0Nh0ooSgI42O/zmFs5M3dy3wh5DLuCVBYlmQNspkoWRelisfpU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=E9mv0ZmN; arc=fail smtp.client-ip=40.107.20.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MkvedjfRTtCW1Ibu8nZWQZes4OqCEKEQi14dB52UgBTE2PYweEIIUhHDw9nbO+1oNsAgR3Dog+OCtWthUblHrVhOa9ymxBsxUCtjbmVFv77Sd6sLFv8TuAwlx89ny691/jqMvvXWwgxLfhTEYsnvETL89UvE3RokovRWXRxg69w4c7wkR71R09dShrKnZgQoea3SCQc9cOrhe9rISETIxh7acU+VT2xY9DcEYPI1SsNmy5Sbl/Dma9yuZ7S7UnmwGI2BUv0dq3Jo/CXOharCqPV6/HXYZWrbBKH12poXyNglb/AB3xAwmYPVw/rjCR1fVvL0jRpL8HY01bwi0tDoXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0GAFmvcrE77bMXib/Z1YreCqEkBfRT1CMZnXJ+g710U=;
 b=cRL3x7vIuH9Rd0h9RB89z5fHhwQbWRce3uOXPxzTpM8BXuwikqXAN4HUPasOHOaE2oBqvtt0ChFB+Iu9g2GSAsy+SRqtJ2CPH0REEMznYGyD9Ksmax9G3NUra2I/efJNdMhTDk05cWowW7xw0SUxhlcMPmn3vm8mG6iVnlWx+HLTJyG/pnLGGJsUEG9y4PJ9T+nO5cdLq5ekuhkCOESuR9k1+Y63+uITehV2meoC+/IBdl85IUZ4ieJ8cxNwXaDYoGkmJ7C7LLj00SAD0c85+BLsk8Uz/t5y0AcGI7SHJOomjFgXyqsdXwCwXDTujDkwA7iaov6eqKR82PjMoTX0DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0GAFmvcrE77bMXib/Z1YreCqEkBfRT1CMZnXJ+g710U=;
 b=E9mv0ZmNv2/TwzY6DiSO/xnGG3azb8zcFZ25ju02fGHBjc6X6opuZJjUmW4KQb0WHMuEQp9q6oOKVCKMMHnfqj+cjACeWFE/ouYbiCZO7e6kU9xLwwbGd9TR0vSCrYHYBPEKMBef3c9+abWULdukUg7GnPGPhzHrrCidI83HwOQ=
Received: from AM9PR04MB8506.eurprd04.prod.outlook.com (2603:10a6:20b:431::16)
 by AM8PR04MB7233.eurprd04.prod.outlook.com (2603:10a6:20b:1df::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.19; Sun, 17 Mar
 2024 18:26:36 +0000
Received: from AM9PR04MB8506.eurprd04.prod.outlook.com
 ([fe80::7d6a:fec:d2b2:9f48]) by AM9PR04MB8506.eurprd04.prod.outlook.com
 ([fe80::7d6a:fec:d2b2:9f48%7]) with mapi id 15.20.7386.025; Sun, 17 Mar 2024
 18:26:36 +0000
From: "Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>
To: Wadim Mueller <wafgo01@gmail.com>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam
	<festevam@gmail.com>, dl-linux-imx <linux-imx@nxp.com>, Chester Lin
	<chester62515@gmail.com>, =?iso-8859-1?Q?Andreas_F=E4rber?=
	<afaerber@suse.de>, Matthias Brugger <mbrugger@suse.com>, dl-S32
	<S32@nxp.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu
	<joabreu@synopsys.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Michael
 Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Richard
 Cochran <richardcochran@gmail.com>, Andrew Halaney <ahalaney@redhat.com>,
	Simon Horman <horms@kernel.org>, Bartosz Golaszewski
	<bartosz.golaszewski@linaro.org>, Johannes Zink <j.zink@pengutronix.de>,
	Shenwei Wang <shenwei.wang@nxp.com>, "Russell King (Oracle)"
	<rmk+kernel@armlinux.org.uk>, Swee Leong Ching <leong.ching.swee@intel.com>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-stm32@st-md-mailman.stormreply.com"
	<linux-stm32@st-md-mailman.stormreply.com>, "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>
Subject: RE: [EXT] [PATCH 2/3] net: stmmac: Add NXP S32 SoC family support
Thread-Topic: [EXT] [PATCH 2/3] net: stmmac: Add NXP S32 SoC family support
Thread-Index: AQHadygmpZcxt3cMdEis10A9c180DLE8QIdA
Date: Sun, 17 Mar 2024 18:26:35 +0000
Message-ID:
 <AM9PR04MB8506244076FBC931101B2205E22E2@AM9PR04MB8506.eurprd04.prod.outlook.com>
References: <20240315222754.22366-1-wafgo01@gmail.com>
 <20240315222754.22366-3-wafgo01@gmail.com>
In-Reply-To: <20240315222754.22366-3-wafgo01@gmail.com>
Accept-Language: cs-CZ, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB8506:EE_|AM8PR04MB7233:EE_
x-ms-office365-filtering-correlation-id: 6dc30c92-7cce-418a-acb0-08dc46afc77e
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 EbkRezFyw6pmolhKaD1p13oQpHgkTy5UyL9OMQ4zlba7yx2JD5Q4Z2VCcqPAyyr0ZO2Jq6y5WQaM+BZWOqK2KUvrahimV5mhJIfy0i8kvftKudDutHKr04CeXFTMRFgTFAI8Q/pZV7WUl+/hFd2kWHXgMkAXhf/dhGQNyT3vm28c3DQ59yaRmI1jyITnkkQlbJbJ6rkTFb2YlZrdftjIUzBNAI0T3KVnZl4c3s0RXbnotQg7u76snDCWH3WZ7S51epuh+qkfkrArkqapiZo+M2Nk0YAg38THeMtv23oM9D2rKS7EvsfX20AfXKYYWBuNbrrt+b/65FFJRSa3Crc65juGmh3f5K5AxVHlWC7wsCuccUUgylCkf76BiYgkw6LAdTwPQxDTkr8UAd+AgWoQ7ng79wN/Y6rvP8VZtqD+xcAI5WcPaSqt2Mal/EYyItpNYM2b2SJc9FR8MhtkOaItDG7abr3vrbOnm2U1W8hm3ENI2Lk10ONKeiW625QBHdhNqk7jxi8bJ2crafh6TRKzWdawBth1cTL8RrvFQ8X667WiLQ9LDjRPaj+ZXpJzuhFD55+HiRj1Rzpb2z6h0oQ8mtwSk6hrVkTZ8jyHJw7Wbezyc086AuBZFRvj9u1YgAtjAHCMSaY016ejlmGHRUpty557Lmf81sfoh2fuZBEps3I=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8506.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(7416005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?TG17Hcfh9EpAne64ecRKPEKe2cJlqB33dBBd1I6Oe1pFAH22BdL12DIBkX?=
 =?iso-8859-1?Q?P3E/mLsDKEr4H8AS5IIFHijPAV+PCbk4bePmxAbeH4/8jmNfunyPCmAiho?=
 =?iso-8859-1?Q?j1Dp2qgHZAMenkspOCm6onORHjdHhyFWrLhirUx7brQKZu38UY0RjiZTY2?=
 =?iso-8859-1?Q?bd9af2X7dBvCCqjbzlSyi0FMJwmwvNvbXmHe97CkBtx4tTSysC87djOpW/?=
 =?iso-8859-1?Q?r/m6Ea55Wuq1akwlf34EyZfPCSv+kQc9AHdsL951KQdjEZ6GUPM+9gi3Xl?=
 =?iso-8859-1?Q?P3NqBJorRFXD6XzNaqaW23fJ1rKvTdoF+rhcfJgLHrDymkxnF3R6Yuck3B?=
 =?iso-8859-1?Q?JewxfpqZ1aNo6ePY1h0SpcxItgavJzvRxTvUx77Z187kKih04mfukuj41w?=
 =?iso-8859-1?Q?aOroP+MlHtQjyQ7GjIrDN71xlwP/fr/v6iWaJuq4oMlQY4ZhuCNI2KLmIz?=
 =?iso-8859-1?Q?FESIsHDUblqzSlxpajQzBXHlrDANiqKYHNVpyS5j+KFgS79ndZnycXWZ1j?=
 =?iso-8859-1?Q?j4UlittUEoQNxHfZQQ32oGJ/FFMzCG5LnfzscC3amABAE+lPGH3WpXvckc?=
 =?iso-8859-1?Q?ZS6sHkPpaOPLftbQjKncSCgnJneZeDfvL9514Ia1+KkIly03Hn30oedEtu?=
 =?iso-8859-1?Q?chR85iRrW4aj9kzI8ykqMzXuYlKiyXUg8vJGicecX2a/8lzt/NJvkXFU95?=
 =?iso-8859-1?Q?fPKUmgC/8HdFb0XOZeyWMq413RSPamg0MBHylSKAR9Ob+fqZEhFNCylqXN?=
 =?iso-8859-1?Q?1uXY834RLQjTgOESdno2fCx006vWqgzc7pUoeN17hjPWF/lOHTFkL+0okz?=
 =?iso-8859-1?Q?yfTJSWGNdSqUK1oDuPkAIAfB2AyIepf93leCEqWOtXW1qf0fX7I3MA47fy?=
 =?iso-8859-1?Q?1yrVJi0Onwv660DD8iSf4ZhDgwIEO8DxSofJY58cVRImx2oMfu5b4OlIUu?=
 =?iso-8859-1?Q?fSIm3VFj68xCO3acbePnO6frK0psyiXc57pmog9qeaVo5p1HmGChQbmC+z?=
 =?iso-8859-1?Q?z269Jwn04C4gjUfZZnZAXZiZGlXBZqp7lTW9lsAGta0CfOq8ijlt/B4+x5?=
 =?iso-8859-1?Q?L0SSWEamhWrmL80fJ8rJwbveXHd5iukG+Ug8rR9Qx9S3ZjXo/7NGafkSA3?=
 =?iso-8859-1?Q?nytebFhlSJGmsayuZpqCFHGL8i9qJ8lvY6gwHJWqQmpDm9ptQrn3wekBBa?=
 =?iso-8859-1?Q?SgvsjMqDYWFpXxQfb0psGkrmrku7zn065ofoxbVGurCZNkdOjlfONEqYji?=
 =?iso-8859-1?Q?l421kN+7YO8NDELkXGGG4qY2PWy5BOFPkENHjfG6nSR31j0yMfxFyco3Vp?=
 =?iso-8859-1?Q?jRJZfzrYZtSy0jD3LutK/EmcR0okdAMIIqkOdpteO9w735qXg9dqQhMbKu?=
 =?iso-8859-1?Q?Omas5q7TJHyTSRJNDNcn3/EVDuRUauEUJuWRnM1OL8UoQRaBMYmYE4zTHg?=
 =?iso-8859-1?Q?HysnUMdR67bS6Vd++bN6XvFAGADrKPuv873GG93frLXxxzNiN0gW5v0y0h?=
 =?iso-8859-1?Q?3OcHDODouD+aKVlKbtQ5i/cluVfxRyyBvO6nAENXa2hlgSSmzBTevt3xn2?=
 =?iso-8859-1?Q?a8ectZ8jVvUM7saCZX+KzIGS8D4lXZsLaKsoIsecCMkCOq5pcy+ZRhxV/W?=
 =?iso-8859-1?Q?yCSAwr4jmlcfYtU20TQHz5U5xvQ3C4GtQ2?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8506.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dc30c92-7cce-418a-acb0-08dc46afc77e
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2024 18:26:35.9886
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FoDfFi9U6PSngon356gnZLyNJH+Dd0dc8L3gHSAoKg0hH1ha3p/rcGdwtaJM2Ni6ktdRGsgN+Xm0kpaNW1EGbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7233

> Add support for NXP S32 SoC family's GMAC to the stmmac network driver.
> This driver implementation is based on the patchset originally contribute=
d by
> Chester Lin [1], which itself draws heavily from NXP's downstream
> implementation [2]. The patchset was never merged.
>

Hi Wadim,

Thank you for your upstreaming activities, but I would like to note that
the old NXP S32CC  stmmac glue was rewritten lately and will be part of nex=
t
NXP BSP Linux release planned for April.

The rework was done mainly to allow simpler upstreaming process, so I would=
 recommend
to postpone your current work.

Thanks.
/Jan

> The S32G2/3 SoCs feature multiple Ethernet interfaces (PFE0, PFE1, PFE2, =
and
> GMAC) which can be routed through a SerDes Subsystem, supporting various
> interfaces such as SGMII and RGMII. However, the current Glue Code lacks
> support for SerDes routing and pinctrl handling, relying solely on correc=
t
> settings in U-Boot. Clock settings for this SoC are managed by the ATF
> Firmware.
>
> Changes made compared to [1]:
>
>     Rebased onto Linux 6.8-rc7
>     Consolidated into a single commit
>     Minor adjustments in naming and usage of dev_err()/dev_info()
>
> Test Environment:
> The driver has been successfully tested on the official S32G-VNP-RDB3
> Reference Design Board from NXP, utilizing an S32G3 SoC. The firmware and
> U-Boot used were from the BSP39 Release. The official BSP39 Ubuntu 22.04
> Release was successfully booted. A network stress test using iperf [3] wa=
s also
> executed without issues.
>
> [1]
> https://patchw/
> ork.kernel.org%2Fproject%2Fnetdevbpf%2Fpatch%2F20221031101052.14956-
> 6-
> clin%40suse.com%2F%2325068228&data=3D05%7C02%7Cjan.petrous%40nxp.c
> om%7C0cc5c9f3d01f4ffd9c8808dc453f46e2%7C686ea1d3bc2b4c6fa92cd99c5
> c301635%7C0%7C0%7C638461385281642147%7CUnknown%7CTWFpbGZsb3
> d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%
> 3D%7C0%7C%7C%7C&sdata=3DrIngeRww4WVHGJtI9z9nQssulWK772YoRkOcB0
> uKoN0%3D&reserved=3D0
> [2]
> https://github/.
> com%2Fnxp-auto-linux%2Flinux%2Fblob%2Frelease%2Fbsp39.0-5.15.129-
> rt%2Fdrivers%2Fnet%2Fethernet%2Fstmicro%2Fstmmac%2Fdwmac-
> s32cc.c&data=3D05%7C02%7Cjan.petrous%40nxp.com%7C0cc5c9f3d01f4ffd9c8
> 808dc453f46e2%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C6384
> 61385281650452%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiL
> CJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata
> =3Dy1EPryNiZIM4lzzTGPfcY4QGHgG8omiOKM8LfTkUqBs%3D&reserved=3D0
> [3]
> https://linux.di/
> e.net%2Fman%2F1%2Fiperf&data=3D05%7C02%7Cjan.petrous%40nxp.com%7C
> 0cc5c9f3d01f4ffd9c8808dc453f46e2%7C686ea1d3bc2b4c6fa92cd99c5c301635
> %7C0%7C0%7C638461385281656709%7CUnknown%7CTWFpbGZsb3d8eyJWI
> joiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0
> %7C%7C%7C&sdata=3DydOwCmVhv4C40MIdo%2F5BCUHr588N%2B%2BqRxeKA
> gCjwlT4%3D&reserved=3D0
> [4]
> https://github/.
> com%2Fnxp-auto-linux%2Fu-
> boot&data=3D05%7C02%7Cjan.petrous%40nxp.com%7C0cc5c9f3d01f4ffd9c880
> 8dc453f46e2%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C638461
> 385281661168%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJ
> QIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=3DR
> vq1e2h%2FdF0ZAAR7rTNWDM9k4ktVlZV3D3Oi0ZDVtts%3D&reserved=3D0
> [5]
> https://github/.
> com%2Fnxp-auto-linux%2Farm-trusted-
> firmware&data=3D05%7C02%7Cjan.petrous%40nxp.com%7C0cc5c9f3d01f4ffd9c
> 8808dc453f46e2%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C638
> 461385281665752%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAi
> LCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdat
> a=3DYaU2kR6PC0%2FkpZ7htdJuLY555XliyI7GU%2BH6TneNSIE%3D&reserved=3D0
>
> Signed-off-by: Wadim Mueller <wafgo01@gmail.com>
> ---
>  drivers/net/ethernet/stmicro/stmmac/Kconfig   |  12 +
>  drivers/net/ethernet/stmicro/stmmac/Makefile  |   1 +
>  drivers/net/ethernet/stmicro/stmmac/common.h  |   3 +
>  .../net/ethernet/stmicro/stmmac/dwmac-s32.c   | 313 ++++++++++++++++++
>  .../net/ethernet/stmicro/stmmac/dwmac4_dma.c  |   9 +
>  .../net/ethernet/stmicro/stmmac/dwmac4_dma.h  |   3 +
>  drivers/net/ethernet/stmicro/stmmac/hwif.h    |   5 +
>  .../net/ethernet/stmicro/stmmac/stmmac_main.c |   7 +
>  include/linux/stmmac.h                        |   9 +
>  9 files changed, 362 insertions(+)
>  create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwmac-s32.c
>
> diff --git a/drivers/net/ethernet/stmicro/stmmac/Kconfig
> b/drivers/net/ethernet/stmicro/stmmac/Kconfig
> index 85dcda51df05..1cdf2da0251c 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/Kconfig
> +++ b/drivers/net/ethernet/stmicro/stmmac/Kconfig
> @@ -142,6 +142,18 @@ config DWMAC_ROCKCHIP
>           This selects the Rockchip RK3288 SoC glue layer support for
>           the stmmac device driver.
>
> +config DWMAC_S32
> +       tristate "NXP S32 series GMAC support"
> +       default ARCH_S32
> +       depends on OF && (ARCH_S32 || COMPILE_TEST)
> +       select PHYLINK
> +       help
> +         Support for ethernet controller on NXP S32 series SOCs.
> +
> +         This selects NXP SoC glue layer support for the stmmac
> +         device driver. This driver is used for the S32 series
> +         SOCs GMAC ethernet controller.
> +
>  config DWMAC_SOCFPGA
>         tristate "SOCFPGA dwmac support"
>         default ARCH_INTEL_SOCFPGA
> diff --git a/drivers/net/ethernet/stmicro/stmmac/Makefile
> b/drivers/net/ethernet/stmicro/stmmac/Makefile
> index 26cad4344701..c48ff95ed972 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/Makefile
> +++ b/drivers/net/ethernet/stmicro/stmmac/Makefile
> @@ -34,6 +34,7 @@ obj-$(CONFIG_DWMAC_GENERIC)   +=3D dwmac-generic.o
>  obj-$(CONFIG_DWMAC_IMX8)       +=3D dwmac-imx.o
>  obj-$(CONFIG_DWMAC_TEGRA)      +=3D dwmac-tegra.o
>  obj-$(CONFIG_DWMAC_VISCONTI)   +=3D dwmac-visconti.o
> +obj-$(CONFIG_DWMAC_S32)        +=3D dwmac-s32.o
>  stmmac-platform-objs:=3D stmmac_platform.o
>  dwmac-altr-socfpga-objs :=3D dwmac-socfpga.o
>
> diff --git a/drivers/net/ethernet/stmicro/stmmac/common.h
> b/drivers/net/ethernet/stmicro/stmmac/common.h
> index 5ba606a596e7..e5e23e8c07e1 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/common.h
> +++ b/drivers/net/ethernet/stmicro/stmmac/common.h
> @@ -254,6 +254,9 @@ struct stmmac_safety_stats {
>  #define CSR_F_150M     150000000
>  #define CSR_F_250M     250000000
>  #define CSR_F_300M     300000000
> +#define CSR_F_500M     500000000
> +#define CSR_F_800M     800000000
> +
>
>  #define        MAC_CSR_H_FRQ_MASK      0x20
>
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-s32.c
> b/drivers/net/ethernet/stmicro/stmmac/dwmac-s32.c
> new file mode 100644
> index 000000000000..1920eeed2269
> --- /dev/null
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-s32.c
> @@ -0,0 +1,313 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * DWMAC Specific Glue layer for NXP S32 SoCs
> + *
> + * Copyright (C) 2019-2022 NXP
> + * Copyright (C) 2022 SUSE LLC
> + *
> + */
> +
> +#include <linux/device.h>
> +#include <linux/ethtool.h>
> +#include <linux/module.h>
> +#include <linux/io.h>
> +#include <linux/clk.h>
> +#include <linux/phy.h>
> +#include <linux/platform_device.h>
> +#include <linux/of.h>
> +#include <linux/of_net.h>
> +#include <linux/of_address.h>
> +#include <linux/stmmac.h>
> +#include "stmmac_platform.h"
> +
> +#define GMAC_TX_RATE_125M 125000000 /* 125MHz */
> +#define GMAC_TX_RATE_25M 25000000 /* 25MHz */
> +#define GMAC_TX_RATE_2M5 2500000 /* 2.5MHz */
> +
> +/* S32 SRC register for phyif selection */
> +#define PHY_INTF_SEL_MII 0x00
> +#define PHY_INTF_SEL_SGMII 0x01
> +#define PHY_INTF_SEL_RGMII 0x02
> +#define PHY_INTF_SEL_RMII 0x08
> +
> +/* AXI4 ACE control settings */
> +#define ACE_DOMAIN_SIGNAL 0x2
> +#define ACE_CACHE_SIGNAL 0xf
> +#define ACE_CONTROL_SIGNALS ((ACE_DOMAIN_SIGNAL << 4) |
> ACE_CACHE_SIGNAL)
> +#define ACE_PROTECTION 0x2
> +
> +struct s32_priv_data {
> +       void __iomem *ctrl_sts;
> +       struct device *dev;
> +       phy_interface_t intf_mode;
> +       struct clk *tx_clk;
> +       struct clk *rx_clk;
> +};
> +
> +static int s32_gmac_init(struct platform_device *pdev, void *priv)
> +{
> +       struct s32_priv_data *gmac =3D priv;
> +       u32 intf_sel;
> +       int ret;
> +
> +       if (gmac->tx_clk) {
> +               ret =3D clk_prepare_enable(gmac->tx_clk);
> +               if (ret) {
> +                       dev_err(&pdev->dev, "Can't set tx clock\n");
> +                       return ret;
> +               }
> +       }
> +
> +       if (gmac->rx_clk) {
> +               ret =3D clk_prepare_enable(gmac->rx_clk);
> +               if (ret) {
> +                       dev_err(&pdev->dev, "Can't set rx clock\n");
> +                       return ret;
> +               }
> +       }
> +
> +       /* set interface mode */
> +       if (gmac->ctrl_sts) {
> +               switch (gmac->intf_mode) {
> +               default:
> +                       dev_info(
> +                               &pdev->dev,
> +                               "unsupported mode %u, set the default phy=
 mode.\n",
> +                               gmac->intf_mode);
> +                       fallthrough;
> +               case PHY_INTERFACE_MODE_SGMII:
> +                       dev_info(&pdev->dev, "phy mode set to SGMII\n");
> +                       intf_sel =3D PHY_INTF_SEL_SGMII;
> +                       break;
> +               case PHY_INTERFACE_MODE_RGMII:
> +               case PHY_INTERFACE_MODE_RGMII_ID:
> +               case PHY_INTERFACE_MODE_RGMII_TXID:
> +               case PHY_INTERFACE_MODE_RGMII_RXID:
> +                       dev_info(&pdev->dev, "phy mode set to RGMII\n");
> +                       intf_sel =3D PHY_INTF_SEL_RGMII;
> +                       break;
> +               case PHY_INTERFACE_MODE_RMII:
> +                       dev_info(&pdev->dev, "phy mode set to RMII\n");
> +                       intf_sel =3D PHY_INTF_SEL_RMII;
> +                       break;
> +               case PHY_INTERFACE_MODE_MII:
> +                       dev_info(&pdev->dev, "phy mode set to MII\n");
> +                       intf_sel =3D PHY_INTF_SEL_MII;
> +                       break;
> +               }
> +
> +               writel(intf_sel, gmac->ctrl_sts);
> +       }
> +
> +       return 0;
> +}
> +
> +static void s32_gmac_exit(struct platform_device *pdev, void *priv)
> +{
> +       struct s32_priv_data *gmac =3D priv;
> +
> +       if (gmac->tx_clk)
> +               clk_disable_unprepare(gmac->tx_clk);
> +
> +       if (gmac->rx_clk)
> +               clk_disable_unprepare(gmac->rx_clk);
> +}
> +
> +static void s32_fix_speed(void *priv, unsigned int speed, unsigned int m=
ode)
> +{
> +       struct s32_priv_data *gmac =3D priv;
> +
> +       if (!gmac->tx_clk || !gmac->rx_clk)
> +               return;
> +
> +       /* SGMII mode doesn't support the clock reconfiguration */
> +       if (gmac->intf_mode =3D=3D PHY_INTERFACE_MODE_SGMII)
> +               return;
> +
> +       switch (speed) {
> +       case SPEED_1000:
> +               dev_info(gmac->dev, "Set TX clock to 125M\n");
> +               clk_set_rate(gmac->tx_clk, GMAC_TX_RATE_125M);
> +               break;
> +       case SPEED_100:
> +               dev_info(gmac->dev, "Set TX clock to 25M\n");
> +               clk_set_rate(gmac->tx_clk, GMAC_TX_RATE_25M);
> +               break;
> +       case SPEED_10:
> +               dev_info(gmac->dev, "Set TX clock to 2.5M\n");
> +               clk_set_rate(gmac->tx_clk, GMAC_TX_RATE_2M5);
> +               break;
> +       default:
> +               dev_err(gmac->dev, "Unsupported/Invalid speed: %d\n", spe=
ed);
> +               return;
> +       }
> +}
> +
> +static int s32_config_cache_coherency(struct platform_device *pdev,
> +                                     struct plat_stmmacenet_data *plat_d=
at)
> +{
> +       plat_dat->axi4_ace_ctrl =3D devm_kzalloc(
> +               &pdev->dev, sizeof(struct stmmac_axi4_ace_ctrl), GFP_KERN=
EL);
> +
> +       if (!plat_dat->axi4_ace_ctrl)
> +               return -ENOMEM;
> +
> +       plat_dat->axi4_ace_ctrl->tx_ar_reg =3D (ACE_CONTROL_SIGNALS << 16=
) |
> +                                            (ACE_CONTROL_SIGNALS << 8) |
> +                                            ACE_CONTROL_SIGNALS;
> +
> +       plat_dat->axi4_ace_ctrl->rx_aw_reg =3D
> +               (ACE_CONTROL_SIGNALS << 24) | (ACE_CONTROL_SIGNALS << 16)=
 |
> +               (ACE_CONTROL_SIGNALS << 8) | ACE_CONTROL_SIGNALS;
> +
> +       plat_dat->axi4_ace_ctrl->txrx_awar_reg =3D
> +               (ACE_PROTECTION << 20) | (ACE_PROTECTION << 16) |
> +               (ACE_CONTROL_SIGNALS << 8) | ACE_CONTROL_SIGNALS;
> +
> +       return 0;
> +}
> +
> +static int s32_dwmac_probe(struct platform_device *pdev)
> +{
> +       struct plat_stmmacenet_data *plat_dat;
> +       struct stmmac_resources stmmac_res;
> +       struct s32_priv_data *gmac;
> +       struct resource *res;
> +       const char *tx_clk, *rx_clk;
> +       int ret;
> +
> +       ret =3D stmmac_get_platform_resources(pdev, &stmmac_res);
> +       if (ret)
> +               return ret;
> +
> +       gmac =3D devm_kzalloc(&pdev->dev, sizeof(*gmac), GFP_KERNEL);
> +       if (!gmac)
> +               return PTR_ERR(gmac);
> +
> +       gmac->dev =3D &pdev->dev;
> +
> +       /* S32G control reg */
> +       res =3D platform_get_resource(pdev, IORESOURCE_MEM, 1);
> +       gmac->ctrl_sts =3D devm_ioremap_resource(&pdev->dev, res);
> +       if (IS_ERR_OR_NULL(gmac->ctrl_sts)) {
> +               dev_err(&pdev->dev, "S32G config region is missing\n");
> +               return PTR_ERR(gmac->ctrl_sts);
> +       }
> +
> +       plat_dat =3D devm_stmmac_probe_config_dt(pdev, stmmac_res.mac);
> +       if (IS_ERR(plat_dat))
> +               return PTR_ERR(plat_dat);
> +
> +       plat_dat->bsp_priv =3D gmac;
> +
> +       switch (plat_dat->phy_interface) {
> +       case PHY_INTERFACE_MODE_SGMII:
> +               tx_clk =3D "tx_sgmii";
> +               rx_clk =3D "rx_sgmii";
> +               break;
> +       case PHY_INTERFACE_MODE_RGMII:
> +       case PHY_INTERFACE_MODE_RGMII_ID:
> +       case PHY_INTERFACE_MODE_RGMII_TXID:
> +       case PHY_INTERFACE_MODE_RGMII_RXID:
> +               tx_clk =3D "tx_rgmii";
> +               rx_clk =3D "rx_rgmii";
> +               break;
> +       case PHY_INTERFACE_MODE_RMII:
> +               tx_clk =3D "tx_rmii";
> +               rx_clk =3D "rx_rmii";
> +               break;
> +       case PHY_INTERFACE_MODE_MII:
> +               tx_clk =3D "tx_mii";
> +               rx_clk =3D "rx_mii";
> +               break;
> +       default:
> +               dev_err(&pdev->dev, "Not supported phy interface mode: [%=
s]\n",
> +                       phy_modes(plat_dat->phy_interface));
> +               return -EINVAL;
> +       };
> +
> +       gmac->intf_mode =3D plat_dat->phy_interface;
> +
> +       /* DMA cache coherency settings */
> +       if (of_dma_is_coherent(pdev->dev.of_node)) {
> +               ret =3D s32_config_cache_coherency(pdev, plat_dat);
> +               if (ret)
> +                       return ret;
> +       }
> +
> +       /* tx clock */
> +       gmac->tx_clk =3D devm_clk_get(&pdev->dev, tx_clk);
> +       if (IS_ERR(gmac->tx_clk)) {
> +               dev_info(&pdev->dev, "tx clock not found\n");
> +               gmac->tx_clk =3D NULL;
> +       }
> +
> +       /* rx clock */
> +       gmac->rx_clk =3D devm_clk_get(&pdev->dev, rx_clk);
> +       if (IS_ERR(gmac->rx_clk)) {
> +               dev_info(&pdev->dev, "rx clock not found\n");
> +               gmac->rx_clk =3D NULL;
> +       }
> +
> +       ret =3D s32_gmac_init(pdev, gmac);
> +       if (ret)
> +               return ret;
> +
> +       /* core feature set */
> +       plat_dat->has_gmac4 =3D true;
> +       plat_dat->pmt =3D 1;
> +
> +       plat_dat->init =3D s32_gmac_init;
> +       plat_dat->exit =3D s32_gmac_exit;
> +       plat_dat->fix_mac_speed =3D s32_fix_speed;
> +
> +       /* safety feature config */
> +       plat_dat->safety_feat_cfg =3D devm_kzalloc(
> +               &pdev->dev, sizeof(*plat_dat->safety_feat_cfg), GFP_KERNE=
L);
> +
> +       if (!plat_dat->safety_feat_cfg) {
> +               dev_err(&pdev->dev, "allocate safety_feat_cfg failed\n");
> +               goto err_gmac_exit;
> +       }
> +
> +       plat_dat->safety_feat_cfg->tsoee =3D 1;
> +       plat_dat->safety_feat_cfg->mrxpee =3D 1;
> +       plat_dat->safety_feat_cfg->mestee =3D 1;
> +       plat_dat->safety_feat_cfg->mrxee =3D 1;
> +       plat_dat->safety_feat_cfg->mtxee =3D 1;
> +       plat_dat->safety_feat_cfg->epsi =3D 1;
> +       plat_dat->safety_feat_cfg->edpp =3D 1;
> +       plat_dat->safety_feat_cfg->prtyen =3D 1;
> +       plat_dat->safety_feat_cfg->tmouten =3D 1;
> +
> +       ret =3D stmmac_dvr_probe(&pdev->dev, plat_dat, &stmmac_res);
> +       if (ret)
> +               goto err_gmac_exit;
> +
> +       return 0;
> +
> +err_gmac_exit:
> +       s32_gmac_exit(pdev, plat_dat->bsp_priv);
> +       return ret;
> +}
> +
> +static const struct of_device_id s32_dwmac_match[] =3D {
> +       { .compatible =3D "nxp,s32-dwmac" },
> +       {}
> +};
> +MODULE_DEVICE_TABLE(of, s32_dwmac_match);
> +
> +static struct platform_driver s32_dwmac_driver =3D {
> +       .probe  =3D s32_dwmac_probe,
> +       .remove_new =3D stmmac_pltfr_remove,
> +       .driver =3D {
> +               .name           =3D "s32-dwmac",
> +               .pm             =3D &stmmac_pltfr_pm_ops,
> +               .of_match_table =3D s32_dwmac_match,
> +       },
> +};
> +module_platform_driver(s32_dwmac_driver);
> +
> +MODULE_AUTHOR("Jan Petrous <jan.petrous@nxp.com>");
> +MODULE_DESCRIPTION("NXP S32 GMAC driver");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c
> b/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c
> index 84d3a8551b03..edb559c36509 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c
> @@ -556,6 +556,14 @@ static int dwmac4_enable_tbs(struct stmmac_priv
> *priv, void __iomem *ioaddr,
>         return 0;
>  }
>
> +static void dwmac4_set_axi4_cc(struct stmmac_priv *priv, void __iomem
> *ioaddr,
> +                          struct stmmac_axi4_ace_ctrl *acecfg)
> +{
> +       writel(acecfg->tx_ar_reg, ioaddr + DMA_AXI4_TX_AR_ACE_CONTROL);
> +       writel(acecfg->rx_aw_reg, ioaddr + DMA_AXI4_RX_AW_ACE_CONTROL);
> +       writel(acecfg->txrx_awar_reg, ioaddr +
> DMA_AXI4_TXRX_AWAR_ACE_CONTROL);
> +}
> +
>  const struct stmmac_dma_ops dwmac4_dma_ops =3D {
>         .reset =3D dwmac4_dma_reset,
>         .init =3D dwmac4_dma_init,
> @@ -608,6 +616,7 @@ const struct stmmac_dma_ops dwmac410_dma_ops
> =3D {
>         .set_tx_ring_len =3D dwmac4_set_tx_ring_len,
>         .set_rx_tail_ptr =3D dwmac4_set_rx_tail_ptr,
>         .set_tx_tail_ptr =3D dwmac4_set_tx_tail_ptr,
> +       .set_axi4_cc =3D dwmac4_set_axi4_cc,
>         .enable_tso =3D dwmac4_enable_tso,
>         .qmode =3D dwmac4_qmode,
>         .set_bfsize =3D dwmac4_set_bfsize,
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.h
> b/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.h
> index 358e7dcb6a9a..7195c643774f 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.h
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.h
> @@ -22,6 +22,9 @@
>  #define DMA_DEBUG_STATUS_1             0x00001010
>  #define DMA_DEBUG_STATUS_2             0x00001014
>  #define DMA_AXI_BUS_MODE               0x00001028
> +#define DMA_AXI4_TX_AR_ACE_CONTROL     0x00001020
> +#define DMA_AXI4_RX_AW_ACE_CONTROL     0x00001024
> +#define DMA_AXI4_TXRX_AWAR_ACE_CONTROL 0x00001028
>  #define DMA_TBS_CTRL                   0x00001050
>
>  /* DMA Bus Mode bitmap */
> diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.h
> b/drivers/net/ethernet/stmicro/stmmac/hwif.h
> index 7be04b54738b..6ea2d8f562d0 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/hwif.h
> +++ b/drivers/net/ethernet/stmicro/stmmac/hwif.h
> @@ -227,6 +227,9 @@ struct stmmac_dma_ops {
>                                 u32 tail_ptr, u32 chan);
>         void (*set_tx_tail_ptr)(struct stmmac_priv *priv, void __iomem *i=
oaddr,
>                                 u32 tail_ptr, u32 chan);
> +       /* Configure AXI4 cache coherency for Tx and Rx DMA channels */
> +        void (*set_axi4_cc)(struct stmmac_priv *priv, void __iomem *ioad=
dr,
> +                          struct stmmac_axi4_ace_ctrl *acecfg);
>         void (*enable_tso)(struct stmmac_priv *priv, void __iomem *ioaddr=
,
>                            bool en, u32 chan);
>         void (*qmode)(struct stmmac_priv *priv, void __iomem *ioaddr,
> @@ -285,6 +288,8 @@ struct stmmac_dma_ops {
>         stmmac_do_void_callback(__priv, dma, set_rx_tail_ptr, __priv, __a=
rgs)
>  #define stmmac_set_tx_tail_ptr(__priv, __args...) \
>         stmmac_do_void_callback(__priv, dma, set_tx_tail_ptr, __priv, __a=
rgs)
> +#define stmmac_set_axi4_cc(__priv, __args...) \
> +        stmmac_do_void_callback(__priv, dma, set_axi4_cc, __priv, __args=
)
>  #define stmmac_enable_tso(__priv, __args...) \
>         stmmac_do_void_callback(__priv, dma, enable_tso, __priv, __args)
>  #define stmmac_dma_qmode(__priv, __args...) \
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 7c6aef033a45..b7b4d7dd1149 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -324,6 +324,10 @@ static void stmmac_clk_csr_set(struct stmmac_priv
> *priv)
>                         priv->clk_csr =3D STMMAC_CSR_150_250M;
>                 else if ((clk_rate >=3D CSR_F_250M) && (clk_rate <=3D CSR=
_F_300M))
>                         priv->clk_csr =3D STMMAC_CSR_250_300M;
> +               else if ((clk_rate >=3D CSR_F_300M) && (clk_rate < CSR_F_=
500M))
> +                       priv->clk_csr =3D STMMAC_CSR_300_500M;
> +               else if ((clk_rate >=3D CSR_F_500M) && (clk_rate < CSR_F_=
800M))
> +                       priv->clk_csr =3D STMMAC_CSR_500_800M;
>         }
>
>         if (priv->plat->flags & STMMAC_FLAG_HAS_SUN8I) {
> @@ -3030,6 +3034,9 @@ static int stmmac_init_dma_engine(struct
> stmmac_priv *priv)
>         if (priv->plat->axi)
>                 stmmac_axi(priv, priv->ioaddr, priv->plat->axi);
>
> +       if (priv->plat->axi4_ace_ctrl)
> +               stmmac_set_axi4_cc(priv, priv->ioaddr, priv->plat->axi4_a=
ce_ctrl);
> +
>         /* DMA CSR Channel configuration */
>         for (chan =3D 0; chan < dma_csr_ch; chan++) {
>                 stmmac_init_chan(priv, priv->ioaddr, priv->plat->dma_cfg,=
 chan);
> diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
> index dee5ad6e48c5..a69ac8b9274e 100644
> --- a/include/linux/stmmac.h
> +++ b/include/linux/stmmac.h
> @@ -34,6 +34,8 @@
>  #define        STMMAC_CSR_35_60M       0x3     /* MDC =3D clk_scr_i/26 *=
/
>  #define        STMMAC_CSR_150_250M     0x4     /* MDC =3D clk_scr_i/102 =
*/
>  #define        STMMAC_CSR_250_300M     0x5     /* MDC =3D clk_scr_i/122 =
*/
> +#define        STMMAC_CSR_300_500M     0x6     /* MDC =3D clk_scr_i/204 =
*/
> +#define        STMMAC_CSR_500_800M     0x7     /* MDC =3D clk_scr_i/324 =
*/
>
>  /* MTL algorithms identifiers */
>  #define MTL_TX_ALGORITHM_WRR   0x0
> @@ -115,6 +117,12 @@ struct stmmac_axi {
>         bool axi_rb;
>  };
>
> +struct stmmac_axi4_ace_ctrl {
> +       u32 tx_ar_reg;
> +       u32 rx_aw_reg;
> +       u32 txrx_awar_reg;
> +};
> +
>  #define EST_GCL                1024
>  struct stmmac_est {
>         struct mutex lock;
> @@ -296,6 +304,7 @@ struct plat_stmmacenet_data {
>         struct reset_control *stmmac_rst;
>         struct reset_control *stmmac_ahb_rst;
>         struct stmmac_axi *axi;
> +       struct stmmac_axi4_ace_ctrl *axi4_ace_ctrl;
>         int has_gmac4;
>         int rss_en;
>         int mac_port_sel_speed;
> --
> 2.25.1


