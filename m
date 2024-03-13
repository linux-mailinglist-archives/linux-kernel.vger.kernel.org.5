Return-Path: <linux-kernel+bounces-101961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BDE887AD1C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:26:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B34341C2121F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCD6F13E7CF;
	Wed, 13 Mar 2024 16:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ro7x6/Os"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E1413D30D;
	Wed, 13 Mar 2024 16:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348170; cv=none; b=bfH6SXm0cB7ECHY7XXmb5DNHESc/xouMdTXxZ1E1WuwrvoxnvFN4qfF4u0MSbRb9biG8ZlhdYlvigLQGymnCzWXWWo+g6nP2AX81L03Az4XecMBMHKxmFT5FqT4Q/sJS/stYPUlBlF1JRpirIBVrupNGr9Ea1/ajk1dY2INrJhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348170; c=relaxed/simple;
	bh=67liw3T/StQ4cXBr9axLBR840ACqH5dgsHUqaBCJwWg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CjCmlGLwEJC5eQPANMfw6KLEG1KIJBno/k+0suAh8DZMAatBOpivrjlJAHLBBEWz0+WmUpX1iuhD28tsb3wXl0Zi6z7bI0+vInNNaOTtCGrrqMZrwHEpWxv7WdASrUhtqY2dMBAoFO+HJUx+G8kpPAx2aULzfHbzqnmN1ZiYSq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ro7x6/Os; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D4A9C433C7;
	Wed, 13 Mar 2024 16:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348170;
	bh=67liw3T/StQ4cXBr9axLBR840ACqH5dgsHUqaBCJwWg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ro7x6/OsWSIq+nrlafX+VJbbLrbi67cH4Xqu0b9mRoermmf4DolJbdFlRzyENU0ZX
	 2F6u3IbIQjXT4nx4TGBWIYhHHl4Ac7zXKf0L6jg5I+eN/Op3SE/IRmsAP3oXLFDimX
	 vlQaSz1rfG4TXgVIqjJn3H+03polxDFEAh2aSLMRCB7+F/AjkR5xpZnn/89yQLFzBK
	 CCQxBkzOnBe8m3zFqNWHD2TU9pIjzyKXTnf2dxi8WzYy0CsSEfih0H1hLCznZSDS5t
	 w9ulrmwDUwBLuYQYBQF7OTzcL2ybKkpw4zf2WPVO6+t/EZXgrhS0+TF6NRaWDUTLfC
	 w1f0x5crzunww==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jason Xing <kernelxing@tencent.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 21/76] netrom: Fix a data-race around sysctl_netrom_transport_acknowledge_delay
Date: Wed, 13 Mar 2024 12:41:28 -0400
Message-ID: <20240313164223.615640-22-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313164223.615640-1-sashal@kernel.org>
References: <20240313164223.615640-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.152-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.15.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.15.152-rc1
X-KernelTest-Deadline: 2024-03-15T16:42+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

[ Upstream commit 806f462ba9029d41aadf8ec93f2f99c5305deada ]

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
index 678a7bbd84bf2..5a5cca18ae0c6 100644
--- a/net/netrom/af_netrom.c
+++ b/net/netrom/af_netrom.c
@@ -455,7 +455,7 @@ static int nr_create(struct net *net, struct socket *sock, int protocol,
 	nr->t1     =
 		msecs_to_jiffies(READ_ONCE(sysctl_netrom_transport_timeout));
 	nr->t2     =
-		msecs_to_jiffies(sysctl_netrom_transport_acknowledge_delay);
+		msecs_to_jiffies(READ_ONCE(sysctl_netrom_transport_acknowledge_delay));
 	nr->n2     =
 		msecs_to_jiffies(READ_ONCE(sysctl_netrom_transport_maximum_tries));
 	nr->t4     =
-- 
2.43.0


