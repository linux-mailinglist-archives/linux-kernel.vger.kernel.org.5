Return-Path: <linux-kernel+bounces-116603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D437A88A0FF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:09:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 886CB2C61BC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D342613D623;
	Mon, 25 Mar 2024 08:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VA8RnF41"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2054.outbound.protection.outlook.com [40.107.220.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2D816AFA5
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 06:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711349053; cv=fail; b=GXguagf/C6AGxWn2Y8CawsHA+/fv6dOtiqnpd6rBwjNIRDWc95ChoXPqMq4SsJ5aoaQp/Y7RmiO1O9TTYHmiJ2H5m5MnXYCpx6K60u3dqLLYIyFHuJMdp+5JUKM2vSynspKez028C29U5FydQYf9mFUXCAAqXqBx+TFO7e7Hq7I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711349053; c=relaxed/simple;
	bh=bjeB1JswHwxvd9lBU3jZalmrSIgJcmCQCxL0XdxtDNM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RbYOjC35yjg22Xbme6pFCIHv50tjUjdCJ43rNE6kpu0fPg5w40rOtTrcDvs9ZqYpW3pDRC8J/ZnoM16OGEyjrFHKdxgG1Riva28PbiTio9o4Vtb17P7IqIDYrYSwT5+v8kiuMRdB/9Wvfhy1hbFKy7pUe6/5XkMxNKsz0FkAMwY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VA8RnF41; arc=fail smtp.client-ip=40.107.220.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YjZfBMraUOULHi6GhTpfYnwwiPUNQ49YDoY+UFvOpXAjFMvWx+68C4WwIxx9d3joM8ZtumfwiIM4U4b2vnYtC+Y7T4YEN3jVPydZ/nycS6aGNuuJB54/fUGwRM3jgzY7ggFXpz/kWi5AdwdoE8rIUi4xUArsH8MG6awXvbkxdI7y9Ug9j58gh2Ja0c/dygGSi7BW3fvvrvPjbFW+kK+45fzoeeAjuX5OmOeXlW+vDpATttd6IW6QmPYFInBt/fvJ6gjNUa8ekiCt/d/D3udggQD7oWn1UgmwGkpGF+FZwljSDPNf2FJrSbvsq54TYRztgJ5UIfU0ZXI2sN0qLkgwFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xlE75bqxn89uk0UBwqJk4I4Zmn/ugZV/VceIAU+H+Sk=;
 b=UV8YmcrhBp2W8vABe+uLv/4tdnMrsQNxBbYv1SH1V8KaaPTfRApVtfmrMY6JdmVzjgA6mQfOmBgHA1SjqCKEbB95NKwK+QHJCy4AioM08FKG22yXCJqm0asxZ9Awrb0quQCtxJKPHj+NVwCqOVwYzBDiISAXeadBh6UU+T2I78DonSCQjq9wdiXjC1WTSJML2nRHXjj6psBfVAvfnJICxp1lFiVjJxQeYfEs43Ob2oC+7Rn6zNIPP5Bhj6LOZCBOveYSeNn6/7dMcqhBX2SRdQ1S8EdRD9lkLYUWQujwrqVAgoJ8CU7pOJhh0sMZ2TaJl+wx315dmvEy7+7V04eBnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xlE75bqxn89uk0UBwqJk4I4Zmn/ugZV/VceIAU+H+Sk=;
 b=VA8RnF41y7YdCL10O3MxG+bO3t4O1yWbgkUXdp2K90gMwrBMO1kBSnVPiI1fImJ8kMdDseWCUHdq6k6e5osBZuGzejAjem33ChRq5br9pyXLTowNqC3HLR8Y7C9gG+oKUZb9OLNcIDWcQJQ3RecbO6Hxv/nix1W8GUR9+UgIZGo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2379.namprd12.prod.outlook.com (2603:10b6:907:9::24)
 by IA1PR12MB7592.namprd12.prod.outlook.com (2603:10b6:208:428::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Mon, 25 Mar
 2024 06:44:07 +0000
Received: from MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::494b:99e2:884a:dca1]) by MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::494b:99e2:884a:dca1%3]) with mapi id 15.20.7409.028; Mon, 25 Mar 2024
 06:44:07 +0000
