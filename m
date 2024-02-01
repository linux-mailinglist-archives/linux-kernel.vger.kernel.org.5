Return-Path: <linux-kernel+bounces-47917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D7FC38454A0
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 10:58:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4384D1F2B433
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 09:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 652C24DA19;
	Thu,  1 Feb 2024 09:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="sLYX7VTk"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2064.outbound.protection.outlook.com [40.107.20.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44824D9F4;
	Thu,  1 Feb 2024 09:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706781500; cv=fail; b=OwLTpF5XdCUtypWYp7HSwJIjC7Qi0UwaamrJ/MfJXPGtjp2s6j/8JCB7CtSYQzLHt0ugepGE312ynkWBSZIuT9TpvqeC5nXaQBrTleh67OsjBmOVFyjNEwBzSxWoEe385LO9OywrghfEF4gIEB3USkfsYZGt45c9d3+6vpUTBRw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706781500; c=relaxed/simple;
	bh=xJaA+XWwLYw/MTv2BjCYZ2lEoyb+vY8KTlZBVHMe5Jc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=e/eNEUq+ffaczo0lHjNK9DH6DUPDO+UCwfsEUN330ZMBQnMKi/7lLmnsGLPQ6a2bc74HtNbr9CAG7+vM1tIu/xNg3IiF6hZUXnZvXm3s4mpbMqEZoLOSpWS4d/roKWnDAzjbsJUvyX5vc7rsgyKqj8Y7mmI0sfeEmQSddKdpqO8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=sLYX7VTk; arc=fail smtp.client-ip=40.107.20.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fk3uHNNBNIa41E+hGfWbWtXa3+3YN4VyLhD6DHwRw7XKb61naKzFN1wF1BswiaHsvldJH9xhd2cBpBzjr7O4Kzfh8MsjC7WF2b9Z1BcOVYzQL9luGyhRki1mdaBYji8cy8lGry1XhfHCjI3uHXF6AZ/8TRzrzR7MWK4LHM7YQqLvhgyG9BvqTIaThpvs5VVl3owP2aj0+AIghClZ+qD6OQFWCdFM5QLYGrkzky4xaFq7l9bMrPukie2sGv9OxVx22MnNOUUppOBh7qIoz4hyYsa+P824h8lQtTGi4UnIL9IhswRLD8st897Nsb2LE71aRksPk2cl3z++r1AUsxr51g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xJaA+XWwLYw/MTv2BjCYZ2lEoyb+vY8KTlZBVHMe5Jc=;
 b=DJGEWhTFubMr2C5LxQN0ci/zTLM15gIEFyYOJ8SX1CoyIwUz1lonC3irdB8ZnZtSlXu+DN2numNClUQ1GzaP6448vso9PTEy+PpGrPvYtOABnEMr4BQBc2VwM5xmylQ5PPtZm/7V6Q6RU5JYP8OIngMDxoxWuMIyUNkrfHASX80ff/7+/Hzm/caf7UvDrBHo52JXN1I7DmXC7AR7O+fSMHGfOfdNUcYrok75XWQ1dwC1ILjsCpLS9/nknN7l5HM4Z9VvfTE/wO+RLAaDRqx48F3HhSnjpEk15Mp38EnLHaBYIGf3CBo8kGki0GT0NTlsDYagiHSFd0thZ9jybDKe/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xJaA+XWwLYw/MTv2BjCYZ2lEoyb+vY8KTlZBVHMe5Jc=;
 b=sLYX7VTknkSRgrasaVBqIsSgRO0gO04+LHPYJznDek8B3KgAu2J0FQ/OQsXglGOf6Gqvc2UVPbU9Datz5i91y5wF1YssBMDNvzWFaatLF9ntnb6Is9EMHbHsVWCd8Objp3P8CM97n27wUaFJGXOmET9fLG6l+rKjQfZAWiVvIiU=
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com (2603:10a6:803:57::30)
 by AM9PR04MB8178.eurprd04.prod.outlook.com (2603:10a6:20b:3e3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.24; Thu, 1 Feb
 2024 09:58:14 +0000
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::f363:2b4f:4f8b:8af5]) by VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::f363:2b4f:4f8b:8af5%6]) with mapi id 15.20.7249.024; Thu, 1 Feb 2024
 09:58:14 +0000
From: Carlos Song <carlos.song@nxp.com>
To: Francesco Dolcini <francesco@dolcini.it>
CC: "broonie@kernel.org" <broonie@kernel.org>, "shawnguo@kernel.org"
	<shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>, dl-linux-imx
	<linux-imx@nxp.com>, "benjamin@bigler.one" <benjamin@bigler.one>,
	"stefanmoring@gmail.com" <stefanmoring@gmail.com>,
	"linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] spi: imx: fix the burst length at DMA mode and CPU
 mode
