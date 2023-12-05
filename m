Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF584805BF7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 18:49:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231916AbjLEQ0X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 11:26:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231799AbjLEQ0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 11:26:21 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B6B4C3
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 08:26:26 -0800 (PST)
Received: from kwepemm000007.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Sl5Vf6nl8zWjDC;
        Wed,  6 Dec 2023 00:25:30 +0800 (CST)
Received: from [10.174.185.179] (10.174.185.179) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 6 Dec 2023 00:26:23 +0800
Subject: Re: [PATCH] cpu/hotplug: Remove the obsolete CPU hotplug states
To:     <linux-kernel@vger.kernel.org>
CC:     <tglx@linutronix.de>, <peterz@infradead.org>,
        <wanghaibin.wang@huawei.com>, <andriy.shevchenko@linux.intel.com>,
        <osalvador@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <fw@strlen.de>, <apatel@ventanamicro.com>,
        <vikas.shivappa@linux.intel.com>, <viresh.kumar@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, <tom.zanussi@linux.intel.com>
References: <20231124121615.1604-1-yuzenghui@huawei.com>
From:   Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <cbb8ce86-5de8-23e0-b97e-9a25e5e9242e@huawei.com>
Date:   Wed, 6 Dec 2023 00:26:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20231124121615.1604-1-yuzenghui@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.185.179]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm000007.china.huawei.com (7.193.23.189)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75 autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Cc more folks (authors of those "removal" commits) to get review
comments.

