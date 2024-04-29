Return-Path: <linux-kernel+bounces-162408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 154458B5AC6
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 16:02:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38EF81C21F08
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 14:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A316976F1D;
	Mon, 29 Apr 2024 14:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xPxDv7Qu"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2052.outbound.protection.outlook.com [40.107.237.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90803DB8E;
	Mon, 29 Apr 2024 14:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714399331; cv=fail; b=pTI3gTTGl0And8rzPaDwwTm58qK1vuPOtoIZ8Vl2qscAQIPKmIHWKkYf3LN0YsbNRnSPblktW8w/sxvkMxZmkxSAySwxcNCTGpjmU4OfXK/EspHLm9NDZ5e3EE/3KdeRVdq3mj9g1W9pdhl3JSKK7leDKJJtxZQG1riYsqL1ZWI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714399331; c=relaxed/simple;
	bh=Qqna3depW5UO/wMG0qw+qAbbqZe+YWG3tJ5iMRXYJWg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZEBwBDqud3RRWS5q/Olu3V0F+yDChKtxN+8khYafT+90UP60/mq7i8eVsS0XveOhZ7UwXlJfsDyQgGECf5qxv7btS22ykCdy06yAgbfThB8GARbMIyH3WZe2IQsDhOeDQKMhNQ/qfwB98AraB+6FkiIh8OMFGUyCTkVv558J358=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xPxDv7Qu; arc=fail smtp.client-ip=40.107.237.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qj7+30FIvCgZdIw1ebRNZqLG3MjTGx7VwhOHaDqhCjdzRE/oa+iBc0S4BZbEOcUlpvAAY2r0oNoo+KWEwTfrJTAntAd0N2w8jPuEu5YimIB+RBZlKWBr+E/TEE2Gqf3iyxkIMF/Uy8X5k2DP/NC1Wzf8U0lheLWFZZKBmr4tNrfHY5acuv2WlPBXWyxRO60ErLpOL36wHDLpGXGLjmBxJajOvofj86jsCiGc6R3LVhzrjRZPPhODUDvuj63xFZjysfB12/RbZu5+uIBZvZlMX0z44X2VJJMzZCYf6cv+g0T97u9+Jw0eKT6TRc9MqL+3qvfeMGak0X2zk3eFf9jj5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pp+oKSpv1Kmviyjva957tM3BpSoWzRvBJEzW9kraiNA=;
 b=PLP/j+9OAwRHCqSjVJUuTVLSTODVFadpIT+AYXPAZ0zhlI6q+JbV2Z5ynYESNHE/vmJvmUqxVbLR0e8ROcrilNgRJjSiJAG+vwkhrWFJ2XjXPj6ZLKiYKQSfPiV+kkFaqJjggEDNAcMSFLFt2HVqiUzqU4ahfn6oR/rpH2aISAyYW35ie9+7ZmGV7AXbUXJdkzh8xf78l0BUuxFjFR38T3JQAox/0O/cy2zqqEzKMf26BVY59w+Olqk+R72UyWtrq+2Gk5vDSXemRml0QYUEDGR/ecv3e/+GPhDvASinU0O0L2QAEAtlpGieu19XAJpdS7cN+QS5buLFaJAnJQsWLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pp+oKSpv1Kmviyjva957tM3BpSoWzRvBJEzW9kraiNA=;
 b=xPxDv7QuVMpK4JIWXyeemqd8Dpw4ZkvToiRMQV+mGnhPeAO/9LMEdlhhPIF1Qr2JvmVr49J2yareVK4m7AGjREJSHJF7I7iJ90iZWIbcQ8Z9uWYRaRPfIX+SUq5WaQ97NyRfRrIqIyGiKLnGRfmW+ck1OevajKKDFTaQ99JTOM4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MW4PR12MB6828.namprd12.prod.outlook.com (2603:10b6:303:209::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Mon, 29 Apr
 2024 14:01:55 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%6]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 14:01:55 +0000
Message-ID: <efd9226b-84b4-47e9-bbb9-68bd0194a8ef@amd.com>
Date: Mon, 29 Apr 2024 09:01:53 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: cpufreq: amd-pstate: Add co-maintainers and
 reviewer
To: Huang Rui <ray.huang@amd.com>,
 "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Meng Li <li.meng@amd.com>, Xiaojian Du <Xiaojian.Du@amd.com>,
 "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
 Perry Yuan <perry.yuan@amd.com>, Ananth Narayan <ananth.narayan@amd.com>
References: <20240429113356.1708284-1-ray.huang@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20240429113356.1708284-1-ray.huang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0037.namprd11.prod.outlook.com
 (2603:10b6:806:d0::12) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|MW4PR12MB6828:EE_
