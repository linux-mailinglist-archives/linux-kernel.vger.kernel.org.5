Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B9C47B2085
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 17:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231590AbjI1PJF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 11:09:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231422AbjI1PJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 11:09:03 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2044.outbound.protection.outlook.com [40.107.93.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D5B31A1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 08:09:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XjIs/ESA/aHorOapwR8dhWTicNi+7UO9KvbDS0AcHvmXnxo5js2/pDNVGOujGPIZW6JOyYsncImorAPnQtz+LogTIjzS164ZEnO6T59ytaiLeVp0dwslIgMJYDX/V/Jw+WaH/z4jtp7x17geWXh8QyspOeNNQbhCFj5p0uMQQYODOTX2iB3iQE7O8C7DxTJ3hKX+HrjTZSGJvmy7o8cuhNOoZSu5dvdSueh5ZMmhx2jo/qlL55SQkF5j/6YZ4f8ZIkZLsgoKU/8/cCp+RgcXDQCloItYdg7mepCuhLSmCMcysm86XSOUMBtVL4QcwGm7gr5heb3L7zztG6aXorKfqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZV7i3h/hNAbHzbhWTZrmGD/CekURueMJDd9wu3MgDpg=;
 b=Ni90TJenB6mb1lOfA1x7bgO6oKdt61Z5E9NOp4T92b5gNONc8HezUBr3jB02iOxFu6AEGNPbgdRL3KLe8up9ZtHlfdUwFIxXkZDjh2oFyqwxQYgCrCvtI3t1b2yT5eS09Tz0Jc13IlWOTuNmZxEsAvoZymhRcPbYGjft5ndMvPSQmgOCF973G2g+TVRkcezjHqQgXeOTWhCph7R6Dsz4qz1GuQzwGhWMh3VzQJ5Pv98Q4IiWys4d+eL6CB53Z785myXGH3digzYxHAFjXP11OJbf+tFjANxgFEAnId5ly7Cwa10t7SfhRl6A1WREsiT0FihP/hKV5jeIvw/ulH+fvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZV7i3h/hNAbHzbhWTZrmGD/CekURueMJDd9wu3MgDpg=;
 b=sNMtLyUTDwJOyTA7UmN02qPmKOXGDWV6JNxzh6/ppkIW78hln/2XQsV/VTyF9/vyr1gydk+JW2CaaohdLDjCKW2w0+GL5geSWKqgd5ghpPjYJfsS2pbFwK8FScgH+C+XalmkmAXg9jxEAtLc6xlduHF4Nq2Dgo7P0/XiMsKj2MA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by PH0PR12MB7888.namprd12.prod.outlook.com (2603:10b6:510:28b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.25; Thu, 28 Sep
 2023 15:08:59 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::fbfe:ec9c:b106:437e]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::fbfe:ec9c:b106:437e%5]) with mapi id 15.20.6838.024; Thu, 28 Sep 2023
 15:08:59 +0000
Message-ID: <13b360ac-4292-5056-6d00-6eb1d4186b11@amd.com>
Date:   Thu, 28 Sep 2023 10:08:56 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v2 1/4] x86/resctrl: Enable non-contiguous bits in Intel
 CAT
Content-Language: en-US
To:     =?UTF-8?Q?Maciej_Wiecz=c3=b3r-Retman?= 
        <maciej.wieczor-retman@intel.com>
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
References: <cover.1695371055.git.maciej.wieczor-retman@intel.com>
 <918e147601697b1d4b8f8589f5751e05d6ceccdf.1695371055.git.maciej.wieczor-retman@intel.com>
 <9751cbaf-8653-d32a-6058-13c251c59b3d@amd.com>
 <4sxjxe4cgvookcobwbrmsoeszjordi3bpjg22zxut3lanjc46j@xpqt6nblx6uc>
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <4sxjxe4cgvookcobwbrmsoeszjordi3bpjg22zxut3lanjc46j@xpqt6nblx6uc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0192.namprd11.prod.outlook.com
 (2603:10b6:806:1bc::17) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|PH0PR12MB7888:EE_
