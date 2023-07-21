Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39B6775BDAA
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 07:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbjGUFPe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 01:15:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjGUFPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 01:15:32 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2079.outbound.protection.outlook.com [40.107.92.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD14619B2;
        Thu, 20 Jul 2023 22:15:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K1OiHD2tar/mAPuXzNGvRl3piUoEAwKqsq6DlhAX/MrXLY2ggdYjsVmwkqUVmTu761g9ysfvGRUr2qHhiT6mP3UpsoE109Lz0PjuVcGttWBWs04VxlAjzJMJQwNHM6HBNrrR3PdG6cm6AQtcLTASTyIk4kHtnkKeCl8LxR35qHqS0uYcxWVaF/5hOkQC4o00YPiltie+9ooYpeOWR2VBYNOmoZ/StAJqdk+rlV7YmpiXAbYdwAxZoBNorO5ukgN2PVRXwsVB4d02SISYiKeBng4GySNw74Fdr9gt3EjMBmw9s0UecUAghn1gtNUOu08Ybjvl3c0RHVfaXjA3Oem3rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XsjZqe/jHcJbKiBDrhq4EE3RAZxdsbx85KxdVIdqRZU=;
 b=lplUUUo+RA0JEfumTfhHEbNCN8RgkFHSnTeUqzmRfunM0lE4qjQ3kAOxFuKtldHs9u3QMsSpawBLnuab1Kda2iRvHcfoE1i3Kpgj1hB8nzYZV0LtY9OftLQ+QmABkC8y7Gu+bnUVjzyQyFr29KPGSZe4OMbYlA3G3m29BuAOKDMscKPsT/drQk913HNGJ14bJBTJ/HxRY5A8i0QcP8XC8wyBU1QuwQakPrVDpjnyzx5Bvz+8Vq2oAWBBC/zXpGgIp6tR0AgCpux4H1OoplOL7it3sHBsIq+dy+oShgAW36UIBkLK8jZM3W7qOH3j/qjqps2MnLIz1wGA6J1r2AVKFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XsjZqe/jHcJbKiBDrhq4EE3RAZxdsbx85KxdVIdqRZU=;
 b=o8Vm27OhCVdMIMHZ2Tyf8P9ipA8CGJ8ycv0RkoXeGQQf+FZ7zwvCwelo/CiuPWsDND9rsT6rkZHD8Rrh6vk5fy0lxrShFzVAEeTIpwAT70Mx+ehBFstN/Xs2GjkWFbh28ME/ogH45DSVtfsjgqozDiWLxM/anHCpUpuh2lc8E3g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB5713.namprd12.prod.outlook.com (2603:10b6:208:370::18)
 by CY5PR12MB6034.namprd12.prod.outlook.com (2603:10b6:930:2e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Fri, 21 Jul
 2023 05:15:27 +0000
Received: from MN0PR12MB5713.namprd12.prod.outlook.com
 ([fe80::8ba3:7aea:769f:718f]) by MN0PR12MB5713.namprd12.prod.outlook.com
 ([fe80::8ba3:7aea:769f:718f%7]) with mapi id 15.20.6609.026; Fri, 21 Jul 2023
 05:15:27 +0000
Message-ID: <19be0aea-30b2-2aa2-12d7-57f668d759cb@amd.com>
Date:   Fri, 21 Jul 2023 10:45:09 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] perf vendor events amd: Add Zen 4 memory controller
 events
To:     Ian Rogers <irogers@google.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        x86@kernel.org, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, adrian.hunter@intel.com, tglx@linutronix.de,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        eranian@google.com, ananth.narayan@amd.com, ravi.bangoria@amd.com,
        santosh.shukla@amd.com
References: <cover.1689748843.git.sandipan.das@amd.com>
 <a70b1ef6ab427b768f21401af280d235dd095412.1689748843.git.sandipan.das@amd.com>
 <CAP-5=fX1NQzus3MQapmBrdgEhDG4+XmawgytfugHHOKD0E-COg@mail.gmail.com>
 <fef0492b-60c3-70ea-c7f1-370bf2734fc3@amd.com>
 <CAP-5=fX=1t51+a9=Fj-xt4zyLw9OG44bu9wRdPsu2hPoh8cNZQ@mail.gmail.com>
Content-Language: en-US
From:   Sandipan Das <sandipan.das@amd.com>
In-Reply-To: <CAP-5=fX=1t51+a9=Fj-xt4zyLw9OG44bu9wRdPsu2hPoh8cNZQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0222.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:ea::12) To MN0PR12MB5713.namprd12.prod.outlook.com
 (2603:10b6:208:370::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB5713:EE_|CY5PR12MB6034:EE_
X-MS-Office365-Filtering-Correlation-Id: 0dab5008-1dd0-48c7-3486-08db89a97eb0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zeOEAO3FHXnnTMkeBBHZyJ6NQJxLP/7poLeZ5FioNeV5pNx+PoQh5cvwBKYtuP+sA7btkd4wiKNPltkZQZOX8gyGlz+/SYAPjH3c7ZRpFUcA25Ll8p3IzXjEEZkWaxlNdY3j9egLtiC+De/FDhXcktyh9lvkvS/RJMwxXHXyYwxgkMpbtYfUhAgS+yYbG/DCx/GlqnBSFDvUGgTo4V6vRdleQGQRk6dOLMchT2zsgb+EqFbMN0VUkap4yZc5V3vUOJ4npnIfPoEfXl/t4z028+ZolOROJxOjEMmBY5FNJ4XYzUFg92RO0uWu+e6wO7uFNNB0e3lVsrWe2rSnjbIaZ9C4RicFg5ECq9j28Vudv9POW9Y3P6uJXIJRdFVvbwiDIqi/7PxBoSA2NT4o8LpEyQLPYrGrmmCEoqEH8ayiwoes77UuiO9bd3v8yipmpygZP1cacq+Xa6syqDgLoL0ySBLN1ZYB7iTnWCEmFz80b9a2zJSkzaDsjDLB02oJINR9GuSpftFSioBEUN+7ddxgcm8+IzqHGPkUupMAssL+lsd7teSUwk+mXfeAcK7RQ5xQ8rP0V1oLMMzLE4kHTxQ1uahEn8lMe0d6/i6RXU4g5XfsA3DSEz/4jy5x20Lw38/5b5QkP3My/6vDzgd7xIBDIw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5713.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(39860400002)(346002)(376002)(366004)(451199021)(83380400001)(2616005)(2906002)(38100700002)(66556008)(316002)(66946007)(478600001)(4326008)(6486002)(6916009)(53546011)(41300700001)(6506007)(26005)(186003)(66476007)(31686004)(6512007)(31696002)(36756003)(5660300002)(44832011)(8936002)(8676002)(86362001)(7416002)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WUlpcWNWbHVzc3NRL09VREZrZ1ErSWRVdnFmTDBZaHNJREkzSUdGYitxNHhO?=
 =?utf-8?B?V0NEN1RrY0JiUDNiMllLSkJGS1dYVHluNDZjSGVlTm54QldrV3JsV2JiSXMy?=
 =?utf-8?B?d2dDN0RoK2hTL0JseWpuazFjWDNoY0R2ZS9QWXp1TXVYOFZBZnhDY1ByUy8x?=
 =?utf-8?B?SFVoOFdCUjE0UElmQVFCRm5zcyswekphOStHYllTc2hpZE1obXRTMjBlK1Uv?=
 =?utf-8?B?bUdLWGthdkZrbGJhTWNuK0JsMndkNDhRVE5tckVoL1J4b3BrZmxxRGZ5MEow?=
 =?utf-8?B?WXBMOUFWMXJRQVlBZVVSN1ZKVzhUMmxRR3FzZjBqbkpSSmRRV0NtOTVMM1Nx?=
 =?utf-8?B?NEpQQXFwYTMwRmZVUVl5SStKZ2cvN0hwdmpoa3NSd0U0dEg1VWdtY3NtU2M2?=
 =?utf-8?B?djNwbk5Lb29HeGp5QnEwc0czd0s3ZGV6cFVmOWszK0hjczYvOERaeDZYakxu?=
 =?utf-8?B?NURkNXpHc2hNOUZUUTUzV0tSRS9ZYmdPZ2ZkRXNJTjBzYU9UNG9abGs3WDZ2?=
 =?utf-8?B?cmN2TzBkTXhMMjdPSU9ESVVGaVA3VHVwd3BWTmdFckZ2RTN2NzVnbnhhSW9F?=
 =?utf-8?B?RWpBV3AxRXdBRmVGTGV3Uk1la0tuQlRCUUxuNUltRUYrSVZPWVZvM1gxcmJz?=
 =?utf-8?B?c1B6bU1pRHRmRVkwMW44MEpwQ01YeFdHSHJVRitzS2w1UC9zVG1KeGthYU9k?=
 =?utf-8?B?ekNPdGNIRXRnRDRySGlKNXlrajBJTzZOR0xsM1hrcXp0ZlFOZVN4elNJQ2NU?=
 =?utf-8?B?aW1kb09CT2pBQWNNOXd5cEtCSUpHSTFZWmR5c2xwTWF2MVdZcVlqVFYvVGNq?=
 =?utf-8?B?dmoxWlp0QUNCOU9vUlltZTFTNlBnaGQzTEhCMVhJRVpNZThCaUVTcDRLM08y?=
 =?utf-8?B?Z2E5UEsrenNLaFFxa0RLQXIrb3VZa3Vqd1JtL0ZGTVRTeUtHR05WU0FsSHpD?=
 =?utf-8?B?YXg4eVV3dDJzdEVvR3RFNUdwSjQvbE9Hc0ZyYVRWU2hHUUZObnBvVGU4c25p?=
 =?utf-8?B?dUNVYmJ6VVR2OWxMZTF2blNhMzJGV0pnUDNBYmlzUVFyZkk4cG5TNUJoMFB5?=
 =?utf-8?B?SVRFSGkzbWhGWG9aSlM2UmtXa3pqRk9jSkdaSFNJdE9yck83S2VPc0xNTG9k?=
 =?utf-8?B?WlYxckFXNmltOTFQL2RIOS80QnR5V2ZpeFgvL05Ka3lEdW5CNlo5SHdzVFBi?=
 =?utf-8?B?SVZUaDNkQzZaUWcxa2lYM3ROeWF4MVMxQ0lzRzZBMFFZVzJVdWh5NFBUK3Qy?=
 =?utf-8?B?YmM2cFJ5Z0dQV0pxQTdLM3BSaGhFM09UQ1FoVVkyajY5RW1jZVg4Y0Q4MjRq?=
 =?utf-8?B?VXNzZTRDeTI4SUIwSHlOQ3FmSkNrYWxvZTMzVklKSVo1bmVBYjNJem5QZWtY?=
 =?utf-8?B?NktjVWdqZFFQRVhiR2hnZkdhUUl3N1krZUdWSnZqcHlmUkY0Z3FHTkRhdkFq?=
 =?utf-8?B?NzV2ZzJ6cTJvdVR0cW9ZMXZUemc3aEEvdUE4akRGZWNuZWROdUdCd2crVFVP?=
 =?utf-8?B?bjNzL0xPbTVjRnZ0YWpPeVNOQ2FvVE9ONk1qUWtFZUFNR3d2NkpzZ2hGbjlx?=
 =?utf-8?B?eVEvUzRHMDZ5MlgzOWpMNkpPZkFXRU5RMWdhNGRhWFpHbm80aTlPTC9vY0dV?=
 =?utf-8?B?eWd1SlNNWVhiRy9qRFJ4UTAxcGlZZU9tcTFjQ3I1WE94NUV1YXo3UEltMTNN?=
 =?utf-8?B?YW1rMmxrNVZPYWNkRXlkaVlzdmNJVXBGUnY5NUV3RGprOWQwZ095WjdZbjFH?=
 =?utf-8?B?aEJmYTFacytGTnBReElNVTA1eUt5dnFRN3dPckNSbmtGY2NOOFJMaWhNelJD?=
 =?utf-8?B?SVM1bUR3MmgzWkYxckl5RGdsTXlIQXB4YWpHWEw2YUZaY3F0WVgwR0RNck4z?=
 =?utf-8?B?eVhNK2R1S2ZadFlna0RMZEMzaXJ2N2F5VGdQVzJoZUhvTmh4NEQ2bkZDVXpx?=
 =?utf-8?B?NGx1VzFJSlIzcVRCYlEvVWsveERPMDBVLzVwSUVFZm02anVzYVgvY1ZEU2pH?=
 =?utf-8?B?NDNoNk9XaW03T3VPOGRLZndRUWNEeXdEb1RHKzJ0Y054d0dFYU5TZVcyc0Zr?=
 =?utf-8?B?eWxPVDZJaTlrZGpwZkQ4OHhXOGJCNVNjU0Iwekp3bmdqZVpCOGM4VUNrbXFV?=
 =?utf-8?Q?UUaZgHAhNchRCR1giFE1awtPr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dab5008-1dd0-48c7-3486-08db89a97eb0
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5713.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2023 05:15:27.4700
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZjqCD7g23QuzDpG4jEb9wRR/+vUwOgYu0t6ZkciUIGQTkVR3bGyFiztC2EYgvnIjX6oSB4g717PacDnjojGiEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6034
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/20/2023 9:20 PM, Ian Rogers wrote:
> On Wed, Jul 19, 2023 at 10:23 PM Sandipan Das <sandipan.das@amd.com> wrote:
>>
>> On 7/19/2023 9:42 PM, Ian Rogers wrote:
>>> On Tue, Jul 18, 2023 at 11:58 PM Sandipan Das <sandipan.das@amd.com> wrote:
>>>>
>>>> Make the jevents parser aware of the Unified Memory Controller (UMC) PMU
>>>> and add events taken from Section 8.2.1 "UMC Performance Monitor Events"
>>>> of the Processor Programming Reference (PPR) for AMD Family 19h Model 11h
>>>> processors. The events capture UMC command activity such as CAS, ACTIVATE,
>>>> PRECHARGE etc. while the metrics derive data bus utilization and memory
>>>> bandwidth out of these events.
>>>>
>>>> Signed-off-by: Sandipan Das <sandipan.das@amd.com>
>>>
>>> Acked-by: Ian Rogers <irogers@google.com>
>>>
>>>> ---
>>>>  .../arch/x86/amdzen4/memory-controller.json   | 101 ++++++++++++++++++
>>>>  .../arch/x86/amdzen4/recommended.json         |  84 +++++++++++++++
>>>>  tools/perf/pmu-events/jevents.py              |   2 +
>>>>  3 files changed, 187 insertions(+)
>>>>  create mode 100644 tools/perf/pmu-events/arch/x86/amdzen4/memory-controller.json
>>>>
>>>> diff --git a/tools/perf/pmu-events/arch/x86/amdzen4/memory-controller.json b/tools/perf/pmu-events/arch/x86/amdzen4/memory-controller.json
>>>> new file mode 100644
>>>> index 000000000000..55263e5e4f69
>>>> --- /dev/null
>>>> +++ b/tools/perf/pmu-events/arch/x86/amdzen4/memory-controller.json
>>>> @@ -0,0 +1,101 @@
>>>> +[
>>>> +  {
>>>> +    "EventName": "umc_mem_clk",
>>>> +    "PublicDescription": "Number of memory clock cycles.",
>>>> +    "EventCode": "0x00",
>>>> +    "PerPkg": "1",
>>>> +    "Unit": "UMCPMC"
>>>
>>> nit: Why use UMCPMC and then rewrite to amd_umc, why not just use "amd_umc" ?
>>>
>>
>> I followed the convention that has been historically used for AMD uncore PMUs e.g.
>> the "Unit" for amd_df is "DFPMC" and for amd_l3 is "L3PMC". I do agree that its
>> simpler to use the same naming so will change this. If you prefer, I can send out
>> a separate patch to change the unit naming for amd_df and amd_l3.
> 
> Thanks for the explanation. I don't mind but it is nicer to have fewer
> renames imo. If we get rid of one, perhaps we can get rid of them all?
> Perhaps merge this and follow up with simplification.
> 

Sure, sounds good.

- Sandipan
