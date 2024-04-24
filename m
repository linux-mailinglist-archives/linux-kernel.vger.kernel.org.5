Return-Path: <linux-kernel+bounces-157635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E04078B13E0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 21:59:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E856BB24A76
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 19:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09D8013B5BD;
	Wed, 24 Apr 2024 19:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tlJhmhtx"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2054.outbound.protection.outlook.com [40.107.237.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C861848;
	Wed, 24 Apr 2024 19:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713988774; cv=fail; b=pr5+rBKWeMnpER/k7f+hXWaDYhKuvhp/6vmBWkpwHCVVB3I1DOSTxEwJD2t8gUzmbY0m7cug80fcpIrnL0ltKBnaIkM16Nid5uNCH8+JkGmlBhKdfbD9fMSutQyB7gq3+lA4ikTkO1cGXhm8ZpIHyWySy2yHN8pWkhLTEUDs244=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713988774; c=relaxed/simple;
	bh=T5Pd74YMxkOUe9mrO07o4IJJCoZ3wXkzYuD940S/FK8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=a1k6r4ZVbDruxLDfVjErxRne9GaP57ttWrdJsL3Fzrd+fKWViKKcWZdzpt1xEyJJjZawB+aMg7JayNGPdcc29dQv3DfJ3HbJvw1HoKEwm21oKUyVK1OM3bZpQdfa3DFCMwHgYEf1Vm/SIInpYQz05kasxpOl2j6eOgfXdW4gOOI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tlJhmhtx; arc=fail smtp.client-ip=40.107.237.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wk/8EDFia9PQx1+NNZpadZUlzRckiWkb7GPhhi1lBmJBO7eGS6iLychwJX3DaUPK5aqaQFxzzIkfiEqaVUewxD78qXSTYgq9gvDmD1WTBASawZC77GfDKa4/w/sz8qPhuU4RgiUlTP+fxxt49k5MjYr6JEQ1rXEj/FJsdOBIL0LWV0djjMFeuQA2Dsh699A8kQXsqMRm7lXoXWZClEXyKE1UBo3DDJB5d9uGMgJGazlOoC/J7eClV4o464XFzFf+/7PbQUCK67ERzFm55yr1pue4NTEMBPqLyJQJu4DXqHptMAo2JVBx6tFpK1YkrYMHhi8eRg63QitMc/mJG0bcpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z4S4w9I/wKbSB0+3kPPifeybViJmBy6hRNWIOGafSuI=;
 b=a+hs2kQDXi3vJ8G7vwCQk5eWGh4IB8pucLME+UDmmNUmq2mhbv+VeF8K5Y2kieikn4qwqcLbxPmrBhH/ynWVExKWo0r3T9ZYr+LXJGTibrG8bR9QI4qmFdwEmI6gFtYTAz42J04Ji6rnudSCsBcMmKYlaQGZW5KSU++oxF53elKF/eImLNO4mekNt9k41gV3IIk/LB5CvIqaKZWY5wCf9SvuG/EzUG1VrwWNJPtCjXH8g0rxiAz0g6jHQLHoEnTgNv5cpCM55rVLylZJ3MUA/TOYxyiigLkt3sdmeSZtB2jc1D1sklqRXzboGAX2iUJcNvYeobVIv8v949bX91pnjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z4S4w9I/wKbSB0+3kPPifeybViJmBy6hRNWIOGafSuI=;
 b=tlJhmhtxAY7kOojs7tAbqNTRHEoH9oh9VqHp0dPWi2nWFb2SWtEFB49PtNg6mYdu5j/0JIKwDmKL6rW0QTJs6PPtPKAUnbfZNhZB77EOewRCOdS9sS/YZAfr5/QN2+dSCgc84lcQS7AZ5aX/LciFmKQcXrfSzuPLRzdLoByUf1Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17)
 by PH0PR12MB7930.namprd12.prod.outlook.com (2603:10b6:510:283::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 19:59:23 +0000
Received: from BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::8b3e:57e8:d574:309a]) by BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::8b3e:57e8:d574:309a%4]) with mapi id 15.20.7472.044; Wed, 24 Apr 2024
 19:59:23 +0000
