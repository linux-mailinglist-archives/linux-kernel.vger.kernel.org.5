Return-Path: <linux-kernel+bounces-101959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F35887AD18
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:26:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDBAF1F213C6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AA8513D2F3;
	Wed, 13 Mar 2024 16:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u888Gcl5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804CD13C9ED;
	Wed, 13 Mar 2024 16:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348168; cv=none; b=Y1UE5ciboWxeeFtSR8sP5hyvUFi0FdlinyxrRPA9US+dgcfkUXj1KPhNiFP8l0ssxnM9PgGBIKaql8QHfTOeNwYQwyjFUNmQj+TiEPeFXbrW85MH1DGDVQmFVRulOqEKXIB1YVWbPiO7tRh4UquXDJsgnLhN6gGIvfoEb1n1YQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348168; c=relaxed/simple;
	bh=v1F9PhDK0oX3T92o4m74/kx58+E0UmC3jFyT+LVR/fs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o/CDER+q0jU7jQKP7t8Cp9+EV124uyodd2HKDpYo6WSUILVf94Pn0Rp+fK4lNBP1iWOFEXwzs6dW9XSrDo4ScQ2FCNY+5644tO1JuQcskpnu4ZNE0ulaFKFG3cqCDG11+YVq/esfkV131FzcMqCBdxdJ8VjvYG/IOojnVA+qi1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u888Gcl5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48622C433C7;
	Wed, 13 Mar 2024 16:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348168;
	bh=v1F9PhDK0oX3T92o4m74/kx58+E0UmC3jFyT+LVR/fs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u888Gcl57wl516iyMboqeO/8aFh4AWRVAOvK+YpkUr3/UTnwmPGAx2Mm1REnsFp6j
	 jpZBdV1GT5WhG5KqCnR/ewBBuU2WotoAopnOLZ6SX7pE3djBozDsBbN5DWPFd96W2q
	 xBSjmv7FFCzGvEgWNaBSEX6dBxOe42UYPfmVq8vT1jNHgAlaJA+s5f3CUDg+R43Bw+
	 /0ksBVE0iWxQ4y6M9h7sRr3o05KCNoqM5mPVnaToO6Foyx8SD6FKAh351KjrrKV5xo
	 E5aGoRhBErQAKDXaWUirxc1y6LHgIV0Q5s2trKD2UpfGwz3ShrG2hCQCvmZym1DzRa
	 W7RokUBoRTwEg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jason Xing <kernelxing@tencent.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 19/76] netrom: Fix a data-race around sysctl_netrom_transport_timeout
Date: Wed, 13 Mar 2024 12:41:26 -0400
Message-ID: <20240313164223.615640-20-sashal@kernel.org>
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


