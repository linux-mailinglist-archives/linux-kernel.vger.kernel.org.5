Return-Path: <linux-kernel+bounces-142982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 210998A32E5
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 17:53:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 437241C22D65
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 15:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D21914882A;
	Fri, 12 Apr 2024 15:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mdeUb6K9"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2086.outbound.protection.outlook.com [40.107.92.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2631487EB
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 15:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712937168; cv=fail; b=nimQ0zqfFcUKmywZ8qjSWjmPULFmbSzbV/s4qAbC6QryYv9MFGOrVLkT0osotgfpxM/yTAoafoKlvHMv4Vdcg+yt3EuyD09NcKGO/PuxP56mFOdwWRNXbY5JqnrHfddPOiKmZLPzqWVILMcXbYGCPePkiL+QAS1vZWZKF6+5l+8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712937168; c=relaxed/simple;
	bh=okLufqXGPKtylXVl8sNesoOmUQkASBZXB7rYMFl+n1c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=c/tKabYp2j4EmHdpLBu5FZobOwo+njYyqoTz2PXPqm+AV2NcDQdx72iTwXmaaDgdlvo1cwRJZpRet5i11q7yZT2/vbSm7clZM+UWr18GD5pBBFx/Vh+YyCbNVutKcLvGfOvjYbuDYt9i6GJkHp8o02B8G0kMzRsQplv3fj+QJg8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mdeUb6K9; arc=fail smtp.client-ip=40.107.92.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OtsYqjBiCcjB/1neYGRhHjDxRXWyOSCUXzpqEPerjk1GRRakHN4tsNXsITkruoXcz8FyKuk9yQKWwN+pZ0X2cLx8qK+JQMvptwLTQcUkz3kdCd9y1KQA25y8J1f3azzmaYIdeZYqXg+OIO5qBJputbx19kNof8tctLmTxTLVh9Qewro6vuaaLNPrDnHJ0YuhQl3kNv5ROrjY/hu0vnjRWXSbIGgSoq3sQ/wPiRCmqvJwSkFGfubCX4fvSVwKNEWNUA2KON1kjo+okzrl+QlSDNOI8edBKN+LTyI7MhmPZpSTH44lEyKCOF0RNia9u7f9IwwJr/WjZGm6lTlArjygWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bBcAPA3PSbuCASCghD8Amfazdu4/aMtn1ZMbaS61Y58=;
 b=Nv5Pf8Ks84V/hxRjJn0N8kLuXeJWPLj0qv5dhCUUt8DUfJymdE+GknZeqYttofoh9+2m6iQWPQioIfWOlxFqxsOz9Ks3q5EoNJmEz8txsgh0SLk3qmpFSDG0Gl5uRsi4gps4yeDALJIWEuRKaz54BONjERHSbu9WYMZKY/SxTBq1DeruCeRx4DaAMycTR2DsArwmML44uSAdA/6B3IjB/opWq50RAsF/6FXfEjTyECP8aPkHtzORrsQg7vHrmt89ya4PVe1oyoKyMxX39t1D8ITWTLtr6M9bHFuGG75P4wAg7eHRJlhbtEPZTTD9AMYFuU/oHP1/yoDl56Rqs5wQdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bBcAPA3PSbuCASCghD8Amfazdu4/aMtn1ZMbaS61Y58=;
 b=mdeUb6K9NcdpTqHLHqq4J7VorxToOIt0OHGnC84trRv7kVdPs22oHPIXKAff3PYelMG/e0N3q4nGutnwiQJNFcRD1yvruxv1nEbgKP0Su1IsCTosNjZp7D0jkmYhE4kAJisnY113mG1nty0eCQkyH1VKMY5gQjW1UNqgJOaxvwg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17)
 by BL1PR12MB5851.namprd12.prod.outlook.com (2603:10b6:208:396::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Fri, 12 Apr
 2024 15:52:43 +0000
Received: from BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::1032:4da5:7572:508]) by BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::1032:4da5:7572:508%6]) with mapi id 15.20.7409.042; Fri, 12 Apr 2024
 15:52:43 +0000
