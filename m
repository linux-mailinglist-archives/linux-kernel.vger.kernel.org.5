Return-Path: <linux-kernel+bounces-40756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B013783E562
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 23:27:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D58A91C22EA3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 22:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DEA92554E;
	Fri, 26 Jan 2024 22:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VGafuoBz"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2044.outbound.protection.outlook.com [40.107.102.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D5A250F1
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 22:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706308021; cv=fail; b=M0sJAaNIgElnsSEIdX7SX/GFQikSJnHZRfdhvLTMP4CdqBvdtsfY6c1Q9T3L8VKJ8REQnhD5tVDxU5oDmqv51BRJFdecdCxg9xkGCAPI1cBvtS3e9nXyUU15ngmVFt6MWf+N8o3mT8d8uye9urSe4HeOMyrxxySv8t5M7hKe48I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706308021; c=relaxed/simple;
	bh=JZthERtXma23nBhkZiVXM69Slu3IM3AftQ7bIOviXdU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=s0eCNlvOcwry849i/+r3pIDazpneOX/sWC5Un+yfEiukEBywvv07+fw/gOnvatqn4Gs6N7Y88LdysBLah6aD44tCKUdmInbr0ih9xT/icDfBiDrW1P/c1etOZ+5+ZJLWcyIOWaYlV+Vy91w6jAUJPDePWaIOk4Brts0dc2KoQwo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VGafuoBz; arc=fail smtp.client-ip=40.107.102.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RqENpdFOj0L8TAZ6whj7SnW4yTpmbphT3hZ5Zqf7OvkHPg3oF5Gjr4NBpunyZOql3YOw1GF4KPA0zHCj2JJuNYndw9TQ1bQ68vqgOAfueBPiNOk/LaFpGIjdt6Ex3lGkZibx8GHonYIPSvaPhQ0ll75fGQbH1qN/0wpRFJ/VIbwb1DgVKgHaebkxm8jRWB0jC3HUpANJLoJEP6DyXPQYrh/mx4CpsGHZsnrOUbmAqySHaWJ8qZ/7XYG9o4rBRwzISIh5SyCsAGXFNYxR93wEkNXDnpER0BkxZrfVHrfdISNAHAnluU4uJ8v3aVIZB/j91d10/7AhhOZa23nEKJka2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nVZKI/D3CSiTelciwKbHQeLiZkSnz3p39KvzZ0HSHTs=;
 b=FDeG7LcsSbyRWqjF12YxZz6tJhArTRzHwJ48NaRp2vRjjpNi+bOJAKAEz2jAZZ032O0tGsAWHfMV9cHgt1OWc/5fmHaGvEQEjTAiuqpreBAsGbADwkzvUmNg4w0PB8KOMZ6Aj1jDNgnbZf6dF9XvkPimhfK6UERvdD1zcKaeAECr+9ml/f1pmxPwjibi5G2PlegI36wcqxYubHmt0SoEsxNihW9WgzU8OqtHMbVtljUk6hYPr/0nQRubabmMZil7/7kDd6IWIr4r/CDfD1n97zzUiQqYj1PS96GG07x+Nlk85l62THeQ02FyfAgEH4yZEyTvGIHIkiuHn2SocoPUVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nVZKI/D3CSiTelciwKbHQeLiZkSnz3p39KvzZ0HSHTs=;
 b=VGafuoBzgKyAOtWwF1s4webnMXkQxkNR1+fwnAKwTeP7zWI1TvJBKks1bGfslny9woV6Azko4mSXbZjH4NoKCb51m6oHvblk3jkGvoOy37DlXmBZqnyY+A0XDxge2DiR4UAmN8/g7bfqB11z+g/yq11SF0tQOgHQBhRCYizD0lo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17)
 by PH0PR12MB7078.namprd12.prod.outlook.com (2603:10b6:510:21d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.27; Fri, 26 Jan
 2024 22:26:53 +0000
Received: from BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::200:c1d0:b9aa:e16c]) by BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::200:c1d0:b9aa:e16c%4]) with mapi id 15.20.7228.027; Fri, 26 Jan 2024
 22:26:53 +0000
