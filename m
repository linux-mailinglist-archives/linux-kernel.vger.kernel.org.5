Return-Path: <linux-kernel+bounces-42068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40DAD83FBE4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 02:39:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65F5B1C2183D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 01:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4487ADF6B;
	Mon, 29 Jan 2024 01:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="bASOoYEq"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2073.outbound.protection.outlook.com [40.107.8.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D924D516;
	Mon, 29 Jan 2024 01:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706492347; cv=fail; b=LII5BELFW5XYnFYlCjOlyJYYIwDFcG5F6+jEkL9Dcxh7f3NGTHqkzKceRtRG4KfYiBwpiGkM+1HGZeDHIVLKk3Y1tm0dFOZHW5Uu9agR9gozP3fVV+hRQysVXGp18QkpjAjFRLzMFZrSofRXMQX4g10bD1aMAbN8ytYOqvMP6M4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706492347; c=relaxed/simple;
	bh=gyr8T7lX1uVM13tKFHFjTveo7BjsToriFd1jMpOo9FU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Tudm3gMo/07EUCkpevoOO6WYAHj0NqYwaU/5t4BTR6BkdxARFLf7uyL1RFojsUnMOOYwHgKuntIhiHJjVBf4j23jQzD109i7aKnv2ATJcRaJa0YVnaDUivnex3AMoU+eGew+G444fWUi0zTXwW/u0uD4xBQcRoMzXRMbu+BtddM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=bASOoYEq; arc=fail smtp.client-ip=40.107.8.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KvHPfCwTNZgqOHcYzr16uC+nUK43WVau2Ox/4/YYMT1ZrtruDDzeLNnZ0wKHo3Ve4ldRZd0P5z0d5sPkwPCSgBmB2f+hYR/WcOVr6WP8apme2C5SYGEnI4kQ96uR4f8mfxp5MTRzan6rpofgWR3KGJboeJE9ni7SjCA4O+KZQlhKSl7xzfSk7zxj0iC+Xn6ksfQmOy+pvbmhj5Ly8K6p6p8GC2Vv9heprAXYe5pwXZLivdCDwtyav1/BvVqXKckj5J8olVHUn5Kdt/FIf5YbICMEX+Qzb1XKNmGNN9fg8sfQ+7vNEXcWlQCx01yDBpBZJHCYQR5vZxk2qQfkZTfXPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gyr8T7lX1uVM13tKFHFjTveo7BjsToriFd1jMpOo9FU=;
 b=KDsEr0IzjBC/F6c2CRE/9mYSMSYUuQpDROFu4ccS0FrPVFgwhxjCD5eCDupdnAeToTskWgVUwTbGEonT2gxToC4tVl9rE5VhtLWDrfkeA5CQjHbqnW6M3s/CyTfJAQQ1jS7NtUK42uNVuI7RauvddTeGAHKlrW5vQgbk/EawULgHoc+7cyZXi4u19osHJL7D7+XqqECuAYn7svnxp1q9aDL07uykG/nappckJH8sJXrEXwsrXUQHyePFQ/Z0D22BG3P2Vou9kxJTxiu/zj1Gka5QvCSKHAHqAzPr7hraeBSGA36Z6bHYElRM1SQdsje47jKkF2YpQC0VVxAqdPUOig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gyr8T7lX1uVM13tKFHFjTveo7BjsToriFd1jMpOo9FU=;
 b=bASOoYEq9JaJrIJUIHebANK4XKzjGLLPLrDYUqnc11m4Q9nze8tSwRpYc2wpbmNa7k/xFiMmV2NvAe1nM3I1s4TIv76ftbVrDoF/1FpHOGsNIf+SpqBoX6p5NJ1oUvJb+6gEQS3/XmLtofjgfa9BTNZeyTO4p3B8IBBoUxtXTNM=
Received: from DB9PR04MB9452.eurprd04.prod.outlook.com (2603:10a6:10:367::13)
 by AM9PR04MB7667.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.28; Mon, 29 Jan
 2024 01:39:01 +0000
Received: from DB9PR04MB9452.eurprd04.prod.outlook.com
 ([fe80::4272:e277:dda3:2446]) by DB9PR04MB9452.eurprd04.prod.outlook.com
 ([fe80::4272:e277:dda3:2446%2]) with mapi id 15.20.7228.029; Mon, 29 Jan 2024
 01:38:59 +0000
From: Sandor Yu <sandor.yu@nxp.com>
To: Adam Ford <aford173@gmail.com>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>
CC: Jacky Bai <ping.bai@nxp.com>, Rob Herring <robh+dt@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
	<conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
	<s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, dl-linux-imx <linux-imx@nxp.com>, Ulf
 Hansson <ulf.hansson@linaro.org>, Lucas Stach <l.stach@pengutronix.de>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Marek Vasut <marex@denx.de>, "Peng Fan (OSS)"
	<peng.fan@oss.nxp.com>
Subject: RE: [EXT] Re: [PATCH 2/3] pmdomain: imx8mp-blk-ctrl: imx8mp_blk: Add
 fdcc clock to hdmimix domain
Thread-Topic: [EXT] Re: [PATCH 2/3] pmdomain: imx8mp-blk-ctrl: imx8mp_blk: Add
 fdcc clock to hdmimix domain
Thread-Index: AQHaUU1zpB2x2NMooUO62wmFXPCChLDv9e3A
Date: Mon, 29 Jan 2024 01:38:59 +0000
Message-ID:
 <DB9PR04MB9452DB580ACF844505F7AA2CF47E2@DB9PR04MB9452.eurprd04.prod.outlook.com>
References: <20240106223951.387067-1-aford173@gmail.com>
 <20240106223951.387067-2-aford173@gmail.com>
 <CAHCN7x+=etco+xEELdf5AyR07sR6c9tTFtsA3K5Dy99qhAZQMg@mail.gmail.com>
In-Reply-To:
 <CAHCN7x+=etco+xEELdf5AyR07sR6c9tTFtsA3K5Dy99qhAZQMg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR04MB9452:EE_|AM9PR04MB7667:EE_
x-ms-office365-filtering-correlation-id: 16a3f665-1bed-450a-4202-08dc206b1106
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 koOe8RKwH7fR6DwsKcvWjKTIP4YUzqANTTvzMZ2CdIQ+vz49RfVDT9axsBoH5Tm8eQOkncMWoUKbwVRh4DKOutEwQH4Hxr45tfNE8tQlVO0LHJu6O2x8mv6rSJyy8QtvZLULVsQ8/BApSCwFS6/bQLEZ1Ku69gSNBC+xvUVlxmhadH51IazLBMU1dP0jD+gnrfH08sie+d9E/bDXI873o3yFrVZwR0tBbu+s7Ijj0n/nJ4Zv17my04OpEEGDa87y/25Seq4ejfiJ/Vp0sD4/RtQwCoVoYzdyHgqe3yyVU/y9RepBcTCKijMrKm/F5sFhicS2tw2xz3HsSoOHrsBOVuEQ545/CtpP9tNJD2WwHSKfRgFk4qUOrVYrCgbuAYN2B7uDKB613hbstBlaTclLvpEXOiyxSUZtf88WoY8V+/61lUiLh0EfzR7G03hZqlc7Ro9Cj6I62jeD20XMoc51Qj0sabM+3r6QlnIf41Z52/RkCEVCw0mO4FackKnk7ywP1t7KxCw+uu+aoVCvVrTbE/MbK9NiYqWH28ecFlXZlhIImzkZT1m2Eprma54rLMOSIqZS8fNKIto4qBj1QaKz0UdwZ/98quA2dsYwge9Sui6fYqTHYZE8L2Yr7z329xUTbiAGSCDEjmiIPB+q8E/Yf/YUheQkmtAIz1i93X2WgAx6R3usaxQ0OCIUWM1BfHfj
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(136003)(346002)(376002)(230922051799003)(230273577357003)(230173577357003)(64100799003)(1800799012)(186009)(451199024)(26005)(8676002)(122000001)(38100700002)(86362001)(41300700001)(33656002)(8936002)(478600001)(83380400001)(4326008)(44832011)(52536014)(66556008)(66946007)(76116006)(316002)(64756008)(54906003)(66476007)(110136005)(2906002)(7416002)(66446008)(71200400001)(9686003)(53546011)(7696005)(5660300002)(6506007)(38070700009)(55016003)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WEo5bkJQd052amlxakxjYmQreUxuYVZPbTBPU0ZnMU9zdEYwL2VqWWU5emI4?=
 =?utf-8?B?UnlIdWNUV1RhS1hCZ3V2TGFSR0p0eHJuLzhWbCtmM2laM0pQMUtpWEQwZEZt?=
 =?utf-8?B?aDVEcjVwR1pUbWVLekpOY0tFVDZtWGppb0xCaEl1a2JaZlZuYjhWanZ0aGwx?=
 =?utf-8?B?eXlsckRud2pjTnA0d3ZxLy9Db1o1dWFjbnZsV0RsaGdRSGd2cG1WYmRyQy96?=
 =?utf-8?B?RXl4V093TWRmY0pSN2llRzh0SjFsMTN1SHFsSmhHK1BiY0tPYXFvNi8vTkNY?=
 =?utf-8?B?Mzc0MHVnY2I4UndTckprL0lQZDA5MmEzcUl4bzF5UzVsK0NoV3ByWEdjeWJW?=
 =?utf-8?B?eVR0TW1sSnN3UnVMTm11c2pjWmk3VTJpVFRvb1VYT0JMVmZTTmQ0TVpaSUJ1?=
 =?utf-8?B?Q0RQR1NyRzNya2lvdmpkM1FtWUk4SVZocEFhbTVIclFzd3ZzR0t3Z0Q0dDJU?=
 =?utf-8?B?UlY5T2RJbUhEL04vQjk0Q2pLZS9ialdhRHhFNk1HOTZsL1FkbnFzdmdDVGJD?=
 =?utf-8?B?dEdlSVdOSlF1elZtVHRndWVJak43U0JiOUFselpwZnVkaUh1cmczUTJjSGF1?=
 =?utf-8?B?VEhFZVEvMU9hZXFaS29XWU00YzFINmtwQXlhc1NrMkJUVHp5UnJOTDMxNVA2?=
 =?utf-8?B?aHA0azhkMzFabWRqK0RHRjJ0R3hiZWszSG1OV1hTWDFrRm96MTIybG5BOEwx?=
 =?utf-8?B?bmtXaUs0dXgrYjE2TU43S3FvdEFkb3puOEd4ejlUakMrT04xZ2swakQ1Y3My?=
 =?utf-8?B?OVRHaUJXU0tlSVh6RXNsUXg2K3pxRS9oNGtDSlhxV2JzdmNuYUlyZzU2c3VR?=
 =?utf-8?B?R3I0b3ZNS2ppYXJ0eStFU0dBaXdONEhuN29UK0ROUDNnQzZyMzI2RjY3TmlI?=
 =?utf-8?B?MkQ1cEViSHNzbXFmTXR5Uk1zY0FoNXU3cUdvZVcweXU1K2NtRmJNRHBYcVRz?=
 =?utf-8?B?dHNmN2Jpek1ETDQzc3BXdktQM0pDdHl3UmwyTjRuci95Mk85ZW04anJKV2hQ?=
 =?utf-8?B?R3lkVDlpK09CWVJaZnRVWkhxcElKM0hDYzBkTWc5eWVVdmNzT2RmUThCRkFo?=
 =?utf-8?B?YUNEYW8xR0NWakJXbXVmSEJhbmJxK2pVUU5FdW15MlJVa1JiUzFMaXZ3R2Ry?=
 =?utf-8?B?aEh2eFpGcFpvb2JWTEQ0dFd0MHpwVHc1b3VRYnozVHVBeFhzRk1uT0J6UVho?=
 =?utf-8?B?OFBmdjdXQ2hJb3RhaUsrQUF5Ti9RbnRjV1J3T1NwU2R6U3NDWnk1cVUxM2U3?=
 =?utf-8?B?VEQxcU13aFhIQ1JVUGc4bFNiTGd2blV0UW1tczQ1dzdNOHE3eGdSNkdlU0Jw?=
 =?utf-8?B?citxalFQK3ZlcU1mV2NEbDI5aTAyL2RQYnl1ZVA2WHJuVS9yTDd3bkllYmJh?=
 =?utf-8?B?KzFvbWZTWEREUTErMDQxN21RN3ZrcklWbzFGQU93bURmdkNKS3Y3KzRLZkk4?=
 =?utf-8?B?ZjBjRlRmcGliU01SaUJLRVhUODhJZjMzVTJ2RVBXazhEZ2xPaGUyNVcxdW45?=
 =?utf-8?B?UHdKZVdIdGdGYklIYVdxcVZnUXltcklwdGh1K3RST1MzYTVtbDRZWXFabHV1?=
 =?utf-8?B?UnBhS2RHSXBsT2pVZVNQWGJYVmc3SVBHQlZENU5DQXpBMWtYVGJ2WVBKRkJO?=
 =?utf-8?B?eC9nUkc2UUh1RDlEODRmYTNQN3RXNlRsekpDTzdnNi9OeHBvdEhRRC8vTExu?=
 =?utf-8?B?QUdEWTZ5TndSbXhrbDRXSURtdndjR0V3SEpxSUEyY3VqMlZrUlRpenlOMnFn?=
 =?utf-8?B?RHJwRThaNW0xQVhpUHJRRitWenlmNkpkeWwvMFBESGxXS012TDVDc1dkSDBT?=
 =?utf-8?B?ZlJMN09INlNSQTIvdjRVd2xuT2E1MDZwWGwwV1Z6eE9VcUVhaDJYWmNoeE5X?=
 =?utf-8?B?UUhpeERocVU0ZzZ5T3lEaXRYRXRHL1I5RnUwb0RTa1NlY0NjcmVYRlZFV3N3?=
 =?utf-8?B?TWJ5emZOZkpsa1R0Z0czSEJwTVpXRXZDc3VUZXZMbzFkTDBiblZRSEF1NGFm?=
 =?utf-8?B?blNucmxZbU85L1c1VXZ5Z0NSQVFUbkxmUEQ2QUhvekhJSDZUcjAyNktVSVhC?=
 =?utf-8?B?ckZPSlNMT1VPaEZYM3BKMXB6UklEOUtKZnZyMkNnWjM2SVFXWk5RYVI3eEJy?=
 =?utf-8?Q?p1Wc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16a3f665-1bed-450a-4202-08dc206b1106
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2024 01:38:59.8515
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s1EDZ8Jq5yt/T8qeSanNcD2zN20iMCvrPJ9sz9PJTT1/eJkcieUPsgm/lz6uDy8qGl7LFt+u9CEjVQaW2Q+vgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7667

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQWRhbSBGb3JkIDxhZm9y
ZDE3M0BnbWFpbC5jb20+DQo+IFNlbnQ6IDIwMjTlubQx5pyIMjjml6UgMjoyMA0KPiBUbzogbGlu
dXgtcG1Admdlci5rZXJuZWwub3JnDQo+IENjOiBTYW5kb3IgWXUgPHNhbmRvci55dUBueHAuY29t
PjsgSmFja3kgQmFpIDxwaW5nLmJhaUBueHAuY29tPjsgUm9iDQo+IEhlcnJpbmcgPHJvYmgrZHRA
a2VybmVsLm9yZz47IEtyenlzenRvZiBLb3psb3dza2kNCj4gPGtyenlzenRvZi5rb3psb3dza2kr
ZHRAbGluYXJvLm9yZz47IENvbm9yIERvb2xleSA8Y29ub3IrZHRAa2VybmVsLm9yZz47DQo+IFNo
YXduIEd1byA8c2hhd25ndW9Aa2VybmVsLm9yZz47IFNhc2NoYSBIYXVlcg0KPiA8cy5oYXVlckBw
ZW5ndXRyb25peC5kZT47IFBlbmd1dHJvbml4IEtlcm5lbCBUZWFtDQo+IDxrZXJuZWxAcGVuZ3V0
cm9uaXguZGU+OyBGYWJpbyBFc3RldmFtIDxmZXN0ZXZhbUBnbWFpbC5jb20+Ow0KPiBkbC1saW51
eC1pbXggPGxpbnV4LWlteEBueHAuY29tPjsgVWxmIEhhbnNzb24gPHVsZi5oYW5zc29uQGxpbmFy
by5vcmc+Ow0KPiBMdWNhcyBTdGFjaCA8bC5zdGFjaEBwZW5ndXRyb25peC5kZT47IGRldmljZXRy
ZWVAdmdlci5rZXJuZWwub3JnOw0KPiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5v
cmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IE1hcmVrDQo+IFZhc3V0IDxtYXJleEBk
ZW54LmRlPjsgUGVuZyBGYW4gKE9TUykgPHBlbmcuZmFuQG9zcy5ueHAuY29tPg0KPiBTdWJqZWN0
OiBbRVhUXSBSZTogW1BBVENIIDIvM10gcG1kb21haW46IGlteDhtcC1ibGstY3RybDogaW14OG1w
X2JsazogQWRkDQo+IGZkY2MgY2xvY2sgdG8gaGRtaW1peCBkb21haW4NCj4gDQo+IENhdXRpb246
IFRoaXMgaXMgYW4gZXh0ZXJuYWwgZW1haWwuIFBsZWFzZSB0YWtlIGNhcmUgd2hlbiBjbGlja2lu
ZyBsaW5rcyBvcg0KPiBvcGVuaW5nIGF0dGFjaG1lbnRzLiBXaGVuIGluIGRvdWJ0LCByZXBvcnQg
dGhlIG1lc3NhZ2UgdXNpbmcgdGhlICdSZXBvcnQNCj4gdGhpcyBlbWFpbCcgYnV0dG9uDQo+IA0K
PiANCj4gT24gU2F0LCBKYW4gNiwgMjAyNCBhdCA0OjQw4oCvUE0gQWRhbSBGb3JkIDxhZm9yZDE3
M0BnbWFpbC5jb20+IHdyb3RlOg0KPiA+DQo+ID4gQWNjb3JkaW5nIHRvIGkuTVg4TVAgUk0gYW5k
IEhETUkgQURELCB0aGUgZmRjYyBjbG9jayBpcyBwYXJ0IG9mIGhkbWkNCj4gPiByeCB2ZXJpZmlj
YXRpb24gSVAgdGhhdCBzaG91bGQgbm90IGVuYWJsZSBmb3IgSERNSSBUWC4NCj4gPiBCdXQgYWN0
dWFsbHkgaWYgdGhlIGNsb2NrIGlzIGRpc2FibGVkIGJlZm9yZSBIRE1JL0xDRElGIHByb2JlLCBM
Q0RJRg0KPiA+IHdpbGwgbm90IGdldCBwaXhlbCBjbG9jayBmcm9tIEhETUkgUEhZIGFuZCBwcmlu
dCB0aGUgZXJyb3INCj4gPiBsb2dzOg0KPiA+DQo+ID4gW0NSVEM6Mzk6Y3J0Yy0yXSB2Ymxhbmsg
d2FpdCB0aW1lZCBvdXQNCj4gPiBXQVJOSU5HOiBDUFU6IDIgUElEOiA5IGF0IGRyaXZlcnMvZ3B1
L2RybS9kcm1fYXRvbWljX2hlbHBlci5jOjE2MzQNCj4gPiBkcm1fYXRvbWljX2hlbHBlcl93YWl0
X2Zvcl92YmxhbmtzLnBhcnQuMCsweDIzYy8weDI2MA0KPiA+DQo+ID4gQWRkIGZkY2MgY2xvY2sg
dG8gTENESUYgYW5kIEhETUkgVFggcG93ZXIgZG9tYWlucyB0byBmaXggdGhlIGlzc3VlLg0KPiAN
Cj4gUGVuZyAob3IgYW55b25lIGZyb20gTlhQKSwNCj4gDQo+IEkgYm9ycm93ZWQgdGhpcyBwYXRj
aCBmcm9tIHRoZSBOWFAgZG93bi1zdHJlYW0ga2VybmVsIGZvciB0d28gcmVhc29uczoNCj4gIEl0
J3MgaW4gTlhQJ3MgYnJhbmNoIHRvIGFkZHJlc3MgYW4gZXJyb3IgJiBtb3ZlIHRoZSBmZGNjIGNs
b2NrIG91dCBvZiB0aGUNCj4gSERNSS10eCBkcml2ZXIgZHVlIHRvIHF1ZXN0aW9ucy9mZWVkYmFj
ayB0aGF0IEx1Y2FzIGdvdCBvbiB0aGF0IGRyaXZlci4NCj4gDQo+IFRoZSBGRENDIGNsb2NrIGlz
bid0IHdlbGwgZG9jdW1lbnRlZCwgYW5kIGl0IHNlZW1zIGxpa2UgaXQncyBuZWNlc3NhcnkgZm9y
IHRoZQ0KPiBIRE1JLVRYLCBidXQgSSdkIGxpa2UgdG8gbWFrZSBzdXJlIHRoaXMgaXMgdGhlIHBy
b3BlciBzb2x1dGlvbiwgYW5kIEkgaGF2ZW4ndA0KPiByZWNlaXZlZCBhbnkgYWRkaXRpb25hbCBm
ZWVkYmFjay4NCj4gQ2FuIHNvbWVvbmUgZnJvbSBOWFAgY29uZmlybSB0aGF0IHJlYWxseSBpcyB0
aGUgcHJvcGVyIHNvbHV0aW9uPw0KPiANCj4gdGhhbmsgeW91LA0KPiANCj4gYWRhbQ0KDQpIaSBB
ZGFtLA0KDQpJbiBOWFAgaW50ZXJuYWwgZG9jdW1lbnQsIHRoZSBjbG9jayBIRE1JX0ZEQ0NfVFNU
X0NMS19ST09UIHdhcyBmb3IgaW50ZXJuYWwgdXNlIG9ubHkgZm9yIGZ1dHVyZSBOWFAgZGV2ZWxv
cG1lbnQgSVAuDQpJdCBzaG91bGQgbm90IGJlIGV4cG9zZWQgdG8gY3VzdG9tZXIgaW4gZG9jdW1l
bnQgYnV0IHVuZm9ydHVuYXRlbHkgaXQgaGF2ZSB0byBiZSBlbmFibGVkIGZvciBIRE1JVFguDQoN
Ckkgc3VibWl0dGVkIGEgcmVxdWVzdCB0aWNrZXQgdG8gdGhlIGRlc2lnbiB0ZWFtIHNldmVyYWwg
bW9udGhzIGFnbywgDQpHZW5lcmFsbHksIHRpY2tldHMgb2YgdGhpcyBkaWRuJ3QgZ2V0IHRoZSBw
cmlvcml0eSBpbiBkZXNpZ24gdGVhbSBhbmQgSSBoYXZlbuKAmXQgcmVjZWl2ZWQgYW55IHZhbHVh
YmxlIGZlZWRiYWNrLg0KT25jZSBkZXNpZ24gdGVhbSBjb25maXJtZWQsIEkgdGhpbmsgdGhlIGRv
Y3VtZW50IHdpbGwgdXBkYXRlIHRvIGFkZCB0aGUgZmRjYyBjbG9jay4NCg0KQi5SDQpTYW5kb3IN
Cg0KPiANCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFNhbmRvciBZdSA8U2FuZG9yLnl1QG54cC5j
b20+DQo+ID4gUmV2aWV3ZWQtYnk6IEphY2t5IEJhaSA8cGluZy5iYWlAbnhwLmNvbT4NCj4gPiBT
aWduZWQtb2ZmLWJ5OiBBZGFtIEZvcmQgPGFmb3JkMTczQGdtYWlsLmNvbT4NCj4gPiAtLS0NCj4g
PiBUaGUgb3JpZ2luYWwgd29yayB3YXMgZnJvbSBTYW5kb3Igb24gdGhlIE5YUCBEb3duLXN0cmVh
bSBrZXJuZWwNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BtZG9tYWluL2lteC9pbXg4
bXAtYmxrLWN0cmwuYw0KPiA+IGIvZHJpdmVycy9wbWRvbWFpbi9pbXgvaW14OG1wLWJsay1jdHJs
LmMNCj4gPiBpbmRleCBlMzIwM2ViNmEwMjIuLmE1NmY3ZjkyZDA5MSAxMDA2NDQNCj4gPiAtLS0g
YS9kcml2ZXJzL3BtZG9tYWluL2lteC9pbXg4bXAtYmxrLWN0cmwuYw0KPiA+ICsrKyBiL2RyaXZl
cnMvcG1kb21haW4vaW14L2lteDhtcC1ibGstY3RybC5jDQo+ID4gQEAgLTU1LDcgKzU1LDcgQEAg
c3RydWN0IGlteDhtcF9ibGtfY3RybF9kb21haW5fZGF0YSB7DQo+ID4gICAgICAgICBjb25zdCBj
aGFyICpncGNfbmFtZTsNCj4gPiAgfTsNCj4gPg0KPiA+IC0jZGVmaW5lIERPTUFJTl9NQVhfQ0xL
UyAyDQo+ID4gKyNkZWZpbmUgRE9NQUlOX01BWF9DTEtTIDMNCj4gPiAgI2RlZmluZSBET01BSU5f
TUFYX1BBVEhTIDMNCj4gPg0KPiA+ICBzdHJ1Y3QgaW14OG1wX2Jsa19jdHJsX2RvbWFpbiB7DQo+
ID4gQEAgLTQ1Nyw4ICs0NTcsOCBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGlteDhtcF9ibGtfY3Ry
bF9kb21haW5fZGF0YQ0KPiBpbXg4bXBfaGRtaV9kb21haW5fZGF0YVtdID0gew0KPiA+ICAgICAg
ICAgfSwNCj4gPiAgICAgICAgIFtJTVg4TVBfSERNSUJMS19QRF9MQ0RJRl0gPSB7DQo+ID4gICAg
ICAgICAgICAgICAgIC5uYW1lID0gImhkbWlibGstbGNkaWYiLA0KPiA+IC0gICAgICAgICAgICAg
ICAuY2xrX25hbWVzID0gKGNvbnN0IGNoYXIgKltdKXsgImF4aSIsICJhcGIiIH0sDQo+ID4gLSAg
ICAgICAgICAgICAgIC5udW1fY2xrcyA9IDIsDQo+ID4gKyAgICAgICAgICAgICAgIC5jbGtfbmFt
ZXMgPSAoY29uc3QgY2hhciAqW10peyAiYXhpIiwgImFwYiIsICJmZGNjIiB9LA0KPiA+ICsgICAg
ICAgICAgICAgICAubnVtX2Nsa3MgPSAzLA0KPiA+ICAgICAgICAgICAgICAgICAuZ3BjX25hbWUg
PSAibGNkaWYiLA0KPiA+ICAgICAgICAgICAgICAgICAucGF0aF9uYW1lcyA9IChjb25zdCBjaGFy
ICpbXSl7ImxjZGlmLWhkbWkifSwNCj4gPiAgICAgICAgICAgICAgICAgLm51bV9wYXRocyA9IDEs
DQo+ID4gQEAgLTQ4Myw4ICs0ODMsOCBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGlteDhtcF9ibGtf
Y3RybF9kb21haW5fZGF0YQ0KPiBpbXg4bXBfaGRtaV9kb21haW5fZGF0YVtdID0gew0KPiA+ICAg
ICAgICAgfSwNCj4gPiAgICAgICAgIFtJTVg4TVBfSERNSUJMS19QRF9IRE1JX1RYXSA9IHsNCj4g
PiAgICAgICAgICAgICAgICAgLm5hbWUgPSAiaGRtaWJsay1oZG1pLXR4IiwNCj4gPiAtICAgICAg
ICAgICAgICAgLmNsa19uYW1lcyA9IChjb25zdCBjaGFyICpbXSl7ICJhcGIiLCAicmVmXzI2Nm0i
IH0sDQo+ID4gLSAgICAgICAgICAgICAgIC5udW1fY2xrcyA9IDIsDQo+ID4gKyAgICAgICAgICAg
ICAgIC5jbGtfbmFtZXMgPSAoY29uc3QgY2hhciAqW10peyAiYXBiIiwgInJlZl8yNjZtIiwNCj4g
ImZkY2MiIH0sDQo+ID4gKyAgICAgICAgICAgICAgIC5udW1fY2xrcyA9IDMsDQo+ID4gICAgICAg
ICAgICAgICAgIC5ncGNfbmFtZSA9ICJoZG1pLXR4IiwNCj4gPiAgICAgICAgIH0sDQo+ID4gICAg
ICAgICBbSU1YOE1QX0hETUlCTEtfUERfSERNSV9UWF9QSFldID0gew0KPiA+IC0tDQo+ID4gMi40
My4wDQo+ID4NCg==

