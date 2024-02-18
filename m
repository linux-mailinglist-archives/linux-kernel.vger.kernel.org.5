Return-Path: <linux-kernel+bounces-70239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61FCA859521
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 07:50:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE5EB282A1E
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 06:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA710EEB7;
	Sun, 18 Feb 2024 06:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Q+H0K7Rq"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2042.outbound.protection.outlook.com [40.107.22.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2191CF98;
	Sun, 18 Feb 2024 06:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708238920; cv=fail; b=SSz767+b8mOfrVkD2r3JjmkcXxZaXaaKhPX+npLeRWVaPFpmIPDp9kobqO6y/C2zcCEe1TTSgfb0a/1al1ELH6rSTro25Aad4FEMpi3Jrky+Erw+Gb0dVjDlNnQnOZZTkTdhUFmj42DAUMzlThtEExiTB/d/LOPAtNJIzh5sDH0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708238920; c=relaxed/simple;
	bh=9OAwHKHrVsCKUehSe9C0aoFr66MxDzzQt5tMmuzJgP4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FA0PelAWfniVnUfGnD0ibjUclUIh2kzTyQyUhoowUZbXnfQimYdH6tokobwVq/Mmhy5WV5xknxEImxWEfTjlXeLej5IJfGwAV8YSVCnV/94nd3R8awmTwAedLTSBDukUbvCvaEDBfJnpYoYVUo8r70kaH/d9cc7CWvliXgO1Q1E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Q+H0K7Rq; arc=fail smtp.client-ip=40.107.22.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HJP52ZNx1znoYv2QpP/qKYiqaNj+yUPCCMlKMilolNN8h2MvgZWBhbU1NPvm+cg/ltWrg2uvMdzKlgX1oSGCEiyxYznmMjzPpCJeUlc+jyIPA6rAus6WmzW7S/D99P8p/DqVBUSP2/cY3JMLQefK+F3DMsF2xviWgEXsHKWQSqcmz4fN9Vm/VHGMJVbDCXoO25OJkpo4V2j5dELsEIhak4M7pIqdZiLbRYHIbqX8FyyIVVT5ka35aPIIEcFEuvQB+h8Ukde5DbM0+JD3ScL9lXbPgxgGVm4MDc5ZOcaONgY+K9BLa4TrZaV0IAv784Byh4zPC/7yQrH1FIoSN6YAfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9OAwHKHrVsCKUehSe9C0aoFr66MxDzzQt5tMmuzJgP4=;
 b=WXMYywOgb8w3c7WYumo10hN2mKDl/KySkq3f10SLeP38liHQoICorPUA5DrIkBWwLYyVTL8d3sGyC6rBTuCLHj7CwUXlwJwpysyD2wR+T+5udCyD0iDgfdAk1eyugI6HA92toLrgER/1ZI3gp2sTq/pxeoxvB22b6nu3wiaL9pgjo6jrbHHxpDhLW9erCAbnNs7oUPtsgt8Gj1cbIcVdrtC6Raslf5y7tFF82cShcIdn7oHblJIw0gz4ARg9wrUH86/2byEETOpKvlK6eM+qeGBTIOxZwppe9tjZzBnlS59SaEK7XyFSO3ILMB0qytRybIlkVDAg9ZoZ05coHrZi6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9OAwHKHrVsCKUehSe9C0aoFr66MxDzzQt5tMmuzJgP4=;
 b=Q+H0K7RqD2Tf0aD9X45edNZCu/vEFP2T/IPclcdVgzRm5CkP4q45940sxybTYvVrCdhamKFAzoO9PasIzjZodDhCwBVOrBzJr/dlAW8X7Kdr5V0znuE14fpGLLfGp7fzUkMa8mEyifzL+Ckl+IkOvoIRlaUDek8ZCopETbhV1Uk=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DBBPR04MB8011.eurprd04.prod.outlook.com (2603:10a6:10:1ec::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.31; Sun, 18 Feb
 2024 06:48:36 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::4ac3:3559:4200:38e1]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::4ac3:3559:4200:38e1%4]) with mapi id 15.20.7292.033; Sun, 18 Feb 2024
 06:48:36 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Jassi Brar <jassisinghbrar@gmail.com>
