Return-Path: <linux-kernel+bounces-98657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 750FE877D7A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 10:59:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4C191F21C15
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 09:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D9D32C68A;
	Mon, 11 Mar 2024 09:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=csgroup.eu header.i=@csgroup.eu header.b="T8jkMDMf"
Received: from PA5P264CU001.outbound.protection.outlook.com (mail-francecentralazon11020002.outbound.protection.outlook.com [52.101.167.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A842BB01;
	Mon, 11 Mar 2024 09:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.167.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710151133; cv=fail; b=dJZyvZvvV048eneLI9Jp5dqdZIcSvHnspRU3Wj1XpbCRAtOPmouijBlrZB0+lfkYHvu2piYxrQErLyU7X5CA1W/08UFE/N3BCbb41tO4vFMHE7tbvzmSxXSqQj5MDjK73eFGOLL/62yLiU5s+TipDqSMkPDVhXFwOcJK66mYjLM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710151133; c=relaxed/simple;
	bh=7Xoq9fhBoFtV4pGxv2hR14+L3dluDeZnAsd12pMY+zw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=C56QAPZB1cd5jGNU0fyN2wlYOR2UYQDYVe16MiZpXjrta/SCTIUh8lV2pfc0H/2+QXUoCC4ZOwfOJXHG8q/Lt9Rlmg8r2xpfHypnyGNiPEwSE0eEPZJGOnFt9GNC6gwy9OIBX/LSDUDnRrE3vlD1CKwFxV+z2KmxuC1vPJkq3eI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; dkim=pass (2048-bit key) header.d=csgroup.eu header.i=@csgroup.eu header.b=T8jkMDMf; arc=fail smtp.client-ip=52.101.167.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bPIbhak6pybAV5gy/0OATYXGyDxtQSqowuevXmw/l9U+9Zd119ZFyIzlv8r+6ohmETn9Qd6ec/BN/kZT9EM6D8Ug/EfZ+dyUf+IuBwQWbaJlGQREGQI+AAp9odBAmY9N3Ys013Z4+4pbnX9eqf+z3jOyBshpZRk7L65HWIfXoMmHZUGSU+CT/bdxCUxj2d/Q24N4XFDODcKRujHjgdQoNqvp/ZnVF5EVLBT8UaD/dwRORjFkyvYAt/62Ib7/Zeb7634W50Y0WSOwVjPeVu0oRfBRcQ/ct5IF03k8CDYPSqxtVG2u0Z6yNz/uMFBh2/v4UQV5JHmoUnPFy80GC3bBIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Xoq9fhBoFtV4pGxv2hR14+L3dluDeZnAsd12pMY+zw=;
 b=RcHgMSP9fQ48bvCkdaTeD9fOB13SXvPwgS4KWG259y/Zv5BW+60XFNKJ/OjQhjtPA3SsT6nrrpxg66QuCGT3L6LjaZVe1Z49Overwivag1xyFpIpD0OXaGO15HPVyEd+Bky4JFv3ZtIe5cDfvU+PiYtp7D/PmyjKrMGD6uSRMIO+mC4vvba4lceBcFVccBfamTF+ervLNaZAU1Q8KDl7VlXMm0Wxj1rlFk/61ujn5DDVoNkb1RRT4WApucIzLYzOI98Flm+civylfXr/p3VOBs55FvEIZLQYy4N1OaB3LmrTnR4mAZptHF70DN+Vqgm/VR/uIZAonO0f9uOKwTOAeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Xoq9fhBoFtV4pGxv2hR14+L3dluDeZnAsd12pMY+zw=;
 b=T8jkMDMf/Yqmv+IC1XzROl21bUdP0ZdCdK7KLL23ws2ErLAVf1G/0rACPUMHmTDAtMccLiSRpp0GeVZMS/WO0kbcnxhc4i19nQogWM3sHQCvv9hbfOdV7Bk3ZbFNxv1hkPnce3gp1JvyKwz/HHpfKXNPZ3i/DrpVoFixHEB2TvQHNYYYB649RpiTl6rBzVdN4It2jH0aaFnjpL2dClIffCcs8aGPtMp8jbDKKSH7iuttSnhX3K8Ztw7A9s4RfAKh0eiq0Cr7OPG2lh964K1JZ1bYF7cAzPry3VIbvhTB9OzlhSzn75OsoAzBTWPXoBdbBxkb4cOZQ3NHH6bM/Cui7A==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PR0P264MB3452.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:160::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Mon, 11 Mar
 2024 09:58:48 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::c192:d40f:1c33:1f4e]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::c192:d40f:1c33:1f4e%6]) with mapi id 15.20.7362.035; Mon, 11 Mar 2024
 09:58:48 +0000
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: "peterx@redhat.com" <peterx@redhat.com>, "linux-mm@kvack.org"
	<linux-mm@kvack.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, Andrew
 Morton <akpm@linux-foundation.org>, Muchun Song <muchun.song@linux.dev>,
	Jason Gunthorpe <jgg@nvidia.com>, Matthew Wilcox <willy@infradead.org>, Mike
 Rapoport <rppt@kernel.org>, "x86@kernel.org" <x86@kernel.org>,
	"sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH RFC 00/13] mm/treewide: Remove pXd_huge() API
