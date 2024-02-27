Return-Path: <linux-kernel+bounces-83847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 469B6869F30
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 19:35:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B24ED1F2CFAE
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 18:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C79EF3E48E;
	Tue, 27 Feb 2024 18:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=csgroup.eu header.i=@csgroup.eu header.b="Wly4/2XD"
Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-pr2fra01on2132.outbound.protection.outlook.com [40.107.12.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950DA3C490;
	Tue, 27 Feb 2024 18:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.12.132
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709058909; cv=fail; b=omsl+gTxc9gNKeL11DoI6dvJ1p62mTnMX7DbMxbyxVj3hRRrD5mm0q5LH8vTO+G7PMlRtlO2aNsxd+uxetj1ogG6zU3eYpklbAjYOyFTVo0877a2f3qTfpbzcPP71dUBB759Kqpc+6Dizo806LLNOD4JINmvwE/NA2YNtOx8Ep8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709058909; c=relaxed/simple;
	bh=8cMbHQt/maC/gSvR6teyt6bdhV+lWv6jRjcqCRgMH/A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NgnzZLjvOshXc2v1kLPE2mzM/qXehoYY5KvhRrG/SrhR4ku8GiL2XFzpOLE14x6cjF+e9aIbujCA6Evdbp2M/7qm5nfUuYnWkzgypoAGYutcgczR+8rr8w/Pt1oOH/evtRkCXOiEOvbNECiEXniqc/MA7T+Xag9au9dw5226n7o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; dkim=pass (2048-bit key) header.d=csgroup.eu header.i=@csgroup.eu header.b=Wly4/2XD; arc=fail smtp.client-ip=40.107.12.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N5aL0DufnqnqZUWn06dv6wh0gz656uhhf1oH5EFJVt7J0BLxMpOyWGTv3Sf7ZrSoxfzVmPWuYmn5g+TixLOJB9xK8HQEkpxCftdYMGn+dYju9F2K/GuN7QcVszAewBkCYV0BVvsQ49qGZszd0xrxLgdbDFMTMl0R/f66gRwUqBlM2GUy9DkAR5r0+Avqqsybasmxl0WPTfOqF0VL0irUAxORPFJRxqAGnvbDH4AFXslLXKe8Eg2vineGorqAJe/xZJ1HDPhRWBtTuusJyqFnTKi8H/ziVpZ2B7hsIq1IN0r0qN9r8bdBuPbaxb4s3i+8GffTWhQJzY9GcbvK7+EHMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8cMbHQt/maC/gSvR6teyt6bdhV+lWv6jRjcqCRgMH/A=;
 b=Itri1bFDF3gBfJZURU631gv/E1UhYMCvsCJZxqPjJybOMJOQ0PIo+uHoaaxJLLA4pfAHnrIpEeqlejXZVCwib4mKTDhGwX9gr0XKl1DgGKtuMizfab+e/56G49WRbpD8h4H/R0qgoD1O3v8Fg3vGPzihMxUy8IFMMynPjy6bPTnsI+WjgU1ItK09A7jZJEDBp4dP81BYabMWjSzfrVegI+AQwKJMlV5fxNK6q4pMB7vFRV9EPozOCPZDwxkL6ToqkGaXMvidkEpoIXd+MFOCNX6GMa5n0NyBV5CamAgzVTtU0UkH1WE3oGxu2linZBx+yR0pxTil3AD6tiDeQ6nPsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8cMbHQt/maC/gSvR6teyt6bdhV+lWv6jRjcqCRgMH/A=;
 b=Wly4/2XDoUtRWBSiGAUyYkIcwulD9ui7wsoJhqwKMLw5dBfXXVh4Dm8WWwaj92EnNmvjtBJ0C9sV2kn1RCIwNJeepHqzmdHaOYa5k3GrsRLBHvuK+8dDpqd8kKZnjUi435Ux3iPZukXDX09J4HZLX27c+m3ZgLhlL+sJWIpgLQ5mvDvwARdt3eZERYXwFR8td301kBlq3H1iZ2b+BChtpf9vZ2qZveVeF1MxYnUlsZ38fXuuWZ/WLk9ezlh3XwqkK8QB34eEV04smr9DgzCmtEsNYEuWwVPiUB9/9CA2CvulS2x9r1r0qQ/nt17mmum5m04Pcvkbl42vQVR6y01nvw==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PR0P264MB2202.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:16c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.36; Tue, 27 Feb
 2024 18:35:04 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::c192:d40f:1c33:1f4e]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::c192:d40f:1c33:1f4e%6]) with mapi id 15.20.7316.035; Tue, 27 Feb 2024
 18:35:04 +0000
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Charlie Jenkins <charlie@rivosinc.com>
CC: "Russell King (Oracle)" <linux@armlinux.org.uk>, Guenter Roeck
	<linux@roeck-us.net>, David Laight <David.Laight@aculab.com>, Palmer Dabbelt
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
 AQHaZqVM7f0VA9oidkaHzRbh3i5s67EcglMAgABWg4CAABKTgIAADGQAgAAIygCAADniAIAADA6AgAAI14CAAHULAIAAPciAgAARwQCAAGrggIAABKIAgAAC1wCAAAPGAA==
