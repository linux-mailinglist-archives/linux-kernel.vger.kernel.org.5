Return-Path: <linux-kernel+bounces-102225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EEBD87AF91
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:28:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E651B23C94
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0F781A2B88;
	Wed, 13 Mar 2024 17:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TqP2YT0T"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF52A1A2B73;
	Wed, 13 Mar 2024 17:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710349521; cv=none; b=cnXYXNfoIfIajoBrbbh01iLESqi2/y4j2lR0Li0Ddnt2qxW4fJNroXTKOWIXdWHu+jwbx8TgBcQXkiH5VRD/ZH5Y7hlVCINK435TcY95blyu55pw1qhqFD0VsKm/wLI/T972xsjwwyF73dwIkbG3DQA4XNmiy8ZKQ1fJSi/ZRFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710349521; c=relaxed/simple;
	bh=1zLnwlgPmLm0i0ZHzo4gXdSqmPLFoDumpBXT7L9pi+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hFZZRH5Omaa6kH1mG96IKSzTQ4yttmB2YlS5rfs6Mr7+QGrkFlpOiEHd0R+/Y70b4SqKF3xLfQgsdGOC2mJcWPGeNFVxaycZJbS66XTy6YrB6dPkhY5WYArc1asuoIGXvmAbZV0+UIBTQBBZ8EV09rbsOGcrSvQ8srTVogkPsxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TqP2YT0T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5661C433C7;
	Wed, 13 Mar 2024 17:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710349520;
	bh=1zLnwlgPmLm0i0ZHzo4gXdSqmPLFoDumpBXT7L9pi+Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TqP2YT0TTxy3NgjWZg3cwy7kXWMLBONbAK3Zr9ZBhcN26YfV6spPrUyMybmbsR78D
	 aMAjnAjey4C9y/CLbD1VppgClZOy2LmdleXG6KPPvP4E01ToRuIHB9mJJ5mly5KGKe
	 7pxjp0Tifd+KJ7dFalM7lXJKzoXUbdfbzTAR6tvBIDNEE86TPhBFNZOLm/BnE8lnB3
	 iKF0AwcX9zWNDmQ2FsoBy8VqKAm+MMT2Kfh6V82gOZfY2mTlnWc/9R9N/wGFiziSzL
	 +J4D1zYMoyIj+WH5N578SKd83eySowpRcEQ1MlqhgKPdTxW9BOk2YBsC164KQEAVkx
	 Uan1FK6m8S7mg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Oleg Nesterov <oleg@redhat.com>,
	Dylan Hatch <dylanbhatch@google.com>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 38/41] exit: wait_task_zombie: kill the no longer necessary spin_lock_irq(siglock)
Date: Wed, 13 Mar 2024 13:04:32 -0400
Message-ID: <20240313170435.616724-39-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313170435.616724-1-sashal@kernel.org>
References: <20240313170435.616724-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.310-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.19.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.19.310-rc1
X-KernelTest-Deadline: 2024-03-15T17:04+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Oleg Nesterov <oleg@redhat.com>

[ Upstream commit c1be35a16b2f1fe21f4f26f9de030ad6eaaf6a25 ]

After the recent changes nobody use siglock to read the values protected
by stats_lock, we can kill spin_lock_irq(&current->sighand->siglock) and
update the comment.

With this patch only __exit_signal() and thread_group_start_cputime() take
stats_lock under siglock.

Link: https://lkml.kernel.org/r/20240123153359.GA21866@redhat.com
Signed-off-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Dylan Hatch <dylanbhatch@google.com>
Cc: Eric W. Biederman <ebiederm@xmission.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/exit.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/kernel/exit.c b/kernel/exit.c
index 24e6953f606d2..a948ce8927975 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -1165,17 +1165,14 @@ static int wait_task_zombie(struct wait_opts *wo, struct task_struct *p)
 		 * and nobody can change them.
 		 *
 		 * psig->stats_lock also protects us from our sub-threads
-		 * which can reap other children at the same time. Until
-		 * we change k_getrusage()-like users to rely on this lock
-		 * we have to take ->siglock as well.
+		 * which can reap other children at the same time.
 		 *
 		 * We use thread_group_cputime_adjusted() to get times for
 		 * the thread group, which consolidates times for all threads
 		 * in the group including the group leader.
 		 */
 		thread_group_cputime_adjusted(p, &tgutime, &tgstime);
-		spin_lock_irq(&current->sighand->siglock);
-		write_seqlock(&psig->stats_lock);
+		write_seqlock_irq(&psig->stats_lock);
 		psig->cutime += tgutime + sig->cutime;
 		psig->cstime += tgstime + sig->cstime;
 		psig->cgtime += task_gtime(p) + sig->gtime + sig->cgtime;
@@ -1198,8 +1195,7 @@ static int wait_task_zombie(struct wait_opts *wo, struct task_struct *p)
 			psig->cmaxrss = maxrss;
 		task_io_accounting_add(&psig->ioac, &p->ioac);
 		task_io_accounting_add(&psig->ioac, &sig->ioac);
-		write_sequnlock(&psig->stats_lock);
-		spin_unlock_irq(&current->sighand->siglock);
+		write_sequnlock_irq(&psig->stats_lock);
 	}
 
 	if (wo->wo_rusage)
-- 
2.43.0