Message-ID: <cf5ce480-275d-fd38-fcfe-579e3c4e8c22@amd.com>
Date: Fri, 26 Jan 2024 16:26:50 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] x86/sme: Fix memory encryption if enabled by default and
 not overridden
Content-Language: en-US
To: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org
Cc: x86@kernel.org, Ard Biesheuvel <ardb@kernel.org>,
 Borislav Petkov <bp@alien8.de>,
 Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
 Kevin Loughlin <kevinloughlin@google.com>
References: <20240126163918.2908990-2-ardb+git@google.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20240126163918.2908990-2-ardb+git@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0201.namprd11.prod.outlook.com
 (2603:10b6:806:1bc::26) To BL1PR12MB5732.namprd12.prod.outlook.com
 (2603:10b6:208:387::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5732:EE_|PH0PR12MB7078:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e9408c8-7fb2-4d19-2baa-08dc1ebde5bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	J+9LWm7T6K3UGu4G3lX5979zagNa8y/acxNBZKvE+PssTdrc5+2tXdIHruUwCTooj9b0bo5CDpfG8wwokm9jSBj4489N4KiQYOVEseowox9VUAcK1RWvf66f3CdSnlT05YPW7eStgZFIKUJesnqBW7nESgZBvAECMPOv14wdJFcm0XahFtjB4ObFkpsua3xZJ9cHuXqOdCAiz/G2dVOTWH20/BRUcwCvlCbWZdSlePQJ6jeEzjkPf07YzmM/BqNsEjhK2BP4mjUCwYbop6+Byp8pmQZaqBEQ8YMulX5pAw/nb9voB/2OjDBFzQhFxhCEjom+dxqbzTyZcKkYMNIcNk6x/NU4LRFuadzfDXUAigXDMc+jLkYs10kLWo39U3zQ0WfyxPNXCvmtNEAXrDnkI7e3hJ1srbTHHkVqeg4+wGPD8ytmM6csDUQKln0JW1+ErDcmRlgBra6JejPpPKf6aQtQKwN6VZTeb6oaOOqKzSebFJnGRKNKXTQnvkDUvsDZwnN5uZFY4utt44i3pI45pRrFm28AHkuWaEjkjb5Z/kiugFf0i/bEDZqyRIVJGmlwBSGxttEP9LtTM255OifOr4ZWBFWbHgwX6+TYSyypvS21BFc1Qf2BE4F7d+FkYXHEkvDfKtejUo4kPQDfbK5KQg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5732.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(39860400002)(366004)(136003)(396003)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(31686004)(6506007)(2616005)(6512007)(26005)(478600001)(31696002)(6486002)(86362001)(66946007)(54906003)(53546011)(316002)(66556008)(66476007)(8676002)(83380400001)(8936002)(4326008)(41300700001)(5660300002)(36756003)(2906002)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RFZDQXdvRWJDT3diT0dpMU5lMnBiQkpLT1lEcXZWQkw5NnV5VFJxTTZ0WXRO?=
 =?utf-8?B?aUN1ZElUSnV2QWJkc3lYbC9LSzBjV2o0N05KRDVOWEd5Q1RQdWxKcWczTGg1?=
 =?utf-8?B?dGd2RGRQUUFZSStjRjE2WnFoTVRaY0QvdFVWcFI0Zi9OaG1ESGF6eFdaVUln?=
 =?utf-8?B?cmZMbUxsVVlPTkNzZmRSekQyMlQrZ0hobHNRT1lqNVE1c1lzdTFjUm9DR2pF?=
 =?utf-8?B?WmxVakhtNTl0L2ZsNW1VL1hFaGRaTlBWdndJMkU1TUVFT2FadFVtb2ZUUHBM?=
 =?utf-8?B?ZXV6dTY3alk5Mk11QlJmbzhORTRmVW1yc3ZrTUtXMlZ2VERLbGxVb1Qyd2JI?=
 =?utf-8?B?cDRNbTlFMVNURnRZRjQvVys1M1RMQXNzdHJaQUpUK3hiUC9CZUVvZmswSUhC?=
 =?utf-8?B?SjVsZGZOS0hqc1Ezb2Z5TC8yRjFkL1NreWF1R2hFcW5UMm12dEZ4SjJ4Q0l2?=
 =?utf-8?B?VTBpSkQ0eGdFZ0doNGVwR1NMTXJXNE9ya2NvRzBQSDVRL2EzczFrQ0FCMDc4?=
 =?utf-8?B?WXprdVI4eW5HbngyUXNUUnN3NWN1VlhIeE9VSUpLYXZiRjFoTHdYTDlGckR4?=
 =?utf-8?B?K0lucVpTZHdRZXBGZFJMY3k4L3N5cnh0YWpDc1NyaXU1T1V1SWVaT0lrSHhV?=
 =?utf-8?B?ZVEwRGNXZ2pZSGF1U0l5WVZ2UWxGUTFrVDVTaEJaVDBNSm1BZmd3ZTgwcW5j?=
 =?utf-8?B?MHNjdjF0ajNHNGIyRjNKRlNtai91Tnp1QmR3dlNmWGlMS29EL1YwMTlyQUl1?=
 =?utf-8?B?MDFUdmN4djVhU0d3VmgyR2F5dzhaVnJxUFlFc3cvQjl6eEZlR3diaG9HZmVN?=
 =?utf-8?B?d3Nnc3pobnRycGNaUWZkMXJIZElPUll0ZXZ3Y3V4WnYwSjRpNXdnYjVVeHJp?=
 =?utf-8?B?NG1MTGUxbnlaeU9saThKZUpSYUNlaTh2UExpZG56RWVjc2tvMTBaem1uQWpi?=
 =?utf-8?B?RXNwZjdGdm9xaXYyZ2lvbWRlV2ZGV3BQcXU2ZE41VXNOeTVmOVhMVEx2L3hL?=
 =?utf-8?B?SGM1Z2lhRWZwUVNBZE9VaXNGbE9sU3MxeFhrVEd1S09PTDZrRHArYWFRc1hG?=
 =?utf-8?B?N0dzOVcxbjF1dXVRa2Q0ZHQ2dlEwSXhtUDdMb0xQbHVLMEtuQjliM2ViemIy?=
 =?utf-8?B?aVZkMzhUWUoyU2ZidmhkTUp1dHo0bEFhV3FiRjRpdUQ5OXJvZnVBSHZ5c1Y5?=
 =?utf-8?B?WXViNmM1NEZBNzJsUE5DbmlhanNkS2tlNVlLOEV4aTFQQld0SDJ3T1NNN2M4?=
 =?utf-8?B?ZkNOSFk1c1NRR2hGeXhmdS9vcnpTb3lmL21MMy9MODB2Vm02OXpiTllWQy9Y?=
 =?utf-8?B?RUFDb28veUhQeG9ERHZ4TDVWVmVyc3lyVVpsSUsxOWlTd2RUL3N5SzRPaGpD?=
 =?utf-8?B?T3d1dmlDVmFQVG9GUHJva3B6QStIS0xtKzR3RkJ3QWFxTTB1cU5XRnU0Sjln?=
 =?utf-8?B?endvMTE3bllyR1ZSY2ZQVXRTbDZqQlV2T0JJOEp2ZW9hVTNBcXRaK3lYWmVZ?=
 =?utf-8?B?V29mTDc0V1M5Si9Rb1hZcm5leTNsTllpeW90QnNkOGhSMWNBcFlId0wwM2hP?=
 =?utf-8?B?NHMvTVBrSWVvd09DM0lsOU1EOU95Q25WdVBNTnl2bEtYbXVWeG4yMW9kTXJS?=
 =?utf-8?B?WnhUQ3d5NXRIYWQ2QmlpUmtuTk4xWTRtaklGVVV2RXh1NVlpVHE0QUp5ZnhC?=
 =?utf-8?B?N0tvdFl4WmxoZWdUSTRkK1J0UXZsLzRuamhSWXJlVXQvaWtkeHJTSG1WSTd1?=
 =?utf-8?B?Qk9ZSHlLK3grRm02THY1cThwQzBwUXYvc3pBRTFwNUFYTi8zbTZrb0FlOTRL?=
 =?utf-8?B?QXR1TXdSNXJVNlo0NlBRV1R4OWdybXJObjJqSGRZZTlHVTFacFhscG50MVpF?=
 =?utf-8?B?Z3YzNlRvL0NkWEZmMXZtM21kb1E5eVltTUMxUkhTWTBDTTVqL2ZGZThhOXND?=
 =?utf-8?B?TjMvOWJwVXB3UTR0SlY5Q3VONDY3OU9lRW5KTTFmV3VBZm1RTU1nbXYzbTJD?=
 =?utf-8?B?OWcvWnY4VXRjejdjVFhERjRmRVg4YjdSTC9WeWkwRGNXNGM1aHpKTlZ1NWtV?=
 =?utf-8?B?SHp1SmVwMWtMQ2RLTWJsVUJaTjVtSVNCeVhxc3NsVGxRTWxJSjZxMFEwa2My?=
 =?utf-8?Q?914OMBE6GOKUUG0iyB703iQPl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e9408c8-7fb2-4d19-2baa-08dc1ebde5bf
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2024 22:26:53.3255
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rRSJLOBEBvpzWHmRjVbjRzDT8rI4re+LzZwX8K99QDlukmzQ1Y33ASXjORD4OD0xMXzTJaE3ts+q2LoH1lw0pQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7078

On 1/26/24 10:39, Ard Biesheuvel wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
> 
> Commit cbebd68f59f0 ("x86/mm: Fix use of uninitialized buffer in
> sme_enable()") 'fixed' an issue in sme_enable() detected by static
> analysis, and broke the common case in the process.
> 
> cmdline_find_option() will return < 0 on an error, or when the command
> line argument does not appear at all. In this particular case, the
> latter is not an error condition, and so the early exit is wrong.
> 
> Instead, without mem_encrypt= on the command line, the compile time
> default should be honoured, which could be to enable memory encryption,
> and this is currently broken.
> 
> Fix it by setting sme_me_mask to a preliminary value based on the
> compile time default, and only omitting the command line argument test
> when cmdline_find_option() returns an error.
> 
> Cc: Borislav Petkov (AMD) <bp@alien8.de>
> Cc: Tom Lendacky <thomas.lendacky@amd.com>
> Cc: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
> Cc: Kevin Loughlin <kevinloughlin@google.com>
> Fixes: cbebd68f59f0 ("x86/mm: Fix use of uninitialized buffer in sme_enable()")
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>

Nice catch.

Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>

> ---
>   arch/x86/mm/mem_encrypt_identity.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/mm/mem_encrypt_identity.c b/arch/x86/mm/mem_encrypt_identity.c
> index d73aeb16417f..30df4f1725f4 100644
> --- a/arch/x86/mm/mem_encrypt_identity.c
> +++ b/arch/x86/mm/mem_encrypt_identity.c
> @@ -600,15 +600,14 @@ void __init sme_enable(struct boot_params *bp)
>   	cmdline_ptr = (const char *)((u64)bp->hdr.cmd_line_ptr |
>   				     ((u64)bp->ext_cmd_line_ptr << 32));
>   
> +	sme_me_mask = active_by_default ? me_mask : 0;
>   	if (cmdline_find_option(cmdline_ptr, cmdline_arg, buffer, sizeof(buffer)) < 0)
> -		return;
> +		goto out;
>   
>   	if (!strncmp(buffer, cmdline_on, sizeof(buffer)))
>   		sme_me_mask = me_mask;
>   	else if (!strncmp(buffer, cmdline_off, sizeof(buffer)))
>   		sme_me_mask = 0;
> -	else
> -		sme_me_mask = active_by_default ? me_mask : 0;
>   out:
>   	if (sme_me_mask) {
>   		physical_mask &= ~sme_me_mask;