X-MS-Office365-Filtering-Correlation-Id: efa1f5af-803d-459c-b0c8-08dbc034d7a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0wZYjv9e2L1blTN+FnNfnilQHhMJ3iSUwmDRy28KKwmuUiYL8ZcfJPQadXuoOzeybp+eMztdooes9MU5vu1iUXQEoNLAJ94ZLfsxysEej3c42hkCtaKpVqyLtol1hR5RMIKcu+zSzyXflDZol9GEHIYXJNGSq2rJ3DMP54acnNJNl6HZ3YKjAUIzf02H7q2AVxHTi4MD6IOw+bnlzagS6c3VHIK9pcXHqNH7YGzk43LI+PdyiyETY49dMmgZX5nZ1TpKXxkf+faYtEiyei09s93UnApjbzO44eIAn4w6M/88xFidt7Uf+Zh28eF0yZtlv3wu+O4n55oPzjXhDT2uH0q0LUo2sFwRMAwfikaYxoRQrYlBqUdfReBOT8cZAXtvGYkqAlmjxZPjTZyQh3mfwIgFYfybFtnek9JVoXMycW+YNSsBfMJD0G31wobvpug8DMBzdiVeNrq6iSbmJIqk4G4olmWuKO9F1iZ9knVLrJ279Nbfb+lk3OMu+bkGUpShkjw9Hzw+YbsW+nvpFgqZ8n/zLvhJXuJKqQQKJd/+dQKlqlKx7hzus3ddXJ6zh9jtTDJERomQKMRJW5KKh9v4CH1+Rm60FGNccNQO6Sda8HoSVsUGcOrnkWd7ot8ner8sgWe9eFHLAtwH4s7kdtCsDA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(376002)(366004)(346002)(39860400002)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(2906002)(53546011)(6486002)(6506007)(478600001)(6666004)(3450700001)(66574015)(7416002)(83380400001)(6512007)(26005)(2616005)(8676002)(66556008)(66476007)(66946007)(4326008)(8936002)(41300700001)(54906003)(316002)(6916009)(5660300002)(31686004)(38100700002)(36756003)(86362001)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UVVXUFIwa1BFQXNrM2hlMVl3U0NwQi9UNUw0YkliUjdWNmJtVUhwYk1PK2Fj?=
 =?utf-8?B?bWdkYlpLaTZKb1lSM2g3cm1RMGlDeGZhMUh6QUdyL3k3YXIwVWlZWE1NMXpZ?=
 =?utf-8?B?ZDlveGw5dE5oQ2ZOa01QYXFhc1lJMmtISHplTHVRaXAxTEttdFUwamd6OVFz?=
 =?utf-8?B?TnlFcTN0ZGFTYmcwTjVlOVRpeHF5NlNZMzlXblR1NkN5NjRaV0ZUZGVBWmFr?=
 =?utf-8?B?M1BGZ2wveTNiZ0NtQUtaVEczaGtDeEZxaGkraDZvZ0RwVnl0a3RjY0ljOFhB?=
 =?utf-8?B?bE11RGs3cVZyMjVjUDBjbVQvTDFCNlUwV2VTU1JRNUF4VFFwOHpqMlZYcmhM?=
 =?utf-8?B?cWg1T0VaYW1VUzc1VGwydzlxZGNMU0hlbWJUdUtXWDlnNVpLQnA3d0tLdVZq?=
 =?utf-8?B?NU5OVGVYQWdJdklqbW0rWGdDM1FBcEhqNGlJNFNmMlhSOXlXQUFmRXBwNW54?=
 =?utf-8?B?ejFCcWRUNUhENTlseG1jMHhybStvcnRFTDIrdlNQVXJQUXRhd2ZGaFZZaGU1?=
 =?utf-8?B?Vjk3VkVkWTV0bkF5RDdVTmlCS3BES1hGVjdUbUdoRmFaZzFaM2R4VkRBSzJN?=
 =?utf-8?B?c1ZsRGZrRlhDMkpUWVZjU0RRUUFxU3RDRm93VUNGWDN5L1UvQkJESTJTNzdt?=
 =?utf-8?B?ckJVbVFEVWs0TGEzNVpCQlY2a0FpTUE4WW9CWUFmU0NFWkRldFZaZlUxbjRt?=
 =?utf-8?B?NTN4WTJuQk9mZlVxbE5ZL3hnMHVSdUNsMG9HSjVJQmFMNE1lWVpBSGM0M2F3?=
 =?utf-8?B?S2IzNEFGNnlQR3o1R2loQjQ1b2RFQzdoV3pSb0ZQQisweVFlVThhMUZMRi9P?=
 =?utf-8?B?SFF0UmZpODJSTXJPTUdNRUJXQzZ4UUNkOFphNU1xbC9zYWRWQnpBem93OG5m?=
 =?utf-8?B?VDBpclBpMTlsS25JaXcvSVFUdTlFNzVIYS9zN2o5RHdENkVBN0dSSUcwRFF1?=
 =?utf-8?B?WkNZSmo4Q01XaVJuRGxtVWJaeXJyNUtWM0RXTkFHMWVlUzR1ZDRyZWRKUHNv?=
 =?utf-8?B?dmlkUVovQ3ZnRHc5YXlwQVd6LythMTlZcFZLbWxCVG1Hdzk5bzdJSFVrMkNs?=
 =?utf-8?B?aytXUk1TMW5PalBISWZnVTd0cUdFY0dZcFFEWXo1NzYvTHZEZFhLU2ZpY01Z?=
 =?utf-8?B?ZHMzTnRmMmRMcWlXSlh2dW9ZWks1WHE5WlAvc1pQRGI5c0ZZSEd0Szk1Y0gy?=
 =?utf-8?B?dWZKRTlRMGJYU1B5VTA2dlByVHMzUlBlRVQyQkh4WUVBelB4TFZwNzBJSUV6?=
 =?utf-8?B?Y05xdHpKckluRWI5R25MY3dISzlCMXViZXJDajE1NkxZTmNzcjN3Uy9DNWlJ?=
 =?utf-8?B?eFRJMmd1TGdvMjBaTG04RElQRFBLNHR2MC81ZmpDK1pvMTU4ZzNqSkZFUTk2?=
 =?utf-8?B?NjdCTjIzU1Z0U2VUc2p1d1ZDNVZ4N3dVZGxnUHgyZXVyd3NONnYyV09PZ3M5?=
 =?utf-8?B?OWxSZVJqa0lMbnNNSG9GeFFBaGh6WnJFTEF4WFIveHNtN25QRVZFcHJUYzRT?=
 =?utf-8?B?TDJWVUJxK1paQjNmd2wwYlFYLytyZXdtKzRGellncnNDSjhQWVBXbFpNSlpj?=
 =?utf-8?B?UXIwWUVNL2phNGc2TnRIcFZZS1JqZXJCNEx2dE1ReFlDbDV0Z0dDWGh6Mjdy?=
 =?utf-8?B?WE5FZFgwQnhIZWVjQm44N25idW9GKzREQzF6aThIUUpsbnBXaDBzRCs1Y0NG?=
 =?utf-8?B?MXM0MlhxZ0lWQ1phYVdZTGp1d2NiRXExWE9NUVNFbWNuWWYycENKekMvV2g5?=
 =?utf-8?B?ZGhIZ3kxNkY0ZTUrbU5ZMnpuTVdrK1ZsMlMrMDZoSG9KOXpkb3BTQWl2N1Ja?=
 =?utf-8?B?NXBpVjU4dHBjVEhydGZueDFLaUxMZXBIOGxmZDhwaVEwWDZXaTNLU3NhYW9i?=
 =?utf-8?B?K1ZCbWZwM3QyL1pQQVBVaTFWZHF0YU5QdTNxYzBRNGhUenlZRER4Y1E2Zm9a?=
 =?utf-8?B?OEREMVdwcHI1c2JRNHltc2VBMWVIcGdYeGhaL1RQZENGcm0rbmE1RG5EUW1D?=
 =?utf-8?B?S1VmdXNUeFNqM0ZXVG5NK1lQd0pjSlNXb1YzQWlpcGxmOTdLeVoxTFRwb1ov?=
 =?utf-8?B?TisrYi9aUm9kWlZaNTg0dDJSOEpxME5kSWFEeVM3MkFZRTBzR0U5SkZGZG8y?=
 =?utf-8?Q?IJSfQGtHgVVE0ZbV/84CImsnB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efa1f5af-803d-459c-b0c8-08dbc034d7a2
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 15:08:59.2944
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xd7Pb2xxc6bw8iKEVGYgNJAmof9kBjpKTs5q8THRzmN3LB2pt1zbMJ44P8NRrPnI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7888
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maciej,

