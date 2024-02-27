Return-Path: <linux-kernel+bounces-83129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AF29868ED5
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 12:32:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E4551C24123
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 11:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95712139597;
	Tue, 27 Feb 2024 11:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=csgroup.eu header.i=@csgroup.eu header.b="CACILOl0"
Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-pr2fra01on2121.outbound.protection.outlook.com [40.107.12.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB6C139593;
	Tue, 27 Feb 2024 11:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.12.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709033545; cv=fail; b=M7Wvf5gHWNimCF6LRaspP/wGdPHCcxmIpG82QFDyjywkxU1IzWqv9WPIWfkEVtR2FDuhiAEyHLa+33GNOE3/M4/26DDypAXaIvUgLIlK1It1/2X7S6nJ5l7YH+MssTLq8760yRO6kVp1ojlb5p64sWPUYz89pD32wE2JNWBVxOI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709033545; c=relaxed/simple;
	bh=IhVngy7xOcSTnzCC0JGWD/uIJaONa+/vtqgYSXB7/+c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cWwtrI4kFZC0D664sv5CRuTD936jjeg0Q27IZF5hKQy91kXnwGn9LVQulW7GjCNaXld95X0/krT1o/9S3BYK3/TISSrl8IhPRDSObjnaUOEuYnkjTbBQYdXShbz6e4jXVsI4a6ezzyCJwsKP8ZFsZ4TDt2V1MdWpefrUjge7870=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; dkim=pass (2048-bit key) header.d=csgroup.eu header.i=@csgroup.eu header.b=CACILOl0; arc=fail smtp.client-ip=40.107.12.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gYNcRqlxlHAyyO2WU89rXMzVSCNrwxY5B1HstJqXmTNwyfRREUYLk8lqP6iKKOjsUark5oByDe/ii5RRRofPJK7YL0/NFZwoz/0rmoLwn2x96/IolQt/eujEdToT5eTiW5+YpDCQRxbmKJGiziEDjZ3b31gS5hfl82qtulosBmE+8MjIEi37zJYuKqYqJI0PhR9+XNwCrtQWAnadROiCujBltcWDldCWwz1rqZG83DPTokJvo5Wk9b7eiIE4qZnrOM93xjNYVvQGt0P0ZZ4ckVmxpXEuMfpXvhhRPIbQGgagyfQnW0wv0qpgO3k4Td/aXkHgsW1GJO9KRMJS3xncGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IhVngy7xOcSTnzCC0JGWD/uIJaONa+/vtqgYSXB7/+c=;
 b=K0+X972P0OYmQpXEb5TaqWeQmP7hUwEUH0+ZPg16hxYy7ptOzWCCh6DoYq5d/sVVE86ldsG3+jHW6+0rEpPB6xTSuuUjDH266TYdaYWJIEGuuSRAXGE6vHzM7OTHfwmI37MDw4x5tmP7hVnZB6WCQsz/rZFo4zvk9julgfdOaeBvuV9oJfJUfRERbjquCEm9vc9HhsjuOGW2OH56DLNwtuuEc+rIOJdznzWJ0WlwljgUAEF6l4TgGj17Xk6CgPqjIX1FSYUQKfrAfHwKt3rnPmT1nK5HYoPJnO0KibDKa84OWk6BZ8E6h0W2rK+jec1QIVnAiL0AeinWAFwNth54sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IhVngy7xOcSTnzCC0JGWD/uIJaONa+/vtqgYSXB7/+c=;
 b=CACILOl0KWqAxfEKVs9oHr8TnDSHrFporia4C/76OvF+QAEvnpz0TVALY1cfXQFYdjEFo3x1Rm823iS12PYl78Fk/UAZKUp7NQLYakyEBYjcoPiPYlO8CKvy3Uw6eoNCTHmtBHdtNHd3T4scvGPYpryNNqr3x/HB0EFkFGdv/q3ZnZGgM2sITfWQhjiGKtYEP2riZzXaHAxanJANQ31PNKOhBtQstapSWWfUdRlFGB1II9q0vYqDIfweeTiX5Xia1uWJ97/F3b0Hzi8fTZbxqTD1tog3wAMgim0wWVH6lzGOz4QOMG0mnDeU0fzUhUQA+H4O+lD9BIr59TSZeFVrlg==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PAZP264MB3197.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1f4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.37; Tue, 27 Feb
 2024 11:32:19 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::c192:d40f:1c33:1f4e]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::c192:d40f:1c33:1f4e%6]) with mapi id 15.20.7316.035; Tue, 27 Feb 2024
 11:32:19 +0000
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
CC: Guenter Roeck <linux@roeck-us.net>, Charlie Jenkins
	<charlie@rivosinc.com>, David Laight <David.Laight@aculab.com>, Palmer
 Dabbelt <palmer@dabbelt.com>, Andrew Morton <akpm@linux-foundation.org>,
	Helge Deller <deller@gmx.de>, "James E.J. Bottomley"
	<James.Bottomley@hansenpartnership.com>, Parisc List
	<linux-parisc@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Palmer Dabbelt
	<palmer@rivosinc.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v10] lib: checksum: Use aligned accesses for ip_fast_csum
 and csum_ipv6_magic tests
