Return-Path: <linux-kernel+bounces-84604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C32286A8ED
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 08:26:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F07FB2874A1
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 07:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A45D24A0A;
	Wed, 28 Feb 2024 07:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=csgroup.eu header.i=@csgroup.eu header.b="b0t7/zxS"
Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-pr2fra01on2137.outbound.protection.outlook.com [40.107.12.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE3A21350;
	Wed, 28 Feb 2024 07:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.12.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709105164; cv=fail; b=gOt33RVvPSSUSjp8lzhaP508i7OxPj9TMB+x2pdBUGg1mG/JsKK/uHidgkUmguSwrdQapecuqx5/0wT3lYQbAhTrqIfjoDb4Vo3RXswKorslGXTpMikIg5R60r5AjQgkqza8cxloqoQ9L3zkRjBtnunQurc5cb5hzkCo4cU4LO4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709105164; c=relaxed/simple;
	bh=HN+UW6zSd2rJshGuQ3Vw+HR2bDrcOCFkDyOPU8AxLi0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EUJhHb3ey3km0uvu2zFHTcVyfvx6uMpTm2v/sOkjnxf30E9qmInA/+F1QpU/Q2Elb8yIzjfaDyqcmoedEkCNJiqzvQI5fTjNxMSCsyFpiokSIEJ9LSGrnt/0o+QK2Zn3gOyyVK4LqcCO76tJkbuQ1ZuJrtnDxhpwjPSRmP3Onbo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; dkim=pass (2048-bit key) header.d=csgroup.eu header.i=@csgroup.eu header.b=b0t7/zxS; arc=fail smtp.client-ip=40.107.12.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UFpGjl2cC+wnA/m29ihy044/iTSKUthP8D0qlqLRyp3KJsPHyvLgPvFWzQpejQh/RQDBR4M0Myidfzzfllas4PH1KhBXSns/GSTzM65vXVKTiP12kXt4Gcj+li/VKTxJESqOa7rXkrDeJqD1XGMvVl6jgOpPvT3P+ghhjXWmO5MevwTrgT6pHbJP6zUOMOT7xewpSxP6/a73TwmHz+wHMYRBoSAnu99YIbnte4CyQ2LS6TQQbRZB1AUtfV5FLHFFfYZbDhq0KaWOIF9eQzE0BknK47eVyj24Z7sKXc4hi3aq4uscIZWOWvTrUmkISvBFh1/8Mq18fi0APg0OB56SLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HN+UW6zSd2rJshGuQ3Vw+HR2bDrcOCFkDyOPU8AxLi0=;
 b=JMc9D++gOH5eKXdmaAOmGno8+yhCVBoolHMf3imZGMdRZ1dEjLE8Za5WE0Nc+9J69SGUW8fuDgnSfnki9Nvvde7h32/NB4rx1fgCAZNSEw7WnHU/AxCRboRsTcLYb3wmpNG/OjzjueYB8PhDIyt9sPllRezD2rmdJ4Kg+pp23OXfbJNhJOYpN4EBh/Q7OQG4NBTaG+wfU9SnmnkjnMncEIH/5AFnJ5cSUTSMtCNaaL7r8oJiLvMBZGUXhK3jBb4LJQMAam/ta24rWW00Bja/LDxWUhMM8iywDAJz7e7SaKVyo7JJaUi8FLc/qBy9gtQoiqUiNMERQ8D/MKFXcCPV6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HN+UW6zSd2rJshGuQ3Vw+HR2bDrcOCFkDyOPU8AxLi0=;
 b=b0t7/zxS9977EQk7n9WsSwJfjnrhQHOLxvim8XCVbvhs76u6RS99RAJ59xcpfMU3vq42LLRU52MLoUsDrGL9kvdKHygTMIHPgr0LVfYNSUd0GS2FFsfU9RkLZw/nTAhbPDSWbIrtivM7W8qEySiUcLrVFOZx9xm/WCAYNKYxPZS476Ijq/TEIyGvGCh44OyI+xIv2FBqTAsb4fLRnnoFGIF3Ho12LOv71itKoC1ybXffKWR1nDdYv+xDnLOcMz1sT1b42l/RQmTcx3KN/+RBJRnDUXW+IEz+s+bwrFfGainhJcXf+vQFTEZDbdjtoLMl21DEyJc6ujjk6To6O7IIQg==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PR1P264MB3493.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:184::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.39; Wed, 28 Feb
 2024 07:25:58 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::c192:d40f:1c33:1f4e]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::c192:d40f:1c33:1f4e%6]) with mapi id 15.20.7316.037; Wed, 28 Feb 2024
 07:25:58 +0000
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Charlie Jenkins <charlie@rivosinc.com>, "Russell King (Oracle)"
	<linux@armlinux.org.uk>
