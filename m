Return-Path: <linux-kernel+bounces-55494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 56B8184BD62
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 19:50:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94E311F276BE
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 18:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD8021B806;
	Tue,  6 Feb 2024 18:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DYl99hDJ"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2082.outbound.protection.outlook.com [40.107.92.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8613A1B7F7
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 18:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707245289; cv=fail; b=a9Q92hv/a15XVeyH0ptSZqw0BSlBHMm8j9XEySh+cMYIV0nILEvqkB8sbJhMLAU1O51ViqXe6o386KJlEiy/i186Rv4Yys9R1lvmAJJ9Q2C8/sUWxaA3gu1vem2xpGtubidZwL5HsOgQqRFjNjahJ3Nh/kGSCb4AtFy2tWfah2A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707245289; c=relaxed/simple;
	bh=C+0J31TaGbPupLTHliL5nzQT80bcg9yKQJnrA/Jo95M=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fk20SlW81+6GuqwwBfvQAKQEv7Y+d0FBHNPZav9sEnh8xfsPk+dK8R+YWP5FJcrKyLcG1GQ0jclJRNaKD7iPAAn7oKrmeGjqn64p3eAtT1aiXVA9eAGfj0W1Gi14HulDQhNnbAUjyFCb6uzekzET5bPg3h6KKj/19hMgPpRHw+s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DYl99hDJ; arc=fail smtp.client-ip=40.107.92.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mv/h31lNU6EWXAaGJhLuQMU27nb2wUqnY3ZiwQ1o2al4zaBZFFYI8iWlvJNGl2jzBCu9+vcTDHrVNYRFWzVzVxUrf8JzD7uInhEq8IZHc91HFwrq0Fpo6NlEefeuaM3giAcQwFC+HGAfCLctPToQYOkBSTue2w19ii30HlNDJFHVLo2Aff5rygkd7/E445+PCz4TEEuVncgBGgASbhaRYWeDdtKRXwQLazNkRiKzrdeEmAuW0xpZRu7d+eXBAVgbM/S8+sp56SX1OLUGnO6ObvUt55O/g/BgiigI8h0BBrJ7nRPSAckFHgCKeMoXXV4INJRvECKAyWLOldLcaCy9cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Pm1U9ses5zsqztbaDV6IMV1pnFFIDa4DlD1OsVNSRg=;
 b=JflY12XzQWxnld8ehUdoSVYWwGpjPUePBkrzpK7MqdSXjbxW3NxJhmN1fKPrp4jCodLdA5a++tKtsjW5N3/mdu5YQqg6JgZgsLmRl1y9fAWCLnaZRTjakscij2xrzeJo4bPcIOXDqUWAQhkJ0Md+VUmnHx+4Y6b12ZOZ2Jv3pVzQSw0+hVAPWnzj8GjsmyMbCf//ioweHI1Bg9OlfdmjqUiy8zJRN78MxacRiXllWDM0Vpeif/yJjTC25Yim5d+eiDasL01ZrzSyOJ3nJizA5aVihri6pSGgvn8D84YHS3I5/pRPY54MNEwF4v/TGOHC8IlNC9qQfhyZx7iMsqt5SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Pm1U9ses5zsqztbaDV6IMV1pnFFIDa4DlD1OsVNSRg=;
 b=DYl99hDJMKP6fCWB4XzjgVkMsytF5QjdSptqBtovrWyXV2jwi1p15HMXIS3xe85oaK6zeabQMLXqrBFYiU5fY0S3LIoWF9GKO13pyqGY4tr2Qu0NFRdf0hXHvrsrZpv0zbJ6xpoYuzsqKyR/DA4VQl0S1TG5pmW67qwU+VHm0hc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17)
 by SA1PR12MB8967.namprd12.prod.outlook.com (2603:10b6:806:38b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.15; Tue, 6 Feb
 2024 18:48:03 +0000
Received: from BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::200:c1d0:b9aa:e16c]) by BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::200:c1d0:b9aa:e16c%4]) with mapi id 15.20.7270.016; Tue, 6 Feb 2024
 18:48:03 +0000
Message-ID: <afabdd17-7f1e-4d8c-a7c2-dbbbb230fccf@amd.com>
Date: Tue, 6 Feb 2024 12:48:00 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/11] x86/sev: Extend the config-fs attestation support
 for an SVSM
To: Dan Williams <dan.j.williams@intel.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Michael Roth <michael.roth@amd.com>,
 Ashish Kalra <ashish.kalra@amd.com>
