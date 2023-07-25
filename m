Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CEF47619E4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 15:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbjGYN0c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 09:26:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230310AbjGYN0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 09:26:31 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8847C1FEB
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 06:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=k3oAO5/lSXvef5qwdiBo4tcyHvCrV2VuBVST9ldPc/g=; b=epnf2dS4tENxjP84BeYNBhJM1D
        wAKxf6t2IzRjlgstBxjqmEQnyiLWMjnSFmFr32o0MFan6q3QeSwyr/ah2Xvi+Frs6d0/tjTKVTbKL
        jHK5/EXORACQQXSz0oMGQiqn3Fda1m47DLmArZVuJkUrjPmctXBBQs89V2dX8iAXf4LZDfz2whcBG
        fVPnuEIeYgjG+nThO4Ejya2Iv/zD8Vomzo+CeCzyx7lVJXSYSghm3/H/byNziiVxxJsjRXLAk6m6K
        DZnEQhJLxZfqwcjJxOPU8mouctQ4aIEfiD4YVr6l6Men+OBSYbJ32Bdw3/bt/TgKx2imbSLUIs1zo
        DLKIcUfw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qOI37-0049rV-2U;
        Tue, 25 Jul 2023 13:26:03 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id EFEDC300155;
        Tue, 25 Jul 2023 15:25:59 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id AD5DE2B20499C; Tue, 25 Jul 2023 15:25:59 +0200 (CEST)
Date:   Tue, 25 Jul 2023 15:25:59 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ruan Jinjie <ruanjinjie@huawei.com>
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] sched/fair: Use struct_size()
Message-ID: <20230725132559.GK3765278@hirez.programming.kicks-ass.net>
References: <20230725195020.3469132-1-ruanjinjie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230725195020.3469132-1-ruanjinjie@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2023 at 07:50:20PM +0000, Ruan Jinjie wrote:
> Use struct_size() instead of hand-writing it, when allocating a structure
> with a flex array.
> 
> This is less verbose.

As per all the other times, no. It is also less clear. I never can
remember what that thing does and the code it replaces is utterly
trivial.

> Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
> ---
>  kernel/sched/fair.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index f8b71ea5948b..cc041a48100f 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -2889,9 +2889,8 @@ static void task_numa_group(struct task_struct *p, int cpupid, int flags,
>  	int i;
>  
>  	if (unlikely(!deref_curr_numa_group(p))) {
> -		unsigned int size = sizeof(struct numa_group) +
> -				    NR_NUMA_HINT_FAULT_STATS *
> -				    nr_node_ids * sizeof(unsigned long);
> +		unsigned int size = struct_size(grp, faults,
> +		                                NR_NUMA_HINT_FAULT_STATS * nr_node_ids);
>  
>  		grp = kzalloc(size, GFP_KERNEL | __GFP_NOWARN);
>  		if (!grp)
> -- 
> 2.34.1
> 
