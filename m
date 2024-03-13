Return-Path: <linux-kernel+bounces-102002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1B8B87AD7D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:36:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F5271C227AA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76F4414BD78;
	Wed, 13 Mar 2024 16:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r4bOOFP2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9186C14BD5C;
	Wed, 13 Mar 2024 16:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348214; cv=none; b=TS/1xh0EqtsM9l7oRVyk+wWmym9HuqY37wJvqc2/Sk11iFdaPb++KZTLz8XpmeHC0pj3R7ISK91TW8lYsL3OVsrEdxdZYM7mddgKf5ewIHyLLYrB6NolqDEc79e7JwsNeCdL+SCnc1U2FKmmc9VH2k0gqvXvj+J6qq8Z1YT14HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348214; c=relaxed/simple;
	bh=dBX5SGMYIABZbhEPwSAvjJkH193cy6hXRvYEI6b9Mqw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ASuyNKu3IErx3y6lwYYKbu4j1F2BZWNIQnObkdl+YoXWaAGYN+i+yjdGMIwVMlwXJ2iPZNwuZc19GI97yg3KY4opj3wYrTUM9OQP0hmeivBW1PbMKgu4+pOQhn5ll1tgxBy4aPaSOlAbUof68yVgH1TQZf252TollbMeOecrFh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r4bOOFP2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8629CC43390;
	Wed, 13 Mar 2024 16:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348214;
	bh=dBX5SGMYIABZbhEPwSAvjJkH193cy6hXRvYEI6b9Mqw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r4bOOFP2owrkwu6tkcPpfxQkEwLaKajdVfFGG8hXZLbucDQ9cgG26ixfhJMWdWb8P
	 GhA+mfxJcohK2pFrbjb+XaIkZo60HeX+MTAzjYrTKFmGfe+B1Nt++mD/9GTQSxmVdH
	 19HV8F4wu0ZpCJGE5Ieh1LnNMNrAI1m2BzZdPuTm6+oXjkTjHDjo2MLfJoxQr+J04r
	 DmN2MsOVKP20/2zI5/ciXa+IiM/NGqYO/4ZfK/0kvtT2YsP9rYir07g1OCxMravTqe
	 3bLegTAX/OSgZr66skeEZpX6n3E4IGHWd/nl3MuWqW29rDtDc/lLmncCiXDZ24S9Uw
	 S8bVdpx4i2XuA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Oleg Nesterov <oleg@redhat.com>,
	Dylan Hatch <dylanbhatch@google.com>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 61/76] getrusage: move thread_group_cputime_adjusted() outside of lock_task_sighand()
Date: Wed, 13 Mar 2024 12:42:08 -0400
Message-ID: <20240313164223.615640-62-sashal@kernel.org>
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

[ Upstream commit daa694e4137571b4ebec330f9a9b4d54aa8b8089 ]

Patch series "getrusage: use sig->stats_lock", v2.

This patch (of 2):

thread_group_cputime() does its own locking, we can safely shift
thread_group_cputime_adjusted() which does another for_each_thread loop
outside of ->siglock protected section.

This is also preparation for the next patch which changes getrusage() to
use stats_lock instead of siglock, thread_group_cputime() takes the same
lock.  With the current implementation recursive read_seqbegin_or_lock()
is fine, thread_group_cputime() can't enter the slow mode if the caller
holds stats_lock, yet this looks more safe and better performance-wise.

Link: https://lkml.kernel.org/r/20240122155023.GA26169@redhat.com
Link: https://lkml.kernel.org/r/20240122155050.GA26205@redhat.com
Signed-off-by: Oleg Nesterov <oleg@redhat.com>
Reported-by: Dylan Hatch <dylanbhatch@google.com>
Tested-by: Dylan Hatch <dylanbhatch@google.com>
Cc: Eric W. Biederman <ebiederm@xmission.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/sys.c | 34 +++++++++++++++++++---------------
 1 file changed, 19 insertions(+), 15 deletions(-)

diff --git a/kernel/sys.c b/kernel/sys.c
index 0298992c1eb9b..25f0c0697356b 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -1763,17 +1763,19 @@ void getrusage(struct task_struct *p, int who, struct rusage *r)
 	struct task_struct *t;
 	unsigned long flags;
 	u64 tgutime, tgstime, utime, stime;
-	unsigned long maxrss = 0;
+	unsigned long maxrss;
+	struct mm_struct *mm;
 	struct signal_struct *sig = p->signal;
 
-	memset((char *)r, 0, sizeof (*r));
+	memset(r, 0, sizeof(*r));
 	utime = stime = 0;
+	maxrss = 0;
 
 	if (who == RUSAGE_THREAD) {
 		task_cputime_adjusted(current, &utime, &stime);
 		accumulate_thread_rusage(p, r);
 		maxrss = sig->maxrss;
-		goto out;
+		goto out_thread;
 	}
 
 	if (!lock_task_sighand(p, &flags))
@@ -1797,9 +1799,6 @@ void getrusage(struct task_struct *p, int who, struct rusage *r)
 		fallthrough;
 
 	case RUSAGE_SELF:
-		thread_group_cputime_adjusted(p, &tgutime, &tgstime);
-		utime += tgutime;
-		stime += tgstime;
 		r->ru_nvcsw += sig->nvcsw;
 		r->ru_nivcsw += sig->nivcsw;
 		r->ru_minflt += sig->min_flt;
@@ -1819,19 +1818,24 @@ void getrusage(struct task_struct *p, int who, struct rusage *r)
 	}
 	unlock_task_sighand(p, &flags);
 
-out:
-	r->ru_utime = ns_to_kernel_old_timeval(utime);
-	r->ru_stime = ns_to_kernel_old_timeval(stime);
+	if (who == RUSAGE_CHILDREN)
+		goto out_children;
 
-	if (who != RUSAGE_CHILDREN) {
-		struct mm_struct *mm = get_task_mm(p);
+	thread_group_cputime_adjusted(p, &tgutime, &tgstime);
+	utime += tgutime;
+	stime += tgstime;
 
-		if (mm) {
-			setmax_mm_hiwater_rss(&maxrss, mm);
-			mmput(mm);
-		}
+out_thread:
+	mm = get_task_mm(p);
+	if (mm) {
+		setmax_mm_hiwater_rss(&maxrss, mm);
+		mmput(mm);
 	}
+
+out_children:
 	r->ru_maxrss = maxrss * (PAGE_SIZE / 1024); /* convert pages to KBs */
+	r->ru_utime = ns_to_kernel_old_timeval(utime);
+	r->ru_stime = ns_to_kernel_old_timeval(stime);
 }
 
 SYSCALL_DEFINE2(getrusage, int, who, struct rusage __user *, ru)
-- 
2.43.0


