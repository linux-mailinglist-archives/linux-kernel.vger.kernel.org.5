Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD6FF7C7EC6
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 09:44:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbjJMHoG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 03:44:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbjJMHoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 03:44:05 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2083.outbound.protection.outlook.com [40.107.223.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C668983;
        Fri, 13 Oct 2023 00:44:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DPpQSWB3JxZE1ghDVf9htDzjuvc10Wj1Qh/66ESColNbh4rgILddLydUKUyK3y6NztCiiYYgM95ycwXvcxu7qR0VjQszJJBlCyEBBt7nzY5/MoXq82uRgeJr19lY8YwDfqVIthAlq2XCx9bvIhPJVMlk9qmjALRA7X+4vbNidkEq/tLif8HI5cELNBW0RybqS9qQPnimXiqKE+rAn9NHa1gXn9W1KLUWULXV6RNvnixEA2oWtX7RWPqy4G1m666qnCcH53SJKorJCKaw9D7h+If0piojOaFsH3AInTo4JETZlBawqd1ctKdNsrU8V7UEZEHEQBUnTujGXqNkkkcZiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m4XyjT3jl32qUN2kicNUfIneW81E524qgY3JLMf5atE=;
 b=FFt1eOFVapXdqmyL37evB0EmGn54eZ2nTlCCG2lRlYGJZY6t4AyUEJjvsTBz67+cRp6fG9P52xblCOGAj9jJVyOVVT1F3CGSl8dR9yOHdkfgdgHHYmIm1jnnrYVH0/DOsiUpfjmUbjkuXzq0sV/Zz0H/1kdSTElTSHc8zCEYJOi77b3orJcPw7kHcxOGaS3SKPl2HM+p2iQHlC5Lb862/xO59DtilFkYN90oDh2DZmjbmNxPl6s74qVlQx1nfgl4WiS9voATOk6aouH1MgHo6li2cPQmwxcnk8/FToWbnkXk24lJRm4014pi0pP1pFiFx0xrVJgQUNg88GAu4mev9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m4XyjT3jl32qUN2kicNUfIneW81E524qgY3JLMf5atE=;
 b=lqzShgHuxrv8wwjE2SMa8M58D5tn8kMqLJLy30q49dh/0olAZ3EHf7IyNQ7pVXv91o3CfHQXZ67umcVqo26yJ6oq8YYELIB6InkSBShzgRLUJdfwuacVnaQ4FkgzJXwaRQUmIWpDE8kVbsbxGclFvk2fiiw9rQ/ESkqXvsRUzdo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5712.namprd12.prod.outlook.com (2603:10b6:510:1e3::13)
 by MW3PR12MB4443.namprd12.prod.outlook.com (2603:10b6:303:2d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Fri, 13 Oct
 2023 07:43:59 +0000
Received: from PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::ec22:9c20:11d9:e840]) by PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::ec22:9c20:11d9:e840%6]) with mapi id 15.20.6863.046; Fri, 13 Oct 2023
 07:43:59 +0000
Message-ID: <fbc90ef0-1418-4c7b-8f3e-7dd1a0d7499e@amd.com>
Date:   Fri, 13 Oct 2023 13:14:04 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf/x86/amd/uncore: fix error codes in amd_uncore_init()
Content-Language: en-US
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
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
        "H. Peter Anvin" <hpa@zytor.com>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <cec62eba-c4b8-4cb7-9671-58894dd4b974@moroto.mountain>
