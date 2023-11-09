Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEBBE7E730A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 21:47:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345197AbjKIUrs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 15:47:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjKIUrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 15:47:46 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2051.outbound.protection.outlook.com [40.107.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E46CB449E
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 12:47:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k78k2XWR3mFJf8JP/8npWosA1Uo4B5bylPkylarXSbWeSwqXpaIkJFh9kL/CJjXzCh3PbNfT10UdACm7/Zw1KD3TjyUmruzzIWQBY9XoW7xbFKuZY3DSxVgV2wWaiRIq4erb//9qWXJcpFQw2lC8xo2HMbXcB15KtBqquCaMGFlF4s+Z14ZgB8tY98jWawDSMUXkHmgJa42wpoPFzUMqXxcvCLe9hqp4ypn8+reyU1L3U4TXTIXljR2Y/VtLd80ATidBNJmxyAuKpR+xCYzvqz/brtxZRIqQd6NfSeqZSsI1z+v7XXz+edV/rxnCPHQ9KlNdKa9YsnDxyYJCUU43pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZfOHR7US1MYqX2eRxJKighP2vcp8ylRtwWVSfJQZTDE=;
 b=OWfIiuh5sAu5Yoc8ofsTBKlsWzSbpIno2HbqRUoDP/7v6uiVNRsSiPEL4VFKtBftw8BDFJndZ9hmX3nV6ygpoiMmzmBORsmO6TWykkipVxfa38pgRarKURJnSeOKcwA0cp/RLOM19HMcKLSDsuw+O06w+dYpv0uu20ljKMAkMq2DdhglQkKAJLAFK1Er9HP53s2Y2PnQnA11FtQ3xsvC/j3tjBFQr9CbQdViSkbUB5u/KCH43oCGLg/y66YjCyRZTLnAbIPGhIK7jrEtPOgsY1pjsTUmCRhPAcoeG3BR9klkpYDZEt8NIPLzXEbqsBk/AT2KqRHR1kxv8fnZXd8Nsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZfOHR7US1MYqX2eRxJKighP2vcp8ylRtwWVSfJQZTDE=;
 b=tm5/yurslpfxdD6lOxGqVGOMcRktAWhZG2yi5F3kheUHtg2FXNk+Utzr7wfxl6yZd7FAs7NXPR+e72s0LGmrsABYpgFBprxVplgD2o8yd5EyN4mnqHIn3nH8jBPHWUq2gOytFL7einIdsaSJObb6qPrLlb3BG6AjYqSziStjd70=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by DM6PR12MB4282.namprd12.prod.outlook.com (2603:10b6:5:223::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Thu, 9 Nov
 2023 20:47:41 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::1549:8c93:8585:ca1b]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::1549:8c93:8585:ca1b%4]) with mapi id 15.20.6977.019; Thu, 9 Nov 2023
 20:47:41 +0000
Message-ID: <876af164-c326-4b26-ab56-790f9a36902e@amd.com>
Date:   Thu, 9 Nov 2023 14:47:37 -0600
User-Agent: Mozilla Thunderbird
From:   "Moger, Babu" <babu.moger@amd.com>
Subject: Re: [PATCH v7 15/24] x86/resctrl: Allow arch to allocate memory
 needed in resctrl_arch_rmid_read()
Reply-To: babu.moger@amd.com
To:     James Morse <james.morse@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        shameerali.kolothum.thodi@huawei.com,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        carl@os.amperecomputing.com, lcherian@marvell.com,
        bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
        baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
        dfustini@baylibre.com, amitsinght@marvell.com
References: <20231025180345.28061-1-james.morse@arm.com>
 <20231025180345.28061-16-james.morse@arm.com>
