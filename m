Return-Path: <linux-kernel+bounces-100643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 538AE879B2F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 19:17:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08579284DDE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 18:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ACA913956D;
	Tue, 12 Mar 2024 18:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=csgroup.eu header.i=@csgroup.eu header.b="Qq1IEq0h"
Received: from PR0P264CU014.outbound.protection.outlook.com (mail-francecentralazon11022018.outbound.protection.outlook.com [52.101.167.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA1B13957B;
	Tue, 12 Mar 2024 18:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.167.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710267449; cv=fail; b=Wp6+deQeDuPqGE3U5l6s2kb/ASCZm4RvnugkKromtXOxgNfHpqXXJLqarrxGSk2tyl/rjB9MB0Qk2MCCtaMy1OT3OjfeZwXQvJCmnnq8iGZUu3E4HmVmJ16LUZ52YCUSz+UslFev2WtgEoxl/UR/ZnZO5Hg7XUxI6boBy5Z9V4w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710267449; c=relaxed/simple;
	bh=mOG0nImlCQzDjDr0KPT/uNwADLlU2dxiZphYVBE/iT4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kEfd4ws6bLIzoHcT6jcEkFZzKIwFpP72Hx3T+WsZvMTh+6HlZjkZGqBpxyB3C6nW4hwFeGhFU2IVKAXQH77fz7YaU9HuAvGcjJLxjCV3pqUFveRaTgT1Ia3Djhh7r1FkTpxzsu7Q0UBo8wUJVjNYv9ZgKJGcaeBxai+QLzlgZsM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; dkim=pass (2048-bit key) header.d=csgroup.eu header.i=@csgroup.eu header.b=Qq1IEq0h; arc=fail smtp.client-ip=52.101.167.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nn7wgnWxIV2cFhN0i042YpCtN+8ctbQRPM6t8cmgpPwRipAihAx5zdE2Q+xj8hjP9Q36qTLUH84CfOX2R+aERZfyF42G0Mnu2txAup32gXcljWm6RLF6Zg41pq0GOV+WyQqnsR0gymujDzOHGsYPACmjxEJWEgV2sdquN9X602zzMGncAPXqpDdGcYAtZimpO6k2MyBagGtTdTseWrapYkj/VNIZboJxfJ4zIza0pvGCj+lICgwiTcVz90Zm4SUtcoGNIbvxh0BnNWxwuR+40rOWBaCfWqHs6bfwvtDrdrtG9GAHhjk9SRbpzkijUFGScJ62gH825IQjO5z4Qv0XgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mOG0nImlCQzDjDr0KPT/uNwADLlU2dxiZphYVBE/iT4=;
 b=jXwxuBdHAz6iaOYBFA25uclRcfOWawbHExYANsCxXdtUF/fZzDBNlZQ7hopJKyr0SBfDWlWVOJIK7MNq11SPX3dKjl41GTEJR2uQAZ9EyVp457ExSF8TvZ+iVw4KiZbhRoPQG4Ad4aUOwC3AWrkxG8mP3yagPUYc9wEmlZKW8fNOMOaZC+0HLgr2A5JoFdLMVdcHVwel5QmblddqCnHu+5WEpkxiHfSzXN5IPoSwBlVWmHJCoH5qMkVzz2hMreoElf7eoMYw8Ni3AC7zBaMQGXgL2sDogz6QKrrXglC5W/l8Qljp6icPx7UlGINcicEtZY0Z+geWklH2ybvIeWMwRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mOG0nImlCQzDjDr0KPT/uNwADLlU2dxiZphYVBE/iT4=;
 b=Qq1IEq0h5FaIuU3PjPhRsbp0/ETVD1ErOfM/QfTwCRPbML16WH7mmPeHvqmBel9NSVo/sTXvS8msSfcvtMbts/G2cP9nMZx0xNhCtuOFF5AK+qWmh0dBJ+lFkz1EsIk6pkag/pjBPB6wi5tFb5Tu9w6REMpqwTxL9aETe/T4KEzfRnmWwxfUnCo4ylMBe7xcTgd2W8qUWSjPQ7z117l6J9JjH8zvu4g5iAiicC4NRTmT60+Aosxr4oD44yaJGjAxJ4tOs/fpOTSWwKAr7hyJVroD4dNYVSY9L/oW2QVnsqXee8oOVLBEzJe2vny/pB7vuVpeby+GAhL0iYAQRvsclg==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by MRZP264MB1928.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:16::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Tue, 12 Mar
 2024 18:17:24 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::c192:d40f:1c33:1f4e]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::c192:d40f:1c33:1f4e%6]) with mapi id 15.20.7362.035; Tue, 12 Mar 2024
 18:17:24 +0000
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: George Stark <gnstark@salutedevices.com>, =?utf-8?B?TWFyZWsgQmVow7pu?=
	<marek.behun@nic.cz>, Waiman Long <longman@redhat.com>
