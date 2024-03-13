Return-Path: <linux-kernel+bounces-102044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41BC987ADDE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:45:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF44B1F29CA9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37E4F1534E6;
	Wed, 13 Mar 2024 16:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dkUb2R7m"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4D3152E10;
	Wed, 13 Mar 2024 16:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348424; cv=none; b=qPA2G4ukEKsC1dV7T1OvtZ1gBGALI6QVAO+TRW+AiSArvH/3iXOZVPgfx+oildrahCsQtSZBvCqmhCzk5unP86lXcuEsmzOI5NJp5m0N9UYbZXlhgi+a2W4hnq3VneL3JE2UbNEfeZ03nN320CUmyFx82mn6NAjzVrnIDl4UvZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348424; c=relaxed/simple;
	bh=TrmtEXDQsycLad657XlqLSOoc3BGOMFxOoA9VKBrig4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BK7Nn34k6vH3sM3aWaYGtVFswjPvTo3a84xW4d81vpqknQc56xfZf7Fuw8oqDxOdbkZ/dFVMm+uXD5mLspjBBO0IOkOU5MhHW4gx214b5r/ZIyyFNZAzwBYMpmduPEiEK96HHIVN+yEcLiTaULTZ2d8XSC1J/Qocz9VXM7iopvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dkUb2R7m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53569C433F1;
	Wed, 13 Mar 2024 16:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348424;
	bh=TrmtEXDQsycLad657XlqLSOoc3BGOMFxOoA9VKBrig4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dkUb2R7mjLyfQ4Bt0EvzyDujS8CFncZHssXdn9x1oGp2lxE5VEfsZ9yEjBCtA3lnB
	 wT50r432VRq+5TWa8URqUO7BKCn8vtphrutoMYOLp0mXicc7rOhaCwPjY8NTZxxeKq
	 5QnkajgAFHDzcOaW9qPbP2BtUr910N1+3x6RFVNeJn8NeeOIip3RAsT7Tn0STJvhCS
	 3pTMGW6hov38y2GTRJQyN2yUWqpIaL3ymWGgMTo7TaAUYTVN/J4VuREpgMbgPEQgYr
	 anFPRSr8+C9h3MHbdszSWjvnAnJflMaeqkHXyv8DliT7xOICKG8i493s2a/PofT1qd
	 9PLUFFoRBnV9w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jason Xing <kernelxing@tencent.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 19/73] netrom: Fix a data-race around sysctl_netrom_obsolescence_count_initialiser
Date: Wed, 13 Mar 2024 12:45:46 -0400
Message-ID: <20240313164640.616049-20-sashal@kernel.org>
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
index 94c4d4554b9c7..8a5375e1dcc77 100644
--- a/net/netrom/nr_route.c
+++ b/net/netrom/nr_route.c
@@ -763,7 +763,7 @@ int nr_route_frame(struct sk_buff *skb, ax25_cb *ax25)
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