Content-Language: en-US
In-Reply-To: <20231025180345.28061-16-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0018.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:22c::18) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|DM6PR12MB4282:EE_
X-MS-Office365-Filtering-Correlation-Id: 34ac8a06-b6df-4227-7269-08dbe1651db3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MywC+1mgOUCuL8PqhHDjNQpI+5KpjbQe0Xw9S+r8jR3+ezr6JKmopJHnqOc+9XiYkNE0lzIJQ3CTqQCqy3jLXWziRbRcZEITiWsnbe5xtvOW5QcjwqU363JQTUhOBoUlImiAjKTi5oU0TXgzpm4jRQU0e3+T5VMnR8h6GtQoxgKYfRHzKIMG7fNQaw6Zxgm52L/JNutnqR61K4Bxelo1GHssZoFhnYp/X45Iqy9IGuxHTJHnnxEn5pV5RVsYMzukS7ZFDZu8vP6tZ2ui9z/6cqNowDDj9ZHiIP7jPvw46Vc4Y2keQTdt02+VQmMRz4jRuiLOKAW5xz9uyXsiRqKtfM0k8GZpPkFXzehjlK0+4ZWzbXdxnOL0BVkb+4aV1llnPcNro8AhoktDtdbWyMT2pay893itZgqmu/upOJ20wQKw5/abNCjpY0ud9ffM3yB5jEz6YxQAUgWB1Mq1mUys3k8PqtXWUbz/UwhcTgZUoNDfsZrU21kcpC2eCGldAVYo8KrvCYwngCfRHwwYEXygSqNl6LXnIih2Ostl7251qeyeDeQcwW7cR+d8vp/0iZPggGG1yH9q4ivY1FCFhLeyVj4EQTDNGdGWnABLo2kuJZJK8MWbu6hURrWHLUFRcrQJGQkfggpeLdRkQnydYXDdydOE35SF5l6cdzOl9kGAfdPP0IvG+CDHP9Wftqmj1/av
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(136003)(376002)(346002)(396003)(230922051799003)(230173577357003)(230273577357003)(186009)(451199024)(64100799003)(1800799009)(5660300002)(6486002)(31686004)(26005)(6666004)(41300700001)(53546011)(6512007)(6506007)(36756003)(2616005)(31696002)(3450700001)(38100700002)(86362001)(7416002)(2906002)(316002)(8676002)(83380400001)(8936002)(4326008)(54906003)(478600001)(66556008)(66946007)(66476007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZUlVQnl1R3ZjMGNSNUZtZUlrRXVXMlkyYmhOZmlMNGtab1pETWNZVnpjMWND?=
 =?utf-8?B?Mmt3eFljT0NDOE1wV293cFR0QmluTzI2VXJDZENkSjFGazBxWHBiUVNqbFM5?=
 =?utf-8?B?WFoxY3l2QmNjZWtyWXRpbC9RUGJhUTVJVk1rTHVQZHV6TERDNjVWenZESmY3?=
 =?utf-8?B?dDF1MmFkT1pBeStwUFNaMTRJTk5LbHFVYlhiRUhpdFFhc0VWbGMyODFzV0lm?=
 =?utf-8?B?dFpndGZ2SWsrVStVMDlITVRaMlRkVmNTbko1dmd2eUpqY0RpZis2by9FV1VZ?=
 =?utf-8?B?b095Ky8zcTNXRzY1SUxueTZYTzFaeUU1ei9LZ2FMbVN6eXlQZ0VNbEVYN3hK?=
 =?utf-8?B?dStaRDByMTJZLzlsZWhxR1dOQkxldEtaeld4b0JDMU40dVFCa3V3S3I1bkxp?=
 =?utf-8?B?TURLK21DdmVhNDluVHRBb28yeXAxSzN5alhTaUpQN00zeVpqVjZBemNVK2tY?=
 =?utf-8?B?QTRqQnEzRHF1ME81UWNJQnR4TU1mV1Zub1Y2amhrQnlBSDQ2elB4S0FZdUlw?=
 =?utf-8?B?QWE1ZzVyUnFkVFpXUEU1OXYzaEZJWVRrVVZMcjY1L1F0Z1RMU1JDTVdoMVhj?=
 =?utf-8?B?blNCclVyL2JVTzBCRUlURDNqZVVLWXVHRmpSMUNibEczTjlvTDFPRmkxWTZq?=
 =?utf-8?B?VlovV2lmNDBzc3liQjY5WS9BdkxZblcxanJ1NHVwbnFEM3AzeFhiL0hubmVn?=
 =?utf-8?B?NjhmMmFXVkhsbm5UeTFQZ0FDbU45SUNSbFJzN2RBaTVZaWhidkNvQWFZN1pY?=
 =?utf-8?B?anB6b1RqbVBXRWRJMzJ3VkxSM05DOC9zOFF2M3M2SWY0Vy9jblpubysyU0xK?=
 =?utf-8?B?akNaN0xESjRTTC9qd0FHamo2cDJYRG5QeFNOZDFJWW51Tm5uQ2JMamtZZ3FU?=
 =?utf-8?B?NUdubE1YY1hST2VaREpjalFIQXFZdGxWRGZxbmx6K1ZSQnRIa3MvSW83N1lv?=
 =?utf-8?B?MG41UkcxVTVLWWxCODY0YVJhZTcrWmxJVC9zYXBpeG1GaG9WL2dnYzQ3MUxM?=
 =?utf-8?B?dmdOVzI0YkJNbE0xVTlQY3RYM25acXhuTW5CQmFVRjFrR0dDSmZwejhwNXRi?=
 =?utf-8?B?VFlnYXM1aGJMdE1FTnpPWktXME5kRk1HQWcxcWdHZmhsZzRHUkR3dmV2L0Nx?=
 =?utf-8?B?N29BMFJISE9POHBOdnpxWm53SU16OFlwaVNRb3lUUUc2SGhvZkgxV0RrM3ZE?=
 =?utf-8?B?VXJ0NWFiQVF4bFJQVWgrbS9sSTY4b0RmZGZnN1g1VVJPY29BZnBIdVdSZCtU?=
 =?utf-8?B?Sk02VDBzek5qaHhVVHNCZjFPVDJnUHVPYkdsMHgzTzBPQUpIaThtV2NEeDlq?=
 =?utf-8?B?ZDFaRVBYdnBKcWlpbURWcEtRcWR2dGpUeFRXZm04UW8wVTRja21ORHVqaWV2?=
 =?utf-8?B?WllPNkZrN2U3TGxSWU13UjRKZVFGUEprc29WS1c5RW1ucStsVlVsZUI5bWQv?=
 =?utf-8?B?dnArN05WY2NjUW5WN2R5N3NJaEwyb1pKeis1bU5KZVh6U2dBWXpjaTBOeXYr?=
 =?utf-8?B?VTYyRUtTYVloWUJpbTdsOEFiMG5QeHpnTUR2eVNsWVRvRVViUFA5OFl5cGtL?=
 =?utf-8?B?V255T1V3SnFXc2pXM2NiK0ZVRi95SEgvUlRTOGdsUStvUUpBVXIyTmFzZ1dl?=
 =?utf-8?B?bkVsbzBZWCtnaU9ZZldWZ2R6TG1yWXd2UW1IYUtsaVFPbmpYdjdLMFgxV0tn?=
 =?utf-8?B?L2N6R3pQZDlvUURhRUFhN2FTU2Rla25wZm5pbUk5aGRmYnlCS3kybXo1clph?=
 =?utf-8?B?aDFBWnRvdDdBTUd2YUdkZkhFa2djOUtYZGFiZUxPTEovSUFRUWEwbXF2VDRu?=
 =?utf-8?B?c3o4c001ckg4TUFIcXMyc0RWWTRObGNYQmJZWEdXRC8vUVhCWm9LdXN2bGtT?=
 =?utf-8?B?endXZ1RSVE0vcnVoMEFtdHk1QU85L1k4NXlseTVjdE9BNWFoa2tuakM2L0Uy?=
 =?utf-8?B?UWoxOVY5cENvYmhMR3BTS1NmdUJuSDl5N2RKTi94dHI2SXdYdnp1R21qeXAv?=
 =?utf-8?B?dCtCK1lSeWRjWmhPUStJSHN5NE8wNE0rQzNLa1VFTlc1L0ZWalZLMWVTWjgy?=
 =?utf-8?B?cFlGQlZKdmRTQ3FkSnoydVA2eVpMTCsyWk5DUTVCMnRicVgwWDVnVmdCWWpL?=
 =?utf-8?Q?j+UY=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34ac8a06-b6df-4227-7269-08dbe1651db3
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 20:47:41.0319
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k5igKRa+qa+N5Gh0Gb5fZiLiv3YpjfsaC/WOdnU5VaNhxItA6dBqw0vdWLmVxgIj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4282
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 10/25/23 13:03, James Morse wrote:
> Depending on the number of monitors available, Arm's MPAM may need to
> allocate a monitor prior to reading the counter value. Allocating a
> contended resource may involve sleeping.
> 
> add_rmid_to_limbo() calls resctrl_arch_rmid_read() for multiple domains,
> the allocation should be valid for all domains.

This above sentence does not look correct after your previous patch [patch
14].  You removed  resctrl_arch_rmid_read() from add_rmid_to_limbo().

Otherwise looks good.

> 
> __check_limbo() and mon_event_count() each make multiple calls to
> resctrl_arch_rmid_read(), to avoid extra work on contended systems,
> the allocation should be valid for multiple invocations of
> resctrl_arch_rmid_read().
> 
> Add arch hooks for this allocation, which need calling before
> resctrl_arch_rmid_read(). The allocated monitor is passed to
> resctrl_arch_rmid_read(), then freed again afterwards. The helper
> can be called on any CPU, and can sleep.
> 
> Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
> Tested-by: Peter Newman <peternewman@google.com>
> Reviewed-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
> Signed-off-by: James Morse <james.morse@arm.com>

Reviewed-by: Babu Moger <babu.moger@amd.com>

> ---
> Changes since v3:
>  * Expanded comment.
>  * Removed stray header include.
>  * Reworded commit message.
>  * Made ctx a void * instead of an int.
> 
> Changes since v4:
>  * Used IS_ERR() in more places.
> 
> Changes since v5:
>  * Pass the error back from mon_event_read() as -EINVAL/Unavailable.
>  * Add some ratelimited warnings when failing to allocate a mon context
> 
> Changes since v6:
>  * Added a newline.
> ---
>  arch/x86/include/asm/resctrl.h            | 11 +++++++
>  arch/x86/kernel/cpu/resctrl/ctrlmondata.c |  7 +++++
>  arch/x86/kernel/cpu/resctrl/internal.h    |  1 +
>  arch/x86/kernel/cpu/resctrl/monitor.c     | 35 +++++++++++++++++++++--
>  include/linux/resctrl.h                   |  5 +++-
>  5 files changed, 55 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/include/asm/resctrl.h b/arch/x86/include/asm/resctrl.h
> index 1d274dbabc44..29c4cc343787 100644
> --- a/arch/x86/include/asm/resctrl.h
> +++ b/arch/x86/include/asm/resctrl.h
> @@ -136,6 +136,17 @@ static inline u32 resctrl_arch_rmid_idx_encode(u32 ignored, u32 rmid)
>  	return rmid;
>  }
>  
> +/* x86 can always read an rmid, nothing needs allocating */
> +struct rdt_resource;
> +static inline void *resctrl_arch_mon_ctx_alloc(struct rdt_resource *r, int evtid)
> +{
> +	might_sleep();
> +	return NULL;
> +};
> +
> +static inline void resctrl_arch_mon_ctx_free(struct rdt_resource *r, int evtid,
> +					     void *ctx) { };
> +
>  void resctrl_cpu_detect(struct cpuinfo_x86 *c);
>  
>  #else
> diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> index d07f99245851..a033e8e32108 100644
> --- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> +++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> @@ -546,6 +546,11 @@ void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
>  	rr->d = d;
>  	rr->val = 0;
>  	rr->first = first;
> +	rr->arch_mon_ctx = resctrl_arch_mon_ctx_alloc(r, evtid);
> +	if (IS_ERR(rr->arch_mon_ctx)) {
> +		rr->err = -EINVAL;
> +		return;
> +	}
>  
>  	cpu = cpumask_any_housekeeping(&d->cpu_mask);
>  
> @@ -559,6 +564,8 @@ void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
>  		smp_call_function_any(&d->cpu_mask, mon_event_count, rr, 1);
>  	else
>  		smp_call_on_cpu(cpu, smp_mon_event_count, rr, false);
> +
> +	resctrl_arch_mon_ctx_free(r, evtid, rr->arch_mon_ctx);
>  }
>  
>  int rdtgroup_mondata_show(struct seq_file *m, void *arg)
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index 33e24fcc8dd0..bb07b9b01e36 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -138,6 +138,7 @@ struct rmid_read {
>  	bool			first;
>  	int			err;
>  	u64			val;
> +	void			*arch_mon_ctx;
>  };
>  
>  extern bool rdt_alloc_capable;
> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
> index 409817b0ae2c..1ca8db8c82cc 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -269,7 +269,7 @@ static u64 mbm_overflow_count(u64 prev_msr, u64 cur_msr, unsigned int width)
>  
>  int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_domain *d,
>  			   u32 unused, u32 rmid, enum resctrl_event_id eventid,
> -			   u64 *val)
> +			   u64 *val, void *ignored)
>  {
>  	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
>  	struct rdt_hw_domain *hw_dom = resctrl_to_arch_dom(d);
> @@ -324,9 +324,17 @@ void __check_limbo(struct rdt_domain *d, bool force_free)
>  	u32 idx_limit = resctrl_arch_system_num_rmid_idx();
>  	struct rmid_entry *entry;
>  	u32 idx, cur_idx = 1;
> +	void *arch_mon_ctx;
>  	bool rmid_dirty;
>  	u64 val = 0;
>  
> +	arch_mon_ctx = resctrl_arch_mon_ctx_alloc(r, QOS_L3_OCCUP_EVENT_ID);
> +	if (IS_ERR(arch_mon_ctx)) {
> +		pr_warn_ratelimited("Failed to allocate monitor context: %ld",
> +				    PTR_ERR(arch_mon_ctx));
> +		return;
> +	}
> +
>  	/*
>  	 * Skip RMID 0 and start from RMID 1 and check all the RMIDs that
>  	 * are marked as busy for occupancy < threshold. If the occupancy
> @@ -340,7 +348,8 @@ void __check_limbo(struct rdt_domain *d, bool force_free)
>  
>  		entry = __rmid_entry(idx);
>  		if (resctrl_arch_rmid_read(r, d, entry->closid, entry->rmid,
> -					   QOS_L3_OCCUP_EVENT_ID, &val)) {
> +					   QOS_L3_OCCUP_EVENT_ID, &val,
> +					   arch_mon_ctx)) {
>  			rmid_dirty = true;
>  		} else {
>  			rmid_dirty = (val >= resctrl_rmid_realloc_threshold);
> @@ -353,6 +362,8 @@ void __check_limbo(struct rdt_domain *d, bool force_free)
>  		}
>  		cur_idx = idx + 1;
>  	}
> +
> +	resctrl_arch_mon_ctx_free(r, QOS_L3_OCCUP_EVENT_ID, arch_mon_ctx);
>  }
>  
>  bool has_busy_rmid(struct rdt_domain *d)
> @@ -533,7 +544,7 @@ static int __mon_event_count(u32 closid, u32 rmid, struct rmid_read *rr)
>  	}
>  
>  	rr->err = resctrl_arch_rmid_read(rr->r, rr->d, closid, rmid, rr->evtid,
> -					 &tval);
> +					 &tval, rr->arch_mon_ctx);
>  	if (rr->err)
>  		return rr->err;
>  
> @@ -744,11 +755,27 @@ static void mbm_update(struct rdt_resource *r, struct rdt_domain *d,
>  	if (is_mbm_total_enabled()) {
>  		rr.evtid = QOS_L3_MBM_TOTAL_EVENT_ID;
>  		rr.val = 0;
> +		rr.arch_mon_ctx = resctrl_arch_mon_ctx_alloc(rr.r, rr.evtid);
> +		if (IS_ERR(rr.arch_mon_ctx)) {
> +			pr_warn_ratelimited("Failed to allocate monitor context: %ld",
> +					    PTR_ERR(rr.arch_mon_ctx));
> +			return;
> +		}
> +
>  		__mon_event_count(closid, rmid, &rr);
> +
> +		resctrl_arch_mon_ctx_free(rr.r, rr.evtid, rr.arch_mon_ctx);
>  	}
>  	if (is_mbm_local_enabled()) {
>  		rr.evtid = QOS_L3_MBM_LOCAL_EVENT_ID;
>  		rr.val = 0;
> +		rr.arch_mon_ctx = resctrl_arch_mon_ctx_alloc(rr.r, rr.evtid);
> +		if (IS_ERR(rr.arch_mon_ctx)) {
> +			pr_warn_ratelimited("Failed to allocate monitor context: %ld",
> +					    PTR_ERR(rr.arch_mon_ctx));
> +			return;
> +		}
> +
>  		__mon_event_count(closid, rmid, &rr);
>  
>  		/*
> @@ -758,6 +785,8 @@ static void mbm_update(struct rdt_resource *r, struct rdt_domain *d,
>  		 */
>  		if (is_mba_sc(NULL))
>  			mbm_bw_count(closid, rmid, &rr);
> +
> +		resctrl_arch_mon_ctx_free(rr.r, rr.evtid, rr.arch_mon_ctx);
>  	}
>  }
>  
> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
> index 8649fc84aac2..bf460c912bf5 100644
> --- a/include/linux/resctrl.h
> +++ b/include/linux/resctrl.h
> @@ -235,6 +235,9 @@ void resctrl_offline_domain(struct rdt_resource *r, struct rdt_domain *d);
>   * @rmid:		rmid of the counter to read.
>   * @eventid:		eventid to read, e.g. L3 occupancy.
>   * @val:		result of the counter read in bytes.
> + * @arch_mon_ctx:	An architecture specific value from
> + *			resctrl_arch_mon_ctx_alloc(), for MPAM this identifies
> + *			the hardware monitor allocated for this read request.
>   *
>   * Some architectures need to sleep when first programming some of the counters.
>   * (specifically: arm64's MPAM cache occupancy counters can return 'not ready'
> @@ -248,7 +251,7 @@ void resctrl_offline_domain(struct rdt_resource *r, struct rdt_domain *d);
>   */
>  int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_domain *d,
>  			   u32 closid, u32 rmid, enum resctrl_event_id eventid,
> -			   u64 *val);
> +			   u64 *val, void *arch_mon_ctx);
>  
>  /**
>   * resctrl_arch_rmid_read_context_check()  - warn about invalid contexts

-- 
Thanks
Babu Moger
