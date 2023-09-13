Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D59B79EE24
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 18:19:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbjIMQTF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 12:19:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjIMQTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 12:19:03 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2084.outbound.protection.outlook.com [40.107.244.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63E0DB3;
        Wed, 13 Sep 2023 09:18:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kMVe3yqN1uveouS1nWKdEVDLlzqDxjNBhSoQaEtNRDM+dKY4/hGywNHPAwWotvqTtBlcx7ffWHjgMrgHB8PV1hKr5MNmtm7/9+EOUa9a4Z1Mh23WgtYwfnEbeYm3MftJ0u6nsN8M4PbVfkj2Gm9HPhW5sP2RaP6dgqmVLP8GaUnnFcbl1coP7Esi1DXoDRCYGyBHoUafwFH5yr3+lLHBBymxXg9+E9a46m1BPBKQPoRHGQsZIwOr5xdiUKbu3dfGXYoPlptIC8l1Lbd/tb9LUAtiLX2vHJIhTy+U5DSP3+r5arJ4MMEe4yKKB2E9JoNshbETD35HL8cdz5VbGeb13A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0GNILEgFe+B49AR7HoyQ7VFDxrODwLEi3eTHPukxTKo=;
 b=F3tqAAEwrrp6yW74W2vtUNSjPVIBM4cDo/YYztHgEVT/4g2gHVNzuDaJfKHRVIm9C68mKv+zo+raP6heFKpPtvI0XoijDoWxh5P0CVWObVHN6OBmBSn2PHNBRga8g6oapkSsH8RCPW4p06xmQq3Yo1gdaCKeO0+ruMEFmBluu+K7nxoHpODCY90a8mssoOsqUFeLp4haNt/DmYKM3aLHN9ps7E9p5qFx1+vS/RfioUYMU228iRMtn2vfVedYjHYugDX4+OQDc2338Lk7PBSx5einaUA+ZmiJHSV/xPrwlhvIQIfcxPlRje9NRXDX3iaMiPkjGFPrhgLxhQ1bZG0jbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0GNILEgFe+B49AR7HoyQ7VFDxrODwLEi3eTHPukxTKo=;
 b=0QICu3ezd64FGG06LOZjRHjTPq1BiMzCmsZtH3Ybb2v/TNMcHk5iYaf8DStVn9Zy30FI0KrDhkJqTyXyRyZuym/yeN+/3c9GC1hXe06cs2gWCkI8bp3VP7vtzRSOSMizY5YkY/5SHE8FXzOAvO/1QZNtkhLi3kAbpCsgxhH0Iqo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5712.namprd12.prod.outlook.com (2603:10b6:510:1e3::13)
 by SJ0PR12MB5405.namprd12.prod.outlook.com (2603:10b6:a03:3af::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19; Wed, 13 Sep
 2023 16:18:55 +0000
Received: from PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::a285:eb6e:8fc:7cd7]) by PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::a285:eb6e:8fc:7cd7%4]) with mapi id 15.20.6745.035; Wed, 13 Sep 2023
 16:18:54 +0000
