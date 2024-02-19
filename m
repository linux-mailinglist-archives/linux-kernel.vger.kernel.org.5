Return-Path: <linux-kernel+bounces-72044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1452985AE30
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 23:10:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63F331F22631
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 22:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D901354F8B;
	Mon, 19 Feb 2024 22:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="40S0AzVQ"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142C25466C
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 22:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708380607; cv=fail; b=FX3QSC9yXsUDp7/qXRLZzmRGQ5GKTuPOAdIqnUWxulkjsf1KXZ6Dd5cSETkUP2CK3yNHQzSlzg5Ax1hAOK0rZ+xQ3wKjHd/2Ug8Y6oxhOtn8IeHKDtQiiHgtXAhiKJnQZBIIbjn2l75wo9u/2UulhuXx7kH5MdtMlfG6jbrBJH4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708380607; c=relaxed/simple;
	bh=8f8dSP1msfgijRQN8SKEEM6FYXR4G0RS0yjxlbhuqRE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lpEDUCX499KyQ9ebk8ntfKLN0enA3KqK7enJjn5MqWls51Ji+bPdcqBU71ydfVSKrLVK1eJhpNZInZKLm8hItlfL2sTHvN262rBaWtLWzs1QjF5lAnZPj1eEDJNk0iY03IxgE3fGvgVzyGwcyViI/QZDxTngxdp8CQ8s+MuX478=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=40S0AzVQ; arc=fail smtp.client-ip=40.107.236.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h/GCOYfVdB0nwXQcJy5M1x3ZZlqqY8RjlWCXe4/wdBo4kZsqs+avv6rG4PFUW26/xOoZTQjh2a5yGwbFfp6nCvlZMVQF/bhwvxXdkF41IvseipbxIpatcbJuw1iguE88NAliCP+Y0NnGt/boPAXJ1kV7cPkf0/PYmW9pXtyjbdLNPDOa/JeG/J8ldESEewET+rfYFiz7WwQHAyiZnXH3aq5euqJ38QC8YvAIEv2WBU9Y7S3oytOHOiOfcqMIRGKYBtsnkbP4oSk57W2g36KhIkArQnIGBDnLiUc51/YE2wh7/ymPGEXF/PJGcfG+OObQoXH9Y6t9E4XQed9CV0IHDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bY2Eof6zhOlECeTlnOShtmkdbVTv0SpQOXyhItEp4Sw=;
 b=jgHguI4Cx89drunQSTBn4nivEwZGR3lVxU+J2Vj+4xTYidK/CyTwIG1iOZNsHNC5J1FESqOh5k32WA7SiXC3iB/n4Ogk/t/r/m7WLQayLwi2ODeRqSvanUnoYTZDzmJa0pTnxuw87/m1xazFOARFpCHWll9lFC4kwbc7QqKJj+1L5QrmgLRhX2a3fc1ogDgfveI/Jxh7i7hWnCjti1MHP/f4vaTvMpU+TaZAJgFWwiLiqhlZAlWRENldzIJ9atIa5Va9tGmM9q6EzLaPSqZ6zXdhlcmc5EvKt2fbyboWS4Bc1AD6tYaJalwBpCqc7jMJu7O9/vUgnkCggDUvDlFBxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bY2Eof6zhOlECeTlnOShtmkdbVTv0SpQOXyhItEp4Sw=;
 b=40S0AzVQA3ElZcOiY/Kfgfr57S9SUoRNammukAtNGEByxmlHM9qfyk81iriZq1VITjWBsjSxn38RQ7SGCVPaWRV1JbnVm/w0X0crqmQNuEt+4dIGUxB0PaPm9Dt4xibS5uBHMAtwKikOUeIHQAxQtSJ3k7AwdQfDF1Ib6iLHwWM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17)
 by DS0PR12MB8573.namprd12.prod.outlook.com (2603:10b6:8:162::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.19; Mon, 19 Feb
 2024 22:10:00 +0000
Received: from BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::db9b:a5f:5d0a:2a42]) by BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::db9b:a5f:5d0a:2a42%4]) with mapi id 15.20.7316.018; Mon, 19 Feb 2024
 22:10:00 +0000
