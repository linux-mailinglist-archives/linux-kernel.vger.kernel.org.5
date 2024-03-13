Return-Path: <linux-kernel+bounces-101890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A979587AC78
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:09:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4487CB22F18
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BBAE7C6D4;
	Wed, 13 Mar 2024 16:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TbDPEkLH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC307C09E;
	Wed, 13 Mar 2024 16:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348025; cv=none; b=rwjpSmeUBrll8C7hu8m2ePFWCxbVwt7qyrtWNMP08XJiVAkfO2hkDcRuMCjn7to89HhxLUM6dHi9TvnsilPevFSUcrTiCBzW3jzLzBE7BdYMWIYDN++poELDnhbzYptLZhcdHT2LCZl/yyxegjRXbmIKfb6PztEJcvUcQ+VMyVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348025; c=relaxed/simple;
	bh=yK4X/3XR1Lzhp5H6UeOTWzpopfJQ0x1XorGvpfCex4k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M3o5+fYB5zN507TuG01Lxn3CKFTVmRLqPKCiQPWOj7eg+rwBZuMGgyQeJIADXDcJz2JekiUyRB1VHjxQ000Jc9PS2aVCRYfyWW/L0QjKI1G4coLzAEXoNQNha6qW3cFp0qMNJXa5bc8ZOMbDZe97DG4+kkmFkmV5arisPX7BAV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TbDPEkLH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1664C433C7;
	Wed, 13 Mar 2024 16:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348025;
	bh=yK4X/3XR1Lzhp5H6UeOTWzpopfJQ0x1XorGvpfCex4k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TbDPEkLHazbdl86EaojJ2CNO5pr6rMcPmhHXDqz6Jr9/9BHnNOjpAQACw9ePoJQ/k
	 okhdSLZ/MCgCidxRSLdfKj4WbIXGzLh4mIm+AlViyYnZynbm5hbCpqn1qxCBQLXBnG
	 Z0uKH594v6HGp1OS9XZVOCjeJY8i+dohzL7e+++TmqAMMxmqVaw67gi7yeR6HSex3h
	 +EVf5tEQSHXP/AENPa19XSzmYxgbFXZ1wQZIr+7Tsr6fz+AKry1G2V0o+NDJNrqtJA
	 +efbxDNpSHCRBumGziVb9B+Ofe5JtJoPUt4MEsehRxw9ERQHvBIVkZXbB4Y+zgqhZt
	 BgC3Imfv5sfDg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jason Xing <kernelxing@tencent.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 22/71] netrom: Fix a data-race around sysctl_netrom_transport_timeout
Date: Wed, 13 Mar 2024 12:39:08 -0400
Message-ID: <20240313163957.615276-23-sashal@kernel.org>
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
index ec5747969f964..3c6567af2ba47 100644
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