Date: Tue, 27 Feb 2024 18:35:04 +0000
Message-ID: <f95267c0-5d4e-4732-8889-56f7a76cf081@csgroup.eu>
References: <ZdzZ5tk459bgUrgz@ghost> <ZdzhRntTHApp0doV@shell.armlinux.org.uk>
 <b13b8847977d4cfa99b6a0c9a0fcbbcf@AcuMS.aculab.com> <Zd0b8SDT8hrG/0yW@ghost>
 <cdd09f7a-83b2-41ba-a32c-9886dd79c43e@roeck-us.net>
 <9b4ce664-3ddb-4789-9d5d-8824f9089c48@csgroup.eu>
 <Zd25XWTkDPuIjpF8@shell.armlinux.org.uk>
 <c8ddcc98-acb0-4d2d-828a-8dd12e771b5f@csgroup.eu> <Zd4h6ZhvLSWfWJG/@ghost>
 <9f756413-806c-4cd0-a6cf-8dd82af14e88@csgroup.eu> <Zd4oLnVFJw6Qq0FA@ghost>
In-Reply-To: <Zd4oLnVFJw6Qq0FA@ghost>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|PR0P264MB2202:EE_
x-ms-office365-filtering-correlation-id: fff8639c-4ead-49be-0e47-08dc37c2d0b8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 6YdzTT00vLma5STcKkPTUQj5rohcOlkibHp8YO4nc8tKvOUX3xyddLmLmVCpJVkZmZqAMJHNGdP4TmzHw70pAIwwJfWzotB06ReGTzdHp7B9hhf29N4e9AG99BdbYbrNVWLJ7hwAhORkPXztp/o7P+7zyFfSAfENKg+LM3L5Q73ddUs1JGTabBNtF8HTyH1atg4+FXvQdR2cfdMWL82wA3BqmeIc6KXFHG4b3kgp5Q2Y+QVLHvW0IOgQvWt6yYiuSySJV6hLIGcnJmYfWq4zhvIGv04fEduaLCd7O1Aszc6h43tWxEgYlJltPTH9BZ/DFy1pm8KrOOIOK3UGDmz2Q+KF7w1EsmffdA1PaANqN9j6HQkPwufRSmE26jz/VBM25AapqLqfXQ3Gl56esYxT/S+6VqxpE88Ut4bVGwBlhPlGWXuO7dfk6eJBdHXzx9tyTlxvgBdLlD8uN0vquC/3p76Hz8LC1G8x/TFtZTG0TNxp8zlzw8mQzwJnLlz10Zup2f6K88VawvVhH/Rr1qd5cdtLcEg/BydULIy4sPxmxk1Q1R0eCyIYy5MmjCAAODpbT+6DX9Sp9bnrXwXdk7RVOeFkfrG5Q2kadMwWhWq3NBLwGJZc6JROhJVaolZExJiD/j1VttTg8Q9dksN/GnQL/kFErlU7jY0zjwz4omrj7s6E95ZdvVatXgdIWS+NGASp5ZoP1kqjtNP19T/uJyjrqbcYuk4yv+WPO9PqL0ZBc68=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UHVNcmJPNEdSTmRWRGVJelpTR1N1K0JTNnlFb0FWeVZZUytFOXNmSnY5VHdt?=
 =?utf-8?B?TU1MRUFYeGxzQnZXQXkxYVYrYWs2WkdDdlRMUU5Ha2o5RElyczhOR0lpdCtV?=
 =?utf-8?B?WjFVMUpOMURjZGszMzZmKzVxMkM3UkhUL1pjYUppbGs3ZTdKV3ZEcjZlZHAz?=
 =?utf-8?B?bU1zMnMvM3lxcU42aG5vbU50R2VFMm11SGlVQjgwRzJyUjVETFF6YUFZMUZL?=
 =?utf-8?B?SlBsNFRqa0x2RGRGektFeC9iZi9iWkl1cm1IOWFmQzBBc0M0aEJ0dzA0NWZz?=
 =?utf-8?B?bjNzVTkxa2lyT0N0QVdXVndodlN1UEQ4U1RPM0JOL2x1QWNkVkQzWUpFVTRB?=
 =?utf-8?B?ZzVMNUV4bk5HQUdZQXUwZGpOSnVYbjlsMDhIbkszNGZ5UUtYUDUrRi9HaFE0?=
 =?utf-8?B?dXBjTGVQZjMrOFkwYTJ4K2lTa0M0UE0wVU9DL1NaY2xvbkNHaFRnMWd3Q1k5?=
 =?utf-8?B?RzVnTG9LRVRseUNUTTBGRjZQZjBmUGt0VGdKd3RBUUVrTWVkZWxKN2EweDdY?=
 =?utf-8?B?eEQxUWRXeFZCSFJMTTFlVEYvQXVrRVFWUkRmU0xTUnNNOUx4ekk0ZUR4em9m?=
 =?utf-8?B?QS9qZTlieVAwejkway83NjVjSUVlVXBpRU9uSWc3V2ZqSnV5NGtSNEE0K2hj?=
 =?utf-8?B?dHhhVWdEM29VTStEVkdTZ3JXRno3alYrMG51T2FKSmhiZFVyQ0RNUG1MbEdK?=
 =?utf-8?B?QWtuWU03ci9rc2JsbUNZSER4YWRPQk5LTjJLR2VWUlRldEhEU3Z1cjhUMEJE?=
 =?utf-8?B?ZnJaUTZvNUVtcElMT2VESFpYaHcxQWVCM3VYUTVWSWNFSEI3TjlzaWRHMUdR?=
 =?utf-8?B?c01BcHpVWUlwMWxzK3BQbkI1NXlSbGtTSVFodEgwdGlLSm5Qdnl1OFBoaFFH?=
 =?utf-8?B?VzhtaVdLeWxhL1VLU2xSeWRXalpkWkpIdXY1UkV2VFd0SzF1OEdZZ3JjL0Q1?=
 =?utf-8?B?NUdhd2RDVG9CUjAyOFkvMTdPTVJubDltYm0vK1RRT1EzOHVUMXUvMy90SUhO?=
 =?utf-8?B?dU1IUytSdTdxRENBQy9aeThnMDVDQmRmWVdMSkYxV28yZTV0NU4rU0hEY0VE?=
 =?utf-8?B?K3l4YVJ1UTRZNlJydTdDaFkrOU9obVpjWnJCMi9TdHpQb3k4Z3NiaFZQU3pj?=
 =?utf-8?B?ejdKN2R1YXFIWlNpRkRKbGF1WkY1QUFDNWVvaTF4dWdTNVoxNE1GSFFCdC9w?=
 =?utf-8?B?QVNkVnVuZHFybUc1Q1NXRXZuZ2RtaHpKSnFhTGVBeVNTL295ZlNYcm5oVjlU?=
 =?utf-8?B?R1VtNEMrVzhrQUcvTFdONkJNMkViNG05bmtHc01XTWR2dkQyVWROaTJsaDdC?=
 =?utf-8?B?TG5JM1RaWlpQQlFFQ0pVZElaK1FnM29yNnZaZUdPV1RXUEZneVV6NGxqUDBu?=
 =?utf-8?B?eEZKajIwakJGUmlsbjNxVzFuMnZUalg1VDY4TFVZMGdtQXRtalk2VWR4NjdY?=
 =?utf-8?B?UWtFdkh3aWNMMXZKS1B0KzdnV2pNOVF5elVuMGEraStIRG5mVEtGL3FGekF6?=
 =?utf-8?B?NUphZVV2UlNCWkFLaGprY2pYQXpSUlE4L1MxRTV1Q0E5a3k0TEdXK0Q2Uzlv?=
 =?utf-8?B?YlpuR0xBeW9EaUVsejRVd3RtL2xndnIwWVRiSVBPZGMzUllGb2xXV2RFMGhB?=
 =?utf-8?B?Zi9QV2g2eHMwd3R1NnhDTWlPNnBzTG8xa0NNc3BKTFVKeEw0YzZRY0J4cmY4?=
 =?utf-8?B?YXg5VnVVOUNPcEVxcmtVUlJRTmlodyswWGtiSEpVZ3VDU25LV0tvek1HVjNS?=
 =?utf-8?B?YjZtY1ZPUDVBUW5JeEtlWUdWSFJ5UlBvelVja2ZLVElnSEw0NU95ZDN0cXFR?=
 =?utf-8?B?UnZ4WHZ3UXQvNnBIUTFwL0hRTGJSS3N2elZxcGhsU0lzLzJWa293V09VS2FH?=
 =?utf-8?B?ZFhsQ1QzZm5nU0xuaTFjNmRYcEh0S1o3d3FUR1RnSGFLZ2NvQ2NBUWU2VHJG?=
 =?utf-8?B?TGtrMzZ0eVNDb2xqV0pYL1kxaHlkZERtY1BCSzBiRWdwYnl0RlJrb3R6TjNL?=
 =?utf-8?B?bHR0ZGJnZFBzWkM4eVBvd0d4bkk0eUxjZlFrRkI1NWNib2lzR05PVWdIZkhS?=
 =?utf-8?B?UHhsa3BFNXZxKytSMW5LbmJCN2JzejBXc21ycy9SeUkrV3J0aXdCeEY5VU84?=
 =?utf-8?B?Y1ZRM2Q0UTQ4NHozTXp2QTZvaUIxcHRPWTRyY204MjdkbXl4T0dXUHlNejVF?=
 =?utf-8?B?N3Q4VHM1dGxDWkpiRXZPRkkwQXZ2UU1kbVp5SUlQSElmWTAyUHhlQUJqU1l2?=
 =?utf-8?B?d21wMzhCOEhDZEVyenZhOHJDalBRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F3F845FAACC62B40A0061854AC2D341D@FRAP264.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: fff8639c-4ead-49be-0e47-08dc37c2d0b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2024 18:35:04.4314
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2XVRbhh4TZvxaxMbWMJATTHiqoz7oFKmIWYah4xP7Ru90PLAAnXax411Juex86wWosN4tgTJ8xiNsQOJXjpToOHmQN/uSTqh07uSnTs4g0I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB2202

