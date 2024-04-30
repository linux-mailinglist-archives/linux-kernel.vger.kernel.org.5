Return-Path: <linux-kernel+bounces-164388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72EEC8B7D13
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 18:34:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9289B1C22957
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 16:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B55E82E3F7;
	Tue, 30 Apr 2024 16:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yCQKLg2C"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2067.outbound.protection.outlook.com [40.107.236.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F67117B4E1;
	Tue, 30 Apr 2024 16:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714494745; cv=fail; b=ow+5A7p4iZd6worfKp//ss69Pwk/exoWrS7Eim1kLlUysOn7nnxi61b/ILmKYjgXrjV7QJXaW8gf5Mmx5PoW5B06VrLpBxyLOzlgyXy7gTCwepW5Jgah7p2fhxNiqexFErw1/fPtfzKdXAJYwL9n/ICJQjLVjbrgdUde38wwt74=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714494745; c=relaxed/simple;
	bh=NeVU7jK5Ypwb9NG+A4wtcraVihuD67SwETYSfRffGaM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cT3OCZQQAlLthFMuCMutOmJR/7IPXMPRTFtem0sU8hjNTaYyJ70EUKSM+UZOhe42qwFP21AtVYoEW9r0c5swzM/skN9Gko5MXPE/UxhT4s9EvkO6dmO3MfWXm5MrfCBzXjZjsdVXoNOZXyrRsbNPD+F0gY49bHj3JhAIWd62Sqo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yCQKLg2C; arc=fail smtp.client-ip=40.107.236.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TJ6vvSbSZPC5ogW7wiXNzds4xrpelFNNn3vzOcoJy79/ACSpdfFv/f/itPdXd2t8qSW0+DKWI/5ickd1NwA7DCUFNRj4lM1pyojzYacyobuzezsUqkOMtaNM2jUoXz2qvHHT2dL2oLe7NNg1C58v6+mHDQNCtwSImXnvkjE2PlklGIuppL6jJ5XDD5pBkr6HOs2bp6gbd79Jy7AG1a1AqtN1cfVJpGoHOT+SNUrdApjDYC/clLUEPlDxDDm7DT7M8rWIWmUc5HOCGGn5qYadOMZeajOJhn4O3JUSiB64162dpQ1L8qoidY27NAI5mxYSul12X4AtNeE8BxzilCf1/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0pjumK72Nqtt3UBVPmbDuhrYCUraMLg4Qv6oD75ODyw=;
 b=kTBGfT0Ac8TQe0fv+ptQib6lBRDvry7YJ4CtR2iF46a2aCpiMhY949Kb1MXepWFk9jZAVqjQdg9wK52CRxisjTOiN6zEEr+hvPLsLnwhsNSJWDmFfkeR+CZErmkcla7Rp+kUYtjafQxj5z5F7Mk7Cnw4EZudSiLi4IpbYkHXidI4RN5FAChYWiexSdKXNsyRVDrpfRCyHAvmk1N74Fh7Fd1c3HyOInDJokNEd2DWzBPbfEUSZ6PSiaCUiuW+DwWn7K3q3vrMg5M1ee9qBopVmfRPFGrKvCPY2R+RdRRlxhf2ANGpEmxtuaHN6Vu1B1AkZqjGbj0vIIMj/EBGpKU4Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0pjumK72Nqtt3UBVPmbDuhrYCUraMLg4Qv6oD75ODyw=;
 b=yCQKLg2C9Y5tHw9Ykr+YszN0RUYftCFUQdkDnphGAofonHckCf+WsCMQrLUbHhtAmL0xqagb3pzntAdpIJ16L8Smb8nFDy77Uh82MLS1wdJ6+gGU60450FDNMS5gE9k7BcGGgC7hgRKp4cmEihxgaf+7bSQg3iVB82ewJCbaZNU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SJ0PR12MB7457.namprd12.prod.outlook.com (2603:10b6:a03:48d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Tue, 30 Apr
 2024 16:32:17 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%6]) with mapi id 15.20.7519.031; Tue, 30 Apr 2024
 16:32:14 +0000
