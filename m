Return-Path: <linux-kernel+bounces-161665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9CA68B4F33
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 03:26:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E6761F21D56
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 01:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D451EC3;
	Mon, 29 Apr 2024 01:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GhTVLqF2"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2058.outbound.protection.outlook.com [40.107.96.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3157F;
	Mon, 29 Apr 2024 01:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714353983; cv=fail; b=RsrCD5Ug3YIdZ0rCaugUcHRkVwIbZT3NDPPrwn3dag/H0IIGxZMPUAX4VP4oyO7oFVl5WKjTglu+FSJsTOuygjWGMAF+UhL0rQUMLhABITRtfiEniDdKpx/Xop2VsCjxpXApxaQZWXSS8mksbE0HJZJkVJYCsyJvTpa8mkshKl0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714353983; c=relaxed/simple;
	bh=M/mvPqvgox2UPYoKPmDOVZS/KgD01aF8OxqGRvwHEpE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iY3Hl7/Tx1rNKkhXgj8Nvldw2nXjvVEjidLrQ1vyabBgBK+q+rK7zuWByw4liJ5wkCNuw1ltqAsrmP7kTpLdck/3hnKVTfedX8bcVJ6AUNaEyU+zY2OsWc7nlc2aruSeFhcjwVVWU+NKXj483l2QDf9Op646dSx1c3FgU+n9VI4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GhTVLqF2; arc=fail smtp.client-ip=40.107.96.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lIIfpZFRMIByPx+YNVpz5QCmvqcWQHgMwnujBli/gCqmmAtSF1XVmDR2BxTpvETCveYRQYuMmIlguzu+JtUplCSPolFJy/6SyfSwWZkFP/01uzIRmVYUKkkDvGRMPtnk5bjnKEaxE6UxZUukADa6jbJVzvM35ROvUvEbJbvlYgkjyPaF5YOATUkYVVg7glnwLTjQqkyCAwvTqWFxi2D2eNAA6PiGJx9OiJhRmvNNVrWq0t93KAecKafU1Zx020DiQP8i/5p0J8aN5gBUBmgR9aCyxzhbo38xCIEfiiLLDRvisq3csyxI93qHJMydCPlNYTfca7HjCbAMsDfhZnnmjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j7sMnhN2+kCB7n5zuqioNz+c2vtVYaKDsuLa2Nky/jo=;
 b=dGFiwpWQegTLVApORHqHpzue64/AkFX3j5xfs/5n8HszVwoRM4SGIkq5tHcseP34nV3eIYx8D8JHBRxyFi5GV/fGQFQyeM+wUCsPLF7lKkfEh5at6VFRg6RUM0/7UHst2MWimYfxd7VxqrqlOOba/sg0vlN35g1nx5myUzEpOz7yyRWgUPKvGzxJS/nW46KW45n0Hao9eKTAPESJp6AL3tyLZ2gc6HO6SoyPBtKNLW+OnEQecy291twLbPa0vbFh5Is1qXdanoH4r3nLSoDCMUrrocRQiFmcSYeIRd/X5f3OQyNkifhuaWdDW9MD3OrQcfhh/pkKjnFW2HDEA7ORVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j7sMnhN2+kCB7n5zuqioNz+c2vtVYaKDsuLa2Nky/jo=;
 b=GhTVLqF22lyoHhSkoH/84xiRZaweRbQngsbYq8LkUgOikqhfmIvWGNEY3q08kc0AMkHjHMSlRicoP5YNDVpbtC2sF4qMrtGCpgRtGEsAat0LcymRKNdkDkI7Kpdy8qWZsS4LnOskGKDZSko3GY0Bve1WW91cZZNOnaBKJD0IOVI=
