Return-Path: <linux-kernel+bounces-101378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9016B87A651
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 11:59:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7502B21E66
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 10:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA6F83EA71;
	Wed, 13 Mar 2024 10:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pxqt3Mdg"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2071.outbound.protection.outlook.com [40.107.243.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDFC83E495;
	Wed, 13 Mar 2024 10:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710327529; cv=fail; b=QmhpQimCVrNYIyqPfpPGlqhqujCnc0FV4M2x0a6EzWAo4owF1e4iIksQB4aBWP8fPiY0eUGBeCGCs8ualnqn/ELY2YtzTipkK3k4rmPiwt+7gLP02n3wtgdA8G5EPtLyu95jjvp+VtnweTI4yucn9m8CKdAW3e6syha1xnduoLE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710327529; c=relaxed/simple;
	bh=qZpT38kXVK687WMzVO/I/WsdP+J5mO9/YV0ycjf9dOg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kRLCkgvZ9hgrwp2uy4OlPl3+pEvSJglyYgF93J/XXLprGuBQZqaashnwOWvMSk5DSvxiartIvM0EaS8/gQMofGl/eOVXJlPRbHEg62rXVl/sTYQ5pIU1uKN7iAYPBgspUXp3jiIgSBr7l0yPVNBqMKvotmCveYWBH3v25Q3NjE8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pxqt3Mdg; arc=fail smtp.client-ip=40.107.243.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IhPp4SRTWzrdTuOpPY55b65YF2kNtjFxXkbFKCgo3yfj2F1mGwq2xRKw30EkKQWKVt3c28BEN0e9kLGvGnh3/EJqQ8otJfjvTnxPnDJ1s6Bs6ZPWKGbffZPE4bAkJf1Um6KybguEc6TXW3QM5a6HSnBDy50sDlEMNQglLBxL/fP9R5X7Xr9s7N4YKRzUNMLkWtMJf/4iATJMVXdGcKGxKhJrgbqu3EKx2iLA1Z9mMGtandzGOveMkhMurRqy6IbyVpBEnhsBZoT/ynoAoFx8fGSZKgYHmsKH7gtOHdKSlA8txaG7jGbaK+vSARZw+VCMbmr85TPTjsccwMgwQ3OP+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+NlmIVD1mWpVfJA4seDcTS+7sGfpHbzG615X7j4cFLA=;
 b=HMRYefyRFTCWrTfu/RiuXbzvxbu/M1zIT4TQhaOSBC/65Ac/oRRC/B6mb6ThwNwFkd+7uS7fEr3NygDKo9flGh/nJzWq8KZQd4lxYYBU8DHzY4ddrZyyTKNsy9xCDMFC4XrIsrQVrGr2U10z0WjcWgMfGo98nZBTRmLCgUAFDL9d0LICy+r7Flshjms4+36Y/8+SDL5xv/c57eZVmqfahqlhahEHuUlaqkdQWvNbl1fFWr1Rrv5CH1CqQUhTm6LK6cDjS6ezKIqy/+wXmdzS/ss3ig/NIVUWedtGtiNzCdJs5haKHZmsFH07SKZvfGmHoOJj+kAcJhn1d/uLslNCkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+NlmIVD1mWpVfJA4seDcTS+7sGfpHbzG615X7j4cFLA=;
 b=pxqt3MdgjokduEGO4Cu+OlfWNDpaq8Fd8h98TGpciEMgNh+A6vkwMbmUV8CVSeBPQTwXcUJk8bxcCrbkdIo7A9gSrhbQA5MTAw2Fv1fengoksWNPrf337rKtHY2FX6A5Wc3KX5hPzGlx4ooSYgHRtrIQ3q/v9phxA3a8eoW3SrU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6460.namprd12.prod.outlook.com (2603:10b6:208:3a8::13)
 by MN2PR12MB4141.namprd12.prod.outlook.com (2603:10b6:208:1d5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.20; Wed, 13 Mar
 2024 10:58:45 +0000
Received: from IA1PR12MB6460.namprd12.prod.outlook.com
 ([fe80::df03:ebca:7c7a:9530]) by IA1PR12MB6460.namprd12.prod.outlook.com
 ([fe80::df03:ebca:7c7a:9530%7]) with mapi id 15.20.7386.017; Wed, 13 Mar 2024
 10:58:45 +0000
Message-ID: <f152da91-816e-4791-9afb-51f189acdbd6@amd.com>
Date: Wed, 13 Mar 2024 16:28:37 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/sev: Apply RMP table fixups for kexec.
To: Ashish Kalra <Ashish.Kalra@amd.com>, linux-tip-commits@vger.kernel.org
Cc: bp@alien8.de, thomas.lendacky@amd.com, michael.roth@amd.com,
 x86@kernel.org, linux-kernel@vger.kernel.org
References: <20240312184757.52699-1-Ashish.Kalra@amd.com>
Content-Language: en-US
From: "Aithal, Srikanth" <sraithal@amd.com>
In-Reply-To: <20240312184757.52699-1-Ashish.Kalra@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0077.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9a::16) To IA1PR12MB6460.namprd12.prod.outlook.com
 (2603:10b6:208:3a8::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6460:EE_|MN2PR12MB4141:EE_
X-MS-Office365-Filtering-Correlation-Id: ce1909c1-b74d-47df-5f83-08dc434c8d88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	RK0dBMuNeWLmmMe1VRU4+rMb+ivi4ffoWafGJxmH7jhRv5ydMbWh7VO4S/cKkPfgEPQ8Ldd0Xqdj700hiSmLb9VlFQ9RKydtHHbWoiMuQGvEtpWQZWNolFYBy2sMNkAvFojGrQyfYiYwdYJeYcNq1EUTPhBNHgnKrFUFxfX+sBhMh2cyBiZNyy9s0w4+S4FCQUPRhQ8x7DFSrxDVeXT4OV9ZiINTddBmJFyuMnK2pBdo6wj4gOoN3r2SeAW/66MGmGAqcCR1e7Bpa3Otszdpqq6XcMCtvWxRT6jqG7dJn2KZtH48aVavKvS+bzrgbTFpqwvVEdjw4DIde46LjtwhgXEjZrv+7HbDCtlBQHIHw/+rrwo3CvOJBGGqYXhBB0cpC/Ph3bzbp4E5QFo9xUtE7uDGLV100FxHiavo/8xZGcJUZwT/K1uUgBqXEdqX7xWyiEZ+a2I7djiRpFb7dxjkSvn0al9E8BHX+m0V1rQvHFgtPCyrTSttt4c+79+jG87jvQHA5IlPGAeVBYPvrW1QbytfgVdiOwI+c9iWEmZbl2fdy0vXVpBacXqho4ioSuKSCtcDl0MEV7q/m0mt+u8KiiRpiRu9yV4rd/61qMkEhxXqT8mcxgf0E0Xme3tIF1Z1Sxx3RCgyyPpDysIeZVZ6pM8Fl7fiGxN6Ti8sR6ic4bY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6460.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ckpjaktJd21NK3RsWSt4ZkkraXZEMjNrbUtDK2wwZjJqcENvMVE0bWdNUWVP?=
 =?utf-8?B?eE9oQjBlbEpCTkNLd0tWbUMxQi9xMU10RHg3ckVCSjFRcEpFdS92dzljUzVR?=
 =?utf-8?B?dHhyOFhoNVRqTWlFR2RXWGhZM1ltZDRUV3VQTVdTUE5QQmZ3Q2I2MDd0eENQ?=
 =?utf-8?B?VkVoeHJ1a1R6dlJRM3JLY2YvR1gxN1J2U0dxWEVIZW56bnlHYkEybDZ6WVFU?=
 =?utf-8?B?TkROeEE3WXFsQm8wSFFXOWZSeDAzSXBLLzVUeGtSK2w2cGR5MVkwK1RacU81?=
 =?utf-8?B?blREa1I4N0M5VWFzVXl0WXEzd1R1UjZIL3NQQmhiL1dvZVlpMGdnUUE4Tkhy?=
 =?utf-8?B?V3ZDdkpJck5EblZUV0tRSUMrY1hWT2N0TE5RUkNwQ3VDTXNpTXhPbVFJSHVy?=
 =?utf-8?B?WW45emZHSUg5Q1hHcS91L3JZUURCbGdCaVNISlNmTWtWQ0hvQjJucVFjcnlI?=
 =?utf-8?B?Uk8wbytDdXBiT29FelVCa3JTcXl4bHcrN0Rlblp3MXh0L2hkNHFHWlNTTTlr?=
 =?utf-8?B?VFZMem5leVYvUEdobjRheHlLeDM3UHlweTlmSncyMlI3NklBbmkxdEtXRVlW?=
 =?utf-8?B?UXhacUZUSmlTTHFSNmtQeVplSUhyakZzcmIyV1dmekFucjV4eG42czUyQktZ?=
 =?utf-8?B?OTJwZ0oyelNaKzRZNldEcFJFZWk5M25MOGdMUkVoRyt4czJXc3p4a2p4KzJE?=
 =?utf-8?B?cy9kU3J1NEgzcWxXVTlZeXpyRTIrNVhZLzVFcnc1MjMxeXdobHpBWHJPejVy?=
 =?utf-8?B?eEU5dFh1dHo3NUlaVGZDYUVsZ2ZraENUY2JLVmJRdmphRGRyRFNuVWsrcmFj?=
 =?utf-8?B?M0JQNnByOWxQNnozbmFRaFJ2aXg0VEJaUzFGbjlMWnlmNGl6aHd6Vkhsd1lE?=
 =?utf-8?B?dUZKbFVqTGxXWWo1ZzcyTjZweTRpUExOT0ZTbHV0enNPdlRtcHpCRkpBNXZ3?=
 =?utf-8?B?ODNENjJqLzVSQzVFeDA4OWhJNHQvYUxvZTY3aEtsYmdYbGdKMW5PWDg1VE9H?=
 =?utf-8?B?QmJZSUxiNUJoTldqdHR2UWxCdE1xcWRYczNQWlZzWnFDVzRFdVpxVnNZQnl3?=
 =?utf-8?B?L2wvc05EcUQ1ZnloanJuSnBYYlltSWNyaTlVZlN2RjJKMjVRak5UazR2cEtT?=
 =?utf-8?B?ZjBISnZEczJ3YXpQdWpwbm9iSnp5MnpCZ2dxQzhmdm9CTG9CaURISzNRcUh1?=
 =?utf-8?B?dEtBU1BhVU5OVXIxZEczQVdYbnZDMGhTVXNodHl4TzNKOGltdmxab1p6STFu?=
 =?utf-8?B?WEFXSnFndkh3S09NaWdVa2FOOU1Ub1h5Q2tFa1hoUzdVb21OdFpxWTNPR2tC?=
 =?utf-8?B?Rm9NZmlnTXg1YlExTXZ1Z2ZuaHN0M1pwZ1V3dzZITkVWbnNqcWY2UFNvNEZk?=
 =?utf-8?B?UVluQldMWktwYU9jb3BZRnNaRUF1c2dwZzhIaVlmNFE1M2UyT29TTDFTL1da?=
 =?utf-8?B?L1hqTmdKeGROdDNQQzdZdzhVTGxhV00xQjJKcWtaenJGK2xmSHVzMmZXYkhY?=
 =?utf-8?B?dkUwclJJQWsvR2prSHNQbEhCYXpsSkhqeHRZeFpKRGRNRXo5Y2dEc05ab3Zk?=
 =?utf-8?B?S2JBd2V4TnRuYTN6NWg0WXk4SjhCTFg5WmU1MTRCVTQ5VTFrRXlwQ1FPcWg3?=
 =?utf-8?B?Wll2Q1NGUkFYU1NILytHQUdYY2M0eTR4TlJjRUsxQkJrUXU1cEhMV1Z1eUxZ?=
 =?utf-8?B?R3U0R0dGRDhaVExDMytiVDF1eXdaV2lyMlAzR0U4MmtmakJYaDdyT3Q2b0lF?=
 =?utf-8?B?Vk9EeDdVdFZna0IwSmR2TGFxcGR0OE9qb1p5TkxoRndPTlJTd1gwellpMHF0?=
 =?utf-8?B?a0hBeXZWRGltOHltQi96dmlYNklhSE5xN0g2cFBEVnJiOGNIUVc0elZWbnlP?=
 =?utf-8?B?enpXQ09JTjFQN3dhdjdFWkhrNTczM0ZkMElLTEVNcHpyZ0NQNEE0VGU2TjJ0?=
 =?utf-8?B?KzUxSGhzcnZZQ0JXVTNoZ1pzanN3bS9UcnhsaG5Ed1lHbDltaldmTlUxOHB6?=
 =?utf-8?B?eGdLQkw1bExCSXVSR3h3ZnJGWHZDUHlsbXJSZHdnTWYyS1FtM2g0V0htdUNz?=
 =?utf-8?B?MDZ1YzliMDRpNEhHUDh3aU5hdmpPNWUyTlp3Mmo1L2pLMmRZRXJGNnoweUo4?=
 =?utf-8?Q?lDilwIHMT371SpqPwXtkkl6KK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce1909c1-b74d-47df-5f83-08dc434c8d88
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2024 10:58:45.4285
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mDQoTaxkTyZyxS8AC6vUNSdZTh7eMgCSUxk3+WnStVyM2R6qrApEYYgigaktJIlmQGEzem7MgogJi103a17rVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4141

On 3/13/2024 12:17 AM, Ashish Kalra wrote:
> From: Ashish Kalra <ashish.kalra@amd.com>
> 
> RMP table start and end physical range may not be aligned to 2MB in
> the e820 tables causing fatal RMP page faults during kexec boot when
> new page allocations are done in the same 2MB page as the RMP table.
> Check if RMP table start and end physical range in e820_table is not
> aligned to 2MB and in that case use e820__range_update() to map this
> range to reserved.
> 
> Override e820__memory_setup_default() to check and apply these RMP table
> fixups in e820_table before e820_table is used to setup
> e280_table_firmware and e820_table_kexec.
> 
> Fixes: c3b86e61b756 ("x86/cpufeatures: Enable/unmask SEV-SNP CPU feature")
> Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
> ---
>   arch/x86/virt/svm/sev.c | 52 +++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 52 insertions(+)
> 
> diff --git a/arch/x86/virt/svm/sev.c b/arch/x86/virt/svm/sev.c
> index cffe1157a90a..e0d7584df28f 100644
> --- a/arch/x86/virt/svm/sev.c
> +++ b/arch/x86/virt/svm/sev.c
> @@ -65,6 +65,8 @@ static u64 probed_rmp_base, probed_rmp_size;
>   static struct rmpentry *rmptable __ro_after_init;
>   static u64 rmptable_max_pfn __ro_after_init;
>   
> +static char *__init snp_rmptable_e820_fixup(void);
> +
>   static LIST_HEAD(snp_leaked_pages_list);
>   static DEFINE_SPINLOCK(snp_leaked_pages_list_lock);
>   
> @@ -160,9 +162,59 @@ bool snp_probe_rmptable_info(void)
>   	pr_info("RMP table physical range [0x%016llx - 0x%016llx]\n",
>   		probed_rmp_base, probed_rmp_base + probed_rmp_size - 1);
>   
> +	/*
> +	 * Override e820__memory_setup_default() to do any RMP table fixups
> +	 * for kexec if required.
> +	 */
> +	x86_init.resources.memory_setup = snp_rmptable_e820_fixup;
> +
>   	return true;
>   }
>   
> +/*
> + * Override e820__memory_setup_default() to do any RMP table fixups
> + * in e820_table before e820_table_firmware and e820_table_kexec
> + * are setup.
> + */
> +static char *__init snp_rmptable_e820_fixup(void)
> +{
> +	/* Populate e820_table from BIOS-supplied e820 map */
> +	char *p =  e820__memory_setup_default();
> +	u64 pa;
> +
> +	/*
> +	 * RMP table start & end physical range may not be aligned to 2MB in the
> +	 * e820 tables causing fatal RMP page faults during kexec boot when new
> +	 * page allocations are done in the same 2MB page as the RMP table.
> +	 * Check if RMP table start & end physical range in e820_table is not aligned
> +	 * to 2MB and in that case use e820__range_update() to map this range to reserved,
> +	 * e820__range_update() nicely handles partial range update and also
> +	 * merges any consecutive ranges of the same type.
> +	 * Need to override e820__memory_setup_default() to check and apply
> +	 * fixups in e820_table before e820_table is used to setup
> +	 * e280_table_firmware and e820_table_kexec.
> +	 */
> +	pa = probed_rmp_base;
> +	if (!IS_ALIGNED(pa, PMD_SIZE)) {
> +		pa = ALIGN_DOWN(pa, PMD_SIZE);
> +		if (e820__mapped_any(pa, pa + PMD_SIZE, E820_TYPE_RAM)) {
> +			pr_info("Reserving start of RMP table on a 2MB boundary [0x%016llx]\n", pa);
> +			e820__range_update(pa, PMD_SIZE, E820_TYPE_RAM, E820_TYPE_RESERVED);
> +		}
> +	}
> +
> +	pa = probed_rmp_base + probed_rmp_size;
> +	if (!IS_ALIGNED(pa, PMD_SIZE)) {
> +		pa = ALIGN_DOWN(pa, PMD_SIZE);
> +		if (e820__mapped_any(pa, pa + PMD_SIZE, E820_TYPE_RAM)) {
> +			pr_info("Reserving end of RMP table on a 2MB boundary [0x%016llx]\n", pa);
> +			e820__range_update(pa, PMD_SIZE, E820_TYPE_RAM, E820_TYPE_RESERVED);
> +		}
> +	}
> +
> +	return p;
> +}
> +
>   /*
>    * Do the necessary preparations which are verified by the firmware as
>    * described in the SNP_INIT_EX firmware command description in the SNP
Tested this patch, it fixes the kexec issue reported. Thank you.

Tested-by: Srikanth Aithal <sraithal@amd.com>



