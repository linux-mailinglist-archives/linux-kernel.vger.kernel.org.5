Return-Path: <linux-kernel+bounces-131935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 047AB898DB7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 20:07:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8504A1F2C30C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 18:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBFB412FB2C;
	Thu,  4 Apr 2024 18:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="smX67zve"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2115.outbound.protection.outlook.com [40.107.94.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF170CA62;
	Thu,  4 Apr 2024 18:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712254064; cv=fail; b=jt1hBcpmyvZm+cri1maD6DmV6Q5Ic3FuwYZZi/JLW+mo6P3ms/ZhV2zz9NdKPBUd25wR9yZsFxiKIOy/o080XzPTqP9JnTV7xVzpqbfHD9ocNG30/yAcYz/c029IS2SBY8O0ZhMEwOcc6hmbMJ10lmzZs238Udnr0jwNTDvK7rQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712254064; c=relaxed/simple;
	bh=rTlubs71Uz0/Cd2e7GY5yyS0FzxRO6rcwUwXMArGz6o=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QsrDBHAkpxYTZTAVtLAo58YLcoLLrCdKmOH8yE9T7gJrT1xlPwu6gNudRYXprXu5gohj4IooFAmqqImeAOd7LqioQjv35NXr12CR4R1b2iWTY6kULJH80cAKV38b7moOTonct6pskZXHOaQcsfEaW4CP/qRRV4QhjHy6IrTmKfU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=smX67zve; arc=fail smtp.client-ip=40.107.94.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RQdG9AbJh1uBCVagPupw632H7usdsCcaAV+THtEe07+LB9kHGpjAwGLe70bqwlQok8Q0Ftvh6Q0IqwjopnENS/pZG/Xh2b5tRgyctndSTE2xmnZOuv0QyekTX6aVOKgLJgPRnnjaYW+FHghJuxAzT6pPTt8C3jRSzpwcbtYsstGWCpNX9L/zEGuzhEFpVhSl+Jml0GT+R/zuwEp3GJa+ox7NoTuH1KDMx+9wmiriJO4LkhDiEiIZkpHcJBgjuNr0j4/1ex3DXLFDlTwwsQYP9pM9GGmecit79BZ0tZ4uIGIVhI5TcEM1uREJxTR3nCWdgQJ1Yiy4XSfdXeiZwW3OhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yF6E1NYNQGVJKGB+5oVsNOOVfED1n29mJI5Wvfd62bs=;
 b=I7QsNXQ+Tw9YHgvPghS/I61V/37/o8uCKKDjocbo4Xf0LnVCsmPjPKGN5s+mCXplOKjWdyCA0KDGO8lAuUmO53EIEqpGVY5PJUnobZDAaKRWsZNZugaCQpRpAujxXjAiLuD88co/KGTayAoL2cmSQSLJhTwF42m3Z8DuhhEl0k0/Oq+kNqP9/oodCAymew6+wc7QcAv9HrSzMXFR88a/iOlJ4j13JZE8PICDNLvDk6dK1aq9p72OtAvmqN+annkHEH/p0gAps2NxhjfJ8IV5kDDClFuABpKeYSZ8WhzDaxPmIzHOWNn66pp41ccuRDvXg4mMFEYHXkb4btjj2vzfGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yF6E1NYNQGVJKGB+5oVsNOOVfED1n29mJI5Wvfd62bs=;
 b=smX67zvenLkANn3mUzayctZyp8WsVyQyh8G1qtGAw5o8AL4UJQ4qcam3EDkszuPSVLbFrLSjiUUei6Zl9GZROWo0kgwyA9SNr+hnxYkrbIk2lBieBw5MVVx48LaxPzXdk/Cd7fQACfslCuVnFPHAmzSYohquoSDFRu+8dXgnGac=
Received: from SN6PR12MB2767.namprd12.prod.outlook.com (2603:10b6:805:75::23)
 by SJ1PR12MB6122.namprd12.prod.outlook.com (2603:10b6:a03:45b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Thu, 4 Apr
 2024 18:07:39 +0000
Received: from SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::3cc5:f552:44ae:1f26]) by SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::3cc5:f552:44ae:1f26%7]) with mapi id 15.20.7409.042; Thu, 4 Apr 2024
 18:07:39 +0000
