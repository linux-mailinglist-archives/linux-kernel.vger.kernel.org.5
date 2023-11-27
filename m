Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2785A7FAABA
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 20:58:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232732AbjK0T6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 14:58:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjK0T6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 14:58:17 -0500
Received: from gentwo.org (gentwo.org [62.72.0.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44E0CB8
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 11:58:23 -0800 (PST)
Received: by gentwo.org (Postfix, from userid 1003)
        id AFF3341AEE; Mon, 27 Nov 2023 11:58:22 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.org (Postfix) with ESMTP id AF4FC41AED;
        Mon, 27 Nov 2023 11:58:22 -0800 (PST)
Date:   Mon, 27 Nov 2023 11:58:22 -0800 (PST)
From:   "Christoph Lameter (Ampere)" <cl@linux.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anshuman.Khandual@arm.com, Valentin.Schneider@arm.com,
        Vanshidhar Konda <vanshikonda@os.amperecomputing.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Dave Kleikamp <dave.kleikamp@oracle.com>,
        Matteo Carlini <Matteo.Carlini@arm.com>
Subject: Re: [PATCH ARM64]: Introduce CONFIG_MAXSMP to allow up to 512 cpus
In-Reply-To: <ZV-o9ORrq7OKWOry@arm.com>
Message-ID: <a32a30d9-f352-cecd-c6f9-16b25963fac1@linux.com>
References: <6a854175-5f89-c754-17b8-deda18447f1f@gentwo.org> <ZV-o9ORrq7OKWOry@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Nov 2023, Catalin Marinas wrote:

>> +config NR_CPUS_RANGE_BEGIN
>> +	int
>> +	default NR_CPUS_RANGE_END if MAXSMP
>> +	default    1 if !SMP
>> +	default    2
>
> We don't support !SMP on arm64.

Ok we can drop that.

>> +	  This is purely to save memory: each supported CPU adds about 8KB
>> +	  to the kernel image.
>
> Is this all needed just to select CPUMASK_OFFSTACK if larger NR_CPUS?
> Would something like this do:
>
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 7b071a00425d..697d5700bad1 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -119,6 +119,7 @@ config ARM64
> 	select CLONE_BACKWARDS
> 	select COMMON_CLK
> 	select CPU_PM if (SUSPEND || CPU_IDLE)
> +	select CPUMASK_OFFSTACK if NR_CPUS > 512
> 	select CRC32
> 	select DCACHE_WORD_ACCESS
> 	select DYNAMIC_FTRACE if FUNCTION_TRACER
>
> togehther with a larger NR_CPUS in defconfig?

Well that is certainly better because it does not introduce an additional 
kernel config option.


