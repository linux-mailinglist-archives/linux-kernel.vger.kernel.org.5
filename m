Return-Path: <linux-kernel+bounces-161689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B7EE8B4F9C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 04:56:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1350E1F217E9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 02:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D94728C09;
	Mon, 29 Apr 2024 02:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cU9D3Gih"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2051.outbound.protection.outlook.com [40.107.243.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E39C79F6;
	Mon, 29 Apr 2024 02:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714359385; cv=fail; b=J/KPag1TLYaDTxhBPvVkWVuwfcOtjbq7CWx2lC9hxscjGWGnq2lKTZozpxfJl1Dwme+2GPE0Ug83vN3K1nXAdIZWmOhIwelwTGGYTWJf3LTTJYAMPwtVuCBSrT72dS5xBafJkIArzplPBEONuiG2ARcdJnx8mLfOhkQDQdvzYyQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714359385; c=relaxed/simple;
	bh=RUF9J0FtR9wKCMZGDCQykGFloaMMiaVEercBbpGFS0Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=H9H3G3cND+eqXslfisvbhSqQsvcX3126Pojh0FLh0H/ZbgBq3bW0Lms2pFiV2mz5aU52I/n1oQpCHNMHNG47Cx2SHOeg+6xXY18OjbXuoN69y2IltlAl0NXnoV4QO66Hn7cRd3IPJtqjEiFa65/T6RcossbQWRZAgDvBVLOQQJs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cU9D3Gih; arc=fail smtp.client-ip=40.107.243.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FpZSAdtE5FCDFiuqBlV7hnXKrXuHHBtPvlfUDd6T/GKYqwzH1RRtZaDH5//CFZTBSBIRaJ/ltstPnPY6XvhGgFn/244UmF82dvGOA8q72U6SGrY9TIxzsNts1Aut3S5KSORUdk5xxBl+ZSj/VOUcc/xRaaYiCLzEDzZAI4+XDdmPQEV8RRXoLyTTEAsmx2gxwfQT8+NEU6iK1yU45FIP6gGqEDS3Ioz3/zYgL6wofNtX6ipVLPQReYWmuSESbj8I3+9Wi/MT21vnYd5y9q4iWZBYQJxbkYHvkElCfz7UUDphY02HpfnwjewBQJoUNJyWpcmOGwkoIUF5mpsTJV/v0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RUF9J0FtR9wKCMZGDCQykGFloaMMiaVEercBbpGFS0Y=;
 b=F3lRRAn4QrPC/mrxEyE+DTWtOoiTHr3laJZ6HsjCDwaSjRv4ti8PPa6Emskl2taqLLpBAD05Kmbk00ta6AWcRZQmYIqH5rGUv4ZzFnv0YqCJMpzzhhE/UAotVWnR7pJs5gzs4HaG1dRHlxASt8ip1xO5p3HMD2Hv9ZuhJW0JEn40FBW777jaRArRs3l2S97u0HH6KvXaBbJ6SZLWXhNFRtjER6V0Xhq3Bw6oJHwbhX1uTwYb/YNoJEujRfwD3b0ihKwrcjJzre2xDyjjR05Q5fqE3bOJgyfMheE/iG01AwhqbdhDbVWJxbGWYDqNA2U8vgKtlgpwT6B6hAWzzErQ8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RUF9J0FtR9wKCMZGDCQykGFloaMMiaVEercBbpGFS0Y=;
 b=cU9D3GihE/tUFP8NkwSXNhBpMvgxgb7L/GLH2clLduhfaNX8pIKTwfRces32TTm9HzXdtbGIBbVFeqgHuwisPoB3X7zG7Uh9uusgB6qpFIvNjPOKgVEdmZiVAMO60ETqfU4ZQUG22ANreOkA7Z+0v42GG6xTt1lyv038gA3z5Eo=
Received: from CYYPR12MB8655.namprd12.prod.outlook.com (2603:10b6:930:c4::19)
 by IA0PR12MB8256.namprd12.prod.outlook.com (2603:10b6:208:407::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.31; Mon, 29 Apr
 2024 02:56:19 +0000
Received: from CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::7fa2:65b3:1c73:cdbf]) by CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::7fa2:65b3:1c73:cdbf%5]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 02:56:19 +0000
From: "Yuan, Perry" <Perry.Yuan@amd.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>, "Limonciello,
 Mario" <Mario.Limonciello@amd.com>, "viresh.kumar@linaro.org"
	<viresh.kumar@linaro.org>, "Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>,
	"Petkov, Borislav" <Borislav.Petkov@amd.com>, "Huang, Ray"
	<Ray.Huang@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>,
	"Huang, Shimmer" <Shimmer.Huang@amd.com>, "oleksandr@natalenko.name"
	<oleksandr@natalenko.name>, "Du, Xiaojian" <Xiaojian.Du@amd.com>, "Meng, Li
 (Jassmine)" <Li.Meng@amd.com>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v12 0/8] AMD Pstate Fixes And Enhancements