CC: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
	<conor+dt@kernel.org>, Aisheng Dong <aisheng.dong@nxp.com>, Shawn Guo
	<shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
	dl-linux-imx <linux-imx@nxp.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, Conor Dooley
	<conor.dooley@microchip.com>
Subject: RE: [PATCH v6 0/4] mailbox: imx: support i.MX95 ELE/V2X MU
Thread-Topic: [PATCH v6 0/4] mailbox: imx: support i.MX95 ELE/V2X MU
Thread-Index: AQHaVJw3fd3lG9k4w0GdiaKSDUAWyLEPbOxAgAAIQQCAAABZIIAAEV4AgAA5EKA=
Date: Sun, 18 Feb 2024 06:48:36 +0000
Message-ID:
 <DU0PR04MB94173DAFBB30F61807396DB088522@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20240201-imx-mailbox-v6-0-76f4f35b403e@nxp.com>
 <PA4PR04MB941646795F4E19D1EC35134F88522@PA4PR04MB9416.eurprd04.prod.outlook.com>
 <CABb+yY0aM9Dn3LPBqb11vU3Ln4bCCGOBXX77sF499cyb_sXiUA@mail.gmail.com>
 <DU0PR04MB94170454D64EF65E6774BEAB88522@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <CABb+yY3U5GzvznLDU7pyA1ppfLT50MQKQ3YRXB3rYwr_QwcH-g@mail.gmail.com>
In-Reply-To:
 <CABb+yY3U5GzvznLDU7pyA1ppfLT50MQKQ3YRXB3rYwr_QwcH-g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|DBBPR04MB8011:EE_
