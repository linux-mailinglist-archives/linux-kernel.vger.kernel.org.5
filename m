Return-Path: <linux-kernel+bounces-102221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 999B587AF89
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:27:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3743B24E03
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A5501A171A;
	Wed, 13 Mar 2024 17:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="abKAUvgv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5D61A1E34;
	Wed, 13 Mar 2024 17:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710349516; cv=none; b=QDTC1A5ogcuUUhItIIzK3QXbR3UsAq9d796V3jCvpZ7PJ0h1Ke+DWuKNL5OtuIQwCd3QunG55bq5DRRcyLViGYHdnj3iwf8JUJpdmM+QOhWBhm3jSaVGNUusPVUWJafGQRmOddhGDSd5pTktmCdKgkMMhbWX0QP9gKCy4q5ytaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710349516; c=relaxed/simple;
	bh=D33qK3iC2lTGGcA6eSg3iDpe+4bzMfIi9a7UvNyKLuc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PEbIlclIgCttg27NjWYiiNFkYRDwDmkVJaobVSf7AAq9Lpgyhv6KaByFYwPqsFlX0TPFO+33C3Kh2Sr3mDse7xIMoL2vcYHoah7sxaTOw5FhVnH6rOflt30g61GxYmiM2znXa74uJdoAtuXaPHv/AUKiM8AfkSNSwYt6nHDXN0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=abKAUvgv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 222BCC433F1;
	Wed, 13 Mar 2024 17:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710349516;
	bh=D33qK3iC2lTGGcA6eSg3iDpe+4bzMfIi9a7UvNyKLuc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=abKAUvgvtdShlzZigAsAdELg0pXot7S5WeWrQ8qJl9/pFc7USfatuq6Fv7DWF/gvF
	 ZypzKBtkfIuS15qBg27+F15UjpTvAHvAchg1i5T8cyxAR3CcjZh+huIgsHtTRbLZei
	 NIIg2c5WVjxPHmasVJ8uVR+SNAOosywlD53KOs4jdsuigMWFYso/oagiCmru4hQ/eR
	 mdPRhp75CvEoKzl4+ez2bEJiL4AB3p4gz2l66ZZr413rrUHRdxPDTziK9+tOK5gQFQ
	 11nOhdYOfGwghUfFToDCK4UC2rMJmTd+06kdSEh2UvTi/dlUy/KdiE0i/uxTgJSEJV
	 q+b8Wjadk6+Mg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Oleg Nesterov <oleg@redhat.com>,
	Dylan Hatch <dylanbhatch@google.com>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 34/41] getrusage: move thread_group_cputime_adjusted() outside of lock_task_sighand()
Date: Wed, 13 Mar 2024 13:04:28 -0400
Message-ID: <20240313170435.616724-35-sashal@kernel.org>
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
index d0d4f4c586518..ab621d7837c97 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -1717,17 +1717,19 @@ void getrusage(struct task_struct *p, int who, struct rusage *r)
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
@@ -1750,9 +1752,6 @@ void getrusage(struct task_struct *p, int who, struct rusage *r)
 			break;
 
 	case RUSAGE_SELF:
-		thread_group_cputime_adjusted(p, &tgutime, &tgstime);
-		utime += tgutime;
-		stime += tgstime;
 		r->ru_nvcsw += sig->nvcsw;
 		r->ru_nivcsw += sig->nivcsw;
 		r->ru_minflt += sig->min_flt;
@@ -1772,19 +1771,24 @@ void getrusage(struct task_struct *p, int who, struct rusage *r)
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


