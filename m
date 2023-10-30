Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BB2A7DBFA3
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 19:20:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231438AbjJ3SUF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 14:20:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230422AbjJ3SUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 14:20:03 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03BA598
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 11:20:01 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3E65C433C8;
        Mon, 30 Oct 2023 18:19:57 +0000 (UTC)
Date:   Mon, 30 Oct 2023 14:19:56 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ankur Arora <ankur.a.arora@oracle.com>, linux-mm@kvack.org,
        x86@kernel.org, akpm@linux-foundation.org, luto@kernel.org,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, willy@infradead.org, mgorman@suse.de,
        jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        jgross@suse.com, andrew.cooper3@citrix.com,
        Joel Fernandes <joel@joelfernandes.org>,
        Youssef Esmat <youssefesmat@chromium.org>,
        Vineeth Pillai <vineethrp@google.com>,
        Suleiman Souhlal <suleiman@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Daniel Bristot de Oliveira <bristot@kernel.org>
Subject: Re: [POC][RFC][PATCH v2] sched: Extended Scheduler Time Slice
Message-ID: <20231030141956.05661b90@gandalf.local.home>
In-Reply-To: <bb628206-28eb-470e-aaea-0f18ce94e983@efficios.com>
References: <20231025235413.597287e1@gandalf.local.home>
        <20231026105944.GJ33965@noisy.programming.kicks-ass.net>
        <20231026071413.4ed47b0e@gandalf.local.home>
        <f5b0fffa-423a-4571-be6c-383399274328@efficios.com>
        <CAHk-=whnyt2TccpDaWGTbDsVkKApL3c2FtDPMEwuTmeu_cEL8Q@mail.gmail.com>
        <7871472b-a0c4-4475-9671-69a3244f956d@efficios.com>
        <20231026164549.14d45c60@gandalf.local.home>
        <644da047-2f7a-4d55-a339-f2dc28d2c852@efficios.com>
        <20231027122442.5c76dd62@gandalf.local.home>
        <f0741a5b-229a-429a-8451-8af17261be9e@efficios.com>
        <20231027124930.3753cdd4@gandalf.local.home>
        <ce0dbdaf-6be4-4f3b-9b5a-aedeac00ddf6@efficios.com>
        <20231030094508.031357b4@gandalf.local.home>
        <bb628206-28eb-470e-aaea-0f18ce94e983@efficios.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Oct 2023 14:05:05 -0400
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> If you have the nesting counter, why do you need the explicit on/off 
> switch ?

Because I gave up when I found that one of the lwlocks seemed to take a long
time (pretty much the entire test) or I couldn't find how it was unlocked
(the code isn't trivial).

So I just made every unlock disable the extended time slot. I need to go
back and enable both a counter and an on/off as I now realize that the spin
locks (called within the lwlock) will disable the extend time before the
lwlock is released. This should work if I have the spinlocks inc and dec
(they are straight forward and all locks are associated with an easily
found unlock), and have the lwlock use bit 31 as an on/off switch.

Anyway, I would let user space decide what it wants to do, and giving it 31
bits to say "I'm extended" and let user space come up with how it handles
those 31 bits.

-- Steve
