Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 176C67A0274
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 13:22:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231851AbjINLWb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 07:22:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbjINLW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 07:22:29 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2069.outbound.protection.outlook.com [40.107.243.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1212E3;
        Thu, 14 Sep 2023 04:22:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XRH9AeAhlhygpXLNN9N6wwV0Boqv8XpqtzxqYchGSjysnz16j5HHfehor71y01u15tfGTpQeDWGekmgb3U38wLht73unO1fL0RBjvrFEwvzFOsDLNJBux/DqVM0G6FyYTj3HCD5uU8va+GVz3dsCz78EiphLBJsxzHZIBqGzLkXuPzB1zs+zjojKUuINyZb79/Iltb1gwACVjtHWyp7rNEycP3cJg7UBnbPx4sxKLysCEPX0G3ud8uQM6eM0+kewQ1eErdw39BlN4MGlyc0EwXS9p8bLdINUpTHIMZGz+hLUrX8kVLaByCDCtsLuVG+KhmEZmw2iKF1XxYBmoECF9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QUj3Jf4hi+Q6I/wCHjDMUH+uZiI7ksQ4tfXeA0VibOk=;
 b=Jp072C4v8cHBGEQhGo7lfOHtgKRBlK/RFqZgqNfTdCz/bpwIS7q/QL3pwoKc4OEOvhquTul4D+OJlwt2cTvoo3x2dXJ4P2PmEiy55xNQmKOFSmKI4nDPMETPFgjqYEo53Og+a01za/AJBZOy3wHfPekPRTQCXhZ+R/vM1BooZH2xdKG3LSQKOzCjKNqNdiSDidwxf85FKy3/ZgT/AOZ/oLrMO1/FHYUMiSEZhkbCIflS34kuXmdVAT8I2kNAOYIAeeWlc/gnc9iWOsdFXr/USSofX8yf/HkcUplz8tpIUNuD3uyaSnr4qvfS2Rw6GVLkcwJKjk2eOkKcD95fijzJKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QUj3Jf4hi+Q6I/wCHjDMUH+uZiI7ksQ4tfXeA0VibOk=;
 b=XnawnQzVR9Z6HY+gN/5tK5IomZf4yiKicVGdtNYnmDqQwX+d2DNBlRVC2oIpHs/mXXyKOVMlM0GE3eRAMMNFa8fTNTG+Cw2oKyz9eElySjNaka+6eUsM1DcdaQ8jSVRxXoZew4kaV23aK3Q9ILcvMZJjm/AtTFG/VExFwWkQjKc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5712.namprd12.prod.outlook.com (2603:10b6:510:1e3::13)
 by CH0PR12MB5058.namprd12.prod.outlook.com (2603:10b6:610:e1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20; Thu, 14 Sep
 2023 11:22:22 +0000
Received: from PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::a285:eb6e:8fc:7cd7]) by PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::a285:eb6e:8fc:7cd7%4]) with mapi id 15.20.6745.035; Thu, 14 Sep 2023
 11:22:22 +0000
Message-ID: <b1cf5990-1019-49ea-a1e8-e22410922801@amd.com>
Date:   Thu, 14 Sep 2023 16:52:13 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf/x86/amd: Do not WARN on every IRQ
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>,
        Breno Leitao <leitao@debian.org>
Cc:     Jirka Hladky <jhladky@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, leit@fb.com,
        dcostantino@meta.com,
        "open list:PERFORMANCE EVENTS SUBSYSTEM" 
        <linux-perf-users@vger.kernel.org>,
        "open list:PERFORMANCE EVENTS SUBSYSTEM" 
        <linux-kernel@vger.kernel.org>
References: <20230616115316.3652155-1-leitao@debian.org>
 <20230616132954.GG4253@hirez.programming.kicks-ass.net>
 <ZQHiJxHSSGNk+ul5@gmail.com>
 <CAE4VaGBXO5Joynan_o13XpT=mNrwt4D84NTZF6H62GXJjpMbBA@mail.gmail.com>
 <f06ef3dd-dd71-4ba4-a4fa-18a08788c035@amd.com>
 <20230914091234.GE16631@noisy.programming.kicks-ass.net>
 <ZQLSw6PeUbV+p2gH@gmail.com>
 <20230914111845.GF16631@noisy.programming.kicks-ass.net>
