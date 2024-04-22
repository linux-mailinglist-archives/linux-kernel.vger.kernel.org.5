Return-Path: <linux-kernel+bounces-153938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 316A18AD51E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 21:46:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54B941C21026
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 19:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8B11155355;
	Mon, 22 Apr 2024 19:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oEez709J"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2054.outbound.protection.outlook.com [40.107.244.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524CB153BFB
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 19:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713815202; cv=fail; b=bc664AMmE+iRyRYhXyNEmuhuCaALPW7MO4evsJtdKBKx35lsk6K0V5tUm0PZlaQ/NDkA6rWsLBfSB21iQfEE20B40XT2wG5TdvN8QvCxGwDz4F8p4/pIJVsH01GcTHDN9OkvQYFP/vJZcaxq8m/SNVFaHc/UbKBj617rxH69N1w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713815202; c=relaxed/simple;
	bh=sT4eXWa3vTBbHp6CH4lKUMsO3OvT+uygnNBzUoGGXLM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BPbeyMh0bMDtqYqY1RlO3Uiy6gh6kTCnHe4bQnb/iHwtTSw3Ppm1tavAWOY3Pc+AThnYQ3Ns47iTW7NR2qcN3XWVOaXpA6gADfm+vKlpxiFPd63jRrrerPn5/2q1Zhqfjt6zKcHPGtpVNG8SrdBoV/NHP/ydmKxO98g524TuLNg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oEez709J; arc=fail smtp.client-ip=40.107.244.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hf/npJ2ufIJOs05b42Qf9SpLIor6jrK1M7sfzTy3XJvUGZuU/IohpeSwh97oPvLincACqkW2Nw8+9DiPhH0OQ9QhI9GNA2nmDznCAtyTuKY2gRkTodJsF0DX/tENCrFUrZKYpE9d5E7kguqbRwdIYSgy04uUmjryHp07+ka2TOnU9E5T0R6y5NWGKIs6pbZuIAGO5ffErNsqEuYFvT8R/mADxaR9MA3xM8cLAgIQj8xr3YU6pKehE4oJHt/n5IAwKVOdB7ECWV68zpKpmPxr0GxhetEV9dvo1T+JIxfISS8HNEI/79xb4Y/18RvRZ0715jwEC5tC9bK4s6n5GwrOBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hY0iW0ArsOq39rM6tpAuX9yDeM5eKSHat8MRkaIKo1E=;
 b=oPX8060n1E1NrvcF34NS43yOfHa7emc7jNnPYmB+UQo79x7ek9TZBbSpRuu/CcmLl8mlN/IUpK8pu/jHzxkcBmG8bgRqQmMhH56yzqpeIbpdv0xcHlQTnYk33BswZ1T42rtWrZoXQrFlCjOaS/9CRR2Wy+R/zM4Y2kIXKPjTc+TIcDxVNLPkWYMcUIaCzDmhnPkPQDYXLyX7L9eP6IItvnnBaO9kWLSoE/j3+TaB6LdJ/pO3sC34qwgYyGEu7GMWMXfRdQR3K+W+a4V8XpjWI7Jqxi8YNN3V/tmVeDEJ2kF7ERTqK84iJfcHTnztHbg/je5aWa8h7hYu4Cmr19xD+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hY0iW0ArsOq39rM6tpAuX9yDeM5eKSHat8MRkaIKo1E=;
 b=oEez709JFOc7FC5QdwGRIgksBm/BEtGZUtY/S20Cs/DB0345Dn7Pr9BTTNINlBkcaziaKEGnAI4Z5NRxNPYhCaBWnXxMlfqpHzXQL294qTj2Ip+psEllVhkrTPLxvjIaBMKARWqxXtUH5cxtlM1f+HIVDZ1/ZtNZpsfsdUoZNGc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17)
 by MW4PR12MB6874.namprd12.prod.outlook.com (2603:10b6:303:20b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 19:46:38 +0000
Received: from BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::bf0:d462:345b:dc52]) by BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::bf0:d462:345b:dc52%7]) with mapi id 15.20.7472.044; Mon, 22 Apr 2024
 19:46:38 +0000
