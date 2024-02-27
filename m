Return-Path: <linux-kernel+bounces-82757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 719FA868923
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 07:47:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0133E1F2596E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 06:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02D04535A2;
	Tue, 27 Feb 2024 06:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=csgroup.eu header.i=@csgroup.eu header.b="CWX4wLO/"
Received: from FRA01-MR2-obe.outbound.protection.outlook.com (mail-mr2fra01on2091.outbound.protection.outlook.com [40.107.9.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC12053395;
	Tue, 27 Feb 2024 06:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.9.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709016464; cv=fail; b=D806M7rrc7sv6kzfjzSgVu/09O+HTBLDc55DD+EuqGyBm6VZ+naqOuKb2itPA9nDX+jNblfwGJjwhbN5Mr0WA4RwdCJc+7K8d27qWoLmbnIQKf/mMYS48rqWVnQj7dOL5t6J9udqVn4C2yKdS8hoy+/+YEMAini1/XbbUVCIVQI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709016464; c=relaxed/simple;
	bh=TWOP0UxarOyu9AeZzfFY9AcFOtd0HCJeIVkitz/7gWk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Qnkl31QwHnfSppmVUfvDaqIQoesqqVIj8e8ptrIzB4X4tokNXymEyS/mC+jxWH4DOIrHIePdmZ1mT8gsxv8srwXU+QB1aLQatURB/oTSf5TuLmElQ0gQhETp3zOOEqCPFbAJ4me4Nt4XHDupmM4mN62SyMLwejGYcQzyLW4Tz88=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; dkim=pass (2048-bit key) header.d=csgroup.eu header.i=@csgroup.eu header.b=CWX4wLO/; arc=fail smtp.client-ip=40.107.9.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lGasjl+J3jjYkAkaB/h4ikqWFhiBs4xfLjWoV9PhQtszOYox6ppsGGXLz3kTjhX1HjDEzYljBTrnc+1NrbCPWDRDXFMhZa+dq6ggqFoUuovXa3m3y8OCtPD8kiBrm8dqAcoEAQzRJQttf88ywNC7mrOJwxtk+VXzltzLbNjmzkCwmnemDIEalX3PE5IWF/+IMZs3CzrY3mO0Mwst9HnmhCXxqi7ACIAqrbQkf+vyB5nnoBDoDKZDWa2kCq2x8Kw3vgjQVbaecNrVHZxCNrGRwXsHeUwkIThyrZMAI6xTQNhGR0k5neIKRC48pnkwWs+2sdLE3uFXYeOECASAveDjwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TWOP0UxarOyu9AeZzfFY9AcFOtd0HCJeIVkitz/7gWk=;
 b=f2o7lJkCUTXvwayghgovFm3+zDAcKH/43oO/GZgXdf8+CyLdP2pqrM/1ToUOBr/jrZWRNCXUhk35uMXBsEpauG1WHG9BNlZ1EwcPoaXApkR+zUT5bPPez8buzvlctX6shnu8R4hloaDnfee3dNTbfDy/N227JlwtlghJW1ia2M4eF4VSzV7d72TDp5cMEEuNnN1CX2W2H81Lx3PKeTrYYRWexOc85ONNeVsTjPJ5ks4VCzqbC/nWAxgqCvY5Sd1MsAdt6TtSWxmf2tskIL3GXjTFMMMrLKAPwuLg3O+6rh2tlY9m83/ctejS3a0uVsScHbrciuItFT/m2FVB/ABOkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TWOP0UxarOyu9AeZzfFY9AcFOtd0HCJeIVkitz/7gWk=;
 b=CWX4wLO/FqZdMzlYqKelX9sSEXC3TR1lstZPkw8XxOl6dbQpQbnt9TGhjl/4FH6OJDFeJhuTuPmH8y1EpKGxWDXiID0unN7pEg9YNjawgESKxM44kWeZ5REqWvP2Futp/rb7zBg2xWb0WP7OrNbzjGdU+iOLZ5Xjc/5StDAz8grYC5Fankc3GK5vcEyFeNtRv0zAIsEr4VPsCZ+9usjMZ8jegj5ga3e3EipVvVr37MjYnDWng7puA3vHz2vfOWPvdzXvD2nb/wLzpuh+Yj5X/JC6wiE6jOGdni8AswTHEX+brfCW/K/INHqJwnnMApL4Pt4lMJHJvAu7b1nRZJtINQ==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by MR1P264MB2963.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:3c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.36; Tue, 27 Feb
 2024 06:47:38 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::c192:d40f:1c33:1f4e]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::c192:d40f:1c33:1f4e%6]) with mapi id 15.20.7316.035; Tue, 27 Feb 2024
 06:47:38 +0000
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Guenter Roeck <linux@roeck-us.net>, Charlie Jenkins
	<charlie@rivosinc.com>, David Laight <David.Laight@aculab.com>