x-ms-office365-filtering-correlation-id: 45079f11-9818-40bf-3a69-08dc304da1a8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 SQl8t5R8B+QC6Ka/zOm8O5tHw6oVoclRVZgJ+/FPmoaLco3KGDxeDIvHm+O7I1X0dGW5Ihm/wDRihi++jj7nuNNWpqn6cUAPAQeIToy/IgkKkCdWIRdctAgFBgRa+4TAweX2cCr2CJW5MTtyqdK/QQeCWAb/kAJR2iZwTilU52zhX5YOIbMXNDOQgSdSM3T8QLJKyykvHyHYJ0vbzttEZ724azyh2BmdjPGVY4ZqEiiG9hXVBDuqUp/mgy6cjnYDmNSGGurOqEYOGvOwvmMWtpfBInY0GLmasE2MFpoCxa973H2G7cns8yizSz5QXEAyW9qYQvNlTDv2xTuDuvl/n3RNXsjiaEYn+YbfPIKI7ClUNjUTPyX0UzVcMiVFA/MUzj30uJBk8XJkZzVCq4QNP2K6QrdYYiVYgFHLorfezAUoLIgehXRCVbgHhc8SgdvTkHKVEtBzxO2de1y4mwE8JOO4JJ4Jd9KLOPr6CG1GhmPmK2tnceX8hoWe4nrJ2I4aBke45P/lT8iOycSwq3QIcYvukkS+J8rA2u/FSf3DnVDopjOP4m+RoHg7Oc0zgrCHtvDQ4Wghhj7PvASTcvOHJlaxVRA/8xa8QoHYNp2n7/l4+gvZTdjzLwibukDD4tJ4
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(136003)(346002)(376002)(396003)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(55016003)(5660300002)(66946007)(15650500001)(76116006)(4326008)(44832011)(64756008)(2906002)(52536014)(8936002)(7416002)(6916009)(8676002)(66476007)(66556008)(66446008)(33656002)(86362001)(122000001)(38070700009)(478600001)(71200400001)(83380400001)(9686003)(54906003)(53546011)(41300700001)(316002)(6506007)(26005)(7696005)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?N0t4emRiNEc4WFAwWEdvRVY0eUtpUGlrdXFJaXVJUUFkbVk2TGdMWGtqNU9Z?=
 =?utf-8?B?K0VFOXMzZW9uOFdRWmpDaUhYZUZBaldHN3Q3TG5QUFNRU2Npdmx4YTdOS2FQ?=
 =?utf-8?B?WE5aZml1UlhRVlVZVzFVVU5uWDZkaTFKdGp3eUtXczFRSDk3RVJvOFNObEFX?=
 =?utf-8?B?c1A1OEF5ZTluY1FmL3VrZ1ZHemlrNjRaWHNmQ241Vk9HOVZhbXc2OW1BeG8v?=
 =?utf-8?B?cFRlZmNlcTNLTDlZVGxzekI4YWtVT2trazByRkpZVEdKZGo4Z2N2RlFBNFRU?=
 =?utf-8?B?QjNuTXoraDZRVngwZ3JWMVhrNC9MNUpBTFB4M3VONXRyMDg2dWNTNVhzM1Fh?=
 =?utf-8?B?VS9EY282VUJLQlZZRnhyNVRtMmVXRjNva09ON3ozczhkU0hsVHloMjB4NWEv?=
 =?utf-8?B?ODJXaTFxZmxjZm9GbTkzNmsrY0FPMU9oc0YxQkcvNGVBNFI4bkxEMGpoU3p1?=
 =?utf-8?B?bWpDWnN4MG8xb2NRTkIvK2hXK0VRMFkyTEpvT1Yyay9NZGxzMnFnL20rVFFK?=
 =?utf-8?B?V2p2M3ZWSUNoYUJWVWh5ZGRWL3ExMWZPZzlIcDFDTnV1QXZHb3JsNGV6Ukpq?=
 =?utf-8?B?eXFGTjNhR3BwaUhEejZjdno0SUplUCszRDIvT0xPYm8xc2huUEVRQm91TUtS?=
 =?utf-8?B?dlhIZVVVNUtuSEc1WWtGY3VBNm9RWmI4dGpwb3pLNXlUdVRLQUtMRWFKR2Qv?=
 =?utf-8?B?RHBObkw0bkluUlZ6dFNtdmlUeHcrNUtQak9QOFJVZDBmMURIQnBoaHI0MmNq?=
 =?utf-8?B?YmVjT09CRzh5b0NBUnMwazM4bUlJR0JHL0RkSytUZFNzZXRrNkx5VGRQdnNS?=
 =?utf-8?B?N0hlTWpRL0JhSk1zYzQ3QXRYbTRlVWM1MHZZR2RJcXhhTjhxYmdaM2pQM3Rz?=
 =?utf-8?B?cTZ3TTcwa1NkUldtL0wrTHdic3BZTFFORklSQ0tUVnRvbFJEaDZ6aDU1NDFp?=
 =?utf-8?B?aEQ4NUNHZlo2V3N1NEJEN1ZxWkw3Qmo1eURhSm1TSU8zNzdsdTFjekk5eC96?=
 =?utf-8?B?OW0xTVJFb2ZoSjQ2ZWJyQ3JTUXdSNU03RE95V1pETEhNWTBEcTZrWHBjTnFW?=
 =?utf-8?B?b2hZVkQ5MDJZSU5JV3VNT1JYaWJHeUJEUm5RL3VrWkJoM2l5Ni91L0ZWNE5u?=
 =?utf-8?B?V2xoaGZndVlsbDg2QVFjajBXRW5wMXJvK0IrZWhrblVIa2NxbUR3Wmswb0Fn?=
 =?utf-8?B?QnVjUU9ub0lCbXdCTFhMcjV0NkQ2WDkrMlJKT2kvRGF1RmRlbEwvUURjMWky?=
 =?utf-8?B?VXdIWmRnQU81emd4SkhwSnFTd2RBblRsR3BtT0N6eklqWU44VmdIbS9YVFBx?=
 =?utf-8?B?ODM0bFpjOWFXUElmdEFrSjNYY20rOEJpcHE5em9adjhCUE1TSjErMzgrOU1N?=
 =?utf-8?B?aW0vS1J4cm1EOFNreVBWSExaRnlCcFdZaVlreUIyYWF0dytBbkZIR0ZsTHJV?=
 =?utf-8?B?bHZKWEVBZERQSXJLOWpuWlJEc1UrQkFCNVU2SWdEc2tNdjJKSjM3QzBaeDVX?=
 =?utf-8?B?b2xLc1lGa0N1YUM2THRjZ1Y2cVUzM3R2MTN5TmNyWEZSd1k5T0ZzSW40TG5i?=
 =?utf-8?B?QU1zUzNXSTBTd3orOVkxMUYzaDluS0xMdkZiUlUyb3Q1OVVnVTR6ZTFuMDZu?=
 =?utf-8?B?eUQ5NnZid1ByWmhySXNpdEVPREQvbi90UklVck9LMmhBcDBFL1JNYWFrRlJU?=
 =?utf-8?B?UjdOOGZIZzlMVTJnZ1BQVWhYbFNVK0htellvajlFV1dNQllPYzcwRW9xQnk0?=
 =?utf-8?B?SlhDTkVWQ0o1MnlyRTlhQ25oY3pnTVNkVVQxSUtEMlZxbkc3Tis2T2VTemx1?=
 =?utf-8?B?MTZBOHlZUVJ1aG9iV1BscG5jYk10S0VZblV6Q3FyQkhjTGtONVU4RHdMcG9O?=
 =?utf-8?B?b2RsVjZna2ZZNG1pZW9QMExlcTdrdm5USDltZVhRU2J2Zm4xcGo1SEFITW1Y?=
 =?utf-8?B?UDZhUlRHN1BiaEtJb0IrdmhsM1hZemtxbnFyYjQ3STVHVDJRQS9FeWhyUVoy?=
 =?utf-8?B?STQydldSaUlLcjdvZ0NMK2tUUEJ0NEcvUVJFaVpRaGtjckVsdCtKTGVZQ2N6?=
 =?utf-8?B?b1ZFMFY0OERFb2dsUGd6SExxc0RhdEM2bXhmTzA2QTltZDk5ZHlFNnR2Qjd5?=
 =?utf-8?Q?XgZQ=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45079f11-9818-40bf-3a69-08dc304da1a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2024 06:48:36.2192
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rFu+GLmyWej/1Cq3kbr+mhhfdj8oSnSOSOAE1H2EsIVO8ZFnTEOURPBcK7FvLhMaEa5LG34WecGpW3E/ObI7Hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB8011

