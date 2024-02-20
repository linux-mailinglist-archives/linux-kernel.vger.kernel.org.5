Return-Path: <linux-kernel+bounces-72935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 282F085BADE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 12:46:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D3261C23EF8
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 11:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2232067C49;
	Tue, 20 Feb 2024 11:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Hgc1h2VY"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2068.outbound.protection.outlook.com [40.107.220.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D88F67A01;
	Tue, 20 Feb 2024 11:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708429556; cv=fail; b=FNeMCzB10U937IeVCDOOqKeN+U+F+Mq6P+V6VZS4hE1PkRKIlwCYNSS3v1fq+idcrLGhaEBMMcOnmSni8HArPTYBi6k773IMSUBXnaIMlDWfStStFIZoGWPTI/gHwM6QMiZ+9OMv5A7hIBkayCQJUjKHs7V0EL1UGI4zn617Tdk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708429556; c=relaxed/simple;
	bh=5Cfq8tMFDYALRpVo5o+yltuNUcFR5jP4c9+JXZNEJVA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EGpOdoBhmqA1PePbx20zpF341PFZ0+OxgoU+vPT8fW+9y6u2Al4t6IFUmWUUND+Lijf5xrDkymQIDPi30yri+zeu5P7dRLy5vkCZCecRsSO6D8TpnG39Z58vZBZSvO7P8pJyxBOSx8IGq4YebgozTT6YphtlnCrQXdirhtSI5KA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Hgc1h2VY; arc=fail smtp.client-ip=40.107.220.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W6UpnwbRka04nBaHPqRpwqx2EfdKsnL3zbozaAZSvH9bELFn7+qC5CvfeJL4vP0X6YiIrRmQMTLpcyzp7N1FPDvy8MYv/oDQpx1ssWgXM56aD+uj7947wM6pqz/e4Ax5vo6QU3gr4aCF4KXbOXa22aFfZzCoAlAhyZ12YeDPKlb+K5zjQhSkcAsY4B22FHUOPxcGTnA8dcSevEBHBvkHtNg5FBwRfGaBdd78DQOb7kL0VNrp0RPW15JNjJpWjxtjcUxgkYTphJTIYk68LQ3A6TJ5pRLxN6fCS7FXSwaOzLbgGkATw9NojEpkaz5A4r/N6bspaTnM4sIlPgnbUJxhJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Cfq8tMFDYALRpVo5o+yltuNUcFR5jP4c9+JXZNEJVA=;
 b=euj6IWDy7rbXEw90QuQ8SLu6D4GZnVFPhbFNlej3v8ChGpjRwA9i37+gllcuU43U9eOKh6SvepNhyaKAbUjKeQRAwu6bp4jt5DBtmh0RaVrEj3nZOzdh4v72IQXiDp03Mud7rhnX5/t9d71LKliwyZlyh/WYBgSGXhmhb7nzp08RTQWkTm3Kco8IpyykrH/o0poJyN+dJd1JRESoGI+ngE3sR97V8tSB9z1uh2vBUoxRzaZgn1EPNjeImVD8xxK1F9nF3Wcsw/9kLLb2jmIAtcx4ySGJ1IbFpjQOMwtz19NnyaHkYPO2/DPBLwkBJibeu0Bqv0ts+p5vWPCHP0MR/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Cfq8tMFDYALRpVo5o+yltuNUcFR5jP4c9+JXZNEJVA=;
 b=Hgc1h2VYO15H7yCSBagVHjBReTUcLzTKa8IOwte0Xh5E+ghVV8gnNQdc3L4IXF6vboXF/GlR2YBTs+1+gfrcnZaIBmVS5H/WT1ApssQEbwgjQWyjQpUwYLfkoJUqLejagVA3PIEVJrHoEzaBYMctOhifWDtiKGAS/kmMwW1W+Zk=
