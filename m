Return-Path: <linux-kernel+bounces-65361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22F7B854BD4
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 15:47:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3C5128358C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 14:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC0115A7BB;
	Wed, 14 Feb 2024 14:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CotBDbNL"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2045.outbound.protection.outlook.com [40.107.220.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876E25C5EE;
	Wed, 14 Feb 2024 14:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707922012; cv=fail; b=r0c5MdXljb+wDXdXEbCsvPjCKXVRN/pAmHpLKYkL8KSVvAq9y1Ji+lJT72zEqQuuBOT38/viLqvPh4YRn1eaPyJU1sPMa/q4suMqCz8ySNWTOmxpmjSUdLgdNo2nPtFVlNUZTUTIWfJPm17VquCaTqC8rKBnAkcIDJZPFww5Yx0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707922012; c=relaxed/simple;
	bh=WS/rLS8o37lozm58Iv3LZNVydpkdGMLe/tcDeGyE42I=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tuKYXARSSud5YBxevd57lgEjCG84rY+HNtCrGi1PsuOYFkvMCFHb1rlxqLlrj8f6KxBpr4KsRvFOka8YDwo+QLRIW0/nkUq0W5AL0gnR8lnI8fOm9P7clqJ21h+GcC1X5YM3EsOlWdTINxgRQlLAjEicPqu1GUcUB2CRpk6dS7U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CotBDbNL; arc=fail smtp.client-ip=40.107.220.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CTz2NmwgSJDUblD+GChN654YEdA0DrHbYpehfbIKeupE59ABH34RzgCDuSHBRlRlwKIAR3Fe1asQrJ90WZHVwqgPFxhvKArPBif8garq9YkS8zKEZHTJ3Mji40WMYgUKCy1KvHgQ6x9pbftsklU/JbvBLjbWB7ZuIXItMXP/NnfSMfP0dyPW5TFkpKZ/Xk+xhl5Zq1ltB77kQFhgQn/54cNKPbmzftguHhNUkVpL77oE4r5c0xNNnNMzXqhtNcr7StUx/2kiKDtIy0gr5BAGWnPrKen7NrEZoJxpU8GjZpC1CTpJh2Mt6jWXv/V8a9GYhaG4rHEDIQWTRxfh2hwD7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jY8qTicG38OTopXaTvosaEF8S4pKFQJZ+JnsZVRBbg0=;
 b=KcQGebElQ6upR3J7pnjxUGE5rYdw8wvuj/ztqq9HxR65tbBnmZ5hMllePZ7giiqXOue401EsINlBdIFEYfE9geNVQGpB/BkhDaPfFrW//Oc3XE4fJu7TH7kc8TXDdVM4vOJWTMtxqJ7H5Of73PWqvZw1ZZ/wUFUIA7zA2CKZ+sT3/IYe21yeUwccIskiQqMS4+8xjOjaaIXSvcZpAnr6goletAaLNSeqh+jC5Zq0yr9Pt+jnFkAemh/SbCdrREx4Jt6tlvVPEfJ5AfQyr/BNuu7PZzRZ7qvKeXs5hPKtsIJWXQ1Z8R3/594DXNmrcCiJ5nwWdSag1iWTCTjR8gAWGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jY8qTicG38OTopXaTvosaEF8S4pKFQJZ+JnsZVRBbg0=;
 b=CotBDbNLLlmlsDktGm7SsR0b/y77gak4/NnnjpKBH354S01sIbW/tP7V884qUrdgVXSewJdUKQ72ZC7l/9BalEuxfdDqpTw0YFT0dQJTm1TRzWJGCQn9z1OG4ymoMMdSdet2IFc36jjcrGFY4xfC9Rr7wc+Fc9cqsZOMUWstwn4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by CY8PR12MB7633.namprd12.prod.outlook.com (2603:10b6:930:9c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.25; Wed, 14 Feb
 2024 14:46:47 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::3a46:cf50:1239:510c]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::3a46:cf50:1239:510c%7]) with mapi id 15.20.7270.016; Wed, 14 Feb 2024
 14:46:47 +0000
Message-ID: <3bc7bef5-9cfc-400a-a1ba-99ebf5d94952@amd.com>
Date: Wed, 14 Feb 2024 09:46:46 -0500
User-Agent: Mozilla Thunderbird
Cc: yazen.ghannam@amd.com, tony.luck@intel.com, linux-edac@vger.kernel.org,
 linux-kernel@vger.kernel.org, avadhut.naik@amd.com, john.allen@amd.com,
 muralidhara.mk@amd.com, naveenkrishna.chatradhi@amd.com,
 sathyapriya.k@amd.com