From:   Sandipan Das <sandipan.das@amd.com>
In-Reply-To: <20230914111845.GF16631@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0235.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:eb::13) To PH7PR12MB5712.namprd12.prod.outlook.com
 (2603:10b6:510:1e3::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5712:EE_|CH0PR12MB5058:EE_
X-MS-Office365-Filtering-Correlation-Id: cf458640-39f7-4f5a-e6b7-08dbb514dd50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NUw3J1/s/guMVOfRkBLB0Fnepw2/Um9mGHc2qQ0JHE2i9NJkEi615a9H2f9p3sdOF7Lc0Cf/oFnMyvbtHawYnsFGoGJwJAYMqbWP6COjgGbRTlVLNPtQzGPa68i6JdDIMuVVmq/VZmOrj6tK6rZgkmF2eXvhCpFCSFE0FRsOZQToocVZZeNzmpznOxzGZNbykr2NJaUtgj5eIOSHhNccjqnYzGNqcLvHjUJpCzk1e8NpQRKpmqxlDdOos498mokdNLy8naO1rt8ywGNyZIMHc+O8RwwGLq4k4I04heiqO0onKoCE3i7Eadhv45GTdQEO3m8yDtceqwB1hRU4wX6LQv8gjf/NO2LJD2QuyV4gsR+gpP4wKIGy6fprZX7tf2EZZBZelxh0ldC85c2adMFGzJ6eJtYurrMBeqRnmixe2RmUiu0M83xCcIaCneI1cJR1JVasczBLdk9U2DFVKL/otj12Iou16h5BqMpTYnDl9W7+If5LIzzRfxlq5l/Ec4OXgqEAdwXRZ9FpBCR9aDKY6xRYzjtN03TuItHC4LkFizO3o2CO+RU8Y22AzG25O6QIEwcmFfiQIUPX6+oaFL8azl8BSdHALg07ES0Kgl39+BUdGErXcvIpcgf5SGCGnYieJxPeVDG7spQA10bVnaEEKA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5712.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(396003)(136003)(366004)(346002)(451199024)(186009)(1800799009)(66476007)(4326008)(66556008)(66946007)(54906003)(31696002)(41300700001)(86362001)(316002)(8676002)(8936002)(31686004)(5660300002)(83380400001)(36756003)(110136005)(38100700002)(7416002)(478600001)(26005)(966005)(44832011)(2906002)(2616005)(53546011)(6512007)(6666004)(6486002)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VU1VbGFvWG1aSlhFOWVRd1ZmM0NMWkNtaGN6dXIvRjd6ZFQ5ZTU2UlVkWkRa?=
 =?utf-8?B?US9SYTZObXJuVC9IK1RqS2lHYi82MmIvWjFXQVZiRFNDVC9TaGJtellxalM2?=
 =?utf-8?B?NmlpZEhuaU1OK0dROTg1T2p3dVVUSkQyVURxRTk2SjJtamVFQnN1dlBNZlkr?=
 =?utf-8?B?QkgxYTlwREwyV2piRVBZamtzcDhNNG5XQUwyamtrUXVVUS9mNS9SL0xNR01Q?=
 =?utf-8?B?SEptR0lTNTRGSk9pUjBOaTlKYm1jVUg5KzlndUdUVlNhbmVKLzdRcWcxVUE4?=
 =?utf-8?B?U3pVMTdVOUU3eXViKzlOak1IS1pCSThwL2t2VlZRUndOdVFYd1A3R01ieGtk?=
 =?utf-8?B?YlJ1TmxKNTh3dXlkR29jYVQ1RElBdkE4eUp6NGNuQjB3aS9EK3o5aVBpVml0?=
 =?utf-8?B?TDFadEdzd1JLcCtsN2wzK0ZvNmdjdUtUOC9sMTlsK255Z1F3Q1REYmhrVUNL?=
 =?utf-8?B?YlpSZU9CZnU2ZWJhQnluczVzaC9mZWNDeE5oUVBubm9VMkJ0UnFYMFU5WUJE?=
 =?utf-8?B?eU1Lb3RycUtKNUJtVEI4c2taWHZxOE9zU2NJYnQyeFA3Tk1NaU5tYU9GSmlJ?=
 =?utf-8?B?S1JySWlmY254NDVMNWs5Y1hvdzJRalhxVnl3M3lqYjZxcCtaaDQwNyswY2dY?=
 =?utf-8?B?UnUwaG5hNXg1UWpwVEc3cm5jdXpLTjhXNzNHOTBpZjhnSkViT3pucE5rclp2?=
 =?utf-8?B?cVdqWTM0SzJlamNBZUplY1puL21sNDNTMVgyYllNcjdYbXdBaVV3WC8raGJw?=
 =?utf-8?B?akthZDNCazBqYjI0bjdWRTFzWm53WGpEK2t5bFJZZlo3RWQ3dTdMeTJDcVlv?=
 =?utf-8?B?YkZBSmRBM0VXQzh1WngvYUhTSGFBK1RINURFY3I5eXpqMkNOcmpyYW5jSDVt?=
 =?utf-8?B?VXc5VjZORzFaNGg3b3VLTG55SmpGWDUvY0gxaGdRaVl2T1AvTWp1S1R4bG93?=
 =?utf-8?B?ZTlkR3IzbTNrZ1F1Z3o4TzFhMzdicWZRNWw3alI0Z2pNZTU5SEs4ckw3T3dr?=
 =?utf-8?B?MytCQ05LZVdPNFcrNGpLK0NzNG9yYU5SYjlZNVdvamZmWWV5ZDB4MmZCUXcr?=
 =?utf-8?B?ZE90SzNUWFIvZXZSaXFTTUQ3TzV0UzRiTHJ5OGI1dmdwa3ZnV0JhK1hhcmZF?=
 =?utf-8?B?ZWYwV1I1RkE3RG1wQnRKb3IxSThKeWsvTGhhZE5nQVlnaTZVRmhwWkJPeXUx?=
 =?utf-8?B?bGlCNWZwSWZMQmd2R2xVVzBiT3JNdTJNcnJ3REZMRzFIK21uUHRzOVlxaHZ5?=
 =?utf-8?B?SE9QcmV3MTI1cUhNNUErM2YvcHBQeUI3OVJPdFdXci9qMjNZdFlxeFVqVXZk?=
 =?utf-8?B?NUlvMVJsUW9kcTJTY2hNcktqbXhSYlhFd1lWRWtyeHBCbS8rOHc0NVZBTTcr?=
 =?utf-8?B?SUpnVE5ja0gyQjlEL08vd1J6NkQ5cnBkVmxPaVRUU3VvWi9IVTlFYlBadUdu?=
 =?utf-8?B?OE5ka3NhK3Ixa2dyNjJ3TFJUYkxIZk52aGxUZlJpeGs5UnJzVnVtbENlUEMv?=
 =?utf-8?B?a1NkNXJ5Z0VjWjhHVFYvZi9OTHkzMzBDZWxoNENkbWl0cUZ6TElDZHhsdkZB?=
 =?utf-8?B?dzVleU0yWXZyT3lwM1ZvU0x0dlFKZUlDbXZSWjVVQU5JUVlSZ210bll6V2VQ?=
 =?utf-8?B?dlZveDJ1dnFLaHV0ZmJZek5KbXhWVjNvY2NMSTFOODVQd1lIdU1MSWZpSXRK?=
 =?utf-8?B?TFJaV1JkRHJCV1lsOVdMcmdWT2laZmFLeDBpS05mSHFwbnljT2R0OXo4ZmJv?=
 =?utf-8?B?ZEh5MDl3RlNiaitsVjd5c01OdVB0UDZ0Vmp5bmY4dk9FYXB2dzhDcUIwcjNX?=
 =?utf-8?B?dnlwS0RWdmo3UVBMTlJXc1JxOUowT2dUakdlLzg5OElBMHVzbzdROFIwektE?=
 =?utf-8?B?bUhRV01XWFlkQXpkUHo2N25HSG1BRWJuTU1OWVJGcEFlQnJ0ZU1CeTJmd0NT?=
 =?utf-8?B?cVVuU1Q1T1dQLzdMV0M3SHdLWlltdHR6WHYxK0c1d3pVY0tWVDlyY25tcVVH?=
 =?utf-8?B?YklmWUhMbnBhS1k2cm9NVGxseHFXSGY2REQ2MXRSZWplbjNGalQ0RlpITFd0?=
 =?utf-8?B?VHdOVnZMRjF4SS9oNms1WlpBUzlESzJVQW1pV0xtUG02WFZFakFSWGJtVUNu?=
 =?utf-8?Q?A5SNw2MVwbkXmdpnegZxhxwdg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf458640-39f7-4f5a-e6b7-08dbb514dd50
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5712.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 11:22:22.3756
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sZHvsfooJdW8jbS7A+R1Erj5atxRRokCTXI95mn9KM6uz7cqOIQOIcj58rT/1j7WAoUSe7xi+iTy55Xym/lctQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5058
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/14/2023 4:48 PM, Peter Zijlstra wrote:
> On Thu, Sep 14, 2023 at 02:30:43AM -0700, Breno Leitao wrote:
>> On Thu, Sep 14, 2023 at 11:12:34AM +0200, Peter Zijlstra wrote:
>>> On Thu, Sep 14, 2023 at 02:25:40PM +0530, Sandipan Das wrote:
>>
>>>> I agree with using WARN_ON_ONCE() to make this less intrusive.
>>>
>>> Could you send a patch that AMD is happy with?
>>
>> Why the current patch is not good enough?
> 
> Sandipan, can you answer this? I don't tihnk I'm qualified to speak for
> the AMD pmu and certainly I don't have insight into their design future.

Hi Breno,

Functionally, the patch looks good to me and I will be reusing it
without any change to the authorship. However, as Peter suggested, I
wanted to add a message to prompt users to update the microcode and
also call out the required patch levels in the commit message since
different Zen 4 variants and steppings use different microcode.

Here's what I plan to send.

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index abadd5f23425..186a124bb3c0 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -909,6 +909,13 @@ static int amd_pmu_v2_handle_irq(struct pt_regs *regs)
                status &= ~GLOBAL_STATUS_LBRS_FROZEN;
        }

+       if (status & ~amd_pmu_global_cntr_mask)
+               pr_warn_once("Unknown status bits are set (0x%llx), please consider updating microcode\n",
+                            status);
+
+       /* Clear any reserved bits set by buggy microcode */
+       status &= amd_pmu_global_cntr_mask;
+
        for (idx = 0; idx < x86_pmu.num_counters; idx++) {
                if (!test_bit(idx, cpuc->active_mask))
                        continue;

--

Hi Peter,

There is another case where users will see warnings but the patch
to fix it (link below) is yet to be reviewed. May I rebase and
resend it along with the above?

https://lore.kernel.org/all/20230613105809.524535-1-sandipan.das@amd.com/