Message-ID: <283877fd-78c7-4322-bbce-ba6420d56765@amd.com>
Date: Mon, 19 Feb 2024 16:09:47 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] x86/coco: Add a new CC attribute to unify cache flush
 during kexec
Content-Language: en-US
To: Borislav Petkov <bp@alien8.de>
Cc: "Huang, Kai" <kai.huang@intel.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org, dave.hansen@intel.com, kirill.shutemov@linux.intel.com,
 tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, luto@kernel.org,
 peterz@infradead.org, chao.gao@intel.com, bhe@redhat.com,
 nik.borisov@suse.com, pbonzini@redhat.com
References: <cover.1706698706.git.kai.huang@intel.com>
 <cd88e97e53c502f0a457d6a82a31d9e8e0f9fca7.1706698706.git.kai.huang@intel.com>
 <20240219161611.GBZdN-y6DO-cspaZrf@fat_crate.local>
 <9164b0e3-f520-4aab-8b80-520131f0e4db@amd.com>
 <20240219203222.GIZdO61ucfq4bFxRT0@fat_crate.local>
From: Tom Lendacky <thomas.lendacky@amd.com>
Autocrypt: addr=thomas.lendacky@amd.com; keydata=
 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
 vFkWitqCJg==
In-Reply-To: <20240219203222.GIZdO61ucfq4bFxRT0@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0066.namprd13.prod.outlook.com
 (2603:10b6:806:23::11) To BL1PR12MB5732.namprd12.prod.outlook.com
 (2603:10b6:208:387::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5732:EE_|DS0PR12MB8573:EE_
X-MS-Office365-Filtering-Correlation-Id: 6312961b-f59e-455a-e8d4-08dc319783cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8wnNqIfhPE9fT9FKTH7R7V9Sa+tH2Zk0VO0ju1m+Xr05gBqpwMyuTGK0+hBB1x+yHkeSdO4bEiJAsWxq9za88lhEnAE+XE/a56N4aKYLLkQH/rVVOr2hSm2AbzGkaWvjfU7J+7ia4igCqnU4NH8YbTcUF2Orl6UR17y8zyq+wNZcz5CpDKqTgAMHQjCJVLbtbutag8D7EEzRe9b+i+RPDI6xIdcREKVE2WGTL3wAqfAPzLSfIx/zXMLiGSqt6K0D0rfbh6RJbvjwxDDA5GZsd2N5rbXhaAaMKuHRJ06Ocz06RbccHTiw6g5SWw3UyocQSWVqweBATsSTFJk40oywVwSiJZ5RP7Kv/QkX6Jo3hzwD0hwoRJ5EJXbjRMni2d1dNmTmpw9ZHR8QQgaVJ7AVwczojC+K67ILryPvGhPWaJFdSTI6nlWz/t79NsBTviMDsp/F6kAT63WE8D+qHlNFUWuITbgQZFQFERK2w022oCuwvP56q6NZyUMAkzoqMS5Mhgi+f13bUQ9/JpVq/b1knuE4WGMYJu6vSLVos+e4xK0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5732.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dXUzMzdIdmc5VlJJNHVJWk1hcXE3ai9pRDdXb05SaDZMOXZiaVBQbUF1UXdz?=
 =?utf-8?B?MW9OSFYyK2hENXZZQkVhcWlsamFudmV1S1BpYis3eC9lN3pHWlhGWm5VQ2Fk?=
 =?utf-8?B?NDFTb3hFaDFnbkVabWRjZitMVkIwRGZRbHdIQTUrU0UvVWp2ck8vSm1RdTVZ?=
 =?utf-8?B?VXo5S05wVWNJd3Q5WnhSZmlEbnhmTjE4Z1l0VlVDditjMktiSERSV3ZHZ1Va?=
 =?utf-8?B?NjE4bUtkc3l3U05iZEhzOHZ2c0FKbGR5dXRBTUhGMTZJT1JQSTZjV0RXVExx?=
 =?utf-8?B?ejl2ZUl6RW1PRVlZMnFLQlVMRFBxdU5rbkFqdjg3KzB2NVZQcS9jMVk2SWxC?=
 =?utf-8?B?R0VvZzdnV09WblJIVWpPZXZJbkN4WEw0OXorbGFWRytuZzhjNXo5blBYTTVz?=
 =?utf-8?B?R1E4QTRJbThpU3h4cEZxOTNkUFhaZko1a2syYlRjc3NoYldUV2JlVHd4eGFH?=
 =?utf-8?B?ci9aanNFc2pjdjdIV2JCR1FRRXREL1JVcVdQOC81R3pIcFE5WGVTdFYycVN6?=
 =?utf-8?B?YWFsdVFqcmF0eE5qSG1yWTdqdEUxWXNCM3UxQjl0YXVsYXp1bXJQcTNUakRX?=
 =?utf-8?B?SHo5VStnY2hPdWxTbnFFa1JhZ1NoS0FzcW9zMmUwQktURzlORVdjNTk0MW5W?=
 =?utf-8?B?TUlDanRSVGdHSUVjT2dhYjBQbFQwdWZjOUQxbnV6bDl6ME5WWXNDUWkwdmNZ?=
 =?utf-8?B?SG5tQnZKMDZ6TFJRdjZPZHM4U0tHa2sweGg5LzVGTXBhWjVGR3BXZUF1Q0dz?=
 =?utf-8?B?NFVYUGF0OVlMZ3F3S3cwb0pLZUx3cDBKV0Y0MnhIMG0yT0hsUmRFcnNkV09v?=
 =?utf-8?B?VUpzaE5wSEtKQjRqSG9yZ3JVZ1ltSlhSaVV2aTNnUW51aElWUFp0UWF4YUNV?=
 =?utf-8?B?SWVMUXpMK3VMR2YyWHAzclpoTlRSMjFic2t6YU1rOEZuak1RV29nMEFoQlpW?=
 =?utf-8?B?cUxPWFF2bWpyMkhCS25OMGF2d1dZOHNTNjB6a0I1djNUY1Q0M2JkMERGMkYv?=
 =?utf-8?B?RE1tblp2K1VuMnpEaGxSMHRwbGZqTExSZlphQm82bVBXa2JaZlVkUEpKMU9p?=
 =?utf-8?B?N1dVc1lSaHVBRk1HY2VFaXdiN0JqcVpXRitGbjRvcm8vUGxZWTYxRWhhSWlt?=
 =?utf-8?B?emtPQjF6NTdpY3N0ZHpIcW51djVGMVVGYU5hM01CNUNNcGd6eUZXVmpMRjhr?=
 =?utf-8?B?SnozN3pMUHduKzRiVW9IclBwN1Y5RGI4ZkVCMWdQamN5aWU1S09OMDdPTFNL?=
 =?utf-8?B?TmxlKzBGblk4QTl0QVFaWDNwT01IK1c3M2YyY0ZyamhhSHE2VkdXTHM4ZCs4?=
 =?utf-8?B?Njh0cnJZd1pPV3gxWWJ3eDlJejFyYnB4VHZYWFJWNUpUNkdtVzRENDNQNDFH?=
 =?utf-8?B?ZkR1YUZDZDE5UlM3VGZZbERNVWNMWWVqdE5xZ0pLYUZHbFRTVFArejQ3ZVBP?=
 =?utf-8?B?N3pjcFpYM25CSGJ2b3BFREpCd2Z1ZmhkUjR5SG16a0VaMEVHK0NWTFU1Um9O?=
 =?utf-8?B?NktoMHY4UEhCQm51RnBBa3RmNTNPVTU1d2NqdTRPckYrZ0NmMytxNXlUQkZR?=
 =?utf-8?B?RnJJeCtzVDZ0amN6aXMrSGxOMUR5QXJWeDlxRFgvZHBLM3V2bk9zNFB6ZHJB?=
 =?utf-8?B?VXpNZ2JZUUZKUUZuSTQ5NnFRL0hUWVJBOFAzdGNFTFh6dFJobVYrMUdSRU5s?=
 =?utf-8?B?Z2FldGlnSm50UlFMRlZpMmR4VDgxMDBDdHBYWkpxVXpNR1JUdDdyMXdIazV3?=
 =?utf-8?B?VzNXdWtVWnZ5bDloa29KMWhTc3A4Z0ZUS2pHaHJtbER4Rm52TGwwanJKUnd3?=
 =?utf-8?B?Mk5haGpPNXBaV0pDTGo1S205Z3B2L01TTkh1TEdQLzB4SXJwUTdtYzVYZUNM?=
 =?utf-8?B?YzNZZk9RVmFNdU02bzl5Z2F4b0ZkRVRNWktNKzJ5NUdtWTRpdFp1MTVkQkFt?=
 =?utf-8?B?bGlTNVFFWnZkNUpQRnJOTWloem5jVWdZSXltWVdRQjg2b1Q1dTFqS2dTbmlO?=
 =?utf-8?B?SmxQZXZWL3F2TGdBUm9PMnRKazVTbG5kNVh3VzU4UTVGd3NhOEJJYXM2MnRN?=
 =?utf-8?B?Rm5xWHBqM3JTZUw4S1p6cVJkZ0Q5Z2ZSYUJsYWlUNTNMV29WQTllb0FnMDF3?=
 =?utf-8?Q?tESqC2xAGrdAaAWIKxFAEX8FZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6312961b-f59e-455a-e8d4-08dc319783cf
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2024 22:10:00.2909
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XC+tbZ/dyTBnc5KNGiQTLEQA5kO0sYYRqcL0PCy/MfNiP6F2ybuAX4ghVTR02gQzgLrDAmazjCUjAOC35DAHxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8573

On 2/19/24 14:32, Borislav Petkov wrote:
> On Mon, Feb 19, 2024 at 01:45:37PM -0600, Tom Lendacky wrote:
>> This change won't return the correct answer. The check needs to remain
>> against the sev_status value.
> 
> Feel free to explain because this patch is confusing me.

In your previous email, you want to put the CC_ATTR_HOST_MEM_INCOHERENT 
case statement with the CC_ATTR_MEM_ENCRYPT case which is returning 
sme_me_mask. That will be zero/false if SME is not active, skipping the 
WBINVD. But, in reality you still need to perform the WBINVD in case the 
kexec target is doing mem_encrypt=on.

That's why the '!(sev_status & MSR_AMD64_SEV_ENABLED)' works here. 
Basically, if you are bare-metal, it will return true. And it will only 
return true for machines that support SME and have the 
MSR_AMD64_SYSCFG_MEM_ENCRYPT bit set in SYS_CFG MSR because of where the 
'cc_vendor = CC_VENDOR_AMD' assignment is. However, if you move the 
'cc_vendor = CC_VENDOR_AMD' to before the if statement, then you will have 
the WBINVD called for any machine that supports SME, even if SME is not 
possible because the proper bit in the SYS_CFG MSR hasn't been set.

I know what I'm trying to say, let me know if it is making sense...

> 
>>> So you can't put it before the if - just slap it in both branches. Geez!
>>
>> I think that will still work because sme_me_mask and sev_status will both be
>> 0 on bare-metal if 'msr & MSR_AMD64_SYSCFG_MEM_ENCRYPT' doesn't evaluate to
>> true. However, that will cause any platform that hasn't enabled memory
>> encryption (see SYS_CFG MSR), to also perform the WBINVD.
> 
> If it keeps the code simpler I don't mind. That's so not a fast path.
> 
>> That won't work, because the current system may not have SME active. The
>> cases that needs to be caught are kexec'ing from a mem_encrypt=off to a
>> mem_encrypt=on or from a mem_encrypt=on to a mem_encrypt=off.
> 
> And I'm saying, we should keep it simple and simply WBINVD on SME
> capable machines, regardless of the encryption setting.

In that case, CC_ATTR_HOST_MEM_INCOHERENT needs to be separate from 
CC_ATTR_MEM_ENCRYPT as the original patch has it. The comment might make 
more sense as:

	 * CC_ATTR_HOST_MEM_INCOHERENT represents whether SME is possible
	 * on the platform, regardless of whether mem_encrypt=on has been
	 * used to make SME active.

Thanks,
Tom

> 
> Any downsides to that which are actually real and noticeable?
> 
> Thx.
> 

