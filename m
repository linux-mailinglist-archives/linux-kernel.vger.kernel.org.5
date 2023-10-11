Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E5907C5496
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 14:56:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346965AbjJKM4x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 08:56:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346956AbjJKM40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 08:56:26 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DB1BE5
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 05:56:07 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697028966;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JXrhAjOL2PrGoBmWfh8hD1aX7SEfXXVHiE6pUua3LlY=;
        b=AtY6nrEO4a9gPJ2KPMKvES233AKtlqhmALl25sFZkmdHZYveKqoCaD2J78H+uQl3Bvjw1x
        uq+nQEJUjuE451ZYS/mAiDMNqH8Cq6HLRjmgg6EZBk8EbzhcpMoCU1/iOmfyCVi8xAhrZH
        U+iFF6AFOEgxV/IK2gK34HYPwxBrNf6+cjQT2eie1hdh6u4w/HeLp7GNUebEf9WiW7pAz3
        Gbb427YVMrvKSaQlBhRYDctD8n2xZYPbwf2zaC4FVEddHwCf5Seq1ojI5jCJtdzQXC4K/u
        QsSW0ZvpJeTJQ37u+nNzKGqgs6vm1Ri3xwtrHgK4p6syJVpcATdQy9exdrNoxA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697028966;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JXrhAjOL2PrGoBmWfh8hD1aX7SEfXXVHiE6pUua3LlY=;
        b=6yGTI9ENIkw1+drkm1HnIwUddzLR/p/5MgZSfsQ+439/y4Jkf4AVA+Cd4OXMcPoBT4/0Gk
        UX7IzgkPTNR5Y0CQ==
To:     yang.yang29@zte.com.cn, peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpu/hotplug: dont offline the last non-isolated CPU
In-Reply-To: <202309161037416349176@zte.com.cn>
References: <202309161037416349176@zte.com.cn>
Date:   Wed, 11 Oct 2023 14:56:05 +0200
Message-ID: <87lec9l3mi.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 16 2023 at 10:37, yang wrote:
> @@ -1502,6 +1502,7 @@ static long __cpu_down_maps_locked(void *arg)
>  static int cpu_down_maps_locked(unsigned int cpu, enum cpuhp_state target)
>  {
>  	struct cpu_down_work work = { .cpu = cpu, .target = target, };
> +	struct cpumask tmp_mask;

Allocating a cpumask on stack is not really a good idea as it takes up
to 1K stack space.

>  	/*
>  	 * If the platform does not support hotplug, report it explicitly to
> @@ -1512,11 +1513,16 @@ static int cpu_down_maps_locked(unsigned int cpu, enum cpuhp_state target)
>  	if (cpu_hotplug_disabled)
>  		return -EBUSY;
>
> +	/*
> +	 * Ensure the last non-isolated CPU is not offlined.
> +	 */
> +	cpumask_and(&tmp_mask, cpu_online_mask, housekeeping_cpumask(HK_TYPE_DOMAIN));

You can spare that excercise. See below.

>  	/*
>  	 * Ensure that the control task does not run on the to be offlined
>  	 * CPU to prevent a deadlock against cfs_b->period_timer.
>  	 */
> -	cpu = cpumask_any_but(cpu_online_mask, cpu);
> +	cpu = cpumask_any_but(&tmp_mask, cpu);

Just open code it this way:

        for_each_cpu_and(cpu, cpu_online_mask, housekeeping_cpumask(HK_TYPE_DOMAIN)) {
        	if (cpu != work.cpu)
  			return work_on_cpu(cpu, __cpu_down_maps_locked, &work);
	}
        return -EBUSY;

Hmm?

Thanks,

        tglx