X-MS-Office365-Filtering-Correlation-Id: b9797823-76a2-4fab-1462-08dc6854ed5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YTlVLzcwMElubThQWktHbk5MWnRrc3hpRGpINE1mN0g3UWlkRUt6YUNmcXp5?=
 =?utf-8?B?TUJiWGxBazN1ZlVnZU9pYlgrWllrdTNTa1V4KzBTQVR1WDQ1MHU0UGhkYVda?=
 =?utf-8?B?dzhTQk5XSTlEZStvV0NvL2lib3VSRWtwcU5RQ2h1TEVhcXAwWG56Y0dhRHdZ?=
 =?utf-8?B?SUdvaXNGQXRWQ0RmTUtVMjFMRzhySHJGZEdHRCs0R2toSWxkRTg5U3EwRzNt?=
 =?utf-8?B?cVE4NUhyNFVsZFFtTnlaYStpMWw0TGgxMGFpZTJBYXJWTHVmMEN4OGpUNmI2?=
 =?utf-8?B?aHB3VFJ0dGs1UkZYUFgycWEzaytCanMzbGcvZFdmdWdRdTBHd3FzQ3MweXRQ?=
 =?utf-8?B?V1dqbmpyYXM4RHpibTZldENPNkhLcW9iODIyRG9UVFhPM0tERnkvUTJoM1BK?=
 =?utf-8?B?TVZMMnNPZWVtSzhSMzNjNGY4UGw4MG4waE01N1I5M1Jhck9JZS9VSGIyN0VY?=
 =?utf-8?B?Y05VekRJWEtTSFhIWGQ4V1lUcmt2UUtFWnFhNGU1UmZ5Zks0N2Yxa0hESzlR?=
 =?utf-8?B?SnNkK1FiOU5WTzBoZWY0RE9DWlNxYjBLK292a1VwdDZyRzQraTV6VkN3eEoz?=
 =?utf-8?B?VmRiWHBzc01US0NrSStZalZ1N3VKVEVjWDArTGtLbzArT1N4S3AxQURYRVhy?=
 =?utf-8?B?cTNrQjVQR3F6RVVDaFNEVDd1OGdheXJrc0lXVUJ2Z05WZW13Rm5JRjcraVNI?=
 =?utf-8?B?NmVheVZndmdQaWZXaldOSmJiZGo1Z3JycXVIc2VnZ3RTcmZ3WlhvVnpYeDVy?=
 =?utf-8?B?RDJOd04vSGkwOW5iQTR4ZVArVFRzelZReTNhUWJEc0xPUFF5T3U4UnB4RjFh?=
 =?utf-8?B?VUovRHQ0OXg1SFBmeHhrYVJNWHR5Z05XL1hNRFE0c0R0ZnN0dmpzYXFuTUZh?=
 =?utf-8?B?bm1sOFJTMTdZOC9DakZNQ1hyS1pIa25vaGNjcmZXTms1ci84eEdIT2hPUm9D?=
 =?utf-8?B?bHNNMWNqbW1KV3AwaytQOUpLb2xkZ1oveUJMUFBDWlBEOEpLMk13OCtOVkRi?=
 =?utf-8?B?dFlPUkV1U3B3QjZLVTd6WnM5L1RVZ2RkS3BYWVdvUEdMcEZuZWtrZVpVVzlX?=
 =?utf-8?B?ZTV1ekRnOHoxbnZxbGpwaTQvMXJyQVgydjFxZ09IU21rODl4RHFvQ3QzbWxW?=
 =?utf-8?B?YkNwc2h4U29CY29kZlZ0OXhWUmtQdE1INyttcWloM2w1Nm1kaHM3MGF1ckk0?=
 =?utf-8?B?b2ljOEFBKzR0RVlXaThWU1pQMmMzVVVENXA0S1hoMlhpMzI4QnpTaS8ycXBF?=
 =?utf-8?B?VFNVRllQaWpHQlR2MHpIdWFpVHFxaC93Ty8ya0wzSVFzbEM2U0NqVkRpT1VS?=
 =?utf-8?B?czZ6clRaMEQ0RlQxdkc3U0c1VjBIR0xEdStoVzliekk1UG4zUE9aRlNLbkxN?=
 =?utf-8?B?SzFQd24vYVN2bkRjWUdJZk9Vc2VpMnBGTVBoaUJHS2sxRmRRQXhFa01mN2FR?=
 =?utf-8?B?YnFVOUJiUzFZL1V5d1JnWUt2YWd4T2tYQTlaaDdmeWF4SjMrL01TbUdsQzho?=
 =?utf-8?B?bVlMMmczcUkydmdmYWFkVVBLTExQbTZQclU4Y1VGanJvR2xkZmdrSmR1cTZT?=
 =?utf-8?B?elYzMXBGM3NsZzUySGhuZ2Z0djBOZW11Y1NLMHdNbzJOS3EvdnQ5NmJ1L3Bo?=
 =?utf-8?B?UGZXTm40UzA2bk05NDBkY1kycE85RlFBTGk3RXRGekxqcHQ1K0dmaW1qTTFi?=
 =?utf-8?B?cGVmZDVuMnRuTy9IajE2OWtoTnhzYThaZnVBZ2l5ZUxDZVdtaEgvRmFRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WmFEY1NUNHBIL2ZRRTU1MEtGTmRudDlZN3lCMyt0ZU94V2hmUXlmLzdCOWNK?=
 =?utf-8?B?c3hnRVFKTkJnSVBmdzY0T0l5KzVEUmIvRGtIK3JTRi9xMytKUnRxNGdzaUV2?=
 =?utf-8?B?T2gvODBtYnhtbm10OE9EUThCU1Z1cTcwenZFM2xwZVBVTFRsdGNQYXdFdEs1?=
 =?utf-8?B?S2VUZDk2emhQTTFLOTU0MGROQ0xIT2tmWmx4WUoxY2dqM2J6OW5DZDdVTTZL?=
 =?utf-8?B?NE16aEFHbWJnMzRDbkRWc1duNWs2UzNWenNOazBhS1lhKzhJUXdGWkE4U1c1?=
 =?utf-8?B?MDhsWmZoaWFzZnM1V2NlSjNlVXRpS0FCQUFyelY0OVlWaXdBVlJqODdvc25r?=
 =?utf-8?B?ajJOZStOSHlyL2N5VnplOGc1U0o5Nks5SDhJSTdSK1pRTEk3aWhHNVhUOG9r?=
 =?utf-8?B?bVlYWkN4bWRmSVpOYW5CQk1MV21mWVFHRzJGV3U5c1BzZm9TY0Z4eC9xL0NW?=
 =?utf-8?B?eXJTbndkZHI5NkpDWVcxTXUrV2NHWWhueXdQQjFlL1BWRGRwZjg5dWF1aEN1?=
 =?utf-8?B?eTJOOFZ5Z0VmZUNPdW9FeXNra0J4OHNFWnZTVEY2eHd5QmFMS2pTTmI4Y3Ix?=
 =?utf-8?B?Z25EclhKajQxcFZzMmc5N3hoS0JSclN0c2FaQ0VnQ0xlc0RzcnZYYzZqNHla?=
 =?utf-8?B?b1JnRCtHU2tranE0dlgwYlRjTkZYcUhuUjRIRm4xTUpqZ0d3dDVMUmRTTzUr?=
 =?utf-8?B?dVBhb1B4Wkpkb25yZDU5QUF0dUxwL0ZmRXlyMkFVNVg3QVlhOHlBVVJKem0z?=
 =?utf-8?B?eTNHaUhERUp1NkQyWnZUcnBMUTVWbVhKbHNlbE1ocVp1czBwMEZ6TmdyV1Fq?=
 =?utf-8?B?blhCL0NjRWJIeWg5LzNKZkR4U3IxVjZQT01tYmxpcStjMjlMc2dzV2FUY3J3?=
 =?utf-8?B?c2l0T2pwNjlYRDNWV3YycytYcTFISGg0RDFzdlQrK0FYQnNWUTFFN1gzUWV2?=
 =?utf-8?B?bHh6MlRNMFo0bjcvWkthNzhEcmRTcG1hZ2lPNGxpempabjUySGpmVGJkNXVG?=
 =?utf-8?B?UENDcTFBUVJrMjNEakM3WVMzN2JweXdZZ3FFYlIzNy82V08yMzVpN3N4aXhl?=
 =?utf-8?B?NWVnUHJLRWlHU3Z2Nmt0ZGFTR2FvZEpWNXpZR1lpK0VEaXQvRzhmbXN3YUF5?=
 =?utf-8?B?dktHYjh6UHhTODNTelp5ajRDZzRGcXV0NmYzTS9jM3cwbTQ0ZkM0K0xYTUMw?=
 =?utf-8?B?ZUtlQ0NLSDN6YkEvNGlyc3Y1QytZZzlKYVhrMmZtaHd6WU5ZL1RNRWJ4dXdP?=
 =?utf-8?B?TXUxNmpYSHlGQUxwUXZuaEFXRGZpanNFRUpGUjJhOXJWcEpqdnpFbzIvcFNi?=
 =?utf-8?B?OFQrZWNhZHU1UmpBb3JmSDUyL25pSnM2UlhmdlZnTzBNSURpdk9ERFloVW9Q?=
 =?utf-8?B?eWtJTVR2QUtXeU5LcTk1ZjJrNUJubHdVMStONWlYSUc1cnorZTZySnliOGQv?=
 =?utf-8?B?MzBSeVU4SlAvMzN5OHJrN2ZJd1lyTHR4UTd3R1ZvczRnRjFxYk1EY1FrT1Vm?=
 =?utf-8?B?RmdqSGdyVVRTZHdrVEJXcFpVeklxdm81VjJIdkdOMGRxdE5nUGplV3F4MjlB?=
 =?utf-8?B?UFl4NEUrL1pGbVdaOFk2L3c2Zkl6WmgzMENQNDdyNDVSWStFRTI0NlhvNjI4?=
 =?utf-8?B?V2JwVlJma0NCZSt1STFodzN3clkvM3NLN240aWFqTzZPbUt0QmNCd0JBcGE0?=
 =?utf-8?B?OGlOd1lpNytFNG5BNVNNZkVKWEo3akxvK08xOXhNeUErK1VTM3FlUVQ0bEVF?=
 =?utf-8?B?VWd1MERBUlFqVzlyZE1ZbjdvQnJ0aXc4eHRUeDZsaFFWenh4Tkh1enBCOWh5?=
 =?utf-8?B?VGpRQ2NjMmtJdmt1a29YYys3di85eHJIdWkrQWJUQTJ5Y2Z3dUJPcm9MTFZ1?=
 =?utf-8?B?K1BRL3ppQlpqdHljaGZtYTV2STdQNnBuL2FMLzdXREFCOHR0MkNPTjJjRHox?=
 =?utf-8?B?cGVGM1dMVGdKVUhsQ1BYNGJrcTl4NlhUaUFTNGxjNjl6LzFpK0JKVTQ5NWcy?=
 =?utf-8?B?ajJKNmdRNjFEaUpuYmpocmt0VFVHakdvM3Y1MTVucHlUbHc4SnF3VTRRaTVO?=
 =?utf-8?B?UTVNMjBBNkRMSDRYRFE2dUl1a0pNclJqYURNdVdxc0kyM1V3QU05cGxIQU1q?=
 =?utf-8?Q?KZjvxNQePAA4xM1DAF5rIt5/U?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9797823-76a2-4fab-1462-08dc6854ed5d
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 14:01:55.1629
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JFR6mYM6nBBUJth6jOYt2bPMvwZx6oJi6Q/fshMINqkJiLOZ+5LnfcHlFnkunzJpmIROJR2uTtRsU9KmDTy4Qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6828

