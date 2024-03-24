Return-Path: <linux-kernel+bounces-114065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DE46888831
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:21:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC5AE28A4E6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BC74233160;
	Sun, 24 Mar 2024 23:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AWJkyCvf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63BE1E6F5A;
	Sun, 24 Mar 2024 23:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321353; cv=none; b=UhshCNo1hYSCiJ+AivorL9mKrRsNaxfoa0oPBnULUBgC0XWjlg3ZIMSlKxTDtDrNToQ4OtTHpPV+QRs2U03ZUgMzmdmOmE4UFqtOAIwK6mbgTX+MwhKlvY6G29u0jV3dFs4y4pvCo4Te8DTww/L3NICMTFEtW1l3vv9CiOHZsHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321353; c=relaxed/simple;
	bh=kM8YQXp6o/qYORoiPGCKnGbBby/uVMwI8X/vAzgwhGU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LkDgO8D5dK6wW7ujXnGnQEbs6fy5qvyjhs7pWZImwlmbjY0XxRcZYubuddycOFUPM65NT4VPT5EhFZJtOr4w4ZTKyp3r+JRPiNparQyB5PijR0kBCUgl8pIKKLwujD3BKSGMthoYAAqPW233UQXlpmqZNhS4xM7/NpkCGzDiHLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AWJkyCvf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB6CAC433F1;
	Sun, 24 Mar 2024 23:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321352;
	bh=kM8YQXp6o/qYORoiPGCKnGbBby/uVMwI8X/vAzgwhGU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AWJkyCvftkYW4R6Z1rCp6UlvqTadMTP1x2BABH+8IJvAZUlkQSNjVlABaqNZp8Z1X
	 vRGDnTzL25r8CNCODe6ACprHCCZIZOh5WORzSpeZRj0uRhGUmQYrIYk2xyYzZ0IaXZ
	 qByUQX5CtSNRFGH0/jwheos75NW8lLiYwmvpj9MsSO8Zf25chNxyQiMOeOoz/43MPd
	 kadirSTnB0v6lfTgd4CY6WBCf27q6qOg/ocBmd9KcwqZJBmyRhHHQPog4OCUBXPSDf
	 SvLaos89dgg7fWschiybJ9BC4YPeKCZwau1U+M9ocrv9C1xzZ5wpVLJEewiCnmBGS5
	 CmYAj0w9fqB3w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 077/638] workqueue: Don't call cpumask_test_cpu() with -1 CPU in wq_update_node_max_active()
Date: Sun, 24 Mar 2024 18:51:54 -0400
Message-ID: <20240324230116.1348576-78-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Tejun Heo <tj@kernel.org>

[ Upstream commit 15930da42f8981dc42c19038042947b475b19f47 ]

For wq_update_node_max_active(), @off_cpu of -1 indicates that no CPU is
going down. The function was incorrectly calling cpumask_test_cpu() with -1
CPU leading to oopses like the following on some archs:

  Unable to handle kernel paging request at virtual address ffff0002100296e0
  ..
  pc : wq_update_node_max_active+0x50/0x1fc
  lr : wq_update_node_max_active+0x1f0/0x1fc
  ...
  Call trace:
    wq_update_node_max_active+0x50/0x1fc
    apply_wqattrs_commit+0xf0/0x114
    apply_workqueue_attrs_locked+0x58/0xa0
    alloc_workqueue+0x5ac/0x774
    workqueue_init_early+0x460/0x540
    start_kernel+0x258/0x684
    __primary_switched+0xb8/0xc0
  Code: 9100a273 35000d01 53067f00 d0016dc1 (f8607a60)
  ---[ end trace 0000000000000000 ]---
  Kernel panic - not syncing: Attempted to kill the idle task!
  ---[ end Kernel panic - not syncing: Attempted to kill the idle task! ]---

Fix it.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reported-by: Nathan Chancellor <nathan@kernel.org>
Tested-by: Nathan Chancellor <nathan@kernel.org>
Link: http://lkml.kernel.org/r/91eacde0-df99-4d5c-a980-91046f66e612@samsung.com
Fixes: 5797b1c18919 ("workqueue: Implement system-wide nr_active enforcement for unbound workqueues")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/workqueue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index b2975e44dffa9..7d231bbd16593 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -1500,7 +1500,7 @@ static void wq_update_node_max_active(struct workqueue_struct *wq, int off_cpu)
 
 	lockdep_assert_held(&wq->mutex);
 
-	if (!cpumask_test_cpu(off_cpu, effective))
+	if (off_cpu >= 0 && !cpumask_test_cpu(off_cpu, effective))
 		off_cpu = -1;
 
 	total_cpus = cpumask_weight_and(effective, cpu_online_mask);
-- 
2.43.0


