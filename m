Return-Path: <linux-kernel+bounces-138332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 719E689EFE3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 12:33:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0E141F2311C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 10:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF556159216;
	Wed, 10 Apr 2024 10:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Idv94gBr"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2104.outbound.protection.outlook.com [40.107.6.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99F941C89;
	Wed, 10 Apr 2024 10:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712745205; cv=fail; b=XQgV0Twsn/CaXDBbik289sELYoCt6gW3eUhFGVmtQR/FSsmvi932gUOsg9I+qhUnZIBDfUNX4NIAU9VtCGigwvcvuXgFrY+FAM9faj88RvAhIrtXobeFx3FypbHiW661HtTIUOeywN2dQmvQRVrjZSQhCP9UdqgJORhjbnPdabo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712745205; c=relaxed/simple;
	bh=nwugw4ZwgEbZKRqRBvT33URlqjo0DNBC2aBdryiHG4c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=r01b6FdQq5fjUsYi7Ucz+cTRuTe0aUQrwEVesEFwraM5GbdyvaKr4LpDgZhJNPPBjXb7T2lK3hXluNd3TkE0fLSboKrYba8ETypK4ChLIOiY63RlxJxQicsBnOKp3JCJdbjr1EUDbHOW7nx7V3/WZ7mV+dtXB+Ww2u76ec18/js=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Idv94gBr; arc=fail smtp.client-ip=40.107.6.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f9GkLBQhJpME6ElGuAJg/BuNhN/r4TglbVATz8YmPA99q2+ObMr1GyApshunY4NNDsaXmlZD7C0kOpflAres9H3JA82WQQnjrr78AjWr+znpf3mXknm8pFGQEzxTtYHN3C/QoNoUgGufP2Np6RQydwINDHtdR7v0i9tw5ctAwmNcBEFk8VdGp/tkOh+BfsPaCHY3qSliTvjRHfWIssC/o6uQgtiRJUQFtG7Q0cqgDgnhWo+S52uhIStUZwjQX8W4A6K8oUOCY/S6rXKevnlgn7NNEcY3RyirqrvM664hfzQGVUwe+coSNbAapL+ycvgYMRSKt16kSI6HhHCcylJCfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nwugw4ZwgEbZKRqRBvT33URlqjo0DNBC2aBdryiHG4c=;
 b=PPZjCI2XG58ROwFW/YsG0apu27e3dsgMpnms+SUmSHKzkFJ89UiC19L5SDEXRKfvLRRWU3fbZf3p0LV9YWeEp5GNbtwnO3HQBRLXUTrRLansFrz3D8Qz6/ymUqPHFNSEF/o3LJAgEUKAXZYKu+tkOyT8+MgKYkdRNtYm8r0BXkvN6jtPMLhtt8ug4Ky+4fet6KZp0PLvJ1emwTrwxpG9xqBRCv8sQc9xcdMDcGVVs9HtCtocGcE+Hdi9N1RtfaRLSIxEoA50h7vm4fMQ6PvIGSrPpanrmaSA3+xTcc9aPZeOJWboTdmXOT1MfXtB34v9WUTrMcEwPFFdJwfLnqjMSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nwugw4ZwgEbZKRqRBvT33URlqjo0DNBC2aBdryiHG4c=;
 b=Idv94gBrNc7tgknZju2kGBjVEGccKCyCvPLgS5bAoJvvCPqAKmrmsS74LmEpPA9nvA41zwKqexi2ocVSk5ILvh/WhabHBbh/tqThWVIrolgku8HEjvklNRqghqflGlZoYl5phSMKsQH3dM2RO6hSW10VEPG4Q58DjM0ctEwNz1M=
