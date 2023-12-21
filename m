Return-Path: <linux-kernel+bounces-7766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4585581ACCE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 03:57:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F111B284AEA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 02:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1EA46FDC;
	Thu, 21 Dec 2023 02:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Gh5/451d"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2089.outbound.protection.outlook.com [40.107.93.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D562DAD21
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 02:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fv0lpJI8wbbMCIM69Ig8kM/QZ6p1GUQQ3g98U7/fU8ImwQQS4wCTXrD85/gt8bgvtrk1Cb5Qe7V9RJtIKWc7Q/bD6vsB5RYCZD1ptnNMtaHuE8d7yIJCMDNxKap8H6/SCCappK7BJWGQCmfmYAQRcshZvSCEU19g+z9xYyECGe/bg3KrI9jmMhhwnOg3xXwOOACPeoO9RVdwQF6pw8+8x4ITEzrsz0UqXJk26+1g1uPQMBwTVpsktOB8wVa7P8WyUp1SweAy76znBItDaAzLnj7oKURklHPVGssQJXwQHw/1saa243CI3lwazbOy1oc7rwbWDiuueMihTZfwurY0QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7XOffK7qU6BVA4NTosoNFf+MsD3P+yacmsFJ1YfvCMs=;
 b=F0Uw8T2jQnYaS9rNJHR45Ec1M0ByaWnFWw5tyPwRKOKvSeHR+fFLSPhfEA5OVaTJkFLl5PoQg9xDhWj+1gzfJfcKcvlTg/OuYHTK8Pffv8B+2yYCN92NVcJGj7tBgnVwfu7FKGJLQJQOr8QOwf6sSjWWEb6PiDIXHapj7FTETakAWbBcX3mfDFRAQ4kAStOCU58+r0+LXkR1ujUk9HpPjo89jow2yjciKpoMWni3DHorKx5sEEgS2LmGx6COfrJjHQu59qPID+ZzYht77I8ubDUHC0J0zzomsEG+6bdRUoGHUy54/XLUqX03Qsq0sErrFNySt+Uh1sqb/+2BzvMJiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7XOffK7qU6BVA4NTosoNFf+MsD3P+yacmsFJ1YfvCMs=;
 b=Gh5/451dsehrOT+i1dNsJv1eKqA8y4fGWy+CdC5H76tfRrdsC71FQKVurhaDaDeCBjlbcU6ZiGfkIXmd9CB9+ycUg+OmyUhNcq1rfNS7vNwemfu8j6ziGhqNwWMqmFhC3INwMKh4mu+yfYoCVAatu9gIKzNH5XPN09ds/+tMH1k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6460.namprd12.prod.outlook.com (2603:10b6:208:3a8::13)
 by BL1PR12MB5078.namprd12.prod.outlook.com (2603:10b6:208:313::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.20; Thu, 21 Dec
 2023 02:56:47 +0000
Received: from IA1PR12MB6460.namprd12.prod.outlook.com
 ([fe80::8a26:c139:11bc:ebf0]) by IA1PR12MB6460.namprd12.prod.outlook.com
 ([fe80::8a26:c139:11bc:ebf0%7]) with mapi id 15.20.7113.019; Thu, 21 Dec 2023
 02:56:47 +0000
Message-ID: <2b7ae17e-0429-47ab-8101-00486ef9841e@amd.com>
Date: Thu, 21 Dec 2023 08:26:37 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [linux-next:master] [mm] bbcbf2a3f0: kernel_BUG_at_mm/memory.c
Content-Language: en-US
To: kernel test robot <oliver.sang@intel.com>,
 Matthew Wilcox <willy@infradead.org>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com,
 Linux Memory Management List <linux-mm@kvack.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
References: <202312192319.fa8f5709-oliver.sang@intel.com>
From: "Aithal, Srikanth" <sraithal@amd.com>
In-Reply-To: <202312192319.fa8f5709-oliver.sang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0009.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:95::17) To IA1PR12MB6460.namprd12.prod.outlook.com
 (2603:10b6:208:3a8::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6460:EE_|BL1PR12MB5078:EE_
X-MS-Office365-Filtering-Correlation-Id: e857f6e0-207d-4e5b-3eab-08dc01d07782
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	U7PIY839O7N5+bB/NI7xcV1cmPq+48omLnf4tDBXVDKYFs2/IPusFz4zXWF6VYFa79MdLzITkrP8qm+4pDMBB12mUUY5Qu3oiD8ThsbEpp5OfNgyHh9bAme49IscM/uZXaOEzXhv8UTdoqcAeHgCKWSxfJBFNJvaImJs99UcNipQ8BvpX3wsURW2O9gBt9uKtrR2F3/P55N07dhzIdySL13oVbCxuBtE84MeNFcwCOPvT8OjTqjxg0YVtPWhojVdYSxbmpZiZ6Os7rFER/yc+72k4Bt5ZiISi7GKaqOy6vtT7F4pfbkOjIZiiKuA6H/x+Jd+ljBQSRFUr4MdN6hLmLNiGlJMYs0JUPmLpsyjy8hYPD1ykc9Y+Oclbjn7uVo2GcVzcW0JENcEslFrjnqvRgIKNyKKoeRy7J2pKfxjW04Jm/DGSaSiV/QJgJX4xJTFdArkEh4RdW34t8JQ5AlnyFVsJ5KXl7tQJ/oBd6v1zYgNsG/rQcl8aPIud/Rj7Tazufx/ElnMOCoIlsDMdyS3Dkpirg5fOBdScHjgjgEgmdS/wGpgRIcJ99B2vvbtxam3dnMcxB8Eyj/zAOcpv3taJB4xoyyAON9BardlPRs/pe8fZpYzyIZ708k/h6q+LMQ8uBCO7qHyocZmmLs6iXWnbA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6460.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(376002)(396003)(39860400002)(366004)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(31686004)(83380400001)(26005)(2616005)(36756003)(31696002)(38100700002)(5660300002)(30864003)(6512007)(6506007)(966005)(6666004)(53546011)(4326008)(66946007)(8936002)(8676002)(54906003)(110136005)(66556008)(316002)(66476007)(41300700001)(2906002)(478600001)(6486002)(45080400002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Yk1ObEpOOVEvTVI0aURlNllkazNPYjhnNEFCYVBmT2JIdG1nejBCQTRwY2FS?=
 =?utf-8?B?b0dTM3NOYkR5amU2Zk9aWU9VZGJvOUVZb2VISEU0ditmTFp5a1R3VHJPSnFX?=
 =?utf-8?B?bVNUSkFBSGZJWGxPL281SWRGS0p6WnRhejJGSkR3SXR4L3IrMmczVGVidEYy?=
 =?utf-8?B?eUlnVk96c1VwSlhTMTUycFV2ajhlU0NjUWJ5YVY0cGZ6YWJjdHEzeXU2MVFv?=
 =?utf-8?B?OEN1SFRPeWtGL0tHTkhIS1llcHBCc3ptbndTSmZrRnYxTG1mMFQrRUNFVkhV?=
 =?utf-8?B?UzQ4OWI1WVE5TXU2SHR4bUxLU0dhSWxITUU2ekdLNDUyY3FZaUNBTVZaQXVC?=
 =?utf-8?B?Skw4Zkd0TFJSLzlsalFzRnNmdkRFM3NsK2VYK3B3eWhIMDJCY3RYenZiY3V5?=
 =?utf-8?B?T2lLaWRkcXlJdnFteXRpQlh6UDBqcXpNZ0hDeTNTSGpIaHc5djhxRGpMUjBw?=
 =?utf-8?B?N2xrTGpTNDE2dWhYUyt0dlRIZVRpa0dtTGtyRXZ1UDFuWHVtRFBtVkJtVy9J?=
 =?utf-8?B?UlhtZ0daWjFXRXlPcHZzbkpSbFpCKyt6aHV4VHVlVjRVU1ZWZXV6UkZ4aGFZ?=
 =?utf-8?B?S0xkTUJldjZBcyt4LzVOdzhLMHhSWlRiSnh1dWpBVThmVEhYOVI4Lzc5eUlj?=
 =?utf-8?B?cnVXV3NYNVZEaFZpV3ZBTnNndGdQNnFmWjNCVUw2b20yVVJUV20rOExBb3ND?=
 =?utf-8?B?cHNLNDVBNjIrYzhoRWdXMnZGUHBPeGVxVm90ODZnN2krTU5YZDlkS0EzVExH?=
 =?utf-8?B?VzFGNno5KzJLWTZNUVFEMXR1Ymp1QmwwMmU3L0xha0Q4TGYyM2VXTm5FaEhU?=
 =?utf-8?B?VkZzOE95NzJVMWw3RnNUWmp4dS9xamg4SHkwWkV6QTUwWEh3cmlkejI1dXk4?=
 =?utf-8?B?QjRFeUlzU3c0V1ZKZG15T3FoK2VFMHRFTUl3L3RDK0R4S1hpZTlnQ29aZ2dV?=
 =?utf-8?B?U0V6bnR4TEZZZW1SY2xsZkVpdXQzYUxlaXYzZE8xKzhNMFVtMmNxd2VRcldY?=
 =?utf-8?B?MFY1SStoTk5xYVBBZmpVd2NGcEdwSkV3dkErSDJaUEh0NzNpVzFldVdPVnIr?=
 =?utf-8?B?aDVaUEl3S0EwTXR4bGJUcFFOQ0sxVGdhdnpXU1hTRzc2bzg2WTJ0V3prVnpy?=
 =?utf-8?B?SkNWc3NUcm9QaHcrd0E3cStsdGhQckZrcjhEOHl3ZUhwOGxDOW52Z1Jhemph?=
 =?utf-8?B?TE52aEtLRmdBaGJIbDM0Wk8zRnFwREtpcmFKYzBKeDV3WlZqSjN4N0QxT054?=
 =?utf-8?B?bm1MMEhTbjBtSGJ1WlpIaUhpaXR0MzdrVU05bEJxMDcxcmpJM0ovYlJxSUQy?=
 =?utf-8?B?QnZmcnpOSEsvVWtYTkkvYXJwNFNST3A5RXAvUmdYaEZSRjFPMnhLZlJUWWhK?=
 =?utf-8?B?K0JuZ0tURzVKQXduWmhXeWY2VzlTVHdQaVNwVk5nY2g0VnFGNjlaTTlvRi9j?=
 =?utf-8?B?Z3NhMUVPNWxDZDBPNmRMbHRFRFNYOVdrdnJRc3BrU0pzYitxeEtHV2tOeXIw?=
 =?utf-8?B?RTlCMVJBMit0OTlrR3hpYzE5QW9ScGhaeEJ6WENDaVdZQnBJUER5Z01ub0hN?=
 =?utf-8?B?N2p5NFdhV3pPZ1IwSGlKbE1Hcmp2MEdGQUYzUFUrb3l0V3pOVHhYcU80Qm1t?=
 =?utf-8?B?dzAyOGJBZ3daNzZaSjhaM3J6Wk1WemxTY21xTDRSUldvOUZ0NmxKMUZkSXVD?=
 =?utf-8?B?RCt0US9MbHdOc1JtZDFMR3RCdUtjUmN2cjlDeG0zVmdpNDBmQnpWQWt2SEZj?=
 =?utf-8?B?cDNsTC9rNHpib1BybTNMWi9HOGZGTGtKL040dEZFbWVLV0tDTnJIcDFBNXFR?=
 =?utf-8?B?WWhnbmNSRWpEaUkzRXJ6dC8xa0R3VDNYeVBoclVrLzhreWJFVWJqblRvVk93?=
 =?utf-8?B?OGF3TXFIbk1jcFRhUGpGVmp0V0k2d1MwRjlVMGQzbUNDRHZoTkFPRCtKVDZO?=
 =?utf-8?B?VVRlbVhzZDN4b285cUdRMHhRb2xjVGk1aGFId21pcGp4Q0FMdC90OTJFZ1ds?=
 =?utf-8?B?WWc2SXhjbUkwZkFaME9kSm5lNW9zQk9sVTAzMzFQTklyZjhKQ2xPa1hSc0dK?=
 =?utf-8?B?ZzRKdDlJVnlJSzcycjV4bThGWURlK3FWUmZOczlSQVhSd2lETXAyU293S3d0?=
 =?utf-8?Q?V3351e8mJAyPCiqN4K5GOGcg1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e857f6e0-207d-4e5b-3eab-08dc01d07782
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2023 02:56:46.9133
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: je3xZ10p774ZTAa32PYNyL/u5jH6TLintqoUYRqKzP787yRq1Tk89quMD6AkXq+RvKP5cPICwaNSsbL0eWa9LA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5078

On 12/19/2023 9:16 PM, kernel test robot wrote:
> 
> 
> Hello,
> 
> kernel test robot noticed "kernel_BUG_at_mm/memory.c" on:
> 
> commit: bbcbf2a3f05f74f9d268eab57abbdce6a65a94ad ("mm: convert ksm_might_need_to_copy() to work on folios")
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> 
> [test failed on linux-next/master aa4db8324c4d0e67aa4670356df4e9fae14b4d37]
> 
> in testcase: vm-scalability
> version: vm-scalability-x86_64-1.0-0_20220518
> with following parameters:
> 
> 	runtime: 300
> 	thp_enabled: always
> 	thp_defrag: always
> 	nr_task: 32
> 	nr_ssd: 1
> 	priority: 1
> 	test: swap-w-rand
> 	cpufreq_governor: performance
> 
> test-description: The motivation behind this suite is to exercise functions and regions of the mm/ of the Linux kernel which are of interest to us.
> test-url: https://git.kernel.org/cgit/linux/kernel/git/wfg/vm-scalability.git/
> 
> 
> compiler: gcc-12
> test machine: 128 threads 2 sockets Intel(R) Xeon(R) Platinum 8358 CPU @ 2.60GHz (Ice Lake) with 128G memory
> 
> (please refer to attached dmesg/kmsg for entire log/backtrace)
> 
> 
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202312192319.fa8f5709-oliver.sang@intel.com
> 
> 
> [   61.404380][ T5947] ------------[ cut here ]------------
> [   61.409984][ T5947] kernel BUG at mm/memory.c:3990!
> [   61.415085][ T5947] invalid opcode: 0000 [#1] SMP NOPTI
> [   61.420506][ T5947] CPU: 32 PID: 5947 Comm: usemem Tainted: G S                 6.7.0-rc4-00252-gbbcbf2a3f05f #1
> [   61.430881][ T5947] Hardware name: Intel Corporation M50CYP2SB1U/M50CYP2SB1U, BIOS SE5C620.86B.01.01.0003.2104260124 04/26/2021
> [ 61.442761][ T5947] RIP: 0010:do_swap_page (mm/memory.c:3990 (discriminator 3))
> [ 61.448112][ T5947] Code: 6f 28 31 d2 be 01 00 00 00 4c 89 ff e8 9b 43 03 00 49 c7 47 28 00 00 00 00 4c 89 f9 48 c7 44 24 08 00 00 00 00 e9 cf fb ff ff <0f> 0b 49 8b 45 08 f0 48 83 28 01 0f 85 3f fc ff ff 49 8b 45 08 4c
> All code
> ========
>     0:	6f                   	outsl  %ds:(%rsi),(%dx)
>     1:	28 31                	sub    %dh,(%rcx)
>     3:	d2 be 01 00 00 00    	sarb   %cl,0x1(%rsi)
>     9:	4c 89 ff             	mov    %r15,%rdi
>     c:	e8 9b 43 03 00       	call   0x343ac
>    11:	49 c7 47 28 00 00 00 	movq   $0x0,0x28(%r15)
>    18:	00
>    19:	4c 89 f9             	mov    %r15,%rcx
>    1c:	48 c7 44 24 08 00 00 	movq   $0x0,0x8(%rsp)
>    23:	00 00
>    25:	e9 cf fb ff ff       	jmp    0xfffffffffffffbf9
>    2a:*	0f 0b                	ud2		<-- trapping instruction
>    2c:	49 8b 45 08          	mov    0x8(%r13),%rax
>    30:	f0 48 83 28 01       	lock subq $0x1,(%rax)
>    35:	0f 85 3f fc ff ff    	jne    0xfffffffffffffc7a
>    3b:	49 8b 45 08          	mov    0x8(%r13),%rax
>    3f:	4c                   	rex.WR
> 
> Code starting with the faulting instruction
> ===========================================
>     0:	0f 0b                	ud2
>     2:	49 8b 45 08          	mov    0x8(%r13),%rax
>     6:	f0 48 83 28 01       	lock subq $0x1,(%rax)
>     b:	0f 85 3f fc ff ff    	jne    0xfffffffffffffc50
>    11:	49 8b 45 08          	mov    0x8(%r13),%rax
>    15:	4c                   	rex.WR
> [   61.468016][ T5947] RSP: 0000:ffa000000bb5fd98 EFLAGS: 00010206
> [   61.474169][ T5947] RAX: ff11000111a47c99 RBX: ffa000000bb5fe08 RCX: 0000002064ac7000
> [   61.482233][ T5947] RDX: 0057ffffc00a106d RSI: 0000000000000043 RDI: ffd400008192b1e8
> [   61.490296][ T5947] RBP: 000000000100c13b R08: 0000000000000000 R09: ffa000000bb5fe08
> [   61.498366][ T5947] R10: 0000000055555554 R11: ff1100018bebbd0c R12: ffd4000044128000
> [   61.506438][ T5947] R13: ff1100205d33d800 R14: ff11000130cd2da8 R15: ffd4000044128000
> [   61.514508][ T5947] FS:  00007f49c900c740(0000) GS:ff11002001000000(0000) knlGS:0000000000000000
> [   61.523534][ T5947] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   61.530225][ T5947] CR2: 00007f4966b3b6b8 CR3: 00000010af786004 CR4: 0000000000771ef0
> [   61.538307][ T5947] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [   61.546387][ T5947] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [   61.554471][ T5947] PKRU: 55555554
> [   61.558137][ T5947] Call Trace:
> [   61.561544][ T5947]  <TASK>
> [ 61.564599][ T5947] ? die (arch/x86/kernel/dumpstack.c:421 arch/x86/kernel/dumpstack.c:434 arch/x86/kernel/dumpstack.c:447)
> [ 61.568429][ T5947] ? do_trap (arch/x86/kernel/traps.c:112 arch/x86/kernel/traps.c:153)
> [ 61.572692][ T5947] ? do_swap_page (mm/memory.c:3990 (discriminator 3))
> [ 61.577475][ T5947] ? do_error_trap (arch/x86/include/asm/traps.h:59 arch/x86/kernel/traps.c:174)
> [ 61.582172][ T5947] ? do_swap_page (mm/memory.c:3990 (discriminator 3))
> [ 61.586966][ T5947] ? exc_invalid_op (arch/x86/kernel/traps.c:265)
> [ 61.591743][ T5947] ? do_swap_page (mm/memory.c:3990 (discriminator 3))
> [ 61.596515][ T5947] ? asm_exc_invalid_op (arch/x86/include/asm/idtentry.h:568)
> [ 61.601638][ T5947] ? do_swap_page (mm/memory.c:3990 (discriminator 3))
> [ 61.606412][ T5947] ? do_swap_page (mm/memory.c:3971)
> [ 61.611179][ T5947] __handle_mm_fault (mm/memory.c:5274)
> [ 61.616203][ T5947] handle_mm_fault (mm/memory.c:5439)
> [ 61.621051][ T5947] do_user_addr_fault (arch/x86/mm/fault.c:1365)
> [ 61.626151][ T5947] exc_page_fault (arch/x86/include/asm/irqflags.h:37 arch/x86/include/asm/irqflags.h:72 arch/x86/mm/fault.c:1513 arch/x86/mm/fault.c:1561)
> [ 61.630824][ T5947] asm_exc_page_fault (arch/x86/include/asm/idtentry.h:570)
> [   61.635748][ T5947] RIP: 0033:0x5612d5878ad6
> [ 61.640229][ T5947] Code: 01 00 00 00 e8 1b f9 ff ff 89 c7 e8 6c ff ff ff bf 00 00 00 00 e8 0a f9 ff ff 85 d2 74 08 48 8d 04 f7 48 8b 00 c3 48 8d 04 f7 <48> 89 30 b8 00 00 00 00 c3 41 54 55 53 48 85 ff 0f 84 21 01 00 00
> All code
> ========
>     0:	01 00                	add    %eax,(%rax)
>     2:	00 00                	add    %al,(%rax)
>     4:	e8 1b f9 ff ff       	call   0xfffffffffffff924
>     9:	89 c7                	mov    %eax,%edi
>     b:	e8 6c ff ff ff       	call   0xffffffffffffff7c
>    10:	bf 00 00 00 00       	mov    $0x0,%edi
>    15:	e8 0a f9 ff ff       	call   0xfffffffffffff924
>    1a:	85 d2                	test   %edx,%edx
>    1c:	74 08                	je     0x26
>    1e:	48 8d 04 f7          	lea    (%rdi,%rsi,8),%rax
>    22:	48 8b 00             	mov    (%rax),%rax
>    25:	c3                   	ret
>    26:	48 8d 04 f7          	lea    (%rdi,%rsi,8),%rax
>    2a:*	48 89 30             	mov    %rsi,(%rax)		<-- trapping instruction
>    2d:	b8 00 00 00 00       	mov    $0x0,%eax
>    32:	c3                   	ret
>    33:	41 54                	push   %r12
>    35:	55                   	push   %rbp
>    36:	53                   	push   %rbx
>    37:	48 85 ff             	test   %rdi,%rdi
>    3a:	0f 84 21 01 00 00    	je     0x161
> 
> Code starting with the faulting instruction
> ===========================================
>     0:	48 89 30             	mov    %rsi,(%rax)
>     3:	b8 00 00 00 00       	mov    $0x0,%eax
>     8:	c3                   	ret
>     9:	41 54                	push   %r12
>     b:	55                   	push   %rbp
>     c:	53                   	push   %rbx
>     d:	48 85 ff             	test   %rdi,%rdi
>    10:	0f 84 21 01 00 00    	je     0x137
> [   61.660112][ T5947] RSP: 002b:00007ffd09f037d8 EFLAGS: 00010246
> [   61.666250][ T5947] RAX: 00007f4966b3b6b8 RBX: 000000000000358f RCX: 00000005deece66d
> [   61.674295][ T5947] RDX: 0000000000000000 RSI: 000000002fa0f0d7 RDI: 00007f47e9ac3000
> [   61.682347][ T5947] RBP: 000000002fa0f0d7 R08: 00007ffd09f0386c R09: 0000000000000001
> [   61.690401][ T5947] R10: 00007ffd09f037c0 R11: 0000000000000000 R12: 000000000001ac78
> [   61.698449][ T5947] R13: 00007f47e9ac3000 R14: 00007ffd09f0386c R15: 00007ffd09f03970
> [   61.706500][ T5947]  </TASK>
> [   61.709607][ T5947] Modules linked in: kmem xfs loop device_dax nd_pmem dax_pmem nd_btt btrfs blake2b_generic xor raid6_pq libcrc32c intel_rapl_msr intel_rapl_common x86_pkg_temp_thermal intel_powerclamp coretemp sd_mod t10_pi crc64_rocksoft_generic crc64_rocksoft crc64 kvm_intel sg kvm irqbypass crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel sha512_ssse3 ahci ipmi_ssif rapl intel_cstate ast libahci mei_me drm_shmem_helper i2c_i801 ioatdma acpi_ipmi libata drm_kms_helper mei intel_uncore joydev i2c_smbus intel_pch_thermal dax_hmem dca wmi ipmi_si ipmi_devintf ipmi_msghandler nfit libnvdimm acpi_power_meter acpi_pad drm fuse ip_tables
> [   61.768510][ T5947] ---[ end trace 0000000000000000 ]---
> [   61.786010][ T5947] pstore: backend (erst) writing error (-28)
> [ 61.792055][ T5947] RIP: 0010:do_swap_page (mm/memory.c:3990 (discriminator 3))
> [ 61.797397][ T5947] Code: 6f 28 31 d2 be 01 00 00 00 4c 89 ff e8 9b 43 03 00 49 c7 47 28 00 00 00 00 4c 89 f9 48 c7 44 24 08 00 00 00 00 e9 cf fb ff ff <0f> 0b 49 8b 45 08 f0 48 83 28 01 0f 85 3f fc ff ff 49 8b 45 08 4c
> All code
> ========
>     0:	6f                   	outsl  %ds:(%rsi),(%dx)
>     1:	28 31                	sub    %dh,(%rcx)
>     3:	d2 be 01 00 00 00    	sarb   %cl,0x1(%rsi)
>     9:	4c 89 ff             	mov    %r15,%rdi
>     c:	e8 9b 43 03 00       	call   0x343ac
>    11:	49 c7 47 28 00 00 00 	movq   $0x0,0x28(%r15)
>    18:	00
>    19:	4c 89 f9             	mov    %r15,%rcx
>    1c:	48 c7 44 24 08 00 00 	movq   $0x0,0x8(%rsp)
>    23:	00 00
>    25:	e9 cf fb ff ff       	jmp    0xfffffffffffffbf9
>    2a:*	0f 0b                	ud2		<-- trapping instruction
>    2c:	49 8b 45 08          	mov    0x8(%r13),%rax
>    30:	f0 48 83 28 01       	lock subq $0x1,(%rax)
>    35:	0f 85 3f fc ff ff    	jne    0xfffffffffffffc7a
>    3b:	49 8b 45 08          	mov    0x8(%r13),%rax
>    3f:	4c                   	rex.WR
> 
> Code starting with the faulting instruction
> ===========================================
>     0:	0f 0b                	ud2
>     2:	49 8b 45 08          	mov    0x8(%r13),%rax
>     6:	f0 48 83 28 01       	lock subq $0x1,(%rax)
>     b:	0f 85 3f fc ff ff    	jne    0xfffffffffffffc50
>    11:	49 8b 45 08          	mov    0x8(%r13),%rax
>    15:	4c                   	rex.WR
> 
> 
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20231219/202312192319.fa8f5709-oliver.sang@intel.com
> 
> 
> 
Hello,

Starting from next-20231214 until next-20231220 have noted regression 
where kernel hangs randomly while running virtualization tests [multiple 
start-shutdown and reboot] against AMD sev guest type, with below call 
trace:

[ 6251.931094] BUG: kernel NULL pointer dereference, address: 
0000000000000000
[ 6251.931297] #PF: supervisor read access in kernel mode
[ 6251.931456] #PF: error_code(0x0000) - not-present page
[ 6251.931604] PGD 800011016c067 P4D 800011016c067 PUD 0
[ 6251.931757] Oops: 0000 [#2] PREEMPT SMP NOPTI
[ 6251.931910] CPU: 20 PID: 11025 Comm: GC Thread#42 Kdump: loaded 
Tainted: G      D            6.7.0-rc6-next-20231219-next-20231219- #1
[ 6251.932259] Hardware name: Dell Inc. PowerEdge R6515/07PXPY, BIOS 
2.8.5 08/18/2022
[ 6251.932434] RIP: 0010:swapin_readahead+0x8f/0x4f0
[ 6251.932616] Code: ff 48 8b 8d 68 ff ff ff 8b 75 84 4c 89 e2 48 8b bd 
70 ff ff ff e8 91 fb ff ff 48 89 c3 4d 85 e4 74 08 41 f6 44 24 06 01 75 
46 <48> 8b 13 48 89 d8 83 e2 40 74 15 8b 53 64 48 83 ea 01 48 23 95 70
[ 6251.933025] RSP: 0018:ffffc9003607fc88 EFLAGS: 00010246
[ 6251.933229] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 
000000000000001b
[ 6251.933453] RDX: ffff88812c45b380 RSI: 00000000000d021b RDI: 
0000000000000000
[ 6251.933668] RBP: ffffc9003607fd28 R08: ffffc9003607fcbf R09: 
00000000000d021b
[ 6251.933885] R10: 0000000000000008 R11: 0000000000000003 R12: 
ffffffff9ef16040
[ 6251.934116] R13: ffffc9003607fdf0 R14: 00000000000d021b R15: 
ffff88a09ce680b8
[ 6251.934339] FS:  00007fe71cdd9640(0000) GS:ffff88a000300000(0000) 
knlGS:0000000000000000
[ 6251.934569] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 6251.934802] CR2: 0000000000000000 CR3: 000800011b43a003 CR4: 
0000000000770ef0
[ 6251.935067] PKRU: 55555554
[ 6251.935306] Call Trace:
[ 6251.935560]  <TASK>
[ 6251.935844]  ? show_regs+0x6d/0x80
[ 6251.936098]  ? __die+0x29/0x70
[ 6251.936339]  ? page_fault_oops+0x15f/0x460
[ 6251.936585]  ? psi_group_change+0x175/0x3b0
[ 6251.936830]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 6251.937080]  ? do_user_addr_fault+0x30f/0x690
[ 6251.937331]  ? exc_page_fault+0x7c/0x190
[ 6251.937580]  ? asm_exc_page_fault+0x2b/0x30
[ 6251.937834]  ? swapin_readahead+0x8f/0x4f0
[ 6251.938087]  ? swapin_readahead+0x3c7/0x4f0
[ 6251.938341]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 6251.938599]  do_swap_page+0x3ae/0xca0
[ 6251.938854]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 6251.939110]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 6251.939366]  ? __pte_offset_map+0x20/0x190
[ 6251.939626]  __handle_mm_fault+0x879/0xe80
[ 6251.939890]  handle_mm_fault+0xc6/0x2f0
[ 6251.940151]  do_user_addr_fault+0x220/0x690
[ 6251.940413]  exc_page_fault+0x7c/0x190
[ 6251.940677]  asm_exc_page_fault+0x2b/0x30
[ 6251.940941] RIP: 0033:0x7fe7a57ddf24
[ 6251.941205] Code: 16 4d 01 7c c6 68 e9 8b fd ff ff 48 8b 43 38 49 89 
44 24 38 48 8b 43 30 49 89 44 24 30 48 8b 43 28 49 89 44 24 28 48 8b 43 
20 <49> 89 44 24 20 48 8b 43 18 49 89 44 24 18 48 8b 43 10 49 89 44 24
[ 6251.941777] RSP: 002b:00007fe71cdd8ab0 EFLAGS: 00010213
[ 6251.942072] RAX: 0000000056293b73 RBX: 00000000fbad2aa8 RCX: 
00000000fc31eadb
[ 6251.942368] RDX: 00007fe7a5fad308 RSI: 0000000000000010 RDI: 
00007fe7a003b950
[ 6251.942662] RBP: 00007fe71cdd8b20 R08: 0000000000040000 R09: 
0000000000000000
[ 6251.942957] R10: 0000000000000001 R11: 0000000000000001 R12: 
00000000fc31ead8
[ 6251.943253] R13: 0000000000000005 R14: 00007fe550000d50 R15: 
0000000000000005
[ 6251.943552]  </TASK>
[ 6251.943838] Modules linked in: binfmt_misc tls overlay ib_core 
xt_CHECKSUM xt_MASQUERADE xt_conntrack ipt_REJECT xt_tcpudp nft_compat 
x_tables nf_nat_tftp nf_conntrack_tftp bridge stp llc nft_fib_inet 
nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 
nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack 
nf_defrag_ipv6 nf_defrag_ipv4 ip_set nf_tables nfnetlink sunrpc 
nls_iso8859_1 ipmi_ssif intel_rapl_msr intel_rapl_common amd64_edac 
kvm_amd kvm rapl joydev input_leds wmi_bmof efi_pstore pcspkr acpi_ipmi 
i2c_piix4 k10temp ipmi_si ipmi_devintf ipmi_msghandler acpi_power_meter 
evbug mac_hid sch_fq_codel xfs libcrc32c mgag200 drm_kms_helper 
i2c_algo_bit drm_shmem_helper hid_generic drm crct10dif_pclmul 
crc32_pclmul ghash_clmulni_intel sha512_ssse3 usbmouse usbkbd 
sha256_ssse3 mpt3sas sha1_ssse3 tg3 usbhid ccp hid raid_class 
scsi_transport_sas sp5100_tco wmi dm_mirror dm_region_hash dm_log msr 
autofs4 aesni_intel crypto_simd cryptd
[ 6251.946304] CR2: 0000000000000000
[ 6251.946607] ---[ end trace 0000000000000000 ]---


Thanks,
"Aithal, Srikanth" <sraithal@amd.com>

