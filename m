Return-Path: <linux-kernel+bounces-37252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6CA183AD4E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 16:28:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DCD02889DE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 15:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A9077A730;
	Wed, 24 Jan 2024 15:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=csgroup.eu header.i=@csgroup.eu header.b="A3WQu90H"
Received: from FRA01-MR2-obe.outbound.protection.outlook.com (mail-mr2fra01on2058.outbound.protection.outlook.com [40.107.9.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A357A708;
	Wed, 24 Jan 2024 15:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.9.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706110119; cv=fail; b=e9sLhuXFWzCFDu4yEZV2V+CtWiTwzbYVX45hQxHZ/sUpANKh+NTo9ASoFkJvjgHaRhUJabAMka2xBVX8oeYdqXIw09OJj85mpUvdkSIpq4mAN3jOZtY3yVKBuiXddadpRZak4edj1sIyDQHjong7EIKNc6Ei6AfsPrdgY2G3LJ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706110119; c=relaxed/simple;
	bh=DQo+b2a4CtQEribEC5JBveKyHCBMcRTUbt4zk635rBU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VnlPetr/uctkJgEhr7uAE9GpyQHto0Qb+scx/n93uXEym4DhRrvPSSKdXlTZVGSCh+aEnAlNUv+tJpEsMuRQQaqK0k3QmSA+wirescXYwuPY0Dmc693/1VjKgdFUTPrpIZnxWY8Dufk6Mv9XQ/NweC5nie4QYFn/tAABWsgcKyU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; dkim=pass (2048-bit key) header.d=csgroup.eu header.i=@csgroup.eu header.b=A3WQu90H; arc=fail smtp.client-ip=40.107.9.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fpo3Ezkqkou+BGS8AI82/J6kqJZD17TOfD268vqFCjP9xRMyqLChn9F/vO9Dm+4C51XVJ2s15iDctNRvLeawqaicVuUsQlv7VpRe+5fOJjmoRpKop/xAqjGvb12VbvdKfQ5lyPJYuLMPDqr2NYC1jj6qnkgnvu4QynMnjEvDoooxyTCCFdMUayQ5xefg4YRYGMZ0ji7YsoX7xyV8fKALL10i9hzlFfV2DOGJkiGladEBe/4useqEhnHoFQuEpBo2TdidX2lnDOeCVmV/LjtrPKjMEaWgUq3zWwgvOlvxGASJyQTbqpRDFEPwZZnw3p2VPlcxBrL5EmJ/ZmynAAtdpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DQo+b2a4CtQEribEC5JBveKyHCBMcRTUbt4zk635rBU=;
 b=X+s0UJdSsv7bRLjNLwxLMcBE+trINwrOrAALb7siibPg2ToMn0sT1LyUdKRRQcFURnR2cUzv+d2rhhrui4wkQ9zdeUmnk2Is0uSBOmZAzBSWPpU8IXjmti7bqh0EkzNWGBZvtokJOkOUh7CIXaVP92zHhZSHdR4psqGskzutudu8zq1f+ZV2ZdXFhoI0k167BzpbmhXFRLH7ghAr0LppH/nFMTIZ8MeUdCsmB8G+hAG3KOwpv+FMaiimD69fUKH3RrUGF++Ogdj1B/gORpYFyWMbVs30fcRLwr712H8hXQfwMjMWpSNDPnENW5i3Pz2dUUet9aAjCBV0RCkwmpFAhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DQo+b2a4CtQEribEC5JBveKyHCBMcRTUbt4zk635rBU=;
 b=A3WQu90H9aXAVj546s0mdudX1XuqpldsZCJzbUMa0BUUnd6RK24osN5zHrG6vdIMbD7oh+Y+fUb6y0NHRUDqi6ZN+VtAX2Tx+HRnKO6/DyWMW/jFXyUlrPvsN3BcdHXH9pf8GoG2Ki5VZm0FTNQFVJPXTDRIFpi+/BhCO7Ou6BhXc/XfBmh9DVfd3NgUr0xq11Kat64Dt5EGrD4KrzSy8eGcL74dZH7IMim36/GvkpR7TzfDqSHFIgmUT4C35MWGW3cNsKrVSomIZiPGAO6oMAny2eq/GouJi81B+ohU++I1/BhNrEelAf0NY9ie/lNVFwCi/Td/36/61gM5nvdLng==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by MR1P264MB2483.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:34::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Wed, 24 Jan
 2024 15:28:32 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::9f77:c0ff:cd22:ae96]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::9f77:c0ff:cd22:ae96%4]) with mapi id 15.20.7228.022; Wed, 24 Jan 2024
 15:28:32 +0000
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Mark Brown <broonie@kernel.org>, Jonas Gorski <jonas.gorski@gmail.com>
CC: Guenter Roeck <linux@roeck-us.net>, Herve Codina
	<herve.codina@bootlin.com>, Amit Kumar Mahapatra
	<amit.kumar-mahapatra@amd.com>, "linux-spi@vger.kernel.org"
	<linux-spi@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Thomas Petazzoni
	<thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH] spi: Raise limit on number of chip selects
