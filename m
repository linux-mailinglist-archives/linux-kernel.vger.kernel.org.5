Return-Path: <linux-kernel+bounces-114460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A459D888A98
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:23:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55038286202
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC57C17AFB9;
	Sun, 24 Mar 2024 23:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dINekPUZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775E614262B;
	Sun, 24 Mar 2024 23:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321884; cv=none; b=g1cXYwLGVWCWbEFPmeIKVlB0OsjJ6//2aEI7XISvBS6a2FmESRJmGOJYoW59zmUzmfmbkO/OJ05hXV50cHTsfixDzcMFfLjVIxmYkPgMRKaACQGONqA5cD+kvUt4kf2WJJWDqYA2Gut4BYeVyav9dnbFXEeeuLF1fKEPFrgFlY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321884; c=relaxed/simple;
	bh=sfT9wSuVWuPB4Vz7YsLj6pSlsKLmBKXhzCbIHB8bj9I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g8I4UPev8DOSyF5C+/lOf7UoeA+JjtsCV6E1kPvxfJ/aLvkB2wJe433AzziqdG1tktggoNu31z57zOsVU3uOfB3SaMk7n3hOmP/VSKbt8djtO+PcSIFFiAwtwTur/FFWzbyBhtH0IqQ5GaicPtGiijwhjgdsFravtsShtHTT/WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dINekPUZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 835CBC43394;
	Sun, 24 Mar 2024 23:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321883;
	bh=sfT9wSuVWuPB4Vz7YsLj6pSlsKLmBKXhzCbIHB8bj9I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dINekPUZug2lM1uwVV+Bpqi86M1gWr0ghL83NEIi75OeCvJVBA689TPosUGvCzDKN
	 6r4iG6rVrezL6MLadsn0Dljc2hObsls8yI5sFrzpYhXNmnizqPvq2/r4hJRoz849T4
	 3aEm8OUFN2omhupHxiMYXF3CxOa1wcj1gzuoaIAOQR2IRb4hMtZzHqwDu25xk7PHo/
	 YUmzLQQInMWiOzeOnrlomeyHbTdGX5ouBhC8SrgZAq369txrV/rEdmqcWB3vMMkbxw
	 EOrbMqOLZ/0WFIjoNyjaI82QEcdBJuaghgqK0uT5EvLIHdzP3+MV8b/aeqX4VYDOcx
	 5cBSrDUnqZHlw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Felix Maurer <fmaurer@redhat.com>,
	Shigeru Yoshida <syoshida@redhat.com>,
	Breno Leitao <leitao@debian.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 611/638] hsr: Handle failures in module init
Date: Sun, 24 Mar 2024 19:00:48 -0400
Message-ID: <20240324230116.1348576-612-sashal@kernel.org>
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

From: Felix Maurer <fmaurer@redhat.com>

[ Upstream commit 3cf28cd492308e5f63ed00b29ea03ca016264376 ]

A failure during registration of the netdev notifier was not handled at
all. A failure during netlink initialization did not unregister the netdev
notifier.

Handle failures of netdev notifier registration and netlink initialization.
Both functions should only return negative values on failure and thereby
lead to the hsr module not being loaded.

Fixes: f421436a591d ("net/hsr: Add support for the High-availability Seamless Redundancy protocol (HSRv0)")
Signed-off-by: Felix Maurer <fmaurer@redhat.com>
Reviewed-by: Shigeru Yoshida <syoshida@redhat.com>
Reviewed-by: Breno Leitao <leitao@debian.org>
Link: https://lore.kernel.org/r/3ce097c15e3f7ace98fc7fd9bcbf299f092e63d1.1710504184.git.fmaurer@redhat.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/hsr/hsr_main.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/net/hsr/hsr_main.c b/net/hsr/hsr_main.c
index b099c31501509..257b50124cee5 100644
--- a/net/hsr/hsr_main.c
+++ b/net/hsr/hsr_main.c
@@ -148,14 +148,21 @@ static struct notifier_block hsr_nb = {
 
 static int __init hsr_init(void)
 {
-	int res;
+	int err;
 
 	BUILD_BUG_ON(sizeof(struct hsr_tag) != HSR_HLEN);
 
-	register_netdevice_notifier(&hsr_nb);
-	res = hsr_netlink_init();
+	err = register_netdevice_notifier(&hsr_nb);
+	if (err)
+		return err;
+
+	err = hsr_netlink_init();
+	if (err) {
+		unregister_netdevice_notifier(&hsr_nb);
+		return err;
+	}
 
-	return res;
+	return 0;
 }
 
 static void __exit hsr_exit(void)
-- 
2.43.0


