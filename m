Return-Path: <linux-kernel+bounces-102220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 527B887AF87
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:27:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E36701F26587
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9904F1A1E1C;
	Wed, 13 Mar 2024 17:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tihd3/Wd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2FD1A1E07;
	Wed, 13 Mar 2024 17:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710349514; cv=none; b=NpiTPc/Ay3TssordR2GE4fs/kqokEBqYhJVM2YMIYr2UFZ99HMPLRPJ95HkXjTdIZAiVEJ77ZaLNPwLZGJENCh1cnHqrqbfy9zjHKwMhU2CC2GlPEBEg8qsloD88e7XNEgey7Gm1KyTTABNStw5euU0B4WPWVa5DbqdByC/bLXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710349514; c=relaxed/simple;
	bh=p1EZa2ZgHDmiucXAq91UYoVHVTEcoPAIJ0eMj0t95P8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZWdboLNCygqMkDk1unJFQPIJVb1GBXDtLuvCdgNXScjNzA9azHMBKKu7CVOY60j+Zc9sDrGQX4/koy0CDQY4RKDGi97I7FKmWZY6II1lRl/jupdQytXnuaLBZJ76bfRGfV6gLoK0hmQo+9tI2c1tc0VyNG3u+qZhXJWhzRVLyeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tihd3/Wd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDB6CC433C7;
	Wed, 13 Mar 2024 17:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710349514;
	bh=p1EZa2ZgHDmiucXAq91UYoVHVTEcoPAIJ0eMj0t95P8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tihd3/Wd5w3HEQ/5+u51K906yqOF7/LZFZFCTU9m7rQ+AZo1ufcIW0s+RP10FEe5l
	 C7vOPYVBDwGRzaKEAKeQmhLMqE0nqLO1IOBzfLNN7hX/p276jJdKuf4tXFs5zmkwb1
	 Ts9PKjKEuaMRjzgzQFWV55GYZbxkkttkJZ1zUCkVxL4ogdMpi+yB8dPXPA6auONa6E
	 HD3T+Ei5XslOJ3n1yVCR4pjvrjpCTZ+m0dlZ9ZUHl6T59/R9Tu1q2AxTIsA5LYi7QL
	 XZxJDXhWPAvPV7xXaYg9XycHh/zHy9IE3w75Z9mhGT6OcAkl12WK/JyVlPRKqjTCMH
	 UPFnwRWIhnA2g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Oleg Nesterov <oleg@redhat.com>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 33/41] getrusage: add the "signal_struct *sig" local variable
Date: Wed, 13 Mar 2024 13:04:27 -0400
Message-ID: <20240313170435.616724-34-sashal@kernel.org>
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
index e18bef5a8f9f5..d0d4f4c586518 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -1718,6 +1718,7 @@ void getrusage(struct task_struct *p, int who, struct rusage *r)
 	unsigned long flags;
 	u64 tgutime, tgstime, utime, stime;
 	unsigned long maxrss = 0;
+	struct signal_struct *sig = p->signal;
 
 	memset((char *)r, 0, sizeof (*r));
 	utime = stime = 0;
@@ -1725,7 +1726,7 @@ void getrusage(struct task_struct *p, int who, struct rusage *r)
 	if (who == RUSAGE_THREAD) {
 		task_cputime_adjusted(current, &utime, &stime);
 		accumulate_thread_rusage(p, r);
-		maxrss = p->signal->maxrss;
+		maxrss = sig->maxrss;
 		goto out;
 	}
 
@@ -1735,15 +1736,15 @@ void getrusage(struct task_struct *p, int who, struct rusage *r)
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
@@ -1752,14 +1753,14 @@ void getrusage(struct task_struct *p, int who, struct rusage *r)
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


