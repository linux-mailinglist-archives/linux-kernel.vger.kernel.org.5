Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB4FD7D6A59
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 13:47:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234559AbjJYLr2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 07:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232688AbjJYLr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 07:47:27 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2050.outbound.protection.outlook.com [40.107.243.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1522812A;
        Wed, 25 Oct 2023 04:47:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UPX8JqEqBaUtfCgboWpd4K2TYz//9W13yGE8arBvl3QJEMvgNPJzLIMWn8OxOivvCx22UdP3jkqKXHiCgjbV6oWT44K/qRohSAZLyWmkoQKOwsZ8bml+FNkzwu57kcXGYBHE1UD+q4vhl0VxUGVZthXpPH9eT59Hi+UrPF5uAyv0N36EIAomN8lmY915tPNhy4Tdyo9Ie1kPOOmrrfB/HEjMAeK1fYSG64qVGtIovc4+1B+Vy0EyMwn9xY6G1oiJI9NT/IDHUWew9bjfpD1vkk1sUBcYd75EyNHARzlEhwyjf8NiuMjkPsBi8MmOqHQyqtPjNZtKqiGEChT27wV1Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W39y/NRyTchyjhLeEH2HS2N2eDNQ72xNMBZSFA+IfJc=;
 b=lx9gE9eg08O3N3HTQV60cSmBecJ+LCfg50Og2XNZqAiUrb24f63SiMr7D+vLz5aEor5P7nnUQCq7y0WYmL811vVts1x/A6H2RvKqYqw6Ej7V+Ovo5BOxXRNxsJg5y3OOvneEWlNnCA9NPKFA4CAI/mfMAsAPUSqlWyCEDi92w79OFFlDkOEAPulfZ4B1mWGXDBCMX7ajGkfzicCHAP7S6HYKp/DQm/tP0aZZYbOaIEnS+THzE58s/Ff5CVvGlQLk43XUS8a29MFBc7rZHIXy87fMQNKLYl2LGqLwpKO5YXwUSbCMZHNww42pcXDuOGJ9zXOjYgyOBm7dCugWz4ZTZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W39y/NRyTchyjhLeEH2HS2N2eDNQ72xNMBZSFA+IfJc=;
 b=l4eK3o9t1foXN6qxBUbW20Jban957TR6j8cG6iJwhSKsXbQ0hzHrVCI18c+E/XbKN/nBoVoWsYMMq2CJPphBDGrSBlPZGX0v89NVYR0TsU5Uok0KEc1mtakKtWiClJWg03g9DHpMfXuFqHrAigpmTsI4KERjCTDR9OMj2FJ+sgw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5712.namprd12.prod.outlook.com (2603:10b6:510:1e3::13)
 by SA1PR12MB7365.namprd12.prod.outlook.com (2603:10b6:806:2ba::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Wed, 25 Oct
 2023 11:47:22 +0000
Received: from PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::f2fc:3e18:9e90:d060]) by PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::f2fc:3e18:9e90:d060%5]) with mapi id 15.20.6907.030; Wed, 25 Oct 2023
 11:47:22 +0000
Message-ID: <fe834675-a745-42ba-ae4a-97f003f84d10@amd.com>
Date:   Wed, 25 Oct 2023 17:17:34 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] perf/x86/amd: Don't allow pre-emption in
 amd_pmu_lbr_reset()
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>,
        Mario Limonciello <mario.limonciello@amd.com>
Cc:     Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-pm@vger.kernel.org, rafael@kernel.org,
        pavel@ucw.cz, linux-perf-users@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>
References: <20231023160018.164054-1-mario.limonciello@amd.com>
 <20231023160018.164054-3-mario.limonciello@amd.com>
 <ZTd6BYr17ycdHR2a@gmail.com> <38ea48b4-aaba-4ba4-84a1-e88d6cb9df94@amd.com>
 <20231024155939.GF33965@noisy.programming.kicks-ass.net>
 <47518940-2803-4a6b-88fd-8cfc872b4219@amd.com>
 <20231024163038.GC40044@noisy.programming.kicks-ass.net>
 <20231024163450.GB13938@noisy.programming.kicks-ass.net>
