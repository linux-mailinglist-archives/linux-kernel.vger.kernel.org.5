Return-Path: <linux-kernel+bounces-161582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5536E8B4DFB
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 23:49:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3EFB8B20B28
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 21:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BE04B66C;
	Sun, 28 Apr 2024 21:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XQQw54+3"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2046.outbound.protection.outlook.com [40.107.220.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C673410F1;
	Sun, 28 Apr 2024 21:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714340986; cv=fail; b=jlpnZmb3txXUwEjzWot1ECY9JyNybv2QMEthmbubyXl9kkvIJCTjqV1lOrJvM1QYKdyH7Dhzt9OmLK9sA7MRj01XeZqU76P9ZmvQQJ5qFK1OZO/HKoqwJRZIlK8KodRTMTtwmtT85L1ZzMQxnAFAXEpEGhV49suSyuQEIQsQiTE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714340986; c=relaxed/simple;
	bh=8fwTo7/I/QzOQndMNngFr83gP/3H21OCPjDAB9/mSQw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jjBn/yg2alRdyoeQDeQ1laa5P9a3qZBPhB1P9cUBcUMKBeN1G6rWQ/17UB1JLT6lJb1f0H+cTOIaDF6bAdJpWgn0+5kNGxEmdn2wyXiSEnWvGk6wjsmQdOiqoboKisSOelZmzR9Xnm6Q9WN3+qCHLJVslXO96hdTqy7mia8g4eo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XQQw54+3; arc=fail smtp.client-ip=40.107.220.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g5IHp9z5Uvy0LNxUGgine2xb4BO5B/d9icOr5BXActWZ2elHPBliPj2nbthtPlRmJPCsAk/EwzuCXGomHpUJbeRXPf6PYbp+m2Z37lIz0UQarJsoiR1CSEqzSZo1TYmZhvnPmeiunizqQ5g4nCd0Y+Vwnp9Cp7z9l+u1PMR+MFnxG03h2G3HV6xeXTR55fLqVDyasYZRVTHKM7aq3xHyPnP9xWdecf8lha+o/Bp0RtQTsh12/Ezuel2qtsJsfWrgdJmHXU6YJCNi64b4kGUDVBOeFdx3BiSvGF0FKRNLpaqptiuioKvjLsf87eU0JkI/fgyWkmM8mAPE/lC9sUS0NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8fwTo7/I/QzOQndMNngFr83gP/3H21OCPjDAB9/mSQw=;
 b=H7QK8yjrSTlwQGLJoGhVlwjUPfa/EH1TuWRtoLxwFZu4m9XLM964WxXVsMl66ROQunzIzDOHtsfN3rEcYMASBNt5zG+xKKlPePNlWKZMbd7Hv5Okdl0cRsUgPdSOf99nNiPmNcbvIuUBN4wQjLymXZlNykVlmG03eihpfG6DWkvjPHTa4EYzq0Yw9k7Dzb/ptxjuiW3SmYVuaFlo+MN5/OdSjPVRA7cM8NQfNkcMBniE2vxZScPU97uC0J4JkOcHv+bQuZtQzZAm9bE0pFFvHr2rKWcH5KoFHyxDTGgFIi2whYnYTjbHBYQvDq9ae0CP4aMwqqi7TsYdHI2+iFJZFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8fwTo7/I/QzOQndMNngFr83gP/3H21OCPjDAB9/mSQw=;
 b=XQQw54+37oSzllxsby0U+CJ90Ld0w//4oxUdSIvgLK484XSDeOwfOTMHojv8llEyaV9ggrU2V/umoQAy1B10p8NXHeODjxvae2+chzCZZ2cyKMqTIx2xdHAXDhlj8wZ1bMaqVSeWsOsavblly14kDyQ2ruGoc3rYSiM2KQzrVwIa++UPjsFnfCdf/KosMMEVzJ0BOJv2lbMh96gylNV+pZ/XW2CPuGT8jqb0+Mp5eRmzfAhnCDE/qLfm+t0lWPtm2B7+drqzD1+F+cll3iQLV2FjM2JdNCX0Q1lIwFwVmRdgm8g7JmA7BmPx5JKNloowSAbq0dORbxqjaD40mbBZxQ==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by SJ2PR12MB8183.namprd12.prod.outlook.com (2603:10b6:a03:4f4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Sun, 28 Apr
 2024 21:49:42 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::a1:5ecd:3681:16f2]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::a1:5ecd:3681:16f2%7]) with mapi id 15.20.7519.031; Sun, 28 Apr 2024
 21:49:40 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Gulam Mohamed <gulam.mohamed@oracle.com>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "axboe@kernel.dk" <axboe@kernel.dk>, Shinichiro Kawasaki
	<shinichiro.kawasaki@wdc.com>
