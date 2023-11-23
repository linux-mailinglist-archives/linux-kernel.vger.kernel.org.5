Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A030B7F6722
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 20:33:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbjKWTdI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 14:33:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjKWTdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 14:33:06 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A473D59
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 11:33:13 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E872EC433CA;
        Thu, 23 Nov 2023 19:33:10 +0000 (UTC)
Date:   Thu, 23 Nov 2023 19:33:08 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     "Christoph Lameter (Ampere)" <cl@gentwo.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anshuman.Khandual@arm.com, Valentin.Schneider@arm.com,
        Vanshidhar Konda <vanshikonda@os.amperecomputing.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Dave Kleikamp <dave.kleikamp@oracle.com>,
        Matteo Carlini <Matteo.Carlini@arm.com>
Subject: Re: [PATCH ARM64]: Introduce CONFIG_MAXSMP to allow up to 512 cpus
Message-ID: <ZV-o9ORrq7OKWOry@arm.com>
References: <6a854175-5f89-c754-17b8-deda18447f1f@gentwo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a854175-5f89-c754-17b8-deda18447f1f@gentwo.org>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2023 at 05:04:35PM -0800, Christoph Lameter (Ampere) wrote:
> Index: linux/arch/arm64/Kconfig
> ===================================================================
> --- linux.orig/arch/arm64/Kconfig
> +++ linux/arch/arm64/Kconfig
> @@ -1402,10 +1402,56 @@ config SCHED_SMT
>   	  MultiThreading at a cost of slightly increased overhead in some
>   	  places. If unsure say N here.
> 
> +
> +config MAXSMP
> +	bool "Compile kernel with support for the maximum number of SMP Processors"
> +	depends on SMP && DEBUG_KERNEL
> +	select CPUMASK_OFFSTACK
> +	help
> +	  Enable maximum number of CPUS and NUMA Nodes for this architecture.
> +	  If unsure, say N.
> +
> +#
> +# The maximum number of CPUs supported:
> +#
> +# The main config value is NR_CPUS, which defaults to NR_CPUS_DEFAULT,
> +# and which can be configured interactively in the
> +# [NR_CPUS_RANGE_BEGIN ... NR_CPUS_RANGE_END] range.
> +#
> +# ( If MAXSMP is enabled we just use the highest possible value and disable
> +#   interactive configuration. )
> +#
> +
> +config NR_CPUS_RANGE_BEGIN
> +	int
> +	default NR_CPUS_RANGE_END if MAXSMP
> +	default    1 if !SMP
> +	default    2

We don't support !SMP on arm64.

> +
> +config NR_CPUS_RANGE_END
> +	int
> +	default 8192 if  SMP && CPUMASK_OFFSTACK
> +	default  512 if  SMP && !CPUMASK_OFFSTACK
> +	default    1 if !SMP
> +
> +config NR_CPUS_DEFAULT
> +	int
> +	default  512 if  MAXSMP
> +	default   64 if  SMP
> +	default    1 if !SMP
> +
>   config NR_CPUS
> -	int "Maximum number of CPUs (2-4096)"
> -	range 2 4096
> -	default "256"
> +	int "Set maximum number of CPUs" if SMP && !MAXSMP
> +	range NR_CPUS_RANGE_BEGIN NR_CPUS_RANGE_END
> +	default NR_CPUS_DEFAULT
> +	help
> +	  This allows you to specify the maximum number of CPUs which this
> +	  kernel will support.  If CPUMASK_OFFSTACK is enabled, the maximum
> +	  supported value is 8192, otherwise the maximum value is 512.  The
> +	  minimum value which makes sense is 2.
> +
> +	  This is purely to save memory: each supported CPU adds about 8KB
> +	  to the kernel image.

Is this all needed just to select CPUMASK_OFFSTACK if larger NR_CPUS?
Would something like this do:

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 7b071a00425d..697d5700bad1 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -119,6 +119,7 @@ config ARM64
 	select CLONE_BACKWARDS
 	select COMMON_CLK
 	select CPU_PM if (SUSPEND || CPU_IDLE)
+	select CPUMASK_OFFSTACK if NR_CPUS > 512
 	select CRC32
 	select DCACHE_WORD_ACCESS
 	select DYNAMIC_FTRACE if FUNCTION_TRACER

togehther with a larger NR_CPUS in defconfig?

-- 
Catalin
