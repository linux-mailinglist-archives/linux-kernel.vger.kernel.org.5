Return-Path: <linux-kernel+bounces-102136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3CAC87AEB7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:07:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FBF628539C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D29BC70CDF;
	Wed, 13 Mar 2024 17:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DwV/ZCTf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1320670CC9;
	Wed, 13 Mar 2024 17:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710349353; cv=none; b=F63Tfn/aHCEVKaoHauru+mOj2GLTtojAqh6+8Cx1W9mM/iUhQuffBUqk5ZrcsG77L7bT8ubqNHdyHzlTT8Vjtc41EX74PB11su92hpJvcoEVu3LR2pkmpbWKCrGaKVfkfNJChw5zvpCyZa2DW5E3n4v0cbw0s+wLlZyhD/EMWtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710349353; c=relaxed/simple;
	bh=gesTlMf+hpgzYhHRhX+5rwQzrtPlUJWHs+/R6s81rrE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IiIdZxr5qKu0U7wcFzmhGPN8IMrWqkm7ps7GKcgOn277W7O4n2PR/SLQqAGn3zCxWv4yzuuNVERpQ6gq8mNgxZYIyeoC/FIcox2of24X+nvhTxiO8t4wepu9WTtvn7qVlPOaDYlqFJBV854G+VPxDNKd4R8OycmqmG3MNiZa3ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DwV/ZCTf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA9BCC43390;
	Wed, 13 Mar 2024 17:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710349352;
	bh=gesTlMf+hpgzYhHRhX+5rwQzrtPlUJWHs+/R6s81rrE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DwV/ZCTfJlNQS3R/ree6HZhmN393OZrVneEcbJh5MwI5ssKdu9YIIUuBqYXkyGNGR
	 c4WB12TrgP1dmUWbprsvuPguptvf3L1Yzt9WaBvpau5Lf4PApstnFsaScheVSGzW7m
	 OKvocQ5Ii0jFqUr+DyzHe5oGJKIra443LqWTyhb8tvRDjyMfxGyci0JkA59xW/lrrp
	 oXkSDQ2nMZjsFt5ABbdfSlfvBVByShNHsmhIRktLq0MN6EPuquEk48hDH7MEdLEy0y
	 ZjXGn3L3cJz6yH6bg5DrPO8CE/DIceRQwUmzT35SOupQvostYKwuAckp71qXQBXIQ9
	 XbxuodiB6h5QQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jason Xing <kernelxing@tencent.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 16/51] netrom: Fix a data-race around sysctl_netrom_transport_timeout
Date: Wed, 13 Mar 2024 13:01:37 -0400
Message-ID: <20240313170212.616443-17-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313170212.616443-1-sashal@kernel.org>
References: <20240313170212.616443-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.272-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.4.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.4.272-rc1
X-KernelTest-Deadline: 2024-03-15T17:02+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

[ Upstream commit 60a7a152abd494ed4f69098cf0f322e6bb140612 ]

We need to protect the reader reading the sysctl value because the
value can be changed concurrently.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Jason Xing <kernelxing@tencent.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netrom/af_netrom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netrom/af_netrom.c b/net/netrom/af_netrom.c
index e18a73264c103..097f4f3b4929f 100644
--- a/net/netrom/af_netrom.c
+++ b/net/netrom/af_netrom.c
@@ -431,7 +431,7 @@ static int nr_create(struct net *net, struct socket *sock, int protocol,
 	nr_init_timers(sk);
 
 	nr->t1     =
-		msecs_to_jiffies(sysctl_netrom_transport_timeout);
+		msecs_to_jiffies(READ_ONCE(sysctl_netrom_transport_timeout));
 	nr->t2     =
 		msecs_to_jiffies(sysctl_netrom_transport_acknowledge_delay);
 	nr->n2     =
-- 
2.43.0


