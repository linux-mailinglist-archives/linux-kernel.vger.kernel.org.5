Return-Path: <linux-kernel+bounces-114693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F29BF888BC2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:59:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6C471F280C8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 259F718C9DB;
	Mon, 25 Mar 2024 00:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nV8SMh8h"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1BA15F40D;
	Sun, 24 Mar 2024 23:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322343; cv=none; b=oJNeliwD7oyZ+Mp7MqjQIehcTmL8wyb5TtHXYeuwxHm2Hu620X92er0NvgVl5CZc0QtCekakqVMaXtFgxfqEKou8nLPQ+eZVp6tG8ppD0BZIz3P5ufwpohWFbs8sYpKA0rFsqA7gDmmMIT8E0jJT5x6J/jEDE1GVQQDQDaUCt6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322343; c=relaxed/simple;
	bh=sfT9wSuVWuPB4Vz7YsLj6pSlsKLmBKXhzCbIHB8bj9I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kx9KfrDbvdsFvN+23Mot2EPpKQWru6B9yiT78+oZfREUrjjuhGyUkFXJqfcOGodB8vN2dqTjv1FlRZRJns7/o9I1Eu5rUMYiHVJD7fvPIVDbHaTnMnKjTDRLU1w1dq7yCvExodzp7C1pAoGjz11gRFz1DXYGdHsQBFK5w5VIUjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nV8SMh8h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A791CC433C7;
	Sun, 24 Mar 2024 23:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322341;
	bh=sfT9wSuVWuPB4Vz7YsLj6pSlsKLmBKXhzCbIHB8bj9I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nV8SMh8hKHsrJxFSt2QAb4xx+nKApcduYz5ck2dwWO7bz6Z34KYyD2JzEuHJT0prr
	 6s9sukzTKQNclAHufk49y5xZrdXzb+6q3S9Xjc8cRE+Z7947150uErU5VltlKXGyPo
	 sQxT5A6dW/g3EvK/zFYHUsLTTb2PkL0IxxKQ9bruWIsRlB7NPA3OVRLJwsmOFtJt0s
	 kaSAbjMeFj5A3uy6AbXoVS9SkEI2wPvEVFwAVbgRTxDyBC9d7Kmfeul2Ayxh8xbXJ4
	 G+5yFqkMH/ZUnmnv1bXXz/QQGdCMlzIJ85w5z8KMUtBaW9oeMNs44qShUUR+M4uJLV
	 h692cVUqmDrrg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Felix Maurer <fmaurer@redhat.com>,
	Shigeru Yoshida <syoshida@redhat.com>,
	Breno Leitao <leitao@debian.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 423/451] hsr: Handle failures in module init
Date: Sun, 24 Mar 2024 19:11:39 -0400
Message-ID: <20240324231207.1351418-424-sashal@kernel.org>
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


