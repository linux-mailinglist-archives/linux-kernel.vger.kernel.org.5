Return-Path: <linux-kernel+bounces-128758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 36051895F5E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 00:10:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91FA7B216FA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 22:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E929A15E808;
	Tue,  2 Apr 2024 22:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lr3f/Eaa"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2122.outbound.protection.outlook.com [40.107.243.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396DD5BAD7;
	Tue,  2 Apr 2024 22:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712095796; cv=fail; b=b1O2JK1Cp8Q4CJezgGmH/vomiPYBD9qs4AtmIAlm/bHtS6V5VOHnCsJC60aLk9RbStfOqr1vhjevHRGlfJdrER9roNFAKuC9k+mwlRxHhyjBH/+AEaqI1Y9E40e+0LGUrWQkwhBbndDNFrnEvsbSbtwz518AKDMWzmVlxCw0w6Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712095796; c=relaxed/simple;
	bh=8wDfBSc7Y4zaj/asYfxx/2rlCl7pdnmjKzGyPcrZItI=;
	h=Message-ID:Date:To:Cc:References:From:Subject:In-Reply-To:
	 Content-Type:MIME-Version; b=JpsuVCCTOFs7JVEhwr4XhxtLwkomnfwBAAF0t4753JoJqSKT7+buFOxIGi6Gr/g46fQL20vrzfA1HCPlKUbWzbfYsHvlNBMGwaZ2qTUwSrNd21Mpt2iVstord8tVjVNGdojBCWzMJFxUZsuD/4lMqj/ZEN3IRKQB4DQXmo6f5EQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lr3f/Eaa; arc=fail smtp.client-ip=40.107.243.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QzlPdRDnwah2Gnr170GLJNqfJBkasZb+O5A6b8kHO+X5K2t+lh+YC2XHQloFJwj+8GamjSRST0wLUxOt1ItEUpQ0/amD1+RKIIfjgUV6Oh1Ter3JT+d/DEsfVQYkzOcMAUc2KX42LcKrKQUTM6R7ypqbfxIcBCzDqnXzJbMLxki92hRMqrW7zz9Jw2MRD2dn5fFF7z/z/a3QZOUq87SXsNNkD2dHesm1II4hTzN6DB30wIvonoDiFTlBxPCshTOJzgHbtOA0bgJV5yXn/cq5iG9/9pVQOEdlxVa3riEWIEH1WLqDOFKmS1Ul9huSC1aFVYEqk+N0ScvVXrmi++1sIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j7gyIN8eEPMJdfYxBUjL4Xf3oNRzNzJM2M9fjx754W8=;
 b=UTWgXz0BBgHU3iUudwSer10CEoYaQVzpy+70j++5vzyNmZRemP/UqnTPXTboH4PoSn4P5KiO78CvHu+w79a4ESk3vm/vyfuJpfKDQ6jVQ2tgGI5MnqaM33ch3CMYUQ+lMEi8awgsnHOtWWg9zaKR11xg622wUTZL203BHlcOaojqdCbgTGAvhZOe1GFF2heSTE+6GQ7STHpIjmyuAALqC8xDdQEAr9yn3XMtT9ilYPF/hmvHR+KRbBaWD0UB/CpZmp6cdOrxKzK5ms75zyAl5bwJ1t6wjgyI4RnN/kldhuduJAWLBsqZ4/i/SoGdZka2ErhFjBTHTaqr0DT8Snso9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j7gyIN8eEPMJdfYxBUjL4Xf3oNRzNzJM2M9fjx754W8=;
 b=lr3f/EaaiMK3S0v4J+LfOp1RUO5KA1cY5qkgC5NOgMUIR4qGI6PgooP9AfGvmfhPWw9MiDgU7e3AORpm9pVrALsQJK39fIZn8r08WyeRtvjFZgS0zVzt87/RfmT2RNgSH8OETX9TPIdDEfQCdS508VcjXnzWazkvnZ1nLyvUQ2Q=
Received: from BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17)
 by PH8PR12MB7327.namprd12.prod.outlook.com (2603:10b6:510:215::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 22:09:50 +0000
Received: from BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::1032:4da5:7572:508]) by BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::1032:4da5:7572:508%6]) with mapi id 15.20.7409.042; Tue, 2 Apr 2024
 22:09:46 +0000
Message-ID: <b1822884-cba3-4009-d685-81a36dbb4353@amd.com>
Date: Tue, 2 Apr 2024 17:09:44 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To: Ashish Kalra <Ashish.Kalra@amd.com>, linux-tip-commits@vger.kernel.org
Cc: bp@alien8.de, michael.roth@amd.com, x86@kernel.org,
 linux-kernel@vger.kernel.org