Received: from DM6PR12MB4465.namprd12.prod.outlook.com (2603:10b6:5:28f::17)
 by CYYPR12MB8940.namprd12.prod.outlook.com (2603:10b6:930:bd::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.19; Tue, 20 Feb
 2024 11:45:52 +0000
Received: from DM6PR12MB4465.namprd12.prod.outlook.com
 ([fe80::3d54:20fd:bfee:7fc6]) by DM6PR12MB4465.namprd12.prod.outlook.com
 ([fe80::3d54:20fd:bfee:7fc6%4]) with mapi id 15.20.7316.018; Tue, 20 Feb 2024
 11:45:52 +0000
From: "Buddhabhatti, Jay" <jay.buddhabhatti@amd.com>
To: "Simek, Michal" <michal.simek@amd.com>, Alexandre Belloni
	<alexandre.belloni@bootlin.com>
CC: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"monstr@monstr.eu" <monstr@monstr.eu>, "michal.simek@xilinx.com"
	<michal.simek@xilinx.com>, "git@xilinx.com" <git@xilinx.com>, Conor Dooley
	<conor+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Rob Herring <robh@kernel.org>, "open
 list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
	<devicetree@vger.kernel.org>, "moderated list:ARM/ZYNQ ARCHITECTURE"
	<linux-arm-kernel@lists.infradead.org>, "open list:REAL TIME CLOCK (RTC)
 SUBSYSTEM" <linux-rtc@vger.kernel.org>
Subject: RE: [PATCH] dt-bindings: rtc: zynqmp: Describe power-domains property
Thread-Topic: [PATCH] dt-bindings: rtc: zynqmp: Describe power-domains
 property
Thread-Index: AQHaY+ZmsRZsdu8zXkqO0n0tzvdoobETDdZQgAAL1wCAAAKycA==
Date: Tue, 20 Feb 2024 11:45:52 +0000
Message-ID:
 <DM6PR12MB4465A3F36E78DDDD0B4C68F89D502@DM6PR12MB4465.namprd12.prod.outlook.com>
References: <202402192019160b9c4120@mail.local>
 <DM6PR12MB4465FAF7AB3F9CE15FAC6C879D502@DM6PR12MB4465.namprd12.prod.outlook.com>
 <74cfdded-be3a-4af6-b23a-eea2c5e748b8@amd.com>
In-Reply-To: <74cfdded-be3a-4af6-b23a-eea2c5e748b8@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB4465:EE_|CYYPR12MB8940:EE_
x-ms-office365-filtering-correlation-id: 6e1dacd8-de0d-4be1-3bbc-08dc32097d9d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 EMmSvv+m4Q/WLCrfYI6K2doBeAY8J8pESzZ1vwF9pIhWjX0rNZTwSxss80DsvhwwkEAzyJ79Rfl+ALh2lwJB6/hkW9kZrvpugZWFZ/DuYRdRQhRswOl1Lms+rUtN22cmpo5gprUhKoURSjp4HGjjsCPIXTJEJWkyl+V4HpNz7NfvZxO8eR5yh40d2fk9SzyAdQFm1EdFHelhBL33Vzw0SZGh7Vjpsb9kbhqAFGn8WEuebBFk9Km/9sABuAhVNF5qeLaxdZYpwRe7Uz0xF3OL/Ls1FKk5pSN6z6vgh8KAFZ6s4lWHpYX+kd1mF7judA2Vk5qU+wFa0jWj8cwiCUdJjYhYQHkEJvHoSW91V6GQZw7n+ufNa9eZQTgk0lG/ro21mlDAixdqsGTijM/8xZkbXR3cEFQ6iTq7GM7NimAdljC9zH1stODGLyLsl0Jvz6y+dJMJYNDKDJRSTY2w7KBggap9JrGt1B7SAxQRKIuIbkyhehkHeOcVTANNpjuBa+nAvC5bP5wBjbcJ8vbqwsvCl2xnXKR7mD7MYOokNKBi+Dt+J1qx4Fx4Rg+Izql3oC2gGdqtyxrnheNiv7PxWWbSosvIPUmW1KU2AydtuVJ15i+EORU9rcGgOCr6DjuLez8K
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4465.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cisrMWgyM1FkdHhabEs0MjJLMENLNC8rVU16SHNNTWdNRjVKRkR6eGR2WE1q?=
 =?utf-8?B?YWpVaHBNUW4rY2JJbktQQmJzaklZd0wyNmdFZnpyNXIzUFQ3N0Y0S0hRUUFX?=
 =?utf-8?B?ZHowcVRmU1FEN2wya0c3ZG5GenpMZzM4QVpnNTNkOEFxZ28vamlEMFVRWGlm?=
 =?utf-8?B?eGRzY3lNS1d4UEJpNW04a3dKMnE3MnB3d0g2SDZPOXpqL2pkNFMwVHhCYlVC?=
 =?utf-8?B?U2lNTy9TS1pJK1FlRUZaRWJJaEpxWnUrQkltMlJueThpOGJGV0FZNlFjZ2tR?=
 =?utf-8?B?djFEeE5ZKzJrT3Faa29qaHRVMWxwQlllbVFXY2pWMk9XWitOc0QxQ2R0L3Zu?=
 =?utf-8?B?K1g2UWFIcDNHRWtURk5lbFk2UzY1cVA0aWovN2ZLZG54ODViamJQK00yWlIz?=
 =?utf-8?B?OFdLRVdEM2kzT0pkQjFTVHdzNWlXbEo4cUdDdlgwTzZvb3NLZkVGVXdwRXpT?=
 =?utf-8?B?ajV6NHB3NTlsYWI2Z0RMZVFpbyt3c1FtV0ZSdFpFNlI0ZzFrKzgrY3BFOWxx?=
 =?utf-8?B?M1JaL0J4RERQK0o0RG1DcElJaTVnV1ZvUHRaRzF6THBncXlMUjl4eWFiL2Qv?=
 =?utf-8?B?bW1BNyszY1JBYXJON3F4SDEveHhpYzVvUHRuUlFKc2I4WUpGejRvMGxnd0E4?=
 =?utf-8?B?ekdYOGtxdFRzcS9pOFppaEJvSXhnRmF4S1o1WmZJVXBpZnBrdE9ScmJkRncz?=
 =?utf-8?B?UVhGNXBUSll3SFdtVjcvWmhyZnh0Z2RmRmJwRzlmWVljVW4xN3h0VXk0cE53?=
 =?utf-8?B?ZThTanRpZXFXekpab29scXYxZDZMV1NNTGU1dGlVMEY4RkZuVWhFcWZ4M2RY?=
 =?utf-8?B?QVh3cHBlalVtRitVc2lINGpyTTdkWHU3SjFkUE4rSkNxZzMrYjBrTW85eDZY?=
 =?utf-8?B?MDBIZlRsTTU3Tk5jNzBGWEVGNHFIWW5QSGExeUhwU2I3SUFnR0t1Vjg1cmFn?=
 =?utf-8?B?VTBZVk5lNUU3REIyTGNHamtlSEU1WW9qQklPaE95KzJRb3VTN3IrWHY3Qk13?=
 =?utf-8?B?YytkY0RtNFVDNElZUys3bVFPZG1xaU5TekE3eXBXbFBLV2hXTVc0eDYzTWUv?=
 =?utf-8?B?V3V1S0g4QmRnS0F2VlZSTnlDSHFVWHVuNFNTMml2OGhVRTdVQmN2V3RrbjVn?=
 =?utf-8?B?Y1Y0VlRkSFJZNlN4SlEvaXNCWlRqT1Y2WTRjNElYZktjbEtzdDVySk55TmN4?=
 =?utf-8?B?eTN2MFAwWUFYcXFRejZUS1hkc1g0ZnJNU0pqSTB3TGxLVnpMdkZiejBGdXVl?=
 =?utf-8?B?ZUhVTUZvdHdKR0R2Yi9pY3N2RnlXL2Z5UC9ETFJSbmpJN1VQTFhyN0tVQVp6?=
 =?utf-8?B?bVVLR1ZPeTROVzNOTnFnWDRMcG1laURYeis1T3NtZVhVL2plU2tNMS9SdW1R?=
 =?utf-8?B?RTN6UklCZmhJc3FWdmhQOXNSTFpPUmpZMnI5OVhmNitGZ2c4KzJ4bGlkNEww?=
 =?utf-8?B?S2RITmp5cHdiUC9zQ3d0T2Zkb0g5UDNNSHNNRkxpYTNkNGpVSDkxVUVKenZP?=
 =?utf-8?B?YkR4aTBScmhPcVlSeVFXWldyU2hPcHNxZk14OTdnWFQ0ZjJGb3pSZlVoeXdp?=
 =?utf-8?B?ZGVHVk5lQjAxQVVUbFJia1hybk9CRForRlNqbUdEYXlTbG9GUTdhUmdZN1B3?=
 =?utf-8?B?OS9ZUmZmOUVlTysxTGU0K1dqUUlWTStrSWxvdnhwQnBaRW5XTjlYaVQ1cEt2?=
 =?utf-8?B?WWs5Yll1dEIxak1hQWZObW14NmViRDZ6Q3ZQWW1RU1ZrNEV5V2RveVZueEpG?=
 =?utf-8?B?cHJscnNYazhNckIySUZ6TVdtS3c3UXh0Y3VWOWtidmZVK3RPcmhkUHlVZ29N?=
 =?utf-8?B?dXphaW1GOXZqWmk1Mmp3NGxmZGJQamxDOGlWekVjUEtSSE9mQ0FjbC9xVWhT?=
 =?utf-8?B?alc0WGJ3U0tZTEtmWFJ1NEpUanY0b09VZmFiMlZoZ1U5RnVaaURVaDhRSjhJ?=
 =?utf-8?B?c05EVXo5M0g5bUZoMXFrdEZqbkV4bll2Tk9jOUtORmgwaVl2aTc3QSs5dDJ3?=
 =?utf-8?B?a1VsQ1ZSeUx5eGFUcHJBSmtybzZpTi90ankwWUY3SGhvU0FpbitBRTRCM0x1?=
 =?utf-8?B?SXpyYVRFcXE5SHdBUllmVVNWczdFWkhna3ZSRWtRYlMxU25vQ3FjQTJOL0o2?=
 =?utf-8?Q?IMNc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4465.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e1dacd8-de0d-4be1-3bbc-08dc32097d9d
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2024 11:45:52.2735
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CtuIw1uvPUNRtKJgt4w7c7IHxlWCxon5auLvd1A1vruIsDPIpOhRgtjwihPdXAZNOoKwYyKkITGOkboS20jJtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8940

SGkgTWljaGFsLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFNpbWVr
LCBNaWNoYWwgPG1pY2hhbC5zaW1la0BhbWQuY29tPg0KPiBTZW50OiBUdWVzZGF5LCBGZWJydWFy
eSAyMCwgMjAyNCA1OjA0IFBNDQo+IFRvOiBCdWRkaGFiaGF0dGksIEpheSA8amF5LmJ1ZGRoYWJo
YXR0aUBhbWQuY29tPjsgQWxleGFuZHJlIEJlbGxvbmkNCj4gPGFsZXhhbmRyZS5iZWxsb25pQGJv
b3RsaW4uY29tPg0KPiBDYzogS3J6eXN6dG9mIEtvemxvd3NraSA8a3J6eXN6dG9mLmtvemxvd3Nr
aUBsaW5hcm8ub3JnPjsgbGludXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IG1vbnN0ckBt
b25zdHIuZXU7IG1pY2hhbC5zaW1la0B4aWxpbnguY29tOw0KPiBnaXRAeGlsaW54LmNvbTsgQ29u
b3IgRG9vbGV5IDxjb25vcitkdEBrZXJuZWwub3JnPjsgS3J6eXN6dG9mIEtvemxvd3NraQ0KPiA8
a3J6eXN6dG9mLmtvemxvd3NraStkdEBsaW5hcm8ub3JnPjsgUm9iIEhlcnJpbmcgPHJvYmhAa2Vy
bmVsLm9yZz47IG9wZW4NCj4gbGlzdDpPUEVOIEZJUk1XQVJFIEFORCBGTEFUVEVORUQgREVWSUNF
IFRSRUUgQklORElOR1MNCj4gPGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnPjsgbW9kZXJhdGVk
IGxpc3Q6QVJNL1pZTlEgQVJDSElURUNUVVJFDQo+IDxsaW51eC1hcm0ta2VybmVsQGxpc3RzLmlu
ZnJhZGVhZC5vcmc+OyBvcGVuIGxpc3Q6UkVBTCBUSU1FIENMT0NLIChSVEMpDQo+IFNVQlNZU1RF
TSA8bGludXgtcnRjQHZnZXIua2VybmVsLm9yZz4NCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gZHQt
YmluZGluZ3M6IHJ0YzogenlucW1wOiBEZXNjcmliZSBwb3dlci1kb21haW5zDQo+IHByb3BlcnR5
DQo+IA0KPiANCj4gDQo+IE9uIDIvMjAvMjQgMTE6NTEsIEJ1ZGRoYWJoYXR0aSwgSmF5IHdyb3Rl
Og0KPiA+IEhpIEFsZXhhbmRyZSwNCj4gPg0KPiA+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0t
LQ0KPiA+PiBGcm9tOiBBbGV4YW5kcmUgQmVsbG9uaSA8YWxleGFuZHJlLmJlbGxvbmlAYm9vdGxp
bi5jb20+DQo+ID4+IFNlbnQ6IFR1ZXNkYXksIEZlYnJ1YXJ5IDIwLCAyMDI0IDE6NDkgQU0NCj4g
Pj4gVG86IFNpbWVrLCBNaWNoYWwgPG1pY2hhbC5zaW1la0BhbWQuY29tPg0KPiA+PiBDYzogS3J6
eXN6dG9mIEtvemxvd3NraSA8a3J6eXN6dG9mLmtvemxvd3NraUBsaW5hcm8ub3JnPjsgbGludXgt
DQo+ID4+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IG1vbnN0ckBtb25zdHIuZXU7IG1pY2hhbC5z
aW1la0B4aWxpbnguY29tOw0KPiA+PiBnaXRAeGlsaW54LmNvbTsgQ29ub3IgRG9vbGV5IDxjb25v
citkdEBrZXJuZWwub3JnPjsgS3J6eXN6dG9mDQo+ID4+IEtvemxvd3NraSA8a3J6eXN6dG9mLmtv
emxvd3NraStkdEBsaW5hcm8ub3JnPjsgUm9iIEhlcnJpbmcNCj4gPj4gPHJvYmhAa2VybmVsLm9y
Zz47IG9wZW4gbGlzdDpPUEVOIEZJUk1XQVJFIEFORCBGTEFUVEVORUQgREVWSUNFDQo+IFRSRUUN
Cj4gPj4gQklORElOR1MgPGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnPjsgbW9kZXJhdGVkIGxp
c3Q6QVJNL1pZTlENCj4gPj4gQVJDSElURUNUVVJFIDxsaW51eC1hcm0ta2VybmVsQGxpc3RzLmlu
ZnJhZGVhZC5vcmc+OyBvcGVuIGxpc3Q6UkVBTA0KPiA+PiBUSU1FIENMT0NLIChSVEMpIFNVQlNZ
U1RFTSA8bGludXgtcnRjQHZnZXIua2VybmVsLm9yZz4NCj4gPj4gU3ViamVjdDogUmU6IFtQQVRD
SF0gZHQtYmluZGluZ3M6IHJ0YzogenlucW1wOiBEZXNjcmliZSBwb3dlci1kb21haW5zDQo+ID4+
IHByb3BlcnR5DQo+ID4+DQo+ID4+IE9uIDE5LzAyLzIwMjQgMTQ6MTE6NTArMDEwMCwgTWljaGFs
IFNpbWVrIHdyb3RlOg0KPiA+Pj4NCj4gPj4+DQo+ID4+PiBPbiAyLzE3LzI0IDA5OjI2LCBLcnp5
c3p0b2YgS296bG93c2tpIHdyb3RlOg0KPiA+Pj4+IE9uIDE2LzAyLzIwMjQgMTA6NDIsIE1pY2hh
bCBTaW1layB3cm90ZToNCj4gPj4+Pj4NCj4gPj4+Pj4NCj4gPj4+Pj4gT24gMi8xNi8yNCAxMDox
OSwgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4gPj4+Pj4+IE9uIDE2LzAyLzIwMjQgMDk6
NTEsIE1pY2hhbCBTaW1layB3cm90ZToNCj4gPj4+Pj4+PiBSVEMgaGFzIGl0cyBvd24gcG93ZXIg
ZG9tYWluIG9uIFhpbGlueCBWZXJzYWwgU09DIHRoYXQncyB3aHkNCj4gPj4+Pj4+PiBkZXNjcmli
ZSBpdCBhcyBvcHRpb25hbCBwcm9wZXJ0eS4NCj4gPj4+Pj4+Pg0KPiA+Pj4+Pj4+IFNpZ25lZC1v
ZmYtYnk6IE1pY2hhbCBTaW1layA8bWljaGFsLnNpbWVrQGFtZC5jb20+DQo+ID4+Pj4+Pj4gLS0t
DQo+ID4+Pj4+Pj4NCj4gPj4+Pj4+PiAgICAgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL3J0Yy94bG54LHp5bnFtcC1ydGMueWFtbCB8DQo+ID4+Pj4+Pj4gMw0KPiA+PiArKysNCj4g
Pj4+Pj4+PiAgICAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKQ0KPiA+Pj4+Pj4+DQo+
ID4+Pj4+Pg0KPiA+Pj4+Pj4gQnV0IFZlcnNhbCBpcyBub3QgZGVzY3JpYmVkIGluIHRoaXMgYmlu
ZGluZywgaXMgaXQ/IEkgc2VlIG9ubHkNCj4gPj4+Pj4+IG9uZSBjb21wYXRpYmxlLg0KPiA+Pj4+
Pg0KPiA+Pj4+PiBJdCBpcyB0aGUgc2FtZSBJUCBvbmx5IGFzIGlzIG9uIHp5bnFtcCB3aXRoIG93
biBwb3dlciByYWlsLg0KPiA+Pj4+DQo+ID4+Pj4gVGhlbiB5b3Ugc2hvdWxkIGhhdmUgc2VwYXJh
dGUgY29tcGF0aWJsZSwgYmVjYXVzZSB0aGV5IGFyZSBub3QNCj4gPj4+PiBpZGVudGljYWwuIEl0
IHdvdWxkIGFsc28gYWxsb3cgeW91IHRvIG5hcnJvdyB0aGUgZG9tYWlucyB0byB2ZXJzYWwNCj4g
Pj4+PiBhbmQgYWxzbyByZXF1aXJlIGl0IChvbiB2ZXJzYWwpLg0KPiA+Pj4NCj4gPj4+IEkgY2Fu
IGRvdWJsZSBjaGVjayB3aXRoIEhXIGd1eXMgYnV0IEkgYW0gcXVpdGUgc3VyZSBJUCBpdHNlbGYg
aXMNCj4gPj4+IGV4YWN0bHkgdGhlIHNhbWUuIFdoYXQgaXQgaXMgZGlmZmVyZW50IGlzIHRoYXQg
dGhlcmUgaXMgb3duIHBvd2VyDQo+ID4+PiBkb21haW4gdG8gaXQgKG5vdCBzaGFyZWQgb25lIGFz
IGlzIGluIHp5bnFtcCBjYXNlKS4NCj4gPj4+DQo+ID4+PiBBbHNvIExpbnV4IGlzIG5vbiBzZWN1
cmUgc3cgYW5kIGlmIHNlY3VyZSBmaXJtd2FyZSB3b24ndCBhbGxvdyB0bw0KPiA+Pj4gY2hhbmdl
IHNldHRpbmcgb2YgaXQgaXQgY2FuJ3QgYmUgcmVxdWlyZWQuIEkgYW0ganVzdCBzYXlpbmcgdGhh
dA0KPiA+Pj4gTGludXggZG9lc24ndCBuZWVkIHRvIGJlIG93bmVyIG9mIGFueSBwb3dlciBkb21h
aW4gdGhhdCdzIHdoeSBpdA0KPiA+Pj4gc2hvdWxkbid0IGJlIHJlcXVpcmVkIHByb3BlcnR5Lg0K
PiA+Pg0KPiA+PiBJIGd1ZXNzIGJlY2F1c2UgdGhlIGludGVncmF0aW9uIGlzIGRpZmZlcmVudCwg
eW91IHN0aWxsIG5lZWQgYQ0KPiA+PiBkaWZmZXJlbnRlIGNvbXBhdGlibGUgc28geW91IGNhbiBm
b3JiaWQgdGhlIHByb3BlcnR5IG9uIG5vbi1WZXJzYWwuDQo+ID4NCj4gPiBbSmF5XSBSVEMgaGFz
IGl0cyBvd24gcG93ZXIgZG9tYWluIGluIGNhc2Ugb2YgVmVyc2FsIGFuZCBaeW5xTVAgYm90aCB0
aGF0DQo+IHdlIGRvdWJsZSBjaGVjayBpdC4NCj4gDQo+IFRoYW5rcyBKYXkgZm9yIGxvb2tpbmcg
aW50byBpdC4gSSBzaG91bGQgZGVmaW5pdGVseSB1cGRhdGUgbXkgY29tbWl0IG1lc3NhZ2UgdG8N
Cj4gcmVmbGVjdCBpdC4gRG8geW91IHN0aWxsIHdhbnQgbWUgdG8gY3JlYXRlIHNvYyBzcGVjaWZp
YyBwcm9wZXJ0eT8NCg0KW0pheV0gVGhpcyBzaG91bGQgYmUgZm9yIGJvdGggWnlucU1QIGFuZCBW
ZXJzYWwgc2luY2UgUlRDIGhhdmUgaXRzIG93biBwb3dlciBkb21haW4gd2Ugc2hvdWxkIGFkZCBw
b3dlciBkb21haW4gcHJvcGVydHkgZm9yIGJvdGggU29Dcy4NCg0KPiANCj4gVGhhbmtzLA0KPiBN
aWNoYWwNCg==

