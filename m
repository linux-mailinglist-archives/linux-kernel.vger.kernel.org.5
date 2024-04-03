Return-Path: <linux-kernel+bounces-130189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41C58897529
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 18:24:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4DDD1F2A2C6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 16:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79E2B152167;
	Wed,  3 Apr 2024 16:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I7M5G9qT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF4414F9F5
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 16:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712161466; cv=none; b=ej+LewFuSEGVNqy/j0VSlGdM3FN6vc99CtXTlXNuHljzAqY97ARSVFxftP496a3sNAi4LIhNaopPmN42Y+Zn04nwfLwB1BKmDRvzLzIO02yBwQe9+ez84rmbqSfcAfVj31AiGTYOIpd3JuTkDqleAwd5XFJ+Q6nQHTiL0HZaikk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712161466; c=relaxed/simple;
	bh=PGkvPz54sw6lbBSWwVDq6/wxpQ7dugoTXvPiOFQUkMM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PAmaX8+3flotda+yYMd/caeQUmKR7w1S5C32k7w/iMlDGCn1ahvkPazDGi5kOFaLH2aBJZxqDQ0qTAjZYNVL69NCNdrznmi0ah1h1/9qt4xfNcFjRPfSJNWrzUtj5paK0lTgWDlXOKzkE8aHeTi4BEgVJdSIVuu1SMO1iSro9rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I7M5G9qT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF362C43399;
	Wed,  3 Apr 2024 16:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712161466;
	bh=PGkvPz54sw6lbBSWwVDq6/wxpQ7dugoTXvPiOFQUkMM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I7M5G9qT/o8LPIZnvTjoSIlf/PCIustxS8/SolfShzjZ4Rjbf/qtRuPXxto/3i0/i
	 OFN947uUt7rocVm90HJ5MdUD9tKokjO8/QkIrajOn+83vuFaiuxOidNGKsWCtN4RT3
	 AwbbcM306JjnnuEQNFmyPidjQtE1nwbtiHbx8XBH2N6tTo1SHdTVurS6UhX7EC/aM8
	 EL2/e3Mc9GJDg1VM3SAmt9jU+32SlIXaYHf4QlbUK6Ay/cznJth69bdnF9jhwmv5/Q
	 +JeI5e9XJSx4O7PLUIjlwdW26+g6beh1rz348T4WGyyOtHOzTmoLzDLnmRzsPBARep
	 CjKscakTNnxwA==
Date: Wed, 3 Apr 2024 18:24:23 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] timers/migration: Fix ignored event due to missing CPU
 update
Message-ID: <Zg2Ct6M2RJAYHgCB@localhost.localdomain>
References: <20240401214859.11533-1-frederic@kernel.org>
 <87r0fo9jmw.fsf@somnus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87r0fo9jmw.fsf@somnus>

Le Tue, Apr 02, 2024 at 11:52:23AM +0200, Anna-Maria Behnsen a écrit :
> Frederic Weisbecker <frederic@kernel.org> writes:
> 
> > When a group event is updated with its expiry unchanged but a different
> > CPU, that target change may go unnoticed and the event may be propagated
> > up with a stale CPU value. The following depicts a scenario that has
> > been actually observed:
> 
> urgh...
> 
> >
> > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> > ---
> >  kernel/time/timer_migration.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/time/timer_migration.c b/kernel/time/timer_migration.c
> > index c63a0afdcebe..90786bb9a607 100644
> > --- a/kernel/time/timer_migration.c
> > +++ b/kernel/time/timer_migration.c
> > @@ -762,8 +762,11 @@ bool tmigr_update_events(struct tmigr_group *group, struct tmigr_group *child,
> >  	 * queue when the expiry time changed only or when it could be ignored.
> >  	 */
> >  	if (timerqueue_node_queued(&evt->nextevt)) {
> > -		if ((evt->nextevt.expires == nextexp) && !evt->ignore)
> > +		if ((evt->nextevt.expires == nextexp) && !evt->ignore) {
> > +			if (evt->cpu != first_childevt->cpu)
> > +				evt->cpu = first_childevt->cpu;
> 
> Why not just unconditionally overwriting the evt->cpu value here?

Right! See below:

---
From d038dad7345398a2f6671a3cda98a48805f9eba3 Mon Sep 17 00:00:00 2001
From: Frederic Weisbecker <frederic@kernel.org>
Date: Mon, 1 Apr 2024 23:48:59 +0200
Subject: [PATCH v2] timers/migration: Fix ignored event due to missing CPU update

When a group event is updated with its expiry unchanged but a different
CPU, that target change may go unnoticed and the event may be propagated
up with a stale CPU value. The following depicts a scenario that has
been actually observed:

                       [GRP2:0]
                   migrator = GRP1:1
                   active   = GRP1:1
                   nextevt  = TGRP1:0 (T0)
                    /              \
               [GRP1:0]           [GRP1:1]
            migrator = NONE       [...]
            active   = NONE
            nextevt  = TGRP0:0 (T0)
            /           \
        [GRP0:0]       [...]
      migrator = NONE
      active   = NONE
      nextevt  = T0
      /         \
    0 (T0)       1 (T1)
    idle         idle

0) The hierarchy has 3 levels. The left part (GRP1:0) is all idle,
including CPU 0 and CPU 1 which have a timer each: T0 and T1. They have
the same expiry value.

                       [GRP2:0]
                   migrator = GRP1:1
                   active   = GRP1:1
                   nextevt  = KTIME_MAX
                    /              \
               [GRP1:0]           [GRP1:1]
            migrator = NONE       [...]
            active   = NONE
            nextevt  = TGRP0:0 (T0)
            /           \
        [GRP0:0]       [...]
      migrator = NONE
      active   = NONE
      nextevt  = T0
      /         \
    0 (T0)       1 (T1)
    idle         idle

1) The migrator in GRP1:1 handles remotely T0. The event is dequeued
from the top and T0 executed.

                       [GRP2:0]
                   migrator = GRP1:1
                   active   = GRP1:1
                   nextevt  = KTIME_MAX
                    /              \
               [GRP1:0]           [GRP1:1]
            migrator = NONE       [...]
            active   = NONE
            nextevt  = TGRP0:0 (T0)
            /           \
        [GRP0:0]       [...]
      migrator = NONE
      active   = NONE
      nextevt  = T1
      /         \
    0            1 (T1)
    idle         idle

2) The migrator in GRP1:1 fetches the next timer for CPU 0 and finds
none. But it updates the events from its groups, starting with GRP0:0
which now has T1 as its next event. So far so good.

                       [GRP2:0]
                   migrator = GRP1:1
                   active   = GRP1:1
                   nextevt  = KTIME_MAX
                    /              \
               [GRP1:0]           [GRP1:1]
            migrator = NONE       [...]
            active   = NONE
            nextevt  = TGRP0:0 (T0)
            /           \
        [GRP0:0]       [...]
      migrator = NONE
      active   = NONE
      nextevt  = T1
      /         \
    0            1 (T1)
    idle         idle

