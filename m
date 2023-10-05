Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9CC57BA183
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:53:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236809AbjJEOpr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 10:45:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238722AbjJEOk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:40:58 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE9CC30DB
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 07:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=UFAdeHE0CWru26KYlbN8q9h2Z7DqAa9DFuRNzqF5s/w=; b=LUSkjQRpwyx+HBSCBOgGN3FIAf
        3xUAGOTJ3xuak04Th9q9g8+PPh88f0tSVltzT7adiZtI/tMqBjGWvvNSXyJ9VYsM4YF4QrR1Yku+i
        hATZb4LpFTTv2PXIIinbLc1hFo9bSSxLBMGazWTGSv3azfKQAjuLdVJKKk2QXplev+0gJRjyWKzsk
        IxFsTa65IECVBbcuSCIpdZAZLKRLq6hznaguShC5m7q7MwY+UfHXCRFQtQluOl9nyOY/7TVgSNMeu
        MyHJ8/MRmKLjw8D8pYbKt3ICokrzUHAjhAwrRFnxAHQLSCQgVpr6bu+JkIIJVrnMzLN2iGMYDQv1s
        R789qNtQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qoP79-00Bkcp-1E;
        Thu, 05 Oct 2023 14:14:09 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7C88D300451; Thu,  5 Oct 2023 16:14:08 +0200 (CEST)
Date:   Thu, 5 Oct 2023 16:14:08 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Youssef Esmat <youssefesmat@chromium.org>
Cc:     Daniel Jordan <daniel.m.jordan@oracle.com>, mingo@kernel.org,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org,
        juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, corbet@lwn.net, qyousef@layalina.io,
        chris.hyser@oracle.com, patrick.bellasi@matbug.net, pjt@google.com,
        pavel@ucw.cz, qperret@google.com, tim.c.chen@linux.intel.com,
        joshdon@google.com, timj@gnu.org, kprateek.nayak@amd.com,
        yu.c.chen@intel.com, joel@joelfernandes.org, efault@gmx.de,
        tglx@linutronix.de
Subject: Re: [PATCH 00/15] sched: EEVDF and latency-nice and/or slice-attr
Message-ID: <20231005141408.GB743@noisy.programming.kicks-ass.net>
References: <20230531115839.089944915@infradead.org>
 <dlbtvvm5cewqzh5bcpl4cqhcwxmnnjb6pdle5jzywiiznlactd@cmhnpim42m3p>
 <20230906131356.GG38741@noisy.programming.kicks-ass.net>
 <CA+q576MS0-MV1Oy-eecvmYpvNT3tqxD8syzrpxQ-Zk310hvRbw@mail.gmail.com>
 <20231002184136.GA1539@noisy.programming.kicks-ass.net>
 <20231005120557.GA743@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231005120557.GA743@noisy.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 05, 2023 at 02:05:57PM +0200, Peter Zijlstra wrote:

> Using the attached program (I got *REALLY* fed up trying to draw these
> diagrams by hand), let us illustrate the difference between Earliest
> *Eligible* Virtual Deadline First and the one with the Eligible test
> taken out: EVDF.
> 
> Specifically, the program was used with the following argument for
> EEVDF:
> 
>   ./eevdf -e "0,1024,6" -e "1,1024,2" -e "2,1024,18" -v 19 
> 
> and with an additional '-n' for the EVDF column.
> 

<snip a metric ton of diagrams>

> 
> As I wrote before; EVDF has worse lag bounds, but this is not
> insurmountable. The biggest problem that I can see is that of wakeup
> preemption. Currently we allow to preempt when 'current' has reached V
> (RUN_TO_PARITY in pick_eevdf()).
> 
> With these rules, when EEVDF schedules C (our large slice task) at t=10
> above, it is only a little behind C and can be reaily preempted after
> about 2 time units.
> 
> However, EVDF will delay scheduling C until much later, see how A and B
> walk far ahead of V until t=36. Only when will we pick C. But this means
> that we're firmly stuck with C for at least 11 time units. A newly
> placed task will be around V and will have no chance to preempt.
> 
> That said, I do have me a patch to cure some of that:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?h=sched/eevdf&id=d7edbe431f31762e516f2730196f41322edcc621
> 
> That would allow a task with a shorter request time to preempt in spite
> of RUN_TO_PARITY.
> 

So, doing all that gave me an idea, see queue/sched/eevdf BIAS_ELIGIBLE.

It pushes the eligibility threshold (V) right by one average request.
The below patch is against eevdf.c.

I've not yet ran it through the normal set of hackbench,netperf etc.. so
it might eat your pet and set your granny on fire.


--- eevdf.c.orig	2023-10-05 16:11:35.821114320 +0200
+++ eevdf.c	2023-10-05 16:08:38.387080327 +0200
@@ -7,6 +7,7 @@
 #include <sys/param.h>
 
 bool eligible = true;
+bool bias = false;
 unsigned long V_lim = 20;
 
 struct entity {
@@ -79,16 +80,17 @@
 
 struct entity *pick_entity(int nr, struct entity *es)
 {
-	unsigned long W = 0, V = 0;
+	unsigned long W = 0, V = 0, R = 0;
 	struct entity *e = NULL;
 
 	for (int i = 0; i < nr; i++) {
 		V += es[i].weight * es[i].vruntime;
+		R += es[i].request;
 		W += es[i].weight;
 	}
 
 	for (int i = 0; i < nr; i++) {
-		if (eligible && W*es[i].vruntime > V)
+		if (eligible && W*es[i].vruntime > V + (bias * R))
 			continue;
 
 		if (!e || es[i].vdeadline < e->vdeadline)
@@ -169,10 +171,14 @@
 
 	const int N = sizeof(es) / sizeof(es[0]);
 
-	while ((opt = getopt(argc, argv, "nv:e:")) != -1) {
+	while ((opt = getopt(argc, argv, "bnv:e:")) != -1) {
 		unsigned int v,w,r;
 
 		switch (opt) {
+		case 'b':
+			bias = true;
+			break;
+
 		case 'n':
 			eligible = false;
 			break;