From:   Sandipan Das <sandipan.das@amd.com>
In-Reply-To: <20231024163450.GB13938@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN0PR01CA0030.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:4e::12) To PH7PR12MB5712.namprd12.prod.outlook.com
 (2603:10b6:510:1e3::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5712:EE_|SA1PR12MB7365:EE_
X-MS-Office365-Filtering-Correlation-Id: 50bea83e-1d6a-4b91-5440-08dbd550266b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9iyDs5BYelwfXRfrKEA6HX/+w7jR7/I7jIVV8hOt+el4LZ+UfNZ42Ife9M7QoCz8JyBcPb5bHqpYXrrwL1/i7PpvcbvJzIjB0+0kg8phG+cLcYUv+MX32U93sW7mDt6g0lsZIJLvs8hkZYL7nm8Byp4reCaNlPdIWrAvmO82o1tjJry//34MhnF7VA2ZMwIgdxyetQ4MXJYFPBdMLAw6963owRduPwM0qy2RG5k17CAOmw1devvC49kPWHZq7aqhCpd9ajNpf4PtvKPBtnHlCmB3pbYVWPMDO0DCmKYSce+kW3dr6/it8Gpsz3S2UGSc+wKhWgAbrelxcdqWANGMhdLGtvJmqmzaEtgpwSy1iasHvL5AmNp9pY5O+mjGcy3Al2YgSnt1j8hAFId5JWoRiG1xRFX0o2htCO6RDiIqmyrLW9EMvMgeRCaICexRDyIDC+Pf8uVxNWfeMhvyFCVHF4UrTwJL6wljfmPmVRjK2iHYF9Q33C08wYdxdmwoM+N8E7n7FLfEbEMWWDXyCtNKcrm2DUT6irRI8gYkUrR7KHj8S11QgbQYNzAFRhq3iJbVzl3q6Za4dbn/Smd3pP6O4oVELXMEYBN26+uC87nlhhZxV3ZVWhxAbvizxhRILs3TVrEdzVmxy3xFGhKceOy8UQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5712.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(396003)(346002)(39860400002)(366004)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(26005)(31686004)(31696002)(44832011)(38100700002)(2906002)(86362001)(7416002)(5660300002)(36756003)(4326008)(8936002)(6666004)(8676002)(110136005)(6486002)(6636002)(2616005)(6506007)(66476007)(41300700001)(54906003)(316002)(66556008)(66946007)(478600001)(83380400001)(6512007)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S1lMTmtTR21YUjIvdU0xS1haTE9IL2UzNk1qWjg3WXlDaVU0YXZ6WGZBOHkr?=
 =?utf-8?B?c1NmajI3citWSmRUOVlSa0VIMU84QmhiN1NmZGsrdWpNSHB2RHZna3g3L2po?=
 =?utf-8?B?K0JEa3ROUVBCYzFmRGxub1E4N29HOExOK21OOGJta2VncHZxWGZISnhaUnkv?=
 =?utf-8?B?NXhZdklaUGdQYnVhcGN2clJuTXNVTkZqdW9rekJnUXdPaExwT1NjcDZ2bk01?=
 =?utf-8?B?YXpmaU5hQUlSZlJ3MTdWR0NCRk9yTTRRMFpwSXVvMWxMTUpEZVc2K0kxelAx?=
 =?utf-8?B?RUt0MXFFMHBEYTFkeEkwSjhYaS9sZ1c0OG81R3JWK3d1dFp4S0czQVlUM1I4?=
 =?utf-8?B?T2wwU29GTXNkbUFRQTVhUWJiNDFmYUdqNml6S2FBUm5OQmQ3UU1FRnZaOHdj?=
 =?utf-8?B?K1JGMTQwdUF2RFRTeUpzeDM1VHk0dU9xUmp1dlR3Rk45Z0hPZGo2TFRMZ0RX?=
 =?utf-8?B?VlFyRWsrRXRWSTZ3ODZld21ra0RuYjhHaXI4NWc5VDJNanpLbEhvRlA2dFZZ?=
 =?utf-8?B?RFprSS9QdUxpUG1WNnRxeXMrODhqbTEzOGZVNDg5SUVjcmJZLzFxeVdsN0RK?=
 =?utf-8?B?TVJrbWo5S0Zmamc5S0ZYZlZ1bkVKdC9HRHQyVWFuVnNUZUJzZW5mVVUwTzI1?=
 =?utf-8?B?MFVpbzBHYWtjMlNjNGo3SWpQRlBUYVNSd1cyOERFVnhadkwzdWJkZWpEKzRk?=
 =?utf-8?B?Z1lwOHZ1MHkvOUdhSHI3S1dPRTVZRzZ0TG5Jc0dXMmNndFhlUkUwOHhEZU5x?=
 =?utf-8?B?Nlc1bEpwNXp6cWdwcW1xRjhKZFA3c0RFUU9PY3JXcEk1bWtpaU1GVFJwS0da?=
 =?utf-8?B?VkVaaVZmbFlHdnZwNktZeFhPOXBMd1hmNUFKeTNhbDJZbUlFYTFYQ2NwWGgr?=
 =?utf-8?B?bW9WdkhpanFscmlyOFhuWmNkUDcrUlc5Sm44ZzBOT0tNSlpCbm9xempSbitO?=
 =?utf-8?B?TmVSNHY2TVpLeXNkbGtvTXl2cmJmUDdvZmdBT1ZVOGpSS2NNeExaOVJ4R1Jk?=
 =?utf-8?B?QWRKeWM5VFE4STF0d09URUlKU256UHdTaVVBbTJPUWE2Z0dreEdpVmZ6ZUxL?=
 =?utf-8?B?amlCdkNjSWRrbWZ2VVhBZ0l4SE5xd3h4WkpreXlzNFp2RkFTdm1WWnFyaE15?=
 =?utf-8?B?RVYrZTNVVlk2dFlPQVBtMkhzU0l0aGNVRlBqNnVDY2Q3Rkd6d1NrWWNISExa?=
 =?utf-8?B?MXlZZFJ3dFNQWHowSktTcGVoWnRodUpxSEJvRHBGM0RkbkdnUjMwSjVNSXhh?=
 =?utf-8?B?RXRKcVhXQ0JZM2RndUdLTFZtSFVPb0FOU0l1QTJWTm9BeEtPUEowZmZBSkFn?=
 =?utf-8?B?OVVheDVOa2lZUlRVank2L0FxaFRIL0VzV0NCZU9zTGVqK01rMjNMSWh6VEtU?=
 =?utf-8?B?UDNIc2JGWGNjS05iQTFhWk9mVDlMOFJHZy9sTzJPSDU1cytLWE14YjVKN1Bw?=
 =?utf-8?B?QlBSdUM4YUVIU0daY0pRSlVKN3RSVDd5VHR6SmdKRitwSk5OajJPUXk1N3pV?=
 =?utf-8?B?dHF0VU5SZ2FRY3drYm9zRTAvMmlUL1o5ajF2Y012U0ViekxQa00rOWcwam1I?=
 =?utf-8?B?Zi9YMmVadFo2ZHlvMkwydkY3Y0V2alBvNEdHOGdxR2lHVEVKRGowb2RJQ3Ba?=
 =?utf-8?B?aVJzOEZPUWEzb09wTEFiMytRZ1pRZWZURmFxVFNJY0ZlOUU0RVp6SCtpOVFl?=
 =?utf-8?B?OFkxczFQOXVUV2JieURtZkVhdlhSaTRIbWh0TmtLTzBvV0Y1WE53aFRoTEIv?=
 =?utf-8?B?VXVMRHpma0dBbzM1bWp2QStjazRjalhEWlJuVjU3cEFrR1Yxd1RwRmNUanN6?=
 =?utf-8?B?cFRWNU0zdk8rTDdHV204MmM4RUxBS1NVZHJiQ2FqRWFHWjdLRDZ1V2hYb3ZX?=
 =?utf-8?B?eHg5UnFrSzlJd2JPYjkwSjM0NW03L3IwN1E5TW5PUkNnLytSQmNtU2IzQldJ?=
 =?utf-8?B?WllldDlJTm05aUpTRUVaa1Z6MW9KcXd3YStWblJIUWRYaGJ5NmFJb0hERlRp?=
 =?utf-8?B?alRUMmpQT3pZL253NEYxS1ZsNEdtd2tDR2paS2RVREtBNjVjNTA4eUJHZ1Fz?=
 =?utf-8?B?WnBQR0RxZFVxaS9VVm9ibWJjQWp5ZmtYUHdGcU9UbkNYcmVJUGFONGVIUVh5?=
 =?utf-8?Q?E4XabQci/JC/V4T9qT8KI8jvj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50bea83e-1d6a-4b91-5440-08dbd550266b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5712.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 11:47:22.5091
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W9/ncSs0LoWLxIF/tHc4Lz7F8Sspu1LnrN3Jgsab6USXayLGYEw4JhSM0AufbOeGc8GlznVh72kGGw8ZPToPvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7365
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/24/2023 10:04 PM, Peter Zijlstra wrote:
> On Tue, Oct 24, 2023 at 06:30:38PM +0200, Peter Zijlstra wrote:
>> On Tue, Oct 24, 2023 at 11:04:06AM -0500, Mario Limonciello wrote:
>>
>>>> IIRC this is the hotplug thread running a teardown function on that CPU
>>>> itself. It being a strict per-cpu thread should not trip
>>>> smp_processor_id() wanrs.
>>>>
>>>
>>> BUG: using smp_processor_id() in preemptible [00000000] code: rtcwake/2960
>>> caller is amd_pmu_lbr_reset+0x19/0xc0
>>> CPU: 104 PID: 2960 Comm: rtcwake Not tainted 6.6.0-rc6-00002-g3e2c7f3ac51f
>>
>> Very much not the cpuhp/%u thread :/, let me try and figure out how that
>> happens.
> 
> Uhh, my bad, these are the PREPARE/DEAD handlers, they run before online
> and after dying. The CPU is completely dead. Running lbr_reset() here
> makes no sense.
> 
> Did that want to be in amd_pmu_cpu_dying() ?
> 

Agreed, it should have gone into the cpu_dying() callback. lbr_reset() is called
once from cpu_starting() so I wonder if its necessary to call it again in the
CPU offline path.