SGkgSmFzc2ksDQoNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NiAwLzRdIG1haWxib3g6IGlteDog
c3VwcG9ydCBpLk1YOTUgRUxFL1YyWCBNVQ0KPiANCj4gT24gU2F0LCBGZWIgMTcsIDIwMjQgYXQg
ODoxMOKAr1BNIFBlbmcgRmFuIDxwZW5nLmZhbkBueHAuY29tPiB3cm90ZToNCj4gPg0KPiA+IEhp
IEphc3NpLA0KPiA+DQo+ID4gPiBTdWJqZWN0OiBSZTogW1BBVENIIHY2IDAvNF0gbWFpbGJveDog
aW14OiBzdXBwb3J0IGkuTVg5NSBFTEUvVjJYIE1VDQo+ID4gPg0KPiA+ID4gSGkgUGVuZywNCj4g
PiA+DQo+ID4gPiBPbiBTYXQsIEZlYiAxNywgMjAyNCBhdCA3OjM44oCvUE0gUGVuZyBGYW4gPHBl
bmcuZmFuQG54cC5jb20+IHdyb3RlOg0KPiA+ID4gPg0KPiA+ID4gPiBIaSBKYXNzaQ0KPiA+ID4g
Pg0KPiA+ID4gPiA+IFN1YmplY3Q6IFtQQVRDSCB2NiAwLzRdIG1haWxib3g6IGlteDogc3VwcG9y
dCBpLk1YOTUgRUxFL1YyWCBNVQ0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gLSBBZGQgZHQtYmluZGlu
Z3MNCj4gPiA+ID4gPiAtIGkuTVg5NSBFTEUvVjJYIHVzZSBzYW1lIHJlZ2lzdGVyIGxheW91dCBh
cyBpLk1YOFVMUCBTNCBNVSwgYnV0DQo+ID4gPiA+ID4gICB0aGUgVFIvUlIgbnVtIGlzIGRpZmZl
cmVudC4gVG8gbWFrZSBjb2RlIHJldXNhYmxlIGFuZCBub3QgYWRkDQo+ID4gPiA+ID4gdG9vDQo+
ID4gPiBtdWNoDQo+ID4gPiA+ID4gICBtYWNyb3MsIGFkZCBydW50aW1lIGRldGVjdCBudW1iZXIg
b2YgVFIgYW5kIFJSIGJ5IHJlYWRpbmcNCj4gUEFSX09GRg0KPiA+ID4gPiA+ICAgcmVnaXN0ZXJz
Lg0KPiA+ID4gPiA+IC0gQWRkIGkuTVg5NSBFTEUvVjJYIE1VIGVudHJ5IGluIGRyaXZlcg0KPiA+
ID4gPg0KPiA+ID4gPiBQaW5nLi4NCj4gPiA+ID4NCj4gPiA+IGR0IGJpbmRpbmdzIGFuZCBjb21w
YXRpYmxlcyBmaXJzdCBuZWVkIHRvIGJlIGFja2VkIGJ5IGR0IG1haW50YWluZXJzLg0KPiA+DQo+
ID4gVGhlIGJpbmRpbmdzIGhhcyBiZWVuIHJldmlld2VkIGJ5IENvbm9yIERvb2xleSB3aG8gbGlz
dGVkIGFzIG1haW50YWluZXI6DQo+ID4gT1BFTiBGSVJNV0FSRSBBTkQgRkxBVFRFTkVEIERFVklD
RSBUUkVFIEJJTkRJTkdTDQo+ID4gTTogICAgICBSb2IgSGVycmluZyA8cm9iaCtkdEBrZXJuZWwu
b3JnPg0KPiA+IE06ICAgICAgS3J6eXN6dG9mIEtvemxvd3NraSA8a3J6eXN6dG9mLmtvemxvd3Nr
aStkdEBsaW5hcm8ub3JnPg0KPiA+IE06ICAgICAgQ29ub3IgRG9vbGV5IDxjb25vcitkdEBrZXJu
ZWwub3JnPg0KPiA+DQo+IE9rLCBJIGRpZG4ndCByZWFsaXNlIHdlIGhhdmUgdGhyZWUgbWFpbnRh
aW5lcnMgbm93Lg0KPiANCj4gSSBzZWUgbm8gcHJvYmxlbSBvdGhlciB0aGFuIGFkZGluZyBvZl9w
bGF0Zm9ybV9wb3B1bGF0ZSgpIGFuZCBjb21wYXRpYmxlcw0KPiBpbiB0aGUgc2FtZSBwYXRjaC4g
VGhleSBzaG91bGQgYmUgc2VwYXJhdGUuDQoNCkp1c3QgcG9zdGVkIG91dCBWNyB0byBhZGRyZXNz
IHRoaXMsIHBsZWFzZSBoYXZlIGEgbG9vay4NCg0KVGhhbmtzLA0KUGVuZy4NCg0KPiANCj4gY2hl
ZXJzLg0K

