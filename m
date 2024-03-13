Return-Path: <linux-kernel+bounces-101247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E326387A492
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 10:05:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 124B31C21BF8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 09:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E40DC250E2;
	Wed, 13 Mar 2024 09:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=csgroup.eu header.i=@csgroup.eu header.b="PuzOpvXq"
Received: from PR0P264CU014.outbound.protection.outlook.com (mail-francecentralazon11022019.outbound.protection.outlook.com [52.101.167.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5172230C
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 09:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.167.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710320682; cv=fail; b=NeNZltMD4tH0ToLYAb6vgWWTX10BJW/MakW+ALjAyrP3QAnhT4C0vlKEKOfZmXd9jS96Fev3ztmXSI7n6vJ5HpKkIcHd64RnOo4mCekYFQMJCgtJyb/giiTECPjn815nhIChxlNpwYwPVOmQ8rNuH+bxf3ZBZMv2BwvyrMBovF0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710320682; c=relaxed/simple;
	bh=/B59Ms4siczV6jO6V1JmnXpZA+NdQUjqQDseBGaUE+M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TuNqjnZwq4NfhEIjRNwjcOmzg72J5k6touHEFsp9smTPhnRmDOm7cx/CmUQod/Rvc1bniS31cT7f5LY8n5Abnh8BVI/TNwojIBiYfKT3MzR343TbPwTjRB4klfC6qkjlNakTIB/IXh2ymMt+3GsNaU6COaANPicCUxqQF3Uhz9g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; dkim=pass (2048-bit key) header.d=csgroup.eu header.i=@csgroup.eu header.b=PuzOpvXq; arc=fail smtp.client-ip=52.101.167.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XEhnuMjsg69bfGofCPB1BDLeShVw8oRUiSyxqIHcv/O98su/XxwWHcUBZyUUTREhxW9IzNYzYWjY9YIseJlnMlZNdiZ0Kb692R5IofdfoEI3C/HUrKkPhXDjPfKdRS1AscEABv9IDBy9Tha4/YGGRYRLNEvlXNUTca/rVNH0Dte1i9WgBnC0aO9HyaGEBQvyPlg35rgUZAn2bWdj7yNS1mj9HwAH5ie112XD/+j2rt1qsU4BILrgRrGVb0HJMIFQFHWRESfeKZqS2dfXkCuR58HFlhm008lCtywtU+MiOS2vJkvqWwAuesRmkegRVaHIitdnuyMyALFa5kh3ayEmDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/B59Ms4siczV6jO6V1JmnXpZA+NdQUjqQDseBGaUE+M=;
 b=IHxy5EgSvxkKN8OUbD3Ldb3kadNExIH4q50OdlWmqOguGMrjB0uoJTcbd2cTo4S0yj27/Rbp/YSh04Jn9vS0d0qs9YVX6mic1XWn0KTzYPTZwz1Y/O2l+rtuMsoPZyJOWxWs+fWLOMHSo6Mshlwwn4Y6FRyThFWlLYM36Gc7dBSHTUzGa+0zyFbl8JrTD89K+cF7OKu++zsa6xAFDfkPS/y82yICXgpKqwkuAVARcomte73FRm9bqB4zunvpPT5bHPZpB5WFHoZLW7Exsnv12PTEj8bX7qT7LuTaXPjmh9lP0aO6w1OMo/rDWmlWO0n/kWM+P7xVDPHl9KOzh8ebMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/B59Ms4siczV6jO6V1JmnXpZA+NdQUjqQDseBGaUE+M=;
 b=PuzOpvXqwCSgV/8EWR7Rqao7UUPjQzDpMrY30eF3McoHjy8WFTPMCw8iWZFB/bYsvRu3lesjOu0BF+z4d6pK9QCS7ea1pcqoXVf+x98zokR/rSQtZXhRwm2030rSqGNvsopdMib20dqtE3jjEG01o8LdjRUjZ7gxOlco/Uf3MGtGUleUiCCcsxznePM9T+Ib8Xe16QMzP3aVLGRn0rdK+g836UG8kL+UwG6JgfpDdz3yLLnDFMx8sg7MsUhMHdGfe8UG2d/QzfSMkbp6XNrN9xuWWoy+th4wtpSwW1GdrHEGqyzg89C2149pOZp8MKSqqtilKu4MUsVBL0d4ID8a+Q==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PR1P264MB1565.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:193::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.20; Wed, 13 Mar
 2024 09:04:37 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::c192:d40f:1c33:1f4e]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::c192:d40f:1c33:1f4e%6]) with mapi id 15.20.7386.017; Wed, 13 Mar 2024
 09:04:37 +0000
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Rick Edgecombe <rick.p.edgecombe@intel.com>, "Liam.Howlett@oracle.com"
	<Liam.Howlett@oracle.com>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "bp@alien8.de" <bp@alien8.de>,
	"broonie@kernel.org" <broonie@kernel.org>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "debug@rivosinc.com" <debug@rivosinc.com>,
	"hpa@zytor.com" <hpa@zytor.com>, "keescook@chromium.org"
	<keescook@chromium.org>, "kirill.shutemov@linux.intel.com"
	<kirill.shutemov@linux.intel.com>, "luto@kernel.org" <luto@kernel.org>,
	"mingo@redhat.com" <mingo@redhat.com>, "peterz@infradead.org"
	<peterz@infradead.org>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"x86@kernel.org" <x86@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH v3 09/12] mm: Take placement mappings gap into account
