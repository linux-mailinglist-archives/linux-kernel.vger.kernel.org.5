Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FF5D7D567C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 17:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343767AbjJXPci (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 11:32:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233646AbjJXPcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 11:32:36 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2075.outbound.protection.outlook.com [40.107.94.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7640B90;
        Tue, 24 Oct 2023 08:32:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jq4iUoq6+H+bKTHUnXqfSJG33FVVpTxHhjHzpSmo1Xs4ZEJ+kFGz4IadxqgR16oO452gp8MXdqWTvLo82FwjUCYlNJ8OZXHgDNN2emBNttDULunXap7XjMc3YTArvP/2+ChN1kWUGXwtvQ65lvDQ+or2pz1V7a8aTasCHQz6cuoRRgWAKVdCmFUxLVEgTVJ2hCVgeDtX2EtuhyU1gCCSduiIFpA6C/uhbZp96xLsX49MCV6yN++V7vIk3yNfv1NICWKrUSrHogh52ZqEqSxrSTG43BxuuXPjrhwJru/A79QnzROnyY5nF/jxorj4zOUbYjLGu0vaFYqjNJkiH7lucw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+mk2U8IOVtyqjTx+aJO0YUULtSCQZLaKVbpWfeLD3c0=;
 b=GgdD1reuPTnm0h/DnobnDZGBg6uIh0rNwUWfqyVCQlS4UGq1/lw7zJV0zBRwwGnZ8lH/K3u7SoTy7FFHMBBTnU8hm573hsb2ja0s239+QO822lXKG5wEXHnX0AxNkt9nlZRcF4QCaqc11TfOH0qYDfbeDEFw+My2BTnzfqLBHSC/ue3Gtrtxdu2Z/xSOkXbm5IF5n3zkPT/bb56v5qOs9/tlBAlqqrDrbII22yvpyD2BVzCQ2lYH1yx/f5Ds+WzuVbqtkygitIDcoQhqDlVEnkGrkGRckZlvwxp6OBRDBgUGj9/KYB+KNrFviX11iW6qvu7ZztqKD2BveIVo8Fu8eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+mk2U8IOVtyqjTx+aJO0YUULtSCQZLaKVbpWfeLD3c0=;
 b=aahbz3iyDi0FGbenJiOolYDGU6fHtdooUskQ6qr5ir2L6Iyf00M8jiBJBVAHbFmtRXJ2j1SmSEa1ZDzO3kSd+jtd89PCQxeRTlX1emXoGOPss714aMKbXT6DqCsPMonhQ4bianjHR+F9V8nMGHASQ+VVQ2I3cSmPXYZ9aohLxds=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by BN9PR12MB5051.namprd12.prod.outlook.com (2603:10b6:408:134::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.31; Tue, 24 Oct
 2023 15:32:31 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a%4]) with mapi id 15.20.6907.022; Tue, 24 Oct 2023
 15:32:31 +0000
Message-ID: <38ea48b4-aaba-4ba4-84a1-e88d6cb9df94@amd.com>
Date:   Tue, 24 Oct 2023 10:32:27 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] perf/x86/amd: Don't allow pre-emption in
 amd_pmu_lbr_reset()
Content-Language: en-US
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sandipan Das <sandipan.das@amd.com>,
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
 <ZTd6BYr17ycdHR2a@gmail.com>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <ZTd6BYr17ycdHR2a@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0130.namprd13.prod.outlook.com
 (2603:10b6:806:27::15) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|BN9PR12MB5051:EE_
