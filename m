Return-Path: <linux-kernel+bounces-101930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7D3287ACCF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:18:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 884BA1F26562
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 738B412F363;
	Wed, 13 Mar 2024 16:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DMhdo9jD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77CE12CDAC;
	Wed, 13 Mar 2024 16:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348073; cv=none; b=WR7KrbeCaWnmAyNa1KmqK8FqV3foJBm/Y0hK6e8nCeg5Y8w0xHq/zy2awqluqNgXqNkaNQamfcHTz8IRRXp/zpCZVw7gGR//rXIBGyYPO1/hlOge/wAZ3P1jAz80Gi/t00XPSsuLESZvUJixOzyWi3cNNqhbfXx7J+J2BVdsWno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348073; c=relaxed/simple;
	bh=HVN3cchGgPe3KmftVzroCKYuacN0khmrFgws4zt+u/A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EgldB0TlG5ZdHJLhqEQUf+HebH6LLMlESrkn67rN7znQedgsnQkw40af199s9NKkk6agxnJbwLyZnKAPgd/YgyaNrNn+N2dfKNgjescf2mjjXPhENXqqpZ76pTCGwGrVx6iSvzyL/LkPW7oOmSgSScoRjK6WiJxD1oTCUeYz1nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DMhdo9jD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61599C43330;
	Wed, 13 Mar 2024 16:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348073;
	bh=HVN3cchGgPe3KmftVzroCKYuacN0khmrFgws4zt+u/A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DMhdo9jDIm9Nuw0S7fOj/WPvZT647cXKMRG8tR8I/6bBcMwvzqjX2e8yE3m9RK6aA
	 T4cotG9XpkmiSb2o3wD3vMYlk9atVs1SZ5GOh9BEe1W9/22m5oFJgMNAC9KD6+rgNZ
	 pyug9CPoCcTV2YN74ES1V8Im//bxMupEaU+HuMBNbWDJy1M5L8w9saAC2Jp2735ltl
	 t3jHjvazS0YIrknFNg7xb3cMIhzcY40Px5mjzONgkhHwNRS7LEns/pe6vyNQDSwUs3
	 ieHwQCOV+NeWM8ly4lgKFOdiyFZAK4N7C+qGnInGRv6YxOQhoIH/gMb+eCtqe5YEvm
	 6AOJ5e8/Gi6yw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Oleg Nesterov <oleg@redhat.com>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 62/71] getrusage: add the "signal_struct *sig" local variable
Date: Wed, 13 Mar 2024 12:39:48 -0400
Message-ID: <20240313163957.615276-63-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313163957.615276-1-sashal@kernel.org>
References: <20240313163957.615276-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.82-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.1.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.1.82-rc1
X-KernelTest-Deadline: 2024-03-15T16:39+00:00
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
index c85e1abf7b7c7..177155ba50cd3 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -1779,6 +1779,7 @@ void getrusage(struct task_struct *p, int who, struct rusage *r)
 	unsigned long flags;
 	u64 tgutime, tgstime, utime, stime;
 	unsigned long maxrss = 0;
+	struct signal_struct *sig = p->signal;
 
 	memset((char *)r, 0, sizeof (*r));
 	utime = stime = 0;
@@ -1786,7 +1787,7 @@ void getrusage(struct task_struct *p, int who, struct rusage *r)
 	if (who == RUSAGE_THREAD) {
 		task_cputime_adjusted(current, &utime, &stime);
 		accumulate_thread_rusage(p, r);
-		maxrss = p->signal->maxrss;
+		maxrss = sig->maxrss;
 		goto out;
 	}
 
@@ -1796,15 +1797,15 @@ void getrusage(struct task_struct *p, int who, struct rusage *r)
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
@@ -1814,14 +1815,14 @@ void getrusage(struct task_struct *p, int who, struct rusage *r)
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


