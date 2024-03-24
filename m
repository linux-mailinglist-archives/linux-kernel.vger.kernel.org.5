Return-Path: <linux-kernel+bounces-112880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52F14887F78
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:33:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D308D1F21428
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 22:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28AF210A36;
	Sun, 24 Mar 2024 22:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UGmVflMy"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2065.outbound.protection.outlook.com [40.107.220.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F2815491
	for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 22:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319574; cv=fail; b=NmlIDgqfJ3ZsOz3yIrwwpUlZt9nkQcbkNYtRgg48vvgfMQf0ig/0H/i0W2L+mbBs5zaXbyBvxa7Il9S+sEeJA5CfxeHFABU/s5k+jbLG5UOA8cvZeEzt+sWrHY/qjx+ChsvLsnhFXpOcyuO2581JW/nhrubdLF2gGiNDxwRlseA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319574; c=relaxed/simple;
	bh=Erpxa34hSTv8AwkfUADhwBMtlnx3vH+DMnoH9NgjoEo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=m2EZURR/j97zgsp3QR7Ucdt4qsMoo16uczjrSvxmEcqjkm4PIJ4CGLZtxYtAFVHPbTk0IP69YGfgSMTmSAdQ5Y9arRfWmZSxth+eHMGNJC6SWogiryDcLz/hhs4H/fEzufp+ECnrorhyrb4g7vcFZCPz1p+D4tjYU5ZweXSPddk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UGmVflMy; arc=fail smtp.client-ip=40.107.220.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KxWc5cPWKxOliAjp9PNruGq7xdyn0FAQWLFeTZFJj9Kbb4UTMgvyYSWfIZVVGGUU1JmB35FoYo+8GNqDic/2MbLudlWEgusQfg+34D6tjaoccrDbhgmrced+jOJW97a49oHRl4fcst8sSY6W+zcBCswCA1gjKXXnMC0Dp8ikXdvTYtANTvwIa1wkMFD5i2j1yRUa6S/O02elMrxCViIYS13dePf9y2igmAZpO1XQbwKplEUn/nl5Aozvllm1sVprLgSvLJ4IzvJO4jnyNYiaS5we1qqxzyE1od543fneDrbvKR05/rvWaLP7l7olbruyE3AHFoL+f04ndAAZyQASGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WHhwatxiOmor5uVUFbpnQ3ra6yqiDjMJIItqHUnlOIM=;
 b=kDutlHYR/9Aie6CwdtL9cGvlY8poqvBHHmSHjDGC9nsQMtqPVWON7Vzvft4bMyesuAglunK1hVt2GgJ9zLlkiwIjGBSFRgKSbq+RJxvTZzSExAE1ePqAy8wvIkCtS1KOu0P5w1fLMP0GoYaw4nu5w5OWHVDAWe/0e50TWOE4C9EaoVK11P1GAABB5xHVPUWTLfPuwq4OrTqV1BGw37BotYK89Ry89mUNkq53/RUhCxrLa1bLusGNnqC4B8koXkcsLcKxhqbGVAthekFoD+BNWSQoF9kQ5o0izDwAbXowovln/liA4pDJv7ETkklPNL0sXJb0HE1vL0Cqee/X1sIHZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WHhwatxiOmor5uVUFbpnQ3ra6yqiDjMJIItqHUnlOIM=;
 b=UGmVflMyUM5A6QWTIkkaYB54kFG2InupOHvOfkGq4yV3BYG/GIjIcf+R/H507im5QrsSlzI7t9OW+n4as8oJxzJdzrllP4+WPswaikEEKF4ZmQXV+bhDj+8po6wwS/QT8cBmIlXYoJ1kPayc7eLN0m5GkOqlJz8FQHITBgSc5RE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2767.namprd12.prod.outlook.com (2603:10b6:805:75::23)
 by SN7PR12MB6816.namprd12.prod.outlook.com (2603:10b6:806:264::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Sun, 24 Mar
 2024 22:32:46 +0000
Received: from SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::3cc5:f552:44ae:1f26]) by SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::3cc5:f552:44ae:1f26%7]) with mapi id 15.20.7409.028; Sun, 24 Mar 2024
 22:32:46 +0000