DQoNCkxlIDI3LzAyLzIwMjQgw6AgMTk6MjEsIENoYXJsaWUgSmVua2lucyBhIMOpY3JpdMKgOg0K
PiBPbiBUdWUsIEZlYiAyNywgMjAyNCBhdCAwNjoxMToyNFBNICswMDAwLCBDaHJpc3RvcGhlIExl
cm95IHdyb3RlOg0KPj4NCj4+DQo+PiBMZSAyNy8wMi8yMDI0IMOgIDE4OjU0LCBDaGFybGllIEpl
bmtpbnMgYSDDqWNyaXTCoDoNCj4+PiBPbiBUdWUsIEZlYiAyNywgMjAyNCBhdCAxMTozMjoxOUFN
ICswMDAwLCBDaHJpc3RvcGhlIExlcm95IHdyb3RlOg0KPj4+Pg0KPj4+Pg0KPj4+PiBMZSAyNy8w
Mi8yMDI0IMOgIDExOjI4LCBSdXNzZWxsIEtpbmcgKE9yYWNsZSkgYSDDqWNyaXTCoDoNCj4+Pj4+
IE9uIFR1ZSwgRmViIDI3LCAyMDI0IGF0IDA2OjQ3OjM4QU0gKzAwMDAsIENocmlzdG9waGUgTGVy
b3kgd3JvdGU6DQo+Pj4+Pj4NCj4+Pj4+Pg0KPj4+Pj4+IExlIDI3LzAyLzIwMjQgw6AgMDA6NDgs
IEd1ZW50ZXIgUm9lY2sgYSDDqWNyaXTCoDoNCj4+Pj4+Pj4gT24gMi8yNi8yNCAxNToxNywgQ2hh
cmxpZSBKZW5raW5zIHdyb3RlOg0KPj4+Pj4+Pj4gT24gTW9uLCBGZWIgMjYsIDIwMjQgYXQgMTA6
MzM6NTZQTSArMDAwMCwgRGF2aWQgTGFpZ2h0IHdyb3RlOg0KPj4+Pj4+Pj4+IC4uLg0KPj4+Pj4+
Pj4+PiBJIHRoaW5rIHlvdSBtaXN1bmRlcnN0YW5kLiAiTkVUX0lQX0FMSUdOIG9mZnNldCBpcyB3
aGF0IHRoZSBrZXJuZWwNCj4+Pj4+Pj4+Pj4gZGVmaW5lcyB0byBiZSBzdXBwb3J0ZWQiIGlzIGEg
Z3Jvc3MgbWlzaW50ZXJwcmV0YXRpb24uIEl0IGlzIG5vdA0KPj4+Pj4+Pj4+PiAiZGVmaW5lZCB0
byBiZSBzdXBwb3J0ZWQiIGF0IGFsbC4gSXQgaXMgdGhlIF9wcmVmZXJyZWRfIGFsaWdubWVudA0K
Pj4+Pj4+Pj4+PiBub3RoaW5nIG1vcmUsIG5vdGhpbmcgbGVzcy4NCj4+Pj4+Pj4+DQo+Pj4+Pj4+
PiBUaGlzIGRpc3RpbmN0aW9uIGlzIGFyYml0cmFyeSBpbiBwcmFjdGljZSwgYnV0IEkgYW0gb3Bl
biB0byBiZWluZyBwcm92ZW4NCj4+Pj4+Pj4+IHdyb25nIGlmIHlvdSBoYXZlIGRhdGEgdG8gYmFj
ayB1cCB0aGlzIHN0YXRlbWVudC4gSWYgdGhlIGRyaXZlciBjaG9vc2VzDQo+Pj4+Pj4+PiB0byBu
b3QgZm9sbG93IHRoaXMsIHRoZW4gdGhlIGRyaXZlciBtaWdodCBub3Qgd29yay4gQVJNIGRlZmlu
ZXMgdGhlDQo+Pj4+Pj4+PiBORVRfSVBfQUxJR04gdG8gYmUgMiB0byBwYWQgb3V0IHRoZSBoZWFk
ZXIgdG8gYmUgb24gdGhlIHN1cHBvcnRlZA0KPj4+Pj4+Pj4gYWxpZ25tZW50LiBJZiB0aGUgZHJp
dmVyIGNob29zZXMgdG8gcGFkIHdpdGggb25lIGJ5dGUgaW5zdGVhZCBvZiAyDQo+Pj4+Pj4+PiBi
eXRlcywgdGhlIGRyaXZlciBtYXkgZmFpbCB0byB3b3JrIGFzIHRoZSBDUFUgbWF5IHN0YWxsIGFm
dGVyIHRoZQ0KPj4+Pj4+Pj4gbWlzYWxpZ25lZCBhY2Nlc3MuDQo+Pj4+Pj4+Pg0KPj4+Pj4+Pj4+
DQo+Pj4+Pj4+Pj4gSSdtIHN1cmUgSSd2ZSBzZWVuIGNvZGUgdGhhdCB3b3VsZCByZWFsaWduIElQ
IGhlYWRlcnMgdG8gYSA0IGJ5dGUNCj4+Pj4+Pj4+PiBib3VuZGFyeSBiZWZvcmUgcHJvY2Vzc2lu
ZyB0aGVtIC0gYnV0IHRoYXQgbWlnaHQgbm90IGhhdmUgYmVlbiBpbg0KPj4+Pj4+Pj4+IExpbnV4
Lg0KPj4+Pj4+Pj4+DQo+Pj4+Pj4+Pj4gSSdtIGFsc28gc3VyZSB0aGVyZSBhcmUgY3B1IHdoaWNo
IHdpbGwgZmF1bHQgZG91YmxlIGxlbmd0aCBtaXNhbGlnbmVkDQo+Pj4+Pj4+Pj4gbWVtb3J5IHRy
YW5zZmVycyAtIHdoaWNoIG1pZ2h0IGJlIHVzZWQgdG8gbWFyZ2luYWxseSBzcGVlZCB1cCBjb2Rl
Lg0KPj4+Pj4+Pj4+IEFzc3VtaW5nIG1vcmUgdGhhbiA0IGJ5dGUgYWxpZ25tZW50IGZvciB0aGUg
SVAgaGVhZGVyIGlzIGxpa2VseQ0KPj4+Pj4+Pj4+ICd3aXNoZnVsIHRoaW5raW5nJy4NCj4+Pj4+
Pj4+Pg0KPj4+Pj4+Pj4+IFRoZXJlIGlzIHBsZW50eSBvZiBldGhlcm5ldCBoYXJkd2FyZSB0aGF0
IGNhbiBvbmx5IHdyaXRlIGZyYW1lcw0KPj4+Pj4+Pj4+IHRvIGV2ZW4gYm91bmRhcmllcyBhbmQg
cGxlbnR5IG9mIGNwdSB0aGF0IGZhdWx0IG1pc2FsaWduZWQgYWNjZXNzZXMuDQo+Pj4+Pj4+Pj4g
VGhlcmUgYXJlIGV2ZW4gY2FzZXMgb2YgYm90aCBvbiB0aGUgc2FtZSBzaWxpY29uIGRpZS4NCj4+
Pj4+Pj4+Pg0KPj4+Pj4+Pj4+IFlvdSBhbHNvIHByZXR0eSBtdWNoIG5ldmVyIHdhbnQgYSBmYXVs
dCBoYW5kbGVyIHRvIGZpeHVwIG1pc2FsaWduZWQNCj4+Pj4+Pj4+PiBldGhlcm5ldCBmcmFtZXMg
KG9yIHJlYWxseSBhbnl0aGluZyBlbHNlIGZvciB0aGF0IG1hdHRlcikuDQo+Pj4+Pj4+Pj4gSXQg
aXMgYWx3YXlzIGdvaW5nIHRvIGJlIGJldHRlciB0byBjaGVjayBpbiB0aGUgY29kZSBpdHNlbGYu
DQo+Pj4+Pj4+Pj4NCj4+Pj4+Pj4+PiB4ODYgaGFzIGp1c3QgbWFkZSBwZW9wbGUgJ3Nsb3BweScg
Oi0pDQo+Pj4+Pj4+Pj4NCj4+Pj4+Pj4+PiAgICDCoMKgwqDCoERhdmlkDQo+Pj4+Pj4+Pj4NCj4+
Pj4+Pj4+PiAtDQo+Pj4+Pj4+Pj4gUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5
IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsDQo+Pj4+Pj4+Pj4gTUsxIDFQVCwgVUsN
Cj4+Pj4+Pj4+PiBSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0KPj4+Pj4+Pj4+DQo+
Pj4+Pj4+Pg0KPj4+Pj4+Pj4gSWYgc29tZWJvZHkgaGFzIGEgc29sdXRpb24gdGhleSBkZWVtIHRv
IGJlIGJldHRlciwgSSBhbSBoYXBweSB0byBjaGFuZ2UNCj4+Pj4+Pj4+IHRoaXMgdGVzdCBjYXNl
LiBPdGhlcndpc2UsIEkgd291bGQgYXBwcmVjaWF0ZSBhIG1haW50YWluZXIgcmVzb2x2aW5nDQo+
Pj4+Pj4+PiB0aGlzIGRpc2N1c3Npb24gYW5kIGFwcGx5IHRoaXMgZml4Lg0KPj4+Pj4+Pj4NCj4+
Pj4+Pj4gQWdyZWVkLg0KPj4+Pj4+Pg0KPj4+Pj4+PiBJIGRvIGhhdmUgYSBjb3VwbGUgb2YgcGF0
Y2hlcyB3aGljaCBhZGQgZXhwbGljaXQgdW5hbGlnbmVkIHRlc3RzIGFzIHdlbGwgYXMNCj4+Pj4+
Pj4gY29ybmVyIGNhc2UgdGVzdHMgKHdoaWNoIGFyZSBpbnRlbmRlZCB0byB0cmlnZ2VyIGFzIG1h
bnkgY2Fycnkgb3ZlcmZsb3dzDQo+Pj4+Pj4+IGFzIHBvc3NpYmxlKS4gT25jZSBJIGdldCB0aG9z
ZSB3b3JraW5nIHJlbGlhYmx5LCBJJ2xsIGJlIGhhcHB5IHRvIHN1Ym1pdA0KPj4+Pj4+PiB0aGVt
IGFzIGFkZGl0aW9uYWwgdGVzdHMuDQo+Pj4+Pj4+DQo+Pj4+Pj4NCj4+Pj4+PiBUaGUgZnVuY3Rp
b25zIGRlZmluaXRlbHkgaGF2ZSB0byB3b3JrIGF0IGxlYXN0IHdpdGggYW5kIHdpdGhvdXQgVkxB
TiwNCj4+Pj4+PiB3aGljaCBtZWFucyB0aGUgYWxpZ25tZW50IGNhbm5vdCBiZSBncmVhdGVyIHRo
YW4gNCBieXRlcy4gVGhhdCdzIGFsc28NCj4+Pj4+PiB0aGUgb3V0Y29tZSBvZiB0aGUgZGlzY3Vz
c2lvbi4NCj4+Pj4+DQo+Pj4+PiBUaGFua3MgZm9yIGNvbXBsZXRlbHkgaWdub3Jpbmcgd2hhdCBJ
J3ZlIHNhaWQuIE5vLiBUaGUgYWxpZ25tZW50IGVuZHMgdXANCj4+Pj4+IGJlaW5nIGNvbW1vbmx5
IDIgYnl0ZXMuDQo+Pj4+Pg0KPj4+Pj4gQXMgSSd2ZSBzYWlkIHNldmVyYWwgdGltZXMsIG5ldHdv
cmsgZHJpdmVycyBkbyBfbm90XyBoYXZlIHRvIHJlc3BlY3QNCj4+Pj4+IE5FVF9JUF9BTElHTi4g
VGhlcmUgYXJlIDMyLWJpdCBBUk0gZHJpdmVycyB3aGljaCBoYXZlIGEgRE1BIGVuZ2luZSBpbg0K
Pj4+Pj4gdGhlbSB3aGljaCBjYW4gb25seSBETUEgdG8gYSAzMi1iaXQgYWxpZ25lZCBhZGRyZXNz
LiBUaGlzIG1lYW5zIHRoYXQNCj4+Pj4+IHRoZSBzdGFydCBvZiB0aGUgZXRoZXJuZXQgaGVhZGVy
IGlzIHBsYWNlZCBhdCBhIDMyLWJpdCBhbGlnbmVkIGFkZHJlc3MNCj4+Pj4+IG1ha2luZyB0aGUg
SVAgaGVhZGVyIG1pc2FsaWduZWQgdG8gMzItYml0Lg0KPj4+Pj4NCj4+Pj4+IEkgZG9uJ3Qgc2Vl
IHdoYXQgaXMgc28gZGlmZmljdWx0IHRvIHVuZGVyc3RhbmQgYWJvdXQgdGhpcy4uLiBidXQgaXQN
Cj4+Pj4+IHNlZW1zIHRoYXQgbXkgY29tbWVudHMgb24gdGhpcyBhcmUgYmVpbmcgaWdub3JlZCB0
aW1lIGFuZCB0aW1lIGFnYWluLA0KPj4+Pj4gYW5kIEkgY2FuIG9ubHkgdGhpbmsgdGhhdCB0aG9z
ZSB3aG8gYXJlIGlnbm9yaW5nIG15IGNvbW1lbnRzIGhhdmUNCj4+Pj4+IHNvbWUgYWx0ZXJpb3Ig
bW90aXZlIGhlcmUuDQo+Pj4+Pg0KPj4+Pg0KPj4+PiBJJ20gc29ycnkgZm9yIHRoaXMgbWlzdW5k
ZXJzdGFuZGluZy4gSSdtIG5vdCBpZ25vcmluZyB3aGF0IHlvdSBzYWlkIGF0DQo+Pj4+IGFsbC4g
SSB1bmRlcnN0b29kIHRoYXQgQVJNIGlzIGFibGUgdG8gaGFuZGxlIHVuYWxpZ25lZCBhY2Nlc3Nl
cyB3aXRoDQo+Pj4+IHNvbWUgZXhjZXB0aW9uIGhhbmRsZXJzIGF0IHdvcnN0IGNhc2UgYW5kIHRo
YXQgRE1BIGNvbnN0cmFpbnRzIG1heSBsZWFkDQo+Pj4+IHRvIHRoZSBJUCBoZWFkZXIgYmVlaW5n
IG9uIGEgMiBieXRlcyBhbGlnbm1lbnQgb25seS4NCj4+Pj4NCj4+Pj4gSG93ZXZlciBJIGFsc28g
dW5kZXJzdG9vZCBmcm9tIG90aGVycyB0aGF0IHNvbWUgYXJjaGl0ZWN0dXJlcyBjYW4ndA0KPj4+
PiBoYW5kbGUgc3VjaCBhIDIgYnl0ZXMgb25seSBhbGlnbm1lbnRzLg0KPj4+Pg0KPj4+PiBJdCdz
IGJlZW4gc3VnZ2VzdGVkIGR1cmluZyB0aGUgZGlzY3Vzc2lvbiB0aGF0IGFsaWdubWVudCB0ZXN0
cyBzaG91bGQgYmUNCj4+Pj4gYWRkZWQgbGF0ZXIgaW4gYSBmb2xsb3ctdXAgcGF0Y2guIFNvIGZv
ciB0aGUgdGltZSBiZWluZyBJJ20gdHJ5aW5nIHRvDQo+Pj4+IGZpbmQgYSBjb21wcm9taXNlIGFu
ZCBnZXQgdGhlIGV4aXN0aW5nIHRlc3RzIHdvcmtpbmcgb24gYWxsIHBsYXRmb3Jtcw0KPj4+PiBi
dXQgd2l0aCBhIHNtYWxsZXIgYWxpZ25tZW50IHRoYW4gdGhlIDE2LWJ5dGVzIGFsaWdubWVudCBi
cm91Z2h0IGJ5DQo+Pj4+IENoYXJsaWUncyB2MTAgcGF0Y2guIEFuZCBhIDQgYnl0ZXMgYWxpZ25t
ZW50IHNlZW1lZCB0byBtZSB0byBiZSBhIGdvb2QNCj4+Pj4gY29tcHJvbWlzZSBmb3IgdGhpcyBm
aXguIFRoZSBpZGVhIGlzIGFsc28gdG8gbWFrZSB0aGUgZml4IGFzIG1pbmltYWwgYXMNCj4+Pj4g
cG9zc2libGUsIHVubGlrZSBDaGFybGllJ3MgcGF0Y2ggdGhhdCBpcyBjaHVybmluZyB1cCB0aGUg
dGVzdHMgcXVpdGUNCj4+Pj4gaGVhdmlseS4NCj4+Pg0KPj4+IERvIHlvdSBoYXZlIGEgbGlzdCBv
ZiBwbGF0Zm9ybXMgdGhpcyBpcyBmYWlsaW5nIG9uPyBJIGhhdmVuJ3Qgc2VlbiBhbnkNCj4+PiBy
ZXBvcnRzIHRoYXQgaGF2ZW4ndCBiZWVuIGZpeGVkLg0KPj4NCj4+IEkgZG9uJ3QgaGF2ZSBzdWNo
IGEgbGlzdCwgYnV0IEkgZ3Vlc3MgeW91IGRvID8gSWYgYWxsIHBsYXRmb3JtcyBoYXZlDQo+PiBh
bHJlYWR5IGJlZW4gZml4ZWQsIHdoeSBhcmUgeW91IHNlbmRpbmcgdGhpcyBwYXRjaCBhdCBhbGwg
Pw0KPiANCj4gVGhpcyBwYXRjaCBpcyB3aGF0IGlzIGRvaW5nIHRoZSAiZml4aW5nIi4gT3ZlciB0
aGUgY291cnNlIG9mIDEwIHZlcnNpb25zDQo+IEkgaGF2ZSAiZml4ZWQiIHRoZSB0ZXN0IGNhc2Vz
IHRvIHdvcmsgb24gcGxhdGZvcm1zIHRoYXQgaGF2ZSB2YXJpb3VzDQo+IGFsaWdubWVudCBhbmQg
ZW5kaWFubmVzcyBjb25zdHJhaW50cy4gVGhlIGVuZGlhbm5lc3MgY2hhbmdlcyB3ZXJlIHBpY2tl
ZA0KPiBvZmYgb2YgdGhlc2UgcGF0Y2hlcyBhbmQgc3B1biBvdXQgaW50byBhIGRpZmZlcmVudCBw
YXRjaCBieSB5b3UuDQo+IA0KPiBJIG9yaWdpbmFsbHkgaW50cm9kdWNlZCB0aGVzZSB0d28gbmV3
IHRlc3QgY2FzZXMgc2luY2UgSSB3cm90ZSB0aGUgcmlzY3YNCj4gY2hlY2tzdW0gZnVuY3Rpb24g
aW1wbGVtZW50YXRpb25zIGFuZCB0aGVzZSB0ZXN0cyB3ZXJlIGhlbHBmdWwgZm9yIG1lDQo+IGFu
ZCBJIGZpZ3VyZWQgdGhleSBtYXkgYmUgaGVscGZ1bCBmb3Igc29tZWJvZHkgZWxzZSB0b28uDQoN
Ckkgc2VlLg0KDQpUaGVuIHlvdSBtaXMtdW5kZXJzdG9vZC4gSSBkb24ndCBzYXkgeW91ciBwYXRj
aCBsZWF2ZSBhbnkgcGxhdGZvcm0gDQp1bmZpeGVkLiBJIHNheSB0aGF0IHlvdXIgcGF0Y2ggc2Vl
bXMgYmlnZ2VyIHRoYW4gcmVxdWlyZWQsIGl0IGlzIGEgDQpjaHVybi4gSW4gYWRkaXRpb24geW91
ciBwYXRjaCBhc3N1bWVzIGFuIGFsaWdubWVudCBvZiAxNi1ieXRlcyB3aGljaCwgYXMgDQpleHBs
YWluZWQgYnkgUnVzc2VsbCwgaXQganVzdCB3cm9uZy4gQXQgbGVhc3QgYW4gYWxpZ25tZW50IG9m
IDQgYnl0ZXMgDQptdXN0IHdvcmsgb24gYW55IHBsYXRmb3JtcyBiZWNhdXNlIG9mIFZMQU5zLg0K
DQpDaHJpc3RvcGhlDQo=