From:   Sandipan Das <sandipan.das@amd.com>
In-Reply-To: <cec62eba-c4b8-4cb7-9671-58894dd4b974@moroto.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1P287CA0009.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:40::17) To PH7PR12MB5712.namprd12.prod.outlook.com
 (2603:10b6:510:1e3::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5712:EE_|MW3PR12MB4443:EE_
X-MS-Office365-Filtering-Correlation-Id: 961196c2-1c15-4242-8581-08dbcbc02933
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kX+KF7yIV/tJPOojhpOyG3mdc8lvQ+1PiZZt+cvwNudIw39eT+7GSXCTqnOb6sXnMbirxsRVSkv5Jhjp6BLEmxJvJExhJlszgVC/9iLg1qVREWbhQ7Sx7s7S8MPbhe2QqxTnOFuwb0minRkQYLShXjhnzMR7vtv9I5xzWB07nwJcN2PN9q2lVVvYamuPirDFCQ7wcx3NzYB0K6Rvo9Ze4EzXDhIumRQ/GfPWYPnjMKXfYpc8Tv4ikGTtC+jfBfMmV9+LTYnXxqBFn7S7kmPqCcUtTxbmc9FGrdHiC2VdS352WK0XX0WL04CuFPEVnGuqgGnvkAM6JoeP6My76gVO1sd0g566H8I5F+NP+AvofMxKk7qZ7AH19d5YJgDxZAJfbdOQzAS+EgVyG6cZybrjcjKABqqNAyT3f65KabHf35LEGxHfN7e/bZw9Ps6NvfFW/Kb7hnYlFm/OwwxaHt4uVRkRjeswdBVvXZWRtbSkaxq0MGdLmHiXkMTg4MXfpjLyzolj3z9T4Tj67yu/gbmGaj3unD9HPVodcj3wnBnBA6r8jhuPz9WbqAhZWNjjM/vIB7rQL0/lW0C2wa9X2ixQ1yNQC6qvlHhkEANr1xWTNpor6WvQENWNwM8me0zrEBPtJRP9W6srHQM77vFjtaxxsA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5712.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(376002)(39860400002)(136003)(366004)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(2616005)(7416002)(6506007)(6666004)(53546011)(41300700001)(2906002)(66476007)(66556008)(66946007)(31686004)(4326008)(44832011)(26005)(478600001)(5660300002)(6512007)(6486002)(83380400001)(316002)(6916009)(54906003)(36756003)(38100700002)(8676002)(31696002)(86362001)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NmZySXJPeHVCU0s1anhQYmxPeXRmY1dMU0pzeGJEY3Z5TnlqalVlOHhYLzRB?=
 =?utf-8?B?MUNscERTMXpkSk1GNEVhRjBRWk9hd09sMUo4Y2JQUzVlUnVyRmZsY1ZONmM4?=
 =?utf-8?B?L3lkZkZjU29qcXNRcE1JbTh1dWhPU1dNNUUwWUpxVXJnMnJxV3FMTGRKNk1q?=
 =?utf-8?B?Y0N1QklnMkUrWmFIZjd2Skl0R21obnlmUGdTLzRFRnVFOEEvejZjOUlJNHlt?=
 =?utf-8?B?Mzlsc1lHdjJvVnZuUTNqRklpM1hDWUNLbnpjTis5L2dnZUxuRkwra3NVN2xy?=
 =?utf-8?B?eUU0bytaTlRDMWt4YUVzcVZxeVpUMG9Ob3RIWjlrYWJOZU9iMlJZZlBjamNr?=
 =?utf-8?B?eEdaWlVRcTVaUUZobzJ6bjJQcUFTdFN5R29saURwKzE2UUFVdDJ6SU43eFhR?=
 =?utf-8?B?L3F0TmRzaEZJUUkyNTlIOE9KQTFnYWZvM09mQjNQK1VtZXNZOFAyNDF3MXZZ?=
 =?utf-8?B?b3k2T2d3SjZCTFdibU55TjFiL2RXZTVtREYvVkx4Tm1wMzRSbm5PZWY3VEpG?=
 =?utf-8?B?c0NkSC9rVk9wei8xZ1NVaW5WSVZtTFZReW1QSXlnWnI4aTVic3EzUVI0ZDBJ?=
 =?utf-8?B?UlNZTTNLcHd1OWtZMjAzem03d0FDY2lUZG9CK245aExqVjhCLzRUTTcvZUYy?=
 =?utf-8?B?dW9PR2x5ejlSZGhvdHovSmU5MkRReFFPeDdlU1hrSExjdGtDMmJnK1ZCNnc4?=
 =?utf-8?B?YXJIYmNuR09tYk1mdzBBdHZNNGVXNWpHaU95aGoxOTlzelFyT1FCeGp5dnRX?=
 =?utf-8?B?OG9hSndNbit4TmRkcWMra3ZNL2Y1U1NkNi9HU3VRb1NkTWh3YXdubyt1ZEVo?=
 =?utf-8?B?Mm9RdE5iajZURzdOZUJGblVya01ZekJSZnVJakJvcG5lek1WQkRvT0FQWU1K?=
 =?utf-8?B?bi85QjJ1WjdOM3dsY21EbkpmUlRyb0hhR0tVNVV3OEh3ZkhlRk5zaHJPRWxx?=
 =?utf-8?B?K05sWnpUZFBzaVpCVHc3VUJ6NFZ5UXd0UVRzZy9neXp1K3BkYVF1ZDc5MkdX?=
 =?utf-8?B?aE9LNDlkKzZNMWpBcGxRNzhyc2dhUkd3OG5KRGdmWWhXQ3RFdUZYSGloVmZH?=
 =?utf-8?B?dmhaWDRJK2FkdlhuSE5tdXhxMEFYZEZzT0gwdWs0SjN2TEpBeWNvNzFPWFov?=
 =?utf-8?B?M2IrNlQyckNJVUpnVi95NU8rSldsMWpLczJvSUwyWTVCUndtTWIxdmVONG1L?=
 =?utf-8?B?WnRnZ0xVNDNKS3lCZ056WWJCb3pJQkNGTVlqbnVWYkF2UWwvUTZxTXpLWFcy?=
 =?utf-8?B?UTROZFIrSHFKMEFyd0xGUDZPb0o3c3FUVUNOZGVUVUdQZE9VTW9qQzBIa1R2?=
 =?utf-8?B?eWczeUlEVko3TGpDZWx0WnlESjd5UUt0bDJndnNLZ1hjMncyZTNRWEQ1NjBq?=
 =?utf-8?B?RjI4cHBzZlNJVG4wb3VoRjVWSVJFbkNJTGZnSk03ZUFmS3RwSWFNaXBJUFY4?=
 =?utf-8?B?UlAyTEhuZ2hoWUtBWjd5d0FveFdRVml0bDFOdnhwSlJrb1BteVo0MUxvK045?=
 =?utf-8?B?eW5QcWp6cE5GN3dkcExjMlI2VndQRFN5RnQvK0w2V29teFlZMVJqTStIVlh2?=
 =?utf-8?B?NU1Mc0hCeDl0R2VUZ3B2VXNTZlBKWnFBRUQ3WStpRkF3U1FvNEZPcTl5eURZ?=
 =?utf-8?B?TEh1Qzd0UWpYTWNBT0VJeEVFZ25lZ0hTbDRjUHZYRW9NT0p6SUlZbE1ROHlK?=
 =?utf-8?B?QkRyWTFhQ0FuSmdQRkVaSUxXTElJKzBSZjM5RFNlYWUrdmZGczRCUUFCWDhZ?=
 =?utf-8?B?N0NJbEJUaXFOZnI5Y2VCQk5uLzdCajgvdWN3cnZ5VDdkdFpCZnlKTDlET2ha?=
 =?utf-8?B?QkJHN2hLTk9HTlZJVkdHN0hCMmhUYXlVaVFPMjRXVk9zQ2U0VUIyMzZhY1Ew?=
 =?utf-8?B?eEZTSVpBLzB5TjkzZFVVOXIwSTladnQ2SWJMRXhlb01LVGNhL2pudnN4eWMw?=
 =?utf-8?B?YWpLaXcvOXoxbEpSWVpHRGF1NjRzdkxReEtLRm82SkxKK3BWL0tWZnIwUEkr?=
 =?utf-8?B?anVUWTNUb0VxZUJJeERXaVJOTDB2N3VXOUJpbFEyWGdXaXJEUE5wTFArTW4v?=
 =?utf-8?B?YXZmMldQb09pL2FWNXJlSGowWjRVaWhlTENhK1RrOUZFM09KTFJwTzh5VzQ5?=
 =?utf-8?Q?b1cfG9SNEtZLrECAeldEPjyGp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 961196c2-1c15-4242-8581-08dbcbc02933
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5712.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 07:43:59.2085
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8LUug/4goWeW4VdaW8jHJbisvxvcosUWNwmWRp4LbiXO8e6Wmm9yvLMeKuD54No5AwUjfvPJXwb2O3e60h5tIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4443
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/13/2023 12:48 PM, Dan Carpenter wrote:
> Some of the error paths in this function return don't initialize the
> error code.  Return -ENODEV.
> 
> Fixes: d6389d3ccc13 ("perf/x86/amd/uncore: Refactor uncore management")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  arch/x86/events/amd/uncore.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/events/amd/uncore.c b/arch/x86/events/amd/uncore.c
> index 9b444ce24108..a389828f378c 100644
> --- a/arch/x86/events/amd/uncore.c
> +++ b/arch/x86/events/amd/uncore.c
> @@ -1009,7 +1009,8 @@ static struct amd_uncore uncores[UNCORE_TYPE_MAX] = {
>  static int __init amd_uncore_init(void)
>  {
>  	struct amd_uncore *uncore;
> -	int ret, i;
> +	int ret = -ENODEV;
> +	int i;
>  
>  	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD &&
>  	    boot_cpu_data.x86_vendor != X86_VENDOR_HYGON)


Thanks for catching this. I see that 'ret' remains uninitialized for cases
where the hotplug callback registration fails and was thinking if the
following is a better fix for this as the reason might not be ENODEV.

diff --git a/arch/x86/events/amd/uncore.c b/arch/x86/events/amd/uncore.c
index 91f01d6c8f7d..7d768dd01522 100644
--- a/arch/x86/events/amd/uncore.c
+++ b/arch/x86/events/amd/uncore.c
@@ -1039,20 +1039,25 @@ static int __init amd_uncore_init(void)
        /*
         * Install callbacks. Core will call them for each online cpu.
         */
-       if (cpuhp_setup_state(CPUHP_PERF_X86_AMD_UNCORE_PREP,
-                             "perf/x86/amd/uncore:prepare",
-                             NULL, amd_uncore_cpu_dead))
+       ret = cpuhp_setup_state(CPUHP_PERF_X86_AMD_UNCORE_PREP,
+                               "perf/x86/amd/uncore:prepare",
+                               NULL, amd_uncore_cpu_dead);
+       if (ret)
                goto fail;

-       if (cpuhp_setup_state(CPUHP_AP_PERF_X86_AMD_UNCORE_STARTING,
-                             "perf/x86/amd/uncore:starting",
-                             amd_uncore_cpu_starting, NULL))
+       ret = cpuhp_setup_state(CPUHP_AP_PERF_X86_AMD_UNCORE_STARTING,
+                               "perf/x86/amd/uncore:starting",
+                               amd_uncore_cpu_starting, NULL);
+       if (ret)
                goto fail_prep;
-       if (cpuhp_setup_state(CPUHP_AP_PERF_X86_AMD_UNCORE_ONLINE,
-                             "perf/x86/amd/uncore:online",
-                             amd_uncore_cpu_online,
-                             amd_uncore_cpu_down_prepare))
+
+       ret = cpuhp_setup_state(CPUHP_AP_PERF_X86_AMD_UNCORE_ONLINE,
+                               "perf/x86/amd/uncore:online",
+                               amd_uncore_cpu_online,
+                               amd_uncore_cpu_down_prepare);
+       if (ret)
                goto fail_start;
+
        return 0;

 fail_start:
 
