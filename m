Return-Path: <linux-kernel+bounces-56532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11C5484CB52
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 14:17:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36F0F1C2505F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 13:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79D7E76C7F;
	Wed,  7 Feb 2024 13:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zJxYtOCz"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2066.outbound.protection.outlook.com [40.107.237.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281E45A0F1;
	Wed,  7 Feb 2024 13:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707311833; cv=fail; b=pG85e2QLXII+aVxmHjkxxNZAmVBCsAlXoEfPA05gxcDcm+/JUWzBmxT4w5t3wRPt7SvurfRcmzFLd5pgikRHNj0en48pIvxBQraCWcKQCWBC2Op0oiviUrMVKl10eVaIYPRaFviScgvfGAgZ7SCsHClQxIBf8ShyUSka40G0TGg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707311833; c=relaxed/simple;
	bh=Uu+bAuLzgIH1f539n+MF/LhI3B8ltyESmpIM00sKnAs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ENXKEsRMFDYRFBDEKe/Zw2GihTQPPa60aVPkI/6/Zrb/cvJ2R9YwIFuTRxXP0NLtFp8gjvRE0JIl4Or7Dnjf/XNrGTOErZ2LIAUWFX3MI0RKE/iXAkGKmcfzCI/270VxL1nT7wcFq4I4B1fyZsBUEunZFHZuTcytyw8GckTd0Gk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zJxYtOCz; arc=fail smtp.client-ip=40.107.237.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VD255WaZj4yByhJxzxFRBIgpy94EFnrxM9mltdkC1o/Ie1NPHI8YWjjKmcPfhsFpezsIdj5GH6+g1vcYWeF43uT9pq7NrbLheY0A7Y8pne1G7lQPRzwU8eJJM0leGCHE66AePb1iaok93ydLkj3nUD/lJyEkaXkqkl4fXaoHbPt+1mSo5po7b9jvRjhnsxRIIhZYnmU3gq5l2qWkgOSHBpXiEHMK2ZKYtip7MFDLri075GvStgRGENJ6lUyXdzMl7SAdyX2YY7uBfl5y9LRuZg9CJ8kL4FEC2p6w0n8v2JpaOBvN+FTkuQhBzCV6dOTfcoxZYMlETJ66qDEZx6vKUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uu+bAuLzgIH1f539n+MF/LhI3B8ltyESmpIM00sKnAs=;
 b=FXSBY6KXImUEIHlGgAU4NfeT1Yny+TQ3UHuG/tI1FzGe9655DKG39k9Jzqi5YeOpdtVeFAkjfcDN+NL5na5PezrULm6xVR3H3TuqfvxPXCtbhUXaiwX9GtKjcXQ+rVLUrEYwUGwIzOQ/6YqxfZSYdvp9/qcd0Rz30xG0ezMoMysIRdr15Cd6xoZXgYO0PMTYgXtrzDK655H63XE7jTFA48d2SGIMs9aPxmZk/tTwGJXpPwIn4JvyGkIunpdCzauZ6piPoFSb0xNt8Vj7fUXT444fFzmAje4OKmKrqAeSeFk2XgUiVzFFXLTpboKx/o1I5c6REmQaFPM/Fk2hsvOzLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uu+bAuLzgIH1f539n+MF/LhI3B8ltyESmpIM00sKnAs=;
 b=zJxYtOCz4zy+qaDs3cfXcG5hEhZ0OlLjCFzY3X8bHdSnVwdgJW34gcjUNYvpEfU+Uo1xJqjyfkdqCkjszdJcIpj6xPbCv3iDz2j5eed/6pHPLO1CIXb2NVVBhFEzj++si5+D+UCsJm5oRDLtMTCTMXnN3cP/M6I2jEwaXlhdE1A=