Thread-Topic: [PATCH RFC 00/13] mm/treewide: Remove pXd_huge() API
Thread-Index: AQHab7Ltok77/R0/c0Oqjk3CI/pwxrEyVgWA
Date: Mon, 11 Mar 2024 09:58:47 +0000
Message-ID: <f9b786bf-27d9-4e16-b8d2-2a2666d917df@csgroup.eu>
References: <20240306104147.193052-1-peterx@redhat.com>
In-Reply-To: <20240306104147.193052-1-peterx@redhat.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|PR0P264MB3452:EE_
x-ms-office365-filtering-correlation-id: 78f98eb6-53ed-42fa-56ad-08dc41b1d89f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 D7PYOgYupECBmnLDm1iZQnfmE+KCRjNvlXSodjP+ISjW+TpWlVPvHCfLBbnHalXSqkAj3biNDENDJCzOJL0PWNaWE+QVNy3gktChglfM3wsjcAzhQpeN6EaJ74usQSo/dyvo8LIhzcqBY5E49XZByYys9wt2yG38SvVrOVOXoxIR9xGnTIFvOXZh79378vprBVXMQiwd6ihEFBMlyMBjJTmcGdVnpFjoNW17253CNHB4AzMJjXq27t88PxBF47mp5XXhWD6C3z41VGGI74cfX6Sn6XQ04WHP+2a1T4a5ED44JQVv3mvHv4aB0qZ/KcbXoAm531hcSl09tCFXlm0AHtFNUjXPxV3i/a+QOIaAsCRQHRWfAC7kXGQsG6NOaAFiPMZ6BoTWUN0WmsOsoK5CuKOk57exIQzKk+rH4/JyGeHs/A4m2dlrzB0VVMi5KUaYdwIREIv8nnzsewDGq1XSJmc8hBQjliSNDt6gYD3rywsoG3tltV7b49enzDf0yHIzv2/wGCGwXtTufdxT3LVhlJe1BTk9LubnVUpjlTt51u7iZhVRK2pB7edCfMW/W5Ggl3stDsw942AI97RwdDGDA+voHnhs0kPj75cwWfbcrRplfEDc9cd+9uR3RWjfvNXG9jHEScxNyqrfT+gOSx8UnWD5o0xmwYvtrVMWPDvmi2o=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VUJJSjBWbXpDR3RwR1o4eEoxd3luUXNiVzlIaXg3MW8xODFmT0Y5b0NiYjgr?=
 =?utf-8?B?aThuOU9LNXAwRTZxbU9rK2dVYncyMGpkdUtqVllpRHZ3VzVGODlTdXZPOWJR?=
 =?utf-8?B?azRRWmVrZFRDdlVSd3RQekgyeHVBVTNDK002amFsYjV1cWoxR0UwSVFaQWo5?=
 =?utf-8?B?SGhjVUVIcUV6WVNIV0NBcDZ2OU82UGd6RnFpRzR5eTVrcFZUS0FGUURHZEQv?=
 =?utf-8?B?RlRReEVQc0pXSFo0dmxFTCttMSt3RGZOcDR4U3h4RHc3Q3phUHd6bFdLbGds?=
 =?utf-8?B?a2RUaXNsM1VmanBTRUdlNjRTQVdOeUxoVUtsbXg2TXFKSW9pTmpHMlV6d3Vx?=
 =?utf-8?B?Nysyc1hCNVlkdXVVN1hiRW52aXpHSWNmclgwV1B1THYxZ2wrWUtBcFpxcFZ3?=
 =?utf-8?B?cEc0WDFLOWs2R3VqN2RwWVNtUEtqS2lSazU2TTJOZ1gyUmpBME1GN3JQakVi?=
 =?utf-8?B?YkMzajFZdk1sVVBka1g2QlBsQWdHZ1ZCd3BqRldIMlhYVFJmWXhaQjV1VTV6?=
 =?utf-8?B?Z2hMcE1EZTQ1cmZPTkU0TFJTRkw0VXd2MzRnL2pWRDRkOUU1cmJ3eTNiZlJm?=
 =?utf-8?B?MEt6RVRVZC9FOFVQcmU2ZUcwenBTbldpTFBTZDJHeTNodCt4R1poMlhtdENz?=
 =?utf-8?B?a1lkYS83SDBEdldXUDNpMUVITkY2U0FIeWJhZjRBRVAzR0lqTE90WGNUZVQ0?=
 =?utf-8?B?RXhBeEVNMXdnbzJwVzlwZ0ZsRDFZWnFZZmxPaU1OVnZObGRQN0xjMHpxUFRD?=
 =?utf-8?B?bTRsMkp6czlkR01UQTNrNnJid0hxeEFmdm4rUHBNZy9XM3ZHQi9sQm04RXRh?=
 =?utf-8?B?anRHcjY3bmcwM3Y0WXdoQjZtTXRaRnRnYXkwUkp0NVgxbnZXMldvSG5LNDVa?=
 =?utf-8?B?TDNoVnkrOHMwQlQrZS9WM0QrTXFjL0MySkdCU1dyeXhoM0g2VDRuR0w2bEVu?=
 =?utf-8?B?WFcyWWlrZGtOU3NpRWk5bnk4eGFmNHNoeGhzaG5aOHc1blRmME1KYUtXOUNR?=
 =?utf-8?B?eWs1M24xaUlPL3p4bkJsaVVJYlZYaWRSRjlZM0RLbXJwUElvczQvSGlUdkZG?=
 =?utf-8?B?Q0RtQVZkdTJjWlhGVEpjTmZPOUhJMWtZaUtEZlEzL21hT1RrS2l4QmdJZ3NF?=
 =?utf-8?B?NktUdDhxTTdzcURaNUpOOWNLU2R6OGtqS2hmWUVJdlk0am1TdWhpR0JZMEJs?=
 =?utf-8?B?WGFHTytDbjkzNnVIZkoxeWQxRUQ2NXZ6SjZXVXdmWTRTRE5UQWlOc01QbUxJ?=
 =?utf-8?B?eDFWU05BL3VWTFY4TS9qajlnb3h1aHFaMnBTblFpdzVkYlM2VkJoc2RUM0NE?=
 =?utf-8?B?dEt4ZXdvcEtQVVNVbzFLMDY0a0xnTXpsejBGaE1VdkpKUWJCbzRWWTAzRXF1?=
 =?utf-8?B?bHViallUdVlsYS9BRUhNK2k2MTZMRXJNODV1NzhMMVB2UDFkc0JHMUdaMnU3?=
 =?utf-8?B?ZXU0YlNmSThhc3Q4OTNPSlhESU1SQk12c0I0WXVMY2NEQnhuMTdINVpZL1FT?=
 =?utf-8?B?SGpJc1J1VUtFQU4xd2VaQjF0UlNicUFBVU05N0hRNytibHNjeVNnQkc3YTB2?=
 =?utf-8?B?bFpuaW5OR0lCMUVXam1wdFF1cThBU2FjVHNVdHNDMll4RDloK28wWUUwMzJx?=
 =?utf-8?B?WjR0UUhUL3NUbmVpVmFsZlo1OWNZRU1nYkM2TFlvV2l3Nm9XdVFJUTViNnUw?=
 =?utf-8?B?dWdVQWpvUTR6RFgzWVJOWFJhR2JLNmY2dmJKek9MYUFWMzRwSEREYTFGMEpR?=
 =?utf-8?B?KzRkV2VIODBvK3lFU2l0VForSEJrRmIzNHVZQzQyMWgwamV5SzIyYSs0YzBi?=
 =?utf-8?B?c2QrcEkxRkNXRXVya0ZIK3FMcFRiSmw0a1FGeFc5d3RpMGdjQWkxcXJ2b0Z0?=
 =?utf-8?B?WWdERjNGcnJkZDJ2WWdtd0tYck5rWmdPNGc4SytuOWwzcmk3SHhaUjZ4dWRF?=
 =?utf-8?B?TmtWSDVzei92SzVody9BUWVDT25rTVc3SjMwaUdnVlpFSnM5OVIxVTVucyt2?=
 =?utf-8?B?RXo1YkhjclAwRm1YK0x3VTlQTGoyZStkUjVqNXB0OEJUQ2drU0MzVm53M0Rt?=
 =?utf-8?B?RmMrc09tSXFpaEZ5Z2FwZ1YxK043QmpmSzQwZ1dGNUxOdXVFT3lkSnVtb2hP?=
 =?utf-8?Q?BpVNRwTdbb/6/ErPMG98sqowe?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <45BC655A753772419C95B7E9071FC9E3@FRAP264.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 78f98eb6-53ed-42fa-56ad-08dc41b1d89f
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2024 09:58:47.8709
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4nqfE9uRpXzzOdm3yOyB3YOY7V/IOTxoaeSruCAx8cxQoQvs45BXvhUISqu7ADCeU3kc2x2u7qAW/iUHYdKhjBuWLqBxxb2XtsPQl6JaIQ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB3452

