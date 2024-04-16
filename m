Return-Path: <linux-kernel+bounces-147198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BD888A70E2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 18:07:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EC691C21E1D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 16:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE184131746;
	Tue, 16 Apr 2024 16:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="AlfOhnSC"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2052.outbound.protection.outlook.com [40.107.94.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6303BB23
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 16:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713283656; cv=fail; b=mEINfJS8yvSKvFdVuz4u16Su7Lt5+Ro5ojhn/4MWnO3vc1zKL/+7BAb9HOSgzNDyv8Tk/LL8mmlsHNP0UVdGbn/bCmCNZe2wUWVvsSRsmKy51JJBihNuaeQuu5ehDLX9AoMExPkxaV6xLQo9fhCqsYZSpR80xtTGy36Hjrepx+0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713283656; c=relaxed/simple;
	bh=hK3tqM9LKNitmp64pDNWjhkUF5zgR1CJgqRQfy9HDBg=;
	h=Message-ID:Date:To:Cc:References:From:Subject:In-Reply-To:
	 Content-Type:MIME-Version; b=rQ+C44mkVwm7cAdsveM1WNEWh+TfvztY/TCmhXKWFzOxc/6ajQC7LAhsh/PkJBOpjcufDI257fSjWZqL+6T+dgLBh7TThd+/bgiM641MzMylfJGJHTtnaSXR4FKRI83gqFQ8PSDKYCFkQ72Gx/eaZL5KWNpW1pSLeBFyGSgqemM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=AlfOhnSC; arc=fail smtp.client-ip=40.107.94.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mjwCgVwiyOlYwuSu5mcRrLMh5M7XOkCvkk3FeFU2cdBWicaCur6R1t7ynnrk4ipKOXZqegn2taJFtFDAFZhkQC7g4AicejnsbnCCu9CW5ekEHKkiX4vwdINUuvDHYBSQ7mrCKDENPSIfMl0LoOftCVIt8OCUa5UeYBdcRoy0MoLGek6uF3EmYCLo2+frB5YBzBHJKhRM6oQMp+EIAoe5aEl8U58uBrIGLUyyquWhc1lzux0ULO59o0kg4YA2mLinr1q1RoM2OErwG3kWSDWALBD+p7UnpD0DuG/Ku1KMMIFd9gMq1b0Qxam95a79UaHBB1Zo0wEBpqMrAmVyYtAfTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WGOVPVDoEVOw6cfh/c0BSuhx5j/OQg/C0hhfFG8RU+Q=;
 b=YGvY3ObaGbzxyepldVBK9bGdZFPLybXLE3bX1sf+K+OODcTtcc3aKeC2nnqe3tW/RDOsfGEJ2nAglgpWNb1ss1ByjYYkBkkMlWQs2IhRlIB/oUumkL/OoIMBWPjvy0A1SvEd2TrSscdXr5dfQsCIMAaqZpJK9rVzEw/tttQn9BH2Fvr1woFvRtBPdERtpWrrJ7Lte2urK6wYq+TWN8xa/2WjrOt8AALNNQRxQsKdlE2K9QkjlrIf1ndDpXIbjs76Hv4kKf0GieHskS5OleJtDgPQRAGCeBzkWqLtR4fCUKtFJtiWVZyn/Ee1r6HJpbJbU4MxE/ltZxJaRH23rOKxwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WGOVPVDoEVOw6cfh/c0BSuhx5j/OQg/C0hhfFG8RU+Q=;
 b=AlfOhnSCnXvo7aXnOyHX5Ib1AkaBJwoCXquxz6Fha5LbaDArfZph8xkqvWxV4eIL0tjMdIm6/79f7rqN9aR/uOWz42wxFcLhvA4VR8zMy5KWhQh5d58GarfFKu5EE32hqCva8VVPFKN8nnAfMgegmpbABcLFaVhrphnt52K606c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17)
 by SJ0PR12MB6832.namprd12.prod.outlook.com (2603:10b6:a03:47e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 16:07:29 +0000
Received: from BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::bf0:d462:345b:dc52]) by BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::bf0:d462:345b:dc52%6]) with mapi id 15.20.7452.049; Tue, 16 Apr 2024
 16:07:29 +0000
Message-ID: <24a30a7e-f90d-550d-b86e-118513ad8017@amd.com>
Date: Tue, 16 Apr 2024 11:07:26 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To: Dan Williams <dan.j.williams@intel.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org, linux-coco@lists.linux.dev, svsm-devel@coconut-svsm.dev
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Michael Roth <michael.roth@amd.com>,
 Ashish Kalra <ashish.kalra@amd.com>, Joel Becker <jlbec@evilplan.org>,
 Christoph Hellwig <hch@lst.de>
