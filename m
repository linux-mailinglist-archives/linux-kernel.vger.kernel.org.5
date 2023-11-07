Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE48C7E4936
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 20:32:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343814AbjKGTcT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 14:32:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232970AbjKGTcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 14:32:18 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 021E7D4A
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 11:32:16 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2890C433C8;
        Tue,  7 Nov 2023 19:32:13 +0000 (UTC)
Date:   Tue, 7 Nov 2023 14:32:16 -0500
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
Message-ID: <20231107143216.170ca582@gandalf.local.home>
In-Reply-To: <20231107125434.284c44da@gandalf.local.home>
References: <cover.1699095159.git.bristot@kernel.org>
        <c7b706d30d6316c52853ca056db5beb82ba72863.1699095159.git.bristot@kernel.org>
        <CAEXW_YS=PrWDx+YGVR7bmq0_SoKNztzGrreApCd9qk1yBLA5bA@mail.gmail.com>
        <CAEXW_YQ8kv3tXQJexLSguPuWi0bXiReKDyYNo9+A-Hgp=Zo1vA@mail.gmail.com>
        <CAEXW_YSjsZSrJK_RbGmbLNy4UrLCgu+7NPZjg-wiLuNbGOGr+w@mail.gmail.com>
        <20231107114732.5dd350ec@gandalf.local.home>
        <20231107123540.69038c6c@gandalf.local.home>
        <20231107125434.284c44da@gandalf.local.home>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Just got this too (with the 20% we talked about on IRC).

 migrate-991     6.....   713.996237: print:                tracing_mark_write: thread 7 iter 3 sleeping

The above is 991 in userspace writing to trace_marker

 migrate-991     6d..2.   713.996251: bprint:               __schedule: Pick userspin:973:120

I added the above printk in the core pick_next_task().

 migrate-991     6d..2.   713.996254: sched_switch:         migrate:991 [90] S ==> userspin:973 [120]

We switch to userspin for just 16 microseconds, and notice, NEED_RESCHED is
not set.

userspin-973     6dN.2.   713.996270: bprint:               pick_task_rt: Pick RT migrate:988:93

The above printk is in pick_next_task_rt(), and NEED_RESCHED is now set!

userspin-973     6dN.2.   713.996271: bprint:               __schedule: Pick migrate:988:93
userspin-973     6d..2.   713.996272: sched_switch:         userspin:973 [120] R ==> migrate:988 [93]

I'll add your latest patch and see if that's different.

I'll also test this without any of the patches first.

-- Steve
