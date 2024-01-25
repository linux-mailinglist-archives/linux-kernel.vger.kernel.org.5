Return-Path: <linux-kernel+bounces-39308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B9F4A83CE90
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 22:27:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87796B264C1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 21:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C62E2E3F0;
	Thu, 25 Jan 2024 21:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=csgroup.eu header.i=@csgroup.eu header.b="J8UEXRfo"
Received: from FRA01-MR2-obe.outbound.protection.outlook.com (mail-mr2fra01on2082.outbound.protection.outlook.com [40.107.9.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB5113A253;
	Thu, 25 Jan 2024 21:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.9.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706218027; cv=fail; b=lZRStY1wAuvMbyrHG4pMoZbjU8seTIkH3JpN7Cu5hy1JZs9jxFtxX/2eR46KrIcAqqSJgzIdxwXvQ8JblZiZD8A7W7WIUYpvJIe+ystRE6Hnt1ke3OkgH9vwKcc8RBH9fMk6fjI4g33ylOU7HBgMHexttvT/5CibwLE4rfxGBW8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706218027; c=relaxed/simple;
	bh=g7UFNJbOGQJapw098z7nbhjURYrOeB0RQEr/gs2fuUs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jgifxAyw1xJr0KGY5cbTMg1yhYzG5QMWngEEKmcNYVsEYGHp9a7yqYJv/2eyk2ciIUelHarwI6vxTnvztdLYzZb2yUvVv8w2TMkbpwFCAJzoz5HErLgdVk/7cfg0wvj1AKM4xcpVx61O2uEImT65FNyzx0R+GhcrSIPrzL4hKSI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; dkim=pass (2048-bit key) header.d=csgroup.eu header.i=@csgroup.eu header.b=J8UEXRfo; arc=fail smtp.client-ip=40.107.9.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lpGUlE6Ee7BxOWojjcgvoOmGsfgsz8IvntiUsHMrku5WECLGzmqQOoau98+bpIbGSN1VU7Lu4gniqGfBJB/gX/QY4sftm7GSvpeQ7xIqs70No+nQDbaFgeEiac/NZHivfE94xJ6KgyAMt0UMWGTSt7PX92JytwomJjS16NdRgCjLOcsnMdOftyg2VEKd6YZ6T7wAKe2dtoZF4By43jExfCwfvJUXPoUR7JZVqBsLzc3VHWr8bfbREGOcihDaA7WlR6E5YdRvOCPrWlu68lkg/yiGEMc0GwIxBzTvE60KiLv20xwIfBnq4RdN02N7zm6yay8lhLi7qBoY1qli2PX9ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g7UFNJbOGQJapw098z7nbhjURYrOeB0RQEr/gs2fuUs=;
 b=lLfWEa5Srtbj+Ee9Pnjxir6jXb3UamRV+z8tPC/AJndiJwfAJhynDL90YgzjWFvHj60YJo5WOsHNy8aAkteKKRLfLpfhnHpOIYo7REUhGocrAv3OS1SSjzSRiPNzXr2BuwDV73ESJsToytKrmk3oqxrQZ+rAar06Jt/jQWLAiP2/cwXD0pdV/zP337qMgIZyARGrb8wZz6OVCwTHcb2GdxTvDaNZeB8Zd4aqMiloerXIRoJfSWIQzHtDcyLB2hIWoj/yESriC48b58GRiAegZBuADTjwtKuDej6QxufRFREnwgCb4KtXdy4TSPuFU5exNdBS26wMHqaUqp0nIWrseA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g7UFNJbOGQJapw098z7nbhjURYrOeB0RQEr/gs2fuUs=;
 b=J8UEXRfoZNKxhf82Otr34cqmfj6yLD4xV+uAEEahbxX70AIADCb/Ker0HRNvx8RShTAi3oASE+SG/Wbc2e5cJiwdrJr0InFBsrC3vfFn1DsTgP+ALhBcJZ78yq7ZSnA7I6sSSMdtlXx2ThltMnyUdiPTG6hkBbUayYM5E34wqotriADenccApmE1UtdZy9wwXe95c1my5XVjlD296Kmtx+2yNTX7aT1C3saQanEKsT2u7XDPyXlkZ6gkvTt0wMsV7Z5FKlZ1xL2PDgZzaLF6dUg4T3uj9Y+BQs7rcvIsYTN2XG+3AILJ6hhGQu12NGWuSnrt4rkL2nGdNmZp0ZuwJw==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by MR1P264MB2308.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:35::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.26; Thu, 25 Jan
 2024 21:27:02 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::9f77:c0ff:cd22:ae96]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::9f77:c0ff:cd22:ae96%4]) with mapi id 15.20.7228.027; Thu, 25 Jan 2024
 21:27:02 +0000
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: David Hildenbrand <david@redhat.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "linux-mm@kvack.org" <linux-mm@kvack.org>, Andrew Morton
	<akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, Ryan
 Roberts <ryan.roberts@arm.com>, Russell King <linux@armlinux.org.uk>, Catalin
 Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Dinh Nguyen
	<dinguyen@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin
	<npiggin@gmail.com>, Aneesh Kumar K.V <aneesh.kumar@kernel.org>, "Naveen N.
 Rao" <naveen.n.rao@linux.ibm.com>, Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
	Alexander Gordeev <agordeev@linux.ibm.com>, Gerald Schaefer
	<gerald.schaefer@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily
 Gorbik <gor@linux.ibm.com>, Christian Borntraeger
	<borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, "David S.
 Miller" <davem@davemloft.net>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linuxppc-dev@lists.ozlabs.org"
	<linuxppc-dev@lists.ozlabs.org>, "linux-riscv@lists.infradead.org"
	<linux-riscv@lists.infradead.org>, "linux-s390@vger.kernel.org"
	<linux-s390@vger.kernel.org>, "sparclinux@vger.kernel.org"
	<sparclinux@vger.kernel.org>
