Return-Path: <linux-kernel+bounces-162405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 41E4A8B5AAE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 15:59:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3346FB2C471
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 13:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C2C477F32;
	Mon, 29 Apr 2024 13:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oDufLfAT"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2042.outbound.protection.outlook.com [40.107.243.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380BC757ED;
	Mon, 29 Apr 2024 13:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714399025; cv=fail; b=QYlXaao+YQVyTn4H+XjiccDJjqay3HB1bQv1HPLjLAhJrI3+gqMK0aV2VeqKQV4tdPu663Ylr3l0ILOaIQQGPbU61+9vpYnGcvU/Yi8FpGj2/a9JA/A2DPeTTzLtKSouP0eWowXSJhSA0f0KcPgCdoN8wvqK4NXsbXQilRTU60Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714399025; c=relaxed/simple;
	bh=IGI35sVtwvAj0BzpbbZdlGVmhDTuGfqwR0KbokoD9ec=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GEzCjx+jeifz0prRU5oiQ2DIt0jks+4Tno+LKF6C5zu2o0vO8QwvzNv5+Z6pwELFjIl7M+Z3TWNqXMzsMCO2lDeys3B2JNrOmzATgzxV1xfQUwIK0UTgTZEUKfl1TTWXBasnF9nk3FxWSrpmsgdgMOV99iuoMn8HB3iDzSAcFrQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oDufLfAT; arc=fail smtp.client-ip=40.107.243.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dX2ixnGIqoCS2XqsW6sZqt+KGB6WadR+fqxDKO9xuwwSL5HHLBRVzcSA5jDMUhTbbwFB2QnRkJgtxQeCjvGH5I1jgCdw2964d9PGxfjBUyZyg1hsMTw60mO1rfxtGsmJuD5rcxHALrGxgGOiXgqFHrSFPnDvYlfw6sRG/aeNPpSc4p7lDJdVmF2SAY9f8JktYghauyLqbMoEJmEyF5I9TZa/gI0Z8EvNHU8ZVNEuANIreES/+Aa9cnYK/VLgBmmvt5kM4t/A2CS3SF22yjDHfRBd5CV2y81lDnMFPzp2DJMPzVC4bHW4BwrLLp511bAL2R7vw5p63RQKPjaB2fsTyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=03gl+AxuYBrh613FdJrLMKFMI38IJ7H9ioPoqYVYMhw=;
 b=ZAKlsYvlHyQ45uClBC4wPSNp6KTCeDmDbKex+BhT7Fn5H74AhbNd3kAsbcCBMdiNlg/wzKJcHidfmEPDR1me8CHiH1PUTnJKbYqKe3+LJNQqTM6JqKZ+Uq5LpMaQw44muSpRaiEcYMYZFwiKy4VGp7Ab1HKfQVhyK9JbGW7aqhKurEjCU5nYcT6fx5Fgb4Q9/lUg69dbIJE78QXhFEzS73lC6wNIeeueycV+8ddeGcpgdEAgTzENkjxLf9JB0bj5X1EogTQKAx+6uzAUSzFsNGjqRV9IJyi/Ygdh0uKTKIIu0qiARSevTraWWYzYiZrZ28hzRbHRI7YJZHOPFSuM3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=03gl+AxuYBrh613FdJrLMKFMI38IJ7H9ioPoqYVYMhw=;
 b=oDufLfATAvPFhUPdQVQeCj/AfYRYpaHVBzPJwnFTUPSa68MOU/OOPqRBl1lNR4aehLU6WjYvKErJEgJv7Mh7c53XA+ndqgQuACzh1uV30yJXmb6MKQPDaLoZ1UMW66/xmMQtLZPoQ6gbmQXDtGYTNwZwJtjC7A8LisThUsd5o0M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by MW6PR12MB8960.namprd12.prod.outlook.com (2603:10b6:303:23e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 13:56:58 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::43a5:ed10:64c2:aba3]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::43a5:ed10:64c2:aba3%7]) with mapi id 15.20.7519.035; Mon, 29 Apr 2024
 13:56:58 +0000