Message-ID: <17930444-3740-f874-91e7-3ed81304b1a9@amd.com>
Date: Mon, 22 Apr 2024 14:46:36 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCHv2] x86/tdx: Preserve shared bit on mprotect()
Content-Language: en-US
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, dave.hansen@intel.com
Cc: sathyanarayanan.kuppuswamy@linux.intel.com, hpa@zytor.com,
 seanjc@google.com, elena.reshetova@intel.com, rick.p.edgecombe@intel.com,
 x86@kernel.org, linux-kernel@vger.kernel.org, Chris Oo <cho@microsoft.com>,
 Dexuan Cui <decui@microsoft.com>
References: <20240419201353.3937135-1-kirill.shutemov@linux.intel.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20240419201353.3937135-1-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0008.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:22c::35) To BL1PR12MB5732.namprd12.prod.outlook.com
 (2603:10b6:208:387::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5732:EE_|MW4PR12MB6874:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cc13a9c-c12a-485e-a0d4-08dc6304ec9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MWdTcmJWSnkvaXFkKzlBS3JRRzlGcEs5bm1mZG0rVnFGd2VSempOcnZac3Bl?=
 =?utf-8?B?czRUeHIwWUdzQWxZbTF4TTJIOFJNV3RreE0xUVRZWm9taStqRlN4TmplYTh1?=
 =?utf-8?B?Y29JWmh0RmNhYlU3SUgwZU1iQ0tPT1dFTHhCZWZtaWllNGhNcUUwWnpMOGhW?=
 =?utf-8?B?UC9tVFp0Uzl1ZVAyUTNBeWwvWVRuOFlKRXJCTm9HMmE0dnFZOUoxYzRZejlO?=
 =?utf-8?B?TW4zcncvSFkzZkhJUTcvMnJXNUJFV3Q0dFI3ZWxQRDBNMEs4NEpnWTVyOU5P?=
 =?utf-8?B?WUM1OEVqY2xRckJ3eTlNM0I1VlQ1WGZBV1pPWjk1WWlWVVM3WmtXQkxhS2Ez?=
 =?utf-8?B?cEYyMC9UQnFiekVseGNYeGtaSU9iNlQ3TkI4YzFlRXprckhyMUI2b0JSUGN4?=
 =?utf-8?B?VlcwSlBrb3ZTRXJwNG8yMXRVTDhZaVZQMk94ZEdpSktYWXB4NTl4aTRLa0lG?=
 =?utf-8?B?a0ZocmRxUEJYWVdoWlVRWFpHOGNEZDBYNzA2RDFRNFFwS083cnlCb3licUJ3?=
 =?utf-8?B?SnZPR2dpTjFNc1p6UUJCWEM5WFNia2luN0I0Umx1UjBnYzg0VmlZOXRXTUpH?=
 =?utf-8?B?eFk5SCtvWktNb2VSWDlpQTdhV2phMEFxMmhnZVIxNDN5SFNkbGp2eG5BNlZr?=
 =?utf-8?B?WXMwcC84V1FnUmpqSEw3dEVaM0dDOW9JRi9KRFYvSkJkd3V2akgyRUVXclJF?=
 =?utf-8?B?Nmpweis4V01HckUvSkxITURSR2VrYzh3YzQ5ZHZvK3RoS2R4bVZuMSs5a3hL?=
 =?utf-8?B?YnJMb2JvR1pwNUJzNW9DNitDTnprcWRqSElSaVZnV3lBL1c5QUlvM0t5UVFs?=
 =?utf-8?B?RHMvZ3lsSDlTWnh3RDJHdjNXOW9vLzFjZDdPMkZJakllbHI0NG9BTG5MM0RN?=
 =?utf-8?B?eXoyQjZURzd3MU5nTjhXZGVaM0tvNzRXTkxFeGNXUjJXZ3BYekNrTFpreVVs?=
 =?utf-8?B?Wmk3N203UzVId2JqcFlUUFpLSTBSNm5YdTFVclFscUNueHg5RUlQU2lrRU14?=
 =?utf-8?B?K2pxNFVhazZkWUEwNTJpVVVzNURTNWkyODhwQTFjS0FUd25XK2hrK25JMmxj?=
 =?utf-8?B?azBQUGRFejR4VWRrUG5vNzF5cDRSZFdNNUNrVzUvMUd1KzVoVk5RMlFLSGVi?=
 =?utf-8?B?MjRPa1JBekgydmZOYjJaNnBZY3V3YWpqS25FTk8yUzJXWWlQd3BjazFHYlNC?=
 =?utf-8?B?YzRma0JQWmEyN0ZQMUFZUFExNFpHZVEzMCtIaUdqWG5RT0hpWFpqRUpqcjdh?=
 =?utf-8?B?OVozdmxsVlAyWHNRbS9ib0drWjhQeFhyRWFkUjd5Zkw5ekVzMm1xc0F4R3Z4?=
 =?utf-8?B?a2pPYWxWSE5IdEtyVDVJbHprOFZSOUtKNXJHOFpsSkZiODgwRng1bW05eFlZ?=
 =?utf-8?B?Q25hN25lYWU1UjFhc3JZbHJvRjhoeVUzSzdoY3pxd3J3L1pQMU9ZOUpSc2ZU?=
 =?utf-8?B?RlUxVGdKbEhqSU82bHdmMTZZWVA0Y1Uvbll5ZXZCbzBEU0RvMzY5RjB6VStz?=
 =?utf-8?B?OG5ZdUQvdy95QTRvT0ViSlAzQmt0ZFpvb09UTHFacE85d3dLSktlWU8vUmxL?=
 =?utf-8?B?Z1FDRTc0YmNXQSs0REZFa0hnQWg0NHBjTS9uSXg0d1pvZFppdFhkamZhdm12?=
 =?utf-8?B?YmFVdGhZaGhuQTlwMDV2amNEdDcvSE5kV3lSMncvTUNOdGNMaHBMbzlRZ0ZQ?=
 =?utf-8?B?c0xoZU5TZU9ucitxU3htNS9GeDh1TTY3bXh6ZGZlRXdOR2RWQTJzSElBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5732.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cTh0b1NzYjBtWVBVMW5kNzdQeXJzMHpFdkcvV05OSGZaUmFZaW5lT0NlTC95?=
 =?utf-8?B?ZEwzZDI3ek9pUFUxQWtjcGF2a0ZrZXZGZmlQL3Q1MlROUEo5dXk1cGVEZ2dq?=
 =?utf-8?B?QlgrMGZ5ZU5pT3FPMXFCNGpoUWxoUHk2SWxFSFRORUNkQmY5UHFJSUdldEhx?=
 =?utf-8?B?bzFDL3ZLMVBQL2VzcEtFNHlUSEI3bXUwRHJDZDVUeUo5dEpjc1JKZzFRc29J?=
 =?utf-8?B?SWJmdk9rVkRGd3NDdFdRSmFLR3ZmZmVYVU9FY1JLdXVhQnV2emJ2UU14Wjhw?=
 =?utf-8?B?S2JSTWhBUlp3YXYzMXBDTXdTR0JzUGc4QVNYM2k3K3J0bndZcFZVM0hRRkFK?=
 =?utf-8?B?TWUwbUxoVnlCSkdpQ2NQaHpyMXY2bEpRQ1l2UWdDSW0wYVFtKzZDQWFIblJi?=
 =?utf-8?B?TkxOMnhNRmFDWHBOWVF4SmQ1S0czQzB5eC95RGdHdFBqVFpoY3UvS09HTWt3?=
 =?utf-8?B?aHFwOVQ4TDZlRUxtOHhIU0duNWpQcUdDS3dDZC81UXFMbHRacExtS1lrZ25w?=
 =?utf-8?B?TzNBejJmUzRNaWVrdXk0WHh2U0xEVWFmUXRVK0dOQU1ROHZ4d25sUVF2cXdu?=
 =?utf-8?B?ODJkVFh2RXFtc1JhbjJlUmdGdkpWQmF0d0w0WHYzaHR5NGMwQUYzakhkQW5h?=
 =?utf-8?B?Wnk5RHB1b3ZuSnoyRDVTbzhsT2w5bEpKVndaUmtRM2pBTGNuaEc1MVh2b2R5?=
 =?utf-8?B?dG5JZlJnK2VWL09TMVBTMnhFUTdsNUtZZzZqSkk1NlVwK3ZtZUx1eEJCMXVF?=
 =?utf-8?B?REpXNDdmM0Y1dENXaFhoOGltRWJQSlFHSWQxcW5KYkJWUXFQWVdLK2p0Z0JD?=
 =?utf-8?B?V1ZycnRnUGNrUWY5WEgxQ0U0YUpkeGdhZlM2Y2RXVzJVeWdpSjk1NFF2QzFy?=
 =?utf-8?B?MDBvaWtHdjVYUW9aUnNmUHlnWlQ0L1dvdVdnczRjOTdaL3FmbUxuQVhpVXVS?=
 =?utf-8?B?QlFNd1U0ZDdlMXJMRlFWSTFDM2ZqdkNlRWNjTGRpTHNuUlFJaVpyRkhrSXBB?=
 =?utf-8?B?QlBsTGwwTFpHU01VNlVlUXRzaXVVaFJLMHpPZkluelIvcFRTL0VIbUtHNDg2?=
 =?utf-8?B?Y0g2U1ZzMWhOU1RCVG1NNndjTi9QSmFjZ0NUanh2NldnU3hCYVBnd0JPMTY4?=
 =?utf-8?B?ME04allxeG01aW50U0JSQlJPOGhSL0x1aFkzQm53cFJ2SlV2V2dpSUYzN2c2?=
 =?utf-8?B?NUVGOXNxNzJwMGRmNVE3Q3RPRk5LdjdiQnRpSW1RRkF4TXFGeXdYSUtaZ0d1?=
 =?utf-8?B?YmUwMnpQVEdYMXZZM2wrWFRQYjZpNTdwVlFVeW5semNsdDZsZ3NvZ2sycVAv?=
 =?utf-8?B?ejBSOGcyc1QwZ2p6ZWp1akhyMVRHTlZiV0lodXNjNk5VQ1ExUW1nbzlyZENE?=
 =?utf-8?B?R28zOU1kTDFFS3RGRDJpaHFNc0U3c0UyUi9HUFRzYXhyZWdFSzhQNStZUWp2?=
 =?utf-8?B?Yk8wNHdKbG95b1g4QlVJOWtlSkNwdjJxeUZUUlA4M0V6UXNPQ2c1V2RWSUR3?=
 =?utf-8?B?Y3lqSmh0dm83WGgzb0ZReEJzbXNWZU9KV3pWTXMwZ2t0c1NKZldnZG0xT0tT?=
 =?utf-8?B?UDdQL1pqenJiYlJMeUdOM2xJd0tBMEVSUGhXSVF6bUNSWWQ4bjJDUHZrNEFT?=
 =?utf-8?B?TWlHdTFjK252WkNpTmhrb0dWWXpmV09HY2JkU29OTWpFZU4vNE9PWUtMaDQ1?=
 =?utf-8?B?em0xazU5cXVnZEVUOXBycm1idFZmSU1LTmdKR3lnZ1czanphOFg3MjNwZGo1?=
 =?utf-8?B?NTlOVEVhWVRCeGJxOUR6ZlhPenNIL0ozVEV2R3ozUDZFYTJUVG5BalRQNFRM?=
 =?utf-8?B?UHZTaVdTdC9kMjc0cEpUSGtXczl3RzdYN2tZVXdzckZxenJsenBZTUFkeW1G?=
 =?utf-8?B?KzFzWk12M21TaTBhWFA1bjk0RHJlV1Jpd3ZycStya2lGNnV1cnhWYXZIS1U5?=
 =?utf-8?B?Y3NUWkN6M2U3VS9JOEhoamYzUFRsd2FiMlpyakExbzJDR2h4UnpDb3dIY3Nn?=
 =?utf-8?B?YkJqWWVXbGoxQ3YwbXNPNmYrRklDWUNZam1QUTh4b1RtK2RYMDVQYzR1RzN2?=
 =?utf-8?B?MzE5dDVCaHBuQTNGODBZdmJiNENHVFFSbFAxUloxQW5YeUZYYTNSNWd0WFpi?=
 =?utf-8?Q?7YmlN4LfaDJT4oE6FGDdbLGyL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cc13a9c-c12a-485e-a0d4-08dc6304ec9c
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 19:46:38.1745
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WE85zcL3BJuz8Cb3ghRxJ3yDwzl6oRAHPde9K6DuIXonX0aB7Vrb52anB32OtxEYHzTRtwtbesyoq2z5R6h3sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6874

On 4/19/24 15:13, Kirill A. Shutemov wrote:
> The TDX guest platform takes one bit from the physical address to
> indicate if the page is shared (accessible by VMM). This bit is not part
> of the physical_mask and is not preserved during mprotect(). As a
> result, the 'shared' bit is lost during mprotect() on shared mappings.
> 
> _COMMON_PAGE_CHG_MASK specifies which PTE bits need to be preserved
> during modification. AMD includes 'sme_me_mask' in the define to
> preserve the 'encrypt' bit.
> 
> To cover both Intel and AMD cases, include 'cc_mask' in
> _COMMON_PAGE_CHG_MASK instead of 'sme_me_mask'.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Fixes: 41394e33f3a0 ("x86/tdx: Extend the confidential computing API to support TDX guests")
> Reported-and-tested-by: Chris Oo <cho@microsoft.com>
> Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Cc: Tom Lendacky <thomas.lendacky@amd.com>

Appears to be no functional change on the AMD side.

Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>

> Cc: Dexuan Cui <decui@microsoft.com>
> ---
> 
>   v2:
>     - Fix build for !CONFIG_ARCH_HAS_CC_PLATFORM
> 
> ---
>   arch/x86/include/asm/coco.h          | 1 +
>   arch/x86/include/asm/pgtable_types.h | 3 ++-
>   2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/include/asm/coco.h b/arch/x86/include/asm/coco.h
> index c086699b0d0c..ac8cd4447d48 100644
> --- a/arch/x86/include/asm/coco.h
> +++ b/arch/x86/include/asm/coco.h
> @@ -25,6 +25,7 @@ u64 cc_mkdec(u64 val);
>   void cc_random_init(void);
>   #else
>   #define cc_vendor (CC_VENDOR_NONE)
> +#define cc_mask 0
>   
>   static inline u64 cc_mkenc(u64 val)
>   {
> diff --git a/arch/x86/include/asm/pgtable_types.h b/arch/x86/include/asm/pgtable_types.h
> index 8857d811fb5d..2f321137736c 100644
> --- a/arch/x86/include/asm/pgtable_types.h
> +++ b/arch/x86/include/asm/pgtable_types.h
> @@ -148,7 +148,7 @@
>   #define _COMMON_PAGE_CHG_MASK	(PTE_PFN_MASK | _PAGE_PCD | _PAGE_PWT |	\
>   				 _PAGE_SPECIAL | _PAGE_ACCESSED |	\
>   				 _PAGE_DIRTY_BITS | _PAGE_SOFT_DIRTY |	\
> -				 _PAGE_DEVMAP | _PAGE_ENC | _PAGE_UFFD_WP)
> +				 _PAGE_DEVMAP | _PAGE_CC | _PAGE_UFFD_WP)
>   #define _PAGE_CHG_MASK	(_COMMON_PAGE_CHG_MASK | _PAGE_PAT)
>   #define _HPAGE_CHG_MASK (_COMMON_PAGE_CHG_MASK | _PAGE_PSE | _PAGE_PAT_LARGE)
>   
> @@ -173,6 +173,7 @@ enum page_cache_mode {
>   };
>   #endif
>   
> +#define _PAGE_CC		(_AT(pteval_t, cc_mask))
>   #define _PAGE_ENC		(_AT(pteval_t, sme_me_mask))
>   
>   #define _PAGE_CACHE_MASK	(_PAGE_PWT | _PAGE_PCD | _PAGE_PAT)