CC: 'Russell King' <linux@armlinux.org.uk>, Palmer Dabbelt
	<palmer@dabbelt.com>, Andrew Morton <akpm@linux-foundation.org>, Helge Deller
	<deller@gmx.de>, "James E.J. Bottomley"
	<James.Bottomley@hansenpartnership.com>, Parisc List
	<linux-parisc@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Palmer Dabbelt
	<palmer@rivosinc.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v10] lib: checksum: Use aligned accesses for ip_fast_csum
 and csum_ipv6_magic tests
Thread-Topic: [PATCH v10] lib: checksum: Use aligned accesses for ip_fast_csum
 and csum_ipv6_magic tests
Thread-Index:
 AQHaZqVM7f0VA9oidkaHzRbh3i5s67EcglMAgABWg4CAABKTgIAADGQAgAAIygCAADniAIAADA6AgAAI14CAAHULAA==
Date: Tue, 27 Feb 2024 06:47:38 +0000
Message-ID: <9b4ce664-3ddb-4789-9d5d-8824f9089c48@csgroup.eu>
References:
 <20240223-fix_sparse_errors_checksum_tests-v10-1-b6a45914b7d8@rivosinc.com>
 <7ae930a7-3b10-4470-94ee-89cb650b3349@csgroup.eu>
 <e11fea7a-e99e-4539-a489-0aa145ee65f0@roeck-us.net>
 <ZdzPgSCTntY7JD5i@shell.armlinux.org.uk> <ZdzZ5tk459bgUrgz@ghost>
 <ZdzhRntTHApp0doV@shell.armlinux.org.uk>
 <b13b8847977d4cfa99b6a0c9a0fcbbcf@AcuMS.aculab.com> <Zd0b8SDT8hrG/0yW@ghost>
 <cdd09f7a-83b2-41ba-a32c-9886dd79c43e@roeck-us.net>
