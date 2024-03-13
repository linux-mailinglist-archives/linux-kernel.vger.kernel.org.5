Return-Path: <linux-kernel+bounces-102006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B927A87AD85
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:37:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB61D1C220DF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 154B514C5BE;
	Wed, 13 Mar 2024 16:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B+dH4tin"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3692414C5A2;
	Wed, 13 Mar 2024 16:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348219; cv=none; b=YBlNJfdsSRwG9hv8onLbivk3t6y+CrtzM0MhUs4RrKDYSWdcLwf7zWilWCXSN0NG76oI6+d6K8EvK9Neq8mxDCyIfgLUkGvyTdPHMxxbgzz2j6LtyO4e7MCFREvucpf5ZthJbKLv9aS0y4Wq7/kDIqSBM1stz5RnfcvHzTUPWEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348219; c=relaxed/simple;
	bh=PgNbsfSnge8biy8YM3pVL9sIVanFruRxDzQvse34EW0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UAiItjvibRo78oVSXQ9XYsw615j2on+4I3poMC0zPSQBMeuiDRWsa3BDQh/be6FzTTj1cxEJHYUHV3lR9nM8cbyoyKUWHizjmaU9H8ZiXH3y409xZLruEwzGd5mBJxdwqMaHBWT+b8H5Qt+s5/uWz2Ytzn9sh3iI1WmXBlSSqNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B+dH4tin; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27F99C433F1;
	Wed, 13 Mar 2024 16:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348219;
	bh=PgNbsfSnge8biy8YM3pVL9sIVanFruRxDzQvse34EW0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B+dH4tin/pdpzY+vUX2/goLoeKAoqY/vRLrW00xkwTLpGg+QSd1yt7QPbLbU41m28
	 rycGsxtwfhLt2VJVp27ytE6KBulMR/eKzktJkVuYJSq3XAEgfi7WfMP8I/L6/j0T3c
	 ghPA1ctDRLQQPUrX2YHjMlMmH2gncyzQWMS3cayBh78J6ukXNZ58UV0GH0tFTe5kul
	 wEolxGGvg/qjWZEZQV9HKkvm4HbdFkb71yBkO+sOgiIkeAEFHyST3HH20ZQEhIyEzm
	 L88WO0ykAuoDmekXGEfvMK5iO90F41efku7UAbPADYLhHdqFa7ZT5BmTllt/p/YMe5
	 CSAo+/V0ikxFg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Oleg Nesterov <oleg@redhat.com>,
	Dylan Hatch <dylanbhatch@google.com>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 65/76] fs/proc: do_task_stat: move thread_group_cputime_adjusted() outside of lock_task_sighand()
Date: Wed, 13 Mar 2024 12:42:12 -0400
Message-ID: <20240313164223.615640-66-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313164223.615640-1-sashal@kernel.org>
References: <20240313164223.615640-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.152-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.15.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.15.152-rc1
X-KernelTest-Deadline: 2024-03-15T16:42+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Oleg Nesterov <oleg@redhat.com>

[ Upstream commit 60f92acb60a989b14e4b744501a0df0f82ef30a3 ]

Patch series "fs/proc: do_task_stat: use sig->stats_".

do_task_stat() has the same problem as getrusage() had before "getrusage:
use sig->stats_lock rather than lock_task_sighand()": a hard lockup.  If
NR_CPUS threads call lock_task_sighand() at the same time and the process
has NR_THREADS, spin_lock_irq will spin with irqs disabled O(NR_CPUS *
NR_THREADS) time.

This patch (of 3):

thread_group_cputime() does its own locking, we can safely shift
thread_group_cputime_adjusted() which does another for_each_thread loop
outside of ->siglock protected section.

Not only this removes for_each_thread() from the critical section with
irqs disabled, this removes another case when stats_lock is taken with
siglock held.  We want to remove this dependency, then we can change the
users of stats_lock to not disable irqs.

Link: https://lkml.kernel.org/r/20240123153313.GA21832@redhat.com
Link: https://lkml.kernel.org/r/20240123153355.GA21854@redhat.com
Signed-off-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Dylan Hatch <dylanbhatch@google.com>
Cc: Eric W. Biederman <ebiederm@xmission.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/proc/array.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/proc/array.c b/fs/proc/array.c
index 77cf4187adecc..c925287a4dc4b 100644
--- a/fs/proc/array.c
+++ b/fs/proc/array.c
@@ -495,7 +495,7 @@ static int do_task_stat(struct seq_file *m, struct pid_namespace *ns,
 
 	sigemptyset(&sigign);
 	sigemptyset(&sigcatch);
-	cutime = cstime = utime = stime = 0;
+	cutime = cstime = 0;
 	cgtime = gtime = 0;
 
 	if (lock_task_sighand(task, &flags)) {
@@ -529,7 +529,6 @@ static int do_task_stat(struct seq_file *m, struct pid_namespace *ns,
 
 			min_flt += sig->min_flt;
 			maj_flt += sig->maj_flt;
-			thread_group_cputime_adjusted(task, &utime, &stime);
 			gtime += sig->gtime;
 		}
 
@@ -542,10 +541,13 @@ static int do_task_stat(struct seq_file *m, struct pid_namespace *ns,
 
 	if (permitted && (!whole || num_threads < 2))
 		wchan = !task_is_running(task);
-	if (!whole) {
+
+	if (whole) {
+		thread_group_cputime_adjusted(task, &utime, &stime);
+	} else {
+		task_cputime_adjusted(task, &utime, &stime);
 		min_flt = task->min_flt;
 		maj_flt = task->maj_flt;
-		task_cputime_adjusted(task, &utime, &stime);
 		gtime = task_gtime(task);
 	}
 
-- 
2.43.0


