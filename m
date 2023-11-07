Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02EF57E47A2
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 18:54:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343739AbjKGRyh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 12:54:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230501AbjKGRyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 12:54:35 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC6C68F
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 09:54:33 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94251C433C8;
        Tue,  7 Nov 2023 17:54:31 +0000 (UTC)
Date:   Tue, 7 Nov 2023 12:54:34 -0500
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
Message-ID: <20231107125434.284c44da@gandalf.local.home>
In-Reply-To: <20231107123540.69038c6c@gandalf.local.home>
References: <cover.1699095159.git.bristot@kernel.org>
        <c7b706d30d6316c52853ca056db5beb82ba72863.1699095159.git.bristot@kernel.org>
        <CAEXW_YS=PrWDx+YGVR7bmq0_SoKNztzGrreApCd9qk1yBLA5bA@mail.gmail.com>
        <CAEXW_YQ8kv3tXQJexLSguPuWi0bXiReKDyYNo9+A-Hgp=Zo1vA@mail.gmail.com>
        <CAEXW_YSjsZSrJK_RbGmbLNy4UrLCgu+7NPZjg-wiLuNbGOGr+w@mail.gmail.com>
        <20231107114732.5dd350ec@gandalf.local.home>
        <20231107123540.69038c6c@gandalf.local.home>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


What's more interesting, when looking at the userspin task, I see a lot of this:

         migrate-1153  [003]  1272.988097: sched_switch:         migrate:1153 [90] S ==> userspin:1135 [120]
        userspin-1135  [003]  1272.988111: sched_switch:         userspin:1135 [120] R ==> migrate:1146 [97]

userspin sneaks in for 14 microseconds

         migrate-1146  [003]  1272.988141: sched_switch:         migrate:1146 [97] R ==> migrate:1159 [84]
         migrate-1159  [003]  1272.988159: print:                tracing_mark_write: thread 13 iter 15, took lock 15020 in 140726333419648 us
         migrate-1159  [003]  1272.992161: print:                tracing_mark_write: thread 13 iter 15, unlock lock 6
         migrate-1159  [003]  1272.992169: print:                tracing_mark_write: thread 13 iter 15 sleeping
         migrate-1159  [003]  1272.992177: sched_switch:         migrate:1159 [84] S ==> userspin:1135 [120]
        userspin-1135  [003]  1272.992190: sched_switch:         userspin:1135 [120] R ==> migrate:1150 [93]

Again for 13 microseconds.

         migrate-1150  [003]  1272.995118: sched_switch:         migrate:1150 [93] R ==> migrate:1153 [90]
         migrate-1153  [003]  1272.995129: print:                tracing_mark_write: thread 7 iter 15, taking lock 5
         migrate-1153  [003]  1272.995164: print:                tracing_mark_write: thread 7 iter 15, took lock 32 in 140726333419648 us
         migrate-1153  [003]  1273.005166: print:                tracing_mark_write: thread 7 iter 15, unlock lock 5
         migrate-1153  [003]  1273.005174: print:                tracing_mark_write: thread 7 iter 15 sleeping
         migrate-1153  [003]  1273.005183: sched_switch:         migrate:1153 [90] S ==> userspin:1135 [120]
        userspin-1135  [003]  1273.005204: sched_switch:         userspin:1135 [120] R ==> migrate:1159 [84]

For 21 microseconds.

         migrate-1159  [003]  1273.005216: print:                tracing_mark_write: thread 13 iter 15, taking lock 7
         migrate-1159  [003]  1273.005271: print:                tracing_mark_write: thread 13 iter 15, took lock 53 in 140726333419648 us
         migrate-1159  [003]  1273.009273: print:                tracing_mark_write: thread 13 iter 15, unlock lock 7
         migrate-1159  [003]  1273.009281: print:                tracing_mark_write: thread 13 iter 15 sleeping
         migrate-1159  [003]  1273.009289: sched_switch:         migrate:1159 [84] S ==> userspin:1135 [120]
        userspin-1135  [003]  1273.009301: sched_switch:         userspin:1135 [120] R ==> migrate:1147 [96]

12 microseconds

         migrate-1147  [003]  1273.012205: sched_switch:         migrate:1147 [96] R ==> migrate:1153 [90]
         migrate-1153  [003]  1273.012217: print:                tracing_mark_write: thread 7 iter 15, taking lock 6
         migrate-1153  [003]  1273.012228: sched_switch:         migrate:1153 [90] S ==> userspin:1135 [120]
        userspin-1135  [003]  1273.012242: sched_switch:         userspin:1135 [120] R ==> migrate:1146 [97]
         migrate-1146  [003]  1273.014251: sched_switch:         migrate:1146 [97] R ==> migrate:1148 [95]

