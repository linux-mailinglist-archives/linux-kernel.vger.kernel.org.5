Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C60067F6B59
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 05:24:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231162AbjKXEYH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 23:24:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjKXEYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 23:24:05 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2083.outbound.protection.outlook.com [40.107.101.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC65511F;
        Thu, 23 Nov 2023 20:24:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BkuXLfIDZWUh42v5ffp6sTupZjhZimD61vZWmFscZNDLYxRTfasd4Lkom8PsSriUsrV182l6kilg07xMe3AMlotWYFJWjeVEIqjjkA+6rZsd7Wmk/dgRouvyRbejPBCQtadEnELR32HleDFqWi0C6TRVU6c7JwvH+fQdrAhdvHw5Y8HlpADQQXV7MaukmGUuxXIAQcDpnIs60mc6aKZB+7+6jwpKySJX3+Axy35KDKrp1ieES19EirY38wj1xkmUlY3sB7yq/419PGokguzUNzGo/WOzkIaMbq1YBFBbq/qrPscS8zpAy73B+MQ9xO03n6+NigE1AF+6d32Pq4+u4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kVrLmkkNcvB4mm1wmls6Qvhorl8b2IkdmqVcDoI6+24=;
 b=fJUvvN0pX7JthIji9Th1WtK3BKOyUUuLNSUH490M31SWwz+vsg8aPshFx6+6b3+ysVXlnlRv/inQku9d8Ei5mWHq0SZBjRCh7w6MG1FXO6wYzRdsy/+nzTxQGBHWMUHw2wWCeOw5HBhkiQpcS5Z+WQ6qJCGlf+4bKuXgxbMsDFvooO1ipZLA+AB9The0qvGUgphzqBRwLoh4GwHWW7E0mDz8w7DuHpYC5/ZOgU5HFj3AbVK8Hifyqx6CXEKXr/4jrrfvsSL/CLqk2qoV0rzWHmY9Ng/6SPvRMb2851TKhKv6XkLtaOqHUsBbs+ALawRkfH2gfNj5OUAnqnXdiz67yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kVrLmkkNcvB4mm1wmls6Qvhorl8b2IkdmqVcDoI6+24=;
 b=1Bp+g8pK95uHTTdiKyr850YPlheyrzBOoNE9BQYRT4TqDpkn7SmijnfrqJ0abesqi8pDRSskkjwWRKg7/7CVsgwS4Qp1+701w0446hc6p5tXGJjPhKPlpv10Ey+hHKkzYbYNUDkn5AEwLr+Re0lalpEYK32gi7TlN4DMOBcYNSw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3888.namprd12.prod.outlook.com (2603:10b6:208:162::32)
 by SJ0PR12MB6941.namprd12.prod.outlook.com (2603:10b6:a03:448::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.20; Fri, 24 Nov
 2023 04:24:09 +0000
Received: from MN2PR12MB3888.namprd12.prod.outlook.com
 ([fe80::6cb9:3a50:957a:f6b6]) by MN2PR12MB3888.namprd12.prod.outlook.com
 ([fe80::6cb9:3a50:957a:f6b6%2]) with mapi id 15.20.7025.021; Fri, 24 Nov 2023
 04:24:09 +0000
Date:   Fri, 24 Nov 2023 09:53:58 +0530
From:   Wyes Karny <wyes.karny@amd.com>
To:     "Gautham R. Shenoy" <gautham.shenoy@amd.com>
Cc:     Huang Rui <ray.huang@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Perry Yuan <Perry.Yuan@amd.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq/amd-pstate: Fix the return value of
 amd_pstate_fast_switch()
Message-ID: <ZWAlXl6MP20khEwB@BLR-5CG13462PL.amd.com>
References: <20231123082757.3527-1-gautham.shenoy@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231123082757.3527-1-gautham.shenoy@amd.com>
X-ClientProxiedBy: PN2PR01CA0124.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:6::9) To MN2PR12MB3888.namprd12.prod.outlook.com
 (2603:10b6:208:162::32)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3888:EE_|SJ0PR12MB6941:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c47a475-5c08-4732-f88f-08dbeca533f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9DZ0IERmSGwk3L2i8emXYNJGOAB311V07eq69Uu7B9i0SOL87gb/NEnu7nfT1X7FDiSUQCNd+lvGdXF5KZIJz7fOn+I43KhRb3k6d5BpP1StKgUojvn7sEzzBKMWdEsPbHX/0ZbkUTtDQ5Izaw+tYS5gBUhX1WSJt3BlbMszZJvQBmFLfK90c6Q5aHnwPWANs8ZyHJgl2bQryOpJhvozuP6Z+1XjVKV41PJ28pOsjvH9uWFxtQ2N4IwPNVEJDCdhWEKfCPGQMVAguc3Vx3Xa6cOKgIZxIwraAxS5PfWYmIGR6Tivb3vMbKa6lDeG0aOIOddugrNyapI3o6HSzw/zL8wrUWHPc0agubUhq2/nIvAx1BbSGDJv8zpXpLZ9umlQqO3z5jR+Ndael2j+69G9lnY/owrPG1ASRq5ogAM2N9o8/3S0V2Si1E5TznK0T9Tly6S4YoSWUDJp4Rtnn0Jn+lcoTkV+KbXjce5T6naGfcYEY5y9PIQL4Eb81Q7TTt4H/AZnqSwPT+z8r855IXTY4w/0koEO9SHFoeirM2vONNfmH+9qq/uN5OSWhfF0TrHT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3888.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(376002)(39860400002)(136003)(366004)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(83380400001)(26005)(6666004)(6512007)(66476007)(6506007)(41300700001)(44832011)(6862004)(5660300002)(2906002)(6486002)(316002)(478600001)(8936002)(8676002)(4326008)(6636002)(66556008)(54906003)(66946007)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4iTLR38LZgzGed8tVB67UaEQsqZc0CwYg+nRFlTFfSSXa/civqsX3Y/6LrtZ?=
 =?us-ascii?Q?32AWYBaJG54LSUMDENvo62pMjFBjYLH1H46IC3AbI0GdFyb8MKayOnRukP0D?=
 =?us-ascii?Q?TlFQzacjiQAfFN3R9sTK0B7UrHpTgW/8dY+lF0GC/HedsNuqzMkjMSd4hhzM?=
 =?us-ascii?Q?pZaxGfxEUAaujLCj5ZSD0L2X+3yQu+5636/112LlqOcV/vEtAwvf/L4cMsPv?=
 =?us-ascii?Q?zoi0WBQnifUXB+pUkgRgzPVeubAQB0Pth+oyA0s4wtp3IDl+vjFnBIv/Lh6R?=
 =?us-ascii?Q?TzcVg9abRp2NywIEhkslqY03qbqbt71pwHDTX2fRFd3YA5OwUM7GOZNKQj+w?=
 =?us-ascii?Q?tIRf8sVCFw3aeYpOU2EN0zl1BAuaF944qQGAaP9BdpylCMUT0hFH83iPDLj9?=
 =?us-ascii?Q?ShBog+2nT/Vhh2EXL2BWlMOOxSASueTgO0orFfKNqje8dgg6yz+l0yHuTivH?=
 =?us-ascii?Q?579ICEhgEm4DLyLnHwUIH9M8fOGGqVPEYT6ukAElOHWhMOpnvh+CahvJydZ7?=
 =?us-ascii?Q?Qh3xh9TNxPMe4HsGHr6hzNT5xtAvaPE0UZ6nNxq4OqM3L9XJdrdLeU9ONkuT?=
 =?us-ascii?Q?juOKvjjtPM+IuM8y0TgywvkZ40TCVWyrMCNn86K8AJdn88OEmoFYlYzmAE8N?=
 =?us-ascii?Q?WObY+26FbGZ5UrFH4Kr8ZQSzZR43foIYx/bwu05SDpORoRJNkbD9iyPPv1aS?=
 =?us-ascii?Q?ZKaRHn+ZdEJ/rBxRxbLFLEQmAaPvyPIzouEyuZXhoC3LeyFA5ZQ0ajbE9Ny0?=
 =?us-ascii?Q?RoL99d6zBFPB4C6Lugt4PBNEUifpiv1WVh1VHRYlzN3wV5DjiIFOeTelPfhL?=
 =?us-ascii?Q?UCkx62mBs8Ydlg0AtRCGJuZjQqe6lM/A6DVPjASbnrBkGSuKf7f9JKHQ/lEf?=
 =?us-ascii?Q?imVDxTT86vHhjJvyEiDC/nUGIErLy6k2sPpOOfNWNk2Go4fGF3iDtkWCU/qC?=
 =?us-ascii?Q?PdSqjAvhXUC3WQwRxBOEwDc7G+vBhVKxw8DZSorvVIrb9sj4CaCNPV6Ae8ml?=
 =?us-ascii?Q?xTgEfyidbVBp4pY/BVXKrXbvwHU5AvxUHGeOFozfDnuMCihkvA9zWLktLiw1?=
 =?us-ascii?Q?fzxQ9ejLWD/vWkrUFY3pGy9ttte7STPY+CL6EbB9xyPunKWqPnComM0jpw5c?=
 =?us-ascii?Q?fMhbx+qd9wjzZxu7y5nw/Lw91UfjdpnqueuIsNNyf7HJiBTFjbREA5jx3SXO?=
 =?us-ascii?Q?N+bZlQzFnafQsUac8ezwWDSjspAYkveCPt4LmP8TlphzoX/fgpc34S98Nk+U?=
 =?us-ascii?Q?a/3L+gvPRSjFUpJWZYZiAp25Z8Ye0geXxCCyzPDWNDFGXereyoZDC+M+9ceo?=
 =?us-ascii?Q?vhcMc/eNypjOMTG/ZdfPtAaABMNH1FLM9ki062VaVBw0ifKZq2NUmtOf/zRb?=
 =?us-ascii?Q?bQa5g6QJAEprBaGt+b9vCcvRJRXFu1mNMClmWuZRwy1DnXYCYIltj2btB7S5?=
 =?us-ascii?Q?aoMXOtn3noHuVl54llm1arZ6jEmWy7aNO1u2DOC9DtyBi7naULgj613opCrt?=
 =?us-ascii?Q?P+MBD4EGav5E1ntZe5Cg3qf0gKoOE642lNaORyaI3RMcLm5ERzEI56uixfgV?=
 =?us-ascii?Q?7x5nk5kxTaH887A/wzVjVvt2HRBF2SvYfqnsP7aX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c47a475-5c08-4732-f88f-08dbeca533f5
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3888.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2023 04:24:09.0595
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kUMnbqdMkd3CHig6rvOGB0bgtlLxh2Hpq7sKRCVsmbC958gRHZJCKq/t7g1sBhFbzErcxmnRA8wW3HTYi+ZBmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6941
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23 Nov 13:57, Gautham R. Shenoy wrote:
> cpufreq_driver->fast_switch() callback expects a frequency as a return
> value. amd_pstate_fast_switch() was returning the return value of
> amd_pstate_update_freq(), which only indicates a success or failure.
> 
> Fix this by making amd_pstate_fast_switch() return the target_freq
> when the call to amd_pstate_update_freq() is successful, and return
> the current frequency from policy->cur when the call to
> amd_pstate_update_freq() is unsuccessful.
> 
> Fixes: 4badf2eb1e98 ("cpufreq: amd-pstate: Add ->fast_switch() callback")

Reviewed-by: Wyes Karny <wyes.karny@amd.com>

> Signed-off-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
> ---
>  drivers/cpufreq/amd-pstate.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 9a1e194d5cf8..300f81d36291 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -518,7 +518,9 @@ static int amd_pstate_target(struct cpufreq_policy *policy,
>  static unsigned int amd_pstate_fast_switch(struct cpufreq_policy *policy,
>  				  unsigned int target_freq)
>  {
> -	return amd_pstate_update_freq(policy, target_freq, true);
> +	if (!amd_pstate_update_freq(policy, target_freq, true))
> +		return target_freq;
> +	return policy->cur;
>  }
>  
>  static void amd_pstate_adjust_perf(unsigned int cpu,
> -- 
> 2.25.1
> 