References: <cover.1711405593.git.thomas.lendacky@amd.com>
 <67893f352bc54de61160bfe251cba0bdf0431f37.1711405593.git.thomas.lendacky@amd.com>
 <661e110326bd2_4d5612949a@dwillia2-mobl3.amr.corp.intel.com.notmuch>
From: Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH v3 13/14] x86/sev: Hide SVSM attestation entries if not
 running under an SVSM
In-Reply-To: <661e110326bd2_4d5612949a@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0162.namprd11.prod.outlook.com
 (2603:10b6:806:1bb::17) To BL1PR12MB5732.namprd12.prod.outlook.com
 (2603:10b6:208:387::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5732:EE_|SJ0PR12MB6832:EE_
X-MS-Office365-Filtering-Correlation-Id: c2d9619a-efe8-4b44-4cda-08dc5e2f50ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	jU88MeBqLS1h74BHeW83bGavVu6GXUVrIzBMomqJnMec1MDaHvkyvRBXTEMG3O5HI/5C5MeV/xSrf0CISfTk0OVl5OG1T8+U7oP5+lq+8IlRRFXv5pMoTpm6jnZkyQ8Xdsq5sr9Xh/BUWbLIseGzkgK2nF7/t5cxNuPehqZKXev5ZbzbylRztXwptA5MMuvzd3A/xaqUffcokw+OjkMdytppCCRDTQv1P7K91RXmGFaWZlfnCjT2JJpcZ99Mq+2Td4fhIH1QmHDSn5KTw4M0FMeOIA+ujR/IAhM5x6VFUkigHzujgOvnxeLBlxFoMm8Il5t1nYo51fvY/v/xBMMdX7MAhjHAqbXwfEL72y56eAwdSi7C2aVjYJw5Hh5SSNlmL7vmtbl6dNMMK2e0EvdNHCxAL1fkzEVHmZbTG6KenC7Qp/SUcZBJ4NoQo+mrGARyhfmO1+H6ghLz2h9C0yTJPE5Wmj76BNqJ3MbdpGRS8DlPFcFXFKJijHQRjHl7zDRuNqSpVycYRf/F8+0mh8J5hgLZJNYeDCUXFdIfRzeQOloacGCwvM6OUm2fm2bP+JpQzlRUYRNZ6VZg0B04S6edXSyUSQirbJ1yLpE+U475Gr96x7aFekOZDRMgPNfjgr9MCQjmfAtqU3PbtvtJpby1Hw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5732.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RUs5VjVwMUk3cldETTlwRVNxNlVmME9sSmxGeUlUZGgwNkp3ZGVWYmE5bENh?=
 =?utf-8?B?UXM1YVJsU3FuRUtHSGFRckxEOUlCSnB0bTNxZ2RzKzVEZUVzeEkvZS9XY3A4?=
 =?utf-8?B?dUorajFjaUZha09FNGcvOEt2QXR5MEsyZjg3Qy9UZ1hQSFNJYkcwZlM4VndU?=
 =?utf-8?B?enlBb2tlSGVra0hvb3JSMkZ0K08xRERsWUV0ZnhrQmxrTUVzVFNuTmduenNp?=
 =?utf-8?B?UzFTN2VJQkQ5M2QwaWxEZXRjK1RnTGFmOTluSFRoQlFOZ2dCYXBJeStZNmQx?=
 =?utf-8?B?cGZGdy94TG1yR1ZZcFE3ZlJvTzg4Vkp1a3dNMEdjbndvaTVKME5sWEt6andr?=
 =?utf-8?B?R3pScnZTcXJBUEF3RU5TRjJoRm9UMzZNODJFQTNHUDd4dmZsSE1ySTdJV2xL?=
 =?utf-8?B?cGpoUjZ5UW9lUzhYY0c5cU9FWHNXY0NJTHJHVlc2UlpiVzBqV3RJVDRza3NN?=
 =?utf-8?B?SEQySXFhSi9yOVRZV3VReTVBS3l3dnlBelphbG96OFBSM2cxd253WTJaY1NH?=
 =?utf-8?B?WWJxMW9KbEVSYitxVXRESkx5VTdVVU12NVV6cVBML0ZDemNVY0t4eW80bkZm?=
 =?utf-8?B?MzFwY202WTBjMUpJY1djRDA5cnhva0hXSlhFdE1mbys0M0U5LzlzNEZxL2dO?=
 =?utf-8?B?TU1rZG9aUnZCVkROYkhEcjdnMzhEMnM5YlhxeUNwaWl2QzJHTm1vekNjcFNw?=
 =?utf-8?B?eVBYUFQraS9iNDJGTXJyL3BVUGsydjhvQ296aWtZTU5zTlpQUWQ2ZDRaWHo3?=
 =?utf-8?B?OGtWWDFrdDNZQXc4aHdnR0FLcjFPenl2YUlyRnVjMXlDS2Fpc2RKcmVleWc1?=
 =?utf-8?B?SGwvc3ZlNnpRaStMcHYxY0MzUmxNa2wxY1piVVdhS3piZlQxem96Ukc2WURR?=
 =?utf-8?B?azNGWWJ5OGRlUjU3UzFmS21hdWxvRjBGV1BJRGx6Z01UcVZoNzRaRUJiMzly?=
 =?utf-8?B?WW1US1JCUVh3RStBRWpEeG82QjZtamNNekUwSVBhV1FnOVoxNlE2UDMxUmRQ?=
 =?utf-8?B?Z0Vvc1BRQWZ4eGpySXVPZHpFZmdUeDBJZmxQOVN0N0hKVzlFZENOTHVmM0hk?=
 =?utf-8?B?QUxyczZSOS9SZk9HT0sxMVRGbWFucHJ6bTJCU2w4VUlRWjlPanpFWS9Sbm9H?=
 =?utf-8?B?Rk1aZDJJZUVkbWNxa3ZTUUV6OWgvWVZRTWZYOU9yY01JK0llWnM1QjJpK3BW?=
 =?utf-8?B?RUhSUGV5U3VEUC9DZjJGbjY2dEpxWkFBRWdPWlkwVXZyblN5RWtjZi9sYzZj?=
 =?utf-8?B?eUNrSGtBd3czMmVFaUxjR0VpUWxmZkpPZWp0bG9XNDY4Q1NncGlGMXJSaEcw?=
 =?utf-8?B?SUFUeVZqWklvcHh0YVdKY0pRdWQyZkxaak1hUFRxdWRGWjMrQTk1U3ZkK0ZZ?=
 =?utf-8?B?R0NZVjdETzM1U2krVXRZb1o5U2dlZUxLM0VnRksyeUpZbzhtTi96bHFJbEtx?=
 =?utf-8?B?Nnc0Z2FKZ3VtUURZb0FMdmpqZlNjaDBXMTkzMWI2UXlaVFl6M1lBNjlWSisr?=
 =?utf-8?B?eDM4S2VOYjVaRXlhSUZwNHp1SVRsbmwrMVpOMjlTcFgzeDhBMkhZdUQvL3Zs?=
 =?utf-8?B?dGRSVW95QWFpaFJJdW5kYm8wV2ROZDdZSDdIL1hkVCtBUmtHdE9FRGwyUnFH?=
 =?utf-8?B?UFEzeXhMMGVFTnk2ZGhDYUhIT0FVM3NDUzR1QzFkVkhXRm0wVkh6SE1qRzcw?=
 =?utf-8?B?anQ4cUNBb0Vuck5MOFhsTFBrL2hLV1JNcnRaYTZzNEpIY3ZrUm1SUEdkNkRG?=
 =?utf-8?B?NTR6YU44YXZJejZVVHpVK0RkNERCMlFneFpLRG5UaEtxRWFFclBpeDJNWGhF?=
 =?utf-8?B?bzZkQTFESXBFVllDNThtNk1mU3V3NHFtRldvdVNGWVJ1bzNGb01SWkdyNHdj?=
 =?utf-8?B?QitRZWZRb213azBlQVhBY1MvQmNoUnhweXN1dC9ZM3AyUjhiZWtiRGdOVm1n?=
 =?utf-8?B?UWh6VEo1NVlsTHhTZ3RHaTgvS2REeEdYZHVyUFV6RERvMHprZlB5UngvMWdx?=
 =?utf-8?B?Q2pvVTFheHFjLzVDYWVsYTlzQWpvOFFuS2dvbVNFblFpYllRT2MvQzlYQ2li?=
 =?utf-8?B?UWJ3VFNIMzdJaFc3UnIzdHNobVVsTktKcU1wVXMyeHFqeEIwMVVrTGhDV0VH?=
 =?utf-8?Q?RthuZEXLQhyZzUz/En8kxV+21?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2d9619a-efe8-4b44-4cda-08dc5e2f50ff
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 16:07:29.6831
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XHHPXBygRmxv8ff2feWFnOKTgV8JcdSDIy2+2IwoW6cvJYtvLnFCwxntoQXMtIKGtQvjBM4gz1cPPYsyDhRCrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6832

On 4/16/24 00:47, Dan Williams wrote:
> Tom Lendacky wrote:
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
> 
> Yeah the same callback specified multiple times feels like something
> that should only happen once at the group level.

I went with this to keep compatibility of all the attributes existing at 
the same level in the report sub-directory. Moving the existing extra 
attributes will break backwards compatibility if we want to apply 
visibility to them.

If we don't want to apply visibility to the existing extra attributes, 
then, yes, the the visibility support can be done at the group level 
instead of the file/attribute level.

Thoughts?

Thanks,
Tom

> 