Subject: Re: [RFC for-6.10/block] loop: Fix a race between loop detach and
 loop open
Thread-Topic: [RFC for-6.10/block] loop: Fix a race between loop detach and
 loop open
Thread-Index: AQHamZyRRSWLnXdUSEOZtsQL29eL27F+OLoA
Date: Sun, 28 Apr 2024 21:49:40 +0000
Message-ID: <4c9436c7-0fbf-43dc-a30b-7b8fe3d49dcb@nvidia.com>
References: <20240428184729.619458-1-gulam.mohamed@oracle.com>
In-Reply-To: <20240428184729.619458-1-gulam.mohamed@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|SJ2PR12MB8183:EE_
x-ms-office365-filtering-correlation-id: e8b32669-3afd-4b77-3a9b-08dc67cd1b35
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?ays4TENDd3BKYjV6V2lBZ1Z1eFMrRkgrNk96bEthemJGY1Z3d2FjSm9VaXJy?=
 =?utf-8?B?NTdXWkVQbnZ4S3lJOEFGcmNpODliNldQVk8yaFBzeDdhZDNTVDRJUHU1K2R6?=
 =?utf-8?B?aUFhREV3OTJLVHNOcC9HTkRQd0FhbWJpVE9xRkF4QkN6RzBmSmw2NDFlK0cv?=
 =?utf-8?B?c2laVW5PL0VqWVNzSUlIMktCUlYxbnF0M0pJdXdjQW9mQXZrK3lFQkd5N01X?=
 =?utf-8?B?NkRJdEFxUmRtUXZrNlRaU3I5TU5PWkZwRitHbXk0S0NxU0F5NjZJeVkrSWFs?=
 =?utf-8?B?MExlcStjNExUemhUcWpWMk4ydzZSY05LV2JLaGZZMnByVlFYVzlNUXpOTTFC?=
 =?utf-8?B?SzltbGNhZmhvbWxTWDJmM29mMmMwRklVNnNncWdCOFFCTjhoTmJobC9ic0Mw?=
 =?utf-8?B?aStVNWxZeHBSZm84MmVncUJvZE5GK2I0Zmc4UGl0RFZQSVRnc0gyMUgvUWs3?=
 =?utf-8?B?czR4NlhMTDltV1Y5cm51Umg0Y3JVU2pxTkJJT0ZZeEtabHdqcU4vempMS01h?=
 =?utf-8?B?eDA0MlVOKzhEbGhWMnBiUEZkRDlBUnNTZ0YvQ2pNYm4yenlySlpEZFhlM2pU?=
 =?utf-8?B?VUxySW5OU2xVQVpNZ0FJN0lFazFtNzZ6UENyeVdHZXpoTldyT1BBZXlHZ3lF?=
 =?utf-8?B?dG5Oc3FjemVYRDU2QkRBQTkwc0prbk1KTlpTZFlIaEpJTWlxOURZSHBqV29Q?=
 =?utf-8?B?cyt6cktEY2VaM0toS0RqRnhuU3FESmQvLzBHdElZSFE3dVdSU3pjY29GK1Mw?=
 =?utf-8?B?UmUzQnA0YWNFcC82V1NLRmVHeGRiN1hHYkJlYTNVQVhWLzAzeWJjc0xieGdm?=
 =?utf-8?B?b2pQWjFJSFY0Z1dla2lCZTVZOHRqQ2FnRXNrZEFKRTd4SFQvYi9IVDkvT2VR?=
 =?utf-8?B?bGZ2Yy9QMjl4akh5bUd5WXNFWFJxNCtBcTBFa2RXWUliTDNoWEtWZndyRHU4?=
 =?utf-8?B?S1dvQWpJN29ML3VDL0s2TE5ISVk1Y3RsM1hBRmUrR2pBRkZmL0JwOVNaOGtU?=
 =?utf-8?B?VFRQVGowTU10QWF6T2J4YUgwWHh0cjJ5ZjFaQ2Y5QmN3M0RhdGduVFBTeExN?=
 =?utf-8?B?cFYwN1hLdWtyQ1ozRXorSFBVYXhvUkI3bGFsWEhkU1hyWWhreW5URlF3eWth?=
 =?utf-8?B?c3dYbkRQcFM2V2JScEFqOTdpZzBURURrSldmU0Ntc1ZCTFlDem1HKzlMUEV1?=
 =?utf-8?B?SnIvTWtyTlMwOFZhLy9OSXNXaUplekFpREJiVHVndkVISDNpWlZ2Tkx1ejdX?=
 =?utf-8?B?VCtXVXpFYmRPeFFuVXZ5VzUvOXJwSXhyK3BFbElGVjh6Z2ZaeTRST0h4aFN6?=
 =?utf-8?B?cnB3L0NjeFNEQTNNVzhoZUF2cm54aWVsV21aT085enlvODIzdjcvTWkyWW5Y?=
 =?utf-8?B?dDd1MDAyUUNNYnJ1b2FtdlRTcUxOUWZUSmVJUU9tSlNQVEczbTFxbWY1YkVv?=
 =?utf-8?B?Y1dkSGJmeEJRZzc2Z0E2K2pKVkF6MlNoazVzSkNuUXFuR2xPcmVMZGxRdUNn?=
 =?utf-8?B?UmZWejY3WlEvQnloL2VzWTFqbzk2RFV3ZmRZVXgwMmVSeDdGSmtQNGhjRVRY?=
 =?utf-8?B?U3QrSWVFV1Z6ekg1Zy9nSGxkVUdvU1puWC82N0Q3U3JWZnExNHYxN3pxcVcw?=
 =?utf-8?B?bEdrZndoc3BMaThuQkpsTjZwbE9rZkpPZURXZ1JTS3RONVZEaTNCekpUYXhZ?=
 =?utf-8?B?eGVlYmIveEFCb1E5RjMybVF2MEcybW11MG5jM2J6NC9lcEJXaER4Uk9NNWNq?=
 =?utf-8?B?QjlzNzhXL3lCeElGa01sbFJzZGwwczFDOXBSZ1M2U2IyYnVSWjdNaVFBOTBH?=
 =?utf-8?B?VGpOZFFPSUYwOTN5T0ovUT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZVdBNldadk1mUG9NZWd5aXRrd2NxWXM0OFF3dWo1M29uOEtwZ29jR2pnWWU5?=
 =?utf-8?B?emVyM3o0U0VRcTZLOCtjWWNXbXZIWWVrcmhaVW5FMDF2REJ2VXBqai9YMGVz?=
 =?utf-8?B?RzhNbEVXTHpheHdRWUZsQm1pTC92Mm5vQmtzR2wwckRwbUNscDBYaGdIT24v?=
 =?utf-8?B?OVZ0VXQ4MFFJc0RXQUkxNWhPY2VMNk5PRjdoVnJSa0ZsT0tFa1hmbU1BZmxP?=
 =?utf-8?B?ZEhRQndEYkZ1U0lqeFFFdSszWEhnTGw1MVpSQXVHaWlGaFRUUC90UzlOL201?=
 =?utf-8?B?eDFqWjVYYU9hY05lZ1I5eXBuN056OXFRVWhrd0Y3bFFmV3VHQ2xHbFY4RzYx?=
 =?utf-8?B?MVdJSWJQc1V3a2lZcmczckVXSXRYVFljbm1mSnFDWUl6bzFhYjZBazg3c0Ry?=
 =?utf-8?B?cllmS3FBd3RsbkRySm4zSXZhdmVxYVNyMHpOTUM1NnRtWmNLWGR4cERVUmJE?=
 =?utf-8?B?RnIwYnhRd1pEcEN5dUp2TUVkL1RMQVdoL3RWQXM2ZGh4ZG5HeDZIWi91TFZa?=
 =?utf-8?B?MFNGMHpGa1RhMzhnaWp5b0ttcE01ekttUnJxb0VENDFDTXBFQmZpME1UK1lF?=
 =?utf-8?B?alN0RnB1RGFhVC9sUVB5YURpYkQ0Q3ovZlRBYWljZEs1RE94ZEpLdm0xQ2k5?=
 =?utf-8?B?Y3ZTQmo5QkNVTE1uQWYzOUprdVFSWmJSK3Qyd1o2MmVua0JGOEhxN2dKaFlo?=
 =?utf-8?B?UVg2djVMMXIzYlBLNlVocXNtcldOeTBmVDM1RFgxbERPenRIdVJxaitUTWd4?=
 =?utf-8?B?QjV4T2drTUJTajJpaDVMcWFNeDJ1UnhzdkdYODJRZFJka2JEQlVWMmdJbFZX?=
 =?utf-8?B?emFieGxTN1BnNVVqVkNSdVkxU0s2bE9XQ3dzb0xybDBtNDdJOFNDWUQvWm8r?=
 =?utf-8?B?QzE0bWhOYlRLWDN1VVFXbmVNQkNlbnhnaVZyR0NxNGZXQTlRZiszRjhGR2Rm?=
 =?utf-8?B?aTZucTdtdzk2eEw1NUIvRnByMDdyTmFJbXNuSHN2Z2l5VCtERzhEeHM2WDQw?=
 =?utf-8?B?ano4VHRUN2NrZzdGb0tCZUtTM2cwNW05RHpSNWp6cndkcit0NWN2MXIzVkpu?=
 =?utf-8?B?eHRkVDkwdGJkREhobkZ4WjJnakVObS9lTExDZGd5SngrcUlNeSt0WVhGcGV5?=
 =?utf-8?B?dmprbEcvYXZJZE92OElmalZPLy9aRXhGSDMvVXRSUENSZmRpZENSbTkzazll?=
 =?utf-8?B?V0VpZHlycUFmU0NZWWplVktBTzdZRDd5Y2taMjIzc2RGVVBkYWRzRWkzcWVX?=
 =?utf-8?B?WXZ2L3RkWUtYSzgzd0Y2ZmNvamRLcmo4QTU1YlJyT1FJbzE4b1ZpTGJVOWNV?=
 =?utf-8?B?SU1yWnN5amxZVW15bC9iM0EwK3dGc0o0Y00zZ1N3NW9PNEsvb3hDS0grZXh1?=
 =?utf-8?B?NTI1Zm0wNEdkdWQyWEtlK0xlU1FrL3NWY3RWUEZoRGVnaTdYQTRXL0JRMjhx?=
 =?utf-8?B?OExQaWs2QmR5cm5JMHIrL0F2aFVqSStLYU5zdXNSMXQvRTFOak1SM0IwT0ho?=
 =?utf-8?B?azZnS0p2clJNeG53dlJQekNjRktoTWpWUlRQOEk4TEpNbHNoR2g5MHkyQTBr?=
 =?utf-8?B?MGlNTEtXdFhINjlIaVd4SDJEM0F3NmhuNC91cmtaRFpjQlU4dkZvcDlYN0JJ?=
 =?utf-8?B?b2dEUDhrTVFtS3E2NHBnaTduNlB0cVZiN1BWVXdLVjRDYWEyek1KNGdTNFZt?=
 =?utf-8?B?VHUvUjZ1UmQwTEpTWW5ITGxQUzRTYlNkVWhkdWJHQVg1SzVLNHRBY2ROSDdD?=
 =?utf-8?B?SGZWdU95d2VQMnFMSm42V0FXdURCRGJVUU5QaFhYL1JxVzBYbXZIRkFWRkRk?=
 =?utf-8?B?THdXS3YwU1J4bmdHSDBIK1RRNGJJdXh3ZGVBdHc0aWZtQ2JlUDUwNmIyYnZX?=
 =?utf-8?B?L1BqaWUvYUI4OU1BTWFTZm15Q2dXNWo0MUJ0eHJEdlBPWE1TcUxIWHRSczhW?=
 =?utf-8?B?QmIxaWhwZFcyWXlRYktya2tTOHVBUGgzYm1Nb1FadWZNZ3JlUGpEMFMwSXZN?=
 =?utf-8?B?ZzhXZjVuMmNaWjVKL2hZbHpUSlRoS2k1QkE2bXE3aWMxUmJOaTRHbnJTZi9Y?=
 =?utf-8?B?VGNLT2JEbEJkL29NNHJIc1FhWlpJNW0rYUd6VmtGaFdZZjJCM213ZFRiQkR4?=
 =?utf-8?B?UUllUm5aV2RHSkhFeFlkV3VUYjlKRWtsUnY2bWczUHdSbWUyZ0dQdnRBMnMv?=
 =?utf-8?Q?7j2MdDIfKSzZDwG7SyQ/8x6mk5PB00iolIzaZb+BuC9t?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1CE9F732F2BCCA44BEB5887B4E7E54F4@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8b32669-3afd-4b77-3a9b-08dc67cd1b35
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2024 21:49:40.1611
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EHgu3PtRHnHmutfp328xyDiRRLOAU4ExR38Wd9XVYZ4XgI1OBF+ayWtdEbW0WhtlpklIvIUJ3QPFo6NrR/8BGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8183

