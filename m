Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E0687E4994
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 21:07:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343582AbjKGUHx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 15:07:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235024AbjKGUHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 15:07:51 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A84EA128
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 12:07:49 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4773EC433C8;
        Tue,  7 Nov 2023 20:07:47 +0000 (UTC)
Date:   Tue, 7 Nov 2023 15:07:50 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org,
        Luca Abeni <luca.abeni@santannapisa.it>,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vineeth Pillai <vineeth@bitbyteword.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Phil Auld <pauld@redhat.com>
Subject: Re: [PATCH v5 6/7] sched/deadline: Deferrable dl server
Message-ID: <20231107150750.5923751b@gandalf.local.home>
In-Reply-To: <20231107143216.170ca582@gandalf.local.home>
References: <cover.1699095159.git.bristot@kernel.org>
        <c7b706d30d6316c52853ca056db5beb82ba72863.1699095159.git.bristot@kernel.org>
        <CAEXW_YS=PrWDx+YGVR7bmq0_SoKNztzGrreApCd9qk1yBLA5bA@mail.gmail.com>
        <CAEXW_YQ8kv3tXQJexLSguPuWi0bXiReKDyYNo9+A-Hgp=Zo1vA@mail.gmail.com>
        <CAEXW_YSjsZSrJK_RbGmbLNy4UrLCgu+7NPZjg-wiLuNbGOGr+w@mail.gmail.com>
        <20231107114732.5dd350ec@gandalf.local.home>
        <20231107123540.69038c6c@gandalf.local.home>
        <20231107125434.284c44da@gandalf.local.home>
        <20231107143216.170ca582@gandalf.local.home>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Nov 2023 14:32:16 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> I'll also test this without any of the patches first.

And it still happens, and I now I know why :-)

Duh! The program is "migrate" which stress tests how RT tasks migrate
between CPUs when there's more RT tasks running that CPUs to run them on.

This is the push/pull logic in action!

 migrate-958     4d..2.   266.971936: sched_switch:         migrate:958 [89] S ==> userspin:939 [120]

Task 958 of priority 89 (lower is higher) goes to sleep. There's no RT
tasks on CPU 4 to run, so it runs userspin.

 migrate-953     2d.h2.   266.971938: sched_waking:         comm=migrate pid=957 prio=90 target_cpu=002
 migrate-953     2d..2.   266.971944: sched_switch:         migrate:953 [94] R ==> migrate:957 [90]

On CPU 2, task 957 (prio 90) preempts 953 (prio 94).

userspin-939     4d..2.   266.971953: sched_switch:         userspin:939 [120] R ==> migrate:953 [94]

Now 953 migrates over to CPU 4 as it's currently the CPU running the lowest
priority task.

There's other cases where another CPU was simply overloaded, and when the
RT task on the CPU with userspin went to sleep, it triggered an IPI to the
overloaded CPU to tell it to push it over here.

All is good. Nothing to see here ;-)

-- Steve
