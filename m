Return-Path: <linux-kernel+bounces-102206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2613B87AF6A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:24:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D66092898C4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDF1E19FAB8;
	Wed, 13 Mar 2024 17:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UudUB1WP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F33619FAA0;
	Wed, 13 Mar 2024 17:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710349500; cv=none; b=QnH49DAHStdLksVZrIY4h9O/d27N5nA8Mjk0/NBgoLxWnwjtoDRkmVYKo/NPpzKTZzvwBbxLHfTAdbLVJq3q24ynnFc07elSas6bwy8YDjGfulqIXsbotZT5NKKoVH4OqQFUaT2FiEUCUi1aU0Xgsfmk7JrxKRpWuOFH9gqceoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710349500; c=relaxed/simple;
	bh=9ItLBwNbhRo+RLBjjnuxZ0wIvw10SZI1a5hzPSILupI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=doaM/Ob3iCDv1biG9Nv+R+Egng2m4yiYt101VH0y8CHyJG2AkTwJjUzucBw8DfvaieT8rQi4y8Tmy/eqLjS3XZq/g/8GYjf3gQP9uMrXesQcvkRtV5E+wyVPrhSjX2TnRf6TR5eVKvBgPCYmwcIYo9wbg7fAFHAgnqw09NlcBps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UudUB1WP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F6EDC433F1;
	Wed, 13 Mar 2024 17:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710349500;
	bh=9ItLBwNbhRo+RLBjjnuxZ0wIvw10SZI1a5hzPSILupI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UudUB1WPGoDOUPuM6ZEm+ZoN8kgPEKJ3RFvLy0gSwqpD8YJXsgGD7t442RB+WHDTT
	 sCsxzDkDRv7xsg5RuDWGAWtSQ3dCEKH+4WkG5+XTU1V2TbF6rmMXqIaWvfLu9APQcT
	 2+gTYkFhb0+9wP+AVdCLZxlGnaIv9qz9E7TRpDfk6VOh8sSxcZqRg0KnTLyKgrotNo
	 7t9XDdPnlxrpq2itDSc7ZyTdvEhOfhwDyJSJYip25+AbariymKbTusveh5+y/d5NrR
	 bbabpsZ6o0Ce+Rffb81xdJzI8Xt0VhRWnXJIfkjjfFUxBw3PCE8GJ2VDPsYXznOzLT
	 6DUfE4p4RUzjQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jason Xing <kernelxing@tencent.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 20/41] netrom: Fix a data-race around sysctl_netrom_transport_no_activity_timeout
Date: Wed, 13 Mar 2024 13:04:14 -0400
Message-ID: <20240313170435.616724-21-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313170435.616724-1-sashal@kernel.org>
References: <20240313170435.616724-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.310-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.19.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.19.310-rc1
X-KernelTest-Deadline: 2024-03-15T17:04+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

[ Upstream commit f99b494b40431f0ca416859f2345746199398e2b ]

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
index 1d4b4d228ca0b..3277f9a7ed02b 100644
--- a/net/netrom/af_netrom.c
+++ b/net/netrom/af_netrom.c
@@ -464,7 +464,7 @@ static int nr_create(struct net *net, struct socket *sock, int protocol,
 	nr->t4     =
 		msecs_to_jiffies(READ_ONCE(sysctl_netrom_transport_busy_delay));
 	nr->idle   =
-		msecs_to_jiffies(sysctl_netrom_transport_no_activity_timeout);
+		msecs_to_jiffies(READ_ONCE(sysctl_netrom_transport_no_activity_timeout));
 	nr->window = READ_ONCE(sysctl_netrom_transport_requested_window_size);
 
 	nr->bpqext = 1;
-- 
2.43.0


