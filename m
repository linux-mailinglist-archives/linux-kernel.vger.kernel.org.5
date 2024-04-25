Return-Path: <linux-kernel+bounces-158669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E47BD8B23A5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 16:13:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 721C6287637
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 14:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DBD9149E0E;
	Thu, 25 Apr 2024 14:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cbF74ojF"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2068.outbound.protection.outlook.com [40.107.237.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91306149C72;
	Thu, 25 Apr 2024 14:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714054374; cv=fail; b=IUR4ZI2x96uXPxfStNnIPfWw5Po28m5CT/vglpdKvhg1yv/gU8uDiPsSzSqWeUgAJVwOGp/C97W6SiicSoCdrHMfy7faAJhmuBfQ2m0NUwmSbjAIc+YkD4QoiG5nYU+l+8FVDvlqI/gF7DzT+gKwH43iO91YhGgIxhpMz7+uZq8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714054374; c=relaxed/simple;
	bh=B6WHt+CH5Hy9yO81kX6Dp7XYlv+MG2xS8PvPmAxCPJ8=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VmvFXJIoHPeEukqX1ZQ6mfAU0rpZwQbbFfX721dTuXo0CXHw8E+FkCgjWkNN9DhvrKFbkl8RxHCZzwmigEccwgwX1knkC/L+tis1AMqQpFSv+rXlRfAWdHyi/nCnGPHuSvmm3Z0IjF11buumwCQFHVEUC19mdd4yc8bnJXi5sSY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cbF74ojF; arc=fail smtp.client-ip=40.107.237.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eWCCckN9NSupOpS7pJa4v2mZz2GrereKaua0F8eqCsJU6FhagvCfMkFzf3dNA7xyU5O0RlVbAUZFNTX82MaabTRuBjLCVdkTNmLh0Bu3dso5aHOccNlsaABEM4PJjnPSAH4wA2RDqHGQj8wO0ETsfRqOn1Jyf2zjcw+emCpZV5jIcSEXq/dHgKlVpylDP3D6ZhV0TncW3Jbh5Hfok2MGDVb9r77BUONQQEigD0o1aBPtC9PbLSDhClMtMMslg8avJwsoiUhK+2kQwaCT2k1Sk/NLUEEyO4GBIdzZgUGq9Ur441KA8ok21ttWSj2CUMu7kPz2Hzf5B3c7J0fsYZE4Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bJZ49GcJFAaGr0VugH+a5oJzm9AM9XDTgu1Xhcp0dD4=;
 b=iqNGYdO3Whx0vg14BEOXxox6xTMfQQpyBazq+5IrcgMdxNeOmEAWWRwa+tRazni+MR0gVAoLgdZdxWrBWrB+83X9xGHDMLdltIuYNnu2qEmCmylVl4zMd9GJlfpWLps5VPU/napRmWM3w4UU1+YPQ8sn8P3AIsnRBgi/RMWreC1EdqlspQ4z1acJDHRq2GvNeke8ptPXCdLhNqRj55LZ8L8Lh7u+lYmpwSJO8GgI8TjBNcCjAw9+In3RNWmaRJdCx7OE6hO+593vqK5fPM1bkubbTgXIqsA9JZu0JLHpQscd6sLt71//kFBpuBYE+swsnRwKC3SUWlj3oizhbNeCyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bJZ49GcJFAaGr0VugH+a5oJzm9AM9XDTgu1Xhcp0dD4=;
 b=cbF74ojF8yiNUxWHtCJ4N/gRqvle1TBWY8+zC+OSZm1QBKocexsfKrvc1Rj5DSMhQPcQmj8KXWHbPN9KHrobeRMvUYoKyedTrS6jErcvZktuWwbQvyb9zH0A0k5YWKLrHAghnvh4uQVh08Vl3/kHiHwWDZvJt3jwGPA++2L86CM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by MW4PR12MB8612.namprd12.prod.outlook.com (2603:10b6:303:1ec::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.24; Thu, 25 Apr
 2024 14:12:48 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::43a5:ed10:64c2:aba3]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::43a5:ed10:64c2:aba3%7]) with mapi id 15.20.7472.044; Thu, 25 Apr 2024
 14:12:48 +0000
