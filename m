Return-Path: <linux-kernel+bounces-102143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FE2D87AEC7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:08:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 466791F303C6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 629E37428A;
	Wed, 13 Mar 2024 17:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c5raL/vB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A087B73526;
	Wed, 13 Mar 2024 17:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710349358; cv=none; b=DtQllVMxalyyljibq/lAljAYcVd1tL8P81KSaPYHO0DVWuSYnpOAs/vvNzs4fvDOAFMDmUogrjK07GFwAsE96pxpwKRTvPI6KVv5YHuM7njMamId16okt6CdytV4HsEOXzxjLB6jcSeVfvZYw3taN2a9TFfYZSBa9UKXGs+edxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710349358; c=relaxed/simple;
	bh=JG3eHXHi8Qb6FhsvXomqSLItNv4UrD60bl2E/R0Qy+w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=brJjNqdjghaNvD+h0WkWNjqWlY9ZrMdPrfxJ79VUfPldhYzluVYsRt53a2sf4rgLDmYNRNqo9qH8IpZQ9j34iEWeyifV8zJDO7RS6MaINUOXC+T2SSoFHN7lvq9h2mi1NwRJ2IcBqCurBnDWXrEyLy0fX+RvCQyJVTg2RFEYzGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c5raL/vB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD74DC433C7;
	Wed, 13 Mar 2024 17:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710349358;
	bh=JG3eHXHi8Qb6FhsvXomqSLItNv4UrD60bl2E/R0Qy+w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c5raL/vB0K5DeShA82dpdSqVK8wa5UiUA2vK0F5B+FDT1HAJVVs4adm52Y2r+QGkm
	 DZ62Cto2HOTV4liQzQCUuOdA508n4rNH8Fz8fn9718Y1GGk7OWCqKbyez0VmCCXByh
	 ZcJsKopQ/mFYauqHDfE2SDu6DiO6M5L4WPJ31sfraWqE4C3ktQNxraUho22dflutJJ
	 vWEzqkUhiMmH0Cds7vhjtQmI2Y+9Ka9U59E6lSwCNhyOPYZKHnB3p/NVbjid+aaqLf
	 LHvB1X0O3YoPipNocnuFjto3rxDLQcS61nxo1uwh86u/VFgMU8ytKJebkczanwfNz2
	 +0k4wjMnSmRyQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jason Xing <kernelxing@tencent.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 22/51] netrom: Fix a data-race around sysctl_netrom_routing_control
Date: Wed, 13 Mar 2024 13:01:43 -0400
Message-ID: <20240313170212.616443-23-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313170212.616443-1-sashal@kernel.org>
References: <20240313170212.616443-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.272-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.4.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.4.272-rc1
X-KernelTest-Deadline: 2024-03-15T17:02+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

[ Upstream commit b5dffcb8f71bdd02a4e5799985b51b12f4eeaf76 ]

We need to protect the reader reading the sysctl value because the
value can be changed concurrently.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Jason Xing <kernelxing@tencent.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netrom/nr_route.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netrom/nr_route.c b/net/netrom/nr_route.c
index 7859217249124..4fb5959a7f070 100644
--- a/net/netrom/nr_route.c
+++ b/net/netrom/nr_route.c
@@ -777,7 +777,7 @@ int nr_route_frame(struct sk_buff *skb, ax25_cb *ax25)
 		return ret;
 	}
 
-	if (!sysctl_netrom_routing_control && ax25 != NULL)
+	if (!READ_ONCE(sysctl_netrom_routing_control) && ax25 != NULL)
 		return 0;
 
 	/* Its Time-To-Live has expired */
-- 
2.43.0


