Return-Path: <linux-kernel+bounces-115560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23F73889C60
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:18:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D151F28A976
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 589BD2A4938;
	Mon, 25 Mar 2024 02:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="exXZorgK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968DA1F1AE5;
	Sun, 24 Mar 2024 22:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321085; cv=none; b=LXo4uJdLQ2ApkmAy3Jc6nP4km9MALo42m8sTLmTirgqKl4zIfOo9ohuQK7SEKcGQOdp13yiHydhro8cJpmmTgw2ot4ui6il8bX9DLrcaqmkisebiYIOElLXrqCPhccX1F27Vkn4wBAHUF+Bvctj1M1beDk/jWBLYGP6iOWa15Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321085; c=relaxed/simple;
	bh=pIMAx/5guFWCXZz7a5DmmTIE8rbWEEKno25pg9I15Mo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uai0CrcIz+ZlNe7sBx3ZvOdvdhf99556s3llfk7oULPp3pb0wELKbYE7uVPhtqdsPMzdtOIzNBDadPfPyOdTcwSMWJxmdEzZi/cP1VW+qNNcZycSJYLLbTYcVo7X1OThqHYh5OJfAJIViRCXuJmw0JbKPM29ITvpyJBvEjFE1Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=exXZorgK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA629C43394;
	Sun, 24 Mar 2024 22:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321085;
	bh=pIMAx/5guFWCXZz7a5DmmTIE8rbWEEKno25pg9I15Mo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=exXZorgKhtOFdh5rlX1Ds6wM+LZVCBnvfll7SdhBldW/wEbdFhrpZnMk+xtsy3IVY
	 AsEOfBOIQcqiSRgJDb7pCdJRCiHdGCZGFJye7G0InaQibEyY4+AQXQSh6zhhGWkq00
	 VEsI0dLbBFiXtVd6DtQxs7NeddoSGW+w7eo0Y+RW4wT25ny4ZI2G9Chii3PFWsUScB
	 n41vDC4GwZBRQicVrb2QKxmf1QSdK5Guh/3zJ9oWpE/bQMq/mYlFzCPdB8z6troCAz
	 WKHEX1aOkPI5h4LB8/Bxo30IEnskjAbm0iuVbrXLGM4UOUML1+Jv8Hwq/Z8hD1fpCK
	 3gx5fbruVeUkw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mete Durlu <meted@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 649/713] s390/vtime: fix average steal time calculation
Date: Sun, 24 Mar 2024 18:46:15 -0400
Message-ID: <20240324224720.1345309-650-sashal@kernel.org>
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
index e0a88dcaf5cb7..24a18e5ef6e8e 100644
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