CC: "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>, "pavel@ucw.cz"
	<pavel@ucw.cz>, "lee@kernel.org" <lee@kernel.org>, "vadimp@nvidia.com"
	<vadimp@nvidia.com>, "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
	"npiggin@gmail.com" <npiggin@gmail.com>, "hdegoede@redhat.com"
	<hdegoede@redhat.com>, "mazziesaccount@gmail.com" <mazziesaccount@gmail.com>,
	"peterz@infradead.org" <peterz@infradead.org>, "mingo@redhat.com"
	<mingo@redhat.com>, "will@kernel.org" <will@kernel.org>,
	"boqun.feng@gmail.com" <boqun.feng@gmail.com>, "nikitos.tr@gmail.com"
	<nikitos.tr@gmail.com>, "kabel@kernel.org" <kabel@kernel.org>,
	"linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"kernel@salutedevices.com" <kernel@salutedevices.com>
Subject: Re: [PATCH v5 02/10] locking/mutex: introduce devm_mutex_init
Thread-Topic: [PATCH v5 02/10] locking/mutex: introduce devm_mutex_init
Thread-Index:
 AQHacDjgK3b+WpnPIEGh5lKDyA2GCLEsCyQAgAA+QACAADOKAIAGv34AgABpg4CAAF1ugIAAA30AgAA9MACAAC6SgA==
Date: Tue, 12 Mar 2024 18:17:24 +0000
Message-ID: <7e174d78-faa9-4d29-967f-c1b3dedb3ef8@csgroup.eu>
References: <20240307024034.1548605-1-gnstark@salutedevices.com>
 <20240307024034.1548605-3-gnstark@salutedevices.com>
 <20240307095639.b6utkbzr36liuu3p@kandell>
 <3d95ab40-2df5-4988-87be-568a628a0561@redhat.com>
 <20240307174414.4059d7ee@dellmb>
 <cfceef12-883e-4593-9dca-50768acb1aa9@salutedevices.com>
 <c3be9cb4-06cf-45c5-841f-3fa016e4d087@csgroup.eu>
 <9e13fd46-b05b-4fc2-abb6-c6c96dd576ee@salutedevices.com>
 <2106ea35-2d96-43f9-92a1-7d33ad5240b4@csgroup.eu>
 <1f3395cb-ebab-44cd-b2b1-716e0130abad@salutedevices.com>
