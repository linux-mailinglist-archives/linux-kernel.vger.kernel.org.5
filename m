Return-Path: <linux-kernel+bounces-102207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A80AB87AF6C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:24:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63672289C63
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15DBC19FADD;
	Wed, 13 Mar 2024 17:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VZereSVR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A1219FAC6;
	Wed, 13 Mar 2024 17:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710349501; cv=none; b=qby90MGGSbzERBbK5M0wcPVrM+Aw3SQaX/gkkon/CGoKZmWpMdBRR5cHOWEWUNhJ43+9cpbtQ7eyr5B/C0vg47rIkuKmzQ4JtiSRmlOPx709Z4MxueyKvP1YCyryJJnnrETH02K04sFav6w3hoCSZxP/jCl05eaPeiM11BGl2ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710349501; c=relaxed/simple;
	bh=XRHm3al7qxwNCzfSlmH6P8xZAQ3EMpC7VgF92P19yzs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YBp/hiFtPCwg/hiMYdfBsXLmB9O3XTXCRc+3+9lAJ4afAkdK4MaDg3CE/ML8BVY+zV/9Oe5JngXS8gYc1FqkHC1OqAgufpZHQPtUbzOK7ama4GckPr2A5e7P9l3TELJlPJMgG4ea56oX2a/l+qdytxvgZjImXKpDoNB4QJJX/LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VZereSVR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C626C43394;
	Wed, 13 Mar 2024 17:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710349501;
	bh=XRHm3al7qxwNCzfSlmH6P8xZAQ3EMpC7VgF92P19yzs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VZereSVRtT3PCWC0NgXv/CJVgBXd8g3nD84U6Yvazbtwkz7BsWtluwrYZ6XGfQolG
	 X+f3z9SfaiW7+Q6n7A4XdRi2pyitHtsv4AlMQ1X9Ni/w/jTN12TjBr80b7YE285fIp
	 I5OChofm+8pV3+OOxFbICQVZplAzUtbhV3atGmTRSKRBOZUO6IRZXHDi35bfE14scB
	 6Rmz5lZSc0zcFpRwFbbJHMmKG7cau9zXRd1WqZ8mfWvUnzaPDB91enaLK3jw3QapgS
	 D68FDbgHLmsfZ3yHI3iSjy23NXKkALQyZSBsSHXQbcb9jkrG4A0g9Q8fQk3/eqjOKe
	 rHpQeW61ynfJQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jason Xing <kernelxing@tencent.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 21/41] netrom: Fix a data-race around sysctl_netrom_routing_control
Date: Wed, 13 Mar 2024 13:04:15 -0400
Message-ID: <20240313170435.616724-22-sashal@kernel.org>
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
index 929446e246b36..eb285b12977b7 100644
--- a/net/netrom/nr_route.c
+++ b/net/netrom/nr_route.c
@@ -780,7 +780,7 @@ int nr_route_frame(struct sk_buff *skb, ax25_cb *ax25)
 		return ret;
 	}
 
-	if (!sysctl_netrom_routing_control && ax25 != NULL)
+	if (!READ_ONCE(sysctl_netrom_routing_control) && ax25 != NULL)
 		return 0;
 
 	/* Its Time-To-Live has expired */
-- 
2.43.0


