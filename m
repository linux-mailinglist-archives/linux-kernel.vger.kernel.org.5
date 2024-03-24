Return-Path: <linux-kernel+bounces-114438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DA9C888A7C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:19:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AED951C28C8E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80E0027DDF5;
	Sun, 24 Mar 2024 23:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MwDNbsnR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D72156247;
	Sun, 24 Mar 2024 23:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321856; cv=none; b=IsuVJI+lGu3lVwPtbweGNMHA0Ccq1tr+8S3H3O0OFMX2LOEqNCuP+kiEL22In/LytyS4R4S351wOKgNZpjZDyhYpCzp8q77barw44+/t5IlVhWnLHXg+6QOqBEO4d50xhFTSAjmCifIyuvvKkh/7BktRwOlj6JACPC/BkdZBiJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321856; c=relaxed/simple;
	bh=pIMAx/5guFWCXZz7a5DmmTIE8rbWEEKno25pg9I15Mo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uZVRqqyUprEuK8LWPeaDDh2bazDLzl2mF6HNghZufREaV4kH+reKPfcGgHthj4DnvGyFZAU/LpNIY51/v3KwRz9rhS7bQ6KChuEGzLR1prH7x0G6iyrqkD/t96I3q+jYkbH2F3rbmUf9SIqRjQQTViUKwDx7kGWrQbmtuL5lMqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MwDNbsnR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05DB2C433C7;
	Sun, 24 Mar 2024 23:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321855;
	bh=pIMAx/5guFWCXZz7a5DmmTIE8rbWEEKno25pg9I15Mo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MwDNbsnRpOPLVvR0orHGev8FR5kAvqRpLQzs2p1rmFvr3ZlQLIC0+C9RphxSU43k6
	 6X4henKt8NbgbVW8FQZfhleRiviMENSNMyw+jvnDHXjYVfF/cWdOKbT+CJuBdbA7A3
	 /E8rInHpahRA+DWcLuUUqZB/sgs3OAcA2196L5NTkQY0OB8huLmfXmFhnTia452FpZ
	 vEcAY00+cPXrZNRM9YTBfjYnP+NG4US/djrDXO6Us1ffB6U02e0lg7chzUlkQpkKW2
	 c0sldj0nQ7Z/PhP/PyPFkwXMnD9lhPOKW37IJ65+7OsJnLRlwKbOly+/U5xWylEl5+
	 C30+qjd4BYLwg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mete Durlu <meted@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 584/638] s390/vtime: fix average steal time calculation
Date: Sun, 24 Mar 2024 19:00:21 -0400
Message-ID: <20240324230116.1348576-585-sashal@kernel.org>
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


