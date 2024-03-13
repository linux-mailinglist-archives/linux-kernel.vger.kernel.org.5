Return-Path: <linux-kernel+bounces-101252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60EFF87A49A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 10:06:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4E4F1F2296E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 09:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C201C383B6;
	Wed, 13 Mar 2024 09:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=csgroup.eu header.i=@csgroup.eu header.b="CdYByf++"
Received: from PA5P264CU001.outbound.protection.outlook.com (mail-francecentralazon11020003.outbound.protection.outlook.com [52.101.167.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E459E36AF3;
	Wed, 13 Mar 2024 09:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.167.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710320689; cv=fail; b=o2n9qtAbVqHJbiumAiaYEkuJAYTCQ8EiGEAwZL6gb7fyBDEH8XweeOmYlA5JYnBIT+uSlIC3myDS5jSrCxhz6x3zhyuRHT+K78soUhGT3t9xgU79ynW4p7m5fP5t48CIJg2D7GORiHZVpHTZ6gRKy94ttJJumfA9S0k69vFOw0E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710320689; c=relaxed/simple;
	bh=T2QC0hCsWBt3VI39v/vnAFFxEtnnH8Rfek/fu5dY1Fc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YZ7NP+j5OyJsledPmw56ev9c7M4LbbzoqfnZlVk40SFGdYEad/bWZqo5zrWRERcxuK8IEi5grtaA1btjETnK73hY41IDBZquScPi+++3x1BlMJq7fO315IgQ2ldeCfuVasRue45iJD5csTm+MIQx6UswvnK+5+fynxIpMcSTibA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; dkim=pass (2048-bit key) header.d=csgroup.eu header.i=@csgroup.eu header.b=CdYByf++; arc=fail smtp.client-ip=52.101.167.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EfDmy4zhT2sQE/mwz4KLkXgnb/fP5J18sMZTYtDQjliErdLKrJTn4mwoN1E6RIaVgrKtpRwRrZA2tTXrldXaUYERhtQPVWX2r1ZTewjWfo558vnbBC1jLWQBZdYMUTcWN54pkEDcOh/VHZdCjm3zwEBZ9qzGYH9idIDV3Qe17pdTY3O6Ok3wMsHSxzLeWudG8TJDYMIWfW7a4qDrDpZ6G0A0HyvXxjhmKLcUDqMC529/tHihzw0l15LWDGaXliqQrZtu31HgEdxRF99Y9QVAamJ6yCWvdwujynO4kNXKQYaKKMGje7HSTntansWd9wqhQ/H0sXJqIR0SDSNI81YbeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T2QC0hCsWBt3VI39v/vnAFFxEtnnH8Rfek/fu5dY1Fc=;
 b=Z2ToWFED4Y9GsqIJsNGT6XldCfyXUbw5+Lp5QFr5p8ZlAKmEET1dxqTti7jPYBPy+K1/EdsHf/PV6yokT1+54RntCQROIlbJ/orlclAvxn8Ru0PaWib4O94ZWnkeb/p5QZqMs7kuFkyQNr28UrASOH77JS7QX8cecTcCFG13WteEdekSMt0nx222xk5xgDwTe/WI4OYOYqfqylIZCNyNkQctxHoK9W5Xc7M4+t8a3Txs+gZHYOAJG8RFvdoWzD0YY8EJTFVZmFGz/Rp64zOD/JWn1hwY3hoOuH7Agx+gVrAdO663XVhKD1kgZ9YmQkfzpNwh0UFnP8pDPo47m6ZyuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T2QC0hCsWBt3VI39v/vnAFFxEtnnH8Rfek/fu5dY1Fc=;
 b=CdYByf++hJdmJ/zO1zFdYaZqtZwZ4jssVDyP/chtmL0GbqZUuPJ3U7ha+tDu1EWa36z7eYrwwf2FMYXh2wYX0DL1FyVyuURcHFC10RX4+SHSA77iNAqvvFYy7qCaL1EDozPK6Hurdtdqwu3aI3MtJJ9gPL7zenCdgKnyAxmyEK9eszhaHE4LjLFoeD5HK2pfoV8G6DSF6oY1GiMhuQIBXLZKXkgq7zbV73rGbAO8zWWJEvQdcv+JOpx3NJRM0H00DdNzkLv1YLi0pmvKdpioBPQg6m/ZZd5ryLPQfJCO3FlVZaqjsQC3srnjP2wJg1ffzzUCvfiYWaZPMJtAqog4Ug==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PAZP264MB2527.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1f1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.19; Wed, 13 Mar
 2024 09:04:43 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::c192:d40f:1c33:1f4e]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::c192:d40f:1c33:1f4e%6]) with mapi id 15.20.7386.017; Wed, 13 Mar 2024
 09:04:43 +0000
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
	"linux-mm@kvack.org" <linux-mm@kvack.org>, Helge Deller <deller@gmx.de>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>