In-Reply-To: <1f3395cb-ebab-44cd-b2b1-716e0130abad@salutedevices.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|MRZP264MB1928:EE_
x-ms-office365-filtering-correlation-id: a7e74b66-f0b4-43d9-f9a5-08dc42c0aa84
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 JhtcExy8buQ854ZLjRDlC1QUz1upQPzMGx8gKsVCuXm+i5vzW7OCVh7ZusUWmHmzKYZnjNxNyHDjBYsqVARPlgkJY3juI1hG26kA0I0Hxh9nqdoOoSm5ry2uj2iuOnCcnIc8aUyOtPEOoFxzf2fnhsFAEAL9FQ1NVyocNnqdaplW38H97ZuN+hsO83m5LQyfy5xGUbZBrf1v0sVHPT0Iy9swTfO+0+WMWVAxP38vsmMHb4+TGd/mlklxLsMpemzCMX+71VObJ6pPg5uv7YmHNXyAwiiQi+wFUzdJalNpwMQQlM0s32P6+LiHHF5RsKHLsTZikVidg8S3hHpdQwFDUW59H9NrzjpbDhJlTwe5oacFhF/Qw3DQ/eBz+KI8YwVkTC9Wbr45A2k25Ik8zOuI2SWLgirmnI+USnx2+NGdamm2KHkMiE2X5VUZr+qGEVEdOOnTdIIG0geLhw4VXm7xlSwGowyKohqEfCqVzFGZz2NuqlbK5K1V/HFVX24Tozbe4v+EyFhbD45C8ucsVEuP7mDa9m8ln8RZ9L8q8kGRP74kHEFxMuCE9TjdbNwdrMuVdC2H2APosR+bM9jrlM3UIlnq+qjxkZwEkMXNnj7NzNTLqlE7HOpMY49QoDnG6f78Vo46cmyxf/6Yw01modtrxH6HhJDnJsjhx3HNGr+mHAOKW4DLuy21HPD/BRulYBeJgIdcyc2oj/gXWOxu9eN+Tg==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SmRrZE9qMy9VMThiSlNLS08xSXdBOXpEYmVOOTBaVVZWVGNaYndlTDRmVkx2?=
 =?utf-8?B?ak4rTmozUVhJak5QUGdVcU4wYTVYaDNVbk96cEJITmFsdUNWVmJCcldDZ2ti?=
 =?utf-8?B?YlVUOFJQL0EvMWRab3pGSGluVUFhRUpGYlRiQ0ZzSlRrSHFrWXZwQ1lIN2lw?=
 =?utf-8?B?YUdGTEJ6K2ZYWmZPOGFoU1BjVHlCTFkyM0oxeUVwM1VuYjJPb2NuVzA5YU5C?=
 =?utf-8?B?S3pkQXozSElHZ0FxVzBuYVE4NjlaZ21zWVVveW5xeGVPcjJaNFVzRlByNGgw?=
 =?utf-8?B?Q3JwMFB3YWNjTlhRZXNnZm00TytBa2dhemhpaUhMclV0d0RISkhORG9Bcndm?=
 =?utf-8?B?eFhFcCt4dlo5Yk56SG1nTnRUN0dycFo2Y1F5ZFNHSFNndm53Skk2TVhFM1pq?=
 =?utf-8?B?VDQ0MDBnTVZxNTVFdDhTd2J1eElPU3F6cy9TOUtJSjVGWnJjaERvaGxkc0hX?=
 =?utf-8?B?V1lSaXlPQ3BYZkFyaEFLNnVKNGJncDgyL3djTU94K0w3b3ZxOWhoZTBjYk10?=
 =?utf-8?B?aDVNSkZaN2JnVExLVVovSFVNUWxKNWtpM2FENVUrbm5ySFZLQnh0c3BHU0ZC?=
 =?utf-8?B?NVFhaVlCc2tKVlQwbTYxcGlKalJxWjh4Vzd2R0swbFpLQWdIUytpWmltckJZ?=
 =?utf-8?B?RWZRU2xEYU1xbkVHeXRvNjh1ems1RGh1eVNJTTVUZ1pBR0Y1aEpXREE4Z3ha?=
 =?utf-8?B?c0YzUkNvemRJMnF3UXRJZEVkZmFVNTJOTWVJUFVmZkwybS96ZUVacXBvbm9L?=
 =?utf-8?B?V2hKYS9lVHBmTjNpY0FvQnRLWHRNMThCWFp6UXI2MURBS2tTRVRhT2YyUTQ3?=
 =?utf-8?B?UzNNUUZNdGZTcWdLbVVSUFhDcER6aXUyMmNiWGxJZDhJM0FGbnh6Mk9qZWJW?=
 =?utf-8?B?bmMyWkhQc0orZzRhcVhDUnF2N2JGUVhCems5RnhySTZnbWd0clRxcVhCTWZG?=
 =?utf-8?B?NEVBaktsc1FycnRvNXBlY0owTWtoYkh6RmF2TmFqd2txTUhKM011VVpQaFh1?=
 =?utf-8?B?RkpOSFlMM1hSVGMxNFRNWEZjMmdPanVtQWVjQVlkQXZjSjQyTzhlUnFONWp2?=
 =?utf-8?B?Nk1aNm9pK1JiV0szck1WenVpYlRhSFhZQ0psbVJDUGdkNFB3c01DOVdQOTdB?=
 =?utf-8?B?YVYzWC9FNXpDNnd4c01hVUpEK0hJOTN3Q3A1Zys3WjI5UW5iR2Njem8zZTRI?=
 =?utf-8?B?S09WVHBvQUxsUDM1SzY1ZVR4cTBmM0tpUzZRWU1QQnpJd1ZaWmw2Uy9UQm5V?=
 =?utf-8?B?THVNcThIbzBrTkdmZ1l0Y1FqR0FMZkdKL2o2NHBDa0pJdVc3dGxzdkJtSHhK?=
 =?utf-8?B?dWRxRktBOFdRbzM0T3VHYy9oeFVmZ3FwS252cjREOUdGZklHTDJTSnhrMTVN?=
 =?utf-8?B?aEJ6RmRZVXpCdzJ3bk92bXJkdEJiVHRVTkFnRVlkNkFVRXdacDRIM2Y0S2ZK?=
 =?utf-8?B?R1F6YVJzeDIwTnhUdmNyWkV3eGVJZnAxd1ZNS3FpL0dDNG1PZkRJQ2Y3NEtI?=
 =?utf-8?B?RFZ2VVpYYVFiTU1FUmo0bXZoeEUzWi9hcnRkYis1WnBoY0N6aDU3c05xUHVx?=
 =?utf-8?B?Ty9uWk5uaXNGSG1WUGhrL2VkQ3RGUnJteGJCYmM3ZGlyUjdjVXc5WVVPaDNp?=
 =?utf-8?B?eXJncHVZS2QrOW9ZaGZUNzcyUU5uMERrNXFqd1ZLREoxMytnUzBKanJLb3pa?=
 =?utf-8?B?b3MvSHp5NDB2VTBsQmlZN04rVkFlWWxwcDNxSTJ2RGZQL0hWUkhhYTcxQjV5?=
 =?utf-8?B?SVkxc2VHNVJXZDR3cExQMnpNeFlWR3p5N3V1OHV0Y0V0T3FiVzIyUytmVVUx?=
 =?utf-8?B?b3pyQ21kSERCNXg4YmIxdHpXR1RDdkxNcUJOWXdBQ3NnOGNuZE1SWTNjbWIx?=
 =?utf-8?B?YXpGSDRWQ3NpY2hPRTBpc0ZWRTFkOUI2RDJXRFlPekIzNW5McTE4ZnpnY0J5?=
 =?utf-8?B?TVlPREdIT1RObXNLbVpncTNGNzRSbHg3cHNTckFmK0h1a3h5bUZsblVXTFFh?=
 =?utf-8?B?K3hUQkFBbkIwaXBtdDlySXoxSnNoUDU5ZHlPZ3JYbnJnUWRrV2twOTFNY2pY?=
 =?utf-8?B?aU5aenhjYVB6MUhRRzczdEtEVDR4ZHZJUFkzRk9KMW9NTFc5WUJEbGJYSWZ6?=
 =?utf-8?B?aHJCQUhUdE51QlZES3FkNE1iWXBzRjV2UUVsMlBONG9BN2taU1BlNTRNTjkz?=
 =?utf-8?B?OWdWOFk2M3lxN3pFQkt5YmZlelJPWWJBdnlPb0tZeUpSNS9OcFhBL1ZwUWl6?=
 =?utf-8?B?aldrTk8wQ3MzajA2aGhlLzYrN1J3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0DE6074984D4FD47B56C79CE5361AB45@FRAP264.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a7e74b66-f0b4-43d9-f9a5-08dc42c0aa84
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2024 18:17:24.1482
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R21WIUZeGYTPnBcsclszEgZbgtBtve1P+c63LZJCx/cIT3nkz2oQQdeCPya48RJaI4smyHJ5MnYuJnUnHXnw6UnaYGU+ZJZskoJbyaoYVPM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRZP264MB1928

