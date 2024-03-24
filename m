Return-Path: <linux-kernel+bounces-114237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 42FF5888954
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:50:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9BC3B26DF5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3957E254F8C;
	Sun, 24 Mar 2024 23:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nBLdSo3+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7A012AAC2;
	Sun, 24 Mar 2024 23:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321586; cv=none; b=m3H4oCQWQUFPpo/+xljx6Pvs2cvGsotiCJFkzhVUp4rGgguNIjm5IdMlhLk1O5aEWPARCJ3VQILLUM4nHmAvOo/oXewm1JEBxst/EUbHc98f6ZbWkH8Gh7kiqlmk7/IsZqsEFVywDFK2D89W4XjhHT0oAesdcoBwtcSpflO4eMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321586; c=relaxed/simple;
	bh=1CZXj3ZSEJhTLO9kDaryueK7/Emi8Jki56hPONpCagg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=in5hYDJW+Ilc4/dBhbWAnj1LQ7c3BHsvco81S3xC754RJxVvhJGtBaVG84CFzQ4K4Lz/knyneWDRJQ1broXGozh9rytwHzWY/IczINMPD8IByO2Objmgze4ezHZe5HteXoldB2h9xKnDPlyd6hZwoiz+MM5gtRnOq5cwvARS85c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nBLdSo3+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C58E4C43390;
	Sun, 24 Mar 2024 23:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321585;
	bh=1CZXj3ZSEJhTLO9kDaryueK7/Emi8Jki56hPONpCagg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nBLdSo3+JCYli9ujmnamYMMaO9Husap0rW7OWYe/lpkLAbLE69sd6vWaXfkbZGNat
	 UYUGlgr3BuG8wVdmmB/44MuX6rzztUKBKB7q/jyA526MTsSG3qkpneb9Ew0WVkhgiT
	 s+o8XW1DR8R49bPO8QZezFufRJvdhakVdXiWhip5RlX5P/pPKfM9YWvw0wRdJUlUHH
	 ZUiynkubb252wKnx9xIkBWdWiJ7qJZLJWgzlTQkGsKRIvQwPx0B8hDE/ZYheyQp2j7
	 kNk77SYS13X9HGrlH3XbxHLzMY7KqbT0c7kdEMT7HXN7+IrAGtwsJaUZrL6WPlTdw7
	 FQffhN2nAVtxA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Heiko Carstens <hca@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 315/638] s390/cache: prevent rebuild of shared_cpu_list
Date: Sun, 24 Mar 2024 18:55:52 -0400
Message-ID: <20240324230116.1348576-316-sashal@kernel.org>
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


