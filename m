Return-Path: <linux-kernel+bounces-102003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13FAE87AD7F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:36:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4522C1C226CA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F48214BF3A;
	Wed, 13 Mar 2024 16:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t2jnWM0b"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC23F14BF20;
	Wed, 13 Mar 2024 16:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348215; cv=none; b=LyZnI2P8zCH2mNbl1I7aaTMxPiFP3KoEVrFpe806XWycUrV9Ie3bpOcz0u53xyRejpxCe7ZzxyX79Gr78oBZTw3hv78yui6n7p3wXzSfPKHmkpPy0SzsJw1YJrd9ExqMZ1rwOdrl+bkvz+pNKcyhZX37IPBcigLgFyb4ZyG8vy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348215; c=relaxed/simple;
	bh=Ua5zIpkGM0VdF4IOpoP+bs2DZ9wApB/huugP8qfRO6Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pqjsAuJFInBI4VA6sKdKg3U6z6btmxz/oDHQHQzvpmJZHav5wLgovCoTNJAc6O2bcXmUE0s9VGCVxOdQBJmMMMr4GObhjK/xXtRRieWVjCW8G6JBQd7yJkfHZsle62xhJ5JV1Fw+vpRDJKjidqo/U8fHm90l3gLhTuZZAQ/724Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t2jnWM0b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB6C6C43399;
	Wed, 13 Mar 2024 16:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348215;
	bh=Ua5zIpkGM0VdF4IOpoP+bs2DZ9wApB/huugP8qfRO6Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t2jnWM0b1frbqK2QpEXLkLtdCrZSS8glgypjmiMP2IK3bVBCqhkyv1NHCqNhD9a7T
	 bkSWK6Oxt/Eyq/acBPIQBw6WbNxbvT7M34gwhAHTat7dGEStawWk0uCg9hhlgqn1vY
	 TIw5UxmYHJT6u97Qz/r9CThK1bqvRnXhljGOeF6gdGedPGHDgrdIaVta/z/50g2Hhg
	 ewETABWvehbTl9m+ozCu6/3+DaL3wal3Ir5mc/P/no7KIWhSIOUtL9TUqsh11EuLcQ
	 sMGjmX8/68BhZ1/LDQWr8H3RCcV/GTx1H6cwoOOSpS841jooOJOLF7ql1l1tlv+qz/
	 bwlCiLsHSnr1A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Oleg Nesterov <oleg@redhat.com>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 62/76] getrusage: use __for_each_thread()
Date: Wed, 13 Mar 2024 12:42:09 -0400
Message-ID: <20240313164223.615640-63-sashal@kernel.org>
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

[ Upstream commit 13b7bc60b5353371460a203df6c38ccd38ad7a3a ]

do/while_each_thread should be avoided when possible.

Plus this change allows to avoid lock_task_sighand(), we can use rcu
and/or sig->stats_lock instead.

Link: https://lkml.kernel.org/r/20230909172629.GA20454@redhat.com
Signed-off-by: Oleg Nesterov <oleg@redhat.com>
Cc: Eric W. Biederman <ebiederm@xmission.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: f7ec1cd5cc7e ("getrusage: use sig->stats_lock rather than lock_task_sighand()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/sys.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/sys.c b/kernel/sys.c
index 25f0c0697356b..85f358a5d5eb5 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -1807,10 +1807,8 @@ void getrusage(struct task_struct *p, int who, struct rusage *r)
 		r->ru_oublock += sig->oublock;
 		if (maxrss < sig->maxrss)
 			maxrss = sig->maxrss;
-		t = p;
-		do {
+		__for_each_thread(sig, t)
 			accumulate_thread_rusage(t, r);
-		} while_each_thread(p, t);
 		break;
 
 	default:
-- 
2.43.0


