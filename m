Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9975E7B0821
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 17:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232320AbjI0PZh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 11:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232425AbjI0PZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 11:25:36 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52BF2136
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 08:25:35 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695828334;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=y+fvbnxtUyztktz5MfYU3ITmngoFIN05Lj7hcWNJGvc=;
        b=wbNssaZcqzwpAoKBeq7miFG6RiZNJsjggSM+a/AEdjBW+v5jbOGEc/AKsWGcbAi9EyTaz2
        LxPbZLdak9NFh+PbeAOJ4pLbb67PZTCICxadDi06Dt+mg8XdMt+WcO7XxodKoat5TYy/Av
        3ZO0Ebd9Mwwyv7UU9kNUrGxpZgys+0nlK3HATLeKnnD6BsHHxPW7k3lqqUEm22TELfoLZ2
        a0PKnlduL7iQcCUZ90MsXxN+Rt7UA7NsMbDCw0nQq6UN7Yqk8rrLsSiLVUW1nJ9ZLJmRzR
        NXcp/KkLdWnJPTvX5VUI7Zp4V0TpkAyA4vjv89iH4cL01G9HQC8HFSl2g1PceQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695828334;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=y+fvbnxtUyztktz5MfYU3ITmngoFIN05Lj7hcWNJGvc=;
        b=5+PFf1I3/iMiGZf+fa9s0idXz1sMzzaxEZPXYjqZjfgZ61VJChvVS5kVl4iwSqjk16cewi
        D0puJ12s/mTUlIBA==
To:     Wei Gong <gongwei833x@gmail.com>
Cc:     linux-kernel@vger.kernel.org, gongwei833x@gmail.com
Subject: Re: [PATCH v2] genirq: avoid long loops in handle_edge_irq
In-Reply-To: <ZRPfjC9JEeUx8zKY@MacBook-Pro-3.local>
References: <20230925025154.37959-1-gongwei833x@gmail.com>
 <87msx9f7a2.ffs@tglx> <ZRPfjC9JEeUx8zKY@MacBook-Pro-3.local>
Date:   Wed, 27 Sep 2023 17:25:24 +0200
Message-ID: <87edijfxjv.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 27 2023 at 15:53, Wei Gong wrote:
> O Tue, Sep 26, 2023 at 02:28:21PM +0200, Thomas Gleixner wrote:
>> On Mon, Sep 25 2023 at 10:51, Wei Gong wrote:
>> > diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
>> > index dc94e0bf2c94..6da455e1a692 100644
>> > --- a/kernel/irq/chip.c
>> > +++ b/kernel/irq/chip.c
>> > @@ -831,7 +831,8 @@ void handle_edge_irq(struct irq_desc *desc)
>> >  		handle_irq_event(desc);
>> >  
>> >  	} while ((desc->istate & IRQS_PENDING) &&
>> > -		 !irqd_irq_disabled(&desc->irq_data));
>> > +		 !irqd_irq_disabled(&desc->irq_data) &&
>> > +		 cpumask_test_cpu(smp_processor_id(), irq_data_get_affinity_mask(&desc->irq_data)));
>> 
>> Assume affinty mask has CPU0 and CPU1 set and the loop is on CPU0, but
>> the effective affinity is on CPU1 then how is this going to move the
>> interrupt?
>
> Loop is on the CPU0 means that the previous effective affinity was on CPU0.
> When the previous effective affinity is a subset of the new affinity mask,
> the effective affinity will not be updated.

That's an implementation detail of a particular interrupt chip driver,
but not a general guaranteed behaviour.

