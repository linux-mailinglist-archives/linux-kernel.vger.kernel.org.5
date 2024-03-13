Return-Path: <linux-kernel+bounces-102201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1F0B87AF61
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:23:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C1A92876A5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF10483B90;
	Wed, 13 Mar 2024 17:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uRGIn3lr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE0F19E7FF;
	Wed, 13 Mar 2024 17:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710349496; cv=none; b=L6CSkHmDO+fj58zy3FMLUZ1wClhWYjc338NGuIoHX2ZG5PoW8s30Y4SH24gb4ihBW5vIyaWTcXcLWaYWkozBT9vNTXmA3k8hEQ3xFVhpIOHxMhk3RINTdrjbpqrghaeMNcuM0ohbhwiIwoX/Mm2wKlRa7j8N9LndYi99dbefuQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710349496; c=relaxed/simple;
	bh=GLENV1XyGzq0SLE0KB8Rh8C/c8aPBufzNibAFr1299E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kr5J4iT2yOih1cekt+oDM9nOsJBIXlJZUH52VX/p4vov3n0J/g6cDPVf9FsoGJgxJ+hYKeWiWQFirDKXvnrPf697L/dro06FRNyMi31uDEuWMbg8bIPcquB/Rk4xRrMy9hWohzVM/DfQ8LUJ++xTJgyp5Q2ZWtNGix0Q5RUXNCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uRGIn3lr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39417C433B2;
	Wed, 13 Mar 2024 17:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710349495;
	bh=GLENV1XyGzq0SLE0KB8Rh8C/c8aPBufzNibAFr1299E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uRGIn3lrI5hy7BKqbjlHiCbS0t1v4lu4KpwSqUw1ChAfmE1PguYJVh4g0WVKm86OB
	 UCQw7QBCPqF5fzf34zB1rSt/PCwUn4m6qifQbILmwANqp+uv3WEmV3MwoHUTH7vrXM
	 DMiQYJzbulXzwJ61FNiq7wIhjtsTC0imo8VdCdgIfAfe4sYY0FQI/A/i3Tco5y6kkU
	 CBNAqytLajxwgxMrBt9bC2Erao/3x2+vah2ppR4GyZoD1HoALX4JHw8c/hfaIjoHBh
	 D+AxUNLgThmjJmV70qrUAypXtw9rxPMcRXUIHrqlS61SZZfuz4TA+VBknetYEVB2i/
	 Vynn1AL8NsOOg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jason Xing <kernelxing@tencent.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 16/41] netrom: Fix a data-race around sysctl_netrom_transport_maximum_tries
Date: Wed, 13 Mar 2024 13:04:10 -0400
Message-ID: <20240313170435.616724-17-sashal@kernel.org>
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
index a07652c91f2da..9d4a1d56badc8 100644
--- a/net/netrom/af_netrom.c
+++ b/net/netrom/af_netrom.c
@@ -460,7 +460,7 @@ static int nr_create(struct net *net, struct socket *sock, int protocol,
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