DQoNCkxlIDEyLzAzLzIwMjQgw6AgMTY6MzAsIEdlb3JnZSBTdGFyayBhIMOpY3JpdMKgOg0KPiBb
Vm91cyBuZSByZWNldmV6IHBhcyBzb3V2ZW50IGRlIGNvdXJyaWVycyBkZSBnbnN0YXJrQHNhbHV0
ZWRldmljZXMuY29tLiANCj4gRMOpY291dnJleiBwb3VycXVvaSBjZWNpIGVzdCBpbXBvcnRhbnQg
w6AgDQo+IGh0dHBzOi8vYWthLm1zL0xlYXJuQWJvdXRTZW5kZXJJZGVudGlmaWNhdGlvbiBdDQo+
IA0KPiBIZWxsbyBDaHJpc3RvcGhlDQo+IA0KPiBPbiAzLzEyLzI0IDE0OjUxLCBDaHJpc3RvcGhl
IExlcm95IHdyb3RlOg0KPj4NCj4+DQo+PiBMZSAxMi8wMy8yMDI0IMOgIDEyOjM5LCBHZW9yZ2Ug
U3RhcmsgYSDDqWNyaXQgOg0KPj4+IFtWb3VzIG5lIHJlY2V2ZXogcGFzIHNvdXZlbnQgZGUgY291
cnJpZXJzIGRlIGduc3RhcmtAc2FsdXRlZGV2aWNlcy5jb20uDQo+Pj4gRMOpY291dnJleiBwb3Vy
cXVvaSBjZWNpIGVzdCBpbXBvcnRhbnQgw6ANCj4+PiBodHRwczovL2FrYS5tcy9MZWFybkFib3V0
U2VuZGVySWRlbnRpZmljYXRpb24gXQ0KPiANCj4gLi4uDQo+IA0KPj4gWW91IGRvbid0IG5lZWQg
dGhhdCBpbmxpbmUgZnVuY3Rpb24sIGp1c3QgY2hhbmdlIGRlYnVnX2Rldm1fbXV0ZXhfaW5pdCgp
DQo+PiB0byBfX2Rldm1fbXV0ZXhfaW5pdCgpLg0KPiANCj4gSSBzdHVjayB0byBkZWJ1Z18qIG5h
bWUgYmVjYXVzZSBtdXRleC1kZWJ1Zy5jIGFscmVhZHkgZXhwb3J0cyBhIHNldA0KPiBvZiBkZWJ1
Z18gY2FsbHMgc28uLi4NCg0KQWggeWVzIHlvdSBhcmUgcmlnaHQgSSBkaWRuJ3Qgc2VlIHRoYXQu
IE9uIHRoZSBvdGhlciBoYW5kIGFsbCB0aG9zZSANCmRlYnVnX211dGV4XyogYXJlIHVzZWQgYnkg
a2VybmVsL2xvY2tpbmcvbXV0ZXguYy4NCkhlcmUgd2UgcmVhbGx5IGRvbid0IHdhbnQgb3VyIG5l
dyBmdW5jdGlvbiB0byBiZSBjYWxsZWQgYnkgYW55dGhpbmcgZWxzZSANCnRoYW4gZGV2bV9tdXRl
eF9pbml0IHNvIGJ5IGNhbGxpbmcgaXQgX19kZXZtX211dGV4X2luaXQoKSB5b3Uga2luZCBvZiAN
CnRpZSB0aGVtIHRvZ2V0aGVyLg0KDQo+IFdlbGwgaXQncyBub3QgZXNzZW50aWFsIGFueXdheS4g
SGVyZSdzIHRoZSBuZXh0IHRyeToNCg0KTG9va3MgZ29vZCB0byBtZS4NCg0KPiANCj4gZGlmZiAt
LWdpdCBhL2luY2x1ZGUvbGludXgvbXV0ZXguaCBiL2luY2x1ZGUvbGludXgvbXV0ZXguaA0KPiBp
bmRleCA2N2VkYzRjYTJiZWUuLjUzN2I1ZWExOGNlYiAxMDA2NDQNCj4gLS0tIGEvaW5jbHVkZS9s
aW51eC9tdXRleC5oDQo+ICsrKyBiL2luY2x1ZGUvbGludXgvbXV0ZXguaA0KPiBAQCAtMjIsNiAr
MjIsOCBAQA0KPiAgwqAjaW5jbHVkZSA8bGludXgvY2xlYW51cC5oPg0KPiAgwqAjaW5jbHVkZSA8
bGludXgvbXV0ZXhfdHlwZXMuaD4NCj4gDQo+ICtzdHJ1Y3QgZGV2aWNlOw0KPiArDQo+ICDCoCNp
ZmRlZiBDT05GSUdfREVCVUdfTE9DS19BTExPQw0KPiAgwqAjIGRlZmluZSBfX0RFUF9NQVBfTVVU
RVhfSU5JVElBTElaRVIobG9ja25hbWUpwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBcDQo+ICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICwgLmRlcF9t
YXAgPSB7wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIFwNCj4gQEAgLTExNyw2ICsxMTksMjkgQEAgZG8gDQo+IHvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgXA0KPiAgwqB9IHdo
aWxlICgwKQ0KPiAgwqAjZW5kaWYgLyogQ09ORklHX1BSRUVNUFRfUlQgKi8NCj4gDQo+ICsjaWZk
ZWYgQ09ORklHX0RFQlVHX01VVEVYRVMNCj4gKw0KPiAraW50IF9fZGV2bV9tdXRleF9pbml0KHN0
cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0IG11dGV4ICpsb2NrKTsNCj4gKw0KPiArI2Vsc2UNCj4g
Kw0KPiArc3RhdGljIGlubGluZSBpbnQgX19kZXZtX211dGV4X2luaXQoc3RydWN0IGRldmljZSAq
ZGV2LCBzdHJ1Y3QgbXV0ZXggDQo+ICpsb2NrKQ0KPiArew0KPiArwqDCoMKgwqDCoMKgIC8qDQo+
ICvCoMKgwqDCoMKgwqDCoCAqIFdoZW4gQ09ORklHX0RFQlVHX01VVEVYRVMgaXMgb2ZmIG11dGV4
X2Rlc3Ryb3kgaXMganVzdCBhIG5vcCBzbw0KPiArwqDCoMKgwqDCoMKgwqAgKiBubyByZWFsbHkg
bmVlZCB0byByZWdpc3RlciBpdCBpbiBkZXZtIHN1YnN5c3RlbS4NCj4gK8KgwqDCoMKgwqDCoMKg
ICovDQo+ICvCoMKgwqDCoMKgwqAgcmV0dXJuIDA7DQo+ICt9DQo+ICsNCj4gKyNlbmRpZg0KPiAr
DQo+ICsjZGVmaW5lIGRldm1fbXV0ZXhfaW5pdChkZXYsIG11dGV4KcKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIFwNCj4gKyh7wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgXA0KPiArwqDCoMKgwqDCoMKgIG11dGV4X2luaXQobXV0ZXgp
O8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgXA0KPiArwqDCoMKgwqDCoMKgIF9fZGV2bV9tdXRleF9pbml0KGRldiwgbXV0ZXgpO8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgXA0KPiArfSkNCj4gKw0KPiAgwqAvKg0KPiAg
wqAgKiBTZWUga2VybmVsL2xvY2tpbmcvbXV0ZXguYyBmb3IgZGV0YWlsZWQgZG9jdW1lbnRhdGlv
biBvZiB0aGVzZSBBUElzLg0KPiAgwqAgKiBBbHNvIHNlZSBEb2N1bWVudGF0aW9uL2xvY2tpbmcv
bXV0ZXgtZGVzaWduLnJzdC4NCj4gZGlmZiAtLWdpdCBhL2tlcm5lbC9sb2NraW5nL211dGV4LWRl
YnVnLmMgYi9rZXJuZWwvbG9ja2luZy9tdXRleC1kZWJ1Zy5jDQo+IGluZGV4IGJjOGFiYjg1NDlk
Mi4uNmFhNzdlM2RjODJlIDEwMDY0NA0KPiAtLS0gYS9rZXJuZWwvbG9ja2luZy9tdXRleC1kZWJ1
Zy5jDQo+ICsrKyBiL2tlcm5lbC9sb2NraW5nL211dGV4LWRlYnVnLmMNCj4gQEAgLTE5LDYgKzE5
LDcgQEANCj4gIMKgI2luY2x1ZGUgPGxpbnV4L2thbGxzeW1zLmg+DQo+ICDCoCNpbmNsdWRlIDxs
aW51eC9pbnRlcnJ1cHQuaD4NCj4gIMKgI2luY2x1ZGUgPGxpbnV4L2RlYnVnX2xvY2tzLmg+DQo+
ICsjaW5jbHVkZSA8bGludXgvZGV2aWNlLmg+DQo+IA0KPiAgwqAjaW5jbHVkZSAibXV0ZXguaCIN
Cj4gDQo+IEBAIC04OSw2ICs5MCwxNiBAQCB2b2lkIGRlYnVnX211dGV4X2luaXQoc3RydWN0IG11
dGV4ICpsb2NrLCBjb25zdCBjaGFyDQo+ICpuYW1lLA0KPiAgwqDCoMKgwqDCoMKgIGxvY2stPm1h
Z2ljID0gbG9jazsNCj4gIMKgfQ0KPiANCj4gK3N0YXRpYyB2b2lkIGRldm1fbXV0ZXhfcmVsZWFz
ZSh2b2lkICpyZXMpDQo+ICt7DQo+ICvCoMKgwqDCoMKgwqAgbXV0ZXhfZGVzdHJveShyZXMpOw0K
PiArfQ0KPiArDQo+ICtpbnQgX19kZXZtX211dGV4X2luaXQoc3RydWN0IGRldmljZSAqZGV2LCBz
dHJ1Y3QgbXV0ZXggKmxvY2spDQo+ICt7DQo+ICvCoMKgwqDCoMKgwqAgcmV0dXJuIGRldm1fYWRk
X2FjdGlvbl9vcl9yZXNldChkZXYsIGRldm1fbXV0ZXhfcmVsZWFzZSwgbG9jayk7DQo+ICt9DQo+
ICsNCj4gIMKgLyoqKg0KPiAgwqAgKiBtdXRleF9kZXN0cm95IC0gbWFyayBhIG11dGV4IHVudXNh
YmxlDQo+ICDCoCAqIEBsb2NrOiB0aGUgbXV0ZXggdG8gYmUgZGVzdHJveWVkDQo+IC0tIA0KPiAy
LjI1LjENCj4gDQo+IA0KPiANCj4+PiArDQo+Pj4gKyNlbHNlDQo+Pj4gKw0KPj4+ICtzdGF0aWMg
aW5saW5lIGludCBfX2Rldm1fbXV0ZXhfaW5pdChzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVjdCBt
dXRleA0KPj4+ICpsb2NrKQ0KPj4+ICt7DQo+Pj4gK8KgwqDCoMKgwqDCoCAvKg0KPj4+ICvCoMKg
wqDCoMKgwqAgKiBXaGVuIENPTkZJR19ERUJVR19NVVRFWEVTIGlzIG9mZiBtdXRleF9kZXN0cm95
IGlzIGp1c3QgYSANCj4+PiBub3Agc28NCj4+PiArwqDCoMKgwqDCoMKgICogbm8gcmVhbGx5IG5l
ZWQgdG8gcmVnaXN0ZXIgaXQgaW4gZGV2bSBzdWJzeXN0ZW0uDQo+Pj4gK8KgwqDCoMKgwqDCoCAq
Lw0KPj4NCj4+IERvbid0IGtub3cgaWYgaXQgaXMgYmVjYXVzZSB0YWJzIGFyZSByZXBsYWNlZCBi
eSBibGFua3MgaW4geW91IGVtYWlsLA0KPj4gYnV0IHRoZSBzdGFycyBzaG91bGQgYmUgYWxpZ25l
ZA0KPiANCj4gQWNrDQo+IA0KPiANCj4gLS0gDQo+IEJlc3QgcmVnYXJkcw0KPiBHZW9yZ2UNCg==

