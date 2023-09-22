Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 484827AB989
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 20:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233750AbjIVSqC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 14:46:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233688AbjIVSp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 14:45:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCD8FAC
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 11:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695408309;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pOyL9qGAxLXAfZ6fB6hqFdfh4A/FpNmiLcufaLJtTM0=;
        b=JFAePYkfgbCx2PkBrHc7z5l3wJs02k3HIQJMawUmLJrLL81g6lcGsOGQUFghevJN9cWuXj
        +QVxbbb2tZBDyOz1eHfd5/LzeigpdtwX3duvtmIYG1UVnpeTNKDmnCJWdpjlXvZIh7FlnG
        a4h0WdeKDPHsZyXV203yDzVkrP63qvQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-171-Fo50w4WeP6arinN7VN5pBQ-1; Fri, 22 Sep 2023 14:45:05 -0400
X-MC-Unique: Fo50w4WeP6arinN7VN5pBQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 73E2C801779;
        Fri, 22 Sep 2023 18:45:05 +0000 (UTC)
Received: from [10.22.18.172] (unknown [10.22.18.172])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1B87C140E950;
        Fri, 22 Sep 2023 18:45:05 +0000 (UTC)
Message-ID: <06163c13-03b2-bfe0-90b4-5267a039a02c@redhat.com>
Date:   Fri, 22 Sep 2023 14:45:04 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2] locking/semaphore: Use wake_q to wake up processes
 outside lock critical section
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
        Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org
References: <20220909192848.963982-1-longman@redhat.com>
 <20230921074247.GC14803@noisy.programming.kicks-ass.net>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20230921074247.GC14803@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/21/23 03:42, Peter Zijlstra wrote:
> On Fri, Sep 09, 2022 at 03:28:48PM -0400, Waiman Long wrote:
>> It was found that a circular lock dependency can happen with the
>> following locking sequence:
>>
>>     +--> (console_sem).lock --> &p->pi_lock --> &rq->__lock --+
>>     |                                                         |
>>     +---------------------------------------------------------+
>>
>> The &p->pi_lock --> &rq->__lock sequence is very common in all the
>> task_rq_lock() calls.
>>
>> The &rq->__lock --> (console_sem).lock sequence happens when the
>> scheduler code calling printk() or more likely the various WARN*()
>> macros while holding the rq lock. The (console_sem).lock is actually
>> a raw spinlock guarding the semaphore. In the particular lockdep splat
>> that I saw, it was caused by SCHED_WARN_ON() call in update_rq_clock().
>> To work around this locking sequence, we may have to ban all WARN*()
>> calls when the rq lock is held, which may be too restrictive, or we
>> may have to add a WARN_DEFERRED() call and modify all the call sites
>> to use it.
> No, this is all because printk() is pure garbage -- but I believe it's
> being worked on.
>
> And I despise that whole deferred thing -- that's just worse garbage.
>
> If you map printk to early_printk none of this is a problem (and this is
> what i've been doing for something close to a decade).
>
> Printk should not do synchronous, or in-context, printing to non-atomic
> consoles. Doubly so when atomic console are actually available.
>
> As long as it does this printk is fundamentally unreliable and any of
> these hacks are just that.

Thanks for the explanation.

I believe early_printk should only be used in the non-SMP boot process. 
The use of printk() is frequently used for debugging purpose and the 
insertion of printk at some lock critical section can cause the lockdep 
splat to come out obscuring the debugging process.

>
>> Even then, a deferred printk or WARN function may still call
>> console_trylock() which may, in turn, calls up_console_sem() leading
>> to this locking sequence.
>>
>> The other ((console_sem).lock --> &p->pi_lock) locking sequence
>> was caused by the fact that the semaphore up() function is calling
>> wake_up_process() while holding the semaphore raw spinlock. This lockiing
>> sequence can be easily eliminated by moving the wake_up_processs()
>> call out of the raw spinlock critical section using wake_q which is
>> what this patch implements. That is the easiest and the most certain
>> way to break this circular locking sequence.
> So I don't mind the patch, but I hate everything about your
> justification for it.
>
OK, I can reword the commit log and see you are OK with that.

Cheers,
Longman