References: <20240312184757.52699-1-Ashish.Kalra@amd.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH] x86/sev: Apply RMP table fixups for kexec.
In-Reply-To: <20240312184757.52699-1-Ashish.Kalra@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7P222CA0010.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:124::33) To BL1PR12MB5732.namprd12.prod.outlook.com
 (2603:10b6:208:387::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5732:EE_|PH8PR12MB7327:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	QujCDaRhCY0ACK1q7LSpF01jauPGlboaS9IF4L+M9gUO4NbGQtgx5F5F6vpJDqfREIKp7YEdmkMZRlZLI14ArjCS1L9ZkzONhucemnY3g7K53/6Sk0AcQK7PuP79POVbHVqs6fc7BhLMiKvRYnVa8ybxEQhAk6tnENmRlxTG6acrcUr6FiBuDNlZr7We7U83NN3AaKfpN+cm6USpsOWxFLWt2i9GfR+QyjRL3AFyNEv9JwhuqG28ybiTqjlF5HSdMrwHJoeNne9+kFksFsihJzkdeS8QvJwG6zsWXCWyBR4EXIt/w8tw2nb/qw0DM33lnwC4aFCnROuW8mn79C7eydeoecsjc65lO3vzIo+aVv+S+CJgsn/UhiNi3os6sYPbFnMK+8oNuojESu5MbXqfaXAnTF9HG/OIrdjeehpg/Njvb9FigAK2Qyur8vALQl8EnERqnGEyvJml83pFRLR7er4JHh1oUTnW1Hoe8YOaEA87U3ze51/3X13a2Hx64CpRvD1b6fqg1ixARK158n0CKO5C6xLGLDgZKuqxCmtkNQUxDccKROz8Jps+vHuxG+zK/C/dKSOChqoY3z99j+PVYbqO6tQt+ORq1vyLaR1W+Ev794dUs1Y9s2FAn22b5lSAripAk7Bt8toJg66xylGfEc2uMMFBUskyYH+dqu4sxC8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5732.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y3UweTNiaWFwM012RzBucGJMWnByNzI2NXE5TmRQYmF3UUVRK29NRjZTbThG?=
 =?utf-8?B?L3lTM2FLclMrckNaRjZGc2hWbDU2bC9iV1dWcmVla1o1RUZtL2g2amZVNmlY?=
 =?utf-8?B?emRqRHFYMmYzSUlPdlpGQ3FUc3VTQ1g0VTNmRXJYY3hDdXFiRGE4Ykp0UW8y?=
 =?utf-8?B?VHZuMGM5Q28rZXFpeUQyVjJIVXZMV0NZU3JPbnI2ZkpWWWdjNktUejlYbmpV?=
 =?utf-8?B?S3FZcndSdkJsMklmNHp0bkFsN3pFdHUvNTZyWXpjUENJK2czMkw5bmJDZjJ0?=
 =?utf-8?B?d0E0YUpyRk5kYmNCTzlXUGN4T3phUlM1WlhuYzNRNE5uTmVuL09OUU9VVWlj?=
 =?utf-8?B?V0NvWk1xN3hzZjB2Mk5hK05JVTk0WnBsSGl6d3hGWHcwWE9OOXF3N3RkTVdH?=
 =?utf-8?B?UDdpaVlFck5zK29qbXlKbk1kdS9pSlFUTDhCOUppdE9ZcVJBcjRlb2NNMHVC?=
 =?utf-8?B?ODQwSWxxSVhiU0RvYVVEMTZQODBaajhwUkhVdC8xWVcreG4xOHoxQVNvNExX?=
 =?utf-8?B?dXZoMloycERPVW1QRlA4L0U1cmluUU11WHZRZ2R6MTFFVWl4R0RSQ3dKd2Jx?=
 =?utf-8?B?ZFltdXhZd1oyNGZCYUdXd2RScm82b05HOXh4eXZ5Uk1TbG1KQ28xWGgrOVRn?=
 =?utf-8?B?V3FKZklWVXVOMHNLaURianl4OGI5K1Y5RTRDNnpTWUE1NWZ4MmZUNXdGOUJ2?=
 =?utf-8?B?bjdqeVZVWEJqMkxSeW4zYytBQVdCUWlRM0l4NklhdW5iUWc1bk5yQkN0NTR3?=
 =?utf-8?B?aXV5bDJnQUx1Z2hseHRpS0EwWVIyT1R3Yy9GSU4rVjlCTHBPWkFuZEFiNFM2?=
 =?utf-8?B?c1ZtRDljblhhdlRGTmZjaVdCZE5sc2dodGFFK3I0dG9zWW9aYXJ4RG9lc2kz?=
 =?utf-8?B?NFFRUXVhMndsOEZFM1A5dmNHSlFvVEdxRVBlWUVYRXRvSjFVY3pORU9Jak9Y?=
 =?utf-8?B?K3lpMXhuc0dsMlNOWGNkZndFZmFFN0czMGwvZnhyUXA0dlN4N2M5aUxLaSti?=
 =?utf-8?B?TTNRSGxCalZZRVR4RFRRd0pkVFdvSlRISjBzNU1QdU1PNE9OQzVtRlRnVkV0?=
 =?utf-8?B?b0xiTkYzSjlTU2FwQVJ3VnlVRk1QaGVlSFlTeDBkajhaV0F6enhOMVlLcWUv?=
 =?utf-8?B?SzNDbHJoRkwxS3c2WlVaK1F4bldybG9FU3BPSUFXQmZORzRETWxuTjNLdlZB?=
 =?utf-8?B?QzFpYkJ2SmtIYjBTZ0xrUllYVFluMldYSjNLbVBhMFRmN1VObVRTcGh1MklV?=
 =?utf-8?B?UGxGcVA3bnlZSEF3QStZM0dLbVlsOVE4R01MMFU1QnFkQU8zK1QzUmNrTjVV?=
 =?utf-8?B?UEkxbWxpTE5hU25LOGlUNjY1Q2xLcDdHR0V4TFI3Vyt4dWtVWGtIL3dZUkxu?=
 =?utf-8?B?enR1RDFuSURRZkVPbnA0RTBGbWNRRmhzaThWWFc0eGZjNE9tdnh5cVVQQlJq?=
 =?utf-8?B?M1NjMFQ5cUdCRW5XeUZiLzRaSFYwQ3k5Z0hqZS9GVkliYmFxeEkvTVFweTJw?=
 =?utf-8?B?UERacWdRKzV4Q0xsZTZkdyt0Y1JtbUhKUGJLeGdxN0pkR0V6aE1BMzVJSVh2?=
 =?utf-8?B?SHg4M0J3Rmg2K1FFcjBYenk2TjdOdFhwMEkwcUFlTlczOVdOVlNDVFhRSG1H?=
 =?utf-8?B?QlpNbUw5YytJb0pxL2d6M1VUNi9rQmZmQzl3eEhqTVZSWFBUVUh2RW01cHdC?=
 =?utf-8?B?YzYvM2dvWDhqY0NNbUJpTzhFN1pHUGR3MGk5Q3JYSW02V2lKbzVmTEJ1d2Jj?=
 =?utf-8?B?L0JTYkNnWnIvclZoYWRMdnJaakEzZHhCTW1NV0JXbHE3UnFaMVdVOFFKOTkr?=
 =?utf-8?B?UjdFVGJkRWJ5VGR1YjVSUFBTQy9NSVVkbGVsTHB4cHFSNEV1RGxabGgxa1Vj?=
 =?utf-8?B?blVkKzJNMjJNaEthenI2Q0xNT2VlQ0xETUpZZzhMQkI1T2tlMlB2TlVPM3ov?=
 =?utf-8?B?akE4VEMvTjQ0UEVCNmUxYldWdVJYdHYrcHJ3UWJtaGE2YlA2N1ZVTjduM2E1?=
 =?utf-8?B?N1V4cHB0YlN6Q3ZUT09ld1MxVk9tRFhpcDVEdTRaaHM5Qk9KU2EvUFZ3MHZW?=
 =?utf-8?B?aFRaOHJ4czZrZWUrZjE0VDkyN2FFSi82ajZ4TlFHNEpDSmdUOFo4OFVBbHNy?=
 =?utf-8?Q?zFyYodq1Hm5S9rbNLJWYS2aD8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ded3e391-619a-4fdb-74b1-08dc53619b82
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 22:09:46.7525
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DyrhXZEg4rgz1J4Tlqw/GLpqMWP0bvtr98hzzWB2wR6Ufp4c8AgJ/FZ155qxKMOyz1YD/G+8NzRzNRsLdfs8kQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7327

On 3/12/24 13:47, Ashish Kalra wrote:
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

This produces a build warning:

WARNING: modpost: vmlinux: section mismatch in reference: snp_probe_rmptable_info+0x95 (section: .text) -> x86_init (section: .init.data)
WARNING: modpost: vmlinux: section mismatch in reference: snp_probe_rmptable_info+0x99 (section: .text) -> snp_rmptable_e820_fixup (section: .init.text)

Thanks,
Tom

> +
>   	return true;
>   }

