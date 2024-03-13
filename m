Return-Path: <linux-kernel+bounces-101858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65DAE87AC34
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:01:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8C2728DF30
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DC34604B8;
	Wed, 13 Mar 2024 16:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RoeXHWXP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5442B7602C;
	Wed, 13 Mar 2024 16:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710347896; cv=none; b=ciM7SJcyBdVjuuEXzaHPIDViYZ4wnPUnrmBDm8BYTSrG5e/ucWh3fiNamE9fhDXVUyKBVZENhzbHql+z9JQY3cy23ERDBj9EIOKLxZ8tysaunVvF9Px9W50X8TzMdboVgJprMXL5I7BIz3js5uT2IFb6q6qq63COp6H0q24NG6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710347896; c=relaxed/simple;
	bh=uys9znSgCeHdgzitYvSe3FISZB4ZDmHwLt7pJPKCqpk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e3m3GOKtvxbYeLxtqpYCoHlsGR+gstsesSxsl9YxO4CNClENHTdcGtriqQj7Ynz7yt6weSGX5dtMVPEt2vDELrfRKTb3eswNA6VBRryHfQ6jtD5GVkGUVVViQyX7gfeX/LlpUw9eOjeS8j61wYC+21axfVqpiPCMz0XAavFFz+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RoeXHWXP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7BC3C433C7;
	Wed, 13 Mar 2024 16:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710347895;
	bh=uys9znSgCeHdgzitYvSe3FISZB4ZDmHwLt7pJPKCqpk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RoeXHWXPeOzN7sF+8vM/ZIDj115CSlP4BeIcnBFFDLz7WA+XQdfeonX3rqkwtJYBx
	 F2eS3JLffeU6TyYE823k+Qo0uUJpIjDCdxMatthHrS9s9hWwl1YdPijVIWbQotxkPI
	 KJ1lFG+rFBaYsNH6//EqQUETjnVErDgXtlGp2Yk9Q9f/241k3mEMA9d16Odyg5kuyi
	 AAXE1TXs17tp+DZYnnADL4rIvjir3slJLJT0LX59WC/9xC44ZISv8DekuuPK5NUDZw
	 QP5Ei7qU/woLFyOVWMciUn/fVcp44SP5XkVpYaq3wxxK4xxpfiLvsPKgKmMotJGXpl
	 ZrmGu5yor9pdQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Oleg Nesterov <oleg@redhat.com>,
	Dylan Hatch <dylanbhatch@google.com>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 55/60] exit: wait_task_zombie: kill the no longer necessary spin_lock_irq(siglock)
Date: Wed, 13 Mar 2024 12:37:02 -0400
Message-ID: <20240313163707.615000-56-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313163707.615000-1-sashal@kernel.org>
References: <20240313163707.615000-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.22-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.6.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.6.22-rc1
X-KernelTest-Deadline: 2024-03-15T16:36+00:00
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
index 21a59a6e1f2e8..1867d420c36c4 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -1148,17 +1148,14 @@ static int wait_task_zombie(struct wait_opts *wo, struct task_struct *p)
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
@@ -1181,8 +1178,7 @@ static int wait_task_zombie(struct wait_opts *wo, struct task_struct *p)
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


