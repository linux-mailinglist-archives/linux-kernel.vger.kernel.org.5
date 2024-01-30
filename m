Return-Path: <linux-kernel+bounces-43831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85200841951
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 03:31:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 119681F29D30
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 02:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7778E3716D;
	Tue, 30 Jan 2024 02:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="mZVhOkF2"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2040.outbound.protection.outlook.com [40.107.20.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD051364CA;
	Tue, 30 Jan 2024 02:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706581704; cv=fail; b=CeBiVfOZo0eASmyIx7PqDmtVs31lBwrPZLSoDNAPba0K/cfSoc2vG44pwvotJgwBY6hOhutIFP1Jn+gDCqyCy4XRSQ7OSpa42dQ07cvckQLvC0ZJYP8o4hA4bT4RuByq81Hial5JsOs84HaYn/XJoOstTczT11Dj36rcCq5lRiY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706581704; c=relaxed/simple;
	bh=RmjSv8tplKUyNkC/J+01CRjpdBI5t7GZ5rFbFUUBD2o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Bh6BaGZAv6PZWVkdenvhaQ7hCRuY42jTVTcA+PKsB6uq1xswRAl/4jD5MgnAZPhk43jHEo09saoRGZUw9PyGLJXPu9MheOYwQMTjz41JMv8RRQQRBVgSws3c2PklJcKh/0WPr2S41i9En/CwPJ3u25QrL8aVf1qzckQ/Y57zdLo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=mZVhOkF2; arc=fail smtp.client-ip=40.107.20.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k37ytzpm34Qwfu4WJ9RRFpthbt+iV0NhG6yU5Id8Xb383aBj8Y02mN/F5ysVsUeJfKLiWYmL+knGPSG5gI8eJeUSXUeQ1Ku+fqcYlaa0YbZr3MenCH+FegNUjl9epaAPkvJcRQpJBoJJ4xhHwF5PrZJBtTFVs9YqhdYlUEWIne3LrNUVXWS5XXJUPeikKAvmFehvOlxfWT79jACasXaHe807Z5hUGD8NoXapXbomwiDjVONt+BzJlM64nJUVCyrQ82WKRRgmKisPPmCHZW8ZwLGawFYlZMsss+lq8x4WCzaJ1rTeERW8BnkYu/8SUPwZZ8pwL9HuXLGFmshuO3EJOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RmjSv8tplKUyNkC/J+01CRjpdBI5t7GZ5rFbFUUBD2o=;
 b=hLaEfS/MeobSj6E/GEpiob7BbIOJE3ACrWBDmKuKUx+kiRCmzxOJDD89Khxm6dkFusnMtNRthcBLaHsYlIABLSDFjKLn4QzsSULEG6qDbQNNLdsmlZa/8SXG+5LcLM0GULYTKWFzZGh8m1hnD+co7mOcpgvW812Dgg0SnrGTeZPvD9xNwg2unI9/L4CW29nbZg+swqhgeTtoBLCddiWnVD2EbssjXwalfRypXxJRmGaiDH0mf29/gUphv5pif0Dzf1w4GET1bsMb/2e40yBy6oz+A2xvPOM5YGfFSmoFvC+GMpbV8ITP+v1B0AKfQxDkc8sT1KgKVn+G58rqh0sWAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RmjSv8tplKUyNkC/J+01CRjpdBI5t7GZ5rFbFUUBD2o=;
 b=mZVhOkF2IHZyygMVC2ejHaFUPm6lL1yQ5ovznw2QQZuXxZJptYK0YzaUoH2tY50eTWTxsLaWozUkU7hw9ao5mCW4Vv/KjMV4XTJJo6q5wIbqJZyFMwAYWZzF1P8QN5LBjPZg+4X3RQxycidxzJPkVF/IcEjIW3V2oj4zJkfEfYo=
Received: from PAXPR04MB9448.eurprd04.prod.outlook.com (2603:10a6:102:2b1::21)
 by PAXPR04MB9490.eurprd04.prod.outlook.com (2603:10a6:102:2c2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Tue, 30 Jan
 2024 02:28:18 +0000
Received: from PAXPR04MB9448.eurprd04.prod.outlook.com
 ([fe80::b24c:5d0d:bb15:3e9]) by PAXPR04MB9448.eurprd04.prod.outlook.com
 ([fe80::b24c:5d0d:bb15:3e9%5]) with mapi id 15.20.7228.029; Tue, 30 Jan 2024
 02:28:18 +0000
From: Sandor Yu <sandor.yu@nxp.com>
To: Adam Ford <aford173@gmail.com>
CC: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Jacky Bai
	<ping.bai@nxp.com>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam
	<festevam@gmail.com>, dl-linux-imx <linux-imx@nxp.com>, Ulf Hansson
	<ulf.hansson@linaro.org>, Lucas Stach <l.stach@pengutronix.de>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Marek Vasut <marex@denx.de>, "Peng Fan (OSS)"
	<peng.fan@oss.nxp.com>
Subject: RE: [EXT] Re: [PATCH 2/3] pmdomain: imx8mp-blk-ctrl: imx8mp_blk: Add
 fdcc clock to hdmimix domain
Thread-Topic: [EXT] Re: [PATCH 2/3] pmdomain: imx8mp-blk-ctrl: imx8mp_blk: Add
 fdcc clock to hdmimix domain
Thread-Index: AQHaUU1zpB2x2NMooUO62wmFXPCChLDv9e3AgAEgMoCAAI0vAA==
Date: Tue, 30 Jan 2024 02:28:18 +0000
Message-ID:
 <PAXPR04MB9448EB972FBC59EE9E1482BEF47D2@PAXPR04MB9448.eurprd04.prod.outlook.com>
References: <20240106223951.387067-1-aford173@gmail.com>
 <20240106223951.387067-2-aford173@gmail.com>
 <CAHCN7x+=etco+xEELdf5AyR07sR6c9tTFtsA3K5Dy99qhAZQMg@mail.gmail.com>
 <DB9PR04MB9452DB580ACF844505F7AA2CF47E2@DB9PR04MB9452.eurprd04.prod.outlook.com>
 <CAHCN7xLwSyGsyo5XigJroB8RftJNXeRDb8o+a-VRSFGSs5NW8A@mail.gmail.com>
In-Reply-To:
 <CAHCN7xLwSyGsyo5XigJroB8RftJNXeRDb8o+a-VRSFGSs5NW8A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9448:EE_|PAXPR04MB9490:EE_
x-ms-office365-filtering-correlation-id: 34583fb5-b3b4-4b55-baf7-08dc213b1ecf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 gPYugI9Z+t2uftOh0doSNwBe9kKJR5cGl0yuGf5S04WjXLG/0vNwXrlc8Oph2jLtNqPwv4LPGg4/5osq0+JmZIYxbjc8SWJuFxe0QZ/sJ8wedGQQGzWwX6dO2xlyGYWFyD3GLDFzu3WU5D9cVGrsrLQBWxU0KWFARiKWkIDAfbOeHtGFNVsG9H1xijEY8L1/VPGafiRdX7DiSHwvXuDkBOgpL4sWVMXp1Yi+URsEQ4+AXWx7hFu6APy1GUXIYYuKPq2rQv5o/Cj3/jwp+PIgVrAYQiUPeyNj3cIRHA/sofWQiYYhGooTvrrFNdvwx3LTH+cJouUi1bcwcyYrDAeFx4VrPF023b6idJ3QaXqVDosuQeUdVHi/o+jiJKtbYUhwZdERghkJazWSlJo4Xma9v5AlCPYIUJ8eKD5JfaVdbulwQve+16Xswa0FJ9Ln1NJBninxYqQBWFcw5OUf14+EZ6twIJl4Yp/OwKvx+LoU6h/hEjDMf35JxoihuelPGajixz0siIh2SVd9zB47feByvAG3l/M5g1SwbRWYw+Fy5083u9TMaOnDyrB15v4WP0kqQxTB0v5J4I1c3BJTEsL9tK1qpy6SRkBAcuRBf1z3isykqRUZYt43czGGHdjxBPGCANsCukA07L1QGUF3oRWqcDsAX/dcJgxBKGO3i+Tz9TTSLD13yG6wlaBfKNGFZ6iL
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9448.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(366004)(376002)(396003)(39860400002)(230922051799003)(230273577357003)(230173577357003)(186009)(64100799003)(451199024)(1800799012)(55016003)(53546011)(26005)(83380400001)(6506007)(7696005)(33656002)(86362001)(38070700009)(7416002)(8676002)(41300700001)(44832011)(5660300002)(4326008)(8936002)(9686003)(66946007)(38100700002)(122000001)(66476007)(2906002)(76116006)(6916009)(66556008)(71200400001)(66446008)(54906003)(64756008)(478600001)(52536014)(316002)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RnpOUXoveFBpT3FLelNUSEdKTzZZRWNPd2w3T2p5ZFIzTTBRS09VaG1lT3Zw?=
 =?utf-8?B?czM5SmFQeS9NL2lwbHk2dHNhRmU3L2t0TmZEczdmYUR2YVZWcWM4Wnpvem9s?=
 =?utf-8?B?ZEs2NENQNEN2SXMwbmhGNmxZWW5YYnQwTXRVZGRZRzltNGpKMDZxbGJ5WmIw?=
 =?utf-8?B?UGREWjFreWxZd1pyeDZ4OXNDdi9MTTRYRGt5UVNNdWFtUlJOZTVHZVZxcFZk?=
 =?utf-8?B?Z3VsYjRPV2orMUJzc2Z5N3gxbkl4MmZzY241R2FwTTVXMjhTS0NHYlU2OFBi?=
 =?utf-8?B?R3hiK2lPREd0UENTbVc2TW5lMTFIdlFCMmM5WVdlTmhCMTVjYXAwWEJPRURx?=
 =?utf-8?B?QUpWNHZCZlZ0dUpvRVdQT2ZKMnVab0NzZjlnc2RTY3Q3WFNqQ0VLbDdobWpm?=
 =?utf-8?B?TDZQL3NSRG12WFlLMXI5K3lmc0JOdjJNdzVHYVJwbjZNa2cvNnczV05FQmJ5?=
 =?utf-8?B?RmJ2K3dyb2RoSk5FdHBNNzd6THhTNzNjQWovdlMwK1NGUnVPTVZlcVowSVFZ?=
 =?utf-8?B?SEFHd05NeTF1Mm9xTWFlODJDUnBVc04wT08yVU1ibXR4eHozTWF1c2NWSlhI?=
 =?utf-8?B?Y2UxUzRWcXZTTVBabVQrL3ZMYnFKeVU1N1ZGTFQ4VmswTnBRUWhVQWJlcVRK?=
 =?utf-8?B?ZklyUC9iT0Q5blVlNThod2Z4VUsrOGs3c3VYSVF5VC95bkJ3ZVZhK2VpRis2?=
 =?utf-8?B?Q2xtRmwxazhud0g4Q0gvekluaWhMb2QwSU5WQWJxQUVyamNDc3RJOGpEdnYy?=
 =?utf-8?B?OEM5L3BBTTJZcXJ4WlN5dnh1MGx6d3d0cFFJenF0K3dMNThYRW9yQ0xSYnhq?=
 =?utf-8?B?SXNheURmbHAzNTVFOHFta2VESWRIaTRiMUJ5RjkwTHdlZTBzSkRjWXkyUnRN?=
 =?utf-8?B?WUNGUXBKcUh3RDF3T3RvQ0ZVY2dnZFllNWF1YnpZbFlwbTlqSlorZ3ltUElB?=
 =?utf-8?B?QktVMjhmcjdIeEVMZDhjV2ZJSTE2ZmJOaGdCZ29hTy9hSjBDOHFtam9pWlpV?=
 =?utf-8?B?eVc2NTNTNXJ3Tk1abmdaS05xQ09GTlZZMEE1TTFQcWJzSkJFK3V3b3lHZEto?=
 =?utf-8?B?am54KzNyS002aGJpOGVpUWI2Qkx3Z2pzNW1QaVlmVHVoVzh4K2l0enlnbEhW?=
 =?utf-8?B?RTFabVNpU3NsWlF0QUhYcGdqdGtUQ2RHelduellheHpyQkRJV0JIUlkrMUto?=
 =?utf-8?B?YVFwYy9JWVVvQkZiWkU5TEVSdEtDY2JzKzdxVlJQNFFzR25PRHQvWUpta1BX?=
 =?utf-8?B?VkZpK0dBU0lobU9zOXNja1k0UlJia3NVMnVsWW5QOHNJL3NEc3o3b0k3d0Ft?=
 =?utf-8?B?Y2VGYUxQWTYrWW1sQ2k3bVc0bEdFdDRhOCtNa1FIVVhucDQvOFJqZnlkRmdY?=
 =?utf-8?B?QVJEYW1NaUNTKzdKV0IzOEYvbCs1a1JTTk5Zby9Gci9rUWwzU2RJaGhIV2Zo?=
 =?utf-8?B?NzlhdXNaakYrMitzU0xPZU5PT0VnR3V1eUg2cWdIRS9ZMHJtYXhCWFZJZWZ6?=
 =?utf-8?B?RDVFTGZ1enFlaDNOS3NSQU5ObFpSZTVDQTdYL05YUTNVZ1RDN09YMkV6cG9x?=
 =?utf-8?B?VFNoY20rc2JrSk9XeXN1RkN6TEt6aGtGK2FVZlFiUS8zQzdubVhZZHcxVHAr?=
 =?utf-8?B?ai9nRXBiQkNqbmRmdDhFbTJ2YlRUbU9mQ1ozZmlBUlFILzEwd1h0UnMwbVVj?=
 =?utf-8?B?TGlpdE5uUzhKZWttNHhERkxEbFpzVmpteHhibGluNnlzQUpLR09RTEo1aFNY?=
 =?utf-8?B?OUZVRXdtVDhBV1A4NUF2dTE3R1VrSGlmVVlnT0VaSlduTjFSTjlUQWo0RzIw?=
 =?utf-8?B?d0Y2U2d5eTlxMlo4SG92VFFYdHd2NHZQSjZMQ3BKVEtxSzlRbW1OcGduaE1P?=
 =?utf-8?B?TUtHUWZveGxiZGdaN2JSc1FzQ0tTQWRqRHVQM0Z0WFJrQ3hXNFZLTUFMVFlq?=
 =?utf-8?B?VDBQRTlGZ1Z0V0ZKZXpKVVRSRDNieUw0V0tja05qTFNRamRHOGJCRHhxNW1C?=
 =?utf-8?B?QWZ5TDhjYjNqNi9kejhYc2R4Mllob1p5MDdQUTN5NFRPa3ZmUG1LYnpJTk1J?=
 =?utf-8?B?b2lBWmo0SnJ0aUtPRXdITGJrRGxKc3RmcHVLZDBvM2NDUHhTWWJuQWE1RllB?=
 =?utf-8?Q?kmTo=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9448.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34583fb5-b3b4-4b55-baf7-08dc213b1ecf
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2024 02:28:18.3451
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yRPdd0B/sJcySqGmMBJLJ+vswwf+7ATfGv62RnYlyMsjk6feMXy0mqIzF+AHydHO2vzFunZXDAKx3hitOwTIIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9490

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQWRhbSBGb3JkIDxhZm9y
ZDE3M0BnbWFpbC5jb20+DQo+IFNlbnQ6IDIwMjTlubQx5pyIMzDml6UgMTo1Ng0KPiBUbzogU2Fu
ZG9yIFl1IDxzYW5kb3IueXVAbnhwLmNvbT4NCj4gQ2M6IGxpbnV4LXBtQHZnZXIua2VybmVsLm9y
ZzsgSmFja3kgQmFpIDxwaW5nLmJhaUBueHAuY29tPjsgUm9iIEhlcnJpbmcNCj4gPHJvYmgrZHRA
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
OiBSZTogW0VYVF0gUmU6IFtQQVRDSCAyLzNdIHBtZG9tYWluOiBpbXg4bXAtYmxrLWN0cmw6IGlt
eDhtcF9ibGs6DQo+IEFkZCBmZGNjIGNsb2NrIHRvIGhkbWltaXggZG9tYWluDQo+IA0KPiBDYXV0
aW9uOiBUaGlzIGlzIGFuIGV4dGVybmFsIGVtYWlsLiBQbGVhc2UgdGFrZSBjYXJlIHdoZW4gY2xp
Y2tpbmcgbGlua3Mgb3INCj4gb3BlbmluZyBhdHRhY2htZW50cy4gV2hlbiBpbiBkb3VidCwgcmVw
b3J0IHRoZSBtZXNzYWdlIHVzaW5nIHRoZSAnUmVwb3J0DQo+IHRoaXMgZW1haWwnIGJ1dHRvbg0K
PiANCj4gDQo+IE9uIFN1biwgSmFuIDI4LCAyMDI0IGF0IDc6MznigK9QTSBTYW5kb3IgWXUgPHNh
bmRvci55dUBueHAuY29tPiB3cm90ZToNCj4gPg0KPiA+DQo+ID4NCj4gPiA+IC0tLS0tT3JpZ2lu
YWwgTWVzc2FnZS0tLS0tDQo+ID4gPiBGcm9tOiBBZGFtIEZvcmQgPGFmb3JkMTczQGdtYWlsLmNv
bT4NCj4gPiA+IFNlbnQ6IDIwMjTlubQx5pyIMjjml6UgMjoyMA0KPiA+ID4gVG86IGxpbnV4LXBt
QHZnZXIua2VybmVsLm9yZw0KPiA+ID4gQ2M6IFNhbmRvciBZdSA8c2FuZG9yLnl1QG54cC5jb20+
OyBKYWNreSBCYWkgPHBpbmcuYmFpQG54cC5jb20+OyBSb2INCj4gPiA+IEhlcnJpbmcgPHJvYmgr
ZHRAa2VybmVsLm9yZz47IEtyenlzenRvZiBLb3psb3dza2kNCj4gPiA+IDxrcnp5c3p0b2Yua296
bG93c2tpK2R0QGxpbmFyby5vcmc+OyBDb25vciBEb29sZXkNCj4gPiA+IDxjb25vcitkdEBrZXJu
ZWwub3JnPjsgU2hhd24gR3VvIDxzaGF3bmd1b0BrZXJuZWwub3JnPjsgU2FzY2hhDQo+IEhhdWVy
DQo+ID4gPiA8cy5oYXVlckBwZW5ndXRyb25peC5kZT47IFBlbmd1dHJvbml4IEtlcm5lbCBUZWFt
DQo+ID4gPiA8a2VybmVsQHBlbmd1dHJvbml4LmRlPjsgRmFiaW8gRXN0ZXZhbSA8ZmVzdGV2YW1A
Z21haWwuY29tPjsNCj4gPiA+IGRsLWxpbnV4LWlteCA8bGludXgtaW14QG54cC5jb20+OyBVbGYg
SGFuc3Nvbg0KPiA+ID4gPHVsZi5oYW5zc29uQGxpbmFyby5vcmc+OyBMdWNhcyBTdGFjaCA8bC5z
dGFjaEBwZW5ndXRyb25peC5kZT47DQo+ID4gPiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsg
bGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOw0KPiA+ID4gbGludXgta2VybmVs
QHZnZXIua2VybmVsLm9yZzsgTWFyZWsgVmFzdXQgPG1hcmV4QGRlbnguZGU+OyBQZW5nIEZhbg0K
PiA+ID4gKE9TUykgPHBlbmcuZmFuQG9zcy5ueHAuY29tPg0KPiA+ID4gU3ViamVjdDogW0VYVF0g
UmU6IFtQQVRDSCAyLzNdIHBtZG9tYWluOiBpbXg4bXAtYmxrLWN0cmw6DQo+ID4gPiBpbXg4bXBf
YmxrOiBBZGQgZmRjYyBjbG9jayB0byBoZG1pbWl4IGRvbWFpbg0KPiA+ID4NCj4gPiA+IENhdXRp
b246IFRoaXMgaXMgYW4gZXh0ZXJuYWwgZW1haWwuIFBsZWFzZSB0YWtlIGNhcmUgd2hlbiBjbGlj
a2luZw0KPiA+ID4gbGlua3Mgb3Igb3BlbmluZyBhdHRhY2htZW50cy4gV2hlbiBpbiBkb3VidCwg
cmVwb3J0IHRoZSBtZXNzYWdlDQo+ID4gPiB1c2luZyB0aGUgJ1JlcG9ydCB0aGlzIGVtYWlsJyBi
dXR0b24NCj4gPiA+DQo+ID4gPg0KPiA+ID4gT24gU2F0LCBKYW4gNiwgMjAyNCBhdCA0OjQw4oCv
UE0gQWRhbSBGb3JkIDxhZm9yZDE3M0BnbWFpbC5jb20+IHdyb3RlOg0KPiA+ID4gPg0KPiA+ID4g
PiBBY2NvcmRpbmcgdG8gaS5NWDhNUCBSTSBhbmQgSERNSSBBREQsIHRoZSBmZGNjIGNsb2NrIGlz
IHBhcnQgb2YNCj4gPiA+ID4gaGRtaSByeCB2ZXJpZmljYXRpb24gSVAgdGhhdCBzaG91bGQgbm90
IGVuYWJsZSBmb3IgSERNSSBUWC4NCj4gPiA+ID4gQnV0IGFjdHVhbGx5IGlmIHRoZSBjbG9jayBp
cyBkaXNhYmxlZCBiZWZvcmUgSERNSS9MQ0RJRiBwcm9iZSwNCj4gPiA+ID4gTENESUYgd2lsbCBu
b3QgZ2V0IHBpeGVsIGNsb2NrIGZyb20gSERNSSBQSFkgYW5kIHByaW50IHRoZSBlcnJvcg0KPiA+
ID4gPiBsb2dzOg0KPiA+ID4gPg0KPiA+ID4gPiBbQ1JUQzozOTpjcnRjLTJdIHZibGFuayB3YWl0
IHRpbWVkIG91dA0KPiA+ID4gPiBXQVJOSU5HOiBDUFU6IDIgUElEOiA5IGF0IGRyaXZlcnMvZ3B1
L2RybS9kcm1fYXRvbWljX2hlbHBlci5jOjE2MzQNCj4gPiA+ID4gZHJtX2F0b21pY19oZWxwZXJf
d2FpdF9mb3JfdmJsYW5rcy5wYXJ0LjArMHgyM2MvMHgyNjANCj4gPiA+ID4NCj4gPiA+ID4gQWRk
IGZkY2MgY2xvY2sgdG8gTENESUYgYW5kIEhETUkgVFggcG93ZXIgZG9tYWlucyB0byBmaXggdGhl
IGlzc3VlLg0KPiA+ID4NCj4gPiA+IFBlbmcgKG9yIGFueW9uZSBmcm9tIE5YUCksDQo+ID4gPg0K
PiA+ID4gSSBib3Jyb3dlZCB0aGlzIHBhdGNoIGZyb20gdGhlIE5YUCBkb3duLXN0cmVhbSBrZXJu
ZWwgZm9yIHR3byByZWFzb25zOg0KPiA+ID4gIEl0J3MgaW4gTlhQJ3MgYnJhbmNoIHRvIGFkZHJl
c3MgYW4gZXJyb3IgJiBtb3ZlIHRoZSBmZGNjIGNsb2NrIG91dA0KPiA+ID4gb2YgdGhlIEhETUkt
dHggZHJpdmVyIGR1ZSB0byBxdWVzdGlvbnMvZmVlZGJhY2sgdGhhdCBMdWNhcyBnb3Qgb24gdGhh
dA0KPiBkcml2ZXIuDQo+ID4gPg0KPiA+ID4gVGhlIEZEQ0MgY2xvY2sgaXNuJ3Qgd2VsbCBkb2N1
bWVudGVkLCBhbmQgaXQgc2VlbXMgbGlrZSBpdCdzDQo+ID4gPiBuZWNlc3NhcnkgZm9yIHRoZSBI
RE1JLVRYLCBidXQgSSdkIGxpa2UgdG8gbWFrZSBzdXJlIHRoaXMgaXMgdGhlDQo+ID4gPiBwcm9w
ZXIgc29sdXRpb24sIGFuZCBJIGhhdmVuJ3QgcmVjZWl2ZWQgYW55IGFkZGl0aW9uYWwgZmVlZGJh
Y2suDQo+ID4gPiBDYW4gc29tZW9uZSBmcm9tIE5YUCBjb25maXJtIHRoYXQgcmVhbGx5IGlzIHRo
ZSBwcm9wZXIgc29sdXRpb24/DQo+ID4gPg0KPiA+ID4gdGhhbmsgeW91LA0KPiA+ID4NCj4gPiA+
IGFkYW0NCj4gPg0KPiA+IEhpIEFkYW0sDQo+ID4NCj4gDQo+IFNhbmRvciwNCj4gDQo+ID4gSW4g
TlhQIGludGVybmFsIGRvY3VtZW50LCB0aGUgY2xvY2sgSERNSV9GRENDX1RTVF9DTEtfUk9PVCB3
YXMgZm9yDQo+IGludGVybmFsIHVzZSBvbmx5IGZvciBmdXR1cmUgTlhQIGRldmVsb3BtZW50IElQ
Lg0KPiA+IEl0IHNob3VsZCBub3QgYmUgZXhwb3NlZCB0byBjdXN0b21lciBpbiBkb2N1bWVudCBi
dXQgdW5mb3J0dW5hdGVseSBpdCBoYXZlDQo+IHRvIGJlIGVuYWJsZWQgZm9yIEhETUlUWC4NCj4g
Pg0KPiA+IEkgc3VibWl0dGVkIGEgcmVxdWVzdCB0aWNrZXQgdG8gdGhlIGRlc2lnbiB0ZWFtIHNl
dmVyYWwgbW9udGhzIGFnbywNCj4gPiBHZW5lcmFsbHksIHRpY2tldHMgb2YgdGhpcyBkaWRuJ3Qg
Z2V0IHRoZSBwcmlvcml0eSBpbiBkZXNpZ24gdGVhbSBhbmQgSSBoYXZlbuKAmXQNCj4gcmVjZWl2
ZWQgYW55IHZhbHVhYmxlIGZlZWRiYWNrLg0KPiA+IE9uY2UgZGVzaWduIHRlYW0gY29uZmlybWVk
LCBJIHRoaW5rIHRoZSBkb2N1bWVudCB3aWxsIHVwZGF0ZSB0byBhZGQgdGhlDQo+IGZkY2MgY2xv
Y2suDQo+IA0KDQpIaSBBZGFtLA0KDQo+IFRoYW5rIHlvdSBmb3IgeW91ciByZXNwb25zZS4gICBE
byB5b3UgaGF2ZSBhbnkgb2JqZWN0aW9ucyB0byBoYXZpbmcNCj4gdGhlIEZEQ0MgY2xvY2sgYWRk
ZWQgdG8gdGhlIHBvd2VyIGRvbWFpbiBkcml2ZXI/ICBJIGtub3cgdGhlcmUgYXJlIHNldmVyYWwN
Cj4gb2YgdXMgd2hvIHdvdWxkIHJlYWxseSBsaWtlIHRvIHNlZSB0aGUgSERNSS1UWCBkcml2ZXIg
YXBwbGllZCwgYW5kIEkgdGhpbmsgdGhpcw0KPiBwYXRjaCBnZXRzIHVzIG9uZSBzdGVwIGNsb3Nl
ci4NCj4gDQpBcyBJIG1lbnRpb25lZCBhYm92ZSwgdGhlIEZEQ0MgY2xvY2sgaXMgbm90IGZvciBI
RE1JVFggaW4gZGVzZ2luLCBidXQgaXQgaXMgcGFydCBvZiBIRE1JIGRvbWFpbiB0aGF0IG5lZWRl
ZCBieSBIRE1JVFguDQpTbyBJIHRoaW5rIGl0IGlzIHJlYXNvbmFibGUgYWRkZWQgaXQgdG8gdGhl
IHBvd2VyIGRvbWFpbiBkcml2ZXIuDQoNCkIuUg0KU2FuZG9yDQoNCj4gdGhhbmtzLA0KPiANCj4g
YWRhbQ0KPiA+DQo+ID4gQi5SDQo+ID4gU2FuZG9yDQo+ID4NCj4gPiA+DQo+ID4gPiA+DQo+ID4g
PiA+IFNpZ25lZC1vZmYtYnk6IFNhbmRvciBZdSA8U2FuZG9yLnl1QG54cC5jb20+DQo+ID4gPiA+
IFJldmlld2VkLWJ5OiBKYWNreSBCYWkgPHBpbmcuYmFpQG54cC5jb20+DQo+ID4gPiA+IFNpZ25l
ZC1vZmYtYnk6IEFkYW0gRm9yZCA8YWZvcmQxNzNAZ21haWwuY29tPg0KPiA+ID4gPiAtLS0NCj4g
PiA+ID4gVGhlIG9yaWdpbmFsIHdvcmsgd2FzIGZyb20gU2FuZG9yIG9uIHRoZSBOWFAgRG93bi1z
dHJlYW0ga2VybmVsDQo+ID4gPiA+DQo+ID4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BtZG9t
YWluL2lteC9pbXg4bXAtYmxrLWN0cmwuYw0KPiA+ID4gPiBiL2RyaXZlcnMvcG1kb21haW4vaW14
L2lteDhtcC1ibGstY3RybC5jDQo+ID4gPiA+IGluZGV4IGUzMjAzZWI2YTAyMi4uYTU2ZjdmOTJk
MDkxIDEwMDY0NA0KPiA+ID4gPiAtLS0gYS9kcml2ZXJzL3BtZG9tYWluL2lteC9pbXg4bXAtYmxr
LWN0cmwuYw0KPiA+ID4gPiArKysgYi9kcml2ZXJzL3BtZG9tYWluL2lteC9pbXg4bXAtYmxrLWN0
cmwuYw0KPiA+ID4gPiBAQCAtNTUsNyArNTUsNyBAQCBzdHJ1Y3QgaW14OG1wX2Jsa19jdHJsX2Rv
bWFpbl9kYXRhIHsNCj4gPiA+ID4gICAgICAgICBjb25zdCBjaGFyICpncGNfbmFtZTsNCj4gPiA+
ID4gIH07DQo+ID4gPiA+DQo+ID4gPiA+IC0jZGVmaW5lIERPTUFJTl9NQVhfQ0xLUyAyDQo+ID4g
PiA+ICsjZGVmaW5lIERPTUFJTl9NQVhfQ0xLUyAzDQo+ID4gPiA+ICAjZGVmaW5lIERPTUFJTl9N
QVhfUEFUSFMgMw0KPiA+ID4gPg0KPiA+ID4gPiAgc3RydWN0IGlteDhtcF9ibGtfY3RybF9kb21h
aW4gew0KPiA+ID4gPiBAQCAtNDU3LDggKzQ1Nyw4IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QNCj4g
PiA+ID4gaW14OG1wX2Jsa19jdHJsX2RvbWFpbl9kYXRhDQo+ID4gPiBpbXg4bXBfaGRtaV9kb21h
aW5fZGF0YVtdID0gew0KPiA+ID4gPiAgICAgICAgIH0sDQo+ID4gPiA+ICAgICAgICAgW0lNWDhN
UF9IRE1JQkxLX1BEX0xDRElGXSA9IHsNCj4gPiA+ID4gICAgICAgICAgICAgICAgIC5uYW1lID0g
ImhkbWlibGstbGNkaWYiLA0KPiA+ID4gPiAtICAgICAgICAgICAgICAgLmNsa19uYW1lcyA9IChj
b25zdCBjaGFyICpbXSl7ICJheGkiLCAiYXBiIiB9LA0KPiA+ID4gPiAtICAgICAgICAgICAgICAg
Lm51bV9jbGtzID0gMiwNCj4gPiA+ID4gKyAgICAgICAgICAgICAgIC5jbGtfbmFtZXMgPSAoY29u
c3QgY2hhciAqW10peyAiYXhpIiwgImFwYiIsICJmZGNjIiB9LA0KPiA+ID4gPiArICAgICAgICAg
ICAgICAgLm51bV9jbGtzID0gMywNCj4gPiA+ID4gICAgICAgICAgICAgICAgIC5ncGNfbmFtZSA9
ICJsY2RpZiIsDQo+ID4gPiA+ICAgICAgICAgICAgICAgICAucGF0aF9uYW1lcyA9IChjb25zdCBj
aGFyICpbXSl7ImxjZGlmLWhkbWkifSwNCj4gPiA+ID4gICAgICAgICAgICAgICAgIC5udW1fcGF0
aHMgPSAxLA0KPiA+ID4gPiBAQCAtNDgzLDggKzQ4Myw4IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QN
Cj4gPiA+ID4gaW14OG1wX2Jsa19jdHJsX2RvbWFpbl9kYXRhDQo+ID4gPiBpbXg4bXBfaGRtaV9k
b21haW5fZGF0YVtdID0gew0KPiA+ID4gPiAgICAgICAgIH0sDQo+ID4gPiA+ICAgICAgICAgW0lN
WDhNUF9IRE1JQkxLX1BEX0hETUlfVFhdID0gew0KPiA+ID4gPiAgICAgICAgICAgICAgICAgLm5h
bWUgPSAiaGRtaWJsay1oZG1pLXR4IiwNCj4gPiA+ID4gLSAgICAgICAgICAgICAgIC5jbGtfbmFt
ZXMgPSAoY29uc3QgY2hhciAqW10peyAiYXBiIiwgInJlZl8yNjZtIiB9LA0KPiA+ID4gPiAtICAg
ICAgICAgICAgICAgLm51bV9jbGtzID0gMiwNCj4gPiA+ID4gKyAgICAgICAgICAgICAgIC5jbGtf
bmFtZXMgPSAoY29uc3QgY2hhciAqW10peyAiYXBiIiwgInJlZl8yNjZtIiwNCj4gPiA+ICJmZGNj
IiB9LA0KPiA+ID4gPiArICAgICAgICAgICAgICAgLm51bV9jbGtzID0gMywNCj4gPiA+ID4gICAg
ICAgICAgICAgICAgIC5ncGNfbmFtZSA9ICJoZG1pLXR4IiwNCj4gPiA+ID4gICAgICAgICB9LA0K
PiA+ID4gPiAgICAgICAgIFtJTVg4TVBfSERNSUJMS19QRF9IRE1JX1RYX1BIWV0gPSB7DQo+ID4g
PiA+IC0tDQo+ID4gPiA+IDIuNDMuMA0KPiA+ID4gPg0K

