Return-Path: <linux-kernel+bounces-147202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98ACB8A70EB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 18:10:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54953285259
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 16:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C6F2131756;
	Tue, 16 Apr 2024 16:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QSIslBDK"
Received: from outbound.mail.protection.outlook.com (mail-dm6nam11on2040.outbound.protection.outlook.com [40.107.223.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF1912FB09
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 16:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713283821; cv=fail; b=lYFmTh4CFtBcuDLOBtFIlateOLCP/EFu3i8HQ1wvgIPmONnr+zP38OSzX/VaeuckhexipwRBn97GJ6aXxjkmUBWGijuSrzuh/3A/o8xjSCzxet+zyQ82hxShdAEdqC9a6ZML0JndckRbpEvMC3OPZwW7OrFn3Mwj/B/xqz3NmaU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713283821; c=relaxed/simple;
	bh=wrvrhX7C8oOVq3Rpzx9bbGXlze0jGgXrEXC86sVUWeo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ka8D+yxNPR2R87a3+9VLzM7ruIx1EXZkOZCVG1mNvHfaBWJqanVnX6LCaGB/H+VgEDjKOzgAX7EfLCIsnOJqBMfIHte4zuCoOzHVuFtSPtjuD7QhCEvjWd/cCccgDemHH5vbjQpfNfV4z+uWZmpYCd8rJsUkACIim4GP1MtXZSQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QSIslBDK; arc=fail smtp.client-ip=40.107.223.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WXb7sID7Hju8SqOK4UDEhyzd/lrRIcVyx2mJqH/m7xKYscGUam2WAekTYEvIjV9apEu72tWdpFjW6E+9YtsWPuUxweUOilfPiyYUGAU07TeGGYfNyT4EfxR7pLODNquDPMJcuCw7TrvwacImxJhBd2J7FPQW3QxNeGg+D6AtZ/L9XGgrCjSaElqIEH4BjPU/HvpJ9iJjlvfwsqqwKnhgbxnvs5et7dY13Ka47OHSjqGEi2fwSb1+ANKJTXhaW3KsDSWNoGrWpuUJAjpGRvTEdmTO/6jrwyaINP/z+FFAW4x4UUc5YQHvLXPkt5FSFMvk+wMwj5cY2C1Z3ur5fIo1HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pvhTamlKAD8kTuh0c9KJ8e4dW0bdeuao5MGTe54skuk=;
 b=PV8mlFHh962ScYHt3oWjREZxOqPfcPzjytNYmActbm+bAlrk7wkmrvEkjJO0W9sjpoFGrYcIts3/hTnFSsDvv3GFpDDtRQ9YNiuuOxzJapI0EZvHpXZs8PihQ3tIHBmtWffTJBbwtc2HWV2OYVlXmtnWhj2ztwFJ/Q+eSOxBXunekOfl++5+ReKBzmm+tlTFgg1g0F0UJvwea9pIev2sS3M9QwV8VdzsiX3lsjbsmFdRd4BHrtJC5Wv9i30oc2s1nloXOpWnJ07GToE+9fkdBWWksXJMd8eZrK+DaIeBmi188qwlinZ95L3MeuJ6H1iOSuy1Eo1tgzmyPHNIPPiaOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pvhTamlKAD8kTuh0c9KJ8e4dW0bdeuao5MGTe54skuk=;
 b=QSIslBDKHm94tHa88MllztuYdxTIEdZlYrUPRF8Evbngl9VaouBuJ5DbsJtxwEJLmTqm1cvwFEP7bB0FB2GsSZppyXjNCmKJUPAct/WCETB6qVJR+sfH7IwF59jMZ3ua3M3qw+fGKc35Exh8MG08MpPZD48FlCBT+5Q+2Zb9WJ8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17)
 by PH8PR12MB7181.namprd12.prod.outlook.com (2603:10b6:510:22a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 16:10:17 +0000
Received: from BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::bf0:d462:345b:dc52]) by BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::bf0:d462:345b:dc52%6]) with mapi id 15.20.7452.049; Tue, 16 Apr 2024
 16:10:17 +0000
Message-ID: <18dfff9a-b8e0-9d43-8538-366f74d74a7d@amd.com>
Date: Tue, 16 Apr 2024 11:10:14 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 13/14] x86/sev: Hide SVSM attestation entries if not
 running under an SVSM
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
 <661e14a2cdb12_4d561294c7@dwillia2-mobl3.amr.corp.intel.com.notmuch>
