Return-Path: <linux-kernel+bounces-102046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D2FC87ADEA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:45:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0CD0EB23743
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3743415351C;
	Wed, 13 Mar 2024 16:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ctbh4Wle"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E52153509;
	Wed, 13 Mar 2024 16:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348426; cv=none; b=KSpFrvDeJ0aFckV7+cgYrxPxLL3ji08ZDkQyZaaaUqQevGD6wTi1oAksq33hr6j1jDQHv0j7D/aSWIyoqcMrdNn79Bj7rrv2vIYoi6DbnrVDSp14EiGuIIp62E/buZ8nD4ve9kWv8tm8qog1Zu/Ggfs6SD7txKfZ1G47z+nKq9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348426; c=relaxed/simple;
	bh=v1F9PhDK0oX3T92o4m74/kx58+E0UmC3jFyT+LVR/fs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BJEYJ9n6bDdr6twA6KfNDHDxs0oUGGa7IQlTC+FIHUgOZrCHnLrOgqjn6LFytXargIcYKLsvYSdvI/LUUWsccqQMn9jYm2xztU4ru6PEKamJ2lmcEKA7OU2ZCuwR7sPEn3KjZW1X/Iw5vQvxzc/mZc+b1eEGNB321t/PuLOEMTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ctbh4Wle; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C7C4C43390;
	Wed, 13 Mar 2024 16:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348426;
	bh=v1F9PhDK0oX3T92o4m74/kx58+E0UmC3jFyT+LVR/fs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ctbh4Wleh/ZsDhtrkD/wBVSlbXqDGCUXCkDZMLkaKnBBq/SAYJipljUL69Q7FV4OF
	 kG2QGTSTxfOvCzl0kc4HKhMoewIfGbGdbSMe3XLK7r40rXwwD0+2LZKLLFvxADm7PV
	 Urzj+K+xsRPbnEvMjg/c1p2xF+ksoS0ZbcsiDXFH7uNIeFeSQ55J0Xz3J54mWlXQMr
	 cW6xeqWQOIQy7zQmCE+ssbAhKtmWtTu+p2mZ9c37u4471PzsexLqtt0jNFgpQKymzy
	 mOw/0inckNq2fEC1D2t7gxrRJR/dJNzTtzsa09AICrM0Sk+7cyXQUN0XGKzEPsJkUD
	 461DdQKQ/WgBQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jason Xing <kernelxing@tencent.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 21/73] netrom: Fix a data-race around sysctl_netrom_transport_timeout
Date: Wed, 13 Mar 2024 12:45:48 -0400
Message-ID: <20240313164640.616049-22-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313164640.616049-1-sashal@kernel.org>
References: <20240313164640.616049-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.213-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.10.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.10.213-rc1
X-KernelTest-Deadline: 2024-03-15T16:46+00:00
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
index 24747163122bb..6857510967448 100644
--- a/net/netrom/af_netrom.c
+++ b/net/netrom/af_netrom.c
@@ -453,7 +453,7 @@ static int nr_create(struct net *net, struct socket *sock, int protocol,
 	nr_init_timers(sk);
 
 	nr->t1     =
-		msecs_to_jiffies(sysctl_netrom_transport_timeout);
+		msecs_to_jiffies(READ_ONCE(sysctl_netrom_transport_timeout));
 	nr->t2     =
 		msecs_to_jiffies(sysctl_netrom_transport_acknowledge_delay);
 	nr->n2     =
-- 
2.43.0


