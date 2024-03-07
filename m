Return-Path: <linux-kernel+bounces-95760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5DF8875227
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 15:44:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 309111F25C88
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 14:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56B051EB3A;
	Thu,  7 Mar 2024 14:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=csgroup.eu header.i=@csgroup.eu header.b="Gb/Ua0nv"
Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-pr2fra01on2137.outbound.protection.outlook.com [40.107.12.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8743D1E876;
	Thu,  7 Mar 2024 14:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.12.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709822637; cv=fail; b=LAxyn2b9SaDkyAXJlMa4UoJtF4qPA3vjhvTO31f/jZTqjYNdBVsWOApJggDTfNFDs5BJq+pp5LM5tMarkR4+Hj7IRXS23r9D0qo86WnM+PAbXWrzH1QEfew+n2jOeAkEyre0cDo5MdyuAO+eQwP05DOZGG3Qb1Z30ETXx+oP4RY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709822637; c=relaxed/simple;
	bh=+j4a0kvkGNqFaVD3pH1WywW5S+YyQUUtXshqYrElXsk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=STAIkxtWvSzbz0EaQU5YwL39I2oEimZsdcxZExpes6Z5qGjdk3ZwT6+X/YanOWwtnhJpG/MgIppcOUTSc1RjqCcT/u93MTHBKsc+ibf7B2YtQU/9b4+raiqJm6nVb1N5rqpsQu6yuEHFLTwiLqt4iZNYdHvKRmaHPJXdlztGXsI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; dkim=pass (2048-bit key) header.d=csgroup.eu header.i=@csgroup.eu header.b=Gb/Ua0nv; arc=fail smtp.client-ip=40.107.12.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L5EcjeDf2yLKbwuZi8HXR1eOt8f0cUoAKXDZGrRsqLVIQIInTVdZiTrAokNcphjaQsfklooFE7htG5mKBRG6LonuMT+GrDh7LcqjESD9w8W6PDeKOfH3rFkAg9xLNym8FJwDK4DTGRom5sonYQCuxhopXA7p3w3zxPMheiUR8KFD71VB+x4HR9vUXeeSgfnXR2jPhS1upmI8g9Ck6DtJ9lDlzu205xjOb/qtq8u083n08ZmU9NDfATO0JIvPx5cwRRnWMmj1S6hYxWL6NvXjMLQTj9Piwwj6kbxkidNLk7jpXsgum3qJ2lVu/v5fDSOFqzjaAM+cMOXVy98b01+myQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+j4a0kvkGNqFaVD3pH1WywW5S+YyQUUtXshqYrElXsk=;
 b=cocenOhJjwbOG6fGm8myiIK1tQBVbV5vuu5gKae2oAdep1Tb9TUhX06pl/4mWlWNkwLB+DXmcH3vUDHNU0NUHFVMdHwM7ZiWjQTIIO/wwxWLxcZ6lr7dxTPhBkSXYG8tRzBEQ/B4jfAngkOc87fzQcrlqEcTWt32ft9kVToMKN/GVIpvexsDAHaCj9R2cjErk4Z129Jd+wHhbAYB1AbMoTfULYJd0BkQJ+AMHDbAWGcpWYE9i7G+VEEdPPegGbLK8ys157lDvd0i5mCmfLgOnnITd4Tmz1CFt6deujDrfFx+xURN3XHH0mJgpnNQ8IfOw08Zf20133KWKpsyEI7Sqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+j4a0kvkGNqFaVD3pH1WywW5S+YyQUUtXshqYrElXsk=;
 b=Gb/Ua0nvoM1UB3Xc9wCqfrdBcwJ7q71hZI4hEXelWgV/X+jZJyjy86CLfJPTNdstnfq/b34TUfpK/pe5VFXgnyCPWr0ouvDdnLNIOZjJQj7qrl7d0J2H4Q7WbcsjDXhwfRkhIlA783Ol3IDBWIbj1qSF4f9BqtJmiFV05UCHR0zRq4iWFIZ7AMOhyjtyxNoVSh6ZDZYTXqOIsdwabqMMJjWTxX8SmnFvOQwLPCttic7XXmiRGdf4SnYNd+Ct7XMXysU21yw0MxuSqnB7AZFoWQAs5QYGCfsXZ1LM66/cICswYD/6V0+nbuYMnyfYVVaHDCugQ8wpfXHG6Nh/JEAakw==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PR0P264MB2375.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1e2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.26; Thu, 7 Mar
 2024 14:43:51 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::c192:d40f:1c33:1f4e]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::c192:d40f:1c33:1f4e%6]) with mapi id 15.20.7362.024; Thu, 7 Mar 2024
 14:43:51 +0000
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Calvin Owens <jcalvinowens@gmail.com>, Luis Chamberlain
	<mcgrof@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Alexei
 Starovoitov <ast@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Masami
 Hiramatsu <mhiramat@kernel.org>, Naveen N Rao <naveen.n.rao@linux.ibm.com>,
	Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>, David S Miller
	<davem@davemloft.net>, Thomas Gleixner <tglx@linutronix.de>
