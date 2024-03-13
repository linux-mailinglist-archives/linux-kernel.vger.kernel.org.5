Return-Path: <linux-kernel+bounces-101848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E76F87AC1D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:58:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 331AA1F26410
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 16:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E0CF7350D;
	Wed, 13 Mar 2024 16:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n8WGzEz4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EFE77352F;
	Wed, 13 Mar 2024 16:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710347884; cv=none; b=eaFDdmq+w4TG7mCioe+G8MyIN7x2xrfniDC0iF9RWV2fTrhOKpz/4emejspMDyQNY+gheZgYnNcyib+DUnpVntv4c7T8tDYtsONDgZ35aG6OvoKFZ4K71x3tWLNf8pBiIBr6VIcuwKwQ9ulShG53H3yR3eADd1QM0mCJAf8vmOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710347884; c=relaxed/simple;
	bh=GtUTCYZzdG/pNLXzItpCeJCbe6gjxjwXPKrh7uW54lY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mmGtS6PFIuhvvFbv7HPHwiPFOsQJE2tfHFcMYd/iNvqsJzMjpVOo2PZEchrVUyDtCB5Rm586yiZRkZMQTEoULEqnrvy8A7zx7b4K4x3XmEOlJcQf7TL5/BU0DiIOs46o5awynDn610dmlPAelVaUvZmv2p4xRSZeZA7PekKDoks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n8WGzEz4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 753B0C433C7;
	Wed, 13 Mar 2024 16:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710347884;
	bh=GtUTCYZzdG/pNLXzItpCeJCbe6gjxjwXPKrh7uW54lY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n8WGzEz4UgpaX4ookhXHubR3J8D9O3NEDorqoaaQG8v1AjdB4BVXBEf1Sj2i7lG8t
	 UWadiEDw8vewQ9iVJDkjhp9v+3qfd05QMNyB7ygO6xkR4gpM8+suPNC35AYNDIczxV
	 j1sjiy+ASdufO7QMCx7wctZbaEUs7WCfk5Ng2y71cxlVu0vm0gPvDjbddBzVKQy1J6
	 WcWgmkOqwyHVY7W9Wa4UKz1fjfuvJ7blBr/If0kk5kUgW9k9DMvlBeVzSVx3uoK4KT
	 H6fQ+cb93BKinWXCa407nJMwi05f11wrKDLffshP1ZbYv9wLOLoDJqRY4lDa5TduOk
	 Hp8wloa+QrAMg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jason Xing <kernelxing@tencent.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 45/60] netrom: Fix a data-race around sysctl_netrom_transport_requested_window_size
Date: Wed, 13 Mar 2024 12:36:52 -0400
Message-ID: <20240313163707.615000-46-sashal@kernel.org>
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

[ Upstream commit a2e706841488f474c06e9b33f71afc947fb3bf56 ]

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
index 3aa52187cf982..851c3a625768d 100644
--- a/net/netrom/af_netrom.c
+++ b/net/netrom/af_netrom.c
@@ -462,7 +462,7 @@ static int nr_create(struct net *net, struct socket *sock, int protocol,
 		msecs_to_jiffies(READ_ONCE(sysctl_netrom_transport_busy_delay));
 	nr->idle   =
 		msecs_to_jiffies(sysctl_netrom_transport_no_activity_timeout);
-	nr->window = sysctl_netrom_transport_requested_window_size;
+	nr->window = READ_ONCE(sysctl_netrom_transport_requested_window_size);
 
 	nr->bpqext = 1;
 	nr->state  = NR_STATE_0;
-- 
2.43.0