Message-ID: <d1e329da-6a04-47f7-bdab-ea6c4f584802@amd.com>
Date: Mon, 29 Apr 2024 09:56:56 -0400
User-Agent: Mozilla Thunderbird
Cc: yazen.ghannam@amd.com, robert.richter@amd.com,
 linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
 tony.luck@intel.com, x86@kernel.org, Avadhut.Naik@amd.com, John.Allen@amd.com
Subject: Re: [PATCH v2 07/16] x86/mce/amd: Simplify DFR handler setup
Content-Language: en-US
To: Borislav Petkov <bp@alien8.de>
References: <20240404151359.47970-1-yazen.ghannam@amd.com>
 <20240404151359.47970-8-yazen.ghannam@amd.com>
 <20240424190658.GHZilYUvw1KfSfVd_e@fat_crate.local>
 <e0d10606-4472-4cde-b55d-34180efad42b@amd.com>
 <20240429125956.GNZi-ZzN1Izxps8ztT@fat_crate.local>
From: Yazen Ghannam <yazen.ghannam@amd.com>
In-Reply-To: <20240429125956.GNZi-ZzN1Izxps8ztT@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN8PR12CA0022.namprd12.prod.outlook.com
 (2603:10b6:408:60::35) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3108:EE_|MW6PR12MB8960:EE_