References: <cover.1706307364.git.thomas.lendacky@amd.com>
 <10637f104d1ed7f21e281a4890f2c549d1e85985.1706307364.git.thomas.lendacky@amd.com>
 <65bc95732df26_65b2629448@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Language: en-US
From: Tom Lendacky <thomas.lendacky@amd.com>
Autocrypt: addr=thomas.lendacky@amd.com; keydata=
 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
 vFkWitqCJg==
In-Reply-To: <65bc95732df26_65b2629448@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR13CA0018.namprd13.prod.outlook.com
 (2603:10b6:5:bc::31) To BL1PR12MB5732.namprd12.prod.outlook.com
 (2603:10b6:208:387::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5732:EE_|SA1PR12MB8967:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cd8a02d-a3f2-41ed-040f-08dc274425f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	szGGVA8XCH2FaGjbPKj75E+Z7tpePWW4wLlswgqpqDYK7cTc0UcYIxj8bQetM1tzt2rqadQq9mQmAWKr6swYYPmlb861K2oX/UhADWD/9GRoXiiMTK2rdTkzFL+0sMLreWxIr5kfwuTi2K7MmuEEzSrWW0MgqoC0Xqvz37Afjjs3iiDX+0qxL8XysvVL0Npvaojd4DsroxJcnz1l8ShUecggTvszBNHaHR0FDHivJELnJzhUwbpH3S4fd7rixjH/MbL5x8L0Mv5Fu52IiUzDIr3GEuu7hPgDIPfXV+BNP3eFBgjkFJUR0CB/Ws/GOGr41nZh6mAUU0uG5xJFEjl4TgpP8Qo6NQG3aigVjMGtTWJRPVXC43/KaYbCvBlKoKWDMM12NA/RXPbGdo1KaFxbwk2DnVG8XuBJjn+BJ8OTQ1SZt5eGwEzWPsY8hwJ49U82g+yw7jnpDOoCTkiZg4g98WdDIoFfsL0kNI5j5wwbVyK9w2ZFT33tHn2vBjwp9awiwCOlR+x8QidGQ2Q+g+qg2wxBHS1QSdBII9ykS6c7xZmGQ5K1hmY803iApCTRIYkj52Yy/zC96GsBj9gYLWkhQvBZu5L1H0bmH0WpWS1r1S5zI8Hp8A3HyWHuqBVHmf+GqxY8vPZ60v500cGVZCRSNA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5732.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(346002)(39860400002)(136003)(376002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(26005)(83380400001)(8676002)(38100700002)(4326008)(66556008)(7416002)(8936002)(30864003)(5660300002)(54906003)(66946007)(316002)(2616005)(66476007)(6506007)(53546011)(2906002)(6486002)(478600001)(6512007)(966005)(86362001)(31696002)(36756003)(41300700001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VHNmM2UzWjJvUGFxbW9HQmQ5SCtKcHRtVUVDZjhhcUthT09EMDkraXRqbm1Q?=
 =?utf-8?B?c0YrK2RoQTREb0VCTWF0SWgxTFRKSUNCZ0F1Mmt5dHh4Y1JRdlg1dXVvdTV3?=
 =?utf-8?B?VFFEOStBd0xreG0xNkw4UHAvVVZjWUlGK3ZGMlY4a1pYdVgxQTNjWVN1Uzlm?=
 =?utf-8?B?Tko3R0o0d3IwZFRuY1greWNKR2hsT2dreU5XUnhmY2VkMUZWM0VxdVhUUnpR?=
 =?utf-8?B?VWlGek9yWVhSUzYrMEhJeDFpZkhSZVBUelNHR1BJRjhra1kzSG1uSTlBNHFR?=
 =?utf-8?B?YVV2Y2xhMkhSY3lWcE16WU95SW4ybW9mcHRmOXhVbWFqSWNpamtPVDk1WEVH?=
 =?utf-8?B?YUtmWXFMQUdHTzBodVVnS01KWVBmUkliTUpyOHdPNTJVTHhaNXJZMk82aXpr?=
 =?utf-8?B?SzRFd0RaTitYclFWaURnaDlTcHFPVVh3dUQvcGEyQ0F2R00yeXNQYW5aaWFp?=
 =?utf-8?B?YWZqVEZYUXF4VE9CekRYNGVGWVZXbmVUUk44WkZFWHYyTzdnTk90dktDYldB?=
 =?utf-8?B?MFZaazVnVnc0aHF6L0NSZjNNc2FvcWd0cGw1eHZYeUdqTTBwWkZCWGt2SGdn?=
 =?utf-8?B?SE5vOG5wVzFrWkNOSFo2SWVWR1RrYVFzVGlGMVpnQ055V3IwbWtNRiszYWZU?=
 =?utf-8?B?WVpGUXBUbExNMTBoTGZMbVg3akdmeEJhRWxXMzhDTm5VckJiYmE2RDdzNlkw?=
 =?utf-8?B?dHpDdHc4TVM4ODFYQmJoSUpPNTIwcDRtUlN5d0ZoNVJUMFJTYXhSWmxaY0Nj?=
 =?utf-8?B?U09OTFQwVmpYRDlReC9qZVdyVFI5NHZobTB1aEx5NmxiaTRpWXI4VmVnbjRu?=
 =?utf-8?B?ZDlHOW9aY2c4UW9zcjhHcHd2amx4akZaTkpXS0N6V3g1eU84MGV4Rklidno1?=
 =?utf-8?B?NytWVGZnUE1WVGc1SnBBNEVUYTIvcHNyQ2ErcmE3T2hsK3o2U25rSEd3dlJp?=
 =?utf-8?B?WlhlbnFhSDdrMFpUUUJnckxVU3pjNjhpQ0tlV0Q4MFNzVFdpTGlnNVVjb0sr?=
 =?utf-8?B?YUNGbXFoWHZCaUkrRUZLWFB3RVlpL0YvZ1RFekpjREM2Zys3Qk9vQ3BKSm5z?=
 =?utf-8?B?V29telZvcjZ4VkVVSVVTUFE4SUZaZDRkaERpYzhkTGJCRExKRFVuOGRJTXdn?=
 =?utf-8?B?Ulp6bVVmSU14ak5SVSttM3VDQTFQZXlTSmZlK21xUzJibGw5MXF5a3A5NFhI?=
 =?utf-8?B?Ny9pcTN1QlJZbFJBd3NtYUdFTkhYZlVSVmh1bTVyT0tnYWIzWUhrYUhpZUI5?=
 =?utf-8?B?R2plbkpleEhxcGhPRmpTbkJSbjBIWGp2TnBNa2ZocGdyY0cvdkVrUUlTK0Fo?=
 =?utf-8?B?WURxZFBTYkVKOWNjcEJYSXVIUERSSG1HSERJYTlzTnJvc3U5M0R3YkQ5aHBm?=
 =?utf-8?B?YktOblpiY3phQlJDemNSV2FWUXZuM005TmNuOVgyU1QrSEplYno0dEFkSEhZ?=
 =?utf-8?B?aVpHSFo3RzNIZGJNRXFLWHFzRUF0Ykkyc1phVTZsSG9FazdJMXNjczd3N1Ax?=
 =?utf-8?B?RzdwT0hoZUtMUWdhR3FYZmkzWFR5WVdoKy9WVmdTU0VPTVVBeXVzQ2ttQzRQ?=
 =?utf-8?B?SWhHVVpYOXE2L0xSUDBKU2h1NENhbzdJSHlyb2xHWmI5ajZRRElSTVNXcklY?=
 =?utf-8?B?UVR3cmFvWDV3N3NTT2UrMFBZblBzdEhxVGIrend1Y0tQT01BN01VN3NzdWFY?=
 =?utf-8?B?R1hITFY5V3F3Qzl5MVU0U1NmZ2hIdnQvNTc1dUZsZlI3bTNrS1BvN0lVYmJt?=
 =?utf-8?B?Z3lRcVo4YUZhdDhtNkovMXMwa3c0aGs3cUVCQlFIQUdRcVJOUXN0R2ZDUjNQ?=
 =?utf-8?B?Um1mTXNnTHczYWZmU2JwZGNkQjVybWRvNVl1SXFXZHpuTE9YUGJGaEtyK1pr?=
 =?utf-8?B?V3NCcFZ4TWN5V0M5SzN5RC85eDhjVkxtVXRiSll0UEZ1NE1NSkEreUl3STVo?=
 =?utf-8?B?N1JWY0J6VUYxTkx0SGNSa2hqWjNzbkp6Wnhib0ZybEJscmhDbVFFcjczR1Bm?=
 =?utf-8?B?Z1hwOW93cmlidXpGVzBuTFdteGFMaVBuTjh5YmZvT043QTdVRVlXWGhvT2s2?=
 =?utf-8?B?emFaMHdjUFNuc0VFaHRRMGNpcnFhR1lEL1cwbGVjVjExbXgxcHE1amtpaEZ4?=
 =?utf-8?Q?qgjNF2G5ecivMyzLhQcjxEFRx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cd8a02d-a3f2-41ed-040f-08dc274425f6
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 18:48:02.9368
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /QQhXfncSuL81XN7IpFlKVK+b7FOQfQBnjKcMPslQ/LtDaHosS2tpIsuQG2wZRw5P35Q6UJqjU+FVhwNd6dl1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8967

On 2/2/24 01:10, Dan Williams wrote:
> Tom Lendacky wrote:
>> When an SVSM is present, the guest can also request attestation reports
>> from the SVSM. These SVSM attestation reports can be used to attest the
>> SVSM and any services running within the SVSM.
>>
>> Extend the config-fs attestation support to allow for an SVSM attestation
>> report. This involves creating four (4) new config-fs attributes:
>>
>>    - 'svsm' (input)
>>      This attribute is used to determine whether the attestation request
>>      should be sent to the SVSM or to the SEV firmware.
>>
>>    - 'service_guid' (input)
>>      Used for requesting the attestation of a single service within the
>>      SVSM. A null GUID implies that the SVSM_ATTEST_SERVICES call should
>>      be used to request the attestation report. A non-null GUID implies
>>      that the SVSM_ATTEST_SINGLE_SERVICE call should be used.
>>
>>    - 'service_version' (input)
>>      Used with the SVSM_ATTEST_SINGLE_SERVICE call, the service version
>>      represents a specific service manifest version be used for the
>>      attestation report.
>>
>>    - 'manifestblob' (output)
>>      Used to return the service manifest associated with the attestation
>>      report.
>>
>> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
>> ---
>>   Documentation/ABI/testing/configfs-tsm  |  55 ++++++++++
>>   arch/x86/include/asm/sev.h              |  31 +++++-
>>   arch/x86/kernel/sev.c                   |  50 +++++++++
>>   drivers/virt/coco/sev-guest/sev-guest.c | 137 ++++++++++++++++++++++++
>>   drivers/virt/coco/tsm.c                 |  95 +++++++++++++++-
>>   include/linux/tsm.h                     |  11 ++
>>   6 files changed, 376 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/ABI/testing/configfs-tsm b/Documentation/ABI/testing/configfs-tsm
>> index dd24202b5ba5..c5423987d323 100644
>> --- a/Documentation/ABI/testing/configfs-tsm
>> +++ b/Documentation/ABI/testing/configfs-tsm
>> @@ -31,6 +31,21 @@ Description:
>>   		Standardization v2.03 Section 4.1.8.1 MSG_REPORT_REQ.
>>   		https://www.amd.com/content/dam/amd/en/documents/epyc-technical-docs/specifications/56421.pdf
>>   
>> +What:		/sys/kernel/config/tsm/report/$name/manifestblob
>> +Date:		January, 2024
>> +KernelVersion:	v6.9
>> +Contact:	linux-coco@lists.linux.dev
>> +Description:
>> +		(RO) Optional supplemental data that a TSM may emit, visibility
>> +		of this attribute depends on TSM, and may be empty if no
>> +		manifest data is available.
>> +
>> +		When @provider is "sev_guest" and the "svsm" attribute is set
>> +		this file contains the service manifest used for the SVSM
>> +		attestation report from Secure VM Service Module for SEV-SNP
>> +		Guests v1.00 Section 7.
>> +		https://www.amd.com/content/dam/amd/en/documents/epyc-technical-docs/specifications/58019.pdf
> 
> I wish configfs had better dynamic visibility so that this could be
> hidden when not active... oh well.

So do I. I played with the idea of having two different structs and 
registering one or the other based on whether an SVSM was present. Thoughts?

> 
>> +
>>   What:		/sys/kernel/config/tsm/report/$name/provider
>>   Date:		September, 2023
>>   KernelVersion:	v6.7
>> @@ -80,3 +95,43 @@ Contact:	linux-coco@lists.linux.dev
>>   Description:
>>   		(RO) Indicates the minimum permissible value that can be written
>>   		to @privlevel.
>> +
>> +What:		/sys/kernel/config/tsm/report/$name/svsm
>> +Date:		January, 2024
>> +KernelVersion:	v6.9
>> +Contact:	linux-coco@lists.linux.dev
>> +Description:
>> +		(WO) Attribute is visible if a TSM implementation provider
>> +		supports the concept of attestation reports for TVMs running
>> +		under an SVSM, like SEV-SNP. Specifying any non-zero value
> 
> Just use kstrtobool just to have a bit more form to it, and who knows
> maybe keeping some non-zero numbers reserved turns out useful someday.
> 
> ...or see below, maybe this shouldn't be an "svsm" flag.
> 
>> +		implies that the attestation report should come from the SVSM.
>> +		Secure VM Service Module for SEV-SNP Guests v1.00 Section 7.
>> +		https://www.amd.com/content/dam/amd/en/documents/epyc-technical-docs/specifications/58019.pdf
> 
> So this affects the output format of outblob? I think @outblob should
> probably document the fact that it depends on @provider, @privlevel, and
> now @svsm. Probably all of the format links should live under @outblob
> not @provider.

It doesn't change the output format, it is still a standard SNP 
attestation report. What changes is that a SHA-512 hash of the nonce and 
the manifest are taken and passed as report data as opposed to just the 
nonce value.

> 
> I worry that "svsm" is not going to be the last name for a selected
> family of services that might convey something to outblob. I wonder if
> this should just be a generic "service" attribute where "svsm" is only
> supported value to write today. Another service family could be
> introduced later and reuse the service_guid concept, or kernel gets
> lucky and a de-facto standard heads off proliferation here.

I can work something up along that line and see what it looks like.

> 
>> +
>> +What:		/sys/kernel/config/tsm/report/$name/service_guid
>> +Date:		January, 2024
>> +KernelVersion:	v6.9
>> +Contact:	linux-coco@lists.linux.dev
>> +Description:
>> +		(WO) Attribute is visible if a TSM implementation provider
>> +		supports the concept of attestation reports for TVMs running
>> +		under an SVSM, like SEV-SNP. Specifying a empty or null GUID
>> +		(00000000-0000-0000-0000-000000) requests all active services
>> +		within the SVSM be part of the attestation report. Specifying
>> +		a non-null GUID requests an attestation report of just the
>> +		specified service using the manifest form specified by the
>> +		service_version attribute.
>> +		Secure VM Service Module for SEV-SNP Guests v1.00 Section 7.
>> +		https://www.amd.com/content/dam/amd/en/documents/epyc-technical-docs/specifications/58019.pdf
> 
> Given the small number of service GUIDs so far perhaps save someone the
> URL fetch and list it here?

I can do that. I'll put the currently defined one(s) along with the link.

> 
>> +
>> +What:		/sys/kernel/config/tsm/report/$name/service_version
>> +Date:		January, 2024
>> +KernelVersion:	v6.9
>> +Contact:	linux-coco@lists.linux.dev
>> +Description:
>> +		(WO) Attribute is visible if a TSM implementation provider
>> +		supports the concept of attestation reports for TVMs running
>> +		under an SVSM, like SEV-SNP. Indicates the service manifest
>> +		version requested for the attestation report.
>> +		Secure VM Service Module for SEV-SNP Guests v1.00 Section 7.
>> +		https://www.amd.com/content/dam/amd/en/documents/epyc-technical-docs/specifications/58019.pdf
> 
> Perhaps document that version 1 is assumed and is always compatible?

Can do.

> 
> What prompts new versions and how does that discovered by guest software?

New versions will depend on the service that is running. Changes or 
updates to that service would document the new versions manifest output.
There isn't currently a discoverable way other than calling with the 
requested version and seeing if an error is returned.

A possible extension to the SVSM attestation protocol could create a 
version query call.

> 
>> diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
>> index b126e50a1358..4cafa92d1d3e 100644
>> --- a/arch/x86/include/asm/sev.h
>> +++ b/arch/x86/include/asm/sev.h
>> @@ -194,6 +194,27 @@ struct svsm_pvalidate_call {
>>   	struct svsm_pvalidate_entry entry[];
>>   };
>>   
>> +/*
>> + * The SVSM Attestation related structures
>> + */
>> +struct svsm_location_entry {
>> +	u64 pa;
>> +	u32 len;
>> +	u8 rsvd[4];
>> +};
>> +
>> +struct svsm_attestation_call {
>> +	struct svsm_location_entry report_buffer;
>> +	struct svsm_location_entry nonce;
>> +	struct svsm_location_entry manifest_buffer;
>> +	struct svsm_location_entry certificates_buffer;
>> +
>> +	/* For attesting a single service */
>> +	u8 service_guid[16];
>> +	u32 service_version;
>> +	u8 rsvd[4];
>> +};
>> +
>>   /*
>>    * SVSM protocol structure
>>    */
>> @@ -217,6 +238,10 @@ struct svsm_call {
>>   #define SVSM_CORE_CREATE_VCPU		2
>>   #define SVSM_CORE_DELETE_VCPU		3
>>   
>> +#define SVSM_ATTEST_CALL(x)		((1ULL << 32) | (x))
>> +#define SVSM_ATTEST_SERVICES		0
>> +#define SVSM_ATTEST_SINGLE_SERVICE	1
>> +
>>   #ifdef CONFIG_AMD_MEM_ENCRYPT
>>   extern void __sev_es_ist_enter(struct pt_regs *regs);
>>   extern void __sev_es_ist_exit(void);
>> @@ -287,6 +312,7 @@ void snp_set_wakeup_secondary_cpu(void);
>>   bool snp_init(struct boot_params *bp);
>>   void __init __noreturn snp_abort(void);
>>   int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input, struct snp_guest_request_ioctl *rio);
>> +int snp_issue_svsm_attestation_request(u64 call_id, struct svsm_attestation_call *input);
>>   void snp_accept_memory(phys_addr_t start, phys_addr_t end);
>>   u64 snp_get_unsupported_features(u64 status);
>>   u64 sev_get_status(void);
>> @@ -316,7 +342,10 @@ static inline int snp_issue_guest_request(u64 exit_code, struct snp_req_data *in
>>   {
>>   	return -ENOTTY;
>>   }
>> -
>> +static inline int snp_issue_svsm_attestation_request(u64 call_id, struct svsm_attestation_call *input)
>> +{
>> +	return -ENOTTY;
>> +}
>>   static inline void snp_accept_memory(phys_addr_t start, phys_addr_t end) { }
>>   static inline u64 snp_get_unsupported_features(u64 status) { return 0; }
>>   static inline u64 sev_get_status(void) { return 0; }
>> diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
>> index 849df3aae4e1..83bc5efa8fcf 100644
>> --- a/arch/x86/kernel/sev.c
>> +++ b/arch/x86/kernel/sev.c
>> @@ -2378,6 +2378,56 @@ static int __init init_sev_config(char *str)
>>   }
>>   __setup("sev=", init_sev_config);
>>   
>> +static void update_attestation_input(struct svsm_call *call, struct svsm_attestation_call *input)
>> +{
>> +	/* If (new) lengths have been returned, propograte them up */
>> +	if (call->rcx_out != call->rcx)
>> +		input->manifest_buffer.len = call->rcx_out;
>> +
>> +	if (call->rdx_out != call->rdx)
>> +		input->certificates_buffer.len = call->rdx_out;
>> +
>> +	if (call->r8_out != call->r8)
>> +		input->report_buffer.len = call->r8_out;
>> +}
>> +
>> +int snp_issue_svsm_attestation_request(u64 call_id, struct svsm_attestation_call *input)
>> +{
>> +	struct svsm_attestation_call *attest_call;
>> +	struct svsm_call call = {};
>> +	unsigned long flags;
>> +	u64 attest_call_pa;
>> +	int ret;
>> +
>> +	if (!vmpl)
>> +		return -EINVAL;
>> +
>> +	local_irq_save(flags);
>> +
>> +	call.caa = __svsm_get_caa();
>> +
>> +	attest_call = (struct svsm_attestation_call *)call.caa->svsm_buffer;
>> +	attest_call_pa = __svsm_get_caa_pa() + offsetof(struct svsm_ca, svsm_buffer);
>> +
>> +	memcpy(attest_call, input, sizeof(*attest_call));
> 
> *attest_call = *input? Just to save that little bit of reviewer
> brainpower wondering if these things are the same type and size?

Ok.

> 
>> +
>> +	/*
>> +	 * Set input registers for the request and set RDX and R8 to known
>> +	 * values in order to detect length values being returned in them.
>> +	 */
>> +	call.rax = call_id;
>> +	call.rcx = attest_call_pa;
>> +	call.rdx = -1;
>> +	call.r8 = -1;
>> +	ret = svsm_protocol(&call);
>> +	update_attestation_input(&call, input);
>> +
>> +	local_irq_restore(flags);
>> +
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(snp_issue_svsm_attestation_request);
>> +
>>   int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input, struct snp_guest_request_ioctl *rio)
>>   {
>>   	struct ghcb_state state;
>> diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
>> index 1ff897913bf4..3693373c4227 100644
>> --- a/drivers/virt/coco/sev-guest/sev-guest.c
>> +++ b/drivers/virt/coco/sev-guest/sev-guest.c
>> @@ -783,6 +783,140 @@ struct snp_msg_cert_entry {
>>   	u32 length;
>>   };
>>   
>> +static int sev_svsm_report_new(struct tsm_report *report, void *data)
>> +{
>> +	unsigned int report_len, manifest_len, certificates_len;
>> +	void *report_blob, *manifest_blob, *certificates_blob;
>> +	struct svsm_attestation_call attest_call = {};
>> +	struct tsm_desc *desc = &report->desc;
>> +	unsigned int size;
>> +	bool try_again;
>> +	void *buffer;
>> +	u64 call_id;
>> +	int ret;
>> +
>> +	/*
>> +	 * Allocate pages for the request:
>> +	 * - Report blob (4K)
>> +	 * - Manifest blob (4K)
>> +	 * - Certificate blob (16K)
>> +	 *
>> +	 * Above addresses must be 4K aligned
>> +	 */
>> +	report_len = SZ_4K;
>> +	manifest_len = SZ_4K;
>> +	certificates_len = SEV_FW_BLOB_MAX_SIZE;
>> +
>> +retry:
>> +	size = report_len + manifest_len + certificates_len;
>> +	buffer = alloc_pages_exact(size, __GFP_ZERO);
>> +	if (!buffer)
>> +		return -ENOMEM;
>> +
>> +	report_blob = buffer;
>> +	attest_call.report_buffer.pa = __pa(report_blob);
>> +	attest_call.report_buffer.len = report_len;
>> +
>> +	manifest_blob = report_blob + report_len;
>> +	attest_call.manifest_buffer.pa = __pa(manifest_blob);
>> +	attest_call.manifest_buffer.len = manifest_len;
>> +
>> +	certificates_blob = manifest_blob + manifest_len;
>> +	attest_call.certificates_buffer.pa = __pa(certificates_blob);
>> +	attest_call.certificates_buffer.len = certificates_len;
>> +
>> +	attest_call.nonce.pa = __pa(desc->inblob);
>> +	attest_call.nonce.len = desc->inblob_len;
>> +
>> +	if (guid_is_null(&desc->service_guid)) {
>> +		call_id = SVSM_ATTEST_CALL(SVSM_ATTEST_SERVICES);
>> +	} else {
>> +		export_guid(attest_call.service_guid, &desc->service_guid);
>> +		attest_call.service_version = desc->service_version;
>> +
>> +		call_id = SVSM_ATTEST_CALL(SVSM_ATTEST_SINGLE_SERVICE);
>> +	}
>> +
>> +	ret = snp_issue_svsm_attestation_request(call_id, &attest_call);
>> +	switch (ret) {
>> +	case SVSM_SUCCESS:
>> +		break;
>> +	case SVSM_ERR_INVALID_PARAMETER:
>> +		try_again = false;
>> +
>> +		if (attest_call.report_buffer.len > report_len) {
>> +			report_len = PAGE_ALIGN(attest_call.report_buffer.len);
>> +			try_again = true;
>> +		}
>> +
>> +		if (attest_call.manifest_buffer.len > manifest_len) {
>> +			manifest_len = PAGE_ALIGN(attest_call.manifest_buffer.len);
>> +			try_again = true;
>> +		}
>> +
>> +		if (attest_call.certificates_buffer.len > certificates_len) {
>> +			certificates_len = PAGE_ALIGN(attest_call.certificates_buffer.len);
>> +			try_again = true;
>> +		}
>> +
>> +		/* If one of the buffers wasn't large enough, retry the request */
>> +		if (try_again) {
>> +			free_pages_exact(buffer, size);
>> +			goto retry;
> 
> Is this expected to ever go past 1 retry? Fail after that? It would seem
> suspicious if the untrusted host kept asking the guest to allocate more
> and more memory. Is there a reasonable max that can be applied to those
> buffers?

The report buffer and manifest buffer should be fixed after boot, but the 
certs buffer could be dynamic. But I wouldn't expect that the provider is 
updating the certs that often.

I can put a maximum retry counter in place here, with 3 attempts seeming 
reasonable.

> 
>> +		}
>> +
>> +		ret = -EINVAL;
>> +		goto error;
>> +	case SVSM_ERR_BUSY:
>> +		ret = -EAGAIN;
>> +		goto error;
>> +	default:
>> +		pr_err_ratelimited("SVSM attestation request failed (%#x)\n", ret);
>> +		ret = -EINVAL;
>> +		goto error;
>> +	}
>> +
>> +	ret = -ENOMEM;
>> +
>> +	report_len = attest_call.report_buffer.len;
>> +	void *rbuf __free(kvfree) = kvzalloc(report_len, GFP_KERNEL);
>> +	if (!rbuf)
>> +		goto error;
>> +
>> +	memcpy(rbuf, report_blob, report_len);
>> +	report->outblob = no_free_ptr(rbuf);
>> +	report->outblob_len = report_len;
>> +
>> +	manifest_len = attest_call.manifest_buffer.len;
>> +	void *mbuf __free(kvfree) = kvzalloc(manifest_len, GFP_KERNEL);
>> +	if (!mbuf)
>> +		goto error;
>> +
>> +	memcpy(mbuf, manifest_blob, manifest_len);
>> +	report->manifestblob = no_free_ptr(mbuf);
>> +	report->manifestblob_len = manifest_len;
>> +
>> +	certificates_len = attest_call.certificates_buffer.len;
>> +	if (!certificates_len)
>> +		goto success;
>> +
>> +	void *cbuf __free(kvfree) = kvzalloc(certificates_len, GFP_KERNEL);
>> +	if (!cbuf)
>> +		goto error;
>> +
>> +	memcpy(cbuf, certificates_blob, certificates_len);
>> +	report->auxblob = no_free_ptr(cbuf);
>> +	report->auxblob_len = certificates_len;
>> +
>> +success:
>> +	ret = 0;
>> +
>> +error:
>> +	free_pages_exact(buffer, size);
> 
> I was going to comment that mixing goto and cleanup.h helpers can be a
> recipe for confusion, but this looks clean to me.
> 
>> +
>> +	return ret;
>> +}
>> +
>>   static int sev_report_new(struct tsm_report *report, void *data)
>>   {
>>   	struct snp_msg_cert_entry *cert_table;
>> @@ -797,6 +931,9 @@ static int sev_report_new(struct tsm_report *report, void *data)
>>   	if (desc->inblob_len != SNP_REPORT_USER_DATA_SIZE)
>>   		return -EINVAL;
>>   
>> +	if (desc->svsm)
>> +		return sev_svsm_report_new(report, data);
>> +
>>   	void *buf __free(kvfree) = kvzalloc(size, GFP_KERNEL);
>>   	if (!buf)
>>   		return -ENOMEM;
>> diff --git a/drivers/virt/coco/tsm.c b/drivers/virt/coco/tsm.c
>> index d1c2db83a8ca..33fa26406bc6 100644
>> --- a/drivers/virt/coco/tsm.c
>> +++ b/drivers/virt/coco/tsm.c
>> @@ -35,7 +35,7 @@ static DECLARE_RWSEM(tsm_rwsem);
>>    * The attestation report format is TSM provider specific, when / if a standard
>>    * materializes that can be published instead of the vendor layout. Until then
>>    * the 'provider' attribute indicates the format of 'outblob', and optionally
>> - * 'auxblob'.
>> + * 'auxblob' and 'manifestblob'.
>>    */
>>   
>>   struct tsm_report_state {
>> @@ -48,6 +48,7 @@ struct tsm_report_state {
>>   enum tsm_data_select {
>>   	TSM_REPORT,
>>   	TSM_CERTS,
>> +	TSM_MANIFEST,
>>   };
>>   
>>   static struct tsm_report *to_tsm_report(struct config_item *cfg)
>> @@ -119,6 +120,77 @@ static ssize_t tsm_report_privlevel_floor_show(struct config_item *cfg,
>>   }
>>   CONFIGFS_ATTR_RO(tsm_report_, privlevel_floor);
>>   
>> +static ssize_t tsm_report_svsm_store(struct config_item *cfg,
>> +				     const char *buf, size_t len)
>> +{
>> +	struct tsm_report *report = to_tsm_report(cfg);
>> +	unsigned int val;
>> +	int rc;
>> +
>> +	rc = kstrtouint(buf, 0, &val);
>> +	if (rc)
>> +		return rc;
>> +
>> +	guard(rwsem_write)(&tsm_rwsem);
>> +	rc = try_advance_write_generation(report);
>> +	if (rc)
>> +		return rc;
>> +	report->desc.svsm = !!val;
>> +
>> +	return len;
>> +}
>> +CONFIGFS_ATTR_WO(tsm_report_, svsm);
> 
> Modulo whether this should become "service" per above the rest of the
> configfs interface changes look good to me.

Let me re-work it for the next version and see how it all looks.

Thanks,
Tom


