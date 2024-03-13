Return-Path: <linux-kernel+bounces-102088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D9487AE4B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:54:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35154B21E92
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DF9F18BDD1;
	Wed, 13 Mar 2024 16:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pt5Go2TT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C97718BDBC;
	Wed, 13 Mar 2024 16:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348472; cv=none; b=ETPq/tzz+bcU6c8E93PEoXME9pgluPF2Wf7NW4EGWijzpET6p04Y1m38mSaY5VFr2onMXjAR2KRQHhQgnNap8eMzTa/yUnjJQozUt6hims+J9xvsSFi9ch8LJWxARLziD/H+TIIr0sAh7Aerw/R/X3TV8fcWittq+yzzMbweyfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348472; c=relaxed/simple;
	bh=EQtMrThS3/qOAKgjVAXRTKvz+c3AvAO/ciTDn8MHz+c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IuFl1nOfeLowxuk6/ZMGk9TDFdtNSy9HS+XGlZcxJj6yoa/HUwhj6ViUPIpn4791Az4QwJHxup09qz6C9KqsKEP2mBwOHX4gvyVhtiulTN9P8T3dBEBeD7juErsEY6fEUwO4JRny/mJmcwpIRg+8yTv6rZwZBlrXat1Y53zPtao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pt5Go2TT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C4D9C433C7;
	Wed, 13 Mar 2024 16:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348472;
	bh=EQtMrThS3/qOAKgjVAXRTKvz+c3AvAO/ciTDn8MHz+c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pt5Go2TThD6bN7YB/znaCGpZfKzcZBnsivFxugGaroM97dk3x8nghBkvya8TcMMCu
	 9RzlFwlUs1WSQkTlBP9uWvyixdvghLKshcShXKMo6rvFN0cKfdPOOAH3ZST1to7nVk
	 Awqq2V8N4iDQNhuRN5RtU4HW4dqkK9yl5oAfNM9czgFC9JscoJQ4NddaW5gcGNzwfC
	 xR8IFdt8VJhytQgJdhu83LQTbRiZ1u9AXOCjSHHfMPUZxhlONCO/qrK+MC5bbXlkbi
	 coglNlbHWQfl7yWHl0QVPYLRi+om8s/2PR/xBIas4kN4MlbpfOjE+m+5pFaSZOH9C1
	 vtvB21/wvS1Jg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Oleg Nesterov <oleg@redhat.com>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 62/73] getrusage: use __for_each_thread()
Date: Wed, 13 Mar 2024 12:46:29 -0400
Message-ID: <20240313164640.616049-63-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313164640.616049-1-sashal@kernel.org>
References: <20240313164640.616049-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.213-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.10.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.10.213-rc1
X-KernelTest-Deadline: 2024-03-15T16:46+00:00
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
index 26c8783bd0757..f1ae8fa627145 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -1780,10 +1780,8 @@ void getrusage(struct task_struct *p, int who, struct rusage *r)
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


