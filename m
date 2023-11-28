Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FE9D7FB213
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 07:47:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343632AbjK1Gks (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 01:40:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343633AbjK1Gkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 01:40:40 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9581F194
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 22:40:45 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BEEDBC15;
        Mon, 27 Nov 2023 22:41:32 -0800 (PST)
Received: from [10.163.33.60] (unknown [10.163.33.60])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 12B873F5A1;
        Mon, 27 Nov 2023 22:40:41 -0800 (PST)
Message-ID: <52b8a7d8-aa4c-46db-a7f5-f36c92ad5380@arm.com>
Date:   Tue, 28 Nov 2023 12:10:38 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ARM64]: Introduce CONFIG_MAXSMP to allow up to 512 cpus
To:     "Christoph Lameter (Ampere)" <cl@gentwo.org>,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Valentin.Schneider@arm.com,
        Vanshidhar Konda <vanshikonda@os.amperecomputing.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Dave Kleikamp <dave.kleikamp@oracle.com>,
        Matteo Carlini <Matteo.Carlini@arm.com>
References: <6a854175-5f89-c754-17b8-deda18447f1f@gentwo.org>
Content-Language: en-US
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <6a854175-5f89-c754-17b8-deda18447f1f@gentwo.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/21/23 06:34, Christoph Lameter (Ampere) wrote:
> Ampere Computing develops high end ARM processors that support an ever
> increasing number of processors. The current default of 256 processors is
> not enough for our newer products. The default is used by Linux
> distros and therefore our customers cannot use distro kernels because
> the number of processors is not supported.

In the previous thread mentioned below, Catalin had mentioned that the
distros do tweak the config for their needs. The default is applicable
for an wide range systems, hence just wondering why default NR_CPUS be
changed for all.

Also just curious, what might be the concern for distros to have large
platform specific configs overriding the default.

> 
> The x86 arch has support for a "CONFIG_MAXSMP" configuration option that
> enables support for the largest known configurations. This usually means
> hundreds or thousands of processors. For those sizes it is no longer
> practical to allocate bitmaps of cpus on the kernel stack. There is
> a kernel option CONFIG_CPUMASK_OFFSTACK that makes the kernel allocate
> and free bitmaps for cpu masks from slab memory instead of keeping it
> on the stack etc.
> 
> With that is becomes possible to dynamically size the allocation of
> the bitmap depending on the quantity of processors detected on
> bootup.
> 
> This patch enables that logic if CONFIG_MAXSMP is enabled.
> 
> If CONFIG_MAXSMP is disabled then a default of 64 processors
> is supported. A bitmap for 64 processors fits into one word and
> therefore can be efficiently handled on the stack. Using a pointer
> to a bitmap would be overkill.
> 
> The number of processors can be manually configured if
> CONFIG_MAXSMP is not set.
> 
> Currently the default for CONFIG_MAXSMP is 512 processors.
> This will have to be increased if ARM processor vendors start
> supporting more processors.
> 
> Signed-off-by: Christoph Lameter (Ampere) <cl@linux.com>
> 
> ---
> NR_CPU limits on ARM64 were discussed before at
> https://lore.kernel.org/all/20210110053615.3594358-1-vanshikonda@os.amperecomputing.com/
> 
> 
> Index: linux/arch/arm64/Kconfig
> ===================================================================
> --- linux.orig/arch/arm64/Kconfig
> +++ linux/arch/arm64/Kconfig
> @@ -1402,10 +1402,56 @@ config SCHED_SMT
>         MultiThreading at a cost of slightly increased overhead in some
>         places. If unsure say N here.
> 
> +
> +config MAXSMP
> +    bool "Compile kernel with support for the maximum number of SMP Processors"
> +    depends on SMP && DEBUG_KERNEL
> +    select CPUMASK_OFFSTACK
> +    help
> +      Enable maximum number of CPUS and NUMA Nodes for this architecture.
> +      If unsure, say N.
> +
> +#
> +# The maximum number of CPUs supported:
> +#
> +# The main config value is NR_CPUS, which defaults to NR_CPUS_DEFAULT,
> +# and which can be configured interactively in the
> +# [NR_CPUS_RANGE_BEGIN ... NR_CPUS_RANGE_END] range.
> +#
> +# ( If MAXSMP is enabled we just use the highest possible value and disable
> +#   interactive configuration. )
> +#
> +
> +config NR_CPUS_RANGE_BEGIN
> +    int
> +    default NR_CPUS_RANGE_END if MAXSMP
> +    default    1 if !SMP
> +    default    2
> +
> +config NR_CPUS_RANGE_END
> +    int
> +    default 8192 if  SMP && CPUMASK_OFFSTACK
> +    default  512 if  SMP && !CPUMASK_OFFSTACK
> +    default    1 if !SMP
> +
> +config NR_CPUS_DEFAULT
> +    int
> +    default  512 if  MAXSMP
> +    default   64 if  SMP
> +    default    1 if !SMP
> +
>   config NR_CPUS
> -    int "Maximum number of CPUs (2-4096)"
> -    range 2 4096
> -    default "256"
> +    int "Set maximum number of CPUs" if SMP && !MAXSMP
> +    range NR_CPUS_RANGE_BEGIN NR_CPUS_RANGE_END
> +    default NR_CPUS_DEFAULT
> +    help
> +      This allows you to specify the maximum number of CPUs which this
> +      kernel will support.  If CPUMASK_OFFSTACK is enabled, the maximum
> +      supported value is 8192, otherwise the maximum value is 512.  The
> +      minimum value which makes sense is 2.
> +
> +      This is purely to save memory: each supported CPU adds about 8KB
> +      to the kernel image.
> 
>   config HOTPLUG_CPU
>       bool "Support for hot-pluggable CPUs"
> Index: linux/arch/arm64/configs/defconfig
> ===================================================================
> --- linux.orig/arch/arm64/configs/defconfig
> +++ linux/arch/arm64/configs/defconfig
> @@ -15,6 +15,7 @@ CONFIG_TASK_IO_ACCOUNTING=y
>   CONFIG_IKCONFIG=y
>   CONFIG_IKCONFIG_PROC=y
>   CONFIG_NUMA_BALANCING=y
> +CONFIG_MAXSMP=y
>   CONFIG_MEMCG=y
>   CONFIG_BLK_CGROUP=y
>   CONFIG_CGROUP_PIDS=y

I do agree with Catalin's suggestion - just selecting CPUMASK_OFFSTACK
for larger NR_CPUS.
