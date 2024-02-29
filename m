Return-Path: <linux-kernel+bounces-86187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD5E986C116
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 07:44:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C108281DC9
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 06:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1563C3D541;
	Thu, 29 Feb 2024 06:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="c7i1YIcW"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2080.outbound.protection.outlook.com [40.107.92.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD1B50260;
	Thu, 29 Feb 2024 06:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709188966; cv=fail; b=o9jS2IWCx0/7bCHlvQlx1pblULgv1h02PWAj5PgAdWINLVHcnFLnQAlbeWpg8dcVlQSHNyWASrJ4hBkGnf6DabUFwLilxktkRBv3hbQVeuATFmFn7vFIG5EwHri8ZxQ2R6UcrLjC4OvbvouoMlIWV4Tw35kKwZzS5FucooQQ5jY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709188966; c=relaxed/simple;
	bh=RLM6tgLf4y4B2BRlM/0CxYeenGA9ZITvg8RmbHia310=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KWegtAsnK5R3UQVtz6/MACNfNU9nBSkyj7/k5df8fpMV3mQZtY2I7QM2z2bu4IZYJjG3osMDMpetCHf8DcVkqfmW+dUiAxEaTtZwwBZ0ge9pf7XHIiGPdFsmmwMGWDP7+J4ZXzEOvpXSHRVolspoBoTQoLgWHiCbnMdHiUksNfA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=c7i1YIcW; arc=fail smtp.client-ip=40.107.92.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K0YFkKkRgjBZfEsx0s7WjSE24351XZ0OdhzwcmAYMC6VIAtm8cWchO4kGKhi5jr8WYcbpjXIIDhMANHfVsDZT9lgVD3wIKEpa/sqOj6B87iIO5bgDIK/Hnyw/9kBh/fSvSp6uKjd2/jtDjWiALFSRmOx8bKzC8c6sDwAL9qrieL0gpwOrDOYx1pgGI39/YGQZDPSJ4UOQNNDlDi7X7ZglIqkqW9UbznwOAjHuFx9+LE+581jQ6DzRLdVDEw7A0xQnpnC03lt7U6f8e6/dEwoI3StcJOOdB802nUI58AoS4fXInLGzIDeMkWl3y6iXAPaY4alXQ5nme8MTSGsPWlXTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8NEm88aMLmnodhor/tGLkxvNDK/ScyfL6eWfK/1O3dk=;
 b=aU1UarhCHQqHugg7Qipa95kNXiREjoLTnGP1gwigIB9tjmDP0fXMYqMoL/D542VfLoqgWboHvf6wSHwI8awYG2DyTSAz/i6YV/gBI6ONyf5yDzaFQIdgYkaxK5JRAi2AqZu14I2PuPTb2vv+1ZMN7g1y7Tibr+Zv+FCBn6asDhsS5NjR92x1MX9XHu4TQFZ4CgMsGww5zR2EI4lArp+hvyOLNMKIRogTq/A6fHJ+hntm4IUi4Q466fmhT49S8tP+9u423hRS1sJv+8x3OCTVQJkMCiTLUZSZ5iaGLhwmCRsmeFRtpyEmeoQnB2OGun3VahMznoBr8VTDNjC5jEflEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8NEm88aMLmnodhor/tGLkxvNDK/ScyfL6eWfK/1O3dk=;
 b=c7i1YIcWmRwodSu0agrGRmdxXxQJyvb5b1SC/fSOtq272jV7zNu0LIBOqRSTI5AbphUOijkk4Is0N4Cnstm4palGlPiT9tRk0spbb2t1kuHnaf/mNDF9woFlasQR5N+6QaWLQei12s9bJVnNuWqB+YKhp48lpOr4VUydEUBXQC0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB8403.namprd12.prod.outlook.com (2603:10b6:610:133::14)
 by LV3PR12MB9215.namprd12.prod.outlook.com (2603:10b6:408:1a0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.36; Thu, 29 Feb
 2024 06:42:42 +0000
Received: from CH3PR12MB8403.namprd12.prod.outlook.com
 ([fe80::aaa1:af99:e0e5:7f14]) by CH3PR12MB8403.namprd12.prod.outlook.com
 ([fe80::aaa1:af99:e0e5:7f14%4]) with mapi id 15.20.7316.039; Thu, 29 Feb 2024
 06:42:41 +0000
Message-ID: <8ee24cad-e9b8-4321-aad4-9a9ba4f8b7b6@amd.com>
Date: Thu, 29 Feb 2024 00:42:38 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/mce: Dynamically size space for machine check records
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
Content-Language: en-US
From: "Naik, Avadhut" <avadnaik@amd.com>
In-Reply-To: <Zd--PJp-NbXGrb39@agluck-desk3>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0071.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2c1::18) To CH3PR12MB8403.namprd12.prod.outlook.com
 (2603:10b6:610:133::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8403:EE_|LV3PR12MB9215:EE_
X-MS-Office365-Filtering-Correlation-Id: 299f51e8-5a99-41f2-31fa-08dc38f1a074
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	x+YMGSZk/G/MP7yxdpvw/0GG3KpKH7eemLqpQUwpAjSh5jqN6iGeqVzMSL63Vi4WjDTc7WppP1zJLH6s3zJtyUBBIV+vQI7srYw+lEjNPxbSd1zAETDCDCW7HAPiiJM5OvHn4+ZOr1/aaUUt6+txR4CTdxzP192XPrVyPtGX+VYQQS1bcqyZcO660qVJnnO8KFD6XqYhApKKlxwU76iXNbCtgJo8XxkgKZwMyRJCXj1Pj8K6/7fpgxtN+TKvozwOGrNkJxNeqE/YByMys8lwpTVRJnSkxanu/vqFOVXNcZXd4j8Uh8XfZ3gPW4yh2Sl7ASDElSyaEXl9j0zcQfyCGvy/Vr3IoUvWGAFhkZenZBLc1CKWv971YWKdSsgRjFtcSX1mLhPz4Z4WXysY28VVzj/SjLeF4gw5zd57aGmT0ehlrY37XiPLVXHgtAZiZlIV+kVTwIjWzrYIgPGp95dkhmReNzeRIZn4t4w9sA+7vDn+cczhxsKDIpUEBQ8zz4cw/P8wfVT7SRtUuyDWx/DgjZKO+JSfsdyvXZqkimonvh9PC13RFpENdP6x7zGTSmfHiifZzByyqKZzcPgUApaKWijKWgrHYU+ebIRb2IyTxNGz2ztXuU0I69cybIDm3pMA
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8403.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZitHUVQ1REZ5MEMraC90a2RSUlovNHVhYlpxTTdIZ3ZSV3FMWFZZK1Q5NjRH?=
 =?utf-8?B?MkphcGRJQm1UemtSY2NlcGdmSG94aFhTMDBlK2RaZElXZXdVVXVXSWU4QzYy?=
 =?utf-8?B?Wno3QkliT2x2Wk0vMU1JU05DZFRwUzY4Y0hVWTNkMVdLWTNaa1p5R1Q2V3ZW?=
 =?utf-8?B?VmhIelZUOWVZUWNQQThwMmYvRE8yUmdVUjZVcEFzUE1oaG9kVFljekpUMnBH?=
 =?utf-8?B?Z2p5ZVZ1L1RwOStmRHZ4aTdraVdGeVVYd3h5US85QXM4SzZaNkpTZHpaWm1x?=
 =?utf-8?B?MzVzc0NLRk9WQ1lmTTVuVHRBMHNMdmNnWXdPTWNKOE5NVXdzbDdDODM2L1FW?=
 =?utf-8?B?QXBmaUJxcVBsZ3FrbkZkTnFFZVZXQThHOEpZTFFhUWJ2TXd2eDJVWFZPb25Q?=
 =?utf-8?B?ZVg3b0RLakRYbm9VQWFKL0k5Z2ZPeHEzSXdKTGg2TE1NZXBHVWpjV29PQ05Q?=
 =?utf-8?B?SDBacERPV0VkbDJnUnkxRjNBNXFwSVBTNm9jbDg5VlhWWTJlOTBrTE1QZnJT?=
 =?utf-8?B?QUcyRE1aVFpTMUNVeWVTb2V6QlgyTWd1dlNtdkZUMlZwcDdzSHI0dzc5MklV?=
 =?utf-8?B?emtxVnZET09ja3pzVlhsSUtQb05ReEpGM1RhYlNPZXZxU3BXbWJ2MEVDRk5V?=
 =?utf-8?B?alFka2hlbzQrNU1ZdFFLT29pK050aHFEZGgxd0JGa1JNSlhoRG5ybnoxZXda?=
 =?utf-8?B?ZDBCQ1BUUnlNeVlyUVJzWjcwTUR5VWN6RWFmV05vYVFTYldsT2RBSFAyeXV1?=
 =?utf-8?B?bktUY2lZN3locytIQnVZUS80Y0c4Tk9OUFBCOHRFNkRZcnhiT3BKbmlEVXBM?=
 =?utf-8?B?TzAvWkppeVZUMkhDQUNudDN6R3ZONENjeHJVOCtXMXA2Z3RPY05LTnVEN01I?=
 =?utf-8?B?cEJoeEV0KzhZRDNxeklNWWU1S2QraWxYWGNnQ21GRDBTbWlkVXZJd2JSa3Bu?=
 =?utf-8?B?OVU1TndHYUp6cHR4ZzE4NC84NEkrWDJHa0k5cjVoQ2kzVTRvRlZzN3dVRW5i?=
 =?utf-8?B?MDgza3llcjlZYnM3cStBZWppRlF1VWlJR0prTTc0cktvNmkzRE1wYjIwRzFS?=
 =?utf-8?B?dlkxMHYrMER1SjRBN01mTjFZRWlVQ2pvMGloQTdKcTZKcFZZakZMK1hSdmls?=
 =?utf-8?B?SEE3SkNBaTNRczZ6T3N3L2NEWHU3c0p3bFp6OGhjVEw2ZFlVTDJkaUY2M0Y4?=
 =?utf-8?B?L25tdGVORmFqSG9TS3BtRlA2c0tCRDNkQkNLYzhEOVIwSFI3NnNzVElPZzNT?=
 =?utf-8?B?TEwwUzV1cCszZGtWdkFoZTRkZ2xnZDFuM05JM3JvcmMxcDgwM0U4NnNIQ0tZ?=
 =?utf-8?B?V0wwRGtoMTA3dGhETTM0QnFCTlh5M0VmbEM0bFFFajE4RjZDYWR6cm94bEtW?=
 =?utf-8?B?a3c4WnRFcFRZaFozOVpmSlVmTXZpdlZUQTBuQXBpZk5jeGFtV1pObHR5aE42?=
 =?utf-8?B?MzJzeFRqdlpGRFpndElFUitQNU1SVHFUNXd6MncwMnBHNzVvSmVqL1gxWDFF?=
 =?utf-8?B?R05jUytoeFlhbHFHNmRTU1oySU9FSDF0ZllabnZoL3N0blpiMmxSc09DSjVR?=
 =?utf-8?B?MVNzczczejJIQmVBT0pXNVZEcGl4N1ZHOWNQNEtPMzZaR01XOVo0QjJhZzNC?=
 =?utf-8?B?YUV2MERaNm5tZDhhSE05UFN1K2lwbmpubVBvOURiZkMvMFZQQStJam9NaFc2?=
 =?utf-8?B?WlhESTJ3TmdTS0xrdndkamwxOUlYM3RiSk1PSExZbk5jOVpZb25jK1MwandJ?=
 =?utf-8?B?bnVtWFpKT25EdElzTjRFSDRjdVZSM2pPU0ZPdGZNaXdqVnFXYlRQYTlXNEps?=
 =?utf-8?B?dm41U1lSSENVSW5PdytsdEU4bTJmVlgrdkNQblJMa3poV0lqV3J4OHE5ME51?=
 =?utf-8?B?TEdrdlk5c1k3OHRDeUJwZEZZaDhTbU9maEdqKyt1TzRnU0JzVDhmTjc5VHhk?=
 =?utf-8?B?cFdaQjZpbzZ1NFZqbUo0L2hiYWNaRkw1TG9EQ3IxMlI0b1crVUwzYkdnZ01z?=
 =?utf-8?B?V211R0NqTXVFcm5PUENMUlR6ejdvK1hPT1ZFeWozY3NuS0FZYlhPRzZ2RFVv?=
 =?utf-8?B?cXJBS3FmaFl2ZHFjVG5kMmJMWEFDLytXKzV4NzQ1akd4cFh5NjgrOTY4VHRi?=
 =?utf-8?Q?CVb23YwfeUD+CADJoiqtLXbK9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 299f51e8-5a99-41f2-31fa-08dc38f1a074
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8403.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Feb 2024 06:42:41.1763
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V+gVD1lp12LIQCMxxQpArEtP6dx3caLftQSGaZ3I+9Nj3bcpgeqasK9yKSBnDXlzAPJZ9PdohYN1oxMJv32Uog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9215

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

Somewhat confused here. Weren't we also exploring ways to avoid
duplicate records from being added to the genpool? Has something
changed in that regard?

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
> +	mce_poolsz = mce_numrecords * (1 << order);
> +	mce_pool = kmalloc(mce_poolsz, GFP_KERNEL);

To err on the side of caution, wouldn't kzalloc() be a safer choice here?

-- 
Thanks,
Avadhut Naik

