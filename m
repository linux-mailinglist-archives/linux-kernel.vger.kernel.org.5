Return-Path: <linux-kernel+bounces-102047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 973C287ADF0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:45:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 577B21F2AF7F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3E5B153BD5;
	Wed, 13 Mar 2024 16:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CQN4iVWV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D80C15351B;
	Wed, 13 Mar 2024 16:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348427; cv=none; b=kIcC6nzIEcq36zwBnnHqJQhqgGQGegCYZ9G2gppjtDD8Wl5dh2D5fJrf8aBP2cMdDUD0C63uHTBRGnKNz02vpw6/PufJs616gnM83UIDQNF7DuADEAxSyuykjxNamuaD/qsIcU7sCy6/0FKRF4drJfJc1oo5DYao+GODe2IyAyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348427; c=relaxed/simple;
	bh=was6sneh7FZD+9dPqJzYCOv8b8gK1yrXIKN6t46lAZA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V6X6GE27lxFwOL0lSZZLXbAOu7gm0FZfK5u2QwccUY5DPSitGOFPqUr/Mm187PosJHq0V5zo+E3DUGGRfG2JYaO59av7xQid1TztK4R1uCGB2mgE5V7/f5G9zz8VHgzfmIx8Lz2bqacI7UuVbwbjFJokrihcKVq9yk0QEhduVDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CQN4iVWV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 570D3C433F1;
	Wed, 13 Mar 2024 16:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348427;
	bh=was6sneh7FZD+9dPqJzYCOv8b8gK1yrXIKN6t46lAZA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CQN4iVWV/Cfc4f+htBgXUGVaur1VWORUigx5VTI1kbiHvsRMfrvawWC6KqUUJmX7p
	 1Pc02xC7Z9bYnGYvyiwuhRhfc2mYT/qp8AN2/h+/dpMUsUiwl30WIKcvD/wOPyFbrA
	 Je+mIWU8ckcN3aHc/iMb+opUsMhjtT9WvJu9z1qp72H02AS32du5HKiVVDlPegEYpM
	 KMLXxBW4zAXUvW8Zq7SdbCeMhn6wHaZ2bj4BX//j4SZs6DtlweqiEnirUOcaMiE8gN
	 ZJyq/GxTu3zhk3z7VrRMnM2W2TB3llCKyDgg7iLzLBNV8LXpUCi/vwdphs7Pt0B/6M
	 vQgsh69L0EO5g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jason Xing <kernelxing@tencent.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 22/73] netrom: Fix a data-race around sysctl_netrom_transport_maximum_tries
Date: Wed, 13 Mar 2024 12:45:49 -0400
Message-ID: <20240313164640.616049-23-sashal@kernel.org>
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
index 6857510967448..678a7bbd84bf2 100644
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