Thread-Topic: [PATCH v10] lib: checksum: Use aligned accesses for ip_fast_csum
 and csum_ipv6_magic tests
Thread-Index:
 AQHaZqVM7f0VA9oidkaHzRbh3i5s67EcglMAgABWg4CAABKTgIAADGQAgAAIygCAADniAIAADA6AgAAI14CAAHULAIAAPciAgAARwQA=
Date: Tue, 27 Feb 2024 11:32:19 +0000
Message-ID: <c8ddcc98-acb0-4d2d-828a-8dd12e771b5f@csgroup.eu>
References:
 <20240223-fix_sparse_errors_checksum_tests-v10-1-b6a45914b7d8@rivosinc.com>
 <7ae930a7-3b10-4470-94ee-89cb650b3349@csgroup.eu>
 <e11fea7a-e99e-4539-a489-0aa145ee65f0@roeck-us.net>
 <ZdzPgSCTntY7JD5i@shell.armlinux.org.uk> <ZdzZ5tk459bgUrgz@ghost>
 <ZdzhRntTHApp0doV@shell.armlinux.org.uk>
 <b13b8847977d4cfa99b6a0c9a0fcbbcf@AcuMS.aculab.com> <Zd0b8SDT8hrG/0yW@ghost>
 <cdd09f7a-83b2-41ba-a32c-9886dd79c43e@roeck-us.net>
 <9b4ce664-3ddb-4789-9d5d-8824f9089c48@csgroup.eu>
 <Zd25XWTkDPuIjpF8@shell.armlinux.org.uk>
