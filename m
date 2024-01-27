Return-Path: <linux-kernel+bounces-41218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79B7483ED85
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 15:38:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4C071F22AE7
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 14:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D14B28E34;
	Sat, 27 Jan 2024 14:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rKq8G6mm"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF7F28E1B
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 14:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706366291; cv=fail; b=KEgZY5vm9cQAWU/pcXtO979PF16DSj68VRFmdggzdG/ToYah4H1cQ2Aws3GIwSesNNeLCFD/6d6zdjw+5DyML8uew2eSwvvz8EWQ47NAuPqq151I/xyGREmuvivnS9VOhRNKsl+xQcnBaUGnPtqLisrF0AYZdsx8e8CxRunBcTk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706366291; c=relaxed/simple;
	bh=efNP053Y08wTh/bn6AIbunMndfnz55pAE6XKcCZJtfo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nYc0cPG0ugavVNY1igGq0aVT0XZkgxDIK3boOaqH8klrh5QcZP1VY2Mnhl35N0/lgg+3MZJ0Ez2MhlKLKCY5eojRowomjrfqk9XsTNiozUuAnAvQ0WsuvrfvuCBUcaef1MXlto2ZB6FKcUwG56bAnULKBfl7b3v3PGfzA8krl9k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rKq8G6mm; arc=fail smtp.client-ip=40.107.236.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CuBppavHtt/GC3S75Sk+vmWdeb1UBHUKa4JrmG8VyNGC+JMnwHwliXhPnnwdrTTJ22VHK/IIgcAej9ZyYwCPoDKnDL3HNBB3yBO2DnxiEZKZobCPUZCvHWsdDnQQUut9FhXgJf0vkFk59i9cgyQ1W9RNihc6ZYuWS+eGiuTKRF7VK00oAh6M0wxszURJU39RyktpE6uOA8to9lh9CGNfGMcPvAN8e7SL3jJEYKx1RUsk5ZOVpaIuQqhaKLEAaj3CjSGwYGWNcwVH7BoiqM4S5KTn5tabXhmQCYk4HKf0PjAbAYMPEvEFZNb+uTlz1z0Lp2FZWieu88fG+YW3i+A7Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xun2ROej3ixomoZvIolZur3SAJoHW9OMhsxMK6jbeCY=;
 b=SqCFyQlH1zYewmS6Hk4YV6erdJm4tcCGa3owz3mqaXgmTlee6dfNysFmH25ns9zkNBcSXeMsgVuqCPD3HBJny9HOeAq1lrFIeESzc3NnRcwAh65yyybyZEWV7nk81o8eveN2u8NiJ3FucPQKZ10UOOmVx2ZKi4zxMC6DBDqkD0LC5Tciwq0Yw2l7EdMhKIkqOSBrn65hsQtFtGSCBBW7vmrwdbZrY2oJ8N7gghCFx8pV+yTY2Q4WczcJX1GITQiLDvt+Cun9JeBaCsl80bwwZmLF44mVhT26KCiXntZOvx6XBTYcva1sJOlI0SWQQyPo+Q9OawEWklCv9mMo3aj1jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xun2ROej3ixomoZvIolZur3SAJoHW9OMhsxMK6jbeCY=;
 b=rKq8G6mmh+7qQEdvEpev+ckNj01+Lvz1kSRZtPKsdwiD1iRg8KW4AehtgFJlKET/hjJWplfZPVhjLbD+bIIIo7LSwBPw0Z/k+XdvuAf21nE89LXX8vNECgLug7G0Iw4CnmUjCvMhkglJYj61RSIOHQmXCDtZtrdNGSRkAusWloA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17)
 by BN9PR12MB5382.namprd12.prod.outlook.com (2603:10b6:408:103::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.30; Sat, 27 Jan
 2024 14:38:03 +0000
Received: from BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::200:c1d0:b9aa:e16c]) by BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::200:c1d0:b9aa:e16c%4]) with mapi id 15.20.7228.029; Sat, 27 Jan 2024
 14:38:03 +0000
Message-ID: <3e99ec2e-adb4-961e-4aab-1c6190fac178@amd.com>
Date: Sat, 27 Jan 2024 08:38:00 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 01/11] x86/sev: Rename snp_init() in the
 boot/compressed/sev.c file
To: Dionna Amalie Glaze <dionnaglaze@google.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Dan Williams <dan.j.williams@intel.com>, Michael Roth
 <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>
References: <cover.1706307364.git.thomas.lendacky@amd.com>
 <98db05934aa2d12e7df4e34ca33309b1aa8c0284.1706307364.git.thomas.lendacky@amd.com>
 <CAAH4kHY-K09tMkqDxnrgbH7vW3uvdtZTRfVH0Bysu77YV36AYw@mail.gmail.com>