2 milliseconds. (which is probably fine).

         migrate-1148  [003]  1273.020300: print:                tracing_mark_write: thread 2 iter 14, unlock lock 2
         migrate-1148  [003]  1273.020302: print:                tracing_mark_write: thread 2 iter 14 sleeping
         migrate-1148  [003]  1273.020309: sched_switch:         migrate:1148 [95] S ==> userspin:1135 [120]
        userspin-1135  [003]  1273.020324: sched_switch:         userspin:1135 [120] R ==> migrate:1147 [96]

15 microseconds.

         migrate-1147  [003]  1273.020360: print:                tracing_mark_write: thread 1 iter 14, unlock lock 1
         migrate-1147  [003]  1273.020373: print:                tracing_mark_write: thread 1 iter 14 sleeping
         migrate-1147  [003]  1273.020381: sched_switch:         migrate:1147 [96] S ==> userspin:1135 [120]
        userspin-1135  [003]  1273.021397: sched_switch:         userspin:1135 [120] R ==> migrate:1147 [96]

1 millisecond.

         migrate-1147  [003]  1273.021402: print:                tracing_mark_write: thread 1 iter 14, taking lock 2
         migrate-1147  [003]  1273.021404: print:                tracing_mark_write: thread 1 iter 14, took lock 1 in 140726333419648 us
         migrate-1147  [003]  1273.022200: sched_switch:         migrate:1147 [96] R ==> migrate:1152 [91]
         migrate-1152  [003]  1273.022206: print:                tracing_mark_write: thread 6 iter 15, taking lock 6
         migrate-1152  [003]  1273.022217: sched_switch:         migrate:1152 [91] S ==> migrate:1147 [96]
         migrate-1147  [003]  1273.022289: sched_switch:         migrate:1147 [96] R ==> migrate:1159 [84]
         migrate-1159  [003]  1273.022299: print:                tracing_mark_write: thread 13 iter 16, taking lock 0
         migrate-1159  [003]  1273.022326: print:                tracing_mark_write: thread 13 iter 16, took lock 25 in 140726333419648 us
         migrate-1159  [003]  1273.026328: print:                tracing_mark_write: thread 13 iter 16, unlock lock 0
         migrate-1159  [003]  1273.026337: print:                tracing_mark_write: thread 13 iter 16 sleeping
         migrate-1159  [003]  1273.026346: sched_switch:         migrate:1159 [84] S ==> userspin:1135 [120]
        userspin-1135  [003]  1273.026359: sched_switch:         userspin:1135 [120] R ==> migrate:1146 [97]

13 microseconds, and so on...

         migrate-1146  [003]  1273.027170: sched_switch:         migrate:1146 [97] R ==> migrate:1149 [94]
         migrate-1149  [003]  1273.027189: print:                tracing_mark_write: thread 3 iter 14, took lock 1927 in 140726333419648 us
         migrate-1149  [003]  1273.027335: sched_switch:         migrate:1149 [94] R ==> migrate:1153 [90]
         migrate-1153  [003]  1273.027349: print:                tracing_mark_write: thread 7 iter 15, took lock 15130 in 140726333419648 us
         migrate-1153  [003]  1273.037352: print:                tracing_mark_write: thread 7 iter 15, unlock lock 6
         migrate-1153  [003]  1273.037362: print:                tracing_mark_write: thread 7 iter 15 sleeping
         migrate-1153  [003]  1273.037370: sched_switch:         migrate:1153 [90] S ==> userspin:1135 [120]
        userspin-1135  [003]  1273.037395: sched_switch:         userspin:1135 [120] R ==> migrate:1147 [96]
         migrate-1147  [003]  1273.037406: print:                tracing_mark_write: thread 1 iter 14, unlock lock 2
         migrate-1147  [003]  1273.037408: print:                tracing_mark_write: thread 1 iter 14 sleeping
         migrate-1147  [003]  1273.037414: sched_switch:         migrate:1147 [96] S ==> userspin:1135 [120]
        userspin-1135  [003]  1273.038428: sched_switch:         userspin:1135 [120] R ==> migrate:1147 [96]


It looks like it sneaks in when it's about to schedule a new RT task.

Is this expected?

-- Steve
