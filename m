Return-Path: <linux-kernel+bounces-65432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C054854CEC
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 16:34:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80EFD1C271DB
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 15:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B421C5B210;
	Wed, 14 Feb 2024 15:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tEYfZHko"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2084.outbound.protection.outlook.com [40.107.92.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190EB5B5A2;
	Wed, 14 Feb 2024 15:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707924801; cv=fail; b=ByvozKiPuTr3YFLhbqNP0+eX6H5nKrDn8j7eaislbTcc6CV1F+BPTq6DCnAas/2sM7uVkUSqhovYyZtJhEU5WSjNYz97pdZL84hKL29QJiC4iXRr77h36e9TFNdRjKqusMKioaRCBtG/+lRv/K+1JHsgbI72N04DoEgeTfzGm24=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707924801; c=relaxed/simple;
	bh=0dDiDntmTqXVRh1RMJRxWHigc02RsCTvqrYoMy1Q65w=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZPM9OLbEf+TDBtpM7lqRI1LCousAe9rC7IoZnD0cv2dlc8x7hiKvd9limoie4stNqY/J7X/cR2wFh7AD2Ig7BCut1eVCucXNebR+TGTExZrW4tKPSitu9osTVotuNYRVie4XhpvUay79WAGB9CBI1yg2Xs73cwuvT8NKq9jX7TI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tEYfZHko; arc=fail smtp.client-ip=40.107.92.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h7McysUAx9MtYx+QuWwr4LIuJfx84qpRN7RzKHcmGhTrG5dEPCSvCr1jkRCERsWZoj75sqq9yvVKa9PtPtJmAO/m780Oqi5JEYe4EvfnLfhQEE45HRUaGjjRtRzkzvQJvXfV4Vj0FiWn62idMPdCpfXhbILM3A+22dhTPHZXlCJ/Aota5Qxh56hdHjBDjKIqhec9V4BNFq8aVkzUlKK8BZELA30JL11PN65iNB+Idxt1zYJb/NxpWSXFfsyMVSuWtadsXJobL9TRfFmHgZjXRafrvMDz3cngkmMCPHkAnxymR4FwsBmy9GNHfsQhP/KER+Kc9nZh2c0pFFBxsCV06w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hHr9rij242PDx9kvGqEXnwQNTvKhHYPypJRD8qjFPh0=;
 b=dJDVVMYYE6mp+cQlZEDVo+mrEZvsYeURg30NT/dITFKeNleJ5LWOr798CoTPokAWKiUMF0qwOcVOi2KQAsdk42bDImWxo4cE3E3gZILyQNVDQej2yGsY74HJ4Wg00tqL6fW6P/ICMyPCivdlGlV2Miagi6hHUk4ph6Ci0l90uOoDFg2JdlU4noiYJmUjTGBhR6y0srczuxxigQbeH6TpUG6makXP1uYLTs6OTQYeZLa2SalTGMv2OOX3fyDGpSC2Bd1HQGLi6nQzue9m8LjYU2UdbDMGNVbrS91DYG5GGAhiukMDAm7Oi1jsTg+pJ/J4UrCLD3dSEwH9ACEQGCDrYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hHr9rij242PDx9kvGqEXnwQNTvKhHYPypJRD8qjFPh0=;
 b=tEYfZHkohfFb+tZgTRtxakcamFVj28SVQY2wjKkETwBBliUWAmdtHT/ZswAqpKExNWf60k/iIkBcbxXB15NsNXBnpnCZVUoifSLz+SApFnk4bBVB5mwBWTfG9IvdQ/Mv236J1pDMxOp+NTsqBhRHw0ISmbKrhaNN8RUcgweHpU8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by DM6PR12MB4218.namprd12.prod.outlook.com (2603:10b6:5:21b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.25; Wed, 14 Feb
 2024 15:33:17 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::3a46:cf50:1239:510c]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::3a46:cf50:1239:510c%7]) with mapi id 15.20.7270.016; Wed, 14 Feb 2024
 15:33:17 +0000
Message-ID: <1a46d8cb-104f-4854-a09e-c60095e2dcd0@amd.com>
Date: Wed, 14 Feb 2024 10:33:15 -0500
User-Agent: Mozilla Thunderbird
Cc: yazen.ghannam@amd.com, tony.luck@intel.com, linux-edac@vger.kernel.org,
 linux-kernel@vger.kernel.org, avadhut.naik@amd.com, john.allen@amd.com,
 muralidhara.mk@amd.com, naveenkrishna.chatradhi@amd.com,
 sathyapriya.k@amd.com