Message-ID: <218a5f34-dcca-ab0e-e098-807993ca3898@amd.com>
Date: Mon, 25 Mar 2024 12:13:54 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v9 0/7] Preparatory changes for Proxy Execution v9
Content-Language: en-US
To: John Stultz <jstultz@google.com>, LKML <linux-kernel@vger.kernel.org>
Cc: Joel Fernandes <joelaf@google.com>, Qais Yousef <qyousef@google.com>,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Valentin Schneider <vschneid@redhat.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Zimuzo Ezeozue <zezeozue@google.com>, Youssef Esmat
 <youssefesmat@google.com>, Mel Gorman <mgorman@suse.de>,
 Daniel Bristot de Oliveira <bristot@redhat.com>,
 Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>,
 Boqun Feng <boqun.feng@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>,
 Metin Kaya <Metin.Kaya@arm.com>, Xuewen Yan <xuewen.yan94@gmail.com>,
 Thomas Gleixner <tglx@linutronix.de>, kernel-team@android.com
References: <20240315044007.2778856-1-jstultz@google.com>
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20240315044007.2778856-1-jstultz@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0189.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:be::11) To MW2PR12MB2379.namprd12.prod.outlook.com
 (2603:10b6:907:9::24)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PR12MB2379:EE_|IA1PR12MB7592:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b4defa0-d482-4486-ce5a-08dc4c96f7cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	CfVwFUp7GXBD6pCBjSFAwrDZCw6bVsGj5OdcrfkdgVhhjOdrxApb2h4oS4T/2a0pBOEN7tgG1Md72jJjbjpcfau6bopX0aswLoQf7IPtpUAHDs2L16LYO9II2EQw0+dFWKsbRkNlzPnlnvd+18Mq+3JQEhSbu5KHvzC3YDvtSv0ZJoZwsMhR68g83xq4SovhNSbMQK4yol8gB++pkfKuAOIu6cPx9ZaElN2jXql386lHAayW4UzLnAE/R5W+VPdEmWfgEWHB+TkGiM6w6qm0zTXXQXhPqp1AUFsM8zMilV/x0pfG5pfrF6tf0HhuhRtux03/hh4q3+liZtUmuCoLxIOjL2kKIuEpIf167stRWNapagKgTQm3X4DPg9q1kB3XEoPk4ODTRvwWTh90+g84FHm0IhLk2dGceu1WqMbZRoBpBNPz5aI2sWLciihrxy4TOlQKlkjumk1/rdm9rFY68FTJCw2pjUKXzLxWs+X5xG9tzUfBm+Vv0vk8BQUOd1JPli4/+qirTg1zlJ175fGC96mQsQGCQ4A6kG82BBQ/YCbx9i/RC6GMdvtll25ZlVndGa2SfWKcVHa7YaFVdpfKAdxIujx51p7Rm/XkK80chT/oBGRaHyvMcjSu7GM+n0fr
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2379.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RUVKSEVnQTAyc21YSGJtNUhaeENIYzkvNmVxbUxrUXpSMFRTNWEzdnVDUkNj?=
 =?utf-8?B?TG4vVVU2WXpnSTV2bGVkYmdndk1tV3ZVQWFaaVA5Nk1ZL0paYlZubHA4NU5I?=
 =?utf-8?B?ZXdrS01RMHBqbHNvdDh3ZS9yRHJTY1VEeElJcEhuUjFMajRnTVJCb3FleGdD?=
 =?utf-8?B?clNwY2wzbHdIakYxRDc5YU1kcWM1eDQvbHRYbW9ReWt3eGdDek5XYityZEYx?=
 =?utf-8?B?K3k4Z1MyTEdtWll2RXh2TnRHV1Bud01LUnBKVnRwRFRqUkVsYnFUUjhNT081?=
 =?utf-8?B?aG9uL0l0RmorcGo2eVY2S0VscE9sRVNkb3RlOFRzbkcrbHltVWlBR2lTUTBx?=
 =?utf-8?B?aERuc1JZVmlGTTArUTl0VDhuU214VkswdXlNcEM4Z1BXbWJScEVIU1hhL0Vu?=
 =?utf-8?B?VzZVUlFSOHV3RHN1aUJ6WDBJNnF0S0lZUEFHTHhWcC8raFhUc3VzUnNFc2lC?=
 =?utf-8?B?b1FoV2kvUEkraHhTbXdrVnFyL1ZXcDV6TTNtVkdMWFZqbVVrSkFnYmhrR3h1?=
 =?utf-8?B?ZGFkNGFIR3lGQ0o3bTI3QzFNVlRJQk1Yb0pXZkd1VkJXZkZSRmZtM00vejcr?=
 =?utf-8?B?c0dCQXFoUjhIQ2VpS1hXUnd1WUNPYmI3YU1QVXVMQmZmSEpEWE9tbjE0WEZl?=
 =?utf-8?B?NjR4UzFwdTIzbVE1RHVON01ScWk3STM5VlFoNHZxUEd1dGl1dThvckdZdWpW?=
 =?utf-8?B?ZGxBYnBqQ205aTRtdUF1ZFNOWUIrU0EyWDFWVWo3Z0VRT0FnbDRTNEJic2Fp?=
 =?utf-8?B?SWFEMGJsOTRJUVBmODhRWXpOUHhTcC9RRWc1dHcwTEhZK2NtQWRLQzJNRUp2?=
 =?utf-8?B?THFDVWlFY29hWTJydFVvQUlwUE1xUmJzbUZnSFJveTEzd2hPTEZ1WXNFNXpT?=
 =?utf-8?B?TVpGWjA0bnJKYTN6V3hmS3gra2ZIcmdVakdjTnd4Y0tBd0cwbUw0THdhOFNq?=
 =?utf-8?B?SWpEZUFqdjlkNlpRQjNsUjFzZEl4K05mMEd6L0Vpc2F4MDNNMlBtYkJIRWhE?=
 =?utf-8?B?bmpRUjNtUGtvQTAwQnRtRmxtTGNLWS9pdnBjKzJ6ZmtoZjYyUVE0QVBGRUxr?=
 =?utf-8?B?aEpDUU04TFdEZjdpeUFMOXc1Q3JpZ0FIVVR4QmpIaFpjSzhybEZpVEtvb0hh?=
 =?utf-8?B?OUhoT1ZSV1BQdjIzMWF2K0ZiSFhMdzdRYjdlTExMa1BETWhudm9lUFFOMVhm?=
 =?utf-8?B?aVRXb1ZPc1ArRG5Kdk5xZXlBVEx4aXR0emNmaEJxYWZYUHFENEkyQUVJK0Vh?=
 =?utf-8?B?R04xRUp3TUlMOCtSUHorKytPTVA3Q01NbG5uL1BPN1RtUzB2aSsrMEJpYXM2?=
 =?utf-8?B?K2VvaDN4aFQ2cFIvU0RaU3hnNXFuOHhaUHk2RjhjRERsa05HcFFkTm5oSnVx?=
 =?utf-8?B?a25Ob0RKZ01KUk5VWE9HRHpaV3pCcDVWSlNnZXpLYzBoU3QyOVRjZnNhRDJV?=
 =?utf-8?B?YnBUVU1aVmN2MURDdWRZUUVoR1lPRkZKK3RIcEZnOU1aRFhBL2k5a21hUjhF?=
 =?utf-8?B?S0x4QWNDRy9lM1ZNZzcrUVZoYVFmVnQxVHh4RzhKb1pNM1VXMm1LcXBnOGU3?=
 =?utf-8?B?K2ZBYmlMYTJ4YlluTXN4NDFuMFdmQnE2eUYyY2pZbHBkMkZ0WUpaakptZ1Ja?=
 =?utf-8?B?bHA3RmpBMmUrMzdNSmozb0UwWkNYYlJCc2hRd0l5aVVIaHRqR3VrdmgvdmRN?=
 =?utf-8?B?Y0JGeXZGd3dzYlNMbkNXbzNsUzBJZXBudGNjY3hmYjZRNDVJNnJ5bWZLdUlu?=
 =?utf-8?B?RkhjQndybTJETDM0VllWdmxpZTFpcXhpeFFKNWRzU3VMZnRzVXY4N1VJNkxV?=
 =?utf-8?B?MXJ5TXFrWHF3ZFJaNEhpU3JOWGVMc0JaaEYvVDEzNHlDTEw3ZFpaZERqcmpn?=
 =?utf-8?B?MnhyNlNpSkpsZE1INS9wdWlIUy9GMnhTcjhOTzZXeHJ2ZXAxNk5UbFBKRUN0?=
 =?utf-8?B?aHp0amRsNTdXQlNveTM0NmlORDlUejRRL3FaTzZOMVFCUGdKdHNQMjFrK2Qy?=
 =?utf-8?B?NlJQZVdlaHdTL1BRL09QS2hIWjIxdld2VkhvTEFVN0V3WGE2b1ZqNldxY0R4?=
 =?utf-8?B?RDAvTlZYNUh6TWhWUks1WElyTVVUQjI5T0J2NFdRZHVFdTNuZ0VORnJja3hN?=
 =?utf-8?Q?cMvithDyiMlgq8GQX/3+B5QPm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b4defa0-d482-4486-ce5a-08dc4c96f7cc
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2024 06:44:06.9370
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kG16AIlJ8BcycdKuvAkAh64gzNIdiLZaCSvgHL/JyhaVWbixDI+1s6LifmFKC1onVk7XJBADOrgRAVpGtonWeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7592