Thread-Topic: [PATCH] spi: Raise limit on number of chip selects
Thread-Index:
 AQHaTevyXnY9D2HHOkixM7NCrJ+XOrDnYXyAgAACFwCAAAfAAIAAMVcAgAAP54CAAU2JgIAAFekAgAAIHYA=
Date: Wed, 24 Jan 2024 15:28:32 +0000
Message-ID: <bc19929e-8231-4bb6-bb36-555a68cb7335@csgroup.eu>
References: <20240122-spi-multi-cs-max-v1-1-a7e98cd5f6c7@kernel.org>
 <20240123120430.75c7ace0@bootlin.com>
 <cefafa30-b78d-471b-83e0-b05060d806d4@sirena.org.uk>
 <93385fc2-7596-4f66-b0c1-07d7d5c9ed8d@csgroup.eu>
 <49b52941-6205-48bd-b2ae-e334018ac5cd@sirena.org.uk>
 <CAOiHx==FzSyyqP3NzLTeOSVxUQYy3ZhypZrDLsc-OjGCdSzvUA@mail.gmail.com>
 <801eecbe-4bf9-4bb8-9de0-1a7ca6673ddf@roeck-us.net>
 <CAOiHx=mM7kpzR-MOshsgXZM+CSB0nawfWxMhpt=tuhmJyMTCzQ@mail.gmail.com>
 <38630519-733c-4598-97a7-19a5e6306513@sirena.org.uk>
