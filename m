Return-Path: <linux-kernel+bounces-102049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F68087ADF9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:46:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C53E5281E43
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B092153BFB;
	Wed, 13 Mar 2024 16:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q017PVcm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86AB21534F1;
	Wed, 13 Mar 2024 16:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348428; cv=none; b=as2FXuLY8PRTBjPZR4Ho8BZF3NZUHKYsotLUj4cDMYhRAMv8cyv3493AKD2EYkvLNLrXvfUoaFHzDIP57+OcOD7pyDMoAmtyCe0JWJjDaMliHP3TUA/FJ5H0f2cYOwIH5SfqfFNKH7ObIZkVXtVSlH9naTB7ZlYsfqnlK3Fv4C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348428; c=relaxed/simple;
	bh=67liw3T/StQ4cXBr9axLBR840ACqH5dgsHUqaBCJwWg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QiW5Dg7dEAd7HvT4LxXLFYBeeIw20EVa670UYsGbZRw7DqVarHwRSkYJnkz6BFPrEUSOPDcjgF6bDsvDXCN5KHKNJBP3oVow9s6K9U5usHpcRWH28WYiv8lzl/HreSKmbS1TXw29zZjMZf6LabmrymNlGwao+8YTSN00/6MTRdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q017PVcm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 596E3C433C7;
	Wed, 13 Mar 2024 16:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348428;
	bh=67liw3T/StQ4cXBr9axLBR840ACqH5dgsHUqaBCJwWg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q017PVcmPg69PTTrybF/umNswuo/WlWcgIwCBhuHiQ/PdSzzea6vXsBUpQ2hS9RZU
	 OMs8CKJatV3zExVs4UU0c0OzoDdNVo558onmZO1JYoacOhHIx44NsRHO8LCAdAD5Ai
	 U9UMiV1zDGFCYLAmk9pfznR3yzvMEwriacleMMpzLBodzs+oXyC4VrbfrZO3FyAn5h
	 PWYaejvBVFU1bBS+m8XkPLhCxQJEhdgVbnyMf0b35ct+p0qII90Rm8KOmEz+tBnGp5
	 ROXnxM8rMYx4eCS2MvhEUlA0JVGeSG3K8L4oGtbNm+mabS6q60uiciN5jx6siTgdY+
	 oaQzaKi1t2kxQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jason Xing <kernelxing@tencent.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 23/73] netrom: Fix a data-race around sysctl_netrom_transport_acknowledge_delay
Date: Wed, 13 Mar 2024 12:45:50 -0400
Message-ID: <20240313164640.616049-24-sashal@kernel.org>
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

[ Upstream commit 806f462ba9029d41aadf8ec93f2f99c5305deada ]

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
index 678a7bbd84bf2..5a5cca18ae0c6 100644
--- a/net/netrom/af_netrom.c
+++ b/net/netrom/af_netrom.c
@@ -455,7 +455,7 @@ static int nr_create(struct net *net, struct socket *sock, int protocol,
 	nr->t1     =
 		msecs_to_jiffies(READ_ONCE(sysctl_netrom_transport_timeout));
 	nr->t2     =
-		msecs_to_jiffies(sysctl_netrom_transport_acknowledge_delay);
+		msecs_to_jiffies(READ_ONCE(sysctl_netrom_transport_acknowledge_delay));
 	nr->n2     =
 		msecs_to_jiffies(READ_ONCE(sysctl_netrom_transport_maximum_tries));
 	nr->t4     =
-- 
2.43.0


