Return-Path: <linux-kernel+bounces-102219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3572E87AF85
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:27:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6712D1C25E11
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD6A01A1E06;
	Wed, 13 Mar 2024 17:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qK/DRyG3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093E01A171A;
	Wed, 13 Mar 2024 17:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710349514; cv=none; b=AED6vtJgt82d2XR2xGxS/dwpXvhheW5ny+CnryPCrneXMf+n2fDCincMq1sQa8tOmh4yz6dtDOtz/WKYK+La7feFzInmt4u1Qd8oBRpHqzOdw+T4r7k5bFxqka8fF0WyOdSPtoJQOgmLkWoryUzpMmK54vcKwSWBIdHTEjqMobg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710349514; c=relaxed/simple;
	bh=JWBIn3l0YqEIYzxEwEDABafvULXVISSaPabgK7EYmKQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c1JjIzHqh9/2+NhKrYFg+hbzxM6L0oF3DbkO3y0z2L8wCgH0dcHJBAEVHwwCx+s9ooa732ifPQFQlNka4PIoFXKcO14t9SCEdHwBaZhbjqVKnn+Y460z+i8oTbcN0oO+9lSTfcLT1hJlZZ7klGqNHpBpHtoOHvjOlAt3BCQhA7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qK/DRyG3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE708C43390;
	Wed, 13 Mar 2024 17:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710349513;
	bh=JWBIn3l0YqEIYzxEwEDABafvULXVISSaPabgK7EYmKQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qK/DRyG3eLOa1d7kLeIZizcLZ9xJOST4wjq3tLtTRyJy49T0CI1ykfiEAORxR9mzh
	 l+k+DfcCGg1hFRsjyNFOkC4IzSjOhRG1gsfyTGmIBOT9qyyw3LKPf6tESvc+Rx4NQO
	 XcBpPzd2UMQWtRsX5gXMpKJ1K/SIH/1PCTu/CpCE3KEOpKzH/8MjNuK1OmdpPcZVoz
	 pV26nBLkYQCI/ZwY70sN30XdrcwEK75HqYtFDJEn/4A2np02EGYyncSAAtxNxm46sq
	 4ICuTgfcOlr8cZHFXle9n5klEmZf2zbw1zcrQ+EuWN2F5xckLBLwlnIlBJfVggwvSi
	 69xdGhE2n5M0w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Cyrill Gorcunov <gorcunov@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 32/41] y2038: rusage: use __kernel_old_timeval
Date: Wed, 13 Mar 2024 13:04:26 -0400
Message-ID: <20240313170435.616724-33-sashal@kernel.org>
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
index cff52d8ffdb12..d5694f263dd61 100644
--- a/arch/alpha/kernel/osf_sys.c
+++ b/arch/alpha/kernel/osf_sys.c
@@ -964,7 +964,7 @@ put_tv32(struct timeval32 __user *o, struct timespec64 *i)
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
index 3548467f6459b..e18bef5a8f9f5 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -1772,8 +1772,8 @@ void getrusage(struct task_struct *p, int who, struct rusage *r)
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


