Return-Path: <linux-kernel+bounces-112898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 306C2887F95
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:38:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61DDE1C210E3
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 22:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3F535478B;
	Sun, 24 Mar 2024 22:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p0Ya6EQH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F165381B;
	Sun, 24 Mar 2024 22:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319709; cv=none; b=bRm9qiSK1v9UeXx/4cFqz+BBAv6ZOogAc/FKKMb2EEBab9zMrAfJlPz27PJ5cz+4NqIwyvlUs3lAyxapUZO0l2jLWGjyUZOtqE9sqIllsohaBe1XAjm4mnV7eS+Bfcf1CZqPN5SNaDOQBklugxcEluGr/EVbViX2U6NTN3DSGY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319709; c=relaxed/simple;
	bh=WDc2CdjJwHVoN79rGTJFg+3uVuux82aXT82wcc+F104=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aLEVFuxBMsvWzyo8ExBKDztqrHOlVGuUGiI0sMr4oAL3yv3/vNaOA1JXnqnRYbqU7GZ4WN95NxR+pTIe72dreuQ7p/BvpgkZksG94TO66uP6dgk1JyXzK1los2xjtXktr1QF5MFsyhwWm8bKucED9WdoYu5nrDbqghHq0xjA2vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p0Ya6EQH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A568FC43399;
	Sun, 24 Mar 2024 22:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319708;
	bh=WDc2CdjJwHVoN79rGTJFg+3uVuux82aXT82wcc+F104=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p0Ya6EQH2C4Jkol610Y/ZJT/WcZ/g08bzDzgcYVCkuEhINKGGgxg7kt+Kq3mKNzJy
	 42CfyLVjw0fEI3SSGjlS15jI9G8uUvaLBk8LTdRKTKcrZdIQ3aFgHcb3GxumY2jjnu
	 iiBekV/OL9KahUOdqBkPy9R47uAoGIwXxrOS0xBl8JZD6k7eQm3B4sksK0+Z7SVurf
	 K9K1s9BQmDqfon2MS5aLCgzuyzEGZqC5ae0PP3MPruBlBqkoHpDcTr1Ixo/URCRZ9y
	 dE+BG+Q+45sReCvcs1bmoJovlLlPWkJf6P4xmgmW8UDpva990oHCiNYVTp0/dHW3u4
	 0A9WZR+JekC2w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 011/715] workqueue: Don't call cpumask_test_cpu() with -1 CPU in wq_update_node_max_active()
Date: Sun, 24 Mar 2024 18:23:10 -0400
Message-ID: <20240324223455.1342824-12-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
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
index 4f3425ed62ed9..ed8ebc9776016 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -1506,7 +1506,7 @@ static void wq_update_node_max_active(struct workqueue_struct *wq, int off_cpu)
 
 	lockdep_assert_held(&wq->mutex);
 
-	if (!cpumask_test_cpu(off_cpu, effective))
+	if (off_cpu >= 0 && !cpumask_test_cpu(off_cpu, effective))
 		off_cpu = -1;
 
 	total_cpus = cpumask_weight_and(effective, cpu_online_mask);
-- 
2.43.0