On 4/29/2024 06:33, Huang Rui wrote:
> I'm happy to add Gautham and Mario as the co-maintainers, Perry as the
> reviewer for amd-pstate driver.
> 
> Signed-off-by: Huang Rui <ray.huang@amd.com>
> Cc: Gautham R. Shenoy <gautham.shenoy@amd.com>
> Cc: Mario Limonciello <mario.limonciello@amd.com>
> Cc: Perry Yuan <perry.yuan@amd.com>
> Cc: Ananth Narayan <ananth.narayan@amd.com>
> ---

Thanks Ray!  We of course talked about this offline and I'm happy to 
step in.  Having coverage of two people is also good for any OOO 
situation in the future to make sure patches can be reviewed in a timely 
fashion.

Acked-by: Mario Limonciello <mario.limonciello@amd.com>

> 
> Hi Rafael,
> 
> Recently, I was assigned other task of virtio-gpu support for Xen, so
> apology not to review the patches timely. After discussing with our AMD
> colleagues, we want to add Gautham and Mario as co-maintainers of this
> driver from server and client side. If one of the maintainers ack the
> amd-pstate patch, then this patch is good to be accepted from AMD
> perspective. And also add Perry as reviewer, he is actively contributing
> the patches on this driver for a long time.
> 
> We will try to keep the patches reviewed on time in future.
> 
> Thanks,
> Ray
> 
>   MAINTAINERS | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ebf03f5f0619..96644624308a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1062,6 +1062,9 @@ F:	drivers/gpu/drm/amd/pm/
>   
>   AMD PSTATE DRIVER
>   M:	Huang Rui <ray.huang@amd.com>
> +M:	Gautham R. Shenoy <gautham.shenoy@amd.com>
> +M:	Mario Limonciello <mario.limonciello@amd.com>
> +R:	Perry Yuan <perry.yuan@amd.com>
>   L:	linux-pm@vger.kernel.org
>   S:	Supported
>   F:	Documentation/admin-guide/pm/amd-pstate.rst