X-MS-Office365-Filtering-Correlation-Id: 4186c59f-78df-48ba-8c65-08dc68543cc9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SVh4MklIOTN6YkJuQk92eXNkSllGK0U4MFdXeGFmK0srZTFGeDBCRjhsaUQy?=
 =?utf-8?B?d01GYi9rS1ZzR2ZSTmEwMzA0dEdLQVc1U0VFTkl4S1NrTU96WFg5bzBwazVS?=
 =?utf-8?B?YWQzYVN0dlk1K3dUZkQxL3hWWTU4cStzSDYzTEplRjVTSnpNZHJMNzNBRVcv?=
 =?utf-8?B?NzZydHEvRGp5NnVHK24zTTRHeEM1WU5waWNOeng1eVAvNGRCLzBtRXVWMUpN?=
 =?utf-8?B?WjhFZm1EakdxbXhqZlNFTUFMZ1ZZL1gweURka3Q5MW1IbDJzUzVhdEhKcEVN?=
 =?utf-8?B?RnFndld0aUhhQzVaWmpNakpDNFJhVW43ZnlBc3VNUnAyZTNYcEJrMlRrYXUr?=
 =?utf-8?B?Mld4WVRvbDJFVHA2ci95WXVzSGQ1YjRTYk5jZkY0bkhUanh6UW43Q0F0Tnpi?=
 =?utf-8?B?bzJ4VUNNL3pNSlJoeDdWdldWL3RzOHZRbjZLaU5lVktyQy9Ud1JRNWpVK3Ny?=
 =?utf-8?B?M1Y1ODRRN1NCZkhOU2xYUEtXZ3lhcU9WaGlwZk4rU0pZK3EySENtU1JPQ2Rx?=
 =?utf-8?B?cGkzSXhZRkJhdVBnbWpCclBLbDM5OWNsa0NDN2lDZDdvWGwrK2Rqd3pRa1RP?=
 =?utf-8?B?ZE94ak5uZ2VubDFqSmJDajR5T3lZK1N3K1VQN3YvbkxLUjRqK2hLeTRBaGZv?=
 =?utf-8?B?cDhwQmhaMnJ3SzhYV0R6dElSTDNKYSs4S1dITExqTmxCWlA0b2ZBTmFUWUo0?=
 =?utf-8?B?Q3k0VTV6b0xJcklhYkJFL3hycEU5TEVJSk9xZDdLSkpIak9DYWJvWkpoVy9N?=
 =?utf-8?B?V3JnWXBGQzFpZG5Md0tNK3plbGg1YXJNem5SdThWcUxBK1d3QWkxckMyVVRz?=
 =?utf-8?B?ZFZYWWlCT2RBREtXTURDS2FFY0tLZnZSelphYTNjdE0xMVpuVTd5Wngra0R3?=
 =?utf-8?B?amV0LzdCcXpsZmdZZ2Y1am9mVU1zTmxNT2tmcDJaQkhmdkwwZk5ySVg0SDQ4?=
 =?utf-8?B?NzRUOERJUW14Mm9WL2RMMUV4OUtGOHBHMFA5NmtlWHhNczN2ejRCekRWQVNN?=
 =?utf-8?B?TU42Y3NHZjlWdllXU2dIc1dJL2k3WmxjWTZVbzRNN2VIZGVXZ2JHRk1vU1dr?=
 =?utf-8?B?WkpHSE1SMFZXeXVXTVh1dXA0bmRpNXhNRVI5bExFYjFFeitTUVlNdGlpOGVj?=
 =?utf-8?B?QUpnS1ZueGxEWitCRnRTSEFhYllyMlJJMmZEV2hMSTRpOG96d0lGeGRSc2lZ?=
 =?utf-8?B?VkcyNG1oQVlJK3NZT0lTWTFnbWp6ZWJKQnNHK0ZpTGpRS05SK0gyMlFHcklU?=
 =?utf-8?B?SXlFa2dYTlB5WWNNVW1jaThrQ0dpdlJIZG55bHAvS0w5R0RGbDErcERFTFpV?=
 =?utf-8?B?SDliU2RTVXBFT1RWblpuZlo2TG9uNjZlbUkzQlhYMlJhK1Z4azhvbG1pL0ZW?=
 =?utf-8?B?bVpKSWlHOG5tdkQ1Z2wxeWhKRVFHeWh5eitxeEFOSVJ3K3lXMEM5UGxwVS84?=
 =?utf-8?B?VzltbXArRkw1ZURKT3ZZUHQ4RytZZnhXcUcxVEd2QkdyV1pXMk9EZ3ZZWWgy?=
 =?utf-8?B?ZVNBcU1kMGFrd2kvZytvVFZEL1BPOHpCWWhGdDVsR1pkcW9xZFhzK3pjZlda?=
 =?utf-8?B?NDdHdjlVNFpCazhiYmlDWVFsVWpURnJzSEZkVklRRHNrWGdnZHdjUkd2RnIy?=
 =?utf-8?B?bGZGeDNEejd2M1ZsTlJBMlRtZkpwY0lEYnJSSDFxc2dxL0lTM1FhUkk2Qkc0?=
 =?utf-8?B?WWlrMWd6bmdWdW5NSkplN3NNTkU5TEdoZGk0THZxSm8rZmkzRFNPalVBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eGNhVUlUVUw5Z0JmSDhRNU5RdlB0Uzhac1dndWVxS2tyR0J4b2N1dCs4SUZk?=
 =?utf-8?B?RnNSWmZMcys1MkFVRFpuYmJ4cjM0UUZVMWVINmQxOERTYk5peFVaRlgwWVZr?=
 =?utf-8?B?NExFc3JGdHgvWUFnRExsQ2M1cmM5aFdRa3JXYkVXY2xIMVRYenYzbGRQakU3?=
 =?utf-8?B?SnZSU2xpa01SamZPeGlVMlgrZGdtMTNnRFJuSXcwZTByeUtBdUZpak9waW1U?=
 =?utf-8?B?NlhNRFR1bHl0RkhFNG50U2NINko4Z21CbkhvcldWOFl1YmUraEhKSmkyUFNy?=
 =?utf-8?B?NklFa2JpQ2QxTE15Y2pja04xb3VZNG5BN3dYZ1hRYUdsazFXWjlMV3pUcG9Y?=
 =?utf-8?B?UkxGcEFkSmM0dEZsUUp2U0cyOGc4Rk9nTHFUWDhXTklXK3BiMU1nNDNvOVIr?=
 =?utf-8?B?UTNValBjOU9yMk0xUmtlVlBvVnQreWU5WEc1R1VkMlZaeDhOaXlnbnNIVHF1?=
 =?utf-8?B?QVV2ODdiWFIwTjdKdDh5YXF5ZEQzOTU3S2Z0V1ozQVUzY2czR0ZqVlQ2WSsz?=
 =?utf-8?B?ZysreUNxM05hWHRhSWVFSzNlalo4VU1NNldydWhtMk5KdVBDV29vTE5YOXRk?=
 =?utf-8?B?UmxSTS9XbllYRkUxbFZIRnk0SURyZ1lWa2c4U1ROQld1VHRLQnoyUkUwVVdU?=
 =?utf-8?B?YXdxbXlZWnhRSWVmWnFMbXdzRHZyOHE1SjJoaHRPaDA3V2V6UmpYelhUY0pO?=
 =?utf-8?B?NEFoTGU1SnJwbmt4SVBzV0FxaHdhYUFHcm1Db3VnTkpwbk5VRTdEZkFLdGZQ?=
 =?utf-8?B?ZDNrbUl5QzMwR1psTCs4R0lSdm5xVjhDUUhFSTBWV0hMK0hCOFVBZWsrKzQ5?=
 =?utf-8?B?OGxtaVBIbmlDWGplcDgyUVVkNjM2VjNMazVGczZ0c294SDJlRld0SkdZUDF4?=
 =?utf-8?B?Q1Z1S2R6OEQ4TW9LYXJ1UGpPdTJlVkI4TGdaK200Z2k0bWYxUjZ3TGpBNk90?=
 =?utf-8?B?WnJnUEtOUmxVUG03S0RGNWFLWVVJY3FEUGdsTmRZRmRlbW4zUCtRNll3SXZk?=
 =?utf-8?B?ellML00wSjM4Y0VKelYxcU56SkNCUFhESTByd0ZEYjRiMkYyKzdDV2pkMWJ3?=
 =?utf-8?B?M0VzRkZJdG9FaEFJbkxyNDNTVDV0U3BxZ3FDeG9SVzRvcTlqQ1h2emQrdXN1?=
 =?utf-8?B?d2tFRVhLL1J0RDZYb3VrMmJqVmxtYnNabTdiZFVBeEswemFHSno4czZ5ZjhR?=
 =?utf-8?B?V2U0Nk5yMXRFUE5WOVZST3AvNXNwcC8yZ3UwZUZaVGVIUWNRWVRqKzl0clpa?=
 =?utf-8?B?U2Q1RnRac1piSjA4U3hEUFlQVy84ZS91U040U29jRVpIVmpOaEFwa3V5MHBw?=
 =?utf-8?B?L2Y3YllIcFRVOUV6bUVyMVlpQlVsTHMvYk9qNVA4dmFrZkJWVm1EMmhpSjMy?=
 =?utf-8?B?NkJHNDNLanF3TUVpbWQ2VXRsT3ZBYk5TWlozTCsvKzE5QU1QcXN4YmNmK1RX?=
 =?utf-8?B?WFk5dDcwWmQzNTQzazJndSttOHBzb0o3alZoSndwYTA1aVlNaXdmSzcvdWl0?=
 =?utf-8?B?b2p3SkdkaGhMM0phN05qNVpMeEFuMkpYU1Z3MlUyeU1USnhPQUJxdkVJVGVn?=
 =?utf-8?B?OGdmOGhxQSs4RWhoQVJxZDg4Ulg5TEpwbGNXMkRsSmxJaXVqME5VUzVxWkg1?=
 =?utf-8?B?R1pOeWpkU2VnTXR0Q083allKN3o3WjYvUUgybVBhOTZkdjY4azhUNzcxcitv?=
 =?utf-8?B?K3I0Vk5wdlVlbmtRS3RrQjNRT1BSaUdLMzB0a01rcEtPTzJtb3hRVTVoRFlu?=
 =?utf-8?B?TGxtRDl3WmZpU1V1ZFFzU3RJVU9qZ2FrVFk2TG5iWm41Q1R3MTMrUkI4bmxM?=
 =?utf-8?B?c2U1NElPeDJSa0RKRUI3RXBybTJGeFN3dHBHQ0lEb01YLzZGeWtIRmhtZDND?=
 =?utf-8?B?c2liSU1lektzZUliN0tZRjlWdlRZVlN0SlYwK0ZhSE1mMHZKSy9mVnJORTFB?=
 =?utf-8?B?WmVYamFsbDkyTGdKdXhIYWxPYkRVbGtncmZkZDNjbzdvQUI4WGhrNzZTSzdn?=
 =?utf-8?B?MWo1YkxtQWtFWUJqWWs3bFNnSHFkOFY0VjJkNDdjUExjR1hKR1h5QWpTUDU5?=
 =?utf-8?B?MFFheVR3TmVEcUFYMEplTko0R0RQcHl0SkVsYkN2UW90NEptNG5lK2R1dXR1?=
 =?utf-8?Q?CT0pnJ3XqBU3prU5eUVV1TAlA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4186c59f-78df-48ba-8c65-08dc68543cc9
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 13:56:58.6988
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wGLCUuCFlnkfs78wguJk8G5RWK5Hrup5XQlSfjJSLftu7QCDIlHcRyNJRAJnk1qiPZEjRfwVx3O0xFogqzEMCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8960