Message-ID: <21068e37-38fb-478c-8ec1-e41b0cd450e2@amd.com>
Date: Tue, 30 Apr 2024 11:32:12 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 0/8] AMD Pstate Fixes And Enhancements
To: "Yuan, Perry" <Perry.Yuan@amd.com>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>
Cc: "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
 "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
 "Petkov, Borislav" <Borislav.Petkov@amd.com>, "Huang, Ray"
 <Ray.Huang@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Huang, Shimmer" <Shimmer.Huang@amd.com>,
 "oleksandr@natalenko.name" <oleksandr@natalenko.name>,
 "Du, Xiaojian" <Xiaojian.Du@amd.com>, "Meng, Li (Jassmine)"
 <Li.Meng@amd.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <cover.1714032153.git.perry.yuan@amd.com>
 <CAJZ5v0iF_NUAMhTCaakUi_F+2CrRgiQMXmrVm00+W7vd+H=wjw@mail.gmail.com>
 <CYYPR12MB8655B901D5176249F0C67FF99C1B2@CYYPR12MB8655.namprd12.prod.outlook.com>
 <CAJZ5v0hfiOkoj45QOO70Dqq18JYgNhxza_VCx5YDXfwVnfmcwA@mail.gmail.com>
 <CYYPR12MB865528B3088DE9B43559000D9C1A2@CYYPR12MB8655.namprd12.prod.outlook.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CYYPR12MB865528B3088DE9B43559000D9C1A2@CYYPR12MB8655.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1PR03CA0017.namprd03.prod.outlook.com
 (2603:10b6:806:2d3::13) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SJ0PR12MB7457:EE_