From: Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <661e14a2cdb12_4d561294c7@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR01CA0032.prod.exchangelabs.com (2603:10b6:805:b6::45)
 To BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5732:EE_|PH8PR12MB7181:EE_
X-MS-Office365-Filtering-Correlation-Id: 16d62ab3-e79f-4c9a-7c6a-08dc5e2fb4c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	RfZJZPhst6ctgOyjrxk+zvjwsAM7DK8w1n46tsM6MEVWWiRcR68QUbizoxl2ePF9DZresb1OzEBlwmMhHpmC1c1zNU8kkIgWGjznYbwyc5G0CEle7lEbcTgvoexeh4gc05bLCNpDQyasVAtVYA9EQKR4xuWM/bHaN1fn8wmRDuolPpecJyBZdtSr762Hk2sLUqsQX+xOvixRFk4OL4ELNdKX0RtM3TmTyVBNF3iCVFI2iNpt7QRZy8vMYSlt36Ys7YUYDEcMQQGB08ZTXI5jiJt/2VVskAdxdCGrHMuo3dFfdbYIB2hdiS30saK+FpCKqO50FAOcnFyUie+9LWjIBXztpcbvBNEypplJHwh72yNVEq4+2cfZIXzDNbJp+L9gmo1V7LOdQ1GgGQA/31PbW4sWi6L18XqukjdfEGw8muoaQPyUwiJMwsTrDCpqeFocKb/7g9iM5dT2rmsQGC60yg7zDUMKYHU5rOQnfiBUfosyz/peATjD2rF+Yh5ttGIHaoFmy2mdfiwtrS0J0sFpjTIyYsE4xqulSfWPdo1esYtKASpaybQ6gpu0lcL3d1k1EmWD7RAmq1IMMY0lMwgEEVvtwPb+qJ+lWMluatRs6EbmdeDZfGsv79gueaJG+ukCMAZRa5nnbUp1/P0NRCdYxqhJcAiQINaHj4HsJ2+adyM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5732.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Um5RblBWbXl4aTFQeTRQSUhDYjJ4UmVnbXY4OUFySTNTT2pFc1RWQlRrY0ln?=
 =?utf-8?B?MzlVUzlQZHk1WWovMzdnWVNpYVZUQnJNZEszMlFEQm9UWTNtSEwrWEQ0NTVi?=
 =?utf-8?B?TWllVlRRS3NFSk5yb1E0VXpTdDdTa3B2d2k1a0xGNUNjT25TekpaUHRWTGpY?=
 =?utf-8?B?QkZGVzJmdldnUXZkWno1MjdmR0RoREtCOHZKZkZpcGlyWGdUVVdLSEZrYkRr?=
 =?utf-8?B?UHIxVndiVUowbVQ1WGZ4RHBGZHpRejAwVmNnR0pzT2lHWGYyc0ZXMk5sSmcz?=
 =?utf-8?B?TnRyNXhmSlV5Z3pyazYrM3g5T0d3Z0FmbTdjb1FjSU8ybkdwTEVWbEFLamx5?=
 =?utf-8?B?S3RMMWUycFBqOWNKN1RmTkNtVFhwdjlFTHlMS2I5OWNnS0dGZmNmU0JvRnU0?=
 =?utf-8?B?YldHOW5QZ2FicDBGOG4zaGphdU9kZGF6cXFuSzRtNE1EOC9vcUpzazczbmVn?=
 =?utf-8?B?anl5ZlBQU2xSZFJqRVZCVzBhY0FzRlplVGJ5RzduMHdqcWJHUExoRzJnTXcz?=
 =?utf-8?B?clBEMTdqNUpaRTJsZHllUVFIQWRiL1FTQ2J2bTRJelZMQnk2VmdEK1YvRm15?=
 =?utf-8?B?ZTFXbGg0VWwrb2x1dFVJS0liTHRndTdpaVNXdFZlbXFha3plR2J2Y1h5NWQx?=
 =?utf-8?B?OFhaQ0hLVUdYTmY1ckdsUlRwa0VkZlNEOW4rdDZaN2hJdXpndlVtVlRqUFhM?=
 =?utf-8?B?cWt2Z3lUQ1FUZ2tHUHBwNzl0NHM5cmJIaS91alRaM1NTTi9jcDN4WENKdFEw?=
 =?utf-8?B?bUI1WnhMVW1TWTdXZFFnM0IvdlVabnpJTDlQVEppQTRyRUtmSmYwU0lFR3Q3?=
 =?utf-8?B?UHpBZGsvR2FtU09NSkFDcHhqTit4bThBeFdaRG1vTXpNK2JmTHNSNEo2RlVi?=
 =?utf-8?B?cGpUY00rMWlLUnZpR2ExcVFhMVZsTjN0YW1XUjIvN29heUVRL0VBLzFuenFw?=
 =?utf-8?B?MzlCYUUxUU8zekdDZVQ4U05YaXpNY05oSnhHc1BLZi9rWDQyd0ozV0hvdFF5?=
 =?utf-8?B?eVdHcEtkQ2R5RUxqaWNNZjkzc1AzeFM0Szkzc0wzWWZXV2tITWlPYnVhVWI3?=
 =?utf-8?B?L1FHYVkxV2pZTk9GU1Z4bEc1MVRIYU9NR3U1SDhFam1lK2FtNWtCNGN6RmQ2?=
 =?utf-8?B?d2tJRXIzMmtKQTA1K1UrTk4wejVITUhXUThuZG5VQjhLSjVxWUxRZ1BxMzlV?=
 =?utf-8?B?M2pkLytXOWJ5RHJLVEhsdTZvRzEzTjFhczR1aEZVcFNBZTNpd09LSG9OTis4?=
 =?utf-8?B?THBaQXJMTWtDNHR3WDRrYUkyd1h3RTl4bDJETkthbk9NeTlHRTB6UnFwZWU5?=
 =?utf-8?B?Z0d2WXhhTUV5QTEwVlFkb29KamQ3Q0VweGIzYkJVdXNhb3RKbjJSdFRzR1ps?=
 =?utf-8?B?TCtHNWlRd3ZITmF0b284ekFSenhFMUZpcm83WGovWWNiUGZObzJOVys4c0sw?=
 =?utf-8?B?eGVGVjRQeG1DcXhrcmtMSlVIdHFVRDg5bFk1ZnU5VG9KWThGZlExejdkMnpW?=
 =?utf-8?B?OVdWQWtyTExlK2cvWkppeit6dldVZlN4UGhsY0hxcjdJUUQ2K2J6ZGticzh6?=
 =?utf-8?B?VXVla202bml1cjBUd3F0T0VpdXFxVmRibzdSODNwN2Rwb0EvSDc3VEtnUW9Q?=
 =?utf-8?B?aTd1Tmhodm84eCtRME8wN3pCZ0hUbFNMTndPM3lhbTUzRldDZk1UWUhQcU5M?=
 =?utf-8?B?bTEzQ2h4QzhRNDlhdFh5Y0IrZzNBbFRMTG9IcFQzdXMrVkovUEdyNlMrck9O?=
 =?utf-8?B?UGhuaXVEeGVBem5zVk9ZVWpzeTMrTnBrN3ZoZ25UdDlOa3VReHM5VVZoVllx?=
 =?utf-8?B?KytXb2EzQmJidjFZdFRzSkRLQndkOFVlSDk5U1o5SWZjK1pGYzEwRkVrdytl?=
 =?utf-8?B?UVQxR1ZRY3FMaWxUbkZ5b2FUN25WOVRjOHFmcnZDSGpYR2dmRXExTGZDSlhj?=
 =?utf-8?B?cUpveHVuczNveldkcHI2T2QvOHJqOHBqSGhZRG5aQzZ6NEJaY3IyWHphVXFT?=
 =?utf-8?B?QTdDQlh2bDlTNkJpdVJ2bGV3UCs3dDJrbEZmajFjYk01TXo0WlR2MTVrejhC?=
 =?utf-8?B?elJ4QmZOVDhuOVJtbGxDeHkzcnAwOFZlSUZrdmQ5cFhudUpJRFAwQzE0d3hu?=
 =?utf-8?Q?2ef16k0vuybz45amrGQEyyDa3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16d62ab3-e79f-4c9a-7c6a-08dc5e2fb4c8
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 16:10:17.0857
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xC4oWDf84az9im+eLeAdzzZsf1Y+4ISswBaTFsMKWiyPy4u8g7tw2woFWcptml/HSXoIQWoeZT6n4v3M6LjWJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7181



On 4/16/24 01:03, Dan Williams wrote:
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
> 
> I expect this needs to be a callback into the provider ops because one
> of the other use cases for this visibility check is to get rid of the
> "extra" attributes and handle that visibility with the same mechanism.

Yes, worked through on the other thread.

But the "extra" attributes are likely to remain visible if we go in the 
group visibility direction, to provide compatibility.

Thanks,
Tom