On 4/29/2024 8:59 AM, Borislav Petkov wrote:
> On Thu, Apr 25, 2024 at 10:12:44AM -0400, Yazen Ghannam wrote:
>> I trust the value from hardware.
>>
>> The intention here is to simplify the code for general maintenance and to make
>> later patches easier.
> 
> There's this BIOS thing which programs those and throws a wrench in all
> our trusting in the hw.
> 
>> All Zen/SMCA systems. I don't recall any issues in this area.
>>
>> Some later Family 15h systems (Carrizo?) had it. But I don't know if it was
>> used in production. It was slightly before my time.
> 
> Yeah, already solved in the previous mail.
> 
>> Right, I found this:
>> 27afdf2008da ("apic, x86: Use BIOS settings for IBS and MCE threshold
>> interrupt LVT offsets")
>>
>> Which is basically the same idea: use what is in the register.
>>
>> But it looks there was an issue with IBS on Family 10h.
> 
> Yap, and it was pretty blatant AFAIR.
> 
>> Is this the only case of a real issue?
> 
> I don't remember anything else but I'm not excluding there not being
> others.
> 
>> If so, then why apply this method to the THR and DFR interrupts?
> 
> Meaning what exactly? You want to trust the hw for THR and DFR and let
> the others use this offset reservation we're doing?
> 

Right, I mean we should do things the simpler way unless there's a real issue
to address.

>> Right, and all CPUs should use the same APIC LVT offset. If they differ, then
>> setup_APIC_eilvt() will fail above and return.
>>
>> Why check "if X != Y, then X = Y"? Why not just unconditionally do "X = Y"?
> 
> Why unconditionally do the assignment if it is already assigned?
> 
> I don't think x86 does store tearing so that we get deferred interrupt
> on some core while some other core writes the same function pointer in
> there but why even risk it if it can be avoided with a simple test?
> 

I'm not opposed to this, but I don't understand what is at risk.

Is it that the function pointer may not be written atomically? So even if we
write it again with the same value, a concurrent interrupt on another core may
see a partially updated (corrupt) pointer?

intel_init_cmci() does not do this check. So is it more at risk, or is the AMD
code just more cautious?

Again I'm not against the current code. I just think we should simplify it, if
possible.

Thanks,
Yazen


