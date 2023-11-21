Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78A1B7F2EA4
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 14:44:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234333AbjKUNoD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 08:44:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234304AbjKUNoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 08:44:01 -0500
Received: from smtpout.efficios.com (unknown [IPv6:2607:5300:203:b2ee::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FD48D70
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 05:43:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1700574234;
        bh=LSmoGRdqodB1izPvXCIKKJJH6EPb6KIVUPLO7Or7sag=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=XTN+K79WBMBuoOWzGHExAGR+aTWHQ2Hqlu03dw+eVDWCZ4dFaTaGFtuLdI8QSml/2
         ApE3MlnCOHo4Qcmfl8Z4HRTD30oT/cuNPaEtNm88p6hcOHZ9oVkkwovmi4xcZuJiu3
         HVthUTnb2lkHq7/iDDp0RcRA4NB6LTTR1KX61CI1VVwXOyYWX4Xb0HzqmnxSjNkwdD
         KEg3Km+FX1ysiqrwm56Gtc1ccggRZ8ugocbZCmiRHbcE+6SNb1bbXahuwYwHSqexH0
         Exh5211ur61P/XCnFv61Q1G8I9zt3/PGvrxWcJwZSrVAXEMuBQGPZIyVKdf1vRUGL7
         qQvyOrlYfNNkQ==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4SZQZf4GYxz1cXb;
        Tue, 21 Nov 2023 08:43:54 -0500 (EST)
Message-ID: <985aff40-97cc-4234-98c5-84dd21c324b7@efficios.com>
Date:   Tue, 21 Nov 2023 08:44:17 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/34] sched: add cpumask_find_and_set() and use it in
 __mm_cid_get()
Content-Language: en-US
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Jan Kara <jack@suse.cz>,
        Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Matthew Wilcox <willy@infradead.org>,
        Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>,
        Alexey Klimov <klimov.linux@gmail.com>
References: <20231118155105.25678-1-yury.norov@gmail.com>
 <20231118155105.25678-5-yury.norov@gmail.com>
 <20231120113105.GR8262@noisy.programming.kicks-ass.net>
 <1eb9435a-aa1c-4c30-ab1a-9167b73d1b83@efficios.com>
 <ZVyxMrisyuBtQ+2Y@yury-ThinkPad>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <ZVyxMrisyuBtQ+2Y@yury-ThinkPad>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-11-21 08:31, Yury Norov wrote:
> On Mon, Nov 20, 2023 at 11:17:32AM -0500, Mathieu Desnoyers wrote:
> 
[...]
> 
> Sure, I can. Can you point me to the work you mention here?

It would have to be updated now, but here is the last version that was posted:

https://lore.kernel.org/lkml/20221122203932.231377-1-mathieu.desnoyers@efficios.com/

Especially those patches:

2022-11-22 20:39 ` [PATCH 22/30] lib: Implement find_{first,next,nth}_notandnot_bit, find_first_andnot_bit Mathieu Desnoyers
2022-11-22 20:39 ` [PATCH 23/30] cpumask: Implement cpumask_{first,next}_{not,}andnot Mathieu Desnoyers
2022-11-22 20:39 ` [PATCH 24/30] sched: NUMA-aware per-memory-map concurrency ID Mathieu Desnoyers
2022-11-22 20:39 ` [PATCH 25/30] rseq: Extend struct rseq with per-memory-map NUMA-aware Concurrency ID Mathieu Desnoyers
2022-11-22 20:39 ` [PATCH 26/30] selftests/rseq: x86: Implement rseq_load_u32_u32 Mathieu Desnoyers
2022-11-22 20:39 ` [PATCH 27/30] selftests/rseq: Implement mm_numa_cid accessors in headers Mathieu Desnoyers
2022-11-22 20:39 ` [PATCH 28/30] selftests/rseq: Implement numa node id vs mm_numa_cid invariant test Mathieu Desnoyers
2022-11-22 20:39 ` [PATCH 29/30] selftests/rseq: Implement mm_numa_cid tests Mathieu Desnoyers
2022-11-22 20:39 ` [PATCH 30/30] tracing/rseq: Add mm_numa_cid field to rseq_update Mathieu Desnoyers

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

