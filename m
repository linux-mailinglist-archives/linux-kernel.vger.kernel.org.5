Return-Path: <linux-kernel+bounces-113209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E4A888254
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:45:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48C7E1C227DD
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 093BF17E3DF;
	Sun, 24 Mar 2024 22:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XVFlCH4J"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1E217E3BE;
	Sun, 24 Mar 2024 22:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320011; cv=none; b=LS5ISOLmWi7oABxEAf6Fk+7eVWqO+JJ7SWkW21JUtm+S95LCLQJy3ET7K4GeU63NJ9ZWm3mwDso0u6NKbuEm8q96YPMHsE/a8bVN4GLvl0Hi++5moK2vJhOgx8JtLce123hXdMBtSoD6Dvz6fBK+lcRB+YJUHBucG9oPxPqr2Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320011; c=relaxed/simple;
	bh=1CZXj3ZSEJhTLO9kDaryueK7/Emi8Jki56hPONpCagg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qoXzi2Iy+lMLLC1hPLvVWxyuWfxOiCHWesbPo8qpzo90+0EZc7YhgC0H36tk+Nfnj4zXeQc0nJtbWZhZDW3TKxEZMBR0S92hvJsprJchezhQRkM965KHZzPpJyWFOHvL2n++IE0rKj+3V5tOGP9V9wiu+RfF4fyoO4XSaH4eZVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XVFlCH4J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22C1CC43399;
	Sun, 24 Mar 2024 22:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320010;
	bh=1CZXj3ZSEJhTLO9kDaryueK7/Emi8Jki56hPONpCagg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XVFlCH4JYFzjCzR8uV83P8aJuqM5HdhIOdDdn59rBK8xyui/rROnN90YErKwvUMZJ
	 EPeORa0bXRBGMFTrDm57Wqzut4OxUQX51dQw0NLf1iZ0a8aq27qKnT7EyVRobd9fJW
	 QRR1yXiidrv4tNI4uvDDJOpR1CgU0v/3BPasfSTOzrg2Vr4Avc4DV+5pa6yP2Rp1az
	 iACtpE8ktKfWDqJScllXdaBFq7Zct3Av0vqp9dbFwmRndO9WMEZk78qEQJSmcaOBR8
	 sbmR+YW83Fo7YL8vkFLG6ZRpAH0k5+quVZKhspc396S9yXjIxSUHlbdsc1N451WasY
	 qRiDzgLUgaKxw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Heiko Carstens <hca@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 318/715] s390/cache: prevent rebuild of shared_cpu_list
Date: Sun, 24 Mar 2024 18:28:17 -0400
Message-ID: <20240324223455.1342824-319-sashal@kernel.org>
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


