Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCCB27F646B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 17:55:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345048AbjKWQzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 11:55:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjKWQz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 11:55:29 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 821DD1A8
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 08:55:36 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C38D2C433CB;
        Thu, 23 Nov 2023 16:55:33 +0000 (UTC)
Date:   Thu, 23 Nov 2023 16:55:31 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Huang Shijie <shijie@os.amperecomputing.com>
Cc:     will@kernel.org, gregkh@linuxfoundation.org, rafael@kernel.org,
        arnd@arndb.de, mark.rutland@arm.com, broonie@kernel.org,
        keescook@chromium.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        patches@amperecomputing.com
Subject: Re: [PATCH v3] arm64: irq: set the correct node for VMAP stack
Message-ID: <ZV-EA46rBJ9WK4UH@arm.com>
References: <ZVZO55IjQSbzWnfG@arm.com>
 <20231118160205.3923-1-shijie@os.amperecomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231118160205.3923-1-shijie@os.amperecomputing.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 19, 2023 at 12:02:05AM +0800, Huang Shijie wrote:
> diff --git a/drivers/base/arch_numa.c b/drivers/base/arch_numa.c
> index eaa31e567d1e..90519d981471 100644
> --- a/drivers/base/arch_numa.c
> +++ b/drivers/base/arch_numa.c
> @@ -144,7 +144,7 @@ void __init early_map_cpu_to_node(unsigned int cpu, int nid)
>  unsigned long __per_cpu_offset[NR_CPUS] __read_mostly;
>  EXPORT_SYMBOL(__per_cpu_offset);
>  
> -static int __init early_cpu_to_node(int cpu)
> +int early_cpu_to_node(int cpu)
>  {
>  	return cpu_to_node_map[cpu];
>  }

I don't think we need this change, let's make the arm64
init_irq_stacks() an __init function instead.

> diff --git a/include/asm-generic/numa.h b/include/asm-generic/numa.h
> index 1a3ad6d29833..16073111bffc 100644
> --- a/include/asm-generic/numa.h
> +++ b/include/asm-generic/numa.h
> @@ -35,6 +35,7 @@ int __init numa_add_memblk(int nodeid, u64 start, u64 end);
>  void __init numa_set_distance(int from, int to, int distance);
>  void __init numa_free_distance(void);
>  void __init early_map_cpu_to_node(unsigned int cpu, int nid);
> +int early_cpu_to_node(int cpu);

And add __init here.

With these changes:

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

Happy to take this patch through the arm64 tree if I get an ack from
Greg or Rafael on the drivers/* change.
