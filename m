Return-Path: <linux-kernel+bounces-115329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 133EC8893A7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:33:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44EEB1C2E885
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE0FA1E1680;
	Mon, 25 Mar 2024 02:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G2zbLnis"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F161D1D4C;
	Sun, 24 Mar 2024 22:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320531; cv=none; b=prKENz6XOcm/xKTXm/83VxsrEbG9dxFcd/TbbVyI5gPKGtUNl9huieCK/VOpxyHuKOKbQDwVsrz3Qq19S0cAlp6Dcxu7GNf4OvpBvh/Rw77Z+XMU1tg0iLLxbOvAt5SNqTqWBWTEY5SD4Dkf6a8hK9FhBvCVp+1PpPVFbhSfq+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320531; c=relaxed/simple;
	bh=kfUHX9dNA6VHlvW4hx4foa6phsP6hWb01o+wTBPm9Go=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GZHdBiVxDNilBG0av1D9jEOdEg/66jiwxYw+v5jiPi1z/jFYB0vOKyJ+/rWeBG5PEIzuaUptYuGvTf6/AMheXaJ0GGW63D4eoGKSYvcDBi3tRZ3Amj06g2kUowyBoitHSiDfQo1BdyDedrWEmeUD43ms0eTNPWTVRHsRndldZeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G2zbLnis; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D84AFC433C7;
	Sun, 24 Mar 2024 22:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320529;
	bh=kfUHX9dNA6VHlvW4hx4foa6phsP6hWb01o+wTBPm9Go=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G2zbLnisKCPx8QmRkESBRKXOA6LyQdlXvV6U4ueTzvKoPpSBFloi4LnvPMuGuaonU
	 I/18z5kt7OpqVOBEh3nQMBMtEUoxTyVscebYSQ/wRHAcgLrmhWJmhaGNlHAZd3QRDv
	 UgGf5gWRXk7aMFYc37Dzn6NpcsGKiF7s3WRi9pkWBro6q9COXL/BN+nxxRMN5uTTNi
	 nDCSATDzueCtEpcDAc18wLwv/oIt5dp1r4SiK2wZ7UwgTESR9Nf9fHnwkHwxjocQt2
	 hFAfUvl+WfJ7ZQPD6B7PhS2bUtCWh1qaMwKqqFtwGnPHOKADFkzyzpCcCozuuGNu7Q
	 TiQUqC8CvyYSA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 091/713] workqueue: Don't call cpumask_test_cpu() with -1 CPU in wq_update_node_max_active()
Date: Sun, 24 Mar 2024 18:36:57 -0400
Message-ID: <20240324224720.1345309-92-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
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
index 6b18926cf3523..6f7cb619aa5e4 100644
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


