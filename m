Return-Path: <linux-kernel+bounces-102052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4D3287AE00
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:46:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82B1A1F28690
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8A62154C0D;
	Wed, 13 Mar 2024 16:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uGhFUvbf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C71154BED;
	Wed, 13 Mar 2024 16:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348431; cv=none; b=IDVFwSPy1Q2lb9hcZQvlGa898bGo5oslevUkqELwnzz1qsTGe8ac86Bq1PnVy7R5pEtvdWy9JxX1Cw1gmQdmKzhAsqTPSeOuBpgZJq1n8P3j2oyaSCJlApGCu3+Hjy61ihXON3jSP25VDTIHwN5u+s7jqJEaFx6SO5cGjxjFPuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348431; c=relaxed/simple;
	bh=g43Mh+Ckbo7u84Iinkv4s2Oe8nqvUxcd3wBs+YIKlwA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M7v3i2jAVHu+79e/D7WCP8wSSXkwYn5eyuhAn7KIgNE/AzXe7ZitVfpnx6Ey892HPqvjFCe42/IdXcuA3XhLVk6/tH5JcsGyp3aco5K/XRzjQ84PT+yeLrgjhk/ZFDsZoluVBQgEifMBRsANKKoFi1LSccnPO7ei69mBNfnAaBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uGhFUvbf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5687DC433F1;
	Wed, 13 Mar 2024 16:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348431;
	bh=g43Mh+Ckbo7u84Iinkv4s2Oe8nqvUxcd3wBs+YIKlwA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uGhFUvbfybczbEAWp97m7+GOQlyrWCj0OqMIuK76QSrg4Q2zCjtV/43eoKxRC8kcM
	 L+m0WQiSI634NFNKVlH67qaWSGlZMq2aL76HJCVP+Y9kchnXWtKf6Y4qGWnJfks1xp
	 Gn8wJ2CJZFl4cLGJvYn+jRSg5vDhuSkVPcUuhjcDU2pLxC+JeT/WT1RWMgJwaMarU5
	 /fbZOyOGtjUabIjyhlI8DOlWc4bC8/7pkUwaBEWqzr6sBNu3ljw1ZgxxfgxIP7qQh+
	 972Hm446gCGAYjPXhqmf9sC43L9f+ol1qsaAvOSJM7QhBVmZmc8VPxg2jWJL5K7emR
	 wAW4F6vD9Ql1w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jason Xing <kernelxing@tencent.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 26/73] netrom: Fix a data-race around sysctl_netrom_transport_no_activity_timeout
Date: Wed, 13 Mar 2024 12:45:53 -0400
Message-ID: <20240313164640.616049-27-sashal@kernel.org>
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
index d780adf54e19e..376b6af431448 100644
--- a/net/netrom/af_netrom.c
+++ b/net/netrom/af_netrom.c
@@ -461,7 +461,7 @@ static int nr_create(struct net *net, struct socket *sock, int protocol,
 	nr->t4     =
 		msecs_to_jiffies(READ_ONCE(sysctl_netrom_transport_busy_delay));
 	nr->idle   =
-		msecs_to_jiffies(sysctl_netrom_transport_no_activity_timeout);
+		msecs_to_jiffies(READ_ONCE(sysctl_netrom_transport_no_activity_timeout));
 	nr->window = READ_ONCE(sysctl_netrom_transport_requested_window_size);
 
 	nr->bpqext = 1;
-- 
2.43.0


