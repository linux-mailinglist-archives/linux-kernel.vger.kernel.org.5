Return-Path: <linux-kernel+bounces-116297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20D70889E0D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:00:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5266F1C33EFD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 318A9184EF6;
	Mon, 25 Mar 2024 03:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VMQcgUF1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8DD2182EE6;
	Sun, 24 Mar 2024 23:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324180; cv=none; b=jo6A4Gnc9Yb5nO2nwZA1oT0ZEg5lst4vBVEFbL536jyapGVsYadHlp3vPOZyn268BbOHSwlRTyk7/YbvieA0IbgOVvTl4VN4VZHUBlWY40ZHnvFaKwoWeSiZ1Rt6Wne4sQZ9BXuWWRzNOg26l/bP5jNf7LJzk975unmY/Ti3Sgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324180; c=relaxed/simple;
	bh=H9+Z6tw0a54j3G9lSJGWtJ0NwwhnT4Y44Yjt7W6ADWY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D5MnaidaIB3RrOCzu0lTbxnAy7iElC/cscVI3tAcJRgddR7m61+hHyFh2eBA5uzCaqdPRC4MrWuh2e0/Kb8hTS9qiycBRjJfU+nzBqIN8/2H+81RGcApaqeQkEHjWo5huTYE+tkEdGP14v5ABsrOXyx2O1ohczi2CdCZhBMV1fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VMQcgUF1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2289C433A6;
	Sun, 24 Mar 2024 23:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324179;
	bh=H9+Z6tw0a54j3G9lSJGWtJ0NwwhnT4Y44Yjt7W6ADWY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VMQcgUF13J6Ld3XiCrZcGwuWeC7ie8YqAl/beuHRfeYrmE0E2vPpMRYDY9pMkx8p3
	 HtaqKpuk2P9VCuBFGP4hTCRSazhQE2dDQMdJr1tWv4JE2kfiNeligBZP5712/u/XU4
	 F8MBpSuKS+jRsg/ynKZeIo2kUbVhuxR1rU+KcAIinD1m5NCZBtOq2unSyQKuSwMeVY
	 zXEwOFCxfNHwXpH3yIm98O6YtiwM7WswrP9QW5Ufv9bIaw0682z6liQ7MPUMohs57G
	 JgqRB/YcwihmA18+sXMGaNJ+Dr5TvDPNoz/5NDmwn/QgZm5Bn8oYcS3JTtkFYqTDb6
	 7ZUHUBsS40stA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mete Durlu <meted@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 170/183] s390/vtime: fix average steal time calculation
Date: Sun, 24 Mar 2024 19:46:23 -0400
Message-ID: <20240324234638.1355609-171-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234638.1355609-1-sashal@kernel.org>
References: <20240324234638.1355609-1-sashal@kernel.org>
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
index 6e60cc2443b2e..2c99de1cc92cb 100644
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