Subject: Re: [PATCH v3 06/12] parisc: Use initializer for struct
 vm_unmapped_area_info
Thread-Topic: [PATCH v3 06/12] parisc: Use initializer for struct
 vm_unmapped_area_info
Thread-Index: AQHadMzQHx9Q/TOuREqSbQq53qZFWbE1YV2A
Date: Wed, 13 Mar 2024 09:04:43 +0000
Message-ID: <32e7ccca-3bb1-4763-9b04-7a15a02a52ac@csgroup.eu>
References: <20240312222843.2505560-1-rick.p.edgecombe@intel.com>
 <20240312222843.2505560-7-rick.p.edgecombe@intel.com>
In-Reply-To: <20240312222843.2505560-7-rick.p.edgecombe@intel.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|PAZP264MB2527:EE_
x-ms-office365-filtering-correlation-id: 1d468621-a46e-4a90-3949-08dc433c9f96
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 oQ2Iy2lkLZVS8vidFpRAFVkDf7F6hyGSLmwaOXl/BghzAE1SzFjnJbajNvXDiVdAjk3U1qDvZNWwmG2q6QHBhDBcg8aELE0zHsO0dglZRw/veTVRW6aNfbkQ3YakPiXcHcvzMP27ScfM/fbbavfsUCiwoDncULbm1EXy9gCYFrbcIZk7G3VKq2jnG9EzLFi0LaE8d7Y6KoTejDZqdF2Hs912e5CDPWOUKc54EYeyjKrlAsDwW2I6AJo4txVzTacf3Jh7bjtGrtG4ZGtIl+hwqu8lhhafD5QhZlaV1V80sBZUNLeJ3pyvXCxWOOVe4hjxS6XekM1Na/ItnaeEwEgMnPA3sZ6hl7ereENzzJz2UnxtbpvUG8a9VFOiehyv7wk+RV/fXTULLEzFBrwwbpgdGxh1ebO9lUFQBBvLxq664is6Z63Gvt1p8MpCF/T0BGpFlidCvehdda1nlaj1D6Jsip66ROBLsQu4fGwshamH7PiOH7dIikkfocE8rTgRTnNrViWn/wKMHe2XyTv25gnnQNIbuGXC3bq5/zq98+7O0yICP3pUJg/1qk4NL/lu2MzsQaYV0myJjyTlW3OyxXt/NBwXUWGtD+g239w4eQ5Pz6dtmzy8A26bs4PspzsQmbIGfdhYWL1epH6t6a/0fdjNPdBDuLVH2goUNG3izv/+lYJbcQiAzE7x+G42PcUkRxbI
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(921011)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UU1udmFpV2tROTVET2dVeTI3UXJkTlJ1L1NpcllpZTJKNzJyMUdGNG8zSm55?=
 =?utf-8?B?bnAxT01TYWJUUW5oRy9QQkNJY2NBUG9pb1Brc3YzelZ2dXZRMkZMd3VsZDZE?=
 =?utf-8?B?VVU2UzFhTGdoZzdTRWhKSGcxQmhEUzlMZlk4ZlVIdXJUemw4RjJGbmlOVWtk?=
 =?utf-8?B?cU1ReXIySlFLdG5pVWJvNmE3VnY5dUpTeFNtS1dmanZMNldaSnM0bmdoYklF?=
 =?utf-8?B?UXE5NG9hVERNalZmOVpXWEZlNklQSXlCbEc2dSt0SHptS2JUSHQ5WDNpZng5?=
 =?utf-8?B?NEQzR1FSclg2a0lZUEJNcytERmFucEJabTMyZlc5TVJRM0dwZjNZWlA4ZUxt?=
 =?utf-8?B?YytubUcydnR4aDg1VjNGbTY2Q3YxZ0ttb0gzRE9GTmxGdDN5aUhKTjFRNnNQ?=
 =?utf-8?B?cFRYaDlPZ0RiaGRtQ1BCVWNOS3gzWTVYUVp6cU0rTnNMRzMyN09vckRXZW9r?=
 =?utf-8?B?ZGZKUTAxbUl2c0xhZFZkNmV1ZW9SRktOYm9vUWN1N2szd0Nqck1Ob0lHdnhB?=
 =?utf-8?B?VmJ2K3FXMWNjUXVFR3FTaDlVa3hmZWZzVU1jak4yNHB1NE9nTXc0b0MxSnY5?=
 =?utf-8?B?NmRjaFhlSkl1RFNBUEd2eklkeUhMZlZLSWVGb0JRbFl6V3lPazY2YlQ4cy96?=
 =?utf-8?B?SnQ5MitwY0hoMmE4SXV2MEMwbjNtdTk2VnFESmt2NDhyZlc0YlZ1SVRmZlBn?=
 =?utf-8?B?VFMwSGt0Z20vNjJadFMxREEvbFdIQ3ZrVExQaFhEWDJvTmlkemM5Mm80bU4w?=
 =?utf-8?B?bE1KcWNmUlFNOWZUOFRwbDlnSG9FNFNDOEJsTCtGODZ2SFJQMzZ5Qm12K1VH?=
 =?utf-8?B?eVF1ditGZDJ2aE4xNU91U1M4R0lSVUIxWGlLUWpsUUpIWFpMcy9LSi9td0Jk?=
 =?utf-8?B?YS8zbUcwZjVxbU05cCtGYnNmcWYzQVdVOUNmVnJNa1luNHpCYmNhWWNCZ3NZ?=
 =?utf-8?B?dEtuMnVaa3lQTUZObkNRdGRwTFNOTTR2YkJDZkpYcUxiOUlkMnNNLzg5Uk5i?=
 =?utf-8?B?Wisvb09uUTVTa3V2M0ZNQThEOGx0Rnp4NjQrWGdJaVN5M0FwQm0zbmFjZllo?=
 =?utf-8?B?OStYQWk3MW95cGdQYXUrbmNOekZxTzhpMmRocGNvb09ySEx3c3o1VnY3NkJP?=
 =?utf-8?B?dEhhQ1RPSE1jSld4bERSZ3dIbE1va0NndjkybHY1eHZPUURFWDJWanByQ0N0?=
 =?utf-8?B?UmhpTjI1azRzNUFRdzBPNm9iZ3YxUTY0bFNpR3BIMXNrMW1ta3JwUGo1Undt?=
 =?utf-8?B?dU8rU21KTTBPNVZKMHJjSStuaDNVaUZHcHdTdVVObmNzeEx3Mk9GWDFKL0Iy?=
 =?utf-8?B?OGRLMlhRZVFBSVlVQkxBbDY3QlpnSjJjcWlWSTN0NkZIUlBzRW9UZEJXT0VN?=
 =?utf-8?B?MStldnY2K05tVjdZcUMwc0VuOE5TZDZYUjhzblE4dHpaRHpVRlVXejZITmlX?=
 =?utf-8?B?Tk9LMldIdG9CTG12TDVoeVZrM1JIb2N4bnZxY05mTFJocHlidHkySzFUdnNQ?=
 =?utf-8?B?bHhUVG9jMzROUUJMWEVZYTN3eXRrNHpmY1JMd3dMS3VMY2ZnYlFjQTNiZ1pt?=
 =?utf-8?B?Qzl2NUQvYjMzNHBjcHJYYnRhbmU0b0hWSDhtNHN6bkgyY0RVTzZEVDRVazRu?=
 =?utf-8?B?V0JidC9oTXgyeEJyd25ZNWVJcVpIUVJJNEZybDNYMm5qaytIak00U2FoNVlH?=
 =?utf-8?B?YkFqMis0c0xnS1R1SnpzTHpTV1dGS0xjVUFkVTA5cUxOYVFZMEY3QzZQdzgz?=
 =?utf-8?B?WCswNm5zOGZMZ3VLcGlKU01XZWU3UHY0VG9xSEZHRUw1TnhuOGd1YXB1MjUv?=
 =?utf-8?B?Vm9SbHk5QjRXd21nR1ZjbjlrVXo5N2xrd3dSRkxaWUtZd1g1ejV0b1hpTDJN?=
 =?utf-8?B?bzhtcmhkSFZFTmY2bnBpam5WaGVvMlptRHlyWUFiY0J6NUZUWU01MnZHYXo5?=
 =?utf-8?B?dE8wSUJUMmVtUkJsc1VnN3pROTRQQUVOUE5uV0ZLZDVMRzhuK0RoSEpsNFAv?=
 =?utf-8?B?dmtvK1RFV3Jad0owWUNqWEp2NEExMndqSXpIR0FIeUtxVHBjNzFGZXhvMWs2?=
 =?utf-8?B?dXJqVSswb3hCS0djdHRVSlk5ZU4vcXp3NkJUN04xenEyd3FUV21zeGpDSGVm?=
 =?utf-8?Q?pgdXinkxGlCV+vXuW3v9/SbHA?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AE128D9C89157B4DBA98E2AEA0948FEF@FRAP264.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d468621-a46e-4a90-3949-08dc433c9f96
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2024 09:04:43.3775
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S741s6fd4ZdR949mM8hpMiZVYzsIrZC/zoSMawg+iefhY2NRV0ODcNNLYkfdzKJ9vO1oVeZdM97NkicreqjtzxI0LNYhiDDBOrZbeNY2qPw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAZP264MB2527

