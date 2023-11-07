Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DF5E7E4659
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 17:47:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232667AbjKGQrh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 11:47:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjKGQrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 11:47:35 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8A4B93
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 08:47:33 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D1D8C433C7;
        Tue,  7 Nov 2023 16:47:31 +0000 (UTC)
Date:   Tue, 7 Nov 2023 11:47:32 -0500
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
Message-ID: <20231107114732.5dd350ec@gandalf.local.home>
In-Reply-To: <CAEXW_YSjsZSrJK_RbGmbLNy4UrLCgu+7NPZjg-wiLuNbGOGr+w@mail.gmail.com>
References: <cover.1699095159.git.bristot@kernel.org>
        <c7b706d30d6316c52853ca056db5beb82ba72863.1699095159.git.bristot@kernel.org>
        <CAEXW_YS=PrWDx+YGVR7bmq0_SoKNztzGrreApCd9qk1yBLA5bA@mail.gmail.com>
        <CAEXW_YQ8kv3tXQJexLSguPuWi0bXiReKDyYNo9+A-Hgp=Zo1vA@mail.gmail.com>
        <CAEXW_YSjsZSrJK_RbGmbLNy4UrLCgu+7NPZjg-wiLuNbGOGr+w@mail.gmail.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Nov 2023 16:37:32 -0500
Joel Fernandes <joel@joelfernandes.org> wrote:

> Say CFS-server runtime is 0.3s and period is 1s.
> 
> At 0.7s, 0-laxity timer fires. CFS runs for 0.29s, then sleeps for
> 0.005s and wakes up at 0.295s (its remaining runtime is 0.01s at this
> point which is < the "time till deadline" of 0.005s)
> 
> Now the runtime of the CFS-server will be replenished to the full 0.3s
> (due to CBS) and the deadline
> pushed out.
> 
> The end result is, the total runtime that the CFS-server actually gets
> is 0.595s (though yes it did sleep for 5ms in between, still that's
> tiny -- say if it briefly blocked on a kernel mutex). That's almost
> double the allocated runtime.
> 
> This is just theoretical and I have yet to see if it is actually an
> issue in practice.

Let me see if I understand what you are asking. By pushing the execution of
the CFS-server to the end of its period, if it it was briefly blocked and
was not able to consume all of its zerolax time, its bandwidth gets
refreshed. Then it can run again, basically doubling its total time.

But this is basically saying that it ran for its runtime at the start of
one period and at the beginning of another, right?

Is that an issue? The CFS-server is still just consuming it's time per
period. That means that an RT tasks was starving the system that much to
push it forward too much anyway. I wonder if we just document this
behavior, if that would be enough?

-- Steve