Hello John,

On 3/15/2024 10:09 AM, John Stultz wrote:
> As mentioned last time[1], after previous submissions of the
> Proxy Execution series, I got feedback that the patch series was
> getting a bit unwieldy to review, and Qais suggested I break out
> just the cleanups/preparatory components of the patch series and
> submit them on their own in the hope we can start to merge the
> less complex bits and discussion can focus on the more
> complicated portions afterwards. This so far has not been very
> successful, with the submission & RESEND of the v8 preparatory
> changes not getting much in the way of review.
> 
> Nonetheless, for v9 of this series, I’m again only submitting
> those early cleanup/preparatory changes here (which have not
> changed since the v8 submissions, but to avoid confusion with the
> git branch names, I’m labeling it as v9). In the meantime, I’ve
> continued to put a lot of effort into the full series, mostly
> focused on polishing the series for correctness, and fixing some
> hard to trip races.
> 
> If you are interested, the full v9 series, it can be found here:
>   https://github.com/johnstultz-work/linux-dev/commits/proxy-exec-v9-6.8
>   https://github.com/johnstultz-work/linux-dev.git proxy-exec-v9-6.8

Tested the v9 of the series.

tl;dr

o I still see a small regression for hackbench. I'll get some perf
  profiles for the same and leave them in this thread soon (I do
  not have them at the moment unfortunately)

