Return-Path: <linux-kernel+bounces-114914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DA45F888C45
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:14:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8CD64B24090
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E4002D4F31;
	Mon, 25 Mar 2024 00:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ONsaFkxF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54631791EE;
	Sun, 24 Mar 2024 23:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323584; cv=none; b=gEzZJhjMyeyVoXtvH4lWyqZsa84qYIn2EZt3H6ZZVRUO+7bNXQgcTWXe7TthIxnfVXFDzi4D2I94coSTMrWEoLmEmMzaS7fbE1UMtMInbMeNg0jOVdN6mO5JljbL0JNjolq5Z1b5QQpMJuEjCBRLUwM8PCfXFgtLmZG3xgPOIKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323584; c=relaxed/simple;
	bh=B+XH0Q8cQ8IRj9cWuauv4e/6nwzU2iYes19X+eo81GE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nicNxSf2MiEFsl+AZoPxj/o8uqX08LB793Y8Vs8NrcTYGfuMwR/t2YV77u8RUH+c47F9tDHzzbLKvpdMafqGo9NBdG0e9FJfWY+H14Uld4CwK5LMD/LQu82uZJ7zT+E4ekBl1GjIXXAoJkW756GGRpc4hYztlI6+alegjHNoZ1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ONsaFkxF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 189DAC43390;
	Sun, 24 Mar 2024 23:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323583;
	bh=B+XH0Q8cQ8IRj9cWuauv4e/6nwzU2iYes19X+eo81GE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ONsaFkxFvr3iGDJlxEgkKqwEHYiaypMbbA3YA+PVss8+We9I3aWfYDjXHzXdIRPsu
	 eYNu78QT8RkPquG8IoHl4um+wNQhvEvgW7IR5xNFg+yfDhCV3P/fgyJHm/d41tSNXP
	 N9kZCp5cPYK4p9Kw/rEwBnKSdoo/0xulMY3FglZ1U4GyuVTr0c17qRKglNDfo6t24/
	 81/WuKT//QN+O3sVXeydT8uwQ9Hyt5uTWbUUITwShS5SQuSsJ1+3a8/6lBgiBQoCo4
	 tiGbhg3DWj+QTHHNpVqk61R+fO5oKdTGdYsP0B2kjxChnU+YMYJjIpfmxtmFgGWNm8
	 umK4dgtEY7Ctw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mete Durlu <meted@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 290/317] s390/vtime: fix average steal time calculation
Date: Sun, 24 Mar 2024 19:34:30 -0400
Message-ID: <20240324233458.1352854-291-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
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
index f216a1b2f8257..86137029235ac 100644
--- a/arch/s390/kernel/vtime.c
+++ b/arch/s390/kernel/vtime.c
@@ -211,13 +211,13 @@ void vtime_flush(struct task_struct *tsk)
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


