Return-Path: <linux-kernel+bounces-102222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9714187AF8B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:27:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BABA61C263FD
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E5AE1A2658;
	Wed, 13 Mar 2024 17:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SW1xrXin"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67DF41A2641;
	Wed, 13 Mar 2024 17:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710349517; cv=none; b=Shbwmy4VdLbVE4l80ohhVmprUM9MTqaG1BtiOLF3F5FQBsBSjRfPZ3ijMhdEKHHgolTeRI34WXwvP6P3yhwoPfuxrth/EWVdlUqiDU/PdHwXCX3PtkDr/iR4TQ+/5sWl4P4ubQhiYaBg8mzP4RjX6d5cC+3L4tynfV9dhtHwTi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710349517; c=relaxed/simple;
	bh=4ia6iyHXr7Jm1ii3HHdTY4Tjrad2F1s0YbgkJHaG3FU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sdF31zSwb503YRcF74SQx4R/LjU3PAG6R004zI9EPQfiO0neYc3Ez3kIq4wjKKL3ZV7CYG6i0HSCEilqrxd3qtGsJDUfEyaFo0cGJd/dx/K6VYjqCYnA9MRG/Sr7nXMVyZZtdtpn/7K8RwQUD9wuCwwxxFCvrIasBr3CVsClMDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SW1xrXin; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D423C43390;
	Wed, 13 Mar 2024 17:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710349517;
	bh=4ia6iyHXr7Jm1ii3HHdTY4Tjrad2F1s0YbgkJHaG3FU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SW1xrXinNnWqtFyQDc+Zrc1p3FvCAtQjdTdAyGlb6M2mUNB6PeR4ME9iGjJHE8fD1
	 z1mDPowaUOBqljnlpL1LCdvv5pMnKba1Qqwka4IJLam3uXJNy3ZqnDIzdOpUUJg1xg
	 ZdeLWeun8rLi9C+Q+lK+9tnc9wHmUM7bsGFYxULZntLzl4wmD/Z0xkbufYW87sReQr
	 29Yo7xJz438k76X/4ZYH8bHeYEOWEHMET6OkTmxzUaJ+Hea6AT+9nNcGiYikhsCNrK
	 PLwHJwTp+hGSFrY4+z48DIJfqHXBjDS9IDS/MzSLcstPAos08f3kNsHbrYHOO2/THY
	 pCMx1v7bre9VQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Oleg Nesterov <oleg@redhat.com>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 35/41] getrusage: use __for_each_thread()
Date: Wed, 13 Mar 2024 13:04:29 -0400
Message-ID: <20240313170435.616724-36-sashal@kernel.org>
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
index ab621d7837c97..521a76d4adbbb 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -1760,10 +1760,8 @@ void getrusage(struct task_struct *p, int who, struct rusage *r)
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


