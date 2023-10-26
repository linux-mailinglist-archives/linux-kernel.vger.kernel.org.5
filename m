Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F5197D862F
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 17:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345482AbjJZPtg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 11:49:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345476AbjJZPte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 11:49:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C3F1196
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 08:49:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E632CC433C8;
        Thu, 26 Oct 2023 15:49:28 +0000 (UTC)
Date:   Thu, 26 Oct 2023 11:49:27 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Mateusz Guzik <mjguzik@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ankur Arora <ankur.a.arora@oracle.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, x86@kernel.org, akpm@linux-foundation.org,
        luto@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, mingo@redhat.com, juri.lelli@redhat.com,
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
Subject: Re: [POC][RFC][PATCH] sched: Extended Scheduler Time Slice
Message-ID: <20231026114927.46145fe6@gandalf.local.home>
In-Reply-To: <20231026094035.213e3744@gandalf.local.home>
References: <20231025054219.1acaa3dd@gandalf.local.home>
        <20231025102952.GG37471@noisy.programming.kicks-ass.net>
        <20231025085434.35d5f9e0@gandalf.local.home>
        <20231025135545.GG31201@noisy.programming.kicks-ass.net>
        <20231025103105.5ec64b89@gandalf.local.home>
        <884e4603-4d29-41ae-8715-a070c43482c4@efficios.com>
        <20231025162435.ibhdktcshhzltr3r@f>
        <20231025131731.48461873@gandalf.local.home>
        <20231026085414.GL31411@noisy.programming.kicks-ass.net>
        <20231026094035.213e3744@gandalf.local.home>
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

On Thu, 26 Oct 2023 09:40:35 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> Hence, why I don't want to associate this with priority inheritance. The
> time constraint is a fundamental difference.

Let me add one more fundamental difference here that makes this solution
different than priority inheritance and ceiling.

PI and ceiling define the correctness of the system. If you get it wrong or
remove it, the system can be incorrect and lock up, fail deadlines, etc.
There's hundreds, if not thousands of papers mathematically defining the
correctness of PI, ceiling and proxy execution, as they are complex and
critical for the system to behave properly.

This feature is a performance boost only, and has nothing to do with
"correctness". That's because it has that arbitrary time where it can run a
little more. It's more like the difference between having something in
cache and a cache miss. This would cause many academics to quit and find a
job in sales if they had to prove the correctness of an algorithm that gave
you a boost for some random amount of time. The idea here is to help with
performance. If it exists, great, your application will likely perform
better. If it doesn't, no big deal, you may just have to deal with longer
wait times on critical sections.

This is why I do not want to associate this as another form of PI or
ceiling.

-- Steve
