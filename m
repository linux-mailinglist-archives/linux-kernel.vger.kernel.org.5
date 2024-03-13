Return-Path: <linux-kernel+bounces-101932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4500C87ACD3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:18:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 568A81C21A91
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77EA8130AFA;
	Wed, 13 Mar 2024 16:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CNMKyvpy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60F512FF6D;
	Wed, 13 Mar 2024 16:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348075; cv=none; b=ULMdJfAm8AnGeS3XLmXU3yoIZ47Kgl04Zz52yMnGilSOu53Mlx5F6/O8edHMEAsaUZc1A5V6FiVXsTN02tdUUi/kDn1I8Drm7QVyKVJVBQ3k7SxyNDCh1A0vvnSM3rupxlV8F5/7nxAxjSbywaI5FKjnf29/y/wImihNuOTyXXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348075; c=relaxed/simple;
	bh=q1NnXT+AJB00pheXcbHdoAByKtIMEu4fRo46oJpbyZ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qw+ZEm3ValLcG4VSSkplJCPVJAsap30/QhWqhWFGHhK9ddhWwdUDiPWYM17AV2i0Er7Ah4ckhvosINfY050QbsJXMKRq9uT7S6t6WTSCkFuRVy1QPwQwgHAGYrnI3/wdo8yDqgasu32eXqlzyHDXztC1kGp/O9YhS5tvuPoeUN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CNMKyvpy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB525C433F1;
	Wed, 13 Mar 2024 16:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348075;
	bh=q1NnXT+AJB00pheXcbHdoAByKtIMEu4fRo46oJpbyZ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CNMKyvpyPiw2AItZ/9DjWPdsENpoJOtKNOfosnbJe8wYeQW+mpS9s2YnDHCK+g3Ot
	 xhZD34IRLDkY9NiZoMRH4sWlLrbAd6lOIqI7oeQDWRqwS9zBgwXKGSLPflio/W4UQ1
	 5hTkgEufNmh0GPxx2vUHYLabJaooefGTin5pmDOegCOYyu+TXk/uDoXwerTBgQlMuM
	 TZCb1PYMIymXvq5rH/CjTvigNle6yqBBcB1dnGYDnA9xSfa+bIDVr9J1ovUMpB9eKJ
	 hIX1qVfW2/YLKT+UajKGp0CdV5EHsvQHNknYxafNwh1V3i58S5jcW2peTrnjVs7MlT
	 x0ORPxhl8F/iA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Oleg Nesterov <oleg@redhat.com>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 64/71] getrusage: use __for_each_thread()
Date: Wed, 13 Mar 2024 12:39:50 -0400
Message-ID: <20240313163957.615276-65-sashal@kernel.org>
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
index 2646047fe5513..04102538cf43f 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -1822,10 +1822,8 @@ void getrusage(struct task_struct *p, int who, struct rusage *r)
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