Message-ID: <e0d10606-4472-4cde-b55d-34180efad42b@amd.com>
Date: Thu, 25 Apr 2024 10:12:44 -0400
User-Agent: Mozilla Thunderbird
Cc: yazen.ghannam@amd.com, linux-edac@vger.kernel.org,
 linux-kernel@vger.kernel.org, tony.luck@intel.com, x86@kernel.org,
 Avadhut.Naik@amd.com, John.Allen@amd.com
Subject: Re: [PATCH v2 07/16] x86/mce/amd: Simplify DFR handler setup
Content-Language: en-US
To: Borislav Petkov <bp@alien8.de>, robert.richter@amd.com
References: <20240404151359.47970-1-yazen.ghannam@amd.com>
 <20240404151359.47970-8-yazen.ghannam@amd.com>
 <20240424190658.GHZilYUvw1KfSfVd_e@fat_crate.local>
From: Yazen Ghannam <yazen.ghannam@amd.com>
In-Reply-To: <20240424190658.GHZilYUvw1KfSfVd_e@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0216.namprd03.prod.outlook.com
 (2603:10b6:408:f8::11) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3108:EE_|MW4PR12MB8612:EE_
X-MS-Office365-Filtering-Correlation-Id: c4adc1f8-3aa9-4383-abd2-08dc6531c8fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aEhpRzQrNWxYVGZXa1kwb1ZFZ21FSjJmUnZqWVhRVTVuSnlSeFJWbHBYOG40?=
 =?utf-8?B?WmZGbXVEZkVCK3lSbXlJWGlsMmcxQjNWemZVL2F4MmZLdXpuVXFTTzM1cTJJ?=
 =?utf-8?B?bGtzY09udkQ5RUxZSFNDMkluK3A5a0lPZzFlWG1DS01ic3o0RzljRC92SnQx?=
 =?utf-8?B?S200OVcwUHNaL3d5b3Z3aWxidzh6Q2VodTRsYXhXVGExYkNvQm9mbWFOdHBy?=
 =?utf-8?B?NWQ3STVUYVVobzhZWWRvZkVGSzVna1MvVXhFK21lT3NJZ0Y4eXJZN3dOOS9t?=
 =?utf-8?B?eHVCQ0wrM29rbGZTR05iVEwrSktVbkpTcGN2S1NITU5WNFdtUWY5ZFZqL2F4?=
 =?utf-8?B?UGtvbndINEhGdFZpM1A2ZlNnekpNTFNnQzlmWnhnRW1sM3cxalhFZDdTZFN3?=
 =?utf-8?B?NWpoQ3lncC8zNEhOU3QwYllDV3VSbWNoZnF0Z1NnQXdzSVpjSlZVTGZzUTI1?=
 =?utf-8?B?SmNHY25OeDFzQTlRM1J0dDB2cUcreG0ydHlZa2VaK3JJdFZ6Y0xNUVZaUmEz?=
 =?utf-8?B?Z0VuVmg0eklVekdnMlZNL0VsRjVVMVN5RUFEY3c3YUwwVFQzVlJVbUJWbDlV?=
 =?utf-8?B?dXdlV0k3MlVLUHh6QXpGK2pBeCtjRnRPa2pBRUh3WlM4cGQrTmpZMzZpd2Np?=
 =?utf-8?B?ZURFdjdMa2FoZFpDRVRla0NRdDJxVnA0WUNGM1AxcVFtNmtqL2oyb1pnMW16?=
 =?utf-8?B?Mzl1MW5sN3pDWk16VWtPZzVRaWRIcFR2UVVQTk10S2pGaGs2S294TTNveTZZ?=
 =?utf-8?B?bUZDVE16TXN4enczK1BMNnQ1UjRrWG1DTWRBTG4waGdoa0FTQ3NuRW5CVTM2?=
 =?utf-8?B?VjRrcDE5dlJGeFB2U0FML2NUaWpYMkQ3d2tiRno1Z0hlOFJHYTFuZDV3ck1t?=
 =?utf-8?B?cVY0Wi9IeFNHMXhITFpWaVVrbGNrekVMd0RLaXIycnhxK2NyQ2RMOWZJZTZG?=
 =?utf-8?B?SmdSQ3V4UnduQUNJcklTdHNWcUpOQmhJRnUzUS9xWkRSVEorQnhJKzlNTHlr?=
 =?utf-8?B?SWM1Q2pFSlA0dE5lZ1dnQjZBQnExOU1GK3B2V1llOTFJRUU5QXVDOWFlSDNh?=
 =?utf-8?B?RTd4c0FMWXVsVkI5QnJsRG1mdGNIN2NLUWM1ejJpeWNBQTJZNVhTSUhndzE2?=
 =?utf-8?B?UGVnK1dMMzhWT0R1U3NvTWlYMzZScllNWkxKQVQ0bWtTU01XaTRhWjdTOXNh?=
 =?utf-8?B?YXMzWWdLb2VrTFNaNnNzQXFveXM1ZGxvd0pRMVUxZjNmYXBSQnFNeHduQXBo?=
 =?utf-8?B?ZUNTdmdaWXJ5QUgyN0FVQ2hqSE9wMThKL3FMazB3YWRxN1VVeW1NRXBKbzVm?=
 =?utf-8?B?OFdMYjFnRTV4cjdwc1JNNlZpL3IzNldJVi9XVXBEVjlqQkFJdHpYcHBGY2da?=
 =?utf-8?B?MWNBUTRkWkVYakY2aTRKa1phcFRpVjZ1MlhTWWVwcFJMWXFrNlJOdDZveUJB?=
 =?utf-8?B?dDJ5bG9GeUZ6NkVXYVJCbWF5OHJLUm4vYkVjU0k0U2ErMEEzaUwrSWdSb1k3?=
 =?utf-8?B?dGFjV3BweGNxa2d1Y1BLWkpUVWRoMG45UStwSUhCYUY4dUJLaW4vdWc4L09a?=
 =?utf-8?B?MUNQTjdtdllqWVNxQVY2TmVRV3hQN0hXdGkyRit4QVYzTFhWYldhc1FnODBL?=
 =?utf-8?B?NXNqbk55RGNObzB5M21DMm9QdDFkOUVHTWY5NDVmR0NTUUxZYkpzdjVZVzZv?=
 =?utf-8?B?d0xKbHZ1d2YzanQ1cWFGNUFGQ0tKalhFSy9XUXN5N3h6VU4vYWhvWXJRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M3grVVdpeVFRWDk1T3kxVEQ4bGJlU2J5dXNzL3dXajliUE1ndjVzM3JaMm9T?=
 =?utf-8?B?VE90UG5ONWVYMDFLY2lsaGxUc1dOZzhCYW1TTDM2SFg5UktsZFluUy9odjZ5?=
 =?utf-8?B?MEJEVE9Fc0p6aHR0MEd2M1pvMkJJeVg1aGMzWGFzVlEzOFhUSmVFVUdQQnZG?=
 =?utf-8?B?S1FHRll6cnMrNmpDYXEwTEtwNmx3NHR4VEhpaDRJQWNnMlBrc3hIbk8ySm45?=
 =?utf-8?B?SktGZHZuTC9CTVNRMy8zVGgzdDFFZHUrZHZxQnZhblNRVE1Od2didzJubTZt?=
 =?utf-8?B?c2N1eUlJQW5xbEZ1OHZNckxVRzh4SXdnVXRLRFQxcEI5R3RqcVRYVlhnVldm?=
 =?utf-8?B?UFBVWE85MjFYbkVZVTZLakNEdFJRTndNeFdlZTVwSTRXUUpDY0ZHQnBvQURv?=
 =?utf-8?B?bWxyUUpVUC90NHlFVUpiUnA3MXBzNDUwdkNvZzRKV3FUUitkcEcvQjZVazN2?=
 =?utf-8?B?M3h1bUtQT1VCaXdkdG1nU3o3SFNKS0Q2bExOdmJLdXoybG5uM3drR2tDd0xq?=
 =?utf-8?B?SUFMTTlQaHZhczJlMmV4NVVscWlqUFNvemZwNS9LMUJBTXEwNk02REExTEM2?=
 =?utf-8?B?Z0gvbk4zMEtqby9idXJMOHlPZnZieWJwMWJWeHJsUC8zQWNWd0M4Z0lETWZ4?=
 =?utf-8?B?T215ZnBOUFR4VHFUZlBkS0cyTXFudWx5T2JWU25iRVJNZTZwS3hOMUVoV0Nh?=
 =?utf-8?B?emdYRFdxemhMSGVMNDJteGtzVGxubkNMa2Zlb0xpZW9TWmpRcnNPeWFsT2hi?=
 =?utf-8?B?dlViR2ttUGNVb0FwZHpVY3JUK0FvYXQ0YzdmcUdRd0thRlFhaEM1dHliRTBM?=
 =?utf-8?B?eEFZU2p5VTNaLytDM003WVFOUXV0SGozZ3NoZnNzSGIwSWJCTWhNT0xCSzU1?=
 =?utf-8?B?WjFpS1dsMithWitPcXdLK29tamlRTVB3QSs1a2NYVGp6R0tSSnlrdkFkSGRS?=
 =?utf-8?B?aU1JNmxiUTN2Yk45Z0EyYjlhUDR1T1RqK1Q3c0dzaTIzRHR3bkRlL1lLcWlN?=
 =?utf-8?B?blFDZ0VrTmJWcGxoeDYzd3RWUTRMUVJqRitZazhRcWg0RmViMGxvZjZPbGNK?=
 =?utf-8?B?elF3dkFtaG5kY1dDM2J2Rm1YT1NDMkV1eU5TelRMUlFycTJDdU1lblI4OWFl?=
 =?utf-8?B?a3RzcitiVEVHcHRHODdUdDJPdnFLdUtGU3RwV2VXZU5OK2IxbDdtK1NMaS9P?=
 =?utf-8?B?dDcyV09RQlJYOXF4NG13UGc4SjNCOEVRWW9qdFNaUWVDNk5aY3htREZFdk5T?=
 =?utf-8?B?ODVwZkttR0RvUVd2clR2Y1YzSWhhMVAyOUtqcWlPNkRlS2E2VUpjK3ZyZmxP?=
 =?utf-8?B?OFdKN1pNazZET201dkFhTGtlMXJsVDZnSkJVL2FwK0NUQU5xN29qT3JuQ01N?=
 =?utf-8?B?K0k4MS9IZ2orcENUZnA5UlY0eXBBMVlJcVdqZWN0SHhUNnNTQUxMVXFyczF4?=
 =?utf-8?B?WC84MWZhNlRMd1NIZUhUR3MvNkJsZVVWVk1BdlpUTlN5NVJ4ZHdQOWxNYVFG?=
 =?utf-8?B?b0dtSG16TUxmOTFDQmh3M0NQTEs1RDh6OTNSOU5kRFNOUkQ0c2hTZFVJNWln?=
 =?utf-8?B?dUtnYWJVekR0SXp2QzMwOGRodlFGbVZSTGdHdk5BUFhtTWgvQVJKVE11Zk5P?=
 =?utf-8?B?dVc0OHlLM1BXMWhmZEJIUzk5WmZCcXIzNEhVVG5ESlFsNkRwZm5oVVlISzVB?=
 =?utf-8?B?SmJPUXhBUkprUmZWa2lkWXVHZ1BYUWxqTmhYc3BYamJNTE5kNXc2SW12MGU2?=
 =?utf-8?B?ejRpMUJkWFltS3Q1QkpQeXhpczZGZFRMbW9nNEpOUjJkSUFUL3IrNmhNZmNY?=
 =?utf-8?B?RWhHN0RQT0NnaHIxT1pKT3dSWTJCazh3UE1xOGlVbWZIK3o5RXgyZnZ5M0FV?=
 =?utf-8?B?NXFQbUc4RC9xOTNEdWxXZjM4bkJSMVI5VEFabE5CV0dvam9RZThVbWtkajZl?=
 =?utf-8?B?NHRGWlBSMVZUWlRlVTRabng2b09YekpzSkQ1cWlleHAxREcrZ0RMa2s1RU1W?=
 =?utf-8?B?ZGcyTkt2R01lb1c2NjlSMVJ0OWtqV2FjVUsrcnFzcmVFVUVadGFMOURSTUpz?=
 =?utf-8?B?MlhSY3lJRVpjTTMzSmhTUGp6dkRlc1JiMFR3U3pKRStiZ01TdkYrMFUyR1JY?=
 =?utf-8?Q?b1NMAmJpjD3d6FfZWT8p2O6on?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4adc1f8-3aa9-4383-abd2-08dc6531c8fa
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 14:12:48.0367
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lr5/UofYqw160LAHKVPfQmL03MYc4klaNxqGxmlCINlxgfVNp5xSqQJ34ArZ7HuXdG3XAnWTZoQRtop9lGKd3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB8612