o There is a regression for some combinations in schbench. I'll
  have to recheck if I can consistently reproduce this or not and
  look at the perf profile to see if something is sticking out.

Rest of the benchmark results look good. I'll leave them below and
go digging at the regressions.

o System Details

- 3rd Generation EPYC System
- 2 x 64C/128T
- NPS1 mode

o Kernels

tip:			tip:sched/core at commit 8cec3dd9e593
			("sched/core: Simplify code by removing
			 duplicate #ifdefs")

proxy-exec-full:	tip + proxy execution commits from
			"proxy-exec-v9-6.8"

o Results

==================================================================
Test          : hackbench
Units         : Normalized time in seconds
Interpretation: Lower is better
Statistic     : AMean
==================================================================
Case:           tip[pct imp](CV)    proxy_exec_v9[pct imp](CV)
 1-groups     1.00 [ -0.00]( 1.80)     1.03 [ -2.88]( 2.71)
 2-groups     1.00 [ -0.00]( 1.76)     1.02 [ -2.32]( 1.71)
 4-groups     1.00 [ -0.00]( 1.82)     1.03 [ -2.79]( 0.84)
 8-groups     1.00 [ -0.00]( 1.40)     1.02 [ -1.89]( 0.89)
16-groups     1.00 [ -0.00]( 3.38)     1.01 [ -0.53]( 1.61)


==================================================================
Test          : tbench
Units         : Normalized throughput
Interpretation: Higher is better
Statistic     : AMean
==================================================================
Clients:           tip[pct imp](CV)    proxy_exec_v9[pct imp](CV)
    1     1.00 [  0.00]( 0.44)     0.99 [ -1.30]( 0.66)
    2     1.00 [  0.00]( 0.39)     0.98 [ -1.76]( 0.64)
    4     1.00 [  0.00]( 0.40)     0.99 [ -1.12]( 0.63)
    8     1.00 [  0.00]( 0.16)     0.97 [ -2.94]( 1.49)
   16     1.00 [  0.00]( 3.00)     1.01 [  0.92]( 2.18)
   32     1.00 [  0.00]( 0.84)     1.01 [  0.66]( 1.22)
   64     1.00 [  0.00]( 1.66)     1.00 [ -0.39]( 0.24)
  128     1.00 [  0.00]( 1.04)     0.99 [ -1.23]( 2.26)
  256     1.00 [  0.00]( 0.26)     1.02 [  1.92]( 1.09)
  512     1.00 [  0.00]( 0.15)     1.02 [  1.84]( 0.17)
 1024     1.00 [  0.00]( 0.20)     1.03 [  2.71]( 0.33)


==================================================================
Test          : stream-10
Units         : Normalized Bandwidth, MB/s
Interpretation: Higher is better
Statistic     : HMean
==================================================================
Test:           tip[pct imp](CV)    proxy_exec_v9[pct imp](CV)
 Copy     1.00 [  0.00]( 6.19)     1.11 [ 11.16]( 2.57)
Scale     1.00 [  0.00]( 6.47)     0.98 [ -2.43]( 7.68)
  Add     1.00 [  0.00]( 6.50)     0.99 [ -0.74]( 7.25)
Triad     1.00 [  0.00]( 5.70)     1.03 [  2.95]( 4.41)


==================================================================
Test          : stream-100
Units         : Normalized Bandwidth, MB/s
Interpretation: Higher is better
Statistic     : HMean
==================================================================
Test:           tip[pct imp](CV)    proxy_exec_v9[pct imp](CV)
 Copy     1.00 [  0.00]( 3.22)     1.04 [  4.29]( 3.02)
Scale     1.00 [  0.00]( 6.17)     1.02 [  1.97]( 1.55)
  Add     1.00 [  0.00]( 5.12)     1.02 [  2.48]( 1.55)
Triad     1.00 [  0.00]( 2.29)     1.01 [  1.06]( 1.49)


==================================================================
Test          : netperf
Units         : Normalized Througput
Interpretation: Higher is better
Statistic     : AMean
==================================================================
Clients:           tip[pct imp](CV)    proxy_exec_v9[pct imp](CV)
 1-clients     1.00 [  0.00]( 0.17)     0.98 [ -1.99]( 0.24)
 2-clients     1.00 [  0.00]( 0.49)     0.98 [ -1.86]( 0.45)
 4-clients     1.00 [  0.00]( 0.65)     0.98 [ -1.65]( 0.30)
 8-clients     1.00 [  0.00]( 0.56)     0.98 [ -1.73]( 0.41)
16-clients     1.00 [  0.00]( 0.78)     0.98 [ -1.52]( 0.34)
32-clients     1.00 [  0.00]( 0.62)     0.98 [ -1.90]( 0.73)
64-clients     1.00 [  0.00]( 1.41)     0.99 [ -1.46]( 1.39)
128-clients    1.00 [  0.00]( 0.83)     0.98 [ -1.63]( 0.89)
256-clients    1.00 [  0.00]( 4.60)     1.01 [  1.47]( 2.12)
512-clients    1.00 [  0.00](54.18)     1.02 [  2.25](56.18)


==================================================================
Test          : schbench
Units         : Normalized 99th percentile latency in us
Interpretation: Lower is better
Statistic     : Median
==================================================================
#workers:           tip[pct imp](CV)    proxy_exec_v9[pct imp](CV)
  1     1.00 [ -0.00](34.63)     1.43 [-43.33]( 2.73)
  2     1.00 [ -0.00]( 2.70)     0.89 [ 10.81](23.82)
  4     1.00 [ -0.00]( 4.70)     1.04 [ -4.44](12.54)
  8     1.00 [ -0.00]( 5.09)     0.87 [ 13.21](14.08)
 16     1.00 [ -0.00]( 5.08)     1.03 [ -3.39]( 4.10)
 32     1.00 [ -0.00]( 2.91)     1.14 [-14.44]( 0.56)
 64     1.00 [ -0.00]( 2.73)     1.04 [ -4.17]( 2.77)
128     1.00 [ -0.00]( 7.89)     1.07 [ -7.14]( 2.83)
256     1.00 [ -0.00](28.55)     0.69 [ 31.37](19.96)
512     1.00 [ -0.00]( 2.11)     1.01 [ -1.20]( 1.07)
--

I'll leave more test results on the thread as I get to them. It has been
a slightly busy season so sorry about the delays.

> 
> 
> New in v9:
> (In the git tree. Again, none of the preparatory patches
> submitted here have changed since v8)

Since these changes in this preparatory series have remained the same,
please feel free to add:

Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>

> ---------
> * Change to force mutex lock handoff when we have a blocked donor
>   (preserves optimistic spinning elsewhere, but still prioritizes
>   donor when present on unlock)
> 
> * Do return migration whenever we’re not on the wake_cpu (should
>   address placement concerns brought up earlier by Xuewen Yan)
> 
> * Closed hole where we might mark a task as BO_RUNNABLE without
>   doing return migration
> 
> * Much improved handling of balance callbacks when we need to
>   pick_again
> 
> * Fixes for cases where we put_prev_task() but left a dangling
>   pointer to rq_selected() when deactivating a task (as it could
>   then be migrated away while we still have a reference to it),
>   by selecting idle before deactivating next.
> 
> * Fixes for dangling references to rq->curr (which had been
>   put_prev_task’ed)  when we drop rq lock for proxy_migration
> 
> * Fixes for ttwu / find_proxy_task() races if the lock owner was
>   being return migrated, and ttwu hadn’t yet set_task_cpu() and
>   activated it, which allowed that task to be scheduled on two
>   cpus at the same time.
> 
> * Fix for live-lock between activate_blocked_tasks() and
>   proxy_enqueue_on_owner() if activated owner went right back to
>   sleep (which also simplifies the locking in
>   activate_blocked_tasks())
> 
> * Cleanups to avoid locked BO_WAKING->BO_RUNNABLE transition in
>   try_to_wake_up() if proxy execution isn't enabled
> 
> * Fix for psi_dequeue, as proxy changes assumptions around
>   voluntary sleeps.
> 
> * Numerous typos, comment improvements, and other fixups
>   suggested by Metin
> 
> * And more!
> 
> 
> Performance:
> ---------
> K Prateek Nayak provided some feedback on the v8 series here[2].
> Given the potential extra overhead of doing rq migrations/return
> migrations/etc for the proxy case, it’s not completely surprising
> a few of K Prateek’s test cases saw ~3-5% regressions, but I’m
> hoping to look into this soon to see if we can reduce those
> further. The donor mutex handoff in this revision may help some.
> 
> 
> Issues still to address:
> ---------
> * The chain migration functionality needs further iterations and
>   better validation to ensure it truly maintains the RT/DL load
>   balancing invariants.
> 
> * CFS load balancing. There was concern that blocked tasks may
>   carry forward load (PELT) to the lock owner's CPU, so the CPU
>   may look like it is overloaded. Needs investigation.
> 
> * The sleeping owner handling (where we deactivate waiting tasks
>   and enqueue them onto a list, then reactivate them when the
>   owner wakes up) doesn’t feel great. This is in part because
>   when we want to activate tasks, we’re already holding a
>   task.pi_lock and a rq_lock, just not the locks for the task
>   we’re activating, nor the rq we’re enqueuing it onto. So there
>   has to be a bit of lock juggling to drop and acquire the right
>   locks (in the right order). It feels like there’s got to be a
>   better way. Also needs some rework to get rid of the recursion.
> 
> 
> Credit/Disclaimer:
> —--------------------
> As mentioned previously, this Proxy Execution series has a long
> history: First described in a paper[3] by Watkins, Straub,
> Niehaus, then from patches from Peter Zijlstra, extended with
> lots of work by Juri Lelli, Valentin Schneider, and Connor
> O'Brien. (and thank you to Steven Rostedt for providing
> additional details here!)
> 
> So again, many thanks to those above, as all the credit for this
> series really is due to them - while the mistakes are likely
> mine.
> 
> Thanks so much!
> -john
> 
> [1] https://lore.kernel.org/lkml/20240224001153.2584030-1-jstultz@google.com/
> [2] https://lore.kernel.org/lkml/c26251d2-e1bf-e5c7-0636-12ad886e1ea8@amd.com/
> [3] https://static.lwn.net/images/conf/rtlws11/papers/proc/p38.pdf
> 
>[..snip..]
> 

--
Thanks and Regards,
Prateek

