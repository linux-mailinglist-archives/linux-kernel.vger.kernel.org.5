Return-Path: <linux-kernel+bounces-101844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB75387AC14
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:57:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FDFE28B881
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 16:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11B5660261;
	Wed, 13 Mar 2024 16:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MZqpYqrd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E22D71B4B;
	Wed, 13 Mar 2024 16:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710347880; cv=none; b=j5f1iUByahC0aPw4rtDTP5Nne07q4uc+TWFoy6M6Sma7UlpMYwollw3QEQCfYHf99UrNIopEDhfOaEACFfumWGIfMNLL9E1tKr3AFfdU9Z/SMWP+HBj7qg6KzZGrmYqsuojkgznEkDgEpkwiDywoxm4Y8aLrNx+29cfiICCDkKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710347880; c=relaxed/simple;
	bh=YUm75QyIDWrVxc/dfGrc7itiCpP7JcwKZfmQ9nq70qk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K3VHWkcLP8PQ5OgBNTNQ+wKbuhPXZGhD3tx54ZVM0XW0jQimnGwLIVyt0gb8Mw4DX9ZyZpbGw9hb1Jix/NsO5+HseU1BvajTQUtSXLd4rcpZBIIDxKyEtsMhUVH69xHHN8R6n2wDp4M9O8lvjQhYRMJNrt1rgzjJl6Y4OIEobsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MZqpYqrd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6226BC43390;
	Wed, 13 Mar 2024 16:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710347880;
	bh=YUm75QyIDWrVxc/dfGrc7itiCpP7JcwKZfmQ9nq70qk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MZqpYqrd/AbCoa1xuY0lHUCLQ33xWnUwpERrx0QNl/qEg7H3GtmEHpK/TFakOW6Se
	 t5RWfRAONZ+PeGw+uP+amB+r+u/8xUIcWhoE3eqttXFRSCPbcCvz+Z5/XkNTozn1XU
	 9BY1pR2Z2wBfUL4zHhcnGgWUF66nlYDHy7aZPhxIDIMSpqKPVb0FuNWFWGJoETT9W0
	 sYbH26MDzpFxbnNlEQsMhrN3omLx61E+Xndv/UqzP7/COOlR640wQOQnBGOzvtacX4
	 s+q3rEzhyUlPcoBAvRkWcEph5AWORxSBdDFrZ8GmQ/TDo8aiMp7pHBSKRsdphVC3rK
	 08tZ25vY3UsKg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jason Xing <kernelxing@tencent.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 41/60] netrom: Fix a data-race around sysctl_netrom_transport_timeout
Date: Wed, 13 Mar 2024 12:36:48 -0400
Message-ID: <20240313163707.615000-42-sashal@kernel.org>
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
index 96e91ab71573c..d8a25f614c500 100644
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


