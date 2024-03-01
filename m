Return-Path: <linux-kernel+bounces-88001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC2D586DBFD
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 08:17:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3750E1F2299A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 07:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FCD66994C;
	Fri,  1 Mar 2024 07:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=csgroup.eu header.i=@csgroup.eu header.b="A/MzIoev"
Received: from FRA01-MR2-obe.outbound.protection.outlook.com (mail-mr2fra01on2139.outbound.protection.outlook.com [40.107.9.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8E66930F;
	Fri,  1 Mar 2024 07:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.9.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709277463; cv=fail; b=uOoqa6Nl3Q4Kf7H9sIbt6dKdyUEzX4cfoMRmW3mFzjrTrUj0L3PW2RoUb944Z+GVz//3PwZrkoFHcxATljShJgnfP0H3YjWn3BfdpPMT5m36+5MUe8M99kz+0idLAp1lQrGEEZUepr/Qiy96ZDsvMuT2QAijCERuf2mZ61R0I2U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709277463; c=relaxed/simple;
	bh=Q7YloBPmXXBoVNNpWXooP1uWjIpxNfbBB9wRaih7XhA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=g7qi9gY6WTrCebBGGq6tOMCDoYiNAUmUntBkRbyPGsm+Op0GPmu0bmxN3hI/A2aS4zzzhUojeAnvmYyNo2xgvk6J9Kee9xO0WD34I5ZTAVHjd7KxyEXoFBiaUFul+eH2UEYZwZSvPiPzGzBsUzGYIAeZq1GeQd6Gx3zQSiZkBHc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; dkim=pass (2048-bit key) header.d=csgroup.eu header.i=@csgroup.eu header.b=A/MzIoev; arc=fail smtp.client-ip=40.107.9.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EOEetsty0kM7OWjKNLcDjBE5sRaNVi8gXYU+C0d3ym/0bPr9EuTFK/O9i583xF42n7lYwq16Ms7T5dVYHShOojdlykbKvN7P/h39tmjuGonISM3Aj3VlmUoHFzoz5E1ECDSKYgDT8k6+baQ3YxekIdd3NyWiukLQXH/54H1aoNgNdjniYvN/U4jit6El40mEs/j/4JASf1tyZwlhaq+7MAxWaczFu8cIwXVqFU/+PVa4xjaaFpVzJV1qQS0vaSaZGpx2bp9XfNucBZdvADXYsCTIvt9jGL2CwpPzg9qreKWt1/wej/nt5wVLQKrqM+wMmY932AvRWKo8Ov4l2ie1BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q7YloBPmXXBoVNNpWXooP1uWjIpxNfbBB9wRaih7XhA=;
 b=ZyfDrA/CfY7rhFSQXc87fNfADhWM3THnV9HHhEmkLFFlJO44n0TX6BqQrNKRilkzBTqvTDo1GjFwgyyEFlXEA3BAl3WCNVwVaF9UFieD9QGpXPQ/6D6kHWj7g7UDQEH2gqH/uNqohUKQ8y9SHsN3AM3CUF/zfNjpG2WSYNNx06QFthiA2jiO62pb+T+4u4Ba9NABZ7Tn97Z++PG8ZnNdvJBH2rZftNc8ANfJGZj+51rJJPNPmyfIUxKOj3dL/3z5ajDt1iT0Z8QZzzh9+X6ciYJJb//am7ipbqhmamsoupHP4fxkGhnVnH7rIGJE/C+xKKBHXjqZIJ5FtnQ9oXC4Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q7YloBPmXXBoVNNpWXooP1uWjIpxNfbBB9wRaih7XhA=;
 b=A/MzIoev62waZC/3yvdSqM3yzocFZP88RDCivDVyQlHPtvkrk3mzmaxW399in96Pa9wyNDoTAqujHtifdBhYpD961xiFJ1U48VJeQEkq84KJTZLJwE5Z5NM/LndmnpnmfpzlwWIG0w/9AAyMmreLP/6s9HXvV4GOFhKCfAaHbDKqVBmGF3dDz9BbYyH7/DBKixQhhqPKOaFo+ybwMtik/2sFh5Z8cPh9eKvoQszxWOVcu6JT+u7eZ/kZ/QJwHRPWU5B1/jb773i5560S52a8erkR0nbZ2PySh2QEcp7CfFDB8ezZvYnOt7FIcvU9tlK5ogbDpxeS99IDXG+S67Ge2Q==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PAYP264MB3437.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:125::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.36; Fri, 1 Mar
 2024 07:17:38 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::c192:d40f:1c33:1f4e]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::c192:d40f:1c33:1f4e%6]) with mapi id 15.20.7316.039; Fri, 1 Mar 2024
 07:17:38 +0000
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Charlie Jenkins <charlie@rivosinc.com>, Guenter Roeck
	<linux@roeck-us.net>, David Laight <David.Laight@aculab.com>, Palmer Dabbelt
	<palmer@dabbelt.com>, Andrew Morton <akpm@linux-foundation.org>, Helge Deller
	<deller@gmx.de>, "James E.J. Bottomley"
	<James.Bottomley@hansenpartnership.com>, Parisc List
	<linux-parisc@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Geert
 Uytterhoeven <geert@linux-m68k.org>, Russell King <linux@armlinux.org.uk>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Palmer
 Dabbelt <palmer@rivosinc.com>, Linux ARM
	<linux-arm-kernel@lists.infradead.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