Message-ID: <6553627f-6b45-4555-81d6-69d12d2c068e@amd.com>
Date: Sun, 24 Mar 2024 17:32:43 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] efi/x86: skip efi_arch_mem_reserve() in case of
 kexec.
Content-Language: en-US
To: Dave Young <dyoung@redhat.com>
Cc: tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
 rafael@kernel.org, peterz@infradead.org, adrian.hunter@intel.com,
 sathyanarayanan.kuppuswamy@linux.intel.com, elena.reshetova@intel.com,
 jun.nakajima@intel.com, rick.p.edgecombe@intel.com, thomas.lendacky@amd.com,
 seanjc@google.com, michael.roth@amd.com, kai.huang@intel.com,
 bhe@redhat.com, kexec@lists.infradead.org, linux-coco@lists.linux.dev,
 linux-kernel@vger.kernel.org, kirill.shutemov@linux.intel.com,
 bdas@redhat.com, vkuznets@redhat.com, dionnaglaze@google.com,
 anisinha@redhat.com, jroedel@suse.de, Ard Biesheuvel <ardb@kernel.org>
References: <20240227212452.3228893-1-kirill.shutemov@linux.intel.com>
 <cover.1710744412.git.ashish.kalra@amd.com>
 <7c2e6ae663da2e5eb41527f0d854f59a56b91ecd.1710744412.git.ashish.kalra@amd.com>
 <ZfkNzyGl4J1ZxaGj@darkstar.users.ipa.redhat.com>
From: "Kalra, Ashish" <ashish.kalra@amd.com>
In-Reply-To: <ZfkNzyGl4J1ZxaGj@darkstar.users.ipa.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7PR04CA0010.namprd04.prod.outlook.com
 (2603:10b6:806:f2::15) To SN6PR12MB2767.namprd12.prod.outlook.com
 (2603:10b6:805:75::23)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR12MB2767:EE_|SN7PR12MB6816:EE_
