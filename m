Return-Path: <linux-kernel+bounces-102200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5637787AF5F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:23:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B91F1F2823E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C159219E7F7;
	Wed, 13 Mar 2024 17:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SFUG+VQy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D66A19E7DC;
	Wed, 13 Mar 2024 17:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710349495; cv=none; b=ix8mGcxRYJ+fEMTC6XwYiix6V4ZwKZhBN80JyxlfZK970JRzKDez9+UtyYmsTKzlrAmriNpviwiAnEnFq861KlLDLjH6YvKKNrblu1VKjrVXzAYEZgbU1nAmP7vNa+aXsuJDbVw/LWRhyv3m3Zw32mVOkdIJNQ4OyayMwdc6a0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710349495; c=relaxed/simple;
	bh=6PUReT8BQ56I212FUQn4EKtgHLCtKs7HkT6w7g8qx3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sh/BMrpuOCvcw/5czaNlxCjiTvylprYQxFVp6Ist3n/JN/3hw+gl8YG6GPl4ySVHi0moAsAGkGCS0yXAhHbcsR71LU5/hS5cN/L2PWySBsDWzbV8+qHaOIeBsE426X+c0j/pQC/ZgSM7/DLBwSoG8XLAGofjL6OxJMohRNtcnSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SFUG+VQy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36266C43399;
	Wed, 13 Mar 2024 17:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710349494;
	bh=6PUReT8BQ56I212FUQn4EKtgHLCtKs7HkT6w7g8qx3Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SFUG+VQyDsizzwDfVXooXYX3i32px+K2Fk9jxFGe099WXa62PJfRebbw+1XZAE78e
	 phneLVMhZzIzVbiSi9wbyZ6TcN6jQOoVxPjx9pzR3LmU1o6RnweP81ZktHzbuUh8mM
	 WV01hvSQqdGfmz+BJSLEDDiPjHD7K6paRvld9p4C95TDNQZyNxBNkeQABnTCsxKKBG
	 LOFEkG1sIPtyB+oGHJZadjAUMwf5qDJqgegRrLGTDYAE6yIANdzHa929PCaEYQeghG
	 sqp8aSwg5RWdzo49pXAvoC3nF8TbFI/wYVnS/qNxcHQxsk2su61gycnxvNbR/W2fGx
	 65Uut6CyiNmzA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jason Xing <kernelxing@tencent.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 15/41] netrom: Fix a data-race around sysctl_netrom_transport_timeout
Date: Wed, 13 Mar 2024 13:04:09 -0400
Message-ID: <20240313170435.616724-16-sashal@kernel.org>
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
index 146550ce0ac6f..a07652c91f2da 100644
--- a/net/netrom/af_netrom.c
+++ b/net/netrom/af_netrom.c
@@ -456,7 +456,7 @@ static int nr_create(struct net *net, struct socket *sock, int protocol,
 	nr_init_timers(sk);
 
 	nr->t1     =
-		msecs_to_jiffies(sysctl_netrom_transport_timeout);
+		msecs_to_jiffies(READ_ONCE(sysctl_netrom_transport_timeout));
 	nr->t2     =
 		msecs_to_jiffies(sysctl_netrom_transport_acknowledge_delay);
 	nr->n2     =
-- 
2.43.0


