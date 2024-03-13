Return-Path: <linux-kernel+bounces-101888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93B5987AC74
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:08:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 335641F2BA5C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B57987B3C3;
	Wed, 13 Mar 2024 16:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tRjqIb3N"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00F77B3F9;
	Wed, 13 Mar 2024 16:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348024; cv=none; b=Ho6UkXRPSHZc/Dfhjmts6YQE8qI0nK7dDmwAvzjJQgFu6FbkBJkve7EHKJQgSMo0TtXyW3ilh2prICRjvH7ydv9iXWMSYkCLUSQr//ihikbdJB6sU0s/T1sD7kJ/k2HG8kdY3kGC7ndSqjP0a/F3fJ+cKwM34owC26By4reMjmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348024; c=relaxed/simple;
	bh=zoz/s8A/E4JPfDEwpZXOOhtjTptdKp3RunG4UOVpAz4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sYLI4jnt5Mcv4yXteTu3sM4iyLBzOBMI2O26lbbQPctedJENk7BGJ9DY6v72oLSOMSYdMpnNjqiN/wUlWvT9j4n19ef+gWYDZtBM6hpF5472O9lHMzxhIISqPcDx95PJw0LPIZVh8xj2Ahg8VrdsNsOoLkqMQbi6ah4OY4eoDds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tRjqIb3N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAEF1C433C7;
	Wed, 13 Mar 2024 16:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348023;
	bh=zoz/s8A/E4JPfDEwpZXOOhtjTptdKp3RunG4UOVpAz4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tRjqIb3NSnx3ckIE12N9WnO+x2tfxDIvm+/rK3n2DTYEysgWviAv4DH5bzOBABlZ3
	 WIEerCNEy4L8p0koin2g1kSHLz4uC6KDYikx+1h77tJKsACexyI8lwbBeU8uzvEjk2
	 ISnY79sZifOwc/+0WYJzUr1l0SZpS1ADho3PoYGi1UouxNxrDxrUJO5v2Y4vZch7Sc
	 zESFzAfdWBiCcFFdKXTCRCpztH03WZrRCM5+SRYZ53A+O6mKGlC2SHtEK5rdTlabBA
	 GgR9nUaeMy4i5Ug55Mt+kc8Jusi1FQtZCavPuPP8u1hRdpeWhJxPhQKmlKz7QH4adI
	 Upt6sJbaeImXQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jason Xing <kernelxing@tencent.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 20/71] netrom: Fix a data-race around sysctl_netrom_obsolescence_count_initialiser
Date: Wed, 13 Mar 2024 12:39:06 -0400
Message-ID: <20240313163957.615276-21-sashal@kernel.org>
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

[ Upstream commit cfd9f4a740f772298308b2e6070d2c744fb5cf79 ]

We need to protect the reader reading the sysctl value
because the value can be changed concurrently.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Jason Xing <kernelxing@tencent.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netrom/nr_route.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netrom/nr_route.c b/net/netrom/nr_route.c
index 6f709fdffc11f..b8ddd8048f352 100644
--- a/net/netrom/nr_route.c
+++ b/net/netrom/nr_route.c
@@ -766,7 +766,7 @@ int nr_route_frame(struct sk_buff *skb, ax25_cb *ax25)
 	if (ax25 != NULL) {
 		ret = nr_add_node(nr_src, "", &ax25->dest_addr, ax25->digipeat,
 				  ax25->ax25_dev->dev, 0,
-				  sysctl_netrom_obsolescence_count_initialiser);
+				  READ_ONCE(sysctl_netrom_obsolescence_count_initialiser));
 		if (ret)
 			return ret;
 	}
-- 
2.43.0