DQoNCkxlIDA2LzAzLzIwMjQgw6AgMTE6NDEsIHBldGVyeEByZWRoYXQuY29tIGEgw6ljcml0wqA6
DQo+IEZyb206IFBldGVyIFh1IDxwZXRlcnhAcmVkaGF0LmNvbT4NCj4gDQo+IFtiYXNlZCBvbiBh
a3BtL21tLXVuc3RhYmxlIGxhdGVzdCBjb21taXQgYTdmMzk5YWU5NjRlXQ0KPiANCj4gSW4gcHJl
dmlvdXMgd29yayBbMV0sIHdlIHJlbW92ZWQgdGhlIHBYZF9sYXJnZSgpIEFQSSwgd2hpY2ggaXMg
YXJjaA0KPiBzcGVjaWZpYy4gIFRoaXMgcGF0Y2hzZXQgZnVydGhlciByZW1vdmVzIHRoZSBodWdl
dGxiIHBYZF9odWdlKCkgQVBJLg0KPiANCj4gSHVnZXRsYiB3YXMgbmV2ZXIgc3BlY2lhbCBvbiBj
cmVhdGluZyBodWdlIG1hcHBpbmdzIHdoZW4gY29tcGFyZWQgd2l0aA0KPiBvdGhlciBodWdlIG1h
cHBpbmdzLiAgSGF2aW5nIGEgc3RhbmRhbG9uZSBBUEkganVzdCB0byBkZXRlY3Qgc3VjaCBwZ3Rh
YmxlDQo+IGVudHJpZXMgaXMgbW9yZSBvciBsZXNzIHJlZHVuZGFudCwgZXNwZWNpYWxseSBhZnRl
ciB0aGUgcFhkX2xlYWYoKSBBUEkgc2V0DQo+IGlzIGludHJvZHVjZWQgd2l0aC93aXRob3V0IENP
TkZJR19IVUdFVExCX1BBR0UuDQo+IA0KPiBXaGVuIGxvb2tpbmcgYXQgdGhpcyBwcm9ibGVtLCBh
IGZldyBpc3N1ZXMgYXJlIGFsc28gZXhwb3NlZCB0aGF0IHdlIGRvbid0DQo+IGhhdmUgYSBjbGVh
ciBkZWZpbml0aW9uIG9mIHRoZSAqX2h1Z2UoKSB2YXJpYW5jZSBBUEkuICBUaGlzIHBhdGNoc2V0
DQo+IHN0YXJ0ZWQgYnkgY2xlYW5pbmcgdGhlc2UgaXNzdWVzIGZpcnN0LCB0aGVuIHJlcGxhY2Ug
YWxsICpfaHVnZSgpIHVzZXJzIHRvDQo+IHVzZSAqX2xlYWYoKSwgdGhlbiBkcm9wIGFsbCAqX2h1
Z2UoKSBjb2RlLg0KPiANCj4gT24geDg2L3NwYXJjLCBzd2FwIGVudHJpZXMgd2lsbCBiZSByZXBv
cnRlZCAidHJ1ZSIgaW4gcFhkX2h1Z2UoKSwgd2hpbGUgZm9yDQo+IGFsbCB0aGUgcmVzdCBhcmNo
cyB0aGV5J3JlIHJlcG9ydGVkICJmYWxzZSIgaW5zdGVhZC4gIFRoaXMgcGFydCBpcyBkb25lIGlu
DQo+IHBhdGNoIDEtNSwgaW4gd2hpY2ggSSBzdXNwZWN0IHBhdGNoIDEgY2FuIGJlIHNlZW4gYXMg
YSBidWcgZml4LCBidXQgSSdsbA0KPiBsZWF2ZSB0aGF0IHRvIGhtbSBleHBlcnRzIHRvIGRlY2lk
ZS4NCj4gDQo+IEJlc2lkZXMsIHRoZXJlIGFyZSB0aHJlZSBhcmNocyAoYXJtLCBhcm02NCwgcG93
ZXJwYykgdGhhdCBoYXZlIHNsaWdodGx5DQo+IGRpZmZlcmVudCBkZWZpbml0aW9ucyBiZXR3ZWVu
IHRoZSAqX2h1Z2UoKSB2LnMuICpfbGVhZigpIHZhcmlhbmNlcy4gIEkNCj4gdGFja2xlZCB0aGVt
IHNlcGFyYXRlbHkgc28gdGhhdCBpdCdsbCBiZSBlYXNpZXIgZm9yIGFyY2ggZXhwZXJ0cyB0byBj
aGltIGluDQo+IHdoZW4gbmVjZXNzYXJ5LiAgVGhpcyBwYXJ0IGlzIGRvbmUgaW4gcGF0Y2ggNi05
Lg0KPiANCj4gVGhlIGZpbmFsIHBhdGNoZXMgMTAtMTMgZG8gdGhlIHJlc3Qgb24gdGhlIGZpbmFs
IHJlbW92YWwsIHNpbmNlICpfbGVhZigpDQo+IHdpbGwgYmUgdGhlIHVsdGltYXRlIEFQSSBpbiB0
aGUgZnV0dXJlLCBhbmQgd2Ugc2VlbSB0byBoYXZlIHF1aXRlIHNvbWUNCj4gY29uZnVzaW9ucyBv
biBob3cgKl9odWdlKCkgQVBJcyBjYW4gYmUgZGVmaW5lZCwgcHJvdmlkZSBhIHJpY2ggY29tbWVu
dCBmb3INCj4gKl9sZWFmKCkgQVBJIHNldCB0byBkZWZpbmUgdGhlbSBwcm9wZXJseSB0byBhdm9p
ZCBmdXR1cmUgbWlzdXNlLCBhbmQNCj4gaG9wZWZ1bGx5IHRoYXQnbGwgYWxzbyBoZWxwIG5ldyBh
cmNocyB0byBzdGFydCBzdXBwb3J0IGh1Z2UgbWFwcGluZ3MgYW5kDQo+IGF2b2lkIHRyYXBzIChs
aWtlIGVpdGhlciBzd2FwIGVudHJpZXMsIG9yIFBST1RfTk9ORSBlbnRyeSBjaGVja3MpLg0KPiAN
Cj4gVGhlIHdob2xlIHNlcmllcyBpcyBvbmx5IGxpZ2h0bHkgdGVzdGVkIG9uIHg4Niwgd2hpbGUg
YXMgdXN1YWwgSSBkb24ndCBoYXZlDQo+IHRoZSBjYXBhYmlsaXR5IHRvIHRlc3QgYWxsIGFyY2hz
IHRoYXQgaXQgdG91Y2hlcy4NCj4gDQo+IE1hcmtpbmcgdGhpcyBzZXJpZXMgUkZDIGFzIG9mIG5v
dy4NCj4gDQo+IFsxXSBodHRwczovL2xvcmUua2VybmVsLm9yZy9yLzIwMjQwMzA1MDQzNzUwLjkz
NzYyLTEtcGV0ZXJ4QHJlZGhhdC5jb20NCj4gDQoNCkhpIFBldGVyLCBhbmQgbmljZSBqb2IgeW91
IGFyZSBkb2luZyBpbiBjbGVhbmluZyB1cCB0aGluZ3MgYXJvdW5kIF9odWdlIA0Kc3R1ZmYuDQoN
Ck9uZSB0aGluZyB0aGF0IG1pZ2h0IGJlIHdvcnRoIGxvb2tpbmcgYXQgYWxzbyBhdCBzb21lIHBv
aW50IGlzIHRoZSBtZXNzIA0KYXJvdW5kIHBtZF9jbGVhcl9odWdlKCkgYW5kIHB1ZF9jbGVhcl9o
dWdlKCkuDQoNCkkgdHJpZWQgdG8gY2xlYW4gdGhpbmdzIHVwIHdpdGggY29tbWl0IGM3NDIxOTlh
MDE0ZCAoIm1tL3BndGFibGU6IGFkZCANCnN0dWJzIGZvciB7cG1kL3B1Yn1fe3NldC9jbGVhcn1f
aHVnZSIpIGJ1dCBpdCB3YXMgcmV2ZXJ0ZWQgYmVjYXVzZSBvZiANCmFybTY0IGJ5IGNvbW1pdCBk
OGE3MTkwNTliOWQgKCJSZXZlcnQgIm1tL3BndGFibGU6IGFkZCBzdHVicyBmb3IgDQp7cG1kL3B1
Yn1fe3NldC9jbGVhcn1faHVnZSIiKQ0KDQpTbyBub3cgcG93ZXJwYy84eHggaGFzIHRvIGltcGxl
bWVudCBwbWRfY2xlYXJfaHVnZSgpIGFuZCANCnB1ZF9jbGVhcl9odWdlKCkgYWxsdGhvdWdoIDh4
eCBwYWdlIGhpZXJhcmNoeSBvbmx5IGhhcyAyIGxldmVscy4NCg0KQ2hyaXN0b3BoZQ0K