Message-ID: <ada0da4e-4260-47c0-897f-09e3e1e1658e@amd.com>
Date:   Wed, 13 Sep 2023 21:48:43 +0530
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
Content-Language: en-US
From:   Sandipan Das <sandipan.das@amd.com>
In-Reply-To: <CAE4VaGBbKC+KgX-drhnc-nHsBo_DfcX4yZWBsNvrULiV3+Li1A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0140.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:6::25) To PH7PR12MB5712.namprd12.prod.outlook.com
 (2603:10b6:510:1e3::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5712:EE_|SJ0PR12MB5405:EE_
X-MS-Office365-Filtering-Correlation-Id: f7a8155a-54f6-4bb6-c5a8-08dbb475202f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Vu7UZCk3IBcflCNEnLDMQS2HX7odj5P14dXnULBP7y4Q7xqOyyuDpRWIj/3TGr1ZV/AiXsm68wBEdFAqqGptMC3Z84btknAojkgjUYu3eJmSfqqYc0B7weYOE1dYNo+RPTtuxjn4MoKLHeDVo75VL0j25BVnWTUqz5xp95yj5b7fJ9WhiC6yFdk1T/Gupw6hzAvfX4dV7f20uZEZIV6jDjoNPjDDdFXxBk6f+LZX90EZ3+Sg40prjltFTr2X6dWGNVfUksWnaVbyB9oMc0GLHOYPYixE0ieaAtjq56vQ5OmTGv1iBuGeieP7ufT5lXnxbbWVdayMaRBTt2vxXpqeGpuChGVvNhUfTfB32/rZSe8BW43icRzwNX7fc0DuAsK1bJt8bDg+kSk6NRgvaaKJCpW8A8xdO+DvT8u7+dSxq7RhdLbIuWMWdfezZlFqiBSo/4YW/zfVSCVoE/aX1DYTwg7tFGOYLoOFV5S6SnHsr9KfFeVzDvFSV86uHRLiZFTeGhkJiuaJz/xXLtfX0VMkPEH2INRXitqat7m+xoPN8Ui+gqJZfkOs4S5jqAjXdpv91jKzqhAylCBKl7Dr2ySau8w5msB9muJwqoSetfJMCQN6mtlgeYUrmqihIEg85v2B/IPozoGMOEfFovWTimrpxg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5712.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(366004)(396003)(376002)(136003)(186009)(451199024)(1800799009)(38100700002)(6512007)(6506007)(6486002)(53546011)(6666004)(2616005)(478600001)(86362001)(31696002)(83380400001)(66946007)(26005)(316002)(66556008)(2906002)(5660300002)(44832011)(7416002)(4326008)(36756003)(54906003)(6916009)(66476007)(8936002)(8676002)(41300700001)(4744005)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c1ZCNEcwK0VWUEpvbVRhbS95SWJvaUtrVEtKNXZaMWNPeVZCbEtsY1l6OEFz?=
 =?utf-8?B?MUVPbFVFa3pRaUxSMEtiRWpvZHdKeU5aMHhtOExkNTJaMThTTHdhNTRub2pn?=
 =?utf-8?B?UjRac25VQlBqV0tHVGQ4TGt4bURkdmtETnY1K0NDN1BtMzV6bklWRjhiUVJD?=
 =?utf-8?B?NHNxOWMzU2NKTWNWUnhGOElldTVjcUt2L0hTRFk1elEwT09yMlRJdlJncVFm?=
 =?utf-8?B?eFphWTJyQmNEL29FVlJXbVpESG8zNTM1ZERXeW43WjFYQ2ExMEIwWHdJWVcz?=
 =?utf-8?B?R0xpR2p5QmhtWWszNGhzZkQvRTZzajJtSThBSVFBWHRIL0JoZXFNM05ndmJi?=
 =?utf-8?B?aThNUkRuN3FJMUhGbytKc3dtOVhZb2hCbUg5MFZKcERRcjVyY1orTFlRTnQw?=
 =?utf-8?B?RVJ4VDZPMmZHTUkzUG42enQzY0VkWmxFWWRnbzl4bmhTODJWOWZJZ2lmcllk?=
 =?utf-8?B?aUxjTkV1MjdBbjQyTU5Wc2lVVXFidUwrd2lQeWUzMk9ZU0ZnODhaM3F1a05n?=
 =?utf-8?B?MFhKQUJTbXJRblJwSUkwRzI5QmhuOCtzU21oMzNMV3hDSEx3QU0yOWFtY0ho?=
 =?utf-8?B?Y0tIanhUbEZ4SUV5Lytrb0t5OGdVb055YzB2WTNZVStsUERWWTd3U3BJWTdB?=
 =?utf-8?B?Y2RFSjRRekFDcVJwWkpWOHhicXN4OXRVby9lRG9GYS9rSVZYYTBjN1gvQkpm?=
 =?utf-8?B?UjhCRkwza0pTVmFvTmE4T1ZoUk9tV29DazZtMG80QVIyaTNVSjZRR3dpR1pl?=
 =?utf-8?B?TFhvYTFGTkwyZ29aU3VjMVBsLy9OajlTVmF5ZEtXUjh4S0NTaVNENXRWTXlL?=
 =?utf-8?B?Q0oyb0JvdmluVVF2WUEySGMzMmNML2J6R2lnV0RWMGVLNStjMlFuTk5MQy9r?=
 =?utf-8?B?R0VkcDU4Ym80a1ZBRDNTTSt4MG1ZOWtYQ3didkxSS1BSaGliQVZ6R0pmSXdy?=
 =?utf-8?B?MzF0NVNlaEViL0ZhdGhHa2xyWFoySHEwd1BMZ1JzQUFZelZkR2xtcmZaTUhq?=
 =?utf-8?B?SVo3WkE2NEVKdnpnZTBKL0RiVHhDUTgwV2ZJVzgwWnZrSHpCdXBHUE93dHJ3?=
 =?utf-8?B?Mmlzeko5K2hvWnVqMEVvSFJBVmlMQ3VvaXpPbk83L29Rc0E0cnIyRGQ2b3BT?=
 =?utf-8?B?SE1BQmxHYk5CMUhicXBTZ2l2N1pPQlhhTjRoRklFZEFXdVMxL0pMZlFZcnhp?=
 =?utf-8?B?VFRzejhLdUY3cTBBZWJUZCtOMmRReWJPOW0zVDJqeWxIL0FLRmlGelowc2FW?=
 =?utf-8?B?YUJJNHhjSVJ2VmV4dU1IMkdFUkdoOWxPRjNpMUdhUjAwODN2a0RLZ0JwSUNR?=
 =?utf-8?B?N3lPZW4wUHdaTEMyekdMcDVkOWlnQ3piNzlBMVdjN1pTV0thb3N1MURRcmlp?=
 =?utf-8?B?UnRBUk8wUjZlY2tISDAwcDJmS3AvTFIvRG9YYUNGVUZSL1I5OThsWkZJVjBK?=
 =?utf-8?B?aGcwMzAvcm1aMGl3dEJDL0JoSDRDRU5EVElsSkJrTzVuZFFQUGRuZ29EZlZi?=
 =?utf-8?B?dHh5dlV4RWthbjlNV1lkT1pUdnZPMHc0RFdSUm1MQjJqYnd4amJFa0o5cWF0?=
 =?utf-8?B?YVY3QkcrQjZ2ekQ3cjJ5WVY1L2IwL1lPSHJwcFcraTFiSVNkU3NmMzFYK0gy?=
 =?utf-8?B?cERvTmlTQUkzSmlzd3BiYkFSZ3lySWljbTR6WHFXNkpmcElOK2FUeEdyVlFQ?=
 =?utf-8?B?MitRN3hKaGRiVXFUc0MvUzJMZmJWL0ZGSGlSNXpwZ1pMVTVFTTlLOFBNMXVu?=
 =?utf-8?B?MUU2WWVhSGZTMmkyenkwYjZjSldWK1ZZbUZKK3NXeHRoTjlSTUtPdjBWZ3Rs?=
 =?utf-8?B?TjBMUVpmTGI4VmdRTU81SE1NQzhGSWtPTWZNMEI5anpnQzdtMlArN2RwRzg3?=
 =?utf-8?B?S21GNFovNGd3T1dmcGVKQ0E2bkxGREFZV0FBMWJTOSthSnBpYVRHRzlXRTh2?=
 =?utf-8?B?L3hCQURpTjNEc0RiVG5xR2wreUhVOXhHSHhFQlRmeVFDZzZkRXJGWit5ZHV1?=
 =?utf-8?B?R1ZCTWVLZ3g4b09JL3B5WmgrNldWQ0ZhWnJxYWlIYlRNNWFwSUU1MWFWVjNJ?=
 =?utf-8?B?MnBCTFhNc1d4ekhFQ1JYOWJxUkIzOWNxUENNVDZvT01TZnl4elZiNDBSKzJT?=
 =?utf-8?Q?dnu6W1grC+P4+/PWCP3EBMjmI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7a8155a-54f6-4bb6-c5a8-08dbb475202f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5712.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2023 16:18:54.9206
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YtDyGpycyQxVQAAaVjtlR7g9370GAY8jxUP+1Np+0xGPUb7TrVyFERXfRVKKeGGmtWYLU8mcqavCG0DGWJpsbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5405
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jirka,

Can you please share the following?

1. Family, Model and Stepping of the processor
2. Microcode patch level
On 9/13/2023 8:00 PM, Jirka Hladky wrote:
> Hi Sandipan,
> 
> Is there any update on this issue? We have hit the issue, and it makes
> the server pretty unusable due to the thousands of Call Traces being
> logged.
> 
> Thanks a lot!
> Jirka
> 
> 
> On Fri, Jun 16, 2023 at 5:34 PM Peter Zijlstra <peterz@infradead.org> wrote:
>>
>> On Fri, Jun 16, 2023 at 08:13:22PM +0530, Sandipan Das (AMD) wrote:
>>> The reserved bits should never be set. The purpose of the WARN_ON() is to catch such anomalies.
>>> I am working out the details with Breno and will report back with a resolution.
>>
>> Thanks!
>>
> 
> 

