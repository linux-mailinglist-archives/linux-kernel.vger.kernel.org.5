Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33F677E3F48
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 13:53:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234189AbjKGMxV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 07:53:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234576AbjKGMw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 07:52:56 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 958C246AE6
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 04:38:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Fsxh3r4+3aEM5exqQO8HWOVmjypvuoVo8U9n02LeJZk=; b=eRcyzvy3wJneZN4S8WC1Mn69UJ
        8r6Wbq4/ZxWl8TOEgUkidjneWHGacbXT87CNrVRUGGCs5kyfez5kUQJpUvpI0c2qptU7OXJNYASWC
        kUV/A9JZ0YI4Km8wzrBNi9HZwSKgttP4OQnXk4IvgI0YYkg9hk5f3t5JmjE/Z4wnbxSfGupv1oJp0
        4LrkppaNMl9ip+wSnT5i+jiJO/ElaM9FA+WqsH8kYPHe5U+WLsy4nBfceV/8wm3Cg8vOHOWnLtcMP
        sC69d75nV6h2Aja7PDkSrskoXsrwsn2tGI6JBaCSIFW7Zwt4ctBv0gG2cdmsrs6DdOqpFDd+fTGqs
        la1vLKng==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1r0LLW-00CIco-5K; Tue, 07 Nov 2023 12:38:18 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 79BE830049D; Tue,  7 Nov 2023 13:38:18 +0100 (CET)
Date:   Tue, 7 Nov 2023 13:38:18 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Daniel Bristot de Oliveira <bristot@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org,
        Luca Abeni <luca.abeni@santannapisa.it>,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
        Thomas Gleixner <tglx@linutronix.de>,
        Joel Fernandes <joel@joelfernandes.org>,
        Vineeth Pillai <vineeth@bitbyteword.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Phil Auld <pauld@redhat.com>
Subject: Re: [PATCH v5 7/7] sched/fair: Fair server interface
Message-ID: <20231107123818.GV8262@noisy.programming.kicks-ass.net>
References: <cover.1699095159.git.bristot@kernel.org>
 <26adad2378c8b15533e4f6216c2863341e587f57.1699095159.git.bristot@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26adad2378c8b15533e4f6216c2863341e587f57.1699095159.git.bristot@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 04, 2023 at 11:59:24AM +0100, Daniel Bristot de Oliveira wrote:
> Add an interface for fair server setup on debugfs.
> 
> Each rq have three files under /sys/kernel/debug/sched/rq/CPU{ID}:
> 
>  - fair_server_runtime: set runtime in ns
>  - fair_server_period: set period in ns
>  - fair_server_defer: on/off for the defer mechanism
> 
> Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
> ---

I did the below, that gives us:

/debug/sched/fair_server/cpuX/{runtime,period,defer}

I wanted to also add:

/debug/sched/fair_server/{runtime,period,defer}

to more easily set all CPUs to the same value, but then figured
userspace will just have to loop.

---

--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -380,10 +380,10 @@ static ssize_t sched_fair_server_write(s
 			break;
 		}
 
-		if (runtime > period
-				|| period > fair_server_period_max
-				|| period < fair_server_period_min
-				|| zerolax > 1) {
+		if (runtime > period ||
+		    period > fair_server_period_max ||
+		    period < fair_server_period_min ||
+		    zerolax > 1) {
 			cnt = -EINVAL;
 			goto out;
 		}
@@ -515,11 +515,11 @@ static struct dentry *debugfs_sched;
 
 static void debugfs_fair_server_init(void)
 {
-	long cpu;
-	struct dentry *rq_dentry;
+	struct dentry *d_fair;
+	unsigned int cpu;
 
-	rq_dentry = debugfs_create_dir("rq", debugfs_sched);
-	if (!rq_dentry)
+	d_fair = debugfs_create_dir("fair_server", debugfs_sched);
+	if (!d_fair)
 		return;
 
 	for_each_possible_cpu(cpu) {
@@ -527,11 +527,11 @@ static void debugfs_fair_server_init(voi
 		char buf[32];
 
 		snprintf(buf, sizeof(buf), "cpu%ld", cpu);
-		d_cpu = debugfs_create_dir(buf, rq_dentry);
+		d_cpu = debugfs_create_dir(buf, d_fair);
 
-		debugfs_create_file("fair_server_runtime", 0644, d_cpu, (void *) cpu, &fair_server_runtime_fops);
-		debugfs_create_file("fair_server_period", 0644, d_cpu, (void *) cpu, &fair_server_period_fops);
-		debugfs_create_file("fair_server_defer", 0644, d_cpu, (void *) cpu, &fair_server_defer_fops);
+		debugfs_create_file("runtime", 0644, d_cpu, (void *) cpu, &fair_server_runtime_fops);
+		debugfs_create_file("period", 0644, d_cpu, (void *) cpu, &fair_server_period_fops);
+		debugfs_create_file("defer", 0644, d_cpu, (void *) cpu, &fair_server_defer_fops);
 	}
 }
 
