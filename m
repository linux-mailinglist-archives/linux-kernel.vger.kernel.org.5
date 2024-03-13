Return-Path: <linux-kernel+bounces-102091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDD4E87AE51
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:55:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B58B1C23487
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DF8D18C6F7;
	Wed, 13 Mar 2024 16:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lG0jEBNT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB76C18C6EE;
	Wed, 13 Mar 2024 16:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348475; cv=none; b=K3yCj8KPB3qzyHN0E7ei+ileeaLvqimOsujSkfRHX9DhuVv8QeoRvJbnDrVnhEDhttUvRejWmVMfMLvJMUl79x+bBlbwO3rpmDXmkSf1YALQVSA9rvMBavLS0CX5MmUSo6Lxj69PSJueoaFzj8Cyw9GF+mqLadRrqBjvSqQujYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348475; c=relaxed/simple;
	bh=Chwo63+CUgFsse9hE2Vrekasq4uLyH88xEX6ey5kJcU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MLQgHQVQJo2NdzRSxMRyJWSBaSASJskW4dzDmTcZ7hlrqAqqtRxswLH3VMmme8unY/yAqIskk8LJ3RcUFllwmeuS79+g3hrksNEHzIAHeo4HMIOD2S1IOwQXdWKsQy9dZQB2HlTMXGNj8IZIAKLtAq/6ZzJErmtFmjak0FpMRVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lG0jEBNT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A82B5C433F1;
	Wed, 13 Mar 2024 16:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348475;
	bh=Chwo63+CUgFsse9hE2Vrekasq4uLyH88xEX6ey5kJcU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lG0jEBNTmzTkB+KN+QGY2tNmL3atzF3hneXDsiNymN7Bv+C77/gGt1WSgtld+2CpV
	 sm6S2Yb6vn8qXY49xoos9kY0Dq0h82S7hsWVJmJWxMdjH1DlTbHPRlVZJKScxcQEWQ
	 IE9/i9HBO608j0er31eRg6by3YIeAZ0mA8GZLfwvBuR/t0SU4z/yxZZWQ8gfZipaxG
	 L3ptvEHz09qQxlMvldz8WwQ+DnfxkX/RVDQsrjxgv1pLxaMJvcui5b370ejxrxh1/P
	 NATLhdftlnb8TWH2jSDq0VanxRnU2HoA5ERkZ9YOqfbPWfRZo68LHeFpJntw67Lmj1
	 keU36DFJ/dktg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Oleg Nesterov <oleg@redhat.com>,
	Dylan Hatch <dylanbhatch@google.com>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 65/73] exit: wait_task_zombie: kill the no longer necessary spin_lock_irq(siglock)
Date: Wed, 13 Mar 2024 12:46:32 -0400
Message-ID: <20240313164640.616049-66-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313164640.616049-1-sashal@kernel.org>
References: <20240313164640.616049-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.213-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.10.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.10.213-rc1
X-KernelTest-Deadline: 2024-03-15T16:46+00:00
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
index c41bdc0a7f06b..8f25abdd5fa7d 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -1106,17 +1106,14 @@ static int wait_task_zombie(struct wait_opts *wo, struct task_struct *p)
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
@@ -1139,8 +1136,7 @@ static int wait_task_zombie(struct wait_opts *wo, struct task_struct *p)
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