CC: Guenter Roeck <linux@roeck-us.net>, David Laight
	<David.Laight@aculab.com>, Palmer Dabbelt <palmer@dabbelt.com>, Andrew Morton
	<akpm@linux-foundation.org>, Helge Deller <deller@gmx.de>, "James E.J.
 Bottomley" <James.Bottomley@hansenpartnership.com>, Parisc List
	<linux-parisc@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Palmer Dabbelt
	<palmer@rivosinc.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v10] lib: checksum: Use aligned accesses for ip_fast_csum
 and csum_ipv6_magic tests
Thread-Topic: [PATCH v10] lib: checksum: Use aligned accesses for ip_fast_csum
 and csum_ipv6_magic tests
Thread-Index:
 AQHaZqVM7f0VA9oidkaHzRbh3i5s67EcglMAgABWg4CAABKTgIAADGQAgAAIygCAADniAIAADA6AgAAI14CAAHULAIAAPciAgADorwCAAHaTgA==
Date: Wed, 28 Feb 2024 07:25:58 +0000
Message-ID: <c0449c0a-33bc-49c4-97e3-56a79a6ce93e@csgroup.eu>
References: <7ae930a7-3b10-4470-94ee-89cb650b3349@csgroup.eu>
 <e11fea7a-e99e-4539-a489-0aa145ee65f0@roeck-us.net>
 <ZdzPgSCTntY7JD5i@shell.armlinux.org.uk> <ZdzZ5tk459bgUrgz@ghost>
 <ZdzhRntTHApp0doV@shell.armlinux.org.uk>
 <b13b8847977d4cfa99b6a0c9a0fcbbcf@AcuMS.aculab.com> <Zd0b8SDT8hrG/0yW@ghost>
 <cdd09f7a-83b2-41ba-a32c-9886dd79c43e@roeck-us.net>
 <9b4ce664-3ddb-4789-9d5d-8824f9089c48@csgroup.eu>
 <Zd25XWTkDPuIjpF8@shell.armlinux.org.uk> <Zd58jvN3PjQSe+yt@ghost>
