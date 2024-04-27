Return-Path: <linux-kernel+bounces-161065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF2C08B46A4
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 16:30:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 867592826E8
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 14:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F863A47;
	Sat, 27 Apr 2024 14:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uvZby1bw"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2049.outbound.protection.outlook.com [40.107.93.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9648463C;
	Sat, 27 Apr 2024 14:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714228230; cv=fail; b=hBX1cnVE5MNRgWi/3WFTuvMUCFuyO1W72UeNrtBFNq65gfP9vmQWRofWPL0alsK2rvTSL5sCAhYCOvdNXiP8TeRu8TgH6hH/TcECKbajraU/3BerVA8tNFtlOvLo6l6E5pyZyG9p5dka64AMZQtU2S1KKOi+o5+psU9remNE+eA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714228230; c=relaxed/simple;
	bh=PWoOmgiglH3oyYv0s5qy9utGqwvkPdepdLdDNN8Wo5M=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tFTgkcEOoIZe2M2b9cwzuiYknhoVa3V8J8R6dS3IAfM0qieDE1TjqXgIPM+Ro9xnkrx7aWJyBjvYtdN5/8m6NKJ0eik5ZHAD7Bzbwm+T/XxoUoUvQU009wo9I6f6HI+mYyz2saX1OtgCRINbeWTme0o/PSmKJ8wLgJsHTW0IeFc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uvZby1bw; arc=fail smtp.client-ip=40.107.93.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CaKIYnk/JFxnOhZZGSdeirx/vwxhEb0fohdNji1fSQTjLN3EJ9Vv8cqb4eyDpvy5KAh1Ii3J4lM+YlPtmoX+e83/7w7ZisdRRtwF1hVGu3b+DTDWtHRGyFvx6VjB+C2H9cC/ikyOGPTU8DAqZlwPDe+cJTzuPNWuQbZfWD86nE2Umbl5TD4yHFksYm3OBCp0I/dpDYbvjwdDuuZT4gYlhIpma4YoiYyAzxk2flohoxMd44EnA4lAOHruPBFxqsKilv75GHgpIlF+Yl7rcylVH0u9PuJ5kGZBp36j1vMuhHn6GpHiy9SJJ66v3OXvlxB5WOdcpuGrCUmwfKxqsK9dLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1mJRWkZCtOg1sSrURA7Aeq796W2Vt0UARW96G1ZMPDA=;
 b=ka4EWeXRd0zK2QoHy2y+5+Aie+OQo7WmOvGumSr/obD1XYNQH6aJqp4zIrMCJ5VBWO0NnOPPmTmD7IisElEiYB8S59AmQSXLpHzil09gSa1or7TXQig0w/7TIywRF4quppt0exoWfsjhUk8fJ/HKUwgfuSqrX3XnVItK7gzK9dNwuxpKwnwsdlYQHQp/P2x0iJ1q7Wg4P37sUjpGPOQsGo4mdGXmhmmh1NWymuuJpFBJxcuIEetxEc0KbEFlkQQcGY95Ph/uWiL1RgFIY5fzNvLb99P8gY5rIzFjBIrQTXs1VgAPCnMhcQConDXnKYAC/nc3YxIYLmJZloVD3J+PaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1mJRWkZCtOg1sSrURA7Aeq796W2Vt0UARW96G1ZMPDA=;
 b=uvZby1bwuvvqrvyNG03Ukx4bVQKz4fOukFxvPFk+httTRuqWjpRKtrRvx6l+gHpfWj2IP5NEbI2TPXhgIjlVRCiU9WyTt3BASoBN823vlIKBCwrUogfRl3oFQU9eDA4bYcIYZ4mfJHFtxBqxceMIp2LW8LAtvaZn0xuvT+EFxpU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by LV3PR12MB9094.namprd12.prod.outlook.com (2603:10b6:408:19e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Sat, 27 Apr
 2024 14:30:26 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.7519.021; Sat, 27 Apr 2024
 14:30:26 +0000
Message-ID: <4cc228c0-a9d0-405a-bb5e-5b049ac39d17@amd.com>
Date: Sat, 27 Apr 2024 09:30:22 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq: amd-pstate: fix code format problems
To: Perry Yuan <perry.yuan@amd.com>, rafael.j.wysocki@intel.com,
 viresh.kumar@linaro.org, gautham.shenoy@amd.com, Borislav.Petkov@amd.com,
 Ray.Huang@amd.com, Alexander.Deucher@amd.com
Cc: Xinmei.Huang@amd.com, oleksandr@natalenko.name, Xiaojian.Du@amd.com,
 Li.Meng@amd.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240427135249.2160493-1-perry.yuan@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20240427135249.2160493-1-perry.yuan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0088.namprd11.prod.outlook.com
 (2603:10b6:806:d2::33) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|LV3PR12MB9094:EE_
X-MS-Office365-Filtering-Correlation-Id: f1d1402b-f344-49ac-e140-08dc66c6949e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aDJnTXU2M2txRWNvWWZEeUFJeitQdzk1OGo4UEowR2xlbTkxc2FUYmliOTUw?=
 =?utf-8?B?RkFOS0JJNjE5SFpDc0liYmpIcmRWTi9aOCtRa05jLzN6cW1PdU4xalI5RFJl?=
 =?utf-8?B?WGh2bEZlemJoYlZzUFBmaEI2ZXQ5TnFxNURxNElsVXNSRHlhYXFKNHVsUitt?=
 =?utf-8?B?UGwvYVdKTzJiOW1JVVVTbFY3czFrSm1aWXFiNnpCaUNhRXl2bXVBNm5tcWU3?=
 =?utf-8?B?a2daWFJvTFR4eWxaQktLNTVGTmdYcHdmT3FCek1iY0NEc3l6WUxQbGtpdjcw?=
 =?utf-8?B?WDV1dmczcjJNZWlqMlhHVDVocE5OQW0vcUZoUERLbGVVQ0NWQ0Yrb0gyZWZ2?=
 =?utf-8?B?K3RhYXdxdW95SzJXNlBpUHpiOFE2M2dmOXlsOWtPdVlCaHFaNG9Ub1NkNFZ2?=
 =?utf-8?B?NnEyOXNOaGo0RGxWTG1lVDdBcVdIcGRHVnJhK0IrcUFvRVBWajlIaXMvdE1i?=
 =?utf-8?B?UEl0YnRNVUpnOGRTOWJaLzF1TXljbnczeVBHd1hZTkloZTBWSFhGN1JleHVD?=
 =?utf-8?B?SjlHQmZzRytjNU94RHFweHRrdFZDWUlCcnJaQ2RDTlZpYnl1LzhOVlRxbUc4?=
 =?utf-8?B?QkQ1bWMvTENQWWFhL3daSFJXbVFSdFo0a2R2YjkzSEtTc3dqa3lnYVlXT0tJ?=
 =?utf-8?B?aDl1d2hTMGtZTWRadFQ4eDYrbUFWNytGNFJuMEpKcm9vbmFPRDEvRjZIVmFR?=
 =?utf-8?B?MHlhQlVlWWQ1UjNMSk5aRFc1ZnIrSWFzQldpL21FL25VYXpmNFdXdi9hYlR3?=
 =?utf-8?B?eG9tQkQxMkRndVZ2WVBpN2lOQ3Ayd3Z6WHIxUW81amJKN09sMFNoQVFITU5z?=
 =?utf-8?B?ak1FMGZ2cjhOdmhsYTJ3cWFXVmN0LzNYWUoyVlBiOW5QR2thdjl6cStwN2lx?=
 =?utf-8?B?cEtjeTJGTkNIbXl4cTVNNXcwdmN1Y0R2RHdNbXJlRmFpb1Z1dms2c21aeEdi?=
 =?utf-8?B?NW81SU1pUmNwL295MDI3WS9CdHlaZnJBelVYNTlQYWszRnZoUFdETFZJTGxT?=
 =?utf-8?B?MkNubllENEJpanV1eFBlc1ZaQVhLdGtUaWdBUUU2ZVBXeHhQbSt5akhtRk5l?=
 =?utf-8?B?Uld6RENJTmlVZmtLcjdPaDV0ZXpvQjdGZkpTNlJmMHN0ZzlTeTlweC9rNHk4?=
 =?utf-8?B?OUVvL1Y1RHdSTm0xV3hUck9oTHdla2o2ZVZnSEpWMTkybktBamRFaElYUDNj?=
 =?utf-8?B?QlR3YThUcDhYQitqdzZMbFdra2ZEcUltZjYydDVHRDlTYmhyNDFjUUZpSDlq?=
 =?utf-8?B?Nys3aWlGTFIyOTBieFRBV2NrVFpya3k3eXJGYU9haWNqVUlEUzlvWkl3WlZp?=
 =?utf-8?B?aDRvczZsaENlSk8rY0lsSnZNdTJ0aW9kMnFHbmd6VHgvaXc5K2Fhc1dTQ0x1?=
 =?utf-8?B?MzN3dkloZjlUZGNlV29vdjlRaW9RTnBJdUpEQSsxRXdydXUrUUw3VGwrcjdI?=
 =?utf-8?B?WXpnamtJakQ3L3VkK3BUZkkwK01xcWdTT1JkWTJLNFd0K0E0aTdwQXBmNkZp?=
 =?utf-8?B?SENMSzZCUXVCWjRRQTN3RXBRMHJpSGkxOG1XVjR6cG92NVlJK2FyUXdQbGZW?=
 =?utf-8?B?aHVFN0JiREdqVzhHNGdHMkE3SlJrNUhNS2J2L1I5WmFYNkhGdm5pKzNEWCsz?=
 =?utf-8?B?aEs3S3Q0Z3VpQkR4ZGhZVmsrY1JTL3pFaWpqSDNFNW9Lc1A0Uk5IeTdTangy?=
 =?utf-8?B?WUlXV1ZlUzIzWWVnT0REeU5oY1dweit1dDZnSHM5eklyTTRLREh0cUhnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RFNheWVZbHBCK2FtTmkzRHRUdkNlNEs2VjZyRnFsWXFDZXRpUXZabWtyMy9i?=
 =?utf-8?B?TFJtQ0hpdExURUxwK0lUTm1UTmo4OEUrSjBVU2ZyelRFYkc3SG81NmlKVEFl?=
 =?utf-8?B?YXNtMmExeXdYclZVd0l5NHhpRWJrazl0R0tQdkE4TXg3M05JRHRwS3FSLzlS?=
 =?utf-8?B?aFY1dVFIeEJTNlNKWlIrK1E0bzRSR0h5MXIrYlY3T1AwaklZWmtaQWw0Nitm?=
 =?utf-8?B?R1NXWGRqMitUSTFuQ21PWnMycDUxSWhsYjIyZXF0a1ZtejltUTdzVFpDbkdv?=
 =?utf-8?B?dTh3UFdtVzUvQlNUN3VkNitIeWFZM2Y0Zy9HbUxNenpZMktjc09acld5SzVW?=
 =?utf-8?B?b3lCT210SWUwT1RjRWVIUUFhN3BOVno5OGJpNkpaNUVUSzRRU3JhYVk4Sjha?=
 =?utf-8?B?VnNMeHcySmVwc1FCeTRxUWhmTEtEay9QZHg2TThPVVFhZlJ0WGZSNjRjZWMv?=
 =?utf-8?B?UCtJTUhJWW1XWTNpZGplN3NKQnlESXRiNG1xalZkeE1GdERCYmRFK1BpMjRj?=
 =?utf-8?B?VHJDYjRXbnZ5V3JYdnFFeUN3YWx4L0FDUUcveHpaSFI5S2ZQYmc1MDIreW9N?=
 =?utf-8?B?VlZHeThabk9kSk1Sd2MwRXd0R2piZGtRRzgweHFBVlNxWW5pMEROZHorbmw0?=
 =?utf-8?B?MlRQSUhqWkVBdjZRdWhMc0cxV1MrTXdvalNDTnh4dEU0N2ViQ01JNTVIZEcw?=
 =?utf-8?B?VVN2eFdDalRIU0xHemxpQlAvSUFJOVVBQUdlK0Naa3FneFpNcWRGOWpNc2Iw?=
 =?utf-8?B?cW9QelhDQ1RqM00yQkpBeUFJbm9YZFUxRGVPNU15S3RwYU5rUHNpWjBWamF1?=
 =?utf-8?B?bXpDQmlrNktpSDNEM2JzcmFib3Nuc2ttSHh4Umd6b09jc1JzS1BMeExsVFFx?=
 =?utf-8?B?WUtQd1VFc1d0VjVTQis0UjkyUmpERUNmVk5ZRFhLNlRuMmFGL2dKMlFEaWJx?=
 =?utf-8?B?Z1lHYkpCSDV4YWZFSitGUEhsdjVYK09xMXB6Tnp5MGdsQTdWdHhqWFBpblMr?=
 =?utf-8?B?NDJtNzJaSmk3clRmK3dqMmRjWW5za2Q4ZGZtZW5MNDJTL25VTCtLT3VFSWRo?=
 =?utf-8?B?NlpRY1ZqYXJ0Y2JCQ3hYNUVWTmxGMnRHOC9Qd1pEd0cwV3hXeGU4a3g5dmVk?=
 =?utf-8?B?YmpwRDhGT3pKZ04wdG1JZjJ4bTRVa01hWWxzRnB5UnpVaDFSMXY0N3ZJUTVX?=
 =?utf-8?B?THRuMVNnbnQrLzROdGZBNFJOcjhqMmpLUWJhYm5CUmM3YUN4STVyRGNEd0FK?=
 =?utf-8?B?YlRKOHY5UjVzalg2SXU1b1k5UmpocjBxTGZJSVQzNW5DWWdoVWhWOWtCRnpa?=
 =?utf-8?B?MVlsaURKQ0FmR1JQcGhTU1pLZkJDTWdSUzBuaUcvaFNpcFdueVByQk41cUds?=
 =?utf-8?B?c044SWxrbHVjU1RNN0VjTEM5L3Y5V091bFNEamVrTnAyWnp3MGtnTjVNUVZy?=
 =?utf-8?B?NS9abzkwNktvUUVoNGM3b3hvUHBNZ2xaMUpNRHY1NnVWbzFRc2F0NVFPN0FL?=
 =?utf-8?B?b1RqUnIwcGhXT0t2YTQ4SUdSOCtnbHZqZnhIYkxtbmEwS1U3T29TRWdyS0JP?=
 =?utf-8?B?UEpkWFk5YnVaYlk3WjZKSENoZTVBM3B1MVNTd3YyQUgramRoS2JLY09DNVkz?=
 =?utf-8?B?NkZsNktBaFRmempWSW52VjFFWjcwTmthTHRGZFNENE1YdGFjR1NJcVVKMWRC?=
 =?utf-8?B?Yk0zWVNPVVNodUJMOTh2V25GeStLaGtSZ3F4WXdZUDhSSkVlNEtsME9rcnVW?=
 =?utf-8?B?YnpjeThlaGhXVjl1emMrY1Y0WnFpVS9hVXJBSUlvOG56eUxMQkFSbEd5RmhO?=
 =?utf-8?B?RkMyTlBZVUZlMzhUWG14TXVTMUlFYjQremJBTWdIdnR3ZE5vdjRvQ2xkcTN5?=
 =?utf-8?B?bDRQTUZ1YVkxTnRSSXJ2STljMW9IOXhXdlVKalVuMHU5cDdtM2k0Y1VvaEIr?=
 =?utf-8?B?dU55MFEveDI4ZmdweEliLy95WnhpZFdGRkpiT2tTYVN6SVBHWEt4dzB6NXRE?=
 =?utf-8?B?bThqQW9naEM5VFZDTGNHeEg3Y1p3MDk4dEJyaGNyQm8zZmxka05mM1RJK0c1?=
 =?utf-8?B?bGZMM2pTM0V0dDQ4cm01dTVtNVIramR0bXJXOE01eTc4M3NLQ1hDS3Vwc0VB?=
 =?utf-8?Q?FJk7OTdngAQngPnHaIcJqDJ+I?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1d1402b-f344-49ac-e140-08dc66c6949e
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2024 14:30:26.3805
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uHMJqV3ngNdtMCC6JqqcrD4h/k6++WavLs/Lz4ygQBHCpPF9ntyDB5nFj19YRIiOcmyj/lV+e3ix+LGc8BKuQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9094

On 4/27/2024 08:52, Perry Yuan wrote:
> get some code format problems fixed in the amd-pstate driver.
> 
> Changes Made:
> 
> - Fixed incorrect comment format in the functions.
> 
> - Removed unnecessary blank line.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202404271148.HK9yHBlB-lkp@intel.com/
> Signed-off-by: Perry Yuan <perry.yuan@amd.com>
> ---

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

>   drivers/cpufreq/amd-pstate.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 83a29b257794..85656342a101 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -792,7 +792,7 @@ static void amd_pstate_update_limits(unsigned int cpu)
>   	mutex_unlock(&amd_pstate_driver_lock);
>   }
>   
> -/**
> +/*
>    * Get pstate transition delay time from ACPI tables that firmware set
>    * instead of using hardcode value directly.
>    */
> @@ -807,7 +807,7 @@ static u32 amd_pstate_get_transition_delay_us(unsigned int cpu)
>   	return transition_delay_ns / NSEC_PER_USEC;
>   }
>   
> -/**
> +/*
>    * Get pstate transition latency value from ACPI tables that firmware
>    * set instead of using hardcode value directly.
>    */
> @@ -822,7 +822,7 @@ static u32 amd_pstate_get_transition_latency(unsigned int cpu)
>   	return transition_latency;
>   }
>   
> -/**
> +/*
>    * amd_pstate_init_freq: Initialize the max_freq, min_freq,
>    *                       nominal_freq and lowest_nonlinear_freq for
>    *                       the @cpudata object.
> @@ -843,7 +843,6 @@ static int amd_pstate_init_freq(struct amd_cpudata *cpudata)
>   	u32 boost_ratio, lowest_nonlinear_ratio;
>   	struct cppc_perf_caps cppc_perf;
>   
> -
>   	ret = cppc_get_perf_caps(cpudata->cpu, &cppc_perf);
>   	if (ret)
>   		return ret;


