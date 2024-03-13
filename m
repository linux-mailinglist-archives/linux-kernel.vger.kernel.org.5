Return-Path: <linux-kernel+bounces-102000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 741FE87AD79
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:35:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3029E28292A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 214D814BD4E;
	Wed, 13 Mar 2024 16:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XHGWpggE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6CD14AD26;
	Wed, 13 Mar 2024 16:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348213; cv=none; b=UNulbj5dA5GA37soWpkWIcCWrNvruZU/q6xtItRnucMps8fqj35kR56YC3Nai0I+zKfhMrn+TU+KWSnvbhqJArNLDmwUoCvSdeVotakPictbbI01dPMit9WspHs5dr9Epooew0DciweWwbDYHFSKUS9hwvw+oPfZIqDCvoxcOz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348213; c=relaxed/simple;
	bh=t8JjLrSBnpcqofryRsssp6nAlEA9Bh5ZWeeJ3QS4LoM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kr2ha2BWZwuhGxc0u/xpceJgEfRvblviDgDkV8gR0CKhnWpvcMFqvHBivMz3dHzNywxxAgJuRkK3xP/BjsI/HwOHQBImAAHZDy7lO8tQ5xqq/H5//gx6XkyskPFoFEXhODL1UgXtZiax0LsdsYwdk3EX5rn2lJ/Ob4TbE5jZr9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XHGWpggE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DD8DC433A6;
	Wed, 13 Mar 2024 16:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348213;
	bh=t8JjLrSBnpcqofryRsssp6nAlEA9Bh5ZWeeJ3QS4LoM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XHGWpggEpUION2Otf+l+LJajRnpS+2Aku/OdjhmVxhEHm5lgeopWEIU9XU20VVsqb
	 EFtUqKn/5xl284OAHHVRpT6OJhS37iA8NAFzcpjchk9Uf/c4B1FDZ8wkvu46WTbV52
	 UeDUMJEHBXtcBoImLOpbguMIx3ZFJx9efDRwr6S1NjQeRU14ZLm/VNKAKuVh0eOuqO
	 sgkK9KzZbnl4YHeaRBzbVPB/r0Lk452sTKf/8e8npsSUphB9qfhrBMzZWTvzD9pKSg
	 nlFRVw5O49b0672/VsDZwpK4Cj51g5AycS07L3H17lZ6DyFo0l/hd8VRKIIXLe222s
	 WsJfUxqLRdpAw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Oleg Nesterov <oleg@redhat.com>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 60/76] getrusage: add the "signal_struct *sig" local variable
Date: Wed, 13 Mar 2024 12:42:07 -0400
Message-ID: <20240313164223.615640-61-sashal@kernel.org>
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
index 2efab44746356..0298992c1eb9b 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -1764,6 +1764,7 @@ void getrusage(struct task_struct *p, int who, struct rusage *r)
 	unsigned long flags;
 	u64 tgutime, tgstime, utime, stime;
 	unsigned long maxrss = 0;
+	struct signal_struct *sig = p->signal;
 
 	memset((char *)r, 0, sizeof (*r));
 	utime = stime = 0;
@@ -1771,7 +1772,7 @@ void getrusage(struct task_struct *p, int who, struct rusage *r)
 	if (who == RUSAGE_THREAD) {
 		task_cputime_adjusted(current, &utime, &stime);
 		accumulate_thread_rusage(p, r);
-		maxrss = p->signal->maxrss;
+		maxrss = sig->maxrss;
 		goto out;
 	}
 
@@ -1781,15 +1782,15 @@ void getrusage(struct task_struct *p, int who, struct rusage *r)
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
@@ -1799,14 +1800,14 @@ void getrusage(struct task_struct *p, int who, struct rusage *r)
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