Subject: Re: [PATCH 2/2] RAS: Introduce the FRU Memory Poison Manager
Content-Language: en-US
To: Borislav Petkov <bp@alien8.de>
References: <20240214033516.1344948-1-yazen.ghannam@amd.com>
 <20240214033516.1344948-3-yazen.ghannam@amd.com>
 <20240214120214.GJZcyrxgyLLwQ8y19Z@fat_crate.local>
From: Yazen Ghannam <yazen.ghannam@amd.com>
In-Reply-To: <20240214120214.GJZcyrxgyLLwQ8y19Z@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0628.namprd03.prod.outlook.com
 (2603:10b6:408:106::33) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3108:EE_|DM6PR12MB4218:EE_
X-MS-Office365-Filtering-Correlation-Id: a12fe400-5154-48bd-55e9-08dc2d724439
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	996S8DSOMyfqf7M+wtOm96UpRXOy1qiSgHRf02MO5v1nBoRpDeFOAn932Cu4d+i07sa3UZeB/G5bcVimv9mbBEznSYUzWfyZsfxKlIB2oLVVy8fGf9opheeiHCggClOYByXAFcWSFVUo1xshvFbwyNMBIM0wYsKn6drYfB0OwuOxPA0es6YcQeSUX83xLhMkTinbKCaPi+F9Quy3k3mqsaVpyueElLd6q5RHA4Mlz4ZffrVn/LJ4+ks2IkoICNKm7SkkjiRkDC8XHAgVTXR6yCd2V2tL/HlEwnzAJGnqYHwh0elwr6xtL91Nkvj/RrXRyonby9QWDM7XKeDRaQhPEJcZe5PGbDfdBqzJXJoCzJNUCbl/5+i+6WebBu6P3H4l/M631XRxb52rKNF/B935bZASfIeKNmcTyMyXHBVbs0eq4PMlHk21Up8mkCHlBFRcJasQcRcnv94jgMhgRJYs4K+w67KuJ9Hv7LgHZYyLGsbKVhy3tLQvLwb4DKVyw74/cZQGXZs2pi4aaEwzrHEA4NSpIjU8A7ojCwg81VTftap4+pEYHX76z0toKf9v7zmG
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(346002)(39860400002)(136003)(376002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(2906002)(31686004)(44832011)(478600001)(2616005)(41300700001)(26005)(83380400001)(8936002)(5660300002)(66476007)(66946007)(8676002)(66556008)(6916009)(4326008)(53546011)(36756003)(66899024)(6506007)(31696002)(6486002)(6512007)(316002)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZFZWRS9MbTE1OWNJOUVBVGZIdThKbXNNb2RlMFNtRmtxeDVmaDEwN2tYenZL?=
 =?utf-8?B?dFlEU28wcWpkSGQydHcyQnErcjJjQkg1emRqOXBMM00wZWpuS1RkakdNZkFK?=
 =?utf-8?B?OHR0LzNvRW1WVkdNVXFGbVFmNEtUVHZkUkxSK3lraWkveEdnNnhYQVRFVmRo?=
 =?utf-8?B?M2szd1FJOG5uTDg5MFpXYTAzWEYwaXRvRGpxNGhEV082YXFGSVVWSGxzcFY1?=
 =?utf-8?B?aHpsT0Q0cWRjR1FGT0I2TFlqV2YreW8yVVNFNC9zWDZBdkFiWEhEaTQ0VSsx?=
 =?utf-8?B?RDAxa2ptOVpZSTN6dTFDZzc2ZzdPUnlDSFNqcm1DRmRBZGM5N1JsTHlONXJ5?=
 =?utf-8?B?NktnWEZFSGRRZk1PbHFkaFZjS0lRbno0S1VtOSt6RytNRzlyaHJBVXVGZURG?=
 =?utf-8?B?ZlpvQzg1MGkwN3Rua0NzeXE2NitwcHRYdWIyeTFGQWNOV3FFZXhTemhvckhP?=
 =?utf-8?B?NFZCeXVSWU1KOU5UZHZsSmRPMWhGOStqdzhBV0JDZ09kMmRZeUU0LzMzOFI5?=
 =?utf-8?B?UnVSeVVHdnNwSFpFYVF1dlZaOEVxYlFEY09UR0pFV2ROYVJGckxhZlY4WnBo?=
 =?utf-8?B?QWlURlBzWklwb2c1YzFtcGk3K1ROWUVPZTM2Z01McXd3bTA3Q2hZa0E2OGdQ?=
 =?utf-8?B?WFc4SmhNUXdQTTA4dE42Ylh2K1B6Z3Z0M0NmUFB2MkM0MU0vSjhMSFhWR3Nw?=
 =?utf-8?B?Q1ppYW10WjVyTGdRb3RkMWFHUGdsVkduU0FwcnNUVW5jVG00QnJUS2UwNkNo?=
 =?utf-8?B?NVhmeDVEMFpERmFrUU1mckNRdmtuYVBvWXZadGlHeHNHWFM1QVg5ekI4bG5L?=
 =?utf-8?B?Q3pKNm5TWWw1bGFab3RLVlpkNTZxeGhuMVAzV2Z6MkV1dUdESEpYQWE0ckor?=
 =?utf-8?B?MitkODhQUzdiWEJzZ2dpeEhwa0Rad2FFaDgrYjNnVXRGSEJidWV2NXhpdklv?=
 =?utf-8?B?OHZXMlUvV3d1MEJ1UUltZXBiUll3UkVnbEVma1BnM0I3ZG9pVzBsQzdmYlda?=
 =?utf-8?B?bysvRzhqQlF0R1hTMkxGT3U2T1VudStaZXgzK0FoTGVSaHAzUEl5NHlqaTRI?=
 =?utf-8?B?dDR1Qk83cCtJQzJrTk0wWXRVMVlMWjkyVGRpWFFBUStZN3N4TTBUNDQzT293?=
 =?utf-8?B?UFJaODJkNHZuNDg3Qy9rSisrK2MrenhwUTgxOWc2cFNDVXYvWS9HT3NodHFh?=
 =?utf-8?B?aW9RbEw4RmdmZjlZdHp3RUw3K2laSjBrb2JFZCsreFV0QVJBSDd2Y3BKT2lJ?=
 =?utf-8?B?SzRmMVZSd2ZqVCtIM0VQK2s0RWU4Y1YvcC8yT080NUlRQnZnOUlzWUpCaFpk?=
 =?utf-8?B?YmlXWGJmSXZvdmdqSHY3a2Q1TVdQaTRieTRneElqVzF2QmlHSytMMXRlWnFQ?=
 =?utf-8?B?Mit1RXkzbmdYajRsVjNIb1U0b2hJak9Ud2swT2VGM21EU1lXbDhjcVowdkpy?=
 =?utf-8?B?YlVkNHpNQ0NhMUg0SU45cUdpaWtwVGRpdnJNNUJDMUp6OUpDWTcva09xaGtW?=
 =?utf-8?B?Z2p1UmFGaTR3bGRHRkZPR0FqbExNWFJsOForWFd5V09VRnUvNUQ3cWZwem4y?=
 =?utf-8?B?S0xlMEdDQzVwM2FvRWl6bVhieTYxaEdLWjY3M09nRk9peVErZDJDbEZYbzdp?=
 =?utf-8?B?RUpTb25ubFV2ZHlJZnlEZlh0VFkweTFweEwvUmJvbzRwcFdMdklOdFhpRzFt?=
 =?utf-8?B?QXEyWnZ3VUNTOWNybElaWUZBUzN1c3gwK05FNkhTamFqV1pmeE16M1d2dnpS?=
 =?utf-8?B?WWV2Yithb01QNi9wYnp1aFAwT0hDNnk1MXhyL0ZYQ3FiYXU1bTNzMUNsdkRx?=
 =?utf-8?B?RzNsdUJpWExEZDFKRTBRVnJLZkhBTVJiRmlMQjNXRkVSYytzL2VXaStPMzh4?=
 =?utf-8?B?Nk1kMmI3M1MvTkFKNUlLeGg3eGNMU20wNlBTVE5HcENkTVZjL1g1Wkoza05K?=
 =?utf-8?B?QTBGMEhRZ09iQllRek9wYXovbGozM3dJcFZpdkxMdzN5Zk5MR2dpT3RYKzMy?=
 =?utf-8?B?SlNZNUt3UGdRRVB1SjgxTlorcFZBajJPSHJLTFI2K2srSGo2dlZIaVdFdUZv?=
 =?utf-8?B?T09PN25uSnNzRmhLWC84S1VNaDNoYnVTUEc3VDBUZld2Wnc5MmJJR2RLRncw?=
 =?utf-8?Q?mmjM089eJyZMmDP/3ioiDkI3i?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a12fe400-5154-48bd-55e9-08dc2d724439
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 15:33:17.4893
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eDNt+ISZVUyZHaSXO8g9pRNPQGC2MbCeP7SKBaUDQvaH8j2doa+yWZTR3yULAAyf34RBmM+DVCGkJnDhqhO1Ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4218

On 2/14/2024 7:02 AM, Borislav Petkov wrote:
> On Tue, Feb 13, 2024 at 09:35:16PM -0600, Yazen Ghannam wrote:
>> +static unsigned int get_cpu_for_fru_num(unsigned int i)
>> +{
>> +	unsigned int cpu = 0;
>> +
>> +	/* Should there be more robust error handling if none found? */
>> +	for_each_online_cpu(cpu) {
> 
> You need to block CPU hotplug operations before iterating over online
> CPUs: cpus_read_lock/unlock.
>

Okay.
  
>> +		if (topology_physical_package_id(cpu) == i)
>> +			return cpu;
>> +	}
>> +
>> +	return cpu;
>> +}
> 
> Fold this one into its single callsite.
>

Ack.
  
>> +
>> +static void init_fmps(void)
>> +{
>> +	struct fru_rec *rec;
>> +	unsigned int i, cpu;
>> +
>> +	for_each_fru(i, rec) {
>> +		cpu = get_cpu_for_fru_num(i);
>> +		set_fmp_fields(get_fmp(rec), cpu);
>> +	}
>> +}
>> +
>> +static int get_system_info(void)
>> +{
>> +	u8 model = boot_cpu_data.x86_model;
> 
> No need for that local var - just use boot_cpu_data.x86_model.
>

Ack.
  
>> +	/* Only load on MI300A systems for now. */
>> +	if (!(model >= 0x90 && model <= 0x9f))
>> +		return -ENODEV;
>> +
>> +	if (!cpu_feature_enabled(X86_FEATURE_AMD_PPIN)) {
>> +		pr_debug("PPIN feature not available");
>> +		return -ENODEV;
>> +	}
>> +
>> +	/* Use CPU Package (Socket) as FRU for MI300 systems. */
>> +	max_nr_fru = topology_max_packages();
>> +	if (!max_nr_fru)
>> +		return -ENODEV;
>> +
>> +	if (!max_nr_entries)
>> +		max_nr_entries = FMPM_DEFAULT_MAX_NR_ENTRIES;
>> +
>> +	max_rec_len  = sizeof(struct fru_rec);
>> +	max_rec_len += sizeof(struct cper_fru_poison_desc) * max_nr_entries;
>> +
>> +	pr_debug("max_nr_fru=%u max_nr_entries=%u, max_rec_len=%lu",
>> +		 max_nr_fru, max_nr_entries, max_rec_len);
>> +	return 0;
>> +}
>> +
>> +static void deallocate_records(void)
> 
> free_records
>

Ack.
  
>> +{
>> +	struct fru_rec *rec;
>> +	int i;
>> +
>> +	for_each_fru(i, rec)
>> +		kfree(rec);
>> +
>> +	kfree(fru_records);
>> +}
>> +
>> +static int allocate_records(void)
>> +{
>> +	int i, ret = 0;
>> +
>> +	fru_records = kcalloc(max_nr_fru, sizeof(struct fru_rec *), GFP_KERNEL);
>> +	if (!fru_records) {
>> +		ret = -ENOMEM;
>> +		goto out;
>> +	}
>> +
>> +	for (i = 0; i < max_nr_fru; i++) {
>> +		fru_records[i] = kzalloc(max_rec_len, GFP_KERNEL);
>> +		if (!fru_records[i]) {
>> +			ret = -ENOMEM;
>> +			goto out_free;
>> +		}
>> +	}
>> +
>> +	return ret;
>> +
>> +out_free:
>> +	for (; i >= 0; i--)
>> +		kfree(fru_records[i]);
>> +
>> +	kfree(fru_records);
>> +out:
>> +	return ret;
>> +}
>> +
>> +static const struct x86_cpu_id fmpm_cpuids[] = {
>> +	X86_MATCH_VENDOR_FAM(AMD, 0x19, NULL),
> 
> This is why this should depend on AMD in Kconfig.
> 

Okay.

I was also thinking that MODULE_DEVICE_TABLE shouldn't be used. Not all
MI300-based systems will need or can use this module. And it does depend
on specific platform configurations.

So the module should not autoload. Users will need to manually load it if
they know that it's usable on their platform. We can keep the cpuid[] and
model checks just for extra safety.

Thanks,
Yazen