On 9/28/23 02:06, Maciej Wieczór-Retman wrote:
> Hi, thanks for reviewing the series,
> 
> On 2023-09-27 at 17:34:27 -0500, Moger, Babu wrote:
>> Hi Maciej,
>>
>> How about this subject line?
>>
>> x86/resctrl: Enable non-contiguous CBMs on Intel CAT
> 
> Changing "bits" to "CBMs" does indeed seem sensible so I'll do that if
> there are no objections.
> 
> But I'm not sure the preposition collocation change from "in" to "on"
> would be grammatical (at least from what I've read in docs about Intel
> CAT so far).
> 
>> On 9/22/2023 3:48 AM, Maciej Wieczor-Retman wrote:
>>> The setting for non-contiguous 1s support in Intel CAT is
>>
>>> hardcoded to false. On these systems, writing non-contiguous
>>> 1s into the schemata file will fail before resctrl passes
>>> the value to the hardware.
>>>
>>> In Intel CAT CPUID.0x10.1:ECX[3] and CPUID.0x10.2:ECX[3] stopped
>>> being reserved and now carry information about non-contiguous 1s
>>> value support for L3 and L2 cache respectively. The CAT
>>> capacity bitmask (CBM) supports a non-contiguous 1s value if
>>> the bit is set.
>>>
>>> Replace the hardcoded non-contiguous support value with
>>> the support learned from the hardware. Add hardcoded non-contiguous
>>> support value to Haswell probe since it can't make use of CPUID for
>>> Cache allocation.
>>>
>>> Originally-by: Fenghua Yu <fenghua.yu@intel.com>
>>> Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
>>> ---
>>> Changelog v2:
>>> - Rewrite part of a comment concerning Haswell. (Reinette)
>>>
>>>   arch/x86/kernel/cpu/resctrl/core.c        |  9 ++++++---
>>>   arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 10 ++++++----
>>>   arch/x86/kernel/cpu/resctrl/internal.h    |  9 +++++++++
>>>   3 files changed, 21 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
>>> index 030d3b409768..c783a873147c 100644
>>> --- a/arch/x86/kernel/cpu/resctrl/core.c
>>> +++ b/arch/x86/kernel/cpu/resctrl/core.c
>>> @@ -152,6 +152,7 @@ static inline void cache_alloc_hsw_probe(void)
>>>   	r->cache.cbm_len = 20;
>>>   	r->cache.shareable_bits = 0xc0000;
>>>   	r->cache.min_cbm_bits = 2;
>>> +	r->cache.arch_has_sparse_bitmaps = false;
>>
>> Is this change required?
>>
>> This is always set to false in rdt_init_res_defs_intel().
> 
> The logic behind moving this variable initialization from
> rdt_init_res_defs_intel() into both cache_alloc_hsw_probe() and
> rdt_get_cache_alloc_cfg() is that the variable doesn't really have a
> default value anymore. It used to when the CPUID.0x10.1:ECX[3] and
> CPUID.0x10.2:ECX[3] bits were reserved.
> 
> Now for the general case the variable is dependent on CPUID output.
> And only for Haswell case it needs to be hardcoded to "false", so the
> assignment makes more sense in Haswell probe rather than in the default
> section.

