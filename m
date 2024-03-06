Return-Path: <linux-kernel+bounces-93944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B862E873751
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 14:05:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B921B1C21AB2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 13:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D0F4130ACC;
	Wed,  6 Mar 2024 13:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PEjDqaJC"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B235E3E48E;
	Wed,  6 Mar 2024 13:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709730320; cv=fail; b=pNl/lsWbsyJ26aQ37qZsPL59e5Cl01MF/jFMlaaQTFI0wcG5U+9wHQkAv2N49mgi0QorkfVA9ded/pVf78QvL7xnIcSuU2vtH9K4l/tNFbjg29oyT40qN9x/ytPDo+rmrsdD9IBxBo/ZA9tfp1mem1WURsbk3XDX1ec3+LR3Rbg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709730320; c=relaxed/simple;
	bh=99/cXbGK8H66CXp1ntcaeMHhfgMmS4M9FfBBYjS+qDs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cmX8Yf1QpzszsboceFIqBARlIpP8IWnh7+Y0OJxEy1b5KXhMAhIh7iMTK/iZP/GZnoKRvnQlzXKBQZua7BJdY422rTPEPEDOoNsGc2bitb6WzVQLSyqu6ulpxAoCfOvRtsIV+EeqJ8Bn17WMqGdipWrT2rvqwQa7wVilFgWjWTk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PEjDqaJC; arc=fail smtp.client-ip=40.107.236.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VyRt6guFb46Pm/cQpSSLAMiCDJFG5WWv89N7zpop+QdGd74folhA8huzXmVeCMk3Lb4zld5DWtdd1DpnVd4thcPlDQl8/EwMhppKDVlmt1GznB5aqcYlWFKmn7QF6VptEN+AtNUTiowUJQEfgFwjPvg6DQHu/YGnPflgGCmaDDi7IyQzaT0zkYV4sthWsa5EBwHAv1RsWmt8QxBGX8U6uHms4MC6SSNt6ZgWISB15Hpxtef3s4z+TmES5KKgO92/jwEa/CE30rVclb8op7IEdASIOkYa7Glnc0iggx1a7Q4xtcp2jyRiZUkyLNf7SziqO0BrV3ixOeyoPRZdWczOaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=99/cXbGK8H66CXp1ntcaeMHhfgMmS4M9FfBBYjS+qDs=;
 b=gL4mskHM0+5rbiHpX5hVTEH5T0Fxgnwrf+qBX50wSFjjqc65EvYOa8fBHbzIRtMsmwGT0WosILEUczaMm4uCtjnN0q3X/mUztbYPeQQKs+0xu1skz8XbS3QWmAo+QYKvawlTS+a6fs+ORd52hpDJAv/X0aQOQRhe9sz/RqTT+55jTHXb69ovAkAoW78+yPZ10ojkfsQpy7z8M7ozO+BUuxPtBn7wlTU0hT2xbCn24gQ22oCxkHwNmvpUjjNwyrHc7m3vdr/B33Z/IIjeCDxi40ra5ReAv18dN9fo5Gsf0PwUd12pbFkniA68tCOmqwe3vm+CnbaiFLBNgSLS7d4VPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=99/cXbGK8H66CXp1ntcaeMHhfgMmS4M9FfBBYjS+qDs=;
 b=PEjDqaJC39yjtvC6WPiX0kL10LkkbbxB5du/ou3JJdBUUwONH/p1qgpuMFYT3jK7FC+EEGB0fqwqXZLbxeWlyoZk1k6o8C10DGT24UctnwJuMIoK25/6/Ybbebfa0/vYhHi4+X1Ehasr4Y1v5ZpiWh58wqam9dj5+FkYAJnW5kYwo4K+glYVBZGNUbL2oW8D6mHP2Dzvx518O5wH0F7kVaECz8kTFyx+e9HzK1Xs7nakkwYXtOXZEQBfD/C/H41P9GO246kVYJWO8Mxwnh/doP2dCymdQnYC1tdsbwMOQw45rRNVKVL/plJW9CycKuNuKB3A8UH4CpxHrPZWVlZOLw==
