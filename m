Return-Path: <linux-kernel+bounces-94617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9765874233
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 22:52:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FA85284069
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 21:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1F501B81F;
	Wed,  6 Mar 2024 21:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MFRaY28A"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2068.outbound.protection.outlook.com [40.107.96.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F8E2FB2;
	Wed,  6 Mar 2024 21:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709761961; cv=fail; b=rziGkDo4MltI0tpR6hGTtSqoPdmqRI3/xTwI5rcZ49UTSt2tfBiTSp8yK9yqz6RFU2SMxzzHMjPifKI43lwNCHesKfph6jG1umJk1KfgRl8a8FSZpTB3fxGxG3K4YAEeCm4YoLILbG+r5kTFtUL/IfvrDlm96hphl5NLwbC4Cus=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709761961; c=relaxed/simple;
	bh=VVpPrm5cYjenRfzzVlWVv6AiGyZtw37eJl10QJMvLQo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=l/jhd58iwledwThHGfEE3hxfSq3JzSrnFmKWR7Kggz+w9kXBVE/gQCCeZpm8/Tt+sAydBiYqgJbVVjYd88k6kW2hSZL7Sr+4FiAW8tEslB7DaHuy/89G5oQKgtTmi1rsdRqYgNWGWmByR06e5/qw6/ziF/0RVGf/jGO611RRd+Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MFRaY28A; arc=fail smtp.client-ip=40.107.96.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cSH4bUFb1aa79g7cLO6kv8EqfYKNemGINGsbElIX69KBq2SF8J08zUn/Dx3C/5djAQdoTf5AwFS1/KcXjQOKDr09xxJ64r681YgvDgaDxE6At/myjyA/0xWZlTh+u7PsDMG4NDzdJrwKy1pE2DVSKmuS0oyr9YBbmGBGVscnFTzS99RLTu2/fHrJxaxCWPrsO9v3MgvszUsN98t+xMwQL8Z3g99kG3rf9B+S8vLw0NLI2gsW77stmTCAgUdPBXYner6Y9dHLQ9VsEQxV41TZv4eokghmOqzzzo4J6G6y5FMR4j5kXDzJC02AYVbAHsjxgWGz4tyfvzEp/uOgFDsy5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y913MFGe8mgk78aQtNczxuflZaNMskiF5iwXGT2TT9s=;
 b=LgQ8/BAFUaOhL22DAcyxsrfPF8myjaNDNvZh3NodwKK8Khllth4ntwskJBvxK+FQXGFCoKJFXreJtPcLxojXUG/pMaR5cB6jjj/l+biU3txZ7rTympJg42wQQG/kpMUiVaCTcLdvr5RgbRbXI3mJna8fHtStr/pCXLzKowccfDsMM2fL8K+wMb1MsKRi11Tlpx/Uau+EnPGH+aYMescbvbCqMYpg6VQ/3n1DXfHQaFJAGNJEs9HR1fcfoVQC2tHVw6M7EGbXQ8IP1BTfiL6c7Fp1OzfYNElQgGdB7KLcOFOK52JGbBjbcUiDPU12KFxXdgcy4T64bmJF+EGxwEOIrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y913MFGe8mgk78aQtNczxuflZaNMskiF5iwXGT2TT9s=;
 b=MFRaY28AXrlBR8ltjQBE7BL11f/hZyEguqwwg9YCLx8bCSw/NDMi54ooYZvtROIgrXDi0VIm/Y0FfqrLJFlmDjUGU7zVWYeUZpL3aK40fRDpJBUAlVc5xiOF3a98O6gswa6bHHuzrcP2dkcnV2x8Fz4CDvXgiJGuOFJ+kMwx9N8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB8403.namprd12.prod.outlook.com (2603:10b6:610:133::14)
 by CY5PR12MB9054.namprd12.prod.outlook.com (2603:10b6:930:36::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Wed, 6 Mar
 2024 21:52:37 +0000
Received: from CH3PR12MB8403.namprd12.prod.outlook.com
 ([fe80::aaa1:af99:e0e5:7f14]) by CH3PR12MB8403.namprd12.prod.outlook.com
 ([fe80::aaa1:af99:e0e5:7f14%5]) with mapi id 15.20.7362.019; Wed, 6 Mar 2024
 21:52:37 +0000
Message-ID: <e6675835-46ca-4183-86ce-008fde928e73@amd.com>
Date: Wed, 6 Mar 2024 15:52:34 -0600
User-Agent: Mozilla Thunderbird
Subject: [PATCH] x86/mce: Dynamically size space for machine check records
Content-Language: en-US
To: Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>
Cc: "Mehta, Sohil" <sohil.mehta@intel.com>, "x86@kernel.org"
 <x86@kernel.org>, "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "yazen.ghannam@amd.com" <yazen.ghannam@amd.com>,
 Avadhut Naik <avadhut.naik@amd.com>
References: <20240212093246.GBZcnlvkPKDC8C7rv5@fat_crate.local>
 <SJ1PR11MB6083B3511D18787BE823AB2CFC482@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20240212175408.GIZcpbQHVjEtwRKLS-@fat_crate.local>
 <SJ1PR11MB60830AF35FA89C7869B8C11EFC482@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20240212191401.GLZcpt-XHFqPg3cDw-@fat_crate.local>
 <SJ1PR11MB6083C60D7584B02E9CAF19D5FC482@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <ZcqPhVO_DtD2x5N7@agluck-desk3>
 <20240212220833.GQZcqW4WxKH34i-oBR@fat_crate.local>
 <20240212221913.GRZcqZYRd6EPTTnN97@fat_crate.local>
 <20240212224220.GSZcqezMhPojxvIcvO@fat_crate.local>
 <Zd--PJp-NbXGrb39@agluck-desk3>
From: "Naik, Avadhut" <avadnaik@amd.com>
In-Reply-To: <Zd--PJp-NbXGrb39@agluck-desk3>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0628.namprd03.prod.outlook.com
 (2603:10b6:408:106::33) To CH3PR12MB8403.namprd12.prod.outlook.com
 (2603:10b6:610:133::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8403:EE_|CY5PR12MB9054:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a8b758e-b770-4ded-846a-08dc3e27bcc0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0MI9w8AoHSo9YPYDlfYKkFMX/BU16RXTyrnAnqw45ANh2tr+63F9Akqjl31w4lfpRDpzlyFt+B5ftgpHIf6YWXAP0wjoWCG0YWQhhDg9RH7Hrz6WPIOX+h3rPsSrAQFNtZK3JpHaaZGvBFWNEvegDZiDkHCOt7+TkbmS7ALNFKz7xA48oXv2B+bDMMQVzn1k7qeatyAM6aHDyr6dnwm2g2o3oofDMmPDimsxGRShMvs+5zXs6ODOpQ2k5b07e+Oo9xcpitQjOcD/D3If6IQCKNd2uqF4KtU69FR1WJiiyDlzi4xqgU9S4+Wxd6HpBtT6Er1dsT6HHXnOlw0Azyzx9IH7xYIQyfJtDv2LA+n81aSxSkOm54RrATefpiiqUASugI8r/RD8WctceMQt4TFX/QHzqZdm3tvH8cpjKalKRNHQfDYWzc17v92o99NmFVtQ0mxtoiS8D1jLy2wXemP2V1SQDvsP8E5/M5CtGzdccivz1EGyJY33d5/ureQscG5yWqro0cRg7Ll03R88AB+9AoNcbYPq0grVSaBq76fBiptmWMrwBNOFKp5mc3kLuo4YVhU9hXHQGPxU1tRn/eYHnW7BVxjtFnBmQVpZYsDRR7b1E1/4+yZK8RX5fbtnBUsMFGf1tlwzwnha131105iQxDdZ5O+L2OCXxUGtqui/epY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8403.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dEgvcXo4a0tvMFdwTlVMOEQ5dElkbTNtb0JKV1FDSTFFejhyZElzNG05RHU0?=
 =?utf-8?B?ejVvczlNMy9jSklnS2hNZEx4YmpQOXpPdXNISy9nLzdIcmwvcTl1eGdSWnFv?=
 =?utf-8?B?RksxMVoxT1dySjB6L2tGQUUveStic2pjS0V0cTZRNTNOMlFWRkxIQ3I0eXJ6?=
 =?utf-8?B?WThvZWtQVHZwL0RNTGsyMWREQ0xwYzVOZGpnOXpPTW8rT05WWk4zM2dkQzNi?=
 =?utf-8?B?ZWN3ZHlnTmVxWXZnM1hRTDAzczl0VmRSdERGcFNwd0d6WVVXMDNhMXVZdDJF?=
 =?utf-8?B?MDBMRkpZUFRtdkFyYWZXVDRNa0kyNXJzQTRIMnNkMFJGdHBGdVhUV3k5Y0N0?=
 =?utf-8?B?UDBCb3ZLQStCVUJ6SUcyZlowSE9ER0dVYTlkVEQwMm1MZ0NSOWpVNlllbVpZ?=
 =?utf-8?B?eGVFTTJYdEhHVjNveW9Zdi9NVnRDalBJTEw3K2JGdEFYQjBMa09kUHpucDZo?=
 =?utf-8?B?Z2t0WjBOV2Z2YTlJOWtwb3kwMy9uQjJoT2dobGdqcGtzY0NCaWhWVTNtejFT?=
 =?utf-8?B?WG9nekJHZUlUL1VGMFZHWXF3ZlNobG83SUVKMzlSWWtrWUUwekMxVlNxUStD?=
 =?utf-8?B?amNBVDRsVUJ3MWdiS1hMSUZ4YjYzazV4Sjl2RjAvdC9pOWt0NHVOR2ZldTRw?=
 =?utf-8?B?UE8xOUJrT1dQejVDdVVXSkZGWjk1VnZVMm5DaG1OcXZQQzhFYWcvZmZ4VmtZ?=
 =?utf-8?B?cU1hNXVJRDE5dHc4UCtabnpmZ2IrUGpQUFpXbjAvclhhSXFlZXFFVFdWTjhV?=
 =?utf-8?B?VEpsN09xdkpUUDNPN0E2UzMvNlZRWTlFYXFpS2hudjhDVklsTWhidzZVaW9a?=
 =?utf-8?B?Y1owdGpab25BZ1k0Nno2U0FqSHFoK1JJMEptT3lwbTZtZHRNUzQwTzRyOGxw?=
 =?utf-8?B?MnV6QXpIQWptcDByZXJETUxVYmRLSTRxanljcEFOMU5ndnZ1YXEzZ2tjRlFQ?=
 =?utf-8?B?M3ltcVplMU5qU3g2dFAwVGQzSXFkVTJGOFFuWGU1WTBMV01EbWhaTEM5VkFq?=
 =?utf-8?B?N2V5TVd0Nm1GYjVMVkh3UzhsSVZiU25pOGtONXNpQjlhb3RMcXRwSXZROEg1?=
 =?utf-8?B?a05PY2RWbVFjdHJlMkExeG9mdE5obThSSDdFNkZRMUt1L1U1RlNDVnBkSVFB?=
 =?utf-8?B?L1lyR21WTk9waFpyMDhFZm04NWJMVG92TEpUakhsMHVzblptUTVjNzI5dnRS?=
 =?utf-8?B?dnFtSmVDSmgvN1J6bVVzVFA0cDF1NjJpQmhtdjBLM2dPUHNxQWNpTEl5R3kw?=
 =?utf-8?B?MTBuQi9mODdRaUNSdFJsOGRsK01yR1BFSnV5TXpnTUZPbE10cE90Nkw5OGpl?=
 =?utf-8?B?VitQNGxlUzZTaUIzZXV4U0pscExzN2thaUJVd0Z2ZW1sNzIvbzAwMjFGN2tB?=
 =?utf-8?B?RlhKdFlhMjVxVmN6YzNRRUdzRWZwODNYMzdUeVVRcjUyYU9hdG5IOXFGTFNq?=
 =?utf-8?B?czdiZXEvNnIwSU92OGNIQXpSMXZGV0wrcTU0OXhlL1lmMHZNbHhnMUw0R29a?=
 =?utf-8?B?ZjZVVkpxVmtFNEVxbytiUFpSYW04WUpYa2FGSmxXNUIxbHBZakJKUnlkZis1?=
 =?utf-8?B?M2gzMjZhclM3Qk9ERDYya2dmcGFNL2RlRXlSSHBZY2h3aFQ1dzZ1TDhJbktW?=
 =?utf-8?B?THF3aXdSLzd5OWlIWmZaVWNGLy9iSWNDcnUxcGZLMlFva21WVHlEc1BSSDZp?=
 =?utf-8?B?b2FjRDdiVm81ODJPVTFRWEJvMDJoTDJweHUrbktBRGVmUUxOV2hZa25wMldl?=
 =?utf-8?B?ZmJsNGdtZ0pYbFZGekNuWFMwazRJaFN4bWJQbVE2ZGFzUi9aNWo5Z1pINHRU?=
 =?utf-8?B?Q3BFdkpwWDIySWlFVlN3bTRobmRFaUo4bm5aOFlWWlgzaXhtRGM0cUI4Vy9l?=
 =?utf-8?B?N1JqM0FpNk1WaTdPNWpMYWUzK2JxNjE0Zi8xWlJENkVTQW00Z3JDcmwwOW1U?=
 =?utf-8?B?Y1BwY0N6dDR3NlhrUTMwaDZ5QlF5YVN2NjhHcnhMUEpZdTFzTUdnaHAvRnJ3?=
 =?utf-8?B?MHI3Y2pKRnZ4ajBxcjhYTzB3MmRwTW5JWXQwd0R3S3YraTgvYjJwS1dMRjJw?=
 =?utf-8?B?amQ1R1c0VU4xczBQc1h4MEpJT01GSFd5M0hza1F2eDJ4NTNic1Z5N1BGdzJH?=
 =?utf-8?Q?gNrPRjitOJBdMmpNyEdMO2Jvy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a8b758e-b770-4ded-846a-08dc3e27bcc0
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8403.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2024 21:52:37.3483
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yV+T7GVUxnfidf6tK9dRLJ1IZoHIbgLuRs/9/KPJ9DUVLzgfSTvzMbzpZbBXTIYvLBaKidEnL41vT7kev6icig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB9054

Hi,

On 2/28/2024 17:14, Tony Luck wrote:
> Systems with a large number of CPUs may generate a large
> number of machine check records when things go seriously
> wrong. But Linux has a fixed buffer that can only capture
> a few dozen errors.
> 
> Allocate space based on the number of CPUs (with a minimum
> value based on the historical fixed buffer that could store
> 80 records).
> 
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> ---
> 
> Discussion earlier concluded with the realization that it is
> safe to dynamically allocate the mce_evt_pool at boot time.
> So here's a patch to do that. Scaling algorithm here is a
> simple linear "4 records per possible CPU" with a minimum
> of 80 to match the legacy behavior. I'm open to other
> suggestions.
> 
> Note that I threw in a "+1" to the return from ilog2() when
> calling gen_pool_create(). From reading code, and running
> some tests, it appears that the min_alloc_order argument
> needs to be large enough to allocate one of the mce_evt_llist
> structures.
> 
> Some other gen_pool users in Linux may also need this "+1".
> 
>  arch/x86/kernel/cpu/mce/genpool.c | 22 ++++++++++++++++------
>  1 file changed, 16 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/mce/genpool.c b/arch/x86/kernel/cpu/mce/genpool.c
> index fbe8b61c3413..a1f0a8f29cf5 100644
> --- a/arch/x86/kernel/cpu/mce/genpool.c
> +++ b/arch/x86/kernel/cpu/mce/genpool.c
> @@ -16,14 +16,13 @@
>   * used to save error information organized in a lock-less list.
>   *
>   * This memory pool is only to be used to save MCE records in MCE context.
> - * MCE events are rare, so a fixed size memory pool should be enough. Use
> - * 2 pages to save MCE events for now (~80 MCE records at most).
> + * MCE events are rare, so a fixed size memory pool should be enough.
> + * Allocate on a sliding scale based on number of CPUs.
>   */
> -#define MCE_POOLSZ	(2 * PAGE_SIZE)
> +#define MCE_MIN_ENTRIES	80
>  
>  static struct gen_pool *mce_evt_pool;
>  static LLIST_HEAD(mce_event_llist);
> -static char gen_pool_buf[MCE_POOLSZ];
>  
>  /*
>   * Compare the record "t" with each of the records on list "l" to see if
> @@ -118,14 +117,25 @@ int mce_gen_pool_add(struct mce *mce)
>  
>  static int mce_gen_pool_create(void)
>  {
> +	int mce_numrecords, mce_poolsz;
>  	struct gen_pool *tmpp;
>  	int ret = -ENOMEM;
> +	void *mce_pool;
> +	int order;
>  
> -	tmpp = gen_pool_create(ilog2(sizeof(struct mce_evt_llist)), -1);
> +	order = ilog2(sizeof(struct mce_evt_llist)) + 1;
> +	tmpp = gen_pool_create(order, -1);
>  	if (!tmpp)
>  		goto out;
>  
> -	ret = gen_pool_add(tmpp, (unsigned long)gen_pool_buf, MCE_POOLSZ, -1);
> +	mce_numrecords = max(80, num_possible_cpus() * 4);

Per Boris's below suggestion, shouldn't this be:
	mce_numrecords = max(80, num_possible_cpus() * 16);

>> 	min(4*PAGE_SIZE, num_possible_cpus() * PAGE_SIZE);
> 
> max() ofc.
> 
>> There's a sane minimum and one page pro logical CPU should be fine on
>> pretty much every configuration...

4 MCE records per CPU equates to 1024 bytes, considering the genpool intrinsic
behavior you explained in the other subthread.

Apart from this, tested the patch on a couple of AMD systems. Didn't observe any
issues.

> +	mce_poolsz = mce_numrecords * (1 << order);
> +	mce_pool = kmalloc(mce_poolsz, GFP_KERNEL);
> +	if (!mce_pool) {
> +		gen_pool_destroy(tmpp);
> +		goto out;
> +	}
> +	ret = gen_pool_add(tmpp, (unsigned long)mce_pool, mce_poolsz, -1);
>  	if (ret) {
>  		gen_pool_destroy(tmpp);
>  		goto out;

-- 
Thanks,
Avadhut Naik