Received: from DU0PR04MB9636.eurprd04.prod.outlook.com (2603:10a6:10:320::21)
 by AM8PR04MB7428.eurprd04.prod.outlook.com (2603:10a6:20b:1d5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 10 Apr
 2024 10:33:20 +0000
Received: from DU0PR04MB9636.eurprd04.prod.outlook.com
 ([fe80::fa84:b970:e920:615a]) by DU0PR04MB9636.eurprd04.prod.outlook.com
 ([fe80::fa84:b970:e920:615a%5]) with mapi id 15.20.7409.046; Wed, 10 Apr 2024
 10:33:20 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: Johannes Berg <johannes@sipsolutions.net>, Brian Norris
	<briannorris@chromium.org>
CC: Francesco Dolcini <francesco@dolcini.it>, "kvalo@kernel.org"
	<kvalo@kernel.org>, "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Pete Hsieh <tsung-hsien.hsieh@nxp.com>,
	rafael.beims <rafael.beims@toradex.com>, Francesco Dolcini
	<francesco.dolcini@toradex.com>
Subject: RE: [EXT] Re: [PATCH v9 0/2] wifi: mwifiex: add code to support host
 mlme
Thread-Topic: [EXT] Re: [PATCH v9 0/2] wifi: mwifiex: add code to support host
 mlme
Thread-Index:
 AQHab2onJLj7by1TDUGmc5gbcJq9YLE4nU6AgAD7hoCABXXFAIAA1QEAgAAD/+CAAIccgIAA07QAgABoFOCAAvNSAIAEIpWAgAXgVOCABsmkAIAL6AowgAAHoQCAACsP0A==
Date: Wed, 10 Apr 2024 10:33:20 +0000
Message-ID:
 <DU0PR04MB96366A0E1FEBD7440F7536D0D1062@DU0PR04MB9636.eurprd04.prod.outlook.com>
References: <ZfTspRKFgrO9xCTH@google.com>
	 <969e95ccc4a1d35b45212b7fcb536ee90995e3b5.camel@sipsolutions.net>
	 <PA4PR04MB9638D253189D6DD330B198B2D1332@PA4PR04MB9638.eurprd04.prod.outlook.com>
	 <PA4PR04MB9638BE73DDBCE1CE8AA32BA8D1332@PA4PR04MB9638.eurprd04.prod.outlook.com>
	 <b2d9a7ef53c5ab4212617e8edf202bbafe52e2f8.camel@sipsolutions.net>
	 <ZftaJEIeNfV7YrVo@google.com>
	 <PA4PR04MB9638F5037D1AB9BCF51CC9D9D1322@PA4PR04MB9638.eurprd04.prod.outlook.com>
	 <Zf4rDifM6bLuqpX2@google.com>
	 <4e5f3741819e457c5c79d825c6520cb9ee531b95.camel@sipsolutions.net>
	 <PA4PR04MB96386917877832602F221282D13A2@PA4PR04MB9638.eurprd04.prod.outlook.com>
	 <ZgxCngq_Rguc4qs8@google.com>
	 <DU0PR04MB96365F2B6AFD856655D6A66CD1062@DU0PR04MB9636.eurprd04.prod.outlook.com>
 <5cf6b243c3967cd5a630f8f8e5bf17f7c9010f01.camel@sipsolutions.net>
In-Reply-To: <5cf6b243c3967cd5a630f8f8e5bf17f7c9010f01.camel@sipsolutions.net>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9636:EE_|AM8PR04MB7428:EE_
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 5gqnUkK8VRiJF9d1fyi68UFXr0DISzjG+3NfW6MQAiuC4hj06QFCWWAvmwH6iAMI96vKiQQN6frQi9Ssa9b7ZgVisPXoGaiSUrUPQCwB78x+GtEdzVG0iw9/nSZnuUMVGomA3ihojh3VZqFXjg3pt1vY4u5KLIydgGKxSWxUwsSn99rjDg7Zfvq2pRnri0elXlxTLz+9/HKD1nfT80/7v5wZdJ+DXRH1GJGh8TBNaLlDGIDOsPXtID1Nklju+9KqQ3aMJAaX4RvjFJpEf28sX9odC3fsJshKfrIEd8HhrzVqUCLN1e2N/sUc3/3KNImD0vyNeqakvUdzigdLL3sm2eworO3s2uj22r1KPs5C2azBXgO0EIvyVmp5gMieLxzyjQffD6ypsqMza9WtrAJYjgsIxkU141vg/3jKGN4seEXHJc1yFcqVPBQPCSso/OEWtwnhRqWZdYboxSZY2CXw2muixg06F1TCor/PSr3UET97YjzUsDsQqzQb6oRkNVxFXUpTTwtNol5r2J+Rxq+XGDiEjKWSly8yu/u7mGyNhxdTkxnnSZcNUMyoNG0rA3XAQdKF8ah6EtH62OQzTKbG1QcdRtUMryyZNswL1P8LQE3qk2Z4PUuTQD0DYZpTtq/MOo6rP3BLdvQAcF8doGYH58lJD6Kspqd9j4FQ6SSahu4=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9636.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZFRBNTlDWk1TQmxrN2lKWVJwR2N3QWRuMDFPNEdIdWtZcEJ0WGo5NVlkem1R?=
 =?utf-8?B?UXU5eHZ2TVhjYXBuSXRZcVhSYlJPaFhhWFowcWhWVWVYbW1EKzk2dUx5ZHBp?=
 =?utf-8?B?eGdIU040a0hXQW9SNktINmVtZGNZTHRBb3dkVENyYjYyWUp5cnE2azM4OFBp?=
 =?utf-8?B?THQrMHArak4zam1Rc0RtOW1lb0E0d0JiODRLYUZac1lTb0FMK2dzdzB4aEtM?=
 =?utf-8?B?OVNVZ09iQURLNU5IMDJlN3ZMUXR3L3pyZmlzV2E0eUpTRXl4dDhtakNLbEIz?=
 =?utf-8?B?bitVNWQ4Z1I0RzZySSs5M1VzV3dUTVJuWEt3TDI5QVpLTFZYcWQ3ZlQ4S0Iz?=
 =?utf-8?B?eTI2SklNWUZFamNRQnBKVjZnVFcxSzVTa1EwUUxoVk9mZUZDL3dMUE9mWkgx?=
 =?utf-8?B?RjRFeTBhbDY1REVaeHRadFdhVTlhUVA4V01xelRmRlJ5M1NCNnBpSU0xYmRh?=
 =?utf-8?B?QzNxN2loNjNhajFPZnpOR0Y3TjNwRThiZmJZK2JEMy9rZ1FlMTQ5SFI5TTVI?=
 =?utf-8?B?YmQvWXNkQzdhcU03TVNNTEZ5aCtlUTBjTmtYMThUbjAwRmgvZnRrMVpsUDZW?=
 =?utf-8?B?c0w3bnZOR3c0aXRsVUlMNmhyazZ6RCsreUtZcEJzTWZ0cnlkNkQ5bC9laXcx?=
 =?utf-8?B?V1AycmJRWHlsZ1dRUjNiRjN2dnBWWGdSLytuUUkwRW9EVmJaMk9IQnpCVUJi?=
 =?utf-8?B?N2pZcGFiTEg4UHF4dlBtQWJIZVdZM1Exb1FRTXFvMWZwUkNHaDJUdkdQaG9V?=
 =?utf-8?B?cjJ1NTQ2NHlKa0p6L21nRXJzWjQyalk1SUZYaEFLbHB5enp3K3dSTEhwTlZ5?=
 =?utf-8?B?VFJNcWRBNUhRdTZ0TENTY3laR25uUGs1bEpaTzZuMDgrZ2hxRzBLNVBmOHJx?=
 =?utf-8?B?OUJLenNRM2NqQmZ4WXc3Rm1LaXp3WDVwQU1kU2g5WDBYYitRb1ZIdVJDZkdR?=
 =?utf-8?B?QTU4YVlXWFYrRERUTVNXOEZnOGpoUFlNclVqRWo2YmdRZHJISXZ2bE93SE9P?=
 =?utf-8?B?VldETzVGbWtvQkF4UStkd2dXdjF3dHU4VzR4WjBjeDU0bUE2RzJ2M01VQUxZ?=
 =?utf-8?B?bjBTMDNUQ2tQYXgvdW5wMUkwUkg4Wk9NRnBVeGlGcGVHdHhuamtZM1V5VHRs?=
 =?utf-8?B?ajFrM3NFVzFIUGlwRythNjlhK1A3OXQ1aGdBNHJGdzJOa3cvYWNEeHE5TWE3?=
 =?utf-8?B?T1hJeVg4K0tTcUZqc1A5c2NzRzBHamtNL0dyaERRN2ZVVkdmOXB6YWpsQ3c2?=
 =?utf-8?B?UGFZdUM3V1dCOVRWTnNqWGU2Y1N2ekF2bEVTcUNXSnNnVEJBMzltak9iUGwz?=
 =?utf-8?B?NHVMM2g5Vi9lcFd1SGdPMFJTcjFSL2RLVUJTNHFwNUNrbi9IYndxZzlONmw4?=
 =?utf-8?B?MjVBajRBdzBjeDBvKzdGK0lvV3FzemhYeGJIeTJ6NkRhTUx4b0J2Y2I5aHMz?=
 =?utf-8?B?Sm05SEcydzZaZHRPREtSalc1Vk9BazJZQVdKbjU5cnh6Ukd5bDJHQ2dIYkJO?=
 =?utf-8?B?d3FMVHhMam42dUZWZmtRdmVMMVNZTmIrK3FpckpxTUlSbjdIZkFWcVM2TWQ0?=
 =?utf-8?B?b2RGa0VOWE5LNzhRdlVhaTFGZFp2anl3NjRUQUxyZTk5QnhjNzJIdGJ5R1Vl?=
 =?utf-8?B?dW5JdDFaSGlub3FUSmRtK1MvZFVOb3NxNHRmQkk5R2RCVXlHT0t2ak9UZHZ2?=
 =?utf-8?B?cmxIMFg1dXFhakJhdnQ4azhFQVZPbzkzTzkxT1JHSjdGa2xpSk5BMll1L0F3?=
 =?utf-8?B?YUx0T1dDQ1hTbWVVTHM1RnRPc2FqVnpCakFDRGpWTDh4WHE4L21kK3c5VCtt?=
 =?utf-8?B?dHB0SmovS0xrQUprVWVqd05lYzdwVVZkQ2JPV2NsVWNxMFZsSklFeE5QUGov?=
 =?utf-8?B?OHZCV2U0NEhERFU0cWJSNmFnbzl6dGw4cWtjRVB4cWFPU1BZdUpFTHh0ZnFV?=
 =?utf-8?B?cTlQT1BjOGZldEROK1UxWXBLcjlYSDBVbzJUS3d2NmNIaFF2UEM0MitqUmNa?=
 =?utf-8?B?SnZtVnF1WS9BY1lwK09rSm82aGZaNVBqU2VEdWxMakpZbXlLODkxMlZ0V0M2?=
 =?utf-8?B?bmFGTGhJcit5QWF6YzB6RXFjZlk3a1BOR3hqMlp0WVY4VnF5cmp0cUF6MzQ1?=
 =?utf-8?Q?jcSj0KhhtupvEVHKDb1YEd8va?=
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
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9636.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63770be3-7f74-422c-a142-08dc5949a44e
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2024 10:33:20.3436
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GO2tAnw+jLwK7tCD2DjM5n1/0VENcQ4WwA/f6t08miWoJQBbqlnkCVwZ9Oia5ZLDwKXWdWpmO+vax2HO0pyFVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7428

PiBGcm9tOiBKb2hhbm5lcyBCZXJnIDxqb2hhbm5lc0BzaXBzb2x1dGlvbnMubmV0Pg0KPiBTZW50
OiBXZWRuZXNkYXksIEFwcmlsIDEwLCAyMDI0IDM6NTUgUE0NCj4gVG86IERhdmlkIExpbiA8eXUt
aGFvLmxpbkBueHAuY29tPjsgQnJpYW4gTm9ycmlzDQo+IDxicmlhbm5vcnJpc0BjaHJvbWl1bS5v
cmc+DQo+IENjOiBGcmFuY2VzY28gRG9sY2luaSA8ZnJhbmNlc2NvQGRvbGNpbmkuaXQ+OyBrdmFs
b0BrZXJuZWwub3JnOw0KPiBsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtl
cm5lbEB2Z2VyLmtlcm5lbC5vcmc7IFBldGUgSHNpZWgNCj4gPHRzdW5nLWhzaWVuLmhzaWVoQG54
cC5jb20+OyByYWZhZWwuYmVpbXMgPHJhZmFlbC5iZWltc0B0b3JhZGV4LmNvbT47DQo+IEZyYW5j
ZXNjbyBEb2xjaW5pIDxmcmFuY2VzY28uZG9sY2luaUB0b3JhZGV4LmNvbT4NCj4gU3ViamVjdDog
UmU6IFtFWFRdIFJlOiBbUEFUQ0ggdjkgMC8yXSB3aWZpOiBtd2lmaWV4OiBhZGQgY29kZSB0byBz
dXBwb3J0IGhvc3QNCj4gbWxtZQ0KPiANCj4gT24gV2VkLCAyMDI0LTA0LTEwIGF0IDA3OjMwICsw
MDAwLCBEYXZpZCBMaW4gd3JvdGU6DQo+ID4gSGkgSm9oYW5uZXMgYW5kIEJyaWFuLA0KPiA+DQo+
ID4gICAgIEkgdGhpbmsgdGhpcyBwYXRjaCBpcyB1c2VkIHRvIGxldmVyYWdlIE1MTUUgb2Ygd3Bh
X3N1cHBsaWNhbnQgYW5kDQo+IGhvc3RhcGQuIEl0IHdvbid0IGFmZmVjdCB0aGUgdXNhZ2Ugb2Yg
Y2ZnODAyMTEgZm9yIG13aWZpZXguIEkgd29uZGVyIGlmIEkgY2FuDQo+IHByZXBhcmUgcGF0Y2gg
djEwLg0KPiANCj4gTm8uIFRoYXQgc2VudGVuY2UgdGVsbHMgbWUgeW91J3ZlIF9zdGlsbF8gbm90
IHVuZGVyc3Rvb2QgYW55IG9mIHRoZSB0ZWNobmljYWwNCj4gYXJndW1lbnRzIGluIHRoZSB0aHJl
YWQsIHlvdSdyZSBfc3RpbGxfIGFyZ3Vpbmcgd2l0aCBjb21wbGV0ZWx5IHVuaW50ZXJlc3RpbmcN
Cj4gYXJndW1lbnRzLiBXaGVyZSBiZWZvcmUgeW91IGhhZCAiaXQncyB3ZWxsIHRlc3RlZCIgYW5k
ICJpdCB1c2VzICdzdGFuZGFyZCcNCj4gQVBJcyIgbm93IHlvdSdyZSBzYXlpbmcgIml0IGRvZXNu
J3QgYWZmZWN0IGFueW9uZSBlbHNlIi4gQWxsIG9mIHRoYXQgaXMgb2J2aW91cywNCj4gYW5kIGFs
c28gY29tcGxldGVseSBiZXNpZGVzIHRoZSBwb2ludC4NCj4gDQo+IFBsZWFzZSBnbyBiYWNrIGFu
ZCBhY3R1YWxseSBfdW5kZXJzdGFuZF8gdGhlIGRpc2N1c3Npb24uIEFsc28gYWN0dWFsbHkNCj4g
X3BhcnRpY2lwYXRlXyBpbiB0aGUgZGlzY3Vzc2lvbiB0b28sIHNvIGZhciB5b3UndmUgcHJldHR5
IG11Y2ggb25seSBtYWRlIGVtcHR5DQo+IGFyZ3VtZW50cy4gT25jZSB5b3UndmUgdW5kZXJzdG9v
ZCB0aGUgY29uY2VybnMgYW5kIGNhbiBleHBsYWluIHdoeSB0aGV5DQo+IGRvbid0IGFwcGx5LCBf
dGhlbl8geW91IGNhbiByZXNlbmQgdGhlIHBhdGNoLg0KPiANCj4gam9oYW5uZXMNCg0KVGFrZSBS
eCBkYXRhIHBhdGggYXMgYW4gZXhhbXBsZSwNCkluIGN1cnJlbnQgRlcsIEJBIHN0cmVhbSBzZXR1
cCBhbmQgZGUtYW1wZHUgYXJlIGhhbmRsZWQgaW4gRlcuIFBhY2tldCBpcyBjb252ZXJ0ZWQgdG8g
ODAyLjMgYmVmb3JlIHBhc3NpbmcgdG8gaG9zdC4gQW1wZHUgcmVvcmRlcmluZyBpcyBoYW5kbGVk
IGluIGhvc3QgZHJpdmVyIChNd2lmaWV4KSBkdWUgdG8gbWVtb3J5IGNvbnNpZGVyYXRpb24uIFdl
IHVzZWQgdG8gd29yayBvbiBhIGRyaXZlciB0aGF0IHVzZXMgUlhfRkxBR184MDIzLiBJdCB3YXMg
b24gYW4gb2xkZXIgV2ktRmkgcGFydCB3aGljaCBoYXMgbW9yZSBtZW1vcnkgYW5kIHBvd2VyZnVs
IHByb2Nlc3Nvci4gQnV0IHdpdGggdGhpcyBjaGlwIGJ1ZmZlciByZXF1aXJlZCBmb3IgcmVvcmRl
cmluZyBkb2VzbuKAmXQgZml0IEZXIG1lbW9yeS4gDQoNCkFtcGR1IHJlb3JkZXJpbmcgbmVlZHMg
TUFDIDgwMi4xMSBoZWFkZXIsIEZXIGtlZXBzIHRoZSBNQUMgaGVhZGVyIGluIHBhY2tldCBkZXNj
cmlwdG9yIHNpbmNlIHBhY2tldCBhbHJlYWR5IDgwMi4zIHdoZW4gYXJyaXZlIGF0IGRyaXZlci4g
QXMgcGFja2V0IGRlc2NyaXB0b3Igb25seSBhY2Nlc3NpYmxlIGluIHRoZSBkcml2ZXIsIE13aWZp
ZXggaGFuZGxlcyB0aGUgcmVvcmRlcmluZyBpbnN0ZWFkIG9mIHVzaW5nIG1hYzgwMjExIHJlb3Jk
ZXJpbmcuIA0KDQpXaXRoIGN1cnJlbnQgRlcgZGVzaWduLCB0byBhcHBseSBtYWM4MDIuMTEgd2Ug
ZWl0aGVyIGNoYW5nZSBGVyB0byBwYXNzIHBhY2tldCBpbiA4MDIuMTEgZm9ybWF0IG9yIGRyaXZl
ciBuZWVkcyB0byBkbyB0aGUgY29udmVyc2lvbiBiYWNrIHRvIDgwMi4xMSAod2hpY2ggSSB0aGlu
ayBkb2VzbuKAmXQgbWFrZSBzZW5zZSkgDQoNCkdpdmVuIGV4aXN0aW5nIEZXIGRlc2lnbiwgd2Ug
dGhpbmsgaXTigJlzIGRpZmZpY3VsdCB0byBhcHBseSBtYWM4MDIxMS4gSG9wZSB0aGlzIG1ha2Ug
dmFsaWQgYXJndW1lbnRzLg0KDQpEYXZpZA0K