In-Reply-To: <Zd58jvN3PjQSe+yt@ghost>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|PR1P264MB3493:EE_
x-ms-office365-filtering-correlation-id: f89aa118-59cd-496f-b097-08dc382e8224
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 5x3btGdwz4e2pOkIFh5JA4vlQ+blDzKr36P9jpx8KiMqV6JbykEVArwBrrYPh6j0KkhNsmBHBaV5DG8qdN5UCliAkQx1xcw2x7lrl+oGe/HtHfFIMcLS+30eXzlUzVZYYIzETQw8YJRmCc9Pu40qP2t19TjlHHh4ed98NzhFhczoiZf+MfQlVntUWO4ep50ypF9y4pIfrulR+3AtSZBlyAloYHhuPUzE/f7pZWzdQ18q3ZnCK5XAMCULpKaZ09Gsuoz7/HVIzMeh2V20UAIYFZ8qFVxxWNWEQ5KMZuCbIlLzLeAJrTy7eZOzfKxXO08dRsL7GPyzhAOqwhzPaxaL7ZVv4T3MfZlwqiiR/oRAOcSa9R1xCUu2ixPLgWVjTnqj4GypqD+xT2zN8W6QyaW3Ym9WTPyxFJJE90wzlkWp2clhaEJn39pTKscInpDM9+yDCdb2dFerzjFKRbnUJys6Nv1YZZroqb+OBrGIO8syTAe7a6ZUJtmZtVz/Rw2DujTdDUW2Qv8fgfrmQd/QyydIfCXueV+MyBCh16z5z9Wdcw7fsaSb06qnCfvXju812w0mJDxp8rfcP6JEewzR7u2oAcPqBkYA4je1nmH4/8TjOn27nuBwfMGt+YVyq3VlBWfgOC5qN5hy4MosljSGvYY1DKDxk25MHjYHU1aEnoKd+PnlH4Y/1ysDIEIIMuGR2pvScJbVI3OzOQQ/tV+WyqZziw==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VTlEbnlpZ3Vmdytock40NmhUd2NDNWMwSmdwdTRLZGY3VzI1Ny9TN3pROW5Z?=
 =?utf-8?B?UE55ZXMvUUVKS09aQk4yWTV0MjFXSlR4ejdjcW56MDNHdUhhbEg2OGQzUTNI?=
 =?utf-8?B?RFAwaVN3b3RWdngvc0NYbmJvQU9sQlZHSkNXNDZuaDhwajZKNE9ubjhKaCtr?=
 =?utf-8?B?U0VLSWtGU25GM3pnUTdLYzRPTXhpS3VHWUVaZlVGMzdBR0VBM3hvdXNTZGsv?=
 =?utf-8?B?VGg3WmJqbnlaRC9OalhuWmtobGw5U0JxVDhWU05PVEt6V2N1ZURQa1lPR0Ex?=
 =?utf-8?B?RTYyclZSTjJVNGQ3MENZUHgzUDljbi84WGFQam5oYytaSWF6NU1KZnNrakF2?=
 =?utf-8?B?UUQzNzdSWndybG1sRmpzOHRDODZFUGZFRVJoenJsYWhXbkFMekl2aWZYbGxU?=
 =?utf-8?B?SitGUlRkazFvQUZoSC9iZ3k0SUdiY2lsbXZLVWNWeGdaWHVqUnhsUG56NWlL?=
 =?utf-8?B?Z2lRUFlpY1M0MGVkTElneWVRSGlNR3VKWHRQV1JRMTlac3BzMzRFUVVoVHVQ?=
 =?utf-8?B?RXlrTEVJejRVLzJsYlRVTzdVWnBIblNHNGNOVklyM2dHeWxteWs3akgrcDhr?=
 =?utf-8?B?N3dQMWNIWWhBVnd6VHdhb0dwdEJSRUlEU1B1bXRJR3dBTmdMYWRoV2YvVCtG?=
 =?utf-8?B?VVhIN0JHWFVZR0dGc0JjYnBIZXZYb2JmWHZUbGkvdWs3Y2JzeUtYM2tLNTBq?=
 =?utf-8?B?S1prMlM0Nm5tMktiY3BSNGVDL044dGMvcHUrNHJCaFFsdWdqTzMwNFZEa29V?=
 =?utf-8?B?aGVPSEx5b2tZU2xXMHlWcks0dWQrNVdFQkdTa1JQUGhtMTVnNkxZS1AyNWZh?=
 =?utf-8?B?ZDRGNklCTkViM2NBSHV3UWFadXlGUEoxV25SV1lXQzVacURHbTNGbnVTcWRp?=
 =?utf-8?B?Y0N1YjkzTFNWMmxKTmh2S21SazRGYnIyUUpPUjFIN2EvWnFyQzZMd3g3cklB?=
 =?utf-8?B?NkFZUlRzZWtxTHlhdFNaM3hFcUhWZHFSUFFsSmp3eERzS0dCaFVONzBsaUhR?=
 =?utf-8?B?NmtkSmJGZDZrcWxyeUloOGlkSThvRk50NzFWdENCWXhtZ2NWSm12YUg3Sm1x?=
 =?utf-8?B?RkJ4MlRjYWlWRktDUGJvVUFVR1JMcnJIcFdXcDVLUy8rdEk4VkFZVGZXMVdh?=
 =?utf-8?B?QXpZdEN4VmN1ZWthbHkwcFdrU0ZuZE1CNmt2RExVbXk1aERONkJJVHV2YWEr?=
 =?utf-8?B?bG9SRjgrOXVFNlhOanJqWVk0amZjdGQwL2tNR3FoZS80QnhNbkl1cko1VnZa?=
 =?utf-8?B?NURmbU1nbkNKL2hBU3A3ZnhDaXpjZ3FMcFlFS3hLV0l4bHpIR0k4enh0T3c1?=
 =?utf-8?B?NXF4MVIwZTkzM3RuTHIzbFlxMmlHRW9MRmNzakhtR2FVMWk0NTRqcVMvdllY?=
 =?utf-8?B?NFRlN3pBZS94UThiMDdzMStyK3N5NFdPa0pHTHRIZGNHNUdIelJ3Z2tMSjlo?=
 =?utf-8?B?R3g4TGgxemhhb21HRWxOSlVsUWpGd0JnVmlBZ2l3OXpMVEZqMGpxYVkwazZ2?=
 =?utf-8?B?S0x2QUJkay9RVm10VWZqeVNwblozMUpONXpmVVNiUTQycERSbmtUNFZTcTRD?=
 =?utf-8?B?MXZjUGpGbjhTU0N5T0tITTVJWDJ5RXY1a3RkdmZEMmp6MUxraGFISDU0aFU3?=
 =?utf-8?B?eHdGUCtkMDg3REovaVN4aTlKTGF5cWI5K0dBWXNSckpVV2RIMGpudEJScGJV?=
 =?utf-8?B?aEJnbFkyc29EaFhYdW9ocXZSSUtweUthdEFrL1A3Ty9qaFlvWFBrNVpCMkVo?=
 =?utf-8?B?YmFRQlpLNlF6dXdpWVQvVXNHaGlySFdGdE85MFdnWENzQkwrSlFzS1BWZW1V?=
 =?utf-8?B?T1JkK1dzQkMvYjYrL0JVcVo3V2lFK2Y1ZUIvc2dlUjU5MkRpdktNcEd2U3p1?=
 =?utf-8?B?OEVXV0w2OTNuSjBpdUJiSlNrb1Q1YWVPbDhka1FCaVNyRUNLN0h2RWhFM3Zi?=
 =?utf-8?B?NVkwQlJRdDdLVXZCSnpFREo1WjNqZDdnRE1tcjExWnFrRVJUN0E5NVN6QVhX?=
 =?utf-8?B?aDQ0ZjlqZFJCVS9PakIyRWRjU1pPd3EvSTdCc2s1Vi9GN3Iyam96SzZ0SFhn?=
 =?utf-8?B?K1RpdG42bkxla1VCYytITDhRTklwa2pKSVBCT0orL3RRZWxJYnRUMW9hRldB?=
 =?utf-8?Q?i8Z/zbdK2KDQUH3PS/CXDok3I?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D569EBFF86721047AB9B72FBCDAABAAC@FRAP264.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f89aa118-59cd-496f-b097-08dc382e8224
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2024 07:25:58.2244
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NfajRtlvO75MK+5Dyb8jO6Vw0OXQuUyhLOIja5wGRp8x/aFUVK82OsCLKO/0vGV4ifQC5favckkurmi4Dq672odeoDZ3w1Aa+NQn51ZsP9U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR1P264MB3493

