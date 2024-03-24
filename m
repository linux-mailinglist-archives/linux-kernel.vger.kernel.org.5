Return-Path: <linux-kernel+bounces-115989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 972BD889910
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:00:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C85891C320EC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 518523998F1;
	Mon, 25 Mar 2024 03:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nxjstq+I"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D9B15EFA6;
	Sun, 24 Mar 2024 23:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322322; cv=none; b=sBsI55FbzEMmCsqNmoFZJYYHoRqbC2dcWb4K6bgh7GfeF2oaRjT+jznRJ819JFwNVkyxaR2JK33Nn/8AFXmNFZlqHaeaqhE5HsFQ7dNVpc/EsZTiWUnenowoppykuWrOVCRxWy4BCAkQZoK5WaAnq8JlAhp9tkcbWcM+XxgFsxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322322; c=relaxed/simple;
	bh=/q7kX7w8e2y4D3v/bVrOi9LBx7ZC0xSu+jKkWdgha84=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y8s9P9PHTe6IjF3us3TQxlf05YXiEX5UkKRRNPadFAZRdMe3hv8e/kC08ud5UjBFNqYgH+Xs+uujYXuVlPS1dohdq0ZiogaVEVmwfpJ6JLVxA4WyI9SNWqpk4giMwwMt2hS+e8up3LcVbyCxTnI3BjtshMJCFSNrDddHG0LHZNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nxjstq+I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2726C43390;
	Sun, 24 Mar 2024 23:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322322;
	bh=/q7kX7w8e2y4D3v/bVrOi9LBx7ZC0xSu+jKkWdgha84=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Nxjstq+IIPQv+TJdgu3xFlQaTTdCUFpBXzpMajeV3jV6TLapvNjGhlfQoXyjk0Rg4
	 zCktU8umfgVOmGnH2ll5CdzJijZji3x17aMh3UfF0wXimRXcvOK8jDBQOkTOJDiEBh
	 tWk9Cdy4xA2aNvdK+WKa1ifdSFLjcCSemUekGhcefOqDH5Q73vNPsHBVGvhqsvVkLe
	 aC3lUn1ABM5ZZHF6/j6bVrjGs0n+uLefWuFL3ZgXSjjkjsQbCKf9otTy4WOls1BqDF
	 8ZkPzw4uNW0a7yiwcXrsmBQAz0E2HQCJ7+oQHYGMMxYe7WgcKRec9dB4yhDxOTLaRh
	 6rE+Z6CgSEXyw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mete Durlu <meted@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 405/451] s390/vtime: fix average steal time calculation
Date: Sun, 24 Mar 2024 19:11:21 -0400
Message-ID: <20240324231207.1351418-406-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Mete Durlu <meted@linux.ibm.com>

[ Upstream commit 367c50f78451d3bd7ad70bc5c89f9ba6dec46ca9 ]

Current average steal timer calculation produces volatile and inflated
values. The only user of this value is KVM so far and it uses that to
decide whether or not to yield the vCPU which is seeing steal time.
KVM compares average steal timer to a threshold and if the threshold
is past then it does not allow CPU polling and yields it to host, else
it keeps the CPU by polling.
Since KVM's steal time threshold is very low by default (%10) it most
likely is not effected much by the bloated average steal timer values
because the operating region is pretty small. However there might be
new users in the future who might rely on this number. Fix average
steal timer calculation by changing the formula from:

	avg_steal_timer = avg_steal_timer / 2 + steal_timer;

to the following:

	avg_steal_timer = (avg_steal_timer + steal_timer) / 2;

This ensures that avg_steal_timer is actually a naive average of steal
timer values. It now closely follows steal timer values but of course
in a smoother manner.

Fixes: 152e9b8676c6 ("s390/vtime: steal time exponential moving average")
Signed-off-by: Mete Durlu <meted@linux.ibm.com>
Acked-by: Heiko Carstens <hca@linux.ibm.com>
Acked-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/kernel/vtime.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kernel/vtime.c b/arch/s390/kernel/vtime.c
index 9436f3053b88c..003c926a0f4de 100644
--- a/arch/s390/kernel/vtime.c
+++ b/arch/s390/kernel/vtime.c
@@ -210,13 +210,13 @@ void vtime_flush(struct task_struct *tsk)
 		virt_timer_expire();
 
 	steal = S390_lowcore.steal_timer;
-	avg_steal = S390_lowcore.avg_steal_timer / 2;
+	avg_steal = S390_lowcore.avg_steal_timer;
 	if ((s64) steal > 0) {
 		S390_lowcore.steal_timer = 0;
 		account_steal_time(cputime_to_nsecs(steal));
 		avg_steal += steal;
 	}
-	S390_lowcore.avg_steal_timer = avg_steal;
+	S390_lowcore.avg_steal_timer = avg_steal / 2;
 }
 
 static u64 vtime_delta(void)
-- 
2.43.0