X-MS-Office365-Filtering-Correlation-Id: 2690293e-491c-4a8b-e900-08dbd4a66fbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8SRFg9kSrQ05LIwE3RiMR0+4/JWqDIiFN9IeAthu2MR2FKsOUtQULEZCqP7Vx6f9KyerGGAobWLI0Tvx8p0mgyRwNauiBfvFa9h7qvn8/mfV16RAOp28liIYOLDgHQoAsKDScKjc2lr41NnWMw8JNEDGXiJiKEUIlzuXdglV3IptRhpFfdGpsc7YFzfsLtzGeLgGaUZkfTWCXzrYZVprtrojGLC2PIZIhMCXZPcLXLYKXTFQ4sHVywYjZg2PEjSHYVTVTTA4CqrAPyhQlkkjmNm80JfjF05yvjN9CZVaxkMRsCSOZ12nHswfjUWD7X5vqTnPArvcNuYuhJMjo1C/eh9R6oLcmrKCQnP9HObmkgzqNYgQtJu/0iwnbPNQXXhHR4mxrEp9L++a1Uy2GRJIWZGQdLh3umq6mCHim+/V5V0/KraxvnYiQ/VZeGMiecZr1vnt3sAKOYfXdGHNlxdsFDsZ5O1wsxBYP3kvkjkbZ6DYlNvbkeAtY+fXWlaOJXG8qZA0IKxKlqDv2jMAQZYdXlQpd8rcylrN44W5UY0NuxrPIhT7i01W8f51RYEPyuO3IIoO90Ppu+TW+6kU3fOqW7bvogD1vr7i+rezZxIjrLGHU62GgU4oN/8kE3zZ4gaD1vUDgj0bH9Xq/c57tUtUiQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(346002)(136003)(39860400002)(396003)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(31686004)(83380400001)(7416002)(44832011)(2906002)(4326008)(36756003)(8936002)(8676002)(53546011)(2616005)(38100700002)(26005)(5660300002)(6916009)(6506007)(31696002)(316002)(6666004)(478600001)(6486002)(6512007)(54906003)(41300700001)(86362001)(66946007)(66476007)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T1JPMEp2ZGlSTk0rNUtEOGVHT3dMbUFsV2NjMVh1NnRNZzdKRVYyaGcyYkor?=
 =?utf-8?B?eDNiaE52NVBHZ2w0ZGhhSDlkZUxaY1dSYmpOZjNnMXk3OUZ0eGh5eG96NGli?=
 =?utf-8?B?NXpnRVN5R0FzRTZibXBEbjMzVDlGVXJTSHU4UWZyc2t2NHdQVXJPSDEzV1N1?=
 =?utf-8?B?UExZWVprSHZmb2RSVTg2aE1qdm81dW9sbS9aWnVIemxyL1h3ZXdDZHNwYmVi?=
 =?utf-8?B?aFNPZ1o3bVpPMFk5Z1VURDBDYlgzNnZJbnI4aDA5NDdGemZBL2hRT0xuYlUw?=
 =?utf-8?B?VURuK093eGZWb3V6ZEd4aDN1YzFVdmpJRHJJWWcrVENHOFNJLzVURU1nQzM0?=
 =?utf-8?B?NUxBdWlkZ1BiTVdjRGVZZ3NacyttRFFqSmtTWUtKZWRJbHRTWDJPbHVocU9a?=
 =?utf-8?B?S1NBQ3A1cUpNVEo4NFFYbzROckVJeTdCcHd2T1BmdnQyMi9lYXVVVWNHWnpn?=
 =?utf-8?B?K3pKbjJ1Zllobkc0UzM3Wnd0R2kyUmNVUS9BU1BJbXFTRFg5Qi9yZ0xiS1Zu?=
 =?utf-8?B?b1AzRmtPWVFmU2tYTk84aThVYmlqUERPVmhFT0JtZTBpOTFvSzN4QkFWNGtx?=
 =?utf-8?B?YTYyY3NibktKaGlBVHdmK2RXbHk5d1doODBRbzh1dGJtaHp5VDlqcUExeVlK?=
 =?utf-8?B?RUkwWW03NmF5bkVadU9wOCtLZWtLbG1aZEJFL0FWZTVwWFJMbnpFUUdQdFYz?=
 =?utf-8?B?NkhQcnVZem5LNFlUY1cwSmkwaWxtT3lWbGxoZTBsMmlsNDVyNXd0K3g1RmZJ?=
 =?utf-8?B?VXBWQXZaTnpOMVVMQWgyaGFVY2ZPbE40RjZuMDNYb1JVNW9EMEZ3Umd0TUVy?=
 =?utf-8?B?bHp4UHF6bjM3WDdVK09rN3pBQ05UN1NmdUd1UXZJdmI2c2Y2ZVJhNGdXcHJJ?=
 =?utf-8?B?dnpDaHdlYUVTakhBcWNCSkpXZDIxYmpSWEJOS3RyeVJqYVpSRWxTV0VyWjY1?=
 =?utf-8?B?azd2RjZIMGdXeE01emYySUtnTTY2OGo5R0JMN0tqTVY4Qmg1cG9VOWE0M1pj?=
 =?utf-8?B?eEt5WEFNNjVRajl3aWZoaUtkSjVYUWtVb3Q4ZlNiRytPVDR5cWFDb21EYng0?=
 =?utf-8?B?U0ZwM0JnVXVOZDVTMUR3K01DKzV3b1Zoa01ZdzJVdVBHdnV1NEZidC82eTI4?=
 =?utf-8?B?cW1xUGhaTmF6V3dsd1c5RzBUcTVGUjdQZVM3SDY3VDBVN2hvK1BIOGJsZEQ3?=
 =?utf-8?B?enJKdUdYUHp0LzBqTmxFdmJEcUdiU05Rd3p4ZFJvSyt1VS9PT3Z3cjdaMzk2?=
 =?utf-8?B?SUtzMEg5MlhwZXJjMkF5a2tENk91Y2ZHYm1VSVVSMWJWdHdkMG8vdEk3RHBD?=
 =?utf-8?B?bWJIelpBVDdqeFBFSExWOGNsWGUya3Q4aHYzMFZuTlZkREpqUFYvWnlNalNF?=
 =?utf-8?B?OVpTVXB3LzJveS9xMFd1MGhSTUpuMnBxZjRQQUs4NFRPOEdqdS93RjcyMGhN?=
 =?utf-8?B?QkUrQUgzeGF5VWlRYVlMZVJNaWQza0V0eURJUU42K1BmS0IyQWx2bytNYlhw?=
 =?utf-8?B?SkhwcStlMTZOUVh1eVo2b01kaFVuRkFYWDRrOEJ6YnNQMUNWeW4ybTByZUI4?=
 =?utf-8?B?QjR3U0pGaEFKTHBaY0d4Rmc4ZmZIS1hrSjZMU0VSN3JNMVNHK1BuelgvQVQ2?=
 =?utf-8?B?em1VK0hQdzJkUTZWYUcvOFBJSWUvU25rV096Nmx3aGxiVDl4U1VxN2lUSXFT?=
 =?utf-8?B?TE9YQmJvZi82MXVWM0xxNzdsS2J4TnUrT3AzYS8yQWlZeHZEeXMvcFdpQUlJ?=
 =?utf-8?B?V2VSa21Ma2Z3emdXSldYRGJhY3AzQisrZ3VJN3psQWZjMVMxMEYzRFJLSGFW?=
 =?utf-8?B?QWlWL0FhL2ZSTG1Sb1Qza3J1RlorV29MMmdNNjRDeG1XSDh1QmhtOVltMTZi?=
 =?utf-8?B?c1ZoRmlvcGE2bWFHVHVKdGZmWloyOVgrZG1Edk5BVkZIS0ZDMDRGOXZNakY2?=
 =?utf-8?B?dmxCd2wrdG9BMFNwaE01RjBTVkxRa04vNUx6aURWNUVWSlZjVXg0R1lCc3ZV?=
 =?utf-8?B?a1lmTTF2akFGV2JoSXI0VHJDWnJwRzFlTVVsU0JHZkFSVEdpc3pmT2tZRFRz?=
 =?utf-8?B?Y2NkZVMwVTNYQ0UxSHZYd21nbEdoRjZMdE56U2x6K1VVdDBHa2N2RHdvV2lq?=
 =?utf-8?Q?m5jtWk3yFtItp94DtcTSp4ofg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2690293e-491c-4a8b-e900-08dbd4a66fbe
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2023 15:32:30.9914
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gOWeqM7nciS1mq7p28uJfW8CLhJz4kAokILgakvy7gJcsciWW+AqQEbaIXFM1bYi7YEmySbZsyx/YuPBfe362g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5051
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/24/2023 03:02, Ingo Molnar wrote:
> 
> * Mario Limonciello <mario.limonciello@amd.com> wrote:
> 
>> Fixes a BUG reported during suspend to ram testing.
>>
>> ```
>> [  478.274752] BUG: using smp_processor_id() in preemptible [00000000] code: rtcwake/2948
>> [  478.274754] caller is amd_pmu_lbr_reset+0x19/0xc0
>> ```
>>
>> Cc: stable@vger.kernel.org # 6.1+
>> Fixes: ca5b7c0d9621 ("perf/x86/amd/lbr: Add LbrExtV2 branch record support")
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>>   arch/x86/events/amd/lbr.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/events/amd/lbr.c b/arch/x86/events/amd/lbr.c
>> index eb31f850841a..5b98e8c7d8b7 100644
>> --- a/arch/x86/events/amd/lbr.c
>> +++ b/arch/x86/events/amd/lbr.c
>> @@ -321,7 +321,7 @@ int amd_pmu_lbr_hw_config(struct perf_event *event)
>>   
>>   void amd_pmu_lbr_reset(void)
>>   {
>> -	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
>> +	struct cpu_hw_events *cpuc = get_cpu_ptr(&cpu_hw_events);
>>   	int i;
>>   
>>   	if (!x86_pmu.lbr_nr)
>> @@ -335,6 +335,7 @@ void amd_pmu_lbr_reset(void)
>>   
>>   	cpuc->last_task_ctx = NULL;
>>   	cpuc->last_log_id = 0;
>> +	put_cpu_ptr(&cpu_hw_events);
>>   	wrmsrl(MSR_AMD64_LBR_SELECT, 0);
>>   }
> 
> Weird, amd_pmu_lbr_reset() is called from these places:
> 
>    - amd_pmu_lbr_sched_task(): during task sched-in during
>      context-switching, this should already have preemption disabled.
> 
>    - amd_pmu_lbr_add(): this gets indirectly called by amd_pmu::add
>      (amd_pmu_add_event()), called by event_sched_in(), which too should have
>      preemption disabled.
> 
> I clearly must have missed some additional place it gets called in.
> 
> Could you please cite the full log of the amd_pmu_lbr_reset() call that
> caused the critical section warning?
> 
> Thanks,
> 
> 	Ingo