CC: "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH 1/4] module: mm: Make module_alloc() generally
 available
Thread-Topic: [RFC][PATCH 1/4] module: mm: Make module_alloc() generally
 available
Thread-Index: AQHacAIY+TqH49H5RUGAtAfs7ysC8bEsW7gA
Date: Thu, 7 Mar 2024 14:43:50 +0000
Message-ID: <267d9173-2a0e-4006-a858-4e94aeff94df@csgroup.eu>
References: <cover.1709676663.git.jcalvinowens@gmail.com>
 <a6b162aed1e6fea7f565ef9dd0204d6f2284bcce.1709676663.git.jcalvinowens@gmail.com>
In-Reply-To:
 <a6b162aed1e6fea7f565ef9dd0204d6f2284bcce.1709676663.git.jcalvinowens@gmail.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|PR0P264MB2375:EE_
x-ms-office365-filtering-correlation-id: 66558de3-5c6a-495c-f8ad-08dc3eb50144
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 FrAGkrTz6hH++qxeEqySxVje8H6iRLtYIUrlFvhp+G1yoNlEoWenbqc4ORyCBHvakdSdM55rI6kt/4u4rIfSdeofFjE87rWBzaGO5ZV5E//nXSCvOizdwMYhZYXCe4kaXgIoByG5jsTTRXOK5FuAnstKnQ3fw9ejvSCu1pRJR2jXk9aBzVWClm+eT3CXCyVOcDWBUsWr4vbLpJNe+v0F19lLM4rzrw2prIehq86xVvdoLgnRBe7Cx+LETFEvk8UC0fdX3Z/iAMGI9gn4wsI+OyOtLNwjMSWZZZeP2s8gHsgUQfHd+1rei43xhIFsaOZ8CPtPJNIg1UaYVRdPMNZrZhOmDEoAMR8UxupW9Oty2Q2euBo4Vql/6JJPS9lJSggnOMkt0fCn8anu2UE7z4rgK8FUDV4cQN8nDPJW1gbfHkjSBXJAIGyLje3QLgUtMFvuJ3l2TvdutALsRklNR2XDucAIEx8GojJ1RRAi7YVagaQZdbOJF50iSnNWZgwNryIlxwxE7CDs0ckD9JbwBSbqNdBFRFNQm+cpUzcYH565jFlUv7LJnKW/6kmwgVh+NF4TIUBOJsVQBf6gbMuGtf2hd/8ms4YigZ3ED/MESsfzU0AtxS6hMwQWVt0GC29XgD8IjjM1nStUtsSdWPvhcw6E9/H+Q/llNwxzETHzZgTOeYAco2FDNL8xruhluL8daBIB
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009)(921011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?c0QvL1E4ZXJiUnhZd0JWaGhMa1pFMVY3eituYUpRSVpDYm5mV3dZVytMd2ZC?=
 =?utf-8?B?a0NvMlBsUlJsWnNWbUwzS0htKzM3M3NmbTB1UTRJQW1naXdBSjdvUE8xNWlp?=
 =?utf-8?B?cWtjN2NXSVFWTjN3VFVBVVNPalBjSDl2RVd3TFRaYTdEY09LSlpoOWcwWm9B?=
 =?utf-8?B?c1RDUFBDNmVWV0F3SmZsRE5zdEVpN1hpcjBVZzhHL2dzNzA3MFJDa2xiQkpy?=
 =?utf-8?B?NWpqMU4wQUdSMEUxektQcU5sWTl5VmJvMEtOTDIxaU5ueTZSY3NwNm0zOUNp?=
 =?utf-8?B?akNCUlc5eWNUc0orbFd6eGsrR0FZdzN0Qnl5azhVeldBLzQ4UHVHUVh0aks3?=
 =?utf-8?B?Mk1QWFVKZDlFL0RtNmtPTTl0OXNoYmlYSkFPRTN0QjJZVWY2Z0xJRFlBUXF3?=
 =?utf-8?B?MzIyNFNEQ1ZCS2VTMldkbHdWdUVFTkdHQ3hNRm1Zc3BoSG5HaGFMcGc3ZnV6?=
 =?utf-8?B?TGxLbkhmNlkwWEY3aE5FSXB2VzQzWExPVDJvL0ROV3B4OHZqclFmdk1NVGF1?=
 =?utf-8?B?OFNvTTBtajZ1N0hpMjJ5UWxUbi8wWE9zMm9udm1hL05nMzllaXpYSm5RaHdD?=
 =?utf-8?B?Qkc1ME5Ed3Z2MXNFbnc5SUtHQmtrcWZmSHU1UUd5UXg0TmVYc2doenVQd0cy?=
 =?utf-8?B?TG9RYzk2ZENEclJpemtFanBjSWdXRktpN3pLV2U2c1FlRDRYTVRwd2tkVXNJ?=
 =?utf-8?B?UlFueklQa0xrcW1vMDVlc2pGVEZVQVhTbjdtTTFOWlc3eTd1d0d1aS9qVW9m?=
 =?utf-8?B?ekJCUHE1NjhmbmhvMFUwWDJBZ3kyOUlzUmEwdmdaVU82RThyOXlzSnM3VCtP?=
 =?utf-8?B?c1YrTXlyYjluYzFrVDNBZll5b0VPOVhBY3pKSHMxdDE4dnRnWXZMZGtqdHVX?=
 =?utf-8?B?T2N0QTArUzIrSCt2ckpFVE83Z0pDUXNZMEY5NG1peEUrcUZpOWdCL1BUYWlT?=
 =?utf-8?B?Sk4xSk44UjRNS3NsR0Ryb1VQVmJYMW0xZUlESHRCVk1aWFRsSHNrMUpwNmFp?=
 =?utf-8?B?ZTNjeG4ydVdUZXp5ZDVqQ2lOWUZ1R3FxME1lYXNEYnVoZE5kam1PcFdONHVH?=
 =?utf-8?B?QnNEc0F2Nk5LZGkrUTRZdWFDZnRwZDZEb09hbVplUTVrOHFHV2xvOHFqV3B2?=
 =?utf-8?B?Mm5UVFF0NFNUVStnWnZaN0o2TEFSei9qRFRJYlo2M01HRkRFODRjZ2RNOGVn?=
 =?utf-8?B?ZE1aTVVkdkdqM0RYK0F6QUE4OWZ5RTRwTlJOMGNyN3Z5Qjl4T2s3bHlLaXpM?=
 =?utf-8?B?bHZMTVgrT1VBYjV5QTVOUVBUUlZKcFhUZzArdVlZYUxMZFpJaVJtWWhrOXh1?=
 =?utf-8?B?K0UxK3VxalJVZjh2Lys4STNCYnJoUWFYRmczdVdGdWloNHYveSs1VUNLK01i?=
 =?utf-8?B?Uk1NMVRtdHdmVWRQMzZTN2VUYWJ2b2RqSUFUVlZ0cVdSOTY4bDNBVHVLSGVi?=
 =?utf-8?B?ZUNPS1lHMXVIMzNOOEJ0VnJOY2tuQzRBZGNRaTlHN1hkNUUxVllWaU5seXpY?=
 =?utf-8?B?bkhYNlBTTDdvako5VGhUS0RSQUlZZkxWM3BDdnhRWjhjOFF4QkpldVJscHlS?=
 =?utf-8?B?QkZkSThpbFREVDk4WmUvcDlxQUlmQXRVek11T0pialpwUU1qcVdzZlBmYTI0?=
 =?utf-8?B?SmVOUWczVFZJV0NVZGFuSFQyanNsSjNabTd5Q2tWT2xVNzBQWlFZaG51NWc5?=
 =?utf-8?B?dmNiRncydFFaNitreVNuOWtEam41SE13VE9PeTlub1Q1U1hDdUJEMmN0UmNq?=
 =?utf-8?B?eFFoSFR1YUMvNFBSbDE3M0ZaWGxoSzRoRDBhUXUxalc2RTJHUXFLKzZmZitQ?=
 =?utf-8?B?L2xLTjlnTEhDb2dzVmFKWHh6eWI1RzNnVENpL0lWL3lkM0xteUNiNHk3UmdY?=
 =?utf-8?B?dDhLbDlpclFLaExBTHZTTUhnZUlYQUtwSytlRlFnR2xTYjd4d3UwbE9zQVZj?=
 =?utf-8?B?M0FLOVJWQkRncnNDR2FqZDhqNWl2MlZLUWEwb0tOSU9zMVR5NTRCZlN3K1NR?=
 =?utf-8?B?MmJmOXRKL2RNei83MEpOT2xwZUQrMnc1dEg2UVh5ZDhVVjVMZWpRSVJCSUpq?=
 =?utf-8?B?ay9COTIveWluaE5QZ0gvckQwMHBMVjhGS2crNVQzTFRZTG5qdTBqS2pVL0d3?=
 =?utf-8?Q?jWPpmRbnQIqfyNEb1ok7dmNMV?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3A019C138DC32241BDFF7B3F3499E245@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 66558de3-5c6a-495c-f8ad-08dc3eb50144
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2024 14:43:51.0778
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NOFGb2R6q1gO56/kfYF+gEv9QLUtI1NchDoUATyIDuQYHD3RyZxVhITPgcCiA2SeBihFMOr+MhfCmsF09JrfWrjm5IADWL3YfUtQINunvpw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB2375

SGkgQ2FsdmluLA0KDQpMZSAwNi8wMy8yMDI0IMOgIDIxOjA1LCBDYWx2aW4gT3dlbnMgYSDDqWNy
aXTCoDoNCj4gW1ZvdXMgbmUgcmVjZXZleiBwYXMgc291dmVudCBkZSBjb3VycmllcnMgZGUgamNh
bHZpbm93ZW5zQGdtYWlsLmNvbS4gRMOpY291dnJleiBwb3VycXVvaSBjZWNpIGVzdCBpbXBvcnRh
bnQgw6AgaHR0cHM6Ly9ha2EubXMvTGVhcm5BYm91dFNlbmRlcklkZW50aWZpY2F0aW9uIF0NCj4g
DQo+IEJvdGggQlBGX0pJVCBhbmQgS1BST0JFUyBkZXBlbmQgb24gQ09ORklHX01PRFVMRVMsIGJ1
dCBvbmx5IHJlcXVpcmUNCj4gbW9kdWxlX2FsbG9jKCkgaXRzZWxmLCB3aGljaCBjYW4gYmUgZWFz
aWx5IHNlcGFyYXRlZCBpbnRvIGEgc3RhbmRhbG9uZQ0KPiBhbGxvY2F0b3IgZm9yIGV4ZWN1dGFi
bGUga2VybmVsIG1lbW9yeS4NCg0KRWFzaWx5IG1heWJlLCBidXQgbm90IGFzIGVhc2lseSBhcyB5
b3UgdGhpbmssIHNlZSBiZWxvdy4NCg0KPiANCj4gVGhvbWFzIEdsZWl4bmVyIHNlbnQgYSBwYXRj
aCB0byBkbyB0aGF0IGZvciB4ODYgYXMgcGFydCBvZiBhIGxhcmdlcg0KPiBzZXJpZXMgYSBjb3Vw
bGUgeWVhcnMgYWdvOg0KPiANCj4gICAgICBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAy
MjA3MTYyMzA5NTMuNDQyOTM3MDY2QGxpbnV0cm9uaXguZGUvDQo+IA0KPiBJJ3ZlIHNpbXBseSBl
eHRlbmRlZCB0aGF0IGFwcHJvYWNoIHRvIHRoZSB3aG9sZSBrZXJuZWwuDQo+IA0KPiBTaWduZWQt
b2ZmLWJ5OiBDYWx2aW4gT3dlbnMgPGpjYWx2aW5vd2Vuc0BnbWFpbC5jb20+DQo+IC0tLQ0KPiAg
IGFyY2gvS2NvbmZpZyAgICAgICAgICAgICAgICAgICAgIHwgICAyICstDQo+ICAgYXJjaC9hcm0v
a2VybmVsL21vZHVsZS5jICAgICAgICAgfCAgMzUgLS0tLS0tLS0tDQo+ICAgYXJjaC9hcm0vbW0v
TWFrZWZpbGUgICAgICAgICAgICAgfCAgIDIgKw0KPiAgIGFyY2gvYXJtL21tL21vZHVsZV9hbGxv
Yy5jICAgICAgIHwgIDQwICsrKysrKysrKysNCj4gICBhcmNoL2FybTY0L2tlcm5lbC9tb2R1bGUu
YyAgICAgICB8IDEyNyAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gICBhcmNoL2Fy
bTY0L21tL01ha2VmaWxlICAgICAgICAgICB8ICAgMSArDQo+ICAgYXJjaC9hcm02NC9tbS9tb2R1
bGVfYWxsb2MuYyAgICAgfCAxMzAgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiAg
IGFyY2gvbG9vbmdhcmNoL2tlcm5lbC9tb2R1bGUuYyAgIHwgICA2IC0tDQo+ICAgYXJjaC9sb29u
Z2FyY2gvbW0vTWFrZWZpbGUgICAgICAgfCAgIDIgKw0KPiAgIGFyY2gvbG9vbmdhcmNoL21tL21v
ZHVsZV9hbGxvYy5jIHwgIDEwICsrKw0KPiAgIGFyY2gvbWlwcy9rZXJuZWwvbW9kdWxlLmMgICAg
ICAgIHwgIDEwIC0tLQ0KPiAgIGFyY2gvbWlwcy9tbS9NYWtlZmlsZSAgICAgICAgICAgIHwgICAy
ICsNCj4gICBhcmNoL21pcHMvbW0vbW9kdWxlX2FsbG9jLmMgICAgICB8ICAxMyArKysrDQo+ICAg
YXJjaC9uaW9zMi9rZXJuZWwvbW9kdWxlLmMgICAgICAgfCAgMjAgLS0tLS0NCj4gICBhcmNoL25p
b3MyL21tL01ha2VmaWxlICAgICAgICAgICB8ICAgMiArDQo+ICAgYXJjaC9uaW9zMi9tbS9tb2R1
bGVfYWxsb2MuYyAgICAgfCAgMjIgKysrKysrDQo+ICAgYXJjaC9wYXJpc2Mva2VybmVsL21vZHVs
ZS5jICAgICAgfCAgMTIgLS0tDQo+ICAgYXJjaC9wYXJpc2MvbW0vTWFrZWZpbGUgICAgICAgICAg
fCAgIDEgKw0KPiAgIGFyY2gvcGFyaXNjL21tL21vZHVsZV9hbGxvYy5jICAgIHwgIDE1ICsrKysN
Cj4gICBhcmNoL3Bvd2VycGMva2VybmVsL21vZHVsZS5jICAgICB8ICAzNiAtLS0tLS0tLS0NCj4g
ICBhcmNoL3Bvd2VycGMvbW0vTWFrZWZpbGUgICAgICAgICB8ICAgMSArDQo+ICAgYXJjaC9wb3dl
cnBjL21tL21vZHVsZV9hbGxvYy5jICAgfCAgNDEgKysrKysrKysrKw0KDQpNaXNzaW5nIHNldmVy
YWwgcG93ZXJwYyBjaGFuZ2VzIHRvIG1ha2UgaXQgd29yay4gWW91IG11c3QgYXVkaXQgZXZlcnkg
DQp1c2Ugb2YgQ09ORklHX01PRFVMRVMgaW5zaWRlIHBvd2VycGMuIEhlcmUgYXJlIGEgZmV3IGV4
ZW1wbGVzOg0KDQpGdW5jdGlvbiBnZXRfcGF0Y2hfcGZuKCkgdG8gZW5hYmxlIHRleHQgY29kZSBw
YXRjaGluZy4NCg0KYXJjaC9wb3dlcnBjL0tjb25maWcgOiAJc2VsZWN0IEtBU0FOX1ZNQUxMT0MJ
CQlpZiBLQVNBTiAmJiBNT0RVTEVTDQoNCmFyY2gvcG93ZXJwYy9pbmNsdWRlL2FzbS9rYXNhbi5o
Og0KDQojaWYgZGVmaW5lZChDT05GSUdfTU9EVUxFUykgJiYgZGVmaW5lZChDT05GSUdfUFBDMzIp
DQojZGVmaW5lIEtBU0FOX0tFUk5fU1RBUlQJQUxJR05fRE9XTihQQUdFX09GRlNFVCAtIFNaXzI1
Nk0sIFNaXzI1Nk0pDQojZWxzZQ0KI2RlZmluZSBLQVNBTl9LRVJOX1NUQVJUCVBBR0VfT0ZGU0VU
DQojZW5kaWYNCg0KYXJjaC9wb3dlcnBjL2tlcm5lbC9oZWFkXzh4eC5TIGFuZCBhcmNoL3Bvd2Vy
cGMva2VybmVsL2hlYWRfYm9vazNzXzMyLlM6IA0KSW5zdHJ1Y3Rpb25UTEJNaXNzIGludGVycnVw
dCBoYW5kbGVyIG11c3Qga25vdyB0aGF0IHRoZXJlIGlzIGV4ZWN1dGFibGUgDQprZXJuZWwgdGV4
dCBvdXRzaWRlIGtlcm5lbCBjb3JlLg0KDQpGdW5jdGlvbiBpc19tb2R1bGVfc2VnbWVudCgpIHRv
IGlkZW50aWZpZWQgc2VnbWVudHMgdXNlZCBmb3IgbW9kdWxlIHRleHQgDQphbmQgc2V0IE5YIChO
b0V4ZWMpIE1NVSBmbGFnIG9uIG5vbi1tb2R1bGUgc2VnbWVudHMuDQoNCg0KDQo+ICAgYXJjaC9y
aXNjdi9rZXJuZWwvbW9kdWxlLmMgICAgICAgfCAgMTEgLS0tDQo+ICAgYXJjaC9yaXNjdi9tbS9N
YWtlZmlsZSAgICAgICAgICAgfCAgIDEgKw0KPiAgIGFyY2gvcmlzY3YvbW0vbW9kdWxlX2FsbG9j
LmMgICAgIHwgIDE3ICsrKysNCj4gICBhcmNoL3MzOTAva2VybmVsL21vZHVsZS5jICAgICAgICB8
ICAzNyAtLS0tLS0tLS0NCj4gICBhcmNoL3MzOTAvbW0vTWFrZWZpbGUgICAgICAgICAgICB8ICAg
MSArDQo+ICAgYXJjaC9zMzkwL21tL21vZHVsZV9hbGxvYy5jICAgICAgfCAgNDIgKysrKysrKysr
Kw0KPiAgIGFyY2gvc3BhcmMva2VybmVsL21vZHVsZS5jICAgICAgIHwgIDMxIC0tLS0tLS0tDQo+
ICAgYXJjaC9zcGFyYy9tbS9NYWtlZmlsZSAgICAgICAgICAgfCAgIDIgKw0KPiAgIGFyY2gvc3Bh
cmMvbW0vbW9kdWxlX2FsbG9jLmMgICAgIHwgIDMxICsrKysrKysrDQo+ICAgYXJjaC94ODYva2Vy
bmVsL2Z0cmFjZS5jICAgICAgICAgfCAgIDIgKy0NCj4gICBhcmNoL3g4Ni9rZXJuZWwvbW9kdWxl
LmMgICAgICAgICB8ICA1NiAtLS0tLS0tLS0tLS0tDQo+ICAgYXJjaC94ODYvbW0vTWFrZWZpbGUg
ICAgICAgICAgICAgfCAgIDIgKw0KPiAgIGFyY2gveDg2L21tL21vZHVsZV9hbGxvYy5jICAgICAg
IHwgIDU5ICsrKysrKysrKysrKysrDQo+ICAgZnMvcHJvYy9rY29yZS5jICAgICAgICAgICAgICAg
ICAgfCAgIDIgKy0NCj4gICBrZXJuZWwvbW9kdWxlL0tjb25maWcgICAgICAgICAgICB8ICAgMSAr
DQo+ICAga2VybmVsL21vZHVsZS9tYWluLmMgICAgICAgICAgICAgfCAgMTcgLS0tLQ0KPiAgIG1t
L0tjb25maWcgICAgICAgICAgICAgICAgICAgICAgIHwgICAzICsNCj4gICBtbS9NYWtlZmlsZSAg
ICAgICAgICAgICAgICAgICAgICB8ICAgMSArDQo+ICAgbW0vbW9kdWxlX2FsbG9jLmMgICAgICAg
ICAgICAgICAgfCAgMjEgKysrKysNCj4gICBtbS92bWFsbG9jLmMgICAgICAgICAgICAgICAgICAg
ICB8ICAgMiArLQ0KPiAgIDQyIGZpbGVzIGNoYW5nZWQsIDQ2NyBpbnNlcnRpb25zKCspLCA0MDIg
ZGVsZXRpb25zKC0pDQoNCi4uLg0KDQo+IGRpZmYgLS1naXQgYS9tbS9LY29uZmlnIGIvbW0vS2Nv
bmZpZw0KPiBpbmRleCBmZmMzYTJiYTNhOGMuLjkyYmZiNWFlMmU5NSAxMDA2NDQNCj4gLS0tIGEv
bW0vS2NvbmZpZw0KPiArKysgYi9tbS9LY29uZmlnDQo+IEBAIC0xMjYxLDYgKzEyNjEsOSBAQCBj
b25maWcgTE9DS19NTV9BTkRfRklORF9WTUENCj4gICBjb25maWcgSU9NTVVfTU1fREFUQQ0KPiAg
ICAgICAgICBib29sDQo+IA0KPiArY29uZmlnIE1PRFVMRV9BTExPQw0KPiArICAgICAgIGRlZl9i
b29sIG4NCj4gKw0KDQpJJ2QgY2FsbCBpdCBzb21ldGhpbmcgZWxzZSB0aGFuIENPTkZJR19NT0RV
TEVfQUxMT0MgYXMgeW91IHdhbnQgdG8gdXNlIA0KaXQgd2hlbiBDT05GSUdfTU9EVUxFIGlzIG5v
dCBzZWxlY3RlZC4NCg0KU29tZXRoaW5nIGxpa2UgQ09ORklHX0VYRUNNRU1fQUxMT0Mgb3IgQ09O
RklHX0RZTkFNSUNfRVhFQ01FTSA/DQoNCg0KDQpDaHJpc3RvcGhlDQo=