Subject: Re: [PATCH 2/2] RAS: Introduce the FRU Memory Poison Manager
Content-Language: en-US
To: Borislav Petkov <bp@alien8.de>
References: <20240214033516.1344948-1-yazen.ghannam@amd.com>
 <20240214033516.1344948-3-yazen.ghannam@amd.com>
 <20240214103446.GDZcyXRkyf1bFzMh7L@fat_crate.local>
From: Yazen Ghannam <yazen.ghannam@amd.com>
In-Reply-To: <20240214103446.GDZcyXRkyf1bFzMh7L@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0635.namprd03.prod.outlook.com
 (2603:10b6:408:13b::10) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3108:EE_|CY8PR12MB7633:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b2a00e7-62ba-4426-8518-08dc2d6bc4f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8wewk65RuvigpvcwC6iqcujGCwK73jFRStQKfMjcQH2v7Nwg37JfKswjeshQ6wGcBF4Kn4v4PcYW2g/DWhgNoEzpsGR4/Z5kKGHZAYKr92MbnM+pyiOu4UXl/sndbbWU1gpH/80y22gh24HN7rByFU6iNe0sSGXSRuQNEJsdDIHUlyZgV2swubrosUo71iWChMXMukgUo94VPUFsk7w6+4dDM/2wrDnQls2n4n1oq2XiObk6HlgjmJgiQG3qbxSbaGJjO10++1nkIaf4nkzafw7g4PD7IIiC5EQ6CxXVWDnIMRpzLiM08fb45e/gLG0192QWZjjpVdnncyYlMkiP9Qn/uH11GcMXIrBq2oiZS907HNRqQ6MpF60KkQTs2ivfpMoE1/xtq3FhB88nxtQP1dAiy8hj79KgMp/+ZWjjmram1wR7EaTsQ8sMUOCkttTdIQvuF9XCRVv+7XkYh7DfVDpyRwRZxWzgclOD2elPsGKg5IEBY5SVKZYY0G8LSfjk8YVEeJ5zEWvp2i9f5YNWX4GO+avSpXnICs7fEmhKafRPDXAonKuD5QeopK5DsP5f
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(396003)(136003)(346002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(2906002)(5660300002)(4744005)(2616005)(6506007)(53546011)(36756003)(6512007)(6486002)(478600001)(38100700002)(83380400001)(26005)(8676002)(4326008)(86362001)(8936002)(44832011)(31696002)(316002)(6916009)(66476007)(66556008)(66946007)(31686004)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bGZEYVB6K21oa3hNZzQ2eEZHVno4MmdsdlF0UGZtRjRpZU4vc2dJOXZYODZm?=
 =?utf-8?B?SnNEaUR6cnUyLys2RzB2ZllaUThMa0NoZVdsbjFHOVB1RnZUN0xqbDVMQ21D?=
 =?utf-8?B?dEg3L08xOGhkbG9KNFROQ1VtSVFWVXJDRjFYZzM4T1BlRzQ5d0J5OXdDWjdK?=
 =?utf-8?B?UG5TRVNTQ1VHNFZFVWhyeDJTTm9zeDk2VHhGKzRhekZsSHl5VlJvSnRsMFdo?=
 =?utf-8?B?YTZ4b2xiMDFPallKeUl1cWZZbzRhZG1uaWxzdmpPakplVzF0S1d3dllvYVEz?=
 =?utf-8?B?RU45elY3TUtZNG9raU1sL3h2Z3ZId0N0YTl0V2k5akNnSmh0MEpQS09PVGcx?=
 =?utf-8?B?ckJkTjZSaTNubGs0U1hFQVlMSHBrY3NrckVVR2gza0J4RFI5V2pSMWNEY2E5?=
 =?utf-8?B?azI1RmRWWmpIeVdadGVMYmZYLy9xdzNIdTg2ZWtSMFQ2bFg0SWREdXN3czF4?=
 =?utf-8?B?UzN4c0FXbElsUzBsTXZXaEJhWWNuZ2dmaTZJZkhpR3AyZEsvMXR6Njh1NmVD?=
 =?utf-8?B?aWhyVlJOWkJVd0NkaFowbGtxaWtVakFFTTNUR1libGhTVUIvUlhxMTY0Ynh5?=
 =?utf-8?B?S1hMVitPN3RqTzVLMGVMeFhBNWR1a1liY0s1ZHJwY21icVNCKy9SelZqK28y?=
 =?utf-8?B?eHRTQVJZVkVIbkVGQnlSYnNmMm9xeFV6VVg2NEVkVHh1UEFmdGNlcDVkelQv?=
 =?utf-8?B?YzVhc2d0M0k2L2dHbHcyUjQ1QXBCZFNZb2s3ZzMxM1FEcHcxTjcxa0h4S0VG?=
 =?utf-8?B?anJobFhRbEloMk5HYUFjK2lTQzhSbjZpSzNSS1BxcHA2em0rUTI2QkJ4aHhM?=
 =?utf-8?B?S1dPMjNaamxjeFp2QlBKY1FmRW9iUGhON29BRFhjZEozU05aVFpnbEljdWtn?=
 =?utf-8?B?elE1dklPNGZEZ1p1TkhabGN5K2FCOGdxOEp0elhYaXpzeE9kanpBUGMrM29p?=
 =?utf-8?B?eERCWnRiZk5Ub0pvYkxvR3lYUC9WNGNFaCtnYWNweXFiOHRLcS9oWitaa2wx?=
 =?utf-8?B?V0ZwY0FtRmpNTGYva2VpZjlYbGZVMktMM3I5NGF6M2pIVkdubmpkSGtjc0Zj?=
 =?utf-8?B?ZHgvd2N2UjJPeTlpY1FpbjErdlQ3TDZ2aS9Kc0hwVDZEVDFpL2Q1Uzllb0JL?=
 =?utf-8?B?Szg0clpZNkhFOXJxQ2Z5OXg0R25sRUxlTGxhR3Z3QlROZU5aVXZRUG5EdjdJ?=
 =?utf-8?B?NzZaY0NCaVlEaDJia0VFb3JXWWVxWDg3eDdaTkRFYmozTnRHZGtUbi82MmNN?=
 =?utf-8?B?TmpUYy9aTDIwT1gxcHZkOWZHMllLdEo0OExydVg3U2pRMTVPaFNyWWhHejVr?=
 =?utf-8?B?OGR1SUJTSEFSeVJjbEQ4MHkrTFVHZHFkSWh5V011RHlvWGE0NWF5WGRWSTRC?=
 =?utf-8?B?R2pQbUlEVUNWNFM1MjdPcjRMSHRUL3NsUTJ4MkhOOCs4b2czQ1ZVZ1VtSHNE?=
 =?utf-8?B?UVBOcjRSdWxWZUl6L2tqaENBTktEcFFIamg0NElUSXhETEtZRWdHSUppbnl1?=
 =?utf-8?B?ZU9lakhwZ1ZiQjg5RERKQkJhbTRDMjVhd3g5ODJqeUVhY2NwRDVOTEtxS0Za?=
 =?utf-8?B?T3NZN2tFZC9qMWcycSsxeCtiNWhkenJVNHliZ2dIT2xnMjRGSmpVL1lMQ216?=
 =?utf-8?B?dkZGSXUwT3RVMWU0dEZYQW9EdGRhUkx2NU9MSWtoUFdwYWtaRG15NzJ2QkpN?=
 =?utf-8?B?SHpoeGl0d2ZlRWRCOTZRVk8yVVp1Q3VJTDREQXdCeEQ3N05LRUtIZ0hEZzFS?=
 =?utf-8?B?eUVmODBvRHVkRDJuRkExZ1FsaXN1cG1IKy9sWVY2blJqdFdoaVEwSjNWOW1K?=
 =?utf-8?B?K05WWlFFK0ZQdFhISitXcURUQ1hXZEZtQlNZRWZBVDJtUkQ3TjRkMmhFeE8v?=
 =?utf-8?B?VUFqU3A1Tnp3MjVxNEd6djgrbC9WYks0NXV3dFpyZUc0b1NqRXptTkxiOVF4?=
 =?utf-8?B?MWphaHNIeklDRHI5MEdVYzBmSW1LditNTmZTL1pob1hwYVNuTmE2ZE11OHA5?=
 =?utf-8?B?aVV4dlNIUzJ3K1czWlk0L1FQTE9pazlVWVVhMytHMURwWnpEd1gwTnRTRXhU?=
 =?utf-8?B?UmpiU3cxaUJVZ3BpZ2Riak1pbE83Wm91bk8rZUlZRjZqaVYzSHBXM1pEaFhy?=
 =?utf-8?Q?PLLJiEDskP46YRAhBNcV9vKh7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b2a00e7-62ba-4426-8518-08dc2d6bc4f9
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 14:46:47.0133
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fGeO62RsEIFxqFcPTNaYxa2+yxKV6ROOzNeS4NjzeBhCFPrrzAhDjngPp2myQtpJ/XCPEJwxhjPgTQ/g2rKvEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7633

On 2/14/2024 5:34 AM, Borislav Petkov wrote:
> On Tue, Feb 13, 2024 at 09:35:16PM -0600, Yazen Ghannam wrote:
>> +#include <asm/mce.h>
> 
> ...
> 
>> +static void init_fpd(struct cper_fru_poison_desc *fpd,  struct mce *m)
> 								^^^^^^
> 
> 
> This is a generic thing and thus can't use an x86-ism struct mce,
> remember?
> 

Yep, that's one of the assumptions/limitations I highlighted.

Thanks,
Yazen