Received: from CYYPR12MB8655.namprd12.prod.outlook.com (2603:10b6:930:c4::19)
 by LV8PR12MB9110.namprd12.prod.outlook.com (2603:10b6:408:18b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.14; Wed, 7 Feb
 2024 13:17:06 +0000
Received: from CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::b26d:fe6e:231:f6f4]) by CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::b26d:fe6e:231:f6f4%4]) with mapi id 15.20.7270.016; Wed, 7 Feb 2024
 13:17:06 +0000
From: "Yuan, Perry" <Perry.Yuan@amd.com>
To: Oleksandr Natalenko <oleksandr@natalenko.name>,
	"rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>, "Limonciello,
 Mario" <Mario.Limonciello@amd.com>, "viresh.kumar@linaro.org"
	<viresh.kumar@linaro.org>, "Huang, Ray" <Ray.Huang@amd.com>, "Shenoy, Gautham
 Ranjal" <gautham.shenoy@amd.com>, "Petkov, Borislav"
	<Borislav.Petkov@amd.com>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Huang, Shimmer"
	<Shimmer.Huang@amd.com>, "Du, Xiaojian" <Xiaojian.Du@amd.com>, "Meng, Li
 (Jassmine)" <Li.Meng@amd.com>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 6/7] cpufreq: amd-pstate: remove legacy set_boost
 callback for passive mode
Thread-Topic: [PATCH v3 6/7] cpufreq: amd-pstate: remove legacy set_boost
 callback for passive mode
Thread-Index: AQHaWadx9By+jykrAEaliStQ0Z5XkrD+qI0AgAAymfA=
Date: Wed, 7 Feb 2024 13:17:06 +0000
Message-ID:
 <CYYPR12MB8655B6D156512E187F2A736B9C452@CYYPR12MB8655.namprd12.prod.outlook.com>
References: <cover.1707297581.git.perry.yuan@amd.com>
 <fb14f6e7748f1b872f68eb2549d4e6033f0facbc.1707297581.git.perry.yuan@amd.com>
 <2887380.mvXUDI8C0e@natalenko.name>