X-MS-Office365-Filtering-Correlation-Id: d2a1db50-309b-472e-1f86-08dc4c525429
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/LIF1bbWgsvWHBKU+ZmOwO6iJpsELpMBnHaxlvIsh3Z86mT9iuvdGK9EeYO6pvwOnZwg4ctTgnm425jVAAf7Cq5PT135nXCqeCtZtSG7uxGf8cpx1FhKKVJdR9N6u0z6RN4ykY0w11kuoi+Wf5rmzepYMCHj/z19Z2rNFdca4K6r1FMAQU9133nDmpW8dwdbPx1GEs5iC4zfhd1emcVpPK1V+/+OjByfc3Y5n+DrEefqvM1x55LfaamrS5OepxEDqh2maVHIJ0X4e6glzroJj1FxisoK1oJB3UtRTkhTsQMDc4SKfP+FdxSJZnDvR0oCddv4l9bRhXnurPc+s+fZ+flg6cHMpDYFvQ7daMUMXYBUCGzZYXp+Zwxky7cUrZlEPLiYuiQkWkBD3a6+kN+w3tKR+ZMhsqPzzxPz41s8+FihaCaD+Snj047VltGxvnDnCNHRr6dIYaNXyzVBamRAVnE1gCgxAb0NN5y2Uq6pHxElMfDNFATtoE8DFCwchUOZBwoU0fGoqp3f3ZkYaBNe9qItwbdOqHd3eV6Tq8xNtMbs2amdlhzhtx29Y4YiR/AJGOgWxxwf/yOOloaFNzaKVNjMTbNmj9hYwPWRZwoHvqvE8Ri054EzOANqcwGFFBB73waM3hHGsjitAqI2cCzxAhqiqdnj09irEw2kKdE9v3I=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2767.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OTgyRDkwV2M4OVJnc1FMRGRsU2ducXY3M3RZc0ZrcjEzSGdNbFdOekNSVWVJ?=
 =?utf-8?B?ZDE3VHkzUWswQTFmdlJJU0t5Uk1tQ2dWdXMyNFErUlZhTk54UktwRDJMczND?=
 =?utf-8?B?aHk1SEFzOEROd2NOZExsdEE2V3FTdUNnQlcwSlZNVGIxT3lLbytZaDh3dE1Z?=
 =?utf-8?B?QWRGRDAwSEp3V3A5Qlc5RFB4enFJekJnb0FjdlFLbU9BUUNrVk9hZU4zbTVU?=
 =?utf-8?B?WTU2djVxT0lBRlFYTkdHRlo1YnFHZkZuTlJBeXdsbEJDT3F1NWRiOWdOeTJ3?=
 =?utf-8?B?YUM1bFNVbEFuc2pnalV6eE5rbG1kVGlOQkdRMUZoTThYN0psYVVZUVY3eXR1?=
 =?utf-8?B?UzVJQ1QrbVpBOXBNSnZVVUU3VUVDMmw0UWIzMHJ2SzBmYzg0SHVyWXY4T1FF?=
 =?utf-8?B?c2o2Y3FvK0lPTy9rUW1QNDlXSXdJSGNMdmxlclpEaHFpTk96VFpJaGxrVUNr?=
 =?utf-8?B?bFNmRDgweHhvd3FWYi9DODc3NHl3Zno3R2tBVlQ2ZlNCazFWUTRZZ2lCUGRz?=
 =?utf-8?B?MGhZeFlId3JrYjc0Q1M5UmVDMkRvOXFyT25pK3NjbDBRTHpMT2JMNlBQd0Vw?=
 =?utf-8?B?RngycTMxMUYxWDBORGtLb0NXMGlxM3FBSjRtelJtTHEzRXV1b1Z5UTl6WVo4?=
 =?utf-8?B?clZjVlByWlA4M3hjOXBvOW5YSzhKTjlYOVMrQTl0a2xyTHFvdXhCRnJmTFV5?=
 =?utf-8?B?VU56bDJyR0pYc2VncTJPanRINVVvWWdWdGMvUGZGZncxT3R6VmtkRXV1RGF2?=
 =?utf-8?B?Wlp3RHdQaVlkellkOStnMnpxU1FmMjBBbWozeWM3SndkTkhYa1ozSk1VRUIy?=
 =?utf-8?B?Y09ZTU43QU9SZXFqTHBMbmI2V0hkZVNLVlYwVHpBc0k5eit6alFHREZ2U2p2?=
 =?utf-8?B?cnhPMm96VUQ0V2V5K2lqaTN1cHczYnZ1aUI1dVhIQ3A0V1A0Wm1UcTFQcDFw?=
 =?utf-8?B?bWFpTjZkTXRNL0c4T2pjRno0dEE3WkFtdHVyQUx2N0QxZHRzTnVIWHhYaXQz?=
 =?utf-8?B?RFlUbk9uTDJFazlETGxvTW9zT2xGZkNBcVVPVGJ5UjF4UC9ZZjYrWDFnbU5U?=
 =?utf-8?B?N0VkYkdWMHZxeVVYMFA2TTZkNUZTbEZIY1V2WE9DSGJHT1I5VTZjS1B0QndO?=
 =?utf-8?B?TmJaTmIyNUVFWWRsZzRsV2pRSWVyNEdCT3pFZXRtSS8yTUdXU29PeXBRdkxX?=
 =?utf-8?B?VVprdkFNSW5uY0kyNjJVYmZvVXQyWVpiYWhiQytTdjgreC95S05ITExLU3N6?=
 =?utf-8?B?Y3pGVGhXUVdyKzBRSWlQbWszOWtzeWR5WnpYaVd1L2lWUXlPNlpEN2NydE5Q?=
 =?utf-8?B?NG5FMzdmZTE2bklmMXZDTStBMlRlOXBZMXo4VXlpc1Z4VnQ0MGI2M3BoME1C?=
 =?utf-8?B?OVRENko5a01VVUJMQUhCYU1vOFhRODNJVTN6NHpOQVVJU2VnYk5QME1yYm4y?=
 =?utf-8?B?RU5Ja05iS0E4OFNoNEtkRVZJNkdTSFFqZndNVmh6czc3RG5JRnp0dllVbjQ1?=
 =?utf-8?B?aXRJdkVoZk9LLzJoVG50SFFhWDVqaDZ5MmxOc3R5bEJOU0JKWEROblVkSUI3?=
 =?utf-8?B?eEJ1TnNLZHVpcnMyNWxTK1A2M3kwT1krdklkbUhtN3VRRzlDMGFVVUVRMURV?=
 =?utf-8?B?WitHZktLWlA5UHhneTR1M0IxSFZLM0dWTWxGWTFCU2VqKy9pa3F6UkxqSGZx?=
 =?utf-8?B?Sm11RmVTWGUzNjl2K1hHQ1FpVWVnTWZqNkp4SngySFRsNlZsaERWZnFUaWtE?=
 =?utf-8?B?cG5JWXZ2ZGxCajIvbkFSblhidVJWdHQ2TDV3N0hBc3NCK2RjdWY4OTZiRHZN?=
 =?utf-8?B?aUh0RTkzYmxyL3lBZ0RRNnNJb1Vyc0tZd2Q1YVUzS2RTbTNMRFY3cUhwT1Mr?=
 =?utf-8?B?RVQvVUdDK1lZZ1NmRWhua3BJT1RtdGhQU2piTHBxUjcrYnV5dWVER1htV3di?=
 =?utf-8?B?WlQrdnErMHBkbElTbXVQcU9QdUFZVnZCM1lVZGFkSkVISEEwRDFpQldZL0Zm?=
 =?utf-8?B?bHBpVElQNzFFczVPTWNheC9aNHJPM3E0U0NXRFdsSEQ0UkVXTmNoSEM1S2ZT?=
 =?utf-8?B?RjMwWmd2cDV4N1FPRXlpcFRrNTZDTEdjNVZQeTBlVkszR0Fic0lrSUZuV1NL?=
 =?utf-8?Q?66RxJZuAR4tHF+m+g99x9Gl+s?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2a1db50-309b-472e-1f86-08dc4c525429
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2767.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2024 22:32:46.4076
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TPCgzRKGoDUrDgZWaLR21MNYDrfVgjvMJFBNSf4nzD2e4WpLYeEI6LSNQRpjonZk0XmQoDxV1kO8epkU+MdUOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6816

