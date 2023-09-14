Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1BA879FEF4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 10:50:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236028AbjINIuG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 04:50:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230234AbjINIuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 04:50:03 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2064.outbound.protection.outlook.com [40.107.237.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36BA091;
        Thu, 14 Sep 2023 01:49:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rqj8KjeV1t2fnUKw13pQ1hhYB8YAnxVJfBoS5yH4enj5IUAFxU5IgMwNV4f7PPsBtczS7QMcd4e7kBd/mJ0RpMQLtYkn1XMNT6P/R42vwOYspPtCt16q88J1fhQNb3Spi8B70ZUsnHUGRcCqfYraOBs3LBpH6lBacXztpe7jABkxXDarps4GtcnrXCiiSLcnH7y3e3af4qZFdK0JE9u2SxE1Jwy2Ldrm/YZaL1w5y+26rbU1o5c4DPvfDoqVT7mZy1z5kYFF0iv+cQLc18LDhIIogh2Uv+fDIgpB2Gd0yff2RwF81nNgvQltc3XFanEI5VRKkCXnswZ1XZKfCrBGVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zAsIzILfNBZ6liarEIjtR8/5fEe2bem/QCYvEgFiVVY=;
 b=KaDFZX+Ti6CShxbZoGV9+p6Yw9KBnxM3cZI2P8y7Vobe3gZKZlFfKeTmDQFXag8Iw4P6+8uVajNuXqMQEiGDWllowQovlEdmXID/+lAvQEisWbsHrX+SsyBrU1iqd/j15PIkL2XLXgI/HOvh0Gnwx+aBOjpnKuiTffKfSv2O2YFQa2YBGZXKsoL3jFMc/WYdRTHvWCc19taoH2HCUIHNpkx8/ad4MgaEKhfb6xeRWeSpYlRDuRADK0D/I6Ajd8fTntJTpxaSu/WNgyQyPm0CzY1IiV28T5vMh6PwLEySJrlhKnzC1WuZ7An7oBV3s/RvuDIxz05paglbyfw+NM89oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zAsIzILfNBZ6liarEIjtR8/5fEe2bem/QCYvEgFiVVY=;
 b=MrbbJJ4iHQ4z2iNOTm8nbV/7JW9zdtMeM5nNXUuT3ujgQENRUkRgUPpltrlsx6OUOuU33lEOjSi+QWaUUnZBpQucH9XbY+UHCaw2qsBIsdQbfnm6c4WbuddH5cp0Y97OivduAvp3AaJ1MWzPpq8j64AVexK+99kzetprPcPkhGs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5712.namprd12.prod.outlook.com (2603:10b6:510:1e3::13)
 by DM3PR12MB9433.namprd12.prod.outlook.com (2603:10b6:0:47::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Thu, 14 Sep
 2023 08:49:57 +0000
Received: from PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::a285:eb6e:8fc:7cd7]) by PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::a285:eb6e:8fc:7cd7%4]) with mapi id 15.20.6745.035; Thu, 14 Sep 2023
 08:49:56 +0000
Message-ID: <f40be1e6-f877-4e32-96bb-d849916284e9@amd.com>
Date:   Thu, 14 Sep 2023 14:19:46 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf/x86/amd: Do not WARN on every IRQ
To:     Jirka Hladky <jhladky@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Breno Leitao <leitao@debian.org>,
        Ingo Molnar <mingo@redhat.com>,
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
        <linux-kernel@vger.kernel.org>, ananth.narayan@amd.com,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Michael Petlan <mpetlan@redhat.com>
References: <20230616115316.3652155-1-leitao@debian.org>
 <20230616132954.GG4253@hirez.programming.kicks-ass.net>
 <ZIxrxpYtffT0FtEx@gmail.com> <100041d0-f2fe-331b-13a7-ad09082aeb7d@gmail.com>
 <20230616153221.GI4253@hirez.programming.kicks-ass.net>
 <CAE4VaGBbKC+KgX-drhnc-nHsBo_DfcX4yZWBsNvrULiV3+Li1A@mail.gmail.com>
 <ada0da4e-4260-47c0-897f-09e3e1e1658e@amd.com>
 <CAE4VaGAcWk0PYygNGcguRA2V2qK03entkv6BUsnxhS-ftdfywg@mail.gmail.com>