In-Reply-To: <2887380.mvXUDI8C0e@natalenko.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=a8b08769-c15f-4ed8-87d6-ea10f517ba6d;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-02-07T13:11:58Z;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR12MB8655:EE_|LV8PR12MB9110:EE_
x-ms-office365-filtering-correlation-id: 45592e40-74e9-4e02-ff92-08dc27df1538
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 EZV7ZrDn5SnsZWZR2bQeqrBJms2jRPZJF6K6eIATDQUKXi2zM2t5gWMAMtq1iS49ujkCVT2PLLz46pzWLzJ12x0mhc4sCjhywcBZ8ZtHTtkKs9C/0HZ28l0ACw14LUgnBo0gsqzS2bGobZ4YX1uJPot/OluxkYxH2wNe/NkHpwP+fA6fEfJJHdXNa5T0L5Ep0fn6TLbu1Th27GpUOsb9B83IZhqfFNVloOrDzB4DtWJcwxZvDxizu2t5FMY3r/cA9/9KYJ/c19QnbVwjdKrcKtu5zfCzFyhbwnd/KbTi7LTnAfNa+K6d1DI0p2gcvFFvp60Cly3Xc6tytyWheJIhEDj80zRhaRW5oSX9HcwwbkX0r9ToebTzaIvG7kS1jI56CyBIA6r2b7Oue6LBKHGhqlA+5j55r2SI+uHIoOP1m+3EURiJOX6yMyRVR1kAZOJ3dFT9/BlQDqseKl73Q53y6ndCmIlj5Jf95FM3x9l7Lw8cGAd9bp/ZA8WMYgwuEfy041pllBYgqduYngSBJF2U0FNUjbtB1aKrd987qIooFpXVLEv8wbzp9kzUfiSDDN9DIwFW/Aw+egOhHBa+kpRsj6BcigtNP2NKr4higEc2iu1h/OkCVywwTReJFYrHB+M/JN6VivdJsfG21VUEJx519g==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8655.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(346002)(396003)(136003)(366004)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(921011)(55016003)(38070700009)(478600001)(86362001)(53546011)(41300700001)(6506007)(26005)(38100700002)(66574015)(9686003)(83380400001)(7696005)(122000001)(71200400001)(2906002)(66446008)(64756008)(76116006)(66476007)(110136005)(5660300002)(33656002)(8936002)(54906003)(4326008)(66556008)(8676002)(66946007)(316002)(52536014)(6636002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Y2U0d3dtcjFmWk9PRjFJT25OcTM0emhvQmFyZHFGc2t5V3JaVklaWkRLNTFV?=
 =?utf-8?B?ZGNPeXVqcWFaOUwyMXVtMUNvOWlZelBKTVIwQ0VHdXBHOWthL3ZETVFQdjNY?=
 =?utf-8?B?M1RmZUtTL2gzekxBOGIxMTFhK3d4NkdhOUFMUW1DbWx5aWhjS0lwUkRVV0lr?=
 =?utf-8?B?QVlab25kN3JoVzlodFNSVjFmTXJteG8rbDlzVU80NkRmNnFKOGxqcXlLMVRC?=
 =?utf-8?B?cXZDR1BvSHhCWjhLdnNTekdwN0N4akJyb3BoNzFvYTJrRHlQY1BwNlpZY0hi?=
 =?utf-8?B?S2F6aE9ibStNc1ZDb0x1VmZrcFpMS2x6UFNySkszWEpsVVEyU0gxOTY2NEJr?=
 =?utf-8?B?QlFJWmVwRUhyY0NVMEg5NnRIZmV0dzZNWTV3YitHVlNBR2tqdFdYQVhPV3V6?=
 =?utf-8?B?Ykg4dG1WUjBFWXoyc3lBNDNnRzMyOTFEc1UwRHZOcVZUVTloc1VmOXRHdWFZ?=
 =?utf-8?B?RDlJQWY2YVY2c0pNRUVmZkFvT1N4MEJ2aFpIc2lTallrWXNHQ3BNNm81emNk?=
 =?utf-8?B?WWtxRmJKQTBoN3hKeVR5Q1JScjkrWDBLNWdHMmhIME5BZm1NcHIyN2VRaUVh?=
 =?utf-8?B?WlBnSmhnVzdqaEpiYkNRVWRPbUFUUU1RWHRsbFVpUjJVOVdBczIxWUtCWnE3?=
 =?utf-8?B?d01BZGpEYTNEbXozVDRycHNsNzlCUEdqYVluV1FTQ2tOWEFaVzgzOGhwUGlG?=
 =?utf-8?B?RS8vLzlsMXMzMzZyS2tlT0VnRy9sRTRlRVR0SWh3Y0xJR1dVU1k1SjVDTCtw?=
 =?utf-8?B?djRjWTBHbmF5cXJNZjIwU3lJOEkwZkdhMUFaS0xpSWVjeFAvZDFiYTloWWZL?=
 =?utf-8?B?RUtnZlRXclErS29hSnhIbHNPdlFNUTZwWkpUOWJmVnBnQWZFRFdnWGhLWTlR?=
 =?utf-8?B?azN0VTlmWnNQMXVGTXZ2byswSmV0ZHVOVkpCUFFuekdRWVRBeThBaytNcmN4?=
 =?utf-8?B?dEFHZEYwLzRTRzE0WTRZM255YSthbWRySDlBQ081Zkl6UlNld1QwdDRNMWRE?=
 =?utf-8?B?eFJBOE0yWTJnalovV2pCemdJcWNlYnlIYnVYTVdWNjFEVitUb3orb2FuZkpn?=
 =?utf-8?B?OVcvZlUyLzUvSzh2LytDRVU0cU90WVpiZGhIY05HeDYvYjhyeXFScUpEU3hF?=
 =?utf-8?B?SFR4UjBicnR3amxUeFUrSUZuenZHOHZCaHNWQlduTlluRUJTelhUVG5lL1Y5?=
 =?utf-8?B?VC9hQmd0VFUwbVRrcFMwRVE0d0hiUk1MNzd1aitSbEtxWHgrb1laZ0liS25R?=
 =?utf-8?B?ZG5hVm1INFBWTk1LY082V2pzcTRDMzA1TVhwOTlUT1JiMkc0UkFZRlZtZmlk?=
 =?utf-8?B?NXZoQ2EvYnJ0ajdGOXMraWhtamtkRU5nNGVXOEdJMlVZRVl1Zmhtc2NnS2N1?=
 =?utf-8?B?bnArYmVWbjF3QTIzV01waUFBUG1HYW1kY2xZTjR2blVYbGFEaDlKZklSbEhF?=
 =?utf-8?B?clJacEQ3M0dZV1Y4alRFZjUwREc4MklsaVk4QTJSZzhvV1R1TnZuMGQvRzN5?=
 =?utf-8?B?U3NLNENWNHkvOVkvQUtzOVRMb3RsMTlFb0Q2NzV2Q3NuRDhEdEhham4zRm1x?=
 =?utf-8?B?c0oyRjhlVXRmQU52cDN5ZmtwbmxPTHB3OXpaUVBYN2UxY1NYUjEwdDFhS1cz?=
 =?utf-8?B?Ny9OWVNMUnlsb01DZjlzYU8rVUlzbUpTaDBKdVhRaWVLdEY1SGNUYmFtakZQ?=
 =?utf-8?B?ZGZ2OVkvbVVWSWZJeEJ1YW8xZVdQYWZyUkltT2hHNlVTS1NrNlhrc1FWOHFF?=
 =?utf-8?B?RnExRkRaRW8zMXlid3NaYUlOdGlpN2FzM2lwdFd1SzkyRms4enpwUzdJaGNs?=
 =?utf-8?B?YUFGTWNDRHNYQUN5Qm5JRVE4dU9VUEZVd3phbEdBYitHNnNna3hzN3JQMlk3?=
 =?utf-8?B?VUs4bnBsMHkrWFkxemJ1VWowMEpFZGc0eEhjNHRDVWV4QitJakloSC9HaW1v?=
 =?utf-8?B?MFY3WlppNzhhVndaelZhdG9VNmtOYTkySDVHS0JxN1gxOWlJTU4yemlIWmFa?=
 =?utf-8?B?RThzSG9NU3RDZWk0SGtsV2FKUHdZaHpCUmRlMVhiNndCaXR0VU5NQ0h3aHEx?=
 =?utf-8?B?YTg4ZEZKRTJ0TjdLYlRzVjAxZlZTM1JzK2doM0xiclBlbFZuSmdROWpzV2Fa?=
 =?utf-8?Q?auys=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8655.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45592e40-74e9-4e02-ff92-08dc27df1538
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2024 13:17:06.6772
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4eAzMPcCj6sVgi/phjXwgfQysGjmLKWMWZUPLUmMTWHYEUd89qs9X71DUCUQmibb0bb/NtxCIEp8KwReDpZ8fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9110

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCkhpLA0KDQo+IC0tLS0tT3JpZ2lu
YWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IE9sZWtzYW5kciBOYXRhbGVua28gPG9sZWtzYW5kckBu
YXRhbGVua28ubmFtZT4NCj4gU2VudDogV2VkbmVzZGF5LCBGZWJydWFyeSA3LCAyMDI0IDY6MTEg
UE0NCj4gVG86IHJhZmFlbC5qLnd5c29ja2lAaW50ZWwuY29tOyBMaW1vbmNpZWxsbywgTWFyaW8N
Cj4gPE1hcmlvLkxpbW9uY2llbGxvQGFtZC5jb20+OyB2aXJlc2gua3VtYXJAbGluYXJvLm9yZzsg
SHVhbmcsIFJheQ0KPiA8UmF5Lkh1YW5nQGFtZC5jb20+OyBTaGVub3ksIEdhdXRoYW0gUmFuamFs
DQo+IDxnYXV0aGFtLnNoZW5veUBhbWQuY29tPjsgUGV0a292LCBCb3Jpc2xhdg0KPiA8Qm9yaXNs
YXYuUGV0a292QGFtZC5jb20+OyBZdWFuLCBQZXJyeSA8UGVycnkuWXVhbkBhbWQuY29tPg0KPiBD
YzogRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgSHVhbmcs
IFNoaW1tZXINCj4gPFNoaW1tZXIuSHVhbmdAYW1kLmNvbT47IER1LCBYaWFvamlhbiA8WGlhb2pp
YW4uRHVAYW1kLmNvbT47IE1lbmcsDQo+IExpIChKYXNzbWluZSkgPExpLk1lbmdAYW1kLmNvbT47
IGxpbnV4LXBtQHZnZXIua2VybmVsLm9yZzsgbGludXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5v
cmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MyA2LzddIGNwdWZyZXE6IGFtZC1wc3RhdGU6IHJl
bW92ZSBsZWdhY3kgc2V0X2Jvb3N0DQo+IGNhbGxiYWNrIGZvciBwYXNzaXZlIG1vZGUNCj4NCj4g
SGVsbG8uDQo+DQo+IE9uIHN0xZllZGEgNy4gw7pub3JhIDIwMjQgMTA6MjE6NTcgQ0VUIFBlcnJ5
IFl1YW4gd3JvdGU6DQo+ID4gV2l0aCBuZXcgZnJlcWVuY3kgYm9vc3QgaW50ZXJmYWNlIHN1cHBv
cnRlZCwgbGVnYWN5IGJvb3N0IGNvbnRyb2wNCj4gPiBkb2Vzbid0IG1ha2Ugc2Vuc2UgYW55IG1v
cmUgd2hpY2ggb25seSBzdXBwb3J0IHBhc3NpdmUgbW9kZS4NCj4gPiBzbyBpdCBjYW4gcmVtb3Zl
IHRoZSBsZWdhY3kgc2V0X2Jvb3N0IGludGVyZmFjZSBmcm9tIGFtZC1wc3RhdGUgZHJpdmVyDQo+
ID4gaW4gY2FzZSBvZiB0aGVyZSBpcyBjb25mbGljdCB3aXRoIG5ldyBib29zdCBjb250cm9sIGxv
Z2ljLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogUGVycnkgWXVhbiA8cGVycnkueXVhbkBhbWQu
Y29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL2NwdWZyZXEvYW1kLXBzdGF0ZS5jIHwgMSAtDQo+
ID4gIGluY2x1ZGUvbGludXgvYW1kLXBzdGF0ZS5oICAgfCAxIC0NCj4gPiAgMiBmaWxlcyBjaGFu
Z2VkLCAyIGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvY3B1ZnJl
cS9hbWQtcHN0YXRlLmMNCj4gPiBiL2RyaXZlcnMvY3B1ZnJlcS9hbWQtcHN0YXRlLmMgaW5kZXgg
MzU3OTFlZmM2ZTg4Li4xZGQ1MjNkYjM4NzENCj4gMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9j
cHVmcmVxL2FtZC1wc3RhdGUuYw0KPiA+ICsrKyBiL2RyaXZlcnMvY3B1ZnJlcS9hbWQtcHN0YXRl
LmMNCj4gPiBAQCAtMTY3NSw3ICsxNjc1LDYgQEAgc3RhdGljIHN0cnVjdCBjcHVmcmVxX2RyaXZl
ciBhbWRfcHN0YXRlX2RyaXZlciA9DQo+IHsNCj4gPiAgICAgLmV4aXQgICAgICAgICAgID0gYW1k
X3BzdGF0ZV9jcHVfZXhpdCwNCj4gPiAgICAgLnN1c3BlbmQgICAgICAgID0gYW1kX3BzdGF0ZV9j
cHVfc3VzcGVuZCwNCj4gPiAgICAgLnJlc3VtZSAgICAgICAgID0gYW1kX3BzdGF0ZV9jcHVfcmVz
dW1lLA0KPiA+IC0gICAuc2V0X2Jvb3N0ICAgICAgPSBhbWRfcHN0YXRlX3NldF9ib29zdCwNCj4g
PiAgICAgLnVwZGF0ZV9saW1pdHMgID0gYW1kX3BzdGF0ZV91cGRhdGVfbGltaXRzLA0KPiA+ICAg
ICAubmFtZSAgICAgICAgICAgPSAiYW1kLXBzdGF0ZSIsDQo+ID4gICAgIC5hdHRyICAgICAgICAg
ICA9IGFtZF9wc3RhdGVfYXR0ciwNCj4gPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9hbWQt
cHN0YXRlLmggYi9pbmNsdWRlL2xpbnV4L2FtZC1wc3RhdGUuaA0KPiA+IGluZGV4IDQ2NWU5Mjk1
YTYwYy4uYWI3Y2EyNjk3NGRhIDEwMDY0NA0KPiA+IC0tLSBhL2luY2x1ZGUvbGludXgvYW1kLXBz
dGF0ZS5oDQo+ID4gKysrIGIvaW5jbHVkZS9saW51eC9hbWQtcHN0YXRlLmgNCj4gPiBAQCAtOTMs
NyArOTMsNiBAQCBzdHJ1Y3QgYW1kX2NwdWRhdGEgew0KPiA+ICAgICBzdHJ1Y3QgYW1kX2FwZXJm
X21wZXJmIHByZXY7DQo+ID4NCj4gPiAgICAgdTY0ICAgICBmcmVxOw0KPiA+IC0gICBib29sICAg
IGJvb3N0X3N1cHBvcnRlZDsNCj4NCj4gQXMgYSByZXN1bHQgb2YgdGhpcyByZW1vdmFsIHRoZSBr
ZXJuZWwtZG9jIGZvciB0aGlzIHN0cnVjdCBzaG91bGQgYmUgYW1lbmRlZA0KPiB0b28gYmVjYXVz
ZSBldmVuIGFmdGVyIHRoaXMgcGF0Y2ggaXMgYXBwbGllZCB0aGUgYGJvb3N0X3N1cHBvcnRlZGAg
ZmllbGQNCj4gcmVtYWlucyBkb2N1bWVudGVkLg0KDQpUaGUgc2V0X2Jvb3N0IGlzIGNhbGxiYWNr
IHVzZWQgYnkgY3B1ZnJlcS5jLCB0aGUgYm9vc3Rfc3VwcG9ydGVkIGlzIG5vdCBkb2N1bWVudGVk
IGJlZm9yZSB0aGUgcGF0Y2guDQpXZSBqdXN0IG5lZWQgdG8gYWRkIG5ldyBzeXNmcyAiY3BiX2Jv
b3N0IiBpbnRyb2R1Y3Rpb24gaW4gdGhlICIvRG9jdW1lbnRhdGlvbi9hZG1pbi1ndWlkZS9wbS9h
bWQtcHN0YXRlLnJzdCINClRoZSBsZWdhY3kgYm9vc3QgaXMgbm90IHN1cHBvcnRlZCBhbnkgbW9y
ZSwgd2UgaGF2ZSBubyBuZWVkIHRvIGRvY3VtZW50IGl0IGFnYWluIGFzIGl0IGlzLg0KDQpQZXJy
eS4NCg0KPg0KPiA+ICAgICBib29sICAgIGh3X3ByZWZjb3JlOw0KPiA+DQo+ID4gICAgIC8qIEVQ
UCBmZWF0dXJlIHJlbGF0ZWQgYXR0cmlidXRlcyovDQo+ID4NCj4NCj4NCj4gLS0NCj4gT2xla3Nh
bmRyIE5hdGFsZW5rbyAocG9zdC1mYWN0dW0pDQo=