In-Reply-To: <cdd09f7a-83b2-41ba-a32c-9886dd79c43e@roeck-us.net>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|MR1P264MB2963:EE_
x-ms-office365-filtering-correlation-id: ee5dc97c-7728-49a3-7247-08dc375ffd16
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 w42jBQ6vasXp47lvL4xsVR5qSc9zV7k+JHJLirzvevmDOD9CHICVILV8+f6HJFh7skF/6VDfMlTf8SNdiSUZsYT4u5f6OsfO9XE7B0+VDjs+JuFf+1lWQs3fC8wmw1rpM4dObIJCNmcftU9uWznUZEZRcXi6fDYYC4971AKmbJnn1uXxhvMywkYYxG38Tf1gG8JJg99oAx6VKKlXnRc6GHKTEVX4EmfoqHwLzlej7m5a14zRvw3BM+3P/fxEC9OF8CnqpZu3mh8SZbB1/mrQllJbnWx/35vntt60e7D+Mg1fx9d/W5ugztJzsydblF9iEsuXfzWjidHTJm4wZliNx2/vMouRgZfcn9KSeH0aDArDwPXHGid0sIB63c1gbAk7PGns9o2z5oHZoos4M/rciOMSFgI2szDxWuaYhrmyrWkIbKfLRynZFd38K3IfMdbqBb2yCJiTGRSttPzLrPGHHb5rRxq0ua+llKvCdZBFDof4dhLhjv62LKjw8CHDZ3Lj0srW6Of8zVSikbA8Yp/yFpU62ZisCGXTXwI8yeiwWM1CQ0cugJc5vOJ+NLL6+72+kdOsk4HQmzTyI7BDA7dXqJokHfDKMI47kUK1PhPPhxFUlVTJjfEmZ4JB45chUvF8JaT2nButCURmyZMdSPBgfJZ+L87+wyIyfURSoYQ4O0BvvNpnBeHDU52Y/y3dQV1l1owepL8UeaYqPIa+KryaA7XlCd79ofBjBpVHMcZZMdI=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UndaQy9RRExHVWthN3I3bHFKd0hOWGdCVldsSFI2ZWJWZ3NmK2I2R1Z2TGdk?=
 =?utf-8?B?NWgwNnl6eVM4OWkrT0NLdWhOQ2tXeTRqeVlrOGt0TVF5TXVvazJKeXgzZk9n?=
 =?utf-8?B?cXlRNEFiRTZxUUh6dm4zeERXSDNYZU10UWdHY1dxTzdjYmp3V2RYMTRISGFp?=
 =?utf-8?B?b2wzcHhUNGRaaGsyTEN6SjduUXA2UDZHQjIvTVIxZlBGNjd5RVRmZXF6MTBv?=
 =?utf-8?B?SWc2OXRmdndvdGNiMys3ZlZ0a1ZDS1FNYXA3SXdQTnZHZk4zNGdDd2p1QmFB?=
 =?utf-8?B?YUU4VzdQbFo3ZFpsb3FDNkcvWkVHTW05RUlwNjY2VWdLZy9VK05zWkorMUJr?=
 =?utf-8?B?QlJHQmdwL0huSFNva2tXellZRThwZVZJN0p5NDZWQVFzZjRwajdKSFk0Ukxz?=
 =?utf-8?B?STVZZkZPNXl3QVVTYW1OUWxROWlhT005Mk1VbnlwMlRiSXFHVlBHNzFhNjBM?=
 =?utf-8?B?MlhDbFFUZXk1YUFqZmJJTkZGM1h6S3V2c0dCZzVQOEJyK0dNbnNuMk5sR1Jj?=
 =?utf-8?B?VlVQTkFxamVjVU5tNDRHNWNVb250YStQc3VXSTBKdk5ZbmJlKzFKYUZETWZP?=
 =?utf-8?B?anNtSHdyUlNaZHRvaWRJbWU0RUZDSHc5U3I5NkNaaHFBR3FUODI0eGdENk5u?=
 =?utf-8?B?WnZzUDBZZkd2K2JXc2J2RjZUZ0hYZjhhTXp4ajRWazhMZXJTSDBQc3ZUYjVx?=
 =?utf-8?B?YkdEOENWY2M2S056eVZ1TlpGOFY2ZjRjcFBzMXM2VHVnL29Yb3owMzR2K2g0?=
 =?utf-8?B?MEIrcUdwUmtBQk1OekYvaWVPMTBIbThqenpoTkw3UHhJVEx5OUJtRVBVdWVy?=
 =?utf-8?B?MThiUXdESys3c3E3TVpDQVJneUs2bjZ5MjZMcE5qQ0ZISFpsMksvYjFZdEdR?=
 =?utf-8?B?aEJscEF6Z3pPS1VGNTdCZi91UFN2Qy9DSkYxaWtGaVp1SnV5d2hNK3A0ajlN?=
 =?utf-8?B?RzRRNXY0eXRHZUwwWmJ0bmpnZ3UxUTFIdm81RXRrK1F6dG5TcVJpSUlBQTZS?=
 =?utf-8?B?S1U1M2ZzcnVVVjF5SUJLK1FhU2tqenpGVW1ESFhlbVpVby8wVG1XS2w0eU1v?=
 =?utf-8?B?TUxwWjBoOWk0TUViTFBiczl3bzAxMkJ6aDUrYVA0ZTRTWmJpTDk3TzVpOHNQ?=
 =?utf-8?B?NzBVaityN1RuVVR5aXkyZVQ3VkVxbG5OOGg5NC91K0NkUzYrT2pyZ21yZ1BE?=
 =?utf-8?B?UHlNODMvd2JpajczdEJCWkh5cEtDbjY0QW1mcHNUM3p3RUhwa3lEWWFVakl5?=
 =?utf-8?B?cVBrK3ZsUWRNNElqTkNIQitnSitsdnp2eER2Rnl1TmVZdnA2Rkw5WXduQ1Q4?=
 =?utf-8?B?ZC9nWlVsdlVRSngrNERHNWh4UnRNckwyeGo0dmIvSFM4SUlBRkFXcWIzZUlj?=
 =?utf-8?B?NzNRMzhDY2llbEg1MjZoTi9sWlBoMmtLRThnVlVxU2xuOTgxSzduNE92QzRh?=
 =?utf-8?B?MCtxdGVqaXI4ZVJZU0ZEMVl2MzEzVWxISTZXZTV2bUxaNUlRUXdtOWkwZGo4?=
 =?utf-8?B?V0VHY0JFRXNFbWtlSFRnMXdQNXhHOStQb3hFeVZ5eGRCK1NmRFVZOUY3RmFk?=
 =?utf-8?B?dVdOU3h6dmtzSUtZaytDSVFXQ0p4dUNMMEFSS0N0eEVXS0VsOGx2cXgvZGp5?=
 =?utf-8?B?OXpXWDhlODNHT2I3L01wWjhoUDZxU1grcnhmYWF3dFVYMHQ5ZXR5RFZydXV0?=
 =?utf-8?B?TkpZSW1ZdEp3RTNmMkdNeXl3b3NwcWNocm5idnJHKzR0Q3Znbm9mV1c5NEhy?=
 =?utf-8?B?aVdDWCt5NDJtOWMrV05mWWxOS1N2YzdvRHM1a0xKSHFWNjgvbmdQNWtnTnBo?=
 =?utf-8?B?WThSUnVYZ3hieDFxVTYvTTE4KzFUNzJWOG5KMmVjVWRQL3FYUmtMTzBQeUpO?=
 =?utf-8?B?bFFEcWM5cWJDRXR5T1pDcjFZTHc0S1phVWRlMkp5NGI0UVBON2VmNUFhZjU2?=
 =?utf-8?B?OGd2MTJzdWhJbnVQc1RIdVUrcVR1c0xmdVhpRVJZTGk5V2kyY2xpZmlEdXJK?=
 =?utf-8?B?WkJhQWdNV0M4Q21kWDdyQkJWTXdQVjd2R0lKUEsreVBNTllDVGtHcjlMVnl1?=
 =?utf-8?B?djVHMVZReHViM3NpWmo5b2ltWks5V2YxWkliKzZINnZjMjIvWHpKSHlKZ1E4?=
 =?utf-8?B?WVEwemRGT1k2bGFtNUNubkV3RHV1TFhNS0xBMldta0I1eFlWdjBhbG5WdExY?=
 =?utf-8?B?ZWJVUzNldm9wdlBjbDRDVFdhSzY4ZGhFYUdkN1FCMFN4VHFnM2Y5SVBPc2E3?=
 =?utf-8?B?d0VYK3pubUpJSDJPY0UwN0dUcTJRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3FC07316A769604997FDCAC155FDAC2C@FRAP264.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ee5dc97c-7728-49a3-7247-08dc375ffd16
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2024 06:47:38.6610
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9RQPLZ63EKfzi2eS/63m0RlTdwgpKxGL02LoaYogGTFBgyiaD6JU4QikpO9Bq/Ed9k0isflqrNV4f7h3HmkeaPLcBAwFyjXcWHJD+MEovdo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB2963

