Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8548177C2CA
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 23:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230438AbjHNVvD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 17:51:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233070AbjHNVu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 17:50:58 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on20601.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eae::601])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5719B10D4;
        Mon, 14 Aug 2023 14:50:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hj7ZhXxRS8kJNsMQFYA6+yMsMqhwik8cvq5kN7vLyeplmIjtqnol26r+wVclNsd4Lmeb6DwFHZ8i90F04xSvJKaaow7OfSh39QBpDuQPJ6+eGh6/8p5aYVbGvlNKQeSCEqCsW2DqyvpWMnUBQEefs65frs0CQCVEf7JYKd9igHMPU9bPawf4y++tdzwEuuoHxWa2QI2zhwW1AlXtbj5L0OMYsKOqJPdItynEOytzcRyT+/V8pBUrA0rjXleqf6UOFNVjJ2ngMdRcZ07AbaKMdXnWjbAlW/+97jv4RMmLzsJfYE67kKpRaWZ235CDgnnU8P9TUt2nkeKBuPnjLM7TEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z0rp2lzM0NR78jjGWAI7LtOmihYIsnV7xZJ4fLekEPU=;
 b=hGv8ad37WqEc5y8bSssbABtpC/ICy+kn/3BOyXpDYWzl6XiNr/Evr3pfDmRxle46cZGhmG4Pd+oKixF5OfQtSHxQEFCwQt73iT4LtALGcc4YLwsZ7skH5Qz/brFrJ24TRvU13ROrBHtnurYzDQXmrfY5eo5150WvM9ZYHMMW8Hp6cmJoLTfOxVgxuD8IlwzGHvMupii7KJv3th5zS9zebYmy3gj7fENcLk6VybSpVxbPbH5Ow0Lj07Yr9CHJTa+2nNQgKF9zQXN6DKVVuuw3NQZuVgo1Xs8O+LWfk4KkJZ7ja+vWPHGpGfols7dcMpD5hrSZiAxRq0/GcJS7+R3+Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z0rp2lzM0NR78jjGWAI7LtOmihYIsnV7xZJ4fLekEPU=;
 b=jMT6ri3Tjc7f45acMq3ZMKu0W97Pf3+HnkeUXLSpl9l8HJW5S6PqvhM8Hvo/4tL+HnS09OIaL/hj5kSKBaKflLxqvBTkvqWqPKxe//nv2wQsMf7HyFx7+A/NbnEMojZSHk8CVSv5YmUPXP6Yy8rGB2llgDQ2Ym8kMGK1SSnb4Xc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CH2PR12MB4906.namprd12.prod.outlook.com (2603:10b6:610:6a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Mon, 14 Aug
 2023 21:50:53 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146%7]) with mapi id 15.20.6678.025; Mon, 14 Aug 2023
 21:50:52 +0000
Message-ID: <696c34d0-3de0-4f56-8003-eac872298605@amd.com>
Date:   Mon, 14 Aug 2023 16:50:49 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpupower: Fix querying boost support for amd-pstate-epp
 mode
Content-Language: en-US
To:     Shuah Khan <skhan@linuxfoundation.org>,
        Huang Rui <ray.huang@amd.com>
Cc:     "Yuan, Perry" <Perry.Yuan@amd.com>,
        "Karny, Wyes" <Wyes.Karny@amd.com>,
        "trenn@suse.com" <trenn@suse.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "chenhq2005@gmail.com" <chenhq2005@gmail.com>
