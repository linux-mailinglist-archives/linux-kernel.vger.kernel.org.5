Return-Path: <linux-kernel+bounces-115574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69F76889C7A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:21:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23F362E449E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C34A91F2FED;
	Mon, 25 Mar 2024 02:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ieNdrLtt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F561F30B5;
	Sun, 24 Mar 2024 22:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321121; cv=none; b=sstXY0GKE+jmotb3ltRqIqo5FsjpR6sY28qon9MPteSUL9lshXD4hKw1br/I26/0CJXqTG/ptSx1uLpvIs0frrLsw6GOBl2irl7qNYn60EqIxhqlrjIMRkj54goL5lTxXKfGyLAcNPkCT6u6lIijWAz4+y74EYsVkDOWgvZNB2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321121; c=relaxed/simple;
	bh=sfT9wSuVWuPB4Vz7YsLj6pSlsKLmBKXhzCbIHB8bj9I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kC5oWaC8gmC298zatmLnp6huoTPfGAfmaIgD2ctdRMfx420Wn2nvyVE9wyh33EuDV8HQSAlif833OXp3JdqszN3pTq8X+CCsW/22qzxrzvCXb07L/YuRFPaMYfuxIEElLlPnBi7Dg869hx3qr/RP9IUqh5g5jde57YXp5zOogDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ieNdrLtt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AB42C43390;
	Sun, 24 Mar 2024 22:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321121;
	bh=sfT9wSuVWuPB4Vz7YsLj6pSlsKLmBKXhzCbIHB8bj9I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ieNdrLttv6t6BJX8Rnr197qKCOHPCaruZ4gKE6Wd0oUxs6i/6bn6u7i8WxR9Dbk0a
	 L9p0sbslzsMMNsZ6Rpl1vpQLJAOogX64VU+iNgi72SMA4jEbxJnhXqgxwG228ReG6w
	 yQunV+ftzjLVIxm/2JJomc7KwAdH8z9u/u5uIZlUV7jIOOOkPPzKDsUC1vrFEvoew6
	 VtQDvjiNSo98sDprv+UiPGqjohfYbo6+j3/1t+tDsmYjNPrKU+8NkzOudDvfSfIUEe
	 EZVrJeDY+HanAyXAsk7eLynlm7BMhxx5xtBky924Pl7R8+R0OyP2lVK9g7/9pbxe3J
	 UPwRcQCmk/NVw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Felix Maurer <fmaurer@redhat.com>,
	Shigeru Yoshida <syoshida@redhat.com>,
	Breno Leitao <leitao@debian.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 682/713] hsr: Handle failures in module init
Date: Sun, 24 Mar 2024 18:46:48 -0400
Message-ID: <20240324224720.1345309-683-sashal@kernel.org>
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