Thread-Topic: [PATCH v3 09/12] mm: Take placement mappings gap into account
Thread-Index: AQHadMy2AcD12Qgk5E+xVTk36tMlvLE1YVaA
Date: Wed, 13 Mar 2024 09:04:37 +0000
Message-ID: <615a783a-0912-4539-94bd-f1e09535bf38@csgroup.eu>
References: <20240312222843.2505560-1-rick.p.edgecombe@intel.com>
 <20240312222843.2505560-10-rick.p.edgecombe@intel.com>
In-Reply-To: <20240312222843.2505560-10-rick.p.edgecombe@intel.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|PR1P264MB1565:EE_
x-ms-office365-filtering-correlation-id: 423af22e-06a1-409b-a9dd-08dc433c9c04
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 foElH1SVeGexpPDGrTIv9b+Ro+2DmDzgqOwPVQIKV8iKc+7CJJ1MwV1hThmTprtrmiOvDMUH5stm4+KpTWxkLjE+SR7jVU4Jnq81Wy4PoTghGQgXlih9j9qEPErCGZiTmleLEbvxJxxpnOc+/J95YLnWuFuTSjhq0qk0xYKHrHh/QFeyoQM7lnOiilUkNpYul20V7M5ei8x3hSORs9WPBJd4iIwHPrrM8iLNevTQ1dHtD4zYE9OdsU8diWCskvoZAn8vho58VaQGPvNeQNCi8zEJhTkHp2tDT7pDoSqnQJGL7PVxzpiFqNWRuBBXjoNIoq7l5ZKvI3abIcEKizEhGt/tF/1IFlMvtqLJ/1qTFL/mZJMSC6bddpIep06MO2e7mLBiGS/WcRRWS9qQ58N4fghO3m0/j5RcaMOadrApenH+OSFmUawhpxjwr4J9OeVh1qRjyMp6sEA/AgSF44AH2kynP9lm4I0crFvunIdAjU8UajPs9WNWpL4KAvxTbRarSldPFsnI0ug4R1EMtyJkntawABi1pS+uJJa0ibREjjSnCl9LoLtNdGbF/5SP0liOUedb7K3EK0/uPh8ps7gdE03H9IC1EzYfxr02RyvbdixKH47mM6CQoWqZcaeRdTonsUcqyj/kcZgwJecQUpJjQGZtoxbtAM0JXoQiSJG/1hZAqFscHazifgghymf+k6bYqsqKFcBF3sQN7aQ+grKQ5KNZxCe7PZXNpzvWGWDn/Lk=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(38070700009)(921011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZUUxVTQ0ZmN6YU5zRVd3bG8zdGFzY0gzM05wMWJYdFNvNnNaN1hkQ1hMckVJ?=
 =?utf-8?B?MWpoWCsvYXhXOXFuUWwrc3lGdUJmU0t4YTFoTVFGcE9CRlhOZ2tORGtsU092?=
 =?utf-8?B?QU5PREIwU2N0ZWNhUVBKSjIxWkdPR3Z3THROQ1grNFNTVURPUjVJVC9WT255?=
 =?utf-8?B?ZWl1TXdnNDFGM0ZDTXZMZVdMUU1HcFA5djZyYm5tR2h6SXB0UjlWbVZqTmNw?=
 =?utf-8?B?VXE4Qy9FWnVzTHhWRU9iRW12cGM4K0k5VkxFaWkrb1B1U0o1RXRRakd5S2Jk?=
 =?utf-8?B?UXBlT2Q4TFJ2djhXcHZQTmtRdmxtbWFOV1p0NFhBTWZRWWc2TGxqQlN6YzNn?=
 =?utf-8?B?Z0tnNXNSOW4rRFZSVSt6dHdZdjVxeks5MEtCUmk2eGs2RUxRQStKYUJUQTU1?=
 =?utf-8?B?d3dsVjRoR29GZkpseUt2RXFGNlZUeHZWb3JhTlovNk1mS1NtS0hjTmx4ZG82?=
 =?utf-8?B?MytmYjJiMjBZNUR6U24zS2NjNmlrVkhpWTdMMS9iaW5lRVZYS0FsZFI1NDRS?=
 =?utf-8?B?YlFTZmRncDZGd1dEeERBMUxXeE9hd2FPejlsVW5SVm4rb0tMaXM1MzF1Y2dw?=
 =?utf-8?B?K3psTC9jcm1XSWtpaldyYTR4N01mQkExTFhDWFRwT2hoWExYNlprM08xSk5M?=
 =?utf-8?B?N04rdWN6Uzh3bUxTNWRUYVVVTTFzU1hETm1wUk9iNTFBWGtyRXRuVG9oTUw2?=
 =?utf-8?B?Z2xKSDJoTjVRenl2bGYvWW13dzJiSWMva2pTdWNscGpWOHRwNC9LN1p3YnJy?=
 =?utf-8?B?Wm85dk1YcnVGT3o0K3c1Ujg4WUxZQ0t2UzV2YVNVQ0NZdkFkZWE4VmhqRDNI?=
 =?utf-8?B?ZjhXUzhXY3UwbVgxSm9YSnRIUEdhN2lydUtIQzRMczE1S1ZUd29SMGNVQ0Z1?=
 =?utf-8?B?ZC9SZXFoTXBZZHQ3UUh6UllCSFRSREMrcXZzcVZwaE11ZDJTcklLSmlTOFla?=
 =?utf-8?B?eTk5K3dtY0hTUjVoZEtuaDMza1dRVTJtTlRMWW9jQnAzVlhiRDAzb1ozdUFv?=
 =?utf-8?B?VEplcndwMEVhMzJUOElLQ2VYOGUrRDNGWXpHa1NVcXRHV1lVQXczYjNLOG9I?=
 =?utf-8?B?QnVveE1kaS9NaGJydVhrMWI0aW0wMGptVjNOdkdjNVlnQ0g3eVlrTjFXZ2lX?=
 =?utf-8?B?NlJjV21JU1Bpb3lQUUVCaUhjdUkyRWdLdkM3cGV6R3dQNXVIazF0TzQrdzFF?=
 =?utf-8?B?enlZRUJhaWNYOWhMWFJaUXZOSVQzbEZoVUdxSWtjVkZRTmxONmRCODdza096?=
 =?utf-8?B?WURYc051VUZVUWxKWWk4Q2p3YUpoVEZNYTBnY2xhVXMySWNITm9qaGl1bG1G?=
 =?utf-8?B?LzhsMDE2Ly94MG9FZW1VNEo1eHlhd1RDWGo5VG1hd1hraFNsakRKUWJSVlli?=
 =?utf-8?B?N245S3llTzEyRVBLZDM2WmU5SUIxbGNuTy93V01oSDl3MHlzZUZHTFBBTy9S?=
 =?utf-8?B?YzNWT1FNdE9NMWRmd3AweGozQ05QRmw1ZlJnT2h6NHZOdWtrY09XaG1saW1l?=
 =?utf-8?B?Y2IrWGpESjUxdHlGU2RZRFRsbjQxNytkMSs5ME0xcjQ3UjM3d255ZENPVlhy?=
 =?utf-8?B?NE92QlR3QmtEL2N2NzFPQlBmdEFJMldmNlFvMDYycWpUUHVYYnB0ZW5rRXBI?=
 =?utf-8?B?ekFvRGIrWEl2SFdta09hN1RDYms1dlpUWDR3OXloODY4NTlTb0czUDRuMHBr?=
 =?utf-8?B?emx1NEF6Y0tuR2JXRmQ2UnFUQlBTaFZGenZtY0lGRlAvV1RHSXZzMStwaHFk?=
 =?utf-8?B?NzM3MTNBL1UwWHdlUWdMam9yTnFTaFh5aktQenpKM05SdW04aGp2RklQeDJJ?=
 =?utf-8?B?cWZBU0FBeTliUkcrYW0weW1jbUhRNVA1eUxsbEZYSzhBSElvaFlDcXVxV1Nq?=
 =?utf-8?B?MG5Vdkw4RzUrMEVQMitoSEp5c0g5OHdHT1NGa3FPQWQyWld2KzhiU1ZMZkdQ?=
 =?utf-8?B?eGFTcmVBNTF0T2JmT0N5OEEvOUM1NXY3UUJsbUVyOTdSdXJlUHZacmhtM3dW?=
 =?utf-8?B?dzloamVYL0dNOHpYMzBmc2R6bnJKaFNqQmFTQ1VrM0orZHBNTkw1WWR1S09P?=
 =?utf-8?B?Y0JhZkpiSk9HaWd4bWhSM1YxTlduTERkcWlLdCtJZkdSSjRDMldEMzBMSHpL?=
 =?utf-8?Q?7C7L/D7T6BXdSgoRw0JWVTK2m?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7A0CC3F8BC58BE4096D379AE805D2AF6@FRAP264.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 423af22e-06a1-409b-a9dd-08dc433c9c04
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2024 09:04:37.4321
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: isr8XUAbeZTcIGg9SFAXprJlyjtXN/4pfJYgZ6fDpHIOSeOdQk+3GCnbN2OZJDV/ZgkotBgQBeQcCxetLc+n37nDtqVk+0kK9zHHisYYK7Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR1P264MB1565

DQoNCkxlIDEyLzAzLzIwMjQgw6AgMjM6MjgsIFJpY2sgRWRnZWNvbWJlIGEgw6ljcml0wqA6DQo+
IFdoZW4gbWVtb3J5IGlzIGJlaW5nIHBsYWNlZCwgbW1hcCgpIHdpbGwgdGFrZSBjYXJlIHRvIHJl
c3BlY3QgdGhlIGd1YXJkDQo+IGdhcHMgb2YgY2VydGFpbiB0eXBlcyBvZiBtZW1vcnkgKFZNX1NI
QURPV1NUQUNLLCBWTV9HUk9XU1VQIGFuZA0KPiBWTV9HUk9XU0RPV04pLiBJbiBvcmRlciB0byBl
bnN1cmUgZ3VhcmQgZ2FwcyBiZXR3ZWVuIG1hcHBpbmdzLCBtbWFwKCkNCj4gbmVlZHMgdG8gY29u
c2lkZXIgdHdvIHRoaW5nczoNCj4gICAxLiBUaGF0IHRoZSBuZXcgbWFwcGluZyBpc27igJl0IHBs
YWNlZCBpbiBhbiBhbnkgZXhpc3RpbmcgbWFwcGluZ3MgZ3VhcmQNCj4gICAgICBnYXBzLg0KPiAg
IDIuIFRoYXQgdGhlIG5ldyBtYXBwaW5nIGlzbuKAmXQgcGxhY2VkIHN1Y2ggdGhhdCBhbnkgZXhp
c3RpbmcgbWFwcGluZ3MNCj4gICAgICBhcmUgbm90IGluICppdHMqIGd1YXJkIGdhcHMuDQo+IA0K
PiBUaGUgbG9uZyBzdGFuZGluZyBiZWhhdmlvciBvZiBtbWFwKCkgaXMgdG8gZW5zdXJlIDEsIGJ1
dCBub3QgdGFrZSBhbnkgY2FyZQ0KPiBhcm91bmQgMi4gU28gZm9yIGV4YW1wbGUsIGlmIHRoZXJl
IGlzIGEgUEFHRV9TSVpFIGZyZWUgYXJlYSwgYW5kIGENCj4gbW1hcCgpIHdpdGggYSBQQUdFX1NJ
WkUgc2l6ZSwgYW5kIGEgdHlwZSB0aGF0IGhhcyBhIGd1YXJkIGdhcCBpcyBiZWluZw0KPiBwbGFj
ZWQsIG1tYXAoKSBtYXkgcGxhY2UgdGhlIHNoYWRvdyBzdGFjayBpbiB0aGUgUEFHRV9TSVpFIGZy
ZWUgYXJlYS4gVGhlbg0KPiB0aGUgbWFwcGluZyB0aGF0IGlzIHN1cHBvc2VkIHRvIGhhdmUgYSBn
dWFyZCBnYXAgd2lsbCBub3QgaGF2ZSBhIGdhcCB0bw0KPiB0aGUgYWRqYWNlbnQgVk1BLg0KPiAN
Cj4gRm9yIE1BUF9HUk9XU0RPV04vVk1fR1JPV1NET1dOIGFuZCBNQVBfR1JPV1NVUC9WTV9HUk9X
U1VQIHRoaXMgaGFzIG5vdA0KPiBiZWVuIGEgcHJvYmxlbSBpbiBwcmFjdGljZSBiZWNhdXNlIGFw
cGxpY2F0aW9ucyBwbGFjZSB0aGVzZSBraW5kcyBvZg0KPiBtYXBwaW5ncyB2ZXJ5IGVhcmx5LCB3
aGVuIHRoZXJlIGlzIG5vdCBtYW55IG1hcHBpbmdzIHRvIGZpbmQgYSBzcGFjZQ0KPiBiZXR3ZWVu
LiBCdXQgZm9yIHNoYWRvdyBzdGFja3MsIHRoZXkgbWF5IGJlIHBsYWNlZCB0aHJvdWdob3V0IHRo
ZSBsaWZldGltZQ0KPiBvZiB0aGUgYXBwbGljYXRpb24uDQo+IA0KPiBVc2UgdGhlIHN0YXJ0X2dh
cCBmaWVsZCB0byBmaW5kIGEgc3BhY2UgdGhhdCBpbmNsdWRlcyB0aGUgZ3VhcmQgZ2FwIGZvcg0K
PiB0aGUgbmV3IG1hcHBpbmcuIFRha2UgY2FyZSB0byBub3QgaW50ZXJmZXJlIHdpdGggdGhlIGFs
aWdubWVudC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFJpY2sgRWRnZWNvbWJlIDxyaWNrLnAuZWRn
ZWNvbWJlQGludGVsLmNvbT4NCj4gLS0tDQo+IHYzOg0KPiAgIC0gU3BlbGxpbmcgZml4IGluIGNv
bW1lbnQNCj4gDQo+IHYyOg0KPiAgIC0gUmVtb3ZlIFZNX1VOTUFQUEVEX1NUQVJUX0dBUF9TRVQg
YW5kIGhhdmUgc3RydWN0IHZtX3VubWFwcGVkX2FyZWFfaW5mbw0KPiAgICAgaW5pdGlhbGl6ZWQg
d2l0aCB6ZXJvcyAoaW4gYW5vdGhlciBwYXRjaCkuIChLaXJpbGwpDQo+ICAgLSBEcm9wIHVucmVs
YXRlZCBzcGFjZSBjaGFuZ2UgKEtpcmlsbCkNCj4gICAtIEFkZCBjb21tZW50IGFyb3VuZCBpbnRl
cmFjdGlvbnMgb2YgYWxpZ25tZW50IGFuZCBzdGFydCBnYXAgc3RlcA0KPiAgICAgKEtpcmlsbCkN
Cj4gLS0tDQo+ICAgaW5jbHVkZS9saW51eC9tbS5oIHwgIDEgKw0KPiAgIG1tL21tYXAuYyAgICAg
ICAgICB8IDEyICsrKysrKysrKy0tLQ0KPiAgIDIgZmlsZXMgY2hhbmdlZCwgMTAgaW5zZXJ0aW9u
cygrKSwgMyBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L21t
LmggYi9pbmNsdWRlL2xpbnV4L21tLmgNCj4gaW5kZXggZDkxY2RlNzlhYWVlLi5kZWFkZTdiZTAw
ZDAgMTAwNjQ0DQo+IC0tLSBhL2luY2x1ZGUvbGludXgvbW0uaA0KPiArKysgYi9pbmNsdWRlL2xp
bnV4L21tLmgNCj4gQEAgLTM0MTgsNiArMzQxOCw3IEBAIHN0cnVjdCB2bV91bm1hcHBlZF9hcmVh
X2luZm8gew0KPiAgIAl1bnNpZ25lZCBsb25nIGhpZ2hfbGltaXQ7DQo+ICAgCXVuc2lnbmVkIGxv
bmcgYWxpZ25fbWFzazsNCj4gICAJdW5zaWduZWQgbG9uZyBhbGlnbl9vZmZzZXQ7DQo+ICsJdW5z
aWduZWQgbG9uZyBzdGFydF9nYXA7DQoNCk9ubHkgYSBzdGFydF9nYXAgaXMgbmVlZGVkID8gTm8g
bmVlZCBvZiBhbiBlbmRfZ2FwID8NCg0KPiAgIH07DQo+ICAgDQo+ICAgZXh0ZXJuIHVuc2lnbmVk
IGxvbmcgdm1fdW5tYXBwZWRfYXJlYShzdHJ1Y3Qgdm1fdW5tYXBwZWRfYXJlYV9pbmZvICppbmZv
KTsNCj4gZGlmZiAtLWdpdCBhL21tL21tYXAuYyBiL21tL21tYXAuYw0KPiBpbmRleCBiODg5Yzc5
ZDExYmQuLjYzNGU3MDZmZDk3ZSAxMDA2NDQNCj4gLS0tIGEvbW0vbW1hcC5jDQo+ICsrKyBiL21t
L21tYXAuYw0KPiBAQCAtMTU4Miw3ICsxNTgyLDcgQEAgc3RhdGljIHVuc2lnbmVkIGxvbmcgdW5t
YXBwZWRfYXJlYShzdHJ1Y3Qgdm1fdW5tYXBwZWRfYXJlYV9pbmZvICppbmZvKQ0KPiAgIAlNQV9T
VEFURShtYXMsICZjdXJyZW50LT5tbS0+bW1fbXQsIDAsIDApOw0KPiAgIA0KPiAgIAkvKiBBZGp1
c3Qgc2VhcmNoIGxlbmd0aCB0byBhY2NvdW50IGZvciB3b3JzdCBjYXNlIGFsaWdubWVudCBvdmVy
aGVhZCAqLw0KPiAtCWxlbmd0aCA9IGluZm8tPmxlbmd0aCArIGluZm8tPmFsaWduX21hc2s7DQo+
ICsJbGVuZ3RoID0gaW5mby0+bGVuZ3RoICsgaW5mby0+YWxpZ25fbWFzayArIGluZm8tPnN0YXJ0
X2dhcDsNCj4gICAJaWYgKGxlbmd0aCA8IGluZm8tPmxlbmd0aCkNCj4gICAJCXJldHVybiAtRU5P
TUVNOw0KPiAgIA0KPiBAQCAtMTU5NCw3ICsxNTk0LDEzIEBAIHN0YXRpYyB1bnNpZ25lZCBsb25n
IHVubWFwcGVkX2FyZWEoc3RydWN0IHZtX3VubWFwcGVkX2FyZWFfaW5mbyAqaW5mbykNCj4gICAJ
aWYgKG1hc19lbXB0eV9hcmVhKCZtYXMsIGxvd19saW1pdCwgaGlnaF9saW1pdCAtIDEsIGxlbmd0
aCkpDQo+ICAgCQlyZXR1cm4gLUVOT01FTTsNCj4gICANCj4gLQlnYXAgPSBtYXMuaW5kZXg7DQo+
ICsJLyoNCj4gKwkgKiBBZGp1c3QgZm9yIHRoZSBnYXAgZmlyc3Qgc28gaXQgZG9lc24ndCBpbnRl
cmZlcmUgd2l0aCB0aGUNCj4gKwkgKiBsYXRlciBhbGlnbm1lbnQuIFRoZSBmaXJzdCBzdGVwIGlz
IHRoZSBtaW5pbXVtIG5lZWRlZCB0bw0KPiArCSAqIGZ1bGlsbCB0aGUgc3RhcnQgZ2FwLCB0aGUg
bmV4dCBzdGVwcyBpcyB0aGUgbWluaW11bSB0byBhbGlnbg0KPiArCSAqIHRoYXQuIEl0IGlzIHRo
ZSBtaW5pbXVtIG5lZWRlZCB0byBmdWxpbGwgYm90aC4NCj4gKwkgKi8NCj4gKwlnYXAgPSBtYXMu
aW5kZXggKyBpbmZvLT5zdGFydF9nYXA7DQo+ICAgCWdhcCArPSAoaW5mby0+YWxpZ25fb2Zmc2V0
IC0gZ2FwKSAmIGluZm8tPmFsaWduX21hc2s7DQo+ICAgCXRtcCA9IG1hc19uZXh0KCZtYXMsIFVM
T05HX01BWCk7DQo+ICAgCWlmICh0bXAgJiYgKHRtcC0+dm1fZmxhZ3MgJiBWTV9TVEFSVEdBUF9G
TEFHUykpIHsgLyogQXZvaWQgcHJldiBjaGVjayBpZiBwb3NzaWJsZSAqLw0KPiBAQCAtMTYzMyw3
ICsxNjM5LDcgQEAgc3RhdGljIHVuc2lnbmVkIGxvbmcgdW5tYXBwZWRfYXJlYV90b3Bkb3duKHN0
cnVjdCB2bV91bm1hcHBlZF9hcmVhX2luZm8gKmluZm8pDQo+ICAgDQo+ICAgCU1BX1NUQVRFKG1h
cywgJmN1cnJlbnQtPm1tLT5tbV9tdCwgMCwgMCk7DQo+ICAgCS8qIEFkanVzdCBzZWFyY2ggbGVu
Z3RoIHRvIGFjY291bnQgZm9yIHdvcnN0IGNhc2UgYWxpZ25tZW50IG92ZXJoZWFkICovDQo+IC0J
bGVuZ3RoID0gaW5mby0+bGVuZ3RoICsgaW5mby0+YWxpZ25fbWFzazsNCj4gKwlsZW5ndGggPSBp
bmZvLT5sZW5ndGggKyBpbmZvLT5hbGlnbl9tYXNrICsgaW5mby0+c3RhcnRfZ2FwOw0KPiAgIAlp
ZiAobGVuZ3RoIDwgaW5mby0+bGVuZ3RoKQ0KPiAgIAkJcmV0dXJuIC1FTk9NRU07DQo+ICAgDQo=

