Return-Path: <linux-kernel+bounces-101893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EA5C87AC80
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:09:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B006F1C21080
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9004E612F0;
	Wed, 13 Mar 2024 16:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lHb8atdl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D059C7D096;
	Wed, 13 Mar 2024 16:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348028; cv=none; b=BuEz2g8jMhSuABi2jWfUbIwgJEbC2HiJF9VT5D2I8cEg+hx4MjG29C06prvUhsBBVXCz2fyWihEEoMApiKXVEM0JyQm7LhP7mYZp9zXpNQLLyKnSpcVxvsQ8qbEi+Yn7B6WrFWelA3upfPK12sR6nZJdZtwu/UokxPc6PAXrBh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348028; c=relaxed/simple;
	bh=23nZTP4nPmiBf9+5k+jJF2wu6aUX7TZXMDOc0WOlfJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YJUFodLc7sraXJVWYp/Rrj/pXHIv1waYH8weqWIP51vBSBOD2bkI8g+WLiMkaDOu9DY2HpowRisf1gQGhJMK9gw36eFazMuqRkR3LhrusYJkN1EGaBmarkrvq3m0DtpwqacClTDuAJeU+6zahln3M1eups9ka/7sXAzEcN2NA3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lHb8atdl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06FD0C43390;
	Wed, 13 Mar 2024 16:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348028;
	bh=23nZTP4nPmiBf9+5k+jJF2wu6aUX7TZXMDOc0WOlfJ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lHb8atdlq8EB+NDJFs7qtxXzMsJW9yGkIvuBWZ/Oh1y3czFPDlIMA0ApJZqmqhazQ
	 +8GiFhpoO3KCo0spPASt/cLMyPkYmmgKZcM1NjuLp16FDyihETEqdAw/7kB6wh19ce
	 MkvXV6WToXcGtsYJ8lDp88ctv1vvtiovR9PlH7L5Kq44VmLVSZdX5ADJGHp4aSJSJP
	 ETuefrqyGuaWKqmlBkOghIlDYxhQ2TO2Sc7mQwU7gGLIQwKMwimy9jp5AeqzyQU9Yp
	 EweWw9e+mQVEeaCn6Ec1ed0Ne63v567CZ3ybfX0Dg/y8iXJyi5rJOSUXbSK2429CXR
	 gv4Rt2h+0kRMw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jason Xing <kernelxing@tencent.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 25/71] netrom: Fix a data-race around sysctl_netrom_transport_busy_delay
Date: Wed, 13 Mar 2024 12:39:11 -0400
Message-ID: <20240313163957.615276-26-sashal@kernel.org>
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

[ Upstream commit 43547d8699439a67b78d6bb39015113f7aa360fd ]

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
index 7428ea436e318..ee6621c0d2e45 100644
--- a/net/netrom/af_netrom.c
+++ b/net/netrom/af_netrom.c
@@ -459,7 +459,7 @@ static int nr_create(struct net *net, struct socket *sock, int protocol,
 	nr->n2     =
 		msecs_to_jiffies(READ_ONCE(sysctl_netrom_transport_maximum_tries));
 	nr->t4     =
-		msecs_to_jiffies(sysctl_netrom_transport_busy_delay);
+		msecs_to_jiffies(READ_ONCE(sysctl_netrom_transport_busy_delay));
 	nr->idle   =
 		msecs_to_jiffies(sysctl_netrom_transport_no_activity_timeout);
 	nr->window = sysctl_netrom_transport_requested_window_size;
-- 
2.43.0