Hello,

On 3/18/2024 11:00 PM, Dave Young wrote:
> Hi,
>
> Added Ard in cc.
>
> On 03/18/24 at 07:02am, Ashish Kalra wrote:
>> From: Ashish Kalra <ashish.kalra@amd.com>
>>
>> For kexec use case, need to use and stick to the EFI memmap passed
>> from the first kernel via boot-params/setup data, hence,
>> skip efi_arch_mem_reserve() during kexec.
>>
>> Additionally during SNP guest kexec testing discovered that EFI memmap
>> is corrupted during chained kexec. kexec_enter_virtual_mode() during
>> late init will remap the efi_memmap physical pages allocated in
>> efi_arch_mem_reserve() via memboot & then subsequently cause random
>> EFI memmap corruption once memblock is freed/teared-down.
>>
>> Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
>> ---
>>   arch/x86/platform/efi/quirks.c | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
>> diff --git a/arch/x86/platform/efi/quirks.c b/arch/x86/platform/efi/quirks.c
>> index f0cc00032751..d4562d074371 100644
>> --- a/arch/x86/platform/efi/quirks.c
>> +++ b/arch/x86/platform/efi/quirks.c
>> @@ -258,6 +258,16 @@ void __init efi_arch_mem_reserve(phys_addr_t addr, u64 size)
>>   	int num_entries;
>>   	void *new;
>>   
>> +	/*
>> +	 * For kexec use case, we need to use the EFI memmap passed from the first
>> +	 * kernel via setup data, so we need to skip this.
>> +	 * Additionally kexec_enter_virtual_mode() during late init will remap
>> +	 * the efi_memmap physical pages allocated here via memboot & then
>> +	 * subsequently cause random EFI memmap corruption once memblock is freed.
> Can you elaborate a bit about the corruption, is it reproducible without
> SNP?

This is only reproducible on SNP.

This is the call-stack for the above function:

[    0.313377]  efi_arch_mem_reserve+0x64/0x220^M
[    0.314060]  ? memblock_add_range+0x2a0/0x2e0^M
[    0.314763]  efi_mem_reserve+0x36/0x60^M
[    0.315360]  efi_bgrt_init+0x17d/0x1a0^M
[    0.315959]  ? __pfx_acpi_parse_bgrt+0x10/0x10^M
[    0.316711]  acpi_parse_bgrt+0x12/0x20^M
[    0.317310]  acpi_table_parse+0x77/0xd0^M
[    0.317922]  acpi_boot_init+0x362/0x630^M
[    0.318535]  setup_arch+0xa4e/0xf90^M
[    0.319091]  start_kernel+0x68/0xa70^M
[    0.319664]  x86_64_start_reservations+0x1c/0x30^M
[    0.320431]  x86_64_start_kernel+0xbf/0x110^M
[    0.321099]  secondary_startup_64_no_verify+0x179/0x17b^M

This function efi_arch_mem_reserve() calls efi_memmap_alloc() which in 
turn calls __efi_memmap_alloc_early()  which does memblock_phys_alloc(), 
and later does efi_memmap_install() which does early_memremap() of the 
EFI memmap into this memblock allocated physical memory. So now EFI 
memmap gets re-mapped into the memblock allocated memory.

Later kexec_enter_virtual_mode() calls efi_memmap_init_late() which 
memremap()'s the EFI memmap into the above memblock allocated physical 
range.

Obviously, when memblocks are later freed during late init, this 
memblock allocated physical range will get freed and re-allocated which 
will eventually overwrite and corrupt the EFI memmap leading to 
subsequent kexec boot crash.

>> +	 */
>> +	if (efi_setup)
>> +		return;
>> +
> How about checking the md attribute instead of checking the efi_setup,
> personally I feel it a bit better, something like below:

I based the above on the following code checking for kexec boot:

void __init efi_enter_virtual_mode(void)
{
        ...

         if (efi_setup)
                 kexec_enter_virtual_mode();
         else
                 __efi_enter_virtual_mode();

But, i have tested with the code (you shared below) about checking the 
md attribute and it works, so i can resend my v2 patch based on this.

Thanks, Ashish

>
> diff --git a/arch/x86/platform/efi/quirks.c b/arch/x86/platform/efi/quirks.c
> index f0cc00032751..699332b075bb 100644
> --- a/arch/x86/platform/efi/quirks.c
> +++ b/arch/x86/platform/efi/quirks.c
> @@ -255,15 +255,24 @@ void __init efi_arch_mem_reserve(phys_addr_t addr, u64 size)
>   	struct efi_memory_map_data data = { 0 };
>   	struct efi_mem_range mr;
>   	efi_memory_desc_t md;
> -	int num_entries;
> +	int num_entries, ret;
>   	void *new;
>   
> -	if (efi_mem_desc_lookup(addr, &md) ||
> -	    md.type != EFI_BOOT_SERVICES_DATA) {
> +	ret = efi_mem_desc_lookup(addr, &md);
> +	if (ret) {
>   		pr_err("Failed to lookup EFI memory descriptor for %pa\n", &addr);
>   		return;
>   	}
>   
> +	if (md.type != EFI_BOOT_SERVICES_DATA) {
> +		pr_err("Skil reserving non EFI Boot Service Data memory for %pa\n", &addr);
> +		return;
> +	}
> +
> +	/* Kexec copied the efi memmap from the 1st kernel, thus skip the case. */
> +	if (md.attribute & EFI_MEMORY_RUNTIME)
> +		return;
> +
>   	if (addr + size > md.phys_addr + (md.num_pages << EFI_PAGE_SHIFT)) {
>   		pr_err("Region spans EFI memory descriptors, %pa\n", &addr);
>   		return;
>
>