X-MS-Office365-Filtering-Correlation-Id: ec27a83b-aa3f-41ea-4e23-08dc693317f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q2R5dnhPeUNmK1hzbEdQQUZlNVpXRDZRYzFjbUl1SjhxS3VIaE9jbmI4Nms3?=
 =?utf-8?B?ZzdUbVFLUWx1MHZhaGZ5SXBvQzlJVk82c01za2pZV1FpbWprY0ZlYUQ2bmlG?=
 =?utf-8?B?SlNBcWQxU0FhUWhSNzVjOXRXU1JxRVVRQ010dy9EV1dWWC8wYXZaUGxzRmlv?=
 =?utf-8?B?YkxyNEJLUTM4VktURXV2MURjSTY3cjdxaUF3MkkyenZJV3BEUGZFQXBsWWdy?=
 =?utf-8?B?VlljeEludG9lWFpBMjVYVjVFZldZcCtIY0JzVGYxU0pvMEw2U3piNWp3VjJL?=
 =?utf-8?B?N0RROTNtd2g1QndVbnlwRDdMK1RuVG11eHR5a05DeWM5QkNHQXppMHE0QWJ6?=
 =?utf-8?B?VjFONnpMK2xoS3kvNXpNS0RqSDlpVlNXTEtsNkJacXliZS9vUjhnam1zQktr?=
 =?utf-8?B?LzV3a0FMZGVwbm90NFg5clZOZEJJMEVZanZGNWVieWtQdThITTM3d1Q1bnJB?=
 =?utf-8?B?RW5yUXh1SXRPWEw2UHYvZnp0TzVqNkg1SERYS2RRaGpnZ2lsS3FQL2FldHBT?=
 =?utf-8?B?MEZ5S2VBWTJreHJrajFaaGxPMnk5QWV3aElGdHJ2USs0cFhYYU4zQXZqVUw1?=
 =?utf-8?B?akJMb1dQY29lYUlGb2h4MGpxTzZBYi9IM0NCK2lQYmtORUVTNlU2ZDA5aUVR?=
 =?utf-8?B?Q2REYldYVklEdkpmT0h6NENzUzdwZjRYNk5UTkEzMDR6MkZTUlpxeTZoVmNo?=
 =?utf-8?B?UjNkZFRqTXBJT2YwVXBsaWczL2hiaHhVSFpEZjVMWERDdEVGd1hWOERXbDVj?=
 =?utf-8?B?eFkrY2lzMStvWURibVlxdkd4c2hrbkJTNWdTS2ozb21uK1hVdXhib21iWmtX?=
 =?utf-8?B?NytLUTFLY0NzU2pCdlJvQjFhdXFWNGJUdDNNck5Qdy9GUVpMcTJ1SW4xcWRR?=
 =?utf-8?B?MU1KdGFMUll2Zld5Z0Y4UjhwVldIa3JBUG9YWGVyRHhaeGRJaS9uWUtEZlRH?=
 =?utf-8?B?WUxZYzZFZzJLaXZFNUR4SjUxb3pjMXRKYVJTeVlyNG1BMHczSGlHWHNxSzYy?=
 =?utf-8?B?cHplMzRUYXNsdGwyOXNpL0NBQWZBSjU5VFBGVXNDbUlJazZpaVdGZlBBUHdD?=
 =?utf-8?B?SGJ5NHlkSnN2UDRLOXVjd1EzMHhhVzhMclY4TzdGZHR5Ni9aV3Y3cU9Sb2hq?=
 =?utf-8?B?dUdYamtMTUNVRUh2UzQ0bW9qS3d3N3IwbFdxU0o3MUdoOVpmZEZuUllTRTFD?=
 =?utf-8?B?K1FUeTJROVZrT0tXMFpGOVRLT0FTTjVmelFNRzBQaXMyNkJRNnEwekFEclFB?=
 =?utf-8?B?M1NaYzhvTzRpZEU1bHdEZzU4MHc4Q0JGOUFTTWxZaGxBdFhJSlk2U0Z4UktQ?=
 =?utf-8?B?TCt4VXpnQzFTSU5tVEs3QnNrZ250c1hSK3JHZG1GSFdUYzZ0cW05SUpzRmxT?=
 =?utf-8?B?OFMxcStCYkIvUFZMaWZkaVlnU2RYdDBvb2J4RXBVRFFBa2tCSUY4bVFhSU9q?=
 =?utf-8?B?MmlFcWQ1QjZCRTQ0VllsaTB5MVA4MStYUlVXSFpmYTE5d0VqOFFDcHYrT0x4?=
 =?utf-8?B?dEcxeFVnUGFvT2JWWW1vT0JUZXVVM3c2M2hMMnQ0UENvejhpaEYyQWoyR25x?=
 =?utf-8?B?c1pmYThGb1hya2lzZWpidHF1T3ZkSFBpcFh2UGN0OGQ3SVVGcXQ3enlsRlhW?=
 =?utf-8?B?cXdmWTY4b2tEY0F5U215VWRJdlkzd3d4bGpjQkE1NWxISEwvZUd4TFhMS3Qy?=
 =?utf-8?B?SUFZMGc1WWdrKytadVl2MDg2Uk1hTEhYWEs3NllLN3A5bUNFQVV5OGRxMnRG?=
 =?utf-8?Q?PVtnHdgpfJOqZpgVy4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?blBXcGFsbTFmSHVCZ3lZeUVZTS9hY1RWY3owd04zYzBnV2I4S1MvdnJ2d0RT?=
 =?utf-8?B?Q2NuRXVOUUY1QkxQK0dPVms0OTVTMEVxT3dYd2lLNWI4RXUzTWlYbkY0UDVZ?=
 =?utf-8?B?eW4vMkk0bFRpUlVjcktDOHhXRHI2K1VqSmJ1b21LNXI5T1JFL3Q2akkrUGkx?=
 =?utf-8?B?dVFhczZKQ0FyVHBWSHFQbm15Q1NWOHBvWHgxdElhbzhibGRoTUFJSC9yOXEy?=
 =?utf-8?B?bG83eEorNG5tSE9mZU1URmRKT2tNSmpzWlpyMHl0anN3U2dUSEp5aWZSSU1K?=
 =?utf-8?B?dnlVSzkrcnZIL1JOQkp0RmlKTHhGYXpBQmtuTFprQ1pqNEF5YVYzMjJudzg3?=
 =?utf-8?B?MGZCMFQwWVpwWDk4Z2ZabGN1REw1Y2Rrb2pIUldFK1ovRldFaVlBaEVLUWNo?=
 =?utf-8?B?a1hKWVNKRGJNZ1FKbmVrbFBkVTJUZEJKUldHeHJuSHNlWlFVOGd5Skh4b0No?=
 =?utf-8?B?bXpLWTIra21WTDRPSlNicVZVenNNS2tiaW1OU3ZIRDRNbFRPZll4d2RVNTVC?=
 =?utf-8?B?bGl3T05qTTVoWEZaYVlnZW9sUE1aajRHNk5icFhuRDJiRzBiRzBGNm5QWm5N?=
 =?utf-8?B?Z0t6Vjh3SjdOcmlHajhKWllIWjhra2pvWFc5OENZcG9halpEeEQycDBxY0xy?=
 =?utf-8?B?eFl6a0hLZGVPUTZDMENzRFdSZndpZ2dlTnpjcE9rWENOR1Nsek92TTZkdk5F?=
 =?utf-8?B?Y2xtV1Y5dXY1dzEyVmdlSjhPTDRBQnBGall5emtxZ1pPMExla1d3VEVwRm1h?=
 =?utf-8?B?clpzRVBWQ0hxdThBT0hvbG9EZW1TT1pSZmwwTmt0M3A0Nys3dlM4c3dCRjNS?=
 =?utf-8?B?L1hMR2QrbVNwbjc5WHRrL2V0UmVWMCtWTlY4VEtQRnhqNGdETFJXdXEvT3JT?=
 =?utf-8?B?SnZLWHp2UVF2Rkx4Z0pKdHhuUGFYK3FXS0sxTzVZQ3hDMGVLRjRkMm4reEJv?=
 =?utf-8?B?N3FmTG5SNS9ISXkvRU9weDVHV0l1cTgvYStyR3podlJQclk0a2NkMUJNZ3Er?=
 =?utf-8?B?WmZOczJ3ZURnai83YUh5UnB4dytjQWY0QVBBb3JHbEtaTWF5VVIxZ1dKdktX?=
 =?utf-8?B?RUtXSmxKM1hCR0QzVmxzNmNtbmROUkNVMzYveTNXMzBEMk13NDh1OHhDZXpr?=
 =?utf-8?B?Qk8vSmV6aW1HRmw3YWYwbHl1ek1HajYyNG5XNFdmWlJkS1ZXZUh5eVBOOG5Q?=
 =?utf-8?B?c1RhMGZqQ0tHVHh3VWVkcnlsSjB4NWprYkpKZ1hKdkpZeDJ3OFdnRXBBc0c4?=
 =?utf-8?B?UEpGTUZvZG1ldDNnQncxeWNmSnlua1lsWERIMVdBcmZncTF1MWx4SHRKZ0Z6?=
 =?utf-8?B?TDhrRUh0enRmbGdGb0FpSU55ZHlKMGI0K0h0MHhJc3NwMFNpbEthSURPckls?=
 =?utf-8?B?QlNhMXRoNkRiOUh5MnkwUVZYRUlNNkxqRXlCR0dGWDNPRTJjcjdLSFlleWRD?=
 =?utf-8?B?WFBKeENkSElQSmN2MTluSEdBaDhhUjZMbURESVJxRUloblk4WlJ4cnFKZXNW?=
 =?utf-8?B?cytqbkhncysxSmoxOXdMRytlaTVVYnpoZUpMcmFUVmRaaWpiNkdBRkpSNk9C?=
 =?utf-8?B?YXg5OVEyQ1ZYaDh3bkltdlMzOHlrTFBTVnVES1NtRlBZeXBmT1FUdGQveUJl?=
 =?utf-8?B?L1BlVVJoaVdidzFjeVlJbnlKbEd5ME9VN1Z4d3VwOU9MeEM3UldzVGxtdzRS?=
 =?utf-8?B?SDdsYmhPbGRTZjdaTFplYXQ4aGdTK0FicXRoWWRES1FvR0lheEZtSVpDa3Br?=
 =?utf-8?B?Z3Q3Y25nR1hZbmI2LzJENm05bGpudGZ5UFlEYmxPMlRjS1ZaWnRGbC82dHNJ?=
 =?utf-8?B?YXM2cWNvRzVlUHF0cHFHcTY0NnB4aFhrTUl4SHlNcnBMTU1YSUhtSFFtSU5H?=
 =?utf-8?B?TmM0cmJhNlRHbFZ0YUJSSmtIelFMV0pRNzNJUkVXM0ZRbDNkaEY3ZXVQcGlW?=
 =?utf-8?B?Y2hRcmFLeXp3aCtvaUhhVUQwR3d2bEl3b2EyQVJRRE9NYldIc2ExUFFsSHpv?=
 =?utf-8?B?T2lLZnFTNGVOWGp1bkJ1QmtXWFg4K2o1cHdtNDN6N3BMWEtYTzNMUHlONUtE?=
 =?utf-8?B?T3FaSXRjTGdja0JZUkxGeWJFenR6OWtEZm5sZVNEOE5lbmg5NDZaVkR0U2U0?=
 =?utf-8?Q?lg7bXJI3QpL94tyP5JCOgjSEK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec27a83b-aa3f-41ea-4e23-08dc693317f3
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 16:32:14.7686
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5zXMFHW1CqMFsYIY1WcmmbsE07tXU8QjTvjBDjpeis7ni4jWZBXIT3bbVZ60hF1ZcP0vp4qQ3JII/cA4rwQ0+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7457