DQoNCkxlIDI3LzAyLzIwMjQgw6AgMDA6NDgsIEd1ZW50ZXIgUm9lY2sgYSDDqWNyaXTCoDoNCj4g
T24gMi8yNi8yNCAxNToxNywgQ2hhcmxpZSBKZW5raW5zIHdyb3RlOg0KPj4gT24gTW9uLCBGZWIg
MjYsIDIwMjQgYXQgMTA6MzM6NTZQTSArMDAwMCwgRGF2aWQgTGFpZ2h0IHdyb3RlOg0KPj4+IC4u
Lg0KPj4+PiBJIHRoaW5rIHlvdSBtaXN1bmRlcnN0YW5kLiAiTkVUX0lQX0FMSUdOIG9mZnNldCBp
cyB3aGF0IHRoZSBrZXJuZWwNCj4+Pj4gZGVmaW5lcyB0byBiZSBzdXBwb3J0ZWQiIGlzIGEgZ3Jv
c3MgbWlzaW50ZXJwcmV0YXRpb24uIEl0IGlzIG5vdA0KPj4+PiAiZGVmaW5lZCB0byBiZSBzdXBw
b3J0ZWQiIGF0IGFsbC4gSXQgaXMgdGhlIF9wcmVmZXJyZWRfIGFsaWdubWVudA0KPj4+PiBub3Ro
aW5nIG1vcmUsIG5vdGhpbmcgbGVzcy4NCj4+DQo+PiBUaGlzIGRpc3RpbmN0aW9uIGlzIGFyYml0
cmFyeSBpbiBwcmFjdGljZSwgYnV0IEkgYW0gb3BlbiB0byBiZWluZyBwcm92ZW4NCj4+IHdyb25n
IGlmIHlvdSBoYXZlIGRhdGEgdG8gYmFjayB1cCB0aGlzIHN0YXRlbWVudC4gSWYgdGhlIGRyaXZl
ciBjaG9vc2VzDQo+PiB0byBub3QgZm9sbG93IHRoaXMsIHRoZW4gdGhlIGRyaXZlciBtaWdodCBu
b3Qgd29yay4gQVJNIGRlZmluZXMgdGhlDQo+PiBORVRfSVBfQUxJR04gdG8gYmUgMiB0byBwYWQg
b3V0IHRoZSBoZWFkZXIgdG8gYmUgb24gdGhlIHN1cHBvcnRlZA0KPj4gYWxpZ25tZW50LiBJZiB0
aGUgZHJpdmVyIGNob29zZXMgdG8gcGFkIHdpdGggb25lIGJ5dGUgaW5zdGVhZCBvZiAyDQo+PiBi
eXRlcywgdGhlIGRyaXZlciBtYXkgZmFpbCB0byB3b3JrIGFzIHRoZSBDUFUgbWF5IHN0YWxsIGFm
dGVyIHRoZQ0KPj4gbWlzYWxpZ25lZCBhY2Nlc3MuDQo+Pg0KPj4+DQo+Pj4gSSdtIHN1cmUgSSd2
ZSBzZWVuIGNvZGUgdGhhdCB3b3VsZCByZWFsaWduIElQIGhlYWRlcnMgdG8gYSA0IGJ5dGUNCj4+
PiBib3VuZGFyeSBiZWZvcmUgcHJvY2Vzc2luZyB0aGVtIC0gYnV0IHRoYXQgbWlnaHQgbm90IGhh
dmUgYmVlbiBpbg0KPj4+IExpbnV4Lg0KPj4+DQo+Pj4gSSdtIGFsc28gc3VyZSB0aGVyZSBhcmUg
Y3B1IHdoaWNoIHdpbGwgZmF1bHQgZG91YmxlIGxlbmd0aCBtaXNhbGlnbmVkDQo+Pj4gbWVtb3J5
IHRyYW5zZmVycyAtIHdoaWNoIG1pZ2h0IGJlIHVzZWQgdG8gbWFyZ2luYWxseSBzcGVlZCB1cCBj
b2RlLg0KPj4+IEFzc3VtaW5nIG1vcmUgdGhhbiA0IGJ5dGUgYWxpZ25tZW50IGZvciB0aGUgSVAg
aGVhZGVyIGlzIGxpa2VseQ0KPj4+ICd3aXNoZnVsIHRoaW5raW5nJy4NCj4+Pg0KPj4+IFRoZXJl
IGlzIHBsZW50eSBvZiBldGhlcm5ldCBoYXJkd2FyZSB0aGF0IGNhbiBvbmx5IHdyaXRlIGZyYW1l
cw0KPj4+IHRvIGV2ZW4gYm91bmRhcmllcyBhbmQgcGxlbnR5IG9mIGNwdSB0aGF0IGZhdWx0IG1p
c2FsaWduZWQgYWNjZXNzZXMuDQo+Pj4gVGhlcmUgYXJlIGV2ZW4gY2FzZXMgb2YgYm90aCBvbiB0
aGUgc2FtZSBzaWxpY29uIGRpZS4NCj4+Pg0KPj4+IFlvdSBhbHNvIHByZXR0eSBtdWNoIG5ldmVy
IHdhbnQgYSBmYXVsdCBoYW5kbGVyIHRvIGZpeHVwIG1pc2FsaWduZWQNCj4+PiBldGhlcm5ldCBm
cmFtZXMgKG9yIHJlYWxseSBhbnl0aGluZyBlbHNlIGZvciB0aGF0IG1hdHRlcikuDQo+Pj4gSXQg
aXMgYWx3YXlzIGdvaW5nIHRvIGJlIGJldHRlciB0byBjaGVjayBpbiB0aGUgY29kZSBpdHNlbGYu
DQo+Pj4NCj4+PiB4ODYgaGFzIGp1c3QgbWFkZSBwZW9wbGUgJ3Nsb3BweScgOi0pDQo+Pj4NCj4+
PiDCoMKgwqDCoERhdmlkDQo+Pj4NCj4+PiAtDQo+Pj4gUmVnaXN0ZXJlZCBBZGRyZXNzIExha2Vz
aWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIA0KPj4+IE1LMSAx
UFQsIFVLDQo+Pj4gUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCj4+Pg0KPj4NCj4+
IElmIHNvbWVib2R5IGhhcyBhIHNvbHV0aW9uIHRoZXkgZGVlbSB0byBiZSBiZXR0ZXIsIEkgYW0g
aGFwcHkgdG8gY2hhbmdlDQo+PiB0aGlzIHRlc3QgY2FzZS4gT3RoZXJ3aXNlLCBJIHdvdWxkIGFw
cHJlY2lhdGUgYSBtYWludGFpbmVyIHJlc29sdmluZw0KPj4gdGhpcyBkaXNjdXNzaW9uIGFuZCBh
cHBseSB0aGlzIGZpeC4NCj4+DQo+IEFncmVlZC4NCj4gDQo+IEkgZG8gaGF2ZSBhIGNvdXBsZSBv
ZiBwYXRjaGVzIHdoaWNoIGFkZCBleHBsaWNpdCB1bmFsaWduZWQgdGVzdHMgYXMgd2VsbCBhcw0K
PiBjb3JuZXIgY2FzZSB0ZXN0cyAod2hpY2ggYXJlIGludGVuZGVkIHRvIHRyaWdnZXIgYXMgbWFu
eSBjYXJyeSBvdmVyZmxvd3MNCj4gYXMgcG9zc2libGUpLiBPbmNlIEkgZ2V0IHRob3NlIHdvcmtp
bmcgcmVsaWFibHksIEknbGwgYmUgaGFwcHkgdG8gc3VibWl0DQo+IHRoZW0gYXMgYWRkaXRpb25h
bCB0ZXN0cy4NCj4gDQoNClRoZSBmdW5jdGlvbnMgZGVmaW5pdGVseSBoYXZlIHRvIHdvcmsgYXQg
bGVhc3Qgd2l0aCBhbmQgd2l0aG91dCBWTEFOLCANCndoaWNoIG1lYW5zIHRoZSBhbGlnbm1lbnQg
Y2Fubm90IGJlIGdyZWF0ZXIgdGhhbiA0IGJ5dGVzLiBUaGF0J3MgYWxzbyANCnRoZSBvdXRjb21l
IG9mIHRoZSBkaXNjdXNzaW9uLg0KDQpUaGVyZWZvcmUsIHdlIGNhbiBlYXNpbHkgZml4IHRoZSB0
ZXN0cyB3aXRoIGZvciBpbnN0YW5jZSB0aGUgZm9sbG93aW5nIA0KY2hhbmdlcy4gRm9yIHRoZSBJ
UHY2IHRlc3QgSSBzd2l0Y2hlZCBwcm90byBhbmQgY3N1bSB0byBrZWVwIGNzdW0gDQphbGlnbmVk
LiAoSW4gYWRkaXRpb24gZXhwZWN0ZWQgdmFsdWVzIG5lZWQgdG8gYmUgcmVjYWxjdWxhdGVkIGZv
ciB0aGUgDQpJUHY2IGNhc2UpLg0KDQpkaWZmIC0tZ2l0IGEvbGliL2NoZWNrc3VtX2t1bml0LmMg
Yi9saWIvY2hlY2tzdW1fa3VuaXQuYw0KaW5kZXggYmY3MDg1MDAzNWM3Li4yNmIwZGJjNWI4ZmQg
MTAwNjQ0DQotLS0gYS9saWIvY2hlY2tzdW1fa3VuaXQuYw0KKysrIGIvbGliL2NoZWNrc3VtX2t1
bml0LmMNCkBAIC01ODEsNyArNTgxLDcgQEAgc3RhdGljIHZvaWQgdGVzdF9pcF9mYXN0X2NzdW0o
c3RydWN0IGt1bml0ICp0ZXN0KQ0KICAJdTE2IGV4cGVjdGVkOw0KDQogIAlmb3IgKGludCBsZW4g
PSBJUHY0X01JTl9XT1JEUzsgbGVuIDwgSVB2NF9NQVhfV09SRFM7IGxlbisrKSB7DQotCQlmb3Ig
KGludCBpbmRleCA9IDA7IGluZGV4IDwgTlVNX0lQX0ZBU1RfQ1NVTV9URVNUUzsgaW5kZXgrKykg
ew0KKwkJZm9yIChpbnQgaW5kZXggPSAwOyBpbmRleCA8IE5VTV9JUF9GQVNUX0NTVU1fVEVTVFM7
IGluZGV4ICs9IDQpIHsNCiAgCQkJY3N1bV9yZXN1bHQgPSBpcF9mYXN0X2NzdW0ocmFuZG9tX2J1
ZiArIGluZGV4LCBsZW4pOw0KICAJCQlleHBlY3RlZCA9DQogIAkJCQlleHBlY3RlZF9mYXN0X2Nz
dW1bKGxlbiAtIElQdjRfTUlOX1dPUkRTKSAqDQpAQCAtNjAzLDEyICs2MDMsMTAgQEAgc3RhdGlj
IHZvaWQgdGVzdF9jc3VtX2lwdjZfbWFnaWMoc3RydWN0IGt1bml0ICp0ZXN0KQ0KDQogIAljb25z
dCBpbnQgZGFkZHJfb2Zmc2V0ID0gc2l6ZW9mKHN0cnVjdCBpbjZfYWRkcik7DQogIAljb25zdCBp
bnQgbGVuX29mZnNldCA9IHNpemVvZihzdHJ1Y3QgaW42X2FkZHIpICsgc2l6ZW9mKHN0cnVjdCBp
bjZfYWRkcik7DQotCWNvbnN0IGludCBwcm90b19vZmZzZXQgPSBzaXplb2Yoc3RydWN0IGluNl9h
ZGRyKSArIHNpemVvZihzdHJ1Y3QgDQppbjZfYWRkcikgKw0KLQkJCSAgICAgc2l6ZW9mKGludCk7
DQotCWNvbnN0IGludCBjc3VtX29mZnNldCA9IHNpemVvZihzdHJ1Y3QgaW42X2FkZHIpICsgc2l6
ZW9mKHN0cnVjdCANCmluNl9hZGRyKSArDQotCQkJICAgIHNpemVvZihpbnQpICsgc2l6ZW9mKGNo
YXIpOw0KKwljb25zdCBpbnQgY3N1bV9vZmZzZXQgPSBsZW5fb2Zmc2V0ICsgc2l6ZW9mKGludCk7
DQorCWNvbnN0IGludCBwcm90b19vZmZzZXQgPSBjc3VtX29mZnNldCArIHNpemVvZihpbnQpOw0K
DQotCWZvciAoaW50IGkgPSAwOyBpIDwgTlVNX0lQdjZfVEVTVFM7IGkrKykgew0KKwlmb3IgKGlu
dCBpID0gMDsgaSA8IE5VTV9JUHY2X1RFU1RTOyBpICs9IDQpIHsNCiAgCQlzYWRkciA9IChjb25z
dCBzdHJ1Y3QgaW42X2FkZHIgKikocmFuZG9tX2J1ZiArIGkpOw0KICAJCWRhZGRyID0gKGNvbnN0
IHN0cnVjdCBpbjZfYWRkciAqKShyYW5kb21fYnVmICsgaSArDQogIAkJCQkJCSAgZGFkZHJfb2Zm
c2V0KTsNCi0tLQ0KV2UgY291bGQgZG8gZXZlbiBiZXR0ZXIgYnkgdGFraW5nIGludG8gYWNjb3Vu
dCANCkNPTkZJR19IQVZFX0VGRklDSUVOVF9VTkFMSUdORURfQUNDRVNTIGFuZCBkbyArMSB3aGVu
IGl0IGlzIHNlbGVjdGVkIGFuZCANCis0IHdoZW4gaXQgaXMgbm90IHNlbGVjdGVkLg0KDQpDaHJp
c3RvcGhlDQo=

