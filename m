Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E16657A1F2C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 14:50:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235120AbjIOMty (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 08:49:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235079AbjIOMtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 08:49:49 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEB5D19A5
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 05:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Subject:Cc:To:From:Date:Message-Id:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=/E4r8T3JsenmCTsTNOexUcOfXwOLHQ3RlyhZFtZ7FpE=; b=UYOIfWrkOxNwWpwL/vdvTFMGIf
        dQ7cukpeY7k8WdH2tus5OjCT2DzqMU+Fv8SLSmLk42TCFbERGQ3yxygtvIn0n631FpCwTX0407k0K
        uEkxBG7rHYfYWslB87yMqgr0FBcfszZa57oJoCJK5Tn2bT+FgDJhQSVcQOCpirrNpZi+2zGp87jF6
        eAvs2VBo2j5tSALmTnumo20ovw3O2rkhkJrgIyfI/1kniWBp9r5tNYPGnF+MdQcV0nqeSn948/AOl
        oR5E9eDIIyGJEo1+9jlp7Gt4tQfgcDya1+mvYLcocDzWYTYoCogjA+f8tssKmk1Z8ra3DFJl5dDBS
        p0foiB0w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qh8Fs-0097rz-0t;
        Fri, 15 Sep 2023 12:49:05 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
        id 60E863005B2; Fri, 15 Sep 2023 14:49:05 +0200 (CEST)
Message-Id: <20230915124354.416936110@noisy.programming.kicks-ass.net>
User-Agent: quilt/0.65
Date:   Fri, 15 Sep 2023 14:43:54 +0200
From:   peterz@infradead.org
To:     mingo@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        vincent.guittot@linaro.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, corbet@lwn.net,
        qyousef@layalina.io, chris.hyser@oracle.com,
        patrick.bellasi@matbug.net, pjt@google.com, pavel@ucw.cz,
        qperret@google.com, tim.c.chen@linux.intel.com, joshdon@google.com,
        timj@gnu.org, kprateek.nayak@amd.com, yu.c.chen@intel.com,
        youssefesmat@chromium.org, joel@joelfernandes.org, efault@gmx.de,
        tglx@linutronix.de, daniel.m.jordan@oracle.com
Subject: [PATCH 0/2] sched/eevdf: sched_attr::sched_runtime slice hint
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

As promised a while ago, here is a new version of the variable slice length
hint stuff.  Back when I asked for comments on the latency-nice vs slice length
thing, there was very limited feedback on-list, a number of people have
expressed interrest in the slice length hint.


I'm still working on improving the wakeup latency -- but esp. after commit:

  63304558ba5d ("sched/eevdf: Curb wakeup-preemption")

it needs a little more work. Everything I tried so far made it worse.

As is it behaves ok-ish:

  root@ivb-ep:~/bench# cat doit-latency-slice.sh
  #!/bin/bash

  perf bench sched messaging -g 40 -l 12000 &

  sleep 1
  chrt3 -o --sched-runtime $((`cat /debug/sched/base_slice_ns`*10)) 0 cyclictest --policy other -D 5 -q   -H 20000 --histfile data.txt ; grep Latencies data.txt
  chrt3 -o --sched-runtime 0 0 cyclictest --policy other -D 5 -q   -H 20000 --histfile data.txt ; grep Latencies data.txt
  chrt3 -o --sched-runtime $((`cat /debug/sched/base_slice_ns`/10)) 0 cyclictest --policy other -D 5 -q   -H 20000 --histfile data.txt ; grep Latencies data.txt

  wait $!
  root@ivb-ep:~/bench# ./doit-latency-slice.sh
  # Running 'sched/messaging' benchmark:
  # /dev/cpu_dma_latency set to 0us
  # Min Latencies: 00060
  # Avg Latencies: 00990
  # Max Latencies: 224925
  # /dev/cpu_dma_latency set to 0us
  # Min Latencies: 00020
  # Avg Latencies: 00656
  # Max Latencies: 37595
  # /dev/cpu_dma_latency set to 0us
  # Min Latencies: 00016
  # Avg Latencies: 00354
  # Max Latencies: 16687
  # 20 sender and receiver processes per group
  # 40 groups == 1600 processes run

       Total time: 38.246 [sec]


(chrt3 is a hacked up version of util-linux/chrt that allows --sched-runtime unconditionally)