Message-ID: <0e8d1e33-f689-4dbe-8a16-3f4f582136ae@amd.com>
Date: Thu, 4 Apr 2024 13:07:37 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/sev: Apply RMP table fixups for kexec.
Content-Language: en-US
To: Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
Cc: Michael Roth <michael.roth@amd.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, linux-tip-commits@vger.kernel.org,
 bp@alien8.de, x86@kernel.org, linux-kernel@vger.kernel.org
References: <20240312184757.52699-1-Ashish.Kalra@amd.com>
 <b1822884-cba3-4009-d685-81a36dbb4353@amd.com>
 <b2da0a15-c0f5-49a7-b34c-eb408e9aa293@amd.com>
 <20240402224222.vxaqenqvyi32zleb@amd.com>
 <ff810b13-b534-4e4f-a2e2-3cdf2b563494@amd.com>
 <20240404081745.GA15636@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
From: "Kalra, Ashish" <ashish.kalra@amd.com>
In-Reply-To: <20240404081745.GA15636@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1P222CA0055.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2c1::7) To SN6PR12MB2767.namprd12.prod.outlook.com
 (2603:10b6:805:75::23)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR12MB2767:EE_|SJ1PR12MB6122:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	J0FYlRaosfxdv0FDfV2noDhb/Gd1u0v25xQ9EE3DuXTEk9X8U3XXHV5euA7vuweeuMQ79WqqqgJxjBUgaVMsZAQRxycK8wGbDEQFL0ufp6lY0Nvr2cOYHkv6cK9dMVUQ6zTjOFx3boJTlYlnr/Rl3PqMhXO2qrVt5g8ibpLtU7DHnt/CycVZjLNfN9IRSHo2/EF2TzxOKfDbSjksSKVacM9JfDVgCpCVblna0A4UreOU3EvAXePWEEvfiPtiTkbr6c7zo5CvoKZL9CDFVnonjTprT3didnll0MN8SDScwecpec30/dcpsYv2yQbmhYqrpCgyoJELOifQKyNm56poQkpw7zbOyiFFGZnTnKUeiP+0PTpp6QUwSgq1+SiGBt1Kv0aG+MBq+tQodwAzDvz74n/ikMXEPoPsbwjf3hmAQjYNE/NfolFWo8Xpl99e8Bf07Q5KZZumvt2eHL3/16o0VRDCCKUa1RR6CUDulB7ky/HZlZwilK68SNI2BrIL2SE9uNvsIVq3I92/m4ZuLF2Ls2nTsxSeb6iY9RSEFJ3GGdquBkS9I689xqFwbBK4draT24j4DAaVVgeTEpFGxaRBEF8ecT4Bc7LTEnhyJuNXz9PBNCjWxOUwuWWFGJ8oMb9f0ZycJfGtUSR6jWMwWGTTpu6LcEmo2+NbFlN4OxDYTAE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2767.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bXZTSm9ydWhhUzZjNXFwWjVwWlBKNndRaEVzL2NMQmI4T01zUW5IVjUzUjJo?=
 =?utf-8?B?aDI5UXZqbW1jVk9UemZLR29tSWxUMG84N3VlS1llWWkvZU1NWUYwckUwZ1Z6?=
 =?utf-8?B?bGJhT0Z1b2R1K2JuNkNHajNrbG1iWDNvZGhjdmZGam4yWGQ4M3pQUnllcDgr?=
 =?utf-8?B?UmsvUWMxUGRjN1BrVHJzdW1OU0wrMG91SzFnNkxBZUZDd0M1SDhMdUhXMkM0?=
 =?utf-8?B?SE1tOGNMcm56SFdZa2RZOWhoN2orSFpnVk01eStTdVdSNlhWck4zbW93UnVW?=
 =?utf-8?B?QVVtWk5sTDhqNW5SR05CR2N4U3psWEdxWlZBcVRIQlVoZGNmYWpka0M5Zldl?=
 =?utf-8?B?SzlCd2lFcWNpWVBQSTBEUjFXTUFGUUJpS05ZVHlPTHlCbFNJSERLbU96M1Ru?=
 =?utf-8?B?bUZtSHZnT3VmeUxSR2J6SjBUM1c3UXBSV1oySEdhUDRUZW00MHVTME9YRHVR?=
 =?utf-8?B?ZFJOaGdyRWp6QWtJQnc1TTdPdDBpMU9IajZoOFlEWlVPdDZwYWZ4bG94enlB?=
 =?utf-8?B?LzJIMk9EZ0hWcm1LaDdQUjk2TUdYNDU4U0ZGOG1ZUUcxQ2R0ZVRWRFo1NDJ1?=
 =?utf-8?B?Rmw0d2hVSjdvNXRxVGFCeEp4ZUlybk1FUDVmL0xMZkEzV01JT29EN2M0SE95?=
 =?utf-8?B?aUZrR3lyOTc2QWZvcGxCY1B0ZXI4WWtoZjBjUkR0c0RCWDA2R1UxN2ZqcUJT?=
 =?utf-8?B?U1Y2VXBaZHhWSWhVL0hDSmRsRTl5cjFHdG9JZDdFaUdlN0dMMU1NS1k2K2RP?=
 =?utf-8?B?UGk3UHRvNElrc3kyd1ZiL1pvNkFzdWpHM1BkNXgxQWxpdHJCKzQ3dWQ0MVY5?=
 =?utf-8?B?Yk56eHFZa2dJdXBJUlBoTjk2Z2JGUXJyaU5MOGN0R0hvQ3ZMa2I3SFBxc256?=
 =?utf-8?B?SisybmNKbkxjTFBoTUVYa2U4enRnY0xCQjJJYmg2OEhlWmY2QTNYTWRtNnBt?=
 =?utf-8?B?Rm14MXMxTXpFMWpnb0xVaklDK0pnOXhVREYrcStHMmRZQ2VTVmp4c0ZOVTVE?=
 =?utf-8?B?NnhSb3F0NHFPeEcyMjNxK3RibzZrcXRCbWlQZHpmMklLKy9EOEo2ekdPZitO?=
 =?utf-8?B?R20vc3BxVG5HUktnb3BPZXpoWEpITGRFZmQrT2YwTlIxRkU5Y3NGZ01JNWF4?=
 =?utf-8?B?S0xub3BvS1o0aHAyTUFJU1dRTXptOE0vaHZrZ1lNTDk0OGRiV0lHNGtHc3p2?=
 =?utf-8?B?dTE0dlZwRE5DVnlqVWM4RUhkRjBQdUIrRDlDb29VczA4amw0UzFYQXh3SFJI?=
 =?utf-8?B?MWVGbHNMYmdGOFc2bjAxNldKY2IrMmNWS1hHcUFYQlFqOUNyVG5aRythR21N?=
 =?utf-8?B?UFlIeHFZenhEbzFiLzlWaHBMTDlRZ0tNN1JoOFZzSlhtWGRpaXhqbXRkTkU4?=
 =?utf-8?B?NzhxQzVwdVpsdE1hWmZkY0ZjYm16SThQYkJUL2cwYzF1anZOdlRaaGJ5RDlQ?=
 =?utf-8?B?ZjlBR3RqekFnczdxNHpuNzVOWWJOSXMxRWlNUzV6WDVya1V3aUNzTy9jUTlz?=
 =?utf-8?B?c09UY3ZIaHVLeUFVMWRqQTk5VVhQUHI3Tk9qUTA4SmpzRVBBWjZYbGVVQmpN?=
 =?utf-8?B?K0R4dWpadU1yc0NtRUUza3B5bGQ0WWRIcTdXQzRuWVZsVnYwRVRQL1dBQXJz?=
 =?utf-8?B?RnRxZXhjU2lpWUQ1SFdHREhYS0pmWTQ0QjZhbjc3Y0lVTjFBV0ZtaTZCS0ts?=
 =?utf-8?B?TzgvUDFVUmRUZnc1NUUzaERuLzl2TlVKZ1pvd1A1VEJyL0x1WXpIcENMbWN6?=
 =?utf-8?B?cEwreXJRZldSMDNZaUExQXcwU0hUQUpmNTMzVS9hZ3pKS1ZxMTkvN0lrZ09Z?=
 =?utf-8?B?enVsT0hXa0tBY0dMajZuMTJITFhsYmx0aUNnNGJzOGZxNnV0T2ovTVM5aCsw?=
 =?utf-8?B?cFc3TUYwL1V1NERMb21Hdk10cmkxaXlFWk5ydDRQWnlDZ0RvR2ovRUtYYUlQ?=
 =?utf-8?B?SmQ1a05jZy93R3lxRE93TnhtbjZTZ3kzS0pHRnFLb1ZqQ1dKUm4yeXNhQUwr?=
 =?utf-8?B?Kzc4cXJyaFNmM2NZU3VRRXAwYnVteTVsR21HL0VKMVBScjRFY2I5aUlOZ2Zz?=
 =?utf-8?B?YzkrZ3VWeG1HQVFGVDMxSzdoajdMN2Z5bld4VmFkNEtsd0syZVltSUpVRDhF?=
 =?utf-8?Q?88ZIKonDujJiBbtupSXxFaROi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 139c6033-826a-4dc0-4c47-08dc54d21d84
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2767.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2024 18:07:39.6354
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hZv/pX+FnNoXvZuK8C0iG1lOYvnLpizyp5k07kDH9mGx8LW8i6vyRAuoAJ/fbOyN1ezOqqE06MV/uDKJLuqFlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6122

