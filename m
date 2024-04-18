Return-Path: <linux-kernel+bounces-150198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D758A9B91
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 15:47:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 997A11C233D2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 13:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43D83161306;
	Thu, 18 Apr 2024 13:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UDGOAmFJ"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2043.outbound.protection.outlook.com [40.107.243.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34B815AAB7
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 13:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713448065; cv=fail; b=k6yUesLNGbk9z88gsN/utZdXneIoysAjZvBB7QrCjKfjY1L5EVn7qYxWw8vhqE8WcmeQAr41GhoUVkvR5SuEEKNJPkbr8S81iR/inb3pOIHgyGiVRklEN5mVWHUoDXNh5YBj407lHd28RiE5E6bwhn2F+aPn/73FndsEeg+tsdI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713448065; c=relaxed/simple;
	bh=kMsHmM78VqCga1h4pPpwkEJ8gtBXXs6AW1HPp/YqdWE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Akpp+rBA/Df/fnEROc3cRKATlBNxSFY3DC+5+r83Vtw7O2sp+gvU6ii1zMSTb8tuAr4Q0MdJGLDpqkAD4d8ilFnPMrdnoUmVFmncfDFdvoNf+atXOclsrDqJEB/Xrzx1dKYHFjkXlyG4hgaM8QG31HxXjYDcvS4e4gkuMARYBaY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UDGOAmFJ; arc=fail smtp.client-ip=40.107.243.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SwAF2rheVkJuA8QQpTGgZ/hShE9IpcTRrqQHC0ctXanI07Kr7Q7bhOYmPQOMMNZ6cj8jmiUZRXfq04mu8EXnqe3D75ieZfl3Prkf8uhNN/a0WgJgp2WziPGLzfxh6FkTdgP6OZWwtSUDwrUmVq3K9WaHfc5Vob0IdxxcHo93sllAHlDdu/lf1JWSE1bgQmEewNJvF8Kf7+O4wnM4icyUCW7eXW4bFUUGtrMy0EJoc05d0DpQykKu38QRjZyDGEpc48siOwcFiXY+kE7sUc2gs1N/MTbb4Uf6tmhhGMfMuhIItvU6ieNzieGjqjMtXwYWBu7uN/31JpnVRZuLVZUVUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jFb5W6CTWP5PsdByfjw9iRZ3yrnwZHn0uwPgi+Mrq7E=;
 b=ifKCM1TAHqN7RfAiGOHFLf3oLZFL55sKaal8utiXc7QaKw13vmhH5T7Vd45d/BuPgVKDC4IvY3JBjUugCFq2pV1v9lfO0BTU6F0Woo5AciCI/Qqq0GyrkI25O/ii8Sxbr6Osu44DxNCpdBe8blDhPSxmSlq5Oj6H0MwIo74mXjm8Voxpj3+WhIvkT/KS+rYQTaXQnpKiTla64apBpwf4AYP7lADuBTV9liUYPS5aY4QPzwt6rTFie4hsarUrtnrE9z2/LP1Moulnznpz6suiV0IkYXVpZMjsRoKXuTnTlZCgoStTiBUqtb9cr0/bm5D+prqJPG5r6/Ii6DGv4Qh4SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jFb5W6CTWP5PsdByfjw9iRZ3yrnwZHn0uwPgi+Mrq7E=;
 b=UDGOAmFJVM7+StIrr3o1S8v+LKWHKDv2YBsKtPfzMMt7EuVo0DGRL//2AwWHh7NfymVgo2Ul4nP8pASwHkKDFga7tG4TSGKRN3TyhqtFtSvGWji8w92jlvEiHemKM3lShYU9InSfsJkRxMwPPxJyy9XHFree68sBR189isC58pY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17)
 by IA1PR12MB8407.namprd12.prod.outlook.com (2603:10b6:208:3d9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.37; Thu, 18 Apr
 2024 13:47:38 +0000
Received: from BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::bf0:d462:345b:dc52]) by BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::bf0:d462:345b:dc52%6]) with mapi id 15.20.7452.049; Thu, 18 Apr 2024
 13:47:38 +0000
