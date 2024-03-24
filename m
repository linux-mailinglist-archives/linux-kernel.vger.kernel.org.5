Return-Path: <linux-kernel+bounces-116215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91C52889FCF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:40:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F3B1BA11C0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DDD43BD1E5;
	Mon, 25 Mar 2024 03:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XZmug1Yh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CBF517DC1B;
	Sun, 24 Mar 2024 23:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323843; cv=none; b=tjephUuUNGcdVnlq/xIdJN7Ka/7Xg70nSzO4wQM35jX40Af22nVpVLXqhR91EZGyrkdHRazbaCw2DZl3F+Qu8O8ADFxM0X72S0lmIIZJH2uTUAFcfBhETe6vlWVcv1xzzgjJZ8lJ10isWqa2afFwor7oVFuukZEQ1RMdjzWI410=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323843; c=relaxed/simple;
	bh=W0aSp3rIAkXDSRRDV929dU0asFR/emNu7jE6ME/72Rg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OCNoB1mljkFlIPf1aVC+ZwvupRhYmNpNluonKp9IV3ehTRHbAOEubMK1T2eJ83lUdTe/hOPAyGEkqjFADhao4eW5JZLfUuZ6HTjlmqzgbl1I3WprrhJztBOafxrJI20lA7JhJibpLq+TuCicRtj1Qe27yyCvCoTMuv9CrwSMoPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XZmug1Yh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83286C433C7;
	Sun, 24 Mar 2024 23:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323842;
	bh=W0aSp3rIAkXDSRRDV929dU0asFR/emNu7jE6ME/72Rg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XZmug1YheXygnwAz2OCGJhBVsG6JEht3hNAT2MGfnXU97vS8lPJLuXjLecn6TODFz
	 wpr6/Y5V0YO9RIg5hU9LRdGGZ105sIweBzwPQexk1Y1h/1hCYba+vufUQNgDkJtJAr
	 JOimnxoUNdGxGZS4dU7jh0k4Qs4LyZdCCep3uEgRRKQh2G/DHRzrPYYLQDEqhozx68
	 HidtzHs8mCT152HTUynC1ZoTA9PKYZI2IA3D9qSjF8D1lrNynB39aTLxvcVujiCrey
	 ExpNt4w79sLmqZMwnSr0Xc1HEQFgbTfaHaqnbEZgW+XHE16kZ3HYcrIwjwYr0nKakp
	 ri7I4ip/78Uyw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mete Durlu <meted@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 220/238] s390/vtime: fix average steal time calculation
Date: Sun, 24 Mar 2024 19:40:08 -0400
Message-ID: <20240324234027.1354210-221-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234027.1354210-1-sashal@kernel.org>
References: <20240324234027.1354210-1-sashal@kernel.org>
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
index 579ec3a8c816f..bd65ff88c5baa 100644
--- a/arch/s390/kernel/vtime.c
+++ b/arch/s390/kernel/vtime.c
@@ -214,13 +214,13 @@ void vtime_flush(struct task_struct *tsk)
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
 
 /*
-- 
2.43.0


