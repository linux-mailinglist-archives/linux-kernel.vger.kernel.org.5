Return-Path: <linux-kernel+bounces-102160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3437487AEED
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:13:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3EB4281BF2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D819192D00;
	Wed, 13 Mar 2024 17:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X80cQ9df"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756FB192CE9;
	Wed, 13 Mar 2024 17:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710349377; cv=none; b=IfMNePATXXumktPm3RyGJSRygNXQEwFEvdfOxiBtum+Y7Jw/iqR9JxPH5FA3lzom0J6a9KSp/8+ufg8IKjPwpq3tTYIB2w8J4lzjicKPVA/LfwSE6s3psB5RxUpqGbaz/ObLpZb6wyQhoAzUtKTyILt3zC6skNKu1NbzyEsxmR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710349377; c=relaxed/simple;
	bh=c5pTaOVu83YktTpWX4QuZjK6vrmSaLm723FjbgRgv04=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qv85epDCD7ET9gfng31huqn1CcADd1z/zfRAYccPXLGYF/LSGmLMj3XauxjWgWB0e+3yjxBvhcBBk9Q3QL4N9ECo31967TzbKulCJGrSjTixDYyUMp+KADm4WbjmfWlzrWHcyLEqgBJXluwk5H52fQW5TYY461f9EaTR2xkfJdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X80cQ9df; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84642C433F1;
	Wed, 13 Mar 2024 17:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710349377;
	bh=c5pTaOVu83YktTpWX4QuZjK6vrmSaLm723FjbgRgv04=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X80cQ9dfn5jctGEEerEefp7yor3hKTcq0G1iV6SNeU/wyxZxk9DFF3/4/fxPcmy4d
	 PTQB+N4qaXtrCBlrcRCabsYtW+VbZAfLKll1fqJ/ZinpnwRh41hRZdQ11PnDIH7xCS
	 Tl8CkRjHirD2WCpyEZskIygKZTj26KroMlC7nVmNQl+NRUaoLVsqJHU2/fW5Ig6zIw
	 e5lIAuQ13fpn7w8UXyi8VxIxElzAPvSz9UGa7aiqoJhnyFDosT9Nid3LBbktDdIGm4
	 euEtILFIRxUgqaUBoIhag88nAKf5quYsHLS7lUnJWeNBtWiqIhYdxuOvYh9AJdnOoJ
	 uNrRciaGxsuig==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Oleg Nesterov <oleg@redhat.com>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 39/51] getrusage: add the "signal_struct *sig" local variable
Date: Wed, 13 Mar 2024 13:02:00 -0400
Message-ID: <20240313170212.616443-40-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313170212.616443-1-sashal@kernel.org>
References: <20240313170212.616443-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.272-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.4.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.4.272-rc1
X-KernelTest-Deadline: 2024-03-15T17:02+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Oleg Nesterov <oleg@redhat.com>

[ Upstream commit c7ac8231ace9b07306d0299969e42073b189c70a ]

No functional changes, cleanup/preparation.

Link: https://lkml.kernel.org/r/20230909172554.GA20441@redhat.com
Signed-off-by: Oleg Nesterov <oleg@redhat.com>
Cc: Eric W. Biederman <ebiederm@xmission.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: daa694e41375 ("getrusage: move thread_group_cputime_adjusted() outside of lock_task_sighand()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/sys.c | 37 +++++++++++++++++++------------------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff --git a/kernel/sys.c b/kernel/sys.c
index bc3cd0ef894e6..76b601d56c027 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -1712,6 +1712,7 @@ void getrusage(struct task_struct *p, int who, struct rusage *r)
 	unsigned long flags;
 	u64 tgutime, tgstime, utime, stime;
 	unsigned long maxrss = 0;
+	struct signal_struct *sig = p->signal;
 
 	memset((char *)r, 0, sizeof (*r));
 	utime = stime = 0;
@@ -1719,7 +1720,7 @@ void getrusage(struct task_struct *p, int who, struct rusage *r)
 	if (who == RUSAGE_THREAD) {
 		task_cputime_adjusted(current, &utime, &stime);
 		accumulate_thread_rusage(p, r);
-		maxrss = p->signal->maxrss;
+		maxrss = sig->maxrss;
 		goto out;
 	}
 
@@ -1729,15 +1730,15 @@ void getrusage(struct task_struct *p, int who, struct rusage *r)
 	switch (who) {
 	case RUSAGE_BOTH:
 	case RUSAGE_CHILDREN:
-		utime = p->signal->cutime;
-		stime = p->signal->cstime;
-		r->ru_nvcsw = p->signal->cnvcsw;
-		r->ru_nivcsw = p->signal->cnivcsw;
-		r->ru_minflt = p->signal->cmin_flt;
-		r->ru_majflt = p->signal->cmaj_flt;
-		r->ru_inblock = p->signal->cinblock;
-		r->ru_oublock = p->signal->coublock;
-		maxrss = p->signal->cmaxrss;
+		utime = sig->cutime;
+		stime = sig->cstime;
+		r->ru_nvcsw = sig->cnvcsw;
+		r->ru_nivcsw = sig->cnivcsw;
+		r->ru_minflt = sig->cmin_flt;
+		r->ru_majflt = sig->cmaj_flt;
+		r->ru_inblock = sig->cinblock;
+		r->ru_oublock = sig->coublock;
+		maxrss = sig->cmaxrss;
 
 		if (who == RUSAGE_CHILDREN)
 			break;
@@ -1747,14 +1748,14 @@ void getrusage(struct task_struct *p, int who, struct rusage *r)
 		thread_group_cputime_adjusted(p, &tgutime, &tgstime);
 		utime += tgutime;
 		stime += tgstime;
-		r->ru_nvcsw += p->signal->nvcsw;
-		r->ru_nivcsw += p->signal->nivcsw;
-		r->ru_minflt += p->signal->min_flt;
-		r->ru_majflt += p->signal->maj_flt;
-		r->ru_inblock += p->signal->inblock;
-		r->ru_oublock += p->signal->oublock;
-		if (maxrss < p->signal->maxrss)
-			maxrss = p->signal->maxrss;
+		r->ru_nvcsw += sig->nvcsw;
+		r->ru_nivcsw += sig->nivcsw;
+		r->ru_minflt += sig->min_flt;
+		r->ru_majflt += sig->maj_flt;
+		r->ru_inblock += sig->inblock;
+		r->ru_oublock += sig->oublock;
+		if (maxrss < sig->maxrss)
+			maxrss = sig->maxrss;
 		t = p;
 		do {
 			accumulate_thread_rusage(t, r);
-- 
2.43.0


