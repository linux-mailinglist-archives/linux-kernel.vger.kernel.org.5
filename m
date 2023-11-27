Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EDB67FA38E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 15:52:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233595AbjK0Owl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 09:52:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233569AbjK0Owf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 09:52:35 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2068.outbound.protection.outlook.com [40.107.237.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11782183;
        Mon, 27 Nov 2023 06:52:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gmT+HAA5M0yElNJJ7IStnskTPYGD3OKqU2xiWNMYHqP43jGwv+yHfxpc97UTRlpTsf3sMJ/jGZMT6uaO6I5fvomjscJ7dfgvA5oSVbcFZzutyulHTkqVKaliX0UwK67jgDBRjy0j3av+ZjE6DUoKP6pLbgjX/25Tiw0LW8ZDDNokoG4gZjPUyeef5NdT9dC1RUKnJr9vcHvGYvpuDPScryRyJ+z2Qmk+YeRwZcswRJA9CqPwahn6syMD58fRUY46CyLEmeCs01zDXispDI6JdAeyi/Z3cHHZJ6s+OvFnw5uEYJqqAPKzJRGLmG2m9pBfF1TGTqnA/x1MUrIJSoVhXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZER9Z0tcWpIX0qkq+HA4Rl/z+Bb3rNJf1SAxvGul1wQ=;
 b=J8iUr9gbz/yQSrv4pw0dkQiWCGd8Sn9+3LsEMW0XIYwur0HENATUT5P6qVOzGyGyG6KeqQc7+OrUbtkHGyN+xOPV4d6wvwK7D3sH5ZDTk404C/lcihIiTiekJzLnkvrh2OVOSSjn32vNavaVRzslnLk+QHvjEeIcULy+OdjAeBuakRLJOW8zi4DfrMI/zXyR0yFbsLfUtvN5N5kCgV41bR9wtNUkhRigy+w0P+EYQ9n00EzwznG+tEwLhxSnun32Ru3gIlIV6TPzIGYn1wy1+qo3oEI57xfAYJqEqcvAxuW+J82B7d1WR9O/3LB4vpkVEw4hSdTPX7hL73mfkYzEwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZER9Z0tcWpIX0qkq+HA4Rl/z+Bb3rNJf1SAxvGul1wQ=;
 b=qlryvvezaTd3DuN0FQPoukhcsaSi9NHXLz1Hlri3Qx1EZNHjmXM0q0nD3ZER+cNeiI7phyuJUNMZGcruU2Sb4bx7Flat2KvzqSyC2CNFapsoEXHDAv/U2JraCdb7stPEnvk0YWV5yjbfjjQz/nFSMRnzQFC4KDoLOc74A9b2e0M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by MW4PR12MB6900.namprd12.prod.outlook.com (2603:10b6:303:20e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29; Mon, 27 Nov
 2023 14:52:37 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::a9cf:f8b8:27bd:74d0]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::a9cf:f8b8:27bd:74d0%3]) with mapi id 15.20.7025.022; Mon, 27 Nov 2023
 14:52:37 +0000
Message-ID: <c822cc63-3ff4-4edd-9416-015c52f9fb5b@amd.com>
Date:   Mon, 27 Nov 2023 09:52:35 -0500
User-Agent: Mozilla Thunderbird
Cc:     yazen.ghannam@amd.com, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, tony.luck@intel.com, x86@kernel.org,
        Avadhut.Naik@amd.com, Smita.KoralahalliChannabasappa@amd.com,
        amd-gfx@lists.freedesktop.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 02/20] x86/mce: Define mce_setup() helpers for global and
 per-CPU fields
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
References: <20231118193248.1296798-1-yazen.ghannam@amd.com>
 <20231118193248.1296798-3-yazen.ghannam@amd.com>
 <20231122182451.GHZV5Hc/49OYomyejc@fat_crate.local>
From:   Yazen Ghannam <yazen.ghannam@amd.com>
In-Reply-To: <20231122182451.GHZV5Hc/49OYomyejc@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0510.namprd03.prod.outlook.com
 (2603:10b6:408:130::35) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3108:EE_|MW4PR12MB6900:EE_