Hello Jeremi,

On 4/4/2024 3:17 AM, Jeremi Piotrowski wrote:
> On Wed, Apr 03, 2024 at 04:08:35PM -0500, Kalra, Ashish wrote:
>> On 4/2/2024 5:42 PM, Michael Roth wrote:
>>> On Tue, Apr 02, 2024 at 05:31:09PM -0500, Kalra, Ashish wrote:
>>>> On 4/2/2024 5:09 PM, Tom Lendacky wrote:
>>>>> On 3/12/24 13:47, Ashish Kalra wrote:
>>>>>> From: Ashish Kalra <ashish.kalra@amd.com>
>>>>>>
>>>>>> RMP table start and end physical range may not be aligned to 2MB in
>>>>>> the e820 tables causing fatal RMP page faults during kexec boot when
>>>>>> new page allocations are done in the same 2MB page as the RMP table.
>>>>>> Check if RMP table start and end physical range in e820_table is not
>>>>>> aligned to 2MB and in that case use e820__range_update() to map this
>>>>>> range to reserved.
>>>>>>
>>>>>> Override e820__memory_setup_default() to check and apply these RMP table
>>>>>> fixups in e820_table before e820_table is used to setup
>>>>>> e280_table_firmware and e820_table_kexec.
>>>>>>
>>>>>> Fixes: c3b86e61b756 ("x86/cpufeatures: Enable/unmask SEV-SNP CPU
>>>>>> feature")
>>>>>> Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
>>>>>> ---
>>>>>>    arch/x86/virt/svm/sev.c | 52 +++++++++++++++++++++++++++++++++++++++++
>>>>>>    1 file changed, 52 insertions(+)
>>>>>>
>>>>>> diff --git a/arch/x86/virt/svm/sev.c b/arch/x86/virt/svm/sev.c
>>>>>> index cffe1157a90a..e0d7584df28f 100644
>>>>>> --- a/arch/x86/virt/svm/sev.c
>>>>>> +++ b/arch/x86/virt/svm/sev.c
>>>>>> @@ -65,6 +65,8 @@ static u64 probed_rmp_base, probed_rmp_size;
>>>>>>    static struct rmpentry *rmptable __ro_after_init;
>>>>>>    static u64 rmptable_max_pfn __ro_after_init;
>>>>>>    +static char *__init snp_rmptable_e820_fixup(void);
>>>>>> +
>>>>>>    static LIST_HEAD(snp_leaked_pages_list);
>>>>>>    static DEFINE_SPINLOCK(snp_leaked_pages_list_lock);
>>>>>>    @@ -160,9 +162,59 @@ bool snp_probe_rmptable_info(void)
>>>>>>        pr_info("RMP table physical range [0x%016llx - 0x%016llx]\n",
>>>>>>            probed_rmp_base, probed_rmp_base + probed_rmp_size - 1);
>>>>>>    +    /*
>>>>>> +     * Override e820__memory_setup_default() to do any RMP table fixups
>>>>>> +     * for kexec if required.
>>>>>> +     */
>>>>>> +    x86_init.resources.memory_setup = snp_rmptable_e820_fixup;
>>>>> This produces a build warning:
>>>>>
>>>>> WARNING: modpost: vmlinux: section mismatch in reference:
>>>>> snp_probe_rmptable_info+0x95 (section: .text) -> x86_init (section:
>>>>> .init.data)
>>>>> WARNING: modpost: vmlinux: section mismatch in reference:
>>>>> snp_probe_rmptable_info+0x99 (section: .text) -> snp_rmptable_e820_fixup
>>>>> (section: .init.text)
>>>>>
>>>> Oh, so this requires snp_probe_rmptable_info() to be fixed to use the __init
>>>> macro.
>>>>
>>>> I believe that snp_probe_rmptable_info() should be anyway using the __init
>>>> macro and this fix for snp_probe_rmptable_info() needs to be sent as a
>>>> separate patch and regardless of this patch getting merged or not.
>>> I think you'll hit issues with:
>>>
>>>    bsp_determine_snp() ->           //non-__init
>>>      snp_probe_rmptable_info()      //__init
>>>
>>> and bsp_determine_snp() sticks around as a function pointer assigned to
>>> cpuinfo_x86 so I don't think you can use __init there.
>>>
>>> So might need to just drop __init from snp_rmptable_e820_fixup().
>> Actually, that will not help as snp_probe_rmptable_info() is *also*
>> accessing x86_init.resources.memory_setup
>>
> What if we flipped the whole flow? Borislav is adding a CC_ATTR to indicate
> HOST_SEV_SNP support, we don't need to clear X86_FEATURE_SEV_SNP at this phase
> (or at all for that matter). snp_probe_rmptable_info() can be done later
> during kernel init, once e820 has been parsed.
>
> One way of doing this would be to override x86_init.resources.memory_setup()
> to do both snp_probe_rmptable_info() and snp_rmptable_e820_fixup().
>
> What do you think?

I like this idea of overriding x86_init.resources_memory_setup() to do 
both snp_probe_rmptable_info() and snp_rmptable_e820_fixup().

This callback seems to be meant for platform specific memory setup and 
SNP enabled RMP table platforms seem to be a good candidate to use this 
callback to probe RMP table, sanitize it and then apply e820 fixups or 
adjustments specific to the RMP table.

Additionally. setup_arch() -> e820__memory_setup() initializes all the 
three e820 tables (including the two tables used for kexec - 
e820_table_kexec and e820_table_firmware) and then there is *no* e820 
API functions available to update e820_table_kexec and 
e820_table_firmware. Even if i add new e820 API interfaces to allow e820 
memmap updates to e820_table_kexec and e820_table_firmware, before 
setup_arch() returns it calls e820__reserve_resources() which exposes 
the e820_table_firmware to sysfs (/sys/firmware/memmap) which is then 
used directly by kexec-tools.

I don't see any callbacks i can use to call any newly added e820 API to 
update e820_table_firmware before it is exposed to sysfs between 
setup_arch()->e820__memory_setup() and 
setup_arch()->e820__reserve_resources().

For the same reason, i tried to use initcalls to invoke 
snp_rmptable_e820_fixup() but then initcalls happen after setup_arch() 
and by that time e820_table_firmware has already been exposed to sysfs.

That's why i see x86_init.resources_memory_setup() an ideal callback to 
probe RMP table itself and then apply any RMP table platform specific 
quirks.

Thanks, Ashish