In-Reply-To: <Zd25XWTkDPuIjpF8@shell.armlinux.org.uk>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|PAZP264MB3197:EE_
x-ms-office365-filtering-correlation-id: 88b0f570-54ec-4141-5016-08dc3787c1d6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 o16RE4zZqQOvz8zv0Fivsx7gFqRPDdsNQwvdcD9SPq9lku3yAOgfQUECAZFgVaBPLy71TWLbJODyxuJ9CHwJQ45cAJi1+jH/jGVj64UF+Cdu84WaX05RSM5jyt21P4B4jWQr5Z07S2j9aZFdO8L+f6ZH221j+qsoBz4xBMl5qJQze8GHW2eAvN/KkWgIIHhhvwHj+DzAgoHPwYGp6HtZBp0m1bVUF+nFEeaXjP9PdIDrZGEf2O4VNL72Rym53VnCRz024VZVfhkGle3gTrZuedrQAymUwGIjHZb0h6ngwn510VGkfO2hUIfSjOIw5PXAyKX5Z8YLZeQ3DLL4J2QwbBlrXxSLcW1pRuh4AJYVx+XZKrK1DzGNGKeKbRBwhEsJGdIx5MFBIJBV019mdKkVHSpX0nsUo0MXGnKNwq/B1gn3pY/lm5Dak5cDLG22zT/6olsuqJJMt0KmoYhmyMZU/xVv63y03tgd0QwbAOM/CIQdtar8asFq4djyqKGxTGKz2do2f1k3aoTaIHml+WvBrS2gMC1X8FtfNCCQtrhPs/IP6bzCJXYqSBoAt4d6ERvtzWQU+L0ZM/7HfB8+dfINln1JrQ8Ibp/91IqHYqq2MVgwJXl6GKi9QWLgK/A6DdmBNGIo34EL4QYuv/+nUzftd8zSNw18lIsYMWVA6jClc/hRmbmUsse75qAnRjITo9eSmuA6VDDjZ7qLPfhV/wysSkrwNlXf21sOpTcKjdO+4Lw=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NFdJVVA3a1FNVytyL1ppVmcyd2xrVzcrMVdXVVJhQUpWZWZpd0pxYXluOG5F?=
 =?utf-8?B?V204UG1Wek9uQnVTRURFcFpkZ0lzSEpkNXVNWGNPQTh3ODZ1Y3ZOamxJd3BW?=
 =?utf-8?B?dDhmSzdaUEViSUtUc2pIMnQxNkZicjdjTmJiSTJtN0I2ZFlIZjVvaXBGQXZU?=
 =?utf-8?B?bXhKei92QURGTUNKaTZib2xQNUdkREZ5M1B4d1J4aDlZRURJZVQxTDJjVDRV?=
 =?utf-8?B?RnhTcG50UnFVSXNSWlRFQTZnWEdVUnhZNUkvU0NHU2loQjYzY0JycnYvUnBW?=
 =?utf-8?B?cGNwWkplZWx2UGl1eVpDL3dSZEhYQmpTRWtUYUZFMDUrd05aU1pGT3o0ekY3?=
 =?utf-8?B?NTNMemQ3NjczQXJIaURGUnl5RjBzWVdHYTNpYVhlNW1sa1Z6L1RCd2pZUmVu?=
 =?utf-8?B?V1JyNHdtMnpWN05qa2FJT0R5Nm11VTA4RE5vNDZ0TjZvZmFablpzRDdoSmp4?=
 =?utf-8?B?QlBGQklIN3laODRndkh3S2hEaGVtNnpVK0txWVlQemhIYkwrVU1FaWR1OVh4?=
 =?utf-8?B?ZGxLWmJnQ3YxME9FQmpKTW5nNTVheHcvNHFCMHFjQlEvdVU1QjlPTFJZc1ZX?=
 =?utf-8?B?Zmd6MTFKUGxrZmJDTzREWXdUZXNXVXU2NEQzNmpNdDcvNGZDYzJCTFRiaDJk?=
 =?utf-8?B?b1h5K1oybkc2cHZYMTBqR1A4VDl1LzQyQnZxZlFuT3lpQno2TXBGUU53bGdY?=
 =?utf-8?B?a0dJUW5Sekt1cUdSTVgrZHhDSXB3Q3krQURWSmlKYVhGZ0htU05PVjcybms3?=
 =?utf-8?B?bnZMNUo1TER2UmJkM0xDeHYvaCt0ZjBEK1FSTWdqYTVpQ0pON3ZvYmNtMWJ3?=
 =?utf-8?B?SmtSWGhtM0puUTdwempVNUZUTXcrbFpRcElOUjJQUno4NkNrOHltUVBmYllL?=
 =?utf-8?B?MCtnaUt4QTZ1aXJZOWc2Q3FqdlJzVmEybnpEek1XNGs1QzB5WFlQTE5JT0RB?=
 =?utf-8?B?SEFod3BabmdoQlJOaU9XODFEV011RllrM0d3Ri9lODIxSHlGUmlnZkZlZ0ow?=
 =?utf-8?B?dDA5Um5Ka0kyOEhlWHpYa2VNUFNuZ25TUEFvUEVIQzBMb1p3UkdLT0VmNU1v?=
 =?utf-8?B?UjJXL2h1cmNjMjJ3STZCWkdtRkdGbHZ3RTZpaGxEWnIycStTc0x4SnJuVnFs?=
 =?utf-8?B?c0NMWVFhSHJ0dDBEbnNpNDNoWkprYjBXM04rUUh0MTkyQWtaRS9id0NUUVJR?=
 =?utf-8?B?VC8xbmxVdFFvTTZGb1hhcllhNThWR3ZVc0RrSURtTlhvL05BVEZXek43N2FM?=
 =?utf-8?B?SzB1eEN3VmlJV3crSjRRcDY1YVhqTmFKQlhGY3AwNS9rc1JjVnBFS0pwcWNj?=
 =?utf-8?B?V2kyaVphOEorR1M5eXRVZ1l3SVd5V0JRZWhOVVJJY3BNRlNxT05oNnZTMjNz?=
 =?utf-8?B?SHBEOUY0WmYwSFFzZUFhMVpydGd4S2Vaam9PSTBuQ3BGRjVoYWFQOU15TWE5?=
 =?utf-8?B?b0VyUmlCZHRNNDBUNWoyT2Nud2dMUVdmU0JBVGsxSE5mT3hPZmxtQWUzN0Jv?=
 =?utf-8?B?R01tSTVKcTJ5MU1la1JRM3ZqeFlsUnA4djVtZ1h0VldRdCt0SU5OYWRmUnhi?=
 =?utf-8?B?V2ZQaDdGdUhZRVFjaThUdTY2ZXFYQ2lEMWUzeVNtRzd4aUJwOUs2cnJrYk53?=
 =?utf-8?B?THhReGdHd3l2WUtQTzd4eEVEOTJrdU1keGMyVkdCZmRVNWJER0VGeFVwblJs?=
 =?utf-8?B?VlRtUXUwR1pRL1ZzeU9ZMlk4VjZWK3E4Vno2R0RRWnhPd2d5cy9YNDk2dHRP?=
 =?utf-8?B?TVYyOHFuWTdPell1QVo1Q1pBbmZWTnhZTXVaOC9QNXl5WW9kZ2U4b3Z2M2h5?=
 =?utf-8?B?ZForNjEvQllYaUZDSTZkTHlYSUJpVWFkK21BaklmTzAyM3BiUzgzSU40cmdH?=
 =?utf-8?B?dWtLb2dRRlpoeVFBTnR2Nm4xUHpBWllsZnAvcU5EcWpMV0owVGRKMVh2dEh3?=
 =?utf-8?B?MExFYWZCR0dnSisvNFU0c0prY0dCR0V4TzZaN3dYTXg3Z0M0MkVjUnRZTUpr?=
 =?utf-8?B?bGU2dXpzRm04RVBqQkQ1UHZyOVN4Zk5udkUzeUsrLytCZEtiN3NNNlVNaldC?=
 =?utf-8?B?OUkvSGMxVGpOSWhLNk9mcnVMN2VSM0pJWUZCZHc4QSt0TFBPWTN1YVR0Qm9I?=
 =?utf-8?B?ZW44YWRId2hTRUpmSktYREszdEtMZW02RUdZNDV6WEh4UVl1K29wSVh0SUNQ?=
 =?utf-8?B?cVpFTlp5TmxlZnl1TjU0S21VYmloRGhFdlJRSGJaYWwxckR0dFpJMTA3RDg3?=
 =?utf-8?B?blBBTzViQ1pSV2llQzFQZGc1THh3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A7438C6D10DEAE4A86C49AF9A7B60D37@FRAP264.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 88b0f570-54ec-4141-5016-08dc3787c1d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2024 11:32:19.1857
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4dyOq9wrUW3hFn33Ll9na2WXpY5Ef99XhGkLCIWAWdb7FE2ihazCvi8+K2Yhm+LoSO7gW23J5FHPsKYxohg1B63Qv2+nqq8+ITAH3GNs1vY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAZP264MB3197

