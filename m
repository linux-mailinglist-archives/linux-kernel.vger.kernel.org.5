Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB42580CE73
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 15:33:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343763AbjLKOdJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 09:33:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343710AbjLKOdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 09:33:08 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 14992C3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 06:33:15 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 49D43FEC;
        Mon, 11 Dec 2023 06:34:01 -0800 (PST)
Received: from [10.1.197.60] (eglon.cambridge.arm.com [10.1.197.60])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3E6943F738;
        Mon, 11 Dec 2023 06:33:12 -0800 (PST)
Message-ID: <27ddb859-a67e-9a9d-7135-c4829c5b27db@arm.com>
Date:   Mon, 11 Dec 2023 14:33:06 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [EXT] [PATCH v7 06/24] x86/resctrl: Access per-rmid structures by
 index
Content-Language: en-GB
To:     Amit Singh Tomar <amitsinght@marvell.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        "shameerali.kolothum.thodi@huawei.com" 
        <shameerali.kolothum.thodi@huawei.com>,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        "carl@os.amperecomputing.com" <carl@os.amperecomputing.com>,
        Linu Cherian <lcherian@marvell.com>,
        "bobo.shaobowang@huawei.com" <bobo.shaobowang@huawei.com>,
        "tan.shaopeng@fujitsu.com" <tan.shaopeng@fujitsu.com>,
        "baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>,
        "peternewman@google.com" <peternewman@google.com>,
        "dfustini@baylibre.com" <dfustini@baylibre.com>,
        "muhammad.zahid@nokia.com" <muhammad.zahid@nokia.com>
References: <20231025180345.28061-1-james.morse@arm.com>
 <20231025180345.28061-7-james.morse@arm.com>
 <MW4PR18MB5084AC18E19386E5B83C0F0EC6A0A@MW4PR18MB5084.namprd18.prod.outlook.com>
From:   James Morse <james.morse@arm.com>
In-Reply-To: <MW4PR18MB5084AC18E19386E5B83C0F0EC6A0A@MW4PR18MB5084.namprd18.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Amit,

On 31/10/2023 07:43, Amit Singh Tomar wrote:
> -----Original Message-----
> From: James Morse <james.morse@arm.com> 
> Sent: Wednesday, October 25, 2023 11:33 PM
> Subject: [EXT] [PATCH v7 06/24] x86/resctrl: Access per-rmid structures by index

Looks like you are afflicted with outlook - let me know if I didn't find all the changes
you made to the original message ...

[..]

> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
> index 2a0233cd0bc9..c02cf32cd17c 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -735,19 +768,20 @@ void mbm_setup_overflow_handler(struct rdt_domain *dom, unsigned long delay_ms)
>  
>  static int dom_data_init(struct rdt_resource *r)  {
> +	u32 idx_limit = resctrl_arch_system_num_rmid_idx();
>  	struct rmid_entry *entry = NULL;
> -	int i, nr_rmids;
> +	u32 idx;
> +	int i;
>  
> -	nr_rmids = r->num_rmid;
> -	rmid_ptrs = kcalloc(nr_rmids, sizeof(struct rmid_entry), GFP_KERNEL);
> +	rmid_ptrs = kcalloc(idx_limit, sizeof(struct rmid_entry), GFP_KERNEL);
> 
> [>>] Is there a chance, it could result in "ZERO_SIZE_PTR", and we should guard it against ZERO_OR_NULL_PTR in the following if condition?
>         It might be related, while testing the snapshot[1] (and subsequent snapshots has similar change) on x86 platform, Zahid is seeing Kernel panic:
>         https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git/tree/fs/resctrl/monitor.c?h=mpam/snapshot/v6.2#n695

Interesting - I didn't think this could happen. Could you share the full splat?

This would imply idx_limit was zero, so boot_cpu_data.x86_cache_max_rmid would be -1.
But wouldn't this happen before this patch? idx_limit has the same value as nr_rmids on
x86, its only MPAM that needs a different value.


Thanks,

James