Content-Language: en-US
From: Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <CAAH4kHY-K09tMkqDxnrgbH7vW3uvdtZTRfVH0Bysu77YV36AYw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1P222CA0114.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c5::21) To BL1PR12MB5732.namprd12.prod.outlook.com
 (2603:10b6:208:387::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5732:EE_|BN9PR12MB5382:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e282395-6ec6-405f-a81a-08dc1f4591a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	IJg+fUBUGhSZavWebkfkdOGMqd2cfwjG+gqqc8fCSjmhocRQdJhZNipEo6UKHxUZn0P/iZH3dRqg0e4Hjul0FSSWlibR0SYIc5DOvdRW2cX8NdUStgdeBCt4kAdvRH5OT8hu8CRwzEtHlD1q7/o2IBs0GRMwMCKQtPHG33s2HFgmT4aoh87Tco8W3wbu2DPClDSvICW8wMuLl1sNYCkZ5QxJOxKQDAp1eTeOzwdA6qGYK8MNhgsgI6w43Lc+zswgzGVjl1g9CNWK1Qdj4w1Qa2tYrwXIhqf/EEV0MbhrG4/+WAtMd/Gnnv8r4HLJM5XgTxjT+mXW9bH3KZ2ONva4WG7/aGnkuesdfGPGvoVk5USoQp9gvNc24pL3LVKNiDE6h1AdTa8Sp+fiM2nSs4LhOaVgVDlRYlkGyZEGvmwUUoDNPCOLO7ZrguG3qsF++hWTS/0foxqpZSP6OEk/dV2iOVzs2LF8HNixRlTPekNfkObY30t2Nl4m8es0A9jV0uKce/JplMwHtJINs/+7c7t5FR+WzEh35B1a5SkN0Hammv/xKafkrzlxRqLbLbiG3TXLn9VMyMrdT+vXRunrimjeuO1A5LG/ZWuDYFzb1+9jythTvyd2ICoIZCRLKtdbtG+G2dWNKaO1lauclugNn+6sPQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5732.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(376002)(366004)(396003)(39860400002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(26005)(83380400001)(53546011)(6506007)(2616005)(6512007)(38100700002)(7416002)(5660300002)(4326008)(8676002)(41300700001)(2906002)(8936002)(6486002)(478600001)(316002)(54906003)(6916009)(66476007)(66556008)(66946007)(31696002)(86362001)(36756003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Visva2VydjhSWVQzeXBMMjVRSXlWckZ4YXMzRjd5WUJDckFyRjdMNUpPSkJW?=
 =?utf-8?B?THJQSk9lbEJCL3lNRWlWd0phOEIxc25GTzhnYnZtL0tTZkl1MnVydmFkUkto?=
 =?utf-8?B?ZDhqMHVSM2RLRlFZaWtjWFM4K3NUSXhvWTBPTWxjQUk2NGQvSENaajBKQVk5?=
 =?utf-8?B?Wk54SlZjWWFkWVlZQkZWbDYzVi9CRFRDa1RMeEt1bTl2czh4OENvanB2cTZL?=
 =?utf-8?B?Q0RnZWRRRlkzZDE2UHp6TUpiTTlGbjkrRWIxQnIrdUpaU01TMHpxbHg1Y1RY?=
 =?utf-8?B?ZEpQeEFFRnViamlVSWJKeHlCZkJUajZGUG1GZ1JMd0NPL3dsdUFNMlZ1TDVi?=
 =?utf-8?B?VjdaVWkwMzBqOEkxWWJvSm5VWVBKUzNUckRGYThhM1A5RFV3a3JUY2J6NjlH?=
 =?utf-8?B?RDlJelNTMkhPaEIrekhteVZtM3pJVXpGeC9aa1NjM0l5U2VCY3JpUlU4eDUr?=
 =?utf-8?B?dzRxb1NFOVZ1aEd3aGoxZThQS1N6ZjZxMFBHVkZsUVFNRndDK1crM2Mxd3Rs?=
 =?utf-8?B?ZXNXL21ubHNWRytlVG15NXR4dENWaHBSOFZ4UmkwRTV2UGNFeWV4cTVQbDFm?=
 =?utf-8?B?czFQRHB2bEZKeTVpWmk3QURNRTAzbWJEQWZKeWJlcFZscFpGbXBrUFJ5anJX?=
 =?utf-8?B?ZS84Y1dpSG1ReHNRTkNvZ0dsa1Zuck1GNTgvZFI0MXg4ZTcydXlNR1VRejZS?=
 =?utf-8?B?ZUtrMXk5U1lvc2thYmtyYVF0RTlKdE1CZHh2Z0dITko0WVo3TmV0Y29rUEhP?=
 =?utf-8?B?ZGdwQlFjampLaG0rZkdHTlZ2ZXA1MmEydjgyL1BnQ2J0cVdWOFY3Y083aUdO?=
 =?utf-8?B?NFFLNnoydjBXSVo3MWhQNXVkN0hzUHVDa2xLSHNWNTlUMGY4eHd2YzRCa2pC?=
 =?utf-8?B?UWM1NUZsOGlsUXQyeTBEV0Q5R2NkSGVEZ056Q2xuWjltWXpsLzNJUVd5RGhx?=
 =?utf-8?B?eVlEdFptb3Y1T2V4T0ZZMFRVcFRaWC9ZZEJtUDhyZGNiRmpWRERVNVJuK0RY?=
 =?utf-8?B?MlZ5YjhyYkdkOWxEM3VOYmR4aG5nS3h1bGdnU1dlc0NqVlRBalAzQ1c0RHJr?=
 =?utf-8?B?T0ZRSE9rakczSTZuNFVmdVdDa1dlWTRBOHhuSE1mSjJzcUR6R2tuYVlEVzdh?=
 =?utf-8?B?QVRxd1NwaUxPUy9vekgzM294T3paYmI2K0pMdjZpYkdtYU1hRm5mZTl1VE1G?=
 =?utf-8?B?enBNazFNSTV3UzV0Y0VUb3ZiTXdUNHhKTGh4M0NvWHF0RGdaaFRoMHo5MkJ3?=
 =?utf-8?B?eHFQSURFYU5Rd0ZPOEtIMEhxTTkwZzBudktCR2NqNlpJdmZjQUY3NEZQQnRC?=
 =?utf-8?B?enFKZURXODdZdk4yZnIyTDY1d25CRXlVWURNYSszNGQrRS94Q2N3RUpneGtN?=
 =?utf-8?B?VWhvVSt4cUI2VTFYWkpCODR2Mys5T004ZndJdXI0UGE2ZFZGMjRNQ2pqdklJ?=
 =?utf-8?B?d3VsN05IeVNEb1YrcFZPYzNwUXVIOEREeDNPUHlzYjFrM3AwUWFwdFVNNDcz?=
 =?utf-8?B?RUpBYVN2NmRJczdsU2lqVlBZSVo3UWVLZndBSlFSc1c4eDEzQ20vOHNVcWNV?=
 =?utf-8?B?TDZ4Vi9iZ2ZRa3I1ODdGbGJhVTlDY0hwK2lCZ1hhSWR3MUlOT1Y2T2l6MitG?=
 =?utf-8?B?TXZkVllOZmExa0dGRHlIMlZONFVuZ0dIYURMTks5c2d0YlZScnZmMkozbFVx?=
 =?utf-8?B?VWhIWDVIMmpIcHRpMGxIYVI5ZWY3ZTVzQTZzSnc4bGJ6QWRXOHRWTExROWlk?=
 =?utf-8?B?RnZ3eGVWYng2Mk9sL2oyZHo5MnR3MkxZQTEraFlNaWFERTNHalAvWFRTS3Jt?=
 =?utf-8?B?cnBNaVM1eDJxS2tHVWdjbGREd0h3WXBsVGdITmZoL2MwaWpLdmtuV3FNTlBS?=
 =?utf-8?B?a2JVV0FxcVFPMlM1cjkvYlN2eEJNRm1IdjBGd2lZbG5jMzZEbE9BemZ1U2tz?=
 =?utf-8?B?ODZvU3BHSGRKMTRaSHpxdXphSDdMM0IwK2V3S1NHR1o4NFIrYlFtTDgwWHBp?=
 =?utf-8?B?Q2hQdVdWTmtlazJtc1I4Z0Y2Q0h5dDBvS0Z1K0EyZXlNQzVYL3dTazVETkI5?=
 =?utf-8?B?QVdCWnhJSUZoYmdKQjc1REx3QjVKeGNXazhwdTFyWllkdlpCR3hUa2hWbGdo?=
 =?utf-8?Q?k3FjCzGzBu60dvaurqBrBd2qE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e282395-6ec6-405f-a81a-08dc1f4591a0
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2024 14:38:03.7871
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ncBSFjWcSbEOUqQM1OkhxM3NNvrAgpYI/cDSNatEHpDid0M9mENxgrm9Id+bUte8iWf6W/f/2dgXY9BvWp08Rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5382

On 1/26/24 18:05, Dionna Amalie Glaze wrote:
> On Fri, Jan 26, 2024 at 2:16 PM Tom Lendacky <thomas.lendacky@amd.com> wrote:
>>
>> The snp_init() function is local to the boot/compressed/sev.c file and is
>> not called from outside of the file. Change the name so that it is not
>> tied to the function definition in arch/x86/include/asm/sev.h. Move the
>> renamed snp_init() and related functions up in the file to avoid having to
>> add a forward declaration and make the function static, too.
>>
>> This will allow the snp_init() function in arch/x86/kernel/sev.c to be
>> changed without having to make the same change in boot/compressed/sev.c.
>>
>> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
>> ---
>>   arch/x86/boot/compressed/sev.c | 162 ++++++++++++++++-----------------
>>   1 file changed, 81 insertions(+), 81 deletions(-)
>>
>> diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
>> index 454acd7a2daf..c3030cfb6484 100644
>> --- a/arch/x86/boot/compressed/sev.c
>> +++ b/arch/x86/boot/compressed/sev.c

> 
> Did some kind of whitespace replacement happen accidentally? There's a
> lot that isn't changed but the diff is quite big.

No whitespace damage. As mentioned in the commit log, the functions were 
moved within the file to avoid forward declarations.

Thanks,
Tom

> 
>>   void sev_prep_identity_maps(unsigned long top_level_pgt)
>>   {
>>          /*
>> --
>> 2.42.0
>>
>>
> 
> 