DQoNCkxlIDI4LzAyLzIwMjQgw6AgMDE6MjEsIENoYXJsaWUgSmVua2lucyBhIMOpY3JpdMKgOg0K
PiBPbiBUdWUsIEZlYiAyNywgMjAyNCBhdCAxMDoyODo0NUFNICswMDAwLCBSdXNzZWxsIEtpbmcg
KE9yYWNsZSkgd3JvdGU6DQo+PiBPbiBUdWUsIEZlYiAyNywgMjAyNCBhdCAwNjo0NzozOEFNICsw
MDAwLCBDaHJpc3RvcGhlIExlcm95IHdyb3RlOg0KPj4+DQo+Pj4NCj4+PiBMZSAyNy8wMi8yMDI0
IMOgIDAwOjQ4LCBHdWVudGVyIFJvZWNrIGEgw6ljcml0wqA6DQo+Pj4+IE9uIDIvMjYvMjQgMTU6
MTcsIENoYXJsaWUgSmVua2lucyB3cm90ZToNCj4+Pj4+IE9uIE1vbiwgRmViIDI2LCAyMDI0IGF0
IDEwOjMzOjU2UE0gKzAwMDAsIERhdmlkIExhaWdodCB3cm90ZToNCj4+Pj4+PiAuLi4NCj4+Pj4+
Pj4gSSB0aGluayB5b3UgbWlzdW5kZXJzdGFuZC4gIk5FVF9JUF9BTElHTiBvZmZzZXQgaXMgd2hh
dCB0aGUga2VybmVsDQo+Pj4+Pj4+IGRlZmluZXMgdG8gYmUgc3VwcG9ydGVkIiBpcyBhIGdyb3Nz
IG1pc2ludGVycHJldGF0aW9uLiBJdCBpcyBub3QNCj4+Pj4+Pj4gImRlZmluZWQgdG8gYmUgc3Vw
cG9ydGVkIiBhdCBhbGwuIEl0IGlzIHRoZSBfcHJlZmVycmVkXyBhbGlnbm1lbnQNCj4+Pj4+Pj4g
bm90aGluZyBtb3JlLCBub3RoaW5nIGxlc3MuDQo+Pj4+Pg0KPj4+Pj4gVGhpcyBkaXN0aW5jdGlv
biBpcyBhcmJpdHJhcnkgaW4gcHJhY3RpY2UsIGJ1dCBJIGFtIG9wZW4gdG8gYmVpbmcgcHJvdmVu
DQo+Pj4+PiB3cm9uZyBpZiB5b3UgaGF2ZSBkYXRhIHRvIGJhY2sgdXAgdGhpcyBzdGF0ZW1lbnQu
IElmIHRoZSBkcml2ZXIgY2hvb3Nlcw0KPj4+Pj4gdG8gbm90IGZvbGxvdyB0aGlzLCB0aGVuIHRo
ZSBkcml2ZXIgbWlnaHQgbm90IHdvcmsuIEFSTSBkZWZpbmVzIHRoZQ0KPj4+Pj4gTkVUX0lQX0FM
SUdOIHRvIGJlIDIgdG8gcGFkIG91dCB0aGUgaGVhZGVyIHRvIGJlIG9uIHRoZSBzdXBwb3J0ZWQN
Cj4+Pj4+IGFsaWdubWVudC4gSWYgdGhlIGRyaXZlciBjaG9vc2VzIHRvIHBhZCB3aXRoIG9uZSBi
eXRlIGluc3RlYWQgb2YgMg0KPj4+Pj4gYnl0ZXMsIHRoZSBkcml2ZXIgbWF5IGZhaWwgdG8gd29y
ayBhcyB0aGUgQ1BVIG1heSBzdGFsbCBhZnRlciB0aGUNCj4+Pj4+IG1pc2FsaWduZWQgYWNjZXNz
Lg0KPj4+Pj4NCj4+Pj4+Pg0KPj4+Pj4+IEknbSBzdXJlIEkndmUgc2VlbiBjb2RlIHRoYXQgd291
bGQgcmVhbGlnbiBJUCBoZWFkZXJzIHRvIGEgNCBieXRlDQo+Pj4+Pj4gYm91bmRhcnkgYmVmb3Jl
IHByb2Nlc3NpbmcgdGhlbSAtIGJ1dCB0aGF0IG1pZ2h0IG5vdCBoYXZlIGJlZW4gaW4NCj4+Pj4+
PiBMaW51eC4NCj4+Pj4+Pg0KPj4+Pj4+IEknbSBhbHNvIHN1cmUgdGhlcmUgYXJlIGNwdSB3aGlj
aCB3aWxsIGZhdWx0IGRvdWJsZSBsZW5ndGggbWlzYWxpZ25lZA0KPj4+Pj4+IG1lbW9yeSB0cmFu
c2ZlcnMgLSB3aGljaCBtaWdodCBiZSB1c2VkIHRvIG1hcmdpbmFsbHkgc3BlZWQgdXAgY29kZS4N
Cj4+Pj4+PiBBc3N1bWluZyBtb3JlIHRoYW4gNCBieXRlIGFsaWdubWVudCBmb3IgdGhlIElQIGhl
YWRlciBpcyBsaWtlbHkNCj4+Pj4+PiAnd2lzaGZ1bCB0aGlua2luZycuDQo+Pj4+Pj4NCj4+Pj4+
PiBUaGVyZSBpcyBwbGVudHkgb2YgZXRoZXJuZXQgaGFyZHdhcmUgdGhhdCBjYW4gb25seSB3cml0
ZSBmcmFtZXMNCj4+Pj4+PiB0byBldmVuIGJvdW5kYXJpZXMgYW5kIHBsZW50eSBvZiBjcHUgdGhh
dCBmYXVsdCBtaXNhbGlnbmVkIGFjY2Vzc2VzLg0KPj4+Pj4+IFRoZXJlIGFyZSBldmVuIGNhc2Vz
IG9mIGJvdGggb24gdGhlIHNhbWUgc2lsaWNvbiBkaWUuDQo+Pj4+Pj4NCj4+Pj4+PiBZb3UgYWxz
byBwcmV0dHkgbXVjaCBuZXZlciB3YW50IGEgZmF1bHQgaGFuZGxlciB0byBmaXh1cCBtaXNhbGln
bmVkDQo+Pj4+Pj4gZXRoZXJuZXQgZnJhbWVzIChvciByZWFsbHkgYW55dGhpbmcgZWxzZSBmb3Ig
dGhhdCBtYXR0ZXIpLg0KPj4+Pj4+IEl0IGlzIGFsd2F5cyBnb2luZyB0byBiZSBiZXR0ZXIgdG8g
Y2hlY2sgaW4gdGhlIGNvZGUgaXRzZWxmLg0KPj4+Pj4+DQo+Pj4+Pj4geDg2IGhhcyBqdXN0IG1h
ZGUgcGVvcGxlICdzbG9wcHknIDotKQ0KPj4+Pj4+DQo+Pj4+Pj4gIMKgwqDCoMKgRGF2aWQNCj4+
Pj4+Pg0KPj4+Pj4+IC0NCj4+Pj4+PiBSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1s
ZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywNCj4+Pj4+PiBNSzEgMVBULCBVSw0K
Pj4+Pj4+IFJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo+Pj4+Pj4NCj4+Pj4+DQo+
Pj4+PiBJZiBzb21lYm9keSBoYXMgYSBzb2x1dGlvbiB0aGV5IGRlZW0gdG8gYmUgYmV0dGVyLCBJ
IGFtIGhhcHB5IHRvIGNoYW5nZQ0KPj4+Pj4gdGhpcyB0ZXN0IGNhc2UuIE90aGVyd2lzZSwgSSB3
b3VsZCBhcHByZWNpYXRlIGEgbWFpbnRhaW5lciByZXNvbHZpbmcNCj4+Pj4+IHRoaXMgZGlzY3Vz
c2lvbiBhbmQgYXBwbHkgdGhpcyBmaXguDQo+Pj4+Pg0KPj4+PiBBZ3JlZWQuDQo+Pj4+DQo+Pj4+
IEkgZG8gaGF2ZSBhIGNvdXBsZSBvZiBwYXRjaGVzIHdoaWNoIGFkZCBleHBsaWNpdCB1bmFsaWdu
ZWQgdGVzdHMgYXMgd2VsbCBhcw0KPj4+PiBjb3JuZXIgY2FzZSB0ZXN0cyAod2hpY2ggYXJlIGlu
dGVuZGVkIHRvIHRyaWdnZXIgYXMgbWFueSBjYXJyeSBvdmVyZmxvd3MNCj4+Pj4gYXMgcG9zc2li
bGUpLiBPbmNlIEkgZ2V0IHRob3NlIHdvcmtpbmcgcmVsaWFibHksIEknbGwgYmUgaGFwcHkgdG8g
c3VibWl0DQo+Pj4+IHRoZW0gYXMgYWRkaXRpb25hbCB0ZXN0cy4NCj4+Pj4NCj4+Pg0KPj4+IFRo
ZSBmdW5jdGlvbnMgZGVmaW5pdGVseSBoYXZlIHRvIHdvcmsgYXQgbGVhc3Qgd2l0aCBhbmQgd2l0
aG91dCBWTEFOLA0KPj4+IHdoaWNoIG1lYW5zIHRoZSBhbGlnbm1lbnQgY2Fubm90IGJlIGdyZWF0
ZXIgdGhhbiA0IGJ5dGVzLiBUaGF0J3MgYWxzbw0KPj4+IHRoZSBvdXRjb21lIG9mIHRoZSBkaXNj
dXNzaW9uLg0KPj4NCj4+IFRoYW5rcyBmb3IgY29tcGxldGVseSBpZ25vcmluZyB3aGF0IEkndmUg
c2FpZC4gTm8uIFRoZSBhbGlnbm1lbnQgZW5kcyB1cA0KPj4gYmVpbmcgY29tbW9ubHkgMiBieXRl
cy4NCj4+DQo+PiBBcyBJJ3ZlIHNhaWQgc2V2ZXJhbCB0aW1lcywgbmV0d29yayBkcml2ZXJzIGRv
IF9ub3RfIGhhdmUgdG8gcmVzcGVjdA0KPj4gTkVUX0lQX0FMSUdOLiBUaGVyZSBhcmUgMzItYml0
IEFSTSBkcml2ZXJzIHdoaWNoIGhhdmUgYSBETUEgZW5naW5lIGluDQo+PiB0aGVtIHdoaWNoIGNh
biBvbmx5IERNQSB0byBhIDMyLWJpdCBhbGlnbmVkIGFkZHJlc3MuIFRoaXMgbWVhbnMgdGhhdA0K
Pj4gdGhlIHN0YXJ0IG9mIHRoZSBldGhlcm5ldCBoZWFkZXIgaXMgcGxhY2VkIGF0IGEgMzItYml0
IGFsaWduZWQgYWRkcmVzcw0KPj4gbWFraW5nIHRoZSBJUCBoZWFkZXIgbWlzYWxpZ25lZCB0byAz
Mi1iaXQuDQo+Pg0KPj4gSSBkb24ndCBzZWUgd2hhdCBpcyBzbyBkaWZmaWN1bHQgdG8gdW5kZXJz
dGFuZCBhYm91dCB0aGlzLi4uIGJ1dCBpdA0KPj4gc2VlbXMgdGhhdCBteSBjb21tZW50cyBvbiB0
aGlzIGFyZSBiZWluZyBpZ25vcmVkIHRpbWUgYW5kIHRpbWUgYWdhaW4sDQo+PiBhbmQgSSBjYW4g
b25seSB0aGluayB0aGF0IHRob3NlIHdobyBhcmUgaWdub3JpbmcgbXkgY29tbWVudHMgaGF2ZQ0K
Pj4gc29tZSBhbHRlcmlvciBtb3RpdmUgaGVyZS4NCj4+DQo+PiAtLSANCj4+IFJNSydzIFBhdGNo
IHN5c3RlbTogaHR0cHM6Ly93d3cuYXJtbGludXgub3JnLnVrL2RldmVsb3Blci9wYXRjaGVzLw0K
Pj4gRlRUUCBpcyBoZXJlISA4ME1icHMgZG93biAxME1icHMgdXAuIERlY2VudCBjb25uZWN0aXZp
dHkgYXQgbGFzdCENCj4gDQo+IEkgZG9uJ3QgdW5kZXJzdGFuZCBob3cgdGhlIGNhcGFiaWxpdGll
cyBvZiBzb21lIEFSTSBkcml2ZXJzIGZhY3RvciBpbg0KPiBoZXJlLiBJdCBhcHBlYXJzIHRoYXQg
YSBjb21tb24gY2FzZSBmb3IgY2FsbGluZyB0aGlzIGZ1bmN0aW9uIGlzIHRvIHBhc3MNCj4gaW4g
YW4gSVAgaGVhZGVyIHRoYXQgaXMgYWxpZ25lZCBhbG9uZyBhbiBldGhlcm5ldCBoZWFkZXIgKyBO
RVRfSVBfQUxJR04uDQo+IEl0IGlzIHBlcmZlY3RseSBhY2NlcHRhYmxlIHRoYXQgc29tZSBkcml2
ZXJzIGRvbid0IGFsaWduIGFsb25nDQo+IE5FVF9JUF9BTElHTiwgYnV0IHRoYXQgZG9lcyBub3Qg
c2VlbSByZWxldmFudCBoZXJlLg0KPiANCj4gVGhpcyB0ZXN0IGNhc2UgaXMgc3VwcG9zZWQgdG8g
YmUgYXMgdHJ1ZSB0byB0aGUgImdlbmVyYWwgY2FzZSIgYXMNCj4gcG9zc2libGUsIHNvIEkgaGF2
ZSBhbGlnbmVkIHRoZSBkYXRhIGFsb25nIDE0ICsgTkVUX0lQX0FMSUdOLiBPbiBBUk0NCj4gdGhp
cyB3aWxsIGJlIGEgMTYtYnl0ZSBib3VuZGFyeSBzaW5jZSBORVRfSVBfQUxJR04gaXMgMi4gQSBk
cml2ZXIgdGhhdA0KPiBkb2VzIG5vdCBmb2xsb3cgdGhpcyBtYXkgbm90IGJlIGFwcHJvcHJpYXRl
bHkgdGVzdGVkIGJ5IHRoaXMgdGVzdCBjYXNlLA0KPiBidXQgYW55b25lIGlzIHdlbGNvbWUgdG8g
c3VibWl0IGFkZGl0aW9uYWwgdGVzdCBjYXNlcyB0aGF0IGFkZHJlc3MgdGhpcw0KPiBhZGRpdGlv
bmFsIGFsaWdubWVudCBjb25jZXJuLg0KDQpCdXQgdGhlbiB0aGlzIHRlc3QgY2FzZSBpcyBiZWNv
bWluZyBsZXNzIGFuZCBsZXNzIHRydWUgdG8gdGhlICJnZW5lcmFsIA0KY2FzZSIgd2l0aCB0aGlz
IHBhdGNoLCB3aGVyZWFzIHlvdXIgaW5pdGlhbCBpbXBsZW1lbnRhdGlvbiB3YXMgYWxtb3N0IA0K
cGVyZmVjdCBhcyBpdCB3YXMgY292ZXJpbmcgbW9zdCBjYXNlcywgYSBsb3QgbW9yZSB0aGFuIHdo
YXQgd2UgZ2V0IHdpdGggDQp0aGF0IHBhdGNoIGFwcGxpZWQuDQoNCg==

