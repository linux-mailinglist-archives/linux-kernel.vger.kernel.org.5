Return-Path: <linux-kernel+bounces-101891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A72AF87AC7C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:09:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6316F28499D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3F357CF39;
	Wed, 13 Mar 2024 16:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JqnnHD72"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3156960EFE;
	Wed, 13 Mar 2024 16:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348027; cv=none; b=Skfg6+JWqNrMmgfaXlvJZaSFfuVg8nzg5TV0bHBqJ+T8R46b+u6tNVkQTI0PfyNF1pjnmSsEikSWe0qakamQlrjZQS9K2U496FN8f1BClRfpdOxo+ypZEXFoyUu/KiuvR1tFPrIOrLRuPKNPgKHh+PPJxnXIIPX5FIdsK6fbp1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348027; c=relaxed/simple;
	bh=dVRYMERwB+cOVOpagrrhjdSloMG8ShLCzuGWGxyuAbs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OafA1QpnlG+pQRr04hASK3mo4ABktZM7NWHNgnsbN4iUhtPJElzXlQocMZYndqXfhQdXlj0vkVDgulChhMU9d9y1cOF0Y8dc69zsF633g02gFVXs+Uyqfb1gNEaXe6J+3Pqwmg3Hdx1WFd79Cdiyq4MpVyXn0s1b+Xv4UsB1pkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JqnnHD72; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 050D7C433F1;
	Wed, 13 Mar 2024 16:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348026;
	bh=dVRYMERwB+cOVOpagrrhjdSloMG8ShLCzuGWGxyuAbs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JqnnHD72agA9OLuNyHrA4MKDicMTxuEr8e5MTYbdE6BVa54uJugTYpTwLNQw5YTNs
	 +Cju0WFgGL8vKT8xcQ6FfwXbAtbFGFXLTl6GVFn/fJCZkpuj5sipDOQrDRkNHCVOb0
	 KtjW4roORE1/eGJpg/G0PJhSdYWviWvG/dfF/DYE2Dy7VLiSi6gDA6xMCqI2LisIGj
	 C4TfAi7TVvILOFfxDDc9wkr+p28h186lPsEb+y8EsTV3V3KAxDohpse1Lc64XEqoo3
	 KX4cJc+zXDbC2m2MxbGydZafHsOBrXo7rOddtj3ItYZ14o8vNqRLpSQhEeafhBQLdA
	 Bs/zVQ3+i3/jw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jason Xing <kernelxing@tencent.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 23/71] netrom: Fix a data-race around sysctl_netrom_transport_maximum_tries
Date: Wed, 13 Mar 2024 12:39:09 -0400
Message-ID: <20240313163957.615276-24-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313163957.615276-1-sashal@kernel.org>
References: <20240313163957.615276-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.82-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.1.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.1.82-rc1
X-KernelTest-Deadline: 2024-03-15T16:39+00:00
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
index 3c6567af2ba47..be404ace98786 100644
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