Below is the call trace in case you think it's better to disable 
preemption by the caller instead.  If you think it's better to keep it 
in amd_pmu_lbr_reset() I'll add this trace to the commit message.

Call Trace:
  <TASK>
  dump_stack_lvl+0x44/0x60
  check_preemption_disabled+0xce/0xf0
  ? __pfx_x86_pmu_dead_cpu+0x10/0x10
  amd_pmu_lbr_reset+0x19/0xc0
  ? __pfx_x86_pmu_dead_cpu+0x10/0x10
  amd_pmu_cpu_reset.constprop.0+0x51/0x60
  amd_pmu_cpu_dead+0x3e/0x90
  x86_pmu_dead_cpu+0x13/0x20
  cpuhp_invoke_callback+0x169/0x4b0
  ? __pfx_virtnet_cpu_dead+0x10/0x10
  __cpuhp_invoke_callback_range+0x76/0xe0
  _cpu_down+0x112/0x270
  freeze_secondary_cpus+0x8e/0x280
  suspend_devices_and_enter+0x342/0x900
  pm_suspend+0x2fd/0x690
  state_store+0x71/0xd0
  kernfs_fop_write_iter+0x128/0x1c0
  vfs_write+0x2db/0x400
  ksys_write+0x5f/0xe0
  do_syscall_64+0x59/0x90