In-Reply-To: <38630519-733c-4598-97a7-19a5e6306513@sirena.org.uk>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|MR1P264MB2483:EE_
x-ms-office365-filtering-correlation-id: dd266933-e440-48e4-b69a-08dc1cf11fb7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 3dCkmNQR4zfPHTmEsmpbYPySnXOtKf7BKWZsSe8kh9JMknvYomEB6SN7V9Q/EFpNGUql1lVOxtjdqxY2KkKmcOC5K58CGHIJJ1a2CzO+wG+bSX5AIN9WtbnJTvLZHFtGcx1nK/x/KkMqbfmICJhLekcNnjdA9JJIZ9Hp4Heb1WLAxT82NiFxps3WHsX0SissxD9qDYvElxYRzBPvfAYblmIXmSjDn/W3B1BtxdDZVkB4Y9PC7NrjPTmoaHy8SbfJw3XvUnU3mSQLp+OA8lxY4dWHNixy9MQWSBOU/ldxGj2bHWueF4wCqtOldzF8rsUqCCP/nRi1URKtYeAr4kIApLUDLye+hyoeBcxaGjQqE0s/AVEQ83CcLAmdkeE3YH7w9XdM/TwlkHs4tr16G/KUmxMfH1LBCIlYs2Wr5BCk50oXPbYl2eKSmmUalv+JmcmNo/2mipVELo1Vc4Gu4RddSgLyrxx6oCtoiGZukgVP0Mf/7v5iK62ptHv4uq0lLGJWF1jWGq3JSGHCvIeZuJRVWZ5zPk9USwz4pMiIzyyGP8b00rsVB24Lj8dFeUYZVy4hJCUvZpJzfnREAWs8oOlt6OAbf99kB1a3EO6tzIroC4pUWfEEwBAPF+/pOpfF/ct7Zjncfou7q+VjkNm/32u+CRp8dDE9fNOFp9KYpZXOWKekaXHF4h33iYJlLO65vxOJ
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(376002)(136003)(396003)(39850400004)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(122000001)(38100700002)(38070700009)(91956017)(66446008)(83380400001)(41300700001)(110136005)(31696002)(76116006)(86362001)(6512007)(66946007)(66476007)(66556008)(316002)(71200400001)(6506007)(6486002)(64756008)(54906003)(478600001)(2616005)(2906002)(26005)(36756003)(4326008)(8936002)(44832011)(5660300002)(8676002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dWorVmtBdHBLNUh1NncxaXR1VWRSSTRUbGo0MUZhcCsyRElwdUxNSnJEQUdS?=
 =?utf-8?B?V1RmWk4xSjJ3WTN6RTVPQUxHOGNTTEo2bktGQXhQOEppMGl4Q3BxbzVVUFp4?=
 =?utf-8?B?RFMvMFI2T2Z3WnBTeGZ1T2ZLOWFJTjJLTWRDZ1d6ZklBN3hnRDBhSUhuNmx0?=
 =?utf-8?B?dldmNEZXdlhGa3pSUWdYZEhBamhsK0QrQnljaGtFcjJsTlRyTU9TT1ZBNHRv?=
 =?utf-8?B?SnJ6Y3FzVTdLdjRYZlhEOTh3L0F5TDkvSk5PVGxna2d0OWR0OTFoZDBoV0Jk?=
 =?utf-8?B?cEFRZ0dPMFIzUXRDdGJjZkI4Y3hVTis1c0p0ZlNFOEVlaW5YdkhtU3N3VWNx?=
 =?utf-8?B?eERpOHhmMjNPV1ZodUFscGYxcWJ5M214d2NTRWx2WW5BUTdabXM2Z2cwNGtl?=
 =?utf-8?B?d2g0SkticnNvVmVvRWU5dnh1TW5EM2VQZXdTZ3VwNUhkTXVoZU5kRGsrUXlJ?=
 =?utf-8?B?eWdRSTFvZEE5QWJjM0E3REV0UU4rQS9EcjM3aHkwNFZkWFBQNW0vYzNCK0Ji?=
 =?utf-8?B?d3F1cUUrR3l1SFlSeWwvLzd5ajZMRzYyV2RQa1VGN2JxcW92a3k1WnFNOVVD?=
 =?utf-8?B?clpEaEsxRXdzV0FjeEVvLzFTMnRCdU1aeEkrTmNQM2lBRW1rdU11SGpFdUZ6?=
 =?utf-8?B?YnBTNzg4bmtSNk95eXhwTG8vSnNreTlrWUp4OEE0NEtDWUxtSGlDV3FhSGMv?=
 =?utf-8?B?MCt4ZG95TCtoQnNoYTdpMEVJN0NPVkRRSGhCemMybjRZa0dOK0NSZGFKVk9z?=
 =?utf-8?B?czFuOFMwa0NybVIvY0c3Y2UvWlUzK0svSzZjZ2lMTFhrS2JSVkpYbDZUVjZ5?=
 =?utf-8?B?NUo1M1lKWVlPTW5ib2VNZ1F2bGhXMElFdDFwQ3pua0w5b0JUNjFTa2NaTkR2?=
 =?utf-8?B?cUphdEQ0dVduN2Nud1dsS0loaUM3K3I1TVYwdEwxZDd5SGZLRHMwZ2lzcUhs?=
 =?utf-8?B?L3hTYkQ2S0FkYkt2NUZlV1dFUHR6elNhNTY0UEFHWEtINnpDWm5BbDhSR2FH?=
 =?utf-8?B?eTNXTm82dWZNaVBYK1VjNkxCQWRNOXhod082S1pIbnMwRmdBTUpYOEx4ZnFN?=
 =?utf-8?B?ZUZTNVdLZWp4aDNneHlSMDhVc1B3TnhZVFp2ZXkwUkY5NG9uR05WaVo1ZGpP?=
 =?utf-8?B?Q2VEdlJVNkNRbzZwNmN0bXRQcmZQWkNFdlpvNzRGb3ZCSkF6OFpUTDE2aWE4?=
 =?utf-8?B?Q2YwVjBoT3k4T3lUVmxqODR0T1NZMmlnTmpXS3RJWVhBTWdtQ3NSMVVNMXlQ?=
 =?utf-8?B?NHZkd0JucnAxNmtsRnFYdUVzOGxIaUVwNndvcjhwUStvdWJSYkJLL3U1UjNk?=
 =?utf-8?B?UGM5am9rdy9raUMwSnN6ZVMwUTREUXRYNEZtektVMHRlaVpKRDRSU0Exam5T?=
 =?utf-8?B?dkc0dFFvd3cybWxRbHN4NmF0ckoyUDd2L2c4WFFINUdSR0w4cjNQRFdYOEI4?=
 =?utf-8?B?azhwWEc0MXoyZlcyVlZFNVdlR0ZUaFl6RXlzOE5aUlZSUnJBblNXUTNXZ2J1?=
 =?utf-8?B?SVV1R3FvLzNvRDhHbkpsVHNyZGhvdHNpKy9weC9Xd0c5NWtVVk15TkNDaTRM?=
 =?utf-8?B?UXRmVkh6bEN0WmRjSE5VUW1ranpDMWV2N0hnQUtQL3RlWlNDcWEzT3c1dUI5?=
 =?utf-8?B?ZTdHYm5FM2dsVU9wcjZYQnc2a1pxenBUcUFPRTJETkFjNk1ENHFjengvYyto?=
 =?utf-8?B?OHhNQk1WUGZjVnBjN09kSkJkRnV0K1llZXhlVGc3ZzFIcHUyWnFTTXFUS3Qr?=
 =?utf-8?B?bWZ6ZGVaMmZlY1VyUnBPbVRsVW5PTXQzaDQyNVliaVlRa2RBV1VTTlVtb01p?=
 =?utf-8?B?Z29NUCtIUitydXRxTkNPL3hUOE9kY1A5MmVBSTBiQmwwdnBTWitHSG1Bcndr?=
 =?utf-8?B?bmk0SEZvY3VWWkY1d09mTDh5eVBIcW9IRDMwcWtxMzRaWkxoTzMvTTFsZlhq?=
 =?utf-8?B?aXBiN1ZBRCs2U1VWamx6Tk84VUZHRHFOQjVwVXBnZndzeEFzSjJUNHZ5eVY0?=
 =?utf-8?B?OWxkRUJyRHF5VXNNM1htbUkxRlJzUVJzYjR0SEZZc3B6aXpqODRsMVV4d3N3?=
 =?utf-8?B?TXEvT1F0N1N5RjBLUkxJOHlJeGFmS1lITXZpZDZnN0tEQTZUQXY2NGR0WnNa?=
 =?utf-8?Q?R6wuwXUlU7rld1grzfqiwrswt?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <22D65B7C906E1649B501FBF38EF1BBB8@FRAP264.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: dd266933-e440-48e4-b69a-08dc1cf11fb7
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2024 15:28:32.4125
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cC/xFKXobuxeRo9Hhsgl+2JHaD8Rl5gFsGTXATgpu0EQvxIxq70yB1+h6oLOICg7wYm2K+ZiUjkmgjWIY8TbETMpqJNnyrsP3q+EheBbxrA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB2483

DQoNCkxlIDI0LzAxLzIwMjQgw6AgMTU6NTksIE1hcmsgQnJvd24gYSDDqWNyaXTCoDoNCj4gT24g
V2VkLCBKYW4gMjQsIDIwMjQgYXQgMDI6NDE6MDNQTSArMDEwMCwgSm9uYXMgR29yc2tpIHdyb3Rl
Og0KPiANCj4+IEZvciBzb21lIHJlYXNvbiB3ZSBkb24ndCBzdG9yZSBuZWl0aGVyIHRoZSBhY3R1
YWwgbnVtYmVyIG9mIHN1cHBvcnRlZA0KPj4gcGFyYWxsZWwgY2hpcHNlbGVjdHMgaW4gdGhlIGNv
bnRyb2xsZXIsIG5vciB0aGUgYW1vdW50IG9mIGNoaXBzZWxlY3RzDQo+PiB1c2VkIGJ5IHRoZSBz
cGkgZGV2aWNlLCBzbyBhbGwgbG9vcHMgYWx3YXlzICBuZWVkIHRvIGl0ZXJhdGUNCj4+IFNQSV9D
U19DTlRfTUFYIHRpbWVzIGFuZCBjaGVjayBmb3IgdGhlIGNoaXBzZWxlY3QgbnVtYmVycyBub3Qg
YmVpbmcNCj4+IDB4ZmYgaW5zdGVhZCBvZiBsaW1pdGluZyBieSB0aGUgKHBvc3NpYmxlIHRvIGtu
b3cpIGFjdHVhbCBudW1iZXIgb2YNCj4+IGNoaXAgc2VsZWN0cyBpbiB1c2UuDQo+IA0KPiBZZXMs
IHdlIHJlYWxseSBjYW4gZG8gYSBsb3QgYmV0dGVyIGhlcmUgaWYgd2Uga2VlcCBhIGJpdCBtb3Jl
IGRhdGENCj4gYXJvdW5kLg0KDQpXaGVuIEkgc2VlIGFsbCB0aG9zZSBsb29wcyBvdmVyIFNQSV9D
U19DTlRfTUFYIEkgaGF2ZSB0aGUgZmVlbGluZyBpdCANCmNvdWxkIGhhdmUgYmVlbiBkb25lIGEg
bG90IGVhc2llciwgZm9yIGluc3RhbmNlIGJ5IHVzaW5nIGJpdG1hcHMuDQoNClNob3VsZCB3ZSBy
ZXZlcnQgdGhhdCBjb21taXQgNGQ4ZmY2YjA5OTFkICgic3BpOiBBZGQgbXVsdGktY3MgbWVtb3Jp
ZXMgDQpzdXBwb3J0IGluIFNQSSBjb3JlIikgYW5kIGltcGxlbWVudCBzb21ldGhpbmcgc2ltcGxl
ciA/DQoNCkFsc28gaGF2ZSB0aGUgaW1wcmVzc2lvbiB0aGF0IHRoZSBjb21taXQgaXMgZG9pbmcg
c2V2ZXJhbCB0aGluZ3MgYXQgb25jZSANCmFuZCBzaG91bGQgaGF2ZSBiZWVuIHNwbGl0IGluIHNl
dmVyYWwgY29tbWl0cywgZm9yIGluc3RhbmNlIHRoYXQgJ2lmIA0KKChvZl9wcm9wZXJ0eV9yZWFk
X2Jvb2wobmMsICJwYXJhbGxlbC1tZW1vcmllcyIpKSAnIHN0dWZmIHNlZW1zIA0KdW5yZWxhdGVk
IHRvIHRoZSBpbXBsZW1lbnRhdGlvbiBvZiB0aGUgZ2VuZXJpYyBzdXBwb3J0IG9mIG11bHRpLWNo
aXBzZWxlY3RzLg0KDQpDaHJpc3RvcGhlDQo=