References: <20230811213501.17293-1-mario.limonciello@amd.com>
 <ZNmqQkOK7CLa7TNl@amd.com>
 <dcb720bc-113f-e467-01bd-3d19869e13ac@linuxfoundation.org>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <dcb720bc-113f-e467-01bd-3d19869e13ac@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0144.namprd11.prod.outlook.com
 (2603:10b6:806:131::29) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CH2PR12MB4906:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ddc6fb0-c540-4035-c9bc-08db9d1087c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kdtX0RG9R0RhE9a2FIfSeyJrtCuNqUaH/GyiWrcdcwPd8a5NcMLvmH6kKyAk6M4XKdsYsBChauAMgD7NWsWpqoa+TOa1l4H0OPTaDcOwCKrGcpxgWHAcJDzODH9jgvsiqbwwByWFkVM8Vz6bv1V1Nt6pFRcpebiKdSoh/DTVSOvsmxUIYGhpmd1ParcHza1/zyyffVsSHWw+j2WXep7VZNDty/owAVF9p8rV9xGbgz1uVyZoK9uGVyo8V/u3EWdx+D7uw9vIgNo/uAHUHrJjblALTpBDZiwvPj8u6ty/E83d5YQwXPceVkQcm6c4WlAMdctFbNrUgb3QxE3WRszxov6p0mj7mANJGUHMF8yXRVCS5whmeWibWvLzVOwFrUM4UEXfrNedoC5OiXC0nLMpOTbo8zeoRSPaSymZ6PAOdUU6knMaGYv4kveZKfa8yfiCyG8uBrnbFjVnIKt9+2t8UXgE7AIiySxi3VmWdYd3rJrjvy80a9MnL3yGn5pMR5MWrV8aHNBEdbZR/Bc+dwVkM66weXaM28NsOhDZPh3Kj1wUCYiOk/MnhKD6Rixvl4y02JMZY3JirMkWZiwqJNKe8j+6hzQ2KJad6IhUPnzKvUkWuoQ8PJJByHSzlZdMs9ZzqTDWkM3VFm6Zs1KnJTExda8WLngQ2QRn3K8SC1j+As76djz4d4DBulUhRujdWjM2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(39860400002)(376002)(366004)(136003)(451199021)(186006)(1800799006)(31686004)(6486002)(6506007)(6666004)(966005)(110136005)(478600001)(83380400001)(36756003)(31696002)(86362001)(2906002)(26005)(6512007)(66946007)(53546011)(2616005)(38100700002)(4326008)(6636002)(8676002)(66476007)(8936002)(5660300002)(66556008)(54906003)(316002)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UTJYZEdPV0xJRndDbzNvby9BbUxjRjU3QjhTbnpyTXJMUFZRcWZoZHNLZllx?=
 =?utf-8?B?VTBQREkzcUtmSXQwRFZocVhMQ3A4MC9EMm9jUVJOOGludGdpM2VxV2V2RDYw?=
 =?utf-8?B?c1hXbmM2U1hEM1pMWkNJOWw3bmdyNndSbm9VckYvTm1aNU1IUEs0cUxHaTBL?=
 =?utf-8?B?UkhzSVl5VG9tb2hJZVg0ZkJSKytPaTNwMGRXcmorRVAra2t6c2VlZ0xmSlpv?=
 =?utf-8?B?T2pwZGdiTHc0MmhjNFQvT2lCQ0ZSSDh2dCtlMFh2T1hVbWhFaFFKeGh2aUU1?=
 =?utf-8?B?RXAyN1N0QlExYlcwaDVqSnVKN0JUVS83clJHV0xUeFlMRFZKNHA3M3JrdVFR?=
 =?utf-8?B?TnBoYXY0Z3JBeFVoOHV0ZkwzbGJ6ZFBYK2VnWXhlMGJoeE02bXJqV3d3Qngz?=
 =?utf-8?B?Ujl3cVByd09iZ3BYeGd6UTZKWmRWekc2NDJCVStQMGs5K1FMRjl6WjF6Y2Z0?=
 =?utf-8?B?QVVQcWw4c3c1MmJ3Tm02TVp3REhDTzlnS3QvbnRHZ1NBZnhMQlptd0xBVytS?=
 =?utf-8?B?RC9qcmFvazdxZzhCa0dIelZLcGpweCtWMllMcnlsZWFKY2x0S05xUXBqTkR0?=
 =?utf-8?B?OUZYN0QyV3Rhb2g2OHdvcE1TNGIwSng2ajlhYWlvaVdmVm1QUTl4RkJSc0l1?=
 =?utf-8?B?OVhDbmh6STc0eW16SjZEdG5yb2VoaDE3OE1XWWRUL2lIN0ZBa0tCRmx4ZDla?=
 =?utf-8?B?c0NJdnlRQ01vRWV5MW90M2svbHd3eDNmaStvWmFyaTI4MlhGWldOaVdBdkJK?=
 =?utf-8?B?S0RtOGJEdFdacGYrWmUyNDBWRWJPd1Y5NlZ4Vm5HSndCcmpOWWZqQVVsU3ZS?=
 =?utf-8?B?cWh0TU9jaHdXOGREN2RsK1h0Wm1Ka0lnZHpzcitKdVQ5eEU3bU9vU3BHMXRT?=
 =?utf-8?B?ZCtHcHZ4UWdHV1NkMXhQMDd1MEN2cGRmc3pPWlZEY01HYlhKZUVjdktOV2Zp?=
 =?utf-8?B?RXFraDhyL25NaVlrTlFlZmJValBzQWZhSUlud1U1Z2pKUFlkdjRyZEU4L0tF?=
 =?utf-8?B?Q2pxYWY2UFl6NjhobmdueTh4eGZhcXNSM3FtM0RNQkxEUnkzT1pSaW1jMzc3?=
 =?utf-8?B?Q2xRU0c5bm4zTjZYWDg0WVp5TXd3MnFQUTVoMzlJbVhNL1h6a044amFRcktU?=
 =?utf-8?B?QXpHMlY1TjN2OWY1ZTNjc2I1NklhdTlVbUpxK1RRZi9CUExyWmdMaHJ6RkpE?=
 =?utf-8?B?N2FsT0NmSUZaRyt0dGtndXRIV25GOWd4WEwrY3ZsZFlxemJ5OWJiWk1oMmZj?=
 =?utf-8?B?OWlIZzVSbU5sSG1NbVB4eDI5eGN0VWRJVHlQV0pTdkh4ZCtuZWwvQ3IxazJv?=
 =?utf-8?B?NldVcUxuV0llc2pGSjNFZ0xkZE9XREVrQ3FWZUxuVWs3OUtXVXJaSnBtd2Q0?=
 =?utf-8?B?Z29jOWo3MnFsbWQ1V29EeTZrdTBkbk1uampvZGZpSEtKZFFnVG5zVUwxbHBX?=
 =?utf-8?B?dkVaWG9aWnUzeFBQc1lBdFVET3drR3liZjhjYWU3cCtzZEpSTzdaa3ZhdDZP?=
 =?utf-8?B?Tmh4OVFiOW1vek5JTFp0NWU5UHZydVByMkZ4UUVPa1VMSlZFcDA5S3RhR1dS?=
 =?utf-8?B?T0VqdnpDMVM5WFlyaE9WQ2VNeVNHM012YmRjbHVKNW5pbzlxSlBwZGdodExz?=
 =?utf-8?B?cTVrYmdJWTdUamNVbFNRSXRybG5NSFJaSEM3VGFtN2l6WWM3M2F5NGdLTm1D?=
 =?utf-8?B?SzhBQmdYdnlWZ1lkQ1NNZkU2eGNQL1ZVNytIbmdZSkJNQ28yU2pnZGVMWDlI?=
 =?utf-8?B?Y2NNTWFLdEJQT2dtRkVXK0Y5WS94d0poVS9oL2d1VlF6QWdGa0E5NjBtTGZi?=
 =?utf-8?B?V25zdUdQVGxldkVrNlNVQVVObnhsbElaTXo5QjV1QXN6emV3VlBReHhwV0xM?=
 =?utf-8?B?eDZ5Y1NiWlFHZWZlemxrS1BkOW4vTStIMXZrWmNyRmFyZE4xci81NXFkeHE5?=
 =?utf-8?B?bFhWNk0xbHl6Q3FJL0plclFKMHFyS0dSU1lyVElsdVZJL25FU3ZZazlPWlhy?=
 =?utf-8?B?RW5rV1hyMkdhNzU3OFZ0NjlqMk9xRjliOGwrdWlqSzR4K2dlRU5SRlVIQ0U2?=
 =?utf-8?B?TGZrZmRVSW9Da084SDUzYm5acUdZT2RjSGNZV21peWRTeTMwbGhZQ3pvUXJj?=
 =?utf-8?Q?wn/z3f0ocNctlszP+cznDVoN2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ddc6fb0-c540-4035-c9bc-08db9d1087c2
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 21:50:52.7371
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mN/JOykiDAqpuLvv3xVLbb92DzqMqwN76wt8WCpZ9pRf5DB9yXxw7TX64C6oMnOG0QeVN2ftX58oR8Nb6w4Ffg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4906
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/14/2023 4:28 PM, Shuah Khan wrote:
> On 8/13/23 22:14, Huang Rui wrote:
>> On Sat, Aug 12, 2023 at 05:35:01AM +0800, Limonciello, Mario wrote:
>>> When running in active mode the driver for amd-pstate has -epp appended.
>>> This throws off amd-pstate detection.
>>>
>>> To detect amd-pstate look for the prefix instead.
>>>
>>> Fixes: ffa5096a7c33 ("cpufreq: amd-pstate: implement Pstate EPP 
>>> support for the AMD processors")
>>> Reported-by: chenhq2005@gmail.com
>>> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217755
>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>
>> Acked-by: Huang Rui <ray.huang@amd.com>
>>
> 
> This patch doesn't apply on top of cpupower latest:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux.git coupower
> 
> Please rebase and send it.
> 
> thanks,
> -- Shuah
> 

It looks like a variation of it is already in your tree as:

a1cf97c2d43ae ("cpupower: Recognise amd-pstate active mode driver")

Considering it was also reported to a kernel bugzilla, perhaps this 
should be considered for fixes?