DQoNCkxlIDI3LzAyLzIwMjQgw6AgMTE6MjgsIFJ1c3NlbGwgS2luZyAoT3JhY2xlKSBhIMOpY3Jp
dMKgOg0KPiBPbiBUdWUsIEZlYiAyNywgMjAyNCBhdCAwNjo0NzozOEFNICswMDAwLCBDaHJpc3Rv
cGhlIExlcm95IHdyb3RlOg0KPj4NCj4+DQo+PiBMZSAyNy8wMi8yMDI0IMOgIDAwOjQ4LCBHdWVu
dGVyIFJvZWNrIGEgw6ljcml0wqA6DQo+Pj4gT24gMi8yNi8yNCAxNToxNywgQ2hhcmxpZSBKZW5r
aW5zIHdyb3RlOg0KPj4+PiBPbiBNb24sIEZlYiAyNiwgMjAyNCBhdCAxMDozMzo1NlBNICswMDAw
LCBEYXZpZCBMYWlnaHQgd3JvdGU6DQo+Pj4+PiAuLi4NCj4+Pj4+PiBJIHRoaW5rIHlvdSBtaXN1
bmRlcnN0YW5kLiAiTkVUX0lQX0FMSUdOIG9mZnNldCBpcyB3aGF0IHRoZSBrZXJuZWwNCj4+Pj4+
PiBkZWZpbmVzIHRvIGJlIHN1cHBvcnRlZCIgaXMgYSBncm9zcyBtaXNpbnRlcnByZXRhdGlvbi4g
SXQgaXMgbm90DQo+Pj4+Pj4gImRlZmluZWQgdG8gYmUgc3VwcG9ydGVkIiBhdCBhbGwuIEl0IGlz
IHRoZSBfcHJlZmVycmVkXyBhbGlnbm1lbnQNCj4+Pj4+PiBub3RoaW5nIG1vcmUsIG5vdGhpbmcg
bGVzcy4NCj4+Pj4NCj4+Pj4gVGhpcyBkaXN0aW5jdGlvbiBpcyBhcmJpdHJhcnkgaW4gcHJhY3Rp
Y2UsIGJ1dCBJIGFtIG9wZW4gdG8gYmVpbmcgcHJvdmVuDQo+Pj4+IHdyb25nIGlmIHlvdSBoYXZl
IGRhdGEgdG8gYmFjayB1cCB0aGlzIHN0YXRlbWVudC4gSWYgdGhlIGRyaXZlciBjaG9vc2VzDQo+
Pj4+IHRvIG5vdCBmb2xsb3cgdGhpcywgdGhlbiB0aGUgZHJpdmVyIG1pZ2h0IG5vdCB3b3JrLiBB
Uk0gZGVmaW5lcyB0aGUNCj4+Pj4gTkVUX0lQX0FMSUdOIHRvIGJlIDIgdG8gcGFkIG91dCB0aGUg
aGVhZGVyIHRvIGJlIG9uIHRoZSBzdXBwb3J0ZWQNCj4+Pj4gYWxpZ25tZW50LiBJZiB0aGUgZHJp
dmVyIGNob29zZXMgdG8gcGFkIHdpdGggb25lIGJ5dGUgaW5zdGVhZCBvZiAyDQo+Pj4+IGJ5dGVz
LCB0aGUgZHJpdmVyIG1heSBmYWlsIHRvIHdvcmsgYXMgdGhlIENQVSBtYXkgc3RhbGwgYWZ0ZXIg
dGhlDQo+Pj4+IG1pc2FsaWduZWQgYWNjZXNzLg0KPj4+Pg0KPj4+Pj4NCj4+Pj4+IEknbSBzdXJl
IEkndmUgc2VlbiBjb2RlIHRoYXQgd291bGQgcmVhbGlnbiBJUCBoZWFkZXJzIHRvIGEgNCBieXRl
DQo+Pj4+PiBib3VuZGFyeSBiZWZvcmUgcHJvY2Vzc2luZyB0aGVtIC0gYnV0IHRoYXQgbWlnaHQg
bm90IGhhdmUgYmVlbiBpbg0KPj4+Pj4gTGludXguDQo+Pj4+Pg0KPj4+Pj4gSSdtIGFsc28gc3Vy
ZSB0aGVyZSBhcmUgY3B1IHdoaWNoIHdpbGwgZmF1bHQgZG91YmxlIGxlbmd0aCBtaXNhbGlnbmVk
DQo+Pj4+PiBtZW1vcnkgdHJhbnNmZXJzIC0gd2hpY2ggbWlnaHQgYmUgdXNlZCB0byBtYXJnaW5h
bGx5IHNwZWVkIHVwIGNvZGUuDQo+Pj4+PiBBc3N1bWluZyBtb3JlIHRoYW4gNCBieXRlIGFsaWdu
bWVudCBmb3IgdGhlIElQIGhlYWRlciBpcyBsaWtlbHkNCj4+Pj4+ICd3aXNoZnVsIHRoaW5raW5n
Jy4NCj4+Pj4+DQo+Pj4+PiBUaGVyZSBpcyBwbGVudHkgb2YgZXRoZXJuZXQgaGFyZHdhcmUgdGhh
dCBjYW4gb25seSB3cml0ZSBmcmFtZXMNCj4+Pj4+IHRvIGV2ZW4gYm91bmRhcmllcyBhbmQgcGxl
bnR5IG9mIGNwdSB0aGF0IGZhdWx0IG1pc2FsaWduZWQgYWNjZXNzZXMuDQo+Pj4+PiBUaGVyZSBh
cmUgZXZlbiBjYXNlcyBvZiBib3RoIG9uIHRoZSBzYW1lIHNpbGljb24gZGllLg0KPj4+Pj4NCj4+
Pj4+IFlvdSBhbHNvIHByZXR0eSBtdWNoIG5ldmVyIHdhbnQgYSBmYXVsdCBoYW5kbGVyIHRvIGZp
eHVwIG1pc2FsaWduZWQNCj4+Pj4+IGV0aGVybmV0IGZyYW1lcyAob3IgcmVhbGx5IGFueXRoaW5n
IGVsc2UgZm9yIHRoYXQgbWF0dGVyKS4NCj4+Pj4+IEl0IGlzIGFsd2F5cyBnb2luZyB0byBiZSBi
ZXR0ZXIgdG8gY2hlY2sgaW4gdGhlIGNvZGUgaXRzZWxmLg0KPj4+Pj4NCj4+Pj4+IHg4NiBoYXMg
anVzdCBtYWRlIHBlb3BsZSAnc2xvcHB5JyA6LSkNCj4+Pj4+DQo+Pj4+PiAgwqDCoMKgwqBEYXZp
ZA0KPj4+Pj4NCj4+Pj4+IC0NCj4+Pj4+IFJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJh
bWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLA0KPj4+Pj4gTUsxIDFQVCwgVUsN
Cj4+Pj4+IFJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo+Pj4+Pg0KPj4+Pg0KPj4+
PiBJZiBzb21lYm9keSBoYXMgYSBzb2x1dGlvbiB0aGV5IGRlZW0gdG8gYmUgYmV0dGVyLCBJIGFt
IGhhcHB5IHRvIGNoYW5nZQ0KPj4+PiB0aGlzIHRlc3QgY2FzZS4gT3RoZXJ3aXNlLCBJIHdvdWxk
IGFwcHJlY2lhdGUgYSBtYWludGFpbmVyIHJlc29sdmluZw0KPj4+PiB0aGlzIGRpc2N1c3Npb24g
YW5kIGFwcGx5IHRoaXMgZml4Lg0KPj4+Pg0KPj4+IEFncmVlZC4NCj4+Pg0KPj4+IEkgZG8gaGF2
ZSBhIGNvdXBsZSBvZiBwYXRjaGVzIHdoaWNoIGFkZCBleHBsaWNpdCB1bmFsaWduZWQgdGVzdHMg
YXMgd2VsbCBhcw0KPj4+IGNvcm5lciBjYXNlIHRlc3RzICh3aGljaCBhcmUgaW50ZW5kZWQgdG8g
dHJpZ2dlciBhcyBtYW55IGNhcnJ5IG92ZXJmbG93cw0KPj4+IGFzIHBvc3NpYmxlKS4gT25jZSBJ
IGdldCB0aG9zZSB3b3JraW5nIHJlbGlhYmx5LCBJJ2xsIGJlIGhhcHB5IHRvIHN1Ym1pdA0KPj4+
IHRoZW0gYXMgYWRkaXRpb25hbCB0ZXN0cy4NCj4+Pg0KPj4NCj4+IFRoZSBmdW5jdGlvbnMgZGVm
aW5pdGVseSBoYXZlIHRvIHdvcmsgYXQgbGVhc3Qgd2l0aCBhbmQgd2l0aG91dCBWTEFOLA0KPj4g
d2hpY2ggbWVhbnMgdGhlIGFsaWdubWVudCBjYW5ub3QgYmUgZ3JlYXRlciB0aGFuIDQgYnl0ZXMu
IFRoYXQncyBhbHNvDQo+PiB0aGUgb3V0Y29tZSBvZiB0aGUgZGlzY3Vzc2lvbi4NCj4gDQo+IFRo
YW5rcyBmb3IgY29tcGxldGVseSBpZ25vcmluZyB3aGF0IEkndmUgc2FpZC4gTm8uIFRoZSBhbGln
bm1lbnQgZW5kcyB1cA0KPiBiZWluZyBjb21tb25seSAyIGJ5dGVzLg0KPiANCj4gQXMgSSd2ZSBz
YWlkIHNldmVyYWwgdGltZXMsIG5ldHdvcmsgZHJpdmVycyBkbyBfbm90XyBoYXZlIHRvIHJlc3Bl
Y3QNCj4gTkVUX0lQX0FMSUdOLiBUaGVyZSBhcmUgMzItYml0IEFSTSBkcml2ZXJzIHdoaWNoIGhh
dmUgYSBETUEgZW5naW5lIGluDQo+IHRoZW0gd2hpY2ggY2FuIG9ubHkgRE1BIHRvIGEgMzItYml0
IGFsaWduZWQgYWRkcmVzcy4gVGhpcyBtZWFucyB0aGF0DQo+IHRoZSBzdGFydCBvZiB0aGUgZXRo
ZXJuZXQgaGVhZGVyIGlzIHBsYWNlZCBhdCBhIDMyLWJpdCBhbGlnbmVkIGFkZHJlc3MNCj4gbWFr
aW5nIHRoZSBJUCBoZWFkZXIgbWlzYWxpZ25lZCB0byAzMi1iaXQuDQo+IA0KPiBJIGRvbid0IHNl
ZSB3aGF0IGlzIHNvIGRpZmZpY3VsdCB0byB1bmRlcnN0YW5kIGFib3V0IHRoaXMuLi4gYnV0IGl0
DQo+IHNlZW1zIHRoYXQgbXkgY29tbWVudHMgb24gdGhpcyBhcmUgYmVpbmcgaWdub3JlZCB0aW1l
IGFuZCB0aW1lIGFnYWluLA0KPiBhbmQgSSBjYW4gb25seSB0aGluayB0aGF0IHRob3NlIHdobyBh
cmUgaWdub3JpbmcgbXkgY29tbWVudHMgaGF2ZQ0KPiBzb21lIGFsdGVyaW9yIG1vdGl2ZSBoZXJl
Lg0KPiANCg0KSSdtIHNvcnJ5IGZvciB0aGlzIG1pc3VuZGVyc3RhbmRpbmcuIEknbSBub3QgaWdu
b3Jpbmcgd2hhdCB5b3Ugc2FpZCBhdCANCmFsbC4gSSB1bmRlcnN0b29kIHRoYXQgQVJNIGlzIGFi
bGUgdG8gaGFuZGxlIHVuYWxpZ25lZCBhY2Nlc3NlcyB3aXRoIA0Kc29tZSBleGNlcHRpb24gaGFu
ZGxlcnMgYXQgd29yc3QgY2FzZSBhbmQgdGhhdCBETUEgY29uc3RyYWludHMgbWF5IGxlYWQgDQp0
byB0aGUgSVAgaGVhZGVyIGJlZWluZyBvbiBhIDIgYnl0ZXMgYWxpZ25tZW50IG9ubHkuDQoNCkhv
d2V2ZXIgSSBhbHNvIHVuZGVyc3Rvb2QgZnJvbSBvdGhlcnMgdGhhdCBzb21lIGFyY2hpdGVjdHVy
ZXMgY2FuJ3QgDQpoYW5kbGUgc3VjaCBhIDIgYnl0ZXMgb25seSBhbGlnbm1lbnRzLg0KDQpJdCdz
IGJlZW4gc3VnZ2VzdGVkIGR1cmluZyB0aGUgZGlzY3Vzc2lvbiB0aGF0IGFsaWdubWVudCB0ZXN0
cyBzaG91bGQgYmUgDQphZGRlZCBsYXRlciBpbiBhIGZvbGxvdy11cCBwYXRjaC4gU28gZm9yIHRo
ZSB0aW1lIGJlaW5nIEknbSB0cnlpbmcgdG8gDQpmaW5kIGEgY29tcHJvbWlzZSBhbmQgZ2V0IHRo
ZSBleGlzdGluZyB0ZXN0cyB3b3JraW5nIG9uIGFsbCBwbGF0Zm9ybXMgDQpidXQgd2l0aCBhIHNt
YWxsZXIgYWxpZ25tZW50IHRoYW4gdGhlIDE2LWJ5dGVzIGFsaWdubWVudCBicm91Z2h0IGJ5IA0K
Q2hhcmxpZSdzIHYxMCBwYXRjaC4gQW5kIGEgNCBieXRlcyBhbGlnbm1lbnQgc2VlbWVkIHRvIG1l
IHRvIGJlIGEgZ29vZCANCmNvbXByb21pc2UgZm9yIHRoaXMgZml4LiBUaGUgaWRlYSBpcyBhbHNv
IHRvIG1ha2UgdGhlIGZpeCBhcyBtaW5pbWFsIGFzIA0KcG9zc2libGUsIHVubGlrZSBDaGFybGll
J3MgcGF0Y2ggdGhhdCBpcyBjaHVybmluZyB1cCB0aGUgdGVzdHMgcXVpdGUgDQpoZWF2aWx5Lg0K
DQpCdXQgbWF5YmUgSSBtaXN1bmRlcnN0b29kIHNvbWUgb2YgdGhlIGRpc2N1c3Npb24gYW5kIGlu
ZGVlZCAyIGJ5dGVzIA0KYWxpZ25tZW50IHdvdWxkIHdvcmsgb24gYWxsIHBsYXRmb3JtcyBhbmQg
b25seSBhbiBvZGQgYWxpZ25tZW50IGlzIA0KcHJvYmxlbWF0aWMgPw0K