3) The migrator in GRP1:1 proceeds upward and updates the events in
GRP1:0. The child event TGRP0:0 is found queued with the same expiry
as before. And therefore it is left unchanged. However the target CPU
is not the same but that fact is ignored so TGRP0:0 still points to
CPU 0 when it should point to CPU 1.

                       [GRP2:0]
                   migrator = GRP1:1
                   active   = GRP1:1
                   nextevt  = TGRP1:0 (T0)
                    /              \
               [GRP1:0]           [GRP1:1]
            migrator = NONE       [...]
            active   = NONE
            nextevt  = TGRP0:0 (T0)
            /           \
        [GRP0:0]       [...]
      migrator = NONE
      active   = NONE
      nextevt  = T1
      /         \
    0            1 (T1)
    idle         idle

4) The propagation has reached the top level and TGRP1:0, having TGRP0:0
as its first event, also wrongly points to CPU 0. TGRP1:0 is added to
the top level group.

                       [GRP2:0]
                   migrator = GRP1:1
                   active   = GRP1:1
                   nextevt  = KTIME_MAX
                    /              \
               [GRP1:0]           [GRP1:1]
            migrator = NONE       [...]
            active   = NONE
            nextevt  = TGRP0:0 (T0)
            /           \
        [GRP0:0]       [...]
      migrator = NONE
      active   = NONE
      nextevt  = T1
      /         \
    0            1 (T1)
    idle         idle

5) The migrator in GRP1:1 dequeues the next event in top level pointing
to CPU 0. But since it actually doesn't see any real event in CPU 0, it
early returns.

6) T1 is left unhandled until either CPU 0 or CPU 1 wake up.

Some other bad scenario may involve trees with just two levels.

Fix this with unconditionally updating the CPU of the child event before
considering to early return while updating a queued event with an
unchanged expiry value.

Fixes: 7ee988770326 ("timers: Implement the hierarchical pull model")
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/time/timer_migration.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/time/timer_migration.c b/kernel/time/timer_migration.c
index c63a0afdcebe..e3075e40cb43 100644
--- a/kernel/time/timer_migration.c
+++ b/kernel/time/timer_migration.c
@@ -762,8 +762,11 @@ bool tmigr_update_events(struct tmigr_group *group, struct tmigr_group *child,
 	 * queue when the expiry time changed only or when it could be ignored.
 	 */
 	if (timerqueue_node_queued(&evt->nextevt)) {
-		if ((evt->nextevt.expires == nextexp) && !evt->ignore)
+		if ((evt->nextevt.expires == nextexp) && !evt->ignore) {
+			/* Make sure not to miss a new CPU event with the same expiry */
+			evt->cpu = first_childevt->cpu;
 			goto check_toplvl;
+		}
 
 		if (!timerqueue_del(&group->events, &evt->nextevt))
 			WRITE_ONCE(group->next_expiry, KTIME_MAX);
-- 
2.44.0


