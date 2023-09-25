Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E197E7AD47A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 11:26:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233178AbjIYJ0I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 05:26:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233202AbjIYJ0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 05:26:05 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B4A3AB
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 02:25:56 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695633954;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KeiJaR4eV+6b3ML+MxpCvtISIuheT6OifK4x46p6gbM=;
        b=MOsn10GUw9NZ+HzcXU1f0XlDrg9QOwh9bxe94rYb6gn0cPFbNRwvXz8/eGhgf7B6EWlJ0d
        5eVWio1dQKFzSm9Ye+yC0IlFoxZFvZMlS3LOe4QtB/5I5rTuFhuj2Cb5qZODumCmpOmFuG
        PL1D1aGw6IbR65EBnVXwKAGPTuCMqjZ+AqUGyKkvENQXRl9gFzCyFqAEWWj447vJKenrVd
        HQ96mbDtXFzb64mbi0+5nhHWjEG37Ai8xCAwNSzvNaOfwzaJAK6eNn9NGpUuNSmp/I1Bxl
        ppmeAGqHWW4y9bOMBzxgG14SQ+aVUjF8Y1s/j/mw9UTbs2+KeSEvNJdXclYWGA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695633954;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KeiJaR4eV+6b3ML+MxpCvtISIuheT6OifK4x46p6gbM=;
        b=zRs/CIrwsjh8IpXgiAmEszCdlUMUM70fbi8t+COJQQs71q+QvCX+K+0l1nPRQMMhSDVBDJ
        qw94gzWdo9gqOiAw==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v2 04/11] printk: nbcon: Provide functions to
 mark atomic write sections
In-Reply-To: <ZQ1ff96wS03ctA-v@alley>
References: <20230919230856.661435-1-john.ogness@linutronix.de>
 <20230919230856.661435-5-john.ogness@linutronix.de>
 <ZQ1ff96wS03ctA-v@alley>
Date:   Mon, 25 Sep 2023 11:31:54 +0206
Message-ID: <87il7ybo4d.fsf@jogness.linutronix.de>
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

On 2023-09-22, Petr Mladek <pmladek@suse.com> wrote:
>> Note that when a CPU is in a priority elevated state, flushing
>> only occurs when dropping back to a lower priority. This allows
>> the full set of printk records (WARN/OOPS/PANIC output) to be
>> stored in the ringbuffer before beginning to flush the backlog.
>
> The above paragraph is a bit confusing. The code added by this patch
> does not do any flushing.

You are right. I should put this patch after patch 5 "printk: nbcon:
Provide function for atomic flushing" to simplify the introduction.

> I guess that this last paragraph is supposed to explain why the
> "nesting" array is needed.

No, it is explaining how this feature works in general. The term
"priority elevated state" means the CPU is in an atomic write section.

The "nesting" array is needed in order to support a feature that is not
explained in the commit message: If nested OOPS/WARN/PANIC occur, only
the outermost OOPS/WARN/PANIC will do the flushing. I will add this
information to the commit message.

>> +static __ref struct nbcon_cpu_state *nbcon_get_cpu_state(void)
>> +{
>> +	if (!printk_percpu_data_ready())
>> +		return &early_nbcon_pcpu_state;
>
> it might worth a comment. Something like:
>
> 	/*
> 	 * The value of __printk_percpu_data_ready is modified in normal
> 	 * context. As a result it could never change inside a nbcon
> 	 * atomic context.
> 	 */
> 	if (!printk_percpu_data_ready())
> 		return &early_nbcon_pcpu_state;

OK.

>> +void nbcon_atomic_exit(enum nbcon_prio prio, enum nbcon_prio prev_prio)
>> +{
>> +	struct nbcon_cpu_state *cpu_state;
>> +
>> +	cpu_state = nbcon_get_cpu_state();
>
> I would add a consistency check:
>
> 	WARN_ON_ONCE(cpu_state->nesting[cpu_state->prio] <= 0)

OK.

John