On 4/24/2024 3:06 PM, Borislav Petkov wrote:
> On Thu, Apr 04, 2024 at 10:13:50AM -0500, Yazen Ghannam wrote:
>> AMD systems with the SUCCOR feature can send an APIC LVT interrupt for
>> deferred errors. The LVT offset is 0x2 by convention, i.e. this is the
>> default as listed in hardware documentation.
>>
>> However, the MCA registers may list a different LVT offset for this
>> interrupt. The kernel should honor the value from the hardware.
> 
> There's this "may" thing again.
> 

Right, I should say "the microarchitecture allows it". :)

> Is this enablement for some future hw too or do you really trust the
> value in MSR_CU_DEF_ERR is programmed correctly in all cases?
> 

I trust the value from hardware.

The intention here is to simplify the code for general maintenance and to make
later patches easier.

>> Simplify the enable flow by using the hardware-provided value. Any
>> conflicts will be caught by setup_APIC_eilvt(). Conflicts on production
>> systems can be handled as quirks, if needed.
> 
> Well, which systems support succor?
> 
> I'd like to test this on them before we face all the quirkery. :)
> 

All Zen/SMCA systems. I don't recall any issues in this area.

Some later Family 15h systems (Carrizo?) had it. But I don't know if it was
used in production. It was slightly before my time.

