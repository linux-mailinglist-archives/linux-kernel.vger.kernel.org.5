Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0942877B3A6
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 10:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233316AbjHNIPc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 04:15:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234463AbjHNIPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 04:15:30 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27FB4DA;
        Mon, 14 Aug 2023 01:15:29 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1692000926;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zJ1ghy/cC3KbZ4m1L04/UEhcm2VHzkV9OS84G/2DbbA=;
        b=XD2ZI5lHlw6mjResxVGaffjC/MhskNPKDHHxl7kErYu4/FVhPjW+7D9Z1ZgQKXas6hOW9F
        wznZGZ+LotiMaHhspkPSGxKg7e8jHgSvkCdFiuLLNKRzWdC0qFzI1BlBZatd7jhQXosyY4
        rZ3YfShpOy8oInsZk5zqo259yx/romBMvVdNE0jLTitommMG8CS1noPPXH9HAasRF2BrAS
        eHpcxGNMNkPBAv1CU/zRjOVNn4DSMi8+pB9WgQz8Y2k6upmSgAeOZsQ/m690txBQonhKPV
        ///RZCBcOKlMES5s82Z2xt91iOUZ75L2csxuQjaFueLPHPZzAzatNeV3531IXw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1692000926;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zJ1ghy/cC3KbZ4m1L04/UEhcm2VHzkV9OS84G/2DbbA=;
        b=5fzRMev22Q84T6aFtbTjNQ1jLYs7//hWK788gjeaQ06Q7orcsGv3zxihFrnKgneBvqOhvY
        dTJmviOdcVUqkmDQ==
To:     Jiri Slaby <jirislaby@kernel.org>, gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vlastimil Babka <vbabka@suse.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH] serial: 8250: drop lockdep annotation from
 serial8250_clear_IER()
In-Reply-To: <7d8ae4f8-8900-5a06-5b7b-d4a3aea0673e@kernel.org>
References: <20230811064340.13400-1-jirislaby@kernel.org>
 <878rae175n.fsf@jogness.linutronix.de>
 <7d8ae4f8-8900-5a06-5b7b-d4a3aea0673e@kernel.org>
Date:   Mon, 14 Aug 2023 10:21:14 +0206
Message-ID: <87bkfa6nvx.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

Thanks for the follow-up. You responded faster than I could correct
myself.

On 2023-08-14, Jiri Slaby <jirislaby@kernel.org> wrote:
>>> The port lock is not always held when calling serial8250_clear_IER().
>>> When an oops is in progress, the lock is tried to be taken and when it
>>> is not, a warning is issued:
>> 
>> Yes, and that is a potential deadlock. The warning is correct.
>
> Could you elaborate on how can not-taking a lock be a potential
> deadlock?

I was wrong to say deadlock. The lockdep annotation is about interrupts
being unintentionally left permanently disabled or being enabled while
another CPU is transmitting.

>>> Therefore, remove the annotation as it doesn't hold for all invocations.
>> 
>> ... because those invocations are broken by design.
>
> Perhaps. But the system is crashing. Better to emit something without 
> the lock rather than nothing (and wait for the lock infinitely).

I am not suggesting to wait infinitely. I am merely pointing out that
the lockdep warning is legitimate.

>>> The other option would be to make the lockdep test conditional on
>>> 'oops_in_progress'

Actually I find this suggestion more appropriate. It makes it clear that
we are willing to take such risks and do not want to see the warnings in
a panic situation. However, I would end up having to revert that change
as well, so it really does not matter to me at this point. Either way I
will be reverting this patch.

>> The proper thing to do is to fix the invocation. The upcoming atomic
>> console implementation for the 8250 does exactly that.
>
> So what does it do?

The upcoming atomic consoles use a new type of synchronization to guard
the IER register (priority-based spinning with timeouts). This allows us
to make intelligent decisions about how and when to flush in a panic,
rather than simply ignorning locks and hoping for the best.

>> If this patch gets accepted (which it appears it will be), I will revert
>> it in my series implementing the 8250 atomic console.
>
> That's fine as soon as the warning is not a problem.

Yes, I am also fine with re-introducing the annotation together with the
8250 series.

John