Here is the current sequence order with your change.

1.
resctrl_late_init -> check_quirks -> __check_quirks_intel ->
cache_alloc_hsw_probe
   r->cache.arch_has_sparse_bitmaps = false; (new code)

2. resctrl_late_init -> rdt_init_res_defs -> rdt_init_res_defs_intel
   r->cache.arch_has_sparse_bitmaps = false; (old code)

3. resctrl_late_init -> get_rdt_resources -> get_rdt_alloc_resources ->
rdt_get_cache_alloc_cfg
   r->cache.arch_has_sparse_bitmaps = ecx.split.noncont; (new code)

The code in (3) is going to overwrite whatever is set in (1) or (2).

I would say you can just remove initialization in both (1) and (2). That
makes the code clearer to me. I assume reserved bits in Intel is always 0.

Thanks
Babu


> 
>>>   	r->alloc_capable = true;
>>>   	rdt_alloc_capable = true;
>>> @@ -267,15 +268,18 @@ static void rdt_get_cache_alloc_cfg(int idx, struct rdt_resource *r)
>>>   {
>>>   	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
>>>   	union cpuid_0x10_1_eax eax;
>>> +	union cpuid_0x10_x_ecx ecx;
>>>   	union cpuid_0x10_x_edx edx;
>>> -	u32 ebx, ecx;
>>> +	u32 ebx;
>>> -	cpuid_count(0x00000010, idx, &eax.full, &ebx, &ecx, &edx.full);
>>> +	cpuid_count(0x00000010, idx, &eax.full, &ebx, &ecx.full, &edx.full);
>>>   	hw_res->num_closid = edx.split.cos_max + 1;
>>>   	r->cache.cbm_len = eax.split.cbm_len + 1;
>>>   	r->default_ctrl = BIT_MASK(eax.split.cbm_len + 1) - 1;
>>>   	r->cache.shareable_bits = ebx & r->default_ctrl;
>>>   	r->data_width = (r->cache.cbm_len + 3) / 4;
>>> +	if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL)
>>> +		r->cache.arch_has_sparse_bitmaps = ecx.split.noncont;
>>>   	r->alloc_capable = true;
>>>   }
>>> @@ -872,7 +876,6 @@ static __init void rdt_init_res_defs_intel(void)
>>>   		if (r->rid == RDT_RESOURCE_L3 ||
>>>   		    r->rid == RDT_RESOURCE_L2) {
>>> -			r->cache.arch_has_sparse_bitmaps = false;
>>
>> Why do you have to remove this one here?   This seems like a right place to
>> initialize.
> 
> Look at the previous comment.
> 

-- 
Thanks
Babu Moger