Thread-Topic: [PATCH v12 0/8] AMD Pstate Fixes And Enhancements
Thread-Index: AQHalueqlgIrGwqnykytG5fQgrNCibF60yIAgAO/P9A=
Date: Mon, 29 Apr 2024 02:56:19 +0000
Message-ID:
 <CYYPR12MB8655B901D5176249F0C67FF99C1B2@CYYPR12MB8655.namprd12.prod.outlook.com>
References: <cover.1714032153.git.perry.yuan@amd.com>
 <CAJZ5v0iF_NUAMhTCaakUi_F+2CrRgiQMXmrVm00+W7vd+H=wjw@mail.gmail.com>
In-Reply-To:
 <CAJZ5v0iF_NUAMhTCaakUi_F+2CrRgiQMXmrVm00+W7vd+H=wjw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=aedfbcc8-9053-41b2-a1c3-9c0f80d3fd46;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-04-29T02:51:12Z;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR12MB8655:EE_|IA0PR12MB8256:EE_
x-ms-office365-filtering-correlation-id: bb45f25b-79b5-4b78-3b76-08dc67f7f1f8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?cU9KU3NuS2ZlcmlIbnN5NEtXWXdJbnhNRm9Xa1RuZGJjcXVSSEI4VTNtQlhk?=
 =?utf-8?B?djdONUtidTBVWTZ0TVlsTVNtYm1rVXJQUXJ5eFJFdFJHNTNyTk9mdGdkVGJm?=
 =?utf-8?B?R2NUN3p6MkFiekN0dVBwaksrUVBUNlNFUk9ZWUs0bTdhdDR2eFF3dlkwMGZx?=
 =?utf-8?B?Wm9QSGN0bWo0UStvRkxsYlIzaitubk9Od21sYXpVTnNDZTBnNmg5RUVjOHlh?=
 =?utf-8?B?cXVJWkg3Q3VNcWNBZFcxVXlOUmVBMnZUclNGWjB1bDlBOWtUZG5WTDBtZTda?=
 =?utf-8?B?SEdYVFRCT3NERmJZQ2JIenpSN3JQbHZLV05kMDNPdndqOW9wY210Y2sySE5J?=
 =?utf-8?B?YzQ5UGZqcG44N0sybEd1WWw4VHBsMDdKVHoyZVpFSlJSb1hrcXMxSWRhUGs2?=
 =?utf-8?B?NkRxaUo1QVdOMkJRc2h5Tnh1L1FoUk1YQzdJaEdLNVJDS2FXVXk1U0VqYm03?=
 =?utf-8?B?VmwrVWFOZkpOT0ROZU11RnA1UjNIcU5neVpoUlBCUWs2QkVUeWhWNG43RjF0?=
 =?utf-8?B?QmxacnByaEtGUlNPa04wUUI4T0RXTnJXV3VjMWxOVWZpVmFZYU1nUEljdjg2?=
 =?utf-8?B?OEw3QnM1L0lHeDRNOVN4MlVEMjErMUNzQ1VPUTNsWXZWTmhZQ0g2UjkweUM4?=
 =?utf-8?B?MUtSYnVpUklNbm4yU24yTFFnbVBNb3JqZjBSaWpaY0l0Nkt1OE9pOTU4UExl?=
 =?utf-8?B?UmdkN2dWdFl0Z1dMM1pLQS9ZWDJYZ2VmWWxsdTE2NENmN1g4Z1ZwOUhjZDR5?=
 =?utf-8?B?OE94dWRPTkROZVFyL2R2RHZpSlVqbG8xKzBONElyZDQyRVU0Vjl1K2ZXZzg3?=
 =?utf-8?B?SjR2dEdVaWJFS3ZBYjVFOWVvVGpiZlZld2xNZ3MvRDJXcXU4cnMyMnQ3UkhT?=
 =?utf-8?B?cXV5aU1wK0w2QllRYVhGRkJvZ0VaZHMyS3Q5U0RxZEhrRG12SStZeFl5dktJ?=
 =?utf-8?B?RU9kOE1QMlA2MTBBM3k5NzhZbUxYS3ZvczY2ay9FdGNDM1NtWVlseWNrY3pp?=
 =?utf-8?B?VXpqai9FQ1RLaDRNSkQ5bzI4Y094bnJaZHRFMUNTTXdrRXJ4ZXZlc0J0MmlU?=
 =?utf-8?B?UjQ2NTBVNEk0L1JiM2laeHhkMWZEYVIwcDEzL1k0bmd0V2ZBWHpqWFB3SU5H?=
 =?utf-8?B?YzhMaVVsSWFvbDBiK1krUUZQT2NUTmdzL1N2Qkk5VEV4Qm1HcU1rV1VBM2lp?=
 =?utf-8?B?czdMZTZXZ1JHbmZpS2FZUGNTQ2xhalMydFpzanRhelhoeXpWb0pxS2phd05w?=
 =?utf-8?B?dWI3ditXaVlSSkkwZHdsMVVwL3ExL3dvRDFyRG9GWW4yTVlUeHZPSFR1MHc4?=
 =?utf-8?B?cFJlVmRINmttcVdVanlvdjlhUkV3cXhjd0t5MVFibzNtMkFsU2M4bXFiOStl?=
 =?utf-8?B?VHd5MDQyZ2tSOXZuaXN2RjFxdjZJOFhPa1hEL2phekRKQlNZdmVUS3pDRTV2?=
 =?utf-8?B?Qi92bklTdndDaG9wRVdvNzBpd0lDZlVsbVFVUEdWaTRtaXhwZUlYS0Zac2d0?=
 =?utf-8?B?ZHd5MlQ4SGpFZFVKREhadXJBUkJOTHlGanlUTkd5RXYxQy94REpGN1l4K0Y4?=
 =?utf-8?B?aDlBb1dNNzhsL25XSElncE5JTlB4OW82ZGd0cE1mM1NtOEJ6WFg2MWo3eDBj?=
 =?utf-8?B?R0FYOVJtRkxyVHRpbUtPSnVlM0FvckVWSW4vVlhDUHF2MjQxdGN2K291ZmJ4?=
 =?utf-8?B?dnhTbnNBZUd0bWNYa3F0VnhGZmxUNklkZ2RxMU42c092V0ZGenVubjIraGwz?=
 =?utf-8?Q?Xi9eOuWHvny2cB9NWk=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8655.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cjBvVFliOWdORzBqdGltZDFpZnRkQ3JqRlBKcVR3cDlSZG9sTHVuR2tSVjdk?=
 =?utf-8?B?cFpXM0dQU2FtUkZET1hlQ3hZUG5IdTNua2ROeFIyS1RiUGlUM0FDTDNxeitB?=
 =?utf-8?B?Zkc1RTJyWHEwQ3A5TlBob3lFMUxhYStPU0h4VG55bDk1NEprR1BhbThDZzl4?=
 =?utf-8?B?QmlpOWZwWjZQUEM4U3YzREFuYW54M2pkaHpxVEFERmR5a1pDRUFKTWdsWkIr?=
 =?utf-8?B?TTdhZW9VdTJ0QkZWQUZTOW5SL0gzNXY3cWwvSU5RZkpwRkxDMEdTU0dHZUQ3?=
 =?utf-8?B?RXErUnl0V2VnN2Rza3hZT0I0czlac2xCRnZmL0NQcS9oR1VEL2dSOHpTV0lY?=
 =?utf-8?B?dnE4N3ZBWTNZQU1DcjBFSjk3djVuelJtT05YdUJwK0h2VFlFZXViYjJHSDNG?=
 =?utf-8?B?blhRc05ZQkR1dEJCNjNPd0JvS3hNZTdTRE5lWlk0ekF3ZE5sbUxBdm8xaDhE?=
 =?utf-8?B?UWN1MEdYWG5pM2x1MXR1TFc3RDZFQlY1QUY1a1h0UHYzWEx6d1A5MC9Ya3RQ?=
 =?utf-8?B?TzhRVE5vMTIvTU9TV2dSWHN6dlcwUndRQUpZTmJaMTdhZlFkWnJBU1dnaUhw?=
 =?utf-8?B?czBWdlYxekh2NkdqQ0UzRDl2L0hKUlIxUHlxOGhNTU9wTlBlUGdNbDRrM1lN?=
 =?utf-8?B?Y2t3OHV1TVRraExSL2toaVQvWFVPM2dBUHh4b0dvQ3JSakdMUC9sN3l6WHpj?=
 =?utf-8?B?YWdUNExOYStzSGRTK090YTF6OUZrSnlVVmF2cEhMcFk0RDFyZkJaTXdpZ0NV?=
 =?utf-8?B?aURiSmtiZml6Y0tlaTBqcmdKeE90MmlVcll1K2QzYk41aFVzK0E4emxLZzNY?=
 =?utf-8?B?bStlZHFuWHkva3lxMjBYcGJBSldKdHM4Yy9UTXVEUkhuWnFoSWJ1Q3lYTnhF?=
 =?utf-8?B?QmR2b3dKV2NpWjZBdDRTMGVKKy9TbU15cmR1NWJPR252ZG5XcitFNTlsbG1m?=
 =?utf-8?B?dUNBdXlVa3RkaEJrcVJqUVdCdldYMFRLVnhIOUNieWlrSHJvbWZpVmZqYVZ3?=
 =?utf-8?B?eDFOdC9GbUprSjhXakdRVmVNSTZvdVB3T2FQejRUeHVEdjJvMnA0MGJ2dGtu?=
 =?utf-8?B?a0x0bmI2TTlocW9VbzVrdkp5U25YalQ4Uk9IazcydVFERVBMWEFYTVNEeU0v?=
 =?utf-8?B?YzdzUHVhSUw2bWl6aUFkMjFhZ0pnMWNFVWZSQk1DOU5WZWFsRTBRRHkwSFEw?=
 =?utf-8?B?b2ZOb2c4RTg1WGlMUkgvWVlOS3Q4d3habHZXRXhhRHFrOVd5VTQyQTFvdFV2?=
 =?utf-8?B?d00zQlZqWThmYTVXUkdBY1d3dTUweERuSm5IMnlIcUhOMWZCWGovVFpSR1No?=
 =?utf-8?B?dUF5dStpd1Mwc3FvMTNNZFNvR3A1cEcvTmlMUjVHZHpyaVg5NExhSTBnOVc4?=
 =?utf-8?B?ZTJsNjFlQkpNdTQrVGtQcm1yWU1uY1A5bjcyNHErWVFFQ1dXdCtsZ3VUeERv?=
 =?utf-8?B?d2x4am14d0N5THpFMFdSNzFSVjBsbDlEalFRdmFWSDBjd1ZadzIwZ0dQeWdN?=
 =?utf-8?B?K1RXWG5wQTFic2NDRktMUFlnaG4xUEMzUEN5S1N4VCt6NkxraU9oR2FtbVpn?=
 =?utf-8?B?alRZOEJ0RmUwbkJCdXZqT2Z6UkY0Y2JsRE5yem12cVNNcmw2K3hkRjBWQkZp?=
 =?utf-8?B?TFNmUDBqSnlHSFNkcHBTUHpNNzRVaVhmcWdFYXp4NUR6UDQvRndSSjRLNCty?=
 =?utf-8?B?dGxzbGw5Q2cvTFNYNFBnNWRrYTlYTzVTVkxEQnpkZHdKVUNQb0NFbVEwSE56?=
 =?utf-8?B?SmtZc0Y2RXdiMG8xbmc0QVc5Z0k0RUVSTjkyTlc3ZnNuRDBOa1RWWmVwbVU0?=
 =?utf-8?B?SzdHZjhsYW8xb2JEb2lFV09SMG1lNng5M2dnRVgvRDh2L3RjQXNOdFE0VlJK?=
 =?utf-8?B?SjRIaTUyVlFlZ2NjVDZHb25yb0pZNnlyWDF6MkhLRUZVWEpvbVlqbWN4dFZn?=
 =?utf-8?B?My91Y1NMK0RINERuZHduWnFmTEhPTFRyT1NSOStqVHNqQ1h0V3VDS3I1Mkli?=
 =?utf-8?B?cTRBbk5kUnZZcGxPUGE4cElmZGlRZGxBclNMZGJJZFZBczlpR1NEL2I5K05j?=
 =?utf-8?B?NlYzMGRsYjI0OURQc1pueXJjNlE1WE44VjhVZ1VYZGcrclpXYURiQXN0NnBz?=
 =?utf-8?Q?sLqM=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: bb45f25b-79b5-4b78-3b76-08dc67f7f1f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2024 02:56:19.3873
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tnPl+wJl1pNS3agudPISVQeQvFXzcgy3e2IGfIb8ZTtJ6DAP2CBcklKVQBDQvp9QCcqdapoTa4viRJEwIHTHpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8256

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCkhpIFJhZmFlbCwNCg0KDQo+IC0t
LS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFJhZmFlbCBKLiBXeXNvY2tpIDxyYWZh
ZWxAa2VybmVsLm9yZz4NCj4gU2VudDogU2F0dXJkYXksIEFwcmlsIDI3LCAyMDI0IDE6MzggQU0N
Cj4gVG86IFl1YW4sIFBlcnJ5IDxQZXJyeS5ZdWFuQGFtZC5jb20+DQo+IENjOiByYWZhZWwuai53
eXNvY2tpQGludGVsLmNvbTsgTGltb25jaWVsbG8sIE1hcmlvDQo+IDxNYXJpby5MaW1vbmNpZWxs
b0BhbWQuY29tPjsgdmlyZXNoLmt1bWFyQGxpbmFyby5vcmc7IFNoZW5veSwgR2F1dGhhbQ0KPiBS
YW5qYWwgPGdhdXRoYW0uc2hlbm95QGFtZC5jb20+OyBQZXRrb3YsIEJvcmlzbGF2DQo+IDxCb3Jp
c2xhdi5QZXRrb3ZAYW1kLmNvbT47IEh1YW5nLCBSYXkgPFJheS5IdWFuZ0BhbWQuY29tPjsgRGV1
Y2hlciwNCj4gQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgSHVhbmcsIFNo
aW1tZXINCj4gPFNoaW1tZXIuSHVhbmdAYW1kLmNvbT47IG9sZWtzYW5kckBuYXRhbGVua28ubmFt
ZTsgRHUsIFhpYW9qaWFuDQo+IDxYaWFvamlhbi5EdUBhbWQuY29tPjsgTWVuZywgTGkgKEphc3Nt
aW5lKSA8TGkuTWVuZ0BhbWQuY29tPjsgbGludXgtDQo+IHBtQHZnZXIua2VybmVsLm9yZzsgbGlu
dXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYxMiAwLzhd
IEFNRCBQc3RhdGUgRml4ZXMgQW5kIEVuaGFuY2VtZW50cw0KPg0KPiBPbiBUaHUsIEFwciAyNSwg
MjAyNCBhdCAxMDowOOKAr0FNIFBlcnJ5IFl1YW4gPHBlcnJ5Lnl1YW5AYW1kLmNvbT4NCj4gd3Jv
dGU6DQo+ID4NCj4gPiBUaGUgcGF0Y2ggc2VyaWVzIGFkZHMgc29tZSBmaXhlcyBhbmQgZW5oYW5j
ZW1lbnRzIHRvIHRoZSBBTUQgcHN0YXRlDQo+ID4gZHJpdmVyLg0KPiA+DQo+ID4gSXQgZW5hYmxl
cyBDUFBDIHYyIGZvciBjZXJ0YWluIHByb2Nlc3NvcnMgaW4gdGhlIGZhbWlseSAxN0gsIGFzDQo+
ID4gcmVxdWVzdGVkIGJ5IFRSNDAgcHJvY2Vzc29yIHVzZXJzIHdobyBleHBlY3QgaW1wcm92ZWQg
cGVyZm9ybWFuY2UgYW5kDQo+ID4gbG93ZXIgc3lzdGVtIHRlbXBlcmF0dXJlLg0KPiA+DQo+ID4g
Y2hhbmdlcyBsYXRlbmN5IGFuZCBkZWxheSB2YWx1ZXMgdG8gYmUgcmVhZCBmcm9tIHBsYXRmb3Jt
IGZpcm13YXJlDQo+ID4gZmlyc3RseSBmb3IgbW9yZSBhY2N1cmF0ZSB0aW1pbmcuDQo+ID4NCj4g
PiBBIG5ldyBxdWlyayBpcyBpbnRyb2R1Y2VkIGZvciBzdXBwb3J0aW5nIGFtZC1wc3RhdGUgb24g
bGVnYWN5DQo+ID4gcHJvY2Vzc29ycyB3aGljaCBlaXRoZXIgbGFjayBDUFBDIGNhcGFiaWxpdHks
IG9yIG9ubHkgb25seSBoYXZlIENQUEMNCj4gPiB2MiBjYXBhYmlsaXR5DQo+ID4NCj4gPiBUZXN0
aW5nIGRvbmUgd2l0aCBvbmUgQVBVIHN5c3RlbSB3aGlsZSBjcGIgYm9vc3Qgb246DQo+ID4NCj4g
PiBhbWRfcHN0YXRlX2xvd2VzdF9ub25saW5lYXJfZnJlcToxNzAxMDAwDQo+ID4gYW1kX3BzdGF0
ZV9tYXhfZnJlcTozNTAxMDAwDQo+ID4gY3B1aW5mb19tYXhfZnJlcTozNTAxMDAwDQo+ID4gY3B1
aW5mb19taW5fZnJlcTo0MDAwMDANCj4gPiBzY2FsaW5nX2N1cl9mcmVxOjMwODQ4MzYNCj4gPiBz
Y2FsaW5nX21heF9mcmVxOjM1MDEwMDANCj4gPiBzY2FsaW5nX21pbl9mcmVxOjQwMDAwMA0KPiA+
DQo+ID4gYW5hbHl6aW5nIENQVSA2Og0KPiA+ICAgZHJpdmVyOiBhbWQtcHN0YXRlLWVwcA0KPiA+
ICAgQ1BVcyB3aGljaCBydW4gYXQgdGhlIHNhbWUgaGFyZHdhcmUgZnJlcXVlbmN5OiA2DQo+ID4g
ICBDUFVzIHdoaWNoIG5lZWQgdG8gaGF2ZSB0aGVpciBmcmVxdWVuY3kgY29vcmRpbmF0ZWQgYnkg
c29mdHdhcmU6IDYNCj4gPiAgIG1heGltdW0gdHJhbnNpdGlvbiBsYXRlbmN5OiAgQ2Fubm90IGRl
dGVybWluZSBvciBpcyBub3Qgc3VwcG9ydGVkLg0KPiA+ICAgaGFyZHdhcmUgbGltaXRzOiA0MDAg
TUh6IC0gMy41MCBHSHoNCj4gPiAgIGF2YWlsYWJsZSBjcHVmcmVxIGdvdmVybm9yczogcGVyZm9y
bWFuY2UgcG93ZXJzYXZlDQo+ID4gICBjdXJyZW50IHBvbGljeTogZnJlcXVlbmN5IHNob3VsZCBi
ZSB3aXRoaW4gNDAwIE1IeiBhbmQgMy41MCBHSHouDQo+ID4gICAgICAgICAgICAgICAgICAgVGhl
IGdvdmVybm9yICJwb3dlcnNhdmUiIG1heSBkZWNpZGUgd2hpY2ggc3BlZWQgdG8gdXNlDQo+ID4g
ICAgICAgICAgICAgICAgICAgd2l0aGluIHRoaXMgcmFuZ2UuDQo+ID4gICBjdXJyZW50IENQVSBm
cmVxdWVuY3k6IFVuYWJsZSB0byBjYWxsIGhhcmR3YXJlDQo+ID4gICBjdXJyZW50IENQVSBmcmVx
dWVuY3k6IDMuNTAgR0h6IChhc3NlcnRlZCBieSBjYWxsIHRvIGtlcm5lbCkNCj4gPiAgIGJvb3N0
IHN0YXRlIHN1cHBvcnQ6DQo+ID4gICAgIFN1cHBvcnRlZDogeWVzDQo+ID4gICAgIEFjdGl2ZTog
eWVzDQo+ID4gICAgIEFNRCBQU1RBVEUgSGlnaGVzdCBQZXJmb3JtYW5jZTogMjU1LiBNYXhpbXVt
IEZyZXF1ZW5jeTogMy41MCBHSHouDQo+ID4gICAgIEFNRCBQU1RBVEUgTm9taW5hbCBQZXJmb3Jt
YW5jZTogMjA0LiBOb21pbmFsIEZyZXF1ZW5jeTogMi44MCBHSHouDQo+ID4gICAgIEFNRCBQU1RB
VEUgTG93ZXN0IE5vbi1saW5lYXIgUGVyZm9ybWFuY2U6IDEyNC4gTG93ZXN0IE5vbi1saW5lYXIN
Cj4gRnJlcXVlbmN5OiAxLjcwIEdIei4NCj4gPiAgICAgQU1EIFBTVEFURSBMb3dlc3QgUGVyZm9y
bWFuY2U6IDMwLiBMb3dlc3QgRnJlcXVlbmN5OiA0MDAgTUh6Lg0KPiA+DQo+ID4NCj4gPiBJIHdv
dWxkIGdyZWF0bHkgYXBwcmVjaWF0ZSBhbnkgZmVlZGJhY2tzLg0KPiA+IFRoYW5rIHlvdSENCj4g
PiBQZXJyeS4NCj4gPg0KPiA+IENoYW5nZXMgZnJvbSB2MTE6DQo+ID4gICogbWlubW9yIGNoYW5n
ZSBmb3IgcGF0Y2ggMSAicGVyZiIgY2hhbmdlIHRvICJwZXJmb3JtYW5jZSIoSHVhbmcgcmF5KQ0K
PiA+ICAqIHJlYmFzZWQgdG8gbGFzdGVzdCBsaW51eC1wbS9ibGVlZGluZy1lZGdlIGJyYW5jaA0K
PiA+DQo+ID4gQ2hhbmdlcyBmcm9tIHYxMDoNCj4gPiAgKiBwaWNrIGFjay1ieSBmbGFncyBmcm9t
IGh1YW5nIHJheSBmb3IgYWxsIHBhdGNoZXMuDQo+ID4gICogcnVuIHRlc3Rpbmcgb24gQU1EIFJ5
emVuIDUgNzY0MFUgd2l0aG91dCByZWdyZXNzaW9uIGlzc3VlLg0KPiA+DQo+ID4gQ2hhbmdlcyBm
cm9tIHY5Og0KPiA+ICAqIHBpY2sgcmV2aWV3IGJ5IGZsYWcgZnJvbSBNZW5nIExpDQo+ID4gICog
cGljayB0ZXN0IGJ5IGZsYWcgZnJvbSBVZ3dla2FyIERoYW5hbmpheQ0KPiA+ICAqIHBpY2wgcmV2
aWV3IGJ5IGZsYWcgZnJvbSBHYXV0aGFtIFIuIFNoZW5veQ0KPiA+DQo+ID4gQ2hhbmdlcyBmcm9t
IHY4Og0KPiA+ICAqIGFkZCBjb21taXQgbG9nIGZvciBwYXRjaCAxIGFuZCBwYXRjaCAyIChSYWZh
ZWwpDQo+ID4gICogYWRkIG1pc3NpbmcgUGVycnkgc2lnbmVkLW9mZi1ieSBmb3IgbmV3IHBhdGNo
ZXMgIzEsIzIsIzQgKFJhZmFlbCkNCj4gPiAgKiByZWJhc2VkIHRvIGxhdGVzdCBsaW51eC1wbS9i
bGVlZGluZy1lZGdlDQo+ID4NCj4gPiBDaGFuZ2VzIGZyb20gdjc6DQo+ID4gICogR2F1dGhhbSBo
ZWxwZWQgdG8gaW52b2xlIHNvbWUgbmV3IGltcHJvdmVkIHBhdGNoZXMgaW50byB0aGUgcGF0Y2hz
ZXQuDQo+ID4gICogQWRkcyBjb21tZW50cyBmb3IgY3B1ZGF0YS0+e21pbixtYXh9X2xpbWl0X3tw
ZXJmLGZyZXF9LCB2YXJpYWJsZXMgW05ldw0KPiBQYXRjaF0uDQo+ID4gICogQ2xhcmlmaWVzIHRo
YXQgdGhlIHVuaXRzIGZvciBjcHVkYXRhLT4qX2ZyZXEgaXMgaW4ga2h6IHZpYSBjb21tZW50cyBb
TmV3DQo+IFBhdGNoXS4NCj4gPiAgKiBJbXBsZW1lbnRzIHRoZSB1bmlmaWVkIGNvbXB1dGF0aW9u
IG9mIGFsbCBjcHVkYXRhLT4qX2ZyZXENCj4gPiAgKiB2NyBQYXRjaCAyLzYgd2FzIGRyb3BwZWQg
d2hpY2ggaXMgbm90IG5lZWRlZCBhbnkgbW9yZQ0KPiA+ICAqIG1vdmVkIHRoZSBxdWlyayBjaGVj
ayB0byB0aGUgYW1kX3BzdGF0ZV9nZXRfZnJlcSgpIGZ1bmN0aW9uDQo+ID4gICogcGljayB1cCBS
QiBmbGFncyBmcm9tIEdhdXRoYW0NCj4gPiAgKiBBZnRlciB0aGUgY2xlYW51cCBpbiBwYXRjaCAz
LCB3ZSBkb24ndCBuZWVkIHRoZSBoZWxwZXJzDQo+ID4gICAgYW1kX2dldF97bWluLG1heCxub21p
bmFsLGxvd2VzdF9ub25saW5lYXJ9X2ZyZXEoKS4gVGhpcw0KPiA+ICAgIHBhdGNoIHJlbW92ZXMg
aXQgW05ldyBQYXRjaF0uDQo+ID4gICogdGVzdGluZyBkb25lIG9uIEFQVSBzeXN0ZW0gYXMgd2Vs
bCwgbm8gcmVncmVzc2lvbiBmb3VuZC4NCj4gPg0KPiA+IENoYW5nZXMgZnJvbSB2NjoNCj4gPiAg
KiBhZGQgb25lIG5ldyBwYXRjaCB0byBpbml0aWFsaXplIGNhcGFiaWxpdGllcyBpbg0KPiA+ICAg
IGFtZF9wc3RhdGVfaW5pdF9wZXJmIHdoaWNoIGNhbiBhdm9pZCBkdXBsaWNhdGUgY3BwYyBjYXBh
YmlsaXRpZXMgcmVhZA0KPiA+ICAgIHRoZSBjaGFuZ2UgaGFzIGJlZW4gdGVzdGVkIG9uIEFQVSBz
eXN0ZW0uDQo+ID4gICogcGljayB1cCBSQiBmbGFncyBmcm9tIEdhdXRoYW0NCj4gPiAgKiBkcm9w
IHRoZSBwYXRjaCAxLzYgd2hpY2ggaGFzIGJlZW4gbWVyZ2VkIGJ5IFJhZmFlbA0KPiA+DQo+ID4g
Q2hhbmdlcyBmcm9tIHY1Og0KPiA+ICAqIHJlYmFzZWQgdG8gbGludXgtcG0gdjYuOA0KPiA+ICAq
IHBpY2sgdXAgUkIgZmxhZyBmcm9tIGZvciBwYXRjaCA2KE1hcmlvKQ0KPiA+DQo+ID4gQ2hhbmdl
cyBmcm9tIHY0Og0KPiA+ICAqIGltcHJvdmUgdGhlIGRtaSBtYXRjaGluZyBydWxlIHdpdGggemVu
MiBmbGFnIG9ubHkNCj4gPg0KPiA+IENoYW5nZXMgZnJvbSB2MzoNCj4gPiAgKiBjaGFuZ2UgcXVp
cmsgbWF0Y2hpbmcgYnJva2VuIEJJT1Mgd2l0aCBmYW1pbHkvbW9kZWwgSUQgYW5kIFplbjINCj4g
PiAgICBmbGFnIHRvIGZpeCB0aGUgQ1BQQyBkZWZpbml0aW9uIGlzc3VlDQo+ID4gICogZml4IHR5
cG8gaW4gcXVpcmsNCj4gPg0KPiA+IENoYW5nZXMgZnJvbSB2MjoNCj4gPiAgKiBjaGFuZ2UgcXVp
cmsgbWF0Y2hpbmcgdG8gQklPUyB2ZXJzaW9uIGFuZCByZWxlYXNlIChNYXJpbykNCj4gPiAgKiBw
aWNrIHVwIFJCIGZsYWcgZnJvbSBNYXJpbw0KPiA+DQo+ID4gQ2hhbmdlcyBmcm9tIHYxOg0KPiA+
ICAqIHBpY2sgdXAgdGhlIFJCIGZsYWdzIGZyb20gTWFyaW8NCj4gPiAgKiBhZGRyZXNzIHJldmll
dyBjb21tZW50IG9mIHBhdGNoICM2IGZvciBhbWRfZ2V0X25vbWluYWxfZnJlcSgpDQo+ID4gICog
cmViYXNlZCB0aGUgc2VyaWVzIHRvIGxpbnV4LXBtL2JsZWVkaW5nLWVkZ2UgdjYuOC4wLXJjMg0K
PiA+ICAqIHVwZGF0ZSBkZWJ1ZyBsb2cgZm9yIHBhdGNoICM1IGFzIE1hcmlvIHN1Z2dlc3RlZC4N
Cj4gPiAgKiBmaXggc29tZSB0eXBvcyBhbmQgZm9ybWF0IHByb2JsZW1zDQo+ID4gICogdGVzdGVk
IG9uIDc5NTBYIHBsYXRmb3JtDQo+ID4NCj4gPg0KPiA+IFYxOg0KPiA+IGh0dHBzOi8vbG9yZS5r
ZXJuZWwub3JnL2xrbWwvNjNjMmIzZDctMDgzYS00ZGFhLWJhNDAtDQo+IDYyOWIzMjIzYTkyZEBt
YWlsDQo+ID4gYm94Lm9yZy8NCj4gPiBWMjoNCj4gPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9h
bGwvY292ZXIuMTcwNjg2Mzk4MS5naXQucGVycnkueXVhbkBhbWQuY29tLw0KPiA+IHYzOg0KPiA+
IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvY292ZXIuMTcwNzAxNjkyNy5naXQucGVycnku
eXVhbkBhbWQuY29tLw0KPiA+IHY0Og0KPiA+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwv
Y292ZXIuMTcwNzE5MzU2Ni5naXQucGVycnkueXVhbkBhbWQuY29tLw0KPiA+IHY1Og0KPiA+IGh0
dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvY292ZXIuMTcwNzI3MzUyNi5naXQucGVycnkueXVh
bkBhbWQuY29tLw0KPiA+IHY2Og0KPiA+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvY292
ZXIuMTcwNzM2Mzc1OC5naXQucGVycnkueXVhbkBhbWQuY29tLw0KPiA+IHY3Og0KPiA+IGh0dHBz
Oi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvY292ZXIuMTcxMDMyMzQxMC5naXQucGVycnkueXVhbkBh
bWQuY29tLw0KPiA+IHY4Og0KPiA+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvY292ZXIu
MTcxMDc1NDQwOS5naXQucGVycnkueXVhbkBhbWQuY29tLw0KPiA+IHY5Og0KPiA+IGh0dHBzOi8v
bG9yZS5rZXJuZWwub3JnL2xrbWwvY292ZXIuMTcxMDgzNjQwNy5naXQucGVycnkueXVhbkBhbWQu
Y29tLw0KPiA+IHYxMDoNCj4gPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sL2NvdmVyLjE3
MTEzMzU3MTQuZ2l0LnBlcnJ5Lnl1YW5AYW1kLmNvbS8NCj4gPiB2MTE6DQo+ID4gaHR0cHM6Ly9s
b3JlLmtlcm5lbC5vcmcvbGttbC9jb3Zlci4xNzEzODU4ODAwLmdpdC5wZXJyeS55dWFuQGFtZC5j
b20vDQo+ID4NCj4gPg0KPiA+IEdhdXRoYW0gUi4gU2hlbm95ICgzKToNCj4gPiAgIGNwdWZyZXE6
IGFtZC1wc3RhdGU6IERvY3VtZW50ICpfbGltaXRfKiBmaWVsZHMgaW4gc3RydWN0IGFtZF9jcHVk
YXRhDQo+ID4gICBjcHVmcmVxOiBhbWQtcHN0YXRlOiBEb2N1bWVudCB0aGUgdW5pdHMgZm9yIGZy
ZXEgdmFyaWFibGVzIGluDQo+ID4gICAgIGFtZF9jcHVkYXRhDQo+ID4gICBjcHVmcmVxOiBhbWQt
cHN0YXRlOiBSZW1vdmUNCj4gPiAgICAgYW1kX2dldF97bWluLG1heCxub21pbmFsLGxvd2VzdF9u
b25saW5lYXJ9X2ZyZXEoKQ0KPiA+DQo+ID4gUGVycnkgWXVhbiAoNSk6DQo+ID4gICBjcHVmcmVx
OiBhbWQtcHN0YXRlOiBVbmlmeSBjb21wdXRhdGlvbiBvZg0KPiA+ICAgICB7bWF4LG1pbixub21p
bmFsLGxvd2VzdF9ub25saW5lYXJ9X2ZyZXENCj4gPiAgIGNwdWZyZXE6IGFtZC1wc3RhdGU6IEJh
aWwgb3V0IGlmIG1pbi9tYXgvbm9taW5hbF9mcmVxIGlzIDANCj4gPiAgIGNwdWZyZXE6IGFtZC1w
c3RhdGU6IGdldCB0cmFuc2l0aW9uIGRlbGF5IGFuZCBsYXRlbmN5IHZhbHVlIGZyb20gQUNQSQ0K
PiA+ICAgICB0YWJsZXMNCj4gPiAgIGNwcGNfYWNwaTogcHJpbnQgZXJyb3IgbWVzc2FnZSBpZiBD
UFBDIGlzIHVuc3VwcG9ydGVkDQo+ID4gICBjcHVmcmVxOiBhbWQtcHN0YXRlOiBBZGQgcXVpcmsg
Zm9yIHRoZSBwc3RhdGUgQ1BQQyBjYXBhYmlsaXRpZXMNCj4gPiAgICAgbWlzc2luZw0KPiA+DQo+
ID4gIGRyaXZlcnMvYWNwaS9jcHBjX2FjcGkuYyAgICAgfCAgIDQgKy0NCj4gPiAgZHJpdmVycy9j
cHVmcmVxL2FtZC1wc3RhdGUuYyB8IDI1NyArKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0t
LS0tLQ0KPiA+ICBpbmNsdWRlL2xpbnV4L2FtZC1wc3RhdGUuaCAgIHwgIDIwICsrLQ0KPiA+ICAz
IGZpbGVzIGNoYW5nZWQsIDE3NCBpbnNlcnRpb25zKCspLCAxMDcgZGVsZXRpb25zKC0pDQo+ID4N
Cj4gPiAtLQ0KPg0KPiBXaG9sZSBzZXJpZXMgYXBwbGllZCBhcyA2LjEwIG1hdGVyaWFsLCB0aGFu
a3MhDQoNClRoYW5rIHlvdSBzbyBtdWNoIGZvciBtZXJnaW5nIHRoZSBjaGFuZ2VzIQ0KDQpSZWdh
cmRzLg0KUGVycnkNCg==

