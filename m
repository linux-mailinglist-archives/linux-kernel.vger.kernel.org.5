Return-Path: <linux-kernel+bounces-113774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 564FB88868B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:35:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B2021F24FC9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74EB912DD8F;
	Sun, 24 Mar 2024 22:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="owHhWoPQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B6A1E307A;
	Sun, 24 Mar 2024 22:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320796; cv=none; b=fYOWyz5Bfm8flL2JdAbqOrPYNLtEHz33dDXToVuvZZUGESqQc31WmR+7eOpSzLfjAPI6J5Meoy8nESd/6OxghfUzhOaomi5EwneSm+trIxB/nR3ocySSpI1ehUdZkXpgjD4ld/4Dn05kcYKy+ov8fD/l2NxuIIrkexyBPgeT6aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320796; c=relaxed/simple;
	bh=1CZXj3ZSEJhTLO9kDaryueK7/Emi8Jki56hPONpCagg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cuFkdTSkizYl6YQAP4UXxQh1OQnNNfQsCEdShN45X0VYE0M20DRNeml5a5Y4RVgmxWm/EqFe2R56pePk1MbsJ+MIRO7ACpxamk9dpjjTduQ+CE6z0FgMYIsarnar5+dgGbEmt+znRUWiXyLiJNasvUIHxDtaL+S0hLQHDGXS14g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=owHhWoPQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB1A5C433C7;
	Sun, 24 Mar 2024 22:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320795;
	bh=1CZXj3ZSEJhTLO9kDaryueK7/Emi8Jki56hPONpCagg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=owHhWoPQI/AM4SRq5ki9OlWo1RfmwZI5X7i0M+aNahMpa4p+llUnY0FNuO413MF8V
	 4uW4Hm4hLiE1j1mZw8RptT3MGiDuh2QlUzWSIcUXdaVoE3XBWlsZoKML0rbPLu7/ie
	 33Sw6PFR72UrFOOJjCE4nQqK6ubqGZZ5bhkrkNkXOlHfSK6pMAdav+lwX8BznW3OkE
	 lzOm18Di2zbLY6AGi1GH2pesSPu7AIL8AXfzbUhlhmjn6HrnpfsXxjF8Fvc570ElXG
	 zVs2ybldZywlZOoTJ9/90PK0tl6fQ3vsMsMcnRsv1P3bKgpE6D6qSUtJ/qgHf6SZqZ
	 x/1uRf8c+Yq+g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Heiko Carstens <hca@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 359/713] s390/cache: prevent rebuild of shared_cpu_list
Date: Sun, 24 Mar 2024 18:41:25 -0400
Message-ID: <20240324224720.1345309-360-sashal@kernel.org>
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
index 56254fa06f990..4f26690302209 100644
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