DQo+IFRlc3QgY2FzZQ0KPiA9PT09PT09PT0NCj4gVGVzdCBjYXNlIGludm9sdmVzIHRoZSBmb2xs
b3dpbmcgdHdvIHNjcmlwdHM6DQo+IA0KPiBzY3JpcHQxLnNoDQo+IC0tLS0tLS0tLS0NCj4gd2hp
bGUgWyAxIF07DQo+IGRvDQo+IAlsb3NldHVwIC1QIC1mIC9ob21lL29wdC9sb29wdGVzdC90ZXN0
MTAuaW1nDQo+IAlibGtpZCAvZGV2L2xvb3AwcDENCj4gZG9uZQ0KPiANCj4gc2NyaXB0Mi5zaA0K
PiAtLS0tLS0tLS0tDQo+IHdoaWxlIFsgMSBdOw0KPiBkbw0KPiAJbG9zZXR1cCAtZCAvZGV2L2xv
b3AwDQo+IGRvbmUNCj4gDQo+IFdpdGhvdXQgZml4LCB0aGUgZm9sbG93aW5nIElPIGVycm9ycyBo
YXZlIGJlZW4gb2JzZXJ2ZWQ6DQo+IA0KPiBrZXJuZWw6IF9fbG9vcF9jbHJfZmQ6IHBhcnRpdGlv
biBzY2FuIG9mIGxvb3AwIGZhaWxlZCAocmM9LTE2KQ0KPiBrZXJuZWw6IEkvTyBlcnJvciwgZGV2
IGxvb3AwLCBzZWN0b3IgMjA5NzEzOTIgb3AgMHgwOihSRUFEKSBmbGFncyAweDgwNzAwDQo+ICAg
ICAgICAgIHBoeXNfc2VnIDEgcHJpbyBjbGFzcyAwDQo+IGtlcm5lbDogSS9PIGVycm9yLCBkZXYg
bG9vcDAsIHNlY3RvciAxMDg4Njggb3AgMHgwOihSRUFEKSBmbGFncyAweDANCj4gICAgICAgICAg
cGh5c19zZWcgMSBwcmlvIGNsYXNzIDANCj4ga2VybmVsOiBCdWZmZXIgSS9PIGVycm9yIG9uIGRl
diBsb29wMHAxLCBsb2dpY2FsIGJsb2NrIDI3MjAxLCBhc3luYyBwYWdlDQo+ICAgICAgICAgIHJl
YWQNCj4gDQoNCg0KY2FuIHlvdSBwbGVhc2Ugc3VibWl0IHRoZSBibGt0ZXN0IGZvciB0aGlzIGlz
c3VlID8gWzFdDQoNClBsZWFzZSBDQyBTaGluaWNoaXJvIEthd2FzYWtpIDxzaGluaWNoaXJvLmth
d2FzYWtpQHdkYy5jb20+IChhZGRlZCBoZXJlKSANCndoZW4geW91IHN1Ym1pdCBibGt0ZXN0cy4N
Cg0KLWNrDQoNClsxXSBodHRwczovL2dpdGh1Yi5jb20vb3NhbmRvdi9ibGt0ZXN0cw0K