DQoNCkxlIDEyLzAzLzIwMjQgw6AgMjM6MjgsIFJpY2sgRWRnZWNvbWJlIGEgw6ljcml0wqA6DQo+
IEZ1dHVyZSBjaGFuZ2VzIHdpbGwgbmVlZCB0byBhZGQgYSBuZXcgbWVtYmVyIHRvIHN0cnVjdA0K
PiB2bV91bm1hcHBlZF9hcmVhX2luZm8uIFRoaXMgd291bGQgY2F1c2UgdHJvdWJsZSBmb3IgYW55
IGNhbGwgc2l0ZSB0aGF0DQo+IGRvZXNuJ3QgaW5pdGlhbGl6ZSB0aGUgc3RydWN0LiBDdXJyZW50
bHkgZXZlcnkgY2FsbGVyIHNldHMgZWFjaCBtZW1iZXINCj4gbWFudWFsbHksIHNvIGlmIG5ldyBt
ZW1iZXJzIGFyZSBhZGRlZCB0aGV5IHdpbGwgYmUgdW5pbml0aWFsaXplZCBhbmQgdGhlDQo+IGNv
cmUgY29kZSBwYXJzaW5nIHRoZSBzdHJ1Y3Qgd2lsbCBzZWUgZ2FyYmFnZSBpbiB0aGUgbmV3IG1l
bWJlci4NCj4gDQo+IEl0IGNvdWxkIGJlIHBvc3NpYmxlIHRvIGluaXRpYWxpemUgdGhlIG5ldyBt
ZW1iZXIgbWFudWFsbHkgdG8gMCBhdCBlYWNoDQo+IGNhbGwgc2l0ZS4gVGhpcyBhbmQgYSBjb3Vw
bGUgb3RoZXIgb3B0aW9ucyB3ZXJlIGRpc2N1c3NlZCwgYW5kIGEgd29ya2luZw0KPiBjb25zZW5z
dXMgKHNlZSBsaW5rcykgd2FzIHRoYXQgaW4gZ2VuZXJhbCB0aGUgYmVzdCB3YXkgdG8gYWNjb21w
bGlzaCB0aGlzDQo+IHdvdWxkIGJlIHZpYSBzdGF0aWMgaW5pdGlhbGl6YXRpb24gd2l0aCBkZXNp
Z25hdGVkIG1lbWJlciBpbml0aWF0b3JzLg0KPiBIYXZpbmcgc29tZSBzdHJ1Y3Qgdm1fdW5tYXBw
ZWRfYXJlYV9pbmZvIGluc3RhbmNlcyBub3QgemVybyBpbml0aWFsaXplZA0KPiB3aWxsIHB1dCB0
aG9zZSBzaXRlcyBhdCByaXNrIG9mIGZlZWRpbmcgZ2FyYmFnZSBpbnRvIHZtX3VubWFwcGVkX2Fy
ZWEoKSBpZg0KPiB0aGUgY29udmVudGlvbiBpcyB0byB6ZXJvIGluaXRpYWxpemUgdGhlIHN0cnVj
dCBhbmQgYW55IG5ldyBtZW1iZXIgYWRkaXRpb24NCj4gbWlzc2VzIGEgY2FsbCBzaXRlIHRoYXQg
aW5pdGlhbGl6ZXMgZWFjaCBtZW1iZXIgbWFudWFsbHkuDQo+IA0KPiBJdCBjb3VsZCBiZSBwb3Nz
aWJsZSB0byBsZWF2ZSB0aGUgY29kZSBtb3N0bHkgdW50b3VjaGVkLCBhbmQganVzdCBjaGFuZ2UN
Cj4gdGhlIGxpbmU6DQo+IHN0cnVjdCB2bV91bm1hcHBlZF9hcmVhX2luZm8gaW5mbw0KPiB0bzoN
Cj4gc3RydWN0IHZtX3VubWFwcGVkX2FyZWFfaW5mbyBpbmZvID0ge307DQo+IA0KPiBIb3dldmVy
LCB0aGF0IHdvdWxkIGxlYXZlIGNsZWFudXAgZm9yIHRoZSBtZW1iZXJzIHRoYXQgYXJlIG1hbnVh
bGx5IHNldA0KPiB0byB6ZXJvLCBhcyBpdCB3b3VsZCBubyBsb25nZXIgYmUgcmVxdWlyZWQuDQo+
IA0KPiBTbyB0byBiZSByZWR1Y2UgdGhlIGNoYW5jZSBvZiBidWdzIHZpYSB1bmluaXRpYWxpemVk
IG1lbWJlcnMsIGluc3RlYWQNCj4gc2ltcGx5IGNvbnRpbnVlIHRoZSBwcm9jZXNzIHRvIGluaXRp
YWxpemUgdGhlIHN0cnVjdCB0aGlzIHdheSB0cmVlIHdpZGUuDQo+IFRoaXMgd2lsbCB6ZXJvIGFu
eSB1bnNwZWNpZmllZCBtZW1iZXJzLiBNb3ZlIHRoZSBtZW1iZXIgaW5pdGlhbGl6ZXJzIHRvIHRo
ZQ0KPiBzdHJ1Y3QgZGVjbGFyYXRpb24gd2hlbiB0aGV5IGFyZSBrbm93biBhdCB0aGF0IHRpbWUu
IExlYXZlIHRoZSBtZW1iZXJzIG91dA0KPiB0aGF0IHdlcmUgbWFudWFsbHkgaW5pdGlhbGl6ZWQg
dG8gemVybywgYXMgdGhpcyB3b3VsZCBiZSByZWR1bmRhbnQgZm9yDQo+IGRlc2lnbmF0ZWQgaW5p
dGlhbGl6ZXJzLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogUmljayBFZGdlY29tYmUgPHJpY2sucC5l
ZGdlY29tYmVAaW50ZWwuY29tPg0KDQpSZXZpZXdlZC1ieTogQ2hyaXN0b3BoZSBMZXJveSA8Y2hy
aXN0b3BoZS5sZXJveUBjc2dyb3VwLmV1Pg0KDQoNCj4gQWNrZWQtYnk6IEhlbGdlIERlbGxlciA8
ZGVsbGVyQGdteC5kZT4NCj4gQ2M6ICJKYW1lcyBFLkouIEJvdHRvbWxleSIgPEphbWVzLkJvdHRv
bWxleUBIYW5zZW5QYXJ0bmVyc2hpcC5jb20+DQo+IENjOiBIZWxnZSBEZWxsZXIgPGRlbGxlckBn
bXguZGU+DQo+IENjOiBsaW51eC1wYXJpc2NAdmdlci5rZXJuZWwub3JnDQo+IExpbms6IGh0dHBz
Oi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvMjAyNDAyMjgwOTEyLjMzQUVFN0E5Q0ZAa2Vlc2Nvb2sv
I3QNCj4gTGluazogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC9qN2JmdmlnM2dldzNxcnVv
dXhyaDd6N2VoamphZnJna2JjbWc2dGNnaGhmaDNyaG16aUB3emxjb2VjZ3k1cnMvDQo+IC0tLQ0K
PiB2MzoNCj4gICAtIEZpeGVkIHNwZWxsaW5nIGVycm9ycyBpbiBsb2cNCj4gICAtIEJlIGNvbnNp
c3RlbnQgYWJvdXQgZmllbGQgdnMgbWVtYmVyIGluIGxvZw0KPiANCj4gSGksDQo+IA0KPiBUaGlz
IHBhdGNoIHdhcyBzcGxpdCBhbmQgcmVmYWN0b3JlZCBvdXQgb2YgYSB0cmVlLXdpZGUgY2hhbmdl
IFswXSB0byBqdXN0DQo+IHplcm8taW5pdCBlYWNoIHN0cnVjdCB2bV91bm1hcHBlZF9hcmVhX2lu
Zm8uIFRoZSBvdmVyYWxsIGdvYWwgb2YgdGhlDQo+IHNlcmllcyBpcyB0byBoZWxwIHNoYWRvdyBz
dGFjayBndWFyZCBnYXBzLiBDdXJyZW50bHksIHRoZXJlIGlzIG9ubHkgb25lDQo+IGFyY2ggd2l0
aCBzaGFkb3cgc3RhY2tzLCBidXQgdHdvIG1vcmUgYXJlIGluIHByb2dyZXNzLiBJdCBpcyBjb21w
aWxlIHRlc3RlZA0KPiBvbmx5Lg0KPiANCj4gVGhlcmUgd2FzIGZ1cnRoZXIgZGlzY3Vzc2lvbiB0
aGF0IHRoaXMgbWV0aG9kIG9mIGluaXRpYWxpemluZyB0aGUgc3RydWN0cw0KPiB3aGlsZSBuaWNl
IGluIHNvbWUgd2F5cyBoYXMgYSBncmVhdGVyIHJpc2sgb2YgaW50cm9kdWNpbmcgYnVncyBpbiBz
b21lIG9mDQo+IHRoZSBtb3JlIGNvbXBsaWNhdGVkIGNhbGxlcnMuIFNpbmNlIHRoaXMgdmVyc2lv
biB3YXMgcmV2aWV3ZWQgbXkgYXJjaA0KPiBtYWludGFpbmVycyBhbHJlYWR5LCBsZWF2ZSBpdCBh
cyB3YXMgYWxyZWFkeSBhY2tub3dsZWRnZWQuDQo+IA0KPiBUaGFua3MsDQo+IA0KPiBSaWNrDQo+
IA0KPiBbMF0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8yMDI0MDIyNjE5MDk1MS4zMjQw
NDMzLTYtcmljay5wLmVkZ2Vjb21iZUBpbnRlbC5jb20vDQo+IC0tLQ0KPiAgIGFyY2gvcGFyaXNj
L2tlcm5lbC9zeXNfcGFyaXNjLmMgfCA2ICsrKy0tLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAzIGlu
c2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9wYXJp
c2Mva2VybmVsL3N5c19wYXJpc2MuYyBiL2FyY2gvcGFyaXNjL2tlcm5lbC9zeXNfcGFyaXNjLmMN
Cj4gaW5kZXggOThhZjcxOWQ1Zjg1Li5mNzcyMjQ1MTI3NmUgMTAwNjQ0DQo+IC0tLSBhL2FyY2gv
cGFyaXNjL2tlcm5lbC9zeXNfcGFyaXNjLmMNCj4gKysrIGIvYXJjaC9wYXJpc2Mva2VybmVsL3N5
c19wYXJpc2MuYw0KPiBAQCAtMTA0LDcgKzEwNCw5IEBAIHN0YXRpYyB1bnNpZ25lZCBsb25nIGFy
Y2hfZ2V0X3VubWFwcGVkX2FyZWFfY29tbW9uKHN0cnVjdCBmaWxlICpmaWxwLA0KPiAgIAlzdHJ1
Y3Qgdm1fYXJlYV9zdHJ1Y3QgKnZtYSwgKnByZXY7DQo+ICAgCXVuc2lnbmVkIGxvbmcgZmlscF9w
Z29mZjsNCj4gICAJaW50IGRvX2NvbG9yX2FsaWduOw0KPiAtCXN0cnVjdCB2bV91bm1hcHBlZF9h
cmVhX2luZm8gaW5mbzsNCj4gKwlzdHJ1Y3Qgdm1fdW5tYXBwZWRfYXJlYV9pbmZvIGluZm8gPSB7
DQo+ICsJCS5sZW5ndGggPSBsZW4NCj4gKwl9Ow0KPiAgIA0KPiAgIAlpZiAodW5saWtlbHkobGVu
ID4gVEFTS19TSVpFKSkNCj4gICAJCXJldHVybiAtRU5PTUVNOw0KPiBAQCAtMTM5LDcgKzE0MSw2
IEBAIHN0YXRpYyB1bnNpZ25lZCBsb25nIGFyY2hfZ2V0X3VubWFwcGVkX2FyZWFfY29tbW9uKHN0
cnVjdCBmaWxlICpmaWxwLA0KPiAgIAkJCXJldHVybiBhZGRyOw0KPiAgIAl9DQo+ICAgDQo+IC0J
aW5mby5sZW5ndGggPSBsZW47DQo+ICAgCWluZm8uYWxpZ25fbWFzayA9IGRvX2NvbG9yX2FsaWdu
ID8gKFBBR0VfTUFTSyAmIChTSE1fQ09MT1VSIC0gMSkpIDogMDsNCj4gICAJaW5mby5hbGlnbl9v
ZmZzZXQgPSBzaGFyZWRfYWxpZ25fb2Zmc2V0KGZpbHBfcGdvZmYsIHBnb2ZmKTsNCj4gICANCj4g
QEAgLTE2MCw3ICsxNjEsNiBAQCBzdGF0aWMgdW5zaWduZWQgbG9uZyBhcmNoX2dldF91bm1hcHBl
ZF9hcmVhX2NvbW1vbihzdHJ1Y3QgZmlsZSAqZmlscCwNCj4gICAJCSAqLw0KPiAgIAl9DQo+ICAg
DQo+IC0JaW5mby5mbGFncyA9IDA7DQo+ICAgCWluZm8ubG93X2xpbWl0ID0gbW0tPm1tYXBfYmFz
ZTsNCj4gICAJaW5mby5oaWdoX2xpbWl0ID0gbW1hcF91cHBlcl9saW1pdChOVUxMKTsNCj4gICAJ
cmV0dXJuIHZtX3VubWFwcGVkX2FyZWEoJmluZm8pOw0K

