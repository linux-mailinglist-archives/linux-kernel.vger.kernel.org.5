Return-Path: <linux-kernel+bounces-114510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69182888AC0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:29:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1931F28AE90
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E96A28CE52;
	Sun, 24 Mar 2024 23:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Owd3EN9P"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE83E1FB09B;
	Sun, 24 Mar 2024 23:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322131; cv=none; b=gTUo5lbThVUl+ybhKupm+1WBM0bxQ8aNgsoBgb/0GEBju5Up56g0nX3ng2PxmTzV/U8+ITJczd/+GBgxaKylv//14rxMJKigNNuDX1eptgFinExqiEwjlYGi8Y5L1vgSz0EWc625TS/AqFlfNFCvvEZCrvhzjSNZkMQA43gWjmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322131; c=relaxed/simple;
	bh=PIbXS+zC5U45dZ/GGdXY7KQF1oCGIlXFWmmhtPeE+aY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mMvlp7VhI2OZTRZN5omMWyr1CnrIx7ZjCDUIPboQANh2GydeWtNjXT7w92J6Iaoch38sbnEkdoQKk7ZfEWQZHa43HDaY26qnC5nfQXNmbmgrrLussss88i9iQjj0B3S65fAQPZRU3o/gaa84fWEwheOU4dnn65qcC+YdxnsSGYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Owd3EN9P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DCD7C433C7;
	Sun, 24 Mar 2024 23:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322130;
	bh=PIbXS+zC5U45dZ/GGdXY7KQF1oCGIlXFWmmhtPeE+aY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Owd3EN9PPVGtv8SiFLi+yYw5QCFN4oZE9o8qbrMvzx9vY5IVTbA4h/+0pzPJiKVI5
	 kdiLxsJ6oxueCv6LOiifGw8AZvvS5YRs/3+7IVoCaHVvgGFt11US/ZXkzJV8gHklWF
	 fjois6hpJJK2pAjONZLf2wsaLh4hmEMIG0XAyVRMQti+/6YjnV1lG6cS9D6qn2xSZA
	 c5RqxZ1jzCWeTaXnckrB+K9vm4+s7sF8UM2v6zMItH0qjuH7/CWnb84uPx6/zR95KY
	 u+JUOGLVve2efTseWibGFeHk2jeLF4vbg0IuAzhvmOrtEAmTKqqVnWYib20AXwwuwV
	 aCQ0KnWrr8OTw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Heiko Carstens <hca@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 207/451] s390/cache: prevent rebuild of shared_cpu_list
Date: Sun, 24 Mar 2024 19:08:03 -0400
Message-ID: <20240324231207.1351418-208-sashal@kernel.org>
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

From: Heiko Carstens <hca@linux.ibm.com>

[ Upstream commit cb0cd4ee11142339f2d47eef6db274290b7a482d ]

With commit 36bbc5b4ffab ("cacheinfo: Allow early detection and population
of cache attributes") the shared cpu list for each cache level higher than
L1 is rebuilt even if the list already has been set up.

This is caused by the removal of the cpumask_empty() check within
cache_shared_cpu_map_setup().

However architectures can enforce that the shared cpu list is not rebuilt
by simply setting cpu_map_populated of the per cpu cache info structure to
true, which is also the fix for this problem.

Before:
$ cat /sys/devices/system/cpu/cpu1/cache/index2/shared_cpu_list
0-7

After:
$ cat /sys/devices/system/cpu/cpu1/cache/index2/shared_cpu_list
1

Fixes: 36bbc5b4ffab ("cacheinfo: Allow early detection and population of cache attributes")
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/kernel/cache.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/s390/kernel/cache.c b/arch/s390/kernel/cache.c
index 7ee3651d00abe..732024ca005ad 100644
--- a/arch/s390/kernel/cache.c
+++ b/arch/s390/kernel/cache.c
@@ -166,5 +166,6 @@ int populate_cache_leaves(unsigned int cpu)
 			ci_leaf_init(this_leaf++, pvt, ctype, level, cpu);
 		}
 	}
+	this_cpu_ci->cpu_map_populated = true;
 	return 0;
 }
-- 
2.43.0