Received: from DM6PR12MB5565.namprd12.prod.outlook.com (2603:10b6:5:1b6::13)
 by IA0PR12MB8423.namprd12.prod.outlook.com (2603:10b6:208:3dc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Wed, 6 Mar
 2024 13:05:14 +0000
Received: from DM6PR12MB5565.namprd12.prod.outlook.com
 ([fe80::bfce:51e5:6c7b:98ae]) by DM6PR12MB5565.namprd12.prod.outlook.com
 ([fe80::bfce:51e5:6c7b:98ae%3]) with mapi id 15.20.7362.024; Wed, 6 Mar 2024
 13:05:14 +0000
From: Dragos Tatulea <dtatulea@nvidia.com>
To: "kuba@kernel.org" <kuba@kernel.org>
CC: "almasrymina@google.com" <almasrymina@google.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "herbert@gondor.apana.org.au"
	<herbert@gondor.apana.org.au>, Gal Pressman <gal@nvidia.com>,
	"dsahern@kernel.org" <dsahern@kernel.org>, "steffen.klassert@secunet.com"
	<steffen.klassert@secunet.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Leon Romanovsky <leonro@nvidia.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "edumazet@google.com"
	<edumazet@google.com>, "ian.kumlien@gmail.com" <ian.kumlien@gmail.com>,
	"Anatoli.Chechelnickiy@m.interpipe.biz"
	<Anatoli.Chechelnickiy@m.interpipe.biz>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
Subject: Re: [RFC] net: esp: fix bad handling of pages from page_pool
Thread-Topic: [RFC] net: esp: fix bad handling of pages from page_pool
Thread-Index: AQHabhlPr1Jip1r+TESj3iFnglf1YrEqCc2AgACn2oA=
Date: Wed, 6 Mar 2024 13:05:14 +0000
Message-ID: <7fc334b847dc4d90af796f84a8663de9f43ede5d.camel@nvidia.com>
References: <20240304094950.761233-1-dtatulea@nvidia.com>
	 <20240305190427.757b92b8@kernel.org>
In-Reply-To: <20240305190427.757b92b8@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.50.4 (3.50.4-1.fc39) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB5565:EE_|IA0PR12MB8423:EE_
x-ms-office365-filtering-correlation-id: 3a72334a-af97-4ee2-e11a-08dc3dde1045
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 LpCRhJmX6NwSFXAX1Oqe8otIMfU4kwfbwMoCQPPimBZuzrPTYI0J/wU+xPZu9VFnU1gmJBvxQ4VB7vK6DAlT7rwvjO3P9fw9JMwkZeMLcBuhB9fN1aoAa4BJUUueqWy5j5/qNGta3N7a/f/MTqNY9y9LT+ZRntXL92/R1MHuGe152W6WtS81zbcYvsfBo8poufeFtSWgW4tKB0iuny63MYpPj8IZ5x2BoIOTNeCmaMJ2dnVOugo6no967Lqm6DKB5XC+0atDGiN+yWc32uVSt2N3Xas8unzZGO+iXeAPHADAhVzKrJK7rwGeGb02Y87cIMLNl/SRpNZlZP10jrS/fYq/ssb0LYf74d5g1apImmEooU77moFRvsFu8KkuHkpiROHPOcjQNeh8XcNy6oaqhA5RLFf7/X3zh79uLPsY5OxO6l18W6LkU+Ehuy/p3f7bu7pM3LxCmYm83uEjFgWcIzEOIpv3pwXOibY6vCLBOGA6cqPPAgCh5ahXecXcDIR4oJEZDq49Elgy6MVcXSyQ0BbZrvebbA0grjJTjmJDQDmKtpsfsBASPc8ndBtCuHXUznJiQ7noaAUKqOll5BHY93yBdcEoMfKtIcjH0+z7FHSiJlkbX5SO1Ana1H3klps2K/W2omuG5ImIGietXXp+UoRo5Tu//FKVlAh+hg+9+/KveZ+/g5l1MMxwhfDvvXV29aYpR1sVKG8x9bC/JyLmLrFT3IDvKYsi3qWuO9Zih2U=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB5565.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eVVuOENpTkVMbWNLU0l6WTJTTE5wb3RURUZTR0FlL25CUEdybDJxM0lUd0dw?=
 =?utf-8?B?OEdjRndNY2xPeGU1MzhUL2ZuaFZIVGw2Y0pIdmdlemk5N1JTUzdtNkpuMkt0?=
 =?utf-8?B?ZUlrK20yeC80RTBFMEE5eVc0OEVld0RVdG1na0VSenZjemZxZldlb3hDZ1ZE?=
 =?utf-8?B?aXVhWmlLRFNSbnNZdFhnT294ZkYyUHlhbC8xUEJLemtHaWNaRUhCSkxWanA5?=
 =?utf-8?B?aWNJaVVpenRzVkllRUJPVkUyRDVYZWFCbkt5Mm5VcXBVZUV2OFhFUWdPcStz?=
 =?utf-8?B?bXlRdmNrWlQyVW85YmxHWkZCNXhoa1Z0YWlwMTRJR01GYkFJdENvL2RwNTlN?=
 =?utf-8?B?bEx3QzVJVFJOeUhTcTVSeDVOT0pYRnZoZGFkTGZvK3MvR3gybW5GY0JOU0tF?=
 =?utf-8?B?YnEvQ2xUdFJad0VRd0tneXBPTVQ0U2FEZ1BRbHFxRmFlMVhPUFZGY3NTWWhX?=
 =?utf-8?B?d2I1d1pnYmdKTjZWYitXaHg1L1dpd1hGdzMxV3o5UlJHOGRtM3hLU05rRS9w?=
 =?utf-8?B?QXJkUUkrT1RVWGxPMFlBN2tKc2UrZWNzME9mT2t3ZWVZTzl3T1l3amRNMENq?=
 =?utf-8?B?WVlRd1B6UjRmeDRqV21QL1hUVVlPWVJnMTVEOEEzQ2RUaEZ0dHFNQjlRNU5l?=
 =?utf-8?B?R01nWDc5Z2ozNWdldVFQQndiRzAxMGJwbE1DaGN5ZWtUQnBVOHFCNXBJNWVF?=
 =?utf-8?B?QzdFOSt5aVB3ZFFpb1owY0VUbFhobm5MenpnQWtwUzhNL0wzdVhqMUlzWTNR?=
 =?utf-8?B?NlJFU0ZZTXhGNjVSR1B2RzRYb3ByZDVvangxQW03T0lMQkZ1bUp6SEwvNkF1?=
 =?utf-8?B?cjBtY25HL05ndHNUeE4zYnFGUjhLUWVMNjRPRDdtYWxnZWl2aWRvdlFKTmk4?=
 =?utf-8?B?T0Nuc0J3WVJnLzFWQkZaRkhCTW0vY3o1eGFaaEtpSnRkSGpVM0pZNnljdVlF?=
 =?utf-8?B?WHRRbGdTaXFTbnR3d29CMmZFcWxJc3hWSzNYMXRleCtLSTZXdDdPaWhMMWNG?=
 =?utf-8?B?a3V0YXNYa0RzdjBFdzcvMW5BZmk1SFZtOSt3Y0phRUcwRmtQb1hhZFc1d0gr?=
 =?utf-8?B?ZjNURWE4dzFkUmFEazNMRXJ0Vm80MDRpVVVCbmMrWEJsVE1zM0p2Zm9vYUZh?=
 =?utf-8?B?WXNBbXVvdHBGQlcza2ZJK2dDMndZTGhPNlFaQXorQldPWnFJL3NnU0ZMNU1M?=
 =?utf-8?B?cWMrQ1JGemh0bGlOaDBjU2pDUmgrbmlGV25QbzN1cTllMXNId2lTUEh3b2dT?=
 =?utf-8?B?SFV1T2p1U1hodlZraDFuM1NaeXJrQ2ZaYnp4MHpUSWMyVWFYbnJ3MEZnVGhB?=
 =?utf-8?B?MmNIRW9EbEJsSUhYMHR6NDlDYitxMUJGLzd5b0xJa2VyOW9ubmVWOExrY1JX?=
 =?utf-8?B?dWkyWWlrMWZpYjNLTUlrVHVnSzJhRGlSNlBhZ3lJMG01SGlHM3UxdjJXK0J4?=
 =?utf-8?B?WWgrS3RkRjc5OGdJUHZrUGZtc0pORkErMDJBcjRuSlYxTHowV3pyUFAyZ1BC?=
 =?utf-8?B?RFYwancrQStRSTFzeGxIM1N2VXFHdlY5QkQxbXVtVEFKTzVXVzY0U0pqRVFm?=
 =?utf-8?B?RlViSThHaTVqTWlZeVVVU2E5UW5LWkhSNUh1LzhlYWk2OGNuOFJOUkc0T1E2?=
 =?utf-8?B?WlFLbjk0RlpyN3BMcVNVcXVrc3NFOVVkejdod3dTQUxhUjNUN1pqU2xyc0p4?=
 =?utf-8?B?UCt0MzNqeUptV3djSnZXajFqMU1yY3lrOFVKQmRBUS9CSWgybTJTaGhLTGJp?=
 =?utf-8?B?SlpUU0xFQk0zcGJZcE1TQTByMnFoSThweHFxZzgxMnFEcGZ6SnMrNUpGQWdX?=
 =?utf-8?B?MU5BZ3RnalVFN1U1eHlnZzFLdVZBUXFIZEJxOEc3TTJFS293ZmRTakZvelVv?=
 =?utf-8?B?TUpCZlUrbXpDdzV1VGdCTlZoc3hsb1o2R1I3MUhsL3R1WjBMN3B4NEdLUTBo?=
 =?utf-8?B?QmFGcnMyWWxDY2gxNnB1T1NJSk4zektGbmZrS2Z1UHk0RjE4NTNRdThJSXhH?=
 =?utf-8?B?eWhoSUtFZTIwMTNkSEl0UzhnZWxQTlZSSGdZb1Z5cU1kU3hYNlVQd2JONm5R?=
 =?utf-8?B?WExZSE0rK2VkYTRaeFZJNEZoaU54MGJOeFdVYUpoQTNaVFRMV2prY1lGdThF?=
 =?utf-8?B?Q0dQMVg1VHd1N05yNGg3UnVMNTNwVjZpc0JIV2ZiR0x6VGlHUWg5YUp3Nm9O?=
 =?utf-8?Q?9BBkZhiZkuqRt9j3LDCRJoOjOpc464MzosHVGK1F8ny7?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6C74CB93C43CCB49A5DDE6B86AE13070@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5565.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a72334a-af97-4ee2-e11a-08dc3dde1045
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2024 13:05:14.4464
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kjyfcKhxzBQznsgehONOIJIEOWevAf2dJVH037takYBUAchYCfq0y4+BOOsWweAT1YmcNbnEstWsezmW6OIhUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8423

T24gVHVlLCAyMDI0LTAzLTA1IGF0IDE5OjA0IC0wODAwLCBKYWt1YiBLaWNpbnNraSB3cm90ZToN
Cj4gT24gTW9uLCA0IE1hciAyMDI0IDExOjQ4OjUyICswMjAwIERyYWdvcyBUYXR1bGVhIHdyb3Rl
Og0KPiA+IFdoZW4gdGhlIHNrYiBpcyByZW9yZ2FuaXplZCBkdXJpbmcgZXNwX291dHB1dCAoIWVz
cC0+aW5saW5lKSwgdGhlIHBhZ2VzDQo+ID4gY29taW5nIGZyb20gdGhlIG9yaWdpbmFsIHNrYiBm
cmFnbWVudHMgYXJlIHN1cHBvc2VkIHRvIGJlIHJlbGVhc2VkIGJhY2sNCj4gPiB0byB0aGUgc3lz
dGVtIHRocm91Z2ggcHV0X3BhZ2UuIEJ1dCBpZiB0aGUgc2tiIGZyYWdtZW50IHBhZ2VzIGFyZQ0K
PiA+IG9yaWdpbmF0aW5nIGZyb20gYSBwYWdlX3Bvb2wsIGNhbGxpbmcgcHV0X3BhZ2Ugb24gdGhl
bSB3aWxsIHRyaWdnZXIgYQ0KPiA+IHBhZ2VfcG9vbCBsZWFrIHdoaWNoIHdpbGwgZXZlbnR1YWxs
eSByZXN1bHQgaW4gYSBjcmFzaC4NCj4gDQo+IFNvIGl0IGp1c3QgZG9lczogc2tiX3NoaW5mbyhz
a2IpLT5ucl9mcmFncyA9IDE7DQo+IGFuZCBhc3N1bWVzIHRoYXQncyBlcXVpdmFsZW50IHRvIG93
bmluZyBhIHBhZ2UgcmVmIG9uIGFsbCB0aGUgZnJhZ3M/DQo+IA0KTXkgdW5kZXJzdGFuZGluZyBp
cyBkaWZmZXJlbnQ6IGl0IHNldHMgbnJfZnJhZ3MgdG8gMSBiZWNhdXNlIGl0J3Mgc3dhcHBpbmcg
b3V0DQp0aGUgb2xkIHBhZ2UgZnJhZyBpbiBmcmFnbWVudCAwIHdpdGggdGhlIG5ldyB4ZnJhZyBw
YWdlIGZyYWcgYW5kIHdpbGwgdXNlIHRoaXMNCiJuZXciIHNrYiBmcm9tIGhlcmUuIEl0IGRvZXMg
dGFrZSBhIHBhZ2UgcmVmZXJlbmNlIGZvciB0aGUgeGZyYWcgcGFnZSBmcmFnLg0KDQo+IEZpeCBs
b29rcyBtb3JlIG9yIGxlc3MgZ29vZCwgd2Ugd291bGQgbmVlZCBhIG5ldyB3cmFwcGVyIHRvIGF2
b2lkDQo+IGJ1aWxkIGlzc3VlcyB3aXRob3V0IFBBR0VfUE9PTCzCoA0KPiANCkFjay4gV2hpY2gg
Y29tcG9uZW50IHdvdWxkIGJlIGJlc3QgbG9jYXRpb24gZm9yIHRoaXMgd3JhcHBlcjogcGFnZV9w
b29sPw0KDQo+IGJ1dCBJIHdvbmRlciBpZiB3ZSB3b3VsZG4ndCBiZSBiZXR0ZXINCj4gb2ZmIGNo
YW5naW5nIHRoZSBvdGhlciBzaWRlLiBJbnN0ZWFkIG9mICJjdXR0aW5nIG9mZiIgdGhlIGZyYWdz
IC0NCj4gd2Fsa2luZyB0aGVtIGFuZCBkZWFsaW5nIHdpdGggdmFyaW91cyBwYWdlIHR5cGVzLiBC
ZWNhdXNlIE1pbmEgYW5kIGNvLg0KPiB3aWxsIHN0ZXAgb250byB0aGlzIGxhbmRtaW5lIGFzIHdl
bGwuDQpUaGUgcGFnZSBmcmFncyBhcmUgc3RpbGwgc3RvcmVkIGFuZCB1c2VkIGluIHRoZSBzZyBz
Y2F0dGVybGlzdC4gSWYgd2UgcmVsZWFzZQ0KdGhlbSBhdCB0aGUgbW9tZW50IHdoZW4gdGhlIHNr
YiBpcyAiY3V0IG9mZiIsIHRoZSBwYWdlcyBpbiB0aGUgc2cgd2lsbCBiZQ0KaW52YWxpZC4gQXQg
bGVhc3QgdGhhdCdzIG15IHVuZGVyc3RhbmRpbmcuDQoNClRoYW5rcywNCkRyYWdvcw0K

