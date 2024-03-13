Return-Path: <linux-kernel+bounces-102159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EDC9187AEEB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:12:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DBADB224AA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 199047690E;
	Wed, 13 Mar 2024 17:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P8YQyktO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B84192530;
	Wed, 13 Mar 2024 17:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710349376; cv=none; b=ShIAYTLMnqC4cl0E/luRiGAdK+eCq56Ojcu9V8ypsUoF1TbnIocZ/mtAegMVqC/xWW2k+yTN28qj4C36efvCQkQxSNxSREKPUFlYAYCLf+cLMdmcMtrEaGTtV540rf5SIBW5RhdtjbcxDt8qyebAZMuXeZ6np1+IsRW6f2Hv1cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710349376; c=relaxed/simple;
	bh=7T0pDHheBPUUNvvlEq6usmgQNt0IgEdw4N4upetox1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Px55oM9eUgNmiQKn04mivrtWkXZLajiIzhfnpk+7Eoz/kJcmV/mZCkIaA02aKLiHX+mV9ky+IoqUw12cIY/aFr9PT6fxW33cX7Fyta/QXXB6wV0XccBUZaTsB+TIuzTGtVy0V43KzPJSXFicEa55SrEJi4a46Fq/sRSjOij2w5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P8YQyktO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86F1EC43399;
	Wed, 13 Mar 2024 17:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710349376;
	bh=7T0pDHheBPUUNvvlEq6usmgQNt0IgEdw4N4upetox1Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P8YQyktOr30QnKSbrO21t8wGCk8XM8fcchLvVDpZy3Gr/mVmHrD7m7PGknGKtoG49
	 K7K4TIJIAmJnZ4/up3sP/i/tekEaXZx461a3Ie8ezD9lm+Gp+vbXcoEyq+aMhyTDZ4
	 8rb9aWHKPHMTcb1+oaVXxOgVO/l/mWukFmublKpsqlyxtlKjwi62AFELcwsqFP49zi
	 b4n1TGhbWu8USGgvFINrf51kwJMcgwuuEIrbwww+1uqAQltdf6Ds/vAg4X4XBjue+g
	 zzb9+kidn3u3ZmP2ziTtkFgQ5Skah8Ys5dsbbwywcoZtrJZZTPfbmbzp5fuDfEO/PZ
	 SFXUx/bWnIg5A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Cyrill Gorcunov <gorcunov@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 38/51] y2038: rusage: use __kernel_old_timeval
Date: Wed, 13 Mar 2024 13:01:59 -0400
Message-ID: <20240313170212.616443-39-sashal@kernel.org>
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

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit bdd565f817a74b9e30edec108f7cb1dbc762b8a6 ]

There are two 'struct timeval' fields in 'struct rusage'.

Unfortunately the definition of timeval is now ambiguous when used in
user space with a libc that has a 64-bit time_t, and this also changes
the 'rusage' definition in user space in a way that is incompatible with
the system call interface.

While there is no good solution to avoid all ambiguity here, change
the definition in the kernel headers to be compatible with the kernel
ABI, using __kernel_old_timeval as an unambiguous base type.

In previous discussions, there was also a plan to add a replacement
for rusage based on 64-bit timestamps and nanosecond resolution,
i.e. 'struct __kernel_timespec'. I have patches for that as well,
if anyone thinks we should do that.

Reviewed-by: Cyrill Gorcunov <gorcunov@gmail.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Stable-dep-of: daa694e41375 ("getrusage: move thread_group_cputime_adjusted() outside of lock_task_sighand()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/alpha/kernel/osf_sys.c   | 2 +-
 include/uapi/linux/resource.h | 4 ++--
 kernel/sys.c                  | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/alpha/kernel/osf_sys.c b/arch/alpha/kernel/osf_sys.c
index bf497b8b0ec60..bbe7a0da6264f 100644
--- a/arch/alpha/kernel/osf_sys.c
+++ b/arch/alpha/kernel/osf_sys.c
@@ -963,7 +963,7 @@ put_tv32(struct timeval32 __user *o, struct timespec64 *i)
 }
 
 static inline long
-put_tv_to_tv32(struct timeval32 __user *o, struct timeval *i)
+put_tv_to_tv32(struct timeval32 __user *o, struct __kernel_old_timeval *i)
 {
 	return copy_to_user(o, &(struct timeval32){
 				.tv_sec = i->tv_sec,
diff --git a/include/uapi/linux/resource.h b/include/uapi/linux/resource.h
index cc00fd0796317..74ef57b38f9f5 100644
--- a/include/uapi/linux/resource.h
+++ b/include/uapi/linux/resource.h
@@ -22,8 +22,8 @@
 #define	RUSAGE_THREAD	1		/* only the calling thread */
 
 struct	rusage {
-	struct timeval ru_utime;	/* user time used */
-	struct timeval ru_stime;	/* system time used */
+	struct __kernel_old_timeval ru_utime;	/* user time used */
+	struct __kernel_old_timeval ru_stime;	/* system time used */
 	__kernel_long_t	ru_maxrss;	/* maximum resident set size */
 	__kernel_long_t	ru_ixrss;	/* integral shared memory size */
 	__kernel_long_t	ru_idrss;	/* integral unshared data size */
diff --git a/kernel/sys.c b/kernel/sys.c
index f6d6ce8da3e4a..bc3cd0ef894e6 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -1767,8 +1767,8 @@ void getrusage(struct task_struct *p, int who, struct rusage *r)
 	unlock_task_sighand(p, &flags);
 
 out:
-	r->ru_utime = ns_to_timeval(utime);
-	r->ru_stime = ns_to_timeval(stime);
+	r->ru_utime = ns_to_kernel_old_timeval(utime);
+	r->ru_stime = ns_to_kernel_old_timeval(stime);
 
 	if (who != RUSAGE_CHILDREN) {
 		struct mm_struct *mm = get_task_mm(p);
-- 
2.43.0


