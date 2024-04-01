Return-Path: <linux-kernel+bounces-127104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0B338946B4
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 23:49:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55069281BF6
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 21:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7557755C3C;
	Mon,  1 Apr 2024 21:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PT1voFun"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83A454FBE
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 21:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712008146; cv=none; b=ZjfasNt/WhSehHlD/MZNMHtAYkYER78GoVdG5aSGjWeSdDC69/OLvWj0IwOMyEAAMmMoPX0nwSu8Gq0f/DbGjR1YgqYqM1pWWkFCq9NOIST/oZW3h/levOcBXhN8Xrx/n89kKLEDGNEDKohxvDxX78HMZf5WY6sKbJqq11IykN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712008146; c=relaxed/simple;
	bh=OaM75925jZLdZHhC39NGd4RsmecdFjlcFz/3krTx1Uc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cpyDvuX7iHsq1sKXmZ01wppornwIrfg00aTws1eNpQr3bYl0NvBXPmbbLv5f92lOIXjfoPYxQMkZeFL8S1QEvRAiK7rWoSfExTGXE8ld6WzOii4gfLnVenyqk/fuU35yF2Av8cGXLmcBCJsdBILPS20E1yXd5z0Xl6floC10kaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PT1voFun; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D73BC433F1;
	Mon,  1 Apr 2024 21:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712008146;
	bh=OaM75925jZLdZHhC39NGd4RsmecdFjlcFz/3krTx1Uc=;
	h=From:To:Cc:Subject:Date:From;
	b=PT1voFun3d5j2XLeGwqrimcNdbQhzQe893LIv3pvw0aGWOO0qZGm6o+WOnhYBDwO2
	 IGDQyK7yK//bqhyB4KVNuyoOqmMMoVg7UqqQhPvJSM1GvUpyVKu3Z7oMOU2gZPVDDF
	 cYDAYPxXcbWz/cWximqPcKIUV0Fy9lIMRk4aYFtHtQW7uceDFEqzpf+d1cbPII9fuC
	 JR3GkMhhDXUiSCwbDeImMhINiccAMOUv/DCvqU6b1tvx1RYv8OdVG9EUR2FDb4SjMS
	 ZtSNbOxhQa6tjrC57mEhNmosD5BRJqIspcsnfrCbr+qKvWPls6dzr2GnzusJhXQ8d+
	 JErhpxMEY6dcA==
From: Frederic Weisbecker <frederic@kernel.org>
To: Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH] timers/migration: Fix ignored event due to missing CPU update
Date: Mon,  1 Apr 2024 23:48:59 +0200
Message-ID: <20240401214859.11533-1-frederic@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

Fix this with checking the CPU, along with the expiry value before
considering to early return while updating a queued event.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/time/timer_migration.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/time/timer_migration.c b/kernel/time/timer_migration.c
index c63a0afdcebe..90786bb9a607 100644
--- a/kernel/time/timer_migration.c
+++ b/kernel/time/timer_migration.c
@@ -762,8 +762,11 @@ bool tmigr_update_events(struct tmigr_group *group, struct tmigr_group *child,
 	 * queue when the expiry time changed only or when it could be ignored.
 	 */
 	if (timerqueue_node_queued(&evt->nextevt)) {
-		if ((evt->nextevt.expires == nextexp) && !evt->ignore)
+		if ((evt->nextevt.expires == nextexp) && !evt->ignore) {
+			if (evt->cpu != first_childevt->cpu)
+				evt->cpu = first_childevt->cpu;
 			goto check_toplvl;
+		}
 
 		if (!timerqueue_del(&group->events, &evt->nextevt))
 			WRITE_ONCE(group->next_expiry, KTIME_MAX);
-- 
2.44.0


