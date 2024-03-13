Return-Path: <linux-kernel+bounces-101786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1E3287AB91
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:43:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93AEC1F22B86
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 16:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C781634FB;
	Wed, 13 Mar 2024 16:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FiU2Y/Iz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E6364CEE;
	Wed, 13 Mar 2024 16:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710347617; cv=none; b=NrHJtlhkM7TlotnHhZnKgI1Es7NBNPssGUjnKf8zwOmWGVRfdrghexkVk9/BhgOXTAj/iEjOX/854xZZzSZQ0CylhtY5EGHJewWTRKVZWpghVZEgmTRrnk1UbRj13yQJ1rvFHfOxHdNRiL6bvT+NVof8CvRucSa4tHLi3L3WJ6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710347617; c=relaxed/simple;
	bh=NqOLZfagkjSeywLR0oTnif/GWISGFpPkYFDlz7YamLc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uR7sDMZ1hX4YCyggsp5E/evFOQfcJzXfR3lqwhtdu0+Nm1Ip+R2Cu9RAAONKTC+VPVH06hM1s6cfzOHGeyABMY40sFm+ptg1G5UyqpAs3fhkAnoRRN7suNg04vzVJcgnnJ6IROVTGxcNGim1mQJvzGwiROVkkXkQO5cNmbnwgk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FiU2Y/Iz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54D96C433F1;
	Wed, 13 Mar 2024 16:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710347617;
	bh=NqOLZfagkjSeywLR0oTnif/GWISGFpPkYFDlz7YamLc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FiU2Y/IzWBNBMm+k/M91FHapmfx2ARdV2tQIudI5L3O3KO6CUwpPR9Nna/noMU7eD
	 jhJLbw+YuvCLDYk/fBhoG5QeT0imlbSqUSRXYoVnWtOLTycoqx3QA4Ef9bC3zeTri/
	 ON78jgQAO/U7VX7Hg7trWghy6v74ddP+iM90MM7FT7Jj/81LPtuecfqSr9Dmt1KPAL
	 yD/DeFBu2BwF58B/q7LwKNpAWHT98ZYHL14Zv5SE1vl7JB7SL5F2DTdUscAwEbAibu
	 AJDCfzRFzRqt4tsZs7rAerLzu/kB9afYfNpjaK786FN42B51AezQyE9M1Tt5UnmbWc
	 IdL8AmjlLRJVw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jason Xing <kernelxing@tencent.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 47/61] netrom: Fix a data-race around sysctl_netrom_transport_maximum_tries
Date: Wed, 13 Mar 2024 12:32:22 -0400
Message-ID: <20240313163236.613880-48-sashal@kernel.org>
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
index 4d0e0834d527b..312fc745db7ff 100644
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


