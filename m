Return-Path: <linux-kernel+bounces-101845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E8E887AC16
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:58:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E1601F25813
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 16:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 217E573186;
	Wed, 13 Mar 2024 16:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="korHunWV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5946660263;
	Wed, 13 Mar 2024 16:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710347881; cv=none; b=L1gKQP3EnFOETxThOgFbTFS2sg0YTRRthWX6AnvivEl8Lt2P/1FNKtGWiq7J5byvLgZejpaUsE7wQcSrS0x9A02RWLEDkTw9M8xVB5X2HhXRX73OKM1Ht5DW4wQKbAGVtWiCMYhbw9Jtz5Bq1gDcP5AdeNukf55fVzfDzsP37E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710347881; c=relaxed/simple;
	bh=ERDYrTAXbmn6vjBsFmmF9bbBTgTNgZvqT4eMG9TUEdU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HfLCm7AQjC2M76GqZLwP9lH1cnhxa8i25x/iEfeLW6zv1XMaffKHytOUm8oBnPkpbytRZFAwpzYgrEg12xy9+sJoDglpU5FRF2LXbL+SnF/KJjs0qDl8hsqaJ8qq5JgUHviN6+rwP9CiHz4f8hnw7tRpwVQDI0ZdbEm1DCKxScw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=korHunWV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69AD3C433C7;
	Wed, 13 Mar 2024 16:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710347881;
	bh=ERDYrTAXbmn6vjBsFmmF9bbBTgTNgZvqT4eMG9TUEdU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=korHunWVlnBsbAbUIhA65v364J8QDF5kdVtqErVZ8H21+kQrSd1sOHCom/d9wkWQr
	 qbkWI5TK96osMFyCjVebH+WRIVolTEYrzwZA9kt6+wR/qxcK7EhcYbcZ43RVgyCh/+
	 X3PXlCoX1NpFHMqLJZ4wgwqz03YQ2x0BqRSm1GnKTiIWkXS9p194E/XIAVP8H3uVOJ
	 X3Ga37FrNIPxcY9dLm8mDi1K8mNMZQmaFApmsGzF00Kp19RKnDTAFfR+T8eFYx8vkQ
	 fKsONpvFJUnmM0LRj2xnow0QyGegYfySQ93F2o26gaMmbzEZb+J6oaoeS6Gb8mjAEb
	 416FrSSwDSQlA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jason Xing <kernelxing@tencent.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 42/60] netrom: Fix a data-race around sysctl_netrom_transport_maximum_tries
Date: Wed, 13 Mar 2024 12:36:49 -0400
Message-ID: <20240313163707.615000-43-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313163707.615000-1-sashal@kernel.org>
References: <20240313163707.615000-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.22-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.6.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.6.22-rc1
X-KernelTest-Deadline: 2024-03-15T16:36+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

[ Upstream commit e799299aafed417cc1f32adccb2a0e5268b3f6d5 ]

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
index d8a25f614c500..a3b02f090bba2 100644
--- a/net/netrom/af_netrom.c
+++ b/net/netrom/af_netrom.c
@@ -457,7 +457,7 @@ static int nr_create(struct net *net, struct socket *sock, int protocol,
 	nr->t2     =
 		msecs_to_jiffies(sysctl_netrom_transport_acknowledge_delay);
 	nr->n2     =
-		msecs_to_jiffies(sysctl_netrom_transport_maximum_tries);
+		msecs_to_jiffies(READ_ONCE(sysctl_netrom_transport_maximum_tries));
 	nr->t4     =
 		msecs_to_jiffies(sysctl_netrom_transport_busy_delay);
 	nr->idle   =
-- 
2.43.0