Thread-Topic: [PATCH v2] spi: imx: fix the burst length at DMA mode and CPU
 mode
Thread-Index: AQHaVPUreNmKXHDCQ02KoZp+IBo02w==
Date: Thu, 1 Feb 2024 09:58:13 +0000
Message-ID:
 <VI1PR04MB50055CD3C608C5A0407B113BE8432@VI1PR04MB5005.eurprd04.prod.outlook.com>
References: <20240131101916.437398-1-carlos.song@nxp.com>
 <20240131194207.GB12870@francesco-nb>
 <VI1PR04MB5005EB37DD02F4E32D94336FE8432@VI1PR04MB5005.eurprd04.prod.outlook.com>
 <20240201085205.GA3906@francesco-nb>
In-Reply-To: <20240201085205.GA3906@francesco-nb>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI1PR04MB5005:EE_|AM9PR04MB8178:EE_
x-ms-office365-filtering-correlation-id: 00e6c300-89f9-4fc3-469a-08dc230c4e74
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 pgzHD0j/CIJc8ANYl4oe3JlNH8Y6VGxrDf1TslLJn+02qmtL4wU6GbLfL4iKGHtFriPqVkTWKiVJLlZ8b6nNoSkOrAY6z/XcUQl2vRVLP2qK858JysMNItBpMq86V2EgKCabshTRHhwmMuxVS10uGrOEgscIUouQRhXKCIQMzAnR8Daw+vm3VI/QbweVl2Miny7Zcz4apHYBFJ2WxfW+dPAvn5yHEIbkzdAu/oxNzyIWuOXHVO2ky4g1j2H9kG7nhwBZzoGZxbNe8e7DCFd6eeYdX0XcGFw/y9jK63DBOxoMk/drmLA/fpylG5laKLORjRQAd5kc8CH6dF7oNgJaLEP55gu6NPBwwTqjROy2ZaaHuB1YjXFlTZBwnKTm6vcBpw+Y39aimWUoL76f2NtojU7LkL07Xlrp0oQRfJ99eTLjGNmwFzqLHwc7ahfXkkKV+PuKCgiamAL6HPwCDCSva3TazWJlAY/Gzcdros8rpd4BoCcy6lN86tssj/J7yggi/IQrUD55petSVWoYdrmSjKyyQbdR6GrKUjwlVZY37ywtEmoTDgu83awXMNT+B4t4QjrisqdRNmyCvZQTuAnYhYi3qAlN8beYPUgcR3eaQBdNreK6loVAEgccGU2Ov+9QdIuLtxT1bUa4glE7jYEu8dPyj4pNWsuB+a4U1czojYA=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5005.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(396003)(136003)(366004)(39860400002)(230922051799003)(230273577357003)(230173577357003)(451199024)(1800799012)(186009)(64100799003)(41300700001)(83380400001)(53546011)(26005)(9686003)(7696005)(38100700002)(8676002)(8936002)(4326008)(122000001)(478600001)(5660300002)(66446008)(52536014)(66556008)(64756008)(7416002)(6506007)(66946007)(2906002)(76116006)(44832011)(66476007)(71200400001)(6916009)(54906003)(316002)(38070700009)(33656002)(86362001)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?eGY2RFV5UzIyR1FXVHh0ZGl0OXg3a2MzeVh1dUxoS3NhbXM5VjBKejFzSEdP?=
 =?gb2312?B?WjRFaitiNmlwaGwxUnUraEdVZjlMUzNteG1NdTVPNTFPbGVmdi9hU1VPVEJS?=
 =?gb2312?B?WVNENWwxcnBHbmorc01CcUxtU0JBVExpZWNGY29CelpOOGVlMDIrYTVKSFdQ?=
 =?gb2312?B?cE03M2tCeEVOa2V1ZVNONnNZSm53V3BmTmtYUk5ickY2ZkpTeFRvVmJSc1BD?=
 =?gb2312?B?UW0ySkQ2TVVWQnhFM280emNnR2N2eFhpdXQzQXVOZ0tSMXo3RXNXOU1SamVs?=
 =?gb2312?B?WWo3MW51clJoYlNpdllhYWpzMC9sdWNlRFlLZTdmeVdWaHE0YlZ2NUM0SU1x?=
 =?gb2312?B?Z21NUUxIbVdURVprRjA2Vk84engvSDBGVEk4MjJTZnhOWG9LZDlmZURnVnpB?=
 =?gb2312?B?NDBtWjdwU1BnWVJsbDViOVdzOVRiUXJvK0hUeXVYaG43bXdLUm5JeHQ2UUJm?=
 =?gb2312?B?ZmhmS1kzSVdobUQ5azhtcThqU1RuT3VkajBRME9HNktJZ2xZRVYzTTF3N1JK?=
 =?gb2312?B?dEJKZElQYlRISnZQY2c4YUZmdjJsS0hnQ0l4MmhwenBCVVU2V1V0RDJVTWM3?=
 =?gb2312?B?cFpWTXBzRkxDeDh1TllLak5GNEFZMHlTelptS2dtVUl0aFpaM0xRS1l0SENj?=
 =?gb2312?B?NHI1M1N1aUxuNzBIVHhOOWtZVjN0WGpEVUVIV2JrZTU3dXlqMWZKcTBpTXlL?=
 =?gb2312?B?V3FOVVhIdW9iNjdZaGlBTnJZZ01vUDBKTkdnZkVMcVdYbENobFVLbWNvV29u?=
 =?gb2312?B?allHZzFOUjUrUkZSRmtSLzVSVkpTQ3g5V1UvSzl5eGk3NlIyWVd0UTNLV2Nq?=
 =?gb2312?B?aFYzbFQ5N0puMzFDKzNvMmhwcXV1OXFvbFF2cWlLV1pINXRLZDdMUDBRalhB?=
 =?gb2312?B?TmU0NjNUandBRnA5S2hvVWZpemVHWm94NHJoWEw3YjhyTUFMbEFMZnlvRkZa?=
 =?gb2312?B?dmt3ZkxaejFLVGs0RU8rMmhDL3lnZy9qNHpqbU93QzBHTEc3aWFWdStPZ1hh?=
 =?gb2312?B?WXlqUjVhZmNUKzhmM0JMODRUUXNNZGt1Q3ozdVZUNWhBdkU0YVdMamRDKzBp?=
 =?gb2312?B?THZnRGFmRFJNa25KYXVuUFVjS3EwRUJnd3dXWGg0aGdLdmtWQmc3VG5SZ1ZI?=
 =?gb2312?B?bW9LS010WUF6dUs4ZkRFeG1qdzhqby9vS045R2YzaTRCU2p2M1JKL0NoZzZF?=
 =?gb2312?B?d3JsWWEzUU9NcXJwN29QS3BkeVdwbW4vWHBLL1RrUXNSS05TWkROTUdBZlp6?=
 =?gb2312?B?UlhUbC9pSWNFNVdyc2E5SXo3N0R1cUlya1pINnhQY01OZXZ4Q3EwZE1sTlJT?=
 =?gb2312?B?UnBkSGpNOFVVVFFMS3lLZUkxdFZaK0wzWXZtaUUwRTQzQzFmMEhxbExtZVI5?=
 =?gb2312?B?aDl5Znc3VUMvMWlZaVNubzhWSkJjSldUZXBJQ29aZ214RzBXaU84eEtrVHdE?=
 =?gb2312?B?RWc3RFNiVFQ3bWtZRkhXY05rQUllMUo3SE11WVZBaXVycFpxOWQxd1o4aUVm?=
 =?gb2312?B?a1ZHcWd5YmxBY0NJVElQUnJoMUxPRjV1b2VPSVhiV0NtTkJtOE52REV1cmty?=
 =?gb2312?B?UVdXbnNsV2FSMTYyYUhsMkF5SXYwRDdqNUphS3BKNnc1ZGIzMkRUNmoxa09L?=
 =?gb2312?B?dW4wb25LNE56UU9BaWRpdHVxdlFMMzdlUlkwRTVKQm5NV1hiTjQzK2x4bURO?=
 =?gb2312?B?cFk1NWRKWnhZS0FiL1FxMEdJOHFWekpKRDFDSU83U21vcTVMR2hKNklzWE94?=
 =?gb2312?B?dEl3bVhSbEliN2s2ZjlNaWdxV2FPWndxQno2UVRqTTBlY2ZnZ3d6VnNoNWFE?=
 =?gb2312?B?bWFwZU5qaWNta2tzaVVmU3NPZExqY0RObGJRODB6d291YTVvczRHcjBIaWQ1?=
 =?gb2312?B?cGpmeUUxUnh5c2F6SWtFMXpJWHg5NHI5M0M3dGFhaVlrSmJxUFZjY3VqaURC?=
 =?gb2312?B?UjVZanJ6OVJiT0lsRnEvc3hoSERnbVNoam93R2J6ak1Id1BQRHRqYTNiQ0JF?=
 =?gb2312?B?WHkzdU9TaElCdERaRk44Y3BDaUhGSzlVc05PdHNqVFhrV0NCVEM1aWNmNll1?=
 =?gb2312?B?ZEY2MkEzY2lOQ1FYSTNRNXd0SGJjUXdzWkM1a1RDYVJBenRRRWR6TkVtS3V3?=
 =?gb2312?Q?M/K8=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5005.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00e6c300-89f9-4fc3-469a-08dc230c4e74
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2024 09:58:14.1983
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p3Qr5AYk5/eMZxEUwhZ1na4UTISXZnbX1+W08cp8yqg3PArMRj540RqBQuN/zbkzTZoxKOl62XorGMBni9YvYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8178

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBGcmFuY2VzY28gRG9sY2luaSA8
ZnJhbmNlc2NvQGRvbGNpbmkuaXQ+DQo+IFNlbnQ6IFRodXJzZGF5LCBGZWJydWFyeSAxLCAyMDI0
IDQ6NTIgUE0NCj4gVG86IENhcmxvcyBTb25nIDxjYXJsb3Muc29uZ0BueHAuY29tPg0KPiBDYzog
RnJhbmNlc2NvIERvbGNpbmkgPGZyYW5jZXNjb0Bkb2xjaW5pLml0PjsgYnJvb25pZUBrZXJuZWwu
b3JnOw0KPiBzaGF3bmd1b0BrZXJuZWwub3JnOyBzLmhhdWVyQHBlbmd1dHJvbml4LmRlOyBrZXJu
ZWxAcGVuZ3V0cm9uaXguZGU7DQo+IGRsLWxpbnV4LWlteCA8bGludXgtaW14QG54cC5jb20+OyBi
ZW5qYW1pbkBiaWdsZXIub25lOw0KPiBzdGVmYW5tb3JpbmdAZ21haWwuY29tOyBsaW51eC1zcGlA
dmdlci5rZXJuZWwub3JnOw0KPiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7
IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogW0VYVF0gUmU6IFtQQVRD
SCB2Ml0gc3BpOiBpbXg6IGZpeCB0aGUgYnVyc3QgbGVuZ3RoIGF0IERNQSBtb2RlIGFuZCBDUFUN
Cj4gbW9kZQ0KPiANCj4gQ2F1dGlvbjogVGhpcyBpcyBhbiBleHRlcm5hbCBlbWFpbC4gUGxlYXNl
IHRha2UgY2FyZSB3aGVuIGNsaWNraW5nIGxpbmtzIG9yIG9wZW5pbmcNCj4gYXR0YWNobWVudHMu
IFdoZW4gaW4gZG91YnQsIHJlcG9ydCB0aGUgbWVzc2FnZSB1c2luZyB0aGUgJ1JlcG9ydCB0aGlz
IGVtYWlsJw0KPiBidXR0b24NCj4gDQo+IA0KPiBPbiBUaHUsIEZlYiAwMSwgMjAyNCBhdCAwMjow
MjozNkFNICswMDAwLCBDYXJsb3MgU29uZyB3cm90ZToNCj4gPiA+IEZyb206IEZyYW5jZXNjbyBE
b2xjaW5pIDxmcmFuY2VzY29AZG9sY2luaS5pdD4gQWRkICNpbmNsdWRlDQo+ID4gPiA8bGludXgv
Yml0cy5oPiBnaXZlbiB5b3UgYXJlIHVzaW5nIEJJVFNfUEVSX0JZVEUNCj4gPiA+DQo+ID4gSSBm
b3VuZCB0aGF0IDxsaW51eC9wcm9wZXJ0eS5oPiBoYXMgYmVlbiBpbmNsdWRlZCBpbiBzcGktaW14
LmMgZHJpdmVyLg0KPiA+IEFuZCA8bGludXgvYml0cy5oPiBoYXMgYmVlbiBpbmNsdWRlZCBpbiA8
bGludXgvcHJvcGVydHkuaD4uDQo+ID4gU28gSSBkaWRuJ3QgYWRkIHRoZSAiI2luY2x1ZGUgPGxp
bnV4L2JpdHMuaD4iIG9uIHB1cnBvc2UuDQo+IA0KPiBJIHRoaW5rIHlvdSBzaG91bGQgYmUgZXhw
bGljaXQgYW5kIGluY2x1ZGUgdGhpcyBoZWFkZXIuDQo+IENvZGUgZ2V0IHJlZmFjdG9yZWQgYWxs
IHRoZSB0aW1lIGFuZCB5b3UgY2FuIHByZXZlbnQgaXNzdWVzIHRoaXMgd2F5Lg0KPiANCkhpo6wN
ClRoYW5rIHlvdSEgVGhpcyBpcyBhY2NlcHRhYmxlLCBJIHdpbGwgaW5jbHVkZSA8bGludXgvYml0
cy5oPiBleHBsaWNpdGx5IGFuZCBzZW5kIFYzLg0KDQpCUg0KQ2FybG9zDQoNCj4gRnJhbmNlc2Nv
DQo+IA0KDQo=

