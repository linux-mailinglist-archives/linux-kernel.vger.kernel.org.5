Return-Path: <linux-kernel+bounces-102082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A20187AE3F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:53:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0603CB24755
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11FE415E5B9;
	Wed, 13 Mar 2024 16:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kn4zTSJy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36632160872;
	Wed, 13 Mar 2024 16:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348465; cv=none; b=HlePAOApzmEX/5z9pEScjIRHZN/ie3NPsoaM5am+2ZZ7QVavKxII5GrrWpyQXCphKUuZ7hrG7Oo6wqrtvEiRG9H79Q17krb0FkliBeZQeAcNv/v1Py63mtYAe1f2pYVRQo7Tm9IJ5HnDcDtGvnuUnjcGL//N+PAnSOTozamIIPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348465; c=relaxed/simple;
	bh=XkzCCer+yg7bRJIGIcsOqFfJw8qAfM9xMxSRoTXkuSU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PQxi3ODERdgaqAPRYACz9aEj6GftMpTrTm/1bYAvBSPmIC+YNK0fIjURiD42zDhGhJoqnk3clj5N7sxcB+LZy6JCxjnnfI5Lnzujp5n86jS9vtwlMDBNGAFun9RklfkoVp6IYAp3imJO0cgdwDrY5kDM0GBQMtbHdjgl5aKdN18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kn4zTSJy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E719DC433C7;
	Wed, 13 Mar 2024 16:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348464;
	bh=XkzCCer+yg7bRJIGIcsOqFfJw8qAfM9xMxSRoTXkuSU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kn4zTSJykKjiAdyMMVysD135je5a+5S7/NVX787AAT0X2w+iLh40gRfJWluxm2fSg
	 YlpAIbth22/Z/2196oKXbeLHeDdAoaKI7u2qJ5m5/7AqmGk35eiQ8Ro/u6lDeWLVq1
	 hIT3bJKQK30HRMwo0HnMBWTPxn/y3fSUwsIsZBaHs5Yg1VQdwgNJX7LvhmEtNKN/iS
	 W4yg5iiFOsxVZ7KuEBp0cThRQTkvZpOSENqVXJJGudrbt8fRNmXbH9R2znoMSOqCRW
	 M3PPb6fvMzalAdZ72RMSQp3uK4pWYASfY3z6Vpxc2JhuWjBnGVK9wSBrmiGi82Vbsq
	 kHk7zjSrfQ1wg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Juhee Kang <claudiajkang@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 56/73] hv_netvsc: use netif_is_bond_master() instead of open code
Date: Wed, 13 Mar 2024 12:46:23 -0400
Message-ID: <20240313164640.616049-57-sashal@kernel.org>
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

From: Juhee Kang <claudiajkang@gmail.com>

[ Upstream commit c60882a4566a0a62dc3a40c85131103aad83dcb3 ]

Use netif_is_bond_master() function instead of open code, which is
((event_dev->priv_flags & IFF_BONDING) && (event_dev->flags & IFF_MASTER)).
This patch doesn't change logic.

Signed-off-by: Juhee Kang <claudiajkang@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Stable-dep-of: 9cae43da9867 ("hv_netvsc: Register VF in netvsc_probe if NET_DEVICE_REGISTER missed")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/hyperv/netvsc_drv.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_drv.c
index 9ec1633b89b48..e8efcc6a0b05a 100644
--- a/drivers/net/hyperv/netvsc_drv.c
+++ b/drivers/net/hyperv/netvsc_drv.c
@@ -2760,8 +2760,7 @@ static int netvsc_netdev_event(struct notifier_block *this,
 		return NOTIFY_DONE;
 
 	/* Avoid Bonding master dev with same MAC registering as VF */
-	if ((event_dev->priv_flags & IFF_BONDING) &&
-	    (event_dev->flags & IFF_MASTER))
+	if (netif_is_bond_master(event_dev))
 		return NOTIFY_DONE;
 
 	switch (event) {
-- 
2.43.0