Received: from CO6PR12MB5394.namprd12.prod.outlook.com (2603:10b6:5:35f::19)
 by LV3PR12MB9402.namprd12.prod.outlook.com (2603:10b6:408:213::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 01:26:17 +0000
Received: from CO6PR12MB5394.namprd12.prod.outlook.com
 ([fe80::641f:33ef:d412:4080]) by CO6PR12MB5394.namprd12.prod.outlook.com
 ([fe80::641f:33ef:d412:4080%5]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 01:26:17 +0000
From: "Zhou, Bob" <Bob.Zhou@amd.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
	<Christian.Koenig@amd.com>, "Pan, Xinhui" <Xinhui.Pan@amd.com>, David Airlie
	<airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, "Kuehling, Felix"
	<Felix.Kuehling@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>, Guchun
 Chen <guchun.chen@amd.com>, "Ma, Le" <Le.Ma@amd.com>, "Lazar, Lijo"
	<Lijo.Lazar@amd.com>, "Sharma, Shashank" <Shashank.Sharma@amd.com>,
	"amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: RE: [PATCH] drm/amdgpu: Fix signedness bug in
 sdma_v4_0_process_trap_irq()
Thread-Topic: [PATCH] drm/amdgpu: Fix signedness bug in
 sdma_v4_0_process_trap_irq()
Thread-Index: AQHamWuWYELGh+nM3kOz+IsJOr/PDrF+dIKA
Date: Mon, 29 Apr 2024 01:26:16 +0000
Message-ID:
 <CO6PR12MB53946126A02595B4FDF76525941B2@CO6PR12MB5394.namprd12.prod.outlook.com>
References: <afb229a9-3f18-44cb-b305-5fbb2e1b4ee3@moroto.mountain>
In-Reply-To: <afb229a9-3f18-44cb-b305-5fbb2e1b4ee3@moroto.mountain>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=5397a72c-fab4-4809-ba65-61f5d1b1955e;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2024-04-29T01:22:22Z;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR12MB5394:EE_|LV3PR12MB9402:EE_
x-ms-office365-filtering-correlation-id: 617eec7d-0d93-4abe-4101-08dc67eb5ddb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info:
 =?iso-2022-jp?B?Rm5hVjdDcVV6SGxFcng3UEhNa2gyV0NzNFVnTk1BWFh2S3c3VmFvdTN4?=
 =?iso-2022-jp?B?VnJYcW5sclBSL2FVRTV5Z1ZUcGg4MDhTUXlhRm5FdzMrSGtIMnlwMUpM?=
 =?iso-2022-jp?B?aG1jNmlmMTVIalZVaCtDZjBVa3Z2eXY4MmMra09LMlRUOFJEa2lvcEdo?=
 =?iso-2022-jp?B?VStOdm1LZ1FxUytPQVVHM2RWZ29uMnE1RU5hM3NQWmdnOG9DU1B1K0xy?=
 =?iso-2022-jp?B?RWFkYTYvdVBJei9EK0tKUDJITnNRNmNLbnNrdVpUa1FFY1hCaUhoN0Zt?=
 =?iso-2022-jp?B?ZjV3R2ZBZUJYb1JzN0dROFdUMURnN09abGFqeVljZm9STGZCUjdqdVc5?=
 =?iso-2022-jp?B?aC9ocTY4c2VDNUE5Z0FsYzRMV0cvUlJmZ3dvcmUvV3o1c1A0aFVrSC9r?=
 =?iso-2022-jp?B?NFprS0JDSTFvNFB6Z0taYmgvUFlOODZGblZLejRwdGNMNUpLOHBkUDI2?=
 =?iso-2022-jp?B?T2NrZFl5OGtOYVR5TDBXMVJtd1lCL3VKSWk4M2VZT0lNZkNreXRZNmE4?=
 =?iso-2022-jp?B?dGl6ZHdsVXpySHhsVmVLTWlTVGhaUU9SOE9mRysyajNtNjlaK1N6OE5Y?=
 =?iso-2022-jp?B?a2liZXVlYjg2QTJwQTJHWmNjQ3BFR2M5K0pQYVpBcVBmWUJZQlRoNG1Z?=
 =?iso-2022-jp?B?Rmg1cVFTMmRvS1JPdjVnSCttRlRTYkJRRjRsV1JMMGVmQ0FkcThQa0tt?=
 =?iso-2022-jp?B?ODNKVGJuUE5hZytRdWF4c0V4NW5paitsRHdPVmQ3Q1M1MkdGTlFyNWJH?=
 =?iso-2022-jp?B?Q3JPMFlDWFQvZEJsT0VFZkp4MEI5TXlXaSs3UnhLaWQrRmIxMkZSYmVj?=
 =?iso-2022-jp?B?RUVjSFBvMFRIQ3RnVy9aNlNGQWlzaWxYcWRUT2tEL0tIWkJQdWFkRmRq?=
 =?iso-2022-jp?B?YVgvZnlJMG5vaDRoQXc0NkkyUGNpT0h4YnYyLzVLTURlVHV5MDlHbkZp?=
 =?iso-2022-jp?B?elBydEFtaG1JZ0Y2Wmk4YTdKVVRFY0Vwc01DNGtqUUdlYjhrdmFESGFl?=
 =?iso-2022-jp?B?Z2YybVRUOFRYNFo4bnpEY0c2R3RmdHVCTlJVUFNFb3gxNWtCVnVTZmpi?=
 =?iso-2022-jp?B?c0tKQ2RlZWF5a0FGMHc2cGIvT0ZlWStUSlgxNE5EYlJHQmt6bVp4NXYz?=
 =?iso-2022-jp?B?blhqUGI5bjF5a05TUnhLMWdZOWlsWnRoTmhETHhocUoyWEpiNE1NSUQ5?=
 =?iso-2022-jp?B?aDRySjFTM1BPYzZGMkNnanNhS1VPZnhOTHF0MlowcTBxT2x3SjdKakFl?=
 =?iso-2022-jp?B?SjU4RmJwVUVpUU9PK21kRlpwOWVFWnc5UFhaL0VXOU5LNFhtNDVXVHh6?=
 =?iso-2022-jp?B?NFVqZlZkR2k0c3MycFlWS0VZTG9PMysxbnhRQWtCKzRLZHVUYlg2Wmw2?=
 =?iso-2022-jp?B?U0RsV0VrRHp4R2VueXR5emFJUlhNME41S1JvWEhGRWl6UlpxZ3ozVWxt?=
 =?iso-2022-jp?B?Y2xQbmg5Qk10NDZJblVlMkRBTC83R1JUL2FkeGJBYmdBbGxJWkRxb2FN?=
 =?iso-2022-jp?B?dk40U1R4TytIb2hhRE9UdjFvQ1pPaVRYR29iUSsrSXE1WXk2YzNkdFBl?=
 =?iso-2022-jp?B?SGZyc2QwZFpVRWZzWWVMT2pzcktZS2RzZEtsZHpIM0ljMWJpeEFsVGZR?=
 =?iso-2022-jp?B?eXo5NFRucExqMjdtbUhNdTRiTzdlMThSZ00yNFFNTk56ZkQwNUZpRkVY?=
 =?iso-2022-jp?B?d2NhZlFPajlYK1FUZmRIalppc0hhTTRvdG4xMml0T1FkWFJZdlphODUr?=
 =?iso-2022-jp?B?N0ZTNExWODJqT1Y5dVVQbno5VlV2bzJNczYyaWh1TDhlSDNTREV6UDFa?=
 =?iso-2022-jp?B?bCtVa1g1a1BFcytHS1B0RmU0WW1hdDUweVB5cFZoOURYaU9NaHhOVEpX?=
 =?iso-2022-jp?B?bTNyV25GWllMdDQyOEgxY0dtS0xmbmJnRUh1RUk0aG1WMG1MWjhybEZu?=
 =?iso-2022-jp?B?ZkpIUUZtT2tkZXFLVndQc0VFTzVjdz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5394.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?L3lmbjdZNTQzb3JqWDdiRU8raUViMi9heXRoVkVEcVVBZHNoYkIwSHJz?=
 =?iso-2022-jp?B?SHNoaXhrazg0SUJDOGxONWVPTDVvcWJIUkY0UUROR0s4VGVlTWZrNlpB?=
 =?iso-2022-jp?B?b28xRzdIRzJXMWgvWXUxYlA2eXR4eFcxT2htZUVFUWIrNFU0VVpDalcy?=
 =?iso-2022-jp?B?aHN3SUNPTHplQUY0TEdySnl3V1hSYmVtVGZpT3g1ZzVXWXMyeWtDdCtD?=
 =?iso-2022-jp?B?ZzB1R3AvNURURjdPamFUNm03V2lWT1JxQWJNN1c2cnRoMmdPVkhOWUxD?=
 =?iso-2022-jp?B?b1prNVgzOFl5RDZtNXJZZXNGVTlGM29pcncvb1ArblJOZ0NZRFhKZEp5?=
 =?iso-2022-jp?B?L25Wc1JhMmgwUHlQa2R2SG5BSTg5ay9zdjBJNlBIOHZRaU8rdHJjaVJL?=
 =?iso-2022-jp?B?NDRmZjRaZ0ZiaDVXMHZ5bktHTUx2bjBEZWtSUDhGNE1ETE9SeHlBc1do?=
 =?iso-2022-jp?B?dmNDelRjQTU2eEVsR0k5cDVkTnRMSnRoYVFOUmlPa2liVnhSU0tMcUNI?=
 =?iso-2022-jp?B?aFE5S1crcXg2cmowcEJyZkJSWHhsbnJWdmo5bGhNemRpc3BkUUgxTGpQ?=
 =?iso-2022-jp?B?UXVLR25JZEdBSkZRa0FoWTZvbHBMSWhSNU5JamU1SFNvcmhsZE00VVht?=
 =?iso-2022-jp?B?NUJTQzB4Qks1K1RjNGFmcTFmcXF2WEFnVFhBaUZlVUtXL2dSaWVrTjZD?=
 =?iso-2022-jp?B?SWxkZTMxODRwRDZOTFFJelVDb1BpUVY3anNtOUlsMkwvN2lRY01ERXFp?=
 =?iso-2022-jp?B?S3htU1A2Sys4MTJXOW1zUHFTcllxajl5L3l3Z1RQWmo0QUZYWWVsSUc4?=
 =?iso-2022-jp?B?cUcwNzZ5emxyVzZVWjJUQnBDNmQra2JzREI5aVZDNlJPcm1TV2ZIdlZp?=
 =?iso-2022-jp?B?MklVQjVNOWdubFMyNFM1SEVTZTIvTjJDcncwQTZLQWhFRnRBRVB4Tjlw?=
 =?iso-2022-jp?B?bVZJOVl5b3hNR3EwbUF6Y0VwSHFpL2wxWHFIV1RnMnk5SUdDMGE1R3FY?=
 =?iso-2022-jp?B?TEI4SWlWNk10OFdkMGVNTlZ6cFJIa1RGR2lWa3VyMktIbDViRmZOZHN5?=
 =?iso-2022-jp?B?cENJbmMvcyt1N0VvakJ2WllobUlKZmI5V3hKUHlaUUR2V0lpd1hpVmd2?=
 =?iso-2022-jp?B?ZE01ZmtiRWF0Mjc5SThKVFQvRWFoTnNzVjhZR0MvYytBUUpJeTkxSE1q?=
 =?iso-2022-jp?B?NS9TN3lmSUlJK1l1bGRhRkJWVlVGbmFGU0lBRGpyN1hpWmt2WTVDMVB6?=
 =?iso-2022-jp?B?WHA4em1rV1o3MWNZaFlXMVdYNC85YWM4VTZGOEJzYmdrTjRndTlOeUlj?=
 =?iso-2022-jp?B?ejJ5ckhCbFIxa0IxUUtZRHpISTEycHNZREhLZ3BRU1pZVWZIRlp3SitR?=
 =?iso-2022-jp?B?NlRmRnpkMmc5cXZmK1NNcW5sSVErS2RubFZSdERZbzltdE9kQTdxbHM3?=
 =?iso-2022-jp?B?M0pKRlVqZ2dRcWlaRDZrN0RWdTJCMnFwcXBTVEVGTnpjYmFHNVlqbzhC?=
 =?iso-2022-jp?B?REdnL3gyT3VmcW5Sbm5yREpCT21nU0dxVzEwMVZlT1pNcm44aXRUSXFD?=
 =?iso-2022-jp?B?NjllMEx0QlJPdURWRFoxb3hNZkF2TU96SlQ4ZUc0L1pIZWk0aVM2T016?=
 =?iso-2022-jp?B?WGJONVdaaEh3SCtHN09ja3BScmpQbDlsRTNCR3JaNUkrQWpVNHdlZDlQ?=
 =?iso-2022-jp?B?T2RqVFRsWU11U1djT2F6cWZzUGs2NHErdGRTdFNEejl5cVBVaU9wRmV1?=
 =?iso-2022-jp?B?SEVQV3pWWi9aN2R2VzVaWjF2d1RBamxaOHdXcFpnT0JTN3Q5d1B1ZW5P?=
 =?iso-2022-jp?B?cnBReVhHVllUbXA3ZzVPMDVKZjhMdXRtL3pSMkpwQzNNNFJFRFI0ZC9t?=
 =?iso-2022-jp?B?N1JJV2pIYW1JZnc2MnV1azRZbjFoWGFkZjcyMk1qM0lEblEwZ3Vsd3l5?=
 =?iso-2022-jp?B?R2Z5SlE0ZmloeFl1M3dSKzFpTWtQVmlSVXRSdkpVd3lqN3JzTUNxcmRS?=
 =?iso-2022-jp?B?YXJMUlhDOTV4SlJxa1NMWTBxcjQvUHJrcGI5Z2RrZ3NOUTFlTnhLM0lM?=
 =?iso-2022-jp?B?YmxsN0crYVFXRlFKVUM5eERyWXRJcVFnZTlSVjJHYzRoTVMwK0VabEg4?=
 =?iso-2022-jp?B?YUp2ZWtVczBZeW5kVVk3Z2FWM3ppMUJ4WnhsOHVra2hIQ0lEaEl2SkRN?=
 =?iso-2022-jp?B?QWdMZW5jcHlMcUFaa1N6K3cwR0tmZEFPZ1ovblBOeHdWclUvelV0NDFI?=
 =?iso-2022-jp?B?UnJxcmJFbzVBeTY1TWx6NWJqV0VpazRWMD0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5394.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 617eec7d-0d93-4abe-4101-08dc67eb5ddb
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2024 01:26:16.9004
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8gzlScOFuLqaU/3bsEe8J9L+x5+3EYXOagzkCHRceK0PzIaVmW1qcyyTmAUgQGVY/73jSNZCVsVJp+jfww8U/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9402

[Public]

Reviewed-by: Bob Zhou <bob.zhou@amd.com>

Regards,
Bob

-----Original Message-----
From: Dan Carpenter <dan.carpenter@linaro.org>
Sent: 2024=1B$BG/=1B(B4=1B$B7n=1B(B28=1B$BF|=1B(B 20:57
To: Zhou, Bob <Bob.Zhou@amd.com>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>; Pan, Xinhui <Xinhui.Pan@amd.com>; David Airlie <airl=
ied@gmail.com>; Daniel Vetter <daniel@ffwll.ch>; Kuehling, Felix <Felix.Kue=
hling@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Guchun Chen <guchun=
chen@amd.com>; Ma, Le <Le.Ma@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; S=
harma, Shashank <Shashank.Sharma@amd.com>; amd-gfx@lists.freedesktop.org; d=
ri-devel@lists.freedesktop.org; linux-kernel@vger.kernel.org; kernel-janito=
rs@vger.kernel.org
Subject: [PATCH] drm/amdgpu: Fix signedness bug in sdma_v4_0_process_trap_i=
rq()

The "instance" variable needs to be signed for the error handling to work.

Fixes: b34ddc71267a ("drm/amdgpu: add error handle to avoid out-of-bounds")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/a=
mdgpu/sdma_v4_0.c
index 101038395c3b..772604feb6ac 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -2017,7 +2017,7 @@ static int sdma_v4_0_process_trap_irq(struct amdgpu_d=
evice *adev,
                                      struct amdgpu_irq_src *source,
                                      struct amdgpu_iv_entry *entry)  {
-       uint32_t instance;
+       int instance;

        DRM_DEBUG("IH: SDMA trap\n");
        instance =3D sdma_v4_0_irq_id_to_seq(entry->client_id);
--
2.43.0