X-MS-Office365-Filtering-Correlation-Id: fe0d7d63-a0cd-4059-8534-08dbef587f4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GahDYae8tx+xZIut7Dt2YERVTwsO4nO6Jc5xaI4XFKKp5RfzB2KWLQwOK5kPwpHeoYeVOCj7SU1Eg6f8FwjLsvv6gS/+W9xUpTQc4b6vJzAWwHtR+MEJr2QvqvdcWxNRgxU5LSlTE0lGI8goUWQbCn72IAgLZctxnLCy28uG6o1rFDTiJCLv+VWooDu1Dxu1FTelV/uRqbcqvApJg3HLFB3vx2/lGaI+zm1BRURLQpmnER/bjCQaCUieTxtZD0ILP3Gm8YSfOgdDO01UyPaloO/qr2p72rdqQrmFHyyVhiw9FFtRg7LsjHlSpGrh2KupCT1CwPrEp/W6WYpWjcyCUJFyYLbqcgUVtv+vtqV1Sqbr3rkF9wSFvGikJsEd1VVg9T5I/qsqxN1GJ0d/q5Q3V6sB60aZGj4e3UqypzbtrSOAP16ym063I1sdnmt7t3B/kzU9gpVwyKK+henCT50QgA2QRy2N7jQtTa7zKuDg4Zm0jwlSu4rmqnw7EOduqqcfrhAK+czx5N7qIFRa630/KZWqE8BLq5DWRzXhjKehuxtlD8AsYe1OdTnynwDuEpLHvv1eWuiYfeAdsP2KeOTENZOP9DPSs9UfzzinMjFsq+5HkglnK3MrvCAKUe1sSbSBR0+cKySRzAa7VbQo5gwNOQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(376002)(396003)(346002)(136003)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(8936002)(8676002)(4326008)(6512007)(6506007)(53546011)(66476007)(66556008)(66946007)(6916009)(316002)(6486002)(478600001)(2906002)(36756003)(38100700002)(41300700001)(31686004)(86362001)(26005)(44832011)(31696002)(2616005)(83380400001)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TEI5M0M2amk5MERpbW5OcmJlNG9xa2owSldBYzFKZGQ1Vkd4M0FHV3BqVlNw?=
 =?utf-8?B?bnlwbEhlZWZGQ281Q1E3eWtNZWdaWnY5MWJaL2ZpUFdCVU1iUzdjeUV1elAz?=
 =?utf-8?B?aWdmODFjbUxNQXFtUWUvYkMzU2pUV3ZNMjhZaDg3dnRpeTBEZmlPU0dZM1FT?=
 =?utf-8?B?a1VOUmxSOXJEQjk5MXhnemRJZnAwSXh6elRvcU40TmxrVExzRlhkR3hRaDQw?=
 =?utf-8?B?cStKcDBtMG11STN3cjdpdVVLY2x0d2FGalZJWEpVWjdIRXMySTh4U0w5UlN2?=
 =?utf-8?B?WldVTUg4MVlyMFdiWkZKMVZUVjBFbllleW03VWtpTkxXOW5aeWxMc2RIbklW?=
 =?utf-8?B?ajJhc2tucUowOGJwejFuWDZ4ZHZiWThqOHhlVlNYSnJyait2ekpIb29OYjlp?=
 =?utf-8?B?REp4OXVsQU40dm83bnZIblRkZG5wOGN5aWdSTDVsMHlIMXl2MzlVYkFaOE9Y?=
 =?utf-8?B?M2JrQXNjSDJpRjNwZTFYcWxnaThRVVI0ZWN2bW1ISWJqTFM1YlJIS1FBZHY0?=
 =?utf-8?B?M1dOa3lqd3AxZFF1am9td3E1c0VUbFNJdGNDdXNweitrNnphTEsxNTE3U2tu?=
 =?utf-8?B?bXB6dXQzSldEd251MHAvS09UT01JN2VielFDRTJreU5qSm41S1NudTAzMExR?=
 =?utf-8?B?RWgvWUZjMW0zWm1kcldKSGZYdnFvcVdxVGp4am1Jb1ZXMGxuWDl1SWxMVDN2?=
 =?utf-8?B?UkZGTkRXSzBrNjRrdFBUcDZTcC83ZW40UEpzczhrQTZWd055QjQzdDhCZ2Nh?=
 =?utf-8?B?Y2hzSlpZWEdNTHdoMWhpdEt0YkhZdU1xTmtJREl2R0dSMmRoekFLOEcvZkFX?=
 =?utf-8?B?eVk0STY0NGFyaWZQdE9mOEZKTzNEVGVZdXFsOTEwcGNCS2dJV1ZicGFVQUJP?=
 =?utf-8?B?dHEzMzUvcEpuSFMvQS8zTkY5SlRRTTVEcnZBQ2I2NGxwQk1xWC9sLzZFV3ZR?=
 =?utf-8?B?S0I4L1lzcnRMMHp2VEN3Sjk2TnpGU0w5V2V1SVBUb3JTU2lUaWg2cDNyNnh1?=
 =?utf-8?B?SC9WWFgxWlIwbzhodjhEc3JpTXBuRGgxOTZ2TDA3VzllNVkvcURzTEJWRncy?=
 =?utf-8?B?dFlTV0dwM1RSN0QxSktEVmpVTWpSUm9Sd1YzZzZ6T2ExemcvRUlma1VRV0I4?=
 =?utf-8?B?WXZhejVtTTdHU1BtU3ljQmhOQWR0TWhxNUhtV2w2OUgrYWdmbEloZk9CdGVL?=
 =?utf-8?B?ZE4rWnlLNUNXaE1mTWFQNmdwK0ZNbng5cGpLUHgvNFk1TW9aOWo4U0JTT0J0?=
 =?utf-8?B?eUVGQ0JUMFNFd1FJZHI4eS95UmJlZlU4aXlzdEw5aGFRU0xuZENOTmo5QXA2?=
 =?utf-8?B?dWo4YjBlbnVxK3JLZythY2pzb0lReDR1QjhjdUZpU0NObXhBc2tNUFlWNkRK?=
 =?utf-8?B?aTNHNHZlU1M4VHlYTlU5SU5Ob0RWTzk0MnoxTjJrdFpZYzJSdThlRWx3S0Z5?=
 =?utf-8?B?UU0xYnA4cTVMTUUyQWViOWozb1ZaV2VWWEpUdDBqdGFxUThxNWNOOUhNcFow?=
 =?utf-8?B?SERZblJTN0JFZ3RrMjZudVNPM056SEZCTElMcGpwempvWkRkRklLSVVLRlph?=
 =?utf-8?B?dWNpWE52WEF6OENtVTAvdWpYY1o4MVI4dHRMa1h1b2xFQ21rb3U1L2lPY05Z?=
 =?utf-8?B?YWE5K2lxWC9DYkowRG1NTW94dmZnRHl5RHQ1bGcyZlo1NVQ0THZUc0NEMEhB?=
 =?utf-8?B?UkZhb0kwRFVqQjlQWU5UK3lEc2V0VmZGanBiSWVTRFZuMVhMbTF5TEx5UlJX?=
 =?utf-8?B?VWVzem95Rk8rNVBROWxVWDBWVU1WWkYzTFZCZWVoQWtYcXFrTE5IOUNEVDhF?=
 =?utf-8?B?QVFpQVJGbll0dmVsS2JpZ1FlZHdkaTdDVXNQOGtvdXBlUGFCZ3FJUUhIOVc1?=
 =?utf-8?B?OGhITlF1by9FVzVwUWFXWGpUYzg0ZHd1RCtFaitmSm5jbVFWM0pyZXIyMkZZ?=
 =?utf-8?B?cmNvcDlDOXU0d2pSLytpNDZzcHRySFNBR1RPR2h1K1FKeWZ2REpXdW5nWTFt?=
 =?utf-8?B?ekJEN3JVd3d6bFJ6cHBoRjA3bnFKU3JvSk41alp3ZHpWUHkvR0pCR0didmZL?=
 =?utf-8?B?MG1ScEZJdGM1dU5jdk9QSzZPOEZoVmNWSTlLZEoxQXRBWjVlZWNjTndOY1hr?=
 =?utf-8?Q?OjKUFsZ+UVkKZNAzSxvbyoBHN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe0d7d63-a0cd-4059-8534-08dbef587f4d
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2023 14:52:37.6519
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0JSZ96L0EN8nhhCXsuYNbagUl8V9OqbsCHW6K/ONk/Y+yl23ap47DcVmmj06mFlxeXcPatUlLi1Q/+8mDZ1BrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6900
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/22/2023 1:24 PM, Borislav Petkov wrote:
> On Sat, Nov 18, 2023 at 01:32:30PM -0600, Yazen Ghannam wrote:
>> +void mce_setup_global(struct mce *m)
> 
> We usually call those things "common":
> 
> mce_setup_common().
> 
>> +{
>> +	memset(m, 0, sizeof(struct mce));
>> +
>> +	m->cpuid	= cpuid_eax(1);
>> +	m->cpuvendor	= boot_cpu_data.x86_vendor;
>> +	m->mcgcap	= __rdmsr(MSR_IA32_MCG_CAP);
>> +	/* need the internal __ version to avoid deadlocks */
>> +	m->time		= __ktime_get_real_seconds();
>> +}
>> +
>> +void mce_setup_per_cpu(struct mce *m)
> 
> And call this
> 
> 	mce_setup_for_cpu(unsigned int cpu, struct mce *m);
> 
> so that it doesn't look like some per_cpu helper.
> 
> And yes, you should supply the CPU number as an argument. Because
> otherwise, when you look at your next change:
> 
> 
> +       mce_setup_global(&m);
> +       m.cpu = m.extcpu = cpu;
> +       mce_setup_per_cpu(&m);
> 
> This contains the "hidden" requirement that m.extcpu happens *always*
> *before* the mce_setup_per_cpu() call and that is flaky and error prone.
> 
> So make that:
> 
> 	mce_setup_common(&m);
> 	mce_setup_for_cpu(m.extcpu, &m);
> 
> and do m.cpu = m.extcpu = cpu inside the second function.
> 
> And then it JustWorks(tm) and you can't "forget" assigning m.extcpu and
> there's no subtlety.
> 
> Ok?
> 

Yep, understood. Thanks!

-Yazen