> That area has been plagued by hw snafus if you look at
> setup_APIC_eilvt() and talk to uncle Robert. :-P
>

Right, I found this:
27afdf2008da ("apic, x86: Use BIOS settings for IBS and MCE threshold
interrupt LVT offsets")

Which is basically the same idea: use what is in the register.

But it looks there was an issue with IBS on Family 10h.

Is this the only case of a real issue? If so, then why apply this method to
the THR and DFR interrupts?

Robert, were there any other issues?

>> @@ -595,17 +584,15 @@ static void deferred_error_interrupt_enable(struct cpuinfo_x86 *c)
>>  	if (rdmsr_safe(MSR_CU_DEF_ERR, &low, &high))
>>  		return;
>>  
>> +	/*
>> +	 * Trust the value from hardware.
>> +	 * If there's a conflict, then setup_APIC_eilvt() will throw an error.
>> +	 */
>>  	def_new = (low & MASK_DEF_LVTOFF) >> 4;
>> -	if (!(low & MASK_DEF_LVTOFF)) {
>> -		pr_err(FW_BUG "Your BIOS is not setting up LVT offset 0x2 for deferred error IRQs correctly.\n");
>> -		def_new = DEF_LVT_OFF;
>> -		low = (low & ~MASK_DEF_LVTOFF) | (DEF_LVT_OFF << 4);
>> -	}
>> +	if (setup_APIC_eilvt(def_new, DEFERRED_ERROR_VECTOR, APIC_EILVT_MSG_FIX, 0))
>> +		return;
>>  
>> -	def_offset = setup_APIC_deferred_error(def_offset, def_new);
>> -	if ((def_offset == def_new) &&
>> -	    (deferred_error_int_vector != amd_deferred_error_interrupt))
>> -		deferred_error_int_vector = amd_deferred_error_interrupt;
> 
> There was a reason for that - deferred_error_int_vector is a global var
> and you're calling enable_deferred_error_interrupt() on each CPU.
>

Right, and all CPUs should use the same APIC LVT offset. If they differ, then
setup_APIC_eilvt() will fail above and return.

Why check "if X != Y, then X = Y"? Why not just unconditionally do "X = Y"?

>> +	deferred_error_int_vector = amd_deferred_error_interrupt;
>>  
>>  	if (!mce_flags.smca)
>>  		low = (low & ~MASK_DEF_INT_TYPE) | DEF_INT_TYPE_APIC;
> 
> Thx.
> 

Thanks,
Yazen