Content-Language: en-US
From:   Sandipan Das <sandipan.das@amd.com>
In-Reply-To: <CAE4VaGAcWk0PYygNGcguRA2V2qK03entkv6BUsnxhS-ftdfywg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0124.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:6::9) To PH7PR12MB5712.namprd12.prod.outlook.com
 (2603:10b6:510:1e3::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5712:EE_|DM3PR12MB9433:EE_
X-MS-Office365-Filtering-Correlation-Id: 1894de21-c3de-491b-1c98-08dbb4ff91fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XU9COUaYRqpDto7uJZqQlD/m6YPU3TkjS+3G39IcsBTGBLz36N+0EpbsZTfcCnP3M/mEE5d053sKo0atCwolffR5zg27P+Y4obia66/xsGEOwJ0Cv9pnRIjCIHDfig88Yvrwz5xrALXm7HFihVZluxAAKTAhOdCqnzZfk9KXs8f44o8Xwc1tynxGmjD2b8jfywFWIIK4U8YyaWo7UVXfOsShRWQ8r9mGeF9eAuU8SNB7Vu4RyJYl0xRC+JnvUrqwmdmV1qEtI+2A3C4oG1e1tIyI2qLYqRdgJ/tDocRnVv/0RkLlRbgBcE0zWcIzQ4Dn81pyDmxzpxYUqNCIfS5AY+S86Q3D+DUXjj/1dxwkTHVUOtOgtAbmSypbDI4OVkK5Z7lFt1k157I/g8Eue9QJ9EwjYAgrdYZFnYaFjzc73iY32BbPPO9VXh2naoymfXTftp8T5+ja9zb9Fnedg6XhGHJUVyXIOSPPcwpyLVGvxNga5BobvvUj+S7dKrrVZl0kjOtGESmEjFBQe20ZDeVbwx7sx2dVkSGo9ZA3XzTruIXlBkSKe3MGYVGEnqm1qPbX5kUrO+gB1OZdsueOb8gSNCPk7PWJLZ6wJn0DZlBo/U3lZ3h2D/URgJpbLVSGRHjM9OaZgclWCkaK8DXoTp2jPA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5712.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(39860400002)(366004)(376002)(396003)(1800799009)(186009)(451199024)(6486002)(53546011)(6506007)(6666004)(478600001)(2616005)(83380400001)(26005)(4326008)(2906002)(6512007)(66556008)(966005)(44832011)(6916009)(66946007)(8936002)(54906003)(66476007)(8676002)(316002)(5660300002)(7416002)(31696002)(36756003)(41300700001)(86362001)(38100700002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SC9KZVovczhzbjFLR3RLS2s4MnhHTnNpcGJxMVFjWVBSd3M1a3N3a05ET0ZB?=
 =?utf-8?B?b0JqMU1IMjRUaFZaMStsVmZGbyttdVNzRVh0STFVa0FoWGRiS1ZmeWcreE5N?=
 =?utf-8?B?R0lGaGhXNS9kb09oTThnQTNrQlZ5UWxEbEE2VmdBc3NSb0pxemlqR2VwWU4z?=
 =?utf-8?B?TnlZdTJZZm1aRUVVYVl2dDVsTEZYdFNBYSsvTjRnNkVsVDk1ZkRmVXU3OXQ0?=
 =?utf-8?B?UVc0VEJoVkVSUndYVUc1NWRsRFJtcUZlMFk2ajlrYlZTWWJ2MXFVSmZ0NzdS?=
 =?utf-8?B?d1h4U21VRmtFNDRtWFUxdEE1dnRGNUpjWURQZCs4dm1oYVJ3RzhnOW13R1ov?=
 =?utf-8?B?em8zVmgzTUFKZ3g4cVVzRlV5VUs1UmFGZERHelBTMitYM3JqL2hPTGdBaGFm?=
 =?utf-8?B?M2VlSXBFWElOZWhBdDQrUHVmcVlhL1ljZWo0aHpZM0RhTHpXMGFiT3lwZGgy?=
 =?utf-8?B?dklEd2V6WjYwM204WllIdmtPY3hRaVFURVdsU3Q4aVF6WmJUZDUyZ3JTNExo?=
 =?utf-8?B?ZXNLUXlSZmM2V3B0cWlGMjh0U2RBWnlLRDQwN25FV1BManRnb01EeUdReTF1?=
 =?utf-8?B?WVZEdWo5V3N4TzNEWXhaOG1FdTFlclc2bWVkbHVuMFlCbzNXVklqWGxVeU1P?=
 =?utf-8?B?Wk45WGhFWGhkeVRZOWxrdXlDZnBCOWdyZTFybCtsZGtiTjZCMmEyMlhBd2tK?=
 =?utf-8?B?dGZjZEdqd1MvbGVobC9Cc09MU3g3ZUJQL09keHdMRlJDSWVIM293VXhlSmlv?=
 =?utf-8?B?SWVQSHpGVGxoaFZTZU90enMybnpjc2JZcnRhbDl5TWJSR2RVQi9RS1VETVZS?=
 =?utf-8?B?RWNhTWZZY0ZCQnUxUnZHQms4MVBwdUpGL3BMK0NyWkREY3ZCdjQwYjFBb2pQ?=
 =?utf-8?B?RXVtTEJ6YzNXZ2tMQmpYUWcyYndsWUhndzdWenppZ2lmVi9mT2ozK3pTZ3hX?=
 =?utf-8?B?WVN2VFhFSUxMbmkyTFJYTkEycVk0Tnp0eDVsS2FFK3lkUDV3VkxhVEc4SzBk?=
 =?utf-8?B?dG5CTnhYTjkzVXJGQmoxdHBQOXNSL0lxamVWODZnc2pOR002TEZVZEROckF0?=
 =?utf-8?B?bFRFVUl3T2wzUkwxYjY0cTkzWmFiWTNqdnJxc0t3bEtnTVE5WDIvcEhiWG9H?=
 =?utf-8?B?VkgrbXg1ZkNTVDZBS2w5S0U2bE1wUFJ3YmNjZm5CcGY1MzAyTGR2Uzk0Mndp?=
 =?utf-8?B?M292TDNRWEp6Wkt6QzIrRXFvTFozdHJpL0RmaEdzSzRCbkM5dFRCaTZsR09a?=
 =?utf-8?B?by9vV0N2aUZyQXJwcE1XbDRzMUIyUnlROWtOV1kweEl4LzhNTkZEYjZubkIy?=
 =?utf-8?B?RXJhakZHTEd5TXZGTFVnL2pjOTFhaGNLM2d5dHUrdFZsTVJ1ZEpRZ3lSQWlr?=
 =?utf-8?B?dVlpalZ2dk9GdDh1R0hsMFkyOEFuRXcrbSttRDBhZHlJcll4OGlOTGxlcFhR?=
 =?utf-8?B?Y2gwVk5mUU54R1BjcHhlUEp6Nkh4bDZaSnM1OWFFdXZHekEvRmhtMGFwU0dB?=
 =?utf-8?B?UnJ5SXFRZ2M4VU1xem5VNlR6SEZxNEo2T1BwN1NjNGpIZTBVZUYxZUovTjFh?=
 =?utf-8?B?UHVlZzE3WGl2dGE5cnR3VHpCNlkxdjlLQTJpN0JFeXNYUUNsejlaTFJEb2kr?=
 =?utf-8?B?L3FMMHZzNUpaRGR3TnRjaGorNGhXMkc3TUpZbWZIUXI2TkovTnBMVTlpaW42?=
 =?utf-8?B?a3hlZTBOOHNBUTZwaHJvbG8wcUwyeVBmWERkWUwzbHc5M1BLaFBGTVJDRnZX?=
 =?utf-8?B?MnNiRHBzbW5UWkZIdURuTFpSTk5LODlJUElzUERYWUw5OG05N05YVEZHWHNi?=
 =?utf-8?B?WDJTczJzNnJFYXptNVVEZTBBTndOTXZOeStONVNRSVhhNHdINUx2RDVDdURu?=
 =?utf-8?B?Zm9BSTN1d0xJU01NR1VaN3lHS05UclNjSnIwVkZDWUpWOWpBU0hOOHJqMURV?=
 =?utf-8?B?UTNtUmVxZTkrdzVjR1R5QzNkZjlBUjJnTDB3Z2ZWZ2M4V2xBZzFmSG9YVnZh?=
 =?utf-8?B?NENzYlNsNzc4cDZYNTY5bHdtUS9kNklQV0I0MmViTlNuR2dzWHYvMFZCNkM2?=
 =?utf-8?B?Qkd3WXhmY2c0VGR6OHRjcS9jUndzOEQvbXE4NHdsZWk1M0pXTWcyZDR4VU5h?=
 =?utf-8?Q?NaOW/2HAc48knIZcYGV79DMA3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1894de21-c3de-491b-1c98-08dbb4ff91fe
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5712.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 08:49:56.6560
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s18lexTz3r7lCt3aPZ0SXLyC3SPYJAQxnBBqrQsGPgFTYBg/Ken5Y6mwDOx26nqhPeNFrN9v3vH1ioOMj5FwsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9433
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jirka,

Thanks for reporting back. Moving to the latest Family 19h microcode (link below) will fix the problem.
https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/tree/amd-ucode/microcode_amd_fam19h.bin


On 9/14/2023 2:03 PM, Jirka Hladky wrote:
> Hi Sandipan,
> 
> here is the info from /proc/cpuinfo
>                                                                                                                                                                                                                      
> vendor_id       : AuthenticAMD                                                                                                                                                                                                              
> cpu family      : 25                                                                                                                                                                                                                        
> model           : 160                                                                                                                                                                                                                      
> model name      : AMD EPYC 9754 128-Core Processor                                                                                                                                                                                          
> stepping        : 2                                                                                                                                                                                                                        
> microcode       : 0xaa0020f
> 
>>2. Microcode patch level
> Is it the microcode string from cpuinfo provided above, or are you looking for something else? 
> 
> Thanks!
> Jirka
> 
> 
> On Wed, Sep 13, 2023 at 6:19 PM Sandipan Das <sandipan.das@amd.com <mailto:sandipan.das@amd.com>> wrote:
> 
>     Hi Jirka,
> 
>     Can you please share the following?
> 
>     1. Family, Model and Stepping of the processor
>     2. Microcode patch level
>     On 9/13/2023 8:00 PM, Jirka Hladky wrote:
>     > Hi Sandipan,
>     >
>     > Is there any update on this issue? We have hit the issue, and it makes
>     > the server pretty unusable due to the thousands of Call Traces being
>     > logged.
>     >
>     > Thanks a lot!
>     > Jirka
>     >
>     >
>     > On Fri, Jun 16, 2023 at 5:34 PM Peter Zijlstra <peterz@infradead.org <mailto:peterz@infradead.org>> wrote:
>     >>
>     >> On Fri, Jun 16, 2023 at 08:13:22PM +0530, Sandipan Das (AMD) wrote:
>     >>> The reserved bits should never be set. The purpose of the WARN_ON() is to catch such anomalies.
>     >>> I am working out the details with Breno and will report back with a resolution.
>     >>
>     >> Thanks!
>     >>
>     >
>     >
> 
> 
> 
> -- 
> -Jirka