On 4/30/2024 02:55, Yuan, Perry wrote:
> [AMD Official Use Only - General]
> 
> Hi Rafael,
> 
>> -----Original Message-----
>> From: Rafael J. Wysocki <rafael@kernel.org>
>> Sent: Tuesday, April 30, 2024 1:05 AM
>> To: Yuan, Perry <Perry.Yuan@amd.com>
>> Cc: Rafael J. Wysocki <rafael@kernel.org>; rafael.j.wysocki@intel.com;
>> Limonciello, Mario <Mario.Limonciello@amd.com>; viresh.kumar@linaro.org;
>> Shenoy, Gautham Ranjal <gautham.shenoy@amd.com>; Petkov, Borislav
>> <Borislav.Petkov@amd.com>; Huang, Ray <Ray.Huang@amd.com>; Deucher,
>> Alexander <Alexander.Deucher@amd.com>; Huang, Shimmer
>> <Shimmer.Huang@amd.com>; oleksandr@natalenko.name; Du, Xiaojian
>> <Xiaojian.Du@amd.com>; Meng, Li (Jassmine) <Li.Meng@amd.com>; linux-
>> pm@vger.kernel.org; linux-kernel@vger.kernel.org
>> Subject: Re: [PATCH v12 0/8] AMD Pstate Fixes And Enhancements
>>
>> On Mon, Apr 29, 2024 at 4:56 AM Yuan, Perry <Perry.Yuan@amd.com>
>> wrote:
>>>
>>> [AMD Official Use Only - General]
>>>
>>> Hi Rafael,
>>>
>>>
>>>> -----Original Message-----
>>>> From: Rafael J. Wysocki <rafael@kernel.org>
>>>> Sent: Saturday, April 27, 2024 1:38 AM
>>>> To: Yuan, Perry <Perry.Yuan@amd.com>
>>>> Cc: rafael.j.wysocki@intel.com; Limonciello, Mario
>>>> <Mario.Limonciello@amd.com>; viresh.kumar@linaro.org; Shenoy,
>>>> Gautham Ranjal <gautham.shenoy@amd.com>; Petkov, Borislav
>>>> <Borislav.Petkov@amd.com>; Huang, Ray <Ray.Huang@amd.com>;
>> Deucher,
>>>> Alexander <Alexander.Deucher@amd.com>; Huang, Shimmer
>>>> <Shimmer.Huang@amd.com>; oleksandr@natalenko.name; Du, Xiaojian
>>>> <Xiaojian.Du@amd.com>; Meng, Li (Jassmine) <Li.Meng@amd.com>;
>> linux-
>>>> pm@vger.kernel.org; linux-kernel@vger.kernel.org
>>>> Subject: Re: [PATCH v12 0/8] AMD Pstate Fixes And Enhancements
>>>>
>>>> On Thu, Apr 25, 2024 at 10:08 AM Perry Yuan <perry.yuan@amd.com>
>>>> wrote:
>>>>>
>>>>> The patch series adds some fixes and enhancements to the AMD
>>>>> pstate driver.
>>>>>
>>>>> It enables CPPC v2 for certain processors in the family 17H, as
>>>>> requested by TR40 processor users who expect improved performance
>>>>> and lower system temperature.
>>>>>
>>>>> changes latency and delay values to be read from platform firmware
>>>>> firstly for more accurate timing.
>>>>>
>>>>> A new quirk is introduced for supporting amd-pstate on legacy
>>>>> processors which either lack CPPC capability, or only only have
>>>>> CPPC
>>>>> v2 capability
>>>>>
>>>>> Testing done with one APU system while cpb boost on:
>>>>>
>>>>> amd_pstate_lowest_nonlinear_freq:1701000
>>>>> amd_pstate_max_freq:3501000
>>>>> cpuinfo_max_freq:3501000
>>>>> cpuinfo_min_freq:400000
>>>>> scaling_cur_freq:3084836
>>>>> scaling_max_freq:3501000
>>>>> scaling_min_freq:400000
>>>>>
>>>>> analyzing CPU 6:
>>>>>    driver: amd-pstate-epp
>>>>>    CPUs which run at the same hardware frequency: 6
>>>>>    CPUs which need to have their frequency coordinated by software: 6
>>>>>    maximum transition latency:  Cannot determine or is not supported.
>>>>>    hardware limits: 400 MHz - 3.50 GHz
>>>>>    available cpufreq governors: performance powersave
>>>>>    current policy: frequency should be within 400 MHz and 3.50 GHz.
>>>>>                    The governor "powersave" may decide which speed to use
>>>>>                    within this range.
>>>>>    current CPU frequency: Unable to call hardware
>>>>>    current CPU frequency: 3.50 GHz (asserted by call to kernel)
>>>>>    boost state support:
>>>>>      Supported: yes
>>>>>      Active: yes
>>>>>      AMD PSTATE Highest Performance: 255. Maximum Frequency: 3.50
>> GHz.
>>>>>      AMD PSTATE Nominal Performance: 204. Nominal Frequency: 2.80
>> GHz.
>>>>>      AMD PSTATE Lowest Non-linear Performance: 124. Lowest
>>>>> Non-linear
>>>> Frequency: 1.70 GHz.
>>>>>      AMD PSTATE Lowest Performance: 30. Lowest Frequency: 400 MHz.
>>>>>
>>>>>
>>>>> I would greatly appreciate any feedbacks.
>>>>> Thank you!
>>>>> Perry.
>>>>>
>>>>> Changes from v11:
>>>>>   * minmor change for patch 1 "perf" change to "performance"(Huang
>>>>> ray)
>>>>>   * rebased to lastest linux-pm/bleeding-edge branch
>>>>>
>>>>> Changes from v10:
>>>>>   * pick ack-by flags from huang ray for all patches.
>>>>>   * run testing on AMD Ryzen 5 7640U without regression issue.
>>>>>
>>>>> Changes from v9:
>>>>>   * pick review by flag from Meng Li
>>>>>   * pick test by flag from Ugwekar Dhananjay
>>>>>   * picl review by flag from Gautham R. Shenoy
>>>>>
>>>>> Changes from v8:
>>>>>   * add commit log for patch 1 and patch 2 (Rafael)
>>>>>   * add missing Perry signed-off-by for new patches #1,#2,#4
>>>>> (Rafael)
>>>>>   * rebased to latest linux-pm/bleeding-edge
>>>>>
>>>>> Changes from v7:
>>>>>   * Gautham helped to invole some new improved patches into the
>> patchset.
>>>>>   * Adds comments for cpudata->{min,max}_limit_{perf,freq},
>>>>> variables [New
>>>> Patch].
>>>>>   * Clarifies that the units for cpudata->*_freq is in khz via
>>>>> comments [New
>>>> Patch].
>>>>>   * Implements the unified computation of all cpudata->*_freq
>>>>>   * v7 Patch 2/6 was dropped which is not needed any more
>>>>>   * moved the quirk check to the amd_pstate_get_freq() function
>>>>>   * pick up RB flags from Gautham
>>>>>   * After the cleanup in patch 3, we don't need the helpers
>>>>>     amd_get_{min,max,nominal,lowest_nonlinear}_freq(). This
>>>>>     patch removes it [New Patch].
>>>>>   * testing done on APU system as well, no regression found.
>>>>>
>>>>> Changes from v6:
>>>>>   * add one new patch to initialize capabilities in
>>>>>     amd_pstate_init_perf which can avoid duplicate cppc capabilities read
>>>>>     the change has been tested on APU system.
>>>>>   * pick up RB flags from Gautham
>>>>>   * drop the patch 1/6 which has been merged by Rafael
>>>>>
>>>>> Changes from v5:
>>>>>   * rebased to linux-pm v6.8
>>>>>   * pick up RB flag from for patch 6(Mario)
>>>>>
>>>>> Changes from v4:
>>>>>   * improve the dmi matching rule with zen2 flag only
>>>>>
>>>>> Changes from v3:
>>>>>   * change quirk matching broken BIOS with family/model ID and Zen2
>>>>>     flag to fix the CPPC definition issue
>>>>>   * fix typo in quirk
>>>>>
>>>>> Changes from v2:
>>>>>   * change quirk matching to BIOS version and release (Mario)
>>>>>   * pick up RB flag from Mario
>>>>>
>>>>> Changes from v1:
>>>>>   * pick up the RB flags from Mario
>>>>>   * address review comment of patch #6 for amd_get_nominal_freq()
>>>>>   * rebased the series to linux-pm/bleeding-edge v6.8.0-rc2
>>>>>   * update debug log for patch #5 as Mario suggested.
>>>>>   * fix some typos and format problems
>>>>>   * tested on 7950X platform
>>>>>
>>>>>
>>>>> V1:
>>>>> https://lore.kernel.org/lkml/63c2b3d7-083a-4daa-ba40-
>>>> 629b3223a92d@mail
>>>>> box.org/
>>>>> V2:
>>>>> https://lore.kernel.org/all/cover.1706863981.git.perry.yuan@amd.co
>>>>> m/
>>>>> v3:
>>>>> https://lore.kernel.org/lkml/cover.1707016927.git.perry.yuan@amd.c
>>>>> om/
>>>>> v4:
>>>>> https://lore.kernel.org/lkml/cover.1707193566.git.perry.yuan@amd.c
>>>>> om/
>>>>> v5:
>>>>> https://lore.kernel.org/lkml/cover.1707273526.git.perry.yuan@amd.c
>>>>> om/
>>>>> v6:
>>>>> https://lore.kernel.org/lkml/cover.1707363758.git.perry.yuan@amd.c
>>>>> om/
>>>>> v7:
>>>>> https://lore.kernel.org/lkml/cover.1710323410.git.perry.yuan@amd.c
>>>>> om/
>>>>> v8:
>>>>> https://lore.kernel.org/lkml/cover.1710754409.git.perry.yuan@amd.c
>>>>> om/
>>>>> v9:
>>>>> https://lore.kernel.org/lkml/cover.1710836407.git.perry.yuan@amd.c
>>>>> om/
>>>>> v10:
>>>>> https://lore.kernel.org/lkml/cover.1711335714.git.perry.yuan@amd.c
>>>>> om/
>>>>> v11:
>>>>> https://lore.kernel.org/lkml/cover.1713858800.git.perry.yuan@amd.c
>>>>> om/
>>>>>
>>>>>
>>>>> Gautham R. Shenoy (3):
>>>>>    cpufreq: amd-pstate: Document *_limit_* fields in struct amd_cpudata
>>>>>    cpufreq: amd-pstate: Document the units for freq variables in
>>>>>      amd_cpudata
>>>>>    cpufreq: amd-pstate: Remove
>>>>>      amd_get_{min,max,nominal,lowest_nonlinear}_freq()
>>>>>
>>>>> Perry Yuan (5):
>>>>>    cpufreq: amd-pstate: Unify computation of
>>>>>      {max,min,nominal,lowest_nonlinear}_freq
>>>>>    cpufreq: amd-pstate: Bail out if min/max/nominal_freq is 0
>>>>>    cpufreq: amd-pstate: get transition delay and latency value from ACPI
>>>>>      tables
>>>>>    cppc_acpi: print error message if CPPC is unsupported
>>>>>    cpufreq: amd-pstate: Add quirk for the pstate CPPC capabilities
>>>>>      missing
>>>>>
>>>>>   drivers/acpi/cppc_acpi.c     |   4 +-
>>>>>   drivers/cpufreq/amd-pstate.c | 257 +++++++++++++++++++++----------
>> ----
>>>>>   include/linux/amd-pstate.h   |  20 ++-
>>>>>   3 files changed, 174 insertions(+), 107 deletions(-)
>>>>>
>>>>> --
>>>>
>>>> Whole series applied as 6.10 material, thanks!
>>>
>>> Thank you so much for merging the changes!
>>
>> No problem.
>>
>> However, there are compiler warnings in the new material that need to be
>> addressed before it goes into linux-next.
>>
>> I've seen your patch addressing some of them, but there is still an unused local
>> variable to deal with.
> 
> Thanks for your reminder.
> I have got that fixed with two patches.
> 
> https://lore.kernel.org/lkml/20240430074857.2069301-1-perry.yuan@amd.com/
> https://lore.kernel.org/lkml/20240430074857.2069301-2-perry.yuan@amd.com/
> 
> Hi @Limonciello, Mario @Shenoy, Gautham Ranjal
> Please help to review and ack the patch for patches merging.
> 
> Perry.

They're simple and obviously correct and Rafael picked those two up 
already this morning it looks.

Thanks!