Message-ID: <19d69960-e548-a2e6-87d9-c463f2851613@amd.com>
Date: Fri, 12 Apr 2024 10:52:40 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 13/14] x86/sev: Hide SVSM attestation entries if not
 running under an SVSM
Content-Language: en-US
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 linux-kernel@vger.kernel.org, x86@kernel.org, linux-coco@lists.linux.dev,
 svsm-devel@coconut-svsm.dev
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Dan Williams <dan.j.williams@intel.com>, Michael Roth
 <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>,
 Joel Becker <jlbec@evilplan.org>, Christoph Hellwig <hch@lst.de>
References: <cover.1711405593.git.thomas.lendacky@amd.com>
 <67893f352bc54de61160bfe251cba0bdf0431f37.1711405593.git.thomas.lendacky@amd.com>
 <1f6f4477-0f2a-434a-8c89-3b5d51d61581@linux.intel.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <1f6f4477-0f2a-434a-8c89-3b5d51d61581@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR2101CA0014.namprd21.prod.outlook.com
 (2603:10b6:805:106::24) To BL1PR12MB5732.namprd12.prod.outlook.com
 (2603:10b6:208:387::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5732:EE_|BL1PR12MB5851:EE_
X-MS-Office365-Filtering-Correlation-Id: 95100450-afe0-4003-a556-08dc5b089712
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	UU/RqnDQEDLGGVzJrk1KBdaT/E0RSX+DQdMQ8Fshnwb0B6GFdVzPNUzZ/zEETLv+X/TKJsCpPhBzTyPJbpggiWzgeyAkc+7TQqClWEeMm7E/7/YxPrTKmmgVJBvznk5l5HVey4PJ/oSOeatyu5FTke5OAhWt1d/wCu4L1/fFAh/65UIp3hvvoNOAZ3ZOhvMX4C+w48zLzxonAui5lF9SSwGp6q/28g/S9E34LWW3SUlBN7+J/2piUw44YNaBeWmvwAOWeY2U6T6z4/kiDWHhhlkll9OTum35C6J32lY1FORH+f8Wf03srF6qdEZmSaxm60/Q7snq5pdQoGpsr9G1ed5B5rf7tnytY5mKSb8tZcAP60jpTAEmddLZwvWnx4eOSSUGmVRP8sE9Xim26EYRkQgFK8H1xkcpVKD9nIFS6WZNWGoVb1JcB7KzCo5GKHAw0QX3ELLCGs2uUW2lB7+p2K5BUiQYEnZVL9ccLBBXCVy37VA3GpH5DXxPZWRrNsW5Nsc2JVVsX5LPteI2TcXhEzijAbTGrj3jP3kXEAt6j5bQF1dMVa56+Qh5W6rJyK78JWy4t0W2Jzr8uTehiyuN6NMNUtdc1lxLL9Hr4mHm2ugaz1gZLsiGzZuWOtXAQXHunAbaTG4e0N0FQqB2t8p4Mv5NfptmSaY8prRyeLsIVkk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5732.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WEZEM0pNY1QvcDhoVnJXVFBUUGh5OVg2K1Fwak13U1RSb0hUWXlBUFZtaW1m?=
 =?utf-8?B?TWhoby83K1BvWGZNVXQ0NkUvM2ZvYmcxVjg2TXFuOHY5cmZBdnl2QWwwRXM4?=
 =?utf-8?B?OVI3ODZCTnBRVmRmQUZ0bjljSmo3b21ucXJXYkthRzRybGtHYkpiekhBNGtU?=
 =?utf-8?B?ZC9lUmxGNEcvRTVnYTdiVGt6ZE00SG1kT3YwQi9MTkZTbStjZWExVGloYkl2?=
 =?utf-8?B?RE9uaUVzdk1NZkdwTkdjcWVQcGl3eFN1RE54anZYcGk0d3E0cDIvRDljUzYx?=
 =?utf-8?B?M1g0OGJNWE5KTHFMdnVKQy92Z1JxakFmbVBsT043Z0tuTHpJaXloZ1pIUVRQ?=
 =?utf-8?B?bkRGVlVRUmgrN2N5cDZyVmo1RzRqQVhUWm5Qd29JSkdvZGREb2haK2dSV251?=
 =?utf-8?B?Vmplc0RzZ2x2WHdFODY4S3NqM0RRSmhuMm1xNnltaTJzZTI4RDRaS0FDRzN4?=
 =?utf-8?B?NVF1S2lOSk5MSlFib0lSSnBpYkxMUmxoQUpHcGRwUlllVlNpSkF1aWtUWTNI?=
 =?utf-8?B?enJzbXV1eEU0aHVGcHgzN1BaQm1BVVBCMEhpdkZDSDRHK0JwSEErTkk4WVN3?=
 =?utf-8?B?NUVOcW56aGxCZXdQRTVJV3VVajFsYWx3dm14RitDdU4yUVVUcitJVU9vZUFZ?=
 =?utf-8?B?Ylo1Z2hjV2ZqQ2hqUzVQRzg0cjRaY2hVUDE5SERrMVBjdk9FeWhCN0JxQ09H?=
 =?utf-8?B?cStqYjF0RFFqWlV3bHUvc0Q1MXFhQ3kzcVNWWjhOSG5BV1U5OW9IVnFIR0Ns?=
 =?utf-8?B?SEgxSHY1OHZyWVlKa1VmcVcrV2kyQVQ3dVNOTlhmMTZpM2QxajdxZEQvajZT?=
 =?utf-8?B?M0ErcXo1TVpSR0VtL0s5RjZNcnN4NlNxK09FZDJ5bWtZMXhVSkJWNS9DTUcr?=
 =?utf-8?B?d2IxMXhvNmxuYWRUSGlsdHkwVnhCVjZYZmV5dTNuLzhaU2Ura2EzaENYQkxq?=
 =?utf-8?B?akF0MGdXWnVkTmR1eVdOL1pXZW40YXE2bWViN2wxRlErZWpTUlo2RmxRRVpB?=
 =?utf-8?B?MkMzNzAzM2w4cDNXMHA4ekhPcnhLQldKUUFCeVpHb0pYZ01qWTJ4Wk9mZng0?=
 =?utf-8?B?SEwwalhQalUzYWJyOWlVcjdoa3M0My9ZVDg4cTFVMVNZS1NyTVppVmRrWDU1?=
 =?utf-8?B?MVBrQzRTSk1QWUJBaTRrL0U1NDBGZ250V1hPaDJoN2ZPc0trUmhhaytPWG8w?=
 =?utf-8?B?QS9hUkxnQkdZRXVDNUl6enpXUkgxemlpT3Q1NmpHczBMeFZyckNldmk0NFpQ?=
 =?utf-8?B?Tm42YzNyUU5WMUdqa3JaNlk3QXdUZVRjZWpiS2JEdm1QNjlCQ043Z0hNMXI3?=
 =?utf-8?B?cDRuRVl2OEsvNThxbzJkRk5tVExtekJoWk5mWlNxL0tad0d6S0FQRSt5enU3?=
 =?utf-8?B?aEdkdHVxYnBieWpoLy9jOS9EUU90bGZiNVhaeHFkR0ZuN2RQa0oycGZUUG5r?=
 =?utf-8?B?VEtCelVYZnJodlo4K3ZzcnpFVUEySnhGTFNhZkZqMXVXellRUHNwYjRucjVj?=
 =?utf-8?B?VmlKdlc2SmJ4UzNlblRxZlhTZVhYZEdjT3FXV1RUZnNZRmcrK09ZRStzWVhU?=
 =?utf-8?B?OGdhOSszVXFZektlUjJ2Ty9NNStvYzh0T3BNOGpoVElweGU1amdOSmhxTFV3?=
 =?utf-8?B?M0JMelBSQjVTQnlWZlpjS015dFRPMXNMOUhwYVZ6ZWFHbmVtVHBmcytuZEFt?=
 =?utf-8?B?ZWtWOHR3YnYrcGlGMm1UUTVmYU1ZSnVpdTV2cW5hbDNKZUxHZzhUdjBmSkJX?=
 =?utf-8?B?eGNUUkRqZU8ydDBYY1BJWEw5em5LQmxQbGtHa0ZMNDBlcGZOcWNuc0tnTGJV?=
 =?utf-8?B?ajJ5dUU2R0ZxY3dqTDVVZXg0cTBDeElheHRiRnRraEloRkZnWHJxdkdKbmRn?=
 =?utf-8?B?OW8vMFd6WnBydUkwQ0VFcVNKem9hSjFWQTA2LzVIMFRhWkViSWlVQ21QS1M2?=
 =?utf-8?B?eWt2dFlLeURFSXJVazBEMXhlKzhQb05LbDNHcmw0SG1SK2l4UzZLbkYxMGlq?=
 =?utf-8?B?RjJ4UlB3NXkrLzdsNHJCV3NnS24xMndwNEdLZ1BwOWNVYTJKUFVwVTVzbnFa?=
 =?utf-8?B?TTMvRi9QN29aWm4yMlpOcVFiUkx4Qko0MWxWbmZjWW1SVU9CZk9nalFWR0xa?=
 =?utf-8?Q?Ut3PB+7GTtJxY9T09RqNdz1hb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95100450-afe0-4003-a556-08dc5b089712
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 15:52:43.4060
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TJ297CwTXkljKOCc54y9mJufJicdu5U34EWoDhYlEgvijDzrXiWNi1e8rE1OZu+RFt7bwPP9jy05FfHCdj6PwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5851

On 4/9/24 13:12, Kuppuswamy Sathyanarayanan wrote:
> 
> On 3/25/24 3:26 PM, Tom Lendacky wrote:
>> Config-fs provides support to hide individual attribute entries. Using
>> this support, base the display of the SVSM related entries on the presence
>> of an SVSM.
>>
>> Cc: Joel Becker <jlbec@evilplan.org>
>> Cc: Christoph Hellwig <hch@lst.de>
>> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
>> ---
>>   arch/x86/coco/core.c        |  4 ++++
>>   drivers/virt/coco/tsm.c     | 14 ++++++++++----
>>   include/linux/cc_platform.h |  8 ++++++++
>>   3 files changed, 22 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/x86/coco/core.c b/arch/x86/coco/core.c
>> index d07be9d05cd0..efa0f648f754 100644
>> --- a/arch/x86/coco/core.c
>> +++ b/arch/x86/coco/core.c
>> @@ -12,6 +12,7 @@
>>   
>>   #include <asm/coco.h>
>>   #include <asm/processor.h>
>> +#include <asm/sev.h>
>>   
>>   enum cc_vendor cc_vendor __ro_after_init = CC_VENDOR_NONE;
>>   u64 cc_mask __ro_after_init;
>> @@ -78,6 +79,9 @@ static bool noinstr amd_cc_platform_has(enum cc_attr attr)
>>   	case CC_ATTR_GUEST_STATE_ENCRYPT:
>>   		return sev_status & MSR_AMD64_SEV_ES_ENABLED;
>>   
>> +	case CC_ATTR_GUEST_SVSM_PRESENT:
>> +		return snp_get_vmpl();
>> +
>>   	/*
>>   	 * With SEV, the rep string I/O instructions need to be unrolled
>>   	 * but SEV-ES supports them through the #VC handler.
>> diff --git a/drivers/virt/coco/tsm.c b/drivers/virt/coco/tsm.c
>> index 46f230bf13ac..d30471874e87 100644
>> --- a/drivers/virt/coco/tsm.c
>> +++ b/drivers/virt/coco/tsm.c
>> @@ -64,6 +64,12 @@ static struct tsm_report_state *to_state(struct tsm_report *report)
>>   	return container_of(report, struct tsm_report_state, report);
>>   }
>>   
>> +static bool provider_visibility(const struct config_item *item,
>> +				const struct configfs_attribute *attr)
>> +{
>> +	return cc_platform_has(CC_ATTR_GUEST_SVSM_PRESENT);
>> +}
>> +
> 
> Any comment about the following query? I think introducing a CC flag for this use
> case is over kill.
> 
> https://lore.kernel.org/lkml/6b90b223-46e0-4e6d-a17c-5caf72e3c949@linux.intel.com/

If you don't think TDX will be able to make use of the SVSM attribute I 
can look at adding a callback. But I was waiting to see if anyone else had 
comments, for or against, before re-doing it all.

Thanks,
Tom

> 
>>   static int try_advance_write_generation(struct tsm_report *report)
>>   {
>>   	struct tsm_report_state *state = to_state(report);
>> @@ -144,7 +150,7 @@ static ssize_t tsm_report_service_provider_store(struct config_item *cfg,
>>   
>>   	return len;
>>   }
>> -CONFIGFS_ATTR_WO(tsm_report_, service_provider);
>> +CONFIGFS_ATTR_VISIBLE_WO(tsm_report_, service_provider, provider_visibility);
>>   
>>   static ssize_t tsm_report_service_guid_store(struct config_item *cfg,
>>   					     const char *buf, size_t len)
>> @@ -165,7 +171,7 @@ static ssize_t tsm_report_service_guid_store(struct config_item *cfg,
>>   
>>   	return len;
>>   }
>> -CONFIGFS_ATTR_WO(tsm_report_, service_guid);
>> +CONFIGFS_ATTR_VISIBLE_WO(tsm_report_, service_guid, provider_visibility);
>>   
>>   static ssize_t tsm_report_service_manifest_version_store(struct config_item *cfg,
>>   							 const char *buf, size_t len)
>> @@ -186,7 +192,7 @@ static ssize_t tsm_report_service_manifest_version_store(struct config_item *cfg
>>   
>>   	return len;
>>   }
>> -CONFIGFS_ATTR_WO(tsm_report_, service_manifest_version);
>> +CONFIGFS_ATTR_VISIBLE_WO(tsm_report_, service_manifest_version, provider_visibility);
>>   
>>   static ssize_t tsm_report_inblob_write(struct config_item *cfg,
>>   				       const void *buf, size_t count)
>> @@ -333,7 +339,7 @@ static ssize_t tsm_report_manifestblob_read(struct config_item *cfg, void *buf,
>>   
>>   	return tsm_report_read(report, buf, count, TSM_MANIFEST);
>>   }
>> -CONFIGFS_BIN_ATTR_RO(tsm_report_, manifestblob, NULL, TSM_OUTBLOB_MAX);
>> +CONFIGFS_BIN_ATTR_VISIBLE_RO(tsm_report_, manifestblob, NULL, TSM_OUTBLOB_MAX, provider_visibility);
>>   
>>   #define TSM_DEFAULT_ATTRS() \
>>   	&tsm_report_attr_generation, \
>> diff --git a/include/linux/cc_platform.h b/include/linux/cc_platform.h
>> index cb0d6cd1c12f..f1b4266c1484 100644
>> --- a/include/linux/cc_platform.h
>> +++ b/include/linux/cc_platform.h
>> @@ -90,6 +90,14 @@ enum cc_attr {
>>   	 * Examples include TDX Guest.
>>   	 */
>>   	CC_ATTR_HOTPLUG_DISABLED,
>> +
>> +	/**
>> +	 * @CC_ATTR_GUEST_SVSM_PRESENT: Guest is running under an SVSM
>> +	 *
>> +	 * The platform/OS is running as a guest/virtual machine and is
>> +	 * running under a Secure VM Service Module (SVSM).
>> +	 */
>> +	CC_ATTR_GUEST_SVSM_PRESENT,
>>   };
>>   
>>   #ifdef CONFIG_ARCH_HAS_CC_PLATFORM
> 