On 2023/11/24 20:16, Zenghui Yu wrote:
> There is a bunch of obsolete constants in the cpuhp_state enum that are no
> longer used anywhere in the kernel. The oldest one has been unused for over
> six years.
> 
> Drop all of them to reduce the size of the cpuhp_hp_states array.
> 
>   obsolete hotpulg states		introduced in	unused since
>   ===================================	=============	============
>   CPUHP_X86_APB_DEAD			148b9e2abea6	1b79fc4f2bfd
>   CPUHP_MM_DEMOTION_DEAD		a6a0251c6fce	734c15700cdf
>   CPUHP_LUSTRE_CFS_DEAD			7b737965b331	be65f9ed267f
>   CPUHP_NET_FLOW_PREPARE		a4fc1bfc4206	09c7570480f7
>   CPUHP_AP_IRQ_RISCV_STARTING		6b7ce8927b5a	832f15f42646
>   CPUHP_AP_MICROCODE_LOADER		78f4e932f776	5af05b8d51a8
>   CPUHP_AP_PERF_X86_CQM_STARTING	f07048270423	c39a0e2c8850
>   CPUHP_AP_MIPS_OP_LOONGSON3_STARTING	65264e3bc3d4	e258958945c6
>   CPUHP_AP_MARCO_TIMER_STARTING		eb0a9d8c672d	446262b27285
>   CPUHP_AP_PERF_X86_CQM_ONLINE		f07048270423	c39a0e2c8850
>   CPUHP_AP_PERF_X86_IDXD_ONLINE		81dd4d4d6178	never used
>   CPUHP_AP_MM_DEMOTION_ONLINE		a6a0251c6fce	734c15700cdf
> 
> Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
> ---
>  include/linux/cpuhotplug.h | 14 --------------
>  1 file changed, 14 deletions(-)
> 
> diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
> index efc0c0b07efb..af6c21aab985 100644
> --- a/include/linux/cpuhotplug.h
> +++ b/include/linux/cpuhotplug.h
> @@ -66,15 +66,12 @@ enum cpuhp_state {
>  	CPUHP_PERF_POWER,
>  	CPUHP_PERF_SUPERH,
>  	CPUHP_X86_HPET_DEAD,
> -	CPUHP_X86_APB_DEAD,
>  	CPUHP_X86_MCE_DEAD,
>  	CPUHP_VIRT_NET_DEAD,
>  	CPUHP_IBMVNIC_DEAD,
>  	CPUHP_SLUB_DEAD,
>  	CPUHP_DEBUG_OBJ_DEAD,
>  	CPUHP_MM_WRITEBACK_DEAD,
> -	/* Must be after CPUHP_MM_VMSTAT_DEAD */
> -	CPUHP_MM_DEMOTION_DEAD,
>  	CPUHP_MM_VMSTAT_DEAD,
>  	CPUHP_SOFTIRQ_DEAD,
>  	CPUHP_NET_MVNETA_DEAD,
> @@ -96,7 +93,6 @@ enum cpuhp_state {
>  	CPUHP_NET_DEV_DEAD,
>  	CPUHP_PCI_XGENE_DEAD,
>  	CPUHP_IOMMU_IOVA_DEAD,
> -	CPUHP_LUSTRE_CFS_DEAD,
>  	CPUHP_AP_ARM_CACHE_B15_RAC_DEAD,
>  	CPUHP_PADATA_DEAD,
>  	CPUHP_AP_DTPM_CPU_DEAD,
> @@ -118,7 +114,6 @@ enum cpuhp_state {
>  	CPUHP_XEN_EVTCHN_PREPARE,
>  	CPUHP_ARM_SHMOBILE_SCU_PREPARE,
>  	CPUHP_SH_SH3X_PREPARE,
> -	CPUHP_NET_FLOW_PREPARE,
>  	CPUHP_TOPOLOGY_PREPARE,
>  	CPUHP_NET_IUCV_PREPARE,
>  	CPUHP_ARM_BL_PREPARE,
> @@ -151,18 +146,14 @@ enum cpuhp_state {
>  	CPUHP_AP_IRQ_ARMADA_XP_STARTING,
>  	CPUHP_AP_IRQ_BCM2836_STARTING,
>  	CPUHP_AP_IRQ_MIPS_GIC_STARTING,
> -	CPUHP_AP_IRQ_RISCV_STARTING,
>  	CPUHP_AP_IRQ_LOONGARCH_STARTING,
>  	CPUHP_AP_IRQ_SIFIVE_PLIC_STARTING,
>  	CPUHP_AP_ARM_MVEBU_COHERENCY,
> -	CPUHP_AP_MICROCODE_LOADER,
>  	CPUHP_AP_PERF_X86_AMD_UNCORE_STARTING,
>  	CPUHP_AP_PERF_X86_STARTING,
>  	CPUHP_AP_PERF_X86_AMD_IBS_STARTING,
> -	CPUHP_AP_PERF_X86_CQM_STARTING,
>  	CPUHP_AP_PERF_X86_CSTATE_STARTING,
>  	CPUHP_AP_PERF_XTENSA_STARTING,
> -	CPUHP_AP_MIPS_OP_LOONGSON3_STARTING,
>  	CPUHP_AP_ARM_VFP_STARTING,
>  	CPUHP_AP_ARM64_DEBUG_MONITORS_STARTING,
>  	CPUHP_AP_PERF_ARM_HW_BREAKPOINT_STARTING,
> @@ -179,7 +170,6 @@ enum cpuhp_state {
>  	CPUHP_AP_QCOM_TIMER_STARTING,
>  	CPUHP_AP_TEGRA_TIMER_STARTING,
>  	CPUHP_AP_ARMADA_TIMER_STARTING,
> -	CPUHP_AP_MARCO_TIMER_STARTING,
>  	CPUHP_AP_MIPS_GIC_TIMER_STARTING,
>  	CPUHP_AP_ARC_TIMER_STARTING,
>  	CPUHP_AP_RISCV_TIMER_STARTING,
> @@ -217,9 +207,7 @@ enum cpuhp_state {
>  	CPUHP_AP_PERF_X86_AMD_UNCORE_ONLINE,
>  	CPUHP_AP_PERF_X86_AMD_POWER_ONLINE,
>  	CPUHP_AP_PERF_X86_RAPL_ONLINE,
> -	CPUHP_AP_PERF_X86_CQM_ONLINE,
>  	CPUHP_AP_PERF_X86_CSTATE_ONLINE,
> -	CPUHP_AP_PERF_X86_IDXD_ONLINE,
>  	CPUHP_AP_PERF_S390_CF_ONLINE,
>  	CPUHP_AP_PERF_S390_SF_ONLINE,
>  	CPUHP_AP_PERF_ARM_CCI_ONLINE,
> @@ -252,8 +240,6 @@ enum cpuhp_state {
>  	CPUHP_AP_BASE_CACHEINFO_ONLINE,
>  	CPUHP_AP_ONLINE_DYN,
>  	CPUHP_AP_ONLINE_DYN_END		= CPUHP_AP_ONLINE_DYN + 30,
> -	/* Must be after CPUHP_AP_ONLINE_DYN for node_states[N_CPU] update */
> -	CPUHP_AP_MM_DEMOTION_ONLINE,
>  	CPUHP_AP_X86_HPET_ONLINE,
>  	CPUHP_AP_X86_KVM_CLK_ONLINE,
>  	CPUHP_AP_ACTIVE,
> 