Subject: Re: [PATCH v2 04/15] powerpc/pgtable: define PFN_PTE_SHIFT
Thread-Topic: [PATCH v2 04/15] powerpc/pgtable: define PFN_PTE_SHIFT
Thread-Index: AQHaT8VU17OQ0Mi9XE+UFgNS0UdpY7DrCuyA
Date: Thu, 25 Jan 2024 21:27:02 +0000
Message-ID: <dfa52bbe-ed5d-41e6-a1e0-fe1981b936e8@csgroup.eu>
References: <20240125193227.444072-1-david@redhat.com>
 <20240125193227.444072-5-david@redhat.com>
In-Reply-To: <20240125193227.444072-5-david@redhat.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|MR1P264MB2308:EE_
x-ms-office365-filtering-correlation-id: 6b58b10f-94a2-4831-8abe-08dc1dec5f19
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 TuhKtacsaVygk8pLB1zoGLYndgoHPTAOycS2X+UGqToCNmdPEk2QhgmxR6A64OiXEUE7XnoXdx07HK5xstvbnM1A0BbP+Ak8b9nWXzNklmRe2rhCE2tbaDJUrDbuv4D/91xhWVoexsQB7rT6FLXZeXtMdPQG1lFTcfaouA+aWMxfny5CTMFN4u+KopgjcbtGF7ZNdhEnccSDS4F3Vqk3oX7A54yTOVKwRH2AvrGSU4sz1bTUvFGUgmtenKryIa/4/Ea2ze8nzW8Tnrta4JQcAuvdccTivTt+c5y8CKSwNPh3Zb6B+7SWFqE0E26ZIyDVbeve71PA2gHFCIUBDeUzJdylkEOiTPNUVoHQwjpa4AqSvG0Cg/0Wq22CEWS9YsNS6f6D41h90koKJTsfXiWRQN7MrP0QiS1PsrVD2rFTNsspQ2LUx2DCSnYQC5AMfBqlElspEubuTZiVrG/pwn+UO1ZFJT7b1vi4I/J5rulmsf4JRisfgEnoCQhs1rW1aqRm2wXJJ6ojmbwf5UN/JWa+0BDxpeKV0HhZTsn6ZRmlJC/gadFQUgC4QhdIdtD/Pd95cJ5d4Y5ClrwIxOm53Y9gxS0BRVaQtMPCCfzpg/dD8vAAPSSKQCGns1ncvlWFsXx6Ahu5H+KHWLhCuk9a04bIQUl+BDo3hZKL6jstRZOx3lL8OKN2uZnSGKNwrwMTdx+Z
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(39860400002)(396003)(346002)(136003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(91956017)(31696002)(64756008)(86362001)(122000001)(6486002)(66946007)(478600001)(66446008)(71200400001)(76116006)(54906003)(66476007)(66556008)(316002)(110136005)(38100700002)(2616005)(6512007)(6506007)(26005)(8936002)(8676002)(4326008)(44832011)(7416002)(4744005)(41300700001)(2906002)(36756003)(31686004)(38070700009)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dVp6YWRhMnVWQWZ0U2xFVWRRN08xdVFoZlNDV2hKK1E1OExac1NHWjZQQi93?=
 =?utf-8?B?Qk1RQXJQZnRjbHBXU1lRUHRsY0c1ZWJyTVlwc3VRSGRaOWZtYndtOXBvdkdj?=
 =?utf-8?B?UWlaWCtnMGtkY2RnWXRGYUhQbVJtREJVK05IeVo5dU4xTGQvbG1rZStUOWtj?=
 =?utf-8?B?QnNvczU0L2JhTkphUzZJMldvNEt6a0JUenF0OE1QRnZxK1hHREpoWnRvUVJl?=
 =?utf-8?B?VHJzNVZzSXhralFjT09aOC94MWQvWHM3N01nSG1zNDNpM1k4TTB0WFU1c1g2?=
 =?utf-8?B?RFJkanQ4Y0tPY1NXWmN5aytEV2VIQkdCN0RmSVdCWVV4VndDbFA5bFRSSUFz?=
 =?utf-8?B?MXhPYTRWdVFJaDJDNlI1aWxQTWxqZmlVUG5FcmRnSGJ6QTZIMmRMaXVzelNs?=
 =?utf-8?B?UWM3SFF5MXd4TytuRjA1QUhFVTdTMC9lM0JGY01GVjFOS3Z5MkMvbUZ6RzRa?=
 =?utf-8?B?WnJTSGlCUU5PWEJoNVJ4ZEdvVkhUa3p0KzUyTVRyOVN2cXUzSHhVanVQcTlS?=
 =?utf-8?B?emJqanNxOFhtRGt0SVNYbERlMWRqMmZ3Vk1UeCtuaUR0SGhyYzRXM0lkckRF?=
 =?utf-8?B?cUdTelAyM1lLT3J6TSt5VGY1TlBlVFNNMDRTTXY5d2NCTlVienRPS21ZVmNQ?=
 =?utf-8?B?Zm42T3dleWh0VkN4K1lpMU9VcEcyOEtDTGxuRXNyUnIrUkpJSlBHbW43TUtJ?=
 =?utf-8?B?Si9MaXh3RGFTdzB0a1VYYU9NZVZyUWFnUDI4QzVYZ1NzM24rZThZMEVkN0Q0?=
 =?utf-8?B?NmkxOEF5bjJVb0FuU2JqZGVZRlhUZy9rTUJ2SGw5cVBibEM5NUhFY1Rmb3NI?=
 =?utf-8?B?NkpYdnR2OW9XT3dPb1J1NUdyVWNQK0tkTWZIMDJBUEdXU2NpNUNJNm42MHdD?=
 =?utf-8?B?dFRmRDdyR0NianpYWmh5RXBpU25aS3FBZTBrTE82VTBGWXE1MGNaOTEvV2o2?=
 =?utf-8?B?c1YybnV6WTk4MlU3OCtUekdpZndyR09jVldpeXpvYUlTZllONnoweU56Mm81?=
 =?utf-8?B?YTVqdE5XaTFhTXJROHNpT0hsWFlKR1lkbkFVaHo1MjdXcEVFTFVCS09xT3B4?=
 =?utf-8?B?ZjRwQ3hRemhlR0tTTnUzMVV4NkVlUHJHcWxkRXE3cVNmWkJSNmdkSkdrbThD?=
 =?utf-8?B?VWVrRUxncUx4QUFEZ1pNdHl0RHN5WE5KcU5VeTZORHNkTDlSWm80UFVlQTZ1?=
 =?utf-8?B?V3AwOExXK2JoYmR0b1V5RHplSktwSU13bENMcXNjNTdnaXdxQ2FjNzNKUUtB?=
 =?utf-8?B?MGdlb3RlZXVXSU4xL2RqeWFpWWxKQ2pXZ3BqaHFlNmJnQm1Dc3RYcGtsUFFX?=
 =?utf-8?B?ZXpJYVZNQ1dHcVY2NjB1b0lsYzFJMzNRbXpkYk82cklSaUhDQ0RWMkF3ankw?=
 =?utf-8?B?UHJEZXNjL1J2d1pyQW5RZFJINi8zWHpXMjFXdThiV0kwTmdnNTl1ZlBVclRI?=
 =?utf-8?B?TmlhOU1kVUZqeWhrNmdVTWM4aE1Jb0VkcHhkV0NlL0RaU2VvOHoycTB0V0da?=
 =?utf-8?B?Z2R4eXo2MVRPMFoyVHdSeFhjbjl6UllrVGJmY1MyK3U0eGM1ZlJlQlR6bWpM?=
 =?utf-8?B?OEhxSmxlTUFWZG1JVTdNYzNyU1ZoUnBsc1JiQmIyY043NnV3WE04bm56cEow?=
 =?utf-8?B?dElGOUpBNUhiV0ZSWHpBdE56ZFNCRDk1NEt6NEw5cC9PbkExVldvd08wcWtC?=
 =?utf-8?B?TjBRbW11Nml6UElVNmlVaWdqM2g5VFNBK1E0MWc5NmhvTVAvdGZXdGZQQnI3?=
 =?utf-8?B?M2NHK3g5TXh4bnRqeUthcDJKZHNSeStnRnBWM3JSVHRDNkU0VXNRWkZ4dm4r?=
 =?utf-8?B?NytXUGxaSFNqZ2pLZ21aZTNvM2pzOHk3cEVJN0tzemE2bGR0WkppRzJ6ZnUy?=
 =?utf-8?B?OC9xdlJYZDJiTFBGRDExdzBBUWhCbzdMamFTUy95cUJwS09keUlGUUVETlE3?=
 =?utf-8?B?TEdNcG91U2o4MjRVcHg3dXF6bTB1SmE4N2ZINUw4YVg2RkJKQUE2cVhEL0NW?=
 =?utf-8?B?bnY2T2V3SDRtS0IwZmVFZldwTWFTYUNrRHRuZWoyYXRwR0NlTmhVQUV6cExs?=
 =?utf-8?B?RU0zU2t6Wkk0MmNTN3RvZXlVZWJVMmg3emxUR0ltM1dSaFNycnp6UEFWOUVJ?=
 =?utf-8?B?Szl0My8xaVhGZG5yYWJqV3dqbWlaU0p2V0U1bHFBMHFpblY2RDNhYk5vTHdz?=
 =?utf-8?B?NHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <69EF9C1C9D22454AB77B13FAFECC740C@FRAP264.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b58b10f-94a2-4831-8abe-08dc1dec5f19
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2024 21:27:02.4196
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZkGGaC82lku9GCpEX+dixkE+DjFW8a0R32Owh88Ofurw2jdpeFT2XF30sErXiMza208CUpB9PgQ+clGUoROytjEJOKl4pzAmQAcdCmHq1xk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB2308

DQoNCkxlIDI1LzAxLzIwMjQgw6AgMjA6MzIsIERhdmlkIEhpbGRlbmJyYW5kIGEgw6ljcml0wqA6
DQo+IFdlIHdhbnQgdG8gbWFrZSB1c2Ugb2YgcHRlX25leHRfcGZuKCkgb3V0c2lkZSBvZiBzZXRf
cHRlcygpLiBMZXQncw0KPiBzaW1wbHkgZGVmaW5lIFBGTl9QVEVfU0hJRlQsIHJlcXVpcmVkIGJ5
IHB0ZV9uZXh0X3BmbigpLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogRGF2aWQgSGlsZGVuYnJhbmQg
PGRhdmlkQHJlZGhhdC5jb20+DQoNClJldmlld2VkLWJ5OiBDaHJpc3RvcGhlIExlcm95IDxjaHJp
c3RvcGhlLmxlcm95QGNzZ3JvdXAuZXU+DQoNCj4gLS0tDQo+ICAgYXJjaC9wb3dlcnBjL2luY2x1
ZGUvYXNtL3BndGFibGUuaCB8IDIgKysNCj4gICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25z
KCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9wb3dlcnBjL2luY2x1ZGUvYXNtL3BndGFibGUu
aCBiL2FyY2gvcG93ZXJwYy9pbmNsdWRlL2FzbS9wZ3RhYmxlLmgNCj4gaW5kZXggOTIyNGYyMzA2
NWZmZi4uN2ExYmE4ODg5YWVhZSAxMDA2NDQNCj4gLS0tIGEvYXJjaC9wb3dlcnBjL2luY2x1ZGUv
YXNtL3BndGFibGUuaA0KPiArKysgYi9hcmNoL3Bvd2VycGMvaW5jbHVkZS9hc20vcGd0YWJsZS5o
DQo+IEBAIC00MSw2ICs0MSw4IEBAIHN0cnVjdCBtbV9zdHJ1Y3Q7DQo+ICAgDQo+ICAgI2lmbmRl
ZiBfX0FTU0VNQkxZX18NCj4gICANCj4gKyNkZWZpbmUgUEZOX1BURV9TSElGVAkJUFRFX1JQTl9T
SElGVA0KPiArDQo+ICAgdm9pZCBzZXRfcHRlcyhzdHJ1Y3QgbW1fc3RydWN0ICptbSwgdW5zaWdu
ZWQgbG9uZyBhZGRyLCBwdGVfdCAqcHRlcCwNCj4gICAJCXB0ZV90IHB0ZSwgdW5zaWduZWQgaW50
IG5yKTsNCj4gICAjZGVmaW5lIHNldF9wdGVzIHNldF9wdGVzDQo=

