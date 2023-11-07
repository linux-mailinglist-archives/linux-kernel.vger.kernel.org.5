Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEB9B7E48B6
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 19:50:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234207AbjKGSuj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 13:50:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233046AbjKGSui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 13:50:38 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98444122
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 10:50:36 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8BF4C433C8;
        Tue,  7 Nov 2023 18:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699383036;
        bh=+ZoM+evIxD7mEneiMmjXU5QkrF9RQO8i/R1XbiDrQZ0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=eSCr5Jpz2N5JLw0L9AGG1S1p0Sj335osvqYOXL2HPNTY6xx5zHmgDJhKajxWFl9h4
         YQnm2ujHQ1TR7a+zSCLTYZ3HWgxUYUiMIwybRywVPw0zcJCYfDAEbTDN0ttYWyLHiT
         KY9jVg3bhvw+c3u13luI9DpDuDdpZL3up0dGGq868cWxGzpP1xkLkaMlI92V1PSftJ
         xwEl7QuddMnCOzah8QnRkcNIwECkKsI2ztcT+TuspqOdVsFO3elNIujfCZiWRMBLEE
         vafY9njuJdP2XXI45J+9twuVxVeiBR9Hdzwr+hDinXkDMP2HOrNTBci69WG71KlFcP
         RrXJyk23m6I/Q==
Message-ID: <3e58fad7-7f66-4e48-adcc-0fda9e9d0d07@kernel.org>
Date:   Tue, 7 Nov 2023 19:50:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 6/7] sched/deadline: Deferrable dl server
To:     Daniel Bristot de Oliveira <bristot@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org,
        Luca Abeni <luca.abeni@santannapisa.it>,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vineeth Pillai <vineeth@bitbyteword.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Phil Auld <pauld@redhat.com>
References: <cover.1699095159.git.bristot@kernel.org>
 <c7b706d30d6316c52853ca056db5beb82ba72863.1699095159.git.bristot@kernel.org>
 <CAEXW_YS=PrWDx+YGVR7bmq0_SoKNztzGrreApCd9qk1yBLA5bA@mail.gmail.com>
 <CAEXW_YQ8kv3tXQJexLSguPuWi0bXiReKDyYNo9+A-Hgp=Zo1vA@mail.gmail.com>
 <CAEXW_YSjsZSrJK_RbGmbLNy4UrLCgu+7NPZjg-wiLuNbGOGr+w@mail.gmail.com>
 <20231107114732.5dd350ec@gandalf.local.home>
 <7d1ea71b-5218-4ee0-bc89-f02ee6bd5154@redhat.com>
Content-Language: en-US, pt-BR, it-IT
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <7d1ea71b-5218-4ee0-bc89-f02ee6bd5154@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> The code is not doing what I intended because I thought it was doing overload
> control on the replenishment, but it is not (my bad).
> 

I am still testing but... it is missing something like this (famous last words).

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 1092ca8892e0..6e2d21c47a04 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -842,6 +842,8 @@ static inline void setup_new_dl_entity(struct sched_dl_entity *dl_se)
  * runtime, or it just underestimated it during sched_setattr().
  */
 static int start_dl_timer(struct sched_dl_entity *dl_se);
+static bool dl_entity_overflow(struct sched_dl_entity *dl_se, u64 t);
+
 static void replenish_dl_entity(struct sched_dl_entity *dl_se)
 {
 	struct dl_rq *dl_rq = dl_rq_of_se(dl_se);
@@ -852,9 +854,18 @@ static void replenish_dl_entity(struct sched_dl_entity *dl_se)
 	/*
 	 * This could be the case for a !-dl task that is boosted.
 	 * Just go with full inherited parameters.
+	 *
+	 * Or, it could be the case of a zerolax reservation that
+	 * was not able to consume its runtime in background and
+	 * reached this point with current u > U.
+	 *
+	 * In both cases, set a new period.
 	 */
-	if (dl_se->dl_deadline == 0)
-		replenish_dl_new_period(dl_se, rq);
+	if (dl_se->dl_deadline == 0 ||
+		(dl_se->dl_zerolax_armed && dl_entity_overflow(dl_se, rq_clock(rq)))) {
+			dl_se->deadline = rq_clock(rq) + pi_of(dl_se)->dl_deadline;
+			dl_se->runtime = pi_of(dl_se)->dl_runtime;
+	}

 	if (dl_se->dl_yielded && dl_se->runtime > 0)
 		dl_se->runtime = 0;

