Return-Path: <linux-kernel+bounces-101784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9570387AB8D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:43:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50CF028751A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 16:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 245FD634F9;
	Wed, 13 Mar 2024 16:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M+uxJjvP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9EC50A9D;
	Wed, 13 Mar 2024 16:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710347613; cv=none; b=VFpxmlgmky+4QFmJttJNLEIw8eO56xfGWgVE3QnHfVK+tvK0gwXLaWwYmqoPoPEHvKqMQ/tch8k1gHOYeKNpWIztdVEfaitzk/k16OR+3DmzK+6gQVIlgZvG8suQeQd7NufuRQRuRz8s3wbD2rRxQHN1ExITkoQu7GIFRlCeO7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710347613; c=relaxed/simple;
	bh=zoz/s8A/E4JPfDEwpZXOOhtjTptdKp3RunG4UOVpAz4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W6osC2k4D48m8e4FVsmb5O45oQOWwxMj5g2zz49pmuXqJZyOUwkufjCfKvnb0v5Xg0sjxVbIHbLz4sJ+F3iC7HiNOGA0vrhCs+Zo6cocblXI7cLmi8CpJzmfXE34tgfODXlKOyf4+rp+21nfYczid/dRc3uJiol92SPmPvg/xjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M+uxJjvP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37337C43390;
	Wed, 13 Mar 2024 16:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710347611;
	bh=zoz/s8A/E4JPfDEwpZXOOhtjTptdKp3RunG4UOVpAz4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M+uxJjvPdsRclDSZxPziqehG0cEMIMfnXgGNRR3W7y+EHclQZoWOzROt611hBgZvq
	 HHW/h2FBA+32wm9ZxvDFzrUGV0UB6FdReyZERZA8pqvMwKEB9ccFK68RfEpt9a0ITZ
	 lfGItMQ9n3qRS6OHJ4XGKyEYHfAhc6UAIKfp8BuFX//awZS1wSuZ6F35qkvlTMJtx9
	 NbD/t45v6QEbcKzUfjDUvfUscHk30uI+N84N3BL9btxQls3I5XCgLt/60rgQ5jg9c0
	 0hHPObF1RKV/Ia0XXHtytoXCdm5rGrBeQspxev3oTr1qzQfcekQvp620msZApLrkFC
	 7dh+85sKQizDg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jason Xing <kernelxing@tencent.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 44/61] netrom: Fix a data-race around sysctl_netrom_obsolescence_count_initialiser
Date: Wed, 13 Mar 2024 12:32:19 -0400
Message-ID: <20240313163236.613880-45-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313163236.613880-1-sashal@kernel.org>
References: <20240313163236.613880-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.7.10-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.7.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.7.10-rc1
X-KernelTest-Deadline: 2024-03-15T16:32+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

[ Upstream commit cfd9f4a740f772298308b2e6070d2c744fb5cf79 ]

We need to protect the reader reading the sysctl value
because the value can be changed concurrently.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Jason Xing <kernelxing@tencent.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netrom/nr_route.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netrom/nr_route.c b/net/netrom/nr_route.c
index 6f709fdffc11f..b8ddd8048f352 100644
--- a/net/netrom/nr_route.c
+++ b/net/netrom/nr_route.c
@@ -766,7 +766,7 @@ int nr_route_frame(struct sk_buff *skb, ax25_cb *ax25)
 	if (ax25 != NULL) {
 		ret = nr_add_node(nr_src, "", &ax25->dest_addr, ax25->digipeat,
 				  ax25->ax25_dev->dev, 0,
-				  sysctl_netrom_obsolescence_count_initialiser);
+				  READ_ONCE(sysctl_netrom_obsolescence_count_initialiser));
 		if (ret)
 			return ret;
 	}
-- 
2.43.0


