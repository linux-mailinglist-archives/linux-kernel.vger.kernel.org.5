Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0ED9776A75
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 22:43:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234439AbjHIUnr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 16:43:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjHIUnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 16:43:46 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD5381AA
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 13:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Subject:Cc:To:From:Date:Message-ID:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=8yhl2TzINEewJjlbzCt9UIZdnhMWIy8NLdXZ4wj9FEE=; b=ge16/NIKyg7FR4Zt8Mgqg88LeK
        ChgDBNr+B1rcXD57RuVHybp2g10gFSkN/vnoAHodoHog0hhjCy59NOeha9F8FT5wprMD779HjSxyh
        1saawXfGKPGnVRnfyQATF8GGso3rZ05nGwn9f593dyxtUjpG1+gmGtqzFWhWXB+8yLFO7Wcdwm8r9
        gcm6mMUkhriI8vvFScENMnDNcCsDvxi+ew7GqWUBVByjsgjsQhkrLHnfnd8iARAiRDxYU4MHNusvi
        fUhpuGz3YmGeshn115w0dreG0zKVMf51fiRQjNq3JhVyomIyPmbh22no8Cut178cvzk9Xmwc1MSVW
        qocJqE6w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qTq1m-005twL-2l;
        Wed, 09 Aug 2023 20:43:35 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 69F05300346;
        Wed,  9 Aug 2023 22:43:33 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 4A243201D9959; Wed,  9 Aug 2023 22:43:33 +0200 (CEST)
Message-ID: <20230809202440.012625269@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 09 Aug 2023 22:24:40 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@redhat.com
Cc:     peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/8] sched: Use lock guards, wave 2
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, as promised, here is the second part of the SBRM patches.

Now that we're a little used to them, these are a little more involved.

New in this series, over the guard()() and scoped_guard () usage, is CLASS().

CLASS() is very like guard() except it also takes a name argument. So where
guard() instantiates an 'anonymous' variable, CLASS() instantiates an
explicitly named one.

  CLASS(task_rq_lock, rq_guard)(p);

which can be read like:

  class_task_rq_lock_t rq_guard __cleanup(class_task_rq_lock_destructor) =
	class_task_rq_lock_constructor(p);

[[ Notable: guard(name) := CLASS(name, __UNIQUE_ID(guard)) ]]

The advantage in this specific case is that the guard object of task_rq_lock
will contain the 'struct rq *' which we'll need.

Another use of CLASS() is:

  CLASS(find_get_task, p)(pid);

Where 'p' is of 'struct task_struct *' type and the constructor does the
pid->task_struct lookup and the destructor does put_task_struct.

Again, mostly aimed at getting rid of error gotos. The final patch is a bunch
of random conversions that happened while I was poking around and playing with
things.

Also available at:

  git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git sched/guards2


Next in line is kernel/events/core.c, but I might not bore all of you with those
patches :-)