Message-ID: <cd6bfe66-a49b-1af3-f329-ac7985a39be6@amd.com>
Date: Thu, 18 Apr 2024 08:47:34 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v4 1/5] x86/kexec: do unconditional WBINVD for bare-metal
 in stop_this_cpu()
Content-Language: en-US
To: Kai Huang <kai.huang@intel.com>, linux-kernel@vger.kernel.org
Cc: x86@kernel.org, dave.hansen@intel.com, bp@alien8.de,
 kirill.shutemov@linux.intel.com, tglx@linutronix.de, mingo@redhat.com,
 hpa@zytor.com, luto@kernel.org, peterz@infradead.org,
 rick.p.edgecombe@intel.com, ashish.kalra@amd.com, chao.gao@intel.com,
 bhe@redhat.com, nik.borisov@suse.com, pbonzini@redhat.com, seanjc@google.com
References: <cover.1713439632.git.kai.huang@intel.com>
 <327899e13c4dbbfbe8ca95cab83ba229d17fb74b.1713439632.git.kai.huang@intel.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <327899e13c4dbbfbe8ca95cab83ba229d17fb74b.1713439632.git.kai.huang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS0PR17CA0003.namprd17.prod.outlook.com
 (2603:10b6:8:191::17) To BL1PR12MB5732.namprd12.prod.outlook.com
 (2603:10b6:208:387::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5732:EE_|IA1PR12MB8407:EE_
X-MS-Office365-Filtering-Correlation-Id: 889b347a-3ab9-4526-3c88-08dc5fae1c67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4bO7h4YK9IdkpLD8IXW42qBtrQOnuLpDHfYQRkBzHcxCDff9npiDBzfO5ZHxjsnLoW4vfZnHZlHCu7wP1zYbI1Ca2i7pT80/Ga4d/I+DFdCQksfV1zcdO5E3J5O61yajV+V6Afp4sEI3oiEihPmJGRdU5X7jQtiPsAIjoxrvB7iRQ+JL+223bc/NhEesDitk2jdHEnbKZ4JlkzZB1uVtdTQVE2KGBHE7DQ78OvtfSEA27Vpo3nf/VvjXy4pzGlLekbLeYY8C1JCA7zGHAmnZSIoSwyvOc0U+DMBo6Z/B4Vmg7XxHUcPWpdiDspPkvFpyZnfD78Zo8oMwuFpPXVfQJz7SyPSj4EdA5oUwybEyWXH6q4Xz+w2uwjtML5yC6zH1c/9F6KA4ZjKwmm1AE+MFnqpregEM924gOJ8MtEcKunmPjCgRiUcz7xTPi0E8v/qNXzJ8FwpmgDjBAcVhhAUcIn/HJFFrml9qdlawCnqBqf6Q4mvl1BI+X6AButGQ4j02dXTHRXLkuxgJc9srfMn4Hb6a6LJFTAA3Svv7+d8jUnnr7vX/NTRD1EOmj6OHOpnZ3ij4Y4ggd80kxehUxfKoqoCaXSwDR97WrwIyA0wBGn9OtyeGd47gWZOjh7TOoB+zJcJyU96FFSJK/HbUptsZpej/u0UjdgIouVJKq4yCt48=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5732.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QWQ1NWl6aitGWHpTNnVJbWVGY2hrT1M3TG9WckdvOE5SOWVjWklRNERRcWhS?=
 =?utf-8?B?Vzd5K0Z4NGh6UkRXTUN2TFI5MldQUTM5WnFlL294VEZqR3VJREF5M0FndEdY?=
 =?utf-8?B?Nmd5eXZMQktlRjg3a0pIbkVhaFd2WWRzYng5NDlXMnlnV1hmUW9CVkJ4dVpX?=
 =?utf-8?B?TUM1UVlGQUxUMVVYRy94eTlPL2k2ME1ackp3OFZxNlRQb0VXcTB0QWI2WDBK?=
 =?utf-8?B?UHVLaFFXM1RRZStWam9FZWExaWpObUJJT00vZFlaalRxVGI2S0tFVEJnRGx1?=
 =?utf-8?B?QVlDNXIrakE5NFdmUXdFV1lETUpPODMvd1RuZEhXWG5mdDl2ZXB0TFBhQTBK?=
 =?utf-8?B?VmVVWUtOWS85NXJVUWRCZnZMeWZKUEphRTRwdk9sZTNzVEVYM3UzaW5TRHZV?=
 =?utf-8?B?QjE4MWhSMjdTeTFTZWdjK3pSeFEvbFZFeVZ2SlppK0V6a3hTamNZQ3A1aitZ?=
 =?utf-8?B?WE9iN1BuTDlXazhQRmtCWDRLQmRwL3NCWHhCc09PU3FLTk9IRE8zR0RmcHBt?=
 =?utf-8?B?VU1oVnllYVZJWE92cW5UTk5XRk1ReW1ydlZxRWZqQ1NIaVpuZGtXM3U4eTJI?=
 =?utf-8?B?VWJIU0RoWFo2Ymk1WllXam9PSnJaWkRySXZ1V2VUSit1WjVsMWx4a0hXSG40?=
 =?utf-8?B?UE5KTFMyTHNCUGRNYnRneVNLRllZazFCdnIvWW5DRVJWV1p1MVlMaWIvVGJI?=
 =?utf-8?B?Mm44T3pGUUQ3a25BOEtqL1JqbktkdjZjYzlaSXlGRXN5U1VrdEo5NG9WTGoz?=
 =?utf-8?B?OU82dkF0NnVhTTRzOUlndElTQ2pKclhuSmlFb2pSQ2pEK1ZNNWxaNjhNZHhU?=
 =?utf-8?B?SlR0UFdOT1lkbVF3MzQyMnNTcHZwbEM2NW02cTdsK051emF5TFhQN0NXMmYv?=
 =?utf-8?B?OUc3eWQwaUJCbmZzRVR6c2xqckE2enpFd3c5TzhpeHVLUXo5MFc3Wlc2ZmpB?=
 =?utf-8?B?Y3JoT3N6TGlZTzIyRHlhUzFrSGVUaUxTTEszM0JDVUc1YStFV1RsVC9LNEhG?=
 =?utf-8?B?VDN6R0c4QTduYVA4QzBJOGdtZ0s3UW15dTRLTTBNeFUwYk5KSU01QmsrNkVv?=
 =?utf-8?B?Qmc3My94NlFlRDM2aVRwU2x6ZHJTZ1UxL1MyR0xkaU1SOWVja1Y4TzU1ais1?=
 =?utf-8?B?SmVYbzUzODlaK0hhQVFmNTYyd29PbHlkRTJmMngxUWM4bmNhRCtmR1FrOEUr?=
 =?utf-8?B?TXhDTHRNOGxFbXZtVUg1bEJBakJCNy9yMlZ6UVJkN0xxZHU0MWpjdXpLN1ZG?=
 =?utf-8?B?d2FkODV5OTIrRUExUWVEVGpneXZGNlh1WVBaT2FUakQvYzd2OHUzRmlmRmJH?=
 =?utf-8?B?SDFTWlBoQXVMSy84RGJtME9rNU1ycmtGUTZTaW84ejBSVlkxVERxTUszWUli?=
 =?utf-8?B?bU52MDVROVdVTWhYbXY5SmZwamVLb2VkclJrMGFyU29lNk0yaU9lTHEzbjA3?=
 =?utf-8?B?OW9sUVphZS9laHZIL0Q0L3NsS0dtK2FxVlpMQ3ZVL0R1UmtsZzlxSm9Ycy8r?=
 =?utf-8?B?UlpuNTYxWGR0YUZKZTBwTDVpT1djLzhvb2hWK0xuQld6L0l0SHJteDllYTRm?=
 =?utf-8?B?Vi8xZ3ZtbldDUXpaWVhUVmQxeWV1djhMUjkyd0tMWTFaM1cwc3dFUzJuTllX?=
 =?utf-8?B?TzJQMzJsV3hjWEh6eW8zNXVRbnVGeG80cG12TStHVlFVU2d4Tkg2UzVyOWxY?=
 =?utf-8?B?bVFGcklVdnhuUlZrQTF1NnZENXZQZ3g4aFJORE8wdzcyRUJkaC8xYnZ0SHRr?=
 =?utf-8?B?SVRXQTVaRHp5bHl1dFRMajkwM0VubVk3dWk2RFk1R0RwMENyOHdaaUlGVjMx?=
 =?utf-8?B?SnBsdERmSmRQbDV3ZnhQNWVicU5FbWl2UlJvYkpBOCtzandicU1ET2ZQUktM?=
 =?utf-8?B?aDgvRk43dTZUSjgrcUhGK3haV0U0OWU2Q2E1SDNPNkxnY1ZEaDBtWUtYNWYv?=
 =?utf-8?B?dThXQUc1U3VxanRCdWR5QmMvSnpad01mdFJycXNJWXk0WS9xanlqOGtObjZW?=
 =?utf-8?B?V1VKQXdBN0JVTkFua1R1S0E4TWRkZGI0K2FKMXRqOVVTanFUZllvaU5LZmlJ?=
 =?utf-8?B?c0tISDdIcUpIMzJFNzRPTytIVWVGcUJ6dlBKZnRSMytwMmxkM3U0ZWNUSkY0?=
 =?utf-8?Q?vIWCFiBrv8bCJcArv7wvggXgq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 889b347a-3ab9-4526-3c88-08dc5fae1c67
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 13:47:38.6311
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HqcRXIQCI0DXKvSYi0y8XSf633CkMqzgGHnEsH5KhRQTfSE3pMCXr40K7FdpVpD1Ki/hHI8knlwnI22VtUXt/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8407

On 4/18/24 06:48, Kai Huang wrote:
> 

..

> Signed-off-by: Kai Huang <kai.huang@intel.com>
> Suggested-by: Borislav Petkov <bp@alien8.de>
> Cc: Tom Lendacky <thomas.lendacky@amd.com>
> Cc: Dave Young <dyoung@redhat.com>

Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>

> ---
> 
> v3 -> v4:
>   - Update part of changelog based on Kirill's version (with minor tweak).
>   - Use "exception (#VE or #VC)" for TDX and SEV-ES/SEV-SNP in changelog
>     and comments.  (Kirill, Tom)
>   - Point out "WBINVD is not necessary for TDX and SEV-ES/SEV-SNP guests"
>     in the comment.  (Tom)
> 
> v2 -> v3:
>   - Change to only do WBINVD for bare metal
> 
> ---
>   arch/x86/kernel/process.c | 19 +++++++++----------
>   1 file changed, 9 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
> index b8441147eb5e..d3c904bfe874 100644
> --- a/arch/x86/kernel/process.c
> +++ b/arch/x86/kernel/process.c
> @@ -813,18 +813,17 @@ void __noreturn stop_this_cpu(void *dummy)
>   	mcheck_cpu_clear(c);
>   
>   	/*
> -	 * Use wbinvd on processors that support SME. This provides support
> -	 * for performing a successful kexec when going from SME inactive
> -	 * to SME active (or vice-versa). The cache must be cleared so that
> -	 * if there are entries with the same physical address, both with and
> -	 * without the encryption bit, they don't race each other when flushed
> -	 * and potentially end up with the wrong entry being committed to
> -	 * memory.
> +	 * The kernel could leave caches in incoherent state on SME/TDX
> +	 * capable platforms.  Flush cache to avoid silent memory
> +	 * corruption for these platforms.
>   	 *
> -	 * Test the CPUID bit directly because the machine might've cleared
> -	 * X86_FEATURE_SME due to cmdline options.
> +	 * stop_this_cpu() isn't a fast path, just do WBINVD for bare-metal
> +	 * to cover both SME and TDX.  It isn't necessary to perform WBINVD
> +	 * in a guest and performing one could result in an exception (#VE
> +	 * or #VC) for a TDX or SEV-ES/SEV-SNP guest that the guest may
> +	 * not be able to handle (e.g., TDX guest panics if it sees #VE).
>   	 */
> -	if (c->extended_cpuid_level >= 0x8000001f && (cpuid_eax(0x8000001f) & BIT(0)))
> +	if (!boot_cpu_has(X86_FEATURE_HYPERVISOR))
>   		native_wbinvd();
>   
>   	/*