Message-ID: <139b8cab-009c-4688-be41-c4c526532ea1@amd.com>
Date: Wed, 24 Apr 2024 14:59:19 -0500
User-Agent: Mozilla Thunderbird
Subject: [PATCH v4] docs/MAINTAINERS: Update my email address
Content-Language: en-US
To: Jonathan Corbet <corbet@lwn.net>, elena.reshetova@intel.com,
 Akira Yokosawa <akiyks@gmail.com>
Cc: bilbao@vt.edu, "Naik, Avadhut" <Avadhut.Naik@amd.com>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Randy Dunlap <rdunlap@infradead.org>
References: <97731c94-99b0-46be-8b78-5dac8510f690@amd.com>
 <87cyqetwhh.fsf@meer.lwn.net>
From: "Bilbao, Carlos" <carlos.bilbao@amd.com>
In-Reply-To: <87cyqetwhh.fsf@meer.lwn.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR13CA0113.namprd13.prod.outlook.com
 (2603:10b6:806:24::28) To BL1PR12MB5874.namprd12.prod.outlook.com
 (2603:10b6:208:396::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5874:EE_|PH0PR12MB7930:EE_
X-MS-Office365-Filtering-Correlation-Id: e2bcbae0-cb08-4b42-75ff-08dc649908ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TkE4UFZIcmNnSnRFdGpEWGVIN0IrR3VTSG5Ha21lajFEcEUxdldZclBra2Z5?=
 =?utf-8?B?RkJjV0RObTdkdGNmdG91L3NkSEVnVTN0TVNlUjY5c1phYUV5dnBUdmEwem85?=
 =?utf-8?B?TnFqUFFMK2h2TjBHMXFQVGZSK2g0YTltL0laR2s2WU5OdnJNbGhZK1E5b1lS?=
 =?utf-8?B?elRDNTJBUllaWklINUtLc3JjcTZxVWRzRURwdjMyZ3FUdkhJSnlzS0h6cVFY?=
 =?utf-8?B?cVZ0S1VPRGJKWDZWYkR5Wko1NTgydE1FVmtHeHFkS0lNOEVKZ0NEaFFSb080?=
 =?utf-8?B?d3VNbDhOOUNVdUYzVkVGWVV1TEFjaENWaWovMHNRTWJTcFozVzdjSzY3TUNh?=
 =?utf-8?B?VUJCb2hhSFJiekRzQ2tzcURPamE5YWoxbEl1YzFpS2ZLOEFCaURGOU5xSUVs?=
 =?utf-8?B?U2lHUjYvTHd4S2hjN24rWFZabTFyczdIMzBZcDdlazFQMVE5TklxLzRQQjUy?=
 =?utf-8?B?NXJkMDJxcFFRVDJncS9DMEl3YmRuZEdJK0ZiTG00WGlidzFVc1drTnVCeXpV?=
 =?utf-8?B?YUZOdzRqNXJETDBFbkx6OXduYW11NEdXNGRmYSt2ZmxnS0Y1QlN0TnowL3Q5?=
 =?utf-8?B?YmU1YzJjY2F1VkNSVkZ0UzY2TXFoVGxRZ25VbExUcTJBaHVPU1RNYjJPcG9h?=
 =?utf-8?B?Z1gxcFhGaUFtT0VQWHdGNW1idXJiWXFjeWJvR21iZFM0aGdCcW43YVNseWJ2?=
 =?utf-8?B?bkdvR2FYZ1RidWdScmUvRENibndWeE9XVE9KTkpvM2M2ZTVkVzAvTHpyMlhh?=
 =?utf-8?B?K2hpVmlpNlJSU3MzK3FZZGRuZS9DU0VKMVAxbXBtQjdXbTZWS1VwRnhGNk40?=
 =?utf-8?B?dUFJSkhCQkliUG0rZXY3QldhN0p6cTRSV3NCd0hacDBKb2lxbWd5T2ZWYWJ3?=
 =?utf-8?B?RElFT0YvcFRFWWlUUDFLMDM4aSt2TGNHNkxWVUdBT2FHTVVZamlYWUcxclZR?=
 =?utf-8?B?VzR4UEUvb1hwZFlHYi9RNTA0czJ6V1FXVnVCOGg3VFlicmp5bU4xempTbUdD?=
 =?utf-8?B?SEtuWDZBS3lQdDRsZFMrVmdkeStaMVMvc01JQ1o2UHZySENqdFBsQUhBWGsw?=
 =?utf-8?B?SzF2T0NIbmZ3QmlvR1dwRC8xSXJ1VmJtVXIwMDhFNGxDMWt4RXo2bUVhZnQ5?=
 =?utf-8?B?NHgwYXdqMVZoTHp5K1RxZTNsaXlzcUpvQU1NdnVlanFpUUZmZXpSUFQ2bEtK?=
 =?utf-8?B?Z2JQNTduQjI5M3JzRW9JbUI3SnJNWTE1UURpV3V3MFAwRzNVY1gxL1YvM09j?=
 =?utf-8?B?aVlzaWlUbWJneW1BMUdkbDBOYnVja1cvdlZ2Q0NqOERoVnExNWtnZkFGMzls?=
 =?utf-8?B?RkVFaDdvNi9YcXNDdWJlU2F0cTUzSVVYK3hsOWhjVk9KUzBJdnEvQ0lGYnVq?=
 =?utf-8?B?cm53NnlJdGh1a013VHNCbHlZODgvY0RSMzQ4Yy9ua0ljR0pPclFQczZyb1or?=
 =?utf-8?B?dFlHZTc5UnVkVkN6c1dwbW5LMUVRYTNTL3hBcnNiTkVpZi80ckJiSHZWbVN5?=
 =?utf-8?B?UFVFWXVQTk9BQncrTS9Yemt4SzI4UXNRWWhlZHJ5cU80eWNXNGxCTHdvbmdR?=
 =?utf-8?B?dDNydDBxVkdlT09ycG5xbUY0UmRDQkc0c3JSSk1XN2tjYkhJQTdwalhhWEd0?=
 =?utf-8?Q?6ZazlJ9oRJ/JsQf7O2JAVM9QzxEMNBt9dw+1dKZkSd8c=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5874.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K2kzOXozcjJWTWlqN2hWYVZNTE5lbVRLRjVFQzVLekZ1VUxxTEg0ZTFmUzBP?=
 =?utf-8?B?aW5mTjdPeElNR0RHQ25salR6OEZtVDVqSHpTazZYbEt6TjhrVkZEdEtrY1or?=
 =?utf-8?B?NVRQSm5rUEVDTWk1N2ZxTWZkbTJRU21mVmRXVFhiYjFIV1Nad0VySUdVaExT?=
 =?utf-8?B?WHVXWCt6aThIZ1ltUUYwU3lTbXc4c0JiQVZNMEZYd2lsK0Jva04vRUZnRjZn?=
 =?utf-8?B?NFRiVjRUams3dVZuWHNWc2ZHSHVuUjRUZUN4MkRFMG5ZREZyd29Lb0VBZkZs?=
 =?utf-8?B?OGtYVXZVSmRYTExoWTVxcWN2WVBtbnYxcWRPZHByT2wvbmRXYjVjMm5FeEds?=
 =?utf-8?B?TmZaVGU3Yy93ZXJybXlTcFJEaGdPcWJrakh6L0d1Y1phZm5yY2FrTTVHS29i?=
 =?utf-8?B?bHZpb2Y5ZEF5My9mZzV3L2NoNDFvV3p4OUR6Y2FpaUtqMU81NVNUdjFQYlQz?=
 =?utf-8?B?ZjUyYnlYWlBXM09kWldoTWZlaFRkajB2d0ZQYVIvNGtIQnpRc1pRNlVzY2M3?=
 =?utf-8?B?UFlzNTlxR2ViK0JHT0x3UmNSeVRiN1JoMzdlQlFLVndiS05NdmEwMktpNWJD?=
 =?utf-8?B?aStVTDRUbC9IdGdRbjNnVEV0SFN0ZHB4NGFpc2pqUk16VU5aRTNpN2Jzd0ht?=
 =?utf-8?B?Q0VPTGUvd1VzUUR0Q3V3S0hMU3gweDdpMm4vOWtKQW4wU1FjWEt3cHNsNXhn?=
 =?utf-8?B?c3MvRFNZZE5ZRERoM1VYdkdOTWZob2QycVZnMDE4T3duWjhHdGRQU3RkVWtW?=
 =?utf-8?B?Q0NTU3hZUm9uR0k1TDVBOWE1MjNrRnloNzBXQzJOYXdZUUlTUW9ucGViUEJv?=
 =?utf-8?B?eUFyeS9XcnVWM05SOUVLa0Zhb2xyRmpNME10WDU1QncxQk9FaVFGN2t3bmtn?=
 =?utf-8?B?VVhTdzZTZWQ5QjAwVElySWg5Vk4yK3JHYm04NFZiYkorNDBQWUNoYnZVRDho?=
 =?utf-8?B?NjFtZ0REUnJVbi9MYnVhQ0U5cnMzT0pMd1lMcklqaGJYcDU1ZGpWZHA5OUtJ?=
 =?utf-8?B?bmlJVGs1b2FtMHFGUGJnNFpuODZwc1NHa2I2R2FlQ0RRa0lnbHU3bzA0cnJK?=
 =?utf-8?B?dVByb0tDSXVsSUJlVFN1c3h5REhGSlBPaXlkOEN5V29saUE2WXNwS3NIR0dr?=
 =?utf-8?B?Y2QrQW5kb3hVdm1Zc1ZVVSt0blVqRDdpdWd2UE44SUJxSC9GelZ3SDMrcldk?=
 =?utf-8?B?NVF4c1ovV2Fvc3VISUp6enRvcnBYNVdhYXgxcXRQYzlQdlRwamlnU0ZRMFZN?=
 =?utf-8?B?ZXJIZ3ZrMnMybHYyMkRSM2UvK2tWM09DN1NoODBQR1ZLNjJnVm5RREtxK2VF?=
 =?utf-8?B?Y21KQUtjdVgweGdkTHNjdVI2dGhHcnFZUndqTG1OSE9UNXJTdlIyWTBsb3Z1?=
 =?utf-8?B?TVIvTllnK08xcjkvaUcrSENoNWRCaXZLejlnNHYzTEc1NnVtZDBFcEEwQnpt?=
 =?utf-8?B?cGloQVBtNm5CQU5vNjQxdHp4QW44ZGYxOVNLU21FbFJJYVRvcmptUThIRndz?=
 =?utf-8?B?QXEwTXhUTnpvcnBsNzhaaUVKc2Q3LzIzeXR1M2c4UUR6ZkhPVEE2RzViU1BT?=
 =?utf-8?B?ekgwSWwrSVJncHNZc3RvYXNua3dFU1JjK3dhcGU5ZmN0ZmZtM1hFRWprYzVQ?=
 =?utf-8?B?T3BGMGkzY0N0WVh4RzRqVVJ5dUROTHRMdHNuU3czUGhhbWpob1ROWDlRcWtJ?=
 =?utf-8?B?Y0N4bGFOTjYxL24zTFdjMDRHbmpsRGI1U0tEeS9jWjVkeEx0K0dDMDlsT2x6?=
 =?utf-8?B?Tm9FcEZvbFY5RTZJOXk3TXRmRHZjUWJSRW10VEpzU1pMaVpMRjlTS2V5K1la?=
 =?utf-8?B?UXpQVnp1ZEVPd3N0dURQelJGREhGUkVQenA5KzlkRGptUnRwdXcyQmJWOG05?=
 =?utf-8?B?VW9nOG1jaHFkcXk2cXV6MG5wV1IwYzJFVkR2S1RLZnBXbm1lM0lmZm5IZlQx?=
 =?utf-8?B?YXVDOXo0bUM0cW5TQW1WbzB2TGVuMkRKa2J0d2NScWU2RTFFWTdtVlM3THJj?=
 =?utf-8?B?L0hDUURLY1dES2NOckoyR1NhREZOVGN0c1JpVGMxWk9KV2h5S0hxaTc0bVpN?=
 =?utf-8?B?cmxKTjdzRDlNbUtTaCsxeHBSSGEzT2lNbDNBTlBqMnRrbUV4TTRKcVJEYlNn?=
 =?utf-8?Q?bLHbxP499B8Qi+pZWWEdvBWu0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2bcbae0-cb08-4b42-75ff-08dc649908ff
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5874.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 19:59:22.8971
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 85ZvEaKxBswMVnm4eH/A9UCU+v6/aIjWOqbR/2CIgVF2AtwejLnfRYPVe6bWPmNL2c3b70bNFQqnh27s+YHRpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7930

In the near future, I will not have access to the email address I used as
maintainer of a number of things, mostly in the documentation. Update that
address to my personal email address (see Link) so I can continue
contributing and update .mailmap.

Link: https://lore.kernel.org/all/BL1PR12MB58749FF2BFEDB817DE1FE6CBF82A2@BL1PR12MB5874.namprd12.prod.outlook.com/
Signed-off-by: Carlos Bilbao <carlos.bilbao@amd.com>
---

Changes since v3:
- Apply on top of docs-next using as base:
  commit e88c4cfcb7b888ac374916806f86c17d8ecaeb67

Change since v2:
- Fix .mailmap entry from <old-email> <new-email> to <new-email> <old-email>

Changes since v1:
- Update .mailmap
---
 .mailmap                                                  | 1 +
 Documentation/security/snp-tdx-threat-model.rst           | 2 +-
 Documentation/translations/sp_SP/index.rst                | 2 +-
 Documentation/translations/sp_SP/memory-barriers.txt      | 4 ++--
 .../translations/sp_SP/process/code-of-conduct.rst        | 2 +-
 Documentation/translations/sp_SP/process/coding-style.rst | 2 +-
 .../translations/sp_SP/process/email-clients.rst          | 2 +-
 Documentation/translations/sp_SP/process/howto.rst        | 2 +-
 Documentation/translations/sp_SP/process/kernel-docs.rst  | 2 +-
 .../sp_SP/process/kernel-enforcement-statement.rst        | 2 +-
 Documentation/translations/sp_SP/process/magic-number.rst | 2 +-
 .../translations/sp_SP/process/programming-language.rst   | 2 +-
 .../translations/sp_SP/process/submitting-patches.rst     | 2 +-
 MAINTAINERS                                               | 8 ++++----
 14 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/.mailmap b/.mailmap
index f877262b0be9..91c7a0f57e99 100644
--- a/.mailmap
+++ b/.mailmap
@@ -116,6 +116,7 @@ Bryan Tan <bryan-bt.tan@broadcom.com> <bryantan@vmware.com>
 Cai Huoqing <cai.huoqing@linux.dev> <caihuoqing@baidu.com>
 Can Guo <quic_cang@quicinc.com> <cang@codeaurora.org>
 Carl Huang <quic_cjhuang@quicinc.com> <cjhuang@codeaurora.org>
+Carlos Bilbao <carlos.bilbao.osdev@gmail.com> <carlos.bilbao@amd.com>
 Changbin Du <changbin.du@intel.com> <changbin.du@gmail.com>
 Changbin Du <changbin.du@intel.com> <changbin.du@intel.com>
 Chao Yu <chao@kernel.org> <chao2.yu@samsung.com>
diff --git a/Documentation/security/snp-tdx-threat-model.rst b/Documentation/security/snp-tdx-threat-model.rst
index ec66f2ed80c9..3a2d41d2e645 100644
--- a/Documentation/security/snp-tdx-threat-model.rst
+++ b/Documentation/security/snp-tdx-threat-model.rst
@@ -4,7 +4,7 @@ Confidential Computing in Linux for x86 virtualization
 
 .. contents:: :local:
 
-By: Elena Reshetova <elena.reshetova@intel.com> and Carlos Bilbao <carlos.bilbao@amd.com>
+By: Elena Reshetova <elena.reshetova@intel.com> and Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
 
 Motivation
 ==========
diff --git a/Documentation/translations/sp_SP/index.rst b/Documentation/translations/sp_SP/index.rst
index c543b495c042..274ef4ad96b9 100644
--- a/Documentation/translations/sp_SP/index.rst
+++ b/Documentation/translations/sp_SP/index.rst
@@ -7,7 +7,7 @@ Traducción al español
 
 	\kerneldocCJKoff
 
-:maintainer: Carlos Bilbao <carlos.bilbao@amd.com>
+:maintainer: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
 
 .. _sp_disclaimer:
 
diff --git a/Documentation/translations/sp_SP/memory-barriers.txt b/Documentation/translations/sp_SP/memory-barriers.txt
index 27097a808c88..153e57130775 100644
--- a/Documentation/translations/sp_SP/memory-barriers.txt
+++ b/Documentation/translations/sp_SP/memory-barriers.txt
@@ -1,6 +1,6 @@
 NOTE:
 This is a version of Documentation/memory-barriers.txt translated into
-Spanish by Carlos Bilbao <carlos.bilbao@amd.com>. If you find any
+Spanish by Carlos Bilbao <carlos.bilbao.osdev@gmail.com>. If you find any
 difference between this document and the original file or a problem with
 the translation, please contact the maintainer of this file. Please also
 note that the purpose of this file is to be easier to read for non English
@@ -18,7 +18,7 @@ Documento original: David Howells <dhowells@redhat.com>
     Will Deacon <will.deacon@arm.com>
     Peter Zijlstra <peterz@infradead.org>
 
-Traducido por: Carlos Bilbao <carlos.bilbao@amd.com>
+Traducido por: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
 Nota: Si tiene alguna duda sobre la exactitud del contenido de esta
 traducción, la única referencia válida es la documentación oficial en
 inglés.
diff --git a/Documentation/translations/sp_SP/process/code-of-conduct.rst b/Documentation/translations/sp_SP/process/code-of-conduct.rst
index adc6c770cc37..a6c08613aefc 100644
--- a/Documentation/translations/sp_SP/process/code-of-conduct.rst
+++ b/Documentation/translations/sp_SP/process/code-of-conduct.rst
@@ -1,7 +1,7 @@
 .. include:: ../disclaimer-sp.rst
 
 :Original: :ref:`Documentation/process/code-of-conduct.rst <code_of_conduct>`
-:Translator: Contributor Covenant and Carlos Bilbao <carlos.bilbao@amd.com>
+:Translator: Contributor Covenant and Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
 
 .. _sp_code_of_conduct:
 
diff --git a/Documentation/translations/sp_SP/process/coding-style.rst b/Documentation/translations/sp_SP/process/coding-style.rst
index a37274764371..b5a84df44cea 100644
--- a/Documentation/translations/sp_SP/process/coding-style.rst
+++ b/Documentation/translations/sp_SP/process/coding-style.rst
@@ -1,7 +1,7 @@
 .. include:: ../disclaimer-sp.rst
 
 :Original: :ref:`Documentation/process/coding-style.rst <submittingpatches>`
-:Translator: Carlos Bilbao <carlos.bilbao@amd.com>
+:Translator: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
 
 .. _sp_codingstyle:
 
diff --git a/Documentation/translations/sp_SP/process/email-clients.rst b/Documentation/translations/sp_SP/process/email-clients.rst
index fdf1e51b84e4..55d5803daf41 100644
--- a/Documentation/translations/sp_SP/process/email-clients.rst
+++ b/Documentation/translations/sp_SP/process/email-clients.rst
@@ -1,7 +1,7 @@
 .. include:: ../disclaimer-sp.rst
 
 :Original: :ref:`Documentation/process/email-clients.rst <email_clients>`
-:Translator: Carlos Bilbao <carlos.bilbao@amd.com>
+:Translator: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
 
 .. _sp_email_clients:
 
diff --git a/Documentation/translations/sp_SP/process/howto.rst b/Documentation/translations/sp_SP/process/howto.rst
index dd793c0f8574..72ea855ac9dc 100644
--- a/Documentation/translations/sp_SP/process/howto.rst
+++ b/Documentation/translations/sp_SP/process/howto.rst
@@ -1,7 +1,7 @@
 .. include:: ../disclaimer-sp.rst
 
 :Original: :ref:`Documentation/process/howto.rst <process_howto>`
-:Translator: Carlos Bilbao <carlos.bilbao@amd.com>
+:Translator: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
 
 .. _sp_process_howto:
 
diff --git a/Documentation/translations/sp_SP/process/kernel-docs.rst b/Documentation/translations/sp_SP/process/kernel-docs.rst
index 2f9b3df8f8fa..a62c6854f59b 100644
--- a/Documentation/translations/sp_SP/process/kernel-docs.rst
+++ b/Documentation/translations/sp_SP/process/kernel-docs.rst
@@ -1,7 +1,7 @@
 .. include:: ../disclaimer-sp.rst
 
 :Original: :ref:`Documentation/process/kernel-docs.rst <kernel_docs>`
-:Translator: Carlos Bilbao <carlos.bilbao@amd.com>
+:Translator: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
 
 .. _sp_kernel_docs:
 
diff --git a/Documentation/translations/sp_SP/process/kernel-enforcement-statement.rst b/Documentation/translations/sp_SP/process/kernel-enforcement-statement.rst
index d66902694089..d47a1c154610 100644
--- a/Documentation/translations/sp_SP/process/kernel-enforcement-statement.rst
+++ b/Documentation/translations/sp_SP/process/kernel-enforcement-statement.rst
@@ -1,7 +1,7 @@
 .. include:: ../disclaimer-sp.rst
 
 :Original: :ref:`Documentation/process/kernel-enforcement-statement.rst <process_statement_kernel>`
-:Translator: Carlos Bilbao <carlos.bilbao@amd.com>
+:Translator: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
 
 .. _sp_process_statement_kernel:
 
diff --git a/Documentation/translations/sp_SP/process/magic-number.rst b/Documentation/translations/sp_SP/process/magic-number.rst
index 7c7dfb4ba80b..32a99aac2f6c 100644
--- a/Documentation/translations/sp_SP/process/magic-number.rst
+++ b/Documentation/translations/sp_SP/process/magic-number.rst
@@ -1,7 +1,7 @@
 .. include:: ../disclaimer-sp.rst
 
 :Original: :ref:`Documentation/process/magic-number.rst <magicnumbers>`
-:Translator: Carlos Bilbao <carlos.bilbao@amd.com>
+:Translator: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
 
 .. _sp_magicnumbers:
 
diff --git a/Documentation/translations/sp_SP/process/programming-language.rst b/Documentation/translations/sp_SP/process/programming-language.rst
index 301f525372d8..ba2164057f45 100644
--- a/Documentation/translations/sp_SP/process/programming-language.rst
+++ b/Documentation/translations/sp_SP/process/programming-language.rst
@@ -1,7 +1,7 @@
 .. include:: ../disclaimer-sp.rst
 
 :Original: :ref:`Documentation/process/programming-language.rst <programming_language>`
-:Translator: Carlos Bilbao <carlos.bilbao@amd.com>
+:Translator: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
 
 .. _sp_programming_language:
 
diff --git a/Documentation/translations/sp_SP/process/submitting-patches.rst b/Documentation/translations/sp_SP/process/submitting-patches.rst
index c2757d9ab216..18bb3413c3ca 100644
--- a/Documentation/translations/sp_SP/process/submitting-patches.rst
+++ b/Documentation/translations/sp_SP/process/submitting-patches.rst
@@ -1,7 +1,7 @@
 .. include:: ../disclaimer-sp.rst
 
 :Original: :ref:`Documentation/process/submitting-patches.rst <submittingpatches>`
-:Translator: Carlos Bilbao <carlos.bilbao@amd.com>
+:Translator: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
 
 .. _sp_submittingpatches:
 
diff --git a/MAINTAINERS b/MAINTAINERS
index ebf03f5f0619..ca27f138cf45 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -993,7 +993,7 @@ F:	drivers/video/fbdev/geode/
 
 AMD HSMP DRIVER
 M:	Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>
-R:	Carlos Bilbao <carlos.bilbao@amd.com>
+R:	Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
 L:	platform-driver-x86@vger.kernel.org
 S:	Maintained
 F:	Documentation/arch/x86/amd_hsmp.rst
@@ -5352,7 +5352,7 @@ F:	drivers/usb/atm/cxacru.c
 
 CONFIDENTIAL COMPUTING THREAT MODEL FOR X86 VIRTUALIZATION (SNP/TDX)
 M:	Elena Reshetova <elena.reshetova@intel.com>
-M:	Carlos Bilbao <carlos.bilbao@amd.com>
+M:	Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
 S:	Maintained
 F:	Documentation/security/snp-tdx-threat-model.rst
 
@@ -10603,7 +10603,7 @@ S:	Orphan
 F:	drivers/video/fbdev/imsttfb.c
 
 INDEX OF FURTHER KERNEL DOCUMENTATION
-M:	Carlos Bilbao <carlos.bilbao@amd.com>
+M:	Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
 S:	Maintained
 F:	Documentation/process/kernel-docs.rst
 
@@ -20690,7 +20690,7 @@ Q:	http://patchwork.linuxtv.org/project/linux-media/list/
 F:	drivers/media/dvb-frontends/sp2*
 
 SPANISH DOCUMENTATION
-M:	Carlos Bilbao <carlos.bilbao@amd.com>
+M:	Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
 R:	Avadhut Naik <avadhut.naik@amd.com>
 S:	Maintained
 F:	Documentation/translations/sp_SP/
-- 
2.41.0