Subject: Re: [PATCH v11] lib: checksum: Use aligned accesses for ip_fast_csum
 and csum_ipv6_magic tests
Thread-Topic: [PATCH v11] lib: checksum: Use aligned accesses for ip_fast_csum
 and csum_ipv6_magic tests
Thread-Index: AQHaa2FN/UPATTv23UaTwsptpp4BsbEiek8A
Date: Fri, 1 Mar 2024 07:17:38 +0000
Message-ID: <41a5d1e8-6f30-4907-ba63-8a7526e71e04@csgroup.eu>
References:
 <20240229-fix_sparse_errors_checksum_tests-v11-1-f608d9ec7574@rivosinc.com>
In-Reply-To:
 <20240229-fix_sparse_errors_checksum_tests-v11-1-f608d9ec7574@rivosinc.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|PAYP264MB3437:EE_
x-ms-office365-filtering-correlation-id: dd18d9a5-e93a-4082-50a7-08dc39bfacfc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 gOS25O9ulV2kloinNp0e0GZyobkXhnIVR/TfBoqQmYVRM3Ju5Tc9mPgbzBiJwskB9RUZxgtYmkB7eFq6KBiD6yIshb0nyaWLQMjmvY9OXUOKpZDMTqIkKLOY1rxNdPTepQxlG9TcqVvOENsXMz94q5tYKJsKAKqtCaEN7sQNhDQQipfSYn9iNNKfifZXdBoiVTCXl8oyBzOuyOoA/IeHaonJNnx2lOUuwRlZGRmo9NKteFqK4NXyCZQ8OQwn6zBrZftrJn01uQRkpJ9hn0r9bwur0haLtp2tjmsBUmvtRp8OeZD/fe+aldoJiF+ImC3y24d37ktoINiW7yyRREokrSDcaFCuY1zPILi3CyZepPx8yVVDtlPYU3mhBX8OSQYsYrWYG8AREbX0A1R0BWCUGRafklU+yeP2cnINsO+4mBBapeH5s48cTD5UOy46mT6kMMUmV+EF4K2aPcuyttruLCKEDA5uBQDiH+hw/uTCB5VclCwTdy5m2dQHmPxNt2LnBwKKxn/1Q4wlIiyrxrHFjd5Tl5XasYUmgfGi8N2j0K1mTjniiN8IMfGO8h8d0Iifs3Aspi3OdHfGn/zE5GseaVGk6iUs62rr2Nwc1U+BXqNumaFRLkc4OwWpPouDfdHzAWjKqpVAaMsjRn9N1xDCmSWO2KhnfvwTbvX7yCYJ8talmO7Vzqjrx5YUuzin6LqNUEt1R8qq5r6IVC2ESgX4oPnU6TNhKQzHpKnXteRLWQk=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(38070700009)(921011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TTJSYm1ZZEZoKy9TSy9YaVk0Qy9Ca0JacU5sZ29vdUVzcDdpN2c5RnYxQ003?=
 =?utf-8?B?RGJpbTFaR0xNUGtmQU5PN2hsdGhhRDBzZXJiOExIQmZ2Uy9yZ0hOOTk5Nk5Z?=
 =?utf-8?B?SW9QZmMzWTViSlJuMlFiRmQyVGJLQlIvTGlkdWN6VStrV0gwMkgvZzU4bnJp?=
 =?utf-8?B?VklOUnF5aWl4V1BzTkJwRHA5RUJKN1ZjL1BQMDMrQzV0U0xIL2NRUkxncEZ0?=
 =?utf-8?B?ZE5SMjRLUDl4S09RQ1NOUGs1V3NHTW1Ibi9qZ2JPcW9YMVRkcHV1MS8vWkVr?=
 =?utf-8?B?T2lLUytyaGx1SmxwNWM1M21NZUs0SWE4Y1gxVnphak5LNVpuRUQ0N1NmMHlI?=
 =?utf-8?B?VUliQnIwMGsrTTh3YTYrdlpKTGFmdTg2QW9DUTZyUnBrajZLdS8zYWZkbU1o?=
 =?utf-8?B?V3FFVHcxV012aDdvM3FEdCt6dGNXRHVaSTBycERpSDhsYWZhOWdFUDdoNzJh?=
 =?utf-8?B?KzdnczF6RVBOTEQ4b1JtTXpBWkNWVXpUU0czY0c1Tk9SVWdQUkZrMXcvQmVH?=
 =?utf-8?B?WFRXeXl2bEM0R2RIejNYMWwvQ1M0UDlxNzNTOFFYeHlUcGF4RnhtNG56bkRr?=
 =?utf-8?B?SjhhUjF5Q0k0dUloR2RtdzAzNXJ0VmFKcjJpMmJwZGw1MFRuZDNRZHQrOEZ0?=
 =?utf-8?B?bTloZFRZOEtGVVlWdml6ZG1xVndOVUlkSUdxeTNGd0syRXdpSWtHQmdVU1BB?=
 =?utf-8?B?RzRyV2ZXSnhZMEc2QXBEbmlpdzk1aUF3QUVNczZCdnBud3RsZDNRU2ZSSkc2?=
 =?utf-8?B?UXFSUmt4blU2Y3dESVdQTFRxMkpadGZZRlIxUHVxS2Y0RWxuUFd4MXZRM1VE?=
 =?utf-8?B?a3IyWURqTytoazVyMUVoaDdaY1hjM0RTV3djaFd2VENXNjMwZWRMNmEwSlpw?=
 =?utf-8?B?UXBiaXVhelRnSTBjSEtBblRVUDc2OTNUengvb3pVaEFJdWNNQ3BBZCtOZkU3?=
 =?utf-8?B?UEtuUC9pdEdybXJKVC9iTTBQTzNtR0RKb3hGTHQ5QWhzLzlVSWowR0cxeDQw?=
 =?utf-8?B?bW9paVFXSXZFMVRxUTZTUkIzNlFRaE1uWURwZ0gyVFh2UlY5UzNtZXQ3OTll?=
 =?utf-8?B?SXhHZVBSUkh0OGg2cFA2MlNkNGNDTUNMS0tRdUdHK0I0NVVuVlEwMzFtWER1?=
 =?utf-8?B?bkhncnkvYkY3UWdxNFJRZTFQbENHeG4yUTZkZlVMTnh5RHFsaS8zYUhXbDhx?=
 =?utf-8?B?WmtJZjVzWURoM3p6NnBua2tacmlUeFVpWi81bDFtM1FpYVZuN0h6RUhMb2Zw?=
 =?utf-8?B?Y3pTVzlJSzdFaDc0a3Jza0xYOWFVM3NWQkR4MlNuUmxvbW9va29ROCtyVGFM?=
 =?utf-8?B?VTFIYWRwdm5jWFl2V0kxRk9QeEl0M3lHRGt4cWdSekRad3M5Y3M5WStrVkhW?=
 =?utf-8?B?ZGhDdGtQNmVKcTJrTXlzblFjZkE1OUhTWngrSkd3U0V5cklqOU5yazlTb2hD?=
 =?utf-8?B?T1IwSWRyelZHeDRoRVJPd3FoR1c2ZlV6TzRDQ29laWUrUjhtenZTUkFoNVBU?=
 =?utf-8?B?eVhaV3JXOXk5QVhGUHF3YnMxMVVlekd6U2JxMnpNb3VlaEVFUEdOZFFLQXN2?=
 =?utf-8?B?cHpzUThOWXA1V3BXaldyR1pXT1lqSkxUQWJmMmlJSmVQN2h3c1B1eDRhZ3NQ?=
 =?utf-8?B?dXhlbG9yWGlpN2JtKzB1bzlZcjQ1UVhiNzdOdHZjaU9YeVR0c2NkT0kwbUVi?=
 =?utf-8?B?OXB0Q21Ra0pDNFZVQVZ2dTc1R3FKTk1USG5WcldOSDVXRHc1bHVkbCtibEwx?=
 =?utf-8?B?UFNqaDA2Z0tpVk9uUVRTZnZwS2N2ZTB6TW9ZalVBakUyb3RReDQ0OWRWR1Ar?=
 =?utf-8?B?SW1ja0xDRmNSbW5Ic0I3SG5vcWw5Y1BzT0hQcEhlRDhsWXFmMDBBVXVnOVZl?=
 =?utf-8?B?WGlobGpVV0dDU3pLSS9DbzBsTm53OVpTSG53N0RiRllGRmJSK0xicEh1Zklv?=
 =?utf-8?B?RlUvc2VBVXp3eEpsSjFHNGg5bWpyMkgzU2RQYWtVa3pqR21wV1dEaVVyMmFQ?=
 =?utf-8?B?czgvWDRwV0hJbzR5RGprcW5jVzlLNlpZQ0J6anFWOVIwK0dqQnRtZUsxcmwz?=
 =?utf-8?B?S0diTzFFMEJsSGFDa1MwaDI5WnVlZXc5L0pQcENiakNlN05iTkNXWXB3QUhv?=
 =?utf-8?B?ek52UmwyYytOY05iZ1ZQZkwvUU5JSlI2VGZXcjJIK1pGRFFJN3ZBaVM1RzRn?=
 =?utf-8?B?UlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3637626EFEFE5D4F9AE8EDDB58C79DB7@FRAP264.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: dd18d9a5-e93a-4082-50a7-08dc39bfacfc
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2024 07:17:38.3393
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hD6BJzFRu6P14ObApDc1rqrAvHfKsg8WbaPSOpk8UWFNIcepClajTR1pK97AB/UFQXrzW2OSQFn6DnvB7R6IyqDJEw13+k/qy+f+PpBBHkM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAYP264MB3437

K0NDIG5ldGRldiBBUk0gUnVzc2VsbA0KDQpMZSAyOS8wMi8yMDI0IMOgIDIzOjQ2LCBDaGFybGll
IEplbmtpbnMgYSDDqWNyaXTCoDoNCj4gVGhlIHRlc3QgY2FzZXMgZm9yIGlwX2Zhc3RfY3N1bSBh
bmQgY3N1bV9pcHY2X21hZ2ljIHdlcmUgbm90IHByb3Blcmx5DQo+IGFsaWduaW5nIHRoZSBJUCBo
ZWFkZXIsIHdoaWNoIHdlcmUgY2F1c2luZyBmYWlsdXJlcyBvbiBhcmNoaXRlY3R1cmVzDQo+IHRo
YXQgZG8gbm90IHN1cHBvcnQgbWlzYWxpZ25lZCBhY2Nlc3NlcyBsaWtlIHNvbWUgQVJNIHBsYXRm
b3Jtcy4gVG8NCj4gc29sdmUgdGhpcywgYWxpZ24gdGhlIGRhdGEgYWxvbmcgKDE0ICsgTkVUX0lQ
X0FMSUdOKSBieXRlcyB3aGljaCBpcyB0aGUNCj4gc3RhbmRhcmQgYWxpZ25tZW50IG9mIGFuIElQ
IGhlYWRlciBhbmQgbXVzdCBiZSBzdXBwb3J0ZWQgYnkgdGhlDQo+IGFyY2hpdGVjdHVyZS4NCg0K
SW4geW91ciBkZXNjcmlwdGlvbiwgcGxlYXNlIHByb3ZpZGUgbW9yZSBkZXRhaWxzIG9uIHBsYXRm
b3JtcyB0aGF0IGhhdmUgDQphIHByb2JsZW0sIHdoYXQgdGhlIHByb2JsZW0gaXMgZXhhY3RseSAo
RmFpbGVkIGNhbGN1bGF0aW9uLCBzbG93bGluZXNzLCANCmtlcm5lbCBPb3BzLCBwYW5pYywgLi4u
Likgb24gZWFjaCBwbGF0Zm9ybS4NCg0KQW5kIHBsZWFzZSBjb3B5IG1haW50YWluZXJzIGFuZCBs
aXN0cyBvZiBwbGF0Zm9ybXMgeW91ciBhcmUgc3BlY2lmaWNhbGx5IA0KYWRkcmVzc2luZyB3aXRo
IHRoaXMgY2hhbmdlLiBBbmQgYXMgdGhpcyBpcyBuZXR3b3JrIHJlbGF0ZWQsIG5ldGRldiBsaXN0
IA0Kc2hvdWxkIGhhdmUgYmVlbiBjb3BpZWQgYXMgd2VsbC4NCg0KSSBzdGlsbCB0aGluayB0aGF0
IHlvdXIgcGF0Y2ggaXMgbm90IHRoZSBnb29kIGFwcHJvYWNoLCBpdCBsb29rcyBsaWtlIA0KeW91
IGFyZSBpZ25vcmluZyBhbGwgdGhlIGRpc2N1c3Npb24uIEJlbG93IGlzIGEgcXVvdGUgb2Ygd2hh
dCBHZWVydCBzYWlkIA0KYW5kIEkgZnVsbHkgYWdyZWUgd2l0aCB0aGF0Og0KDQoJSU1ITyB0aGUg
dGVzdHMgc2hvdWxkIHZhbGlkYXRlIHRoZSBleHBlY3RlZCBmdW5jdGlvbmFsaXR5LiAgSWYgYSB0
ZXN0DQoJZmFpbHMsIGVpdGhlciBmdW5jdGlvbmFsaXR5IGlzIG1pc3Npbmcgb3IgYmVoYXZlcyB3
cm9uZywgb3IgdGhlIHRlc3QNCglpcyB3cm9uZy4NCg0KCVdoYXQgaXMgdGhlIHBvaW50IG9mIHdy
aXRpbmcgdGVzdHMgZm9yIGEgY29yZSBmdW5jdGlvbmFsaXR5IGxpa2UgbmV0d29yaw0KCWNoZWNr
c3VtbWluZyB0aGF0IGRvIG5vdCBtYXRjaCB0aGUgZXhwZWN0ZWQgZnVuY3Rpb25hbGl0eT8NCg0K
DQpTbyB3ZSBhbGwgYWdyZWUgdGhhdCB0aGVyZSBpcyBzb21ldGhpbmcgdG8gZml4LCBiZWNhdXNl
IHRvZGF5J3MgdGVzdCANCmRvZXMgb2RkLWFkZHJlc3MgYWNjZXNzZXMgd2hpY2ggaXMgdW5leHBl
Y3RlZCBmb3IgdGhvc2UgZnVuY3Rpb25zLCBidXQgDQoyLWJ5dGUgYWxpZ25tZW50cyBzaG91bGQg
YmUgc3VwcG9ydGVkIGhlbmNlIHRlc3RlZCBieSB0aGUgdGVzdC4gTGltaXRpbmcgDQp0aGUgdGVz
dCB0byBhIDE2LWJ5dGVzIGFsaWdubWVudCBkZWVwbHkgcmVkdWNlcyB0aGUgdXNlZnVsbG5lc3Mg
b2YgdGhlIHRlc3QuDQoNCkNocmlzdG9waGUNCg==

