Return-Path: <linux-kernel+bounces-101963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5071B87AD20
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:26:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 004DC1F2589D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA01C13F452;
	Wed, 13 Mar 2024 16:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lfqXwO05"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FFF313F434;
	Wed, 13 Mar 2024 16:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348172; cv=none; b=bpNCEHqA00tTRviAozyDjyA9RghIZ7QKhO6TSrVkZcl9p9qGTKOmKHWsJmvwJ+6/Jc3JU+fX4yUw0MRGROutR314tRwKPjvePAQmcSqGN3JGfLOyqenqWLLhjPGuhR7jHhERHU8J6Ele8UR7WRWhZn01WUdv2SrqN+FHVkgSKsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348172; c=relaxed/simple;
	bh=A45mpmaNrioN7F+79MkqmOhHiGCPFpIHmheKJHJxoKk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FB54B8/GGy94w8f3bHkFGycBYLUbjcodKfCg2EErY5hv3VVfmIAWvw6laR08uncRiZvq9JIcRWX4WsloKgPaFD233+Ot+c1ghHHDWq3BLJ5I+w3vQUbLkVvHI3KfcvWNEHX/VRmTGFTIfZawO4Tx7hw2tvB3J9cJPlKdUthxa1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lfqXwO05; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D97FC433F1;
	Wed, 13 Mar 2024 16:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348172;
	bh=A45mpmaNrioN7F+79MkqmOhHiGCPFpIHmheKJHJxoKk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lfqXwO051bFHCoDctVnN8PVdrDC7k/XGuOzap5bvsyAHCK2cGrrvY5Zhmh5LjZIiY
	 Mlgl/JBfVJUlKVc0aBINOuNkqzGrM9plLqCxOfXuCGel3X6r5scptwu1Bp9SkjkcX5
	 vjiUq30pcb2sb4OeJaknx+0zxpWdIDVg1N5i8pGnprbJmvkHvNVfUvTs8xnoeYfA7p
	 B16l2LOdw0FFlA0iRwmG9H1SfysFmVhiWANZ8A2gm4NO3R+EiQphYAsSJ8Jx+kbsQR
	 HsII7QWsQHG2FMlo00WUKH+zAboN31oRafJurh0tBu/K8Fg1l8QRKLvqVjR3oolOIl
	 geqrN8rdY2wxQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jason Xing <kernelxing@tencent.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 23/76] netrom: Fix a data-race around sysctl_netrom_transport_requested_window_size
Date: Wed, 13 Mar 2024 12:41:30 -0400
Message-ID: <20240313164223.615640-24-sashal@kernel.org>
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
index 76d66eb0de255..d780adf54e19e 100644
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


